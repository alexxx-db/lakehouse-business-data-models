-- Schema for Domain: scheduling | Business:  | Version: v2_ecm
-- Generated on: 2026-06-30 04:18:31

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`scheduling` COMMENT 'Owns the Electronic Program Guide (EPG) and all playout scheduling logic for linear broadcast channels and on-demand programming windows. Manages dayparts, program rundowns, linear channel grids, ad pod placement, SCTE-35 cue markers, simulcast configurations, and automated schedule generation. Drives Ericsson MediaFirst automation for channel playout and failover, ensuring compliance with must-carry and blackout obligations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` (
    `channel_id` BIGINT COMMENT 'Unique surrogate identifier for each linear broadcast channel record. Primary key for the channel master data product within the scheduling domain. | Column channel_id (BIGINT) in scheduling.channel',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Channels have associated billing accounts for carriage fees, retransmission consent payments, and affiliate revenue. Essential for MVPD/distribution billing, carriage agreement invoicing, and per-subs | Column billing_account_id (BIGINT) in billing.channel',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Channels originate from physical broadcast facilities - fundamental for transmission operations, FCC license compliance, NOC monitoring, and facility capacity planning. Every broadcast channel has a p | Column broadcast_facility_id (BIGINT) in technology.channel',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Every broadcast channel operates under a regulatory license issued by FCC/Ofcom. License terms govern transmission power, coverage area, must-carry obligations, and renewal cycles. Essential for regul | Column broadcast_license_id (BIGINT) in compliance.channel',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Channels are cost centers in broadcast operations. Monthly financial close, P&L reporting, EBITDA analysis, and budget variance reporting all require channel-to-cost-center mapping. Standard practice  | Column cost_center_id (BIGINT) in finance.channel',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Channels have operational managers responsible for programming strategy, compliance monitoring, and performance targets. Standard broadcast operations structure requires tracking channel leadership fo | Column manager_employee_id (BIGINT) in workforce.channel',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Channels are owned/operated by broadcast partners (affiliates, network operators, cable systems). Essential for affiliate management, carriage fee calculation, retransmission consent tracking, and net | Column partner_id (BIGINT) in partner.channel',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Channels are profit centers for revenue and cost tracking. Executive dashboards, board reporting, segment EBITDA, and management accounting all depend on channel-to-profit-center mapping. Core financi | Column profit_center_id (BIGINT) in finance.channel',
    `transmission_equipment_id` BIGINT COMMENT 'Foreign key linking to technology.transmission_equipment. Business justification: Channels transmitted via specific equipment - critical for signal path management, maintenance coordination, outage root cause analysis, and equipment performance tracking. Supports NOC operations and | Column transmission_equipment_id (BIGINT) in technology.channel',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in scheduling.channel',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in scheduling.channel',
    `ad_break_duration_sec` STRING COMMENT 'Default duration in seconds of a standard ad pod (ad break) for this channel. Used by Wide Orbit traffic system for ad scheduling, inventory management, and avail calculation. Typical values are 120 (2 minutes) or 180 (3 minutes). | Column ad_break_duration_sec (INT) in scheduling.channel',
    `affiliate_network_code` STRING COMMENT 'Code identifying the parent broadcast network or affiliate group this channel belongs to (e.g., NBC, CBS, ABC, FOX). Used for network affiliation reporting, retransmission consent negotiations, and carriage fee calculations. | Column affiliate_network_code (STRING) in scheduling.channel',
    `blackout_enabled` BOOLEAN COMMENT 'Indicates whether geographic broadcast blackout restrictions are applicable to this channel. When true, blackout rules must be enforced during playout and OTT delivery to restrict content in specific geographic markets per rights agreements. | Column blackout_enabled (BOOLEAN) in scheduling.channel',
    `broadcast_timezone` STRING COMMENT 'IANA timezone identifier for the channels primary broadcast timezone (e.g., America/New_York, Europe/London). Governs daypart definitions, schedule generation, and EPG time display for the channels primary market. | Column broadcast_timezone (STRING) in scheduling.channel',
    `call_sign` STRING COMMENT 'Officially assigned broadcast call sign (e.g., WABC, KNBC) that uniquely identifies the station with the regulatory authority. Serves as the primary external business identifier for the channel as registered with the FCC or Ofcom. | Column call_sign (STRING) in scheduling.channel. Valid values are `^[A-Z0-9-]{2,10}$`',
    `carriage_fee_usd` DECIMAL(18,2) COMMENT 'The per-subscriber monthly carriage fee in US dollars charged to MVPDs and vMVPDs for distributing this channel. Commercially sensitive financial data used in revenue assurance, financial reconciliation in SAP S/4HANA, and EBITDA reporting. | Column carriage_fee_usd (DECIMAL(18,4)) in scheduling.channel',
    `cdn_origin_url` STRING COMMENT 'The origin ingest URL configured in Akamai CDN for this channels live stream delivery. Used for OTT/streaming distribution, ABR (Adaptive Bitrate Streaming) packaging, and CDN cache configuration. | Column cdn_origin_url (STRING) in scheduling.channel',
    `channel_status` STRING COMMENT 'Current operational lifecycle state of the channel. Drives playout automation eligibility, EPG publication, and scheduling availability in Ericsson MediaFirst. | Column channel_status (STRING) in scheduling.channel. Valid values are `active|inactive|suspended|testing|decommissioned`',
    `channel_type` STRING COMMENT 'Classification of the channel by its distribution and scheduling model. Linear indicates traditional scheduled broadcast; simulcast indicates simultaneous multi-platform broadcast; pop-up indicates temporary event channel; FAST (Free Ad-Supported Streaming Television) indicates ad-supported streaming linear channel; VOD indicates on-demand programming window channel. | Column channel_type (STRING) in scheduling.channel. Valid values are `linear|simulcast|pop-up|FAST|VOD`',
    `content_rating_system` STRING COMMENT 'Default content advisory rating applied to the channels programming under the applicable rating system (e.g., US TV Parental Guidelines). Drives V-chip compliance, parental control enforcement, and COPPA-regulated childrens content restrictions. | Column content_rating_system (STRING) in scheduling.channel. Valid values are `TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA`',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code identifying the country where the channel is licensed and originates its broadcast signal (e.g., USA, GBR, DEU). Used for regulatory jurisdiction determination, rights windowing, and blackout rule enforcement. | Column country_of_origin (STRING) in scheduling.channel. Valid values are `^[A-Z]{3}$`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in scheduling.channel',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this channel record was first created in the system of record. Used for data lineage, audit trail, and record lifecycle tracking in the Silver Layer lakehouse. | Column created_timestamp (TIMESTAMP) in scheduling.channel',
    `dai_enabled` BOOLEAN COMMENT 'Indicates whether Dynamic Ad Insertion (DAI) is active for this channel, enabling server-side ad replacement for OTT/streaming delivery. Drives ad operations workflow in Wide Orbit and integration with DAI platforms. | Column dai_enabled (BOOLEAN) in scheduling.channel',
    `dalet_channel_code` STRING COMMENT 'The channel identifier as configured in Dalet Galaxy Media Asset Management system. Used to link this channel to content ingest workflows, metadata management, archive operations, and rundown generation in Dalet. | Column dalet_channel_code (STRING) in scheduling.channel',
    `decommission_date` DATE COMMENT 'The date on which this channel was or is scheduled to be permanently decommissioned and removed from broadcast. Nullable for active channels. Used for lifecycle management, licence surrender, and EPG removal planning. | Column decommission_date (DATE) in scheduling.channel',
    `drm_enabled` BOOLEAN COMMENT 'Indicates whether Digital Rights Management (DRM) encryption is applied to this channels content stream for OTT/streaming delivery. Drives content protection configuration in Akamai CDN and subscriber entitlement enforcement in Zuora. | Column drm_enabled (BOOLEAN) in scheduling.channel',
    `epg_enabled` BOOLEAN COMMENT 'Indicates whether this channel is published to the Electronic Program Guide (EPG) for audience-facing schedule display. Channels under testing or decommissioned may be excluded from EPG publication. | Column epg_enabled (BOOLEAN) in scheduling.channel',
    `genre` STRING COMMENT 'Primary programming genre classification of the channel (e.g., News, Sports, Entertainment, Children, Documentary, Music). Used for EPG categorization, audience segmentation, advertising sales targeting, and Nielsen ratings demographic alignment. [ENUM-REF-CANDIDATE: News|Sports|Entertainment|Children|Documentary|Music|General|Movies|Lifestyle|Education — promote to reference product] | Column genre (STRING) in scheduling.channel',
    `hls_stream_url` STRING COMMENT 'The HLS (HTTP Live Streaming) manifest URL for this channels live stream, used for Apple device and browser-based OTT delivery via Akamai CDN. Supports ABR (Adaptive Bitrate Streaming) for adaptive quality delivery. | Column hls_stream_url (STRING) in scheduling.channel',
    `launch_date` DATE COMMENT 'The date on which this channel first went live and began broadcasting. Used for channel lifecycle tracking, anniversary reporting, regulatory licence history, and audience growth analytics. | Column launch_date (DATE) in scheduling.channel',
    `logical_channel_number` STRING COMMENT 'The numeric channel position assigned to this channel in the Electronic Program Guide (EPG) and set-top box channel lineup. Used by MVPDs and vMVPDs for channel navigation and must-carry compliance reporting. | Column logical_channel_number (INT) in scheduling.channel',
    `max_ad_load_pct` DECIMAL(18,2) COMMENT 'Maximum percentage of total broadcast hour that may be allocated to advertising on this channel. Governs inventory capacity planning, FCC commercial limits compliance (childrens programming), and upfront/scatter market sales commitments. | Column max_ad_load_pct (DECIMAL(5,2)) in scheduling.channel',
    `mediafirst_channel_code` STRING COMMENT 'The channel identifier as configured in the Ericsson MediaFirst playout automation system. Used to link this master channel record to the playout engine for schedule execution, automation triggers, graphics insertion, and failover configuration. | Column mediafirst_channel_code (STRING) in scheduling.channel',
    `mpeg_dash_stream_url` STRING COMMENT 'The MPEG-DASH (Dynamic Adaptive Streaming over HTTP) manifest URL for this channels live stream, used for Android, Smart TV, and cross-platform OTT delivery via Akamai CDN. | Column mpeg_dash_stream_url (STRING) in scheduling.channel',
    `must_carry_status` BOOLEAN COMMENT 'Indicates whether this channel is subject to must-carry obligations requiring MVPDs to include it in their channel lineup. Drives compliance reporting and carriage fee negotiations. | Column must_carry_status (BOOLEAN) in scheduling.channel',
    `network_name` STRING COMMENT 'Human-readable name of the broadcast network or channel brand (e.g., CNN, BBC One, ESPN). Used as the primary identity label for display in EPG, scheduling tools, and audience-facing interfaces. | Column network_name (STRING) in scheduling.channel',
    `nielsen_station_code` STRING COMMENT 'The unique station identifier assigned by Nielsen Media Research for audience measurement, ratings reporting, and GRP/TRP calculations. Links this channel to Nielsen ratings data for advertising sales and audience analytics. | Column nielsen_station_code (STRING) in scheduling.channel',
    `playout_automation_enabled` BOOLEAN COMMENT 'Indicates whether the channel is configured for automated playout via Ericsson MediaFirst. When true, schedule execution, ad insertion cues, and failover are handled automatically. When false, manual playout operation is required. | Column playout_automation_enabled (BOOLEAN) in scheduling.channel',
    `primary_language` STRING COMMENT 'ISO 639-1/639-2 language code representing the primary audio language of the channels programming (e.g., en for English, es for Spanish, fra for French). Used for EPG metadata, accessibility compliance, and audience targeting. | Column primary_language (STRING) in scheduling.channel. Valid values are `^[a-z]{2,3}$`',
    `resolution_profile` STRING COMMENT 'Video resolution classification of the channel output. SD (Standard Definition), HD (High Definition 1080i/720p), UHD (Ultra High Definition 4K/8K). Determines encoding profiles, CDN delivery tiers, and subscriber package eligibility. | Column resolution_profile (STRING) in scheduling.channel. Valid values are `SD|HD|UHD|4K`',
    `retransmission_consent_required` BOOLEAN COMMENT 'Indicates whether this channel requires retransmission consent from MVPDs before rebroadcasting. Drives carriage fee negotiations and compliance with FCC retransmission consent rules. | Column retransmission_consent_required (BOOLEAN) in scheduling.channel',
    `scte35_enabled` BOOLEAN COMMENT 'Indicates whether SCTE-35 digital program insertion cue markers are active on this channel for Dynamic Ad Insertion (DAI). SCTE-35 signals define ad pod boundaries and splice points used by Wide Orbit traffic system and DAI platforms. | Column scte35_enabled (BOOLEAN) in scheduling.channel',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in scheduling.channel',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in scheduling.channel',
    `transmission_standard` STRING COMMENT 'Technical broadcast transmission standard used to deliver the channel signal. ATSC and ATSC 3.0 apply to North American over-the-air broadcast; DVB-T/T2 and DVB-S/S2 apply to European terrestrial and satellite; QAM applies to cable distribution; IP applies to OTT/streaming delivery. [ENUM-REF-CANDIDATE: ATSC|ATSC3|DVB-T|DVB-T2|DVB-S|DVB-S2|QAM|IP — promote to reference product] | Column transmission_standard (STRING) in scheduling.channel',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in scheduling.channel',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this channel record was most recently modified. Used for change data capture (CDC), incremental ETL processing, and audit trail compliance in the Databricks Silver Layer. | Column updated_timestamp (TIMESTAMP) in scheduling.channel',
    `wide_orbit_station_code` STRING COMMENT 'The station code as configured in the Wide Orbit traffic and billing system. Used to link this channel master record to ad scheduling, sales orders, affidavit generation, and invoicing workflows in Wide Orbit. | Column wide_orbit_station_code (STRING) in scheduling.channel',
    CONSTRAINT pk_channel PRIMARY KEY(`channel_id`)
) COMMENT 'Master record for each linear broadcast channel — capturing network identity, call sign, transmission standard (ATSC, DVB-T/T2, QAM), logical channel number, language, resolution profile (SD/HD/UHD), and playout automation linkage to Ericsson MediaFirst. Serves as the SSOT for channel identity referenced by program schedules, EPG entries, playout events, and simulcast configurations within this domain. | Unity Catalog table: media_broadcasting_ecm.scheduling.channel';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` (
    `daypart_id` BIGINT COMMENT 'Primary key for daypart | Column daypart_id (BIGINT) in scheduling.daypart',
    `dai_configuration_id` BIGINT COMMENT 'Foreign key linking to distribution.dai_configuration. Business justification: Daypart-specific DAI rules enforce regulatory and business constraints (COPPA restrictions in childrens dayparts, primetime ad load caps, scatter vs upfront eligibility). Technical operations configu | Column dai_configuration_id (BIGINT) in distribution.daypart',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in scheduling.daypart',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in scheduling.daypart',
    `ad_pod_max_count` STRING COMMENT 'The maximum number of ad pods (commercial breaks) permitted per hour within this daypart. Used by Wide Orbit for ad scheduling capacity planning and by Ericsson MediaFirst for playout rundown validation. Supports FCC commercial time compliance monitoring. | Column ad_pod_max_count (INT) in scheduling.daypart',
    `ad_pod_max_duration_seconds` STRING COMMENT 'The maximum allowable total duration in seconds for an ad pod (group of ads in a break) within this daypart. Governs commercial break length limits enforced by Ericsson MediaFirst playout automation and Wide Orbit ad scheduling. Aligns with FCC commercial time limits for childrens programming dayparts. | Column ad_pod_max_duration_seconds (INT) in scheduling.daypart',
    `applicable_days` STRING COMMENT 'Pipe-delimited list of days of the week on which this daypart definition applies, using three-letter abbreviations (e.g., MON|TUE|WED|THU|FRI for weekday dayparts, SAT|SUN for weekend). Governs schedule generation in Ericsson MediaFirst and ad inventory availability in Wide Orbit. [ENUM-REF-CANDIDATE: MON|TUE|WED|THU|FRI|SAT|SUN — promote to reference product] | Column applicable_days (STRING) in scheduling.daypart',
    `avg_audience_000` DECIMAL(18,2) COMMENT 'The average audience size in thousands of viewers (000s) expected during this daypart, based on Nielsen Media Research Platform historical ratings data. Used as the principal quantitative measurement of daypart audience value for ad sales, GRP calculations, and content scheduling decisions. | Column avg_audience_000 (DECIMAL(12,2)) in scheduling.daypart',
    `base_cpm_usd` DECIMAL(18,2) COMMENT 'The baseline CPM (Cost Per Mille) rate in US dollars for advertising inventory sold within this daypart, before application of the rate_multiplier or audience demographic adjustments. Represents the floor pricing reference used in Salesforce Media Cloud upfront and scatter market proposals. | Column base_cpm_usd (DECIMAL(10,4)) in scheduling.daypart',
    `blackout_eligible` BOOLEAN COMMENT 'Indicates whether geographic broadcast blackout restrictions can be applied to content scheduled within this daypart. When True, blackout rules (e.g., sports rights geographic exclusivity) may be enforced by the distribution platform. Aligns with must-carry and retransmission consent obligations. | Column blackout_eligible (BOOLEAN) in scheduling.daypart',
    `daypart_code` STRING COMMENT 'Short alphanumeric business identifier for the daypart, used as the externally-known reference key across Wide Orbit traffic system, Ericsson MediaFirst playout automation, and Salesforce Media Cloud ad sales. Examples: PRIME, EARLY_AM, DAYTIME, LATE_FRINGE, OVERNIGHT. Aligns with Nielsen daypart taxonomy codes. | Column daypart_code (STRING) in scheduling.daypart. Valid values are `^[A-Z0-9_]{2,20}$`',
    `content_rating_restriction` STRING COMMENT 'The maximum permissible TV content rating (per MPA/TV Parental Guidelines) for programming scheduled within this daypart. Enforces content appropriateness standards — e.g., Prime Time may allow up to TV-14, while Childrens dayparts are restricted to TV-Y or TV-Y7. Used by Ericsson MediaFirst for schedule validation. | Column content_rating_restriction (STRING) in scheduling.daypart. Valid values are `TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA`',
    `coppa_restricted` BOOLEAN COMMENT 'Indicates whether this daypart is subject to COPPA (Childrens Online Privacy Protection Act) restrictions due to programming directed at children under 13. When True, audience data collection, behavioral targeting, and ad pod duration limits are governed by COPPA compliance rules and FCC childrens television regulations. | Column coppa_restricted (BOOLEAN) in scheduling.daypart',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in scheduling.daypart',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this daypart record was first created in the scheduling domain data product. Supports audit trail, data lineage tracking, and Silver layer ingestion reconciliation in the Databricks Lakehouse. | Column created_timestamp (TIMESTAMP) in scheduling.daypart',
    `dai_eligible` BOOLEAN COMMENT 'Indicates whether this daypart is eligible for Dynamic Ad Insertion (DAI) on OTT and streaming platforms. When True, ad pods within this daypart can be dynamically replaced with targeted ads during streaming delivery through Akamai CDN, enabling addressable advertising revenue. | Column dai_eligible (BOOLEAN) in scheduling.daypart',
    `day_category` STRING COMMENT 'High-level classification of the day-of-week applicability for the daypart. weekday covers Monday–Friday, weekend covers Saturday–Sunday, all_week applies every day, and holiday applies on designated public holidays. Used for rate card segmentation and audience demographic profiling. | Column day_category (STRING) in scheduling.daypart. Valid values are `weekday|weekend|all_week|holiday`',
    `daypart_status` STRING COMMENT 'Current lifecycle state of the daypart definition. active indicates the daypart is in operational use for scheduling and ad sales. inactive means temporarily suspended. draft means under review before activation. deprecated means retired from use but retained for historical reference. | Column daypart_status (STRING) in scheduling.daypart. Valid values are `active|inactive|draft|deprecated`',
    `daypart_type` STRING COMMENT 'Classifies the daypart by broadcast delivery mode. linear applies to traditional scheduled broadcast, non_linear to on-demand programming windows, simulcast to simultaneous multi-platform broadcast segments, and vod_window to VOD availability windows governed by this daypart definition. | Column daypart_type (STRING) in scheduling.daypart. Valid values are `linear|non_linear|simulcast|vod_window`',
    `daypart_description` STRING COMMENT 'Free-text narrative description of the daypart, including its programming characteristics, audience profile, and scheduling context. Used for internal documentation, Salesforce Media Cloud proposal narratives, and EPG metadata. Example: Prime Time (8PM-11PM) — highest-rated evening programming block targeting Adults 18-49. | Column daypart_description (STRING) in scheduling.daypart',
    `duration_minutes` STRING COMMENT 'Total duration of the daypart window expressed in minutes. Derived from start_time and end_time boundaries but stored explicitly for scheduling calculations, ad inventory capacity planning, and rate card generation in Wide Orbit. | Column duration_minutes (INT) in scheduling.daypart',
    `effective_from` DATE COMMENT 'The calendar date from which this daypart definition becomes effective for scheduling and ad sales operations. Supports versioned daypart definitions where boundaries or rates change seasonally or following regulatory updates. Used in Wide Orbit and Ericsson MediaFirst schedule generation. | Column effective_from (DATE) in scheduling.daypart',
    `effective_until` DATE COMMENT 'The calendar date on which this daypart definition expires and is no longer applicable for scheduling and ad sales. Null indicates an open-ended definition with no planned expiry. Supports seasonal daypart adjustments (e.g., summer schedule changes) and regulatory compliance updates. | Column effective_until (DATE) in scheduling.daypart',
    `end_time` TIMESTAMP COMMENT 'The clock time (HH:mm:ss, 24-hour or extended broadcast-day format) at which the daypart ends. Supports broadcast day overflow notation (e.g., 25:59:59 for content airing past midnight within the same broadcast day). Paired with start_time to define the daypart boundary. | Column end_time (TIMESTAMP) in scheduling.daypart',
    `epg_display_order` STRING COMMENT 'The sequential display order of this daypart within the Electronic Program Guide (EPG) channel grid, used by Ericsson MediaFirst for schedule presentation and by digital EPG distribution systems. Lower values appear earlier in the broadcast day display. | Column epg_display_order (INT) in scheduling.daypart',
    `grp_index` DECIMAL(18,2) COMMENT 'The GRP (Gross Rating Point) index value representing the expected audience delivery weight for this daypart relative to the total broadcast day. Used in media planning, upfront negotiations, and scatter market pricing. Sourced from Nielsen Media Research Platform ratings data. | Column grp_index (DECIMAL(8,4)) in scheduling.daypart',
    `hut_level` DECIMAL(18,2) COMMENT 'The HUT (Homes Using Television) percentage representing the proportion of TV households actively viewing during this daypart. A key audience measurement metric sourced from Nielsen Media Research Platform, used to benchmark daypart audience potential and inform ad pricing. | Column hut_level (DECIMAL(6,4)) in scheduling.daypart',
    `makegood_eligible` BOOLEAN COMMENT 'Indicates whether compensatory ad spots (makegoods) can be scheduled within this daypart to fulfill underdelivered audience guarantees from other dayparts. Governs Wide Orbit makegood scheduling logic and Salesforce Media Cloud campaign reconciliation workflows. | Column makegood_eligible (BOOLEAN) in scheduling.daypart',
    `daypart_name` STRING COMMENT 'Human-readable label for the daypart segment as displayed in the Electronic Program Guide (EPG), ad sales proposals, and scheduling interfaces. Examples: Early Morning, Morning Drive, Daytime, Prime Time, Late Fringe, Overnight. | Column daypart_name (STRING) in scheduling.daypart',
    `nielsen_daypart_code` STRING COMMENT 'The standardized daypart code as defined by Nielsen Media Research taxonomy (e.g., PRIME, EARLY_NEWS, LATE_NEWS, DAYTIME, EARLY_FRINGE, LATE_FRINGE, OVERNIGHT). Used to align internal scheduling definitions with Nielsen audience measurement reports and ratings data ingested from the Nielsen Media Research Platform. | Column nielsen_daypart_code (STRING) in scheduling.daypart',
    `rate_multiplier` DECIMAL(18,2) COMMENT 'Pricing multiplier applied to the base CPM (Cost Per Mille) rate card for ad inventory sold within this daypart. A value of 1.0000 represents the base rate; Prime Time typically carries a multiplier greater than 1.0 (e.g., 2.5000), while Overnight may be below 1.0 (e.g., 0.3000). Used in Salesforce Media Cloud proposal generation and Wide Orbit billing. | Column rate_multiplier (DECIMAL(6,4)) in scheduling.daypart',
    `scatter_eligible` BOOLEAN COMMENT 'Indicates whether unsold ad inventory within this daypart is available for scatter market (last-minute) sales. Governs Wide Orbit inventory availability rules for short-notice ad placement and makegood scheduling. | Column scatter_eligible (BOOLEAN) in scheduling.daypart',
    `scte35_cue_enabled` BOOLEAN COMMENT 'Indicates whether SCTE-35 digital program insertion cue markers are enabled for ad break signaling within this daypart. When True, Ericsson MediaFirst playout automation inserts SCTE-35 splice_insert commands at ad pod boundaries, enabling Dynamic Ad Insertion (DAI) for OTT and streaming distribution via Akamai CDN. | Column scte35_cue_enabled (BOOLEAN) in scheduling.daypart',
    `simulcast_eligible` BOOLEAN COMMENT 'Indicates whether content scheduled in this daypart is eligible for simultaneous multi-platform broadcast (simulcast) across linear, OTT, and digital channels. When True, Ericsson MediaFirst can trigger simulcast distribution workflows for this dayparts programming. | Column simulcast_eligible (BOOLEAN) in scheduling.daypart',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in scheduling.daypart',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in scheduling.daypart',
    `start_time` TIMESTAMP COMMENT 'The clock time (HH:mm:ss, 24-hour format) at which the daypart begins each applicable day. Used by Ericsson MediaFirst for automated playout boundary detection and by Wide Orbit for ad scheduling slot assignment. Stored as STRING to support broadcast day conventions (e.g., 25:00:00 for post-midnight). | Column start_time (TIMESTAMP) in scheduling.daypart',
    `sweeps_period_flag` BOOLEAN COMMENT 'Indicates whether this daypart definition has special audience measurement and programming rules applied during Nielsen sweeps periods (intensive ratings measurement periods in February, May, July, and November). When True, enhanced content scheduling and ad pricing rules may apply. | Column sweeps_period_flag (BOOLEAN) in scheduling.daypart',
    `target_demographic` STRING COMMENT 'Primary audience demographic profile associated with this daypart, expressed using Nielsen standard demographic notation (e.g., A18-49, W25-54, M18-34, HH, P2+). Drives audience targeting in ad sales proposals, GRP/TRP calculations, and content scheduling decisions. Sourced from Nielsen Media Research Platform audience measurement data. | Column target_demographic (STRING) in scheduling.daypart',
    `timezone_code` STRING COMMENT 'The IANA timezone identifier (e.g., America/New_York, America/Los_Angeles, Europe/London) governing the clock boundaries of this daypart. Critical for multi-market broadcast operations where the same daypart definition must be applied across different time zones for network affiliates and regional channels. | Column timezone_code (STRING) in scheduling.daypart. Valid values are `^[A-Za-z_/]{3,40}$`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in scheduling.daypart',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to this daypart record. Used for change data capture (CDC), incremental ETL processing in the Databricks Lakehouse Silver layer, and audit trail compliance. | Column updated_timestamp (TIMESTAMP) in scheduling.daypart',
    `upfront_eligible` BOOLEAN COMMENT 'Indicates whether ad inventory within this daypart is offered during the upfront advance advertising sales event. Prime Time and key dayparts are typically upfront-eligible. Drives Salesforce Media Cloud opportunity and proposal configuration for annual upfront sales cycles. | Column upfront_eligible (BOOLEAN) in scheduling.daypart',
    `wide_orbit_daypart_code` STRING COMMENT 'The corresponding daypart identifier as configured in the Wide Orbit traffic and billing system. Used to reconcile internal daypart definitions with ad scheduling, sales orders, and affidavit records in Wide Orbit. Enables cross-system traceability for revenue assurance. | Column wide_orbit_daypart_code (STRING) in scheduling.daypart',
    CONSTRAINT pk_daypart PRIMARY KEY(`daypart_id`)
) COMMENT 'Reference definition of named broadcast time segments (e.g., Early Morning, Morning Drive, Daytime, Prime Time, Late Fringe, Overnight) used to govern ad pricing, content scheduling, and audience targeting. Captures daypart code, start/end time boundaries, day-of-week applicability, audience demographic profile, and rate multiplier. Aligns with Nielsen daypart taxonomy and Wide Orbit traffic system. | Unity Catalog table: media_broadcasting_ecm.scheduling.daypart | Domain ownership: EPG, program schedule, slots, rundowns, ad breaks, dayparts, simulcast, playout (Ericsson MediaFirst)';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` (
    `program_schedule_id` BIGINT COMMENT 'Unique surrogate identifier for the program schedule record. One record per channel per broadcast date per schedule version. This is the primary key of the program_schedule data product. | Column program_schedule_id (BIGINT) in scheduling.program_schedule',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Schedules executed at specific facilities - required for playout coordination, facility capacity planning, multi-site broadcast operations, and as-run log reconciliation. Essential for distributed bro | Column broadcast_facility_id (BIGINT) in technology.program_schedule',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Program schedules must comply with license terms including childrens programming quotas, must-carry requirements, and public interest obligations. Required for FCC quarterly compliance reports and li | Column broadcast_license_id (BIGINT) in compliance.program_schedule',
    `channel_id` BIGINT COMMENT 'Reference to the broadcast channel for which this schedule is defined. Identifies the linear channel in the channel master (e.g., NBC East, CNN HD). Drives Ericsson MediaFirst playout automation for the specific channel. | Column channel_id (BIGINT) in scheduling.program_schedule',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Program schedules incur production and transmission costs tracked to cost centers. Schedule cost reconciliation, budget variance analysis, and production accounting require this mapping. Standard broa | Column cost_center_id (BIGINT) in finance.program_schedule',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Program schedules can be invoiced as sponsored blocks or packaged programming deals (e.g., branded content blocks, sponsored dayparts). Required for package billing, sponsorship revenue recognition, a | Column invoice_id (BIGINT) in billing.program_schedule',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Program schedules are created by specific scheduling coordinators. Critical for workflow tracking, quality control, and accountability when schedule conflicts or errors occur. Standard broadcast traff | Column scheduler_employee_id (BIGINT) in workforce.program_schedule',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in scheduling.program_schedule',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in scheduling.program_schedule',
    `ad_pod_count` STRING COMMENT 'Total number of ad pods (groups of ads in a break) planned in the schedule for this channel day. An ad pod is a contiguous block of commercial spots within a program break. Used for inventory planning and SCTE-35 cue marker validation. | Column ad_pod_count (INT) in scheduling.program_schedule',
    `approved_by` STRING COMMENT 'Name or user identifier of the programming operations staff member who approved this schedule version. Required for audit trail and accountability in the schedule approval workflow. Populated when schedule_status transitions to approved. | Column approved_by (STRING) in scheduling.program_schedule',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this schedule version was formally approved by the programming team. Marks the transition from draft to approved status. Used for SLA tracking of schedule readiness lead time before broadcast date. | Column approved_timestamp (TIMESTAMP) in scheduling.program_schedule',
    `as_run_confirmed_timestamp` TIMESTAMP COMMENT 'Timestamp when the as-run log was confirmed and reconciled against the planned schedule. Marks the transition to as-run status. Used for Wide Orbit affidavit generation, Nielsen ratings reconciliation, and revenue assurance. | Column as_run_confirmed_timestamp (TIMESTAMP) in scheduling.program_schedule',
    `blackout_flag` BOOLEAN COMMENT 'Indicates whether any geographic broadcast blackout restriction applies to this schedule. True = one or more programs in this schedule are subject to blackout in specific markets (e.g., sports rights blackout). Triggers downstream blackout enforcement in distribution and CDN systems. | Column blackout_flag (BOOLEAN) in scheduling.program_schedule',
    `broadcast_date` DATE COMMENT 'The calendar date for which this program schedule is planned and transmitted. Represents the broadcast day (which may span midnight for overnight programming). Formatted as yyyy-MM-dd per enterprise date convention. | Column broadcast_date (DATE) in scheduling.program_schedule',
    `broadcast_standard` STRING COMMENT 'The broadcast technical standard under which this schedule is transmitted. ATSC = Advanced Television Systems Committee (North America); DVB = Digital Video Broadcasting (Europe/international); ISDB = Integrated Services Digital Broadcasting (Japan/Brazil); NTSC/PAL = legacy analog standards. | Column broadcast_standard (STRING) in scheduling.program_schedule. Valid values are `ATSC|DVB|ISDB|NTSC|PAL`',
    `content_rating_advisory` STRING COMMENT 'The highest content rating advisory applicable to any program in this schedule for the broadcast day. Used for parental control systems, V-chip compliance, and FCC content standards reporting. Ratings follow the TV Parental Guidelines system mandated by the FCC. | Column content_rating_advisory (STRING) in scheduling.program_schedule. Valid values are `TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in scheduling.program_schedule',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this program schedule record was first created in the system. Represents the business event time of schedule initiation. Used for audit trail, SLA measurement of schedule build lead time, and data lineage tracking. | Column created_timestamp (TIMESTAMP) in scheduling.program_schedule',
    `dalet_workflow_code` STRING COMMENT 'Reference identifier for the Dalet Galaxy media asset management workflow instance associated with this schedules content preparation and ingest activities. Links the schedule to the MAM workflow for asset readiness validation prior to playout. | Column dalet_workflow_code (STRING) in scheduling.program_schedule',
    `daypart_code` STRING COMMENT 'Primary daypart classification for the schedules dominant programming block. Daypart is the time segment of the broadcast day used for audience measurement, ad sales, and programming strategy. Values align with Nielsen daypart definitions. [ENUM-REF-CANDIDATE: EARLY_MORNING|MORNING|DAYTIME|EARLY_FRINGE|PRIME_ACCESS|PRIME|LATE_NEWS|LATE_FRINGE|OVERNIGHT — promote to reference product] | Column daypart_code (STRING) in scheduling.program_schedule',
    `emergency_alert_ready` BOOLEAN COMMENT 'Indicates whether the schedule has been configured with Emergency Alert System (EAS) interrupt capability for this broadcast date. True = EAS interrupt slots are provisioned in the Ericsson MediaFirst rundown. Required for FCC EAS compliance. | Column emergency_alert_ready (BOOLEAN) in scheduling.program_schedule',
    `epg_grid_code` STRING COMMENT 'External identifier assigned to this schedule in the Electronic Program Guide (EPG) distribution system. Used by downstream EPG aggregators, set-top box providers, and digital guide services to reference the channel day grid. Aligns with DVB SI/EIT table identifiers. | Column epg_grid_code (STRING) in scheduling.program_schedule',
    `fcc_children_programming_compliant` BOOLEAN COMMENT 'Indicates whether this schedule meets FCC childrens educational and informational (E/I) programming requirements for the broadcast date. True = minimum required hours of qualifying childrens programming are scheduled. Required for FCC license renewal compliance reporting. | Column fcc_children_programming_compliant (BOOLEAN) in scheduling.program_schedule',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this program schedule record. Tracks the last update across any field change, version increment, or status transition. Used for change detection in downstream EPG distribution and playout systems. | Column last_modified_timestamp (TIMESTAMP) in scheduling.program_schedule',
    `mediafirst_rundown_code` STRING COMMENT 'Reference identifier for the automation rundown object in Ericsson MediaFirst that corresponds to this program schedule. Used to reconcile the planned schedule with the playout automation systems rundown for failover and as-run log generation. | Column mediafirst_rundown_code (STRING) in scheduling.program_schedule',
    `must_carry_compliant` BOOLEAN COMMENT 'Indicates whether this schedule satisfies must-carry obligations for the channel on this broadcast date. Must-carry is the mandatory channel inclusion requirement imposed on cable and satellite MVPDs by the FCC. True = compliant; False = compliance issue requiring resolution. | Column must_carry_compliant (BOOLEAN) in scheduling.program_schedule',
    `playout_failover_mode` STRING COMMENT 'Indicates the Ericsson MediaFirst playout failover configuration active for this schedule. primary = normal automated playout; backup = failover to backup playout server; manual_override = operator has taken manual control of playout. Used for SLA and incident reporting. | Column playout_failover_mode (STRING) in scheduling.program_schedule. Valid values are `primary|backup|manual_override`',
    `rights_clearance_status` STRING COMMENT 'Aggregate rights clearance status for all programs in this schedule as verified against Rightsline rights management. cleared = all programs have confirmed broadcast rights for this date and territory; pending = clearance in progress; partial = some programs cleared; failed = one or more rights conflicts identified. | Column rights_clearance_status (STRING) in scheduling.program_schedule. Valid values are `cleared|pending|partial|failed`',
    `schedule_end_time` TIMESTAMP COMMENT 'The planned end timestamp of the broadcast schedule for this channel day, including timezone offset. Typically 23:59:59 local broadcast time but may extend past midnight for overnight programming blocks. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX. | Column schedule_end_time (TIMESTAMP) in scheduling.program_schedule',
    `schedule_name` STRING COMMENT 'Human-readable label for the schedule, typically combining channel name and broadcast date (e.g., CNN-HD 2024-06-15 v2). Used by scheduling operations staff to identify and reference the schedule in Ericsson MediaFirst and Wide Orbit Traffic systems. | Column schedule_name (STRING) in scheduling.program_schedule',
    `schedule_notes` STRING COMMENT 'Free-text operational notes entered by scheduling staff regarding special instructions, exceptions, or context for this schedule (e.g., Breaking news override applied to 8PM slot, Live sports event extends prime block by 30 min). Not used for automated processing. | Column schedule_notes (STRING) in scheduling.program_schedule',
    `schedule_source` STRING COMMENT 'Indicates how this schedule was generated. manual = built by scheduling staff; automated = generated by Ericsson MediaFirst automated schedule engine; imported = ingested from an external programming supplier or network feed; template = derived from a recurring schedule template. | Column schedule_source (STRING) in scheduling.program_schedule. Valid values are `manual|automated|imported|template`',
    `schedule_start_time` TIMESTAMP COMMENT 'The planned start timestamp of the broadcast schedule for this channel day, including timezone offset. Typically 00:00:00 local broadcast time but may differ for overnight schedules that begin at a non-midnight boundary. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX. | Column schedule_start_time (TIMESTAMP) in scheduling.program_schedule',
    `schedule_status` STRING COMMENT 'Current lifecycle state of the program schedule. draft = initial build in progress; approved = signed off by programming team; transmitted = sent to Ericsson MediaFirst playout automation; as-run = actual broadcast log confirmed; cancelled = schedule voided and replaced. | Column schedule_status (STRING) in scheduling.program_schedule. Valid values are `draft|approved|transmitted|as-run|cancelled`',
    `schedule_type` STRING COMMENT 'Classification of the schedule by programming strategy type. standard = regular broadcast day; special_event = live event or breaking news override; holiday = holiday programming grid; sweeps = Nielsen sweeps period intensive ratings schedule; upfront_preview = advance advertising sales event programming. | Column schedule_type (STRING) in scheduling.program_schedule. Valid values are `standard|special_event|holiday|sweeps|upfront_preview`',
    `schedule_version` STRING COMMENT 'Monotonically incrementing version number for the schedule on a given channel and broadcast date. Enables tracking of schedule revisions from initial draft through final as-run. Version 1 is the initial draft; each approved revision increments the version. | Column schedule_version (INT) in scheduling.program_schedule',
    `scte35_cue_count` STRING COMMENT 'Total number of SCTE-35 digital program insertion cue markers embedded in the schedule for this channel day. SCTE-35 cues signal ad break opportunities for Dynamic Ad Insertion (DAI) in both linear and OTT streams. Used to validate DAI readiness. | Column scte35_cue_count (INT) in scheduling.program_schedule',
    `simulcast_flag` BOOLEAN COMMENT 'Indicates whether this schedule is configured for simultaneous multi-platform broadcast (simulcast). True = the schedule is transmitted concurrently across linear broadcast and one or more OTT/streaming platforms. Drives Ericsson MediaFirst simulcast automation configuration. | Column simulcast_flag (BOOLEAN) in scheduling.program_schedule',
    `simulcast_platform_count` STRING COMMENT 'Number of platforms on which this schedule is simultaneously broadcast when simulcast_flag is True. Used for multi-platform distribution planning and rights compliance verification across linear, OTT, and vMVPD delivery channels. | Column simulcast_platform_count (INT) in scheduling.program_schedule',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in scheduling.program_schedule',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in scheduling.program_schedule',
    `timezone` STRING COMMENT 'IANA timezone identifier for the broadcast timezone in which this schedules times are expressed (e.g., America/New_York, Europe/London). Critical for accurate EPG display, daypart classification, and regulatory compliance reporting across markets. | Column timezone (STRING) in scheduling.program_schedule',
    `total_ad_time_seconds` STRING COMMENT 'Total planned advertising airtime in seconds across all ad pods in the schedule for this channel day. Used for commercial inventory management, FCC commercial limits compliance, and revenue forecasting against Wide Orbit traffic orders. | Column total_ad_time_seconds (INT) in scheduling.program_schedule',
    `total_program_time_seconds` STRING COMMENT 'Total planned programming (non-commercial) airtime in seconds for this channel day schedule. Equals total_runtime_seconds minus total_ad_time_seconds. Used for content utilization reporting and rights compliance verification. | Column total_program_time_seconds (INT) in scheduling.program_schedule',
    `total_runtime_seconds` STRING COMMENT 'Total planned runtime of all program items in the schedule, expressed in seconds. Used to validate that the schedule fills the full broadcast day (86,400 seconds for a 24-hour schedule) and to detect gaps or overlaps in the rundown. | Column total_runtime_seconds (INT) in scheduling.program_schedule',
    `transmission_type` STRING COMMENT 'Indicates the primary mode of content delivery for this schedule. linear = traditional scheduled broadcast; vod_window = on-demand programming window; fast_channel = Free Ad-Supported Streaming Television (FAST) channel; simulcast = simultaneous multi-platform broadcast. | Column transmission_type (STRING) in scheduling.program_schedule. Valid values are `linear|vod_window|fast_channel|simulcast`',
    `transmitted_timestamp` TIMESTAMP COMMENT 'Timestamp when the approved schedule was transmitted to the Ericsson MediaFirst playout automation system. Marks the transition from approved to transmitted status. Used for playout readiness SLA monitoring and failover preparation. | Column transmitted_timestamp (TIMESTAMP) in scheduling.program_schedule',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in scheduling.program_schedule',
    `wide_orbit_log_code` STRING COMMENT 'Reference identifier for the corresponding traffic log in Wide Orbit Traffic and Billing system. Links the program schedule to the ad scheduling and affidavit records for commercial break reconciliation and proof-of-broadcast (affidavit) generation. | Column wide_orbit_log_code (STRING) in scheduling.program_schedule',
    CONSTRAINT pk_program_schedule PRIMARY KEY(`program_schedule_id`)
) COMMENT 'The authoritative linear channel grid (EPG backbone) representing the planned broadcast schedule for a channel on a given broadcast date. Captures schedule version, channel, broadcast date, schedule status (draft, approved, transmitted, as-run), total runtime, blackout flags, must-carry compliance status, and the Ericsson MediaFirst automation rundown reference. One record per channel per broadcast day per schedule version. | Unity Catalog table: media_broadcasting_ecm.scheduling.program_schedule | Domain ownership: EPG, program schedule, slots, rundowns, ad breaks, dayparts, simulcast, playout (Ericsson MediaFirst)';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` (
    `schedule_slot_id` BIGINT COMMENT 'Unique surrogate identifier for each individual schedule slot record within the Electronic Program Guide (EPG) rundown. Primary key for the schedule_slot data product managed in Ericsson MediaFirst. | Column schedule_slot_id (BIGINT) in scheduling.schedule_slot',
    `ad_pod_id` BIGINT COMMENT 'Reference to the ad pod (group of commercials within a break) associated with this slot when the slot type is a commercial break. Populated only for commercial break slots; null for program and promo slots. | Column ad_pod_id (BIGINT) in sales.schedule_slot',
    `channel_id` BIGINT COMMENT 'Reference to the linear broadcast channel on which this schedule slot is programmed. Identifies the originating channel within the EPG grid. | Column channel_id (BIGINT) in scheduling.schedule_slot',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Each scheduled slot requires verified content rating for daypart appropriateness (watershed compliance), V-chip encoding, and parental guidance systems. Real-time compliance verification prevents regu | Column compliance_content_rating_id (BIGINT) in compliance.schedule_slot',
    `daypart_id` BIGINT COMMENT 'Reference to the daypart classification assigned to this slot (e.g., Prime Time, Late Night, Morning Drive). Dayparts are standard time segments of the broadcast day used for audience targeting and advertising rate-card pricing. | Column daypart_id (BIGINT) in scheduling.schedule_slot',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Schedule slots must reference the specific media file for playout automation systems (MediaFirst, WideOrbit) to execute. Critical for broadcast operations - automation pulls the actual file URI from t | Column media_asset_id (BIGINT) in mediaasset.schedule_slot',
    `program_schedule_id` BIGINT COMMENT 'Reference to the parent broadcast schedule or rundown document that contains this slot. Links the atomic slot to its daily or weekly schedule container in Ericsson MediaFirst. | Column program_schedule_id (BIGINT) in scheduling.schedule_slot',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Schedule slots generate revenue through ad sales, sponsorships, and carriage fees. ASC 606 revenue recognition, sales order fulfillment, and revenue assurance all require slot-to-revenue-stream mappin | Column revenue_stream_id (BIGINT) in finance.schedule_slot',
    `scheduling_availability_window_id` BIGINT COMMENT 'Reference to the active rights window in Rightsline that authorizes the broadcast of the content in this slot. Validates that the airing falls within the licensed holdback and windowing period for the territory and platform. | Column scheduling_availability_window_id (BIGINT) in scheduling.schedule_slot',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: On-air talent (hosts, anchors, guests) are scheduled in broadcast slots. Scheduling systems track which talent appears in which slot for call sheets, union reporting, rights clearance verification, an | Column talent_profile_id (BIGINT) in talent.schedule_slot',
    `title_id` BIGINT COMMENT 'Reference to the content asset or media item assigned to this slot. Links to the Digital Asset Management (DAM) record in Dalet Galaxy for the program, promo, commercial, or filler material. | Column title_id (BIGINT) in content.schedule_slot',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Traffic coordinators assign and manage individual schedule slots, handle preemptions, and coordinate with sales. Standard broadcast traffic operations workflow requires tracking who manages each slot  | Column traffic_coordinator_employee_id (BIGINT) in workforce.schedule_slot',
    `transmission_equipment_id` BIGINT COMMENT 'Foreign key linking to technology.transmission_equipment. Business justification: Slots may require specific transmission equipment for live events, special broadcasts, or equipment-specific configurations - supports technical coordination, equipment allocation, and signal routing  | Column transmission_equipment_id (BIGINT) in technology.schedule_slot',
    `schedule_status_ref_id` BIGINT COMMENT '',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in scheduling.schedule_slot',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in scheduling.schedule_slot',
    `actual_duration_seconds` STRING COMMENT 'Real-world duration of the slot in seconds as recorded in the as-run log. Compared against planned_duration_seconds to identify overruns, underruns, and schedule compliance deviations. Used in affidavit reconciliation and makegoods processing. | Column actual_duration_seconds (INT) in scheduling.schedule_slot',
    `actual_start_time` TIMESTAMP COMMENT 'Real-world start time of the slot as recorded in the as-run log by Ericsson MediaFirst playout automation. May differ from planned_start_time due to live events, technical delays, or schedule overruns. Critical for affidavit generation in Wide Orbit and Nielsen audience measurement reconciliation. | Column actual_start_time (TIMESTAMP) in scheduling.schedule_slot',
    `aspect_ratio` STRING COMMENT 'Video aspect ratio of the content assigned to this slot. Drives playout automation letterboxing/pillarboxing decisions in Ericsson MediaFirst and ensures compliance with broadcast technical standards. | Column aspect_ratio (NUMERIC) in scheduling.schedule_slot',
    `audio_format` STRING COMMENT 'Audio encoding format for the content in this slot (e.g., stereo, Dolby 5.1, Dolby Atmos, mono). Required for playout automation configuration in Ericsson MediaFirst and compliance with broadcast audio loudness standards. | Column audio_format (STRING) in scheduling.schedule_slot. Valid values are `stereo|dolby_5_1|dolby_atmos|mono|surround`',
    `automation_event_code` STRING COMMENT 'Ericsson MediaFirst playout automation system event identifier for this slot. The native key from the MediaFirst rundown used for as-run reconciliation, failover event tracking, and technical operations audit. | Column automation_event_code (STRING) in scheduling.schedule_slot',
    `broadcast_date` DATE COMMENT 'Calendar date on which this slot is scheduled to air, expressed in yyyy-MM-dd format. Used as the primary partition key for EPG queries, Nielsen ratings alignment, and daily schedule reporting. Represents the broadcast day which may span midnight for overnight programming. | Column broadcast_date (DATE) in scheduling.schedule_slot',
    `closed_caption_flag` BOOLEAN COMMENT 'Indicates whether closed captioning is present and enabled for this slot (True). Mandatory for FCC compliance under the Twenty-First Century Communications and Video Accessibility Act (CVAA) for applicable programming. | Column closed_caption_flag (BOOLEAN) in scheduling.schedule_slot',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in scheduling.schedule_slot',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this schedule slot record was first created in the EPG system. Supports audit trail requirements, schedule change history analysis, and data lineage tracking in the Databricks Silver Layer. | Column created_timestamp (TIMESTAMP) in scheduling.schedule_slot',
    `eas_alert_type` STRING COMMENT 'Type of Emergency Alert System (EAS) message associated with this slot when slot_type is eas (e.g., EAN — Emergency Action Notification, NPT — National Periodic Test, RWT — Required Weekly Test). Null for non-EAS slots. Mandatory for FCC EAS compliance logging. [ENUM-REF-CANDIDATE: EAN|NPT|RWT|SVR|TOR|FFW|HUW|WSW — promote to reference product] | Column eas_alert_type (STRING) in scheduling.schedule_slot',
    `episode_number` STRING COMMENT 'Episode identifier for serialized program content in this slot (e.g., S02E05 for Season 2, Episode 5). Used for rights window tracking in Rightsline, repeat detection, and EPG metadata publication. | Column episode_number (STRING) in scheduling.schedule_slot',
    `is_blackout` BOOLEAN COMMENT 'Indicates whether a geographic broadcast restriction (blackout) applies to this slot (True). Blackout rules are enforced at the distribution layer and must be flagged at the slot level for rights compliance and audience measurement exclusion. | Column is_blackout (BOOLEAN) in scheduling.schedule_slot',
    `is_live` BOOLEAN COMMENT 'Indicates whether this slot carries a live broadcast event (True) or pre-recorded/taped content (False). Live slots require different playout automation handling, DAI configuration, and rights clearance verification in Rightsline. | Column is_live (BOOLEAN) in scheduling.schedule_slot',
    `is_repeat` BOOLEAN COMMENT 'Indicates whether this slot is a repeat airing of previously broadcast content (True) rather than a first-run premiere (False). Affects talent residuals calculations in Rightsline and Nielsen audience measurement weighting. | Column is_repeat (BOOLEAN) in scheduling.schedule_slot',
    `is_simulcast` BOOLEAN COMMENT 'Indicates whether this slot is simultaneously broadcast across multiple platforms or channels (True). Simulcast slots require coordinated playout across linear and OTT/streaming distribution paths and may trigger additional rights obligations. | Column is_simulcast (BOOLEAN) in scheduling.schedule_slot',
    `isan_code` STRING COMMENT 'International Standard Audiovisual Number (ISAN) uniquely identifying the audiovisual work airing in this slot. Enables cross-platform content identification, rights clearance verification in Rightsline, and royalty calculation for residuals. | Column isan_code (STRING) in scheduling.schedule_slot. Valid values are `^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$`',
    `isci_code` STRING COMMENT 'Industry Standard Commercial Identification (ISCI) code for the commercial spot airing in this slot. An 8-character alphanumeric code used by Wide Orbit and ad agencies to uniquely identify a specific commercial creative. Null for non-commercial slot types. | Column isci_code (STRING) in scheduling.schedule_slot. Valid values are `^[A-Z0-9]{8}$`',
    `must_carry_flag` BOOLEAN COMMENT 'Indicates whether this slot is subject to must-carry obligations requiring MVPDs to include this channel/content in their basic tier (True). Flags slots that cannot be blacked out or substituted under FCC must-carry rules. | Column must_carry_flag (BOOLEAN) in scheduling.schedule_slot',
    `nielsen_program_code` STRING COMMENT 'Nielsen Media Research proprietary program code assigned to the content in this slot. Used to match as-run schedule data with Nielsen ratings data for audience measurement, GRP/TRP calculation, and advertiser reporting. | Column nielsen_program_code (STRING) in scheduling.schedule_slot',
    `planned_duration_seconds` STRING COMMENT 'Intended duration of the slot in seconds as scheduled in the EPG rundown. Used for schedule integrity validation, ad pod capacity planning, and compliance with broadcast standards for minimum program duration. | Column planned_duration_seconds (INT) in scheduling.schedule_slot',
    `planned_end_time` TIMESTAMP COMMENT 'Scheduled end date and time for this slot as defined in the EPG rundown. Derived from planned_start_time plus planned_duration_seconds but stored explicitly to support EPG grid queries and boundary validation. | Column planned_end_time (TIMESTAMP) in scheduling.schedule_slot',
    `planned_start_time` TIMESTAMP COMMENT 'Scheduled start date and time for this slot as defined in the EPG rundown prior to broadcast. Expressed in ISO 8601 format with timezone offset. Used for EPG publication, audience measurement alignment, and ad trafficking in Wide Orbit. | Column planned_start_time (TIMESTAMP) in scheduling.schedule_slot',
    `program_title` STRING COMMENT 'Human-readable title of the program or content event airing in this slot as it appears in the published EPG. Used for audience-facing program guides, Nielsen ratings matching, and schedule reporting. | Column program_title (STRING) in scheduling.schedule_slot',
    `resolution` STRING COMMENT 'Video resolution classification of the content in this slot (SD, HD, UHD, 4K). Determines the playout chain and CDN delivery profile used by Akamai and affects carriage fee agreements with MVPDs. | Column resolution (STRING) in scheduling.schedule_slot. Valid values are `SD|HD|UHD|4K`',
    `schedule_version` STRING COMMENT 'Version number of the schedule rundown in which this slot was last modified. Incremented each time the EPG rundown is revised in Ericsson MediaFirst. Supports schedule change audit trails and version comparison for compliance reporting. | Column schedule_version (INT) in scheduling.schedule_slot',
    `scte35_cue_in_time` TIMESTAMP COMMENT 'Timestamp of the SCTE-35 splice_insert cue-in signal marking the return to primary program content after an ad break. Paired with scte35_cue_out_time to define the exact ad avail window for DAI and Wide Orbit ad scheduling. | Column scte35_cue_in_time (TIMESTAMP) in scheduling.schedule_slot',
    `scte35_cue_out_time` TIMESTAMP COMMENT 'Timestamp of the SCTE-35 splice_insert cue-out signal marking the start of an ad break or content interruption within this slot. Used by Dynamic Ad Insertion (DAI) systems and downstream distribution platforms to trigger ad replacement. Null for non-break slot types. | Column scte35_cue_out_time (TIMESTAMP) in scheduling.schedule_slot',
    `secondary_audio_flag` BOOLEAN COMMENT 'Indicates whether a Secondary Audio Program (SAP) track is available for this slot (True), typically used for audio description (AD) for visually impaired viewers or alternate language audio. Required for FCC video description compliance reporting. | Column secondary_audio_flag (BOOLEAN) in scheduling.schedule_slot',
    `slot_sequence_number` STRING COMMENT 'Ordinal position of this slot within the daily rundown for the channel. Determines the playout order in Ericsson MediaFirst automation. Sequence numbers are contiguous integers starting at 1 for each broadcast day. | Column slot_sequence_number (INT) in scheduling.schedule_slot',
    `slot_status` STRING COMMENT 'Current lifecycle state of the schedule slot within the EPG workflow. Values: scheduled (initial EPG entry), confirmed (locked for playout), on_air (currently broadcasting), completed (as-run recorded), cancelled (removed from schedule), replaced (substituted with alternate content). Drives Ericsson MediaFirst automation state machine. | Column slot_status (STRING) in scheduling.schedule_slot. Valid values are `scheduled|confirmed|on_air|completed|cancelled|replaced`',
    `slot_type` STRING COMMENT 'Classification of the schedule slot by content category. Values: program (primary editorial content), promo (promotional spot), commercial_break (paid advertising break), filler (interstitial padding content), psa (Public Service Announcement), eas (Emergency Alert System message). Drives playout automation logic and ad insertion rules in Ericsson MediaFirst. | Column slot_type (STRING) in scheduling.schedule_slot. Valid values are `program|promo|commercial_break|filler|psa|eas`',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in scheduling.schedule_slot',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in scheduling.schedule_slot',
    `traffic_order_number` STRING COMMENT 'Wide Orbit traffic system order number associated with this slot when it carries a commercial or promotional spot. Links the EPG slot to the ad sales order for affidavit generation, billing reconciliation, and makegood processing. | Column traffic_order_number (STRING) in scheduling.schedule_slot',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in scheduling.schedule_slot',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this schedule slot record was last modified. Tracks EPG edits, schedule revisions, and as-run updates. Used in conjunction with schedule_version for change management and compliance audit. | Column updated_timestamp (TIMESTAMP) in scheduling.schedule_slot',
    CONSTRAINT pk_schedule_slot PRIMARY KEY(`schedule_slot_id`)
) COMMENT 'Individual time slot within a program schedule representing a single content event or break event on a linear channel. Captures slot sequence number, planned start time, planned duration, actual start time (as-run), actual duration, slot type (program, promo, commercial break, filler, PSA, EAS), content reference, daypart assignment, and live/tape flag. The atomic unit of the EPG rundown managed in Ericsson MediaFirst. | Unity Catalog table: media_broadcasting_ecm.scheduling.schedule_slot | Domain ownership: EPG, program schedule, slots, rundowns, ad breaks, dayparts, simulcast, playout (Ericsson MediaFirst)';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` (
    `epg_entry_id` BIGINT COMMENT 'Unique surrogate identifier for each Electronic Program Guide (EPG) entry record in the scheduling domain. Serves as the primary key for this Silver Layer data product. | Column epg_entry_id (BIGINT) in scheduling.epg_entry',
    `channel_id` BIGINT COMMENT 'Reference to the broadcast channel on which this EPG entry is scheduled for playout. Links to the channel master record in the scheduling domain. | Column channel_id (BIGINT) in scheduling.epg_entry',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: EPG displays must show accurate content ratings for viewer guidance, V-chip filtering, and watershed compliance. Regulatory requirement in UK (Ofcom) and US (FCC) for electronic program guides. Denorm | Column compliance_content_rating_id (BIGINT) in compliance.epg_entry',
    `media_asset_id` BIGINT COMMENT 'Reference to the media content asset in the Digital Asset Management system (Dalet Galaxy) that is being broadcast for this EPG entry. | Column media_asset_id (BIGINT) in mediaasset.epg_entry',
    `rights_availability_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_availability_window. Business justification: EPG publication workflow requires real-time validation that content is within its rights availability window before displaying to viewers. Prevents publishing unavailable content and supports automate | Column rights_availability_window_id (BIGINT) in rights.epg_entry',
    `schedule_slot_id` BIGINT COMMENT 'Reference to the approved schedule slot from which this EPG entry was derived. Represents the authoritative playout scheduling record in Ericsson MediaFirst. | Column schedule_slot_id (BIGINT) in scheduling.epg_entry',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: EPG entries require daypart linkage for audience reach estimation, program discovery optimization, and daypart-based content recommendations. Creates new scheduling_daypart_id FK (role-prefixed to avo | Column scheduling_daypart_id (BIGINT) in scheduling.epg_entry',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: EPG metadata includes featured talent names for viewer discovery, search functionality, and promotional purposes. Broadcasters link talent profiles to EPG entries to enable find shows with this actor | Column talent_profile_id (BIGINT) in talent.epg_entry',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in scheduling.epg_entry',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in scheduling.epg_entry',
    `ad_pod_count` STRING COMMENT 'The number of ad pods (groups of advertisements within a break) scheduled within this program. Used for advertising inventory planning, Wide Orbit traffic scheduling, and revenue forecasting. | Column ad_pod_count (INT) in scheduling.epg_entry',
    `blackout_region_codes` STRING COMMENT 'Comma-separated list of geographic region or market codes where this program is subject to broadcast blackout restrictions. Used by distribution systems to suppress EPG entry delivery in restricted markets. Populated only when is_blackout is True. | Column blackout_region_codes (STRING) in scheduling.epg_entry',
    `broadcast_date` DATE COMMENT 'The calendar date on which this program is scheduled to air, in yyyy-MM-dd format. Used for day-level EPG grid display, daypart assignment, and schedule reporting. | Column broadcast_date (DATE) in scheduling.epg_entry',
    `epg_entry_code` STRING COMMENT 'Externally distributed business identifier for this EPG entry, used in feeds delivered to MVPDs, vMVPDs, set-top boxes, and digital platforms for program discovery. Format: EPG-{CHANNEL}-{YYYYMMDD}-{HHMMSS}. | Column epg_entry_code (STRING) in scheduling.epg_entry. Valid values are `^EPG-[A-Z0-9]{3,10}-[0-9]{8}-[0-9]{6}$`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in scheduling.epg_entry',
    `distribution_window` STRING COMMENT 'The distribution window or release strategy under which this EPG entry is being broadcast, reflecting the windowing strategy for sequential content release. Determines rights availability and platform eligibility per Rightsline contract terms. | Column distribution_window (STRING) in scheduling.epg_entry. Valid values are `linear|svod|avod|tvod|fast|syndication`',
    `duration_seconds` STRING COMMENT 'The total scheduled duration of the program in seconds, derived from the difference between scheduled start and end times. Used for EPG display, ad pod planning, and playout automation validation. | Column duration_seconds (INT) in scheduling.epg_entry',
    `eidr` STRING COMMENT 'The Entertainment Identifier Registry (EIDR) identifier for this content, providing a universal content identifier used across the media supply chain for content tracking, rights management, and EPG data exchange with MVPDs and vMVPDs. | Column eidr (STRING) in scheduling.epg_entry. Valid values are `^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$`',
    `entry_status` STRING COMMENT 'The current lifecycle status of this EPG entry within the scheduling workflow. draft indicates pending review; approved indicates cleared for distribution; published indicates actively distributed to EPG feeds; cancelled indicates removed from schedule; expired indicates the broadcast window has passed. | Column entry_status (STRING) in scheduling.epg_entry. Valid values are `draft|approved|published|cancelled|expired`',
    `epg_feed_version` STRING COMMENT 'The version number of this EPG entry record as distributed in the EPG feed. Incremented each time the entry is updated and redistributed to MVPDs, vMVPDs, and digital platforms. Enables downstream systems to detect and apply updates. | Column epg_feed_version (INT) in scheduling.epg_entry',
    `episode_number` STRING COMMENT 'The sequential episode number within the season for this EPG entry. Used for viewer navigation and content ordering in EPG feeds. Null for non-episodic content. | Column episode_number (INT) in scheduling.epg_entry',
    `episode_title` STRING COMMENT 'The title of the specific episode within a series, as displayed in the EPG. Null for non-episodic content such as feature films or standalone specials. | Column episode_title (STRING) in scheduling.epg_entry',
    `genre_primary` STRING COMMENT 'The primary content genre classification for this EPG entry as distributed in the EPG feed (e.g., Drama, Comedy, News, Sports, Documentary, Reality). Used for viewer discovery, content filtering, and audience analytics. [ENUM-REF-CANDIDATE: drama|comedy|news|sports|documentary|reality|entertainment|children|film|music — promote to reference product] | Column genre_primary (STRING) in scheduling.epg_entry',
    `genre_secondary` STRING COMMENT 'An optional secondary genre sub-classification providing more granular content categorization for EPG discovery and audience targeting (e.g., Crime Drama, Political Comedy, Investigative Documentary). | Column genre_secondary (STRING) in scheduling.epg_entry',
    `is_blackout` BOOLEAN COMMENT 'Indicates whether geographic broadcast restrictions (blackout) apply to this EPG entry (True). When True, the program is subject to blackout rules that restrict distribution in specific geographic markets per rights agreements managed in Rightsline. | Column is_blackout (BOOLEAN) in scheduling.epg_entry',
    `is_closed_caption` BOOLEAN COMMENT 'Indicates whether closed captioning (CC) is available for this program (True). Distributed in EPG feeds for accessibility compliance and viewer information. Required for FCC closed captioning regulatory compliance. | Column is_closed_caption (BOOLEAN) in scheduling.epg_entry',
    `is_hdr` BOOLEAN COMMENT 'Indicates whether this program is available in High Dynamic Range (HDR) format (True). Distributed in EPG feeds to inform viewers and set-top boxes of enhanced picture quality availability. | Column is_hdr (BOOLEAN) in scheduling.epg_entry',
    `is_live` BOOLEAN COMMENT 'Indicates whether this EPG entry represents a live broadcast event (True) as opposed to a pre-recorded or time-shifted program (False). Drives playout automation configuration in Ericsson MediaFirst and is distributed in EPG feeds for viewer-facing live indicators. | Column is_live (BOOLEAN) in scheduling.epg_entry',
    `is_new_episode` BOOLEAN COMMENT 'Indicates whether this EPG entry represents a new, first-run episode (True) or a repeat/rerun broadcast (False). Distributed in EPG feeds for viewer-facing NEW indicators and drives audience measurement prioritization. | Column is_new_episode (BOOLEAN) in scheduling.epg_entry',
    `is_simulcast` BOOLEAN COMMENT 'Indicates whether this program is being simultaneously broadcast across multiple platforms or channels (simulcast). When True, the same content is distributed concurrently on linear and digital/OTT platforms. | Column is_simulcast (BOOLEAN) in scheduling.epg_entry',
    `isan` STRING COMMENT 'The International Standard Audiovisual Number (ISAN) uniquely identifying this audiovisual work globally. Used for rights management, content identification across platforms, and interoperability with Rightsline and international content registries. | Column isan (STRING) in scheduling.epg_entry. Valid values are `^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$`',
    `language_code` STRING COMMENT 'The primary audio language of the program, expressed as a three-letter ISO 639-2 language code (e.g., eng for English, spa for Spanish). Used in EPG feeds for language filtering and accessibility compliance. | Column language_code (STRING) in scheduling.epg_entry. Valid values are `^[a-z]{3}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this EPG entry record was most recently modified, including schedule changes, metadata updates, or status transitions. Used for change detection in downstream EPG feed distribution and audit trail. | Column last_updated_timestamp (TIMESTAMP) in scheduling.epg_entry',
    `program_title` STRING COMMENT 'The primary viewer-facing title of the program as it appears in the Electronic Program Guide. Used for consumer-facing program discovery across all distribution platforms. | Column program_title (STRING) in scheduling.epg_entry',
    `published_timestamp` TIMESTAMP COMMENT 'The date and time when this EPG entry was first published and distributed to external EPG feeds (MVPDs, vMVPDs, set-top boxes, digital platforms). Serves as the record audit created timestamp for this data product. | Column published_timestamp (TIMESTAMP) in scheduling.epg_entry',
    `rights_window_end` DATE COMMENT 'The end date of the broadcast rights window during which this content is cleared for transmission on this channel. After this date, the content enters a holdback period and cannot be broadcast without rights renewal in Rightsline. | Column rights_window_end (DATE) in scheduling.epg_entry',
    `rights_window_start` DATE COMMENT 'The start date of the broadcast rights window during which this content is cleared for transmission on this channel. Derived from Rightsline contract availabilities and used to validate schedule compliance. | Column rights_window_start (DATE) in scheduling.epg_entry',
    `scheduled_end_time` TIMESTAMP COMMENT 'The precise date and time at which this program is scheduled to end broadcast on the channel. Used to calculate program duration and to sequence adjacent EPG entries in the linear channel grid. | Column scheduled_end_time (TIMESTAMP) in scheduling.epg_entry',
    `scheduled_start_time` TIMESTAMP COMMENT 'The precise date and time at which this program is scheduled to begin broadcast on the channel, expressed in ISO 8601 format with timezone offset. This is the principal business event timestamp for the EPG entry and drives all downstream playout automation in Ericsson MediaFirst. | Column scheduled_start_time (TIMESTAMP) in scheduling.epg_entry',
    `scte35_cue_out_time` TIMESTAMP COMMENT 'The timestamp of the SCTE-35 splice_insert cue-out signal marking the start of an ad break opportunity within this program. Used by Dynamic Ad Insertion (DAI) systems and Wide Orbit traffic systems for ad pod placement and automated ad scheduling. | Column scte35_cue_out_time (TIMESTAMP) in scheduling.epg_entry',
    `season_number` STRING COMMENT 'The season number within the series for this episode. Used for EPG display and content navigation. Null for non-episodic or non-seasonal content. | Column season_number (INT) in scheduling.epg_entry',
    `series_name` STRING COMMENT 'The name of the parent series or franchise to which this episode belongs. Enables series-level grouping and discovery in EPG interfaces. Null for non-series content. | Column series_name (STRING) in scheduling.epg_entry',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in scheduling.epg_entry',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in scheduling.epg_entry',
    `synopsis_long` STRING COMMENT 'A detailed program description (typically up to 500 characters) distributed in EPG feeds for display on digital platforms, OTT apps, and web-based program guides. Sourced from Dalet Galaxy content metadata. | Column synopsis_long (STRING) in scheduling.epg_entry',
    `synopsis_short` STRING COMMENT 'A brief program description (typically up to 100 characters) distributed in EPG feeds for display on set-top boxes and digital platforms with limited screen real estate. Sourced from Dalet Galaxy content metadata. | Column synopsis_short (STRING) in scheduling.epg_entry',
    `total_ad_break_duration_seconds` STRING COMMENT 'The total cumulative duration in seconds of all scheduled ad breaks within this program. Used for advertising inventory management, compliance with ad load regulations, and Wide Orbit traffic scheduling. | Column total_ad_break_duration_seconds (INT) in scheduling.epg_entry',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in scheduling.epg_entry',
    `video_resolution` STRING COMMENT 'The video resolution format of this program as distributed in the EPG feed (e.g., SD, HD, FHD, UHD/4K). Used for viewer-facing display in EPG interfaces and for platform compatibility routing. | Column video_resolution (STRING) in scheduling.epg_entry. Valid values are `SD|HD|FHD|UHD|4K|8K`',
    CONSTRAINT pk_epg_entry PRIMARY KEY(`epg_entry_id`)
) COMMENT 'Published Electronic Program Guide record distributed to MVPDs, vMVPDs, set-top boxes, and digital platforms for viewer-facing program discovery. Captures program title, episode title, series name, genre, content rating (MPA), short and long synopsis, start/end time, channel, language, closed-caption flag, HDR/resolution flag, ISAN/EIDR identifier, and distribution window. Derived from approved schedule slots and enriched with content metadata for consumer-facing EPG feeds. | Unity Catalog table: media_broadcasting_ecm.scheduling.epg_entry | Domain ownership: EPG, program schedule, slots, rundowns, ad breaks, dayparts, simulcast, playout (Ericsson MediaFirst)';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` (
    `ad_break_id` BIGINT COMMENT 'Unique surrogate identifier for the ad break (ad pod) record within the scheduling domain. Primary key for this entity. | Column ad_break_id (BIGINT) in scheduling.ad_break',
    `ad_billing_order_id` BIGINT COMMENT 'Foreign key linking to billing.ad_billing_order. Business justification: Ad breaks are the inventory units sold in ad orders. Direct link required for order-to-inventory reconciliation, flight pacing analysis, and verifying contracted vs. delivered spots in advertising bil | Column ad_billing_order_id (BIGINT) in billing.ad_break',
    `channel_id` BIGINT COMMENT 'Reference to the broadcast channel on which this ad break is scheduled for playout. Supports multi-channel scheduling and channel-level inventory reporting. | Column channel_id (BIGINT) in scheduling.ad_break',
    `dai_configuration_id` BIGINT COMMENT 'Foreign key linking to distribution.dai_configuration. Business justification: Linear ad breaks drive DAI stitching rules when simulcast to OTT. Operations teams configure DAI parameters (max pod duration, fill rate targets, frequency caps) per break type and daypart to ensure c | Column dai_configuration_id (BIGINT) in distribution.ad_break',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Ad break currently stores daypart_code as a STRING. This should be normalized to FK to the daypart reference table. Ad break pricing, GRP targets, and inventory management all depend on daypart attrib | Column daypart_id (BIGINT) in scheduling.ad_break',
    `political_ad_record_id` BIGINT COMMENT 'Foreign key linking to compliance.political_ad_record. Business justification: Political ad breaks require detailed public inspection file documentation per FCC Section 315 (reasonable access, lowest unit charge). Each political ad break must link to compliance record for public | Column political_ad_record_id (BIGINT) in compliance.ad_break',
    `scte_marker_id` BIGINT COMMENT 'The identifier of the SCTE-35 splice_insert or time_signal cue-out marker that signals the start of the ad break to downstream distribution systems and Dynamic Ad Insertion (DAI) platforms. References the specific SCTE-35 message that triggers break entry. | Column primary_ad_scte_marker_id (BIGINT) in scheduling.ad_break',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Ad breaks are the primary advertising revenue mechanism. Revenue recognition, sales reconciliation, and makegood accounting all depend on ad-break-to-revenue-stream mapping. Essential for advertising  | Column revenue_stream_id (BIGINT) in finance.ad_break',
    `schedule_slot_id` BIGINT COMMENT 'Reference to the parent schedule slot within which this ad break is positioned. Links the ad break to its containing program or interstitial window in the linear channel grid. | Column schedule_slot_id (BIGINT) in scheduling.ad_break',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Ad breaks are managed by traffic personnel who handle avail sales, makegoods, and preemptions. Core advertising operations workflow requires tracking responsible traffic manager for each break for acc | Column traffic_manager_employee_id (BIGINT) in workforce.ad_break',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in scheduling.ad_break',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in scheduling.ad_break',
    `actual_duration_seconds` STRING COMMENT 'The actual total duration of the ad break as recorded during playout by the Ericsson MediaFirst automation system. Used for post-log reconciliation, affidavit generation, and makegood assessment when actual duration deviates from planned. | Column actual_duration_seconds (INT) in scheduling.ad_break',
    `actual_start_time` TIMESTAMP COMMENT 'The actual wall-clock time at which the ad break commenced during playout, as recorded by the Ericsson MediaFirst automation system. Used for affidavit generation and post-log reconciliation against the scheduled start time. | Column actual_start_time (TIMESTAMP) in scheduling.ad_break',
    `affidavit_generated` BOOLEAN COMMENT 'Indicates whether a proof-of-broadcast affidavit has been generated for this ad break in the Wide Orbit traffic system following confirmed playout. Affidavits are required for advertiser billing reconciliation and regulatory compliance. | Column affidavit_generated (BOOLEAN) in scheduling.ad_break',
    `automation_event_code` STRING COMMENT 'The event identifier assigned by the Ericsson MediaFirst playout automation system to the break trigger event. Used to correlate the scheduled ad break with the actual playout automation log for post-log reconciliation and technical fault analysis. | Column automation_event_code (STRING) in scheduling.ad_break',
    `avail_count` STRING COMMENT 'The total number of individual advertising avail slots (unit positions) within this ad break pod. Each avail represents a discrete sellable unit (e.g., a 30-second spot position). Used for inventory capacity planning and traffic scheduling. | Column avail_count (INT) in scheduling.ad_break',
    `blackout_restricted` BOOLEAN COMMENT 'Indicates whether this ad break is subject to geographic blackout restrictions that prevent its broadcast or streaming in specific markets or regions. When true, downstream distribution systems must apply blackout logic per rights and regulatory obligations. | Column blackout_restricted (BOOLEAN) in scheduling.ad_break',
    `break_position` STRING COMMENT 'Positional classification of the ad break relative to the surrounding program content. pre-roll = before program content begins; mid-roll = within program content; post-roll = after program content ends; interstitial = between programs in the schedule grid. | Column break_position (STRING) in scheduling.ad_break. Valid values are `pre-roll|mid-roll|post-roll|interstitial`',
    `break_status` STRING COMMENT 'Current lifecycle status of the ad break within the scheduling and playout workflow. scheduled = planned but not yet confirmed; confirmed = traffic-confirmed with sold inventory; aired = playout completed and affidavit-eligible; cancelled = removed from schedule; hold = temporarily suspended pending resolution. | Column break_status (STRING) in scheduling.ad_break. Valid values are `scheduled|confirmed|aired|cancelled|hold`',
    `break_type` STRING COMMENT 'Classification of the ad break by inventory ownership and commercial purpose. local_avail = inventory sold by local affiliate; network_avail = inventory sold by the network; promotional = house promotional content; public_service = public service announcements; emergency = emergency alert system override. Drives revenue attribution and traffic scheduling rules. | Column break_type (STRING) in scheduling.ad_break. Valid values are `local_avail|network_avail|promotional|public_service|emergency`',
    `broadcast_date` DATE COMMENT 'The calendar date on which this ad break is scheduled to air, expressed in the channels broadcast day convention (which may differ from the wall-clock date for late-night programming). Used for daily traffic scheduling, affidavit generation, and revenue reporting. | Column broadcast_date (DATE) in scheduling.ad_break',
    `content_restriction_code` STRING COMMENT 'A code indicating any content category restrictions applicable to advertising within this break (e.g., no alcohol ads during childrens programming, no competitor ads). Enforced by the traffic system during ad assignment. [ENUM-REF-CANDIDATE: NO_ALCOHOL|NO_GAMBLING|NO_PHARMA|NO_COMPETITOR|CHILDREN_SAFE|NONE — promote to reference product] | Column content_restriction_code (STRING) in scheduling.ad_break',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in scheduling.ad_break',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this ad break record was first created in the scheduling system. Serves as the RECORD_AUDIT_CREATED field for data lineage, audit trail, and Silver layer ingestion tracking. | Column created_timestamp (TIMESTAMP) in scheduling.ad_break',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the rate card CPM and any monetary values associated with this ad break (e.g., USD, GBP, EUR). Supports multi-currency operations for international broadcast networks. | Column currency_code (STRING) in scheduling.ad_break. Valid values are `^[A-Z]{3}$`',
    `dai_eligible` BOOLEAN COMMENT 'Indicates whether this ad break is enabled for Dynamic Ad Insertion (DAI), allowing server-side ad replacement for OTT/streaming simulcast audiences. When true, the break is eligible for addressable advertising via DAI platforms such as those integrated with Akamai CDN. | Column dai_eligible (BOOLEAN) in scheduling.ad_break',
    `epg_break_label` STRING COMMENT 'The human-readable label or descriptor for this ad break as it appears in the Electronic Program Guide (EPG) and scheduling rundown. Used by traffic coordinators and scheduling operators to identify breaks in the EPG interface. | Column epg_break_label (STRING) in scheduling.ad_break',
    `grp_target` DECIMAL(18,2) COMMENT 'The target Gross Rating Point (GRP) value for this ad break, representing the expected total audience delivery as a percentage of the total target population. Used for audience guarantee tracking and campaign delivery reporting against Nielsen ratings. | Column grp_target (DECIMAL(8,4)) in scheduling.ad_break',
    `makegood_required` BOOLEAN COMMENT 'Indicates whether a makegood (compensatory ad spot) is required for this break due to a failure to air as contracted — for example, due to preemption, technical failure, or underdelivery. Triggers makegood workflow in Wide Orbit. | Column makegood_required (BOOLEAN) in scheduling.ad_break',
    `max_duration_seconds` STRING COMMENT 'The maximum allowable duration of the ad break in seconds, representing the hard ceiling for total ad content that may be inserted. Exceeding this value would cause schedule overrun. May differ from planned duration when flex time is permitted. | Column max_duration_seconds (INT) in scheduling.ad_break',
    `nielsen_program_rating` DECIMAL(18,2) COMMENT 'The Nielsen audience rating for the program surrounding this ad break, representing the percentage of total TV households tuned in. Used for CPM calculation, audience guarantee assessment, and scatter market pricing. | Column nielsen_program_rating (DECIMAL(6,4)) in scheduling.ad_break',
    `planned_duration_seconds` STRING COMMENT 'The planned total duration of the ad break (ad pod) in seconds as defined in the program schedule. Represents the total sellable commercial time allocated to this break. Standard pod durations are typically 30, 60, 90, 120, or 180 seconds. | Column planned_duration_seconds (INT) in scheduling.ad_break',
    `pod_number` STRING COMMENT 'The pod number identifying this ad break within the broadcast day for the channel. Distinct from sequence_number (which is relative to the program); pod_number is the channel-day-level ordinal used in traffic scheduling and affidavit reporting. | Column pod_number (INT) in scheduling.ad_break',
    `preemption_reason` STRING COMMENT 'The reason code explaining why this ad break was preempted or cancelled if it did not air as scheduled. Used for makegood processing, revenue assurance, and operational reporting. none when the break aired as planned. | Column preemption_reason (STRING) in scheduling.ad_break. Valid values are `breaking_news|emergency_alert|technical_failure|rights_conflict|schedule_change|none`',
    `rate_card_cpm` DECIMAL(18,2) COMMENT 'The published rate card CPM (Cost Per Mille — cost per 1,000 audience impressions) for this ad break, expressed in the local currency. Represents the base pricing for inventory in this break before negotiated discounts. Used for revenue forecasting and yield management. | Column rate_card_cpm (DECIMAL(10,4)) in scheduling.ad_break',
    `scheduled_start_time` TIMESTAMP COMMENT 'The planned wall-clock date and time at which the ad break is scheduled to begin on the linear channel. Expressed in the channels broadcast timezone. This is the principal BUSINESS_EVENT_TIMESTAMP for the break. | Column scheduled_start_time (TIMESTAMP) in scheduling.ad_break',
    `sequence_number` STRING COMMENT 'Ordinal position of this ad break within the parent schedule slot or program. Used to order multiple breaks within a single program (e.g., break 1, break 2, break 3) for traffic scheduling and playout automation. | Column sequence_number (INT) in scheduling.ad_break',
    `simulcast_eligible` BOOLEAN COMMENT 'Indicates whether this ad break is included in the simultaneous multi-platform broadcast (simulcast) of the channel. When false, the break may be suppressed or replaced on simulcast streams (e.g., OTT, vMVPD). | Column simulcast_eligible (BOOLEAN) in scheduling.ad_break',
    `sold_avail_count` STRING COMMENT 'The number of individual avail slots within this break that have been sold and assigned to advertiser spots in the Wide Orbit traffic system. Used with avail_count to compute sellout rate and unsold inventory. | Column sold_avail_count (INT) in scheduling.ad_break',
    `sold_duration_seconds` STRING COMMENT 'The total duration in seconds of ad inventory within this break that has been sold to advertisers via the Wide Orbit traffic system. Used to calculate unsold (remnant) inventory and sellout rate for revenue assurance reporting. | Column sold_duration_seconds (INT) in scheduling.ad_break',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in scheduling.ad_break',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in scheduling.ad_break',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in scheduling.ad_break',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this ad break record was most recently modified in the scheduling system. Serves as the RECORD_AUDIT_UPDATED field for change tracking, incremental data pipeline processing, and audit compliance. | Column updated_timestamp (TIMESTAMP) in scheduling.ad_break',
    `wide_orbit_break_code` STRING COMMENT 'The externally-known break identifier assigned by the Wide Orbit traffic and billing system. Used to reconcile ad break inventory between the scheduling domain and the ad sales/traffic fulfillment workflow. This is the BUSINESS_IDENTIFIER for the break as known to the traffic system. | Column wide_orbit_break_code (STRING) in scheduling.ad_break',
    CONSTRAINT pk_ad_break PRIMARY KEY(`ad_break_id`)
) COMMENT 'Commercial break (ad pod) within a schedule slot — capturing break position (pre-roll, mid-roll, post-roll), sequence number, planned and maximum pod duration, break type (local avail, network avail, promotional), SCTE-35 cue-in/cue-out marker references, DAI eligibility flag, and Wide Orbit traffic system break ID. The structural container for sellable ad inventory within the linear schedule, linking scheduling to advertising sales fulfillment. | Unity Catalog table: media_broadcasting_ecm.scheduling.ad_break';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` (
    `scte_marker_id` BIGINT COMMENT 'Unique surrogate identifier for each SCTE-35 splice information message record in the broadcast transport stream. Primary key for the scte_marker data product. | Column scte_marker_id (BIGINT) in scheduling.scte_marker',
    `ad_pod_id` BIGINT COMMENT 'Reference to the ad pod record that this SCTE-35 marker is intended to open or close. An Ad Pod is a group of ads scheduled within a single break. Links the splice event to the Wide Orbit traffic system ad pod for campaign reconciliation and affidavit generation. | Column ad_pod_id (BIGINT) in sales.scte_marker',
    `channel_id` BIGINT COMMENT 'Reference to the linear broadcast channel on which this SCTE-35 marker was embedded. Links the splice event to the originating playout channel managed in Ericsson MediaFirst. | Column channel_id (BIGINT) in scheduling.scte_marker',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: SCTE marker currently stores daypart_code as a STRING. Normalizing to FK enables retrieval of daypart attributes for ad insertion rules and DAI eligibility checks. Remove daypart_code as it becomes re | Column daypart_id (BIGINT) in scheduling.scte_marker',
    `program_schedule_id` BIGINT COMMENT 'Reference to the program schedule entry or rundown record that triggered this SCTE-35 marker. Ties the splice event to the Electronic Program Guide (EPG) scheduling context. | Column program_schedule_id (BIGINT) in scheduling.scte_marker',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: SCTE-35 markers signal ad insertion points at specific schedule slots. Currently scte_marker links to program_schedule (schedule_id) but not to the specific schedule_slot where the cue is embedded. Ad | Column schedule_slot_id (BIGINT) in scheduling.scte_marker',
    `title_id` BIGINT COMMENT 'Reference to the program or content asset record associated with this splice event. Links the SCTE-35 marker to the content catalogue in Dalet Galaxy for rights verification, blackout enforcement, and audience measurement attribution. | Column title_id (BIGINT) in content.scte_marker',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in scheduling.scte_marker',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in scheduling.scte_marker',
    `auto_return` BOOLEAN COMMENT 'Indicates whether the playout system should automatically return to network programming at the end of the break_duration without waiting for an explicit splice-in command. When True, the break is time-bounded; when False, an explicit splice-in SCTE-35 message is required. | Column auto_return (BOOLEAN) in scheduling.scte_marker',
    `avail_num` STRING COMMENT 'The avail_num field from the SCTE-35 splice_insert() command, indicating the sequential number of this ad avail within the current program. Used alongside avails_expected to track avail inventory completeness for a given program break sequence. | Column avail_num (INT) in scheduling.scte_marker',
    `avails_expected` STRING COMMENT 'The avails_expected field from the SCTE-35 splice_insert() command, indicating the total number of ad avails expected within the current program. Enables DAI systems and Wide Orbit to validate that all avail windows have been signalled and filled. | Column avails_expected (INT) in scheduling.scte_marker',
    `blackout_flag` BOOLEAN COMMENT 'Indicates whether this SCTE-35 marker is associated with a geographic broadcast blackout restriction. When True, downstream MVPDs and vMVPDs must suppress the content in the affected geographic region and substitute alternate programming or a blackout slate. | Column blackout_flag (BOOLEAN) in scheduling.scte_marker',
    `blackout_region_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code or proprietary DMA/region code identifying the geographic area subject to the blackout restriction signalled by this marker. Populated only when blackout_flag is True. Used for MVPD compliance and retransmission consent enforcement. | Column blackout_region_code (STRING) in scheduling.scte_marker',
    `break_duration_ms` STRING COMMENT 'The total duration of the ad break or content replacement window in milliseconds, as signalled in the SCTE-35 break_duration() structure. Defines the length of the avail window available for ad pod insertion. Used by Wide Orbit traffic system for avail reconciliation. | Column break_duration_ms (INT) in scheduling.scte_marker',
    `component_count` STRING COMMENT 'Number of elementary stream components (video, audio tracks, data) included in the splice command when component_splice_flag is set. Indicates multi-component splice operations for multi-language or multi-audio broadcast streams. | Column component_count (INT) in scheduling.scte_marker',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in scheduling.scte_marker',
    `created_timestamp` TIMESTAMP COMMENT 'UTC timestamp when this SCTE-35 marker record was first created in the Silver layer data product. Audit trail field for data lineage and pipeline monitoring. | Column created_timestamp (TIMESTAMP) in scheduling.scte_marker',
    `cw_index` STRING COMMENT 'The cw_index field from the SCTE-35 splice_info_section, referencing the encryption control word used when the splice message is encrypted. A value of 0xFF indicates no encryption. Relevant for DRM-protected transport streams. | Column cw_index (INT) in scheduling.scte_marker',
    `descriptor_loop_length` STRING COMMENT 'The total byte length of the splice descriptor loop in the SCTE-35 splice_info_section. Indicates the presence and size of additional descriptors such as segmentation_descriptor, DTMF_descriptor, or avail_descriptor. Used for message parsing validation. | Column descriptor_loop_length (INT) in scheduling.scte_marker',
    `encrypted_packet` BOOLEAN COMMENT 'Indicates whether the SCTE-35 splice_info_section payload is encrypted. When True, the cw_index field identifies the applicable decryption key. Relevant for secure ad insertion in DRM-protected broadcast streams. | Column encrypted_packet (BOOLEAN) in scheduling.scte_marker',
    `out_of_network` BOOLEAN COMMENT 'The out_of_network_indicator bit from the SCTE-35 splice_insert() command. True indicates the splice point transitions to out-of-network content (e.g., local ad insertion); False indicates a return to in-network programming. Fundamental for MVPD local ad insertion compliance. | Column out_of_network (BOOLEAN) in scheduling.scte_marker',
    `pre_roll_duration_ms` STRING COMMENT 'The pre-roll duration in milliseconds between the time the SCTE-35 message is detected and the actual splice point. Allows downstream DAI systems and MVPDs sufficient lead time to prepare and insert the ad content before the avail window opens. | Column pre_roll_duration_ms (INT) in scheduling.scte_marker',
    `processing_error_code` STRING COMMENT 'Proprietary error code assigned when processing_status is failed. Identifies the specific failure reason (e.g., CRC mismatch, invalid PTS, unsupported command type, descriptor parse error). Used for operational monitoring and SLA compliance reporting. | Column processing_error_code (STRING) in scheduling.scte_marker',
    `processing_status` STRING COMMENT 'Current processing lifecycle status of this SCTE-35 marker record in the Silver layer pipeline. received = ingested from transport stream; validated = passed SCTE-35 structural validation; processed = forwarded to DAI/MVPD systems; failed = processing error; skipped = intentionally bypassed (e.g., duplicate or test signal). | Column processing_status (STRING) in scheduling.scte_marker. Valid values are `received|validated|processed|failed|skipped`',
    `program_number` STRING COMMENT 'The MPEG-2 program_number (PAT/PMT) identifying the specific program within the transport stream to which this SCTE-35 message applies. Enables precise association of the splice event with the correct elementary stream in multi-programme multiplexes. | Column program_number (INT) in scheduling.scte_marker',
    `pts_time` BIGINT COMMENT 'The 33-bit Presentation Time Stamp (PTS) value in 90 kHz clock ticks at which the splice event is to occur in the MPEG-2 transport stream. Stored as BIGINT to accommodate the full 33-bit range. Fundamental for frame-accurate ad insertion by DAI systems and Akamai CDN delivery. | Column pts_time (BIGINT) in scheduling.scte_marker',
    `pts_time_utc` TIMESTAMP COMMENT 'Wall-clock UTC timestamp derived from the PTS value after applying the PCR/PTS offset for the channel. Enables correlation of splice events with EPG schedules, ad trafficking records in Wide Orbit, and audience measurement windows in Nielsen. | Column pts_time_utc (TIMESTAMP) in scheduling.scte_marker',
    `segmentation_type_code` STRING COMMENT 'Numeric segmentation_type_id from the SCTE-35 segmentation_descriptor (SCTE-104 descriptor table). Identifies the semantic purpose of the marker: e.g., 0x10 = Program Start, 0x11 = Program End, 0x20 = Chapter Start, 0x30 = Provider Advertisement Start, 0x34 = Distributor Advertisement Start. Critical for MVPD ad insertion compliance and blackout enforcement. | Column segmentation_type_code (INT) in scheduling.scte_marker',
    `segmentation_type_label` STRING COMMENT 'Human-readable label corresponding to the segmentation_type_id, derived from the SCTE-35 segmentation descriptor table (e.g., Provider Advertisement Start, Program Blackout Override, Chapter Start). Facilitates operational reporting and EPG reconciliation without requiring lookup joins. | Column segmentation_type_label (STRING) in scheduling.scte_marker',
    `segmentation_upid_type` STRING COMMENT 'Numeric code identifying the type of the segmentation UPID carried in the segmentation_descriptor, per SCTE-35 Table 22. Common values: 0x01=URI, 0x03=Ad-ID, 0x08=ISAN, 0x09=TID, 0x0A=TI, 0x0C=MPU, 0x0E=ADS Information. Determines how the segmentation_upid_value should be interpreted. | Column segmentation_upid_type (INT) in scheduling.scte_marker',
    `segmentation_upid_value` DECIMAL(18,2) COMMENT 'The actual UPID value carried in the segmentation_descriptor, interpreted according to segmentation_upid_type. May contain an Ad-ID, ISAN, URI, or other content identifier. Used to link the splice event to content records in Dalet Galaxy MAM and rights records in Rightsline. | Column segmentation_upid_value (DECIMAL(18,2)) in scheduling.scte_marker',
    `signal_detected_timestamp` TIMESTAMP COMMENT 'Wall-clock UTC timestamp at which the SCTE-35 splice_info_section was first detected and extracted from the transport stream by the playout or monitoring system. Represents the business event time of signal receipt. Used for pre-roll lead time calculation and SLA monitoring. | Column signal_detected_timestamp (TIMESTAMP) in scheduling.scte_marker',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in scheduling.scte_marker',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in scheduling.scte_marker',
    `splice_command_type` STRING COMMENT 'The SCTE-35 splice command type encoded in the splice_info_section. Determines the action to be taken by downstream DAI and playout systems. splice_insert signals a direct ad avail; time_signal carries segmentation descriptors; bandwidth_reservation reserves capacity. [ENUM-REF-CANDIDATE: splice_null|splice_insert|time_signal|bandwidth_reservation|private_command — promote to reference product if additional vendor-specific types are required] | Column splice_command_type (STRING) in scheduling.scte_marker. Valid values are `splice_null|splice_insert|time_signal|bandwidth_reservation|private_command`',
    `splice_event_number` BIGINT COMMENT 'Unique 32-bit splice_event_id as defined in the SCTE-35 splice_insert() command structure. Identifies the specific splice event within the transport stream and is used by Dynamic Ad Insertion (DAI) systems to correlate splice-in and splice-out pairs. | Column splice_event_number (BIGINT) in scheduling.scte_marker',
    `splice_immediate` BOOLEAN COMMENT 'Indicates whether the splice should occur immediately upon receipt of the SCTE-35 message (True) rather than at the specified PTS time (False). When True, the pts_time field is not applicable. Used for emergency override and live event boundary signalling. | Column splice_immediate (BOOLEAN) in scheduling.scte_marker',
    `splice_insert_type` STRING COMMENT 'Indicates whether this splice_insert command is a splice-out (entering an ad avail or blackout) or splice-in (returning to network programming). Applicable when splice_command_type is splice_insert. Used by DAI systems to bracket the ad pod window. | Column splice_insert_type (STRING) in scheduling.scte_marker. Valid values are `splice_in|splice_out`',
    `tier` STRING COMMENT 'The 12-bit tier field from the SCTE-35 splice_info_section, used to address specific MVPDs or distribution tiers. A value of 0xFFF indicates the message applies to all tiers. Enables selective ad insertion targeting for specific distribution partners. | Column tier (INT) in scheduling.scte_marker',
    `transport_stream_number` STRING COMMENT 'The MPEG-2 transport stream identifier in which this SCTE-35 message was embedded. Used to correlate the splice event with the specific multiplex or virtual channel carrying the broadcast signal, particularly relevant for DVB and ATSC multi-programme transport streams. | Column transport_stream_number (INT) in scheduling.scte_marker',
    `unique_program_code` STRING COMMENT 'The unique_program_id field from the SCTE-35 splice_insert() command, identifying the program associated with this splice event. Used by MVPDs and DAI systems to associate the avail with a specific program for audience targeting and ad campaign attribution. | Column unique_program_code (INT) in scheduling.scte_marker',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in scheduling.scte_marker',
    `updated_timestamp` TIMESTAMP COMMENT 'UTC timestamp when this SCTE-35 marker record was last modified in the Silver layer data product, such as when processing_status is updated after DAI system acknowledgement. | Column updated_timestamp (TIMESTAMP) in scheduling.scte_marker',
    CONSTRAINT pk_scte_marker PRIMARY KEY(`scte_marker_id`)
) COMMENT 'SCTE-35 splice information message record embedded in the broadcast transport stream to signal ad insertion, blackout, and program boundary events. Captures splice command type (splice_insert, time_signal, bandwidth_reservation), PTS timestamp, pre-roll duration, segmentation type ID (SCTE-104 descriptor), unique program ID, avail number, avails expected, and processing status. Critical for DAI systems and MVPD ad insertion compliance. | Unity Catalog table: media_broadcasting_ecm.scheduling.scte_marker | Domain ownership: EPG, program schedule, slots, rundowns, ad breaks, dayparts, simulcast, playout (Ericsson MediaFirst)';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` (
    `simulcast_config_id` BIGINT COMMENT 'Unique surrogate identifier for the simulcast configuration record. Primary key for this entity in the Databricks Silver Layer. | Column simulcast_config_id (BIGINT) in scheduling.simulcast_config',
    `abr_profile_id` BIGINT COMMENT 'Reference to the Adaptive Bitrate (ABR) streaming profile applied to the target simulcast feed for OTT delivery. Defines the bitrate ladder (HLS or MPEG-DASH renditions) used by Akamai CDN for adaptive streaming to end-user devices. | Column abr_profile_id (BIGINT) in distribution.simulcast_config',
    `billing_carriage_fee_invoice_id` BIGINT COMMENT 'Foreign key linking to billing.billing_carriage_fee_invoice. Business justification: Simulcast configurations drive multi-platform carriage fee calculations (linear + streaming). Link required for platform-specific fee allocation, subscriber count apportionment, and multi-platform car | Column billing_carriage_fee_invoice_id (BIGINT) in billing.simulcast_config',
    `dai_configuration_id` BIGINT COMMENT 'Foreign key linking to distribution.dai_configuration. Business justification: Simulcast routes require DAI stitching rules when ad insertion differs between linear SCTE-35 cues and OTT server-side stitching. Technical operations configure DAI per simulcast to handle ad pod subs | Column dai_configuration_id (BIGINT) in distribution.simulcast_config',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Simulcast originates from specific facility - required for signal routing, redundancy planning, facility failover configuration, and multi-platform distribution. Role prefix origin_ distinguishes fr | Column origin_broadcast_facility_id (BIGINT) in technology.simulcast_config',
    `channel_id` BIGINT COMMENT 'Reference to the backup or secondary source channel used by Ericsson MediaFirst failover automation when the primary source channel becomes unavailable. Supports broadcast continuity and SLA compliance. | Column primary_simulcast_backup_source_channel_id (BIGINT) in scheduling.simulcast_config',
    `retransmission_consent_id` BIGINT COMMENT 'Reference to the retransmission consent agreement authorizing the rebroadcast of the source channel content on the target distribution platform. Required for MVPD and cable carriage of broadcast signals under FCC retransmission consent rules. | Column retransmission_consent_id (BIGINT) in distribution.simulcast_config',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Simulcast distribution agreements are with specific partners (cable operators, streaming platforms, syndication partners). Critical for multi-platform distribution tracking, partner SLA compliance, an | Column simulcast_partner_partner_partner_id (BIGINT) in partner.simulcast_config',
    `source_channel_id` BIGINT COMMENT 'Reference to the originating linear broadcast channel whose feed is being simulcast to one or more target channels or platforms. Drives Ericsson MediaFirst multi-feed automation as the master playout source. | Column source_channel_id (BIGINT) in scheduling.simulcast_config',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: Simulcast configurations map linear channels to specific OTT delivery endpoints for live streaming workflows. Operations teams configure CDN routing, failover paths, and geo-restrictions per simulcast | Column streaming_endpoint_id (BIGINT) in distribution.simulcast_config',
    `target_channel_id` BIGINT COMMENT 'Reference to the destination channel or platform that receives the simulcast feed from the source channel. May represent a linear channel, OTT platform feed, HD/SD variant, or secondary distribution outlet. | Column target_channel_id (BIGINT) in scheduling.simulcast_config',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Simulcast configurations are managed by technical operations/engineering staff responsible for multi-platform distribution. Broadcast engineering workflow requires tracking responsible technical direc | Column technical_director_employee_id (BIGINT) in workforce.simulcast_config',
    `transmission_equipment_id` BIGINT COMMENT 'Foreign key linking to technology.transmission_equipment. Business justification: Simulcast uses specific transmission equipment - critical for signal path configuration, equipment redundancy planning, and simulcast failover operations. Supports multi-platform distribution technica | Column transmission_equipment_id (BIGINT) in technology.simulcast_config',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in scheduling.simulcast_config',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in scheduling.simulcast_config',
    `ad_pod_substitution` BOOLEAN COMMENT 'Indicates whether the ad pods (groups of ads in a break) from the source linear feed are substituted with alternative ad content on the target simulcast feed. Distinct from DAI — covers cases where static alternate ad content replaces source pods without dynamic targeting. | Column ad_pod_substitution (BOOLEAN) in scheduling.simulcast_config',
    `audio_description_passthrough` BOOLEAN COMMENT 'Indicates whether the audio description (video description) secondary audio track is passed through from the source to the target simulcast feed. Required for FCC accessibility compliance for visually impaired audiences on qualifying broadcast and MVPD platforms. | Column audio_description_passthrough (BOOLEAN) in scheduling.simulcast_config',
    `audio_profile_code` BIGINT COMMENT 'Reference to the audio encoding and channel configuration profile applied to the target simulcast feed (e.g., stereo, 5.1 surround, Dolby Atmos, audio description track). Ensures correct audio mapping from source to target platform. | Column audio_profile_code (BIGINT) in scheduling.simulcast_config',
    `blackout_enforced` BOOLEAN COMMENT 'Indicates whether geographic broadcast blackout restrictions are enforced on the target simulcast feed. When true, blackout rules (e.g., sports rights geographic restrictions) are applied to suppress content in restricted territories on the target platform. | Column blackout_enforced (BOOLEAN) in scheduling.simulcast_config',
    `cdn_origin_path` STRING COMMENT 'The Akamai CDN origin ingest path or stream key for the target simulcast feed. Used to route the encoded simulcast stream from Ericsson MediaFirst playout to the CDN origin for OTT and digital distribution. | Column cdn_origin_path (STRING) in scheduling.simulcast_config',
    `closed_caption_passthrough` BOOLEAN COMMENT 'Indicates whether closed caption data from the source channel feed is passed through to the target simulcast feed. Required for FCC accessibility compliance on all broadcast and MVPD distribution platforms. | Column closed_caption_passthrough (BOOLEAN) in scheduling.simulcast_config',
    `config_code` STRING COMMENT 'Externally-known alphanumeric business identifier for this simulcast configuration, used in Ericsson MediaFirst automation rules, runsheets, and operational documentation. Unique across all active configurations. | Column config_code (STRING) in scheduling.simulcast_config. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `config_description` STRING COMMENT 'Free-text operational description of the simulcast configuration, including business rationale, special handling instructions, and notes for scheduling and playout operations teams. | Column config_description (STRING) in scheduling.simulcast_config',
    `config_name` STRING COMMENT 'Human-readable descriptive name for the simulcast configuration (e.g., CNN HD to CNN SD Full-Feed, Linear to OTT Time-Shifted +1hr). Used in EPG management and scheduling operations. | Column config_name (STRING) in scheduling.simulcast_config',
    `content_rating_restriction` STRING COMMENT 'Maximum content rating permitted on the target simulcast feed per Motion Picture Association (MPA) and FCC content rating standards. Ensures age-appropriate content controls are applied on the target platform, particularly for COPPA-regulated childrens platforms. | Column content_rating_restriction (STRING) in scheduling.simulcast_config. Valid values are `TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in scheduling.simulcast_config',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this simulcast configuration record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for configuration lifecycle management. | Column created_timestamp (TIMESTAMP) in scheduling.simulcast_config',
    `dai_enabled` BOOLEAN COMMENT 'Indicates whether Dynamic Ad Insertion (DAI) is active on the target simulcast feed, replacing linear ad pods with dynamically served targeted advertisements. Applicable primarily to OTT and AVOD distribution platforms. | Column dai_enabled (BOOLEAN) in scheduling.simulcast_config',
    `distribution_platform` STRING COMMENT 'The delivery platform type of the target channel or feed. Distinguishes linear broadcast from OTT (Over-The-Top), MVPD (Multichannel Video Programming Distributor), vMVPD (Virtual MVPD), FAST (Free Ad-Supported Streaming Television), cable, satellite, IPTV, or web delivery. [ENUM-REF-CANDIDATE: linear|ott|mvpd|vmvpd|fast|cable|satellite|iptv|web — promote to reference product] | Column distribution_platform (STRING) in scheduling.simulcast_config',
    `drm_scheme` STRING COMMENT 'The Digital Rights Management (DRM) encryption scheme applied to the target simulcast feed for content protection on OTT and digital distribution platforms. Widevine for Android/Chrome, FairPlay for Apple, PlayReady for Microsoft. None for unencrypted linear broadcast. | Column drm_scheme (STRING) in scheduling.simulcast_config. Valid values are `widevine|fairplay|playready|none`',
    `effective_from` DATE COMMENT 'The calendar date from which this simulcast configuration becomes operationally active and is applied by Ericsson MediaFirst playout automation. Aligns with schedule activation windows in the EPG. | Column effective_from (DATE) in scheduling.simulcast_config',
    `effective_until` DATE COMMENT 'The calendar date on which this simulcast configuration expires and is deactivated. Nullable for open-ended configurations with no planned end date. Supports windowing and holdback period management. | Column effective_until (DATE) in scheduling.simulcast_config',
    `epg_sync_enabled` BOOLEAN COMMENT 'Indicates whether the Electronic Program Guide (EPG) metadata from the source channel schedule is automatically synchronized to the target simulcast channels EPG. When true, program titles, descriptions, and ratings are mirrored to the target channel grid. | Column epg_sync_enabled (BOOLEAN) in scheduling.simulcast_config',
    `failover_mode` STRING COMMENT 'Defines the failover behavior for the simulcast target feed in Ericsson MediaFirst when the source channel signal is lost or degraded. Automatic triggers immediate failover to backup source; manual requires operator intervention; disabled means no failover is configured. | Column failover_mode (STRING) in scheduling.simulcast_config. Valid values are `automatic|manual|disabled`',
    `graphics_passthrough` BOOLEAN COMMENT 'Indicates whether on-screen graphics, lower-thirds, and channel branding overlays from the source channel are passed through to the target simulcast feed. When false, the target feed may apply its own branding or suppress source graphics. | Column graphics_passthrough (BOOLEAN) in scheduling.simulcast_config',
    `mediafirst_config_ref` STRING COMMENT 'The external configuration reference identifier assigned by Ericsson MediaFirst playout automation system to this simulcast configuration. Used for reconciliation between the data lakehouse Silver Layer and the operational playout system. | Column mediafirst_config_ref (STRING) in scheduling.simulcast_config. Valid values are `^[A-Z0-9_-]{1,50}$`',
    `must_carry_compliant` BOOLEAN COMMENT 'Indicates whether this simulcast configuration satisfies must-carry obligations requiring MVPDs to carry local broadcast stations. Ensures regulatory compliance tracking for FCC must-carry and retransmission consent requirements. | Column must_carry_compliant (BOOLEAN) in scheduling.simulcast_config',
    `priority_rank` STRING COMMENT 'Numeric priority ranking for this simulcast configuration when multiple configurations apply to the same source channel simultaneously. Lower values indicate higher priority. Used by Ericsson MediaFirst to resolve conflicts in multi-feed automation. | Column priority_rank (INT) in scheduling.simulcast_config',
    `rights_territory_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code identifying the geographic territory in which this simulcast configuration is licensed to operate. Enforces windowing and holdback obligations managed in Rightsline. | Column rights_territory_code (STRING) in scheduling.simulcast_config. Valid values are `^[A-Z]{3}$`',
    `scte35_cue_passthrough` BOOLEAN COMMENT 'Indicates whether SCTE-35 digital program insertion cue markers from the source channel are passed through to the target simulcast feed. When true, ad break triggers and blackout signals are propagated to the target. Critical for DAI (Dynamic Ad Insertion) on OTT platforms. | Column scte35_cue_passthrough (BOOLEAN) in scheduling.simulcast_config',
    `simulcast_config_status` STRING COMMENT 'Current lifecycle state of the simulcast configuration record. Active configurations are processed by Ericsson MediaFirst automation. Suspended configurations are temporarily halted (e.g., rights blackout). Draft configurations are under review prior to activation. | Column simulcast_config_status (STRING) in scheduling.simulcast_config. Valid values are `active|inactive|pending|suspended|draft`',
    `simulcast_type` STRING COMMENT 'Classification of the simulcast relationship: full_feed (identical content and timing), partial (selected programs only), time_shifted (offset delay applied), simulcast_only (live events only), ad_substituted (DAI replaces linear ad pods on target). Drives automation logic in Ericsson MediaFirst. | Column simulcast_type (STRING) in scheduling.simulcast_config. Valid values are `full_feed|partial|time_shifted|simulcast_only|ad_substituted`',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in scheduling.simulcast_config',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in scheduling.simulcast_config',
    `time_offset_seconds` STRING COMMENT 'The delay in seconds applied to the target feed relative to the source channel. Zero for true simultaneous simulcast. Positive values indicate a time-shifted delay (e.g., +3600 for a +1 hour catch-up feed). Used by Ericsson MediaFirst to schedule playout offset. | Column time_offset_seconds (INT) in scheduling.simulcast_config',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in scheduling.simulcast_config',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this simulcast configuration record was last modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports change tracking and audit compliance for playout configuration governance. | Column updated_timestamp (TIMESTAMP) in scheduling.simulcast_config',
    `video_profile_code` BIGINT COMMENT 'Reference to the video encoding and resolution profile applied to the target simulcast feed (e.g., HD 1080i, SD 576p, UHD 4K, HDR10). Drives transcode and format conversion settings in Ericsson MediaFirst and Akamai CDN delivery. | Column video_profile_code (BIGINT) in scheduling.simulcast_config',
    `watermark_enabled` BOOLEAN COMMENT 'Indicates whether a forensic or visible watermark is applied to the target simulcast feed for content protection, piracy detection, and rights enforcement tracking. Supports MPA anti-piracy compliance. | Column watermark_enabled (BOOLEAN) in scheduling.simulcast_config',
    CONSTRAINT pk_simulcast_config PRIMARY KEY(`simulcast_config_id`)
) COMMENT 'Configuration record defining a simulcast relationship where a single program or schedule is broadcast simultaneously across multiple channels or platforms (e.g., linear + OTT, HD + SD, primary + secondary feed). Captures source channel, target channel or platform, simulcast type (full-feed, partial, time-shifted), offset in seconds, audio/video profile mapping, and active date range. Drives Ericsson MediaFirst multi-feed automation. | Unity Catalog table: media_broadcasting_ecm.scheduling.simulcast_config | Domain ownership: EPG, program schedule, slots, rundowns, ad breaks, dayparts, simulcast, playout (Ericsson MediaFirst)';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` (
    `scheduling_blackout_rule_id` BIGINT COMMENT 'Unique surrogate identifier for the blackout rule record in the scheduling domain. Primary key for the scheduling_blackout_rule data product. | Column scheduling_blackout_rule_id (BIGINT) in scheduling.scheduling_blackout_rule',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Blackout rules have approved_by field tracking who approved the rights restriction. Natural FK to employee for compliance audit trail and rights management workflow. Removes denormalized approved_by i | Column approved_by_employee_id (BIGINT) in workforce.scheduling_blackout_rule',
    `channel_id` BIGINT COMMENT 'Reference to the linear broadcast channel on which the blackout rule is enforced, as managed in Ericsson MediaFirst. Identifies the specific channel playout stream subject to the geographic or platform restriction. | Column channel_id (BIGINT) in scheduling.scheduling_blackout_rule',
    `license_agreement_id` BIGINT COMMENT 'Reference to the rights and licensing contract in Rightsline that mandates or authorizes this blackout rule. Links the blackout enforcement obligation to its contractual source for rights clearance and compliance auditing. | Column license_agreement_id (BIGINT) in rights.scheduling_blackout_rule',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Blackout rules often stem from partner-specific territorial restrictions in distribution agreements (e.g., regional sports blackouts, affiliate exclusivity zones). Essential for rights compliance, par | Column partner_id (BIGINT) in partner.scheduling_blackout_rule',
    `title_id` BIGINT COMMENT 'Reference to the content asset subject to the blackout restriction, as catalogued in Dalet Galaxy Media Asset Management. Links to the master content record for the program, film, or event being blacked out. | Column primary_scheduling_title_id (BIGINT) in content.scheduling_blackout_rule',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Blackout rules often stem from regulatory obligations (sports blackouts per FCC 76.67, retransmission consent restrictions). Links scheduling enforcement to underlying compliance obligation for audit  | Column regulatory_obligation_id (BIGINT) in compliance.scheduling_blackout_rule',
    `rights_availability_window_id` BIGINT COMMENT 'Reference to the specific rights availability window in Rightsline that defines the holdback period driving this blackout rule. Links the blackout enforcement to the precise contractual window (e.g., theatrical window, home video window, broadcast window) in the rights management system. | Column rights_availability_window_id (BIGINT) in rights.scheduling_blackout_rule',
    `rights_blackout_rule_id` BIGINT COMMENT 'FK to canonical rights blackout rule for enforcement | Column rights_blackout_rule_id (BIGINT) in rights.scheduling_blackout_rule',
    `scheduling_rights_rights_blackout_rule_id` BIGINT COMMENT 'FK reference to canonical source',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in scheduling.scheduling_blackout_rule',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in scheduling.scheduling_blackout_rule',
    `akamai_rule_code` STRING COMMENT 'The corresponding rule identifier in Akamai CDN configuration that enforces this blackout at the content delivery network level for OTT and streaming platforms. Enables traceability between the scheduling blackout rule and its CDN enforcement policy. | Column akamai_rule_code (STRING) in scheduling.scheduling_blackout_rule',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time at which this blackout rule was formally approved for enforcement by the authorized approver. Distinct from the record creation timestamp; represents the business approval event in the rule lifecycle. | Column approved_timestamp (TIMESTAMP) in scheduling.scheduling_blackout_rule',
    `blackout_end_timestamp` TIMESTAMP COMMENT 'The exact date and time (exclusive) at which the blackout restriction is lifted and normal playout/streaming of the content in the restricted territory may resume. Nullable for open-ended holdback obligations. Enforced by Ericsson MediaFirst and Akamai CDN. | Column blackout_end_timestamp (TIMESTAMP) in scheduling.scheduling_blackout_rule',
    `blackout_start_timestamp` TIMESTAMP COMMENT 'The exact date and time (inclusive) at which the blackout restriction becomes effective and playout/streaming of the content in the restricted territory must be suppressed. Enforced by Ericsson MediaFirst at playout and Akamai CDN at delivery. Stored in ISO 8601 format with timezone offset. | Column blackout_start_timestamp (TIMESTAMP) in scheduling.scheduling_blackout_rule',
    `clearance_status` STRING COMMENT 'Current rights clearance verification status for this blackout rule. pending indicates clearance is being verified; cleared indicates the blackout obligation has been confirmed against the rights contract; disputed indicates a conflict with the rights holder; waived indicates the rights holder has waived the blackout requirement; escalated indicates the clearance issue has been escalated for legal review. | Column clearance_status (STRING) in scheduling.scheduling_blackout_rule. Valid values are `pending|cleared|disputed|waived|escalated`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in scheduling.scheduling_blackout_rule',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this blackout rule record was first created in the scheduling data product. Supports audit trail, data lineage, and compliance reporting requirements. | Column created_timestamp (TIMESTAMP) in scheduling.scheduling_blackout_rule',
    `dai_override_flag` BOOLEAN COMMENT 'Indicates whether Dynamic Ad Insertion (DAI) should be overridden or suppressed during the blackout window for the restricted territory. When True, DAI ad pods are not inserted into the substitute content stream, preventing ad revenue leakage or compliance violations during blackout periods. | Column dai_override_flag (BOOLEAN) in scheduling.scheduling_blackout_rule',
    `eidr_code` STRING COMMENT 'Industry-standard EIDR identifier for the content asset subject to the blackout rule. Provides a globally unique, persistent content identifier enabling cross-system rights and blackout enforcement interoperability. | Column eidr_code (STRING) in scheduling.scheduling_blackout_rule. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `enforcement_scope` STRING COMMENT 'Defines where the blackout rule is enforced in the distribution chain. playout_only restricts at Ericsson MediaFirst broadcast playout; cdn_only restricts at Akamai CDN for streaming; playout_and_cdn enforces at both layers; epg_suppression additionally removes the program from EPG listings in the restricted territory. | Column enforcement_scope (STRING) in scheduling.scheduling_blackout_rule. Valid values are `playout_only|cdn_only|playout_and_cdn|epg_suppression`',
    `epg_suppression_flag` BOOLEAN COMMENT 'Indicates whether the program should be suppressed from the Electronic Program Guide (EPG) listing in the restricted territory during the blackout window. When True, the program title and metadata are hidden from viewer-facing EPG displays in the blacked-out market. | Column epg_suppression_flag (BOOLEAN) in scheduling.scheduling_blackout_rule',
    `holdback_type` STRING COMMENT 'The specific type of holdback obligation driving this blackout rule. exclusivity indicates a contractual exclusivity period; windowing indicates a sequential release window restriction; league_mandate indicates a sports league blackout mandate; regulatory indicates an FCC or Ofcom regulatory requirement; carriage_agreement indicates a distribution carriage fee agreement restriction. | Column holdback_type (STRING) in scheduling.scheduling_blackout_rule. Valid values are `exclusivity|windowing|league_mandate|regulatory|carriage_agreement`',
    `mediafirst_rule_code` STRING COMMENT 'The corresponding blackout rule identifier in Ericsson MediaFirst playout automation system. Used to synchronize blackout enforcement between the scheduling data product and the playout automation layer. | Column mediafirst_rule_code (STRING) in scheduling.scheduling_blackout_rule',
    `must_carry_exempt_flag` BOOLEAN COMMENT 'Indicates whether this blackout rule is exempt from must-carry obligations under FCC regulations. When True, the blackout may override must-carry requirements for the specified territory, typically applicable to sports blackout rules under 47 CFR Part 76. | Column must_carry_exempt_flag (BOOLEAN) in scheduling.scheduling_blackout_rule',
    `restricted_platform_type` STRING COMMENT 'The distribution platform category on which the blackout is enforced. Supports platform-specific blackout enforcement across linear broadcast, SVOD (Subscription Video On Demand), AVOD (Advertising-Supported Video On Demand), TVOD (Transactional Video On Demand), OTT (Over-The-Top), MVPD (Multichannel Video Programming Distributor), vMVPD (Virtual MVPD), and FAST (Free Ad-Supported Streaming Television) channels. [ENUM-REF-CANDIDATE: linear|svod|avod|tvod|ott|mvpd|vmvpd|fast — 8 candidates stripped; promote to reference product] | Column restricted_platform_type (STRING) in scheduling.scheduling_blackout_rule',
    `restricted_territory_code` STRING COMMENT 'The specific geographic territory code where the blackout is enforced, aligned with the restricted_territory_type. For DMA, this is the Nielsen DMA code (e.g., 501 for New York); for country, this is ISO 3166-1 alpha-3 (e.g., GBR); for state/province, this is ISO 3166-2 (e.g., US-CA). Used by Akamai CDN for geo-fencing enforcement. | Column restricted_territory_code (STRING) in scheduling.scheduling_blackout_rule',
    `restricted_territory_name` STRING COMMENT 'Human-readable name of the restricted geographic territory (e.g., New York DMA, United Kingdom, California). Used in EPG displays, rights clearance reports, and operational dashboards. | Column restricted_territory_name (STRING) in scheduling.scheduling_blackout_rule',
    `restricted_territory_type` STRING COMMENT 'Granularity level of the geographic restriction applied by this blackout rule. dma refers to Nielsen Designated Market Area; country uses ISO 3166-1 alpha-3; postal_region uses postal code ranges; state_province uses ISO 3166-2 subdivision codes; designated_zone refers to a custom broadcast zone defined in the rights contract. | Column restricted_territory_type (STRING) in scheduling.scheduling_blackout_rule. Valid values are `dma|country|postal_region|state_province|designated_zone`',
    `retransmission_consent_flag` BOOLEAN COMMENT 'Indicates whether this blackout rule is linked to a retransmission consent agreement. When True, the blackout is enforced as a condition of the retransmission consent negotiation between the broadcaster and the MVPD or vMVPD distributor. | Column retransmission_consent_flag (BOOLEAN) in scheduling.scheduling_blackout_rule',
    `rightsline_restriction_code` STRING COMMENT 'The restriction or holdback record identifier in Rightsline Rights and Royalties Management system that is the source of record for this blackout obligation. Enables bidirectional traceability between scheduling enforcement and rights contract management. | Column rightsline_restriction_code (STRING) in scheduling.scheduling_blackout_rule',
    `rule_code` STRING COMMENT 'Externally-known, human-readable business identifier for the blackout rule, used in Ericsson MediaFirst playout automation and Akamai CDN enforcement configurations. Follows the BKO- prefix convention for operational traceability. | Column rule_code (STRING) in scheduling.scheduling_blackout_rule. Valid values are `^BKO-[A-Z0-9]{4,12}$`',
    `rule_name` STRING COMMENT 'Descriptive human-readable name for the blackout rule, used in EPG management interfaces and rights clearance workflows (e.g., NFL Sunday Ticket DMA Blackout - New York). Supports operational identification in Rightsline and Wide Orbit. | Column rule_name (STRING) in scheduling.scheduling_blackout_rule',
    `rule_notes` STRING COMMENT 'Free-text operational notes providing additional context for the blackout rule, such as specific contractual conditions, exceptions, or instructions for the scheduling and playout teams. Not used for enforcement logic. | Column rule_notes (STRING) in scheduling.scheduling_blackout_rule',
    `rule_status` STRING COMMENT 'Current lifecycle state of the blackout rule. draft indicates the rule is being configured; active indicates it is currently enforced at playout and CDN; suspended indicates temporary non-enforcement; expired indicates the rule window has passed; cancelled indicates the rule was voided before activation. | Column rule_status (STRING) in scheduling.scheduling_blackout_rule. Valid values are `draft|active|suspended|expired|cancelled`',
    `rule_type` STRING COMMENT 'Classification of the blackout rule by its originating business driver. rights_holdback indicates a contractual windowing restriction from Rightsline; regulatory indicates FCC or Ofcom mandate; sports_blackout indicates league-mandated local market blackout; network_exclusivity indicates carriage agreement exclusivity; geographic_restriction indicates a general territorial restriction. [ENUM-REF-CANDIDATE: rights_holdback|regulatory|sports_blackout|network_exclusivity|geographic_restriction — promote to reference product] | Column rule_type (STRING) in scheduling.scheduling_blackout_rule. Valid values are `rights_holdback|regulatory|sports_blackout|network_exclusivity|geographic_restriction`',
    `scte35_cue_code` STRING COMMENT 'The SCTE-35 splice_event_id or cue identifier associated with this blackout rule, used by Ericsson MediaFirst to insert the blackout signal into the transport stream at the correct splice point. Enables automated blackout triggering at playout. | Column scte35_cue_code (STRING) in scheduling.scheduling_blackout_rule',
    `simulcast_blackout_flag` BOOLEAN COMMENT 'Indicates whether the blackout rule applies to simulcast transmissions of the content across multiple platforms simultaneously. When True, the blackout is enforced on all simulcast streams in addition to the primary broadcast channel. | Column simulcast_blackout_flag (BOOLEAN) in scheduling.scheduling_blackout_rule',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in scheduling.scheduling_blackout_rule',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in scheduling.scheduling_blackout_rule',
    `substitute_content_type` STRING COMMENT 'Classification of the substitute content to be delivered during the blackout window. alternate_program is a scheduled replacement; local_affiliate_feed is a local station feed; blackout_slate is a static or animated blackout message; network_filler is generic filler programming; none indicates no substitute is configured. | Column substitute_content_type (STRING) in scheduling.scheduling_blackout_rule. Valid values are `alternate_program|local_affiliate_feed|blackout_slate|network_filler|none`',
    `timezone_code` STRING COMMENT 'IANA timezone identifier for the blackout window (e.g., America/New_York, Europe/London). Ensures correct local-time interpretation of blackout_start_timestamp and blackout_end_timestamp for playout automation and CDN enforcement. | Column timezone_code (STRING) in scheduling.scheduling_blackout_rule',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in scheduling.scheduling_blackout_rule',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this blackout rule record was last modified. Tracks the most recent change to any attribute of the rule, supporting change management, audit trails, and downstream incremental processing in the Databricks Lakehouse Silver Layer. | Column updated_timestamp (TIMESTAMP) in scheduling.scheduling_blackout_rule',
    CONSTRAINT pk_scheduling_blackout_rule PRIMARY KEY(`scheduling_blackout_rule_id`)
) COMMENT 'Defines geographic or platform-specific broadcast restriction rules that prevent a program from airing in designated markets or on designated platforms, driven by rights holdback obligations or regulatory requirements. Captures content reference, restricted territory (DMA, country, postal region), restricted platform type, blackout start/end datetime, substitute content reference, and rights contract linkage. Enforced at playout by Ericsson MediaFirst and at CDN level by Akamai. | Unity Catalog table: media_broadcasting_ecm.scheduling.scheduling_blackout_rule | Domain ownership: EPG, program schedule, slots, rundowns, ad breaks, dayparts, simulcast, playout (Ericsson MediaFirst)';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` (
    `playout_event_id` BIGINT COMMENT 'Unique surrogate identifier for each as-run playout event record in the Ericsson MediaFirst as-run log. Serves as the primary key for this table. | Column playout_event_id (BIGINT) in scheduling.playout_event',
    `ad_pod_id` BIGINT COMMENT 'Identifier of the advertising pod (Ad Pod) to which this playout event belongs, if the event is a commercial break or advertisement. Links to the Wide Orbit ad scheduling record for billing reconciliation. | Column ad_pod_id (BIGINT) in sales.playout_event',
    `affidavit_id` BIGINT COMMENT 'Identifier of the Wide Orbit affidavit document generated for this playout event. Populated when affidavit_generated is true. Used for advertiser billing reconciliation and regulatory proof-of-performance. | Column affidavit_id (BIGINT) in sales.playout_event',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Playout events occur at specific facilities - fundamental for as-run logs, FCC compliance reporting, multi-site operations coordination, and facility-level performance tracking. Required for regulator | Column broadcast_facility_id (BIGINT) in technology.playout_event',
    `channel_id` BIGINT COMMENT 'Reference to the broadcast channel on which this playout event was transmitted. Links to the channel master record. | Column channel_id (BIGINT) in scheduling.playout_event',
    `closed_caption_record_id` BIGINT COMMENT 'Foreign key linking to compliance.closed_caption_record. Business justification: Each playout event must have corresponding closed caption compliance record for FCC CVAA accessibility reporting. Required for quarterly closed captioning quality reports and complaint response. Links | Column closed_caption_record_id (BIGINT) in compliance.playout_event',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Playout events incur transmission and playout automation costs. Transmission cost allocation, actual-vs-budget variance analysis, and operational cost accounting require event-to-cost-center mapping.  | Column cost_center_id (BIGINT) in finance.playout_event',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Playout event currently stores daypart_code as a STRING. As-run logs need to reference daypart attributes for affidavit generation, Nielsen reporting, and GRP calculation. Normalizing to FK enables JO | Column daypart_id (BIGINT) in scheduling.playout_event',
    `eas_log_id` BIGINT COMMENT 'Foreign key linking to compliance.eas_log. Business justification: Emergency Alert System activations during playout must be logged for FCC Part 11 compliance verification. Required for EAS test documentation and public inspection file. Links broadcast event to regul | Column eas_log_id (BIGINT) in compliance.playout_event',
    `employee_id` BIGINT COMMENT 'Identifier of the broadcast operator or system user who initiated or overrode this playout event in Ericsson MediaFirst. Populated for manual and override automation modes; null for fully automated events. | Column employee_id (BIGINT) in workforce.playout_event',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: As-run logs must capture the actual media file played for affidavit generation, FCC compliance reporting, and discrepancy analysis. Playout events record what actually aired at file level, not just ti | Column media_asset_id (BIGINT) in mediaasset.playout_event',
    `title_id` BIGINT COMMENT 'Reference to the content asset (programme, advertisement, interstitial, or filler) that was transmitted in this playout event. Links to the content master in the Digital Asset Management system. | Column primary_playout_title_id (BIGINT) in content.playout_event',
    `program_schedule_id` BIGINT COMMENT 'Reference to the planned program schedule entry from which this playout event was derived. Enables deviation analysis between planned and actual transmission. | Column program_schedule_id (BIGINT) in scheduling.playout_event',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: Playout events are as-run logs capturing actual transmission of schedule slots. Currently playout_event links to program_schedule but not to the specific schedule_slot that was transmitted. This FK en | Column schedule_slot_id (BIGINT) in scheduling.playout_event',
    `scte_marker_id` BIGINT COMMENT 'SCTE-35 splice cue identifier associated with this playout event, used for Dynamic Ad Insertion (DAI) signaling and ad break demarcation. Populated for commercial and interstitial events where SCTE-35 cue markers are active. | Column scte_marker_id (BIGINT) in scheduling.playout_event',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Playout systems log actual talent appearances for affidavit generation, residual payment calculation triggers, and as-run reconciliation against talent contracts. Required for guild reporting, usage r | Column talent_profile_id (BIGINT) in talent.playout_event',
    `transmission_equipment_id` BIGINT COMMENT 'Foreign key linking to technology.transmission_equipment. Business justification: Events transmitted via specific equipment - required for technical affidavits, equipment performance tracking, and playout automation diagnostics. Supports as-run reconciliation and equipment maintena | Column transmission_equipment_id (BIGINT) in technology.playout_event',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in scheduling.playout_event',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in scheduling.playout_event',
    `actual_duration_seconds` STRING COMMENT 'Actual transmitted duration of the playout event in seconds as recorded in the as-run log. Used for rights usage reporting, billing reconciliation, and compliance verification. | Column actual_duration_seconds (INT) in scheduling.playout_event',
    `actual_end_time` TIMESTAMP COMMENT 'Actual transmission end time as recorded in the Ericsson MediaFirst as-run log. Used with actual_start_time to confirm full transmission and calculate actual duration. | Column actual_end_time (TIMESTAMP) in scheduling.playout_event',
    `actual_start_time` TIMESTAMP COMMENT 'Actual transmission start time as recorded in the Ericsson MediaFirst as-run log. The authoritative timestamp for affidavit generation, rights usage reporting, and regulatory proof-of-performance. | Column actual_start_time (TIMESTAMP) in scheduling.playout_event',
    `affidavit_generated` BOOLEAN COMMENT 'Indicates whether a broadcast affidavit (proof-of-performance document) has been generated for this playout event in Wide Orbit. Affidavits are the evidentiary basis for advertiser billing and regulatory compliance. | Column affidavit_generated (BOOLEAN) in scheduling.playout_event',
    `automation_mode` STRING COMMENT 'Operational mode of the Ericsson MediaFirst playout automation at the time of this event. auto = fully automated playout; manual = operator-controlled; override = scheduled automation overridden by operator; failover = backup/failover system active. | Column automation_mode (STRING) in scheduling.playout_event. Valid values are `auto|manual|override|failover`',
    `blackout_flag` BOOLEAN COMMENT 'Indicates whether this playout event was subject to a geographic broadcast blackout restriction. When true, the event was blacked out in one or more markets per rights or regulatory obligations. | Column blackout_flag (BOOLEAN) in scheduling.playout_event',
    `broadcast_date` DATE COMMENT 'Calendar date on which this playout event was transmitted, expressed in the channels local broadcast day (which may differ from UTC date for overnight programming). | Column broadcast_date (DATE) in scheduling.playout_event',
    `broadcast_standard` STRING COMMENT 'Technical broadcast standard under which this playout event was transmitted. Determines encoding, modulation, and compliance requirements. | Column broadcast_standard (STRING) in scheduling.playout_event. Valid values are `ATSC|DVB|ISDB|NTSC|PAL`',
    `content_rating` STRING COMMENT 'Content rating classification of the transmitted asset as defined by the Motion Picture Association (MPA) TV Parental Guidelines. Used for COPPA compliance, watershed enforcement, and FCC childrens programming obligations. | Column content_rating (STRING) in scheduling.playout_event. Valid values are `TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in scheduling.playout_event',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this as-run playout event record was first ingested into the Silver layer from the Ericsson MediaFirst as-run log. Serves as the audit creation timestamp for data lineage. | Column created_timestamp (TIMESTAMP) in scheduling.playout_event',
    `dai_eligible` BOOLEAN COMMENT 'Indicates whether this playout event was eligible for Dynamic Ad Insertion (DAI) on OTT/streaming platforms. Used for digital advertising reconciliation and DAI revenue attribution. | Column dai_eligible (BOOLEAN) in scheduling.playout_event',
    `dalet_asset_code` STRING COMMENT 'Asset identifier in the Dalet Galaxy Media Asset Management system for the content transmitted in this playout event. Used for digital asset reconciliation and archive linkage. | Column dalet_asset_code (STRING) in scheduling.playout_event',
    `event_type` STRING COMMENT 'Classification of the playout event by content category. Determines applicable rights, billing rules, and regulatory requirements. [ENUM-REF-CANDIDATE: program|commercial|promo|interstitial|filler|ident|emergency_alert — promote to reference product] | Column event_type (STRING) in scheduling.playout_event',
    `failover_activated` BOOLEAN COMMENT 'Indicates whether the Ericsson MediaFirst failover/backup playout system was active during this event. When true, the primary playout chain was unavailable and the backup system handled transmission. | Column failover_activated (BOOLEAN) in scheduling.playout_event',
    `isan_code` STRING COMMENT 'International Standard Audiovisual Number (ISAN) identifying the programme or content asset transmitted. Used for rights usage reporting and royalty calculation in Rightsline. | Column isan_code (STRING) in scheduling.playout_event',
    `isci_code` STRING COMMENT 'Industry Standard Commercial Identification (ISCI) code for the commercial asset transmitted in this playout event. Used for advertiser billing reconciliation and affidavit generation in Wide Orbit. | Column isci_code (STRING) in scheduling.playout_event. Valid values are `^[A-Z0-9]{8}$`',
    `mediafirst_event_code` STRING COMMENT 'Native event identifier assigned by Ericsson MediaFirst automation system for this as-run log entry. Used for reconciliation with the source playout system. | Column mediafirst_event_code (STRING) in scheduling.playout_event',
    `must_carry_flag` BOOLEAN COMMENT 'Indicates whether this playout event was subject to must-carry obligations requiring mandatory channel inclusion by MVPDs. Used for regulatory compliance reporting to the FCC. | Column must_carry_flag (BOOLEAN) in scheduling.playout_event',
    `playout_status` STRING COMMENT 'Outcome status of the playout event as recorded in the Ericsson MediaFirst as-run log. aired = transmitted as planned; skipped = omitted from transmission; substituted = replaced with alternate content; failed = transmission error; partial = incomplete transmission; delayed = transmitted late. | Column playout_status (STRING) in scheduling.playout_event. Valid values are `aired|skipped|substituted|failed|partial|delayed`',
    `rights_clearance_status` STRING COMMENT 'Rights clearance status of the content asset at the time of transmission. cleared = rights verified and valid; pending = clearance in progress; expired = rights window had lapsed; restricted = transmission was restricted. Used for rights compliance audit and Rightsline reconciliation. | Column rights_clearance_status (STRING) in scheduling.playout_event. Valid values are `cleared|pending|expired|restricted`',
    `scheduled_duration_seconds` STRING COMMENT 'Planned duration of the playout event in seconds as defined in the program schedule rundown. Used as the baseline for duration deviation analysis. | Column scheduled_duration_seconds (INT) in scheduling.playout_event',
    `scheduled_start_time` TIMESTAMP COMMENT 'Planned transmission start time for this event as defined in the Electronic Program Guide (EPG) and program schedule rundown. Used as the baseline for schedule deviation calculation. | Column scheduled_start_time (TIMESTAMP) in scheduling.playout_event',
    `simulcast_flag` BOOLEAN COMMENT 'Indicates whether this playout event was simultaneously broadcast across multiple platforms (simulcast). When true, the event was transmitted on additional channels or OTT platforms concurrently. | Column simulcast_flag (BOOLEAN) in scheduling.playout_event',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in scheduling.playout_event',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in scheduling.playout_event',
    `start_deviation_seconds` STRING COMMENT 'Difference in seconds between actual_start_time and scheduled_start_time. Positive values indicate late start; negative values indicate early start. Key metric for schedule adherence and SLA reporting. | Column start_deviation_seconds (INT) in scheduling.playout_event',
    `substitution_reason` STRING COMMENT 'Reason code explaining why the originally scheduled content was substituted with alternate content. Populated only when playout_status is substituted. Used for rights compliance and editorial audit trails. | Column substitution_reason (STRING) in scheduling.playout_event. Valid values are `rights_expired|technical_fault|editorial_decision|emergency_override|blackout|operator_override`',
    `transmission_type` STRING COMMENT 'Mode of content delivery for this playout event. linear = traditional scheduled broadcast; vod = Video On Demand; simulcast = simultaneous multi-platform; ott = Over-The-Top streaming; fast = Free Ad-Supported Streaming Television. | Column transmission_type (STRING) in scheduling.playout_event. Valid values are `linear|vod|simulcast|ott|fast`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in scheduling.playout_event',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this playout event record was last modified in the Silver layer, for example following affidavit generation, rights clearance update, or schedule reconciliation. | Column updated_timestamp (TIMESTAMP) in scheduling.playout_event',
    `wide_orbit_log_code` STRING COMMENT 'Corresponding log entry identifier in Wide Orbit Traffic and Billing system. Used for advertiser billing reconciliation and affidavit generation. | Column wide_orbit_log_code (STRING) in scheduling.playout_event',
    CONSTRAINT pk_playout_event PRIMARY KEY(`playout_event_id`)
) COMMENT 'As-run log record from Ericsson MediaFirst capturing actual transmission of each schedule slot as broadcast. Records actual start/end time, duration, content ID, channel, playout status (aired, skipped, substituted, failed), automation mode (auto, manual, override), operator ID, and deviation from planned schedule in seconds. The authoritative as-run record serving as the evidentiary basis for affidavit generation, rights usage reporting, advertiser billing reconciliation, and regulatory proof-of-performance. | Unity Catalog table: media_broadcasting_ecm.scheduling.playout_event | Domain ownership: EPG, program schedule, slots, rundowns, ad breaks, dayparts, simulcast, playout (Ericsson MediaFirst)';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` (
    `program_rundown_id` BIGINT COMMENT 'Unique surrogate identifier for the program rundown record in the Databricks Silver Layer. Primary key for this entity. | Column program_rundown_id (BIGINT) in scheduling.program_rundown',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Rundowns executed at specific facilities - supports live production coordination, facility resource allocation, studio booking, and multi-site news/sports operations. Essential for production planning | Column broadcast_facility_id (BIGINT) in technology.program_rundown',
    `channel_id` BIGINT COMMENT 'Reference to the broadcast channel on which this program rundown is executed. Links to the channel master in the scheduling domain. | Column channel_id (BIGINT) in scheduling.program_rundown',
    `content_episode_id` BIGINT COMMENT 'Reference to the episode or content asset in the content domain that this rundown is associated with. Enables linkage to content metadata, rights, and digital asset records. | Column content_episode_id (BIGINT) in content.program_rundown',
    `coppa_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.coppa_declaration. Business justification: Childrens programming rundowns require COPPA compliance declarations for data collection practices and FCC childrens programming rules. Required for quarterly childrens programming reports and FTC  | Column coppa_declaration_id (BIGINT) in compliance.program_rundown',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Program rundown currently stores daypart_code as a STRING. This should be normalized to FK to the daypart reference table (scheduling_daypart_id). This enables JOIN to retrieve daypart_name, rate_mult | Column daypart_id (BIGINT) in scheduling.program_rundown',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Live news/sports rundowns reference specific media assets (pre-produced packages, VTR rolls, B-roll) for playout during live production. Production control systems need direct asset references for ope | Column media_asset_id (BIGINT) in mediaasset.program_rundown',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Program rundowns are created by producers/directors for live and taped programs. Fundamental production workflow tracking requires linking rundown to responsible producer for coordination, approval ro | Column producer_employee_id (BIGINT) in workforce.program_rundown',
    `program_schedule_id` BIGINT COMMENT 'Reference to the parent program schedule entry (Electronic Program Guide slot) that this rundown fulfills. Aligns with scheduling.program_schedule. | Column program_schedule_id (BIGINT) in scheduling.program_rundown',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Live show rundowns (news, talk shows, morning programs) specify primary talent (anchors, hosts) for production coordination, union notification requirements, and screen time tracking. Essential for ca | Column talent_profile_id (BIGINT) in talent.program_rundown',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in scheduling.program_rundown',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in scheduling.program_rundown',
    `ad_pod_count` STRING COMMENT 'Number of commercial break ad pods (groups of ads) planned within this rundown. Used for Wide Orbit traffic scheduling and SCTE-35 cue marker planning. | Column ad_pod_count (INT) in scheduling.program_rundown',
    `approved_by` STRING COMMENT 'Name or identifier of the producer or scheduling manager who approved the final rundown for transmission. Required for production accountability and compliance audit trails. | Column approved_by (STRING) in scheduling.program_rundown',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the rundown was formally approved for playout. Marks the transition from approved to locked status in the production workflow. | Column approved_timestamp (TIMESTAMP) in scheduling.program_rundown',
    `blackout_flag` BOOLEAN COMMENT 'Indicates whether geographic broadcast blackout restrictions apply to this program rundown. When True, blackout rules must be enforced by distribution systems per rights agreements managed in Rightsline. | Column blackout_flag (BOOLEAN) in scheduling.program_rundown',
    `broadcast_date` DATE COMMENT 'The calendar date on which this program rundown is scheduled for transmission. Used for EPG alignment, scheduling compliance, and as-run reconciliation. | Column broadcast_date (DATE) in scheduling.program_rundown',
    `content_rating` STRING COMMENT 'The TV Parental Guidelines content rating assigned to the program (e.g., TV-G, TV-14, TV-MA). Used for scheduling compliance, COPPA restrictions, and EPG display. | Column content_rating (STRING) in scheduling.program_rundown. Valid values are `TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in scheduling.program_rundown',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this rundown record was first created in the system, typically when the production team initiates show preparation in Dalet Galaxy. | Column created_timestamp (TIMESTAMP) in scheduling.program_rundown',
    `dai_eligible` BOOLEAN COMMENT 'Indicates whether this program rundown is eligible for Dynamic Ad Insertion (DAI) on streaming/OTT platforms. Drives ad tech configuration in Akamai CDN and Adobe Experience Platform. | Column dai_eligible (BOOLEAN) in scheduling.program_rundown',
    `dalet_story_code` STRING COMMENT 'The story or rundown identifier in Dalet Galaxy Media Asset Management system. Enables traceability from the Silver Layer back to the MAM workflow for metadata, archive, and ingest operations. | Column dalet_story_code (STRING) in scheduling.program_rundown',
    `emergency_alert_ready` BOOLEAN COMMENT 'Indicates whether the rundown and playout configuration supports Emergency Alert System (EAS) interruption. Required for FCC broadcast compliance and emergency preparedness. | Column emergency_alert_ready (BOOLEAN) in scheduling.program_rundown',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this rundown record was last updated. Tracks the most recent editorial or operational change to the rundown for audit and version control purposes. | Column last_modified_timestamp (TIMESTAMP) in scheduling.program_rundown',
    `live_flag` BOOLEAN COMMENT 'Indicates whether the program is transmitted live (True) or is a pre-recorded/tape playback (False). Drives Ericsson MediaFirst live playout mode and affects DAI eligibility and failover configuration. | Column live_flag (BOOLEAN) in scheduling.program_rundown',
    `mediafirst_rundown_code` STRING COMMENT 'The native rundown identifier assigned by Ericsson MediaFirst playout automation system. Used for bidirectional reconciliation between the Silver Layer and the operational playout system. | Column mediafirst_rundown_code (STRING) in scheduling.program_rundown',
    `playout_failover_mode` STRING COMMENT 'Defines the failover strategy configured in Ericsson MediaFirst if the primary playout source fails during this program. none = no failover; backup_channel = switch to backup feed; filler_loop = play filler content; manual = operator intervention required. | Column playout_failover_mode (STRING) in scheduling.program_rundown. Valid values are `none|backup_channel|filler_loop|manual`',
    `production_format` STRING COMMENT 'Describes the production origination format of the program. studio = produced in-house studio; remote = outside broadcast; hybrid = mixed studio and remote; tape = pre-recorded playback; simulcast = simultaneous multi-platform broadcast. | Column production_format (STRING) in scheduling.program_rundown. Valid values are `studio|remote|hybrid|tape|simulcast`',
    `program_content_seconds` STRING COMMENT 'Total planned duration of editorial/program content segments in seconds, excluding commercial breaks and credits. Used for content-to-ad ratio compliance reporting. | Column program_content_seconds (INT) in scheduling.program_rundown',
    `program_title` STRING COMMENT 'The editorial title of the program for which this rundown is prepared (e.g., Morning News Live, Prime Time Sports). Used for display in production systems and EPG. | Column program_title (STRING) in scheduling.program_rundown',
    `rights_clearance_status` STRING COMMENT 'Current rights clearance status for the program content in this rundown. cleared = all rights verified for broadcast; pending = clearance in progress; restricted = broadcast blocked; expired = rights window has lapsed. Sourced from Rightsline. | Column rights_clearance_status (STRING) in scheduling.program_rundown. Valid values are `cleared|pending|restricted|expired`',
    `rundown_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the rundown, used by production teams and Ericsson MediaFirst automation to reference the show rundown. Unique within a broadcast date and channel. | Column rundown_code (STRING) in scheduling.program_rundown. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `rundown_notes` STRING COMMENT 'Free-text production notes associated with the rundown, capturing special instructions, last-minute changes, talent notes, or technical advisories for the production and playout teams. | Column rundown_notes (STRING) in scheduling.program_rundown',
    `rundown_status` STRING COMMENT 'Current lifecycle state of the rundown. draft = in preparation; approved = signed off by producer; locked = no further edits permitted; transmitted = playout completed; archived = retained for compliance. | Column rundown_status (STRING) in scheduling.program_rundown. Valid values are `draft|approved|locked|transmitted|archived`',
    `rundown_type` STRING COMMENT 'Classification of the program rundown by genre or production format. Drives template selection in Ericsson MediaFirst and informs segment structure expectations. [ENUM-REF-CANDIDATE: news|sports|entertainment|talk_show|documentary|magazine|special — promote to reference product] | Column rundown_type (STRING) in scheduling.program_rundown',
    `rundown_version` STRING COMMENT 'Incremental version number of the rundown, incremented each time the rundown is revised. Enables version tracking and rollback for production teams and playout automation. | Column rundown_version (INT) in scheduling.program_rundown',
    `scheduled_end_time` TIMESTAMP COMMENT 'The planned transmission end timestamp for the program. Used to calculate total runtime and validate against EPG slot allocation. | Column scheduled_end_time (TIMESTAMP) in scheduling.program_rundown',
    `scheduled_start_time` TIMESTAMP COMMENT 'The planned transmission start timestamp for the program, including timezone offset. Used by Ericsson MediaFirst automation for playout triggering and EPG publication. | Column scheduled_start_time (TIMESTAMP) in scheduling.program_rundown',
    `scte35_cue_count` STRING COMMENT 'Number of SCTE-35 digital program insertion cue markers planned in this rundown. Used for Dynamic Ad Insertion (DAI) triggering and ad break signaling to downstream distribution systems. | Column scte35_cue_count (INT) in scheduling.program_rundown',
    `segment_count` STRING COMMENT 'Total number of rundown items (segments) defined in this rundown, including news blocks, interviews, commercial breaks, tosses, and credits. Used for production planning and playout validation. | Column segment_count (INT) in scheduling.program_rundown',
    `simulcast_flag` BOOLEAN COMMENT 'Indicates whether this program rundown is simultaneously broadcast across multiple platforms (linear, OTT, streaming). When True, simulcast platform configurations must be applied. | Column simulcast_flag (BOOLEAN) in scheduling.program_rundown',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in scheduling.program_rundown',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in scheduling.program_rundown',
    `total_ad_time_seconds` STRING COMMENT 'Total planned advertising time in seconds across all ad pods in the rundown. Used for FCC/Ofcom advertising minutage compliance and Wide Orbit traffic reconciliation. | Column total_ad_time_seconds (INT) in scheduling.program_rundown',
    `total_runtime_seconds` STRING COMMENT 'Total planned duration of the program in seconds, encompassing all segments including program content, commercial breaks, and credits. Must match the EPG slot allocation. | Column total_runtime_seconds (INT) in scheduling.program_rundown',
    `transmitted_timestamp` TIMESTAMP COMMENT 'The actual date and time when playout of this program rundown commenced transmission. Populated by Ericsson MediaFirst upon broadcast start. Used for as-run reconciliation and affidavit generation. | Column transmitted_timestamp (TIMESTAMP) in scheduling.program_rundown',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in scheduling.program_rundown',
    `wide_orbit_log_code` STRING COMMENT 'The traffic log identifier in Wide Orbit used to reconcile ad pod placements in this rundown against the ad scheduling and billing system. Supports affidavit generation and as-run confirmation. | Column wide_orbit_log_code (STRING) in scheduling.program_rundown',
    CONSTRAINT pk_program_rundown PRIMARY KEY(`program_rundown_id`)
) COMMENT 'Detailed production rundown for a live or studio program defining the internal segment structure — news blocks, interview segments, commercial breaks, toss segments, and closing credits. Captures program title, episode reference, total runtime, segment count, live/tape flag, rundown status, and the ordered list of rundown items with planned durations. Used by Ericsson MediaFirst automation for live show playout control and by production teams for show preparation. | Unity Catalog table: media_broadcasting_ecm.scheduling.program_rundown | Domain ownership: EPG, program schedule, slots, rundowns, ad breaks, dayparts, simulcast, playout (Ericsson MediaFirst)';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` (
    `rundown_item_id` BIGINT COMMENT 'Unique surrogate identifier for each individual segment or item within a program rundown. Primary key for the rundown_item entity in the Databricks Silver Layer. | Column rundown_item_id (BIGINT) in scheduling.rundown_item',
    `employee_id` BIGINT COMMENT 'Reference to the talent record for the presenter, anchor, or reporter assigned to deliver this rundown item. Supports talent scheduling, residuals tracking, and on-air credit reporting. | Column employee_id (BIGINT) in workforce.rundown_item',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Individual rundown items (VTR, PKG, VO) must reference the specific media file for playout. Production operators need asset-level metadata (duration, timecode, format) for live show execution. Distinc | Column media_asset_id (BIGINT) in mediaasset.rundown_item',
    `program_rundown_id` BIGINT COMMENT 'Foreign key linking to scheduling.program_rundown. Business justification: Rundown items are individual segments within a program rundown. Currently rundown_item only links to program_schedule, but it should also link to the specific program_rundown that contains it. This pr | Column program_rundown_id (BIGINT) in scheduling.rundown_item',
    `program_schedule_id` BIGINT COMMENT 'Reference to the parent program schedule (rundown header) that this item belongs to. Links the atomic rundown item to its containing broadcast schedule. | Column program_schedule_id (BIGINT) in scheduling.rundown_item',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Individual rundown segments feature specific talent (correspondents, panelists, guests) requiring tracking for segment-level screen time calculation, residual eligibility determination, and credit att | Column talent_profile_id (BIGINT) in talent.rundown_item',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in scheduling.rundown_item',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in scheduling.rundown_item',
    `actual_duration_seconds` STRING COMMENT 'Real elapsed duration of the rundown item in seconds as recorded during or after playout. Compared against planned_duration_seconds for show timing analysis and as-run log reconciliation. | Column actual_duration_seconds (INT) in scheduling.rundown_item',
    `actual_end_time` TIMESTAMP COMMENT 'Actual wall-clock time at which this rundown item completed playout. Used alongside actual_start_time to compute actual_duration_seconds and to validate show overrun or underrun conditions. | Column actual_end_time (TIMESTAMP) in scheduling.rundown_item',
    `actual_start_time` TIMESTAMP COMMENT 'Actual wall-clock time at which this rundown item began playout as recorded by the Ericsson MediaFirst automation system. Used for as-run log generation and Wide Orbit affidavit reconciliation. | Column actual_start_time (TIMESTAMP) in scheduling.rundown_item',
    `ad_pod_duration_seconds` STRING COMMENT 'Total allocated duration in seconds for the ad pod break associated with this rundown item. Populated only when ad_pod_flag is true. Used for ad load compliance and Wide Orbit traffic scheduling. | Column ad_pod_duration_seconds (INT) in scheduling.rundown_item',
    `ad_pod_flag` BOOLEAN COMMENT 'Indicates whether this rundown item represents an Ad Pod (a group of commercial spots within a break). When true, triggers SCTE-35 cue marker insertion and Dynamic Ad Insertion (DAI) eligibility checks. | Column ad_pod_flag (BOOLEAN) in scheduling.rundown_item',
    `ad_pod_spot_count` STRING COMMENT 'Number of individual commercial spots scheduled within this ad pod break. Used for ad load monitoring, Wide Orbit traffic log validation, and FCC childrens programming ad limit compliance. | Column ad_pod_spot_count (INT) in scheduling.rundown_item',
    `backtime_flag` BOOLEAN COMMENT 'Indicates whether this rundown item is backtimed — i.e., its start time is calculated backwards from a fixed end point (e.g., top-of-hour news break or programme end). Critical for live show timing control in Ericsson MediaFirst. | Column backtime_flag (BOOLEAN) in scheduling.rundown_item',
    `blackout_flag` BOOLEAN COMMENT 'Indicates whether geographic broadcast blackout restrictions apply to this rundown item. When true, triggers blackout enforcement logic in the distribution layer per rights agreements managed in Rightsline. | Column blackout_flag (BOOLEAN) in scheduling.rundown_item',
    `content_rating` STRING COMMENT 'Motion Picture Association (MPA) or TV Parental Guidelines content rating applicable to this rundown item. Used for COPPA compliance checks, watershed scheduling enforcement, and EPG advisory display. | Column content_rating (STRING) in scheduling.rundown_item. Valid values are `TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in scheduling.rundown_item',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rundown item record was first created in the data platform, typically corresponding to the initial rundown build in Dalet Galaxy or Ericsson MediaFirst. Supports audit trail and data lineage. | Column created_timestamp (TIMESTAMP) in scheduling.rundown_item',
    `cue_text` STRING COMMENT 'Editorial cue or introduction text read by the presenter or director to introduce this rundown item. Stored as the production script reference for live show execution and post-broadcast archive. | Column cue_text (STRING) in scheduling.rundown_item',
    `dalet_asset_code` STRING COMMENT 'Reference identifier for the content asset in Dalet Galaxy Media Asset Management system associated with this rundown item. Links the production element to its archived media essence, metadata, and workflow history. | Column dalet_asset_code (STRING) in scheduling.rundown_item',
    `daypart_code` STRING COMMENT 'Code identifying the broadcast daypart (time segment of the broadcast day) in which this rundown item falls. Links to scheduling.daypart for rate multiplier, demographic targeting, and Nielsen audience measurement context. | Column daypart_code (STRING) in scheduling.rundown_item',
    `duration_variance_seconds` STRING COMMENT 'Difference in seconds between actual_duration_seconds and planned_duration_seconds (actual minus planned). Positive values indicate overrun; negative values indicate underrun. Used for show timing analysis and rundown optimisation. | Column duration_variance_seconds (INT) in scheduling.rundown_item',
    `eom_timecode` STRING COMMENT 'SMPTE timecode marking the End of Message (EOM) — the precise out-point of the media asset for this rundown item. Used alongside som_timecode for frame-accurate duration calculation and playout control. | Column eom_timecode (STRING) in scheduling.rundown_item. Valid values are `^d{2}:d{2}:d{2}[;:]d{2}$`',
    `epg_description` STRING COMMENT 'Short editorial description of this rundown item for display in the Electronic Program Guide (EPG). Populated for story packages and feature segments; used by EPG aggregators and on-screen guide systems. | Column epg_description (STRING) in scheduling.rundown_item',
    `graphics_template_code` STRING COMMENT 'Identifier for the graphics or lower-third template to be rendered by the Ericsson MediaFirst graphics engine for this rundown item. Applicable for graphic and lower_third segment formats. | Column graphics_template_code (STRING) in scheduling.rundown_item',
    `isci_code` STRING COMMENT 'Industry Standard Commercial Identification (ISCI) code for the commercial spot associated with this rundown item. Populated for commercial_break items; used for Wide Orbit affidavit generation and advertiser billing reconciliation. | Column isci_code (STRING) in scheduling.rundown_item. Valid values are `^[A-Z0-9]{8}$`',
    `item_status` STRING COMMENT 'Current production lifecycle state of the rundown item as managed in the live show production control system. Drives automation decisions in Ericsson MediaFirst and Dalet Galaxy workflow. | Column item_status (STRING) in scheduling.rundown_item. Valid values are `ready|on_air|completed|skipped|hold|missing`',
    `item_title` STRING COMMENT 'Human-readable editorial title or slug for the rundown item as displayed in the production control system and Electronic Program Guide (EPG). Used by producers and directors during live show execution. | Column item_title (STRING) in scheduling.rundown_item',
    `item_type` STRING COMMENT 'Classification of the discrete production element represented by this rundown item. Determines playout behaviour, automation triggers, and ad pod eligibility. [ENUM-REF-CANDIDATE: story_package|live_shot|interview|commercial_break|graphic|music_bed|filler|open|close — promote to reference product] | Column item_type (STRING) in scheduling.rundown_item',
    `live_flag` BOOLEAN COMMENT 'Indicates whether this rundown item is a live production element (true) or a pre-recorded/packaged asset (false). Drives Ericsson MediaFirst automation mode selection and EPG live indicator display. | Column live_flag (BOOLEAN) in scheduling.rundown_item',
    `mediafirst_item_code` STRING COMMENT 'Native item identifier assigned by the Ericsson MediaFirst playout automation system for this rundown element. Used for reconciliation between the Silver Layer data product and the operational playout system. | Column mediafirst_item_code (STRING) in scheduling.rundown_item',
    `planned_duration_seconds` STRING COMMENT 'Scheduled duration of the rundown item in seconds as defined during pre-production rundown preparation. Used for total show timing, backtime calculations, and ad pod compliance checks. | Column planned_duration_seconds (INT) in scheduling.rundown_item',
    `planned_start_time` TIMESTAMP COMMENT 'Scheduled wall-clock start time for this rundown item based on the pre-production rundown. Used for Electronic Program Guide (EPG) display, backtime calculations, and SCTE-35 cue marker pre-positioning. | Column planned_start_time (TIMESTAMP) in scheduling.rundown_item',
    `rights_clearance_status` STRING COMMENT 'Current rights clearance state for the content asset associated with this rundown item as verified against Rightsline. Prevents playout of uncleared content and supports compliance with windowing and holdback obligations. | Column rights_clearance_status (STRING) in scheduling.rundown_item. Valid values are `cleared|pending|restricted|expired|not_required`',
    `scte35_cue_in_time` TIMESTAMP COMMENT 'Timestamp at which the SCTE-35 splice_insert cue-in signal is triggered to mark the return to programme content after an ad break. Used for DAI reconciliation and ad delivery verification. | Column scte35_cue_in_time (TIMESTAMP) in scheduling.rundown_item',
    `scte35_cue_out_time` TIMESTAMP COMMENT 'Timestamp at which the SCTE-35 splice_insert cue-out signal is triggered to mark the start of an ad break for Dynamic Ad Insertion (DAI) and addressable advertising systems. Populated for commercial_break item types. | Column scte35_cue_out_time (TIMESTAMP) in scheduling.rundown_item',
    `segment_format` STRING COMMENT 'Production format classification of the rundown item using broadcast newsroom terminology. Determines the technical playout configuration and graphics overlay requirements in Ericsson MediaFirst. [ENUM-REF-CANDIDATE: pkg|vo|vosot|sot|live|standup|anchor_read|graphic_full|lower_third — promote to reference product] | Column segment_format (STRING) in scheduling.rundown_item',
    `sequence_number` STRING COMMENT 'Ordinal position of this item within the program rundown, determining the playout order. Used by Ericsson MediaFirst automation to sequence segments during live show production control. | Column sequence_number (INT) in scheduling.rundown_item',
    `simulcast_flag` BOOLEAN COMMENT 'Indicates whether this rundown item is simultaneously broadcast across multiple platforms (linear, OTT, streaming). When true, triggers multi-platform distribution workflows and DAI configuration in Akamai CDN. | Column simulcast_flag (BOOLEAN) in scheduling.rundown_item',
    `skip_reason` STRING COMMENT 'Reason code explaining why this rundown item was skipped during playout. Populated only when item_status = skipped. Used for post-broadcast editorial review and rights compliance audit. | Column skip_reason (STRING) in scheduling.rundown_item. Valid values are `rights_issue|technical_fault|editorial_decision|time_overrun|duplicate|not_applicable`',
    `som_timecode` STRING COMMENT 'SMPTE timecode marking the Start of Message (SOM) — the precise in-point of the media asset to be played for this rundown item. Used by Ericsson MediaFirst for frame-accurate playout cueing. | Column som_timecode (STRING) in scheduling.rundown_item. Valid values are `^d{2}:d{2}:d{2}[;:]d{2}$`',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in scheduling.rundown_item',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in scheduling.rundown_item',
    `tape_number` STRING COMMENT 'Physical or virtual media identifier (tape ID, clip ID, or server ID) for the pre-recorded asset associated with this rundown item in the Dalet Galaxy MAM system. Used for media retrieval and playout server cueing. | Column tape_number (STRING) in scheduling.rundown_item',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in scheduling.rundown_item',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this rundown item record. Tracks editorial changes, status transitions, and timing adjustments throughout the show production lifecycle. | Column updated_timestamp (TIMESTAMP) in scheduling.rundown_item',
    `wide_orbit_spot_code` STRING COMMENT 'Identifier from the Wide Orbit Traffic and Billing system for commercial spots or ad pod items within this rundown. Populated only for item_type = commercial_break; used for affidavit generation and billing reconciliation. | Column wide_orbit_spot_code (STRING) in scheduling.rundown_item',
    CONSTRAINT pk_rundown_item PRIMARY KEY(`rundown_item_id`)
) COMMENT 'Individual segment or item within a program rundown, representing a discrete production element (story package, live shot, interview, commercial break, graphic, music bed, or filler). Captures item sequence, item type, planned duration, actual duration, content asset reference, presenter/anchor assignment, cue text, backtime flag, and item status (ready, on-air, completed, skipped). The atomic unit of live show production control. | Unity Catalog table: media_broadcasting_ecm.scheduling.rundown_item | Domain ownership: EPG, program schedule, slots, rundowns, ad breaks, dayparts, simulcast, playout (Ericsson MediaFirst)';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` (
    `scheduling_availability_window_id` BIGINT COMMENT 'Primary key for availability_window | Column scheduling_availability_window_id (BIGINT) in scheduling.scheduling_availability_window',
    `compliance_consent_record_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_record. Business justification: Streaming availability windows require user consent verification for personalized content delivery under GDPR/CCPA. Links content windowing strategy to privacy compliance for targeted advertising and  | Column compliance_consent_record_id (BIGINT) in compliance.scheduling_availability_window',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Distribution windows apply to specific media assets (master files, localized versions, format variants) not just title-level metadata. Rights management requires asset-level tracking for DRM applicati | Column media_asset_id (BIGINT) in mediaasset.scheduling_availability_window',
    `ott_platform_id` BIGINT COMMENT 'Reference to the distribution platform or service on which this availability window applies (e.g., SVOD app, AVOD channel, TVOD storefront, FAST channel). | Column ott_platform_id (BIGINT) in distribution.scheduling_availability_window',
    `rights_availability_window_id` BIGINT COMMENT 'Reference to the corresponding rights window record in the rights and licensing domain (Rightsline), linking operational scheduling parameters to the underlying contractual rights availability. | Column rights_availability_window_id (BIGINT) in rights.scheduling_availability_window',
    `title_id` BIGINT COMMENT 'Reference to the content title for which this availability window is defined. Links to the master content asset record in the content domain. | Column title_id (BIGINT) in content.scheduling_availability_window',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in scheduling.scheduling_availability_window',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in scheduling.scheduling_availability_window',
    `ad_break_max_duration_seconds` STRING COMMENT 'The maximum allowable duration in seconds for a single ad break (ad pod) within the content during this availability window. Used to enforce ad load limits and viewer experience standards on AVOD and FAST platforms. | Column ad_break_max_duration_seconds (INT) in scheduling.scheduling_availability_window',
    `ad_pod_max_count` STRING COMMENT 'The maximum number of ad pods (groups of ads in a break) permitted within the content during this availability window. Governs ad load compliance for AVOD and FAST platforms. Null for SVOD or TVOD windows where advertising is not applicable. | Column ad_pod_max_count (INT) in scheduling.scheduling_availability_window',
    `akamai_stream_url` STRING COMMENT 'The Akamai CDN origin stream URL for delivering the content during this availability window. Specifies the endpoint used for HLS or MPEG-DASH adaptive bitrate streaming to end-user devices. | Column akamai_stream_url (STRING) in scheduling.scheduling_availability_window. Valid values are `^https://[a-zA-Z0-9._/-]+$`',
    `approved_by` STRING COMMENT 'The name or identifier of the scheduling or rights operations personnel who approved this availability window configuration for activation. Required for audit trail and compliance with rights clearance workflows. | Column approved_by (STRING) in scheduling.scheduling_availability_window',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time at which this availability window configuration was formally approved for activation. Part of the lifecycle audit trail for rights and scheduling compliance. | Column approved_timestamp (TIMESTAMP) in scheduling.scheduling_availability_window',
    `blackout_flag` BOOLEAN COMMENT 'Indicates whether a geographic blackout restriction applies to this availability window. When True, the content must be blocked from delivery in the specified territory, typically due to sports rights, retransmission consent, or must-carry obligations. | Column blackout_flag (BOOLEAN) in scheduling.scheduling_availability_window',
    `content_rating` STRING COMMENT 'The audience content rating assigned to the title for this availability window, used to enforce age-gating, parental controls, and COPPA compliance on the platform. Follows MPA and TV Parental Guidelines rating systems. [ENUM-REF-CANDIDATE: G|PG|PG-13|R|NC-17|TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA|NR — 12 candidates stripped; promote to reference product] | Column content_rating (STRING) in scheduling.scheduling_availability_window',
    `coppa_restricted` BOOLEAN COMMENT 'Indicates whether this availability window is subject to COPPA (Childrens Online Privacy Protection Act) restrictions, requiring child-safe delivery mode, restricted data collection, and parental consent enforcement on the platform. | Column coppa_restricted (BOOLEAN) in scheduling.scheduling_availability_window',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in scheduling.scheduling_availability_window',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this availability window record was first created in the system. Used for audit trail, data lineage, and compliance reporting. | Column created_timestamp (TIMESTAMP) in scheduling.scheduling_availability_window',
    `dai_enabled` BOOLEAN COMMENT 'Indicates whether Dynamic Ad Insertion (DAI) is enabled for this availability window. When True, server-side ad insertion is applied during streaming delivery, enabling targeted advertising for AVOD and FAST platform types. | Column dai_enabled (BOOLEAN) in scheduling.scheduling_availability_window',
    `dalet_asset_code` STRING COMMENT 'The asset identifier from Dalet Galaxy Media Asset Management system corresponding to the content title in this availability window. Used to trigger ingest, metadata enrichment, and archive workflows aligned with the window schedule. | Column dalet_asset_code (STRING) in scheduling.scheduling_availability_window. Valid values are `^[A-Z0-9_-]{3,50}$`',
    `drm_required` BOOLEAN COMMENT 'Indicates whether Digital Rights Management (DRM) protection must be enforced for content delivery during this availability window. When True, the Akamai CDN and streaming infrastructure must apply DRM encryption before delivery. | Column drm_required (BOOLEAN) in scheduling.scheduling_availability_window',
    `eidr_code` STRING COMMENT 'The Entertainment Identifier Registry (EIDR) persistent identifier for the content title associated with this window. Enables interoperability with industry partners, distributors, and rights management systems for content identification. | Column eidr_code (STRING) in scheduling.scheduling_availability_window. Valid values are `^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$`',
    `exclusive_flag` BOOLEAN COMMENT 'Indicates whether this availability window grants exclusive rights to the platform for the specified territory and window period. When True, the content must not be made available on any competing platform during this window. | Column exclusive_flag (BOOLEAN) in scheduling.scheduling_availability_window',
    `holdback_flag` BOOLEAN COMMENT 'Indicates whether this window represents a holdback period during which the content is explicitly withheld from the platform or service tier. When True, the content must not be made available regardless of other scheduling parameters. | Column holdback_flag (BOOLEAN) in scheduling.scheduling_availability_window',
    `isan` STRING COMMENT 'The International Standard Audiovisual Number (ISAN) uniquely identifying the audiovisual work associated with this availability window. Used for cross-platform content identification, rights clearance verification, and EIDR reconciliation. | Column isan (STRING) in scheduling.scheduling_availability_window. Valid values are `^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$`',
    `platform_type` STRING COMMENT 'Classification of the distribution platform by monetization model. SVOD = Subscription Video On Demand; AVOD = Advertising-Supported Video On Demand; TVOD = Transactional Video On Demand; FAST = Free Ad-Supported Streaming Television; MVPD = Multichannel Video Programming Distributor; vMVPD = Virtual Multichannel Video Programming Distributor. | Column platform_type (STRING) in scheduling.scheduling_availability_window. Valid values are `SVOD|AVOD|TVOD|FAST|MVPD|vMVPD`',
    `rights_clearance_status` STRING COMMENT 'The current rights clearance verification status for this availability window. cleared means all rights have been confirmed for the platform, territory, and window period; pending means clearance is in progress; blocked means a rights conflict prevents availability; expired means rights have lapsed; not_required means no clearance is needed. | Column rights_clearance_status (STRING) in scheduling.scheduling_availability_window. Valid values are `cleared|pending|blocked|expired|not_required`',
    `rightsline_window_ref` STRING COMMENT 'The native window reference identifier from the Rightsline Rights and Royalties Management system. Used for cross-system reconciliation between the scheduling domain and the rights domain to ensure operational parameters align with contractual rights. | Column rightsline_window_ref (STRING) in scheduling.scheduling_availability_window. Valid values are `^[A-Z0-9_-]{3,50}$`',
    `scte35_cue_enabled` BOOLEAN COMMENT 'Indicates whether SCTE-35 digital program insertion cue markers are enabled for this availability window. When True, SCTE-35 splice points are embedded in the stream to signal ad break opportunities for DAI systems. | Column scte35_cue_enabled (BOOLEAN) in scheduling.scheduling_availability_window',
    `service_tier_code` STRING COMMENT 'Identifies the specific subscription or service tier within the platform on which this window applies (e.g., BASIC, STANDARD, PREMIUM, AD_FREE). Aligns with Zuora subscription plan tiers for entitlement enforcement. | Column service_tier_code (STRING) in scheduling.scheduling_availability_window. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `simulcast_flag` BOOLEAN COMMENT 'Indicates whether this availability window is part of a simulcast configuration, meaning the content is being delivered simultaneously across multiple platforms or channels at the same time. | Column simulcast_flag (BOOLEAN) in scheduling.scheduling_availability_window',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in scheduling.scheduling_availability_window',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in scheduling.scheduling_availability_window',
    `stagger_offset_days` STRING COMMENT 'For staggered windowing strategy, the number of days this platforms availability window is offset relative to the primary release platform or theatrical/linear premiere date. Zero indicates simultaneous release; positive values indicate delayed release. | Column stagger_offset_days (INT) in scheduling.scheduling_availability_window',
    `streaming_protocol` STRING COMMENT 'The adaptive bitrate (ABR) streaming protocol used to deliver the content during this availability window. HLS = HTTP Live Streaming; MPEG-DASH = Dynamic Adaptive Streaming over HTTP; SMOOTH = Microsoft Smooth Streaming; PROGRESSIVE = progressive download. | Column streaming_protocol (STRING) in scheduling.scheduling_availability_window. Valid values are `HLS|MPEG-DASH|HLS_DASH|SMOOTH|PROGRESSIVE`',
    `territory_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code identifying the geographic territory in which this availability window applies. Used to enforce blackout obligations, retransmission consent, and territorial rights restrictions. | Column territory_code (STRING) in scheduling.scheduling_availability_window. Valid values are `^[A-Z]{3}$`',
    `territory_scope` STRING COMMENT 'Broad geographic scope classification for the availability window. worldwide means no territorial restriction; regional means a multi-country region; national means a single country; local means a sub-national market; excluded means the territory is explicitly excluded from availability. | Column territory_scope (STRING) in scheduling.scheduling_availability_window. Valid values are `worldwide|regional|national|local|excluded`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in scheduling.scheduling_availability_window',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this availability window record was last modified. Used for change tracking, incremental data pipeline processing, and audit compliance. | Column updated_timestamp (TIMESTAMP) in scheduling.scheduling_availability_window',
    `window_close_timestamp` TIMESTAMP COMMENT 'The exact date and time (with timezone offset) at which the content title expires and is no longer available on the specified platform. Null indicates an open-ended window with no defined expiry. | Column window_close_timestamp (TIMESTAMP) in scheduling.scheduling_availability_window',
    `window_code` STRING COMMENT 'Externally-known business identifier code for this availability window, used in operational systems such as Rightsline and Dalet Galaxy for cross-system reference and reconciliation. | Column window_code (STRING) in scheduling.scheduling_availability_window. Valid values are `^[A-Z0-9_-]{3,40}$`',
    `window_duration_days` STRING COMMENT 'The total duration of the availability window in days, calculated as the difference between window_close_timestamp and window_open_timestamp. Stored as an operational field for scheduling and reporting purposes. Null for open-ended windows. | Column window_duration_days (INT) in scheduling.scheduling_availability_window',
    `window_notes` STRING COMMENT 'Free-text operational notes or comments associated with this availability window, capturing scheduling rationale, rights exceptions, platform-specific instructions, or escalation context for scheduling operations teams. | Column window_notes (STRING) in scheduling.scheduling_availability_window',
    `window_open_timestamp` TIMESTAMP COMMENT 'The exact date and time (with timezone offset) at which the content title becomes available on the specified platform. This is the principal business event timestamp for the availability window lifecycle. | Column window_open_timestamp (TIMESTAMP) in scheduling.scheduling_availability_window',
    `window_status` STRING COMMENT 'Current lifecycle state of the availability window. draft indicates configuration in progress; scheduled means approved but not yet open; active means currently available to audiences; expired means the window close datetime has passed; cancelled means removed before activation; suspended means temporarily withheld. | Column window_status (STRING) in scheduling.scheduling_availability_window. Valid values are `draft|scheduled|active|expired|cancelled|suspended`',
    `windowing_strategy` STRING COMMENT 'The sequential release strategy applied to this availability window. day_and_date means simultaneous release across all platforms; staggered means delayed release relative to another platform; exclusive means available only on this platform for the window duration; holdback means content is withheld from this platform during the window; rolling means a continuously refreshed window; simultaneous means released at the same time as theatrical or linear broadcast. | Column windowing_strategy (STRING) in scheduling.scheduling_availability_window. Valid values are `day_and_date|staggered|exclusive|holdback|rolling|simultaneous`',
    CONSTRAINT pk_scheduling_availability_window PRIMARY KEY(`scheduling_availability_window_id`)
) COMMENT 'Defines the on-demand programming window configuration for VOD, SVOD, AVOD, and TVOD platforms — specifying when a content title becomes available and when it expires on each platform or service tier. Captures content reference, platform type (SVOD, AVOD, TVOD, FAST), window open datetime, window close datetime, holdback flag, geographic territory, and windowing strategy (day-and-date, staggered, exclusive). Complements rights windows from the rights domain with operational scheduling parameters. | Unity Catalog table: media_broadcasting_ecm.scheduling.scheduling_availability_window | Domain ownership: EPG, program schedule, slots, rundowns, ad breaks, dayparts, simulcast, playout (Ericsson MediaFirst)';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` (
    `channel_carriage_id` BIGINT COMMENT 'Unique surrogate identifier for each channel carriage agreement record. Primary key. | Column channel_carriage_id (BIGINT) in scheduling.channel_carriage',
    `channel_id` BIGINT COMMENT 'Foreign key linking to the linear broadcast channel being carried on the OTT platform | Column channel_id (BIGINT) in scheduling.channel_carriage',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to the OTT platform carrying the channel | Column ott_platform_id (BIGINT) in distribution.channel_carriage',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in scheduling.channel_carriage',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in scheduling.channel_carriage',
    `blackout_rules_override` STRING COMMENT 'Platform-specific geographic blackout rules that override or supplement the channels default blackout_enabled configuration for this OTT platform. Explicitly identified in detection phase relationship data. | Column blackout_rules_override (STRING) in scheduling.channel_carriage',
    `carriage_fee_usd` DECIMAL(18,2) COMMENT 'The per-subscriber monthly carriage fee in US dollars that this OTT platform pays to carry this channel, which may differ from the channels default carriage_fee_usd based on negotiated terms. | Column carriage_fee_usd (DECIMAL(18,4)) in scheduling.channel_carriage',
    `carriage_status` STRING COMMENT 'Current operational status of this channel carriage agreement. active = channel is live on platform, pending = agreement signed but not yet launched, suspended = temporarily unavailable, terminated = agreement ended. | Column carriage_status (STRING) in scheduling.channel_carriage',
    `contract_end_date` DATE COMMENT 'The expiration or renewal date of the commercial carriage agreement. Null indicates evergreen or auto-renewing contract. | Column contract_end_date (DATE) in scheduling.channel_carriage',
    `contract_start_date` DATE COMMENT 'The effective start date of the commercial carriage agreement between the channel and the OTT platform. | Column contract_start_date (DATE) in scheduling.channel_carriage',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in scheduling.channel_carriage',
    `dai_enabled_flag` BOOLEAN COMMENT 'Indicates whether Dynamic Ad Insertion is enabled for this channel on this specific OTT platform, overriding the channels default dai_enabled setting. Explicitly identified in detection phase relationship data. | Column dai_enabled_flag (BOOLEAN) in scheduling.channel_carriage',
    `epg_sync_enabled` BOOLEAN COMMENT 'Indicates whether Electronic Program Guide data for this channel is synchronized to this OTT platforms EPG system. Explicitly identified in detection phase relationship data. | Column epg_sync_enabled (BOOLEAN) in scheduling.channel_carriage',
    `platform_channel_number` STRING COMMENT 'The logical channel number assigned to this channel specifically on this OTT platform, which may differ from the channels broadcast logical_channel_number. Explicitly identified in detection phase relationship data. | Column platform_channel_number (INT) in scheduling.channel_carriage',
    `platform_display_name` STRING COMMENT 'The branded channel name displayed to subscribers on this specific OTT platform, which may differ from the channels network_name for branding or licensing reasons. Explicitly identified in detection phase relationship data. | Column platform_display_name (STRING) in scheduling.channel_carriage',
    `priority_rank` STRING COMMENT 'The display priority or prominence ranking assigned to this channel within this OTT platforms channel lineup, used for UI ordering and recommendation algorithms. Explicitly identified in detection phase relationship data. | Column priority_rank (INT) in scheduling.channel_carriage',
    `simulcast_enabled` BOOLEAN COMMENT 'Indicates whether this channel is configured for simultaneous multi-platform broadcast (simulcast). When true, the channels linear feed is distributed concurrently across broadcast, cable, and OTT/streaming platforms. [Moved from channel: This boolean flag on the channel product indicates whether the channel is configured for simulcast, but the actual simulcast configuration is platform-specific. The flag should remain on channel as a capability indicator, but the actual simulcast implementation details (start/end dates, platform-specific settings) belong in the carriage association. However, upon review, this attribute can remain on channel as a general capability flag - no move required.] | Column simulcast_enabled (BOOLEAN) in scheduling.channel_carriage',
    `simulcast_end_date` DATE COMMENT 'The date on which this channel ceased or will cease simulcast distribution on this OTT platform. Null indicates ongoing carriage. Explicitly identified in detection phase relationship data. | Column simulcast_end_date (DATE) in scheduling.channel_carriage',
    `simulcast_start_date` DATE COMMENT 'The date on which this channel began or will begin simulcast distribution on this OTT platform. Explicitly identified in detection phase relationship data. | Column simulcast_start_date (DATE) in scheduling.channel_carriage',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in scheduling.channel_carriage',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in scheduling.channel_carriage',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in scheduling.channel_carriage',
    CONSTRAINT pk_channel_carriage PRIMARY KEY(`channel_carriage_id`)
) COMMENT 'This association product represents the carriage contract between a linear broadcast channel and an OTT platform. It captures the commercial and technical terms under which a specific channel is distributed on a specific OTT platform. Each record links one channel to one OTT platform with platform-specific configurations including simulcast timing, channel positioning, branding overrides, ad insertion rules, and blackout policies that exist only in the context of this distribution relationship.. Existence Justification: In media broadcasting operations, linear broadcast channels are distributed across multiple OTT platforms simultaneously (e.g., CNN appears on Hulu, YouTube TV, Peacock, Sling), and each OTT platform carries dozens to hundreds of channels in its lineup. Each channel-platform pairing requires a distinct carriage agreement with platform-specific commercial terms (carriage fees, contract dates) and technical configurations (channel numbering, branding, DAI settings, blackout overrides, EPG sync). The business actively manages these carriage agreements as operational contracts. | Unity Catalog table: media_broadcasting_ecm.scheduling.channel_carriage | Domain ownership: EPG, program schedule, slots, rundowns, ad breaks, dayparts, simulcast, playout (Ericsson MediaFirst)';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` (
    `channel_allocation_id` BIGINT COMMENT 'Unique identifier for this channel allocation record. Primary key. | Column channel_allocation_id (BIGINT) in scheduling.channel_allocation',
    `sales_campaign_id` BIGINT COMMENT 'Foreign key linking to the advertising campaign being allocated to this channel | Column campaign_id (BIGINT) in sales.channel_allocation',
    `channel_id` BIGINT COMMENT 'Foreign key linking to the broadcast channel where campaign ads will air | Column channel_id (BIGINT) in scheduling.channel_allocation',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in scheduling.channel_allocation',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in scheduling.channel_allocation',
    `actual_grp_delivered` DECIMAL(18,2) COMMENT 'The actual Gross Rating Points delivered on this channel for this campaign as of the last measurement. Compared against target_grp to assess delivery performance. | Column actual_grp_delivered (DECIMAL(10,2)) in scheduling.channel_allocation',
    `actual_spots_aired` STRING COMMENT 'The actual number of ad spots that have aired on this channel for this campaign as of the last measurement. Compared against spot_count to track fulfillment. | Column actual_spots_aired (INT) in scheduling.channel_allocation',
    `allocated_budget_amount` DECIMAL(18,2) COMMENT 'The portion of the total campaign budget allocated to this specific channel. Sum of all channel allocations should equal campaign total_budget_amount. | Column allocated_budget_amount (DECIMAL(18,2)) in scheduling.channel_allocation',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in scheduling.channel_allocation',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel allocation record was first created in the system. | Column created_timestamp (TIMESTAMP) in scheduling.channel_allocation',
    `daypart_mix` STRING COMMENT 'The distribution of spots across dayparts (e.g., Prime: 40%, Early Fringe: 30%, Late Night: 30%) for this channel allocation. Defines when ads will air. | Column daypart_mix (STRING) in scheduling.channel_allocation',
    `delivery_status` STRING COMMENT 'Current fulfillment status of this channel allocation. Tracks whether the contracted spots and GRPs are being delivered as planned. | Column delivery_status (STRING) in scheduling.channel_allocation',
    `flight_end_date` DATE COMMENT 'The date when ad spots for this campaign stop airing on this channel. Must fall within campaign_start_date and campaign_end_date. | Column flight_end_date (DATE) in scheduling.channel_allocation',
    `flight_start_date` DATE COMMENT 'The date when ad spots for this campaign begin airing on this channel. Must fall within campaign_start_date and campaign_end_date. | Column flight_start_date (DATE) in scheduling.channel_allocation',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel allocation record was last modified. | Column modified_timestamp (TIMESTAMP) in scheduling.channel_allocation',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in scheduling.channel_allocation',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in scheduling.channel_allocation',
    `spot_count` STRING COMMENT 'The total number of ad spots contracted to air on this channel for this campaign during the flight period. | Column spot_count (INT) in scheduling.channel_allocation',
    `target_grp` DECIMAL(18,2) COMMENT 'Target Gross Rating Points allocated to this channel for this campaign. Represents the reach and frequency goals specific to this channel allocation. | Column target_grp (DECIMAL(10,2)) in scheduling.channel_allocation',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in scheduling.channel_allocation',
    CONSTRAINT pk_channel_allocation PRIMARY KEY(`channel_allocation_id`)
) COMMENT 'This association product represents the media buying allocation between a broadcast channel and an advertising campaign. It captures the strategic distribution of campaign budget, GRP targets, and spot inventory across channels. Each record links one channel to one campaign with flight dates, allocated budget, target GRPs, spot counts, and delivery tracking that exist only in the context of this specific channel-campaign pairing.. Existence Justification: In media broadcasting operations, advertising campaigns are strategically distributed across multiple broadcast channels to reach target audiences, and each channel simultaneously carries multiple campaigns from different advertisers. Media buyers actively manage channel allocations as distinct planning and fulfillment entities, tracking budget distribution, GRP targets, flight schedules, spot counts, and delivery performance for each campaign-channel pairing. | Unity Catalog table: media_broadcasting_ecm.scheduling.channel_allocation | Domain ownership: EPG, program schedule, slots, rundowns, ad breaks, dayparts, simulcast, playout (Ericsson MediaFirst)';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` (
    `channel_license_id` BIGINT COMMENT 'Unique surrogate identifier for each channel license record. Primary key for the association. | Column channel_license_id (BIGINT) in scheduling.channel_license',
    `channel_id` BIGINT COMMENT 'Foreign key linking to the linear broadcast channel receiving the license | Column channel_id (BIGINT) in scheduling.channel_license',
    `title_id` BIGINT COMMENT 'Foreign key linking to the content title being licensed for broadcast | Column title_id (BIGINT) in content.channel_license',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in scheduling.channel_license',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in scheduling.channel_license',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in scheduling.channel_license',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this license record was created in the broadcast rights management system. | Column created_timestamp (TIMESTAMP) in scheduling.channel_license',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this license grants exclusive broadcast rights to this channel within the specified territory, preventing other channels from airing the same title during the license window. | Column exclusivity_flag (BOOLEAN) in scheduling.channel_license',
    `license_end_date` DATE COMMENT 'The expiration date of the broadcast license window. Defines when the channel must cease airing the title unless the license is renewed. | Column license_end_date (DATE) in scheduling.channel_license',
    `license_fee_usd` DECIMAL(18,2) COMMENT 'The total licensing fee paid by the channel to acquire broadcast rights for this title, denominated in US dollars. Used for rights cost allocation and profitability analysis. | Column license_fee_usd (DECIMAL(18,4)) in scheduling.channel_license',
    `license_start_date` DATE COMMENT 'The effective start date of the broadcast license window. Defines when the channel is authorized to begin airing the title. | Column license_start_date (DATE) in scheduling.channel_license',
    `license_status` STRING COMMENT 'Current operational status of the license. Active licenses are available for scheduling; expired licenses have passed their end date; suspended licenses are temporarily unavailable; pending licenses are awaiting activation. | Column license_status (STRING) in scheduling.channel_license',
    `runs_allowed` STRING COMMENT 'The maximum number of times the channel is permitted to broadcast this title under this license agreement. Null indicates unlimited runs. | Column runs_allowed (INT) in scheduling.channel_license',
    `runs_consumed` STRING COMMENT 'The cumulative count of times this title has been broadcast on this channel under this license. Incremented by playout automation after each airing. Used to enforce runs_allowed limits. | Column runs_consumed (INT) in scheduling.channel_license',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in scheduling.channel_license',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in scheduling.channel_license',
    `territory_code` STRING COMMENT 'ISO 3166-1 alpha-2 or alpha-3 country or region code defining the geographic territory where this license is valid. Enforces territorial broadcast restrictions. | Column territory_code (STRING) in scheduling.channel_license',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in scheduling.channel_license',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this license record was last modified, typically when runs_consumed is incremented or license_status is changed. | Column updated_timestamp (TIMESTAMP) in scheduling.channel_license',
    CONSTRAINT pk_channel_license PRIMARY KEY(`channel_license_id`)
) COMMENT 'This association product represents the broadcast rights grant between a content title and a linear channel. It captures the licensing agreement that authorizes a specific channel to broadcast a specific title within defined temporal, territorial, and usage constraints. Each record links one title to one channel with attributes that exist only in the context of this licensing relationship—including license windows, exclusivity terms, geographic restrictions, and run limits that govern how and when the content may be aired.. Existence Justification: In broadcast operations, content titles are licensed to multiple linear channels simultaneously under separate rights agreements, and each channel carries a portfolio of many titles under distinct license terms. The licensing relationship is an operational business entity actively managed by rights and scheduling teams—each license has its own temporal window, territorial restrictions, exclusivity terms, run limits, and financial terms that cannot be modeled as attributes of either the title or the channel alone. This is the core Channel License or Broadcast Rights Grant business concept. | Unity Catalog table: media_broadcasting_ecm.scheduling.channel_license | Domain ownership: EPG, program schedule, slots, rundowns, ad breaks, dayparts, simulcast, playout (Ericsson MediaFirst)';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` (
    `channel_asset_playout_id` BIGINT COMMENT 'Unique identifier for this channel-asset playout configuration record. Primary key. | Column channel_asset_playout_id (BIGINT) in scheduling.channel_asset_playout',
    `channel_id` BIGINT COMMENT 'Foreign key linking to the broadcast channel that will air this media asset | Column channel_id (BIGINT) in scheduling.channel_asset_playout',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to the media asset configured for playout on this channel | Column media_asset_id (BIGINT) in mediaasset.channel_asset_playout',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in scheduling.channel_asset_playout',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in scheduling.channel_asset_playout',
    `active_from_date` DATE COMMENT 'Date when this asset becomes available for playout on this channel. Supports embargo management and scheduled content releases. | Column active_from_date (DATE) in scheduling.channel_asset_playout',
    `active_to_date` DATE COMMENT 'Date when this asset is no longer available for playout on this channel. Supports license expiration, seasonal content rotation, and rights window management. | Column active_to_date (DATE) in scheduling.channel_asset_playout',
    `air_count` STRING COMMENT 'Total number of times this asset has been broadcast on this channel. Used for rights management (license play limits), rotation analytics, and content performance tracking. | Column air_count (INT) in scheduling.channel_asset_playout',
    `backup_asset_flag` BOOLEAN COMMENT 'Indicates whether this asset serves as a backup/filler for this channel. Backup assets are used when primary scheduled content is unavailable or to fill unscheduled time slots. | Column backup_asset_flag (BOOLEAN) in scheduling.channel_asset_playout',
    `channel_specific_version` STRING COMMENT 'Version identifier for channel-specific edits or adaptations of the media asset (e.g., regional edit, censored version, time-compressed version). Same base asset may have different versions per channel based on content rating, market, or time slot requirements. | Column channel_specific_version (STRING) in scheduling.channel_asset_playout',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in scheduling.channel_asset_playout',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel-asset playout configuration was created in the system. | Column created_timestamp (TIMESTAMP) in scheduling.channel_asset_playout',
    `last_aired_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent playout of this asset on this channel. Used for rotation management to ensure content freshness and avoid excessive repetition. | Column last_aired_timestamp (TIMESTAMP) in scheduling.channel_asset_playout',
    `max_plays_per_day` STRING COMMENT 'Maximum number of times this asset may be broadcast on this channel within a 24-hour period. Used to prevent over-rotation and maintain content variety. | Column max_plays_per_day (INT) in scheduling.channel_asset_playout',
    `min_hours_between_plays` STRING COMMENT 'Minimum number of hours that must elapse between consecutive airings of this asset on this channel. Prevents back-to-back repetition. | Column min_hours_between_plays (INT) in scheduling.channel_asset_playout',
    `playout_priority` STRING COMMENT 'Channel-specific priority ranking for this asset in automated playout rotation. Lower numbers indicate higher priority. Used by Ericsson MediaFirst to select assets when multiple options are available. | Column playout_priority (INT) in scheduling.channel_asset_playout',
    `playout_status` STRING COMMENT 'Current operational status of this channel-asset playout configuration. Active=available for playout, Suspended=temporarily disabled, Expired=past active_to_date, Pending=before active_from_date. | Column playout_status (STRING) in scheduling.channel_asset_playout',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in scheduling.channel_asset_playout',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in scheduling.channel_asset_playout',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in scheduling.channel_asset_playout',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this channel-asset playout configuration. | Column updated_timestamp (TIMESTAMP) in scheduling.channel_asset_playout',
    CONSTRAINT pk_channel_asset_playout PRIMARY KEY(`channel_asset_playout_id`)
) COMMENT 'This association product represents the playout configuration between channel and media_asset. It captures channel-specific asset management for broadcast automation, including playout priority, backup designation, versioning, air history, and rotation scheduling. Each record links one channel to one media_asset with operational metadata that exists only in the context of this channel-asset relationship for Ericsson MediaFirst playout automation.. Existence Justification: In broadcast operations, the same media asset (e.g., syndicated show master, promotional spot, filler content) is licensed and configured for playout across multiple channels, and each channel maintains a library of multiple assets in rotation. The relationship is actively managed by broadcast operations teams who configure channel-specific playout rules, priority rankings, rotation schedules, and air history tracking for each channel-asset combination in the Ericsson MediaFirst playout automation system. | Unity Catalog table: media_broadcasting_ecm.scheduling.channel_asset_playout | Domain ownership: EPG, program schedule, slots, rundowns, ad breaks, dayparts, simulcast, playout (Ericsson MediaFirst)';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` (
    `channel_abr_assignment_id` BIGINT COMMENT 'Unique surrogate identifier for each channel-to-ABR-profile assignment record. Primary key. | Column channel_abr_assignment_id (BIGINT) in scheduling.channel_abr_assignment',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to the ABR encoding ladder profile being assigned to the channel | Column abr_profile_id (BIGINT) in distribution.channel_abr_assignment',
    `channel_id` BIGINT COMMENT 'Foreign key linking to the broadcast channel receiving the ABR profile assignment | Column channel_id (BIGINT) in scheduling.channel_abr_assignment',
    `employee_id` BIGINT COMMENT 'Identifier of the broadcast operations or encoding engineer who created this ABR profile assignment. Used for audit trail and operational accountability. | Column employee_id (BIGINT) in workforce.channel_abr_assignment',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in scheduling.channel_abr_assignment',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in scheduling.channel_abr_assignment',
    `assignment_reason` STRING COMMENT 'Free-text explanation of why this ABR profile was assigned to this channel (e.g., Upgraded to 4K for premium sports content, Cost optimization - reduced bitrate ladder, New HDR support for flagship channel). | Column assignment_reason (STRING) in scheduling.channel_abr_assignment',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the assignment. Active assignments are used in production encoding; scheduled assignments will become active at effective_start_date; testing assignments are used in pre-production validation. | Column assignment_status (STRING) in scheduling.channel_abr_assignment',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in scheduling.channel_abr_assignment',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was created in the system. | Column created_timestamp (TIMESTAMP) in scheduling.channel_abr_assignment',
    `device_class_override` STRING COMMENT 'Optional device class override that restricts this ABR profile assignment to specific device types, overriding the profiles default target_device_class. Used when a channel requires different encoding strategies per device class (e.g., mobile-optimized profile for cellular delivery, 4K profile for smart TVs). | Column device_class_override (STRING) in scheduling.channel_abr_assignment',
    `effective_end_date` TIMESTAMP COMMENT 'Timestamp when this ABR profile assignment expires or is superseded by a new assignment. Null indicates the assignment is currently active with no planned end date. | Column effective_end_date (TIMESTAMP) in scheduling.channel_abr_assignment',
    `effective_start_date` TIMESTAMP COMMENT 'Timestamp when this ABR profile assignment becomes active for the channel. Used by the encoding farm to determine which profile to apply for transcode jobs initiated after this date. | Column effective_start_date (TIMESTAMP) in scheduling.channel_abr_assignment',
    `encoding_cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated monthly encoding cost in USD for this channel-profile assignment, calculated based on channel broadcast hours, ABR profile complexity (rendition count, codec), and encoding farm pricing. Used for cost optimization and budget planning. | Column encoding_cost_estimate_usd (DECIMAL(18,4)) in scheduling.channel_abr_assignment',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was last updated. | Column last_modified_timestamp (TIMESTAMP) in scheduling.channel_abr_assignment',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the priority or preference order of this ABR profile for the channel when multiple profiles are assigned simultaneously (e.g., primary HD profile = 1, fallback SD profile = 2). Lower numbers indicate higher priority. | Column priority_rank (INT) in scheduling.channel_abr_assignment',
    `qos_tier` STRING COMMENT 'Quality of Service tier designation for this specific channel-profile assignment, which may differ from the ABR profiles default qos_tier. Allows per-channel QoS tuning based on content importance, audience demographics, or commercial agreements. | Column qos_tier (STRING) in scheduling.channel_abr_assignment',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in scheduling.channel_abr_assignment',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in scheduling.channel_abr_assignment',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in scheduling.channel_abr_assignment',
    CONSTRAINT pk_channel_abr_assignment PRIMARY KEY(`channel_abr_assignment_id`)
) COMMENT 'This association product represents the operational assignment of Adaptive Bitrate encoding profiles to broadcast channels for multi-platform streaming delivery. It captures the technical configuration decisions made by broadcast operations teams to optimize encoding costs and viewer Quality of Experience (QoE) across different device classes and quality tiers. Each record links one channel to one ABR profile with effective dates, priority rankings, and device-specific overrides that exist only in the context of this streaming delivery configuration.. Existence Justification: In broadcast operations, a single channel requires multiple ABR profiles to serve different device classes (mobile, tablet, smart TV, desktop) and quality tiers (SD, HD, 4K, HDR) simultaneously. Conversely, a single ABR profile (e.g., Standard HD H.264) is reused across dozens or hundreds of channels to standardize encoding and reduce operational complexity. Broadcast operations teams actively manage these assignments with effective dates, priority rankings, device overrides, and cost estimates as a core operational process. | Unity Catalog table: media_broadcasting_ecm.scheduling.channel_abr_assignment | Domain ownership: EPG, program schedule, slots, rundowns, ad breaks, dayparts, simulcast, playout (Ericsson MediaFirst)';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` (
    `channel_targeting_id` BIGINT COMMENT 'Unique surrogate identifier for each channel-demographic targeting record. Primary key. | Column channel_targeting_id (BIGINT) in scheduling.channel_targeting',
    `channel_id` BIGINT COMMENT 'Foreign key linking to the broadcast channel being targeted | Column channel_id (BIGINT) in scheduling.channel_targeting',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to the demographic segment being targeted by this channel | Column demographic_segment_id (BIGINT) in audience.channel_targeting',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in scheduling.channel_targeting',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in scheduling.channel_targeting',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in scheduling.channel_targeting',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel targeting record was created in the system. | Column created_timestamp (TIMESTAMP) in scheduling.channel_targeting',
    `daypart_strategy` STRING COMMENT 'Comma-separated list of dayparts where this channel actively targets this demographic segment (e.g., Prime Time, Late Fringe, Early Morning). Drives programming and ad inventory allocation decisions. | Column daypart_strategy (STRING) in scheduling.channel_targeting',
    `effective_from` DATE COMMENT 'The date from which this channel-demographic targeting strategy and rate structure became effective. Typically aligned with broadcast season or upfront period start. | Column effective_from (DATE) in scheduling.channel_targeting',
    `effective_until` DATE COMMENT 'The date until which this channel-demographic targeting strategy and rate structure remains effective. Null indicates current/ongoing targeting. Used to track historical targeting strategy changes. | Column effective_until (DATE) in scheduling.channel_targeting',
    `guaranteed_grp` DECIMAL(18,2) COMMENT 'The guaranteed Gross Rating Points (GRP) committed to advertisers for this channel-demographic pairing during the upfront sales period. Drives make-good obligations if underdelivered. | Column guaranteed_grp (DECIMAL(10,2)) in scheduling.channel_targeting',
    `is_primary_target` BOOLEAN COMMENT 'Indicates whether this demographic segment is designated as a primary target demographic for this channel (vs. secondary or tertiary). Primary targets drive programming decisions and receive highest sales priority. | Column is_primary_target (BOOLEAN) in scheduling.channel_targeting',
    `rate_multiplier` DECIMAL(18,2) COMMENT 'The pricing multiplier applied to the base CPM rate for this demographic segment on this channel. Reflects the relative value and scarcity of this audience on this specific channel (e.g., 1.25 for premium demos, 0.80 for lower-value segments). | Column rate_multiplier (DECIMAL(6,4)) in scheduling.channel_targeting',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in scheduling.channel_targeting',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in scheduling.channel_targeting',
    `target_rating` DECIMAL(18,2) COMMENT 'The target rating point (percentage of demographic universe) that this channel aims to achieve for this specific demographic segment. Used in upfront guarantees and programming performance evaluation. | Column target_rating (DECIMAL(5,2)) in scheduling.channel_targeting',
    `targeting_status` STRING COMMENT 'Current lifecycle status of this channel-demographic targeting relationship. Active indicates current targeting, Planned for future seasons, Suspended for temporary holds, Discontinued for ended strategies. | Column targeting_status (STRING) in scheduling.channel_targeting',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in scheduling.channel_targeting',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel targeting record was last modified. | Column updated_timestamp (TIMESTAMP) in scheduling.channel_targeting',
    CONSTRAINT pk_channel_targeting PRIMARY KEY(`channel_targeting_id`)
) COMMENT 'This association product represents the targeting strategy between channel and demographic_segment. It captures the commercial and programming relationship where each channel defines segment-specific rate cards, GRP guarantees, and daypart strategies for ad sales and upfront negotiations. Each record links one channel to one demographic segment with pricing, performance targets, and effectiveness metrics that exist only in the context of this channel-segment pairing.. Existence Justification: In media broadcasting operations, channels actively define and manage targeting strategies for multiple demographic segments simultaneously, with each channel-segment pairing having distinct rate cards, GRP guarantees, and daypart strategies used in upfront negotiations and ad sales. Conversely, each demographic segment (e.g., A18-49, W25-54) is targeted by multiple channels with different commercial terms and performance commitments. This is a core operational relationship managed by ad sales and programming teams, not an analytical correlation. | Unity Catalog table: media_broadcasting_ecm.scheduling.channel_targeting | Domain ownership: EPG, program schedule, slots, rundowns, ad breaks, dayparts, simulcast, playout (Ericsson MediaFirst)';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` (
    `daypart_assignment_id` BIGINT COMMENT 'Unique surrogate identifier for this daypart assignment record. Primary key. | Column daypart_assignment_id (BIGINT) in scheduling.daypart_assignment',
    `channel_id` BIGINT COMMENT 'Channel for the daypart assignment',
    `employee_id` BIGINT COMMENT 'Employee who approved the assignment',
    `daypart_backup_employee_id` BIGINT COMMENT 'Backup employee for coverage',
    `daypart_employee_id` BIGINT COMMENT 'Foreign key to workforce.employee - identifies which employee is assigned to this daypart | Column employee_id (BIGINT) in workforce.daypart_assignment',
    `daypart_supervisor_employee_id` BIGINT COMMENT 'Supervisor for this assignment',
    `daypart_id` BIGINT COMMENT 'Foreign key to scheduling.daypart - identifies which broadcast daypart this assignment covers | Column scheduling_daypart_id (BIGINT) in scheduling.daypart_assignment',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in scheduling.daypart_assignment',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in scheduling.daypart_assignment',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp of assignment approval',
    `approved_by` STRING COMMENT 'User who approved the assignment',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp of approval',
    `assignment_end_date` DATE COMMENT 'The date this employee stopped covering this daypart (null for active assignments). Used for tracking assignment history and staffing transitions. This attribute was explicitly identified in the detection phase relationship data. | Column assignment_end_date (DATE) in scheduling.daypart_assignment',
    `assignment_start_date` DATE COMMENT 'The date this employee began covering this daypart in this role. Used for tracking assignment history and calculating tenure. This attribute was explicitly identified in the detection phase relationship data. | Column assignment_start_date (DATE) in scheduling.daypart_assignment',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this daypart assignment. active = currently scheduled, on_leave = temporarily suspended, temporary = short-term coverage, ended = assignment completed. | Column assignment_status (STRING) in scheduling.daypart_assignment',
    `assignment_type` STRING COMMENT 'Type of assignment (primary, backup, float)',
    `certification_required` STRING COMMENT 'Required certifications for the role',
    `certification_required_flag` BOOLEAN COMMENT 'Whether certification is required',
    `coverage_percentage` DECIMAL(18,2) COMMENT 'Percentage of daypart covered by assignment',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in scheduling.daypart_assignment',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was created in the system | Column created_timestamp (TIMESTAMP) in scheduling.daypart_assignment',
    `days_of_week` STRING COMMENT 'Pipe-delimited list of days this employee covers this daypart (e.g., MON|TUE|WED or SAT|SUN). Allows for split-week scheduling patterns common in 24/7 broadcast operations. This attribute was explicitly identified in the detection phase relationship data. | Column days_of_week (STRING) in scheduling.daypart_assignment',
    `effective_end_date` DATE COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `max_hours_per_week` DECIMAL(18,2) COMMENT 'Maximum hours per week for this assignment',
    `notes` STRING COMMENT 'Additional notes for the assignment',
    `override_allowed_flag` BOOLEAN COMMENT 'Whether assignment can be overridden',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Whether assignment is overtime eligible',
    `primary_daypart_flag` BOOLEAN COMMENT 'Indicates whether this is the employees primary daypart assignment (true) or a secondary/backup assignment (false). Used for scheduling priority and resource allocation. This attribute was explicitly identified in the detection phase relationship data. | Column primary_daypart_flag (BOOLEAN) in scheduling.daypart_assignment',
    `priority_level` STRING COMMENT 'Priority level for scheduling conflicts',
    `priority_rank` STRING COMMENT 'Priority ranking for scheduling conflicts',
    `rate_multiplier` DECIMAL(18,2) COMMENT '',
    `remote_eligible_flag` BOOLEAN COMMENT 'Whether assignment can be done remotely',
    `rotation_sequence` STRING COMMENT 'Sequence number in rotation schedule',
    `shift_role` STRING COMMENT 'The operational role the employee performs during this daypart assignment. Examples: producer, director, technical_director, master_control_operator, traffic_coordinator. This attribute was explicitly identified in the detection phase relationship data. | Column shift_role (STRING) in scheduling.daypart_assignment',
    `skill_requirements` STRING COMMENT 'Required skills for the assignment',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in scheduling.daypart_assignment',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in scheduling.daypart_assignment',
    `target_demographic` STRING COMMENT '',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in scheduling.daypart_assignment',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was last modified | Column updated_timestamp (TIMESTAMP) in scheduling.daypart_assignment',
    CONSTRAINT pk_daypart_assignment PRIMARY KEY(`daypart_assignment_id`)
) COMMENT 'This association product represents the operational assignment of employees to broadcast daypart coverage responsibilities. It captures which employees are scheduled to work during which dayparts, including their role during that time period, the days of week they cover, and whether this is their primary daypart responsibility. Each record links one daypart to one employee with attributes that exist only in the context of this staffing assignment.. Existence Justification: In 24/7 broadcast operations, employees are assigned to cover multiple dayparts (e.g., a master control operator may cover Early Morning MON-WED and Late Fringe THU-FRI), and each daypart requires multiple employees in different operational roles (producer, technical director, audio engineer, traffic coordinator, etc.). The business actively manages these staffing assignments with specific roles, day-of-week patterns, and time periods. This is an operational workforce scheduling relationship, not an analytical correlation. | Unity Catalog table: media_broadcasting_ecm.scheduling.daypart_assignment | Domain ownership: EPG, program schedule, slots, rundowns, ad breaks, dayparts, simulcast, playout (Ericsson MediaFirst)';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` (
    `schedule_status_ref_id` BIGINT COMMENT 'Column schedule_status_ref_id in media_broadcasting.scheduling.schedule_status_ref',
    `program_schedule_id` BIGINT COMMENT '',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in scheduling.schedule_status_ref',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in scheduling.schedule_status_ref',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in scheduling.schedule_status_ref',
    `created_timestamp` TIMESTAMP COMMENT 'Column created_timestamp in media_broadcasting.scheduling.schedule_status_ref',
    `is_active_flag` BOOLEAN COMMENT 'Column is_active_flag in media_broadcasting.scheduling.schedule_status_ref',
    `sort_order` STRING COMMENT 'Column sort_order in media_broadcasting.scheduling.schedule_status_ref',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in scheduling.schedule_status_ref',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in scheduling.schedule_status_ref',
    `status_code` STRING COMMENT 'Column status_code in media_broadcasting.scheduling.schedule_status_ref',
    `status_description` STRING COMMENT 'Column status_description in media_broadcasting.scheduling.schedule_status_ref',
    `status_name` STRING COMMENT 'Column status_name in media_broadcasting.scheduling.schedule_status_ref',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in scheduling.schedule_status_ref',
    `updated_timestamp` TIMESTAMP COMMENT 'Column updated_timestamp in media_broadcasting.scheduling.schedule_status_ref',
    CONSTRAINT pk_schedule_status_ref PRIMARY KEY(`schedule_status_ref_id`)
) COMMENT 'Reference table for schedule slot statuses | Unity Catalog table: media_broadcasting_ecm.scheduling.schedule_status_ref';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_network_clearance` (
    `scheduling_network_clearance_id` BIGINT COMMENT 'Primary key for network clearance',
    `affiliate_station_id` BIGINT COMMENT 'FK to affiliate station',
    `employee_id` BIGINT COMMENT 'Employee who confirmed clearance',
    `program_schedule_id` BIGINT COMMENT 'FK to program schedule',
    `title_id` BIGINT COMMENT 'FK to content title',
    `clearance_confirmed_timestamp` TIMESTAMP COMMENT 'When clearance was confirmed',
    `clearance_status` STRING COMMENT 'Clearance status (cleared, preempted, delayed)',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `delayed_air_date` DATE COMMENT 'Rescheduled air date if delayed',
    `delayed_air_time` TIMESTAMP COMMENT 'Rescheduled air time if delayed',
    `makegood_required_flag` BOOLEAN COMMENT 'Whether makegood is required',
    `network_notification_sent_flag` BOOLEAN COMMENT 'Whether network was notified',
    `notes` STRING COMMENT 'Additional notes',
    `preemption_reason` STRING COMMENT 'Reason for preemption if applicable',
    `replacement_content` STRING COMMENT 'Content aired instead if preempted',
    `scheduled_air_date` DATE COMMENT 'Originally scheduled air date',
    `scheduled_air_time` TIMESTAMP COMMENT 'Originally scheduled air time',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_scheduling_network_clearance PRIMARY KEY(`scheduling_network_clearance_id`)
) COMMENT 'Tracks affiliate station clearance decisions for network programming including preemptions and make-goods';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_local_avail_inventory` (
    `scheduling_local_avail_inventory_id` BIGINT COMMENT 'Primary key for local avail inventory',
    `ad_break_id` BIGINT COMMENT 'FK to ad break',
    `affiliate_station_id` BIGINT COMMENT 'FK to affiliate station',
    `daypart_id` BIGINT COMMENT 'FK to daypart',
    `program_schedule_id` BIGINT COMMENT 'FK to program schedule',
    `distribution_local_avail_inventory_id` BIGINT COMMENT '',
    `avail_date` DATE COMMENT 'Date of availability',
    `avail_duration_seconds` STRING COMMENT 'Total avail duration in seconds',
    `avail_end_time` TIMESTAMP COMMENT 'End time of avail window',
    `avail_start_time` TIMESTAMP COMMENT 'Start time of avail window',
    `avail_type` STRING COMMENT 'Type (local_break, network_adjacency, local_news)',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `estimated_impressions` BIGINT COMMENT 'Estimated impressions for this avail',
    `estimated_rating` DECIMAL(18,2) COMMENT 'Estimated rating',
    `inventory_status` STRING COMMENT 'Status (available, partially_sold, sold_out, held)',
    `rate_card_rate` DECIMAL(18,2) COMMENT 'Rate card rate per unit',
    `rate_currency_code` STRING COMMENT 'Currency code for rate',
    `remaining_units` STRING COMMENT 'Number of units remaining',
    `sellout_percentage` DECIMAL(18,2) COMMENT 'Percentage of inventory sold',
    `sold_units` STRING COMMENT 'Number of units sold',
    `total_units` STRING COMMENT 'Total ad units available',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_scheduling_local_avail_inventory PRIMARY KEY(`scheduling_local_avail_inventory_id`)
) COMMENT 'Local advertising avail inventory for affiliate stations tracking available local ad slots within network programming.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_scheduling_availability_window_id` FOREIGN KEY (`scheduling_availability_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window`(`scheduling_availability_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_schedule_status_ref_id` FOREIGN KEY (`schedule_status_ref_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref`(`schedule_status_ref_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_scte_marker_id` FOREIGN KEY (`scte_marker_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker`(`scte_marker_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ADD CONSTRAINT `fk_scheduling_scte_marker_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ADD CONSTRAINT `fk_scheduling_scte_marker_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ADD CONSTRAINT `fk_scheduling_scte_marker_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ADD CONSTRAINT `fk_scheduling_scte_marker_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_source_channel_id` FOREIGN KEY (`source_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_target_channel_id` FOREIGN KEY (`target_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ADD CONSTRAINT `fk_scheduling_scheduling_blackout_rule_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_scte_marker_id` FOREIGN KEY (`scte_marker_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker`(`scte_marker_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_program_rundown_id` FOREIGN KEY (`program_rundown_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown`(`program_rundown_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ADD CONSTRAINT `fk_scheduling_channel_carriage_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ADD CONSTRAINT `fk_scheduling_channel_allocation_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ADD CONSTRAINT `fk_scheduling_channel_license_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ADD CONSTRAINT `fk_scheduling_channel_asset_playout_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ADD CONSTRAINT `fk_scheduling_channel_abr_assignment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ADD CONSTRAINT `fk_scheduling_channel_targeting_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ADD CONSTRAINT `fk_scheduling_daypart_assignment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ADD CONSTRAINT `fk_scheduling_daypart_assignment_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ADD CONSTRAINT `fk_scheduling_schedule_status_ref_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_network_clearance` ADD CONSTRAINT `fk_scheduling_scheduling_network_clearance_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_local_avail_inventory` ADD CONSTRAINT `fk_scheduling_scheduling_local_avail_inventory_ad_break_id` FOREIGN KEY (`ad_break_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`ad_break`(`ad_break_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_local_avail_inventory` ADD CONSTRAINT `fk_scheduling_scheduling_local_avail_inventory_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_local_avail_inventory` ADD CONSTRAINT `fk_scheduling_scheduling_local_avail_inventory_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`scheduling` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`scheduling` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` SET TAGS ('dbx_subdomain' = 'channel_programming');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` SET TAGS ('dbx_data_type' = 'dimension_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.scheduling.channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.scheduling.channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` SET TAGS ('dbx_workload_mode' = 'Linear');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` SET TAGS ('dbx_protocols' = 'ATSC/DVB/QAM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.billing_account_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.billing_account_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.broadcast_facility_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.broadcast_facility_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.broadcast_license_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.broadcast_license_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.cost_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.cost_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `employee_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `employee_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.manager_employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `employee_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.manager_employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `partner_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `partner_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `partner_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.profit_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.profit_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Equipment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.transmission_equipment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.transmission_equipment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `ad_break_duration_sec` SET TAGS ('dbx_business_glossary_term' = 'Standard Ad Break Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `ad_break_duration_sec` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `ad_break_duration_sec` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.ad_break_duration_sec');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `ad_break_duration_sec` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.ad_break_duration_sec');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `affiliate_network_code` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Network Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `affiliate_network_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `affiliate_network_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.affiliate_network_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `affiliate_network_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.affiliate_network_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `affiliate_network_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `blackout_enabled` SET TAGS ('dbx_business_glossary_term' = 'Blackout Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `blackout_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `blackout_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.blackout_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `blackout_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.blackout_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `broadcast_timezone` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Timezone');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `broadcast_timezone` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `broadcast_timezone` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.broadcast_timezone');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `broadcast_timezone` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.broadcast_timezone');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `call_sign` SET TAGS ('dbx_business_glossary_term' = 'Call Sign');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `call_sign` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{2,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `call_sign` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `call_sign` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.call_sign');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `call_sign` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.call_sign');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.carriage_fee_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.carriage_fee_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `cdn_origin_url` SET TAGS ('dbx_business_glossary_term' = 'CDN Origin URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `cdn_origin_url` SET TAGS ('dbx_validation_regex_^https?' = '//[^s]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `cdn_origin_url` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `cdn_origin_url` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.cdn_origin_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `cdn_origin_url` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.cdn_origin_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_business_glossary_term' = 'Channel Lifecycle Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|testing|decommissioned');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.channel_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.channel_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'linear|simulcast|pop-up|FAST|VOD');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.channel_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.channel_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_business_glossary_term' = 'Content Rating System');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_value_regex' = 'TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.content_rating_system');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.content_rating_system');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.country_of_origin');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.country_of_origin');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.dai_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.dai_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `dalet_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `dalet_channel_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `dalet_channel_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.dalet_channel_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `dalet_channel_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.dalet_channel_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `dalet_channel_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Channel Decommission Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `decommission_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `decommission_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.decommission_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `decommission_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.decommission_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `drm_enabled` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `drm_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `drm_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.drm_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `drm_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.drm_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `epg_enabled` SET TAGS ('dbx_business_glossary_term' = 'Electronic Program Guide (EPG) Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `epg_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `epg_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.epg_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `epg_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.epg_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `genre` SET TAGS ('dbx_business_glossary_term' = 'Channel Genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `genre` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `genre` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `genre` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `hls_stream_url` SET TAGS ('dbx_business_glossary_term' = 'HTTP Live Streaming (HLS) Stream URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `hls_stream_url` SET TAGS ('dbx_validation_regex_^https?' = '//[^s]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `hls_stream_url` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `hls_stream_url` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.hls_stream_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `hls_stream_url` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.hls_stream_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Channel Launch Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `launch_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `launch_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.launch_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `launch_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.launch_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `logical_channel_number` SET TAGS ('dbx_business_glossary_term' = 'Logical Channel Number (LCN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `logical_channel_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `logical_channel_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.logical_channel_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `logical_channel_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.logical_channel_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `max_ad_load_pct` SET TAGS ('dbx_business_glossary_term' = 'Maximum Ad Load Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `max_ad_load_pct` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `max_ad_load_pct` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.max_ad_load_pct');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `max_ad_load_pct` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.max_ad_load_pct');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `mediafirst_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Ericsson MediaFirst Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `mediafirst_channel_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `mediafirst_channel_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.mediafirst_channel_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `mediafirst_channel_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.mediafirst_channel_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `mediafirst_channel_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `mpeg_dash_stream_url` SET TAGS ('dbx_business_glossary_term' = 'MPEG-DASH Stream URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `mpeg_dash_stream_url` SET TAGS ('dbx_validation_regex_^https?' = '//[^s]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `mpeg_dash_stream_url` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `mpeg_dash_stream_url` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.mpeg_dash_stream_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `mpeg_dash_stream_url` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.mpeg_dash_stream_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `must_carry_status` SET TAGS ('dbx_business_glossary_term' = 'Must-Carry Status Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `must_carry_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `must_carry_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.must_carry_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `must_carry_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.must_carry_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `network_name` SET TAGS ('dbx_business_glossary_term' = 'Network Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `network_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `network_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `network_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.network_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `network_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.network_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `nielsen_station_code` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Station ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `nielsen_station_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `nielsen_station_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.nielsen_station_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `nielsen_station_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.nielsen_station_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `nielsen_station_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `playout_automation_enabled` SET TAGS ('dbx_business_glossary_term' = 'Playout Automation Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `playout_automation_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `playout_automation_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.playout_automation_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `playout_automation_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.playout_automation_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.primary_language');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.primary_language');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `resolution_profile` SET TAGS ('dbx_business_glossary_term' = 'Resolution Profile');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `resolution_profile` SET TAGS ('dbx_value_regex' = 'SD|HD|UHD|4K');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `resolution_profile` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `resolution_profile` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.resolution_profile');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `resolution_profile` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.resolution_profile');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `retransmission_consent_required` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `retransmission_consent_required` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `retransmission_consent_required` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.retransmission_consent_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `retransmission_consent_required` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.retransmission_consent_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `scte35_enabled` SET TAGS ('dbx_business_glossary_term' = 'SCTE-35 Cue Marker Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `scte35_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `scte35_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.scte35_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `scte35_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.scte35_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `transmission_standard` SET TAGS ('dbx_business_glossary_term' = 'Transmission Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `transmission_standard` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `transmission_standard` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.transmission_standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `transmission_standard` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.transmission_standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `wide_orbit_station_code` SET TAGS ('dbx_business_glossary_term' = 'Wide Orbit Station Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `wide_orbit_station_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `wide_orbit_station_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel.wide_orbit_station_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `wide_orbit_station_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel.wide_orbit_station_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ALTER COLUMN `wide_orbit_station_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` SET TAGS ('dbx_subdomain' = 'channel_programming');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` SET TAGS ('dbx_star_schema_role' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` SET TAGS ('dbx_data_type' = 'dimension_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.scheduling.daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.scheduling.daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` SET TAGS ('dbx_domain_ownership' = 'EPG; program schedule; slots; rundowns; ad breaks; dayparts; simulcast; playout (Ericsson MediaFirst)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` SET TAGS ('dbx_workload_mode' = 'Linear');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` SET TAGS ('dbx_protocols' = 'ATSC/DVB/QAM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.daypart_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.daypart_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `dai_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Dai Configuration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `dai_configuration_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `dai_configuration_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.dai_configuration_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `dai_configuration_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.dai_configuration_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `ad_pod_max_count` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Maximum Count Per Hour');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `ad_pod_max_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `ad_pod_max_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.ad_pod_max_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `ad_pod_max_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.ad_pod_max_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `ad_pod_max_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Maximum Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `ad_pod_max_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `ad_pod_max_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.ad_pod_max_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `ad_pod_max_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.ad_pod_max_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `applicable_days` SET TAGS ('dbx_business_glossary_term' = 'Daypart Applicable Days of Week');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `applicable_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `applicable_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.applicable_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `applicable_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.applicable_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `avg_audience_000` SET TAGS ('dbx_business_glossary_term' = 'Average Audience (Thousands)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `avg_audience_000` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `avg_audience_000` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.avg_audience_000');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `avg_audience_000` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.avg_audience_000');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `base_cpm_usd` SET TAGS ('dbx_business_glossary_term' = 'Base Cost Per Mille (CPM) Rate (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `base_cpm_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `base_cpm_usd` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `base_cpm_usd` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.base_cpm_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `base_cpm_usd` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.base_cpm_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `blackout_eligible` SET TAGS ('dbx_business_glossary_term' = 'Blackout Eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `blackout_eligible` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `blackout_eligible` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.blackout_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `blackout_eligible` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.blackout_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_code` SET TAGS ('dbx_business_glossary_term' = 'Daypart Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.daypart_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.daypart_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `content_rating_restriction` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `content_rating_restriction` SET TAGS ('dbx_value_regex' = 'TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `content_rating_restriction` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `content_rating_restriction` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.content_rating_restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `content_rating_restriction` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.content_rating_restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `coppa_restricted` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Restricted');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `coppa_restricted` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `coppa_restricted` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.coppa_restricted');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `coppa_restricted` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.coppa_restricted');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `dai_eligible` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `dai_eligible` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `dai_eligible` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.dai_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `dai_eligible` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.dai_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `day_category` SET TAGS ('dbx_business_glossary_term' = 'Daypart Day Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `day_category` SET TAGS ('dbx_value_regex' = 'weekday|weekend|all_week|holiday');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `day_category` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `day_category` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.day_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `day_category` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.day_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `day_category` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_status` SET TAGS ('dbx_business_glossary_term' = 'Daypart Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|deprecated');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.daypart_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.daypart_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_type` SET TAGS ('dbx_business_glossary_term' = 'Daypart Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_type` SET TAGS ('dbx_value_regex' = 'linear|non_linear|simulcast|vod_window');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.daypart_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.daypart_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_description` SET TAGS ('dbx_business_glossary_term' = 'Daypart Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_description` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_description` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.daypart_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_description` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.daypart_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Daypart Duration (Minutes)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.duration_minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.duration_minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Daypart Effective From Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `effective_from` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `effective_from` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.effective_from');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `effective_from` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.effective_from');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Daypart Effective Until Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `effective_until` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `effective_until` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.effective_until');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `effective_until` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.effective_until');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Daypart End Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `end_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `end_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.end_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `end_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.end_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `epg_display_order` SET TAGS ('dbx_business_glossary_term' = 'Electronic Program Guide (EPG) Display Order');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `epg_display_order` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `epg_display_order` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.epg_display_order');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `epg_display_order` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.epg_display_order');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `grp_index` SET TAGS ('dbx_business_glossary_term' = 'Gross Rating Point (GRP) Index');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `grp_index` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `grp_index` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.grp_index');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `grp_index` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.grp_index');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `hut_level` SET TAGS ('dbx_business_glossary_term' = 'Homes Using Television (HUT) Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `hut_level` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `hut_level` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.hut_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `hut_level` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.hut_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `makegood_eligible` SET TAGS ('dbx_business_glossary_term' = 'Makegood Eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `makegood_eligible` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `makegood_eligible` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.makegood_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `makegood_eligible` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.makegood_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_name` SET TAGS ('dbx_business_glossary_term' = 'Daypart Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.daypart_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `daypart_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.daypart_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `nielsen_daypart_code` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Daypart Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `nielsen_daypart_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `nielsen_daypart_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.nielsen_daypart_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `nielsen_daypart_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.nielsen_daypart_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `nielsen_daypart_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Daypart Rate Multiplier');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `rate_multiplier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `rate_multiplier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.rate_multiplier');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `rate_multiplier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.rate_multiplier');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `scatter_eligible` SET TAGS ('dbx_business_glossary_term' = 'Scatter Market Eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `scatter_eligible` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `scatter_eligible` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.scatter_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `scatter_eligible` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.scatter_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `scte35_cue_enabled` SET TAGS ('dbx_business_glossary_term' = 'SCTE-35 Cue Marker Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `scte35_cue_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `scte35_cue_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.scte35_cue_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `scte35_cue_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.scte35_cue_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `simulcast_eligible` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `simulcast_eligible` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `simulcast_eligible` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.simulcast_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `simulcast_eligible` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.simulcast_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Daypart Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `start_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `start_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `start_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `sweeps_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Sweeps Period Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `sweeps_period_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `sweeps_period_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.sweeps_period_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `sweeps_period_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.sweeps_period_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Daypart Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `target_demographic` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `target_demographic` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.target_demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `target_demographic` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.target_demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `target_demographic` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `timezone_code` SET TAGS ('dbx_business_glossary_term' = 'Daypart Timezone Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `timezone_code` SET TAGS ('dbx_value_regex' = '^[A-Za-z_/]{3,40}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `timezone_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `timezone_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.timezone_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `timezone_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.timezone_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `timezone_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `upfront_eligible` SET TAGS ('dbx_business_glossary_term' = 'Upfront Sales Eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `upfront_eligible` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `upfront_eligible` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.upfront_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `upfront_eligible` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.upfront_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `wide_orbit_daypart_code` SET TAGS ('dbx_business_glossary_term' = 'Wide Orbit Daypart Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `wide_orbit_daypart_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `wide_orbit_daypart_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart.wide_orbit_daypart_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `wide_orbit_daypart_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart.wide_orbit_daypart_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ALTER COLUMN `wide_orbit_daypart_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` SET TAGS ('dbx_subdomain' = 'channel_programming');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` SET TAGS ('dbx_data_type' = 'dimension_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.scheduling.program_schedule');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.scheduling.program_schedule');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` SET TAGS ('dbx_domain_ownership' = 'EPG; program schedule; slots; rundowns; ad breaks; dayparts; simulcast; playout (Ericsson MediaFirst)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` SET TAGS ('dbx_supports_use_cases' = 'Linear playout + as-run reconciliation (5-star)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` SET TAGS ('dbx_use_case_fitness' = 'Linear playout + as-run reconciliation (5-star)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` SET TAGS ('dbx_workload_mode' = 'Linear');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` SET TAGS ('dbx_protocols' = 'ATSC/DVB/QAM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Program Schedule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.program_schedule_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.program_schedule_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.broadcast_facility_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.broadcast_facility_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.broadcast_license_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.broadcast_license_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.cost_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.cost_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `invoice_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `invoice_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.invoice_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `invoice_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.invoice_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduler Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.scheduler_employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.scheduler_employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `ad_pod_count` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `ad_pod_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `ad_pod_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.ad_pod_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `ad_pod_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.ad_pod_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Schedule Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.approved_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.approved_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.approved_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.approved_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `as_run_confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'As-Run Confirmed Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `as_run_confirmed_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `as_run_confirmed_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.as_run_confirmed_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `as_run_confirmed_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.as_run_confirmed_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_business_glossary_term' = 'Blackout Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.blackout_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.blackout_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.broadcast_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.broadcast_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `broadcast_standard` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Technical Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `broadcast_standard` SET TAGS ('dbx_value_regex' = 'ATSC|DVB|ISDB|NTSC|PAL');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `broadcast_standard` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `broadcast_standard` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.broadcast_standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `broadcast_standard` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.broadcast_standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `content_rating_advisory` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Advisory');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `content_rating_advisory` SET TAGS ('dbx_value_regex' = 'TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `content_rating_advisory` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `content_rating_advisory` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.content_rating_advisory');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `content_rating_advisory` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.content_rating_advisory');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `dalet_workflow_code` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Workflow ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `dalet_workflow_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `dalet_workflow_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.dalet_workflow_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `dalet_workflow_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.dalet_workflow_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `dalet_workflow_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `daypart_code` SET TAGS ('dbx_business_glossary_term' = 'Daypart Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `daypart_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `daypart_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.daypart_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `daypart_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.daypart_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `daypart_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `emergency_alert_ready` SET TAGS ('dbx_business_glossary_term' = 'Emergency Alert System (EAS) Ready Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `emergency_alert_ready` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `emergency_alert_ready` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.emergency_alert_ready');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `emergency_alert_ready` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.emergency_alert_ready');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `epg_grid_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Program Guide (EPG) Grid ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `epg_grid_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `epg_grid_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.epg_grid_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `epg_grid_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.epg_grid_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `epg_grid_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `fcc_children_programming_compliant` SET TAGS ('dbx_business_glossary_term' = 'FCC Childrens Programming Compliance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `fcc_children_programming_compliant` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `fcc_children_programming_compliant` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.fcc_children_programming_compliant');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `fcc_children_programming_compliant` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.fcc_children_programming_compliant');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `mediafirst_rundown_code` SET TAGS ('dbx_business_glossary_term' = 'Ericsson MediaFirst Rundown ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `mediafirst_rundown_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `mediafirst_rundown_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.mediafirst_rundown_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `mediafirst_rundown_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.mediafirst_rundown_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `mediafirst_rundown_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `must_carry_compliant` SET TAGS ('dbx_business_glossary_term' = 'Must-Carry Compliance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `must_carry_compliant` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `must_carry_compliant` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.must_carry_compliant');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `must_carry_compliant` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.must_carry_compliant');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `playout_failover_mode` SET TAGS ('dbx_business_glossary_term' = 'Playout Failover Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `playout_failover_mode` SET TAGS ('dbx_value_regex' = 'primary|backup|manual_override');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `playout_failover_mode` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `playout_failover_mode` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.playout_failover_mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `playout_failover_mode` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.playout_failover_mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|partial|failed');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.rights_clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.rights_clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_end_time` SET TAGS ('dbx_business_glossary_term' = 'Schedule End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_end_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_end_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.schedule_end_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_end_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.schedule_end_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.schedule_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.schedule_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.schedule_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.schedule_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_source` SET TAGS ('dbx_business_glossary_term' = 'Schedule Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_source` SET TAGS ('dbx_value_regex' = 'manual|automated|imported|template');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_source` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_source` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.schedule_source');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_source` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.schedule_source');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_start_time` SET TAGS ('dbx_business_glossary_term' = 'Schedule Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_start_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_start_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.schedule_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_start_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.schedule_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|approved|transmitted|as-run|cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.schedule_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.schedule_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'standard|special_event|holiday|sweeps|upfront_preview');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.schedule_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.schedule_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.schedule_version');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.schedule_version');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `scte35_cue_count` SET TAGS ('dbx_business_glossary_term' = 'SCTE-35 Cue Marker Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `scte35_cue_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `scte35_cue_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.scte35_cue_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `scte35_cue_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.scte35_cue_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `simulcast_flag` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `simulcast_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `simulcast_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.simulcast_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `simulcast_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.simulcast_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `simulcast_platform_count` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Platform Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `simulcast_platform_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `simulcast_platform_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.simulcast_platform_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `simulcast_platform_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.simulcast_platform_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Timezone');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `timezone` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `timezone` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.timezone');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `timezone` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.timezone');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `total_ad_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Advertising Time (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `total_ad_time_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `total_ad_time_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.total_ad_time_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `total_ad_time_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.total_ad_time_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `total_program_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Program Time (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `total_program_time_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `total_program_time_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.total_program_time_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `total_program_time_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.total_program_time_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `total_runtime_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Schedule Runtime (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `total_runtime_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `total_runtime_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.total_runtime_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `total_runtime_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.total_runtime_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `transmission_type` SET TAGS ('dbx_business_glossary_term' = 'Transmission Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `transmission_type` SET TAGS ('dbx_value_regex' = 'linear|vod_window|fast_channel|simulcast');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `transmission_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `transmission_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.transmission_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `transmission_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.transmission_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `transmission_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `transmitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Transmitted Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `transmitted_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `transmitted_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.transmitted_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `transmitted_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.transmitted_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `wide_orbit_log_code` SET TAGS ('dbx_business_glossary_term' = 'Wide Orbit Traffic Log ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `wide_orbit_log_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `wide_orbit_log_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_schedule.wide_orbit_log_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `wide_orbit_log_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_schedule.wide_orbit_log_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ALTER COLUMN `wide_orbit_log_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` SET TAGS ('dbx_subdomain' = 'channel_programming');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` SET TAGS ('dbx_data_type' = 'dimension_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.scheduling.schedule_slot');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.scheduling.schedule_slot');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` SET TAGS ('dbx_domain_ownership' = 'EPG; program schedule; slots; rundowns; ad breaks; dayparts; simulcast; playout (Ericsson MediaFirst)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` SET TAGS ('dbx_workload_mode' = 'Linear');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` SET TAGS ('dbx_protocols' = 'ATSC/DVB/QAM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.schedule_slot_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.schedule_slot_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.ad_pod_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.ad_pod_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.compliance_content_rating_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.compliance_content_rating_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `daypart_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `daypart_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.daypart_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `daypart_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.daypart_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.program_schedule_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.program_schedule_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.revenue_stream_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.revenue_stream_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `scheduling_availability_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Window ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `scheduling_availability_window_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `scheduling_availability_window_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.scheduling_availability_window_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `scheduling_availability_window_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.scheduling_availability_window_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `title_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `title_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `title_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Traffic Coordinator Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `employee_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `employee_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.traffic_coordinator_employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `employee_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.traffic_coordinator_employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Equipment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.transmission_equipment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.transmission_equipment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `schedule_status_ref_id` SET TAGS ('dbx_relationship' = 'siloed_fix');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `actual_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `actual_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `actual_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.actual_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `actual_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.actual_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time (As-Run)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.actual_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.actual_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `audio_format` SET TAGS ('dbx_business_glossary_term' = 'Audio Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `audio_format` SET TAGS ('dbx_value_regex' = 'stereo|dolby_5_1|dolby_atmos|mono|surround');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `audio_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `audio_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.audio_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `audio_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.audio_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `audio_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `automation_event_code` SET TAGS ('dbx_business_glossary_term' = 'Automation Event ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `automation_event_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `automation_event_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.automation_event_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `automation_event_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.automation_event_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `automation_event_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.broadcast_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.broadcast_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `closed_caption_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `closed_caption_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `closed_caption_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.closed_caption_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `closed_caption_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.closed_caption_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `eas_alert_type` SET TAGS ('dbx_business_glossary_term' = 'Emergency Alert System (EAS) Alert Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `eas_alert_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `eas_alert_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.eas_alert_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `eas_alert_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.eas_alert_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `eas_alert_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `episode_number` SET TAGS ('dbx_business_glossary_term' = 'Episode Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `episode_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `episode_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.episode_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `episode_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.episode_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `is_blackout` SET TAGS ('dbx_business_glossary_term' = 'Blackout Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `is_blackout` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `is_blackout` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.is_blackout');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `is_blackout` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.is_blackout');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `is_live` SET TAGS ('dbx_business_glossary_term' = 'Live Broadcast Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `is_live` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `is_live` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.is_live');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `is_live` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.is_live');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `is_repeat` SET TAGS ('dbx_business_glossary_term' = 'Repeat Broadcast Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `is_repeat` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `is_repeat` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.is_repeat');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `is_repeat` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.is_repeat');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `is_simulcast` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `is_simulcast` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `is_simulcast` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.is_simulcast');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `is_simulcast` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.is_simulcast');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `isan_code` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `isan_code` SET TAGS ('dbx_value_regex' = '^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `isan_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `isan_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.isan_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `isan_code` SET TAGS ('dbx_regex' = '^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}(-[0-9A-F]{4}-[0-9A-F]{4})?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `isan_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.isan_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `isan_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `isci_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Standard Commercial Identification (ISCI) Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `isci_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `isci_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `isci_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.isci_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `isci_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.isci_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `isci_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `must_carry_flag` SET TAGS ('dbx_business_glossary_term' = 'Must-Carry Obligation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `must_carry_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `must_carry_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.must_carry_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `must_carry_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.must_carry_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `nielsen_program_code` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Program Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `nielsen_program_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `nielsen_program_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.nielsen_program_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `nielsen_program_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.nielsen_program_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `nielsen_program_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `planned_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `planned_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `planned_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.planned_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `planned_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.planned_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `planned_end_time` SET TAGS ('dbx_business_glossary_term' = 'Planned End Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `planned_end_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `planned_end_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.planned_end_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `planned_end_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.planned_end_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `planned_start_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `planned_start_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `planned_start_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.planned_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `planned_start_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.planned_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `program_title` SET TAGS ('dbx_business_glossary_term' = 'Program Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `program_title` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `program_title` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.program_title');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `program_title` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.program_title');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `resolution` SET TAGS ('dbx_value_regex' = 'SD|HD|UHD|4K');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `resolution` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `resolution` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `resolution` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `schedule_version` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `schedule_version` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.schedule_version');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `schedule_version` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.schedule_version');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `scte35_cue_in_time` SET TAGS ('dbx_business_glossary_term' = 'SCTE-35 Cue-In Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `scte35_cue_in_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `scte35_cue_in_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.scte35_cue_in_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `scte35_cue_in_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.scte35_cue_in_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `scte35_cue_out_time` SET TAGS ('dbx_business_glossary_term' = 'SCTE-35 Cue-Out Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `scte35_cue_out_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `scte35_cue_out_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.scte35_cue_out_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `scte35_cue_out_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.scte35_cue_out_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `secondary_audio_flag` SET TAGS ('dbx_business_glossary_term' = 'Secondary Audio Program (SAP) Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `secondary_audio_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `secondary_audio_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.secondary_audio_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `secondary_audio_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.secondary_audio_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `slot_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Slot Sequence Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `slot_sequence_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `slot_sequence_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.slot_sequence_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `slot_sequence_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.slot_sequence_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `slot_status` SET TAGS ('dbx_business_glossary_term' = 'Slot Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `slot_status` SET TAGS ('dbx_value_regex' = 'scheduled|confirmed|on_air|completed|cancelled|replaced');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `slot_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `slot_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.slot_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `slot_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.slot_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `slot_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `slot_type` SET TAGS ('dbx_business_glossary_term' = 'Slot Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `slot_type` SET TAGS ('dbx_value_regex' = 'program|promo|commercial_break|filler|psa|eas');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `slot_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `slot_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.slot_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `slot_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.slot_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `slot_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `traffic_order_number` SET TAGS ('dbx_business_glossary_term' = 'Traffic Order Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `traffic_order_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `traffic_order_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.traffic_order_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `traffic_order_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.traffic_order_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_slot.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_slot.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` SET TAGS ('dbx_subdomain' = 'channel_programming');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` SET TAGS ('dbx_fact_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` SET TAGS ('dbx_data_type' = 'fact_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.scheduling.epg_entry');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.scheduling.epg_entry');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` SET TAGS ('dbx_domain_ownership' = 'EPG; program schedule; slots; rundowns; ad breaks; dayparts; simulcast; playout (Ericsson MediaFirst)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` SET TAGS ('dbx_workload_mode' = 'Linear');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` SET TAGS ('dbx_protocols' = 'ATSC/DVB/QAM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` SET TAGS ('dbx_fact_dim_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` SET TAGS ('dbx_star_schema' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `epg_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Program Guide (EPG) Entry ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `epg_entry_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `epg_entry_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.epg_entry_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `epg_entry_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.epg_entry_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.compliance_content_rating_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.compliance_content_rating_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `rights_availability_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Availability Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `rights_availability_window_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `rights_availability_window_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.rights_availability_window_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `rights_availability_window_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.rights_availability_window_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.schedule_slot_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.schedule_slot_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `daypart_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `daypart_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.scheduling_daypart_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `daypart_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.scheduling_daypart_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `ad_pod_count` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `ad_pod_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `ad_pod_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.ad_pod_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `ad_pod_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.ad_pod_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `blackout_region_codes` SET TAGS ('dbx_business_glossary_term' = 'Blackout Region Codes');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `blackout_region_codes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `blackout_region_codes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.blackout_region_codes');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `blackout_region_codes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.blackout_region_codes');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.broadcast_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.broadcast_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `epg_entry_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Program Guide (EPG) Entry Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `epg_entry_code` SET TAGS ('dbx_value_regex' = '^EPG-[A-Z0-9]{3,10}-[0-9]{8}-[0-9]{6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `epg_entry_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `epg_entry_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.epg_entry_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `epg_entry_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.epg_entry_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `epg_entry_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `distribution_window` SET TAGS ('dbx_business_glossary_term' = 'Distribution Window');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `distribution_window` SET TAGS ('dbx_value_regex' = 'linear|svod|avod|tvod|fast|syndication');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `distribution_window` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `distribution_window` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.distribution_window');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `distribution_window` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.distribution_window');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Program Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `eidr` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `eidr` SET TAGS ('dbx_value_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `eidr` SET TAGS ('dbx_validation_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `eidr` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `eidr` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.eidr');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `eidr` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.eidr');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'EPG Entry Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_value_regex' = 'draft|approved|published|cancelled|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.entry_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.entry_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `epg_feed_version` SET TAGS ('dbx_business_glossary_term' = 'EPG Feed Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `epg_feed_version` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `epg_feed_version` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.epg_feed_version');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `epg_feed_version` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.epg_feed_version');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `episode_number` SET TAGS ('dbx_business_glossary_term' = 'Episode Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `episode_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `episode_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.episode_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `episode_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.episode_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `episode_title` SET TAGS ('dbx_business_glossary_term' = 'Episode Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `episode_title` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `episode_title` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.episode_title');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `episode_title` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.episode_title');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `genre_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `genre_primary` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `genre_primary` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.genre_primary');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `genre_primary` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.genre_primary');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `genre_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `genre_secondary` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `genre_secondary` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.genre_secondary');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `genre_secondary` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.genre_secondary');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_blackout` SET TAGS ('dbx_business_glossary_term' = 'Blackout Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_blackout` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_blackout` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.is_blackout');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_blackout` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.is_blackout');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_closed_caption` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_closed_caption` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_closed_caption` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.is_closed_caption');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_closed_caption` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.is_closed_caption');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_hdr` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_hdr` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_hdr` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.is_hdr');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_hdr` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.is_hdr');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_live` SET TAGS ('dbx_business_glossary_term' = 'Live Broadcast Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_live` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_live` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.is_live');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_live` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.is_live');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_new_episode` SET TAGS ('dbx_business_glossary_term' = 'New Episode Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_new_episode` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_new_episode` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.is_new_episode');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_new_episode` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.is_new_episode');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_simulcast` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_simulcast` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_simulcast` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.is_simulcast');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `is_simulcast` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.is_simulcast');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `isan` SET TAGS ('dbx_value_regex' = '^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `isan` SET TAGS ('dbx_validation_regex' = '^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `isan` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `isan` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.isan');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `isan` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.isan');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code (ISO 639-2)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `language_code` SET TAGS ('dbx_validation_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `language_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `language_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.language_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `language_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.language_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `language_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.last_updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.last_updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `program_title` SET TAGS ('dbx_business_glossary_term' = 'Program Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `program_title` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `program_title` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.program_title');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `program_title` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.program_title');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.published_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.published_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `rights_window_end` SET TAGS ('dbx_business_glossary_term' = 'Rights Window End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `rights_window_end` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `rights_window_end` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.rights_window_end');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `rights_window_end` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.rights_window_end');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `rights_window_start` SET TAGS ('dbx_business_glossary_term' = 'Rights Window Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `rights_window_start` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `rights_window_start` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.rights_window_start');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `rights_window_start` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.rights_window_start');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.scheduled_end_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.scheduled_end_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.scheduled_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.scheduled_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `scte35_cue_out_time` SET TAGS ('dbx_business_glossary_term' = 'SCTE-35 Cue Out Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `scte35_cue_out_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `scte35_cue_out_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.scte35_cue_out_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `scte35_cue_out_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.scte35_cue_out_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `season_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `season_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.season_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `season_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.season_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `series_name` SET TAGS ('dbx_business_glossary_term' = 'Series Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `series_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `series_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `series_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.series_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `series_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.series_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Long Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.synopsis_long');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.synopsis_long');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Short Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.synopsis_short');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.synopsis_short');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `total_ad_break_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Ad Break Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `total_ad_break_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `total_ad_break_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.total_ad_break_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `total_ad_break_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.total_ad_break_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `video_resolution` SET TAGS ('dbx_value_regex' = 'SD|HD|FHD|UHD|4K|8K');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `video_resolution` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `video_resolution` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.epg_entry.video_resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `video_resolution` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.epg_entry.video_resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ALTER COLUMN `video_resolution` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` SET TAGS ('dbx_subdomain' = 'playout_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` SET TAGS ('dbx_data_type' = 'fact_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.scheduling.ad_break');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.scheduling.ad_break');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` SET TAGS ('dbx_workload_mode' = 'Linear');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` SET TAGS ('dbx_protocols' = 'ATSC/DVB/QAM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `ad_break_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Break ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `ad_break_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `ad_break_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.ad_break_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `ad_break_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.ad_break_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `ad_billing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Billing Order Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `ad_billing_order_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `ad_billing_order_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.ad_billing_order_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `ad_billing_order_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.ad_billing_order_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `dai_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Dai Configuration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `dai_configuration_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `dai_configuration_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.dai_configuration_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `dai_configuration_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.dai_configuration_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `daypart_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `daypart_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.daypart_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `daypart_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.daypart_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `political_ad_record_id` SET TAGS ('dbx_business_glossary_term' = 'Political Ad Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `political_ad_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `political_ad_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.political_ad_record_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `political_ad_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.political_ad_record_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `scte_marker_id` SET TAGS ('dbx_business_glossary_term' = 'SCTE-35 Cue-Out Marker ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `scte_marker_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `scte_marker_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.primary_ad_scte_marker_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `scte_marker_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.primary_ad_scte_marker_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.revenue_stream_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.revenue_stream_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.schedule_slot_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.schedule_slot_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Traffic Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `employee_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `employee_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.traffic_manager_employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `employee_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.traffic_manager_employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `actual_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Actual Ad Pod Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `actual_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `actual_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.actual_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `actual_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.actual_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Break Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.actual_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.actual_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `affidavit_generated` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Generated Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `affidavit_generated` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `affidavit_generated` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.affidavit_generated');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `affidavit_generated` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.affidavit_generated');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `automation_event_code` SET TAGS ('dbx_business_glossary_term' = 'Ericsson MediaFirst Automation Event ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `automation_event_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `automation_event_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.automation_event_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `automation_event_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.automation_event_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `automation_event_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `avail_count` SET TAGS ('dbx_business_glossary_term' = 'Ad Avail Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `avail_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `avail_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.avail_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `avail_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.avail_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `blackout_restricted` SET TAGS ('dbx_business_glossary_term' = 'Geographic Blackout Restriction Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `blackout_restricted` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `blackout_restricted` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.blackout_restricted');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `blackout_restricted` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.blackout_restricted');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `break_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Break Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `break_position` SET TAGS ('dbx_value_regex' = 'pre-roll|mid-roll|post-roll|interstitial');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `break_position` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `break_position` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.break_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `break_position` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.break_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `break_status` SET TAGS ('dbx_business_glossary_term' = 'Ad Break Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `break_status` SET TAGS ('dbx_value_regex' = 'scheduled|confirmed|aired|cancelled|hold');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `break_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `break_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.break_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `break_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.break_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `break_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `break_type` SET TAGS ('dbx_business_glossary_term' = 'Ad Break Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `break_type` SET TAGS ('dbx_value_regex' = 'local_avail|network_avail|promotional|public_service|emergency');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `break_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `break_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.break_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `break_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.break_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `break_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.broadcast_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.broadcast_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `content_restriction_code` SET TAGS ('dbx_business_glossary_term' = 'Ad Content Restriction Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `content_restriction_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `content_restriction_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.content_restriction_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `content_restriction_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.content_restriction_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `content_restriction_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `dai_eligible` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `dai_eligible` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `dai_eligible` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.dai_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `dai_eligible` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.dai_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `epg_break_label` SET TAGS ('dbx_business_glossary_term' = 'Electronic Program Guide (EPG) Break Label');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `epg_break_label` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `epg_break_label` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.epg_break_label');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `epg_break_label` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.epg_break_label');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `grp_target` SET TAGS ('dbx_business_glossary_term' = 'Gross Rating Point (GRP) Target');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `grp_target` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `grp_target` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.grp_target');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `grp_target` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.grp_target');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `makegood_required` SET TAGS ('dbx_business_glossary_term' = 'Makegood Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `makegood_required` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `makegood_required` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.makegood_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `makegood_required` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.makegood_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `max_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Maximum Ad Pod Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `max_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `max_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.max_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `max_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.max_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `nielsen_program_rating` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Program Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `nielsen_program_rating` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `nielsen_program_rating` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.nielsen_program_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `nielsen_program_rating` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.nielsen_program_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `planned_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Planned Ad Pod Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `planned_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `planned_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.planned_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `planned_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.planned_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `pod_number` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `pod_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `pod_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.pod_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `pod_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.pod_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `preemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Break Preemption Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `preemption_reason` SET TAGS ('dbx_value_regex' = 'breaking_news|emergency_alert|technical_failure|rights_conflict|schedule_change|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `preemption_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `preemption_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.preemption_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `preemption_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.preemption_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `rate_card_cpm` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `rate_card_cpm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `rate_card_cpm` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `rate_card_cpm` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `rate_card_cpm` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.rate_card_cpm');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `rate_card_cpm` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.rate_card_cpm');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Break Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.scheduled_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.scheduled_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Break Sequence Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `sequence_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `sequence_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.sequence_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `sequence_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.sequence_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `simulcast_eligible` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `simulcast_eligible` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `simulcast_eligible` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.simulcast_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `simulcast_eligible` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.simulcast_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `sold_avail_count` SET TAGS ('dbx_business_glossary_term' = 'Sold Ad Avail Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `sold_avail_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `sold_avail_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.sold_avail_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `sold_avail_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.sold_avail_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `sold_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Sold Ad Pod Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `sold_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `sold_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.sold_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `sold_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.sold_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `wide_orbit_break_code` SET TAGS ('dbx_business_glossary_term' = 'Wide Orbit Traffic System Break ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `wide_orbit_break_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `wide_orbit_break_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.ad_break.wide_orbit_break_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `wide_orbit_break_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.ad_break.wide_orbit_break_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ALTER COLUMN `wide_orbit_break_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` SET TAGS ('dbx_subdomain' = 'playout_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` SET TAGS ('dbx_data_type' = 'fact_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.scheduling.scte_marker');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.scheduling.scte_marker');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` SET TAGS ('dbx_domain_ownership' = 'EPG; program schedule; slots; rundowns; ad breaks; dayparts; simulcast; playout (Ericsson MediaFirst)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` SET TAGS ('dbx_workload_mode' = 'Linear');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` SET TAGS ('dbx_protocols' = 'ATSC/DVB/QAM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `scte_marker_id` SET TAGS ('dbx_business_glossary_term' = 'Society of Cable Telecommunications Engineers (SCTE) Marker ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `scte_marker_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `scte_marker_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.scte_marker_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `scte_marker_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.scte_marker_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.ad_pod_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.ad_pod_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `daypart_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `daypart_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.daypart_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `daypart_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.daypart_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.program_schedule_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.program_schedule_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.schedule_slot_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.schedule_slot_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `title_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `title_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `title_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `auto_return` SET TAGS ('dbx_business_glossary_term' = 'Auto Return Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `auto_return` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `auto_return` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.auto_return');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `auto_return` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.auto_return');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `avail_num` SET TAGS ('dbx_business_glossary_term' = 'Avail Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `avail_num` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `avail_num` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.avail_num');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `avail_num` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.avail_num');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `avails_expected` SET TAGS ('dbx_business_glossary_term' = 'Avails Expected');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `avails_expected` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `avails_expected` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.avails_expected');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `avails_expected` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.avails_expected');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_business_glossary_term' = 'Blackout Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.blackout_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.blackout_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `blackout_region_code` SET TAGS ('dbx_business_glossary_term' = 'Blackout Region Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `blackout_region_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `blackout_region_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.blackout_region_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `blackout_region_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.blackout_region_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `blackout_region_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `break_duration_ms` SET TAGS ('dbx_business_glossary_term' = 'Break Duration (Milliseconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `break_duration_ms` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `break_duration_ms` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.break_duration_ms');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `break_duration_ms` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.break_duration_ms');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `component_count` SET TAGS ('dbx_business_glossary_term' = 'Component Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `component_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `component_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.component_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `component_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.component_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `cw_index` SET TAGS ('dbx_business_glossary_term' = 'Control Word (CW) Index');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `cw_index` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `cw_index` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.cw_index');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `cw_index` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.cw_index');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `descriptor_loop_length` SET TAGS ('dbx_business_glossary_term' = 'Descriptor Loop Length');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `descriptor_loop_length` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `descriptor_loop_length` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.descriptor_loop_length');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `descriptor_loop_length` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.descriptor_loop_length');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `encrypted_packet` SET TAGS ('dbx_business_glossary_term' = 'Encrypted Packet Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `encrypted_packet` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `encrypted_packet` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.encrypted_packet');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `encrypted_packet` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.encrypted_packet');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `out_of_network` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Network Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `out_of_network` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `out_of_network` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.out_of_network');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `out_of_network` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.out_of_network');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `pre_roll_duration_ms` SET TAGS ('dbx_business_glossary_term' = 'Pre-Roll Duration (Milliseconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `pre_roll_duration_ms` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `pre_roll_duration_ms` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.pre_roll_duration_ms');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `pre_roll_duration_ms` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.pre_roll_duration_ms');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `processing_error_code` SET TAGS ('dbx_business_glossary_term' = 'Processing Error Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `processing_error_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `processing_error_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.processing_error_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `processing_error_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.processing_error_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `processing_error_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'received|validated|processed|failed|skipped');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `processing_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `processing_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.processing_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `processing_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.processing_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `processing_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `program_number` SET TAGS ('dbx_business_glossary_term' = 'Program Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `program_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `program_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.program_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `program_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.program_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `pts_time` SET TAGS ('dbx_business_glossary_term' = 'Presentation Time Stamp (PTS) Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `pts_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `pts_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.pts_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `pts_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.pts_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `pts_time_utc` SET TAGS ('dbx_business_glossary_term' = 'Presentation Time Stamp (PTS) UTC Wall-Clock Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `pts_time_utc` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `pts_time_utc` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.pts_time_utc');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `pts_time_utc` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.pts_time_utc');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `segmentation_type_code` SET TAGS ('dbx_business_glossary_term' = 'Segmentation Type ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `segmentation_type_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `segmentation_type_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.segmentation_type_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `segmentation_type_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.segmentation_type_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `segmentation_type_label` SET TAGS ('dbx_business_glossary_term' = 'Segmentation Type Label');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `segmentation_type_label` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `segmentation_type_label` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.segmentation_type_label');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `segmentation_type_label` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.segmentation_type_label');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `segmentation_upid_type` SET TAGS ('dbx_business_glossary_term' = 'Segmentation Unique Program Identifier (UPID) Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `segmentation_upid_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `segmentation_upid_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.segmentation_upid_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `segmentation_upid_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.segmentation_upid_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `segmentation_upid_value` SET TAGS ('dbx_business_glossary_term' = 'Segmentation Unique Program Identifier (UPID) Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `segmentation_upid_value` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `segmentation_upid_value` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.segmentation_upid_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `segmentation_upid_value` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.segmentation_upid_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `signal_detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signal Detected Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `signal_detected_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `signal_detected_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.signal_detected_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `signal_detected_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.signal_detected_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `splice_command_type` SET TAGS ('dbx_business_glossary_term' = 'Splice Command Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `splice_command_type` SET TAGS ('dbx_value_regex' = 'splice_null|splice_insert|time_signal|bandwidth_reservation|private_command');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `splice_command_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `splice_command_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.splice_command_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `splice_command_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.splice_command_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `splice_command_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `splice_event_number` SET TAGS ('dbx_business_glossary_term' = 'Splice Event ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `splice_event_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `splice_event_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.splice_event_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `splice_event_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.splice_event_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `splice_immediate` SET TAGS ('dbx_business_glossary_term' = 'Splice Immediate Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `splice_immediate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `splice_immediate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.splice_immediate');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `splice_immediate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.splice_immediate');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `splice_insert_type` SET TAGS ('dbx_business_glossary_term' = 'Splice Insert Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `splice_insert_type` SET TAGS ('dbx_value_regex' = 'splice_in|splice_out');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `splice_insert_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `splice_insert_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.splice_insert_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `splice_insert_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.splice_insert_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `splice_insert_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `transport_stream_number` SET TAGS ('dbx_business_glossary_term' = 'Transport Stream ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `transport_stream_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `transport_stream_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.transport_stream_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `transport_stream_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.transport_stream_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `unique_program_code` SET TAGS ('dbx_business_glossary_term' = 'Unique Program ID (UPID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `unique_program_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `unique_program_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.unique_program_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `unique_program_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.unique_program_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scte_marker.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scte_marker.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` SET TAGS ('dbx_subdomain' = 'channel_programming');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` SET TAGS ('dbx_data_type' = 'fact_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.scheduling.simulcast_config');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.scheduling.simulcast_config');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` SET TAGS ('dbx_domain_ownership' = 'EPG; program schedule; slots; rundowns; ad breaks; dayparts; simulcast; playout (Ericsson MediaFirst)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` SET TAGS ('dbx_workload_mode' = 'Linear');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` SET TAGS ('dbx_protocols' = 'ATSC/DVB/QAM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `simulcast_config_id` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Configuration ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `simulcast_config_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `simulcast_config_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.simulcast_config_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `simulcast_config_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.simulcast_config_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.abr_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.abr_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `billing_carriage_fee_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Carriage Fee Invoice Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `billing_carriage_fee_invoice_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `billing_carriage_fee_invoice_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.billing_carriage_fee_invoice_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `billing_carriage_fee_invoice_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.billing_carriage_fee_invoice_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `dai_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Dai Configuration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `dai_configuration_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `dai_configuration_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.dai_configuration_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `dai_configuration_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.dai_configuration_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.origin_broadcast_facility_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.origin_broadcast_facility_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Backup Source Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.primary_simulcast_backup_source_channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.primary_simulcast_backup_source_channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `retransmission_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `retransmission_consent_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `retransmission_consent_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.retransmission_consent_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `retransmission_consent_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.retransmission_consent_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `partner_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `partner_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.simulcast_partner_partner_partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `partner_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.simulcast_partner_partner_partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `source_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Source Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `source_channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `source_channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.source_channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `source_channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.source_channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.streaming_endpoint_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.streaming_endpoint_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `target_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Target Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `target_channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `target_channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.target_channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `target_channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.target_channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Director Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.technical_director_employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.technical_director_employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Equipment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.transmission_equipment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.transmission_equipment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `ad_pod_substitution` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Substitution Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `ad_pod_substitution` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `ad_pod_substitution` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.ad_pod_substitution');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `ad_pod_substitution` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.ad_pod_substitution');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `audio_description_passthrough` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Passthrough Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `audio_description_passthrough` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `audio_description_passthrough` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.audio_description_passthrough');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `audio_description_passthrough` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.audio_description_passthrough');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `audio_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Audio Profile ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `audio_profile_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `audio_profile_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.audio_profile_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `audio_profile_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.audio_profile_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `blackout_enforced` SET TAGS ('dbx_business_glossary_term' = 'Blackout Enforced');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `blackout_enforced` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `blackout_enforced` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.blackout_enforced');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `blackout_enforced` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.blackout_enforced');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `cdn_origin_path` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Origin Path');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `cdn_origin_path` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `cdn_origin_path` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.cdn_origin_path');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `cdn_origin_path` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.cdn_origin_path');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `closed_caption_passthrough` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Passthrough Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `closed_caption_passthrough` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `closed_caption_passthrough` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.closed_caption_passthrough');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `closed_caption_passthrough` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.closed_caption_passthrough');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `config_code` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Configuration Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `config_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `config_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `config_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.config_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `config_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.config_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `config_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `config_description` SET TAGS ('dbx_business_glossary_term' = 'Configuration Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `config_description` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `config_description` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.config_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `config_description` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.config_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `config_name` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Configuration Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `config_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `config_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `config_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.config_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `config_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.config_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `content_rating_restriction` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `content_rating_restriction` SET TAGS ('dbx_value_regex' = 'TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `content_rating_restriction` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `content_rating_restriction` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.content_rating_restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `content_rating_restriction` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.content_rating_restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.dai_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.dai_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `distribution_platform` SET TAGS ('dbx_business_glossary_term' = 'Distribution Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `distribution_platform` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `distribution_platform` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.distribution_platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `distribution_platform` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.distribution_platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `drm_scheme` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Scheme');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `drm_scheme` SET TAGS ('dbx_value_regex' = 'widevine|fairplay|playready|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `drm_scheme` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `drm_scheme` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.drm_scheme');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `drm_scheme` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.drm_scheme');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `effective_from` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `effective_from` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.effective_from');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `effective_from` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.effective_from');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `effective_until` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `effective_until` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.effective_until');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `effective_until` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.effective_until');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `epg_sync_enabled` SET TAGS ('dbx_business_glossary_term' = 'Electronic Program Guide (EPG) Sync Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `epg_sync_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `epg_sync_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.epg_sync_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `epg_sync_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.epg_sync_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `failover_mode` SET TAGS ('dbx_business_glossary_term' = 'Failover Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `failover_mode` SET TAGS ('dbx_value_regex' = 'automatic|manual|disabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `failover_mode` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `failover_mode` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.failover_mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `failover_mode` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.failover_mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `graphics_passthrough` SET TAGS ('dbx_business_glossary_term' = 'Graphics Passthrough Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `graphics_passthrough` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `graphics_passthrough` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.graphics_passthrough');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `graphics_passthrough` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.graphics_passthrough');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `mediafirst_config_ref` SET TAGS ('dbx_business_glossary_term' = 'Ericsson MediaFirst Configuration Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `mediafirst_config_ref` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,50}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `mediafirst_config_ref` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `mediafirst_config_ref` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.mediafirst_config_ref');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `mediafirst_config_ref` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.mediafirst_config_ref');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `must_carry_compliant` SET TAGS ('dbx_business_glossary_term' = 'Must-Carry Compliant');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `must_carry_compliant` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `must_carry_compliant` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.must_carry_compliant');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `must_carry_compliant` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.must_carry_compliant');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `priority_rank` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `priority_rank` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.priority_rank');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `priority_rank` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.priority_rank');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `rights_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `rights_territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `rights_territory_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `rights_territory_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.rights_territory_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `rights_territory_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.rights_territory_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `rights_territory_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `scte35_cue_passthrough` SET TAGS ('dbx_business_glossary_term' = 'SCTE-35 Cue Passthrough Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `scte35_cue_passthrough` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `scte35_cue_passthrough` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.scte35_cue_passthrough');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `scte35_cue_passthrough` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.scte35_cue_passthrough');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `simulcast_config_status` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Configuration Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `simulcast_config_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|draft');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `simulcast_config_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `simulcast_config_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.simulcast_config_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `simulcast_config_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.simulcast_config_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `simulcast_config_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `simulcast_type` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `simulcast_type` SET TAGS ('dbx_value_regex' = 'full_feed|partial|time_shifted|simulcast_only|ad_substituted');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `simulcast_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `simulcast_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.simulcast_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `simulcast_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.simulcast_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `simulcast_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `time_offset_seconds` SET TAGS ('dbx_business_glossary_term' = 'Time Offset Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `time_offset_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `time_offset_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.time_offset_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `time_offset_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.time_offset_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `video_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Video Profile ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `video_profile_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `video_profile_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.video_profile_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `video_profile_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.video_profile_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `watermark_enabled` SET TAGS ('dbx_business_glossary_term' = 'Watermark Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `watermark_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `watermark_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.simulcast_config.watermark_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ALTER COLUMN `watermark_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.simulcast_config.watermark_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` SET TAGS ('dbx_subdomain' = 'playout_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` SET TAGS ('dbx_ssot_ref' = 'rights.rights_blackout_rule');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` SET TAGS ('dbx_ssot_canonical' = 'rights.rights_blackout_rule');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` SET TAGS ('dbx_data_type' = 'dimension_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.scheduling.scheduling_blackout_rule');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` SET TAGS ('dbx_domain_ownership' = 'EPG; program schedule; slots; rundowns; ad breaks; dayparts; simulcast; playout (Ericsson MediaFirst)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` SET TAGS ('dbx_workload_mode' = 'Linear');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` SET TAGS ('dbx_protocols' = 'ATSC/DVB/QAM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `scheduling_blackout_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Blackout Rule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `scheduling_blackout_rule_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `scheduling_blackout_rule_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.scheduling_blackout_rule_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `scheduling_blackout_rule_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.scheduling_blackout_rule_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.approved_by_employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.approved_by_employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `partner_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `partner_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `partner_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `title_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `title_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.primary_scheduling_title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `title_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.primary_scheduling_title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.regulatory_obligation_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.regulatory_obligation_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rights_availability_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Window ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rights_availability_window_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rights_availability_window_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.rights_availability_window_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rights_availability_window_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.rights_availability_window_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rights_blackout_rule_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rights_blackout_rule_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.rights_blackout_rule_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rights_blackout_rule_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.rights_blackout_rule_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `akamai_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Akamai CDN Rule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `akamai_rule_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `akamai_rule_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.akamai_rule_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `akamai_rule_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.akamai_rule_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `akamai_rule_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.approved_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.approved_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `blackout_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Blackout End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `blackout_end_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `blackout_end_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.blackout_end_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `blackout_end_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.blackout_end_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `blackout_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Blackout Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `blackout_start_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `blackout_start_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.blackout_start_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `blackout_start_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.blackout_start_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|disputed|waived|escalated');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `clearance_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `clearance_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `clearance_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `clearance_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `dai_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Override Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `dai_override_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `dai_override_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.dai_override_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `dai_override_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.dai_override_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `eidr_code` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `eidr_code` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `eidr_code` SET TAGS ('dbx_validation_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `eidr_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `eidr_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.eidr_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `eidr_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.eidr_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `eidr_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `enforcement_scope` SET TAGS ('dbx_business_glossary_term' = 'Blackout Enforcement Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `enforcement_scope` SET TAGS ('dbx_value_regex' = 'playout_only|cdn_only|playout_and_cdn|epg_suppression');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `enforcement_scope` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `enforcement_scope` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.enforcement_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `enforcement_scope` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.enforcement_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `epg_suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Program Guide (EPG) Suppression Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `epg_suppression_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `epg_suppression_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.epg_suppression_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `epg_suppression_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.epg_suppression_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `holdback_type` SET TAGS ('dbx_business_glossary_term' = 'Holdback Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `holdback_type` SET TAGS ('dbx_value_regex' = 'exclusivity|windowing|league_mandate|regulatory|carriage_agreement');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `holdback_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `holdback_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.holdback_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `holdback_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.holdback_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `holdback_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `mediafirst_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Ericsson MediaFirst Rule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `mediafirst_rule_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `mediafirst_rule_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.mediafirst_rule_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `mediafirst_rule_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.mediafirst_rule_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `mediafirst_rule_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `must_carry_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Must-Carry Exemption Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `must_carry_exempt_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `must_carry_exempt_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.must_carry_exempt_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `must_carry_exempt_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.must_carry_exempt_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `restricted_platform_type` SET TAGS ('dbx_business_glossary_term' = 'Restricted Platform Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `restricted_platform_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `restricted_platform_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.restricted_platform_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `restricted_platform_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.restricted_platform_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `restricted_platform_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `restricted_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Restricted Territory Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `restricted_territory_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `restricted_territory_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.restricted_territory_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `restricted_territory_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.restricted_territory_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `restricted_territory_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `restricted_territory_name` SET TAGS ('dbx_business_glossary_term' = 'Restricted Territory Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `restricted_territory_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `restricted_territory_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `restricted_territory_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.restricted_territory_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `restricted_territory_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.restricted_territory_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `restricted_territory_type` SET TAGS ('dbx_business_glossary_term' = 'Restricted Territory Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `restricted_territory_type` SET TAGS ('dbx_value_regex' = 'dma|country|postal_region|state_province|designated_zone');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `restricted_territory_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `restricted_territory_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.restricted_territory_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `restricted_territory_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.restricted_territory_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `restricted_territory_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `retransmission_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `retransmission_consent_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `retransmission_consent_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.retransmission_consent_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `retransmission_consent_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.retransmission_consent_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rightsline_restriction_code` SET TAGS ('dbx_business_glossary_term' = 'Rightsline Restriction ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rightsline_restriction_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rightsline_restriction_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.rightsline_restriction_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rightsline_restriction_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.rightsline_restriction_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rightsline_restriction_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Blackout Rule Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^BKO-[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.rule_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.rule_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Blackout Rule Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.rule_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.rule_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_notes` SET TAGS ('dbx_business_glossary_term' = 'Blackout Rule Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.rule_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.rule_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Blackout Rule Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.rule_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.rule_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Blackout Rule Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'rights_holdback|regulatory|sports_blackout|network_exclusivity|geographic_restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.rule_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.rule_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `scte35_cue_code` SET TAGS ('dbx_business_glossary_term' = 'SCTE-35 Cue Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `scte35_cue_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `scte35_cue_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.scte35_cue_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `scte35_cue_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.scte35_cue_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `scte35_cue_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `simulcast_blackout_flag` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Blackout Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `simulcast_blackout_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `simulcast_blackout_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.simulcast_blackout_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `simulcast_blackout_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.simulcast_blackout_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `substitute_content_type` SET TAGS ('dbx_business_glossary_term' = 'Substitute Content Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `substitute_content_type` SET TAGS ('dbx_value_regex' = 'alternate_program|local_affiliate_feed|blackout_slate|network_filler|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `substitute_content_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `substitute_content_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.substitute_content_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `substitute_content_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.substitute_content_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `substitute_content_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `timezone_code` SET TAGS ('dbx_business_glossary_term' = 'Timezone Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `timezone_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `timezone_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.timezone_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `timezone_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.timezone_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `timezone_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_blackout_rule.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_blackout_rule.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` SET TAGS ('dbx_subdomain' = 'playout_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` SET TAGS ('dbx_fact_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.scheduling.playout_event');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.scheduling.playout_event');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` SET TAGS ('dbx_domain_ownership' = 'EPG; program schedule; slots; rundowns; ad breaks; dayparts; simulcast; playout (Ericsson MediaFirst)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` SET TAGS ('dbx_supports_use_cases' = 'Linear playout + as-run reconciliation (5-star)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` SET TAGS ('dbx_use_case_fitness' = 'Linear playout + as-run reconciliation (5-star)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` SET TAGS ('dbx_workload_mode' = 'Linear');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` SET TAGS ('dbx_protocols' = 'ATSC/DVB/QAM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` SET TAGS ('dbx_data_type' = 'fact_transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` SET TAGS ('dbx_fact_dim_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` SET TAGS ('dbx_star_schema' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `playout_event_id` SET TAGS ('dbx_business_glossary_term' = 'Playout Event ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `playout_event_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `playout_event_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.playout_event_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `playout_event_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.playout_event_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.ad_pod_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.ad_pod_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `affidavit_id` SET TAGS ('dbx_business_glossary_term' = 'Affidavit ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `affidavit_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `affidavit_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.affidavit_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `affidavit_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.affidavit_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.broadcast_facility_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.broadcast_facility_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `closed_caption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `closed_caption_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `closed_caption_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.closed_caption_record_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `closed_caption_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.closed_caption_record_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.cost_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.cost_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `daypart_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `daypart_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.daypart_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `daypart_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.daypart_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `eas_log_id` SET TAGS ('dbx_business_glossary_term' = 'Eas Log Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `eas_log_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `eas_log_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.eas_log_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `eas_log_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.eas_log_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `title_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `title_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.primary_playout_title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `title_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.primary_playout_title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Program Schedule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.program_schedule_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.program_schedule_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.schedule_slot_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.schedule_slot_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `scte_marker_id` SET TAGS ('dbx_business_glossary_term' = 'SCTE-35 Cue ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `scte_marker_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `scte_marker_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.scte_marker_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `scte_marker_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.scte_marker_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Equipment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.transmission_equipment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.transmission_equipment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `actual_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `actual_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `actual_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.actual_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `actual_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.actual_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.actual_end_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.actual_end_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.actual_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.actual_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `affidavit_generated` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Generated Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `affidavit_generated` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `affidavit_generated` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.affidavit_generated');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `affidavit_generated` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.affidavit_generated');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `automation_mode` SET TAGS ('dbx_business_glossary_term' = 'Automation Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `automation_mode` SET TAGS ('dbx_value_regex' = 'auto|manual|override|failover');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `automation_mode` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `automation_mode` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.automation_mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `automation_mode` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.automation_mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_business_glossary_term' = 'Blackout Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.blackout_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.blackout_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.broadcast_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.broadcast_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `broadcast_standard` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `broadcast_standard` SET TAGS ('dbx_value_regex' = 'ATSC|DVB|ISDB|NTSC|PAL');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `broadcast_standard` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `broadcast_standard` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.broadcast_standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `broadcast_standard` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.broadcast_standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `content_rating` SET TAGS ('dbx_value_regex' = 'TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `content_rating` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `content_rating` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.content_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `content_rating` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.content_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `content_rating` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `dai_eligible` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `dai_eligible` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `dai_eligible` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.dai_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `dai_eligible` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.dai_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `dalet_asset_code` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `dalet_asset_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `dalet_asset_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.dalet_asset_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `dalet_asset_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.dalet_asset_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `dalet_asset_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Playout Event Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `event_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `event_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.event_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `event_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.event_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `event_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `failover_activated` SET TAGS ('dbx_business_glossary_term' = 'Failover Activated Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `failover_activated` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `failover_activated` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.failover_activated');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `failover_activated` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.failover_activated');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `isan_code` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN) Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `isan_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `isan_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.isan_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `isan_code` SET TAGS ('dbx_regex' = '^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}(-[0-9A-F]{4}-[0-9A-F]{4})?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `isan_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.isan_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `isan_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `isci_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Standard Commercial Identification (ISCI) Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `isci_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `isci_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `isci_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.isci_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `isci_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.isci_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `isci_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `mediafirst_event_code` SET TAGS ('dbx_business_glossary_term' = 'Ericsson MediaFirst Event ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `mediafirst_event_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `mediafirst_event_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.mediafirst_event_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `mediafirst_event_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.mediafirst_event_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `mediafirst_event_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `must_carry_flag` SET TAGS ('dbx_business_glossary_term' = 'Must-Carry Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `must_carry_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `must_carry_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.must_carry_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `must_carry_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.must_carry_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `playout_status` SET TAGS ('dbx_business_glossary_term' = 'Playout Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `playout_status` SET TAGS ('dbx_value_regex' = 'aired|skipped|substituted|failed|partial|delayed');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `playout_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `playout_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.playout_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `playout_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.playout_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `playout_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|expired|restricted');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.rights_clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.rights_clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `scheduled_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `scheduled_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `scheduled_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.scheduled_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `scheduled_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.scheduled_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.scheduled_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.scheduled_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `simulcast_flag` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `simulcast_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `simulcast_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.simulcast_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `simulcast_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.simulcast_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `start_deviation_seconds` SET TAGS ('dbx_business_glossary_term' = 'Start Time Deviation (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `start_deviation_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `start_deviation_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.start_deviation_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `start_deviation_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.start_deviation_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `substitution_reason` SET TAGS ('dbx_business_glossary_term' = 'Substitution Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `substitution_reason` SET TAGS ('dbx_value_regex' = 'rights_expired|technical_fault|editorial_decision|emergency_override|blackout|operator_override');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `substitution_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `substitution_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.substitution_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `substitution_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.substitution_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `transmission_type` SET TAGS ('dbx_business_glossary_term' = 'Transmission Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `transmission_type` SET TAGS ('dbx_value_regex' = 'linear|vod|simulcast|ott|fast');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `transmission_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `transmission_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.transmission_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `transmission_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.transmission_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `transmission_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `wide_orbit_log_code` SET TAGS ('dbx_business_glossary_term' = 'Wide Orbit Traffic Log ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `wide_orbit_log_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `wide_orbit_log_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.playout_event.wide_orbit_log_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `wide_orbit_log_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.playout_event.wide_orbit_log_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ALTER COLUMN `wide_orbit_log_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` SET TAGS ('dbx_subdomain' = 'channel_programming');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` SET TAGS ('dbx_fact_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` SET TAGS ('dbx_data_type' = 'fact_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.scheduling.program_rundown');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.scheduling.program_rundown');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` SET TAGS ('dbx_domain_ownership' = 'EPG; program schedule; slots; rundowns; ad breaks; dayparts; simulcast; playout (Ericsson MediaFirst)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` SET TAGS ('dbx_workload_mode' = 'Linear');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` SET TAGS ('dbx_protocols' = 'ATSC/DVB/QAM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `program_rundown_id` SET TAGS ('dbx_business_glossary_term' = 'Program Rundown ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `program_rundown_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `program_rundown_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.program_rundown_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `program_rundown_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.program_rundown_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.broadcast_facility_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.broadcast_facility_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Episode ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.content_episode_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.content_episode_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `coppa_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Coppa Declaration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `coppa_declaration_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `coppa_declaration_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.coppa_declaration_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `coppa_declaration_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.coppa_declaration_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `daypart_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `daypart_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.daypart_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `daypart_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.daypart_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `employee_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `employee_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.producer_employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `employee_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.producer_employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Program Schedule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.program_schedule_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.program_schedule_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `ad_pod_count` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `ad_pod_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `ad_pod_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.ad_pod_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `ad_pod_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.ad_pod_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `approved_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `approved_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.approved_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `approved_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.approved_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.approved_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.approved_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_business_glossary_term' = 'Blackout Restriction Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.blackout_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.blackout_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.broadcast_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.broadcast_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `content_rating` SET TAGS ('dbx_value_regex' = 'TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `content_rating` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `content_rating` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.content_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `content_rating` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.content_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `content_rating` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `dai_eligible` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `dai_eligible` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `dai_eligible` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.dai_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `dai_eligible` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.dai_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `dalet_story_code` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Story ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `dalet_story_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `dalet_story_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.dalet_story_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `dalet_story_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.dalet_story_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `dalet_story_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `emergency_alert_ready` SET TAGS ('dbx_business_glossary_term' = 'Emergency Alert System (EAS) Ready Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `emergency_alert_ready` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `emergency_alert_ready` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.emergency_alert_ready');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `emergency_alert_ready` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.emergency_alert_ready');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `live_flag` SET TAGS ('dbx_business_glossary_term' = 'Live Broadcast Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `live_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `live_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.live_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `live_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.live_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `mediafirst_rundown_code` SET TAGS ('dbx_business_glossary_term' = 'Ericsson MediaFirst Rundown ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `mediafirst_rundown_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `mediafirst_rundown_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.mediafirst_rundown_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `mediafirst_rundown_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.mediafirst_rundown_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `mediafirst_rundown_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `playout_failover_mode` SET TAGS ('dbx_business_glossary_term' = 'Playout Failover Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `playout_failover_mode` SET TAGS ('dbx_value_regex' = 'none|backup_channel|filler_loop|manual');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `playout_failover_mode` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `playout_failover_mode` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.playout_failover_mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `playout_failover_mode` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.playout_failover_mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `production_format` SET TAGS ('dbx_business_glossary_term' = 'Production Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `production_format` SET TAGS ('dbx_value_regex' = 'studio|remote|hybrid|tape|simulcast');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `production_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `production_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.production_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `production_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.production_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `production_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `program_content_seconds` SET TAGS ('dbx_business_glossary_term' = 'Program Content Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `program_content_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `program_content_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.program_content_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `program_content_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.program_content_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `program_title` SET TAGS ('dbx_business_glossary_term' = 'Program Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `program_title` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `program_title` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.program_title');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `program_title` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.program_title');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|restricted|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.rights_clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.rights_clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_code` SET TAGS ('dbx_business_glossary_term' = 'Rundown Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.rundown_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.rundown_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_notes` SET TAGS ('dbx_business_glossary_term' = 'Rundown Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.rundown_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.rundown_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_status` SET TAGS ('dbx_business_glossary_term' = 'Rundown Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_status` SET TAGS ('dbx_value_regex' = 'draft|approved|locked|transmitted|archived');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.rundown_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.rundown_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_type` SET TAGS ('dbx_business_glossary_term' = 'Rundown Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.rundown_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.rundown_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_version` SET TAGS ('dbx_business_glossary_term' = 'Rundown Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_version` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_version` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.rundown_version');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `rundown_version` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.rundown_version');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.scheduled_end_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.scheduled_end_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.scheduled_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.scheduled_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `scte35_cue_count` SET TAGS ('dbx_business_glossary_term' = 'SCTE-35 Cue Marker Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `scte35_cue_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `scte35_cue_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.scte35_cue_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `scte35_cue_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.scte35_cue_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `segment_count` SET TAGS ('dbx_business_glossary_term' = 'Segment Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `segment_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `segment_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.segment_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `segment_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.segment_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `simulcast_flag` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `simulcast_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `simulcast_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.simulcast_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `simulcast_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.simulcast_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `total_ad_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Advertising Time (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `total_ad_time_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `total_ad_time_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.total_ad_time_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `total_ad_time_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.total_ad_time_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `total_runtime_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Runtime (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `total_runtime_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `total_runtime_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.total_runtime_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `total_runtime_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.total_runtime_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `transmitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transmitted Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `transmitted_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `transmitted_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.transmitted_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `transmitted_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.transmitted_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `wide_orbit_log_code` SET TAGS ('dbx_business_glossary_term' = 'Wide Orbit Traffic Log ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `wide_orbit_log_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `wide_orbit_log_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.program_rundown.wide_orbit_log_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `wide_orbit_log_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.program_rundown.wide_orbit_log_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ALTER COLUMN `wide_orbit_log_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` SET TAGS ('dbx_subdomain' = 'channel_programming');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` SET TAGS ('dbx_fact_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` SET TAGS ('dbx_data_type' = 'fact_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.scheduling.rundown_item');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.scheduling.rundown_item');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` SET TAGS ('dbx_domain_ownership' = 'EPG; program schedule; slots; rundowns; ad breaks; dayparts; simulcast; playout (Ericsson MediaFirst)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` SET TAGS ('dbx_workload_mode' = 'Linear');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` SET TAGS ('dbx_protocols' = 'ATSC/DVB/QAM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `rundown_item_id` SET TAGS ('dbx_business_glossary_term' = 'Rundown Item ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `rundown_item_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `rundown_item_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.rundown_item_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `rundown_item_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.rundown_item_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Presenter / Anchor ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `program_rundown_id` SET TAGS ('dbx_business_glossary_term' = 'Program Rundown Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `program_rundown_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `program_rundown_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.program_rundown_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `program_rundown_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.program_rundown_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Program Schedule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.program_schedule_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.program_schedule_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `actual_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `actual_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `actual_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.actual_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `actual_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.actual_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.actual_end_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.actual_end_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.actual_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.actual_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `ad_pod_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `ad_pod_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `ad_pod_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.ad_pod_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `ad_pod_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.ad_pod_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `ad_pod_flag` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `ad_pod_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `ad_pod_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.ad_pod_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `ad_pod_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.ad_pod_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `ad_pod_spot_count` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Spot Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `ad_pod_spot_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `ad_pod_spot_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.ad_pod_spot_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `ad_pod_spot_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.ad_pod_spot_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `backtime_flag` SET TAGS ('dbx_business_glossary_term' = 'Backtime Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `backtime_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `backtime_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.backtime_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `backtime_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.backtime_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_business_glossary_term' = 'Blackout Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.blackout_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.blackout_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `content_rating` SET TAGS ('dbx_value_regex' = 'TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `content_rating` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `content_rating` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.content_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `content_rating` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.content_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `content_rating` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `cue_text` SET TAGS ('dbx_business_glossary_term' = 'Cue Text');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `cue_text` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `cue_text` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.cue_text');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `cue_text` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.cue_text');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `dalet_asset_code` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `dalet_asset_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `dalet_asset_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.dalet_asset_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `dalet_asset_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.dalet_asset_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `dalet_asset_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `daypart_code` SET TAGS ('dbx_business_glossary_term' = 'Daypart Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `daypart_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `daypart_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.daypart_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `daypart_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.daypart_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `daypart_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `duration_variance_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration Variance (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `duration_variance_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `duration_variance_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.duration_variance_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `duration_variance_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.duration_variance_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `eom_timecode` SET TAGS ('dbx_business_glossary_term' = 'End of Message (EOM) Timecode');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `eom_timecode` SET TAGS ('dbx_value_regex' = '^d{2}:d{2}:d{2}[;:]d{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `eom_timecode` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `eom_timecode` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.eom_timecode');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `eom_timecode` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.eom_timecode');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `epg_description` SET TAGS ('dbx_business_glossary_term' = 'Electronic Program Guide (EPG) Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `epg_description` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `epg_description` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.epg_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `epg_description` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.epg_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `graphics_template_code` SET TAGS ('dbx_business_glossary_term' = 'Graphics Template ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `graphics_template_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `graphics_template_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.graphics_template_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `graphics_template_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.graphics_template_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `graphics_template_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `isci_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Standard Commercial Identification (ISCI) Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `isci_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `isci_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `isci_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.isci_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `isci_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.isci_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `isci_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `item_status` SET TAGS ('dbx_business_glossary_term' = 'Rundown Item Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `item_status` SET TAGS ('dbx_value_regex' = 'ready|on_air|completed|skipped|hold|missing');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `item_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `item_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.item_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `item_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.item_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `item_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `item_title` SET TAGS ('dbx_business_glossary_term' = 'Rundown Item Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `item_title` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `item_title` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.item_title');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `item_title` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.item_title');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `item_type` SET TAGS ('dbx_business_glossary_term' = 'Rundown Item Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `item_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `item_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.item_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `item_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.item_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `item_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `live_flag` SET TAGS ('dbx_business_glossary_term' = 'Live Broadcast Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `live_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `live_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.live_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `live_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.live_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `mediafirst_item_code` SET TAGS ('dbx_business_glossary_term' = 'Ericsson MediaFirst Item ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `mediafirst_item_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `mediafirst_item_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.mediafirst_item_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `mediafirst_item_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.mediafirst_item_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `mediafirst_item_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `planned_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `planned_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `planned_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.planned_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `planned_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.planned_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `planned_start_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `planned_start_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `planned_start_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.planned_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `planned_start_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.planned_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|restricted|expired|not_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.rights_clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.rights_clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `scte35_cue_in_time` SET TAGS ('dbx_business_glossary_term' = 'SCTE-35 Cue In Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `scte35_cue_in_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `scte35_cue_in_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.scte35_cue_in_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `scte35_cue_in_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.scte35_cue_in_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `scte35_cue_out_time` SET TAGS ('dbx_business_glossary_term' = 'SCTE-35 Cue Out Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `scte35_cue_out_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `scte35_cue_out_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.scte35_cue_out_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `scte35_cue_out_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.scte35_cue_out_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `segment_format` SET TAGS ('dbx_business_glossary_term' = 'Segment Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `segment_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `segment_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.segment_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `segment_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.segment_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `segment_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Rundown Sequence Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `sequence_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `sequence_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.sequence_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `sequence_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.sequence_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `simulcast_flag` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `simulcast_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `simulcast_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.simulcast_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `simulcast_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.simulcast_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `skip_reason` SET TAGS ('dbx_business_glossary_term' = 'Skip Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `skip_reason` SET TAGS ('dbx_value_regex' = 'rights_issue|technical_fault|editorial_decision|time_overrun|duplicate|not_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `skip_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `skip_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.skip_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `skip_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.skip_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `som_timecode` SET TAGS ('dbx_business_glossary_term' = 'Start of Message (SOM) Timecode');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `som_timecode` SET TAGS ('dbx_value_regex' = '^d{2}:d{2}:d{2}[;:]d{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `som_timecode` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `som_timecode` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.som_timecode');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `som_timecode` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.som_timecode');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `tape_number` SET TAGS ('dbx_business_glossary_term' = 'Tape / Media ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `tape_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `tape_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.tape_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `tape_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.tape_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `wide_orbit_spot_code` SET TAGS ('dbx_business_glossary_term' = 'Wide Orbit Spot ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `wide_orbit_spot_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `wide_orbit_spot_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.rundown_item.wide_orbit_spot_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `wide_orbit_spot_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.rundown_item.wide_orbit_spot_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ALTER COLUMN `wide_orbit_spot_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` SET TAGS ('dbx_subdomain' = 'channel_programming');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` SET TAGS ('dbx_ssot_canonical' = 'rights.rights_availability_window');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` SET TAGS ('dbx_data_type' = 'fact_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.scheduling.scheduling_availability_window');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` SET TAGS ('dbx_ssot_ref' = 'rights.rights_availability_window');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` SET TAGS ('dbx_domain_ownership' = 'EPG; program schedule; slots; rundowns; ad breaks; dayparts; simulcast; playout (Ericsson MediaFirst)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` SET TAGS ('dbx_workload_mode' = 'VOD_windowing');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` SET TAGS ('dbx_protocols' = 'Window_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `scheduling_availability_window_id` SET TAGS ('dbx_business_glossary_term' = 'Availability Window Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `scheduling_availability_window_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `scheduling_availability_window_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.scheduling_availability_window_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `scheduling_availability_window_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.scheduling_availability_window_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `compliance_consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `compliance_consent_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `compliance_consent_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.compliance_consent_record_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `compliance_consent_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.compliance_consent_record_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.ott_platform_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.ott_platform_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `rights_availability_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Window ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `rights_availability_window_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `rights_availability_window_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.rights_availability_window_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `rights_availability_window_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.rights_availability_window_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `title_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `title_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `title_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `ad_break_max_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Ad Break Maximum Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `ad_break_max_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `ad_break_max_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.ad_break_max_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `ad_break_max_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.ad_break_max_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `ad_pod_max_count` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Maximum Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `ad_pod_max_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `ad_pod_max_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.ad_pod_max_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `ad_pod_max_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.ad_pod_max_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `akamai_stream_url` SET TAGS ('dbx_business_glossary_term' = 'Akamai CDN Stream URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `akamai_stream_url` SET TAGS ('dbx_value_regex' = '^https://[a-zA-Z0-9._/-]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `akamai_stream_url` SET TAGS ('dbx_validation_regex_^https?' = '//[^s]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `akamai_stream_url` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `akamai_stream_url` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.akamai_stream_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `akamai_stream_url` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.akamai_stream_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `approved_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `approved_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.approved_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `approved_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.approved_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.approved_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.approved_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_business_glossary_term' = 'Blackout Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.blackout_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.blackout_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `content_rating` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `content_rating` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.content_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `content_rating` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.content_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `content_rating` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `coppa_restricted` SET TAGS ('dbx_business_glossary_term' = 'COPPA Restricted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `coppa_restricted` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `coppa_restricted` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.coppa_restricted');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `coppa_restricted` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.coppa_restricted');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.dai_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.dai_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `dalet_asset_code` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `dalet_asset_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,50}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `dalet_asset_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `dalet_asset_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.dalet_asset_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `dalet_asset_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.dalet_asset_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `dalet_asset_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `drm_required` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `drm_required` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `drm_required` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.drm_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `drm_required` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.drm_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `eidr_code` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `eidr_code` SET TAGS ('dbx_value_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `eidr_code` SET TAGS ('dbx_validation_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `eidr_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `eidr_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.eidr_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `eidr_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.eidr_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `eidr_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `exclusive_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `exclusive_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `exclusive_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.exclusive_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `exclusive_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.exclusive_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `holdback_flag` SET TAGS ('dbx_business_glossary_term' = 'Holdback Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `holdback_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `holdback_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.holdback_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `holdback_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.holdback_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `isan` SET TAGS ('dbx_value_regex' = '^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `isan` SET TAGS ('dbx_validation_regex' = '^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `isan` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `isan` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.isan');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `isan` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.isan');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type (VOD Model)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `platform_type` SET TAGS ('dbx_value_regex' = 'SVOD|AVOD|TVOD|FAST|MVPD|vMVPD');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `platform_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `platform_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.platform_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `platform_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.platform_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `platform_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|blocked|expired|not_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.rights_clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.rights_clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `rightsline_window_ref` SET TAGS ('dbx_business_glossary_term' = 'Rightsline Window Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `rightsline_window_ref` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,50}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `rightsline_window_ref` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `rightsline_window_ref` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.rightsline_window_ref');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `rightsline_window_ref` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.rightsline_window_ref');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `scte35_cue_enabled` SET TAGS ('dbx_business_glossary_term' = 'SCTE-35 Cue Marker Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `scte35_cue_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `scte35_cue_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.scte35_cue_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `scte35_cue_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.scte35_cue_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `service_tier_code` SET TAGS ('dbx_business_glossary_term' = 'Service Tier Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `service_tier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `service_tier_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `service_tier_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.service_tier_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `service_tier_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.service_tier_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `service_tier_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `simulcast_flag` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `simulcast_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `simulcast_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.simulcast_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `simulcast_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.simulcast_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `stagger_offset_days` SET TAGS ('dbx_business_glossary_term' = 'Stagger Offset Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `stagger_offset_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `stagger_offset_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.stagger_offset_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `stagger_offset_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.stagger_offset_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'HLS|MPEG-DASH|HLS_DASH|SMOOTH|PROGRESSIVE');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.streaming_protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.streaming_protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Territory Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `territory_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `territory_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.territory_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `territory_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.territory_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `territory_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `territory_scope` SET TAGS ('dbx_value_regex' = 'worldwide|regional|national|local|excluded');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `territory_scope` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `territory_scope` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.territory_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `territory_scope` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.territory_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_close_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Window Close Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_close_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_close_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.window_close_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_close_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.window_close_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_code` SET TAGS ('dbx_business_glossary_term' = 'Availability Window Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,40}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.window_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.window_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Window Duration (Days)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_duration_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_duration_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.window_duration_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_duration_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.window_duration_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_notes` SET TAGS ('dbx_business_glossary_term' = 'Availability Window Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.window_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.window_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_open_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Window Open Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_open_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_open_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.window_open_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_open_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.window_open_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Window Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|expired|cancelled|suspended');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.window_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.window_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `window_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Windowing Strategy');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_value_regex' = 'day_and_date|staggered|exclusive|holdback|rolling|simultaneous');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.scheduling_availability_window.windowing_strategy');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.scheduling_availability_window.windowing_strategy');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` SET TAGS ('dbx_subdomain' = 'carriage_distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` SET TAGS ('dbx_association_edges' = 'scheduling.channel,distribution.ott_platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` SET TAGS ('dbx_data_type' = 'bridge_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.scheduling.channel_carriage');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.scheduling.channel_carriage');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` SET TAGS ('dbx_domain_ownership' = 'EPG; program schedule; slots; rundowns; ad breaks; dayparts; simulcast; playout (Ericsson MediaFirst)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` SET TAGS ('dbx_workload_mode' = 'MVPD_vMVPD_carriage');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` SET TAGS ('dbx_protocols' = 'Carriage_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `channel_carriage_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Carriage Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `channel_carriage_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `channel_carriage_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_carriage.channel_carriage_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `channel_carriage_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_carriage.channel_carriage_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Carriage - Channel Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_carriage.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_carriage.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Carriage - Ott Platform Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_carriage.ott_platform_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_carriage.ott_platform_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_carriage._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_carriage._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_carriage._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_carriage._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `blackout_rules_override` SET TAGS ('dbx_business_glossary_term' = 'Blackout Rules Override');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `blackout_rules_override` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `blackout_rules_override` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_carriage.blackout_rules_override');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `blackout_rules_override` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_carriage.blackout_rules_override');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee USD');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_carriage.carriage_fee_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_carriage.carriage_fee_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `carriage_status` SET TAGS ('dbx_business_glossary_term' = 'Carriage Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `carriage_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `carriage_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_carriage.carriage_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `carriage_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_carriage.carriage_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `carriage_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_carriage.contract_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_carriage.contract_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_carriage.contract_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_carriage.contract_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_carriage.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_carriage.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `dai_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `dai_enabled_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `dai_enabled_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_carriage.dai_enabled_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `dai_enabled_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_carriage.dai_enabled_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `epg_sync_enabled` SET TAGS ('dbx_business_glossary_term' = 'EPG Sync Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `epg_sync_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `epg_sync_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_carriage.epg_sync_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `epg_sync_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_carriage.epg_sync_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `platform_channel_number` SET TAGS ('dbx_business_glossary_term' = 'Platform Channel Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `platform_channel_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `platform_channel_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_carriage.platform_channel_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `platform_channel_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_carriage.platform_channel_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `platform_display_name` SET TAGS ('dbx_business_glossary_term' = 'Platform Display Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `platform_display_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `platform_display_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `platform_display_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_carriage.platform_display_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `platform_display_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_carriage.platform_display_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `priority_rank` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `priority_rank` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_carriage.priority_rank');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `priority_rank` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_carriage.priority_rank');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `simulcast_enabled` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `simulcast_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `simulcast_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_carriage.simulcast_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `simulcast_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_carriage.simulcast_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `simulcast_end_date` SET TAGS ('dbx_business_glossary_term' = 'Simulcast End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `simulcast_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `simulcast_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_carriage.simulcast_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `simulcast_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_carriage.simulcast_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `simulcast_start_date` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `simulcast_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `simulcast_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_carriage.simulcast_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `simulcast_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_carriage.simulcast_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_carriage._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_carriage._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_carriage.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_carriage.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_carriage.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_carriage.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` SET TAGS ('dbx_subdomain' = 'carriage_distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` SET TAGS ('dbx_association_edges' = 'scheduling.channel,advertising.campaign');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` SET TAGS ('dbx_fact_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` SET TAGS ('dbx_data_type' = 'fact_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.scheduling.channel_allocation');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.scheduling.channel_allocation');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` SET TAGS ('dbx_domain_ownership' = 'EPG; program schedule; slots; rundowns; ad breaks; dayparts; simulcast; playout (Ericsson MediaFirst)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` SET TAGS ('dbx_workload_mode' = 'Linear');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` SET TAGS ('dbx_protocols' = 'ATSC/DVB/QAM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` SET TAGS ('dbx_fact_dim_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` SET TAGS ('dbx_star_schema' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `channel_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Allocation ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `channel_allocation_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `channel_allocation_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_allocation.channel_allocation_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `channel_allocation_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_allocation.channel_allocation_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Allocation - Campaign Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_allocation.campaign_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_allocation.campaign_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Allocation - Channel Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_allocation.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_allocation.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_allocation._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_allocation._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_allocation._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_allocation._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `actual_grp_delivered` SET TAGS ('dbx_business_glossary_term' = 'Actual GRP Delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `actual_grp_delivered` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `actual_grp_delivered` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_allocation.actual_grp_delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `actual_grp_delivered` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_allocation.actual_grp_delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `actual_spots_aired` SET TAGS ('dbx_business_glossary_term' = 'Actual Spots Aired');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `actual_spots_aired` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `actual_spots_aired` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_allocation.actual_spots_aired');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `actual_spots_aired` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_allocation.actual_spots_aired');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `allocated_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Budget Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `allocated_budget_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `allocated_budget_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_allocation.allocated_budget_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `allocated_budget_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_allocation.allocated_budget_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_allocation.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_allocation.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_allocation.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_allocation.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_business_glossary_term' = 'Daypart Mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_allocation.daypart_mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_allocation.daypart_mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `delivery_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `delivery_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_allocation.delivery_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `delivery_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_allocation.delivery_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `delivery_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_allocation.flight_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_allocation.flight_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_allocation.flight_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_allocation.flight_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_allocation.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_allocation.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_allocation._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_allocation._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_allocation.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_allocation.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `spot_count` SET TAGS ('dbx_business_glossary_term' = 'Spot Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `spot_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `spot_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_allocation.spot_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `spot_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_allocation.spot_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `target_grp` SET TAGS ('dbx_business_glossary_term' = 'Target GRP');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `target_grp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `target_grp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_allocation.target_grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `target_grp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_allocation.target_grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_allocation.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_allocation.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` SET TAGS ('dbx_subdomain' = 'carriage_distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` SET TAGS ('dbx_association_edges' = 'content.title,scheduling.channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` SET TAGS ('dbx_star_schema_role' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` SET TAGS ('dbx_data_type' = 'dimension_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.scheduling.channel_license');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.scheduling.channel_license');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` SET TAGS ('dbx_domain_ownership' = 'EPG; program schedule; slots; rundowns; ad breaks; dayparts; simulcast; playout (Ericsson MediaFirst)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` SET TAGS ('dbx_workload_mode' = 'Linear');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` SET TAGS ('dbx_protocols' = 'ATSC/DVB/QAM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `channel_license_id` SET TAGS ('dbx_business_glossary_term' = 'Channel License ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `channel_license_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `channel_license_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_license.channel_license_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `channel_license_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_license.channel_license_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel License - Channel Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_license.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_license.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Channel License - Title Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `title_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `title_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_license.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `title_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_license.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_license._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_license._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_license._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_license._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_license.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_license.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_license.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_license.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_license.exclusivity_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_license.exclusivity_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `license_end_date` SET TAGS ('dbx_business_glossary_term' = 'License End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `license_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `license_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_license.license_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `license_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_license.license_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `license_fee_usd` SET TAGS ('dbx_business_glossary_term' = 'License Fee USD');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `license_fee_usd` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `license_fee_usd` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `license_fee_usd` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_license.license_fee_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `license_fee_usd` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_license.license_fee_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `license_start_date` SET TAGS ('dbx_business_glossary_term' = 'License Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `license_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `license_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_license.license_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `license_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_license.license_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `license_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `license_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_license.license_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `license_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_license.license_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `license_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `runs_allowed` SET TAGS ('dbx_business_glossary_term' = 'Runs Allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `runs_allowed` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `runs_allowed` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_license.runs_allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `runs_allowed` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_license.runs_allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `runs_consumed` SET TAGS ('dbx_business_glossary_term' = 'Runs Consumed');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `runs_consumed` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `runs_consumed` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_license.runs_consumed');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `runs_consumed` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_license.runs_consumed');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_license._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_license._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_license.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_license.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `territory_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `territory_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_license.territory_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `territory_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_license.territory_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `territory_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_license.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_license.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_license.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_license.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` SET TAGS ('dbx_subdomain' = 'playout_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` SET TAGS ('dbx_association_edges' = 'scheduling.channel,mediaasset.media_asset');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` SET TAGS ('dbx_fact_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` SET TAGS ('dbx_data_type' = 'dimension_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.scheduling.channel_asset_playout');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.scheduling.channel_asset_playout');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` SET TAGS ('dbx_domain_ownership' = 'EPG; program schedule; slots; rundowns; ad breaks; dayparts; simulcast; playout (Ericsson MediaFirst)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` SET TAGS ('dbx_workload_mode' = 'Linear');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` SET TAGS ('dbx_protocols' = 'ATSC/DVB/QAM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `channel_asset_playout_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Asset Playout Configuration ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `channel_asset_playout_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `channel_asset_playout_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_asset_playout.channel_asset_playout_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `channel_asset_playout_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_asset_playout.channel_asset_playout_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Asset Playout - Channel Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_asset_playout.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_asset_playout.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Asset Playout - Media Asset Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_asset_playout.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_asset_playout.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_asset_playout._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_asset_playout._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_asset_playout._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_asset_playout._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `active_from_date` SET TAGS ('dbx_business_glossary_term' = 'Active From Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `active_from_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `active_from_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_asset_playout.active_from_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `active_from_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_asset_playout.active_from_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `active_to_date` SET TAGS ('dbx_business_glossary_term' = 'Active To Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `active_to_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `active_to_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_asset_playout.active_to_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `active_to_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_asset_playout.active_to_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `air_count` SET TAGS ('dbx_business_glossary_term' = 'Total Air Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `air_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `air_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_asset_playout.air_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `air_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_asset_playout.air_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `backup_asset_flag` SET TAGS ('dbx_business_glossary_term' = 'Backup Asset Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `backup_asset_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `backup_asset_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_asset_playout.backup_asset_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `backup_asset_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_asset_playout.backup_asset_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `channel_specific_version` SET TAGS ('dbx_business_glossary_term' = 'Channel-Specific Asset Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `channel_specific_version` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `channel_specific_version` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_asset_playout.channel_specific_version');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `channel_specific_version` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_asset_playout.channel_specific_version');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_asset_playout.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_asset_playout.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_asset_playout.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_asset_playout.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `last_aired_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Aired Date and Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `last_aired_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `last_aired_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_asset_playout.last_aired_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `last_aired_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_asset_playout.last_aired_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `max_plays_per_day` SET TAGS ('dbx_business_glossary_term' = 'Maximum Daily Play Limit');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `max_plays_per_day` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `max_plays_per_day` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_asset_playout.max_plays_per_day');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `max_plays_per_day` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_asset_playout.max_plays_per_day');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `min_hours_between_plays` SET TAGS ('dbx_business_glossary_term' = 'Minimum Hours Between Plays');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `min_hours_between_plays` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `min_hours_between_plays` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_asset_playout.min_hours_between_plays');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `min_hours_between_plays` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_asset_playout.min_hours_between_plays');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `playout_priority` SET TAGS ('dbx_business_glossary_term' = 'Playout Priority Rank');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `playout_priority` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `playout_priority` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_asset_playout.playout_priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `playout_priority` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_asset_playout.playout_priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `playout_status` SET TAGS ('dbx_business_glossary_term' = 'Playout Configuration Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `playout_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `playout_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_asset_playout.playout_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `playout_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_asset_playout.playout_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `playout_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_asset_playout._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_asset_playout._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_asset_playout.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_asset_playout.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_asset_playout.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_asset_playout.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_asset_playout.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_asset_playout.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` SET TAGS ('dbx_subdomain' = 'playout_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` SET TAGS ('dbx_association_edges' = 'scheduling.channel,distribution.abr_profile');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` SET TAGS ('dbx_fact_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` SET TAGS ('dbx_data_type' = 'bridge_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.scheduling.channel_abr_assignment');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.scheduling.channel_abr_assignment');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` SET TAGS ('dbx_domain_ownership' = 'EPG; program schedule; slots; rundowns; ad breaks; dayparts; simulcast; playout (Ericsson MediaFirst)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` SET TAGS ('dbx_workload_mode' = 'OTT');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` SET TAGS ('dbx_protocols' = 'HLS/MPEG-DASH/ABR/DRM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` SET TAGS ('dbx_fact_dim_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` SET TAGS ('dbx_star_schema' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `channel_abr_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ABR Assignment Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `channel_abr_assignment_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `channel_abr_assignment_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_abr_assignment.channel_abr_assignment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `channel_abr_assignment_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_abr_assignment.channel_abr_assignment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Abr Assignment - Abr Profile Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_abr_assignment.abr_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_abr_assignment.abr_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Abr Assignment - Channel Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_abr_assignment.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_abr_assignment.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_abr_assignment.employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_abr_assignment.employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_abr_assignment._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_abr_assignment._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_abr_assignment._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_abr_assignment._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_abr_assignment.assignment_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_abr_assignment.assignment_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_abr_assignment.assignment_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_abr_assignment.assignment_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_abr_assignment.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_abr_assignment.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_abr_assignment.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_abr_assignment.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `device_class_override` SET TAGS ('dbx_business_glossary_term' = 'Device Class Override');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `device_class_override` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `device_class_override` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_abr_assignment.device_class_override');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `device_class_override` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_abr_assignment.device_class_override');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_abr_assignment.effective_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_abr_assignment.effective_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_abr_assignment.effective_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_abr_assignment.effective_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `encoding_cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Encoding Cost Estimate');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `encoding_cost_estimate_usd` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `encoding_cost_estimate_usd` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_abr_assignment.encoding_cost_estimate_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `encoding_cost_estimate_usd` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_abr_assignment.encoding_cost_estimate_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_abr_assignment.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_abr_assignment.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Profile Priority Rank');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_abr_assignment.priority_rank');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_abr_assignment.priority_rank');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `qos_tier` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `qos_tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `qos_tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_abr_assignment.qos_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `qos_tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_abr_assignment.qos_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `qos_tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_abr_assignment._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_abr_assignment._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_abr_assignment.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_abr_assignment.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_abr_assignment.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_abr_assignment.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` SET TAGS ('dbx_subdomain' = 'carriage_distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` SET TAGS ('dbx_association_edges' = 'scheduling.channel,audience.demographic_segment');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` SET TAGS ('dbx_star_schema_role' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` SET TAGS ('dbx_data_type' = 'dimension_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.scheduling.channel_targeting');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.scheduling.channel_targeting');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` SET TAGS ('dbx_domain_ownership' = 'EPG; program schedule; slots; rundowns; ad breaks; dayparts; simulcast; playout (Ericsson MediaFirst)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` SET TAGS ('dbx_workload_mode' = 'Linear');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` SET TAGS ('dbx_protocols' = 'ATSC/DVB/QAM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `channel_targeting_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Targeting Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `channel_targeting_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `channel_targeting_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_targeting.channel_targeting_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `channel_targeting_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_targeting.channel_targeting_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Targeting - Channel Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_targeting.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_targeting.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Targeting - Demographic Segment Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_targeting.demographic_segment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_targeting.demographic_segment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_targeting._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_targeting._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_targeting._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_targeting._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_targeting.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_targeting.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_targeting.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_targeting.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `daypart_strategy` SET TAGS ('dbx_business_glossary_term' = 'Daypart Targeting Strategy');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `daypart_strategy` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `daypart_strategy` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_targeting.daypart_strategy');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `daypart_strategy` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_targeting.daypart_strategy');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Targeting Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `effective_from` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `effective_from` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_targeting.effective_from');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `effective_from` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_targeting.effective_from');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Targeting Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `effective_until` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `effective_until` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_targeting.effective_until');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `effective_until` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_targeting.effective_until');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `guaranteed_grp` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Gross Rating Points');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `guaranteed_grp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `guaranteed_grp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_targeting.guaranteed_grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `guaranteed_grp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_targeting.guaranteed_grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `is_primary_target` SET TAGS ('dbx_business_glossary_term' = 'Primary Target Demographic Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `is_primary_target` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `is_primary_target` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_targeting.is_primary_target');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `is_primary_target` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_targeting.is_primary_target');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Multiplier');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `rate_multiplier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `rate_multiplier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_targeting.rate_multiplier');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `rate_multiplier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_targeting.rate_multiplier');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_targeting._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_targeting._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_targeting.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_targeting.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `target_rating` SET TAGS ('dbx_business_glossary_term' = 'Target Rating Point');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `target_rating` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `target_rating` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_targeting.target_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `target_rating` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_targeting.target_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `targeting_status` SET TAGS ('dbx_business_glossary_term' = 'Targeting Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `targeting_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `targeting_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_targeting.targeting_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `targeting_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_targeting.targeting_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `targeting_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_targeting.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_targeting.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.channel_targeting.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.channel_targeting.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` SET TAGS ('dbx_subdomain' = 'playout_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` SET TAGS ('dbx_association_edges' = 'scheduling.daypart,workforce.employee');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` SET TAGS ('dbx_fact_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` SET TAGS ('dbx_data_type' = 'bridge_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.scheduling.daypart_assignment');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.scheduling.daypart_assignment');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` SET TAGS ('dbx_domain_ownership' = 'EPG; program schedule; slots; rundowns; ad breaks; dayparts; simulcast; playout (Ericsson MediaFirst)');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` SET TAGS ('dbx_workload_mode' = 'Linear');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` SET TAGS ('dbx_protocols' = 'ATSC/DVB/QAM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` SET TAGS ('dbx_fact_dim_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` SET TAGS ('dbx_star_schema' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `daypart_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Assignment ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `daypart_assignment_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `daypart_assignment_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart_assignment.daypart_assignment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `daypart_assignment_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart_assignment.daypart_assignment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `daypart_backup_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `daypart_backup_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `daypart_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `daypart_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `daypart_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `daypart_employee_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `daypart_employee_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart_assignment.employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `daypart_employee_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart_assignment.employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `daypart_supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `daypart_supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `daypart_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `daypart_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart_assignment.scheduling_daypart_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `daypart_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart_assignment.scheduling_daypart_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart_assignment._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart_assignment._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart_assignment._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart_assignment._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart_assignment.assignment_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart_assignment.assignment_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart_assignment.assignment_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart_assignment.assignment_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart_assignment.assignment_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart_assignment.assignment_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart_assignment.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart_assignment.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart_assignment.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart_assignment.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `days_of_week` SET TAGS ('dbx_business_glossary_term' = 'Days of Week');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `days_of_week` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `days_of_week` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart_assignment.days_of_week');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `days_of_week` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart_assignment.days_of_week');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `primary_daypart_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Daypart Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `primary_daypart_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `primary_daypart_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart_assignment.primary_daypart_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `primary_daypart_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart_assignment.primary_daypart_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `shift_role` SET TAGS ('dbx_business_glossary_term' = 'Shift Role');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `shift_role` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `shift_role` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart_assignment.shift_role');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `shift_role` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart_assignment.shift_role');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart_assignment._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart_assignment._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart_assignment.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart_assignment.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart_assignment.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart_assignment.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.daypart_assignment.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.daypart_assignment.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` SET TAGS ('dbx_subdomain' = 'channel_programming');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` SET TAGS ('dbx_reference_data' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` SET TAGS ('dbx_lookup' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` SET TAGS ('dbx_enum_materialized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` SET TAGS ('dbx_star_schema_role' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` SET TAGS ('dbx_data_type' = 'dimension_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.scheduling.schedule_status_ref');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.scheduling.schedule_status_ref');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `schedule_status_ref_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `schedule_status_ref_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_status_ref.schedule_status_ref_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `schedule_status_ref_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_status_ref.schedule_status_ref_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_relationship' = 'siloed_fix');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_status_ref._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_status_ref._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_status_ref._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_status_ref._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_status_ref.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_status_ref.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_status_ref.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_status_ref.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `is_active_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_status_ref.is_active_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `is_active_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_status_ref.is_active_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `sort_order` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_status_ref.sort_order');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `sort_order` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_status_ref.sort_order');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_status_ref._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_status_ref._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_status_ref.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_status_ref.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `status_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_status_ref.status_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `status_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_status_ref.status_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `status_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `status_description` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_status_ref.status_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `status_description` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_status_ref.status_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `status_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `status_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_status_ref.status_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `status_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_status_ref.status_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_status_ref.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_status_ref.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.scheduling.schedule_status_ref.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_status_ref` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.scheduling.schedule_status_ref.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_network_clearance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_network_clearance` SET TAGS ('dbx_subdomain' = 'carriage_distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_network_clearance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_network_clearance` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_network_clearance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_network_clearance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_local_avail_inventory` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_local_avail_inventory` SET TAGS ('dbx_subdomain' = 'carriage_distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_local_avail_inventory` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_local_avail_inventory` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_local_avail_inventory` ALTER COLUMN `distribution_local_avail_inventory_id` SET TAGS ('dbx_ssot_owner' = 'distribution.distribution_local_avail_inventory.distribution_local_avail_inventory_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_local_avail_inventory` ALTER COLUMN `distribution_local_avail_inventory_id` SET TAGS ('dbx_ssot_entity' = 'local_avail_inventory');
