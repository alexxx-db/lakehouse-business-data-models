-- Schema for Domain: distribution | Business: Media_Broadcasting | Version: v3_mvm
-- Generated on: 2026-07-10 21:14:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`distribution` COMMENT 'Governs multi-platform content delivery across linear broadcast (DVB, ATSC, QAM), OTT streaming (HLS, MPEG-DASH, ABR), MVPD/vMVPD carriage, FAST channel syndication, and OTT platform infrastructure. Manages CDN configuration, DRM enforcement, DAI, streaming endpoints, ABR profiles, device support, QoS monitoring, and all delivery SLAs.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` (
    `ott_platform_id` BIGINT COMMENT 'Unique surrogate identifier for each OTT service platform record in the master registry. Primary key for the ott_platform entity — all downstream distribution products reference this key.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: OTT platforms have platform-wide accessibility obligations (UI accessibility, player controls, caption support). Compliance tracking and regulatory reporting require linking platforms to their specifi',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: OTT platforms require billing account linkage for subscription billing setup, revenue recognition by platform, and financial reporting. Media broadcasting operations track platform-level billing confi',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to billing.cycle. Business justification: OTT platforms operate on defined subscription billing cycles (monthly, annual) that govern when subscriber invoices are generated. Linking ott_platform to billing.cycle enables platform-level billing ',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: OTT platforms retransmitting broadcast content operate under specific broadcast licenses. Retransmission consent agreements and carriage rights require tracking which license authorizes the platforms',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: OTT platforms operate in specific territories with distinct regulatory, content rating, and rights enforcement requirements. Replaces geographic_availability text with structured territory reference. ',
    `adobe_property_code` STRING COMMENT 'The unique property identifier assigned to this OTT platform within Adobe Experience Platform (AEP) for audience data collection, segmentation, and personalization. Used to link platform-level engagement events to subscriber profiles and Nielsen cross-platform measurement.',
    `arpu` DECIMAL(18,2) COMMENT 'Average monthly revenue generated per active subscriber on this platform, expressed in the platforms billing currency. Calculated at the platform level for strategic pricing and investor reporting. Confidential as a key financial performance indicator. Sourced from Zuora revenue recognition data.',
    `base_subscription_price` DECIMAL(18,2) COMMENT 'The standard monthly subscription price for this platform in the billing currency. Applicable for SVOD and HYBRID tiers. Null for AVOD and FAST platforms with no subscription fee. Used in Zuora plan configuration and financial forecasting in SAP S/4HANA.',
    `billing_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the primary billing currency used on this platform (e.g., USD, GBP, EUR). Governs Zuora subscription plan pricing, SAP S/4HANA financial reconciliation, and multi-currency revenue reporting.. Valid values are `^[A-Z]{3}$`',
    `cdn_origin_url` STRING COMMENT 'The base origin URL configured in the CDN for this platforms content delivery. Used by Akamai CDN to route requests to the correct media origin server. Critical for CDN configuration audits and incident troubleshooting.. Valid values are `^https?://[a-zA-Z0-9._/-]+$`',
    `cdn_provider` STRING COMMENT 'The primary CDN provider contracted to deliver streaming content for this OTT platform. Drives SLA monitoring, peering agreements, and cost allocation. Multi-CDN indicates a load-balanced or failover configuration across multiple providers. Maps to Akamai CDN platform configuration records.. Valid values are `Akamai|Cloudflare|AWS CloudFront|Fastly|Multi-CDN`',
    `content_rating_system` STRING COMMENT 'The content classification and rating system applied to content on this platform (e.g., MPAA for USA, BBFC for UK, FSK for Germany). Governs parental control enforcement, COPPA compliance for childrens content, and MPA anti-piracy obligations.. Valid values are `MPAA|BBFC|FSK|ACB|CBFC|TV-PG`',
    `coppa_compliant` BOOLEAN COMMENT 'Indicates whether this platform is designated as COPPA-compliant, meaning it is directed at children under 13 and adheres to COPPA data collection restrictions. True = COPPA-compliant childrens platform; False = general audience platform. Drives data collection policies in Adobe Experience Platform and ad targeting restrictions.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this OTT platform record was first created in the master registry. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for data lineage, audit trails, and Silver layer ingestion tracking.',
    `dai_enabled` BOOLEAN COMMENT 'Indicates whether Dynamic Ad Insertion is active on this platform, enabling server-side ad stitching into the stream. True = DAI active (relevant for AVOD and HYBRID tiers); False = no DAI. Drives ad operations workflow in Wide Orbit and ad campaign targeting in Salesforce Media Cloud.',
    `dai_provider` STRING COMMENT 'The technology vendor or platform providing DAI services for this OTT platform (e.g., Google DAI, FreeWheel, Yospace, Brightcove SSAI). Null if DAI is not enabled. Used for vendor management, SLA tracking, and ad revenue reconciliation.',
    `drm_system` STRING COMMENT 'The DRM technology binding enforced on this platform for content protection. Widevine = Google DRM for Android/Chrome; FairPlay = Apple DRM for iOS/Safari; PlayReady = Microsoft DRM for Windows/Xbox; Multi-DRM = all three enforced simultaneously; NONE = no DRM (e.g., FAST free content). Directly linked to Rightsline rights window enforcement and content clearance workflows.. Valid values are `Widevine|FairPlay|PlayReady|Multi-DRM|NONE`',
    `epg_feed_url` STRING COMMENT 'The URL of the Electronic Program Guide data feed for this platform, used by third-party EPG aggregators, smart TV manufacturers, and vMVPD partners to display scheduling information. Null for pure VOD platforms without a linear schedule. Sourced from Ericsson MediaFirst playout system.. Valid values are `^https?://[a-zA-Z0-9._/-]+$`',
    `fast_channel_enabled` BOOLEAN COMMENT 'Indicates whether this platform operates or hosts FAST channels — linear-style, ad-supported free streaming channels. True = FAST channel delivery active; False = no FAST channel. Relevant for FAST syndication partnerships and Wide Orbit ad scheduling.',
    `free_trial_days` STRING COMMENT 'Number of days in the free trial period offered to new subscribers on this platform. Zero or null if no free trial is offered. Configured in Zuora subscription plans and used in churn rate and LTV analysis.',
    `gdpr_applicable` BOOLEAN COMMENT 'Indicates whether GDPR data protection obligations apply to this platform based on its geographic availability and subscriber base. True = GDPR applies (EU/EEA territories served); False = GDPR not applicable. Governs consent management, data subject rights workflows, and Adobe Experience Platform profile handling.',
    `hdr_supported` BOOLEAN COMMENT 'Indicates whether the platform supports High Dynamic Range video delivery (HDR10, Dolby Vision, or HLG). True = HDR delivery supported; False = SDR only. Relevant for premium content licensing negotiations and CTV device compatibility.',
    `launch_date` DATE COMMENT 'The calendar date on which the OTT platform was officially made available to the public or target subscriber base. Used for platform age calculations, anniversary promotions, and regulatory reporting of service commencement.',
    `max_concurrent_streams` STRING COMMENT 'The maximum number of simultaneous streams permitted per subscriber account on this platform. Enforced at the entitlement layer to prevent credential sharing and manage CDN bandwidth capacity. A key parameter in Zuora subscription plan configuration.',
    `max_download_devices` STRING COMMENT 'The maximum number of devices on which a subscriber may store downloaded content for offline viewing on this platform. Null if offline downloads are not supported. Governed by DRM policy and Rightsline windowing rules.',
    `max_video_resolution` STRING COMMENT 'The highest video resolution tier supported for streaming on this platform. SD = Standard Definition (480p); HD = High Definition (720p); FHD = Full HD (1080p); 4K = Ultra HD (2160p); 8K = Super Hi-Vision (4320p). Drives ABR profile configuration, CDN bandwidth planning, and content ingest specifications in Dalet Galaxy.. Valid values are `SD|HD|FHD|4K|8K`',
    `mvpd_carriage_eligible` BOOLEAN COMMENT 'Indicates whether this OTT platforms content or channels are eligible for carriage by MVPD or vMVPD partners (cable, satellite, virtual pay-TV operators). True = eligible for carriage agreements; False = direct-to-consumer only. Governs retransmission consent and must-carry negotiations.',
    `parent_brand` STRING COMMENT 'The overarching corporate or media brand under which this OTT platform operates (e.g., Media Broadcasting Group, MB Sports Network). Supports brand hierarchy reporting, consolidated audience measurement, and multi-brand advertising sales in Salesforce Media Cloud.',
    `platform_code` STRING COMMENT 'Externally-known, human-readable unique code assigned to the OTT platform (e.g., MB_SVOD_WEB, MB_AVOD_CTV). Used in operational systems, contracts, and partner integrations as the canonical platform identifier. Maps to the platform identifier used in Zuora subscription plans and Akamai CDN configuration.. Valid values are `^[A-Z0-9_]{2,30}$`',
    `platform_description` STRING COMMENT 'Detailed narrative description of the platforms content offering, target audience, and service proposition. Used in partner onboarding documentation, regulatory filings, and internal product catalogues.',
    `platform_name` STRING COMMENT 'Official commercial brand name of the OTT platform as presented to subscribers and partners (e.g., MediaBroadcast+, MB Sports Live). Used in marketing materials, EPG listings, and subscriber-facing interfaces.',
    `platform_status` STRING COMMENT 'Current lifecycle state of the OTT platform. active = live and serving audiences; beta = limited release for testing; sunset = scheduled for decommission; suspended = temporarily offline; inactive = decommissioned. Governs whether the platform is eligible for new subscriber acquisition, ad campaign targeting, and CDN resource allocation.. Valid values are `active|inactive|beta|sunset|suspended`',
    `primary_streaming_protocol` STRING COMMENT 'The primary adaptive bitrate streaming protocol used for content delivery on this platform. HLS = HTTP Live Streaming (Apple standard, widely supported); MPEG-DASH = Dynamic Adaptive Streaming over HTTP (ISO 23009 standard); RTMP = Real-Time Messaging Protocol (legacy live); SRT = Secure Reliable Transport (low-latency live). Drives CDN configuration in Akamai and player SDK selection.. Valid values are `HLS|MPEG-DASH|HLS,MPEG-DASH|RTMP|SRT`',
    `service_tier` STRING COMMENT 'Business model classification of the OTT platform. SVOD = Subscription Video On Demand (recurring fee, no ads); AVOD = Advertising-Supported Video On Demand (free with ads); TVOD = Transactional Video On Demand (pay-per-view); FAST = Free Ad-Supported Streaming Television (linear-style free channel); HYBRID = combination of tiers. Drives revenue recognition logic in Zuora and ad inventory management in Wide Orbit.. Valid values are `SVOD|AVOD|TVOD|FAST|HYBRID`',
    `sla_uptime_target_pct` DECIMAL(18,2) COMMENT 'The contractually committed platform availability target expressed as a percentage (e.g., 99.95). Governs CDN SLA enforcement with Akamai, incident escalation thresholds, and operational reporting. Distinct from actual measured uptime.',
    `subscriber_count` BIGINT COMMENT 'Current count of active paying or registered subscribers on this platform as of the last reconciliation cycle. A key operational metric for ARPU calculation, churn rate monitoring, and Zuora revenue reporting. Confidential as it represents commercially sensitive business performance data.',
    `sunset_date` DATE COMMENT 'Planned or actual date on which the OTT platform will be or was decommissioned. Null if the platform has no scheduled end-of-life. Used for subscriber migration planning, contract wind-down, and CDN resource deallocation.',
    `supported_device_classes` STRING COMMENT 'Comma-separated list of device categories supported by this platform (e.g., web,mobile,ctv,stb,gaming_console). Drives device compatibility testing, app store distribution, and audience reach reporting. [ENUM-REF-CANDIDATE: web|mobile|ctv|stb|gaming_console|smart_tv|tablet — promote to reference product]',
    `target_start_bitrate_kbps` STRING COMMENT 'The minimum target bitrate in kilobits per second at which the ABR player should initiate playback on this platform. Drives ABR profile ladder configuration in Akamai CDN and QoS monitoring thresholds. Key parameter for streaming quality benchmarking.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this OTT platform record was most recently modified. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture (CDC) in the Databricks Silver layer pipeline and audit compliance.',
    `zuora_product_code` STRING COMMENT 'The product identifier in Zuoras subscription billing platform corresponding to this OTT platforms subscription offering. Used for revenue recognition, invoice generation, and subscription lifecycle management. Links the platform master record to Zuoras billing product catalogue.',
    CONSTRAINT pk_ott_platform PRIMARY KEY(`ott_platform_id`)
) COMMENT 'Master registry of all OTT service platforms operated by Media Broadcasting — web, mobile, connected TV (CTV), and set-top box (STB). Captures platform identity, service tier (SVOD, AVOD, TVOD, FAST), launch date, supported protocols (HLS, MPEG-DASH), DRM system bindings, CDN provider assignments, geographic availability, regulatory jurisdiction, brand identity, and operational status. This is the SSOT anchor for the entire platform domain — all other platform products reference back to this entity.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` (
    `device_type_id` BIGINT COMMENT 'Unique identifier for the device type record. Primary key.',
    `abr_profile_dash` BOOLEAN COMMENT 'Indicates whether the device supports MPEG-DASH (Dynamic Adaptive Streaming over HTTP) adaptive bitrate streaming protocol.',
    `abr_profile_hls` BOOLEAN COMMENT 'Indicates whether the device supports HLS (HTTP Live Streaming) adaptive bitrate streaming protocol.',
    `abr_profile_smooth` BOOLEAN COMMENT 'Indicates whether the device supports Microsoft Smooth Streaming adaptive bitrate protocol.',
    `active_install_base` BIGINT COMMENT 'Estimated number of active devices of this type currently accessing the OTT platform, used for capacity planning and analytics.',
    `certification_date` DATE COMMENT 'Date when the device successfully completed OTT platform certification testing.',
    `certification_expiry_date` DATE COMMENT 'Date when the device certification expires and requires re-certification for continued platform support.',
    `certification_status` STRING COMMENT 'Current certification status of the device for OTT platform compatibility (certified, pending, failed, not_tested).. Valid values are `certified|pending|failed|not_tested`',
    `codec_audio_support` STRING COMMENT 'List of audio codecs supported by the device (e.g., AAC, Dolby Digital, Dolby Atmos, DTS). Pipe-separated list.',
    `codec_video_support` STRING COMMENT 'List of video codecs supported by the device (e.g., H.264, H.265/HEVC, VP9, AV1). Pipe-separated list.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this device type record was first created in the system.',
    `dai_supported` BOOLEAN COMMENT 'Indicates whether the device supports DAI (Dynamic Ad Insertion) for server-side ad stitching in streaming content.',
    `device_category` STRING COMMENT 'High-level classification of the device type (e.g., smart TV, mobile phone, tablet, desktop browser, streaming stick, gaming console, set-top box). [ENUM-REF-CANDIDATE: smart_tv|mobile_phone|tablet|desktop_browser|streaming_stick|gaming_console|set_top_box — 7 candidates stripped; promote to reference product]',
    `drm_fairplay_supported` BOOLEAN COMMENT 'Indicates whether the device supports Apple FairPlay DRM for content protection.',
    `drm_playready_supported` BOOLEAN COMMENT 'Indicates whether the device supports Microsoft PlayReady DRM for content protection.',
    `drm_widevine_level` STRING COMMENT 'Google Widevine DRM security level supported (L1 = hardware-backed, L2 = software-backed, L3 = software only, not_supported).. Valid values are `L1|L2|L3|not_supported`',
    `form_factor` STRING COMMENT 'Physical form factor of the device (handheld, television, desktop, wearable, embedded).. Valid values are `handheld|television|desktop|wearable|embedded`',
    `hdr_capable` BOOLEAN COMMENT 'Indicates whether the device supports HDR (High Dynamic Range) video playback for enhanced color and contrast.',
    `hdr_format` STRING COMMENT 'Specific HDR formats supported by the device (e.g., HDR10, HDR10+, Dolby Vision, HLG). Pipe-separated list if multiple formats are supported.',
    `input_method` STRING COMMENT 'Primary input method(s) supported by the device (e.g., touchscreen, remote_control, keyboard_mouse, voice, gamepad). Pipe-separated list if multiple.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this device type is currently active and supported for OTT platform streaming.',
    `manufacturer` STRING COMMENT 'Name of the device manufacturer or brand (e.g., Samsung, Apple, Roku, Amazon, LG, Sony).',
    `max_bitrate_mbps` DECIMAL(18,2) COMMENT 'Maximum streaming bitrate supported by the device in megabits per second (Mbps), used for ABR profile selection and QoS (Quality of Service) optimization.',
    `model_name` STRING COMMENT 'Specific model name or identifier assigned by the manufacturer (e.g., Galaxy S21, iPhone 13 Pro, Fire TV Stick 4K).',
    `model_number` STRING COMMENT 'Technical model number or SKU (Stock Keeping Unit) used for precise device identification and inventory tracking.',
    `network_capability` STRING COMMENT 'Network connectivity capabilities of the device (e.g., wifi, ethernet, cellular_4g, cellular_5g). Pipe-separated list if multiple.',
    `os_family` STRING COMMENT 'Operating system family running on the device (e.g., Android, iOS, tvOS, webOS, Tizen, Roku OS, Fire OS, Windows, macOS, Linux, PlayStation, Xbox). [ENUM-REF-CANDIDATE: android|ios|tvos|webos|tizen|roku_os|fire_os|windows|macos|linux|playstation|xbox — 12 candidates stripped; promote to reference product]',
    `os_version_max` STRING COMMENT 'Maximum OS version tested and certified for compatibility. Null indicates no upper bound.',
    `os_version_min` STRING COMMENT 'Minimum OS version required for OTT (Over-The-Top) platform compatibility and playback support.',
    `qos_tier` STRING COMMENT 'QoS tier assigned to the device type for streaming quality segmentation and CDN (Content Delivery Network) routing (premium, standard, basic).. Valid values are `premium|standard|basic`',
    `screen_resolution_class` STRING COMMENT 'Display resolution category supported by the device (SD, HD, Full HD, 4K UHD (Ultra High Definition), 8K UHD).. Valid values are `sd|hd|full_hd|4k_uhd|8k_uhd`',
    `support_end_date` DATE COMMENT 'Date when platform support for this device type will be discontinued, after which playback may no longer be guaranteed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this device type record was last modified.',
    `user_agent_string` STRING COMMENT 'Standard HTTP user agent string reported by the device, used for device detection and analytics.',
    CONSTRAINT pk_device_type PRIMARY KEY(`device_type_id`)
) COMMENT 'Reference catalog of all device categories and models supported across OTT platforms — smart TVs, mobile phones, tablets, desktop browsers, streaming sticks, gaming consoles, and STBs. Captures device category, manufacturer, OS family, OS version range, screen resolution class, HDR capability, DRM compatibility (Widevine, PlayReady, FairPlay), ABR profile support, and certification status. Used for device-specific playback configuration and QoS segmentation.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` (
    `streaming_endpoint_id` BIGINT COMMENT 'Unique identifier for the streaming endpoint. Primary key for the streaming endpoint master record.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Streaming endpoints use specific CDN configurations. streaming_endpoint.cdn_provider is STRING but should FK to cdn_configuration. Removes cdn_provider STRING.',
    `failover_endpoint_streaming_endpoint_id` BIGINT COMMENT 'Reference to the backup streaming endpoint that should be used if this endpoint becomes unavailable. Supports high availability and disaster recovery.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Streaming endpoints are provisioned for specific OTT platforms. Each endpoint serves content for a platform. No visible platform_type column but relationship is essential for endpoint management.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Streaming endpoints rely on transmission equipment (encoders, transcoders). Required for equipment failure impact analysis and encoder capacity management.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Streaming endpoints serve specific geographic territories. Essential for enforcing geo-restriction rules per rights grants, validating territory-based rights compliance, and routing playback sessions ',
    `activated_timestamp` TIMESTAMP COMMENT 'The date and time when this endpoint was first activated and began serving live traffic.',
    `bandwidth_limit_gbps` DECIMAL(18,2) COMMENT 'Maximum aggregate bandwidth capacity in gigabits per second allocated to this endpoint. Used for capacity planning and cost management.',
    `cache_ttl_seconds` STRING COMMENT 'The duration in seconds that content should be cached at edge locations before refreshing from origin. Balances freshness with CDN efficiency.',
    `cost_per_gb` DECIMAL(18,2) COMMENT 'The CDN providers charge per gigabyte of data transferred through this endpoint. Used for cost allocation and financial forecasting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this streaming endpoint record was first created in the system.',
    `dai_enabled` BOOLEAN COMMENT 'Indicates whether this endpoint supports Dynamic Ad Insertion, allowing personalized ads to be stitched into the stream in real-time.',
    `deactivated_timestamp` TIMESTAMP COMMENT 'The date and time when this endpoint was deactivated or taken out of service. Null if currently active.',
    `drm_license_server_url` STRING COMMENT 'URL of the DRM license server that provides decryption keys and enforces content protection policies for this endpoint. Critical for securing premium content.. Valid values are `^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$`',
    `endpoint_name` STRING COMMENT 'Human-readable name or label for the streaming endpoint, used for identification and operational reference.',
    `endpoint_type` STRING COMMENT 'Classification of the endpoint role within the CDN architecture. Origin endpoints serve as the source, edge endpoints serve end users, and backup endpoints provide failover capability.. Valid values are `origin|edge|backup`',
    `endpoint_url` STRING COMMENT 'The full URL address of the streaming endpoint, including protocol, domain, and path. This is the technical delivery address for the stream.. Valid values are `^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$`',
    `geo_restriction_mode` STRING COMMENT 'Defines whether geo_restriction_rules represent an allow list (whitelist) or deny list (blacklist) for content delivery.. Valid values are `whitelist|blacklist|none`',
    `geo_restriction_rules` STRING COMMENT 'Comma-separated list of ISO country codes or regions where content delivery is allowed or blocked. Enforces territorial licensing and rights management requirements.',
    `health_check_interval_seconds` STRING COMMENT 'Frequency in seconds at which automated health checks are performed against this endpoint.',
    `health_check_url` STRING COMMENT 'URL endpoint used for automated health monitoring and availability checks. Returns status codes indicating endpoint health.. Valid values are `^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$`',
    `ipv6_enabled` BOOLEAN COMMENT 'Indicates whether this endpoint supports IPv6 addressing in addition to IPv4, enabling delivery to modern network infrastructures.',
    `last_health_check_timestamp` TIMESTAMP COMMENT 'The date and time of the most recent successful health check performed on this endpoint.',
    `manifest_format` STRING COMMENT 'The streaming manifest file format used by this endpoint. m3u8 for HLS, mpd for MPEG-DASH, ism for Smooth Streaming, f4m for Adobe HDS.. Valid values are `m3u8|mpd|ism|f4m`',
    `max_bitrate_mbps` DECIMAL(18,2) COMMENT 'The maximum streaming bitrate in megabits per second that this endpoint can deliver. Defines the upper quality limit for adaptive streaming.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this streaming endpoint record was last modified or updated.',
    `operational_status` STRING COMMENT 'Current operational state of the streaming endpoint. Active endpoints are serving traffic; inactive endpoints are provisioned but not in use; maintenance indicates scheduled downtime.. Valid values are `active|inactive|maintenance|degraded|failed`',
    `provisioned_date` DATE COMMENT 'The date when this streaming endpoint was initially provisioned and configured in the CDN infrastructure.',
    `sla_uptime_target_percent` DECIMAL(18,2) COMMENT 'The contractual uptime percentage target for this endpoint (e.g., 99.99%). Used for SLA compliance monitoring and vendor accountability.',
    `ssl_certificate_expiry_date` DATE COMMENT 'Expiration date of the SSL/TLS certificate securing this endpoint. Critical for maintaining secure HTTPS delivery and avoiding service disruptions.',
    `streaming_protocol` STRING COMMENT 'The streaming protocol used by this endpoint for content delivery. HLS (HTTP Live Streaming) and MPEG-DASH (Dynamic Adaptive Streaming over HTTP) are the most common adaptive bitrate protocols.. Valid values are `HLS|MPEG-DASH|RTMP|WebRTC|Smooth Streaming`',
    `supported_devices` STRING COMMENT 'Comma-separated list of device types or platforms that this endpoint is optimized to serve (e.g., iOS, Android, Smart TV, Web Browser, Set-Top Box).',
    `token_authentication_scheme` STRING COMMENT 'The authentication mechanism used to secure access to the endpoint. Prevents unauthorized access and hotlinking through cryptographic token validation.. Valid values are `JWT|HMAC|Akamai Token|AWS Signature|None`',
    CONSTRAINT pk_streaming_endpoint PRIMARY KEY(`streaming_endpoint_id`)
) COMMENT 'Master record of all streaming origin and edge endpoints managed across the CDN infrastructure (Akamai CDN). Captures endpoint URL, CDN provider, PoP (Point of Presence) region, protocol (HLS, MPEG-DASH), ABR ladder configuration reference, DRM license server URL, token authentication scheme, geo-restriction rules, failover endpoint reference, SLA tier, and operational status. SSOT for the technical delivery address of each stream.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` (
    `playback_session_id` BIGINT COMMENT 'Unique identifier for each individual viewer playback session initiated on the OTT (Over-The-Top) platform. Primary key for the playback session record.',
    `audience_profile_id` BIGINT COMMENT 'Foreign key linking to audience.audience_profile. Business justification: Every OTT playback session is attributed to an audience profile for cross-platform measurement, personalization, and Nielsen streaming measurement. This is a foundational link in OTT audience analytic',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: When playback sessions include ad delivery (dai_enabled), linking to campaign enables campaign reach/frequency measurement, content-adjacency analysis, and cross-domain attribution. Critical for measu; FK references sales domain entity; namespace reconciled from advertising context',
    `closed_caption_record_id` BIGINT COMMENT 'Foreign key linking to compliance.closed_caption_record. Business justification: Individual playback sessions generate closed caption quality metrics (accuracy, synchronization, latency). Session-level caption performance data feeds FCC compliance reporting and quality assurance.',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Every playback session must enforce content rating restrictions for parental controls, age-gating, and COPPA compliance. Real-time rating validation during session initialization is standard practice.',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Nielsen C3/C7 ratings, GRP/TRP calculation, and programmatic ad targeting require demographic classification of every playback session. Essential for audience guarantee reconciliation and upfront comm',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Playback sessions consume content under specific rights grants. Essential for per-stream royalty calculation, usage reporting to rights holders, and rights compliance verification. Media broadcasting ',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.app_version. Business justification: Playback sessions should FK to app_version master for version tracking and analytics. Removes app_version STRING (derivable from app_version.version_number).',
    `device_type_id` BIGINT COMMENT 'Reference to the device used for this playback session. Enables device-level analytics and QoS (Quality of Service) monitoring.',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: Playback sessions should FK to streaming_endpoint master to track which endpoint served the session. Removes streaming_endpoint_url STRING (derivable from streaming_endpoint.endpoint_url).',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who initiated this playback session. Links to the subscriber master record for audience measurement and personalization.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Playback sessions occur in specific territories. Essential for territory-based royalty calculation, rights compliance verification, and exploitation reporting to rights holders. Replaces geographic_co',
    `ad_breaks_served_count` STRING COMMENT 'Number of ad breaks (ad pods) served during this playback session. Used for advertising inventory management and revenue reconciliation.',
    `audio_language` STRING COMMENT 'ISO 639 language code for the audio track selected by the viewer. Supports multi-language content analytics and localization strategy.',
    `average_bitrate_kbps` STRING COMMENT 'Average streaming bitrate in kilobits per second during the session. Indicates video quality delivered and network performance.',
    `cdn_pop_location` STRING COMMENT 'Geographic location identifier of the CDN point of presence that served this session. Critical for CDN performance optimization and SLA monitoring.',
    `closed_captions_enabled` BOOLEAN COMMENT 'Indicates whether closed captions were enabled during the session. Critical for accessibility compliance reporting and user preference analysis.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of content watched relative to total content duration. Key engagement metric for content performance and recommendation algorithms.',
    `content_duration_seconds` STRING COMMENT 'Total duration of the content asset in seconds. Used to calculate completion rate and identify partial vs. full viewing sessions.',
    `dai_enabled` BOOLEAN COMMENT 'Indicates whether Dynamic Ad Insertion was enabled for this playback session. Critical for advertising revenue attribution and campaign measurement.',
    `error_code` STRING COMMENT 'Technical error code if the session ended due to an error. Enables root cause analysis and platform stability monitoring.',
    `exit_reason` STRING COMMENT 'The reason the playback session ended. Critical for distinguishing intentional exits from technical failures and optimizing viewer experience.. Valid values are `user_stop|completion|error|timeout|network_failure|drm_failure`',
    `geographic_city` STRING COMMENT 'City where the viewer is located during playback. Enables hyper-local audience analytics and targeted advertising campaigns.',
    `geographic_postal_code` STRING COMMENT 'Postal code derived from viewer location. Used for demographic overlay and targeted advertising. Subject to privacy regulations.',
    `initial_buffering_duration_ms` STRING COMMENT 'Time in milliseconds from session start until playback began. Key QoS metric for measuring time-to-first-frame and viewer experience.',
    `platform_type` STRING COMMENT 'The platform category on which the playback session occurred. Enables cross-platform measurement and platform-specific QoS analysis.. Valid values are `web|mobile_ios|mobile_android|smart_tv|streaming_device|gaming_console`',
    `playback_mode` STRING COMMENT 'The mode of content consumption: live linear broadcast, VOD (Video On Demand), DVR (time-shifted), or restart. Critical for audience measurement methodology and rights management.. Valid values are `live|vod|dvr|restart`',
    `rebuffering_events_count` STRING COMMENT 'Number of rebuffering (stalling) events that occurred during the session. Critical QoS metric for viewer experience and churn prediction.',
    `session_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this playback session record was created in the system. Used for data lineage and operational monitoring.',
    `session_end_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the playback session ended. Used to calculate total watch duration and session completion metrics.',
    `session_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the viewer initiated the playback session. Critical for audience measurement, daypart analysis, and concurrent viewer calculations.',
    `session_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this playback session record was last updated. Supports audit trail and data quality monitoring.',
    `streaming_protocol` STRING COMMENT 'The ABR (Adaptive Bitrate Streaming) protocol used for content delivery. HLS (HTTP Live Streaming) or MPEG-DASH (Dynamic Adaptive Streaming over HTTP) are most common.. Valid values are `hls|mpeg_dash|smooth_streaming`',
    `subtitle_language` STRING COMMENT 'ISO 639 language code for subtitles displayed during the session. Null if no subtitles were enabled. Supports accessibility and localization analytics.',
    `total_ad_duration_seconds` STRING COMMENT 'Cumulative duration of all advertisements served during the session. Essential for advertising billing and viewer experience analysis.',
    `total_rebuffering_duration_ms` STRING COMMENT 'Cumulative time in milliseconds spent in rebuffering state during the session. Complements rebuffering count for comprehensive QoS analysis.',
    `total_watch_duration_seconds` STRING COMMENT 'Total time in seconds the viewer actively watched content during this session. Primary metric for audience measurement and content engagement analysis.',
    `video_resolution` STRING COMMENT 'The video resolution delivered during the session (e.g., 1920x1080, 3840x2160). Indicates quality tier and device capability.',
    `viewer_ip_address` STRING COMMENT 'IP address of the viewer during the playback session. Used for geographic analysis, fraud detection, and blackout enforcement. Subject to GDPR and CCPA privacy regulations.',
    CONSTRAINT pk_playback_session PRIMARY KEY(`playback_session_id`)
) COMMENT 'Transactional record of each individual viewer playback session initiated on the OTT platform. Captures session ID, subscriber/device reference, content asset reference, session start and end timestamps, platform and app version, device type, streaming endpoint used, ABR profile, DRM policy applied, initial buffering duration, average bitrate, rebuffering events count, total watch duration, exit reason (user-initiated, error, completion), CDN PoP served, and geographic location. Primary operational event for QoS monitoring and audience measurement.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` (
    `distribution_partner_id` BIGINT COMMENT 'Unique identifier for the distribution partner. Primary key for the distribution partner entity.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Distribution partners (MVPDs, cable operators, streaming aggregators) are billing customers for carriage fees, retransmission consent, and content licensing. Real business process: partner invoicing, ',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to billing.cycle. Business justification: Distribution partners are billed on defined cycles (monthly carriage fees, quarterly revenue share settlements). The billing cycle governs invoice generation timing, payment due dates, and dunning sch',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: distribution_partner is a distribution-domain specialization of a partner entity. Linking to the master partner record enables unified partner reporting, credit risk assessment, and strategic tier man',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Distribution partners independently file regulatory documents (annual EEO reports, must-carry elections, retransmission consent filings). A direct FK from distribution_partner to regulatory_filing sup',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: MVPDs and cable operators are subject to FCC regulatory obligations (must-carry, retransmission consent, EEO reporting). Tracking the primary regulatory_obligation per distribution_partner is essentia',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Distribution partners have co-located equipment at broadcaster facilities. Required for partner technical integration coordination and facility access control management.',
    `abr_profile_support` STRING COMMENT 'Description of Adaptive Bitrate streaming profiles and quality tiers supported by the distribution partner for OTT and streaming delivery. Includes resolution ranges, bitrate ladders, and codec support.',
    `blackout_capability_flag` BOOLEAN COMMENT 'Indicates whether the distribution partner has technical capability to enforce geographic broadcast restrictions and content blackouts based on licensing and rights windows.',
    `carriage_capacity_channels` STRING COMMENT 'Number of linear channels or content streams that the distribution partner has capacity to carry simultaneously. Relevant for MVPD, vMVPD, and cable operators.',
    `carriage_fee_model` STRING COMMENT 'Commercial model for carriage fees paid by or to the distribution partner. Per Subscriber indicates fees based on subscriber count, Flat Rate indicates fixed periodic payment, Revenue Share indicates percentage of advertising or subscription revenue, Hybrid indicates combination of models.. Valid values are `Per Subscriber|Flat Rate|Revenue Share|Hybrid|No Fee`',
    `cdn_provider` STRING COMMENT 'Name of the Content Delivery Network provider used by the distribution partner for content streaming and delivery. May include Akamai, Cloudflare, AWS CloudFront, or partner-owned CDN infrastructure.',
    `contract_end_date` DATE COMMENT 'Date when the current distribution agreement with the partner expires or is scheduled for renewal. Null indicates open-ended or evergreen agreement.',
    `contract_renewal_notice_days` STRING COMMENT 'Number of days advance notice required for contract renewal or termination as specified in the distribution agreement.',
    `contract_start_date` DATE COMMENT 'Date when the current distribution agreement with the partner became effective.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution partner record was first created in the system.',
    `dai_support_flag` BOOLEAN COMMENT 'Indicates whether the distribution partner supports Dynamic Ad Insertion technology for server-side ad stitching in streaming content.',
    `drm_capability` STRING COMMENT 'Digital Rights Management systems and encryption standards supported by the distribution partner. May include Widevine, FairPlay, PlayReady, and other DRM technologies.',
    `geographic_footprint` STRING COMMENT 'Description of the geographic markets, regions, or territories served by this distribution partner. May include country codes, DMA (Designated Market Area) codes, or regional descriptors.',
    `headquarters_address` STRING COMMENT 'Physical address of the distribution partners corporate headquarters or primary business location.',
    `headquarters_city` STRING COMMENT 'City where the distribution partners headquarters is located.',
    `headquarters_country_code` STRING COMMENT 'Three-letter ISO country code representing the country where the distribution partners headquarters is located.. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the distribution partners headquarters location.',
    `headquarters_state_province` STRING COMMENT 'State, province, or administrative region where the distribution partners headquarters is located.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution partner record was most recently updated or modified.',
    `must_carry_obligation_flag` BOOLEAN COMMENT 'Indicates whether the distribution partner has a must-carry obligation requiring mandatory inclusion of certain broadcast channels under FCC regulations.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or contextual information about the distribution partner relationship.',
    `partner_tier` STRING COMMENT 'Strategic classification of the partner based on reach, revenue contribution, and business importance. Tier 1 represents largest national/international partners, Tier 2 represents regional significant partners, Tier 3 represents local or niche partners.. Valid values are `Tier 1|Tier 2|Tier 3|Strategic|Emerging`',
    `partner_type` STRING COMMENT 'Classification of the distribution partner based on delivery model. MVPD (Multichannel Video Programming Distributor) includes traditional cable, satellite, and telco providers. vMVPD (Virtual MVPD) includes internet-based multichannel services. OTT Platform includes direct-to-consumer streaming services. FAST Aggregator includes Free Ad-Supported Streaming Television channel aggregators. Syndication Outlet includes broadcast stations and regional networks.. Valid values are `MVPD|vMVPD|OTT Platform|FAST Aggregator|Syndication Outlet|Cable Operator`',
    `payment_terms_days` STRING COMMENT 'Standard payment terms in days for invoices related to carriage fees, revenue share, or other financial transactions with the distribution partner.',
    `portal_url` STRING COMMENT 'Web URL for the distribution partners business portal, technical documentation, or partner management system.',
    `preferred_currency_code` STRING COMMENT 'Three-letter ISO currency code for financial transactions and reporting with this distribution partner.. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact for distribution operations, technical coordination, and business communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the distribution partner organization for operational coordination and escalation.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for reaching the distribution partner contact for urgent operational matters and coordination.',
    `qos_monitoring_enabled_flag` BOOLEAN COMMENT 'Indicates whether active Quality of Service monitoring and reporting is enabled for content delivery through this distribution partner.',
    `relationship_status` STRING COMMENT 'Current state of the commercial relationship and content distribution agreement with the partner.. Valid values are `Active|Inactive|Suspended|Pending|Terminated|Under Negotiation`',
    `retransmission_consent_status` STRING COMMENT 'Status of retransmission consent authorization allowing the distribution partner to rebroadcast content. Relevant for MVPD and cable operators under FCC regulations.. Valid values are `Granted|Denied|Pending|Not Applicable|Under Negotiation`',
    `sla_latency_target_ms` STRING COMMENT 'Maximum acceptable latency in milliseconds for content delivery as defined in the distribution Service Level Agreement. Critical for live streaming and low-latency applications.',
    `sla_uptime_target_percent` DECIMAL(18,2) COMMENT 'Contractual uptime percentage target defined in the distribution Service Level Agreement. Represents the minimum availability commitment for content delivery.',
    `subscriber_reach_estimate` BIGINT COMMENT 'Estimated number of subscribers, households, or unique users that can access content through this distribution partner. Used for reach analysis and revenue forecasting.',
    `technical_delivery_standards` STRING COMMENT 'Comma-separated list of technical broadcast and streaming standards supported by the partner. May include DVB (Digital Video Broadcasting), ATSC (Advanced Television Systems Committee), QAM (Quadrature Amplitude Modulation), HLS (HTTP Live Streaming), MPEG-DASH (Dynamic Adaptive Streaming over HTTP), and other delivery protocols.',
    CONSTRAINT pk_distribution_partner PRIMARY KEY(`distribution_partner_id`)
) COMMENT 'Master record for all distribution partners including MVPDs (cable, satellite, telco), vMVPDs, OTT platform operators, FAST aggregators, and syndication outlets. Captures partner identity, tier classification, distribution footprint (geographic markets served), carriage capacity, technical delivery capabilities (DVB, ATSC, HLS, MPEG-DASH), and commercial relationship status. SSOT for distribution partner identity within the distribution domain — distinct from the enterprise partner domain which owns broader commercial relationships.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` (
    `carriage_agreement_id` BIGINT COMMENT 'Unique identifier for the carriage agreement record. Primary key.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Carriage agreements define ongoing carriage fees billed to distribution partners. The existing master_invoice_id links to one invoice; the billing_account_id enables credit management, payment terms e',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Retransmission consent agreements are legally tied to specific broadcast licenses. Must-carry elections, carriage fees, and retransmission consent status are license-specific regulatory obligations re',
    `channel_id` BIGINT COMMENT 'Reference to the channel or content package covered by this carriage agreement.',
    `deal_id` BIGINT COMMENT 'Foreign key linking to distribution.deal. Business justification: A carriage_agreement is the operational contract governing channel carriage terms with an MVPD/vMVPD, while a deal is the overarching commercial distribution deal negotiated with a partner. In media b',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Carriage agreements are executed under the umbrella of a formal distribution_agreement. Operations teams must trace which distribution_agreement authorizes each carriage_agreement for compliance audit',
    `distribution_partner_id` BIGINT COMMENT 'Reference to the MVPD, vMVPD, or OTT platform carrying the content under this agreement.',
    `public_inspection_file_id` BIGINT COMMENT 'Foreign key linking to compliance.public_inspection_file. Business justification: FCC rules require retransmission consent and carriage agreements to be disclosed in the public inspection file. Linking carriage_agreement to public_inspection_file enables automated compliance verifi',
    `agreement_number` STRING COMMENT 'Externally-known unique identifier or contract number for this carriage agreement, used in business communications and legal references.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the carriage agreement: draft (being prepared), active (in force), suspended (temporarily paused), expired (term ended), terminated (cancelled before expiry), or under negotiation (renewal or amendment in progress).. Valid values are `draft|active|suspended|expired|terminated|under_negotiation`',
    `agreement_type` STRING COMMENT 'Classification of the carriage agreement: retransmission consent (FCC-regulated authorization for MVPDs to rebroadcast OTA signals), must-carry (mandatory carriage under FCC rules), voluntary carriage (negotiated carriage without must-carry obligation), or platform carriage (OTT/vMVPD distribution agreement).. Valid values are `retransmission_consent|must_carry|voluntary_carriage|platform_carriage`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews at the end of the term unless either party provides termination notice.',
    `blackout_provisions` STRING COMMENT 'Geographic or temporal restrictions on content availability, such as sports blackout rules, local market exclusions, or event-specific restrictions required by rights holders or league rules.',
    `carriage_fee_amount` DECIMAL(18,2) COMMENT 'Monetary compensation paid by the distribution partner to the content provider for the right to carry the channel or content package. May be per-subscriber, flat fee, or tiered based on subscriber count.',
    `carriage_fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the carriage fee amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `carriage_fee_structure` STRING COMMENT 'Pricing model for the carriage fee: per-subscriber (fee per active subscriber), flat monthly (fixed monthly payment), tiered (rate varies by subscriber volume), revenue share (percentage of ad or subscription revenue), or barter (non-cash compensation such as promotional commitments or channel positioning).. Valid values are `per_subscriber|flat_monthly|tiered|revenue_share|barter`',
    `channel_number_assignment` STRING COMMENT 'The channel number or dial position assigned to the channel on the distribution platform. May vary by market or headend.',
    `channel_positioning_tier` STRING COMMENT 'The service tier or package in which the channel is positioned (e.g., basic, expanded basic, premium, sports tier). Affects channel visibility and subscriber reach.',
    `compensation_terms` STRING COMMENT 'Detailed description of all compensation provided under the agreement, including cash payments, barter arrangements (e.g., promotional commitments, ad inventory exchange), channel carriage reciprocity, or other non-monetary considerations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carriage agreement record was first created in the system.',
    `dispute_resolution_mechanism` STRING COMMENT 'Agreed method for resolving disputes arising under the agreement: arbitration (binding third-party decision), mediation (facilitated negotiation), litigation (court proceedings), or negotiation (direct party-to-party resolution).. Valid values are `arbitration|mediation|litigation|negotiation`',
    `drm_requirements` STRING COMMENT 'DRM and content protection requirements mandated under the agreement, such as encryption standards, conditional access systems, watermarking, and anti-piracy measures.',
    `effective_date` DATE COMMENT 'Date when the carriage agreement becomes binding and the distribution partner is authorized to carry the channel or content package.',
    `exclusivity_window` STRING COMMENT 'Period during which the distribution partner has exclusive carriage rights within a defined geographic territory or platform category (e.g., exclusive MVPD rights in a DMA, exclusive vMVPD rights nationally).',
    `expiration_date` DATE COMMENT 'Date when the carriage agreement term ends. Nullable for open-ended or evergreen agreements subject to termination notice.',
    `geographic_coverage` STRING COMMENT 'Geographic scope of the carriage agreement, typically expressed as authorized DMAs (Designated Market Areas), states, regions, or national coverage. Defines where the distribution partner is authorized to carry the content.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law applicable to the agreement (e.g., State of New York, England and Wales). Determines which courts and laws apply in case of dispute.',
    `holdback_restrictions` STRING COMMENT 'Restrictions on when or where content may be made available on other platforms or windows. Protects the distribution partners investment by limiting competing distribution during the agreement term.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or modification to the carriage agreement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this carriage agreement record was last updated in the system.',
    `minimum_subscriber_guarantee` STRING COMMENT 'Minimum number of subscribers the distribution partner guarantees to deliver for the channel. Used in per-subscriber fee calculations and performance commitments.',
    `must_carry_election` BOOLEAN COMMENT 'Indicates whether the broadcaster has elected must-carry status under FCC rules, requiring the MVPD to carry the signal without negotiation. Applicable to qualified broadcast stations.',
    `negotiation_history` STRING COMMENT 'Summary of key negotiation milestones, amendments, and material changes to the agreement over its lifecycle. Provides context for current terms and future renegotiations.',
    `promotional_commitment` STRING COMMENT 'Marketing and promotional obligations agreed by either party, such as on-air promotion, co-marketing campaigns, EPG placement guarantees, or cross-platform promotion.',
    `renewal_terms` STRING COMMENT 'Conditions and terms governing agreement renewal, including renewal period length, rate adjustments, renegotiation triggers, and notice requirements.',
    `retransmission_consent_granted` BOOLEAN COMMENT 'Indicates whether retransmission consent has been granted under FCC regulations, authorizing the MVPD to rebroadcast over-the-air signals. Applicable only to retransmission consent agreement types.',
    `service_level_agreement` STRING COMMENT 'Performance commitments and service quality standards, including uptime guarantees, signal quality metrics, fault resolution times, and penalties for non-compliance.',
    `technical_delivery_requirements` STRING COMMENT 'Technical specifications for content delivery, including signal format (HD, 4K, HDR), encoding standards (MPEG-2, MPEG-4, HEVC), delivery method (satellite, fiber, IP), and quality parameters (bitrate, resolution, audio channels).',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the agreement. Protects both parties from abrupt service disruption.',
    CONSTRAINT pk_carriage_agreement PRIMARY KEY(`carriage_agreement_id`)
) COMMENT 'Contractual record governing the terms under which a channel or content package is carried by an MVPD, vMVPD, or OTT platform. Covers both retransmission consent agreements (FCC-regulated authorization for MVPDs to rebroadcast OTA signals) and standard carriage contracts. Captures agreement type (retransmission consent, must-carry, voluntary carriage), retransmission consent terms, must-carry election status, carriage fee rates, channel positioning tiers, geographic coverage (authorized DMAs), exclusivity windows, holdback restrictions, compensation terms (cash, channel carriage, promotional commitments), contract effective/expiry dates, and negotiation history. Links to distribution partner and channel master. Distinct from rights licensing contracts owned by the rights domain.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` (
    `delivery_channel_id` BIGINT COMMENT 'Unique identifier for the delivery channel. Primary key.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Linear channels have specific closed captioning, audio description, and accessibility compliance obligations under FCC CVAA rules. Each channel tracks its applicable obligations for compliance reporti',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Linear delivery channels operate under specific broadcast licenses. FCC compliance, public inspection files, EAS participation, and closed captioning obligations all require linking channels to their ',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Delivery channels use specific CDN configurations. delivery_channel.cdn_provider is STRING but should FK to cdn_configuration. Removes cdn_provider STRING.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Linear channels originate from specific facilities with master control. Required for FCC license compliance (facility identification) and channel origination tracking.',
    `ad_insertion_method` STRING COMMENT 'Technical method used for inserting advertisements into the content stream: server-side stitching, client-side insertion, DAI (Dynamic Ad Insertion), SCTE-35 marker-based, or none for ad-free channels.. Valid values are `server-side|client-side|dai|scte-35|none`',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the channel content (4:3 legacy, 16:9 widescreen standard, 21:9 cinematic).. Valid values are `4:3|16:9|21:9`',
    `audio_format` STRING COMMENT 'Audio encoding and delivery format supported by the channel (stereo, Dolby Digital 5.1, Dolby Atmos, DTS, AAC).. Valid values are `stereo|dolby-digital|dolby-atmos|dts|aac`',
    `blackout_rules_enabled` BOOLEAN COMMENT 'Indicates whether geographic or rights-based blackout restrictions are enforced for this channel (true) or not (false).',
    `channel_type` STRING COMMENT 'Classification of the delivery channel by distribution model: linear (traditional broadcast), OTT (over-the-top streaming), FAST (free ad-supported streaming TV), simulcast (simultaneous multi-platform), VOD (video on demand), or hybrid.. Valid values are `linear|ott|fast|simulcast|vod|hybrid`',
    `content_refresh_cadence` STRING COMMENT 'Frequency at which the channel programming lineup or content library is updated with new material.. Valid values are `daily|weekly|monthly|quarterly|on-demand|continuous`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery channel record was first created in the system.',
    `delivery_technology` STRING COMMENT 'The technical transmission standard used for content delivery. DVB (Digital Video Broadcasting) variants for European broadcast, ATSC (Advanced Television Systems Committee) for North American broadcast, QAM (Quadrature Amplitude Modulation) for cable, HLS (HTTP Live Streaming) and MPEG-DASH for adaptive bitrate streaming. [ENUM-REF-CANDIDATE: dvb-t|dvb-s|dvb-c|atsc|qam|hls|mpeg-dash|smooth-streaming|rtmp|webrtc — 10 candidates stripped; promote to reference product]',
    `epg_source_code` STRING COMMENT 'External identifier linking this channel to its Electronic Program Guide (EPG) metadata feed provider (e.g., Gracenote, Tribune Media Services).',
    `fast_aggregator_platform` STRING COMMENT 'Name of the FAST platform aggregator hosting the channel (e.g., Pluto TV, Tubi, Samsung TV Plus, Roku Channel, Xumo). Applicable only to FAST channel types.',
    `fast_playlist_type` STRING COMMENT 'Content scheduling model for FAST channels: linear-loop (repeating content block), scheduled (traditional time-based EPG), dynamic (algorithm-driven), or hybrid. Applicable only to FAST channel types.. Valid values are `linear-loop|scheduled|dynamic|hybrid`',
    `genre_category` STRING COMMENT 'Primary content genre or programming category of the channel. [ENUM-REF-CANDIDATE: news|sports|entertainment|kids|lifestyle|documentary|music|movies|drama|comedy — 10 candidates stripped; promote to reference product]',
    `is_active` BOOLEAN COMMENT 'Indicates whether the channel is currently active and operational (true) or inactive/retired (false).',
    `launch_date` DATE COMMENT 'Date when the channel first went live and began broadcasting or streaming to audiences.',
    `max_bitrate_mbps` DECIMAL(18,2) COMMENT 'Maximum streaming bitrate supported by the channel in megabits per second, representing the highest quality tier in the ABR ladder.',
    `monetization_model` STRING COMMENT 'Revenue model for the channel: AVOD (Advertising-Supported Video On Demand), SVOD (Subscription Video On Demand), TVOD (Transactional Video On Demand), hybrid (multiple models), or free (no monetization).. Valid values are `avod|svod|tvod|hybrid|free`',
    `operational_status` STRING COMMENT 'Current operational state of the delivery channel in the distribution infrastructure.. Valid values are `active|inactive|suspended|testing|planned|retired`',
    `parental_control_rating` STRING COMMENT 'TV Parental Guidelines rating assigned to the channel for content filtering and parental control systems.. Valid values are `tv-y|tv-y7|tv-g|tv-pg|tv-14|tv-ma`',
    `primary_language` STRING COMMENT 'ISO 639-3 three-letter code for the primary broadcast language of the channel (e.g., eng for English, spa for Spanish, fra for French).. Valid values are `^[a-z]{3}$`',
    `qos_tier` STRING COMMENT 'Service level tier defining performance guarantees, uptime SLA, and priority for this channel (premium, standard, basic).. Valid values are `premium|standard|basic`',
    `resolution_format` STRING COMMENT 'Video resolution tier supported by the channel: SD (standard definition 480p), HD (720p), Full HD (1080p), 4K UHD (2160p), 8K UHD (4320p).. Valid values are `sd|hd|full-hd|4k-uhd|8k-uhd`',
    `retirement_date` DATE COMMENT 'Date when the channel ceased operations or was decommissioned. Null for active channels.',
    `retransmission_consent_required` BOOLEAN COMMENT 'Indicates whether retransmission consent agreements are required for MVPDs to rebroadcast this channel (true) or if must-carry rules apply (false).',
    `sla_uptime_percent` DECIMAL(18,2) COMMENT 'Contractual uptime guarantee for the channel expressed as a percentage (e.g., 99.95 for four nines availability).',
    `streaming_endpoint_url` STRING COMMENT 'Primary streaming endpoint URL or manifest URL for OTT and FAST channels. Confidential operational data.',
    `target_market` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the primary geographic market for the channel (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery channel record was last modified.',
    CONSTRAINT pk_delivery_channel PRIMARY KEY(`delivery_channel_id`)
) COMMENT 'Master definition of a logical distribution channel — a named, configured delivery pathway through which content is transmitted to audiences. Covers linear broadcast channels (DVB-T, DVB-S, ATSC, QAM), OTT streaming channels, FAST channels (Pluto TV, Tubi, Samsung TV Plus, Roku Channel), and simulcast feeds. Captures channel name, call sign, channel number, channel type (linear, OTT, FAST, simulcast), delivery technology standard, resolution/format, language, target market, EPG linkage, operational status, and FAST-specific attributes where applicable (aggregator platform, playlist type, ad insertion method, content refresh cadence, monetization model). SSOT for channel identity within the distribution domain.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` (
    `release_window_id` BIGINT COMMENT 'Primary key for release_window',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Release windows specify closed_caption_required and audio_description_required flags. Linking to accessibility_obligation formalizes the governing FCC accessibility mandate per window, enabling compli',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Distribution windows have rating-specific restrictions (R-rated content excluded from daytime windows, TV-Y required for childrens blocks). Content rating determines window eligibility and ad inserti',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Windowing strategies target specific demographics to maximize revenue across release windows. Theatrical windows target A18-49, SVOD windows target families, and AVOD windows target broader demos for ',
    `distribution_partner_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_partner. Business justification: Release windows are negotiated with distribution partners. release_window.platform_name is STRING but should FK to distribution_partner. Removes platform_name STRING.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Release windows operationalize specific grants (SVOD rights, TVOD rights); direct grant link required for automated clearance validation before window activation, royalty calculation per exploitation ',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Distribution windows for childrens content require COPPA declarations. Window-specific data collection practices (viewing analytics, personalization) must be declared and parental consent obtained.',
    `syndication_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.syndication_agreement. Business justification: Release windows for syndicated content are directly governed by syndication_agreement terms (run limits, holdback periods, exclusivity windows). Rights operations teams must link each release window t',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Release windows are inherently territory-specific (US SVOD window vs UK TVOD window); direct territory FK required for geo-blocking rule enforcement, territory-based availability queries, and regulato',
    `ad_insertion_enabled` BOOLEAN COMMENT 'Indicates whether Dynamic Ad Insertion (DAI) is enabled for this distribution window, allowing targeted advertising within the content stream.',
    `ad_load_minutes` DECIMAL(18,2) COMMENT 'Total minutes of advertising permitted per hour of content in this distribution window. Applicable for AVOD, linear, and FAST windows.',
    `audio_description_required` BOOLEAN COMMENT 'Indicates whether audio description track is required for visually impaired accessibility in this distribution window.',
    `blackout_rules` STRING COMMENT 'Geographic or temporal blackout restrictions applied to this distribution window, preventing broadcast in specific regions or time periods (e.g., sports blackout rules).',
    `carriage_fee_amount` DECIMAL(18,2) COMMENT 'Fixed carriage fee paid by the distributor or MVPD for the right to carry this content during the window period.',
    `closed_caption_required` BOOLEAN COMMENT 'Indicates whether closed captioning is required for accessibility compliance in this distribution window.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution window record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for pricing in this distribution window (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dubbing_languages` STRING COMMENT 'Comma-separated list of dubbing/audio track languages available for this distribution window (ISO 639-1 codes).',
    `effective_timestamp` TIMESTAMP COMMENT 'Precise timestamp when this distribution window record became effective and operational for scheduling and delivery systems.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this distribution window grants exclusive rights to the platform, preventing simultaneous distribution on competing platforms during the window period.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Precise timestamp when this distribution window record expires and is no longer valid for operational use. Nullable for indefinite windows.',
    `hdr_enabled` BOOLEAN COMMENT 'Indicates whether High Dynamic Range video format is enabled for this distribution window, providing enhanced color and contrast.',
    `holdback_period_days` STRING COMMENT 'Number of days between the close of the previous window and the open of this window, enforcing exclusivity periods per rights agreements.',
    `language_version` STRING COMMENT 'Primary language version of the content distributed in this window (e.g., English, Spanish, French). ISO 639-1 two-letter language codes preferred.',
    `max_resolution` STRING COMMENT 'Maximum video resolution permitted for distribution in this window. SD = Standard Definition (480p); HD = High Definition (720p); Full HD = 1080p; 4K = Ultra HD (2160p); 8K = 4320p.. Valid values are `sd|hd|full_hd|4k|8k`',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment amount from the distributor or platform for this distribution window, regardless of actual performance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution window record was last modified or updated.',
    `platform_type` STRING COMMENT 'Classification of the distribution platform. OTT = Over-The-Top streaming; Linear Broadcast = traditional scheduled TV; Theatrical = cinema exhibition; MVPD = Multichannel Video Programming Distributor; vMVPD = Virtual MVPD; FAST Channel = Free Ad-Supported Streaming Television channel; Syndication Network = content resale network. [ENUM-REF-CANDIDATE: ott|linear_broadcast|theatrical|mvpd|vmvpd|fast_channel|syndication_network — 7 candidates stripped; promote to reference product]',
    `pricing_model` STRING COMMENT 'Revenue model for this distribution window. Subscription = SVOD flat fee; Transactional = TVOD pay-per-view or rental; Advertising = AVOD ad-supported; Free = no charge to viewer; Hybrid = combination of models.. Valid values are `subscription|transactional|advertising|free|hybrid`',
    `purchase_price` DECIMAL(18,2) COMMENT 'Price charged to viewers for permanent purchase/download during this window (EST model). Nullable if not applicable.',
    `rental_price` DECIMAL(18,2) COMMENT 'Price charged to viewers for transactional rental access during this window (TVOD model). Nullable if not applicable.',
    `revenue_share_percent` DECIMAL(18,2) COMMENT 'Percentage of revenue shared with the platform or distributor for this window, per the commercial distribution agreement.',
    `streaming_protocol` STRING COMMENT 'Primary streaming protocol used for content delivery in this window. HLS = HTTP Live Streaming; MPEG-DASH = Dynamic Adaptive Streaming over HTTP; Smooth Streaming = Microsoft Smooth Streaming; RTMP = Real-Time Messaging Protocol; Progressive Download = traditional file download.. Valid values are `hls|mpeg_dash|smooth_streaming|rtmp|progressive_download`',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of subtitle languages available for this distribution window (ISO 639-1 codes).',
    `territory_scope` STRING COMMENT 'Geographic territory or market where this distribution window applies. May be a single country code (ISO 3166-1 alpha-3), region, or WORLDWIDE for global distribution.',
    `window_close_date` DATE COMMENT 'Date when the distribution window closes and content is no longer available on the specified platform or channel. Nullable for open-ended windows.',
    `window_code` STRING COMMENT 'Business identifier code for the distribution window, used for operational scheduling and reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `window_open_date` DATE COMMENT 'Date when the distribution window opens and content becomes available on the specified platform or channel.',
    `window_priority` STRING COMMENT 'Numeric priority ranking of this window in the overall release strategy, where 1 = highest priority (typically theatrical), incrementing for subsequent windows.',
    `window_status` STRING COMMENT 'Current lifecycle status of the distribution window. Planned = scheduled but not yet open; Active = currently in distribution; Closed = window period has ended; Suspended = temporarily paused; Cancelled = window will not proceed.. Valid values are `planned|active|closed|suspended|cancelled`',
    `window_type` STRING COMMENT 'Type of distribution window defining the release strategy. Theatrical = cinema release; SVOD = Subscription Video On Demand; AVOD = Advertising-Supported Video On Demand; TVOD = Transactional Video On Demand; Linear = traditional broadcast; FAST = Free Ad-Supported Streaming Television; Syndication = content resale to multiple outlets; PPV = Pay-Per-View; EST = Electronic Sell-Through. [ENUM-REF-CANDIDATE: theatrical|svod|avod|tvod|linear|fast|syndication|vod|ppv|est — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_release_window PRIMARY KEY(`release_window_id`)
) COMMENT 'Master record defining the sequential release windowing strategy for a content title across distribution platforms and channels. Captures window type (theatrical, SVOD, AVOD, TVOD, linear, FAST, syndication), platform or channel assignment, window open date, window close date, holdback period, exclusivity flag, and territory scope. Implements the windowing strategy derived from rights agreements and commercial distribution deals. Complements the rights domains window records by focusing on operational delivery scheduling.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` (
    `delivery_event_id` BIGINT COMMENT 'Unique identifier for the delivery event record. Primary key.',
    `ad_billing_order_id` BIGINT COMMENT 'Foreign key linking to billing.ad_billing_order. Business justification: Delivery events record actual ad spot delivery (ad_fill_rate_percent, ad_pod_position, scte35_signal_type). Linking to ad_billing_order enables post-log affidavit reconciliation — verifying contracted',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Market attribution of delivery events enables DMA-level reporting, geographic blackout enforcement, local advertising compliance, and Nielsen station index measurement for broadcast and streaming conv',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: When delivery_event records ad delivery (dai_enabled flag), linking to campaign enables campaign-level delivery verification and performance tracking. Essential for bridging distribution delivery logs; FK references sales domain entity; namespace reconciled from advertising context',
    `channel_id` BIGINT COMMENT 'Reference to the distribution channel through which content was delivered (linear broadcast channel, OTT platform, FAST channel).',
    `closed_caption_record_id` BIGINT COMMENT 'Foreign key linking to compliance.closed_caption_record. Business justification: FCC closed captioning compliance requires that each captioned delivery event be traceable to its closed_caption_record for accuracy scoring, complaint investigation, and regulatory filing. This link e',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: delivery_event.delivery_channel_type is a free-text STRING describing the type of delivery channel used for the event. Normalizing this to a FK delivery_channel_id -> delivery_channel.delivery_channel',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Content delivery logs require demographic context for Nielsen measurement reconciliation, audience guarantee validation, and cross-platform deduplication. Supports C3/C7 commercial ratings and makegoo',
    `device_type_id` BIGINT COMMENT 'Reference to the device type used by the viewer for this delivery event.',
    `eas_log_id` BIGINT COMMENT 'Foreign key linking to compliance.eas_log. Business justification: Delivery events for emergency alert system messages must be logged for FCC compliance. Each EAS delivery creates a compliance log entry documenting transmission, relay, and attention signal.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Delivery events represent actual content delivery under specific rights grants. Essential for usage tracking, run count enforcement, and royalty calculation based on actual exploitation. Enables right',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Delivery events link to transmission equipment for performance tracking. Required for equipment performance reporting and failure pattern analysis.',
    `playback_session_id` BIGINT COMMENT 'Reference to the playback session associated with this delivery event for OTT/streaming deliveries.',
    `political_ad_record_id` BIGINT COMMENT 'Foreign key linking to compliance.political_ad_record. Business justification: FCC requires broadcasters to maintain records of political ad airings. Linking delivery_event to political_ad_record enables automated verification that political spots were delivered as contracted, s',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: CDN delivery events must tie to scheduled slots for technical delivery SLA monitoring, as-run log reconciliation, and troubleshooting delivery failures against scheduled content. Operations teams need',
    `streaming_endpoint_id` BIGINT COMMENT 'Reference to the streaming endpoint used for OTT delivery events.',
    `ad_fill_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of available ad inventory that was successfully filled during this DAI event (0.00 to 100.00).',
    `ad_pod_position` STRING COMMENT 'Position of the ad pod within the content stream for DAI events (e.g., pre-roll=1, mid-roll=2, post-roll=3).',
    `audio_codec` STRING COMMENT 'Audio codec used for the delivered content (e.g., AAC, AC-3, E-AC-3, Dolby Atmos).',
    `bitrate_kbps` STRING COMMENT 'Stream bitrate in kilobits per second at the time of this delivery event.',
    `bytes_delivered` BIGINT COMMENT 'Total number of bytes delivered to the viewer during this event.',
    `cdn_cache_status` STRING COMMENT 'CDN cache status for this delivery (hit, miss, stale, bypass).. Valid values are `hit|miss|stale|bypass`',
    `cdn_node_code` STRING COMMENT 'Identifier of the CDN edge node that served the content for this delivery event.',
    `cdn_pop_location` STRING COMMENT 'Geographic location identifier of the CDN point of presence that served this delivery.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery event record was created in the system.',
    `dai_enabled` BOOLEAN COMMENT 'Flag indicating whether dynamic ad insertion was enabled for this delivery event.',
    `delivery_status` STRING COMMENT 'Outcome status of the delivery event (success, failure, degraded quality, partial delivery).. Valid values are `success|failure|degraded|partial`',
    `delivery_technology` STRING COMMENT 'Technical protocol or standard used for content delivery (HLS, MPEG-DASH, DVB, ATSC, QAM, Smooth Streaming, RTMP). [ENUM-REF-CANDIDATE: hls|mpeg_dash|dvb|atsc|qam|smooth_streaming|rtmp — 7 candidates stripped; promote to reference product]',
    `drm_system` STRING COMMENT 'DRM system applied to protect the content during delivery (Widevine, PlayReady, FairPlay, or none for unprotected content).. Valid values are `widevine|playready|fairplay|none`',
    `error_code` STRING COMMENT 'System error code if the delivery event encountered a failure or degradation.',
    `error_message` STRING COMMENT 'Human-readable error message describing the delivery failure or issue.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the delivery event occurred (stream start, broadcast transmission, VOD delivery initiation).',
    `event_type` STRING COMMENT 'Type of delivery event being recorded (stream start, VOD delivery, broadcast transmission, DAI insertion, stream end, playback error, buffer event). [ENUM-REF-CANDIDATE: stream_start|vod_delivery|broadcast_tx|dai_insertion|stream_end|playback_error|buffer_event — 7 candidates stripped; promote to reference product]',
    `geographic_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the delivery occurred (e.g., USA, GBR, CAN).',
    `geographic_region` STRING COMMENT 'Geographic region where the content was delivered (e.g., North America, EMEA, APAC, or specific country/state codes).',
    `network_latency_ms` STRING COMMENT 'Network latency measured in milliseconds between CDN edge and viewer device.',
    `origin_server_response_time_ms` STRING COMMENT 'Response time from origin server in milliseconds for cache-miss scenarios.',
    `resolution` STRING COMMENT 'Video resolution delivered (e.g., 1920x1080, 3840x2160, 1280x720).',
    `scte35_signal_type` STRING COMMENT 'Type of SCTE-35 signal that triggered the DAI event (e.g., splice_insert, time_signal).',
    `session_duration_seconds` STRING COMMENT 'Total duration of the delivery session in seconds for streaming events.',
    `sla_tier` STRING COMMENT 'SLA tier classification applicable to this delivery event (e.g., premium, standard, basic).',
    `streaming_protocol` STRING COMMENT 'Specific streaming protocol used for OTT delivery (HLS, DASH, Smooth Streaming, RTMP, WebRTC).. Valid values are `hls|dash|smooth|rtmp|webrtc`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery event record was last updated.',
    `user_agent` STRING COMMENT 'User agent string from the viewer device identifying browser/app and operating system.',
    `video_codec` STRING COMMENT 'Video codec used for encoding the delivered content (e.g., H.264, H.265/HEVC, VP9, AV1).',
    `viewer_ip_address` STRING COMMENT 'IP address of the viewer device that received the content delivery.',
    CONSTRAINT pk_delivery_event PRIMARY KEY(`delivery_event_id`)
) COMMENT 'Transactional record capturing each discrete content delivery event — including stream session initiations, linear broadcast transmissions, VOD asset deliveries, FAST channel playout events, and dynamic ad insertion (DAI) sessions. Captures event timestamp, event type (stream_start, vod_delivery, broadcast_tx, dai_insertion), delivery channel, content asset reference, delivery technology (HLS, MPEG-DASH, DVB, ATSC), CDN node, geographic region, stream quality (bitrate, resolution), delivery status (success, failure, degraded), error codes, and DAI-specific attributes (ad pod position, SCTE-35 signal, fill rate) where applicable. Feeds delivery SLA monitoring, CDN performance reporting, and AVOD/FAST monetization reconciliation.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` (
    `channel_lineup_id` BIGINT COMMENT 'Primary key for channel_lineup',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Channel lineup records specify closed_caption_required and audio_description_available. Linking to accessibility_obligation formalizes the governing FCC accessibility mandate per lineup entry, enablin',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Channel lineups vary by DMA due to must-carry rules, local station carriage, blackout restrictions, and market-specific programming rights. Required for FCC compliance and retransmission consent enfor',
    `carriage_agreement_id` BIGINT COMMENT 'Foreign key linking to distribution.carriage_agreement. Business justification: Channel lineups are defined by carriage agreements. Lineup terms and channel positioning come from agreements. Removes contract_reference_number STRING (derivable from carriage_agreement.agreement_num',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Channel lineups carry per-subscriber carriage fees invoiced monthly to distribution partners. A direct FK to the billing invoice enables carriage fee reconciliation and invoice auditing at the lineup ',
    `channel_id` BIGINT COMMENT 'Reference to the specific broadcast or streaming channel included in this lineup.',
    `distribution_partner_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_partner. Business justification: Channel lineups belong to distribution partners. channel_lineup.partner_id should FK to distribution_partner. Removes partner_id BIGINT (replaced by distribution_partner_id FK).',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Channel lineup entries must comply with must-carry obligations and channel positioning rules. Linking channel_lineup to regulatory_obligation supports FCC compliance reporting on must-carry elections ',
    `audio_description_available` BOOLEAN COMMENT 'Indicates whether audio description (descriptive video service) is available for visually impaired subscribers.',
    `blackout_region_codes` STRING COMMENT 'Comma-separated list of geographic region codes where blackout restrictions apply for this channel (e.g., DMA codes, postal codes, state codes).',
    `blackout_rules_applicable` BOOLEAN COMMENT 'Indicates whether geographic broadcast restriction (blackout) rules apply to this channel within the lineup.',
    `carriage_fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the carriage fee (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `carriage_fee_per_subscriber` DECIMAL(18,2) COMMENT 'Monthly fee paid by the MVPD/vMVPD to the content provider per subscriber who has access to this channel within the lineup. Used for carriage fee calculation and revenue assurance.',
    `carriage_type` STRING COMMENT 'Legal basis for the channels inclusion in the lineup: must-carry (mandatory FCC requirement), retransmission consent (negotiated rebroadcast authorization), or negotiated carriage agreement.. Valid values are `must_carry|retransmission_consent|negotiated`',
    `channel_display_name` STRING COMMENT 'The branded name of the channel as displayed to subscribers in the EPG (Electronic Program Guide) for this specific lineup.',
    `channel_position_number` STRING COMMENT 'Logical channel number or position assigned to the channel within this lineup (e.g., channel 101, channel 502). Used for Electronic Program Guide (EPG) display and subscriber navigation.',
    `closed_caption_required` BOOLEAN COMMENT 'Indicates whether closed captioning is mandated for this channel per FCC accessibility requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel lineup record was first created in the system.',
    `dma_code` STRING COMMENT 'Nielsen Designated Market Area code identifying the specific television market where this lineup is offered (e.g., 501 for New York).',
    `dvr_enabled` BOOLEAN COMMENT 'Indicates whether subscribers can record content from this channel using DVR functionality.',
    `effective_end_date` DATE COMMENT 'Date when this channel lineup configuration expires or is replaced. Null indicates an open-ended active lineup.',
    `effective_start_date` DATE COMMENT 'Date when this channel lineup configuration becomes active and available to subscribers.',
    `geographic_restriction_rules` STRING COMMENT 'Detailed description of geographic restrictions, including allowed and blocked regions, for subscriber entitlement validation.',
    `hd_available` BOOLEAN COMMENT 'Indicates whether the channel is available in high definition (HD) format within this lineup.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel lineup record was most recently updated.',
    `lineup_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the lineup within the partners system (e.g., BASIC-01, PREM-SPORTS).',
    `lineup_name` STRING COMMENT 'Business name of the channel lineup or package (e.g., Basic Cable, Premium Sports Tier, Expanded Basic).',
    `lineup_status` STRING COMMENT 'Current operational status of the channel lineup configuration.. Valid values are `active|inactive|pending|suspended|expired`',
    `market_applicability` STRING COMMENT 'Geographic scope of the lineup: national (available across all markets), regional (multi-state region), local (single market), or DMA-specific (Designated Market Area).. Valid values are `national|regional|local|dma_specific`',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this channel lineup record.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special instructions, or business context related to this channel lineup configuration.',
    `parental_control_rating` STRING COMMENT 'Content rating classification for parental control enforcement at the channel level within the lineup. [ENUM-REF-CANDIDATE: TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA|not_rated — 7 candidates stripped; promote to reference product]',
    `priority_rank` STRING COMMENT 'Relative priority or importance ranking of this channel within the lineup, used for EPG display ordering and promotional emphasis.',
    `promotional_end_date` DATE COMMENT 'Date when the promotional offering for this channel expires, after which standard pricing or availability rules apply.',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this channel is being offered as part of a promotional campaign or limited-time offer within the lineup.',
    `service_tier` STRING COMMENT 'Service level classification indicating the quality or feature set of the lineup (e.g., standard definition, high definition, 4K).. Valid values are `standard|enhanced|premium|ultra`',
    `subscriber_count_estimate` STRING COMMENT 'Estimated number of subscribers who have access to this channel through this lineup. Used for carriage fee calculation and audience reach estimation.',
    `tier_type` STRING COMMENT 'Classification of the channel tier or package type offered to subscribers. [ENUM-REF-CANDIDATE: basic|expanded_basic|premium|sports|news|entertainment|international|a_la_carte — 8 candidates stripped; promote to reference product]',
    `uhd_4k_available` BOOLEAN COMMENT 'Indicates whether the channel is available in 4K ultra high definition format within this lineup.',
    `vod_enabled` BOOLEAN COMMENT 'Indicates whether Video On Demand (VOD) content is available for this channel within the lineup.',
    CONSTRAINT pk_channel_lineup PRIMARY KEY(`channel_lineup_id`)
) COMMENT 'Master record defining the channel package or tier lineup offered by an MVPD or vMVPD partner, specifying which delivery channels are included in each subscriber tier (basic, expanded basic, premium, sports, etc.). Captures partner, tier name, tier type, included channels, channel position number, effective date, and market applicability. Used for carriage fee calculation, blackout enforcement, and subscriber entitlement validation.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` (
    `deal_id` BIGINT COMMENT 'Primary key for deal',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Distribution deals originate from sales opportunities in the deal lifecycle. Tracks opportunity-to-contract conversion for distribution partnerships, platform licensing, and carriage agreements. Essen',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Retransmission consent and carriage deals are directly tied to specific broadcast licenses — the license defines the rights being negotiated. Linking deal to broadcast_license supports deal compliance',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Distribution deals are negotiated and executed under a governing distribution_agreement. Deal management and revenue reporting require linking each deal to its authorizing distribution_agreement — a n',
    `distribution_partner_id` BIGINT COMMENT 'Reference to the OTT platform, FAST aggregator, syndication buyer, or international distributor party to this deal.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Distribution deals with partners are governed by underlying content license agreements. Critical for validating distribution rights chain, ensuring revenue share terms align with license obligations, ',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the deal automatically renews at expiration unless terminated. True = auto-renews; False = requires explicit renewal.',
    `content_scope` STRING COMMENT 'Description of the content assets included in this deal. May reference specific titles, series, libraries, or content categories covered by the agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this deal record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this deal (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deal_number` STRING COMMENT 'Externally-known unique business identifier for the distribution deal, used in contracts and communications.',
    `deal_status` STRING COMMENT 'Current lifecycle status of the distribution deal. Tracks progression from initial draft through negotiation, approval, active operation, and eventual closure or renewal. [ENUM-REF-CANDIDATE: draft|negotiation|pending approval|active|suspended|expired|terminated|renewed — 8 candidates stripped; promote to reference product]',
    `deal_type` STRING COMMENT 'Classification of the distribution deal structure. SVOD licensing = Subscription Video On Demand content licensing; AVOD revenue share = Advertising-Supported Video On Demand with revenue sharing; FAST syndication = Free Ad-Supported Streaming Television channel syndication; linear carriage = traditional broadcast carriage; TVOD licensing = Transactional Video On Demand licensing; international distribution = cross-border content distribution agreements.. Valid values are `SVOD licensing|AVOD revenue share|FAST syndication|linear carriage|TVOD licensing|international distribution`',
    `dispute_resolution_mechanism` STRING COMMENT 'Agreed method for resolving disputes arising from this deal.. Valid values are `arbitration|mediation|litigation|negotiation`',
    `drm_requirements` STRING COMMENT 'Specification of DRM systems and protection levels required for content delivery under this deal (e.g., Widevine L1, PlayReady SL3000, FairPlay).',
    `effective_date` DATE COMMENT 'Date when the distribution deal becomes active and content distribution rights commence.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this deal grants exclusive distribution rights to the partner within the specified territory and platform type. True = exclusive; False = non-exclusive.',
    `exclusivity_window_days` STRING COMMENT 'Duration in days of the exclusivity period or holdback window during which content cannot be distributed through competing channels.',
    `expiration_date` DATE COMMENT 'Date when the distribution deal expires and content distribution rights terminate. Nullable for open-ended or perpetual deals.',
    `flat_fee_amount` DECIMAL(18,2) COMMENT 'Fixed payment amount for flat fee deal structures. Represents total or periodic payment value.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction whose laws govern the interpretation and enforcement of this deal (e.g., State of California, England and Wales).',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or modification to the deal terms.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum Guarantee amount paid upfront or over the deal term, recoupable against future revenue share or royalties.',
    `minimum_subscriber_guarantee` BIGINT COMMENT 'Minimum number of subscribers or active users the distribution partner guarantees for revenue calculation purposes.',
    `deal_name` STRING COMMENT 'Human-readable name or title of the distribution deal for identification and reporting purposes.',
    `negotiation_start_date` DATE COMMENT 'Date when commercial negotiations for this deal commenced.',
    `notes` STRING COMMENT 'Free-form text field for additional context, special conditions, or internal comments about the deal.',
    `payment_terms` STRING COMMENT 'Description of payment schedule, frequency, and conditions (e.g., net 30, quarterly in arrears, monthly advance).',
    `platform_type` STRING COMMENT 'Type of distribution platform. OTT = Over-The-Top streaming; FAST = Free Ad-Supported Streaming Television; MVPD = Multichannel Video Programming Distributor; vMVPD = Virtual MVPD; linear broadcast = traditional broadcast; syndication = content resale; international = cross-border distribution. [ENUM-REF-CANDIDATE: OTT|FAST|MVPD|vMVPD|linear broadcast|syndication|international — 7 candidates stripped; promote to reference product]',
    `promotional_commitment` STRING COMMENT 'Description of marketing and promotional activities the distribution partner has committed to perform (e.g., homepage placement, email campaigns, social media promotion).',
    `renewal_notice_days` STRING COMMENT 'Number of days advance notice required to exercise or decline renewal option before expiration.',
    `reporting_frequency` STRING COMMENT 'Frequency at which the distribution partner must provide performance and revenue reports.. Valid values are `monthly|quarterly|semi-annually|annually|on-demand`',
    `revenue_model` STRING COMMENT 'Commercial structure defining how revenue is generated and shared. Flat fee = fixed payment; revenue share = percentage of platform revenue; minimum guarantee = MG against future royalties; hybrid = combination of models; cost per stream = per-view payment; cost per subscriber = per-subscriber payment.. Valid values are `flat fee|revenue share|minimum guarantee|hybrid|cost per stream|cost per subscriber`',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue allocated to the content owner under revenue share agreements. Expressed as a percentage (e.g., 65.00 represents 65%).',
    `signed_date` DATE COMMENT 'Date when the distribution deal contract was executed by all parties.',
    `sla_tier` STRING COMMENT 'Service level tier defining uptime, performance, and support commitments for content delivery under this deal.. Valid values are `premium|standard|basic`',
    `technical_delivery_requirements` STRING COMMENT 'Technical specifications for content delivery including format, resolution, bitrate, codec, and delivery method (e.g., HLS 1080p H.264, DASH 4K HEVC).',
    `term_months` STRING COMMENT 'Duration of the deal term expressed in months. Calculated from effective date to expiration date.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the deal prior to natural expiration.',
    `territory` STRING COMMENT 'Geographic territory or territories covered by this distribution deal. May be a single country code, multiple countries, or regional designation (e.g., USA, CAN|MEX, EMEA).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this deal record was last modified in the system.',
    CONSTRAINT pk_deal PRIMARY KEY(`deal_id`)
) COMMENT 'Master record for commercial distribution deals negotiated with OTT platforms, FAST aggregators, syndication buyers, and international distributors. Captures deal name, deal type (SVOD licensing, AVOD revenue share, FAST syndication, linear carriage), counterparty, territory, content scope, revenue model (flat fee, revenue share percentage, MG against royalty), deal effective date, expiry date, and deal status. Distinct from carriage_agreement (which is MVPD-specific) — this covers broader OTT and digital distribution commercial arrangements.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` (
    `content_delivery_order_id` BIGINT COMMENT 'Unique identifier for the content delivery order. Primary key for this transactional record representing a formal order to deliver content assets to distribution partners or platforms.',
    `carriage_agreement_id` BIGINT COMMENT 'Reference to the underlying carriage or distribution agreement that authorizes this content delivery. Links order to contractual obligations.',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: content_delivery_order.target_platform is a STRING field capturing the destination delivery channel for the order. Normalizing this to a FK delivery_channel_id -> delivery_channel.delivery_channel_id ',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Delivery orders fulfill specific content exploitation rights; grant link enables pre-delivery clearance verification ("do we have rights to deliver this?"), usage tracking for royalty calculation, and',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Delivery orders specify exact rendition (proxy/mezzanine/distribution master) for partner fulfillment. Broadcasters track which version was delivered for audit/quality purposes. Existing content_asset',
    `program_schedule_id` BIGINT COMMENT 'Foreign key linking to scheduling.program_schedule. Business justification: Content delivery orders fulfill scheduled programming requirements. Operations and billing teams must track which delivery orders satisfy which program schedules for fulfillment verification, delivery',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Content delivery orders for broadcast content must reference the applicable regulatory_obligation (closed captioning delivery, accessibility, EAS) to ensure compliant fulfillment. This link supports c',
    `release_window_id` BIGINT COMMENT 'Foreign key linking to distribution.release_window. Business justification: A content_delivery_order represents a formal order to deliver a content asset to a partner/platform. release_window defines the sequential windowing strategy for a title across distribution platforms,',
    `streaming_endpoint_id` BIGINT COMMENT 'Reference to the target streaming endpoint or Content Delivery Network (CDN) origin where content will be published.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Timestamp when the content was actually delivered and confirmed received by the distribution partner. Used for SLA performance measurement.',
    `approved_by_user` STRING COMMENT 'Username or identifier of the user who approved this delivery order for fulfillment. Tracks authorization and approval workflow.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery order was approved for fulfillment. Marks the transition from draft to active status.',
    `audio_configuration` STRING COMMENT 'Audio channel configuration and format for the delivered content. Defines the immersive audio capabilities and speaker layout.. Valid values are `stereo|surround_5_1|surround_7_1|dolby_atmos|dts_x`',
    `audio_languages` STRING COMMENT 'Comma-separated list of ISO 639-2 language codes for audio tracks included in the delivery. Supports multi-language distribution requirements.',
    `closed_captions_included` BOOLEAN COMMENT 'Indicates whether closed captions are included in the delivered content. Required for FCC compliance and accessibility standards.',
    `content_duration_seconds` STRING COMMENT 'Total runtime duration of the content asset being delivered, measured in seconds. Used for capacity planning and delivery time estimation.',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this delivery order. Provides accountability and audit trail for order origination.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery order record was first created in the system. Audit trail for record lifecycle tracking.',
    `delivery_deadline_timestamp` TIMESTAMP COMMENT 'Precise deadline timestamp for content delivery. Used for Service Level Agreement (SLA) compliance tracking and penalty calculations.',
    `delivery_format` STRING COMMENT 'Required content format for delivery. Specifies the container format, codec, and packaging standard expected by the distribution partner. [ENUM-REF-CANDIDATE: hls|mpeg_dash|smooth_streaming|mxf|mp4|prores|imf — 7 candidates stripped; promote to reference product]',
    `delivery_method` STRING COMMENT 'Technical method or protocol used to transfer the content to the distribution partner. Defines the transport mechanism for content delivery.. Valid values are `cdn_push|ftp|aspera|satellite_uplink|physical_media|api`',
    `delivery_notes` STRING COMMENT 'Free-text notes and special instructions for the delivery order. Captures partner-specific requirements, technical considerations, or operational alerts.',
    `estimated_delivery_duration_minutes` STRING COMMENT 'Estimated time required to complete the content delivery, measured in minutes. Based on file size, bandwidth, and delivery method.',
    `failure_reason` STRING COMMENT 'Description of the reason for delivery failure if order status is failed. Used for root cause analysis and process improvement.',
    `file_size_gb` DECIMAL(18,2) COMMENT 'Total file size of the content package being delivered, measured in gigabytes. Used for bandwidth planning and cost estimation.',
    `fulfillment_confirmation_number` STRING COMMENT 'Unique confirmation identifier provided upon successful delivery completion. Used for proof of delivery and reconciliation with distribution partners.',
    `geographic_restrictions` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where content delivery is restricted or permitted. Enforces territorial rights and blackout rules.',
    `hdr_format` STRING COMMENT 'High Dynamic Range format specification for the delivered content. Defines the color space and dynamic range capabilities.. Valid values are `sdr|hdr10|hdr10_plus|dolby_vision|hlg`',
    `order_date` TIMESTAMP COMMENT 'Timestamp when the delivery order was created or placed. Represents the principal business event time for this transaction.',
    `order_number` STRING COMMENT 'Externally-known unique business identifier for this delivery order. Used for tracking, communication, and reconciliation with distribution partners.. Valid values are `^CDO-[0-9]{8}-[A-Z0-9]{6}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the delivery order. Tracks the order through its workflow from creation to fulfillment or cancellation. [ENUM-REF-CANDIDATE: draft|pending|approved|in_progress|delivered|failed|cancelled — 7 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the delivery order type. Indicates the nature and urgency of the content delivery request.. Valid values are `new_release|refresh|replacement|emergency|scheduled|on_demand`',
    `priority_level` STRING COMMENT 'Business priority assigned to this delivery order. Determines resource allocation and scheduling precedence in the delivery queue.. Valid values are `critical|high|normal|low`',
    `requested_delivery_date` DATE COMMENT 'Target date by which the content must be delivered to the distribution partner. Drives scheduling and prioritization of delivery tasks.',
    `retry_count` STRING COMMENT 'Number of delivery attempts made for this order. Tracks resilience and reliability of the delivery process.',
    `sla_tier` STRING COMMENT 'Service level tier assigned to this delivery order. Determines performance targets, priority, and penalty provisions.. Valid values are `platinum|gold|silver|bronze|standard`',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of ISO 639-2 language codes for subtitle tracks included in the delivery. Supports accessibility and international distribution.',
    `transcode_profile_code` BIGINT COMMENT 'Reference to the transcode profile specifying encoding parameters, bitrates, resolutions, and quality settings for content preparation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery order record was last modified. Tracks the most recent change to any field in the record.',
    `video_resolution` STRING COMMENT 'Target video resolution for the delivered content. Specifies the quality tier and display format for the distribution platform.. Valid values are `sd|hd_720p|hd_1080p|uhd_4k|uhd_8k`',
    CONSTRAINT pk_content_delivery_order PRIMARY KEY(`content_delivery_order_id`)
) COMMENT 'Transactional record representing a formal order to deliver a specific content asset or package to a distribution partner or platform by a specified deadline. Captures order type (new release, refresh, replacement, emergency), content asset reference, target distribution platform, required delivery format, transcode profile, DRM policy, delivery deadline, delivery method (CDN push, FTP, Aspera, satellite uplink), order status, and fulfillment confirmation. Operationalizes the distribution deal and window commitments into actionable delivery tasks.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_failover_endpoint_streaming_endpoint_id` FOREIGN KEY (`failover_endpoint_streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`deal`(`deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_playback_session_id` FOREIGN KEY (`playback_session_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`playback_session`(`playback_session_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ADD CONSTRAINT `fk_distribution_channel_lineup_carriage_agreement_id` FOREIGN KEY (`carriage_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement`(`carriage_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ADD CONSTRAINT `fk_distribution_channel_lineup_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_carriage_agreement_id` FOREIGN KEY (`carriage_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement`(`carriage_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_release_window_id` FOREIGN KEY (`release_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`release_window`(`release_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`distribution` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`distribution` SET TAGS ('dbx_domain' = 'distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` SET TAGS ('dbx_subdomain' = 'platform_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Top (OTT) Platform ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `adobe_property_code` SET TAGS ('dbx_business_glossary_term' = 'Adobe Experience Platform Property ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `arpu` SET TAGS ('dbx_business_glossary_term' = 'Average Revenue Per User (ARPU)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `arpu` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `base_subscription_price` SET TAGS ('dbx_business_glossary_term' = 'Base Subscription Price');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `base_subscription_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `billing_currency` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency (ISO 4217)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `billing_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_origin_url` SET TAGS ('dbx_business_glossary_term' = 'CDN Origin URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_origin_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9._/-]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Provider');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_value_regex' = 'Akamai|Cloudflare|AWS CloudFront|Fastly|Multi-CDN');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_business_glossary_term' = 'Content Rating System');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_value_regex' = 'MPAA|BBFC|FSK|ACB|CBFC|TV-PG');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `coppa_compliant` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Compliant Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `dai_provider` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Provider');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `drm_system` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) System');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `drm_system` SET TAGS ('dbx_value_regex' = 'Widevine|FairPlay|PlayReady|Multi-DRM|NONE');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `epg_feed_url` SET TAGS ('dbx_business_glossary_term' = 'Electronic Program Guide (EPG) Feed URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `epg_feed_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9._/-]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `fast_channel_enabled` SET TAGS ('dbx_business_glossary_term' = 'Free Ad-Supported Streaming Television (FAST) Channel Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `free_trial_days` SET TAGS ('dbx_business_glossary_term' = 'Free Trial Period (Days)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `hdr_supported` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Support Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Platform Launch Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_concurrent_streams` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Streams Per Subscriber');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_download_devices` SET TAGS ('dbx_business_glossary_term' = 'Maximum Offline Download Devices');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Maximum Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_video_resolution` SET TAGS ('dbx_value_regex' = 'SD|HD|FHD|4K|8K');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `mvpd_carriage_eligible` SET TAGS ('dbx_business_glossary_term' = 'Multichannel Video Programming Distributor (MVPD) Carriage Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `parent_brand` SET TAGS ('dbx_business_glossary_term' = 'Parent Brand Identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'OTT Platform Business Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,30}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_description` SET TAGS ('dbx_business_glossary_term' = 'OTT Platform Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_name` SET TAGS ('dbx_business_glossary_term' = 'OTT Platform Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_status` SET TAGS ('dbx_business_glossary_term' = 'OTT Platform Operational Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_status` SET TAGS ('dbx_value_regex' = 'active|inactive|beta|sunset|suspended');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `primary_streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Primary Streaming Protocol (HLS/MPEG-DASH)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `primary_streaming_protocol` SET TAGS ('dbx_value_regex' = 'HLS|MPEG-DASH|HLS,MPEG-DASH|RTMP|SRT');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `service_tier` SET TAGS ('dbx_business_glossary_term' = 'OTT Service Tier (SVOD/AVOD/TVOD/FAST)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `service_tier` SET TAGS ('dbx_value_regex' = 'SVOD|AVOD|TVOD|FAST|HYBRID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `sla_uptime_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Target Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `subscriber_count` SET TAGS ('dbx_business_glossary_term' = 'Active Subscriber Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `subscriber_count` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `sunset_date` SET TAGS ('dbx_business_glossary_term' = 'Platform Sunset Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `supported_device_classes` SET TAGS ('dbx_business_glossary_term' = 'Supported Device Classes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `target_start_bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Target Start Bitrate (Kbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `zuora_product_code` SET TAGS ('dbx_business_glossary_term' = 'Zuora Product Catalog ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` SET TAGS ('dbx_subdomain' = 'platform_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `device_type_id` SET TAGS ('dbx_business_glossary_term' = 'Device Type ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `abr_profile_dash` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile MPEG-DASH Supported');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `abr_profile_hls` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile HTTP Live Streaming (HLS) Supported');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `abr_profile_smooth` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile Smooth Streaming Supported');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `active_install_base` SET TAGS ('dbx_business_glossary_term' = 'Active Install Base Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Device Certification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Device Certification Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Device Certification Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|failed|not_tested');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `codec_audio_support` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec Support');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `codec_video_support` SET TAGS ('dbx_business_glossary_term' = 'Video Codec Support');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `dai_supported` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Supported');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `device_category` SET TAGS ('dbx_business_glossary_term' = 'Device Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `drm_fairplay_supported` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) FairPlay Supported');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `drm_playready_supported` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) PlayReady Supported');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `drm_widevine_level` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Widevine Security Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `drm_widevine_level` SET TAGS ('dbx_value_regex' = 'L1|L2|L3|not_supported');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `form_factor` SET TAGS ('dbx_business_glossary_term' = 'Device Form Factor');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `form_factor` SET TAGS ('dbx_value_regex' = 'handheld|television|desktop|wearable|embedded');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `hdr_capable` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Capable');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `hdr_format` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `input_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Input Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Device Type Active Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Device Manufacturer');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `max_bitrate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bitrate Megabits Per Second (Mbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Device Model Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Device Model Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `network_capability` SET TAGS ('dbx_business_glossary_term' = 'Network Capability');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `os_family` SET TAGS ('dbx_business_glossary_term' = 'Operating System (OS) Family');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `os_version_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Operating System (OS) Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `os_version_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating System (OS) Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `qos_tier` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `qos_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|basic');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `screen_resolution_class` SET TAGS ('dbx_business_glossary_term' = 'Screen Resolution Class');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `screen_resolution_class` SET TAGS ('dbx_value_regex' = 'sd|hd|full_hd|4k_uhd|8k_uhd');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `support_end_date` SET TAGS ('dbx_business_glossary_term' = 'Device Support End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `user_agent_string` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `user_agent_string` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `user_agent_string` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` SET TAGS ('dbx_subdomain' = 'platform_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Configuration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `failover_endpoint_streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Failover Endpoint Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `failover_endpoint_streaming_endpoint_id` SET TAGS ('dbx_self_ref_fk_reviewed' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Equipment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `bandwidth_limit_gbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Limit Gigabits Per Second (Gbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `cache_ttl_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cache Time To Live (TTL) Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `cost_per_gb` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Gigabyte (GB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `cost_per_gb` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deactivated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `drm_license_server_url` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) License Server URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `drm_license_server_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `drm_license_server_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_type` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_type` SET TAGS ('dbx_value_regex' = 'origin|edge|backup');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `geo_restriction_mode` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `geo_restriction_mode` SET TAGS ('dbx_value_regex' = 'whitelist|blacklist|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `geo_restriction_rules` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Rules');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Health Check Interval Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_business_glossary_term' = 'Health Check URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ipv6_enabled` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol Version 6 (IPv6) Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Health Check Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `manifest_format` SET TAGS ('dbx_business_glossary_term' = 'Manifest Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `manifest_format` SET TAGS ('dbx_value_regex' = 'm3u8|mpd|ism|f4m');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `max_bitrate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bitrate Megabits Per Second (Mbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|degraded|failed');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_business_glossary_term' = 'Provisioned Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Target Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ssl_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Secure Sockets Layer (SSL) Certificate Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'HLS|MPEG-DASH|RTMP|WebRTC|Smooth Streaming');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `supported_devices` SET TAGS ('dbx_business_glossary_term' = 'Supported Devices');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `token_authentication_scheme` SET TAGS ('dbx_business_glossary_term' = 'Token Authentication Scheme');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `token_authentication_scheme` SET TAGS ('dbx_value_regex' = 'JWT|HMAC|Akamai Token|AWS Signature|None');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` SET TAGS ('dbx_subdomain' = 'platform_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_business_glossary_term' = 'Playback Session ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `audience_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `closed_caption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'App Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `device_type_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `device_type_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `device_type_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `ad_breaks_served_count` SET TAGS ('dbx_business_glossary_term' = 'Ad Breaks Served Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `audio_language` SET TAGS ('dbx_business_glossary_term' = 'Audio Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `average_bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Average Bitrate (Kilobits Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `cdn_pop_location` SET TAGS ('dbx_business_glossary_term' = 'CDN (Content Delivery Network) PoP (Point of Presence) Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `closed_captions_enabled` SET TAGS ('dbx_business_glossary_term' = 'Closed Captions Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `content_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Content Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_business_glossary_term' = 'DAI (Dynamic Ad Insertion) Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `exit_reason` SET TAGS ('dbx_business_glossary_term' = 'Exit Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `exit_reason` SET TAGS ('dbx_value_regex' = 'user_stop|completion|error|timeout|network_failure|drm_failure');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `geographic_city` SET TAGS ('dbx_business_glossary_term' = 'Geographic City');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `geographic_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Postal Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `geographic_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `geographic_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `initial_buffering_duration_ms` SET TAGS ('dbx_business_glossary_term' = 'Initial Buffering Duration (Milliseconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `platform_type` SET TAGS ('dbx_value_regex' = 'web|mobile_ios|mobile_android|smart_tv|streaming_device|gaming_console');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_mode` SET TAGS ('dbx_business_glossary_term' = 'Playback Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_mode` SET TAGS ('dbx_value_regex' = 'live|vod|dvr|restart');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `rebuffering_events_count` SET TAGS ('dbx_business_glossary_term' = 'Rebuffering Events Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'hls|mpeg_dash|smooth_streaming');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subtitle_language` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `total_ad_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Ad Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `total_rebuffering_duration_ms` SET TAGS ('dbx_business_glossary_term' = 'Total Rebuffering Duration (Milliseconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `total_watch_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Watch Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Viewer IP (Internet Protocol) Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `abr_profile_support` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile Support');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `blackout_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Geographic Blackout Capability Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `carriage_capacity_channels` SET TAGS ('dbx_business_glossary_term' = 'Carriage Capacity in Channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `carriage_fee_model` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `carriage_fee_model` SET TAGS ('dbx_value_regex' = 'Per Subscriber|Flat Rate|Revenue Share|Hybrid|No Fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `carriage_fee_model` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Provider');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Contract End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `contract_renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Notice Period in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `contract_renewal_notice_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Contract Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `dai_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Support Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `drm_capability` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Capability');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `geographic_footprint` SET TAGS ('dbx_business_glossary_term' = 'Geographic Distribution Footprint');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `must_carry_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Must-Carry Obligation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `partner_tier` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `partner_tier` SET TAGS ('dbx_value_regex' = 'Tier 1|Tier 2|Tier 3|Strategic|Emerging');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'MVPD|vMVPD|OTT Platform|FAST Aggregator|Syndication Outlet|Cable Operator');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `portal_url` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Portal Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `qos_monitoring_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Monitoring Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Relationship Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Pending|Terminated|Under Negotiation');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `retransmission_consent_status` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `retransmission_consent_status` SET TAGS ('dbx_value_regex' = 'Granted|Denied|Pending|Not Applicable|Under Negotiation');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `sla_latency_target_ms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Latency Target in Milliseconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Target Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `subscriber_reach_estimate` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Reach Estimate');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `subscriber_reach_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `technical_delivery_standards` SET TAGS ('dbx_business_glossary_term' = 'Technical Delivery Standards Supported');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `public_inspection_file_id` SET TAGS ('dbx_business_glossary_term' = 'Public Inspection File Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|under_negotiation');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'retransmission_consent|must_carry|voluntary_carriage|platform_carriage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `blackout_provisions` SET TAGS ('dbx_business_glossary_term' = 'Blackout Provisions');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Structure');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_value_regex' = 'per_subscriber|flat_monthly|tiered|revenue_share|barter');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_number_assignment` SET TAGS ('dbx_business_glossary_term' = 'Channel Number Assignment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_positioning_tier` SET TAGS ('dbx_business_glossary_term' = 'Channel Positioning Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `compensation_terms` SET TAGS ('dbx_business_glossary_term' = 'Compensation Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `compensation_terms` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `compensation_terms` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_value_regex' = 'arbitration|mediation|litigation|negotiation');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `drm_requirements` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `exclusivity_window` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Window');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `holdback_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Holdback Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `minimum_subscriber_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Minimum Subscriber Guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `must_carry_election` SET TAGS ('dbx_business_glossary_term' = 'Must-Carry Election');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `negotiation_history` SET TAGS ('dbx_business_glossary_term' = 'Negotiation History');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `promotional_commitment` SET TAGS ('dbx_business_glossary_term' = 'Promotional Commitment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `retransmission_consent_granted` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent Granted');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_business_glossary_term' = 'Technical Delivery Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Configuration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `ad_insertion_method` SET TAGS ('dbx_business_glossary_term' = 'Ad Insertion Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `ad_insertion_method` SET TAGS ('dbx_value_regex' = 'server-side|client-side|dai|scte-35|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '4:3|16:9|21:9');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `audio_format` SET TAGS ('dbx_business_glossary_term' = 'Audio Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `audio_format` SET TAGS ('dbx_value_regex' = 'stereo|dolby-digital|dolby-atmos|dts|aac');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `blackout_rules_enabled` SET TAGS ('dbx_business_glossary_term' = 'Blackout Rules Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'linear|ott|fast|simulcast|vod|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `content_refresh_cadence` SET TAGS ('dbx_business_glossary_term' = 'Content Refresh Cadence');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `content_refresh_cadence` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|on-demand|continuous');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_business_glossary_term' = 'Delivery Technology Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `epg_source_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Program Guide (EPG) Source ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `fast_aggregator_platform` SET TAGS ('dbx_business_glossary_term' = 'Free Ad-Supported Streaming Television (FAST) Aggregator Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `fast_playlist_type` SET TAGS ('dbx_business_glossary_term' = 'Free Ad-Supported Streaming Television (FAST) Playlist Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `fast_playlist_type` SET TAGS ('dbx_value_regex' = 'linear-loop|scheduled|dynamic|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `genre_category` SET TAGS ('dbx_business_glossary_term' = 'Genre Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `max_bitrate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bitrate Megabits Per Second (Mbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `monetization_model` SET TAGS ('dbx_business_glossary_term' = 'Monetization Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `monetization_model` SET TAGS ('dbx_value_regex' = 'avod|svod|tvod|hybrid|free');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|testing|planned|retired');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `parental_control_rating` SET TAGS ('dbx_business_glossary_term' = 'Parental Control Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `parental_control_rating` SET TAGS ('dbx_value_regex' = 'tv-y|tv-y7|tv-g|tv-pg|tv-14|tv-ma');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `qos_tier` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `qos_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|basic');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `resolution_format` SET TAGS ('dbx_business_glossary_term' = 'Resolution Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `resolution_format` SET TAGS ('dbx_value_regex' = 'sd|hd|full-hd|4k-uhd|8k-uhd');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `retransmission_consent_required` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `sla_uptime_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `streaming_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `streaming_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_market` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `release_window_id` SET TAGS ('dbx_business_glossary_term' = 'Release Window Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Coppa Declaration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `ad_insertion_enabled` SET TAGS ('dbx_business_glossary_term' = 'Ad Insertion Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `ad_load_minutes` SET TAGS ('dbx_business_glossary_term' = 'Ad Load Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `audio_description_required` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `blackout_rules` SET TAGS ('dbx_business_glossary_term' = 'Blackout Rules');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `closed_caption_required` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `dubbing_languages` SET TAGS ('dbx_business_glossary_term' = 'Dubbing Languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiration Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `hdr_enabled` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `language_version` SET TAGS ('dbx_business_glossary_term' = 'Language Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `max_resolution` SET TAGS ('dbx_business_glossary_term' = 'Maximum Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `max_resolution` SET TAGS ('dbx_value_regex' = 'sd|hd|full_hd|4k|8k');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'subscription|transactional|advertising|free|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `rental_price` SET TAGS ('dbx_business_glossary_term' = 'Rental Price');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'hls|mpeg_dash|smooth_streaming|rtmp|progressive_download');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `window_close_date` SET TAGS ('dbx_business_glossary_term' = 'Window Close Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `window_code` SET TAGS ('dbx_business_glossary_term' = 'Window Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `window_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `window_open_date` SET TAGS ('dbx_business_glossary_term' = 'Window Open Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `window_priority` SET TAGS ('dbx_business_glossary_term' = 'Window Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `window_status` SET TAGS ('dbx_business_glossary_term' = 'Window Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `window_status` SET TAGS ('dbx_value_regex' = 'planned|active|closed|suspended|cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `window_type` SET TAGS ('dbx_business_glossary_term' = 'Window Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` SET TAGS ('dbx_subdomain' = 'content_fulfillment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_event_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Event ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `ad_billing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Billing Order Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `closed_caption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `device_type_id` SET TAGS ('dbx_business_glossary_term' = 'Device Type ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `eas_log_id` SET TAGS ('dbx_business_glossary_term' = 'Eas Log Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Equipment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_business_glossary_term' = 'Playback Session ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `political_ad_record_id` SET TAGS ('dbx_business_glossary_term' = 'Political Ad Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `ad_fill_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Ad Fill Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Bitrate (Kilobits Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `bytes_delivered` SET TAGS ('dbx_business_glossary_term' = 'Bytes Delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `cdn_cache_status` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Cache Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `cdn_cache_status` SET TAGS ('dbx_value_regex' = 'hit|miss|stale|bypass');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `cdn_node_code` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Node ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `cdn_pop_location` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Point of Presence (POP) Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'success|failure|degraded|partial');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_business_glossary_term' = 'Delivery Technology');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `drm_system` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) System');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `drm_system` SET TAGS ('dbx_value_regex' = 'widevine|playready|fairplay|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `network_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Network Latency (Milliseconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `origin_server_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Origin Server Response Time (Milliseconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `scte35_signal_type` SET TAGS ('dbx_business_glossary_term' = 'Society of Cable Telecommunications Engineers (SCTE) 35 Signal Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `session_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Session Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'hls|dash|smooth|rtmp|webrtc');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Viewer Internet Protocol (IP) Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` SET TAGS ('dbx_subdomain' = 'content_fulfillment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `channel_lineup_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Lineup Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Invoice Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `blackout_region_codes` SET TAGS ('dbx_business_glossary_term' = 'Blackout Region Codes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `blackout_rules_applicable` SET TAGS ('dbx_business_glossary_term' = 'Blackout Rules Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `carriage_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `carriage_fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `carriage_fee_per_subscriber` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Per Subscriber');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `carriage_fee_per_subscriber` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `carriage_type` SET TAGS ('dbx_business_glossary_term' = 'Carriage Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `carriage_type` SET TAGS ('dbx_value_regex' = 'must_carry|retransmission_consent|negotiated');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `channel_display_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Display Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `channel_position_number` SET TAGS ('dbx_business_glossary_term' = 'Channel Position Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `closed_caption_required` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `dvr_enabled` SET TAGS ('dbx_business_glossary_term' = 'Digital Video Recorder (DVR) Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `geographic_restriction_rules` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Rules');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `hd_available` SET TAGS ('dbx_business_glossary_term' = 'High Definition (HD) Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `lineup_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Lineup Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `lineup_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Lineup Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `lineup_status` SET TAGS ('dbx_business_glossary_term' = 'Channel Lineup Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `lineup_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `market_applicability` SET TAGS ('dbx_business_glossary_term' = 'Market Applicability');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `market_applicability` SET TAGS ('dbx_value_regex' = 'national|regional|local|dma_specific');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lineup Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `parental_control_rating` SET TAGS ('dbx_business_glossary_term' = 'Parental Control Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `promotional_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotional End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `service_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `service_tier` SET TAGS ('dbx_value_regex' = 'standard|enhanced|premium|ultra');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `subscriber_count_estimate` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Count Estimate');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `subscriber_count_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `tier_type` SET TAGS ('dbx_business_glossary_term' = 'Tier Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `uhd_4k_available` SET TAGS ('dbx_business_glossary_term' = 'Ultra High Definition (UHD) 4K Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `vod_enabled` SET TAGS ('dbx_business_glossary_term' = 'Video On Demand (VOD) Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` SET TAGS ('dbx_subdomain' = 'content_fulfillment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Source Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `content_scope` SET TAGS ('dbx_business_glossary_term' = 'Content Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_business_glossary_term' = 'Deal Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_business_glossary_term' = 'Deal Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'SVOD licensing|AVOD revenue share|FAST syndication|linear carriage|TVOD licensing|international distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_value_regex' = 'arbitration|mediation|litigation|negotiation');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `drm_requirements` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `exclusivity_window_days` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Window Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `minimum_subscriber_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Minimum Subscriber Guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_name` SET TAGS ('dbx_business_glossary_term' = 'Deal Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `negotiation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `promotional_commitment` SET TAGS ('dbx_business_glossary_term' = 'Promotional Commitment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annually|annually|on-demand');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `revenue_model` SET TAGS ('dbx_business_glossary_term' = 'Revenue Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `revenue_model` SET TAGS ('dbx_value_regex' = 'flat fee|revenue share|minimum guarantee|hybrid|cost per stream|cost per subscriber');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|basic');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_business_glossary_term' = 'Technical Delivery Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `term_months` SET TAGS ('dbx_business_glossary_term' = 'Term Months');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `territory` SET TAGS ('dbx_business_glossary_term' = 'Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` SET TAGS ('dbx_subdomain' = 'content_fulfillment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `content_delivery_order_id` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Order Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Program Schedule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `release_window_id` SET TAGS ('dbx_business_glossary_term' = 'Release Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_business_glossary_term' = 'Audio Configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_value_regex' = 'stereo|surround_5_1|surround_7_1|dolby_atmos|dts_x');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `audio_languages` SET TAGS ('dbx_business_glossary_term' = 'Audio Languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `closed_captions_included` SET TAGS ('dbx_business_glossary_term' = 'Closed Captions Included Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `content_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Content Duration in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_deadline_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Deadline Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Delivery Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'cdn_push|ftp|aspera|satellite_uplink|physical_media|api');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `delivery_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `estimated_delivery_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Duration in Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `file_size_gb` SET TAGS ('dbx_business_glossary_term' = 'File Size in Gigabytes (GB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `fulfillment_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Confirmation Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `geographic_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `hdr_format` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `hdr_format` SET TAGS ('dbx_value_regex' = 'sdr|hdr10|hdr10_plus|dolby_vision|hlg');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Order Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^CDO-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'new_release|refresh|replacement|emergency|scheduled|on_demand');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `transcode_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Transcode Profile Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `video_resolution` SET TAGS ('dbx_value_regex' = 'sd|hd_720p|hd_1080p|uhd_4k|uhd_8k');
