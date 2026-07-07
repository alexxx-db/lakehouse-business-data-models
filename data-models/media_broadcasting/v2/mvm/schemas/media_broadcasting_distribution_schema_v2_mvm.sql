-- Schema for Domain: distribution | Business: Media_Broadcasting | Version: v2_mvm
-- Generated on: 2026-06-30 06:39:03

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`distribution` COMMENT 'Governs multi-platform content delivery across linear broadcast (DVB, ATSC, QAM), OTT streaming (HLS, MPEG-DASH, ABR), MVPD/vMVPD carriage, FAST channel syndication, and OTT platform infrastructure. Manages CDN configuration, DRM enforcement, DAI, streaming endpoints, ABR profiles, device support, QoS monitoring, and all delivery SLAs.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` (
    `ott_platform_id` BIGINT COMMENT 'Unique surrogate identifier for each OTT service platform record in the master registry. Primary key for the ott_platform entity — all downstream distribution products reference this key. | Column ott_platform_id (BIGINT) in distribution.ott_platform',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in distribution.ott_platform',
    `_source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in distribution.ott_platform',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in distribution.ott_platform',
    `adobe_property_code` STRING COMMENT 'The unique property identifier assigned to this OTT platform within Adobe Experience Platform (AEP) for audience data collection, segmentation, and personalization. Used to link platform-level engagement events to subscriber profiles and Nielsen cross-platform measurement. | Column adobe_property_code (STRING) in distribution.ott_platform',
    `arpu` DECIMAL(18,2) COMMENT 'Average monthly revenue generated per active subscriber on this platform, expressed in the platforms billing currency. Calculated at the platform level for strategic pricing and investor reporting. Confidential as a key financial performance indicator. Sourced from Zuora revenue recognition data. | Column arpu (DECIMAL(10,4)) in distribution.ott_platform',
    `base_subscription_price` DECIMAL(18,2) COMMENT 'The standard monthly subscription price for this platform in the billing currency. Applicable for SVOD and HYBRID tiers. Null for AVOD and FAST platforms with no subscription fee. Used in Zuora plan configuration and financial forecasting in SAP S/4HANA. | Column base_subscription_price (DECIMAL(10,2)) in distribution.ott_platform',
    `billing_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the primary billing currency used on this platform (e.g., USD, GBP, EUR). Governs Zuora subscription plan pricing, SAP S/4HANA financial reconciliation, and multi-currency revenue reporting. | Column billing_currency (STRING) in distribution.ott_platform. Valid values are `^[A-Z]{3}$`',
    `cdn_origin_url` STRING COMMENT 'The base origin URL configured in the CDN for this platforms content delivery. Used by Akamai CDN to route requests to the correct media origin server. Critical for CDN configuration audits and incident troubleshooting. | Column cdn_origin_url (STRING) in distribution.ott_platform. Valid values are `^https?://[a-zA-Z0-9._/-]+$`',
    `cdn_provider` STRING COMMENT 'The primary CDN provider contracted to deliver streaming content for this OTT platform. Drives SLA monitoring, peering agreements, and cost allocation. Multi-CDN indicates a load-balanced or failover configuration across multiple providers. Maps to Akamai CDN platform configuration records. | Column cdn_provider (STRING) in distribution.ott_platform. Valid values are `Akamai|Cloudflare|AWS CloudFront|Fastly|Multi-CDN`',
    `content_rating_system` STRING COMMENT 'The content classification and rating system applied to content on this platform (e.g., MPAA for USA, BBFC for UK, FSK for Germany). Governs parental control enforcement, COPPA compliance for childrens content, and MPA anti-piracy obligations. | Column content_rating_system (STRING) in distribution.ott_platform. Valid values are `MPAA|BBFC|FSK|ACB|CBFC|TV-PG`',
    `coppa_compliant` BOOLEAN COMMENT 'Indicates whether this platform is designated as COPPA-compliant, meaning it is directed at children under 13 and adheres to COPPA data collection restrictions. True = COPPA-compliant childrens platform; False = general audience platform. Drives data collection policies in Adobe Experience Platform and ad targeting restrictions. | Column coppa_compliant (BOOLEAN) in distribution.ott_platform',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in distribution.ott_platform',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this OTT platform record was first created in the master registry. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for data lineage, audit trails, and Silver layer ingestion tracking. | Column created_timestamp (TIMESTAMP) in distribution.ott_platform',
    `dai_enabled` BOOLEAN COMMENT 'Indicates whether Dynamic Ad Insertion is active on this platform, enabling server-side ad stitching into the stream. True = DAI active (relevant for AVOD and HYBRID tiers); False = no DAI. Drives ad operations workflow in Wide Orbit and ad campaign targeting in Salesforce Media Cloud. | Column dai_enabled (BOOLEAN) in distribution.ott_platform',
    `dai_provider` STRING COMMENT 'The technology vendor or platform providing DAI services for this OTT platform (e.g., Google DAI, FreeWheel, Yospace, Brightcove SSAI). Null if DAI is not enabled. Used for vendor management, SLA tracking, and ad revenue reconciliation. | Column dai_provider (STRING) in distribution.ott_platform',
    `distribution_verified` BOOLEAN COMMENT 'Flag indicating distribution verification',
    `drm_system` STRING COMMENT 'The DRM technology binding enforced on this platform for content protection. Widevine = Google DRM for Android/Chrome; FairPlay = Apple DRM for iOS/Safari; PlayReady = Microsoft DRM for Windows/Xbox; Multi-DRM = all three enforced simultaneously; NONE = no DRM (e.g., FAST free content). Directly linked to Rightsline rights window enforcement and content clearance workflows. | Column drm_system (STRING) in distribution.ott_platform. Valid values are `Widevine|FairPlay|PlayReady|Multi-DRM|NONE`',
    `epg_feed_url` STRING COMMENT 'The URL of the Electronic Program Guide data feed for this platform, used by third-party EPG aggregators, smart TV manufacturers, and vMVPD partners to display scheduling information. Null for pure VOD platforms without a linear schedule. Sourced from Ericsson MediaFirst playout system. | Column epg_feed_url (STRING) in distribution.ott_platform. Valid values are `^https?://[a-zA-Z0-9._/-]+$`',
    `fast_channel_enabled` BOOLEAN COMMENT 'Indicates whether this platform operates or hosts FAST channels — linear-style, ad-supported free streaming channels. True = FAST channel delivery active; False = no FAST channel. Relevant for FAST syndication partnerships and Wide Orbit ad scheduling. | Column fast_channel_enabled (BOOLEAN) in distribution.ott_platform',
    `free_trial_days` STRING COMMENT 'Number of days in the free trial period offered to new subscribers on this platform. Zero or null if no free trial is offered. Configured in Zuora subscription plans and used in churn rate and LTV analysis. | Column free_trial_days (INT) in distribution.ott_platform',
    `gdpr_applicable` BOOLEAN COMMENT 'Indicates whether GDPR data protection obligations apply to this platform based on its geographic availability and subscriber base. True = GDPR applies (EU/EEA territories served); False = GDPR not applicable. Governs consent management, data subject rights workflows, and Adobe Experience Platform profile handling. | Column gdpr_applicable (BOOLEAN) in distribution.ott_platform',
    `hdr_supported` BOOLEAN COMMENT 'Indicates whether the platform supports High Dynamic Range video delivery (HDR10, Dolby Vision, or HLG). True = HDR delivery supported; False = SDR only. Relevant for premium content licensing negotiations and CTV device compatibility. | Column hdr_supported (BOOLEAN) in distribution.ott_platform',
    `launch_date` DATE COMMENT 'The calendar date on which the OTT platform was officially made available to the public or target subscriber base. Used for platform age calculations, anniversary promotions, and regulatory reporting of service commencement. | Column launch_date (DATE) in distribution.ott_platform',
    `max_concurrent_streams` STRING COMMENT 'The maximum number of simultaneous streams permitted per subscriber account on this platform. Enforced at the entitlement layer to prevent credential sharing and manage CDN bandwidth capacity. A key parameter in Zuora subscription plan configuration. | Column max_concurrent_streams (INT) in distribution.ott_platform',
    `max_download_devices` STRING COMMENT 'The maximum number of devices on which a subscriber may store downloaded content for offline viewing on this platform. Null if offline downloads are not supported. Governed by DRM policy and Rightsline windowing rules. | Column max_download_devices (INT) in distribution.ott_platform',
    `max_video_resolution` STRING COMMENT 'The highest video resolution tier supported for streaming on this platform. SD = Standard Definition (480p); HD = High Definition (720p); FHD = Full HD (1080p); 4K = Ultra HD (2160p); 8K = Super Hi-Vision (4320p). Drives ABR profile configuration, CDN bandwidth planning, and content ingest specifications in Dalet Galaxy. | Column max_video_resolution (STRING) in distribution.ott_platform. Valid values are `SD|HD|FHD|4K|8K`',
    `mvpd_carriage_eligible` BOOLEAN COMMENT 'Indicates whether this OTT platforms content or channels are eligible for carriage by MVPD or vMVPD partners (cable, satellite, virtual pay-TV operators). True = eligible for carriage agreements; False = direct-to-consumer only. Governs retransmission consent and must-carry negotiations. | Column mvpd_carriage_eligible (BOOLEAN) in distribution.ott_platform',
    `parent_brand` STRING COMMENT 'The overarching corporate or media brand under which this OTT platform operates (e.g., Media Broadcasting Group, MB Sports Network). Supports brand hierarchy reporting, consolidated audience measurement, and multi-brand advertising sales in Salesforce Media Cloud. | Column parent_brand (STRING) in distribution.ott_platform',
    `platform_code` STRING COMMENT 'Externally-known, human-readable unique code assigned to the OTT platform (e.g., MB_SVOD_WEB, MB_AVOD_CTV). Used in operational systems, contracts, and partner integrations as the canonical platform identifier. Maps to the platform identifier used in Zuora subscription plans and Akamai CDN configuration. | Column platform_code (STRING) in distribution.ott_platform. Valid values are `^[A-Z0-9_]{2,30}$`',
    `platform_description` STRING COMMENT 'Detailed narrative description of the platforms content offering, target audience, and service proposition. Used in partner onboarding documentation, regulatory filings, and internal product catalogues. | Column platform_description (STRING) in distribution.ott_platform',
    `platform_name` STRING COMMENT 'Official commercial brand name of the OTT platform as presented to subscribers and partners (e.g., MediaBroadcast+, MB Sports Live). Used in marketing materials, EPG listings, and subscriber-facing interfaces. | Column platform_name (STRING) in distribution.ott_platform',
    `platform_status` STRING COMMENT 'Current lifecycle state of the OTT platform. active = live and serving audiences; beta = limited release for testing; sunset = scheduled for decommission; suspended = temporarily offline; inactive = decommissioned. Governs whether the platform is eligible for new subscriber acquisition, ad campaign targeting, and CDN resource allocation. | Column platform_status (STRING) in distribution.ott_platform. Valid values are `active|inactive|beta|sunset|suspended`',
    `primary_streaming_protocol` STRING COMMENT 'The primary adaptive bitrate streaming protocol used for content delivery on this platform. HLS = HTTP Live Streaming (Apple standard, widely supported); MPEG-DASH = Dynamic Adaptive Streaming over HTTP (ISO 23009 standard); RTMP = Real-Time Messaging Protocol (legacy live); SRT = Secure Reliable Transport (low-latency live). Drives CDN configuration in Akamai and player SDK selection. | Column primary_streaming_protocol (STRING) in distribution.ott_platform. Valid values are `HLS|MPEG-DASH|HLS,MPEG-DASH|RTMP|SRT`',
    `programmatic_enabled` BOOLEAN COMMENT 'Flag indicating programmatic advertising support',
    `service_tier` STRING COMMENT 'Business model classification of the OTT platform. SVOD = Subscription Video On Demand (recurring fee, no ads); AVOD = Advertising-Supported Video On Demand (free with ads); TVOD = Transactional Video On Demand (pay-per-view); FAST = Free Ad-Supported Streaming Television (linear-style free channel); HYBRID = combination of tiers. Drives revenue recognition logic in Zuora and ad inventory management in Wide Orbit. | Column service_tier (STRING) in distribution.ott_platform. Valid values are `SVOD|AVOD|TVOD|FAST|HYBRID`',
    `sla_uptime_target_pct` DECIMAL(18,2) COMMENT 'The contractually committed platform availability target expressed as a percentage (e.g., 99.95). Governs CDN SLA enforcement with Akamai, incident escalation thresholds, and operational reporting. Distinct from actual measured uptime. | Column sla_uptime_target_pct (DECIMAL(5,2)) in distribution.ott_platform',
    `source_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in distribution.ott_platform',
    `subscriber_count` BIGINT COMMENT 'Current count of active paying or registered subscribers on this platform as of the last reconciliation cycle. A key operational metric for ARPU calculation, churn rate monitoring, and Zuora revenue reporting. Confidential as it represents commercially sensitive business performance data. | Column subscriber_count (BIGINT) in distribution.ott_platform',
    `sunset_date` DATE COMMENT 'Planned or actual date on which the OTT platform will be or was decommissioned. Null if the platform has no scheduled end-of-life. Used for subscriber migration planning, contract wind-down, and CDN resource deallocation. | Column sunset_date (DATE) in distribution.ott_platform',
    `supported_device_classes` STRING COMMENT 'Comma-separated list of device categories supported by this platform (e.g., web,mobile,ctv,stb,gaming_console). Drives device compatibility testing, app store distribution, and audience reach reporting. [ENUM-REF-CANDIDATE: web|mobile|ctv|stb|gaming_console|smart_tv|tablet — promote to reference product] | Column supported_device_classes (STRING) in distribution.ott_platform',
    `target_start_bitrate_kbps` STRING COMMENT 'The minimum target bitrate in kilobits per second at which the ABR player should initiate playback on this platform. Drives ABR profile ladder configuration in Akamai CDN and QoS monitoring thresholds. Key parameter for streaming quality benchmarking. | Column target_start_bitrate_kbps (INT) in distribution.ott_platform',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in distribution.ott_platform',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this OTT platform record was most recently modified. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture (CDC) in the Databricks Silver layer pipeline and audit compliance. | Column updated_timestamp (TIMESTAMP) in distribution.ott_platform',
    `zuora_product_code` STRING COMMENT 'The product identifier in Zuoras subscription billing platform corresponding to this OTT platforms subscription offering. Used for revenue recognition, invoice generation, and subscription lifecycle management. Links the platform master record to Zuoras billing product catalogue. | Column zuora_product_code (STRING) in distribution.ott_platform',
    CONSTRAINT pk_ott_platform PRIMARY KEY(`ott_platform_id`)
) COMMENT 'Master registry of all OTT service platforms operated by Media Broadcasting — web, mobile, connected TV (CTV), and set-top box (STB). Captures platform identity, service tier (SVOD, AVOD, TVOD, FAST), launch date, supported protocols (HLS, MPEG-DASH), DRM system bindings, CDN provider assignments, geographic availability, regulatory jurisdiction, brand identity, and operational status. This is the SSOT anchor for the entire platform domain — all other platform products reference back to this entity. | Unity Catalog table: media_broadcasting_ecm.distribution.ott_platform';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` (
    `streaming_endpoint_id` BIGINT COMMENT 'Unique identifier for the streaming endpoint. Primary key for the streaming endpoint master record. | Column streaming_endpoint_id (BIGINT) in distribution.streaming_endpoint',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: A streaming endpoint delivers a specific broadcast channels stream. This link enables QoS monitoring per channel, stream health alerting tied to playout status, and SLA reporting by channel — essenti',
    `failover_streaming_endpoint_id` BIGINT COMMENT 'Reference to the backup streaming endpoint that should be used if this endpoint becomes unavailable. Supports high availability and disaster recovery. | Column failover_endpoint_id (BIGINT) in distribution.streaming_endpoint',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to mediaasset.storage_location. Business justification: CDN origin routing configuration requires knowing which storage location backs each streaming endpoint. CDN origin pull configuration is a named infrastructure process; cdn_origin_url is a denormali',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Streaming endpoints are provisioned for specific OTT platforms. Each endpoint serves content for a platform. No visible platform_type column but relationship is essential for endpoint management. | Column ott_platform_id (BIGINT) in distribution.streaming_endpoint',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in distribution.streaming_endpoint',
    `_source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in distribution.streaming_endpoint',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in distribution.streaming_endpoint',
    `activated_timestamp` TIMESTAMP COMMENT 'The date and time when this endpoint was first activated and began serving live traffic. | Column activated_timestamp (TIMESTAMP) in distribution.streaming_endpoint',
    `bandwidth_limit_gbps` DECIMAL(18,2) COMMENT 'Maximum aggregate bandwidth capacity in gigabits per second allocated to this endpoint. Used for capacity planning and cost management. | Column bandwidth_limit_gbps (DECIMAL(10,2)) in distribution.streaming_endpoint',
    `cache_ttl_seconds` STRING COMMENT 'The duration in seconds that content should be cached at edge locations before refreshing from origin. Balances freshness with CDN efficiency. | Column cache_ttl_seconds (INT) in distribution.streaming_endpoint',
    `cost_per_gb` DECIMAL(18,2) COMMENT 'The CDN providers charge per gigabyte of data transferred through this endpoint. Used for cost allocation and financial forecasting. | Column cost_per_gb (DECIMAL(10,4)) in distribution.streaming_endpoint',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in distribution.streaming_endpoint',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this streaming endpoint record was first created in the system. | Column created_timestamp (TIMESTAMP) in distribution.streaming_endpoint',
    `dai_enabled` BOOLEAN COMMENT 'Indicates whether this endpoint supports Dynamic Ad Insertion, allowing personalized ads to be stitched into the stream in real-time. | Column dai_enabled (BOOLEAN) in distribution.streaming_endpoint',
    `deactivated_timestamp` TIMESTAMP COMMENT 'The date and time when this endpoint was deactivated or taken out of service. Null if currently active. | Column deactivated_timestamp (TIMESTAMP) in distribution.streaming_endpoint',
    `drm_license_server_url` STRING COMMENT 'URL of the DRM license server that provides decryption keys and enforces content protection policies for this endpoint. Critical for securing premium content. | Column drm_license_server_url (STRING) in distribution.streaming_endpoint. Valid values are `^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$`',
    `endpoint_name` STRING COMMENT 'Human-readable name or label for the streaming endpoint, used for identification and operational reference. | Column endpoint_name (STRING) in distribution.streaming_endpoint',
    `endpoint_type` STRING COMMENT 'Classification of the endpoint role within the CDN architecture. Origin endpoints serve as the source, edge endpoints serve end users, and backup endpoints provide failover capability. | Column endpoint_type (STRING) in distribution.streaming_endpoint. Valid values are `origin|edge|backup`',
    `endpoint_url` STRING COMMENT 'The full URL address of the streaming endpoint, including protocol, domain, and path. This is the technical delivery address for the stream. | Column endpoint_url (STRING) in distribution.streaming_endpoint. Valid values are `^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$`',
    `geo_restriction_mode` STRING COMMENT 'Defines whether geo_restriction_rules represent an allow list (whitelist) or deny list (blacklist) for content delivery. | Column geo_restriction_mode (STRING) in distribution.streaming_endpoint. Valid values are `whitelist|blacklist|none`',
    `geo_restriction_rules` STRING COMMENT 'Comma-separated list of ISO country codes or regions where content delivery is allowed or blocked. Enforces territorial licensing and rights management requirements. | Column geo_restriction_rules (STRING) in distribution.streaming_endpoint',
    `health_check_interval_seconds` STRING COMMENT 'Frequency in seconds at which automated health checks are performed against this endpoint. | Column health_check_interval_seconds (INT) in distribution.streaming_endpoint',
    `health_check_url` STRING COMMENT 'URL endpoint used for automated health monitoring and availability checks. Returns status codes indicating endpoint health. | Column health_check_url (STRING) in distribution.streaming_endpoint. Valid values are `^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$`',
    `ipv6_enabled` BOOLEAN COMMENT 'Indicates whether this endpoint supports IPv6 addressing in addition to IPv4, enabling delivery to modern network infrastructures. | Column ipv6_enabled (BOOLEAN) in distribution.streaming_endpoint',
    `last_health_check_timestamp` TIMESTAMP COMMENT 'The date and time of the most recent successful health check performed on this endpoint. | Column last_health_check_timestamp (TIMESTAMP) in distribution.streaming_endpoint',
    `manifest_format` STRING COMMENT 'The streaming manifest file format used by this endpoint. m3u8 for HLS, mpd for MPEG-DASH, ism for Smooth Streaming, f4m for Adobe HDS. | Column manifest_format (STRING) in distribution.streaming_endpoint. Valid values are `m3u8|mpd|ism|f4m`',
    `max_bitrate_mbps` DECIMAL(18,2) COMMENT 'The maximum streaming bitrate in megabits per second that this endpoint can deliver. Defines the upper quality limit for adaptive streaming. | Column max_bitrate_mbps (DECIMAL(10,2)) in distribution.streaming_endpoint',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this streaming endpoint record was last modified or updated. | Column modified_timestamp (TIMESTAMP) in distribution.streaming_endpoint',
    `operational_status` STRING COMMENT 'Current operational state of the streaming endpoint. Active endpoints are serving traffic; inactive endpoints are provisioned but not in use; maintenance indicates scheduled downtime. | Column operational_status (STRING) in distribution.streaming_endpoint. Valid values are `active|inactive|maintenance|degraded|failed`',
    `provisioned_date` DATE COMMENT 'The date when this streaming endpoint was initially provisioned and configured in the CDN infrastructure. | Column provisioned_date (DATE) in distribution.streaming_endpoint',
    `sla_uptime_target_percent` DECIMAL(18,2) COMMENT 'The contractual uptime percentage target for this endpoint (e.g., 99.99%). Used for SLA compliance monitoring and vendor accountability. | Column sla_uptime_target_percent (DECIMAL(5,2)) in distribution.streaming_endpoint',
    `source_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in distribution.streaming_endpoint',
    `ssl_certificate_expiry_date` DATE COMMENT 'Expiration date of the SSL/TLS certificate securing this endpoint. Critical for maintaining secure HTTPS delivery and avoiding service disruptions. | Column ssl_certificate_expiry_date (DATE) in distribution.streaming_endpoint',
    `streaming_protocol` STRING COMMENT 'The streaming protocol used by this endpoint for content delivery. HLS (HTTP Live Streaming) and MPEG-DASH (Dynamic Adaptive Streaming over HTTP) are the most common adaptive bitrate protocols. | Column streaming_protocol (STRING) in distribution.streaming_endpoint. Valid values are `HLS|MPEG-DASH|RTMP|WebRTC|Smooth Streaming`',
    `supported_devices` STRING COMMENT 'Comma-separated list of device types or platforms that this endpoint is optimized to serve (e.g., iOS, Android, Smart TV, Web Browser, Set-Top Box). | Column supported_devices (STRING) in distribution.streaming_endpoint',
    `token_authentication_scheme` STRING COMMENT 'The authentication mechanism used to secure access to the endpoint. Prevents unauthorized access and hotlinking through cryptographic token validation. | Column token_authentication_scheme (STRING) in distribution.streaming_endpoint. Valid values are `JWT|HMAC|Akamai Token|AWS Signature|None`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in distribution.streaming_endpoint',
    CONSTRAINT pk_streaming_endpoint PRIMARY KEY(`streaming_endpoint_id`)
) COMMENT 'Master record of all streaming origin and edge endpoints managed across the CDN infrastructure (Akamai CDN). Captures endpoint URL, CDN provider, PoP (Point of Presence) region, protocol (HLS, MPEG-DASH), ABR ladder configuration reference, DRM license server URL, token authentication scheme, geo-restriction rules, failover endpoint reference, SLA tier, and operational status. SSOT for the technical delivery address of each stream. | Unity Catalog table: media_broadcasting_ecm.distribution.streaming_endpoint';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` (
    `playback_session_id` BIGINT COMMENT 'Unique identifier for each individual viewer playback session initiated on the OTT (Over-The-Top) platform. Primary key for the playback session record. | Column playback_session_id (BIGINT) in distribution.playback_session',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: QoE reporting and ABR ladder performance analysis require linking each viewer session to the specific rendition served. ABR/QoE performance reporting is a named streaming operations process; without',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: A playback_session occurs on a specific delivery_channel (e.g., a FAST channel, a VOD channel, a live stream channel). Linking playback_session to delivery_channel enables audience analytics per chann',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Nielsen C3/C7 ratings, GRP/TRP calculation, and programmatic ad targeting require demographic classification of every playback session. Essential for audience guarantee reconciliation and upfront comm | Column demographic_segment_id (BIGINT) in audience.playback_session',
    `epg_entry_id` BIGINT COMMENT 'Foreign key linking to scheduling.epg_entry. Business justification: OTT playback sessions are initiated from EPG listings. Linking playback_session to epg_entry enables EPG-driven audience analytics — knowing which EPG entry drove a viewing session is a core OTT produ',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Playback sessions consume content under specific rights grants. Essential for per-stream royalty calculation, usage reporting to rights holders, and rights compliance verification. Media broadcasting  | Column grant_id (BIGINT) in rights.playback_session',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset being played in this session. Links to the digital asset management system for content metadata and rights verification. | Column media_asset_id (BIGINT) in mediaasset.playback_session',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: playback_session.platform_type is a denormalized string describing the OTT platform on which the session occurred. Adding ott_platform_id FK normalizes this — platform name, service tier, DRM system, ',
    `sales_campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: When playback sessions include ad delivery (dai_enabled), linking to campaign enables campaign reach/frequency measurement, content-adjacency analysis, and cross-domain attribution. Critical for measu | Column campaign_id (BIGINT) in sales.playback_session',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: OTT playback sessions correspond to scheduled content slots. This link enables audience measurement per scheduled slot for Nielsen/ratings reporting and daypart audience analytics — a core requirement',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: Playback sessions should FK to streaming_endpoint master to track which endpoint served the session. Removes streaming_endpoint_url STRING (derivable from streaming_endpoint.endpoint_url). | Column streaming_endpoint_id (BIGINT) in distribution.playback_session',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who initiated this playback session. Links to the subscriber master record for audience measurement and personalization. | Column subscriber_id (BIGINT) in subscriber.playback_session',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in distribution.playback_session',
    `_source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in distribution.playback_session',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in distribution.playback_session',
    `ad_breaks_served_count` STRING COMMENT 'Number of ad breaks (ad pods) served during this playback session. Used for advertising inventory management and revenue reconciliation. | Column ad_breaks_served_count (INT) in distribution.playback_session',
    `audio_language` STRING COMMENT 'ISO 639 language code for the audio track selected by the viewer. Supports multi-language content analytics and localization strategy. | Column audio_language (STRING) in distribution.playback_session',
    `average_bitrate_kbps` STRING COMMENT 'Average streaming bitrate in kilobits per second during the session. Indicates video quality delivered and network performance. | Column average_bitrate_kbps (INT) in distribution.playback_session',
    `cdn_pop_location` STRING COMMENT 'Geographic location identifier of the CDN point of presence that served this session. Critical for CDN performance optimization and SLA monitoring. | Column cdn_pop_location (STRING) in distribution.playback_session',
    `closed_captions_enabled` BOOLEAN COMMENT 'Indicates whether closed captions were enabled during the session. Critical for accessibility compliance reporting and user preference analysis. | Column closed_captions_enabled (BOOLEAN) in distribution.playback_session',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of content watched relative to total content duration. Key engagement metric for content performance and recommendation algorithms. | Column completion_percentage (DECIMAL(5,2)) in distribution.playback_session',
    `content_duration_seconds` STRING COMMENT 'Total duration of the content asset in seconds. Used to calculate completion rate and identify partial vs. full viewing sessions. | Column content_duration_seconds (INT) in distribution.playback_session',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in distribution.playback_session',
    `dai_enabled` BOOLEAN COMMENT 'Indicates whether Dynamic Ad Insertion was enabled for this playback session. Critical for advertising revenue attribution and campaign measurement. | Column dai_enabled (BOOLEAN) in distribution.playback_session',
    `error_code` STRING COMMENT 'Technical error code if the session ended due to an error. Enables root cause analysis and platform stability monitoring. | Column error_code (STRING) in distribution.playback_session',
    `exit_reason` STRING COMMENT 'The reason the playback session ended. Critical for distinguishing intentional exits from technical failures and optimizing viewer experience. | Column exit_reason (STRING) in distribution.playback_session. Valid values are `user_stop|completion|error|timeout|network_failure|drm_failure`',
    `geographic_city` STRING COMMENT 'City where the viewer is located during playback. Enables hyper-local audience analytics and targeted advertising campaigns. | Column geographic_city (STRING) in distribution.playback_session',
    `geographic_postal_code` STRING COMMENT 'Postal code derived from viewer location. Used for demographic overlay and targeted advertising. Subject to privacy regulations. | Column geographic_postal_code (STRING) in distribution.playback_session',
    `initial_buffering_duration_ms` STRING COMMENT 'Time in milliseconds from session start until playback began. Key QoS metric for measuring time-to-first-frame and viewer experience. | Column initial_buffering_duration_ms (INT) in distribution.playback_session',
    `playback_mode` STRING COMMENT 'The mode of content consumption: live linear broadcast, VOD (Video On Demand), DVR (time-shifted), or restart. Critical for audience measurement methodology and rights management. | Column playback_mode (STRING) in distribution.playback_session. Valid values are `live|vod|dvr|restart`',
    `rebuffering_events_count` STRING COMMENT 'Number of rebuffering (stalling) events that occurred during the session. Critical QoS metric for viewer experience and churn prediction. | Column rebuffering_events_count (INT) in distribution.playback_session',
    `session_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this playback session record was created in the system. Used for data lineage and operational monitoring. | Column session_created_timestamp (TIMESTAMP) in distribution.playback_session',
    `session_end_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the playback session ended. Used to calculate total watch duration and session completion metrics. | Column session_end_timestamp (TIMESTAMP) in distribution.playback_session',
    `session_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the viewer initiated the playback session. Critical for audience measurement, daypart analysis, and concurrent viewer calculations. | Column session_start_timestamp (TIMESTAMP) in distribution.playback_session',
    `session_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this playback session record was last updated. Supports audit trail and data quality monitoring. | Column session_updated_timestamp (TIMESTAMP) in distribution.playback_session',
    `source_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in distribution.playback_session',
    `streaming_protocol` STRING COMMENT 'The ABR (Adaptive Bitrate Streaming) protocol used for content delivery. HLS (HTTP Live Streaming) or MPEG-DASH (Dynamic Adaptive Streaming over HTTP) are most common. | Column streaming_protocol (STRING) in distribution.playback_session. Valid values are `hls|mpeg_dash|smooth_streaming`',
    `subtitle_language` STRING COMMENT 'ISO 639 language code for subtitles displayed during the session. Null if no subtitles were enabled. Supports accessibility and localization analytics. | Column subtitle_language (STRING) in distribution.playback_session',
    `total_ad_duration_seconds` STRING COMMENT 'Cumulative duration of all advertisements served during the session. Essential for advertising billing and viewer experience analysis. | Column total_ad_duration_seconds (INT) in distribution.playback_session',
    `total_rebuffering_duration_ms` STRING COMMENT 'Cumulative time in milliseconds spent in rebuffering state during the session. Complements rebuffering count for comprehensive QoS analysis. | Column total_rebuffering_duration_ms (INT) in distribution.playback_session',
    `total_watch_duration_seconds` STRING COMMENT 'Total time in seconds the viewer actively watched content during this session. Primary metric for audience measurement and content engagement analysis. | Column total_watch_duration_seconds (INT) in distribution.playback_session',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in distribution.playback_session',
    `video_resolution` STRING COMMENT 'The video resolution delivered during the session (e.g., 1920x1080, 3840x2160). Indicates quality tier and device capability. | Column video_resolution (STRING) in distribution.playback_session',
    `viewer_ip_address` STRING COMMENT 'IP address of the viewer during the playback session. Used for geographic analysis, fraud detection, and blackout enforcement. Subject to GDPR and CCPA privacy regulations. | Column viewer_ip_address (STRING) in distribution.playback_session',
    CONSTRAINT pk_playback_session PRIMARY KEY(`playback_session_id`)
) COMMENT 'Transactional record of each individual viewer playback session initiated on the OTT platform. Captures session ID, subscriber/device reference, content asset reference, session start and end timestamps, platform and app version, device type, streaming endpoint used, ABR profile, DRM policy applied, initial buffering duration, average bitrate, rebuffering events count, total watch duration, exit reason (user-initiated, error, completion), CDN PoP served, and geographic location. Primary operational event for QoS monitoring and audience measurement. | Unity Catalog table: media_broadcasting_ecm.distribution.playback_session';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` (
    `partner_id` BIGINT COMMENT 'Unique identifier for the distribution partner. Primary key for the distribution partner entity. | Column distribution_partner_id (BIGINT) in distribution.distribution_partner',
    `account_id` BIGINT COMMENT 'Foreign key linking to sales.sales_account. Business justification: Distribution partners (MVPDs, OTT aggregators, cable operators) are commercial entities managed as sales accounts for billing, contract management, and revenue tracking. A broadcast distribution exper',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in distribution.distribution_partner',
    `_source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in distribution.distribution_partner',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in distribution.distribution_partner',
    `abr_profile_support` STRING COMMENT 'Description of Adaptive Bitrate streaming profiles and quality tiers supported by the distribution partner for OTT and streaming delivery. Includes resolution ranges, bitrate ladders, and codec support. | Column abr_profile_support (STRING) in distribution.distribution_partner',
    `blackout_capability_flag` BOOLEAN COMMENT 'Indicates whether the distribution partner has technical capability to enforce geographic broadcast restrictions and content blackouts based on licensing and rights windows. | Column blackout_capability_flag (BOOLEAN) in distribution.distribution_partner',
    `carriage_capacity_channels` STRING COMMENT 'Number of linear channels or content streams that the distribution partner has capacity to carry simultaneously. Relevant for MVPD, vMVPD, and cable operators. | Column carriage_capacity_channels (INT) in distribution.distribution_partner',
    `carriage_fee_model` STRING COMMENT 'Commercial model for carriage fees paid by or to the distribution partner. Per Subscriber indicates fees based on subscriber count, Flat Rate indicates fixed periodic payment, Revenue Share indicates percentage of advertising or subscription revenue, Hybrid indicates combination of models. | Column carriage_fee_model (STRING) in distribution.distribution_partner. Valid values are `Per Subscriber|Flat Rate|Revenue Share|Hybrid|No Fee`',
    `cdn_provider` STRING COMMENT 'Name of the Content Delivery Network provider used by the distribution partner for content streaming and delivery. May include Akamai, Cloudflare, AWS CloudFront, or partner-owned CDN infrastructure. | Column cdn_provider (STRING) in distribution.distribution_partner',
    `contract_end_date` DATE COMMENT 'Date when the current distribution agreement with the partner expires or is scheduled for renewal. Null indicates open-ended or evergreen agreement. | Column contract_end_date (DATE) in distribution.distribution_partner',
    `contract_renewal_notice_days` STRING COMMENT 'Number of days advance notice required for contract renewal or termination as specified in the distribution agreement. | Column contract_renewal_notice_days (INT) in distribution.distribution_partner',
    `contract_start_date` DATE COMMENT 'Date when the current distribution agreement with the partner became effective. | Column contract_start_date (DATE) in distribution.distribution_partner',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in distribution.distribution_partner',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution partner record was first created in the system. | Column created_timestamp (TIMESTAMP) in distribution.distribution_partner',
    `dai_support_flag` BOOLEAN COMMENT 'Indicates whether the distribution partner supports Dynamic Ad Insertion technology for server-side ad stitching in streaming content. | Column dai_support_flag (BOOLEAN) in distribution.distribution_partner',
    `drm_capability` STRING COMMENT 'Digital Rights Management systems and encryption standards supported by the distribution partner. May include Widevine, FairPlay, PlayReady, and other DRM technologies. | Column drm_capability (STRING) in distribution.distribution_partner',
    `geographic_footprint` STRING COMMENT 'Description of the geographic markets, regions, or territories served by this distribution partner. May include country codes, DMA (Designated Market Area) codes, or regional descriptors. | Column geographic_footprint (STRING) in distribution.distribution_partner',
    `headquarters_address` STRING COMMENT 'Physical address of the distribution partners corporate headquarters or primary business location. | Column headquarters_address (STRING) in distribution.distribution_partner',
    `headquarters_city` STRING COMMENT 'City where the distribution partners headquarters is located. | Column headquarters_city (STRING) in distribution.distribution_partner',
    `headquarters_country_code` STRING COMMENT 'Three-letter ISO country code representing the country where the distribution partners headquarters is located. | Column headquarters_country_code (STRING) in distribution.distribution_partner. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the distribution partners headquarters location. | Column headquarters_postal_code (STRING) in distribution.distribution_partner',
    `headquarters_state_province` STRING COMMENT 'State, province, or administrative region where the distribution partners headquarters is located. | Column headquarters_state_province (STRING) in distribution.distribution_partner',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution partner record was most recently updated or modified. | Column last_modified_timestamp (TIMESTAMP) in distribution.distribution_partner',
    `must_carry_obligation_flag` BOOLEAN COMMENT 'Indicates whether the distribution partner has a must-carry obligation requiring mandatory inclusion of certain broadcast channels under FCC regulations. | Column must_carry_obligation_flag (BOOLEAN) in distribution.distribution_partner',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or contextual information about the distribution partner relationship. | Column notes (STRING) in distribution.distribution_partner',
    `partner_type` STRING COMMENT 'Classification of the distribution partner based on delivery model. MVPD (Multichannel Video Programming Distributor) includes traditional cable, satellite, and telco providers. vMVPD (Virtual MVPD) includes internet-based multichannel services. OTT Platform includes direct-to-consumer streaming services. FAST Aggregator includes Free Ad-Supported Streaming Television channel aggregators. Syndication Outlet includes broadcast stations and regional networks. | Column partner_type (STRING) in distribution.distribution_partner. Valid values are `MVPD|vMVPD|OTT Platform|FAST Aggregator|Syndication Outlet|Cable Operator`',
    `payment_terms_days` STRING COMMENT 'Standard payment terms in days for invoices related to carriage fees, revenue share, or other financial transactions with the distribution partner. | Column payment_terms_days (INT) in distribution.distribution_partner',
    `portal_url` STRING COMMENT 'Web URL for the distribution partners business portal, technical documentation, or partner management system. | Column portal_url (STRING) in distribution.distribution_partner',
    `preferred_currency_code` STRING COMMENT 'Three-letter ISO currency code for financial transactions and reporting with this distribution partner. | Column preferred_currency_code (STRING) in distribution.distribution_partner. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact for distribution operations, technical coordination, and business communications. | Column primary_contact_email (STRING) in distribution.distribution_partner. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the distribution partner organization for operational coordination and escalation. | Column primary_contact_name (STRING) in distribution.distribution_partner',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for reaching the distribution partner contact for urgent operational matters and coordination. | Column primary_contact_phone (STRING) in distribution.distribution_partner',
    `qos_monitoring_enabled_flag` BOOLEAN COMMENT 'Indicates whether active Quality of Service monitoring and reporting is enabled for content delivery through this distribution partner. | Column qos_monitoring_enabled_flag (BOOLEAN) in distribution.distribution_partner',
    `relationship_status` STRING COMMENT 'Current state of the commercial relationship and content distribution agreement with the partner. | Column relationship_status (STRING) in distribution.distribution_partner. Valid values are `Active|Inactive|Suspended|Pending|Terminated|Under Negotiation`',
    `retransmission_consent_status` STRING COMMENT 'Status of retransmission consent authorization allowing the distribution partner to rebroadcast content. Relevant for MVPD and cable operators under FCC regulations. | Column retransmission_consent_status (STRING) in distribution.distribution_partner. Valid values are `Granted|Denied|Pending|Not Applicable|Under Negotiation`',
    `sla_latency_target_ms` STRING COMMENT 'Maximum acceptable latency in milliseconds for content delivery as defined in the distribution Service Level Agreement. Critical for live streaming and low-latency applications. | Column sla_latency_target_ms (INT) in distribution.distribution_partner',
    `sla_uptime_target_percent` DECIMAL(18,2) COMMENT 'Contractual uptime percentage target defined in the distribution Service Level Agreement. Represents the minimum availability commitment for content delivery. | Column sla_uptime_target_percent (DECIMAL(5,2)) in distribution.distribution_partner',
    `source_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in distribution.distribution_partner',
    `subscriber_reach_estimate` BIGINT COMMENT 'Estimated number of subscribers, households, or unique users that can access content through this distribution partner. Used for reach analysis and revenue forecasting. | Column subscriber_reach_estimate (BIGINT) in distribution.distribution_partner',
    `technical_delivery_standards` STRING COMMENT 'Comma-separated list of technical broadcast and streaming standards supported by the partner. May include DVB (Digital Video Broadcasting), ATSC (Advanced Television Systems Committee), QAM (Quadrature Amplitude Modulation), HLS (HTTP Live Streaming), MPEG-DASH (Dynamic Adaptive Streaming over HTTP), and other delivery protocols. | Column technical_delivery_standards (STRING) in distribution.distribution_partner',
    `tier` STRING COMMENT 'Strategic classification of the partner based on reach, revenue contribution, and business importance. Tier 1 represents largest national/international partners, Tier 2 represents regional significant partners, Tier 3 represents local or niche partners. | Column partner_tier (STRING) in distribution.distribution_partner. Valid values are `Tier 1|Tier 2|Tier 3|Strategic|Emerging`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in distribution.distribution_partner',
    CONSTRAINT pk_partner PRIMARY KEY(`partner_id`)
) COMMENT 'Master record for all distribution partners including MVPDs (cable, satellite, telco), vMVPDs, OTT platform operators, FAST aggregators, and syndication outlets. Captures partner identity, tier classification, distribution footprint (geographic markets served), carriage capacity, technical delivery capabilities (DVB, ATSC, HLS, MPEG-DASH), and commercial relationship status. SSOT for distribution partner identity within the distribution domain — distinct from the enterprise partner domain which owns broader commercial relationships. | Unity Catalog table: media_broadcasting_ecm.distribution.distribution_partner';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` (
    `carriage_agreement_id` BIGINT COMMENT 'Unique identifier for the carriage agreement record. Primary key. | Column carriage_agreement_id (BIGINT) in distribution.carriage_agreement',
    `account_id` BIGINT COMMENT 'Foreign key linking to sales.sales_account. Business justification: Carriage agreements with MVPDs and cable operators are commercial contracts managed under a sales account. Contract billing, renewal tracking, and revenue reporting all require linking carriage agreem',
    `channel_id` BIGINT COMMENT 'Reference to the channel or content package covered by this carriage agreement. | Column channel_id (BIGINT) in scheduling.carriage_agreement',
    `deal_id` BIGINT COMMENT 'Foreign key linking to distribution.deal. Business justification: A carriage_agreement is executed under the umbrella of a commercial distribution deal. The deal captures the high-level commercial terms negotiated with a distribution_partner, while the carriage_agre',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Carriage agreements with MVPDs/distributors reference underlying content license agreements that authorize the carriage. Critical for rights chain validation, ensuring distribution partners have prope | Column license_agreement_id (BIGINT) in rights.carriage_agreement',
    `partner_id` BIGINT COMMENT 'Reference to the MVPD, vMVPD, or OTT platform carrying the content under this agreement. | Column distribution_partner_id (BIGINT) in distribution.carriage_agreement',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in distribution.carriage_agreement',
    `_source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in distribution.carriage_agreement',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in distribution.carriage_agreement',
    `agreement_number` STRING COMMENT 'Externally-known unique identifier or contract number for this carriage agreement, used in business communications and legal references. | Column agreement_number (STRING) in distribution.carriage_agreement',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the carriage agreement: draft (being prepared), active (in force), suspended (temporarily paused), expired (term ended), terminated (cancelled before expiry), or under negotiation (renewal or amendment in progress). | Column agreement_status (STRING) in distribution.carriage_agreement. Valid values are `draft|active|suspended|expired|terminated|under_negotiation`',
    `agreement_type` STRING COMMENT 'Classification of the carriage agreement: retransmission consent (FCC-regulated authorization for MVPDs to rebroadcast OTA signals), must-carry (mandatory carriage under FCC rules), voluntary carriage (negotiated carriage without must-carry obligation), or platform carriage (OTT/vMVPD distribution agreement). | Column agreement_type (STRING) in distribution.carriage_agreement. Valid values are `retransmission_consent|must_carry|voluntary_carriage|platform_carriage`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews at the end of the term unless either party provides termination notice. | Column auto_renewal_flag (BOOLEAN) in distribution.carriage_agreement',
    `blackout_provisions` STRING COMMENT 'Geographic or temporal restrictions on content availability, such as sports blackout rules, local market exclusions, or event-specific restrictions required by rights holders or league rules. | Column blackout_provisions (STRING) in distribution.carriage_agreement',
    `carriage_fee_amount` DECIMAL(18,2) COMMENT 'Monetary compensation paid by the distribution partner to the content provider for the right to carry the channel or content package. May be per-subscriber, flat fee, or tiered based on subscriber count. | Column carriage_fee_amount (DECIMAL(15,2)) in distribution.carriage_agreement',
    `carriage_fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the carriage fee amount (e.g., USD, GBP, EUR). | Column carriage_fee_currency (STRING) in distribution.carriage_agreement. Valid values are `^[A-Z]{3}$`',
    `carriage_fee_structure` STRING COMMENT 'Pricing model for the carriage fee: per-subscriber (fee per active subscriber), flat monthly (fixed monthly payment), tiered (rate varies by subscriber volume), revenue share (percentage of ad or subscription revenue), or barter (non-cash compensation such as promotional commitments or channel positioning). | Column carriage_fee_structure (STRING) in distribution.carriage_agreement. Valid values are `per_subscriber|flat_monthly|tiered|revenue_share|barter`',
    `channel_number_assignment` STRING COMMENT 'The channel number or dial position assigned to the channel on the distribution platform. May vary by market or headend. | Column channel_number_assignment (STRING) in distribution.carriage_agreement',
    `channel_positioning_tier` STRING COMMENT 'The service tier or package in which the channel is positioned (e.g., basic, expanded basic, premium, sports tier). Affects channel visibility and subscriber reach. | Column channel_positioning_tier (STRING) in distribution.carriage_agreement',
    `compensation_terms` STRING COMMENT 'Detailed description of all compensation provided under the agreement, including cash payments, barter arrangements (e.g., promotional commitments, ad inventory exchange), channel carriage reciprocity, or other non-monetary considerations. | Column compensation_terms (STRING) in distribution.carriage_agreement',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in distribution.carriage_agreement',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carriage agreement record was first created in the system. | Column created_timestamp (TIMESTAMP) in distribution.carriage_agreement',
    `dispute_resolution_mechanism` STRING COMMENT 'Agreed method for resolving disputes arising under the agreement: arbitration (binding third-party decision), mediation (facilitated negotiation), litigation (court proceedings), or negotiation (direct party-to-party resolution). | Column dispute_resolution_mechanism (STRING) in distribution.carriage_agreement. Valid values are `arbitration|mediation|litigation|negotiation`',
    `drm_requirements` STRING COMMENT 'DRM and content protection requirements mandated under the agreement, such as encryption standards, conditional access systems, watermarking, and anti-piracy measures. | Column drm_requirements (STRING) in distribution.carriage_agreement',
    `effective_date` DATE COMMENT 'Date when the carriage agreement becomes binding and the distribution partner is authorized to carry the channel or content package. | Column effective_date (DATE) in distribution.carriage_agreement',
    `exclusivity_window` STRING COMMENT 'Period during which the distribution partner has exclusive carriage rights within a defined geographic territory or platform category (e.g., exclusive MVPD rights in a DMA, exclusive vMVPD rights nationally). | Column exclusivity_window (STRING) in distribution.carriage_agreement',
    `expiration_date` DATE COMMENT 'Date when the carriage agreement term ends. Nullable for open-ended or evergreen agreements subject to termination notice. | Column expiration_date (DATE) in distribution.carriage_agreement',
    `geographic_coverage` STRING COMMENT 'Geographic scope of the carriage agreement, typically expressed as authorized DMAs (Designated Market Areas), states, regions, or national coverage. Defines where the distribution partner is authorized to carry the content. | Column geographic_coverage (STRING) in distribution.carriage_agreement',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law applicable to the agreement (e.g., State of New York, England and Wales). Determines which courts and laws apply in case of dispute. | Column governing_law_jurisdiction (STRING) in distribution.carriage_agreement',
    `holdback_restrictions` STRING COMMENT 'Restrictions on when or where content may be made available on other platforms or windows. Protects the distribution partners investment by limiting competing distribution during the agreement term. | Column holdback_restrictions (STRING) in distribution.carriage_agreement',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or modification to the carriage agreement. | Column last_amendment_date (DATE) in distribution.carriage_agreement',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this carriage agreement record was last updated in the system. | Column last_modified_timestamp (TIMESTAMP) in distribution.carriage_agreement',
    `minimum_subscriber_guarantee` STRING COMMENT 'Minimum number of subscribers the distribution partner guarantees to deliver for the channel. Used in per-subscriber fee calculations and performance commitments. | Column minimum_subscriber_guarantee (INT) in distribution.carriage_agreement',
    `must_carry_election` BOOLEAN COMMENT 'Indicates whether the broadcaster has elected must-carry status under FCC rules, requiring the MVPD to carry the signal without negotiation. Applicable to qualified broadcast stations. | Column must_carry_election (BOOLEAN) in distribution.carriage_agreement',
    `negotiation_history` STRING COMMENT 'Summary of key negotiation milestones, amendments, and material changes to the agreement over its lifecycle. Provides context for current terms and future renegotiations. | Column negotiation_history (STRING) in distribution.carriage_agreement',
    `promotional_commitment` STRING COMMENT 'Marketing and promotional obligations agreed by either party, such as on-air promotion, co-marketing campaigns, EPG placement guarantees, or cross-platform promotion. | Column promotional_commitment (STRING) in distribution.carriage_agreement',
    `renewal_terms` STRING COMMENT 'Conditions and terms governing agreement renewal, including renewal period length, rate adjustments, renegotiation triggers, and notice requirements. | Column renewal_terms (STRING) in distribution.carriage_agreement',
    `retransmission_consent_granted` BOOLEAN COMMENT 'Indicates whether retransmission consent has been granted under FCC regulations, authorizing the MVPD to rebroadcast over-the-air signals. Applicable only to retransmission consent agreement types. | Column retransmission_consent_granted (BOOLEAN) in distribution.carriage_agreement',
    `service_level_agreement` STRING COMMENT 'Performance commitments and service quality standards, including uptime guarantees, signal quality metrics, fault resolution times, and penalties for non-compliance. | Column service_level_agreement (STRING) in distribution.carriage_agreement',
    `source_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in distribution.carriage_agreement',
    `technical_delivery_requirements` STRING COMMENT 'Technical specifications for content delivery, including signal format (HD, 4K, HDR), encoding standards (MPEG-2, MPEG-4, HEVC), delivery method (satellite, fiber, IP), and quality parameters (bitrate, resolution, audio channels). | Column technical_delivery_requirements (STRING) in distribution.carriage_agreement',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the agreement. Protects both parties from abrupt service disruption. | Column termination_notice_days (INT) in distribution.carriage_agreement',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in distribution.carriage_agreement',
    CONSTRAINT pk_carriage_agreement PRIMARY KEY(`carriage_agreement_id`)
) COMMENT 'Contractual record governing the terms under which a channel or content package is carried by an MVPD, vMVPD, or OTT platform. Covers both retransmission consent agreements (FCC-regulated authorization for MVPDs to rebroadcast OTA signals) and standard carriage contracts. Captures agreement type (retransmission consent, must-carry, voluntary carriage), retransmission consent terms, must-carry election status, carriage fee rates, channel positioning tiers, geographic coverage (authorized DMAs), exclusivity windows, holdback restrictions, compensation terms (cash, channel carriage, promotional commitments), contract effective/expiry dates, and negotiation history. Links to distribution partner and channel master. Distinct from rights licensing contracts owned by the rights domain. | Unity Catalog table: media_broadcasting_ecm.distribution.carriage_agreement';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` (
    `delivery_channel_id` BIGINT COMMENT 'Unique identifier for the delivery channel. Primary key. | Column delivery_channel_id (BIGINT) in distribution.delivery_channel',
    `carriage_agreement_id` BIGINT COMMENT 'Foreign key linking to distribution.carriage_agreement. Business justification: A delivery_channel is the operational manifestation of a carriage_agreement — the agreement governs the terms under which the channel is carried by an MVPD/vMVPD. Linking delivery_channel to its gover',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: OTT/FAST delivery channels originate from a broadcast channel. Linking delivery_channel to scheduling.channel enables channel lineup reconciliation, carriage fee attribution, and EPG synchronization —',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: A delivery_channel (FAST channel, OTT stream, linear simulcast) is configured and operated under a specific OTT platform. One ott_platform hosts many delivery_channels. This FK normalizes the platform',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: delivery_channel.streaming_endpoint_url is a denormalized string reference to the streaming origin/edge endpoint. Adding streaming_endpoint_id FK normalizes this relationship — the endpoint URL and al',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in distribution.delivery_channel',
    `_source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in distribution.delivery_channel',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in distribution.delivery_channel',
    `ad_insertion_method` STRING COMMENT 'Technical method used for inserting advertisements into the content stream: server-side stitching, client-side insertion, DAI (Dynamic Ad Insertion), SCTE-35 marker-based, or none for ad-free channels. | Column ad_insertion_method (STRING) in distribution.delivery_channel. Valid values are `server-side|client-side|dai|scte-35|none`',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the channel content (4:3 legacy, 16:9 widescreen standard, 21:9 cinematic). | Column aspect_ratio (NUMERIC) in distribution.delivery_channel',
    `audio_format` STRING COMMENT 'Audio encoding and delivery format supported by the channel (stereo, Dolby Digital 5.1, Dolby Atmos, DTS, AAC). | Column audio_format (STRING) in distribution.delivery_channel. Valid values are `stereo|dolby-digital|dolby-atmos|dts|aac`',
    `blackout_rules_enabled` BOOLEAN COMMENT 'Indicates whether geographic or rights-based blackout restrictions are enforced for this channel (true) or not (false). | Column blackout_rules_enabled (BOOLEAN) in distribution.delivery_channel',
    `carriage_fee_usd` DECIMAL(18,2) COMMENT 'Monthly or per-subscriber carriage fee paid by MVPDs or vMVPDs to carry this channel, expressed in USD. Confidential commercial data. | Column carriage_fee_usd (DECIMAL(12,2)) in distribution.delivery_channel',
    `channel_type` STRING COMMENT 'Classification of the delivery channel by distribution model: linear (traditional broadcast), OTT (over-the-top streaming), FAST (free ad-supported streaming TV), simulcast (simultaneous multi-platform), VOD (video on demand), or hybrid. | Column channel_type (STRING) in distribution.delivery_channel. Valid values are `linear|ott|fast|simulcast|vod|hybrid`',
    `content_refresh_cadence` STRING COMMENT 'Frequency at which the channel programming lineup or content library is updated with new material. | Column content_refresh_cadence (STRING) in distribution.delivery_channel. Valid values are `daily|weekly|monthly|quarterly|on-demand|continuous`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in distribution.delivery_channel',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery channel record was first created in the system. | Column created_timestamp (TIMESTAMP) in distribution.delivery_channel',
    `delivery_technology` STRING COMMENT 'The technical transmission standard used for content delivery. DVB (Digital Video Broadcasting) variants for European broadcast, ATSC (Advanced Television Systems Committee) for North American broadcast, QAM (Quadrature Amplitude Modulation) for cable, HLS (HTTP Live Streaming) and MPEG-DASH for adaptive bitrate streaming. [ENUM-REF-CANDIDATE: dvb-t|dvb-s|dvb-c|atsc|qam|hls|mpeg-dash|smooth-streaming|rtmp|webrtc — 10 candidates stripped; promote to reference product] | Column delivery_technology (STRING) in distribution.delivery_channel',
    `fast_aggregator_platform` STRING COMMENT 'Name of the FAST platform aggregator hosting the channel (e.g., Pluto TV, Tubi, Samsung TV Plus, Roku Channel, Xumo). Applicable only to FAST channel types. | Column fast_aggregator_platform (STRING) in distribution.delivery_channel',
    `fast_playlist_type` STRING COMMENT 'Content scheduling model for FAST channels: linear-loop (repeating content block), scheduled (traditional time-based EPG), dynamic (algorithm-driven), or hybrid. Applicable only to FAST channel types. | Column fast_playlist_type (STRING) in distribution.delivery_channel. Valid values are `linear-loop|scheduled|dynamic|hybrid`',
    `genre_category` STRING COMMENT 'Primary content genre or programming category of the channel. [ENUM-REF-CANDIDATE: news|sports|entertainment|kids|lifestyle|documentary|music|movies|drama|comedy — 10 candidates stripped; promote to reference product] | Column genre_category (STRING) in distribution.delivery_channel',
    `is_active` BOOLEAN COMMENT 'Indicates whether the channel is currently active and operational (true) or inactive/retired (false). | Column is_active (BOOLEAN) in distribution.delivery_channel',
    `launch_date` DATE COMMENT 'Date when the channel first went live and began broadcasting or streaming to audiences. | Column launch_date (DATE) in distribution.delivery_channel',
    `max_bitrate_mbps` DECIMAL(18,2) COMMENT 'Maximum streaming bitrate supported by the channel in megabits per second, representing the highest quality tier in the ABR ladder. | Column max_bitrate_mbps (DECIMAL(6,2)) in distribution.delivery_channel',
    `monetization_model` STRING COMMENT 'Revenue model for the channel: AVOD (Advertising-Supported Video On Demand), SVOD (Subscription Video On Demand), TVOD (Transactional Video On Demand), hybrid (multiple models), or free (no monetization). | Column monetization_model (STRING) in distribution.delivery_channel. Valid values are `avod|svod|tvod|hybrid|free`',
    `operational_status` STRING COMMENT 'Current operational state of the delivery channel in the distribution infrastructure. | Column operational_status (STRING) in distribution.delivery_channel. Valid values are `active|inactive|suspended|testing|planned|retired`',
    `parental_control_rating` STRING COMMENT 'TV Parental Guidelines rating assigned to the channel for content filtering and parental control systems. | Column parental_control_rating (STRING) in distribution.delivery_channel. Valid values are `tv-y|tv-y7|tv-g|tv-pg|tv-14|tv-ma`',
    `primary_language` STRING COMMENT 'ISO 639-3 three-letter code for the primary broadcast language of the channel (e.g., eng for English, spa for Spanish, fra for French). | Column primary_language (STRING) in distribution.delivery_channel. Valid values are `^[a-z]{3}$`',
    `qos_tier` STRING COMMENT 'Service level tier defining performance guarantees, uptime SLA, and priority for this channel (premium, standard, basic). | Column qos_tier (STRING) in distribution.delivery_channel. Valid values are `premium|standard|basic`',
    `resolution_format` STRING COMMENT 'Video resolution tier supported by the channel: SD (standard definition 480p), HD (720p), Full HD (1080p), 4K UHD (2160p), 8K UHD (4320p). | Column resolution_format (STRING) in distribution.delivery_channel. Valid values are `sd|hd|full-hd|4k-uhd|8k-uhd`',
    `retirement_date` DATE COMMENT 'Date when the channel ceased operations or was decommissioned. Null for active channels. | Column retirement_date (DATE) in distribution.delivery_channel',
    `retransmission_consent_required` BOOLEAN COMMENT 'Indicates whether retransmission consent agreements are required for MVPDs to rebroadcast this channel (true) or if must-carry rules apply (false). | Column retransmission_consent_required (BOOLEAN) in distribution.delivery_channel',
    `sla_uptime_percent` DECIMAL(18,2) COMMENT 'Contractual uptime guarantee for the channel expressed as a percentage (e.g., 99.95 for four nines availability). | Column sla_uptime_percent (DECIMAL(5,2)) in distribution.delivery_channel',
    `source_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in distribution.delivery_channel',
    `target_demographic` STRING COMMENT 'Primary audience demographic segment targeted by the channel programming (e.g., Adults 18-49, Kids 6-11, Women 25-54). | Column target_demographic (STRING) in distribution.delivery_channel',
    `target_market` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the primary geographic market for the channel (e.g., USA, GBR, CAN). | Column target_market (STRING) in distribution.delivery_channel. Valid values are `^[A-Z]{3}$`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in distribution.delivery_channel',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery channel record was last modified. | Column updated_timestamp (TIMESTAMP) in distribution.delivery_channel',
    CONSTRAINT pk_delivery_channel PRIMARY KEY(`delivery_channel_id`)
) COMMENT 'Master definition of a logical distribution channel — a named, configured delivery pathway through which content is transmitted to audiences. Covers linear broadcast channels (DVB-T, DVB-S, ATSC, QAM), OTT streaming channels, FAST channels (Pluto TV, Tubi, Samsung TV Plus, Roku Channel), and simulcast feeds. Captures channel name, call sign, channel number, channel type (linear, OTT, FAST, simulcast), delivery technology standard, resolution/format, language, target market, EPG linkage, operational status, and FAST-specific attributes where applicable (aggregator platform, playlist type, ad insertion method, content refresh cadence, monetization model). SSOT for channel identity within the distribution domain. | Unity Catalog table: media_broadcasting_ecm.distribution.delivery_channel';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` (
    `delivery_event_id` BIGINT COMMENT 'Unique identifier for the delivery event record. Primary key. | Column delivery_event_id (BIGINT) in distribution.delivery_event',
    `ad_break_id` BIGINT COMMENT 'Foreign key linking to scheduling.ad_break. Business justification: Delivery events carry SCTE-35 signals and ad pod positions that correspond to scheduled ad breaks. Linking delivery_event to ad_break enables ad delivery reconciliation against scheduled inventory — a',
    `ad_order_line_id` BIGINT COMMENT 'Foreign key linking to sales.ad_order_line. Business justification: Delivery events record actual technical delivery of ad content. Linking to ad_order_line enables post-campaign delivery verification, affidavit generation, and billing reconciliation at the line level',
    `ad_spot_id` BIGINT COMMENT 'Foreign key linking to sales.ad_spot. Business justification: A delivery event records the technical delivery of a specific ad spot. Linking delivery_event to ad_spot enables spot-level proof-of-performance, affidavit filing, and makegood adjudication — fundamen',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: CDN billing, DRM audit trails, and delivery quality reporting require knowing which specific rendition/version (bitrate, codec, resolution) was delivered — not just the master asset. Version-level de',
    `channel_id` BIGINT COMMENT 'Reference to the distribution channel through which content was delivered (linear broadcast channel, OTT platform, FAST channel). | Column channel_id (BIGINT) in scheduling.delivery_event',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: delivery_event.delivery_channel_type is a denormalized string describing the type of delivery channel for the event. Adding delivery_channel_id FK normalizes this — channel name, type, monetization mo',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Delivery events represent actual content delivery under specific rights grants. Essential for usage tracking, run count enforcement, and royalty calculation based on actual exploitation. Enables right | Column grant_id (BIGINT) in rights.delivery_event',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset being delivered in this event. | Column media_asset_id (BIGINT) in mediaasset.delivery_event',
    `partner_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_partner. Business justification: A delivery_event represents a discrete content delivery event which occurs through a specific distribution_partner (MVPD, vMVPD, OTT aggregator). Linking delivery_event to distribution_partner enables',
    `playback_session_id` BIGINT COMMENT 'Reference to the playback session associated with this delivery event for OTT/streaming deliveries. | Column playback_session_id (BIGINT) in distribution.delivery_event',
    `sales_campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: When delivery_event records ad delivery (dai_enabled flag), linking to campaign enables campaign-level delivery verification and performance tracking. Essential for bridging distribution delivery logs | Column campaign_id (BIGINT) in sales.delivery_event',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: Delivery events are triggered by scheduled playout slots. This link enables as-run log reconciliation and broadcast affidavit generation — a core FCC compliance and advertiser billing requirement. Eve',
    `streaming_endpoint_id` BIGINT COMMENT 'Reference to the streaming endpoint used for OTT delivery events. | Column streaming_endpoint_id (BIGINT) in distribution.delivery_event',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in distribution.delivery_event',
    `_source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in distribution.delivery_event',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in distribution.delivery_event',
    `ad_fill_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of available ad inventory that was successfully filled during this DAI event (0.00 to 100.00). | Column ad_fill_rate_percent (DECIMAL(5,2)) in distribution.delivery_event',
    `ad_pod_position` STRING COMMENT 'Position of the ad pod within the content stream for DAI events (e.g., pre-roll=1, mid-roll=2, post-roll=3). | Column ad_pod_position (INT) in distribution.delivery_event',
    `audio_codec` STRING COMMENT 'Audio codec used for the delivered content (e.g., AAC, AC-3, E-AC-3, Dolby Atmos). | Column audio_codec (STRING) in distribution.delivery_event',
    `bitrate_kbps` STRING COMMENT 'Stream bitrate in kilobits per second at the time of this delivery event. | Column bitrate_kbps (INT) in distribution.delivery_event',
    `bytes_delivered` BIGINT COMMENT 'Total number of bytes delivered to the viewer during this event. | Column bytes_delivered (BIGINT) in distribution.delivery_event',
    `cdn_cache_status` STRING COMMENT 'CDN cache status for this delivery (hit, miss, stale, bypass). | Column cdn_cache_status (STRING) in distribution.delivery_event. Valid values are `hit|miss|stale|bypass`',
    `cdn_node_code` STRING COMMENT 'Identifier of the CDN edge node that served the content for this delivery event. | Column cdn_node_code (STRING) in distribution.delivery_event',
    `cdn_pop_location` STRING COMMENT 'Geographic location identifier of the CDN point of presence that served this delivery. | Column cdn_pop_location (STRING) in distribution.delivery_event',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in distribution.delivery_event',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery event record was created in the system. | Column created_timestamp (TIMESTAMP) in distribution.delivery_event',
    `dai_enabled` BOOLEAN COMMENT 'Flag indicating whether dynamic ad insertion was enabled for this delivery event. | Column dai_enabled (BOOLEAN) in distribution.delivery_event',
    `delivery_status` STRING COMMENT 'Outcome status of the delivery event (success, failure, degraded quality, partial delivery). | Column delivery_status (STRING) in distribution.delivery_event. Valid values are `success|failure|degraded|partial`',
    `delivery_technology` STRING COMMENT 'Technical protocol or standard used for content delivery (HLS, MPEG-DASH, DVB, ATSC, QAM, Smooth Streaming, RTMP). [ENUM-REF-CANDIDATE: hls|mpeg_dash|dvb|atsc|qam|smooth_streaming|rtmp — 7 candidates stripped; promote to reference product] | Column delivery_technology (STRING) in distribution.delivery_event',
    `drm_system` STRING COMMENT 'DRM system applied to protect the content during delivery (Widevine, PlayReady, FairPlay, or none for unprotected content). | Column drm_system (STRING) in distribution.delivery_event. Valid values are `widevine|playready|fairplay|none`',
    `error_code` STRING COMMENT 'System error code if the delivery event encountered a failure or degradation. | Column error_code (STRING) in distribution.delivery_event',
    `error_message` STRING COMMENT 'Human-readable error message describing the delivery failure or issue. | Column error_message (STRING) in distribution.delivery_event',
    `event_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the delivery event occurred (stream start, broadcast transmission, VOD delivery initiation). | Column event_timestamp (TIMESTAMP) in distribution.delivery_event',
    `event_type` STRING COMMENT 'Type of delivery event being recorded (stream start, VOD delivery, broadcast transmission, DAI insertion, stream end, playback error, buffer event). [ENUM-REF-CANDIDATE: stream_start|vod_delivery|broadcast_tx|dai_insertion|stream_end|playback_error|buffer_event — 7 candidates stripped; promote to reference product] | Column event_type (STRING) in distribution.delivery_event',
    `geographic_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the delivery occurred (e.g., USA, GBR, CAN). | Column geographic_country_code (STRING) in distribution.delivery_event',
    `geographic_region` STRING COMMENT 'Geographic region where the content was delivered (e.g., North America, EMEA, APAC, or specific country/state codes). | Column geographic_region (STRING) in distribution.delivery_event',
    `network_latency_ms` STRING COMMENT 'Network latency measured in milliseconds between CDN edge and viewer device. | Column network_latency_ms (INT) in distribution.delivery_event',
    `origin_server_response_time_ms` STRING COMMENT 'Response time from origin server in milliseconds for cache-miss scenarios. | Column origin_server_response_time_ms (INT) in distribution.delivery_event',
    `resolution` STRING COMMENT 'Video resolution delivered (e.g., 1920x1080, 3840x2160, 1280x720). | Column resolution (STRING) in distribution.delivery_event',
    `scte35_signal_type` STRING COMMENT 'Type of SCTE-35 signal that triggered the DAI event (e.g., splice_insert, time_signal). | Column scte35_signal_type (STRING) in distribution.delivery_event',
    `session_duration_seconds` STRING COMMENT 'Total duration of the delivery session in seconds for streaming events. | Column session_duration_seconds (INT) in distribution.delivery_event',
    `sla_tier` STRING COMMENT 'SLA tier classification applicable to this delivery event (e.g., premium, standard, basic). | Column sla_tier (STRING) in distribution.delivery_event',
    `source_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in distribution.delivery_event',
    `streaming_protocol` STRING COMMENT 'Specific streaming protocol used for OTT delivery (HLS, DASH, Smooth Streaming, RTMP, WebRTC). | Column streaming_protocol (STRING) in distribution.delivery_event. Valid values are `hls|dash|smooth|rtmp|webrtc`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in distribution.delivery_event',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery event record was last updated. | Column updated_timestamp (TIMESTAMP) in distribution.delivery_event',
    `user_agent` STRING COMMENT 'User agent string from the viewer device identifying browser/app and operating system. | Column user_agent (STRING) in distribution.delivery_event',
    `video_codec` STRING COMMENT 'Video codec used for encoding the delivered content (e.g., H.264, H.265/HEVC, VP9, AV1). | Column video_codec (STRING) in distribution.delivery_event',
    `viewer_ip_address` STRING COMMENT 'IP address of the viewer device that received the content delivery. | Column viewer_ip_address (STRING) in distribution.delivery_event',
    CONSTRAINT pk_delivery_event PRIMARY KEY(`delivery_event_id`)
) COMMENT 'Transactional record capturing each discrete content delivery event — including stream session initiations, linear broadcast transmissions, VOD asset deliveries, FAST channel playout events, and dynamic ad insertion (DAI) sessions. Captures event timestamp, event type (stream_start, vod_delivery, broadcast_tx, dai_insertion), delivery channel, content asset reference, delivery technology (HLS, MPEG-DASH, DVB, ATSC), CDN node, geographic region, stream quality (bitrate, resolution), delivery status (success, failure, degraded), error codes, and DAI-specific attributes (ad pod position, SCTE-35 signal, fill rate) where applicable. Feeds delivery SLA monitoring, CDN performance reporting, and AVOD/FAST monetization reconciliation. | Unity Catalog table: media_broadcasting_ecm.distribution.delivery_event';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` (
    `deal_id` BIGINT COMMENT 'Primary key for deal | Column deal_id (BIGINT) in distribution.deal',
    `account_id` BIGINT COMMENT 'Foreign key linking to sales.sales_account. Business justification: Distribution deals (OTT licensing, syndication, MVPD carriage) are commercial contracts owned by a sales account. Revenue reporting, billing, and account management require this direct link. A broadca',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Distribution deals govern rights to carry specific channels. Linking deal to scheduling.channel enables channel-level revenue reporting, deal compliance tracking, and carriage fee reconciliation — a f',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Distribution deals with partners are governed by underlying content license agreements. Critical for validating distribution rights chain, ensuring revenue share terms align with license obligations,  | Column license_agreement_id (BIGINT) in rights.deal',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: deal.platform_type is a denormalized string describing the OTT platform type for the deal. Adding ott_platform_id FK normalizes this — platform name, service tier, DRM requirements, and all platform c',
    `partner_id` BIGINT COMMENT 'Reference to the OTT platform, FAST aggregator, syndication buyer, or international distributor party to this deal. | Column distribution_partner_id (BIGINT) in distribution.deal',
    `programmatic_deal_id` BIGINT COMMENT 'External programmatic deal ID for OpenRTB',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in distribution.deal',
    `_source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in distribution.deal',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in distribution.deal',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the deal automatically renews at expiration unless terminated. True = auto-renews; False = requires explicit renewal. | Column auto_renewal_flag (BOOLEAN) in distribution.deal',
    `content_scope` STRING COMMENT 'Description of the content assets included in this deal. May reference specific titles, series, libraries, or content categories covered by the agreement. | Column content_scope (STRING) in distribution.deal',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in distribution.deal',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this deal record was first created in the system. | Column created_timestamp (TIMESTAMP) in distribution.deal',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this deal (e.g., USD, EUR, GBP). | Column currency_code (STRING) in distribution.deal. Valid values are `^[A-Z]{3}$`',
    `deal_number` STRING COMMENT 'Externally-known unique business identifier for the distribution deal, used in contracts and communications. | Column deal_number (STRING) in distribution.deal',
    `deal_status` STRING COMMENT 'Current lifecycle status of the distribution deal. Tracks progression from initial draft through negotiation, approval, active operation, and eventual closure or renewal. [ENUM-REF-CANDIDATE: draft|negotiation|pending approval|active|suspended|expired|terminated|renewed — 8 candidates stripped; promote to reference product] | Column deal_status (STRING) in distribution.deal',
    `deal_type` STRING COMMENT 'Classification of the distribution deal structure. SVOD licensing = Subscription Video On Demand content licensing; AVOD revenue share = Advertising-Supported Video On Demand with revenue sharing; FAST syndication = Free Ad-Supported Streaming Television channel syndication; linear carriage = traditional broadcast carriage; TVOD licensing = Transactional Video On Demand licensing; international distribution = cross-border content distribution agreements. | Column deal_type (STRING) in distribution.deal. Valid values are `SVOD licensing|AVOD revenue share|FAST syndication|linear carriage|TVOD licensing|international distribution`',
    `dispute_resolution_mechanism` STRING COMMENT 'Agreed method for resolving disputes arising from this deal. | Column dispute_resolution_mechanism (STRING) in distribution.deal. Valid values are `arbitration|mediation|litigation|negotiation`',
    `drm_requirements` STRING COMMENT 'Specification of DRM systems and protection levels required for content delivery under this deal (e.g., Widevine L1, PlayReady SL3000, FairPlay). | Column drm_requirements (STRING) in distribution.deal',
    `effective_date` DATE COMMENT 'Date when the distribution deal becomes active and content distribution rights commence. | Column effective_date (DATE) in distribution.deal',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this deal grants exclusive distribution rights to the partner within the specified territory and platform type. True = exclusive; False = non-exclusive. | Column exclusivity_flag (BOOLEAN) in distribution.deal',
    `exclusivity_window_days` STRING COMMENT 'Duration in days of the exclusivity period or holdback window during which content cannot be distributed through competing channels. | Column exclusivity_window_days (INT) in distribution.deal',
    `expiration_date` DATE COMMENT 'Date when the distribution deal expires and content distribution rights terminate. Nullable for open-ended or perpetual deals. | Column expiration_date (DATE) in distribution.deal',
    `flat_fee_amount` DECIMAL(18,2) COMMENT 'Fixed payment amount for flat fee deal structures. Represents total or periodic payment value. | Column flat_fee_amount (DECIMAL(15,2)) in distribution.deal',
    `floor_price_cpm` DECIMAL(18,2) COMMENT 'Floor price in CPM for programmatic',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction whose laws govern the interpretation and enforcement of this deal (e.g., State of California, England and Wales). | Column governing_law_jurisdiction (STRING) in distribution.deal',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or modification to the deal terms. | Column last_amendment_date (DATE) in distribution.deal',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum Guarantee amount paid upfront or over the deal term, recoupable against future revenue share or royalties. | Column minimum_guarantee_amount (DECIMAL(15,2)) in distribution.deal',
    `minimum_subscriber_guarantee` BIGINT COMMENT 'Minimum number of subscribers or active users the distribution partner guarantees for revenue calculation purposes. | Column minimum_subscriber_guarantee (BIGINT) in distribution.deal',
    `deal_name` STRING COMMENT 'Human-readable name or title of the distribution deal for identification and reporting purposes. | Column deal_name (STRING) in distribution.deal',
    `negotiation_start_date` DATE COMMENT 'Date when commercial negotiations for this deal commenced. | Column negotiation_start_date (DATE) in distribution.deal',
    `notes` STRING COMMENT 'Free-form text field for additional context, special conditions, or internal comments about the deal. | Column notes (STRING) in distribution.deal',
    `payment_terms` STRING COMMENT 'Description of payment schedule, frequency, and conditions (e.g., net 30, quarterly in arrears, monthly advance). | Column payment_terms (STRING) in distribution.deal',
    `programmatic_deal_type` STRING COMMENT 'Programmatic deal type (PMP, PG, open auction)',
    `promotional_commitment` STRING COMMENT 'Description of marketing and promotional activities the distribution partner has committed to perform (e.g., homepage placement, email campaigns, social media promotion). | Column promotional_commitment (STRING) in distribution.deal',
    `renewal_notice_days` STRING COMMENT 'Number of days advance notice required to exercise or decline renewal option before expiration. | Column renewal_notice_days (INT) in distribution.deal',
    `reporting_frequency` STRING COMMENT 'Frequency at which the distribution partner must provide performance and revenue reports. | Column reporting_frequency (STRING) in distribution.deal. Valid values are `monthly|quarterly|semi-annually|annually|on-demand`',
    `revenue_model` STRING COMMENT 'Commercial structure defining how revenue is generated and shared. Flat fee = fixed payment; revenue share = percentage of platform revenue; minimum guarantee = MG against future royalties; hybrid = combination of models; cost per stream = per-view payment; cost per subscriber = per-subscriber payment. | Column revenue_model (STRING) in distribution.deal. Valid values are `flat fee|revenue share|minimum guarantee|hybrid|cost per stream|cost per subscriber`',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue allocated to the content owner under revenue share agreements. Expressed as a percentage (e.g., 65.00 represents 65%). | Column revenue_share_percentage (DECIMAL(5,2)) in distribution.deal',
    `signed_date` DATE COMMENT 'Date when the distribution deal contract was executed by all parties. | Column signed_date (DATE) in distribution.deal',
    `sla_tier` STRING COMMENT 'Service level tier defining uptime, performance, and support commitments for content delivery under this deal. | Column sla_tier (STRING) in distribution.deal. Valid values are `premium|standard|basic`',
    `source_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in distribution.deal',
    `technical_delivery_requirements` STRING COMMENT 'Technical specifications for content delivery including format, resolution, bitrate, codec, and delivery method (e.g., HLS 1080p H.264, DASH 4K HEVC). | Column technical_delivery_requirements (STRING) in distribution.deal',
    `term_months` STRING COMMENT 'Duration of the deal term expressed in months. Calculated from effective date to expiration date. | Column term_months (INT) in distribution.deal',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the deal prior to natural expiration. | Column termination_notice_days (INT) in distribution.deal',
    `territory` STRING COMMENT 'Geographic territory or territories covered by this distribution deal. May be a single country code, multiple countries, or regional designation (e.g., USA, CAN|MEX, EMEA). | Column territory (STRING) in distribution.deal',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in distribution.deal',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this deal record was last modified in the system. | Column updated_timestamp (TIMESTAMP) in distribution.deal',
    CONSTRAINT pk_deal PRIMARY KEY(`deal_id`)
) COMMENT 'Master record for commercial distribution deals negotiated with OTT platforms, FAST aggregators, syndication buyers, and international distributors. Captures deal name, deal type (SVOD licensing, AVOD revenue share, FAST syndication, linear carriage), counterparty, territory, content scope, revenue model (flat fee, revenue share percentage, MG against royalty), deal effective date, expiry date, and deal status. Distinct from carriage_agreement (which is MVPD-specific) — this covers broader OTT and digital distribution commercial arrangements. | Unity Catalog table: media_broadcasting_ecm.distribution.deal';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` (
    `content_delivery_order_id` BIGINT COMMENT 'Unique identifier for the content delivery order. Primary key for this transactional record representing a formal order to deliver content assets to distribution partners or platforms. | Column content_delivery_order_id (BIGINT) in distribution.content_delivery_order',
    `carriage_agreement_id` BIGINT COMMENT 'Reference to the underlying carriage or distribution agreement that authorizes this content delivery. Links order to contractual obligations. | Column carriage_agreement_id (BIGINT) in distribution.content_delivery_order',
    `clearance_id` BIGINT COMMENT 'Foreign key linking to talent.talent_clearance. Business justification: Before fulfilling a content delivery order, operations must verify talent clearances are granted and not blocked. Guild rules and talent contracts require clearance confirmation prior to distribution.',
    `deal_id` BIGINT COMMENT 'Foreign key linking to distribution.deal. Business justification: A content_delivery_order is a formal order to deliver content under the terms of a commercial distribution deal. Linking content_delivery_order to its governing deal enables full order-to-deal traceab',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: A content_delivery_order delivers content to a specific delivery_channel (the logical distribution pathway). Linking content_delivery_order to delivery_channel enables channel-level order tracking, fu',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: A content delivery order must be authorized by a specific rights grant specifying territory, window, media type, and right_type. Operations teams verify the authorizing grant before fulfillment. The e',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Delivery orders fulfill content distribution under specific license agreements. Essential for pre-delivery rights compliance verification, ensuring delivery parameters match license terms, and authori | Column license_agreement_id (BIGINT) in rights.content_delivery_order',
    `media_asset_id` BIGINT COMMENT 'Reference to the specific content asset or package being delivered. Links to the master content asset record in the Digital Assets domain. | Column media_asset_id (BIGINT) in mediaasset.content_delivery_order',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: content_delivery_order.target_platform is a denormalized string describing the target OTT platform for the delivery order. Adding ott_platform_id FK normalizes this — platform name, CDN configuration,',
    `partner_id` BIGINT COMMENT 'Reference to the distribution partner or platform receiving the content. Identifies the counterparty in this delivery transaction. | Column distribution_partner_id (BIGINT) in distribution.content_delivery_order',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: A content delivery order fulfills a specific scheduled slot — this is the operational link between traffic scheduling and distribution fulfillment. Without it, operations cannot trace which scheduled ',
    `streaming_endpoint_id` BIGINT COMMENT 'Reference to the target streaming endpoint or Content Delivery Network (CDN) origin where content will be published. | Column streaming_endpoint_id (BIGINT) in distribution.content_delivery_order',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in distribution.content_delivery_order',
    `_source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in distribution.content_delivery_order',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in distribution.content_delivery_order',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Timestamp when the content was actually delivered and confirmed received by the distribution partner. Used for SLA performance measurement. | Column actual_delivery_timestamp (TIMESTAMP) in distribution.content_delivery_order',
    `approved_by_user` STRING COMMENT 'Username or identifier of the user who approved this delivery order for fulfillment. Tracks authorization and approval workflow. | Column approved_by_user (STRING) in distribution.content_delivery_order',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery order was approved for fulfillment. Marks the transition from draft to active status. | Column approved_timestamp (TIMESTAMP) in distribution.content_delivery_order',
    `audio_configuration` STRING COMMENT 'Audio channel configuration and format for the delivered content. Defines the immersive audio capabilities and speaker layout. | Column audio_configuration (STRING) in distribution.content_delivery_order. Valid values are `stereo|surround_5_1|surround_7_1|dolby_atmos|dts_x`',
    `audio_languages` STRING COMMENT 'Comma-separated list of ISO 639-2 language codes for audio tracks included in the delivery. Supports multi-language distribution requirements. | Column audio_languages (STRING) in distribution.content_delivery_order',
    `closed_captions_included` BOOLEAN COMMENT 'Indicates whether closed captions are included in the delivered content. Required for FCC compliance and accessibility standards. | Column closed_captions_included (BOOLEAN) in distribution.content_delivery_order',
    `content_duration_seconds` STRING COMMENT 'Total runtime duration of the content asset being delivered, measured in seconds. Used for capacity planning and delivery time estimation. | Column content_duration_seconds (INT) in distribution.content_delivery_order',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in distribution.content_delivery_order',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this delivery order. Provides accountability and audit trail for order origination. | Column created_by_user (STRING) in distribution.content_delivery_order',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery order record was first created in the system. Audit trail for record lifecycle tracking. | Column created_timestamp (TIMESTAMP) in distribution.content_delivery_order',
    `delivery_deadline_timestamp` TIMESTAMP COMMENT 'Precise deadline timestamp for content delivery. Used for Service Level Agreement (SLA) compliance tracking and penalty calculations. | Column delivery_deadline_timestamp (TIMESTAMP) in distribution.content_delivery_order',
    `delivery_format` STRING COMMENT 'Required content format for delivery. Specifies the container format, codec, and packaging standard expected by the distribution partner. [ENUM-REF-CANDIDATE: hls|mpeg_dash|smooth_streaming|mxf|mp4|prores|imf — 7 candidates stripped; promote to reference product] | Column delivery_format (STRING) in distribution.content_delivery_order',
    `delivery_method` STRING COMMENT 'Technical method or protocol used to transfer the content to the distribution partner. Defines the transport mechanism for content delivery. | Column delivery_method (STRING) in distribution.content_delivery_order. Valid values are `cdn_push|ftp|aspera|satellite_uplink|physical_media|api`',
    `delivery_notes` STRING COMMENT 'Free-text notes and special instructions for the delivery order. Captures partner-specific requirements, technical considerations, or operational alerts. | Column delivery_notes (STRING) in distribution.content_delivery_order',
    `estimated_delivery_duration_minutes` STRING COMMENT 'Estimated time required to complete the content delivery, measured in minutes. Based on file size, bandwidth, and delivery method. | Column estimated_delivery_duration_minutes (INT) in distribution.content_delivery_order',
    `failure_reason` STRING COMMENT 'Description of the reason for delivery failure if order status is failed. Used for root cause analysis and process improvement. | Column failure_reason (STRING) in distribution.content_delivery_order',
    `file_size_gb` DECIMAL(18,2) COMMENT 'Total file size of the content package being delivered, measured in gigabytes. Used for bandwidth planning and cost estimation. | Column file_size_gb (DECIMAL(12,3)) in distribution.content_delivery_order',
    `fulfillment_confirmation_number` STRING COMMENT 'Unique confirmation identifier provided upon successful delivery completion. Used for proof of delivery and reconciliation with distribution partners. | Column fulfillment_confirmation_number (STRING) in distribution.content_delivery_order',
    `geographic_restrictions` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where content delivery is restricted or permitted. Enforces territorial rights and blackout rules. | Column geographic_restrictions (STRING) in distribution.content_delivery_order',
    `hdr_format` STRING COMMENT 'High Dynamic Range format specification for the delivered content. Defines the color space and dynamic range capabilities. | Column hdr_format (STRING) in distribution.content_delivery_order. Valid values are `sdr|hdr10|hdr10_plus|dolby_vision|hlg`',
    `order_date` TIMESTAMP COMMENT 'Timestamp when the delivery order was created or placed. Represents the principal business event time for this transaction. | Column order_date (TIMESTAMP) in distribution.content_delivery_order',
    `order_number` STRING COMMENT 'Externally-known unique business identifier for this delivery order. Used for tracking, communication, and reconciliation with distribution partners. | Column order_number (STRING) in distribution.content_delivery_order. Valid values are `^CDO-[0-9]{8}-[A-Z0-9]{6}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the delivery order. Tracks the order through its workflow from creation to fulfillment or cancellation. [ENUM-REF-CANDIDATE: draft|pending|approved|in_progress|delivered|failed|cancelled — 7 candidates stripped; promote to reference product] | Column order_status (STRING) in distribution.content_delivery_order',
    `order_type` STRING COMMENT 'Classification of the delivery order type. Indicates the nature and urgency of the content delivery request. | Column order_type (STRING) in distribution.content_delivery_order. Valid values are `new_release|refresh|replacement|emergency|scheduled|on_demand`',
    `priority_level` STRING COMMENT 'Business priority assigned to this delivery order. Determines resource allocation and scheduling precedence in the delivery queue. | Column priority_level (STRING) in distribution.content_delivery_order. Valid values are `critical|high|normal|low`',
    `requested_delivery_date` DATE COMMENT 'Target date by which the content must be delivered to the distribution partner. Drives scheduling and prioritization of delivery tasks. | Column requested_delivery_date (DATE) in distribution.content_delivery_order',
    `retry_count` STRING COMMENT 'Number of delivery attempts made for this order. Tracks resilience and reliability of the delivery process. | Column retry_count (INT) in distribution.content_delivery_order',
    `sla_tier` STRING COMMENT 'Service level tier assigned to this delivery order. Determines performance targets, priority, and penalty provisions. | Column sla_tier (STRING) in distribution.content_delivery_order. Valid values are `platinum|gold|silver|bronze|standard`',
    `source_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in distribution.content_delivery_order',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of ISO 639-2 language codes for subtitle tracks included in the delivery. Supports accessibility and international distribution. | Column subtitle_languages (STRING) in distribution.content_delivery_order',
    `transcode_profile_code` BIGINT COMMENT 'Reference to the transcode profile specifying encoding parameters, bitrates, resolutions, and quality settings for content preparation. | Column transcode_profile_code (BIGINT) in distribution.content_delivery_order',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in distribution.content_delivery_order',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery order record was last modified. Tracks the most recent change to any field in the record. | Column updated_timestamp (TIMESTAMP) in distribution.content_delivery_order',
    `video_resolution` STRING COMMENT 'Target video resolution for the delivered content. Specifies the quality tier and display format for the distribution platform. | Column video_resolution (STRING) in distribution.content_delivery_order. Valid values are `sd|hd_720p|hd_1080p|uhd_4k|uhd_8k`',
    CONSTRAINT pk_content_delivery_order PRIMARY KEY(`content_delivery_order_id`)
) COMMENT 'Transactional record representing a formal order to deliver a specific content asset or package to a distribution partner or platform by a specified deadline. Captures order type (new release, refresh, replacement, emergency), content asset reference, target distribution platform, required delivery format, transcode profile, DRM policy, delivery deadline, delivery method (CDN push, FTP, Aspera, satellite uplink), order status, and fulfillment confirmation. Operationalizes the distribution deal and window commitments into actionable delivery tasks. | Unity Catalog table: media_broadcasting_ecm.distribution.content_delivery_order';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_failover_streaming_endpoint_id` FOREIGN KEY (`failover_streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`deal`(`deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_carriage_agreement_id` FOREIGN KEY (`carriage_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement`(`carriage_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_playback_session_id` FOREIGN KEY (`playback_session_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`playback_session`(`playback_session_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`deal`(`deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_carriage_agreement_id` FOREIGN KEY (`carriage_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement`(`carriage_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`deal`(`deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`distribution` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`distribution` SET TAGS ('dbx_domain' = 'distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` SET TAGS ('dbx_subdomain' = 'platform_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Top (OTT) Platform ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.ott_platform_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.ott_platform_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `_source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `_source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `_source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `_source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `adobe_property_code` SET TAGS ('dbx_business_glossary_term' = 'Adobe Experience Platform Property ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `adobe_property_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `adobe_property_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `adobe_property_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.adobe_property_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `adobe_property_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.adobe_property_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `adobe_property_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `arpu` SET TAGS ('dbx_business_glossary_term' = 'Average Revenue Per User (ARPU)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `arpu` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `arpu` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `arpu` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.arpu');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `arpu` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.arpu');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `base_subscription_price` SET TAGS ('dbx_business_glossary_term' = 'Base Subscription Price');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `base_subscription_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `base_subscription_price` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `base_subscription_price` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.base_subscription_price');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `base_subscription_price` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.base_subscription_price');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `billing_currency` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency (ISO 4217)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `billing_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `billing_currency` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `billing_currency` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.billing_currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `billing_currency` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.billing_currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_origin_url` SET TAGS ('dbx_business_glossary_term' = 'CDN Origin URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_origin_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9._/-]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_origin_url` SET TAGS ('dbx_validation_regex_^https?' = '//[^s]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_origin_url` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_origin_url` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.cdn_origin_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_origin_url` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.cdn_origin_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Provider');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_value_regex' = 'Akamai|Cloudflare|AWS CloudFront|Fastly|Multi-CDN');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.cdn_provider');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.cdn_provider');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_business_glossary_term' = 'Content Rating System');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_value_regex' = 'MPAA|BBFC|FSK|ACB|CBFC|TV-PG');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.content_rating_system');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.content_rating_system');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `coppa_compliant` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Compliant Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `coppa_compliant` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `coppa_compliant` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.coppa_compliant');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `coppa_compliant` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.coppa_compliant');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.dai_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.dai_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `dai_provider` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Provider');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `dai_provider` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `dai_provider` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.dai_provider');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `dai_provider` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.dai_provider');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `drm_system` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) System');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `drm_system` SET TAGS ('dbx_value_regex' = 'Widevine|FairPlay|PlayReady|Multi-DRM|NONE');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `drm_system` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `drm_system` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.drm_system');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `drm_system` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.drm_system');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `epg_feed_url` SET TAGS ('dbx_business_glossary_term' = 'Electronic Program Guide (EPG) Feed URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `epg_feed_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9._/-]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `epg_feed_url` SET TAGS ('dbx_validation_regex_^https?' = '//[^s]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `epg_feed_url` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `epg_feed_url` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.epg_feed_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `epg_feed_url` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.epg_feed_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `fast_channel_enabled` SET TAGS ('dbx_business_glossary_term' = 'Free Ad-Supported Streaming Television (FAST) Channel Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `fast_channel_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `fast_channel_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.fast_channel_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `fast_channel_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.fast_channel_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `free_trial_days` SET TAGS ('dbx_business_glossary_term' = 'Free Trial Period (Days)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `free_trial_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `free_trial_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.free_trial_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `free_trial_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.free_trial_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.gdpr_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.gdpr_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `hdr_supported` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Support Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `hdr_supported` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `hdr_supported` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.hdr_supported');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `hdr_supported` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.hdr_supported');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Platform Launch Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `launch_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `launch_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.launch_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `launch_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.launch_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_concurrent_streams` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Streams Per Subscriber');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_concurrent_streams` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_concurrent_streams` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.max_concurrent_streams');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_concurrent_streams` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.max_concurrent_streams');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_download_devices` SET TAGS ('dbx_business_glossary_term' = 'Maximum Offline Download Devices');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_download_devices` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_download_devices` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.max_download_devices');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_download_devices` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.max_download_devices');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Maximum Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_video_resolution` SET TAGS ('dbx_value_regex' = 'SD|HD|FHD|4K|8K');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_video_resolution` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_video_resolution` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.max_video_resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_video_resolution` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.max_video_resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `mvpd_carriage_eligible` SET TAGS ('dbx_business_glossary_term' = 'Multichannel Video Programming Distributor (MVPD) Carriage Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `mvpd_carriage_eligible` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `mvpd_carriage_eligible` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.mvpd_carriage_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `mvpd_carriage_eligible` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.mvpd_carriage_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `parent_brand` SET TAGS ('dbx_business_glossary_term' = 'Parent Brand Identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `parent_brand` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `parent_brand` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.parent_brand');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `parent_brand` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.parent_brand');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'OTT Platform Business Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,30}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.platform_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.platform_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_description` SET TAGS ('dbx_business_glossary_term' = 'OTT Platform Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_description` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_description` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.platform_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_description` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.platform_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_name` SET TAGS ('dbx_business_glossary_term' = 'OTT Platform Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.platform_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.platform_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_status` SET TAGS ('dbx_business_glossary_term' = 'OTT Platform Operational Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_status` SET TAGS ('dbx_value_regex' = 'active|inactive|beta|sunset|suspended');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.platform_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.platform_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `primary_streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Primary Streaming Protocol (HLS/MPEG-DASH)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `primary_streaming_protocol` SET TAGS ('dbx_value_regex' = 'HLS|MPEG-DASH|HLS,MPEG-DASH|RTMP|SRT');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `primary_streaming_protocol` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `primary_streaming_protocol` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.primary_streaming_protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `primary_streaming_protocol` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.primary_streaming_protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `service_tier` SET TAGS ('dbx_business_glossary_term' = 'OTT Service Tier (SVOD/AVOD/TVOD/FAST)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `service_tier` SET TAGS ('dbx_value_regex' = 'SVOD|AVOD|TVOD|FAST|HYBRID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `service_tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `service_tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.service_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `service_tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.service_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `service_tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `sla_uptime_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Target Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `sla_uptime_target_pct` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `sla_uptime_target_pct` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.sla_uptime_target_pct');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `sla_uptime_target_pct` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.sla_uptime_target_pct');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `subscriber_count` SET TAGS ('dbx_business_glossary_term' = 'Active Subscriber Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `subscriber_count` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `subscriber_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `subscriber_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.subscriber_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `subscriber_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.subscriber_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `sunset_date` SET TAGS ('dbx_business_glossary_term' = 'Platform Sunset Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `sunset_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `sunset_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.sunset_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `sunset_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.sunset_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `supported_device_classes` SET TAGS ('dbx_business_glossary_term' = 'Supported Device Classes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `supported_device_classes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `supported_device_classes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.supported_device_classes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `supported_device_classes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.supported_device_classes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `target_start_bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Target Start Bitrate (Kbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `target_start_bitrate_kbps` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `target_start_bitrate_kbps` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.target_start_bitrate_kbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `target_start_bitrate_kbps` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.target_start_bitrate_kbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `zuora_product_code` SET TAGS ('dbx_business_glossary_term' = 'Zuora Product Catalog ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `zuora_product_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `zuora_product_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.ott_platform.zuora_product_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `zuora_product_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.ott_platform.zuora_product_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `zuora_product_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` SET TAGS ('dbx_subdomain' = 'platform_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.streaming_endpoint_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.streaming_endpoint_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `failover_streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Failover Endpoint Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `failover_streaming_endpoint_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `failover_streaming_endpoint_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.failover_endpoint_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `failover_streaming_endpoint_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.failover_endpoint_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.ott_platform_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.ott_platform_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `_source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `_source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `_source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `_source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.activated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.activated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `bandwidth_limit_gbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Limit Gigabits Per Second (Gbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `bandwidth_limit_gbps` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `bandwidth_limit_gbps` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.bandwidth_limit_gbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `bandwidth_limit_gbps` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.bandwidth_limit_gbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `cache_ttl_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cache Time To Live (TTL) Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `cache_ttl_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `cache_ttl_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.cache_ttl_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `cache_ttl_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.cache_ttl_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `cost_per_gb` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Gigabyte (GB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `cost_per_gb` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `cost_per_gb` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `cost_per_gb` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.cost_per_gb');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `cost_per_gb` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.cost_per_gb');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.dai_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.dai_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deactivated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.deactivated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.deactivated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `drm_license_server_url` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) License Server URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `drm_license_server_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `drm_license_server_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `drm_license_server_url` SET TAGS ('dbx_validation_regex_^https?' = '//[^s]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `drm_license_server_url` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `drm_license_server_url` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.drm_license_server_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `drm_license_server_url` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.drm_license_server_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.endpoint_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.endpoint_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_type` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_type` SET TAGS ('dbx_value_regex' = 'origin|edge|backup');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.endpoint_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.endpoint_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_validation_regex_^https?' = '//[^s]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.endpoint_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.endpoint_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `geo_restriction_mode` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `geo_restriction_mode` SET TAGS ('dbx_value_regex' = 'whitelist|blacklist|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `geo_restriction_mode` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `geo_restriction_mode` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.geo_restriction_mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `geo_restriction_mode` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.geo_restriction_mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `geo_restriction_rules` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Rules');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `geo_restriction_rules` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `geo_restriction_rules` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.geo_restriction_rules');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `geo_restriction_rules` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.geo_restriction_rules');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Health Check Interval Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.health_check_interval_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.health_check_interval_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_business_glossary_term' = 'Health Check URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_validation_regex_^https?' = '//[^s]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.health_check_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.health_check_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ipv6_enabled` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol Version 6 (IPv6) Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ipv6_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ipv6_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.ipv6_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ipv6_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.ipv6_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Health Check Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.last_health_check_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.last_health_check_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `manifest_format` SET TAGS ('dbx_business_glossary_term' = 'Manifest Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `manifest_format` SET TAGS ('dbx_value_regex' = 'm3u8|mpd|ism|f4m');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `manifest_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `manifest_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.manifest_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `manifest_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.manifest_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `manifest_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `max_bitrate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bitrate Megabits Per Second (Mbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `max_bitrate_mbps` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `max_bitrate_mbps` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.max_bitrate_mbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `max_bitrate_mbps` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.max_bitrate_mbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|degraded|failed');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.operational_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.operational_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_business_glossary_term' = 'Provisioned Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.provisioned_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.provisioned_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Target Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.sla_uptime_target_percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.sla_uptime_target_percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ssl_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Secure Sockets Layer (SSL) Certificate Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ssl_certificate_expiry_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ssl_certificate_expiry_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.ssl_certificate_expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ssl_certificate_expiry_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.ssl_certificate_expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'HLS|MPEG-DASH|RTMP|WebRTC|Smooth Streaming');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.streaming_protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.streaming_protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `supported_devices` SET TAGS ('dbx_business_glossary_term' = 'Supported Devices');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `supported_devices` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `supported_devices` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.supported_devices');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `supported_devices` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.supported_devices');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `token_authentication_scheme` SET TAGS ('dbx_business_glossary_term' = 'Token Authentication Scheme');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `token_authentication_scheme` SET TAGS ('dbx_value_regex' = 'JWT|HMAC|Akamai Token|AWS Signature|None');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `token_authentication_scheme` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `token_authentication_scheme` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.token_authentication_scheme');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `token_authentication_scheme` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.token_authentication_scheme');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.streaming_endpoint.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.streaming_endpoint.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` SET TAGS ('dbx_subdomain' = 'platform_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_business_glossary_term' = 'Playback Session ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.playback_session_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.playback_session_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.demographic_segment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.demographic_segment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `epg_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Epg Entry Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `grant_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `grant_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.grant_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `grant_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.grant_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.campaign_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.campaign_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.streaming_endpoint_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.streaming_endpoint_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.subscriber_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.subscriber_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `_source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `_source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `_source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `_source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `ad_breaks_served_count` SET TAGS ('dbx_business_glossary_term' = 'Ad Breaks Served Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `ad_breaks_served_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `ad_breaks_served_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.ad_breaks_served_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `ad_breaks_served_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.ad_breaks_served_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `audio_language` SET TAGS ('dbx_business_glossary_term' = 'Audio Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `audio_language` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `audio_language` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.audio_language');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `audio_language` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.audio_language');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `average_bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Average Bitrate (Kilobits Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `average_bitrate_kbps` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `average_bitrate_kbps` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.average_bitrate_kbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `average_bitrate_kbps` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.average_bitrate_kbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `cdn_pop_location` SET TAGS ('dbx_business_glossary_term' = 'CDN (Content Delivery Network) PoP (Point of Presence) Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `cdn_pop_location` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `cdn_pop_location` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.cdn_pop_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `cdn_pop_location` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.cdn_pop_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `closed_captions_enabled` SET TAGS ('dbx_business_glossary_term' = 'Closed Captions Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `closed_captions_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `closed_captions_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.closed_captions_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `closed_captions_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.closed_captions_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.completion_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.completion_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `content_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Content Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `content_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `content_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.content_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `content_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.content_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_business_glossary_term' = 'DAI (Dynamic Ad Insertion) Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.dai_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.dai_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `error_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `error_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.error_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `error_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.error_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `error_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `exit_reason` SET TAGS ('dbx_business_glossary_term' = 'Exit Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `exit_reason` SET TAGS ('dbx_value_regex' = 'user_stop|completion|error|timeout|network_failure|drm_failure');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `exit_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `exit_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.exit_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `exit_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.exit_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `geographic_city` SET TAGS ('dbx_business_glossary_term' = 'Geographic City');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `geographic_city` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `geographic_city` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.geographic_city');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `geographic_city` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.geographic_city');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `geographic_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Postal Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `geographic_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `geographic_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `geographic_postal_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `geographic_postal_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.geographic_postal_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `geographic_postal_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.geographic_postal_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `geographic_postal_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `initial_buffering_duration_ms` SET TAGS ('dbx_business_glossary_term' = 'Initial Buffering Duration (Milliseconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `initial_buffering_duration_ms` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `initial_buffering_duration_ms` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.initial_buffering_duration_ms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `initial_buffering_duration_ms` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.initial_buffering_duration_ms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_mode` SET TAGS ('dbx_business_glossary_term' = 'Playback Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_mode` SET TAGS ('dbx_value_regex' = 'live|vod|dvr|restart');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_mode` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_mode` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.playback_mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_mode` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.playback_mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `rebuffering_events_count` SET TAGS ('dbx_business_glossary_term' = 'Rebuffering Events Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `rebuffering_events_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `rebuffering_events_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.rebuffering_events_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `rebuffering_events_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.rebuffering_events_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.session_created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.session_created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.session_end_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.session_end_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.session_start_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.session_start_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.session_updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.session_updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'hls|mpeg_dash|smooth_streaming');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.streaming_protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.streaming_protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subtitle_language` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subtitle_language` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subtitle_language` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.subtitle_language');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subtitle_language` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.subtitle_language');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `total_ad_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Ad Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `total_ad_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `total_ad_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.total_ad_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `total_ad_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.total_ad_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `total_rebuffering_duration_ms` SET TAGS ('dbx_business_glossary_term' = 'Total Rebuffering Duration (Milliseconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `total_rebuffering_duration_ms` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `total_rebuffering_duration_ms` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.total_rebuffering_duration_ms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `total_rebuffering_duration_ms` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.total_rebuffering_duration_ms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `total_watch_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Watch Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `total_watch_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `total_watch_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.total_watch_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `total_watch_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.total_watch_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `video_resolution` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `video_resolution` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.video_resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `video_resolution` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.video_resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `video_resolution` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Viewer IP (Internet Protocol) Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.playback_session.viewer_ip_address');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.playback_session.viewer_ip_address');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `partner_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `partner_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.distribution_partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `partner_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.distribution_partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `_source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `_source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `_source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `_source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `abr_profile_support` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile Support');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `abr_profile_support` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `abr_profile_support` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.abr_profile_support');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `abr_profile_support` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.abr_profile_support');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `blackout_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Geographic Blackout Capability Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `blackout_capability_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `blackout_capability_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.blackout_capability_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `blackout_capability_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.blackout_capability_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_capacity_channels` SET TAGS ('dbx_business_glossary_term' = 'Carriage Capacity in Channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_capacity_channels` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_capacity_channels` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.carriage_capacity_channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_capacity_channels` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.carriage_capacity_channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_fee_model` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_fee_model` SET TAGS ('dbx_value_regex' = 'Per Subscriber|Flat Rate|Revenue Share|Hybrid|No Fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_fee_model` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_fee_model` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_fee_model` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.carriage_fee_model');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_fee_model` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.carriage_fee_model');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Provider');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.cdn_provider');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.cdn_provider');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Contract End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.contract_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.contract_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Notice Period in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_renewal_notice_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_renewal_notice_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_renewal_notice_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.contract_renewal_notice_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_renewal_notice_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.contract_renewal_notice_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Contract Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.contract_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.contract_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `dai_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Support Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `dai_support_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `dai_support_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.dai_support_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `dai_support_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.dai_support_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `drm_capability` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Capability');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `drm_capability` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `drm_capability` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.drm_capability');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `drm_capability` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.drm_capability');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `geographic_footprint` SET TAGS ('dbx_business_glossary_term' = 'Geographic Distribution Footprint');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `geographic_footprint` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `geographic_footprint` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.geographic_footprint');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `geographic_footprint` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.geographic_footprint');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.headquarters_address');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.headquarters_address');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.headquarters_city');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.headquarters_city');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_validation_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.headquarters_country_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.headquarters_country_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.headquarters_postal_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.headquarters_postal_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.headquarters_state_province');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.headquarters_state_province');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `must_carry_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Must-Carry Obligation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `must_carry_obligation_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `must_carry_obligation_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.must_carry_obligation_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `must_carry_obligation_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.must_carry_obligation_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'MVPD|vMVPD|OTT Platform|FAST Aggregator|Syndication Outlet|Cable Operator');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.partner_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.partner_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.payment_terms_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.payment_terms_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `portal_url` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Portal Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `portal_url` SET TAGS ('dbx_validation_regex_^https?' = '//[^s]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `portal_url` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `portal_url` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.portal_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `portal_url` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.portal_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.preferred_currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.preferred_currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_validation_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.primary_contact_email');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.primary_contact_email');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.primary_contact_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.primary_contact_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_validation_regex' = '^+?[1-9]d{1');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_14}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.primary_contact_phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.primary_contact_phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `qos_monitoring_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Monitoring Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `qos_monitoring_enabled_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `qos_monitoring_enabled_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.qos_monitoring_enabled_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `qos_monitoring_enabled_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.qos_monitoring_enabled_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Relationship Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Pending|Terminated|Under Negotiation');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `relationship_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `relationship_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.relationship_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `relationship_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.relationship_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `relationship_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `retransmission_consent_status` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `retransmission_consent_status` SET TAGS ('dbx_value_regex' = 'Granted|Denied|Pending|Not Applicable|Under Negotiation');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `retransmission_consent_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `retransmission_consent_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.retransmission_consent_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `retransmission_consent_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.retransmission_consent_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `retransmission_consent_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `sla_latency_target_ms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Latency Target in Milliseconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `sla_latency_target_ms` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `sla_latency_target_ms` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.sla_latency_target_ms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `sla_latency_target_ms` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.sla_latency_target_ms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Target Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.sla_uptime_target_percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.sla_uptime_target_percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `subscriber_reach_estimate` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Reach Estimate');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `subscriber_reach_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `subscriber_reach_estimate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `subscriber_reach_estimate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.subscriber_reach_estimate');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `subscriber_reach_estimate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.subscriber_reach_estimate');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `technical_delivery_standards` SET TAGS ('dbx_business_glossary_term' = 'Technical Delivery Standards Supported');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `technical_delivery_standards` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `technical_delivery_standards` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.technical_delivery_standards');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `technical_delivery_standards` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.technical_delivery_standards');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'Tier 1|Tier 2|Tier 3|Strategic|Emerging');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.partner_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.partner_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.distribution_partner.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.distribution_partner.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.carriage_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.carriage_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.distribution_partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.distribution_partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `_source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `_source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `_source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `_source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.agreement_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.agreement_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|under_negotiation');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.agreement_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.agreement_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'retransmission_consent|must_carry|voluntary_carriage|platform_carriage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.agreement_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.agreement_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.auto_renewal_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.auto_renewal_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `blackout_provisions` SET TAGS ('dbx_business_glossary_term' = 'Blackout Provisions');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `blackout_provisions` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `blackout_provisions` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.blackout_provisions');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `blackout_provisions` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.blackout_provisions');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.carriage_fee_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.carriage_fee_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_currency` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_currency` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.carriage_fee_currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_currency` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.carriage_fee_currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Structure');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_value_regex' = 'per_subscriber|flat_monthly|tiered|revenue_share|barter');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.carriage_fee_structure');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.carriage_fee_structure');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_number_assignment` SET TAGS ('dbx_business_glossary_term' = 'Channel Number Assignment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_number_assignment` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_number_assignment` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.channel_number_assignment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_number_assignment` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.channel_number_assignment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_positioning_tier` SET TAGS ('dbx_business_glossary_term' = 'Channel Positioning Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_positioning_tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_positioning_tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.channel_positioning_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_positioning_tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.channel_positioning_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_positioning_tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `compensation_terms` SET TAGS ('dbx_business_glossary_term' = 'Compensation Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `compensation_terms` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `compensation_terms` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `compensation_terms` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `compensation_terms` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.compensation_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `compensation_terms` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.compensation_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_value_regex' = 'arbitration|mediation|litigation|negotiation');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.dispute_resolution_mechanism');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.dispute_resolution_mechanism');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `drm_requirements` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `drm_requirements` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `drm_requirements` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.drm_requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `drm_requirements` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.drm_requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.effective_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.effective_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `exclusivity_window` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Window');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `exclusivity_window` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `exclusivity_window` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.exclusivity_window');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `exclusivity_window` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.exclusivity_window');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.expiration_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.expiration_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.geographic_coverage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.geographic_coverage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.governing_law_jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.governing_law_jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `holdback_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Holdback Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `holdback_restrictions` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `holdback_restrictions` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.holdback_restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `holdback_restrictions` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.holdback_restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.last_amendment_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.last_amendment_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `minimum_subscriber_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Minimum Subscriber Guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `minimum_subscriber_guarantee` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `minimum_subscriber_guarantee` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.minimum_subscriber_guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `minimum_subscriber_guarantee` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.minimum_subscriber_guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `must_carry_election` SET TAGS ('dbx_business_glossary_term' = 'Must-Carry Election');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `must_carry_election` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `must_carry_election` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.must_carry_election');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `must_carry_election` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.must_carry_election');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `negotiation_history` SET TAGS ('dbx_business_glossary_term' = 'Negotiation History');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `negotiation_history` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `negotiation_history` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.negotiation_history');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `negotiation_history` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.negotiation_history');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `promotional_commitment` SET TAGS ('dbx_business_glossary_term' = 'Promotional Commitment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `promotional_commitment` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `promotional_commitment` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.promotional_commitment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `promotional_commitment` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.promotional_commitment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.renewal_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.renewal_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `retransmission_consent_granted` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent Granted');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `retransmission_consent_granted` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `retransmission_consent_granted` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.retransmission_consent_granted');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `retransmission_consent_granted` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.retransmission_consent_granted');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.service_level_agreement');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.service_level_agreement');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_business_glossary_term' = 'Technical Delivery Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.technical_delivery_requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.technical_delivery_requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.termination_notice_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.termination_notice_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.carriage_agreement.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.carriage_agreement.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` SET TAGS ('dbx_subdomain' = 'platform_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.delivery_channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.delivery_channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `_source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `_source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `_source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `_source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `ad_insertion_method` SET TAGS ('dbx_business_glossary_term' = 'Ad Insertion Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `ad_insertion_method` SET TAGS ('dbx_value_regex' = 'server-side|client-side|dai|scte-35|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `ad_insertion_method` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `ad_insertion_method` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.ad_insertion_method');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `ad_insertion_method` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.ad_insertion_method');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `ad_insertion_method` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `audio_format` SET TAGS ('dbx_business_glossary_term' = 'Audio Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `audio_format` SET TAGS ('dbx_value_regex' = 'stereo|dolby-digital|dolby-atmos|dts|aac');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `audio_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `audio_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.audio_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `audio_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.audio_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `audio_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `blackout_rules_enabled` SET TAGS ('dbx_business_glossary_term' = 'Blackout Rules Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `blackout_rules_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `blackout_rules_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.blackout_rules_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `blackout_rules_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.blackout_rules_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee United States Dollars (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.carriage_fee_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.carriage_fee_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'linear|ott|fast|simulcast|vod|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.channel_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.channel_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `content_refresh_cadence` SET TAGS ('dbx_business_glossary_term' = 'Content Refresh Cadence');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `content_refresh_cadence` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|on-demand|continuous');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `content_refresh_cadence` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `content_refresh_cadence` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.content_refresh_cadence');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `content_refresh_cadence` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.content_refresh_cadence');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_business_glossary_term' = 'Delivery Technology Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.delivery_technology');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.delivery_technology');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `fast_aggregator_platform` SET TAGS ('dbx_business_glossary_term' = 'Free Ad-Supported Streaming Television (FAST) Aggregator Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `fast_aggregator_platform` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `fast_aggregator_platform` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.fast_aggregator_platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `fast_aggregator_platform` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.fast_aggregator_platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `fast_playlist_type` SET TAGS ('dbx_business_glossary_term' = 'Free Ad-Supported Streaming Television (FAST) Playlist Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `fast_playlist_type` SET TAGS ('dbx_value_regex' = 'linear-loop|scheduled|dynamic|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `fast_playlist_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `fast_playlist_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.fast_playlist_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `fast_playlist_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.fast_playlist_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `fast_playlist_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `genre_category` SET TAGS ('dbx_business_glossary_term' = 'Genre Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `genre_category` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `genre_category` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.genre_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `genre_category` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.genre_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `genre_category` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `is_active` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `is_active` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.is_active');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `is_active` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.is_active');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `launch_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `launch_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.launch_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `launch_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.launch_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `max_bitrate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bitrate Megabits Per Second (Mbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `max_bitrate_mbps` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `max_bitrate_mbps` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.max_bitrate_mbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `max_bitrate_mbps` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.max_bitrate_mbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `monetization_model` SET TAGS ('dbx_business_glossary_term' = 'Monetization Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `monetization_model` SET TAGS ('dbx_value_regex' = 'avod|svod|tvod|hybrid|free');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `monetization_model` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `monetization_model` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.monetization_model');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `monetization_model` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.monetization_model');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|testing|planned|retired');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `operational_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `operational_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.operational_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `operational_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.operational_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `operational_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `parental_control_rating` SET TAGS ('dbx_business_glossary_term' = 'Parental Control Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `parental_control_rating` SET TAGS ('dbx_value_regex' = 'tv-y|tv-y7|tv-g|tv-pg|tv-14|tv-ma');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `parental_control_rating` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `parental_control_rating` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.parental_control_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `parental_control_rating` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.parental_control_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.primary_language');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.primary_language');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `qos_tier` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `qos_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|basic');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `qos_tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `qos_tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.qos_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `qos_tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.qos_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `qos_tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `resolution_format` SET TAGS ('dbx_business_glossary_term' = 'Resolution Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `resolution_format` SET TAGS ('dbx_value_regex' = 'sd|hd|full-hd|4k-uhd|8k-uhd');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `resolution_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `resolution_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.resolution_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `resolution_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.resolution_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `resolution_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `retirement_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `retirement_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.retirement_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `retirement_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.retirement_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `retransmission_consent_required` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `retransmission_consent_required` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `retransmission_consent_required` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.retransmission_consent_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `retransmission_consent_required` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.retransmission_consent_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `sla_uptime_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `sla_uptime_percent` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `sla_uptime_percent` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.sla_uptime_percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `sla_uptime_percent` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.sla_uptime_percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_demographic` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_demographic` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.target_demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_demographic` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.target_demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_demographic` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_market` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_market` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_market` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.target_market');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_market` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.target_market');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_channel.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_channel.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` SET TAGS ('dbx_subdomain' = 'platform_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_event_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Event ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_event_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_event_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.delivery_event_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_event_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.delivery_event_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `ad_break_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Break Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `ad_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Line Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `ad_spot_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Spot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `grant_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `grant_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.grant_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `grant_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.grant_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_business_glossary_term' = 'Playback Session ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.playback_session_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.playback_session_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.campaign_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.campaign_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.streaming_endpoint_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.streaming_endpoint_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `_source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `_source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `_source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `_source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `ad_fill_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Ad Fill Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `ad_fill_rate_percent` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `ad_fill_rate_percent` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.ad_fill_rate_percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `ad_fill_rate_percent` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.ad_fill_rate_percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.ad_pod_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.ad_pod_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `audio_codec` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `audio_codec` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.audio_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `audio_codec` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.audio_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `audio_codec` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Bitrate (Kilobits Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.bitrate_kbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.bitrate_kbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `bytes_delivered` SET TAGS ('dbx_business_glossary_term' = 'Bytes Delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `bytes_delivered` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `bytes_delivered` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.bytes_delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `bytes_delivered` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.bytes_delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `cdn_cache_status` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Cache Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `cdn_cache_status` SET TAGS ('dbx_value_regex' = 'hit|miss|stale|bypass');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `cdn_cache_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `cdn_cache_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.cdn_cache_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `cdn_cache_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.cdn_cache_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `cdn_cache_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `cdn_node_code` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Node ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `cdn_node_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `cdn_node_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.cdn_node_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `cdn_node_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.cdn_node_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `cdn_node_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `cdn_pop_location` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Point of Presence (POP) Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `cdn_pop_location` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `cdn_pop_location` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.cdn_pop_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `cdn_pop_location` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.cdn_pop_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.dai_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.dai_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'success|failure|degraded|partial');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.delivery_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.delivery_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_business_glossary_term' = 'Delivery Technology');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.delivery_technology');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.delivery_technology');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `drm_system` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) System');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `drm_system` SET TAGS ('dbx_value_regex' = 'widevine|playready|fairplay|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `drm_system` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `drm_system` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.drm_system');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `drm_system` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.drm_system');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `error_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `error_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.error_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `error_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.error_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `error_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `error_message` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `error_message` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.error_message');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `error_message` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.error_message');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.event_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.event_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `event_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `event_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.event_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `event_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.event_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `event_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_validation_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.geographic_country_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.geographic_country_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `geographic_region` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `geographic_region` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.geographic_region');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `geographic_region` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.geographic_region');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `network_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Network Latency (Milliseconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `network_latency_ms` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `network_latency_ms` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.network_latency_ms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `network_latency_ms` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.network_latency_ms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `origin_server_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Origin Server Response Time (Milliseconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `origin_server_response_time_ms` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `origin_server_response_time_ms` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.origin_server_response_time_ms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `origin_server_response_time_ms` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.origin_server_response_time_ms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `resolution` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `resolution` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `resolution` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `scte35_signal_type` SET TAGS ('dbx_business_glossary_term' = 'Society of Cable Telecommunications Engineers (SCTE) 35 Signal Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `scte35_signal_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `scte35_signal_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.scte35_signal_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `scte35_signal_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.scte35_signal_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `scte35_signal_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `session_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Session Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `session_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `session_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.session_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `session_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.session_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `sla_tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `sla_tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.sla_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `sla_tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.sla_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `sla_tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'hls|dash|smooth|rtmp|webrtc');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.streaming_protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.streaming_protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.user_agent');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.user_agent');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `video_codec` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `video_codec` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.video_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `video_codec` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.video_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `video_codec` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Viewer Internet Protocol (IP) Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.delivery_event.viewer_ip_address');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.delivery_event.viewer_ip_address');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.deal_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.deal_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `partner_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `partner_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.distribution_partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `partner_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.distribution_partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `_source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `_source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `_source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `_source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.auto_renewal_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.auto_renewal_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `content_scope` SET TAGS ('dbx_business_glossary_term' = 'Content Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `content_scope` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `content_scope` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.content_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `content_scope` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.content_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_business_glossary_term' = 'Deal Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.deal_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.deal_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_business_glossary_term' = 'Deal Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.deal_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.deal_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'SVOD licensing|AVOD revenue share|FAST syndication|linear carriage|TVOD licensing|international distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.deal_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.deal_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_value_regex' = 'arbitration|mediation|litigation|negotiation');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.dispute_resolution_mechanism');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.dispute_resolution_mechanism');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `drm_requirements` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `drm_requirements` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `drm_requirements` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.drm_requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `drm_requirements` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.drm_requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `effective_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `effective_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.effective_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `effective_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.effective_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.exclusivity_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.exclusivity_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `exclusivity_window_days` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Window Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `exclusivity_window_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `exclusivity_window_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.exclusivity_window_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `exclusivity_window_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.exclusivity_window_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `expiration_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `expiration_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.expiration_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `expiration_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.expiration_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.flat_fee_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.flat_fee_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.governing_law_jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.governing_law_jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.last_amendment_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.last_amendment_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.minimum_guarantee_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.minimum_guarantee_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `minimum_subscriber_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Minimum Subscriber Guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `minimum_subscriber_guarantee` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `minimum_subscriber_guarantee` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.minimum_subscriber_guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `minimum_subscriber_guarantee` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.minimum_subscriber_guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_name` SET TAGS ('dbx_business_glossary_term' = 'Deal Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.deal_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.deal_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `negotiation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `negotiation_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `negotiation_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.negotiation_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `negotiation_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.negotiation_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `payment_terms` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `payment_terms` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.payment_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `payment_terms` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.payment_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `promotional_commitment` SET TAGS ('dbx_business_glossary_term' = 'Promotional Commitment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `promotional_commitment` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `promotional_commitment` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.promotional_commitment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `promotional_commitment` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.promotional_commitment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.renewal_notice_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.renewal_notice_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annually|annually|on-demand');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.reporting_frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.reporting_frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `revenue_model` SET TAGS ('dbx_business_glossary_term' = 'Revenue Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `revenue_model` SET TAGS ('dbx_value_regex' = 'flat fee|revenue share|minimum guarantee|hybrid|cost per stream|cost per subscriber');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `revenue_model` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `revenue_model` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.revenue_model');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `revenue_model` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.revenue_model');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.revenue_share_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.revenue_share_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `signed_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `signed_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.signed_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `signed_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.signed_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|basic');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `sla_tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `sla_tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.sla_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `sla_tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.sla_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `sla_tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_business_glossary_term' = 'Technical Delivery Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.technical_delivery_requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.technical_delivery_requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `term_months` SET TAGS ('dbx_business_glossary_term' = 'Term Months');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `term_months` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `term_months` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.term_months');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `term_months` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.term_months');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.termination_notice_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.termination_notice_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `territory` SET TAGS ('dbx_business_glossary_term' = 'Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `territory` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `territory` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `territory` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.deal.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.deal.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `content_delivery_order_id` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Order Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `content_delivery_order_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `content_delivery_order_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.content_delivery_order_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `content_delivery_order_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.content_delivery_order_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.carriage_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.carriage_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Clearance Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `partner_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `partner_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.distribution_partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `partner_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.distribution_partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.streaming_endpoint_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.streaming_endpoint_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `_source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `_source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `_source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `_source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.actual_delivery_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.actual_delivery_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.approved_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.approved_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.approved_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.approved_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_business_glossary_term' = 'Audio Configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_value_regex' = 'stereo|surround_5_1|surround_7_1|dolby_atmos|dts_x');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.audio_configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.audio_configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `audio_languages` SET TAGS ('dbx_business_glossary_term' = 'Audio Languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `audio_languages` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `audio_languages` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.audio_languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `audio_languages` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.audio_languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `closed_captions_included` SET TAGS ('dbx_business_glossary_term' = 'Closed Captions Included Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `closed_captions_included` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `closed_captions_included` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.closed_captions_included');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `closed_captions_included` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.closed_captions_included');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `content_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Content Duration in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `content_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `content_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.content_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `content_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.content_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `created_by_user` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `created_by_user` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.created_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `created_by_user` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.created_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_deadline_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Deadline Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_deadline_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_deadline_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.delivery_deadline_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_deadline_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.delivery_deadline_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Delivery Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.delivery_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.delivery_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'cdn_push|ftp|aspera|satellite_uplink|physical_media|api');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_method` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_method` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.delivery_method');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_method` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.delivery_method');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_method` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.delivery_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.delivery_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `estimated_delivery_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Duration in Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `estimated_delivery_duration_minutes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `estimated_delivery_duration_minutes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.estimated_delivery_duration_minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `estimated_delivery_duration_minutes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.estimated_delivery_duration_minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `failure_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `failure_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.failure_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `failure_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.failure_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `file_size_gb` SET TAGS ('dbx_business_glossary_term' = 'File Size in Gigabytes (GB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `file_size_gb` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `file_size_gb` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.file_size_gb');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `file_size_gb` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.file_size_gb');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `fulfillment_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Confirmation Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `fulfillment_confirmation_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `fulfillment_confirmation_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.fulfillment_confirmation_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `fulfillment_confirmation_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.fulfillment_confirmation_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `geographic_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `geographic_restrictions` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `geographic_restrictions` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.geographic_restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `geographic_restrictions` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.geographic_restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `hdr_format` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `hdr_format` SET TAGS ('dbx_value_regex' = 'sdr|hdr10|hdr10_plus|dolby_vision|hlg');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `hdr_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `hdr_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.hdr_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `hdr_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.hdr_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `hdr_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.order_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.order_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Order Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^CDO-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.order_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.order_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.order_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.order_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'new_release|refresh|replacement|emergency|scheduled|on_demand');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.order_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.order_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.priority_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.priority_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.requested_delivery_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.requested_delivery_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `retry_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `retry_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.retry_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `retry_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.retry_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `sla_tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `sla_tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.sla_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `sla_tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.sla_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `sla_tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.subtitle_languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.subtitle_languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `transcode_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Transcode Profile Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `transcode_profile_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `transcode_profile_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.transcode_profile_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `transcode_profile_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.transcode_profile_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `video_resolution` SET TAGS ('dbx_value_regex' = 'sd|hd_720p|hd_1080p|uhd_4k|uhd_8k');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `video_resolution` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `video_resolution` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.distribution.content_delivery_order.video_resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `video_resolution` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.distribution.content_delivery_order.video_resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `video_resolution` SET TAGS ('dbx_enum_ref_candidate' = 'true');
