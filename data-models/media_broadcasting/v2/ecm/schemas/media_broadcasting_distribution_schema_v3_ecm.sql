-- Schema for Domain: distribution | Business:  | Version: v3_ecm
-- Generated on: 2026-07-10 19:30:36

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`distribution` COMMENT 'Governs multi-platform content delivery across linear broadcast (DVB, ATSC, QAM), OTT streaming (HLS, MPEG-DASH, ABR), MVPD/vMVPD carriage, FAST channel syndication, and OTT platform infrastructure. Manages CDN configuration, DRM enforcement, DAI, streaming endpoints, ABR profiles, device support, QoS monitoring, and all delivery SLAs.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` (
    `ott_platform_id` BIGINT COMMENT 'Unique surrogate identifier for each OTT service platform record in the master registry. Primary key for the ott_platform entity — all downstream distribution products reference this key.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: OTT platforms have platform-wide accessibility obligations (UI accessibility, player controls, caption support). Compliance tracking and regulatory reporting require linking platforms to their specifi',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: OTT platforms originate from broadcast facilities housing master control and encoding infrastructure. Critical for NOC escalation routing, facility maintenance impact assessment, and disaster recovery',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: OTT platforms are distinct cost centers for P&L reporting and budget allocation. Monthly financial close allocates platform operating expenses (content, technology, marketing) to specific cost centers',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: OTT platforms require operational ownership for launch management, SLA compliance monitoring, sunset decisions, and incident escalation. Platform managers are accountable for subscriber growth, ARPU t',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: OTT platforms are profit centers for revenue tracking and margin analysis. Quarterly earnings reports break out revenue, costs, and EBITDA by platform/service for investor reporting and segment perfor',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Platform launches, service tier changes, and privacy policy updates trigger regulatory filings (FCC, FTC, state regulators). Platform lifecycle events generate compliance obligations requiring filing ',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: OTT platforms operate in specific territories with distinct regulatory, content rating, and rights enforcement requirements. Replaces geographic_availability text with structured territory reference. ',
    `tech_project_id` BIGINT COMMENT 'Foreign key linking to technology.tech_project. Business justification: OTT platforms are launched via technology projects. Required for platform launch project tracking and capex budget allocation.',
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
    `secondary_streaming_protocol` STRING COMMENT 'Fallback or secondary adaptive bitrate streaming protocol supported by the platform for device compatibility or redundancy. Null or NONE if only one protocol is used. Supports multi-protocol CDN origin configuration in Akamai.. Valid values are `HLS|MPEG-DASH|RTMP|SRT|NONE`',
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
    `broadcast_standard_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_standard. Business justification: Device types support specific broadcast standards (ATSC 3.0, DVB-T2). Required for device certification and broadcast standard support matrix.',
    `maintenance_work_order_id` BIGINT COMMENT 'Foreign key linking to technology.maintenance_work_order. Business justification: Device types require maintenance tracking for firmware updates and recalls. Required for device firmware update campaigns and recall management.',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` (
    `app_version_id` BIGINT COMMENT 'Unique identifier for each application version release. Primary key for the app_version product.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Each app version must demonstrate compliance with accessibility standards. Version-specific accessibility features (screen reader support, caption rendering) are validated against applicable obligatio',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Each app version is built for a specific OTT platform. app_version.platform is STRING but should FK to ott_platform master. Removes platform_type (derivable from ott_platform.platform_code).',
    `employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - app versions need a release manager for accountability',
    `ab_test_cohort` STRING COMMENT 'Identifier for the A/B test cohort or experiment group assigned to this application version. Used for controlled feature testing and user experience optimization.',
    `active_install_count` BIGINT COMMENT 'The current number of active installations of this application version across all users. Used for version adoption tracking and deprecation planning.',
    `analytics_sdk_version` STRING COMMENT 'Version of the analytics SDK integrated for tracking user engagement, viewership metrics, and QoS (Quality of Service) data.',
    `app_size_mb` DECIMAL(18,2) COMMENT 'The total download size of the application package in megabytes. Important for user download experience and app store requirements.',
    `build_number` STRING COMMENT 'Internal build identifier assigned by the continuous integration system. Used for precise version tracking and debugging. May be numeric or alphanumeric.',
    `ccpa_compliant` BOOLEAN COMMENT 'Indicates whether this application version meets CCPA (California Consumer Privacy Act) requirements for viewer data privacy in California.',
    `cdn_endpoint_url` STRING COMMENT 'The primary CDN (Content Delivery Network) endpoint URL configured for this application version. Determines content delivery infrastructure and streaming performance.',
    `closed_caption_support` BOOLEAN COMMENT 'Indicates whether this application version supports closed captioning and subtitles for accessibility compliance.',
    `crash_reporting_enabled` BOOLEAN COMMENT 'Indicates whether automated crash reporting and error tracking is enabled for this application version. Critical for QoS root-cause analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this application version record was first created in the system. Used for audit trail and version history tracking.',
    `dai_enabled` BOOLEAN COMMENT 'Indicates whether this application version supports DAI (Dynamic Ad Insertion) for server-side ad stitching in streaming content.',
    `dash_support_enabled` BOOLEAN COMMENT 'Indicates whether this application version supports MPEG-DASH (Dynamic Adaptive Streaming over HTTP) protocol for video streaming.',
    `deprecation_date` DATE COMMENT 'The date when this application version will be officially deprecated and no longer supported. Nullable for current production versions.',
    `dolby_atmos_enabled` BOOLEAN COMMENT 'Indicates whether this application version supports Dolby Atmos immersive audio technology.',
    `drm_library_version` STRING COMMENT 'Version of the DRM (Digital Rights Management) library integrated into this application build. Critical for content protection and license enforcement compliance.',
    `feature_flags` STRING COMMENT 'Comma-separated list or JSON string of feature flags enabled in this application version. Controls experimental features, A/B test variants, and gradual rollout capabilities.',
    `force_upgrade_threshold` STRING COMMENT 'The minimum application version number below which users will be forced to upgrade. Used to enforce critical security patches or deprecate incompatible versions.',
    `gdpr_compliant` BOOLEAN COMMENT 'Indicates whether this application version meets GDPR (General Data Protection Regulation) requirements for user data privacy and consent management in EU markets.',
    `hdr_support_enabled` BOOLEAN COMMENT 'Indicates whether this application version supports HDR (High Dynamic Range) video playback for enhanced picture quality.',
    `hls_support_enabled` BOOLEAN COMMENT 'Indicates whether this application version supports HLS (HTTP Live Streaming) protocol for adaptive bitrate video delivery.',
    `internal_notes` STRING COMMENT 'Internal technical notes and documentation for this application version. Includes deployment instructions, known issues, and rollback procedures.',
    `max_bitrate_mbps` DECIMAL(18,2) COMMENT 'The maximum streaming bitrate supported by this application version in Mbps. Determines highest video quality available through ABR (Adaptive Bitrate Streaming).',
    `minimum_os_version` STRING COMMENT 'The minimum operating system version required to run this application version. Format varies by platform (e.g., iOS 14.0, Android 10, Roku OS 9.4).',
    `offline_playback_enabled` BOOLEAN COMMENT 'Indicates whether this application version supports offline content download and playback for SVOD (Subscription Video On Demand) users.',
    `parental_control_enabled` BOOLEAN COMMENT 'Indicates whether this application version includes parental control features for content rating enforcement and child safety.',
    `platform` STRING COMMENT 'The OTT (Over-The-Top) platform or operating system for which this application version was built. Determines device compatibility and distribution channel. [ENUM-REF-CANDIDATE: iOS|Android|tvOS|Roku|Fire TV|Samsung Tizen|LG webOS|Xbox|PlayStation|Web — 10 candidates stripped; promote to reference product]',
    `player_sdk_version` STRING COMMENT 'Version of the video player SDK embedded in this application. Determines streaming capabilities, ABR (Adaptive Bitrate Streaming) support, and playback features.',
    `release_date` DATE COMMENT 'The date when this application version was officially released to production and made available to end users through app stores or distribution channels.',
    `release_notes` STRING COMMENT 'User-facing description of new features, bug fixes, and improvements included in this application version. Published in app stores and update notifications.',
    `release_status` STRING COMMENT 'Current lifecycle status of the application version. Tracks progression from development through production release to eventual deprecation. [ENUM-REF-CANDIDATE: development|alpha|beta|release_candidate|released|deprecated|withdrawn — 7 candidates stripped; promote to reference product]',
    `rollout_percentage` DECIMAL(18,2) COMMENT 'The percentage of users to whom this application version is currently deployed. Used for gradual rollout and canary deployment strategies (0.00 to 100.00).',
    `supported_resolutions` STRING COMMENT 'Comma-separated list of video resolutions supported by this application version (e.g., 480p, 720p, 1080p, 4K). Determines playback quality options.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this application version record was last modified. Tracks changes to version metadata, status updates, and configuration changes.',
    `version_number` STRING COMMENT 'Semantic version number of the application release following major.minor.patch format (e.g., 3.2.1, 4.0.0-beta). This is the externally-known identifier for the release.. Valid values are `^d+.d+.d+(.[w-]+)?$`',
    CONSTRAINT pk_app_version PRIMARY KEY(`app_version_id`)
) COMMENT 'Tracks all released and in-flight versions of the Media Broadcasting OTT client applications across platforms (iOS, Android, tvOS, Roku, Fire TV, Samsung Tizen, LG webOS, Xbox, PlayStation). Captures app version number, platform target, release date, minimum OS version, feature flags enabled, DRM library version, player SDK version, A/B test cohort assignments, force-upgrade threshold, and deprecation date. Critical for QoS root-cause analysis and rollout management.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` (
    `streaming_endpoint_id` BIGINT COMMENT 'Unique identifier for the streaming endpoint. Primary key for the streaming endpoint master record.',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: Streaming endpoints use specific ABR profiles. streaming_endpoint.abr_profile_reference is STRING but should FK to abr_profile master. Removes abr_profile_reference STRING.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Streaming endpoints must meet accessibility standards (WCAG, CVAA). Each endpoints technical capabilities (caption support, audio description) are validated against applicable accessibility obligatio',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Streaming endpoints are physically hosted in broadcast facilities. Required for facility outage impact analysis, power/cooling capacity planning, and physical security management.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Streaming endpoints delivering broadcast content must comply with originating broadcast license terms for geographic restrictions, transmission standards, and regulatory reporting. License governs end',
    `cdn_configuration_id` BIGINT COMMENT 'Foreign key linking to distribution.cdn_configuration. Business justification: Streaming endpoints use specific CDN configurations. streaming_endpoint.cdn_provider is STRING but should FK to cdn_configuration. Removes cdn_provider STRING.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Streaming endpoints incur CDN and hosting costs that must be allocated to technology cost centers for chargeback and budget management. Monthly CDN invoice reconciliation allocates bandwidth and compu',
    `dai_configuration_id` BIGINT COMMENT 'Foreign key linking to distribution.dai_configuration. Business justification: Streaming endpoints can have default DAI configurations. Removes dai_provider STRING (derivable from dai_configuration).',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Streaming endpoints enforce specific DRM policies. streaming_endpoint.drm_system is STRING but should FK to drm_policy. Removes drm_system STRING (derivable from drm_policy.drm_system).',
    `encoder_config_id` BIGINT COMMENT 'Foreign key linking to technology.encoder_config. Business justification: Streaming endpoints receive feeds from encoder configurations. Required for encoder-endpoint signal routing and configuration management.',
    `failover_endpoint_id` BIGINT COMMENT 'Reference to the backup streaming endpoint that should be used if this endpoint becomes unavailable. Supports high availability and disaster recovery.',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: CDN endpoints serve specific DMAs for geo-restriction enforcement, local ad insertion, and market-specific content delivery. Required for retransmission consent compliance and must-carry obligations i',
    `network_circuit_id` BIGINT COMMENT 'Foreign key linking to technology.network_circuit. Business justification: Streaming endpoints rely on network circuits for connectivity. Required for circuit capacity planning and endpoint failover configuration.',
    `noc_monitor_id` BIGINT COMMENT 'Foreign key linking to technology.noc_monitor. Business justification: Streaming endpoints have assigned NOC monitors tracking uptime and latency. Required for NOC monitoring configuration and alert routing.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Streaming endpoints are provisioned for specific OTT platforms. Each endpoint serves content for a platform. No visible platform_type column but relationship is essential for endpoint management.',
    `outage_record_id` BIGINT COMMENT 'Foreign key linking to technology.outage_record. Business justification: Streaming endpoints experience outages requiring tracking. Required for endpoint availability reporting and outage pattern analysis.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Streaming endpoint provisioning and technical changes may trigger regulatory filings (new service launch notifications, technical standard certifications). Endpoint lifecycle events generate filing re',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Streaming endpoints serve specific geographic territories. Essential for enforcing geo-restriction rules per rights grants, validating territory-based rights compliance, and routing playback sessions ',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to distribution.sla_definition. Business justification: Streaming endpoints have SLA commitments. streaming_endpoint.sla_tier is STRING but should FK to sla_definition. Removes sla_tier STRING (derivable from sla_definition.sla_tier).',
    `software_license_id` BIGINT COMMENT 'Foreign key linking to technology.software_license. Business justification: Streaming endpoints run licensed CDN and DRM software. Required for software license compliance tracking and endpoint cost allocation.',
    `tech_project_id` BIGINT COMMENT 'Foreign key linking to technology.tech_project. Business justification: Streaming endpoints are deployed via CDN expansion projects. Required for CDN project ROI analysis and endpoint deployment timeline tracking.',
    `tech_sla_id` BIGINT COMMENT 'Foreign key linking to technology.tech_sla. Business justification: Streaming endpoints have technology SLAs for uptime and latency. Required for endpoint SLA compliance reporting and performance benchmarking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Streaming endpoints are critical infrastructure requiring technical ownership for incident response, maintenance windows, configuration changes, and failover testing. Essential for on-call rotations, ',
    `technical_standard_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.technical_standard_cert. Business justification: Streaming endpoints must be certified against technical standards (HLS spec, DASH spec, DRM robustness, accessibility). Each endpoint references its certification records for compliance validation.',
    `transmission_equipment_id` BIGINT COMMENT 'Foreign key linking to technology.transmission_equipment. Business justification: Streaming endpoints rely on transmission equipment (encoders, transcoders). Required for equipment failure impact analysis and encoder capacity management.',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` (
    `abr_profile_id` BIGINT COMMENT 'Unique identifier for the ABR encoding ladder profile. Primary key.',
    `broadcast_standard_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_standard. Business justification: ABR profiles implement broadcast standards (HLS, DASH). Required for broadcast standard compliance verification and device interoperability testing.',
    `encoder_config_id` BIGINT COMMENT 'Foreign key linking to technology.encoder_config. Business justification: ABR profiles are generated by encoder configurations. Required for encoder profile assignment and video quality troubleshooting.',
    `format_specification_id` BIGINT COMMENT 'Foreign key linking to mediaasset.format_specification. Business justification: ABR profiles implement technical delivery standards (codec, bitrate ladder, resolution tiers) defined in format specifications. Broadcasters validate ABR configs against house specs for compliance. Qo',
    `technical_standard_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.technical_standard_cert. Business justification: ABR profiles must comply with codec standards, streaming protocol specifications, and accessibility requirements. Profile certification validates compliance with technical standards before deployment.',
    `audio_bitrate_kbps` STRING COMMENT 'Audio bitrate in kilobits per second (e.g., 128, 192, 256). Defines audio quality.',
    `audio_channel_config` STRING COMMENT 'Audio channel layout (mono, stereo, 5.1 surround, 7.1 surround, Dolby Atmos). Defines spatial audio configuration.. Valid values are `mono|stereo|5.1|7.1|Atmos`',
    `audio_codec` STRING COMMENT 'Audio codec used for encoding (AAC, HE-AAC, AC-3/Dolby Digital, E-AC-3/Dolby Digital Plus, Opus).. Valid values are `AAC|HE-AAC|AC-3|E-AC-3|Opus`',
    `cdn_optimization_flag` BOOLEAN COMMENT 'Indicates whether the profile is optimized for CDN delivery with caching-friendly segment naming and structure. True if CDN-optimized; false otherwise.',
    `color_space` STRING COMMENT 'Color space standard used for encoding (BT.709 for HD, BT.2020 for UHD/HDR, DCI-P3 for cinema).. Valid values are `BT.709|BT.2020|DCI-P3`',
    `container_format` STRING COMMENT 'Media container format for the encoded segments (fMP4 for DASH, TS for HLS, MP4, WebM). Defines how video and audio streams are packaged.. Valid values are `fMP4|TS|MP4|WebM`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ABR profile record was first created in the system.',
    `drm_support_flag` BOOLEAN COMMENT 'Indicates whether the profile supports DRM encryption. True if DRM is enabled; false otherwise.',
    `drm_system` STRING COMMENT 'DRM system(s) supported by this profile (Widevine, PlayReady, FairPlay Streaming, Multi-DRM). Null if DRM is not enabled.. Valid values are `Widevine|PlayReady|FairPlay|Multi-DRM`',
    `effective_date` DATE COMMENT 'Date when the ABR profile became active and available for use in production encoding workflows.',
    `encoding_preset` STRING COMMENT 'Encoder speed/quality preset (fast, medium, slow, veryslow). Slower presets yield better compression but require more processing time.. Valid values are `fast|medium|slow|veryslow`',
    `expiration_date` DATE COMMENT 'Date when the ABR profile is scheduled to be deprecated or retired. Null for profiles with no planned end date.',
    `frame_rate` DECIMAL(18,2) COMMENT 'Target frame rate for video renditions (e.g., 23.976, 25, 29.97, 30, 50, 59.94, 60). May vary by rendition.',
    `hdr_format` STRING COMMENT 'Specific HDR format supported (HDR10, HDR10+, Dolby Vision, HLG). Null if HDR is not supported.. Valid values are `HDR10|HDR10+|Dolby Vision|HLG`',
    `hdr_support_flag` BOOLEAN COMMENT 'Indicates whether the profile supports HDR (High Dynamic Range) video. True if HDR is enabled; false for SDR (Standard Dynamic Range) only.',
    `keyframe_interval_seconds` STRING COMMENT 'Interval between keyframes (I-frames) in seconds. Aligns with segment duration for seamless ABR switching.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the ABR profile record was last updated or modified.',
    `manifest_template_reference` STRING COMMENT 'Reference to the MPEG-DASH MPD or HLS M3U8 manifest template used for this profile. Defines playlist structure and metadata.',
    `max_bitrate_kbps` STRING COMMENT 'Highest video bitrate in kilobits per second across all renditions in the ladder. Used for high-quality streaming on fast connections.',
    `max_resolution` STRING COMMENT 'Highest video resolution in the ladder (e.g., 1920x1080, 3840x2160). Defines the top quality tier.',
    `min_bitrate_kbps` STRING COMMENT 'Lowest video bitrate in kilobits per second across all renditions in the ladder. Used for low-bandwidth scenarios.',
    `min_resolution` STRING COMMENT 'Lowest video resolution in the ladder (e.g., 320x180, 640x360). Typically used for mobile or constrained bandwidth.',
    `owner_team` STRING COMMENT 'Name of the engineering or operations team responsible for maintaining and updating this ABR profile.',
    `profile_code` STRING COMMENT 'Unique business identifier code for the ABR profile used in transcode job requests and CDN configuration.',
    `profile_description` STRING COMMENT 'Detailed description of the ABR profile, including use cases, target audience, and technical notes.',
    `profile_name` STRING COMMENT 'Human-readable name of the ABR profile (e.g., Premium 4K HDR, Standard HD, Mobile Optimized).',
    `profile_status` STRING COMMENT 'Current lifecycle status of the ABR profile. Active profiles are used in production encoding; deprecated profiles are phased out; testing profiles are under validation; inactive profiles are disabled.. Valid values are `active|deprecated|testing|inactive`',
    `qos_tier` STRING COMMENT 'Quality of Service tier associated with this profile (premium, standard, basic). Influences CDN priority and SLA commitments.. Valid values are `premium|standard|basic`',
    `rendition_count` STRING COMMENT 'Total number of video renditions (bitrate/resolution variants) in the ABR ladder. Typical range is 3-10 renditions.',
    `segment_duration_seconds` STRING COMMENT 'Duration of each media segment in seconds (e.g., 2, 4, 6, 10). Shorter segments enable faster ABR switching but increase overhead.',
    `streaming_protocol` STRING COMMENT 'Adaptive bitrate streaming protocol supported by this profile (HLS, MPEG-DASH, CMAF, Smooth Streaming).. Valid values are `HLS|MPEG-DASH|CMAF|Smooth Streaming`',
    `target_device_class` STRING COMMENT 'Primary device class this profile is optimized for (mobile, tablet, desktop, smart TV, set-top box, gaming console). Influences resolution and bitrate choices.. Valid values are `mobile|tablet|desktop|smart_tv|set_top_box|gaming_console`',
    `version_number` STRING COMMENT 'Version number of the ABR profile. Incremented with each significant change to the encoding ladder or configuration.',
    `video_codec` STRING COMMENT 'Primary video codec used for encoding (H.264/AVC, H.265/HEVC, AV1, VP9). Determines compression efficiency and device compatibility.. Valid values are `H.264|H.265|HEVC|AV1|VP9`',
    CONSTRAINT pk_abr_profile PRIMARY KEY(`abr_profile_id`)
) COMMENT 'Defines Adaptive Bitrate (ABR) encoding ladder profiles used for multi-platform streaming delivery. Captures profile name, codec (H.264, H.265/HEVC, AV1, VP9), container format (fMP4, TS), rendition count, per-rendition bitrate/resolution/frame-rate specifications, audio codec and channel configuration, HDR/SDR flag, MPEG-DASH or HLS manifest template reference, and target device class. Governs the encoding farm (transcode) output specifications.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` (
    `playback_session_id` BIGINT COMMENT 'Unique identifier for each individual viewer playback session initiated on the OTT (Over-The-Top) platform. Primary key for the playback session record.',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: Playback sessions should FK to abr_profile master to track which ABR profile was used. Removes abr_profile STRING (derivable from abr_profile.profile_code).',
    `app_version_id` BIGINT COMMENT 'Foreign key linking to distribution.app_version. Business justification: Playback sessions should FK to app_version master for version tracking and analytics. Removes app_version STRING (derivable from app_version.version_number).',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Playback sessions trace to originating facilities for root cause analysis of QoS issues. Essential for facility performance benchmarking and distributed CDN troubleshooting.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: When playback sessions include ad delivery (dai_enabled), linking to campaign enables campaign reach/frequency measurement, content-adjacency analysis, and cross-domain attribution. Critical for measu [FK namespace reconciled: points to sales.campaign]',
    `closed_caption_record_id` BIGINT COMMENT 'Foreign key linking to compliance.closed_caption_record. Business justification: Individual playback sessions generate closed caption quality metrics (accuracy, synchronization, latency). Session-level caption performance data feeds FCC compliance reporting and quality assurance.',
    `compliance_consent_record_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_record. Business justification: Playback sessions collect viewing data subject to consent (analytics, personalization, third-party sharing). Session initialization validates consent status before data collection begins.',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Every playback session must enforce content rating restrictions for parental controls, age-gating, and COPPA compliance. Real-time rating validation during session initialization is standard practice.',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Nielsen C3/C7 ratings, GRP/TRP calculation, and programmatic ad targeting require demographic classification of every playback session. Essential for audience guarantee reconciliation and upfront comm',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Playback sessions should FK to drm_policy master to track which DRM policy was applied. Removes drm_policy_applied STRING (derivable from drm_policy.policy_code).',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Playback sessions consume content under specific rights grants. Essential for per-stream royalty calculation, usage reporting to rights holders, and rights compliance verification. Media broadcasting ',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: DMA attribution is mandatory for Nielsen ratings, local ad insertion, blackout enforcement, and retransmission consent compliance. Every streaming session must be assigned to a market for regulatory a',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset being played in this session. Links to the digital asset management system for content metadata and rights verification.',
    `device_type_id` BIGINT COMMENT 'Reference to the device used for this playback session. Enables device-level analytics and QoS (Quality of Service) monitoring.',
    `playback_device_type_id` BIGINT COMMENT 'Foreign key linking to distribution.device_type. Business justification: Playback sessions should FK to device_type master for accurate device tracking. Removes device_type STRING (derivable from device_type.device_category).',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Playback sessions on ad-supported platforms generate advertising revenue that must be recognized. Monthly ad revenue reconciliation aggregates sessions by revenue stream for accrual accounting and rev',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Playback sessions occur in specific territories. Essential for territory-based royalty calculation, rights compliance verification, and exploitation reporting to rights holders. Replaces geographic_co',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: Playback sessions should FK to streaming_endpoint master to track which endpoint served the session. Removes streaming_endpoint_url STRING (derivable from streaming_endpoint.endpoint_url).',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who initiated this playback session. Links to the subscriber master record for audience measurement and personalization.',
    `device_device_type_id` BIGINT COMMENT '',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` (
    `qos_event_id` BIGINT COMMENT 'Unique identifier for the QoS event record. Primary key.',
    `closed_caption_record_id` BIGINT COMMENT 'Foreign key linking to compliance.closed_caption_record. Business justification: QoS events capture caption-specific failures (caption dropout, synchronization errors, rendering issues). These events are linked to caption compliance records for remediation tracking and regulatory ',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: QoE analysis by demographic segment identifies service quality disparities, drives platform optimization for key demos, and supports Nielsen commercial ratings validation. Critical for audience guaran',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: Market-level QoS monitoring supports DMA-specific SLA compliance, identifies regional CDN performance issues, and enables market-based service optimization for distribution partners and Nielsen measur',
    `noc_alert_id` BIGINT COMMENT 'Foreign key linking to technology.noc_alert. Business justification: QoS events are generated in response to NOC alerts. Required for event correlation analysis and root cause determination.',
    `playback_session_id` BIGINT COMMENT 'Reference to the parent playback session during which this QoS event occurred. Links to the session-level summary record.',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: QoS events should reference the streaming endpoint for performance tracking. Removes cdn_edge_node STRING (derivable from streaming_endpoint.pop_region).',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Live talent-driven programming (sports commentary, news anchors, talk shows) requires quality monitoring tied to specific talent for SLA compliance and performance evaluation. Broadcasters track techn',
    `title_id` BIGINT COMMENT 'Unique identifier of the content asset being played during this event. Links to the content catalog for asset-level QoS analysis.',
    `transmission_equipment_id` BIGINT COMMENT 'Foreign key linking to technology.transmission_equipment. Business justification: QoS events trace to specific transmission equipment failures. Critical for NOC rapid incident resolution and equipment health monitoring.',
    `ad_pod_duration_seconds` STRING COMMENT 'Total duration of the ad pod in seconds when event_type is ad_pod_insertion. Null for other event types.',
    `ad_pod_position` STRING COMMENT 'Position of the ad pod within the content stream when event_type is ad_pod_insertion. Null for other event types. Used for DAI analysis.',
    `bitrate_kbps` STRING COMMENT 'Current streaming bitrate in kilobits per second at the time of the event. Reflects the ABR profile tier active during this event.',
    `buffer_level_seconds` DECIMAL(18,2) COMMENT 'Amount of video content buffered in the player at the time of the event, measured in seconds. Indicates playback health and risk of stalling.',
    `cdn_cache_status` STRING COMMENT 'CDN cache status for the content segment at the time of the event: hit (served from cache), miss (fetched from origin), stale (expired cache), bypass (cache bypassed).. Valid values are `hit|miss|stale|bypass`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this QoS event record was created in the data platform, in format yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for data lineage and audit purposes.',
    `device_type` STRING COMMENT 'Type of device on which the playback event occurred: smart TV, mobile phone, tablet, desktop, set-top box, gaming console, etc.',
    `download_throughput_kbps` STRING COMMENT 'Measured download throughput in kilobits per second at the time of the event. Used by ABR algorithms to determine optimal bitrate.',
    `drm_system` STRING COMMENT 'DRM system protecting the content stream: Widevine, FairPlay, PlayReady, or None for unprotected content.. Valid values are `Widevine|FairPlay|PlayReady|None`',
    `dropped_frames_count` STRING COMMENT 'Number of video frames dropped by the player at the time of the event. Indicates rendering performance issues.',
    `error_code` STRING COMMENT 'Specific error code returned by the player or CDN when event_type is error. Null for non-error events. Used for detailed troubleshooting and root-cause analysis.',
    `error_message` STRING COMMENT 'Human-readable error message describing the failure when event_type is error. Null for non-error events.',
    `event_severity` STRING COMMENT 'Severity level of the QoS event indicating impact on user experience: critical (playback failure), high (significant degradation), medium (noticeable impact), low (minor impact), info (informational only).. Valid values are `critical|high|medium|low|info`',
    `event_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the QoS event occurred during playback, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `event_type` STRING COMMENT 'Type of QoS event captured: buffering start/end, bitrate switch (up/down), error code, stall event, seek event, ad pod insertion signal, or heartbeat. [ENUM-REF-CANDIDATE: buffering_start|buffering_end|bitrate_switch_up|bitrate_switch_down|error|stall|seek|ad_pod_insertion|heartbeat — 9 candidates stripped; promote to reference product]',
    `geographic_region` STRING COMMENT 'Geographic region or market where the viewer is located at the time of the event. Used for regional QoS analysis and CDN optimization.',
    `isp_name` STRING COMMENT 'Name of the Internet Service Provider through which the viewer is connected. Used for ISP-level QoS analysis and peering optimization.',
    `network_latency_ms` STRING COMMENT 'Network round-trip latency in milliseconds measured at the time of the event. Indicates network performance and potential delivery issues.',
    `new_bitrate_kbps` STRING COMMENT 'Bitrate in kilobits per second after a bitrate switch event. Populated when event_type is bitrate_switch_up or bitrate_switch_down. Null for other event types.',
    `origin_server_response_time_ms` STRING COMMENT 'Response time in milliseconds from the origin server when CDN cache status is miss. Null for cache hits. Indicates origin performance.',
    `playback_position_seconds` DECIMAL(18,2) COMMENT 'Current playback position in seconds within the content at the time of the event. Used to correlate events with specific content segments.',
    `player_state` STRING COMMENT 'State of the video player at the time of the event: playing, paused, buffering, seeking, idle, or error.. Valid values are `playing|paused|buffering|seeking|idle|error`',
    `player_version` STRING COMMENT 'Version identifier of the video player software that generated this QoS event. Used for player-specific issue analysis.',
    `previous_bitrate_kbps` STRING COMMENT 'Bitrate in kilobits per second before a bitrate switch event. Populated when event_type is bitrate_switch_up or bitrate_switch_down. Null for other event types.',
    `seek_position_seconds` DECIMAL(18,2) COMMENT 'Playback position in seconds to which the user seeked. Populated when event_type is seek. Null for other event types.',
    `session_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the parent playback session started, in format yyyy-MM-ddTHH:mm:ss.SSSXXX. Provides temporal context for event sequencing.',
    `stall_duration_ms` STRING COMMENT 'Duration of the playback stall or buffering event in milliseconds. Populated when event_type is buffering_start, buffering_end, or stall. Null for other event types.',
    `streaming_protocol` STRING COMMENT 'Streaming protocol used for content delivery: HLS (HTTP Live Streaming), MPEG-DASH (Dynamic Adaptive Streaming over HTTP), RTMP, WebRTC, or Smooth Streaming.. Valid values are `HLS|MPEG-DASH|RTMP|WebRTC|Smooth Streaming`',
    `user_agent` STRING COMMENT 'User agent string of the viewer device and browser/app at the time of the event. Used for device and platform-specific issue analysis.',
    `viewer_ip_address` STRING COMMENT 'IP address of the viewer device at the time of the event. Used for network-level troubleshooting and geographic analysis. May be considered PII in some jurisdictions.',
    CONSTRAINT pk_qos_event PRIMARY KEY(`qos_event_id`)
) COMMENT 'Granular Quality of Service (QoS) telemetry events captured during playback sessions — distinct from the session-level summary in playback_session. Each record captures a specific QoS signal: buffering start/end, bitrate switch (up/down), error code, stall event, seek event, ad pod insertion signal, or heartbeat. Includes timestamp, session reference, event type, severity, bitrate at event time, buffer level, CDN edge node, and player state. Enables root-cause analysis of streaming quality degradation.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` (
    `sla_definition_id` BIGINT COMMENT 'Unique identifier for the SLA definition record. Primary key.',
    `employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - SLA definitions need an accountable owner for governance',
    `applicable_platform` STRING COMMENT 'The OTT platform, CDN, or service to which this SLA applies (e.g., OTT Web Platform, Mobile App, Akamai CDN, All Platforms).',
    `approval_status` STRING COMMENT 'The approval state of the SLA definition (pending, approved, rejected).. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this SLA definition.',
    `approved_date` DATE COMMENT 'The date on which this SLA definition was formally approved.',
    `breach_penalty_amount` DECIMAL(18,2) COMMENT 'The monetary amount or percentage of the penalty applied per SLA breach incident.',
    `breach_penalty_currency` STRING COMMENT 'The currency in which the breach penalty is denominated, using ISO 4217 three-letter currency code.. Valid values are `^[A-Z]{3}$`',
    `breach_penalty_type` STRING COMMENT 'The type of penalty or remedy applied when the SLA is breached (credit, refund, none, custom).. Valid values are `credit|refund|none|custom`',
    `calculation_method` STRING COMMENT 'Description of the formula or methodology used to calculate the SLA metric from raw measurements.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA definition record was first created in the system.',
    `critical_threshold` DECIMAL(18,2) COMMENT 'The threshold value at which a critical alert is triggered, indicating an SLA breach has occurred or is imminent.',
    `data_source` STRING COMMENT 'The system or platform from which the SLA metric data is collected (e.g., Akamai CDN Monitoring, Adobe Analytics, Internal QoS System).',
    `sla_definition_description` STRING COMMENT 'Detailed description of the SLA, including business context, objectives, and any special conditions.',
    `effective_end_date` DATE COMMENT 'The date on which this SLA definition expires or is superseded. Null indicates an open-ended SLA.',
    `effective_start_date` DATE COMMENT 'The date from which this SLA definition becomes active and enforceable.',
    `escalation_procedure` STRING COMMENT 'Description of the escalation process and contacts when an SLA breach occurs or is imminent.',
    `exclusion_criteria` STRING COMMENT 'Conditions or events that are excluded from SLA measurement (e.g., scheduled maintenance, force majeure, third-party failures).',
    `geographic_scope` STRING COMMENT 'The geographic region or market to which this SLA applies (e.g., Global, North America, EMEA, APAC).',
    `measurement_frequency` STRING COMMENT 'How often the metric is sampled and evaluated (real-time, hourly, daily, weekly, monthly).. Valid values are `real_time|hourly|daily|weekly|monthly`',
    `measurement_window` STRING COMMENT 'The time period over which the SLA metric is calculated and evaluated (e.g., monthly, daily, rolling_30_days, per_incident).',
    `metric_name` STRING COMMENT 'Name of the specific performance metric being measured (e.g., Streaming Uptime, Start Time Latency, Rebuffering Ratio, CDN Cache Hit Rate, DRM License Issuance Latency, API Response Time).',
    `metric_type` STRING COMMENT 'Classification of the metric being measured (uptime, latency, throughput, error rate, response time, availability).. Valid values are `uptime|latency|throughput|error_rate|response_time|availability`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA definition record was last modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or operational guidance related to this SLA definition.',
    `owner_department` STRING COMMENT 'The business department or team responsible for managing and enforcing this SLA (e.g., Platform Operations, Distribution, Customer Success).',
    `reporting_frequency` STRING COMMENT 'How often SLA performance reports are generated and delivered to stakeholders (real-time, daily, weekly, monthly, quarterly).. Valid values are `real_time|daily|weekly|monthly|quarterly`',
    `service_tier` STRING COMMENT 'The subscription or service tier to which this SLA applies (premium, standard, basic, enterprise).. Valid values are `premium|standard|basic|enterprise`',
    `sla_code` STRING COMMENT 'Unique business identifier or code for the SLA definition used in contracts and operational systems.',
    `sla_definition_status` STRING COMMENT 'Current lifecycle status of the SLA definition (active, inactive, draft, superseded, retired).. Valid values are `active|inactive|draft|superseded|retired`',
    `sla_name` STRING COMMENT 'Human-readable name of the SLA definition (e.g., Premium Streaming Uptime SLA, Standard CDN Performance SLA).',
    `sla_type` STRING COMMENT 'Category of SLA defining the nature of the service commitment (availability, performance, quality, capacity, support, security).. Valid values are `availability|performance|quality|capacity|support|security`',
    `target_value` DECIMAL(18,2) COMMENT 'The target threshold value that defines the SLA commitment (e.g., 99.9 for 99.9% uptime, 2.0 for 2 seconds latency).',
    `unit_of_measure` STRING COMMENT 'The unit in which the metric is measured (e.g., percent, milliseconds, seconds, requests_per_second, ratio).',
    `version_number` STRING COMMENT 'Version identifier for this SLA definition, used to track revisions and changes over time.',
    `warning_threshold` DECIMAL(18,2) COMMENT 'The threshold value at which a warning alert is triggered, indicating performance is approaching but has not yet breached the SLA target.',
    CONSTRAINT pk_sla_definition PRIMARY KEY(`sla_definition_id`)
) COMMENT 'Defines Service Level Agreement (SLA) targets and thresholds for OTT platform performance obligations — covering streaming availability uptime, start-time latency, rebuffering ratio, CDN cache-hit rate, DRM license issuance latency, and API response time. Captures SLA name, metric type, target threshold, warning threshold, critical threshold, measurement window, applicable platform/service tier, and effective date range. Used for SLA performance tracking and breach alerting.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` (
    `sla_performance_id` BIGINT COMMENT 'Unique identifier for the SLA performance measurement record.',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: SLA measurements are facility-specific for uptime and latency reporting. Required for facility-level SLA compliance reporting and vendor performance reviews.',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: SLA measurement is market-specific due to CDN topology, regional infrastructure differences, and DMA-level service commitments in distribution partner agreements. Required for carriage fee penalty cal',
    `credit_memo_id` BIGINT COMMENT 'Foreign key linking to billing.credit_memo. Business justification: SLA breaches trigger contractual penalties and service credits to distribution partners or advertisers. Real business process: SLA penalty assessment, makegood credit issuance, partner compensation fo',
    `sla_definition_id` BIGINT COMMENT 'Reference to the SLA definition that establishes the target thresholds and measurement criteria for this performance record.',
    `tech_incident_id` BIGINT COMMENT 'The identifier of the incident management ticket or case associated with this SLA breach. Links to operational incident tracking systems.',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual measured value of the SLA metric during the measurement period. Unit of measure is defined in the associated SLA definition.',
    `affected_platform` STRING COMMENT 'The distribution platform affected by this SLA measurement (e.g., OTT streaming, linear broadcast, MVPD carriage, FAST channel, CDN endpoint). Identifies the delivery channel scope.',
    `affected_region` STRING COMMENT 'The geographic region or market affected by this SLA measurement. May be a country code, region name, or CDN edge location identifier.',
    `breach_duration_minutes` STRING COMMENT 'The total duration in minutes that the SLA was in breach state during the measurement period. Null if no breach occurred.',
    `breach_flag` BOOLEAN COMMENT 'Boolean indicator of whether the SLA was breached during this measurement period. True indicates a breach occurred; False indicates SLA was met.',
    `breach_severity` STRING COMMENT 'The severity classification of the SLA breach if one occurred. None indicates no breach; minor through critical indicate escalating severity levels based on business impact.. Valid values are `none|minor|moderate|major|critical`',
    `cdn_provider` STRING COMMENT 'The CDN provider responsible for content delivery during this measurement period (e.g., Akamai, Cloudflare, AWS CloudFront). Relevant for streaming and OTT SLA measurements.',
    `contract_reference` STRING COMMENT 'The contract or agreement reference number under which this SLA is defined. Links performance measurement to contractual obligations.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this SLA performance record was first created in the system. Part of audit trail for data lineage.',
    `device_category` STRING COMMENT 'The category of end-user device for which this SLA performance was measured (e.g., smart TV, mobile, desktop, set-top box, gaming console). Relevant for device-specific QoS monitoring.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether this SLA performance measurement is under dispute by the distribution partner or internal stakeholders. True indicates active dispute.',
    `dispute_reason` STRING COMMENT 'Textual description of the reason for disputing this SLA performance measurement. Captures partner or stakeholder objections for resolution tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this SLA performance record was last modified. Tracks updates through validation, dispute, and approval workflows.',
    `measurement_granularity` STRING COMMENT 'The time granularity at which this SLA performance measurement was captured (hourly, daily, weekly, monthly, quarterly, annual).. Valid values are `hourly|daily|weekly|monthly|quarterly|annual`',
    `measurement_period_end` TIMESTAMP COMMENT 'The end timestamp of the measurement period for this SLA performance record. Represents the conclusion of the observation window.',
    `measurement_period_start` TIMESTAMP COMMENT 'The start timestamp of the measurement period for this SLA performance record. Represents the beginning of the observation window.',
    `measurement_source` STRING COMMENT 'The source system or monitoring tool that captured this SLA performance measurement (e.g., Akamai CDN analytics, Ericsson MediaFirst monitoring, custom QoS probe). Provides data lineage.',
    `measurement_status` STRING COMMENT 'The workflow status of this SLA performance measurement record. Tracks progression from initial capture through validation, dispute resolution, and final approval.. Valid values are `draft|validated|disputed|approved|closed`',
    `notes` STRING COMMENT 'Free-form notes providing additional context, operational commentary, or special circumstances related to this SLA performance measurement.',
    `partner_name` STRING COMMENT 'The name of the distribution partner (MVPD, vMVPD, OTT platform, syndication partner) to whom this SLA applies. Used for partner-specific SLA reporting and governance.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The monetary penalty or service credit amount assessed due to the SLA breach. Expressed in the contract currency. Null if no penalty applies.',
    `penalty_applicable_flag` BOOLEAN COMMENT 'Boolean indicator of whether a contractual penalty or service credit is applicable due to this SLA breach. True indicates financial or contractual consequences apply.',
    `penalty_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the penalty amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `remediation_action` STRING COMMENT 'Description of the corrective action taken to address the SLA breach or performance degradation. Documents operational response and resolution steps.',
    `remediation_timestamp` TIMESTAMP COMMENT 'The timestamp when remediation action was completed and normal service levels were restored. Null if remediation is pending or not applicable.',
    `root_cause_category` STRING COMMENT 'The high-level category of the root cause for SLA breach or performance degradation (e.g., network congestion, origin server failure, CDN capacity, encoding issue, third-party dependency). [ENUM-REF-CANDIDATE: network|infrastructure|capacity|configuration|third-party|content|security|unknown — promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed textual description of the root cause analysis findings for the SLA breach or performance issue. Provides operational context for remediation and reporting.',
    `sample_size` BIGINT COMMENT 'The number of individual observations or data points used to calculate the aggregated SLA metric value. Provides statistical context for measurement confidence.',
    `streaming_protocol` STRING COMMENT 'The streaming protocol used for content delivery during this measurement (HLS, MPEG-DASH, RTMP, WebRTC, Smooth Streaming). Applicable to OTT and streaming SLA measurements.. Valid values are `HLS|MPEG-DASH|RTMP|WebRTC|Smooth Streaming`',
    `target_value` DECIMAL(18,2) COMMENT 'The target value defined in the SLA definition that the actual performance is measured against. Represents the contractual or operational commitment.',
    `threshold_value` DECIMAL(18,2) COMMENT 'The threshold value at which an SLA breach is triggered. May differ from target value to allow for acceptable variance before breach declaration.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the SLA metric values (e.g., milliseconds, percentage, Mbps, count, ratio). Provides context for interpreting actual, target, and threshold values.',
    `validated_by` STRING COMMENT 'The username or identifier of the user who validated this SLA performance measurement. Part of the approval and sign-off workflow.',
    `validated_timestamp` TIMESTAMP COMMENT 'The timestamp when this SLA performance measurement was validated and approved. Null if validation is pending.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance expressed as a percentage of the target value. Calculated as ((actual - target) / target) * 100.',
    `variance_value` DECIMAL(18,2) COMMENT 'The calculated variance between actual value and target value (actual minus target). Positive values indicate over-performance, negative values indicate under-performance.',
    CONSTRAINT pk_sla_performance PRIMARY KEY(`sla_performance_id`)
) COMMENT 'Transactional records tracking actual SLA performance measurements against defined SLA targets over time. Captures SLA definition reference, measurement period (hourly/daily/monthly), actual metric value, target value, breach flag, breach severity, affected platform/region, root-cause category, remediation action taken, and sign-off status. Distinct from sla_definition (the target) — this is the operational record of measured performance. Supports SLA reporting to distribution partners and internal governance.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` (
    `api_endpoint_id` BIGINT COMMENT 'Unique identifier for the API endpoint. Primary key.',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: API endpoints are hosted in specific facilities for disaster recovery and data residency compliance. Critical for DR planning and API geographic latency optimization.',
    `noc_monitor_id` BIGINT COMMENT 'Foreign key linking to technology.noc_monitor. Business justification: API endpoints require NOC monitoring for availability. Required for API monitoring setup and SLA compliance measurement.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: API endpoints are exposed by specific OTT platforms. Each API belongs to a platform service. Essential for API governance and platform-specific routing.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: API endpoints require engineering ownership for deprecation decisions, rate limit adjustments, SLA monitoring, and breaking change management. Essential for on-call rotations, API versioning accountab',
    `tech_project_id` BIGINT COMMENT 'Foreign key linking to technology.tech_project. Business justification: API endpoints are developed via technology projects. Required for API development project tracking and feature release management.',
    `tech_sla_id` BIGINT COMMENT 'Foreign key linking to technology.tech_sla. Business justification: API endpoints have technology SLAs for availability and response time. Required for API SLA compliance tracking and performance optimization.',
    `activated_timestamp` TIMESTAMP COMMENT 'The date and time when this endpoint was activated and made available for use. Null if the endpoint has never been activated or is still in development.',
    `allowed_origins` STRING COMMENT 'Comma-separated list of allowed origin domains for CORS requests (e.g., https://www.example.com, https://app.example.com). Asterisk (*) indicates all origins are allowed. Null if CORS is disabled.',
    `api_version` STRING COMMENT 'The version of the API that this endpoint belongs to (e.g., v1, v2, v3). Used for versioning and backward compatibility management.. Valid values are `^v[0-9]+$`',
    `authentication_scheme` STRING COMMENT 'The authentication mechanism required to access this endpoint (OAuth2 for token-based, API key for simple key-based, JWT for JSON Web Token, basic auth for username/password, none for public endpoints).. Valid values are `oauth2|api_key|jwt|basic_auth|none`',
    `authorization_scope` STRING COMMENT 'The OAuth2 scope or permission level required to access this endpoint (e.g., read:content, write:profile, admin:all). Defines what actions the authenticated user is authorized to perform.',
    `cache_strategy` STRING COMMENT 'The caching strategy applied to responses from this endpoint (no_cache for dynamic data, private for user-specific data, public for shared data, cdn for CDN-cacheable content).. Valid values are `no_cache|private|public|cdn`',
    `cache_ttl_seconds` STRING COMMENT 'The time-to-live in seconds for cached responses from this endpoint. Defines how long the response can be cached before it must be revalidated. Null indicates no caching.',
    `cors_enabled` BOOLEAN COMMENT 'Indicates whether Cross-Origin Resource Sharing is enabled for this endpoint (true), allowing web browsers to make requests from different domains, or disabled (false) for same-origin only.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this API endpoint record was first created in the registry. Used for audit trail and lifecycle tracking.',
    `deprecation_date` DATE COMMENT 'The date when this endpoint was officially marked as deprecated. Used to track the deprecation timeline and communicate sunset schedules to API consumers.',
    `documentation_url` STRING COMMENT 'The URL to the detailed API documentation for this endpoint, typically hosted in a developer portal or API documentation system (e.g., Swagger, Postman, Confluence).. Valid values are `^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$`',
    `endpoint_description` STRING COMMENT 'Detailed description of the endpoints purpose, functionality, and business use case. Explains what the endpoint does and when it should be used.',
    `endpoint_name` STRING COMMENT 'Human-readable name or label for the API endpoint (e.g., Content Search, Playback Authorization, Subscriber Entitlement Check).',
    `endpoint_path` STRING COMMENT 'The URI path of the API endpoint (e.g., /api/v2/content/search, /api/v1/playback/authorize). This is the resource path exposed to API consumers.. Valid values are `^/[a-zA-Z0-9/_-]+$`',
    `endpoint_status` STRING COMMENT 'The current operational status of the endpoint (active for production use, beta for testing with select partners, alpha for internal testing, inactive for disabled, maintenance for temporary unavailability).. Valid values are `active|inactive|beta|alpha|maintenance`',
    `functional_category` STRING COMMENT 'The business function or domain that this endpoint serves (e.g., content discovery for browsing, playback authorization for DRM, DAI for Dynamic Ad Insertion, EPG for Electronic Program Guide). [ENUM-REF-CANDIDATE: content_discovery|playback_authorization|subscriber_entitlement|epg|search|recommendation|dai|user_profile|analytics|billing — 10 candidates stripped; promote to reference product]',
    `http_method` STRING COMMENT 'The HTTP method supported by this endpoint (GET for retrieval, POST for creation, PUT for full update, PATCH for partial update, DELETE for removal). [ENUM-REF-CANDIDATE: GET|POST|PUT|PATCH|DELETE|HEAD|OPTIONS — 7 candidates stripped; promote to reference product]',
    `is_deprecated` BOOLEAN COMMENT 'Indicates whether this endpoint has been marked as deprecated (true) and should no longer be used by new integrations. Deprecated endpoints are maintained for backward compatibility but will eventually be removed.',
    `is_public` BOOLEAN COMMENT 'Indicates whether this endpoint is publicly accessible without authentication (true) or requires authentication (false). Public endpoints are typically used for content discovery and marketing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this API endpoint record was last updated. Used for change tracking and audit purposes.',
    `owning_service` STRING COMMENT 'The name of the microservice or backend service that implements and owns this endpoint (e.g., content-service, playback-service, subscriber-service). Used for operational ownership and incident routing.',
    `owning_team` STRING COMMENT 'The engineering team responsible for maintaining and supporting this endpoint (e.g., Content Platform Team, Playback Engineering, Subscriber Services). Used for escalation and change management.',
    `rate_limit_requests_per_day` STRING COMMENT 'The maximum number of requests allowed per day for this endpoint under the assigned rate limit tier. Used for daily quota enforcement.',
    `rate_limit_requests_per_minute` STRING COMMENT 'The maximum number of requests allowed per minute for this endpoint under the assigned rate limit tier. Null indicates no specific limit or unlimited access.',
    `rate_limit_tier` STRING COMMENT 'The rate limiting tier applied to this endpoint, determining how many requests per time window are allowed (e.g., public tier allows 100 req/min, enterprise allows 10000 req/min).. Valid values are `public|standard|premium|enterprise|unlimited`',
    `replacement_endpoint_path` STRING COMMENT 'The URI path of the replacement endpoint that should be used instead of this deprecated endpoint. Null if no direct replacement exists. Used to guide API consumers during migration.',
    `request_content_type` STRING COMMENT 'The expected content type for the request body (e.g., application/json for JSON payloads, application/xml for XML). Null for endpoints that do not accept a request body (e.g., GET requests).. Valid values are `application/json|application/xml|application/x-www-form-urlencoded|multipart/form-data|text/plain`',
    `response_content_type` STRING COMMENT 'The content type returned by this endpoint in the response body (e.g., application/json for JSON responses, application/xml for XML). Defines the format of the data returned to the client.. Valid values are `application/json|application/xml|text/html|text/plain|application/octet-stream`',
    `sla_response_time_ms` STRING COMMENT 'The target response time in milliseconds for this endpoint under normal load conditions (e.g., 200ms for p95, 500ms for p99). Used for performance monitoring and alerting.',
    `sla_tier` STRING COMMENT 'The service level agreement tier for this endpoint, defining uptime guarantees, response time targets, and support priority (e.g., mission_critical requires 99.99% uptime, gold requires 99.9%).. Valid values are `bronze|silver|gold|platinum|mission_critical`',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'The guaranteed uptime percentage for this endpoint as defined in the SLA (e.g., 99.99 for four nines, 99.9 for three nines). Measured monthly.',
    `sunset_date` DATE COMMENT 'The planned date when this endpoint will be permanently removed and no longer available. Null if no sunset is planned. Used to give API consumers advance notice for migration.',
    `supports_filtering` BOOLEAN COMMENT 'Indicates whether this endpoint supports query parameter filtering to narrow down results (true) or returns a fixed result set (false). Filtering allows clients to request specific subsets of data.',
    `supports_pagination` BOOLEAN COMMENT 'Indicates whether this endpoint supports pagination for large result sets (true) or returns all results in a single response (false). Paginated endpoints typically accept page and page_size query parameters.',
    `supports_sorting` BOOLEAN COMMENT 'Indicates whether this endpoint supports query parameter sorting to order results (true) or returns results in a default order (false). Sorting allows clients to control result ordering.',
    CONSTRAINT pk_api_endpoint PRIMARY KEY(`api_endpoint_id`)
) COMMENT 'Master registry of all business-facing API endpoints exposed by the OTT platform — content discovery, playback authorization, subscriber entitlement, EPG, search, recommendation, and DAI (Dynamic Ad Insertion) APIs. Captures endpoint path, HTTP method, API version, authentication scheme (OAuth2, API key, JWT), rate limit policy, SLA tier, deprecation date, owning service, and documentation URL. Distinct from streaming_endpoint (media delivery) — this governs the application API surface.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` (
    `personalization_engine_id` BIGINT COMMENT 'Unique identifier for the personalization engine instance. Primary key for the personalization engine configuration record.',
    `compliance_consent_record_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_record. Business justification: Personalization engines processing user data must validate consent before profiling. Engine operations are gated by consent status for analytics, personalization, and third-party sharing.',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Recommendation algorithms incorporate demographic signals for content discovery, cold-start personalization, and Nielsen-aligned performance prediction. Supports demographic-based A/B testing and enga',
    `fallback_engine_personalization_engine_id` BIGINT COMMENT 'Reference to an alternative personalization engine to use if this engine fails or returns insufficient recommendations. Ensures continuous user experience during engine failures or maintenance.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Personalization engines are deployed per OTT platform. Each engine instance serves a specific platform. Removes target_platform STRING (derivable from ott_platform).',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Personalization engines require data science/ML engineering ownership for model training, A/B test analysis, performance monitoring, and GDPR/CCPA compliance. Essential for accountability in recommend',
    `segment_id` BIGINT COMMENT 'Foreign key linking to audience.audience_segment. Business justification: Modern personalization relies on behavioral segments for recommendation accuracy and engagement optimization. Supports genre affinity modeling, viewing pattern analysis, and cross-platform content dis',
    `software_license_id` BIGINT COMMENT 'Foreign key linking to technology.software_license. Business justification: Personalization engines use licensed ML frameworks. Required for ML software license compliance and engine cost allocation.',
    `tech_project_id` BIGINT COMMENT 'Foreign key linking to technology.tech_project. Business justification: Personalization engines are deployed via ML projects. Required for personalization project ROI tracking and model deployment timeline management.',
    `ab_test_variant` STRING COMMENT 'A/B test variant identifier if this engine is part of an experimentation framework (e.g., control, variant_a, variant_b). Null if not part of active testing.',
    `algorithm_type` STRING COMMENT 'The machine learning algorithm type used by the personalization engine. Collaborative filtering uses user behavior patterns, content-based uses content attributes, hybrid combines both approaches, matrix factorization decomposes user-item interactions, deep learning uses neural networks, and contextual bandit balances exploration and exploitation.. Valid values are `collaborative_filtering|content_based|hybrid|matrix_factorization|deep_learning|contextual_bandit`',
    `api_endpoint_url` STRING COMMENT 'Uniform Resource Locator (URL) of the Application Programming Interface (API) endpoint that serves recommendations from this engine. Used by client applications to request personalized content.',
    `business_justification` STRING COMMENT 'Business rationale and expected outcomes for deploying this personalization engine (e.g., Increase Average Revenue Per User (ARPU) by 15%, Reduce churn rate by improving content discovery, Support new FAST channel launch).',
    `cache_ttl_seconds` STRING COMMENT 'Time-To-Live (TTL) in seconds for cached recommendations. Balances recommendation freshness against system performance. Shorter TTL provides more current recommendations but increases computational load.',
    `ccpa_compliant_flag` BOOLEAN COMMENT 'Boolean indicator of whether this personalization engine complies with California Consumer Privacy Act (CCPA) requirements, including opt-out mechanisms and data sale restrictions.',
    `cold_start_strategy` STRING COMMENT 'Strategy used to generate recommendations for new users or content with insufficient interaction history. Popularity-based shows trending content, content similarity uses metadata matching, demographic default uses segment averages, hybrid fallback combines multiple approaches, and random exploration introduces serendipity.. Valid values are `popularity_based|content_similarity|demographic_default|hybrid_fallback|random_exploration`',
    `confidence_threshold` DECIMAL(18,2) COMMENT 'Minimum confidence score (0.00 to 1.00) required for a recommendation to be surfaced to users. Lower thresholds increase recommendation volume but may reduce relevance.',
    `content_filter_rules` STRING COMMENT 'Business rules defining content eligibility for recommendations (e.g., exclude expired rights, enforce parental controls, respect geographic blackouts, honor windowing restrictions). Stored as structured text or JSON.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this personalization engine configuration record was first created in the system. Used for audit trail and data lineage tracking.',
    `deployment_date` DATE COMMENT 'Date when this personalization engine instance was first deployed to production. Used for tracking engine age and performance trends over time.',
    `diversity_threshold` DECIMAL(18,2) COMMENT 'Minimum diversity score (0.00 to 1.00) enforced in recommendation sets to prevent filter bubbles. Higher values ensure greater variety in content genres, formats, and themes.',
    `engine_code` STRING COMMENT 'Unique business identifier code for the personalization engine (e.g., HOME_REC_01, CONT_DISC_02). Used for system integration and API references.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `engine_name` STRING COMMENT 'Human-readable name of the personalization engine instance (e.g., Homepage Recommender, Content Discovery Engine, Next Episode Predictor). Used for operational identification and reporting.',
    `feature_set_configuration` STRING COMMENT 'JSON or structured text describing the feature set used by the model (e.g., viewing history, genre preferences, time-of-day patterns, device type, engagement metrics). Defines the input variables for the recommendation algorithm.',
    `gdpr_compliant_flag` BOOLEAN COMMENT 'Boolean indicator of whether this personalization engine complies with General Data Protection Regulation (GDPR) requirements for audience data processing, including consent management, data minimization, and right to erasure.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this personalization engine configuration record. Critical for change tracking and configuration management.',
    `last_training_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent model training execution. Critical for monitoring model freshness and ensuring recommendations reflect current user behavior patterns.',
    `model_version` STRING COMMENT 'Semantic version number of the deployed machine learning model (e.g., v1.2.3). Follows semantic versioning convention for model lifecycle management and rollback capability.. Valid values are `^v[0-9]+.[0-9]+.[0-9]+$`',
    `operational_status` STRING COMMENT 'Current operational state of the personalization engine. Active engines serve live traffic, inactive are disabled, testing are in validation phase, deprecated are scheduled for retirement, and maintenance indicates temporary unavailability.. Valid values are `active|inactive|testing|deprecated|maintenance`',
    `owner_team` STRING COMMENT 'Name of the business or technical team responsible for this personalization engine instance. Used for operational accountability and incident escalation.',
    `performance_metric_target` STRING COMMENT 'Primary business metric this personalization engine is optimized to maximize. Click-through rate measures initial engagement, watch time measures sustained viewing, completion rate measures content finish rate, engagement score is a composite metric, and revenue per user measures monetization impact.. Valid values are `click_through_rate|watch_time|completion_rate|engagement_score|revenue_per_user`',
    `personalization_scope` STRING COMMENT 'Granularity level at which personalization is applied. User-level provides individual recommendations, segment-level groups similar users, household-level considers shared viewing, and device-level adapts to device context.. Valid values are `user_level|segment_level|household_level|device_level`',
    `recommendation_count_limit` STRING COMMENT 'Maximum number of recommendations this engine will return per request. Typical values range from 10 to 100 depending on user interface requirements and performance constraints.',
    `refresh_cadence` STRING COMMENT 'Frequency at which the personalization model is retrained or recommendations are regenerated. Real-time engines update continuously, while batch engines refresh on schedule.. Valid values are `real_time|hourly|daily|weekly|on_demand`',
    `response_time_sla_ms` STRING COMMENT 'Maximum acceptable response time in milliseconds for recommendation requests as defined in the Service Level Agreement (SLA). Typical values range from 100ms to 500ms for real-time engines.',
    `training_data_window_days` STRING COMMENT 'Number of days of historical data used to train the personalization model. Typical values range from 30 to 365 days depending on content velocity and user behavior patterns.',
    CONSTRAINT pk_personalization_engine PRIMARY KEY(`personalization_engine_id`)
) COMMENT 'Master configuration record for each personalization and recommendation engine instance deployed on the OTT platform (Adobe Experience Platform integration). Captures engine name, algorithm type (collaborative filtering, content-based, hybrid), model version, training data window, feature set configuration, A/B test variant assignment, target platform, refresh cadence, cold-start strategy, and operational status. SSOT for the personalization layer configuration distinct from individual recommendation events.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` (
    `dai_configuration_id` BIGINT COMMENT 'Unique identifier for the DAI configuration record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: DAI configurations control ad insertion logic and revenue streams, requiring ownership for approval workflows, fill rate troubleshooting, blackout override decisions, and ad server contract compliance',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: DAI configurations are platform-specific. Each DAI config applies to a specific OTT platform for ad insertion rules and targeting.',
    `abr_profile_compatibility` STRING COMMENT 'Comma-separated list of ABR streaming profiles this DAI configuration is compatible with (e.g., HLS, MPEG-DASH, Smooth Streaming).',
    `ad_decision_server_url` STRING COMMENT 'Endpoint URL for the Ad Decision Server that determines which ads to serve based on targeting criteria and inventory availability.. Valid values are `^https?://[a-zA-Z0-9.-]+(/.*)?$`',
    `ad_format_support` STRING COMMENT 'Comma-separated list of supported ad formats for this configuration (e.g., VAST, VMAP, VPAID, SIMID).',
    `ad_pod_placement_rules` STRING COMMENT 'Business rules defining where ad pods (groups of ads in a break) can be inserted within the content, including pre-roll, mid-roll, and post-roll positions.',
    `ad_server_timeout_milliseconds` STRING COMMENT 'Maximum time in milliseconds to wait for a response from the ad decision server before triggering fallback logic.',
    `backup_ad_server_url` STRING COMMENT 'Failover endpoint URL for ad decision requests when the primary ad server is unavailable or times out.. Valid values are `^https?://[a-zA-Z0-9.-]+(/.*)?$`',
    `blackout_override_enabled` BOOLEAN COMMENT 'Indicates whether this DAI configuration can override geographic blackout restrictions for ad insertion purposes.',
    `cdn_integration_mode` STRING COMMENT 'How the DAI system integrates with the CDN: direct (CDN serves pre-stitched streams), proxied (DAI proxies through CDN), or edge decisioning (ad decisions at CDN edge).. Valid values are `direct|proxied|edge_decisioning`',
    `companion_ads_enabled` BOOLEAN COMMENT 'Indicates whether companion banner ads are displayed alongside video ads to enhance engagement and click-through rates.',
    `configuration_code` STRING COMMENT 'Unique alphanumeric code identifying this DAI configuration across systems and platforms.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `configuration_name` STRING COMMENT 'Human-readable name for this DAI configuration, used for identification and reference by operations teams.',
    `configuration_status` STRING COMMENT 'Current lifecycle status of this DAI configuration: active (in production use), inactive (not in use), testing (under validation), or deprecated (scheduled for removal).. Valid values are `active|inactive|testing|deprecated`',
    `configuration_version` STRING COMMENT 'Version number of this configuration, incremented with each modification to support change tracking and rollback capabilities.',
    `content_type` STRING COMMENT 'Type of content this DAI configuration applies to: Video On Demand (VOD), live streaming, linear broadcast, or Free Ad-Supported Streaming Television (FAST) channels.. Valid values are `vod|live|linear|fast`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this DAI configuration record was first created in the system.',
    `device_targeting_enabled` BOOLEAN COMMENT 'Indicates whether device-specific targeting is enabled to serve ads optimized for the viewers device type (mobile, tablet, TV, desktop).',
    `drm_enforcement_mode` STRING COMMENT 'Level of DRM enforcement applied to ad content: strict (full encryption), lenient (selective protection), or disabled (no DRM on ads).. Valid values are `strict|lenient|disabled`',
    `effective_end_date` DATE COMMENT 'Date when this DAI configuration expires and is no longer eligible for use. Null indicates no expiration.',
    `effective_start_date` DATE COMMENT 'Date when this DAI configuration becomes active and eligible for use in ad insertion workflows.',
    `fallback_creative_strategy` STRING COMMENT 'Strategy for handling unfilled ad inventory: display house ads, show slate/filler, continue content, or repeat the last served ad.. Valid values are `house_ad|slate|content_continuation|repeat_last`',
    `fill_rate_target_percentage` DECIMAL(18,2) COMMENT 'Target percentage of available ad inventory that should be filled with paid advertisements, used to measure monetization effectiveness.',
    `frequency_cap_enabled` BOOLEAN COMMENT 'Indicates whether frequency capping is enforced to limit the number of times a viewer sees the same ad within a session or time period.',
    `geo_targeting_enabled` BOOLEAN COMMENT 'Indicates whether geographic targeting is enabled to serve location-specific ads based on viewer IP address or device location.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this DAI configuration record was last updated or modified.',
    `max_ad_pod_duration_seconds` STRING COMMENT 'Maximum allowed duration in seconds for a single ad pod insertion, ensuring viewer experience and regulatory compliance.',
    `max_impressions_per_hour` STRING COMMENT 'Maximum number of times the same ad creative can be shown to a viewer within a one-hour period when frequency capping is enabled.',
    `max_impressions_per_session` STRING COMMENT 'Maximum number of times the same ad creative can be shown to a viewer within a single viewing session when frequency capping is enabled.',
    `min_ad_pod_duration_seconds` STRING COMMENT 'Minimum required duration in seconds for an ad pod to be considered valid for insertion.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this DAI configuration record.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or context about this DAI configuration.',
    `priority_level` STRING COMMENT 'Numeric priority level used to resolve conflicts when multiple DAI configurations could apply to the same content. Higher values indicate higher priority.',
    `scte35_signal_handling` STRING COMMENT 'How SCTE-35 cue markers embedded in the content stream are processed: enabled (parse and act), disabled (ignore), or passthrough (forward without processing).. Valid values are `enabled|disabled|passthrough`',
    `stitching_mode` STRING COMMENT 'Method used to insert ads into the content stream: server-side stitching (SSAI), client-side stitching (CSAI), or hybrid approach combining both.. Valid values are `server_side|client_side|hybrid`',
    `tracking_events_enabled` BOOLEAN COMMENT 'Indicates whether ad tracking events (impressions, quartiles, completions, clicks) are captured and reported to measurement systems.',
    CONSTRAINT pk_dai_configuration PRIMARY KEY(`dai_configuration_id`)
) COMMENT 'Configuration records for Dynamic Ad Insertion (DAI) on the OTT platform — defining ad pod placement rules, SCTE-35 signal handling, ad decision server (ADS) endpoints, fill-rate fallback logic, ad stitching mode (server-side vs client-side), blackout override rules, and frequency cap enforcement. Captures DAI config name, applicable content type (VOD, live), ad server URL, timeout thresholds, and effective date. Bridges the platform domain with the advertising domains campaign delivery.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` (
    `feature_flag_id` BIGINT COMMENT 'Unique identifier for the feature flag configuration record.',
    `ott_platform_id` BIGINT COMMENT 'add column distribution_ott_platform_id (BIGINT) with FK to distribution.ott_platform.ott_platform_id - feature flags control platform-specific functionality and need platform linkage',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Feature flags control user experience and require product manager ownership for rollout decisions, kill switch activation during incidents, A/B test result analysis, and experiment hypothesis validati',
    `app_version_max` STRING COMMENT 'Maximum Over-The-Top (OTT) application version for which this feature flag is active (semantic versioning format: major.minor.patch). Null if no upper bound.. Valid values are `^d+.d+.d+$`',
    `app_version_min` STRING COMMENT 'Minimum Over-The-Top (OTT) application version required for this feature flag to be active (semantic versioning format: major.minor.patch).. Valid values are `^d+.d+.d+$`',
    `approval_status` STRING COMMENT 'Approval workflow status for feature flag changes: pending (awaiting review), approved (authorized for deployment), rejected (change denied).. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Username or identifier of the product owner or technical lead who approved this feature flag for deployment. Null if not yet approved.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this feature flag configuration was approved for deployment. Null if not yet approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this feature flag record was first created in the system.',
    `dependency_flags` STRING COMMENT 'Comma-separated list of other feature flag keys that must be enabled for this flag to function correctly. Captures flag interdependencies.',
    `feature_flag_description` STRING COMMENT 'Detailed business description of the feature controlled by this flag, including purpose, expected behavior, and rollout strategy.',
    `effective_end_date` TIMESTAMP COMMENT 'Timestamp when the feature flag expires and is automatically disabled. Null for indefinite flags.',
    `effective_start_date` TIMESTAMP COMMENT 'Timestamp when the feature flag becomes active and begins controlling feature availability or behavior.',
    `enabled_flag` BOOLEAN COMMENT 'Boolean indicator of whether the feature flag is currently enabled (True) or disabled (False) for the target audience.',
    `evaluation_count` BIGINT COMMENT 'Total number of times this feature flag has been evaluated by application code since activation. Used for usage analytics and cleanup decisions.',
    `experiment_hypothesis` STRING COMMENT 'Business hypothesis being tested when flag_type is experiment (e.g., Personalized content rail will increase engagement by 15%). Null for non-experiment flags.',
    `flag_key` STRING COMMENT 'Unique programmatic identifier for the feature flag used in application code (e.g., new_player_ui, personalized_rail_v2). Must be unique across the platform.. Valid values are `^[a-z0-9_-]{3,64}$`',
    `flag_name` STRING COMMENT 'Human-readable display name for the feature flag shown in management dashboards and reporting interfaces.',
    `flag_status` STRING COMMENT 'Current lifecycle status of the feature flag: active (in use), inactive (temporarily disabled), archived (no longer needed but retained for audit), deprecated (scheduled for removal).. Valid values are `active|inactive|archived|deprecated`',
    `flag_type` STRING COMMENT 'Classification of the feature flag purpose: release_toggle (gradual feature rollout), experiment (A/B test variant), ops_toggle (operational control), permission_toggle (access control), ux_variant (user experience configuration), kill_switch (emergency disable capability).. Valid values are `release_toggle|experiment|ops_toggle|permission_toggle|ux_variant|kill_switch`',
    `kill_switch_enabled` BOOLEAN COMMENT 'Boolean indicator of whether this flag can be used as an emergency kill switch to rapidly disable a feature without application redeployment.',
    `last_evaluation_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent evaluation of this feature flag by any application instance. Used to identify stale or unused flags.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this feature flag configuration.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this feature flag record was last modified.',
    `owning_product_team` STRING COMMENT 'Name of the product team responsible for managing this feature flag and making rollout decisions (e.g., Player Experience Team, Personalization Team).',
    `priority_level` STRING COMMENT 'Business priority classification for this feature flag indicating urgency and impact: critical (revenue-impacting or regulatory), high (major feature), medium (enhancement), low (minor tweak).. Valid values are `critical|high|medium|low`',
    `rollout_percentage` DECIMAL(18,2) COMMENT 'Percentage of the target audience to which the feature is rolled out (0.00 to 100.00). Enables gradual feature deployment and canary releases.',
    `tags` STRING COMMENT 'Comma-separated list of tags for categorization and filtering (e.g., personalization, monetization, compliance, performance). Enables flag discovery and governance.',
    `target_audience_segment` STRING COMMENT 'Audience segment or cohort identifier to which this feature flag applies (e.g., premium_subscribers, beta_testers, geo_usa_west). References audience segmentation taxonomy.',
    `target_platform` STRING COMMENT 'Over-The-Top (OTT) platform or device type where this feature flag is deployed: web (browser-based), ios (Apple mobile), android (Android mobile), roku, fire_tv, apple_tv, samsung_tv, lg_tv, or all_platforms for cross-platform flags. [ENUM-REF-CANDIDATE: web|ios|android|roku|fire_tv|apple_tv|samsung_tv|lg_tv|all_platforms — 9 candidates stripped; promote to reference product]',
    `traffic_split_percentage` DECIMAL(18,2) COMMENT 'Percentage of traffic allocated to variant B in A/B experiments (0.00 to 100.00). Remaining traffic goes to variant A. Null for non-experiment flags.',
    `ux_configuration_json` STRING COMMENT 'JSON-encoded configuration parameters for user experience variants including rail ordering, theme selection, layout variant, navigation structure, and other UX-specific settings controlled by this flag.',
    `variant_a_config` STRING COMMENT 'Configuration parameters for variant A in A/B test experiments (typically the control group). JSON-encoded or plain text depending on complexity.',
    `variant_b_config` STRING COMMENT 'Configuration parameters for variant B in A/B test experiments (typically the treatment group). JSON-encoded or plain text depending on complexity.',
    `created_by` STRING COMMENT 'Username or identifier of the product manager or engineer who created this feature flag configuration.',
    CONSTRAINT pk_feature_flag PRIMARY KEY(`feature_flag_id`)
) COMMENT 'Business configuration registry of feature flags, A/B test variants, UX experiments, and controlled rollout configurations deployed across OTT platform app versions. Captures flag name, flag type (release toggle, experiment, ops toggle, permission, UX variant), target platform, target audience segment or cohort, enabled/disabled state, rollout percentage, experiment hypothesis, UX configuration parameters (rail ordering, theme, layout variant), start and end dates, and owning product team. Enables controlled feature rollouts, UX experimentation, multivariate testing, and rapid kill-switch capability without app redeployment.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` (
    `distribution_partner_id` BIGINT COMMENT 'Unique identifier for the distribution partner. Primary key for the distribution partner entity.',
    `sales_territory_id` BIGINT COMMENT 'Foreign key linking to sales.sales_territory. Business justification: Distribution partners (MVPDs, cable operators, streaming aggregators) are assigned to sales territories for account management. Supports territory-based partner relationship management, quota allocati',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Distribution partners (MVPDs, cable operators, streaming aggregators) are billing customers for carriage fees, retransmission consent, and content licensing. Real business process: partner invoicing, ',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Distribution partners have co-located equipment at broadcaster facilities. Required for partner technical integration coordination and facility access control management.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: MVPDs and distribution partners may operate under their own broadcast licenses when originating content or providing local broadcast services. Partner licensing status affects carriage eligibility and',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Large distribution partners (MVPDs, cable operators) have dedicated cost centers for partner management expenses including account management, technical support, and integration costs. Monthly cost al',
    `network_circuit_id` BIGINT COMMENT 'Foreign key linking to technology.network_circuit. Business justification: Distribution partners connect via dedicated network circuits. Required for partner circuit billing reconciliation and SLA compliance tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Distribution partnerships require dedicated relationship managers for contract negotiations, SLA dispute resolution, carriage fee negotiations, and technical integration oversight. Essential for escal',
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
    `partner_code` STRING COMMENT 'Unique business identifier or short code assigned to the distribution partner for operational reference and system integration.. Valid values are `^[A-Z0-9]{3,12}$`',
    `partner_name` STRING COMMENT 'Legal or trade name of the distribution partner organization.',
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
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Carriage agreements are managed by assigned sales reps who negotiate terms and maintain partner relationships. Critical for rep commission calculation on carriage fees, account ownership tracking, and',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Retransmission consent agreements are legally tied to specific broadcast licenses. Must-carry elections, carriage fees, and retransmission consent status are license-specific regulatory obligations re',
    `channel_id` BIGINT COMMENT 'Reference to the channel or content package covered by this carriage agreement.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Carriage agreements are high-value contracts requiring business/legal owner for amendments, renewal negotiations, retransmission consent disputes, and must-carry elections. Essential for approval work',
    `distribution_partner_id` BIGINT COMMENT 'Reference to the MVPD, vMVPD, or OTT platform carrying the content under this agreement.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Carriage agreements with MVPDs/distributors reference underlying content license agreements that authorize the carriage. Critical for rights chain validation, ensuring distribution partners have prope',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: Retransmission consent and carriage agreements are negotiated per DMA with market-specific subscriber counts, fees, and blackout provisions mandated by FCC regulations. Essential for must-carry compli',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Carriage agreements generate master invoices for services beyond specialized carriage fee invoices (setup fees, equipment, technical services). Real business process: comprehensive agreement billing, ',
    `network_circuit_id` BIGINT COMMENT 'Foreign key linking to technology.network_circuit. Business justification: Carriage agreements specify dedicated network circuits for content delivery. Required for technical compliance verification and circuit cost allocation.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Carriage agreements often require regulatory filings (retransmission consent elections, program carriage complaints, must-carry notifications). Agreement execution and amendments trigger FCC filing wo',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Carriage agreements generate specific revenue streams (retransmission consent fees, carriage fees) that must be recognized under ASC 606. Monthly carriage fee invoicing posts to specific revenue strea',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` (
    `distribution_carriage_fee_invoice_id` BIGINT COMMENT 'Unique identifier for the carriage fee invoice record. Primary key for this transactional billing entity.',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Carriage fee invoices create A/R entries when billed to distribution partners. Monthly A/R aging reports include outstanding carriage fee invoices for cash flow management and collections tracking in ',
    `carriage_agreement_id` BIGINT COMMENT 'Reference to the master carriage agreement under which this invoice is issued. Links to the contractual relationship governing carriage fees.',
    `distribution_partner_id` BIGINT COMMENT 'Reference to the MVPD, vMVPD, cable operator, or OTT platform partner who is the counterparty to this invoice. The party being billed or paying the carriage fee.',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Carriage fee invoices are tracked by responsible sales rep for commission calculation and dispute resolution. Essential for rep compensation on recurring carriage revenue, account health monitoring, a',
    `revenue_recognition_event_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_recognition_event. Business justification: Carriage fee invoices trigger revenue recognition events under ASC 606/IFRS 15. Monthly revenue recognition close ties invoices to recognition events for financial statement preparation and revenue as',
    `subscriber_count_report_id` BIGINT COMMENT 'Foreign key linking to distribution.subscriber_count_report. Business justification: Carriage fee invoices are based on subscriber count reports. Billing uses reported subscriber counts for fee calculation. Removes subscriber_count BIGINT (derivable from subscriber_count_report.report',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total adjustments applied to the base fee, including discounts, credits, penalties, or promotional adjustments. May be positive or negative.',
    `base_fee_amount` DECIMAL(18,2) COMMENT 'The base carriage fee amount before any adjustments, discounts, or taxes. Represents the core contractual fee for the billing period.',
    `billing_period_end_date` DATE COMMENT 'The last date of the period for which carriage fees are being billed. Defines the end of the service or subscription window covered by this invoice.',
    `billing_period_start_date` DATE COMMENT 'The first date of the period for which carriage fees are being billed. Defines the beginning of the service or subscription window covered by this invoice.',
    `cost_center_code` STRING COMMENT 'The cost center or profit center to which this invoice is allocated for internal financial reporting and management accounting.',
    `created_by_user` STRING COMMENT 'The username or identifier of the user or system process that created this invoice record. Used for audit and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the invoice is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dispute_date` DATE COMMENT 'The date on which the dispute was formally raised by the distribution partner. Null if the invoice has never been disputed.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether the invoice is currently under dispute by the distribution partner. True if disputed, false otherwise.',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason for the dispute, if the invoice is disputed. Captures the distribution partners objection or concern.',
    `due_date` DATE COMMENT 'The date by which payment is contractually required. Used to determine overdue status and trigger late payment processes.',
    `fee_basis` STRING COMMENT 'The pricing model or calculation method used to determine the carriage fee amount. Defines whether the fee is per-subscriber, flat-rate, tiered by volume, revenue-share, or a hybrid structure.. Valid values are `per_subscriber|flat_rate|tiered|revenue_share|hybrid|minimum_guarantee`',
    `general_ledger_account_code` STRING COMMENT 'The GL account code to which this carriage fee invoice is posted in the financial system. Used for financial reporting and revenue recognition.',
    `invoice_date` DATE COMMENT 'The date on which the invoice was officially issued to the distribution partner. This is the principal business event timestamp for the invoice transaction.',
    `invoice_number` STRING COMMENT 'Externally-visible unique invoice number used for billing correspondence, payment reconciliation, and financial reporting. Typically follows a sequential or structured numbering scheme.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the carriage fee invoice. Tracks progression from draft through issuance, acknowledgment, payment, and potential dispute or cancellation. [ENUM-REF-CANDIDATE: draft|issued|sent|acknowledged|paid|partially_paid|overdue|disputed|cancelled|void — 10 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text notes or comments related to the invoice. May include special instructions, explanations of adjustments, or internal remarks.',
    `payment_method` STRING COMMENT 'The payment instrument or mechanism used or expected for settling this invoice (e.g., wire transfer, ACH, check).. Valid values are `wire_transfer|ach|check|credit_card|direct_debit|other`',
    `payment_received_date` DATE COMMENT 'The date on which payment was received and applied to this invoice. Null if the invoice has not been paid.',
    `payment_reference_number` STRING COMMENT 'External reference number or transaction identifier provided by the payer or payment processor. Used for payment reconciliation and traceability.',
    `payment_status` STRING COMMENT 'Current payment status of the invoice. Tracks whether the invoice has been paid in full, partially paid, remains unpaid, or is overdue or disputed.. Valid values are `unpaid|paid|partially_paid|overdue|disputed|waived`',
    `payment_terms` STRING COMMENT 'Contractual payment terms for this invoice, such as Net 30, Net 60, or custom terms. Defines the expected payment timeline and conditions.',
    `reconciliation_date` DATE COMMENT 'The date on which the invoice was successfully reconciled against subscriber data, payments, and contractual obligations. Null if reconciliation is pending or failed.',
    `reconciliation_status` STRING COMMENT 'Status of the revenue assurance reconciliation process for this invoice. Indicates whether the invoice has been matched to subscriber reports, payments, and contractual terms.. Valid values are `pending|reconciled|discrepancy|under_review`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the invoice, including sales tax, VAT, or other applicable taxes based on jurisdiction and tax rules.',
    `total_amount` DECIMAL(18,2) COMMENT 'The final total amount due on the invoice, calculated as base fee plus adjustments plus taxes. This is the amount the distribution partner must pay.',
    `updated_by_user` STRING COMMENT 'The username or identifier of the user or system process that last modified this invoice record. Used for audit and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_distribution_carriage_fee_invoice PRIMARY KEY(`distribution_carriage_fee_invoice_id`)
) COMMENT 'Transactional billing record for carriage fees owed by or to distribution partners under active carriage agreements. Captures invoice period, fee amount, fee basis (per-subscriber, flat-rate, tiered), currency, payment due date, payment status, and reconciliation flags. Supports revenue assurance and financial reconciliation processes. Distinct from subscriber invoices (owned by billing domain) and advertising invoices (owned by advertising domain).';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` (
    `delivery_channel_id` BIGINT COMMENT 'Unique identifier for the delivery channel. Primary key.',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: Delivery channels use specific ABR profiles. delivery_channel.abr_profile is STRING but should FK to abr_profile master. Removes abr_profile STRING.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Linear channels have specific closed captioning, audio description, and accessibility compliance obligations under FCC CVAA rules. Each channel tracks its applicable obligations for compliance reporti',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Linear channels originate from specific facilities with master control. Required for FCC license compliance (facility identification) and channel origination tracking.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Linear delivery channels operate under specific broadcast licenses. FCC compliance, public inspection files, EAS participation, and closed captioning obligations all require linking channels to their ',
    `cdn_configuration_id` BIGINT COMMENT 'Foreign key linking to distribution.cdn_configuration. Business justification: Delivery channels use specific CDN configurations. delivery_channel.cdn_provider is STRING but should FK to cdn_configuration. Removes cdn_provider STRING.',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Delivery channels enforce specific DRM policies. delivery_channel.drm_system is STRING but should FK to drm_policy. Removes drm_system STRING.',
    `encoder_config_id` BIGINT COMMENT 'Foreign key linking to technology.encoder_config. Business justification: Delivery channels use encoder configurations for video/audio encoding. Required for channel encoding configuration and quality assurance.',
    `outage_record_id` BIGINT COMMENT 'Foreign key linking to technology.outage_record. Business justification: Delivery channels experience outages requiring regulatory reporting. Required for FCC outage reporting and channel SLA compliance tracking.',
    `ad_insertion_method` STRING COMMENT 'Technical method used for inserting advertisements into the content stream: server-side stitching, client-side insertion, DAI (Dynamic Ad Insertion), SCTE-35 marker-based, or none for ad-free channels.. Valid values are `server-side|client-side|dai|scte-35|none`',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the channel content (4:3 legacy, 16:9 widescreen standard, 21:9 cinematic).. Valid values are `4:3|16:9|21:9`',
    `audio_format` STRING COMMENT 'Audio encoding and delivery format supported by the channel (stereo, Dolby Digital 5.1, Dolby Atmos, DTS, AAC).. Valid values are `stereo|dolby-digital|dolby-atmos|dts|aac`',
    `blackout_rules_enabled` BOOLEAN COMMENT 'Indicates whether geographic or rights-based blackout restrictions are enforced for this channel (true) or not (false).',
    `carriage_fee_usd` DECIMAL(18,2) COMMENT 'Monthly or per-subscriber carriage fee paid by MVPDs or vMVPDs to carry this channel, expressed in USD. Confidential commercial data.',
    `channel_name` STRING COMMENT 'The official brand name of the delivery channel as presented to audiences (e.g., HBO Max, NBC Sports, Pluto TV Comedy).',
    `channel_number` STRING COMMENT 'Logical channel number or position in the Electronic Program Guide (EPG) lineup (e.g., 7.1, 502, virtual 12).',
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
    `secondary_language` STRING COMMENT 'ISO 639-3 three-letter code for the secondary audio track or subtitle language, if available (e.g., SAP - Secondary Audio Program).. Valid values are `^[a-z]{3}$`',
    `sla_uptime_percent` DECIMAL(18,2) COMMENT 'Contractual uptime guarantee for the channel expressed as a percentage (e.g., 99.95 for four nines availability).',
    `streaming_endpoint_url` STRING COMMENT 'Primary streaming endpoint URL or manifest URL for OTT and FAST channels. Confidential operational data.',
    `target_demographic` STRING COMMENT 'Primary audience demographic segment targeted by the channel programming (e.g., Adults 18-49, Kids 6-11, Women 25-54).',
    `target_market` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the primary geographic market for the channel (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery channel record was last modified.',
    CONSTRAINT pk_delivery_channel PRIMARY KEY(`delivery_channel_id`)
) COMMENT 'Master definition of a logical distribution channel — a named, configured delivery pathway through which content is transmitted to audiences. Covers linear broadcast channels (DVB-T, DVB-S, ATSC, QAM), OTT streaming channels, FAST channels (Pluto TV, Tubi, Samsung TV Plus, Roku Channel), and simulcast feeds. Captures channel name, call sign, channel number, channel type (linear, OTT, FAST, simulcast), delivery technology standard, resolution/format, language, target market, EPG linkage, operational status, and FAST-specific attributes where applicable (aggregator platform, playlist type, ad insertion method, content refresh cadence, monetization model). SSOT for channel identity within the distribution domain.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` (
    `drm_policy_id` BIGINT COMMENT 'Primary key for drm_policy',
    `technical_standard_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.technical_standard_cert. Business justification: DRM policies must meet technical standards (Widevine robustness levels, HDCP requirements, encryption schemes). Policy certification validates compliance with DRM specifications and security standards',
    `employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - DRM policies need an owner for security governance',
    `airplay_enabled` BOOLEAN COMMENT 'Flag indicating whether Apple AirPlay streaming to external devices is permitted.',
    `allowed_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where content playback is permitted.',
    `analog_output_control` STRING COMMENT 'Policy governing analog video output (allowed, restricted with downscaling, or completely blocked).. Valid values are `allowed|restricted|blocked`',
    `analog_sunset_enabled` BOOLEAN COMMENT 'Flag indicating whether analog output is progressively restricted or disabled (analog sunset policy).',
    `blocked_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where content playback is explicitly blocked.',
    `chromecast_enabled` BOOLEAN COMMENT 'Flag indicating whether Google Chromecast streaming to external devices is permitted.',
    `concurrent_stream_limit` STRING COMMENT 'The maximum number of simultaneous streams allowed per user account or license.',
    `content_key_reference` STRING COMMENT 'The unique identifier for the encryption key used to protect the content.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this DRM policy record was first created in the system.',
    `device_binding_enabled` BOOLEAN COMMENT 'Flag indicating whether licenses are bound to specific devices to prevent unauthorized sharing.',
    `drm_system` STRING COMMENT 'The DRM technology platform used for content protection (Widevine, PlayReady, FairPlay, Primetime, Marlin, ClearKey).. Valid values are `widevine|playready|fairplay|primetime|marlin|clearkey`',
    `drm_vendor` STRING COMMENT 'The vendor or provider of the DRM solution (e.g., Google, Microsoft, Apple, Adobe).',
    `effective_end_date` DATE COMMENT 'The date when this DRM policy expires or is no longer enforceable. Null indicates indefinite validity.',
    `effective_start_date` DATE COMMENT 'The date when this DRM policy becomes active and enforceable for content protection.',
    `encryption_scheme` STRING COMMENT 'The encryption scheme used for content protection (CENC, CBC1, CENS, CBCS) as defined by Common Encryption standards.. Valid values are `cenc|cbc1|cens|cbcs`',
    `geo_restriction_enabled` BOOLEAN COMMENT 'Flag indicating whether geographic restrictions are enforced for content delivery based on viewer location.',
    `hdcp_level_required` STRING COMMENT 'The minimum HDCP version required for output protection to prevent unauthorized digital copying. [ENUM-REF-CANDIDATE: none|hdcp_1_0|hdcp_1_1|hdcp_1_2|hdcp_1_3|hdcp_1_4|hdcp_2_0|hdcp_2_1|hdcp_2_2|hdcp_2_3 — 10 candidates stripped; promote to reference product]',
    `key_rotation_interval_hours` STRING COMMENT 'The frequency in hours at which encryption keys are rotated for enhanced security.',
    `license_duration_seconds` STRING COMMENT 'The validity period in seconds for a DRM license before it must be renewed.',
    `license_server_endpoint` STRING COMMENT 'The URL endpoint of the DRM license server that issues decryption keys to authorized clients.',
    `max_device_registrations` STRING COMMENT 'The maximum number of devices that can be registered for content playback per user account.',
    `offline_license_duration_hours` STRING COMMENT 'The maximum duration in hours that offline downloaded content remains playable before license expiration.',
    `offline_playback_enabled` BOOLEAN COMMENT 'Flag indicating whether content can be downloaded and played offline without an active internet connection.',
    `offline_playback_window_hours` STRING COMMENT 'The time window in hours during which offline content must be played once playback begins.',
    `persistent_license_enabled` BOOLEAN COMMENT 'Flag indicating whether licenses can be stored persistently on the device for offline or repeated playback.',
    `playback_duration_hours` STRING COMMENT 'The time window in hours during which content must be consumed once playback begins for rental content.',
    `policy_code` STRING COMMENT 'Unique business code or identifier for the DRM policy used across systems and platforms.',
    `policy_name` STRING COMMENT 'Human-readable name of the DRM policy for identification and reference purposes.',
    `policy_priority` STRING COMMENT 'The priority ranking of this policy when multiple policies could apply. Lower numbers indicate higher priority.',
    `policy_status` STRING COMMENT 'The current lifecycle status of the DRM policy (draft, active, suspended, deprecated, retired).. Valid values are `draft|active|suspended|deprecated|retired`',
    `rental_duration_hours` STRING COMMENT 'The total rental period in hours during which content is accessible for Transactional Video On Demand (TVOD) rentals.',
    `screen_capture_blocked` BOOLEAN COMMENT 'Flag indicating whether screen capture and recording are blocked during content playback.',
    `security_level` STRING COMMENT 'The security level required for DRM implementation (software or hardware-based cryptography and decoding).. Valid values are `sw_secure_crypto|sw_secure_decode|hw_secure_crypto|hw_secure_decode|hw_secure_all`',
    `token_expiry_seconds` STRING COMMENT 'The expiration time in seconds for authentication tokens used in DRM license acquisition.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this DRM policy record was last modified.',
    `widevine_security_level` STRING COMMENT 'The Widevine-specific security level (L1 hardware-backed, L2 software-backed, L3 software only).. Valid values are `L1|L2|L3`',
    `created_by` STRING COMMENT 'The user or system identifier that created this DRM policy record.',
    CONSTRAINT pk_drm_policy PRIMARY KEY(`drm_policy_id`)
) COMMENT 'Reference master defining Digital Rights Management packaging and enforcement policies applied to content streams. Captures DRM system (Widevine, PlayReady, FairPlay), license server endpoint, key rotation interval, output control rules (HDCP level, analog sunset), geo-restriction enforcement flag, offline download permissions, concurrent stream limits, and token expiry settings. Governs how content is protected during OTT and MVPD delivery.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` (
    `cdn_configuration_id` BIGINT COMMENT 'Unique identifier for the CDN configuration record. Primary key for the cdn_configuration product.',
    `channel_id` BIGINT COMMENT 'Reference to the delivery channel or OTT service to which this CDN configuration is assigned.',
    `broadcast_facility_id` BIGINT COMMENT 'add column technology_broadcast_facility_id (BIGINT) with FK to technology.broadcast_facility.broadcast_facility_id - CDN configurations are deployed at specific broadcast facilities and need infrastructure linkage',
    `employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - CDN configurations require an owner/responsible engineer for change management',
    `activated_timestamp` TIMESTAMP COMMENT 'The timestamp when this CDN configuration was activated and began serving live traffic.',
    `bandwidth_limit_gbps` DECIMAL(18,2) COMMENT 'The maximum bandwidth capacity provisioned for this CDN configuration in gigabits per second. Exceeding this limit may trigger throttling or overage charges.',
    `cache_control_header` STRING COMMENT 'HTTP Cache-Control header directives applied to CDN responses, controlling caching behavior at edge and client levels.',
    `cache_ttl_seconds` STRING COMMENT 'Duration in seconds that content is cached at the CDN edge before revalidation with the origin. Controls freshness and origin load.',
    `cdn_provider` STRING COMMENT 'The CDN vendor providing content delivery services for this configuration. Akamai is the primary provider per operational systems of record.. Valid values are `akamai|cloudflare|cloudfront|fastly|limelight|level3`',
    `compression_enabled` BOOLEAN COMMENT 'Indicates whether content compression (gzip, brotli) is enabled at the CDN edge to reduce bandwidth consumption and improve delivery performance.',
    `configuration_name` STRING COMMENT 'Human-readable name for this CDN configuration, used for operational identification and management.',
    `cost_per_gb` DECIMAL(18,2) COMMENT 'The contracted cost per gigabyte of data transferred through this CDN configuration. Used for cost allocation and financial reconciliation.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this CDN configuration record was first created in the system.',
    `deactivated_timestamp` TIMESTAMP COMMENT 'The timestamp when this CDN configuration was deactivated and stopped serving traffic. Null for active configurations.',
    `failover_origin_url` STRING COMMENT 'Secondary origin server URL used for redundancy and failover when the primary origin is unavailable.',
    `geo_blocking_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes subject to geo-blocking rules (allowed or denied based on mode).',
    `geo_blocking_enabled` BOOLEAN COMMENT 'Indicates whether geographic content restrictions are enforced at the CDN edge based on viewer location.',
    `geo_blocking_mode` STRING COMMENT 'Specifies whether the geo-blocking rules operate as an allow-list (whitelist) or deny-list (blacklist) of countries.. Valid values are `allow_list|deny_list`',
    `health_check_interval_seconds` STRING COMMENT 'Frequency in seconds at which health checks are performed against this CDN configuration to detect outages or degradation.',
    `health_check_url` STRING COMMENT 'The URL endpoint used by monitoring systems to verify CDN configuration availability and responsiveness.',
    `http2_enabled` BOOLEAN COMMENT 'Indicates whether HTTP/2 protocol is enabled for this CDN configuration to improve streaming performance through multiplexing and header compression.',
    `ipv6_enabled` BOOLEAN COMMENT 'Indicates whether IPv6 addressing is enabled for this CDN configuration to support next-generation internet protocol delivery.',
    `last_health_check_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent successful health check performed against this CDN configuration.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this CDN configuration record was last modified or updated.',
    `operational_status` STRING COMMENT 'Current operational state of this CDN configuration. Active configurations are serving live traffic; inactive configurations are not in use.. Valid values are `active|inactive|suspended|testing`',
    `origin_pull_url` STRING COMMENT 'The origin server URL from which the CDN pulls content when not cached. Typically points to the media asset management system or playout server.',
    `prefetch_enabled` BOOLEAN COMMENT 'Indicates whether content prefetching is enabled to proactively cache content at edge locations before viewer requests.',
    `property_hostname` STRING COMMENT 'The fully qualified domain name (FQDN) of the CDN property or edge hostname used for content delivery.',
    `provisioned_date` DATE COMMENT 'The date when this CDN configuration was initially provisioned and deployed to the CDN provider infrastructure.',
    `query_string_caching_mode` STRING COMMENT 'Defines how URL query string parameters are handled in cache key generation. Controls cache efficiency and personalization support.. Valid values are `ignore_all|include_all|include_specified`',
    `sla_tier` STRING COMMENT 'The contracted service level tier for this CDN configuration, determining uptime guarantees, support response times, and performance commitments.. Valid values are `premium|standard|basic`',
    `sla_uptime_target_percent` DECIMAL(18,2) COMMENT 'The contracted uptime percentage guarantee for this CDN configuration (e.g., 99.99%). Used for SLA compliance monitoring and reporting.',
    `ssl_certificate_expiry_date` DATE COMMENT 'The expiration date of the SSL/TLS certificate. Operations teams must renew certificates before this date to prevent service disruption.',
    `ssl_certificate_reference` STRING COMMENT 'Reference identifier or serial number of the SSL/TLS certificate deployed on the CDN property for secure HTTPS delivery.',
    `token_authentication_enabled` BOOLEAN COMMENT 'Indicates whether token-based authentication is enabled for this CDN configuration to prevent unauthorized access to content.',
    `token_authentication_scheme` STRING COMMENT 'The method by which authentication tokens are passed to the CDN edge for validation (query parameter, cookie, or HTTP header).. Valid values are `query_string|cookie|header`',
    `token_secret_key` STRING COMMENT 'The cryptographic secret key used to generate and validate authentication tokens. Must be kept confidential and rotated regularly.',
    CONSTRAINT pk_cdn_configuration PRIMARY KEY(`cdn_configuration_id`)
) COMMENT 'Master configuration record for CDN (Akamai) delivery properties assigned to a delivery channel or OTT service. Captures CDN provider, property hostname, origin pull URL, caching rules (TTL, cache-control headers), token authentication settings, geo-blocking rules, failover origin configuration, SSL certificate reference, and SLA tier. Enables operations teams to manage Akamai CDN settings per channel and delivery endpoint.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` (
    `delivery_sla_id` BIGINT COMMENT 'Unique identifier for the delivery SLA record. Primary key.',
    `distribution_partner_id` BIGINT COMMENT 'add column distribution_distribution_partner_id (BIGINT) with FK to distribution.distribution_partner.distribution_partner_id - delivery SLAs are negotiated with specific distribution partners',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Delivery SLAs require ownership for target setting, measurement validation, penalty negotiation, and partner contract alignment. Essential for accountability in service quality, escalation paths, perf',
    `applicable_platform` STRING COMMENT 'Specific platform, device type, or streaming protocol this SLA applies to (e.g., HLS, MPEG-DASH, mobile, smart TV).',
    `approval_status` STRING COMMENT 'Current approval status of the SLA document or agreement.. Valid values are `approved|pending|rejected|under_review`',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this SLA.',
    `approved_date` DATE COMMENT 'Date when this SLA was formally approved.',
    `cdn_availability_target_percent` DECIMAL(18,2) COMMENT 'Target availability percentage for CDN infrastructure supporting content delivery.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA record was first created in the system.',
    `data_source` STRING COMMENT 'System or platform from which SLA performance metrics are collected (e.g., CDN analytics, QoS monitoring system).',
    `delivery_sla_status` STRING COMMENT 'Current lifecycle status of the SLA record (e.g., active, inactive, suspended, expired, draft, pending approval).. Valid values are `active|inactive|suspended|expired|draft|pending_approval`',
    `delivery_sla_description` STRING COMMENT 'Detailed description of the SLA scope, objectives, and key commitments.',
    `distribution_channel` STRING COMMENT 'The distribution channel or platform type this SLA applies to (e.g., linear broadcast, OTT streaming, MVPD carriage, vMVPD, FAST channel, CDN).. Valid values are `linear|ott|mvpd|vmvpd|fast|cdn`',
    `effective_end_date` DATE COMMENT 'Date when this SLA expires or is no longer enforceable. Null indicates an open-ended agreement.',
    `effective_start_date` DATE COMMENT 'Date when this SLA becomes active and enforceable.',
    `error_rate_threshold_percent` DECIMAL(18,2) COMMENT 'Maximum allowable error rate percentage for delivery failures, buffering events, or playback errors.',
    `escalation_contact_email` STRING COMMENT 'Email address of the escalation contact for SLA breach notifications and coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `escalation_contact_name` STRING COMMENT 'Name of the primary contact person for SLA breach escalation and resolution.',
    `escalation_contact_phone` STRING COMMENT 'Phone number of the escalation contact for urgent SLA breach communications.',
    `exclusion_criteria` STRING COMMENT 'Conditions or events excluded from SLA measurement (e.g., planned maintenance, force majeure, third-party failures).',
    `geographic_scope` STRING COMMENT 'Geographic regions or markets where this SLA applies (e.g., North America, EMEA, APAC, or specific country codes).',
    `max_latency_ms` STRING COMMENT 'Maximum allowable latency in milliseconds for content delivery from origin to edge or end-user device.',
    `measurement_frequency` STRING COMMENT 'Frequency at which SLA performance metrics are collected and reported.. Valid values are `real-time|hourly|daily|weekly|monthly`',
    `measurement_window` STRING COMMENT 'Time window over which SLA metrics are measured and evaluated (e.g., monthly, quarterly).. Valid values are `hourly|daily|weekly|monthly|quarterly`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA record was last modified or updated.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this SLA.',
    `owner_department` STRING COMMENT 'Business department or team responsible for managing and enforcing this SLA (e.g., Distribution Operations, Partner Management).',
    `partner_name` STRING COMMENT 'Name of the distribution partner, MVPD, vMVPD, or OTT platform to which this SLA applies.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount applied per SLA breach incident or measurement period.',
    `penalty_clause` STRING COMMENT 'Description of financial or service penalties applied when SLA commitments are breached.',
    `penalty_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for penalty amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `reporting_frequency` STRING COMMENT 'Frequency at which SLA performance reports are delivered to stakeholders and partners.. Valid values are `real-time|daily|weekly|monthly|quarterly`',
    `service_tier` STRING COMMENT 'Service tier classification indicating the level of delivery service provided under this SLA.. Valid values are `premium|standard|basic|enterprise`',
    `sla_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the SLA tier for operational reference and system integration.',
    `sla_name` STRING COMMENT 'Business-friendly name of the SLA tier or agreement (e.g., Premium Delivery SLA, Standard OTT SLA).',
    `sla_tier` STRING COMMENT 'Classification tier of the SLA indicating the level of service commitment (e.g., platinum for highest priority, bronze for basic service).. Valid values are `platinum|gold|silver|bronze|standard|basic`',
    `stream_start_time_target_ms` STRING COMMENT 'Target time in milliseconds for stream initialization and first frame delivery to the viewer.',
    `uptime_commitment_percent` DECIMAL(18,2) COMMENT 'Guaranteed uptime percentage for content delivery availability (e.g., 99.95% uptime commitment).',
    `version_number` STRING COMMENT 'Version number of the SLA document for change tracking and audit purposes.',
    CONSTRAINT pk_delivery_sla PRIMARY KEY(`delivery_sla_id`)
) COMMENT 'Master record defining Service Level Agreements governing content delivery performance commitments per distribution channel or partner. Captures SLA tier name, uptime commitment (%), maximum allowable latency (ms), stream start time target, error rate threshold, CDN availability target, measurement window, penalty clauses, and escalation contacts. Used to monitor and enforce delivery quality obligations with MVPDs, vMVPDs, and OTT platform partners.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` (
    `signal_route_id` BIGINT COMMENT 'Unique identifier for the signal routing path. Primary key for the signal route entity.',
    `abr_profile_id` BIGINT COMMENT 'Identifier of the Adaptive Bitrate (ABR) profile applied to this signal route, defining rendition ladder, bitrates, and encoding parameters for streaming delivery.',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Signal routes originate/terminate at broadcast facilities. Complements existing satellite_transponder_id FK for complete path topology and signal troubleshooting.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Signal routing from broadcast facilities to distribution points must track originating broadcast license for compliance with transmission power, coverage area, frequency allocation, and technical stan',
    `cdn_configuration_id` BIGINT COMMENT 'Unique identifier for the CDN configuration profile applied to this signal route, defining caching, security, and delivery policies.',
    `network_circuit_id` BIGINT COMMENT 'Foreign key linking to technology.network_circuit. Business justification: Signal routes traverse specific network circuits. Required for signal path redundancy design and circuit failover testing.',
    `channel_id` BIGINT COMMENT 'Identifier of the specific playout channel within the playout system that originates the signal for this route.',
    `satellite_transponder_id` BIGINT COMMENT 'Identifier of the satellite transponder used for uplink or downlink transmission in satellite-based signal routes.',
    `sla_definition_id` BIGINT COMMENT 'Identifier of the Service Level Agreement (SLA) definition governing uptime, performance, and quality commitments for this signal route.',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: Signal routes originate from streaming endpoints. signal_route.origin_endpoint_url is STRING but should FK to streaming_endpoint. Removes origin_endpoint_url STRING.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Signal routes are broadcast infrastructure requiring technical ownership for failover testing, maintenance windows, satellite coordination, and IRD management. Essential for FCC compliance ownership, ',
    `activated_timestamp` TIMESTAMP COMMENT 'Timestamp when the signal route was activated and made operational for live signal transmission.',
    `backup_path_description` STRING COMMENT 'Detailed description of the backup or redundant signal routing path used for failover in case of primary path failure.',
    `bandwidth_mbps` DECIMAL(18,2) COMMENT 'Allocated bandwidth capacity for this signal route in megabits per second (Mbps), defining the maximum throughput for signal transmission.',
    `cdn_provider` STRING COMMENT 'Name of the Content Delivery Network provider handling signal distribution for OTT and streaming routes (e.g., Akamai, Cloudflare, AWS CloudFront).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the signal route record was first created in the system.',
    `deactivated_timestamp` TIMESTAMP COMMENT 'Timestamp when the signal route was deactivated or taken out of service, if applicable.',
    `destination_endpoint_url` STRING COMMENT 'Uniform Resource Locator (URL) of the destination endpoint where the signal is delivered (CDN origin, distribution partner, or broadcast facility).',
    `downlink_frequency_mhz` DECIMAL(18,2) COMMENT 'Downlink reception frequency in megahertz (MHz) for satellite signal routes.',
    `drm_license_server_url` STRING COMMENT 'Uniform Resource Locator (URL) of the DRM license server that issues decryption keys for protected content delivered via this route.',
    `drm_system` STRING COMMENT 'Digital Rights Management (DRM) system applied to the signal route for content protection (e.g., Widevine, PlayReady, FairPlay).',
    `encryption_algorithm` STRING COMMENT 'Cryptographic algorithm used for signal encryption (e.g., AES-128, AES-256).',
    `encryption_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether signal encryption is enabled for this route to protect content during transmission.',
    `failover_mode` STRING COMMENT 'Method by which the signal route switches from primary to backup path during a failure event (automatic, manual, or hybrid).. Valid values are `automatic|manual|hybrid`',
    `failover_priority` STRING COMMENT 'Numeric priority ranking determining the order in which this route is selected during failover scenarios (lower number indicates higher priority).',
    `failover_threshold_seconds` STRING COMMENT 'Maximum allowable signal interruption duration in seconds before automatic failover to backup path is triggered.',
    `geographic_region` STRING COMMENT 'Geographic region or market served by this signal route (e.g., North America, EMEA, APAC, specific country or metro area).',
    `ird_model` STRING COMMENT 'Model name and identifier of the Integrated Receiver Decoder (IRD) equipment used to receive and decode the satellite or terrestrial signal.',
    `ird_serial_number` STRING COMMENT 'Serial number of the IRD equipment deployed for this signal route, used for asset tracking and maintenance.',
    `latency_target_ms` STRING COMMENT 'Target end-to-end latency in milliseconds for signal delivery from origin to destination, critical for live broadcast and low-latency streaming.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the signal route record was last modified or updated.',
    `operational_status` STRING COMMENT 'Current operational state of the signal route indicating availability and readiness for broadcast or streaming delivery.. Valid values are `active|standby|inactive|maintenance|testing|decommissioned`',
    `playout_system_code` BIGINT COMMENT 'Identifier of the playout automation system serving as the origin source for this signal route (e.g., Ericsson MediaFirst instance).',
    `polarization` STRING COMMENT 'Polarization mode of the satellite signal transmission (horizontal, vertical, left circular, right circular).. Valid values are `horizontal|vertical|left_circular|right_circular`',
    `primary_path_description` STRING COMMENT 'Detailed description of the primary signal routing path, including intermediate hops, network segments, and infrastructure components.',
    `provisioned_date` DATE COMMENT 'Date when the signal route was initially provisioned and configured in the broadcast or streaming infrastructure.',
    `qos_tier` STRING COMMENT 'Quality of Service tier assigned to this signal route, determining priority, bandwidth allocation, and service level guarantees.. Valid values are `premium|standard|basic`',
    `route_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the signal route in operational systems and documentation.',
    `route_name` STRING COMMENT 'Human-readable name identifying the signal routing path, typically describing the source-to-destination flow (e.g., Studio-A-to-East-Coast-Uplink).',
    `route_type` STRING COMMENT 'Classification of the signal routing path based on delivery technology and infrastructure (linear broadcast, OTT streaming, hybrid, satellite uplink, terrestrial transmission, IP interconnect).. Valid values are `linear_broadcast|ott_streaming|hybrid|satellite_uplink|terrestrial|ip_interconnect`',
    `streaming_protocol` STRING COMMENT 'Application-layer streaming protocol used for adaptive bitrate delivery in OTT scenarios (e.g., HLS, DASH, Smooth Streaming).',
    `transport_protocol` STRING COMMENT 'Technical protocol used for signal transport and delivery across the routing path. Includes HTTP Live Streaming (HLS), MPEG Dynamic Adaptive Streaming over HTTP (MPEG-DASH), User Datagram Protocol/Transport Stream (UDP/TS), Digital Video Broadcasting Satellite Second Generation (DVB-S2), and others. [ENUM-REF-CANDIDATE: HLS|MPEG-DASH|UDP/TS|DVB-S2|DVB-T2|ATSC|RTP|RTMP|SRT — 9 candidates stripped; promote to reference product]',
    `uplink_frequency_mhz` DECIMAL(18,2) COMMENT 'Uplink transmission frequency in megahertz (MHz) for satellite signal routes.',
    CONSTRAINT pk_signal_route PRIMARY KEY(`signal_route_id`)
) COMMENT 'Master record defining the end-to-end signal routing path for a broadcast or streaming feed — from playout origin through satellite uplink, terrestrial transmission, CDN origin, or IP interconnect to the distribution endpoint. Captures source playout system (Ericsson MediaFirst), transport protocol (HLS, MPEG-DASH, UDP/TS, DVB-S2), uplink/downlink transponder details, IRD configuration, primary and backup path definitions, and failover priority. Critical for linear broadcast operations.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` (
    `release_window_id` BIGINT COMMENT 'Primary key for release_window',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Distribution windows have rating-specific restrictions (R-rated content excluded from daytime windows, TV-Y required for childrens blocks). Content rating determines window eligibility and ad inserti',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.talent_contract. Business justification: Distribution windows (theatrical, streaming, syndication) are often governed by talent contract terms including exclusivity clauses, holdback periods, and platform restrictions. Rights clearance workf',
    `coppa_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.coppa_declaration. Business justification: Distribution windows for childrens content require COPPA declarations. Window-specific data collection practices (viewing analytics, personalization) must be declared and parental consent obtained.',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Windowing strategies target specific demographics to maximize revenue across release windows. Theatrical windows target A18-49, SVOD windows target families, and AVOD windows target broader demos for ',
    `distribution_partner_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_partner. Business justification: Release windows are negotiated with distribution partners. release_window.platform_name is STRING but should FK to distribution_partner. Removes platform_name STRING.',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Release windows have DRM requirements. release_window.drm_requirement is STRING but should FK to drm_policy. Removes drm_requirement STRING.',
    `license_agreement_id` BIGINT COMMENT 'Reference to the underlying rights and licensing agreement that governs this distribution window.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Distribution windows define platform/territory/pricing rules per-asset. Windowing strategy (SVOD→TVOD→AVOD progression) requires asset-level binding. Media-broadcasting operators manage release calend',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Distribution windows (theatrical, SVOD, AVOD, TVOD) represent distinct revenue streams with different recognition methods and GL accounts. Content licensing revenue is recognized differently by window',
    `segment_id` BIGINT COMMENT 'Foreign key linking to audience.audience_segment. Business justification: Advanced windowing uses behavioral segments for platform-specific releases and personalized availability windows. Supports binge-release strategies, sports fan exclusives, and genre-based holdback opt',
    `title_id` BIGINT COMMENT 'Reference to the content title (film, series, episode, or program) subject to this distribution window.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Release windows are strategic revenue decisions requiring business owner for holdback negotiations, pricing decisions, exclusivity terms, and PVOD/TVOD strategy. Essential for P&L accountability, righ',
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
    `abr_profile_id` BIGINT COMMENT 'Reference to the ABR profile configuration used for this adaptive streaming delivery.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: When delivery_event records ad delivery (dai_enabled flag), linking to campaign enables campaign-level delivery verification and performance tracking. Essential for bridging distribution delivery logs [FK namespace reconciled: points to sales.campaign]',
    `channel_id` BIGINT COMMENT 'Reference to the distribution channel through which content was delivered (linear broadcast channel, OTT platform, FAST channel).',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Content delivery logs require demographic context for Nielsen measurement reconciliation, audience guarantee validation, and cross-platform deduplication. Supports C3/C7 commercial ratings and makegoo',
    `device_type_id` BIGINT COMMENT 'Reference to the device type used by the viewer for this delivery event.',
    `eas_log_id` BIGINT COMMENT 'Foreign key linking to compliance.eas_log. Business justification: Delivery events for emergency alert system messages must be logged for FCC compliance. Each EAS delivery creates a compliance log entry documenting transmission, relay, and attention signal.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Delivery events represent actual content delivery under specific rights grants. Essential for usage tracking, run count enforcement, and royalty calculation based on actual exploitation. Enables right',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: Market attribution of delivery events enables DMA-level reporting, geographic blackout enforcement, local advertising compliance, and Nielsen station index measurement for broadcast and streaming conv',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset being delivered in this event.',
    `playback_session_id` BIGINT COMMENT 'Reference to the playback session associated with this delivery event for OTT/streaming deliveries.',
    `streaming_endpoint_id` BIGINT COMMENT 'Reference to the streaming endpoint used for OTT delivery events.',
    `transmission_equipment_id` BIGINT COMMENT 'Foreign key linking to technology.transmission_equipment. Business justification: Delivery events link to transmission equipment for performance tracking. Required for equipment performance reporting and failure pattern analysis.',
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
    `delivery_channel_type` STRING COMMENT 'Classification of the delivery channel type (linear broadcast, OTT streaming, VOD, FAST channel, MVPD, vMVPD).. Valid values are `linear_broadcast|ott_streaming|vod|fast_channel|mvpd|vmvpd`',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` (
    `sla_breach_id` BIGINT COMMENT 'Unique identifier for the SLA breach record. Primary key for the sla_breach product.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: SLA breaches with distribution partners trigger penalty payments or makegood obligations, creating A/P liabilities. Quarterly SLA review creates A/P accruals for penalties owed to partners per carriag',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: SLA breaches violating regulatory commitments (accessibility uptime, emergency alert delivery, closed caption availability) escalate to compliance incidents. Breach severity and regulatory impact dete',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: SLA breaches require incident ownership for root cause analysis, remediation coordination, partner communication, and penalty mitigation. Essential for on-call rotations, incident postmortems, perform',
    `noc_alert_id` BIGINT COMMENT 'Foreign key linking to technology.noc_alert. Business justification: SLA breaches are triggered by NOC alerts. Required for breach root cause analysis and penalty dispute resolution traceability.',
    `sla_definition_id` BIGINT COMMENT 'Reference to the SLA definition that was breached, linking to the specific SLA commitment and thresholds.',
    `streaming_endpoint_id` BIGINT COMMENT 'Reference to the streaming endpoint where the breach occurred, identifying the specific delivery channel affected.',
    `affected_platform` STRING COMMENT 'The distribution platform or service tier affected by the breach, such as OTT, MVPD, or FAST channel.',
    `affected_region` STRING COMMENT 'The geographic region or CDN Point of Presence (POP) where the breach occurred, identifying the scope of impact.',
    `breach_duration_minutes` STRING COMMENT 'The total duration of the SLA breach in minutes, from detection to restoration of service within SLA parameters.',
    `breach_severity` STRING COMMENT 'The severity classification of the breach based on business impact, used for prioritization and escalation.. Valid values are `critical|high|medium|low`',
    `breach_status` STRING COMMENT 'Current state of the breach in its resolution lifecycle, tracking progress from detection through closure.. Valid values are `open|acknowledged|investigating|resolved|closed|disputed`',
    `breach_timestamp` TIMESTAMP COMMENT 'The exact date and time when the SLA breach was detected and recorded. This is the principal business event timestamp for the breach.',
    `cdn_provider` STRING COMMENT 'The CDN provider responsible for content delivery at the time of the breach, used for vendor accountability.',
    `contract_reference` STRING COMMENT 'Reference to the contract or service agreement under which the SLA commitment was made, used for dispute resolution.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this breach record was first created in the system for audit trail purposes.',
    `detection_method` STRING COMMENT 'The method by which the SLA breach was detected, indicating whether it was proactive monitoring or reactive reporting.. Valid values are `automated_monitoring|customer_report|manual_audit|health_check|synthetic_test`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the breach determination or penalty is under dispute by the partner or service provider.',
    `dispute_reason` STRING COMMENT 'Explanation provided for disputing the breach determination, penalty calculation, or responsibility assignment.',
    `escalation_level` STRING COMMENT 'The escalation tier reached during breach resolution, indicating the organizational level involved in remediation.. Valid values are `none|tier_1|tier_2|tier_3|executive`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this breach record was last updated, tracking changes throughout the breach lifecycle.',
    `makegood_triggered_flag` BOOLEAN COMMENT 'Indicates whether a makegood (compensatory delivery or ad spot) was triggered as a result of this breach.',
    `measured_value` DECIMAL(18,2) COMMENT 'The actual measured value of the metric at the time of breach, representing the performance level that violated the SLA threshold.',
    `metric_name` STRING COMMENT 'The specific SLA metric that was breached, such as uptime percentage, latency, error rate, or availability.',
    `metric_type` STRING COMMENT 'Category of the SLA metric that was breached, classifying the nature of the performance issue.. Valid values are `availability|latency|throughput|error_rate|response_time|packet_loss`',
    `notes` STRING COMMENT 'Additional free-text notes or comments regarding the breach, investigation, or resolution for operational context.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether breach notification was sent to affected partners, stakeholders, or customers as required by SLA terms.',
    `notification_timestamp` TIMESTAMP COMMENT 'The date and time when breach notification was sent to affected parties.',
    `partner_name` STRING COMMENT 'The name of the distribution partner or MVPD affected by the breach, relevant for partner SLA reporting.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The monetary penalty or service credit amount triggered by the breach, as defined in the SLA contract.',
    `penalty_applicable_flag` BOOLEAN COMMENT 'Indicates whether a contractual penalty or credit is applicable for this breach based on SLA terms.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount.. Valid values are `^[A-Z]{3}$`',
    `remediation_action` STRING COMMENT 'Description of the corrective action taken to resolve the breach and restore service to acceptable levels.',
    `resolution_timestamp` TIMESTAMP COMMENT 'The date and time when the breach was resolved and service was restored to within SLA parameters.',
    `root_cause_category` STRING COMMENT 'High-level categorization of the underlying cause of the SLA breach, used for trend analysis and preventive action.. Valid values are `cdn_failure|origin_failure|network_congestion|ddos_attack|configuration_error|capacity_exceeded`',
    `root_cause_description` STRING COMMENT 'Detailed narrative explanation of the root cause identified through investigation, providing context for the breach.',
    `streaming_protocol` STRING COMMENT 'The streaming protocol in use when the breach occurred, such as HLS or MPEG-DASH.. Valid values are `HLS|MPEG-DASH|Smooth Streaming|RTMP|WebRTC`',
    `threshold_value` DECIMAL(18,2) COMMENT 'The SLA threshold value that was violated, representing the minimum acceptable performance level defined in the SLA commitment.',
    `unit_of_measure` STRING COMMENT 'The unit in which the metric is measured, such as percentage, milliseconds, Mbps, or requests per second.',
    `validated_by` STRING COMMENT 'The user or system that validated the breach measurement and determination, ensuring accuracy for reporting.',
    `validated_timestamp` TIMESTAMP COMMENT 'The date and time when the breach record was validated and approved for reporting or penalty processing.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance expressed as a percentage of the threshold, providing a normalized measure of breach severity.',
    `variance_value` DECIMAL(18,2) COMMENT 'The calculated difference between the measured value and the threshold value, quantifying the magnitude of the breach.',
    CONSTRAINT pk_sla_breach PRIMARY KEY(`sla_breach_id`)
) COMMENT 'Transactional record capturing instances where a delivery SLA commitment was violated for a distribution channel or partner. Captures breach timestamp, affected delivery channel, SLA metric breached (uptime, latency, error rate), measured value, SLA threshold, breach duration, root cause category, resolution timestamp, and whether a makegood or penalty was triggered. Supports partner SLA reporting, dispute resolution, and operational improvement tracking.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` (
    `dai_session_id` BIGINT COMMENT 'Unique identifier for the DAI session. Primary key for the dai_session product.',
    `ad_order_id` BIGINT COMMENT 'Foreign key linking to sales.ad_order. Business justification: DAI sessions fulfill contracted ad orders. Linking to ad_order enables order-level delivery tracking, contracted-vs-actual reconciliation, billing verification, and order fulfillment reporting. Essent [FK namespace reconciled: points to sales.ad_order]',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Distribution DAI sessions serve ads from specific advertising campaigns. Linking enables campaign-level delivery reporting, pacing analysis, cross-domain revenue attribution, and campaign performance  [FK namespace reconciled: points to sales.campaign]',
    `channel_id` BIGINT COMMENT 'Reference to the linear or FAST channel on which the DAI session occurred. Applicable for live broadcast and FAST channel monetization.',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Dynamic ad insertion must respect content rating for ad appropriateness (no alcohol ads in childrens programming). Real-time rating checks during ad decisioning ensure compliance.',
    `dai_configuration_id` BIGINT COMMENT 'Foreign key linking to distribution.dai_configuration. Business justification: DAI sessions should reference the configuration used. Tracks which DAI config was applied during the session. Removes dai_provider STRING (derivable from dai_configuration).',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Real-time demographic targeting drives programmatic ad decisioning, frequency capping by demo, and guaranteed audience delivery. Essential for upfront commitment fulfillment and Nielsen-rated commerci',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: DAI sessions insert ads into content governed by specific rights grants. Ad insertion rights, ad load limits, and ad revenue share calculations depend on the underlying rights grant. Essential for rig',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset (video, live stream, FAST channel) being delivered when the DAI session was executed.',
    `playback_session_id` BIGINT COMMENT 'Reference to the parent streaming playback session during which this DAI session occurred. Links DAI monetization events to viewer streaming activity.',
    `political_ad_record_id` BIGINT COMMENT 'Foreign key linking to compliance.political_ad_record. Business justification: DAI sessions inserting political ads must create political ad records for FCC public inspection files. Real-time ad insertion generates compliance documentation including sponsor identification and ra',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: DAI (dynamic ad insertion) sessions generate advertising revenue streams. Daily ad revenue reconciliation ties DAI sessions to revenue streams for accrual accounting and reconciliation with ad server ',
    `segment_id` BIGINT COMMENT 'Foreign key linking to audience.audience_segment. Business justification: Behavioral audience segments enable advanced programmatic targeting beyond demographics, supporting lookalike modeling, cross-platform campaign optimization, and addressable advertising in modern ad t',
    `streaming_endpoint_id` BIGINT COMMENT 'Reference to the streaming endpoint (CDN edge, origin server) that served the DAI-enabled stream.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier for the subscriber or viewer associated with this DAI session. Enables personalized ad targeting and frequency capping.',
    `ad_decision_server_response_time_ms` STRING COMMENT 'Time in milliseconds taken by the ad decision server to respond with ad selection. Critical for measuring DAI latency and QoS.',
    `ad_decision_server_url` STRING COMMENT 'URL of the ad decision server (ADS) that was queried to determine which ads to insert. Typically a VAST or VMAP endpoint.',
    `ad_pod_duration_seconds` DECIMAL(18,2) COMMENT 'Total duration of the ad pod in seconds. Represents the available inventory window for ad insertion.',
    `ad_pod_position` STRING COMMENT 'Position of the ad pod within the content stream. Indicates whether ads were served before content (pre-roll), during content (mid-roll), or after content (post-roll).. Valid values are `pre_roll|mid_roll|post_roll|overlay|pause_ad|companion`',
    `ad_pod_sequence_number` STRING COMMENT 'Sequential number of this ad pod within the content playback session. Enables tracking of multiple ad breaks within a single viewing session.',
    `ad_targeting_segment_ids` STRING COMMENT 'Comma-separated list of audience segment IDs applied for ad targeting during this DAI session. Links to audience segmentation and personalization strategies.',
    `ads_fallback_count` STRING COMMENT 'Number of fallback or house ads served when primary ad inventory was unavailable. Indicates unfilled demand.',
    `ads_inserted_count` STRING COMMENT 'Number of ads successfully inserted and delivered during this DAI session. Used to calculate fill rate and monetization efficiency.',
    `ads_requested_count` STRING COMMENT 'Number of ad slots requested from the ad decision server for this DAI session. Represents the maximum fill capacity of the ad pod.',
    `app_version` STRING COMMENT 'Version of the streaming application or player that executed the DAI session. Used for troubleshooting and feature compatibility analysis.',
    `blackout_override_flag` BOOLEAN COMMENT 'Indicates whether geographic blackout restrictions were overridden for this DAI session. True if blackout rules were bypassed (e.g., for authenticated subscribers).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this DAI session record was first created in the system. Used for data lineage and audit trail.',
    `device_type` STRING COMMENT 'Type of device on which the DAI session was delivered. Influences ad format compatibility and targeting strategies. [ENUM-REF-CANDIDATE: smart_tv|mobile|tablet|desktop|set_top_box|gaming_console|streaming_stick|other — 8 candidates stripped; promote to reference product]',
    `drm_enforcement_flag` BOOLEAN COMMENT 'Indicates whether DRM protection was enforced on the ad-stitched stream. True if ads were delivered with DRM encryption.',
    `error_code` STRING COMMENT 'Error code returned if the DAI session encountered a failure. Used for troubleshooting ad delivery issues and optimizing fill rates.',
    `error_message` STRING COMMENT 'Human-readable error message describing the failure reason if the DAI session did not complete successfully.',
    `fill_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of requested ad slots that were successfully filled with paid ads. Calculated as (ads_inserted_count / ads_requested_count) * 100. Key monetization metric.',
    `frequency_cap_applied_flag` BOOLEAN COMMENT 'Indicates whether frequency capping rules were applied to limit ad repetition for this viewer. True if frequency cap was enforced.',
    `geographic_country_code` STRING COMMENT 'Three-letter ISO country code representing the viewers geographic location. Derived from IP address or device GPS. Used for geo-targeted ad campaigns.. Valid values are `^[A-Z]{3}$`',
    `geographic_dma_code` STRING COMMENT 'Nielsen Designated Market Area code representing the viewers media market. Critical for local advertising sales and audience measurement alignment.',
    `geographic_region` STRING COMMENT 'State, province, or region where the viewer was located during the DAI session. Enables regional ad targeting and compliance with local advertising regulations.',
    `platform_type` STRING COMMENT 'Operating system or platform on which the DAI-enabled player was running. Critical for device-specific ad targeting and compatibility. [ENUM-REF-CANDIDATE: web|ios|android|roku|fire_tv|apple_tv|samsung_tizen|lg_webos|xbox|playstation|other — 11 candidates stripped; promote to reference product]',
    `scte35_cue_type` STRING COMMENT 'Type of SCTE-35 cue message that triggered the DAI session. Indicates the nature of the ad opportunity (splice insert, time signal, segmentation descriptor). [ENUM-REF-CANDIDATE: splice_insert|time_signal|segmentation_descriptor|provider_advertisement|distributor_advertisement|program_start|program_end|chapter_start|break_start|break_end — 10 candidates stripped; promote to reference product]',
    `scte35_signal_timestamp` TIMESTAMP COMMENT 'Timestamp of the SCTE-35 cue message that triggered the DAI opportunity. Critical for synchronizing ad insertion with content breaks.',
    `session_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the DAI session completed. Marks the end of ad pod delivery and return to content.',
    `session_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the DAI session was initiated. Represents the moment the ad decision server was queried for this ad opportunity.',
    `session_status` STRING COMMENT 'Final status of the DAI session. Indicates whether the session completed successfully, partially filled, failed, timed out, or was abandoned by the viewer.. Valid values are `completed|partial|failed|timeout|abandoned`',
    `stitching_mode` STRING COMMENT 'Method used to insert ads into the stream. Server-side stitching (SSAI) integrates ads at the CDN level; client-side stitching occurs in the player.. Valid values are `server_side|client_side|hybrid`',
    `streaming_protocol` STRING COMMENT 'Adaptive bitrate streaming protocol used for DAI delivery (HLS, MPEG-DASH, Smooth Streaming). Affects manifest manipulation and ad stitching approach.. Valid values are `hls|dash|smooth_streaming|hds`',
    `total_ad_duration_seconds` DECIMAL(18,2) COMMENT 'Total duration of all ads actually delivered during this DAI session. May differ from ad_pod_duration_seconds if pod was not fully filled.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this DAI session record was last modified. Tracks changes to session status or post-session reconciliation updates.',
    `viewer_ip_address` STRING COMMENT 'IP address of the viewer device at the time of the DAI session. Used for geo-targeting and fraud detection. May be considered PII under GDPR.',
    CONSTRAINT pk_dai_session PRIMARY KEY(`dai_session_id`)
) COMMENT 'Transactional record capturing Dynamic Ad Insertion (DAI) sessions executed during streaming delivery. Captures session identifier, delivery channel or stream, viewer session reference, ad pod position (pre-roll, mid-roll, post-roll), SCTE-35 signal timestamp, ad decision server response, number of ads inserted, fill rate, fallback ad flag, and DAI provider (e.g., Google DAI, Yospace). Supports AVOD and FAST channel monetization reconciliation and ad fill rate optimization.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` (
    `retransmission_consent_id` BIGINT COMMENT 'Primary key for retransmission_consent',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Retransmission consent records must directly reference broadcast license for FCC filing, public inspection file inclusion, and must-carry election tracking. License is the regulatory anchor for consen',
    `carriage_agreement_id` BIGINT COMMENT 'Foreign key linking to distribution.carriage_agreement. Business justification: Retransmission consent is often tied to carriage agreements. Consent enables carriage under specific agreement terms. Essential for legal compliance tracking.',
    `distribution_partner_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_partner. Business justification: Retransmission consent is granted to specific MVPD partners (MVPDs are distribution partners). retransmission_consent.mvpd_id should FK to distribution_partner. Removes mvpd_id BIGINT and mvpd_name ST',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Retransmission consent agreements are specialized broadcast rights licenses. Linking enables rights chain validation, ensures MVPDs have proper authorization, and supports fee reconciliation between r',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Retransmission consent agreements are regulatory/legal contracts requiring negotiator ownership for FCC compliance, blackout coordination, must-carry elections, and good-faith negotiation requirements',
    `partner_id` BIGINT COMMENT 'Identifier of the broadcast station granting retransmission consent authorization.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Retransmission consent agreements originate from sales opportunities during broadcaster-MVPD negotiations. Tracks negotiation lifecycle from opportunity through executed consent agreement. Critical fo',
    `approval_date` DATE COMMENT 'Date when the retransmission consent agreement received final internal approval and authorization for execution.',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or legal authority who approved the retransmission consent agreement on behalf of the broadcaster.',
    `authorized_dma_list` STRING COMMENT 'Comma-separated list of Nielsen DMA codes where the MVPD is authorized to retransmit the broadcast signal (e.g., 501,602,803).',
    `blackout_provision_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes geographic blackout provisions restricting retransmission in certain markets or during specific events.',
    `blackout_terms` STRING COMMENT 'Detailed description of blackout restrictions, including affected content types, geographic areas, and triggering conditions.',
    `cash_compensation_amount` DECIMAL(18,2) COMMENT 'Monetary compensation amount paid by the MVPD to the broadcaster per billing period. Null if compensation is non-cash.',
    `channel_carriage_commitment` STRING COMMENT 'Description of channel carriage commitments provided by the MVPD as part of the retransmission consent agreement (e.g., carriage of affiliated digital subchannels).',
    `compensation_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for cash compensation (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `compensation_frequency` STRING COMMENT 'Billing frequency for cash compensation payments from MVPD to broadcaster.. Valid values are `monthly|quarterly|annually|one_time`',
    `compensation_type` STRING COMMENT 'Primary form of compensation provided by the MVPD to the broadcaster in exchange for retransmission consent.. Valid values are `cash|reverse_compensation|channel_carriage|promotional|hybrid|none`',
    `consent_agreement_number` STRING COMMENT 'Externally-known unique business identifier for the retransmission consent agreement, typically formatted as RTC-YYYYNNNN.. Valid values are `^RTC-[0-9]{8}$`',
    `consent_status` STRING COMMENT 'Current lifecycle status of the retransmission consent agreement. [ENUM-REF-CANDIDATE: draft|negotiation|active|expired|terminated|suspended|disputed — 7 candidates stripped; promote to reference product]',
    `consent_type` STRING COMMENT 'Type of carriage authorization: retransmission consent (negotiated) or must-carry (mandatory under FCC rules).. Valid values are `retransmission_consent|must_carry`',
    `contract_document_reference` STRING COMMENT 'Reference identifier or file path to the executed retransmission consent contract document in the document management system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this retransmission consent record was first created in the system.',
    `dispute_resolution_method` STRING COMMENT 'Agreed-upon method for resolving disputes arising from the retransmission consent agreement.. Valid values are `arbitration|mediation|litigation|FCC_complaint`',
    `effective_date` DATE COMMENT 'Date when the retransmission consent agreement becomes legally binding and carriage authorization begins.',
    `expiry_date` DATE COMMENT 'Date when the retransmission consent agreement terminates and carriage authorization ends. Nullable for indefinite agreements.',
    `fcc_filing_reference` STRING COMMENT 'Reference number or identifier for any FCC filings, notifications, or complaints associated with this retransmission consent agreement.',
    `geographic_scope` STRING COMMENT 'Geographic coverage scope of the retransmission consent agreement.. Valid values are `local|regional|national`',
    `good_faith_negotiation_flag` BOOLEAN COMMENT 'Indicates whether both parties certified compliance with FCC good faith negotiation requirements during retransmission consent discussions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this retransmission consent record was last updated or modified.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this retransmission consent record.',
    `must_carry_election_date` DATE COMMENT 'Date when the broadcaster formally elected must-carry status with the MVPD. Null if retransmission consent was negotiated.',
    `must_carry_election_flag` BOOLEAN COMMENT 'Indicates whether the broadcaster elected must-carry status instead of negotiating retransmission consent. True if must-carry was elected.',
    `mvpd_type` STRING COMMENT 'Classification of the MVPD platform type receiving retransmission consent.. Valid values are `cable|satellite|telco|vMVPD|IPTV`',
    `negotiation_completion_date` DATE COMMENT 'Date when retransmission consent negotiations were successfully concluded and agreement was reached.',
    `negotiation_start_date` DATE COMMENT 'Date when retransmission consent negotiations formally commenced between broadcaster and MVPD.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or contextual information regarding the retransmission consent agreement.',
    `promotional_commitment` STRING COMMENT 'Description of promotional support commitments provided by the MVPD (e.g., on-air promotion, co-marketing campaigns).',
    `renewal_notice_days` STRING COMMENT 'Number of days advance notice required before expiry date to trigger renewal or renegotiation process.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes an automatic renewal option or requires renegotiation at expiry.',
    `termination_clause` STRING COMMENT 'Description of conditions under which either party may terminate the retransmission consent agreement prior to expiry date.',
    CONSTRAINT pk_retransmission_consent PRIMARY KEY(`retransmission_consent_id`)
) COMMENT 'Master record documenting retransmission consent authorizations granted to MVPDs and vMVPDs to rebroadcast over-the-air broadcast signals. Captures grantor broadcaster, grantee MVPD/vMVPD, authorized markets (DMAs), consent effective date, consent expiry date, compensation terms (cash, channel carriage, promotional commitments), must-carry election status, and negotiation history flags. Governed by FCC retransmission consent regulations.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` (
    `subscriber_count_report_id` BIGINT COMMENT 'Unique identifier for the subscriber count report record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Subscriber count reports drive carriage fee invoicing and require auditor ownership for variance investigation, dispute resolution, audit rights exercise, and third-party auditor coordination. Essenti',
    `carriage_agreement_id` BIGINT COMMENT 'Foreign key linking to distribution.carriage_agreement. Business justification: Subscriber count reports validate carriage agreement terms. Reports are submitted per agreement for billing purposes. Removes contract_reference STRING (derivable from carriage_agreement.agreement_num',
    `channel_id` BIGINT COMMENT 'Reference to the specific channel or channel tier for which subscriber counts are being reported.',
    `distribution_partner_id` BIGINT COMMENT 'Reference to the MVPD (Multichannel Video Programming Distributor) or vMVPD (Virtual Multichannel Video Programming Distributor) partner submitting the subscriber count report.',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: Subscriber counts are reported by DMA for carriage fee calculation, retransmission consent compliance, and Nielsen universe estimation. Market-level reporting is mandated in distribution partner contr',
    `approval_date` DATE COMMENT 'Date on which the subscriber count report was formally approved for use in carriage fee invoice generation.',
    `approval_status` STRING COMMENT 'Current approval status of the subscriber count report in the verification and reconciliation workflow.. Valid values are `pending|approved|rejected|disputed|under_review|conditionally_approved`',
    `approved_by` STRING COMMENT 'Name or identifier of the internal user or role who approved the subscriber count report for carriage fee calculation.',
    `audit_report_reference` STRING COMMENT 'Reference identifier to the formal audit report document associated with this subscriber count verification, if a third-party audit was conducted.',
    `audit_rights_exercised` BOOLEAN COMMENT 'Indicator of whether contractual audit rights were formally exercised for this reporting period, triggering enhanced verification procedures.',
    `auditor_notes` STRING COMMENT 'Internal notes and observations recorded by the auditor or verification team during the subscriber count review process.',
    `carriage_fee_per_subscriber` DECIMAL(18,2) COMMENT 'Contractual per-subscriber carriage fee rate applicable to this reporting period, used to calculate total carriage fee invoice amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this subscriber count report record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the carriage fee amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dispute_flag` BOOLEAN COMMENT 'Indicator of whether the distribution partner has formally disputed the verified subscriber count or variance findings.',
    `dispute_reason` STRING COMMENT 'Explanation provided by the distribution partner for disputing the verified subscriber count or audit findings.',
    `dispute_resolution_status` STRING COMMENT 'Current status of any dispute resolution process related to this subscriber count report.. Valid values are `open|in_negotiation|resolved|escalated|arbitration`',
    `invoice_generated_flag` BOOLEAN COMMENT 'Indicator of whether a carriage fee invoice has been generated based on this subscriber count report.',
    `invoice_reference` STRING COMMENT 'Reference identifier to the carriage fee invoice generated from this subscriber count report.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this subscriber count report record was last modified or updated.',
    `notes` STRING COMMENT 'General notes and comments related to this subscriber count report, capturing additional context or special circumstances.',
    `report_number` STRING COMMENT 'Externally-known unique identifier for this subscriber count report, used for contractual reference and audit tracking.. Valid values are `^[A-Z0-9]{3,20}$`',
    `report_status` STRING COMMENT 'Current lifecycle status of the subscriber count report in the end-to-end reporting and reconciliation process.. Valid values are `draft|submitted|under_verification|verified|invoiced|archived`',
    `reported_subscriber_count` BIGINT COMMENT 'Total number of subscribers reported by the distribution partner for the specified channel and period, as submitted by the MVPD or vMVPD.',
    `reporting_period_end_date` DATE COMMENT 'Last day of the period covered by this subscriber count report.',
    `reporting_period_start_date` DATE COMMENT 'First day of the period covered by this subscriber count report.',
    `reporting_period_type` STRING COMMENT 'Frequency of the subscriber count reporting period as defined in the carriage agreement (monthly, quarterly, annual, or custom).. Valid values are `monthly|quarterly|annual|custom`',
    `submission_date` DATE COMMENT 'Date on which the distribution partner submitted the subscriber count report to the broadcaster.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise date and time when the subscriber count report was received by the broadcasters system.',
    `third_party_auditor` STRING COMMENT 'Name of the external audit firm or third-party verification service engaged to validate subscriber counts, if applicable.',
    `variance_count` BIGINT COMMENT 'Numerical difference between reported subscriber count and verified subscriber count (verified minus reported).',
    `variance_explanation` STRING COMMENT 'Detailed explanation provided by the distribution partner or internal audit team describing the reason for any variance between reported and verified counts.',
    `variance_flag` BOOLEAN COMMENT 'Indicator of whether a material variance exists between reported and verified subscriber counts, triggering additional review or dispute resolution.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance between reported and verified subscriber counts, calculated as (variance_count / reported_subscriber_count) * 100.',
    `verification_date` DATE COMMENT 'Date on which the internal verification and audit process was completed for this subscriber count report.',
    `verification_method` STRING COMMENT 'Method used to verify the reported subscriber count (automated system check, manual review, third-party audit, statistical sampling, or full audit).. Valid values are `automated|manual|third_party_audit|sampling|full_audit`',
    `verified_subscriber_count` BIGINT COMMENT 'Subscriber count after internal verification and audit processes, used as the basis for carriage fee calculation.',
    CONSTRAINT pk_subscriber_count_report PRIMARY KEY(`subscriber_count_report_id`)
) COMMENT 'Transactional record capturing periodic subscriber count certifications submitted by MVPD and vMVPD partners, used as the basis for per-subscriber carriage fee calculation. Captures reporting period (monthly/quarterly), distribution partner, channel or channel tier, reported subscriber count, verified subscriber count, variance flag, variance explanation, submission date, verification date, approval status, and auditor notes. Feeds carriage_fee_invoice generation and revenue assurance reconciliation. Subject to contractual audit rights. Distinct from subscriber master data owned by the subscriber domain.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` (
    `channel_lineup_id` BIGINT COMMENT 'Primary key for channel_lineup',
    `carriage_agreement_id` BIGINT COMMENT 'Foreign key linking to distribution.carriage_agreement. Business justification: Channel lineups are defined by carriage agreements. Lineup terms and channel positioning come from agreements. Removes contract_reference_number STRING (derivable from carriage_agreement.agreement_num',
    `channel_id` BIGINT COMMENT 'Reference to the specific broadcast or streaming channel included in this lineup.',
    `distribution_partner_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_partner. Business justification: Channel lineups belong to distribution partners. channel_lineup.partner_id should FK to distribution_partner. Removes partner_id BIGINT (replaced by distribution_partner_id FK).',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: Channel lineups vary by DMA due to must-carry rules, local station carriage, blackout restrictions, and market-specific programming rights. Required for FCC compliance and retransmission consent enfor',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` (
    `playout_feed_id` BIGINT COMMENT 'Unique identifier for the playout feed. Primary key for the playout feed entity representing a discrete output stream from the playout automation system.',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: Playout feeds use ABR profiles for encoding. Each feed has a specific ABR profile for multi-bitrate delivery. Essential for encoding configuration.',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Playout feeds originate from facilities housing playout automation. Required for playout system maintenance scheduling and facility failover coordination.',
    `channel_id` BIGINT COMMENT 'Reference to the broadcast channel associated with this playout feed. Links the feed to its delivery channel configuration.',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Playout feeds enforce DRM policies. Each feed has DRM requirements for content protection. Removes encryption_enabled BOOLEAN and encryption_method STRING (derivable from drm_policy).',
    `encoder_config_id` BIGINT COMMENT 'Foreign key linking to technology.encoder_config. Business justification: Playout feeds are encoded by encoder configurations. Required for playout signal chain tracking and encoder assignment management.',
    `failover_feed_id` BIGINT COMMENT 'Reference to the backup playout feed that will take over in case of failure of this primary feed, enabling high availability and business continuity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Playout feeds are broadcast operations infrastructure requiring engineering ownership for failover testing, graphics overlay management, SCTE-35 configuration, and automation system integration. Essen',
    `signal_route_id` BIGINT COMMENT 'Foreign key linking to distribution.signal_route. Business justification: Playout feeds are routed via signal routes. Each feed uses a signal route for distribution. Essential for feed routing and failover management.',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: Playout feeds output to streaming endpoints. Each feed targets a specific endpoint for distribution. Removes output_destination_url STRING (derivable from streaming_endpoint.endpoint_url).',
    `transmission_equipment_id` BIGINT COMMENT 'Foreign key linking to technology.transmission_equipment. Business justification: Playout feeds are generated by specific transmission equipment. Required for equipment lifecycle management and redundancy planning.',
    `activated_timestamp` TIMESTAMP COMMENT 'Timestamp when the playout feed was activated and began operational broadcasting, marking the start of live service.',
    `aspect_ratio` STRING COMMENT 'Video aspect ratio for the playout feed output: 4:3 for standard definition, 16:9 for widescreen HD/UHD, or 21:9 for ultra-widescreen cinema formats.. Valid values are `4:3|16:9|21:9`',
    `audio_bitrate_kbps` STRING COMMENT 'Target audio bitrate in kilobits per second (kbps) for the playout feed audio output, determining audio quality and bandwidth consumption.',
    `audio_channel_config` STRING COMMENT 'Audio channel layout configuration for the playout feed: mono, stereo, 5.1 surround, 7.1 surround, or Dolby Atmos immersive audio.. Valid values are `mono|stereo|5.1|7.1|Dolby Atmos`',
    `audio_codec` STRING COMMENT 'Audio compression codec used for encoding the playout feed audio: Advanced Audio Coding (AAC), Dolby Digital (AC-3), Dolby Digital Plus (E-AC-3), MPEG-1 Layer II, or Opus.. Valid values are `AAC|AC-3|E-AC-3|MPEG-1 Layer II|Opus`',
    `automation_mode` STRING COMMENT 'Level of automation for playout operations: fully automated with no operator intervention, semi-automated requiring operator approval for certain events, or manual requiring operator control for all playout actions.. Valid values are `fully_automated|semi_automated|manual`',
    `branding_profile` STRING COMMENT 'Name or identifier of the branding profile applied to this playout feed, controlling channel logos, watermarks, and visual identity elements.',
    `closed_caption_enabled` BOOLEAN COMMENT 'Indicates whether closed captioning (CEA-608, CEA-708) is enabled and embedded in the playout feed output for accessibility compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the playout feed record was first created in the system, capturing the initial data entry event for audit and tracking purposes.',
    `deactivated_timestamp` TIMESTAMP COMMENT 'Timestamp when the playout feed was deactivated and ceased broadcasting operations, marking the end of service or transition to offline status.',
    `failover_trigger_mode` STRING COMMENT 'Method by which failover to the backup feed is initiated: automatic based on health monitoring, manual operator intervention, or scheduled for planned maintenance.. Valid values are `automatic|manual|scheduled`',
    `feed_code` STRING COMMENT 'Unique business identifier code for the playout feed used in scheduling systems, traffic systems, and operational workflows.',
    `feed_name` STRING COMMENT 'Human-readable name of the playout feed used for identification and operational reference within the playout automation system.',
    `feed_type` STRING COMMENT 'Classification of the playout feed indicating its operational role: primary broadcast feed, backup feed for failover, redundant feed for high availability, test feed for validation, or preview feed for quality control.. Valid values are `primary|backup|redundant|test|preview`',
    `frame_rate` DECIMAL(18,2) COMMENT 'Video frame rate in frames per second (fps) for the playout feed output, following broadcast standards for different regions and formats.',
    `graphics_overlay_enabled` BOOLEAN COMMENT 'Indicates whether real-time graphics overlay (bugs, tickers, lower thirds, branding elements) is enabled for this playout feed.',
    `graphics_template_code` STRING COMMENT 'Reference to the graphics template configuration used for branding, bugs, and overlay elements on this playout feed.',
    `last_health_check_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent automated health check performed on the playout feed to verify operational status and signal quality.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the playout feed record was last modified, capturing the most recent update event for change tracking and audit compliance.',
    `multicast_address` STRING COMMENT 'Multicast IP address used for distributing the playout feed to multiple receivers simultaneously in IP-based broadcast networks.',
    `operational_status` STRING COMMENT 'Current operational state of the playout feed indicating whether it is actively broadcasting, on standby for failover, offline, under maintenance, experiencing errors, or in testing mode.. Valid values are `active|standby|offline|maintenance|error|testing`',
    `output_format` STRING COMMENT 'Physical or network output format of the playout feed: Serial Digital Interface (SDI) for baseband video, Internet Protocol (IP) for network streaming, Asynchronous Serial Interface (ASI) for MPEG transport streams, Secure Reliable Transport (SRT), Reliable Internet Stream Transport (RIST), or Network Device Interface (NDI).. Valid values are `SDI|IP|ASI|SRT|RIST|NDI`',
    `playout_server_code` STRING COMMENT 'Identifier of the physical or virtual playout server assigned to generate this feed. Links the feed to the automation infrastructure.',
    `port_number` STRING COMMENT 'Network port number used for the playout feed output connection in IP-based delivery configurations.',
    `provisioned_date` DATE COMMENT 'Date when the playout feed was initially provisioned and configured in the playout automation system.',
    `redundancy_mode` STRING COMMENT 'Redundancy configuration for the playout feed: none (single feed), hot standby (backup ready to take over), active-active (both feeds broadcasting simultaneously), or N+1 (shared backup for multiple feeds).. Valid values are `none|hot_standby|active_active|N+1`',
    `scte35_enabled` BOOLEAN COMMENT 'Indicates whether SCTE-35 digital program insertion cue messages are enabled in the playout feed for Dynamic Ad Insertion (DAI) and program segmentation.',
    `service_identifier` STRING COMMENT 'DVB Service ID or ATSC program number identifying the service within the transport stream for Electronic Program Guide (EPG) and receiver tuning.',
    `sla_tier` STRING COMMENT 'Service level tier assigned to this playout feed defining uptime guarantees, response times, and support priority: platinum (highest), gold, silver, bronze, or standard.. Valid values are `platinum|gold|silver|bronze|standard`',
    `subtitle_format` STRING COMMENT 'Subtitle or closed caption format embedded in the playout feed: DVB subtitles, Teletext, CEA-608, CEA-708, Timed Text Markup Language (TTML), or Web Video Text Tracks (WebVTT).. Valid values are `DVB|Teletext|CEA-608|CEA-708|TTML|WebVTT`',
    `transport_stream_identifier` STRING COMMENT 'MPEG Transport Stream ID (TSID) assigned to this playout feed for multiplexing and demultiplexing in broadcast distribution networks.',
    `uptime_target_percent` DECIMAL(18,2) COMMENT 'Target uptime percentage for the playout feed as defined in the Service Level Agreement (SLA), typically 99.9% or higher for mission-critical broadcast feeds.',
    `video_bitrate_mbps` DECIMAL(18,2) COMMENT 'Target video bitrate in megabits per second (Mbps) for the playout feed output, determining video quality and bandwidth consumption.',
    `video_codec` STRING COMMENT 'Video compression codec used for encoding the playout feed output: H.264 (AVC), H.265 (HEVC), MPEG-2, AV1, or VP9.. Valid values are `H.264|H.265|MPEG-2|AV1|VP9`',
    `video_resolution` STRING COMMENT 'Output video resolution class: Standard Definition (SD), High Definition (HD), Full High Definition (FHD), Ultra High Definition (UHD), 4K, or 8K.. Valid values are `SD|HD|FHD|UHD|4K|8K`',
    CONSTRAINT pk_playout_feed PRIMARY KEY(`playout_feed_id`)
) COMMENT 'Master record for each discrete playout feed managed through Ericsson MediaFirst, representing a configured output stream from the playout automation system. Captures feed name, associated delivery channel, playout server assignment, output format (SDI, IP, ASI), transport stream parameters, graphics/branding overlay configuration, automation mode (fully automated, semi-automated, manual), redundancy configuration, and current operational status. The operational anchor linking scheduling to physical signal delivery.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` (
    `deal_id` BIGINT COMMENT 'Primary key for deal',
    `distribution_partner_id` BIGINT COMMENT 'Reference to the OTT platform, FAST aggregator, syndication buyer, or international distributor party to this deal.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Distribution deals with partners are governed by underlying content license agreements. Critical for validating distribution rights chain, ensuring revenue share terms align with license obligations, ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Distribution deals are high-value contracts requiring business development owner for negotiations, revenue forecasting, MG tracking, and relationship management. Essential for commission tracking, app',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Distribution deals define revenue models (rev share, flat fee, minimum guarantee) that map to specific revenue streams for accounting purposes. Contract setup creates revenue stream mappings for autom',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Distribution deals originate from sales opportunities in the deal lifecycle. Tracks opportunity-to-contract conversion for distribution partnerships, platform licensing, and carriage agreements. Essen',
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
    `abr_profile_id` BIGINT COMMENT 'Reference to the Adaptive Bitrate streaming profile defining the rendition ladder and streaming configuration for OTT delivery.',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Delivery orders specify exact rendition (proxy/mezzanine/distribution master) for partner fulfillment. Broadcasters track which version was delivered for audit/quality purposes. Existing content_asset',
    `carriage_agreement_id` BIGINT COMMENT 'Reference to the underlying carriage or distribution agreement that authorizes this content delivery. Links order to contractual obligations.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.talent_contract. Business justification: Content delivery workflow requires talent usage rights clearance before distribution. Delivery orders must validate that talent contracts permit the requested delivery method, territory, and platform.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Content delivery operations (transcoding, QC, distribution) incur costs allocated to technology or operations cost centers. Monthly cost allocation for content operations charges cost centers based on',
    `distribution_partner_id` BIGINT COMMENT 'Reference to the distribution partner or platform receiving the content. Identifies the counterparty in this delivery transaction.',
    `drm_policy_id` BIGINT COMMENT 'Reference to the DRM policy governing content protection, encryption, and playback restrictions for this delivery.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Content delivery orders require operations ownership for prioritization, troubleshooting delivery failures, SLA compliance, and partner communication. Essential for on-call rotations, delivery metrics',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Delivery orders fulfill content distribution under specific license agreements. Essential for pre-delivery rights compliance verification, ensuring delivery parameters match license terms, and authori',
    `media_asset_id` BIGINT COMMENT 'Reference to the specific content asset or package being delivered. Links to the master content asset record in the Digital Assets domain.',
    `rights_availability_window_id` BIGINT COMMENT 'Reference to the rights and licensing window that permits this content delivery. Ensures delivery complies with windowing and holdback restrictions.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Content delivery orders for encoding, transcoding, QC, and distribution services are billable to content owners or internal cost centers. Real business process: content services billing, delivery fee ',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Content delivery orders fulfill closed content licensing opportunities. Tracks opportunity-to-fulfillment lifecycle for syndication deals, content licensing agreements, and distribution contracts. Ess',
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
    `target_platform` STRING COMMENT 'Type of distribution platform or channel where the content will be delivered. Determines technical delivery requirements and format specifications.. Valid values are `linear_broadcast|ott_streaming|mvpd|vmvpd|fast_channel|cdn`',
    `transcode_profile_code` BIGINT COMMENT 'Reference to the transcode profile specifying encoding parameters, bitrates, resolutions, and quality settings for content preparation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery order record was last modified. Tracks the most recent change to any field in the record.',
    `video_resolution` STRING COMMENT 'Target video resolution for the delivered content. Specifies the quality tier and display format for the distribution platform.. Valid values are `sd|hd_720p|hd_1080p|uhd_4k|uhd_8k`',
    CONSTRAINT pk_content_delivery_order PRIMARY KEY(`content_delivery_order_id`)
) COMMENT 'Transactional record representing a formal order to deliver a specific content asset or package to a distribution partner or platform by a specified deadline. Captures order type (new release, refresh, replacement, emergency), content asset reference, target distribution platform, required delivery format, transcode profile, DRM policy, delivery deadline, delivery method (CDN push, FTP, Aspera, satellite uplink), order status, and fulfillment confirmation. Operationalizes the distribution deal and window commitments into actionable delivery tasks.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` (
    `platform_distribution_agreement_id` BIGINT COMMENT 'Unique surrogate identifier for each platform distribution agreement record',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to the OTT platform being distributed through this agreement',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the distribution partner carrying the platform',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the distribution agreement. Active = live and operational, Pending = signed but not yet launched, Suspended = temporarily paused, Terminated = ended early, Expired = reached natural end date',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the distribution agreement automatically renews at the end of the contract term unless either party provides notice',
    `carriage_fee_amount` DECIMAL(18,2) COMMENT 'Fixed periodic fee paid to the distribution partner for carrying the platform, independent of subscriber volume. Typically monthly or annual.',
    `carriage_fee_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the carriage fee amount',
    `contract_end_date` DATE COMMENT 'The expiration or termination date of the distribution agreement contract. May be null for evergreen agreements.',
    `contract_start_date` DATE COMMENT 'The effective start date of the distribution agreement contract between the platform and partner',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this distribution agreement record was first created in the system',
    `distribution_territories` STRING COMMENT 'Comma-separated list of ISO country codes or geographic regions where this partner is authorized to distribute the platform under this agreement',
    `exclusivity_end_date` DATE COMMENT 'End date of the exclusivity window if exclusivity_flag is true',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this distribution partner has exclusive rights to distribute the platform in specific territories or device categories during the exclusivity window',
    `exclusivity_start_date` DATE COMMENT 'Start date of the exclusivity window if exclusivity_flag is true',
    `minimum_subscriber_commitment` BIGINT COMMENT 'Minimum number of subscribers the partner commits to deliver or the platform commits to maintain through this distribution channel, if applicable',
    `platform_launch_date` DATE COMMENT 'The date on which the OTT platform was made available through this specific distribution partner channel. May differ from the platforms overall launch date.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'The percentage of subscription or transaction revenue that is shared with the distribution partner under this agreement. Expressed as a percentage (e.g., 15.00 for 15%).',
    `sla_tier` STRING COMMENT 'Service level agreement tier negotiated with this distribution partner, defining uptime commitments, support response times, and technical integration requirements',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this distribution agreement record was last modified',
    CONSTRAINT pk_platform_distribution_agreement PRIMARY KEY(`platform_distribution_agreement_id`)
) COMMENT 'This association product represents the contractual distribution agreement between an OTT platform and an external partner (app store, device manufacturer, MVPD, aggregator, ISP). It captures platform-partner-specific commercial terms, technical SLA commitments, revenue sharing arrangements, carriage fees, launch coordination, and exclusivity windows. Each record links one OTT platform to one distribution partner with attributes that exist only in the context of this specific distribution relationship.. Existence Justification: In media broadcasting operations, OTT platforms are distributed through multiple partner channels simultaneously (app stores like Apple/Google, device manufacturers like Roku/Samsung, MVPDs, ISPs, aggregators), and each distribution partner carries multiple OTT platforms. The business actively manages platform-partner distribution agreements as distinct contractual entities with partner-specific commercial terms, revenue sharing models, carriage fees, SLA commitments, launch coordination, and exclusivity windows that vary by partner relationship.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`endpoint_allocation` (
    `endpoint_allocation_id` BIGINT COMMENT 'Primary key uniquely identifying each endpoint-partner allocation record',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the partner receiving the endpoint allocation',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to the streaming endpoint being allocated to the partner',
    `activated_timestamp` TIMESTAMP COMMENT 'Date and time when this endpoint allocation was activated for the partner',
    `allocation_status` STRING COMMENT 'Current operational status of this endpoint-partner allocation (Active, Suspended, Decommissioned, Pending)',
    `bandwidth_allocation_gbps` DECIMAL(18,2) COMMENT 'Dedicated bandwidth in gigabits per second allocated to this partner for this endpoint. Explicitly identified in detection phase relationship data.',
    `contract_reference` STRING COMMENT 'Reference to the legal contract or service agreement governing this endpoint allocation. Explicitly identified in detection phase relationship data.',
    `cost_per_gb` DECIMAL(18,2) COMMENT 'Partner-specific cost per gigabyte of data transferred through this endpoint. Pricing varies by partner relationship and volume commitments. Explicitly identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this allocation record was created',
    `deactivated_timestamp` TIMESTAMP COMMENT 'Date and time when this endpoint allocation was deactivated or terminated. Null if currently active.',
    `geo_restriction_rules` STRING COMMENT 'Partner-specific geo-restriction rules for this endpoint allocation. Different partners may have different territorial rights requiring distinct geo-fencing. Explicitly identified in detection phase relationship data.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this allocation record was last modified',
    `provisioned_date` DATE COMMENT 'Date when this specific endpoint was provisioned for this partner. Explicitly identified in detection phase relationship data.',
    `sla_tier` STRING COMMENT 'Partner-specific SLA tier for this endpoint allocation (e.g., Platinum, Gold, Silver). Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_endpoint_allocation PRIMARY KEY(`endpoint_allocation_id`)
) COMMENT 'This association product represents the service agreement between streaming endpoints and distribution partners. It captures partner-specific endpoint configurations including SLA commitments, bandwidth allocations, cost structures, and geo-restriction policies. Each record links one streaming endpoint to one partner with attributes that exist only in the context of this specific service relationship.. Existence Justification: In media broadcasting CDN operations, streaming endpoints serve multiple distribution partners (MVPDs, vMVPDs, FAST operators, syndicators) simultaneously, and each partner consumes content from multiple endpoints (primary, failover, regional PoPs). The business actively manages partner-specific endpoint configurations including SLA tiers, bandwidth allocations, cost structures, and geo-restriction policies that vary by partner relationship and contractual terms.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` (
    `playout_id` BIGINT COMMENT 'Unique identifier for this playout event record. Primary key.',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to the delivery channel through which the media asset is transmitted',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to the media asset being transmitted through the delivery channel',
    `schedule_slot_id` BIGINT COMMENT 'add column scheduling_schedule_slot_id (BIGINT) with FK to scheduling.schedule_slot.schedule_slot_id - playout events execute specific schedule slots and need scheduling linkage',
    `employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - playout operations need operator attribution for audit trails',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual timestamp when transmission completed, as recorded by playout automation. Used for as-run logs and billing reconciliation. Null until playout completes.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual timestamp when transmission began, as recorded by playout automation. May differ from scheduled start due to overruns, technical issues, or live event delays. Null until playout begins.',
    `ad_insertion_enabled` BOOLEAN COMMENT 'Indicates whether dynamic ad insertion is enabled for this specific playout event. May override channel-level ad insertion settings based on content rights or programming requirements.',
    `blackout_applied` BOOLEAN COMMENT 'Indicates whether geographic or rights-based blackout restrictions are applied to this specific playout event. Enforces content licensing and distribution rights on a per-transmission basis.',
    `created_by_user` STRING COMMENT 'User ID or system identifier that created this playout schedule entry. Used for accountability and workflow tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this playout event was created in the scheduling system. Used for audit trail and schedule change tracking.',
    `end_timestamp` TIMESTAMP COMMENT 'Scheduled end timestamp for when this media asset completes transmission on this delivery channel. Calculated from start time plus asset duration plus any padding.',
    `playout_status` STRING COMMENT 'Current operational status of this playout event: scheduled (future), in_progress (currently transmitting), completed (successfully aired), failed (technical failure), cancelled (removed from schedule), preempted (replaced by breaking news or priority content).',
    `preemption_reason` STRING COMMENT 'Business reason if this playout event was preempted or cancelled (e.g., breaking news, technical failure, rights issue, schedule change). Null for completed playouts.',
    `priority` STRING COMMENT 'Priority classification for this playout event. Breaking news and critical content may preempt standard programming. Used by playout automation for conflict resolution.',
    `sequence_number` STRING COMMENT 'Sequential position of this asset within the channels playout schedule for the broadcast day. Used for playlist ordering and EPG generation.',
    `start_timestamp` TIMESTAMP COMMENT 'Scheduled start timestamp for when this media asset begins transmission on this delivery channel. Used for EPG scheduling and playout automation.',
    CONSTRAINT pk_playout PRIMARY KEY(`playout_id`)
) COMMENT 'This association product represents the scheduled playout event between a delivery channel and a media asset. It captures the operational scheduling and transmission of specific media assets through specific delivery channels. Each record links one delivery channel to one media asset with playout-specific attributes including timing, sequencing, ad insertion configuration, and blackout rules that exist only in the context of this scheduled transmission.. Existence Justification: In media broadcasting operations, the same media asset is scheduled for playout across multiple delivery channels (e.g., a news segment airs on the main linear channel, regional feeds, and FAST channels), and each delivery channel transmits many different media assets throughout the broadcast day. Playout scheduling is an operational business process where traffic and scheduling teams actively create, modify, and manage playout events with channel-specific timing, ad insertion rules, blackout restrictions, and sequencing. This is not an analytical correlation but a core operational entity.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` (
    `channel_compliance_id` BIGINT COMMENT 'Unique identifier for this channel-obligation compliance record. Primary key.',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to the delivery channel subject to this compliance obligation',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to the regulatory obligation applicable to this channel',
    `employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - channel compliance records need an accountable compliance officer',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting channel-specific compliance considerations, remediation actions, or special circumstances for this obligation.',
    `compliance_status` STRING COMMENT 'Current compliance status of this specific channel with respect to this specific obligation. Tracks whether the channel is meeting the regulatory requirement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance record was created in the system.',
    `effective_date` DATE COMMENT 'Date when this obligation became applicable to this channel. May differ from the obligations general effective_date if the channel launched after the regulation took effect.',
    `exemption_basis` STRING COMMENT 'Legal or regulatory basis for exemption if this channel is exempt from this obligation (e.g., low-power exemption, OTT platform exclusion, grandfathered status). Null if no exemption applies.',
    `expiration_date` DATE COMMENT 'Date when this obligation ceases to apply to this channel (e.g., channel retirement, exemption granted, regulation superseded). Null for ongoing obligations.',
    `last_audit_date` DATE COMMENT 'Date of the most recent internal or external audit of this channels compliance with this obligation.',
    `last_compliance_review_date` DATE COMMENT 'Date when compliance of this channel with this obligation was last reviewed or assessed. Channel-specific review date distinct from the obligation-level review.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next audit of this channels compliance with this obligation.',
    `next_filing_date` DATE COMMENT 'Scheduled date for the next compliance filing or submission for this channel-obligation combination. Channel-specific deadline that may differ from the general obligation deadline based on channel launch date or exemption status.',
    `reporting_frequency` STRING COMMENT 'How often this channel must report or demonstrate compliance with this obligation. May differ from the obligations general compliance_frequency based on channel type or exemption status.',
    `responsible_contact` STRING COMMENT 'Name or identifier of the individual responsible for ensuring this channels compliance with this specific obligation. May be a channel manager, compliance officer, or legal counsel.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance record was last updated.',
    CONSTRAINT pk_channel_compliance PRIMARY KEY(`channel_compliance_id`)
) COMMENT 'This association product represents the compliance relationship between delivery channels and regulatory obligations. It captures channel-specific compliance status, review schedules, exemptions, and filing deadlines for each obligation applicable to each channel. Each record links one delivery channel to one regulatory obligation with attributes that exist only in the context of this specific compliance relationship.. Existence Justification: In media broadcasting operations, each delivery channel (linear, OTT, FAST) is subject to multiple regulatory obligations (closed captioning, EAS participation, childrens programming quotas, political advertising disclosure, content rating requirements). Conversely, each regulatory obligation applies to multiple channels based on channel type, market, and platform. Compliance teams actively manage channel-specific compliance status, review schedules, exemptions, and filing deadlines for each channel-obligation pair as a distinct operational record.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ADD CONSTRAINT `fk_distribution_app_version_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_cdn_configuration_id` FOREIGN KEY (`cdn_configuration_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration`(`cdn_configuration_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_dai_configuration_id` FOREIGN KEY (`dai_configuration_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration`(`dai_configuration_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_failover_endpoint_id` FOREIGN KEY (`failover_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_app_version_id` FOREIGN KEY (`app_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`app_version`(`app_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_playback_device_type_id` FOREIGN KEY (`playback_device_type_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_device_device_type_id` FOREIGN KEY (`device_device_type_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ADD CONSTRAINT `fk_distribution_qos_event_playback_session_id` FOREIGN KEY (`playback_session_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`playback_session`(`playback_session_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ADD CONSTRAINT `fk_distribution_qos_event_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ADD CONSTRAINT `fk_distribution_sla_performance_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ADD CONSTRAINT `fk_distribution_api_endpoint_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ADD CONSTRAINT `fk_distribution_personalization_engine_fallback_engine_personalization_engine_id` FOREIGN KEY (`fallback_engine_personalization_engine_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine`(`personalization_engine_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ADD CONSTRAINT `fk_distribution_personalization_engine_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ADD CONSTRAINT `fk_distribution_dai_configuration_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ADD CONSTRAINT `fk_distribution_feature_flag_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ADD CONSTRAINT `fk_distribution_distribution_carriage_fee_invoice_carriage_agreement_id` FOREIGN KEY (`carriage_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement`(`carriage_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ADD CONSTRAINT `fk_distribution_distribution_carriage_fee_invoice_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ADD CONSTRAINT `fk_distribution_distribution_carriage_fee_invoice_subscriber_count_report_id` FOREIGN KEY (`subscriber_count_report_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report`(`subscriber_count_report_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_cdn_configuration_id` FOREIGN KEY (`cdn_configuration_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration`(`cdn_configuration_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ADD CONSTRAINT `fk_distribution_delivery_sla_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_cdn_configuration_id` FOREIGN KEY (`cdn_configuration_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration`(`cdn_configuration_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_playback_session_id` FOREIGN KEY (`playback_session_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`playback_session`(`playback_session_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ADD CONSTRAINT `fk_distribution_sla_breach_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ADD CONSTRAINT `fk_distribution_sla_breach_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_dai_configuration_id` FOREIGN KEY (`dai_configuration_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration`(`dai_configuration_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_playback_session_id` FOREIGN KEY (`playback_session_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`playback_session`(`playback_session_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ADD CONSTRAINT `fk_distribution_retransmission_consent_carriage_agreement_id` FOREIGN KEY (`carriage_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement`(`carriage_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ADD CONSTRAINT `fk_distribution_retransmission_consent_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ADD CONSTRAINT `fk_distribution_subscriber_count_report_carriage_agreement_id` FOREIGN KEY (`carriage_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement`(`carriage_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ADD CONSTRAINT `fk_distribution_subscriber_count_report_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ADD CONSTRAINT `fk_distribution_channel_lineup_carriage_agreement_id` FOREIGN KEY (`carriage_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement`(`carriage_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ADD CONSTRAINT `fk_distribution_channel_lineup_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ADD CONSTRAINT `fk_distribution_playout_feed_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ADD CONSTRAINT `fk_distribution_playout_feed_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ADD CONSTRAINT `fk_distribution_playout_feed_failover_feed_id` FOREIGN KEY (`failover_feed_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`playout_feed`(`playout_feed_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ADD CONSTRAINT `fk_distribution_playout_feed_signal_route_id` FOREIGN KEY (`signal_route_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`signal_route`(`signal_route_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ADD CONSTRAINT `fk_distribution_playout_feed_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_carriage_agreement_id` FOREIGN KEY (`carriage_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement`(`carriage_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ADD CONSTRAINT `fk_distribution_platform_distribution_agreement_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`endpoint_allocation` ADD CONSTRAINT `fk_distribution_endpoint_allocation_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` ADD CONSTRAINT `fk_distribution_playout_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` ADD CONSTRAINT `fk_distribution_channel_compliance_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`distribution` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`distribution` SET TAGS ('dbx_domain' = 'distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` SET TAGS ('dbx_subdomain' = 'platform_registry');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Top (OTT) Platform ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `tech_project_id` SET TAGS ('dbx_business_glossary_term' = 'Tech Project Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `secondary_streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Secondary Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `secondary_streaming_protocol` SET TAGS ('dbx_value_regex' = 'HLS|MPEG-DASH|RTMP|SRT|NONE');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` SET TAGS ('dbx_subdomain' = 'platform_registry');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `device_type_id` SET TAGS ('dbx_business_glossary_term' = 'Device Type ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `broadcast_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Standard Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ALTER COLUMN `maintenance_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` SET TAGS ('dbx_subdomain' = 'platform_registry');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `app_version_id` SET TAGS ('dbx_business_glossary_term' = 'Application Version Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `ab_test_cohort` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Cohort Assignment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `active_install_count` SET TAGS ('dbx_business_glossary_term' = 'Active Installation Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `analytics_sdk_version` SET TAGS ('dbx_business_glossary_term' = 'Analytics Software Development Kit (SDK) Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `app_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Application Size in Megabytes (MB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `build_number` SET TAGS ('dbx_business_glossary_term' = 'Build Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `ccpa_compliant` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Compliant');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `cdn_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Endpoint URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `cdn_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `closed_caption_support` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Support');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `crash_reporting_enabled` SET TAGS ('dbx_business_glossary_term' = 'Crash Reporting Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `dash_support_enabled` SET TAGS ('dbx_business_glossary_term' = 'MPEG-DASH Support Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `dolby_atmos_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dolby Atmos Audio Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `drm_library_version` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Library Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `feature_flags` SET TAGS ('dbx_business_glossary_term' = 'Feature Flags Configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `force_upgrade_threshold` SET TAGS ('dbx_business_glossary_term' = 'Force Upgrade Threshold Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `gdpr_compliant` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `hdr_support_enabled` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Support Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `hls_support_enabled` SET TAGS ('dbx_business_glossary_term' = 'HTTP Live Streaming (HLS) Support Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Release Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `max_bitrate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bitrate in Megabits Per Second (Mbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `minimum_os_version` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating System (OS) Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `offline_playback_enabled` SET TAGS ('dbx_business_glossary_term' = 'Offline Playback Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `parental_control_enabled` SET TAGS ('dbx_business_glossary_term' = 'Parental Control Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Target Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `player_sdk_version` SET TAGS ('dbx_business_glossary_term' = 'Player Software Development Kit (SDK) Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `release_notes` SET TAGS ('dbx_business_glossary_term' = 'Release Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `release_status` SET TAGS ('dbx_business_glossary_term' = 'Release Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `rollout_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rollout Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `supported_resolutions` SET TAGS ('dbx_business_glossary_term' = 'Supported Video Resolutions');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Application Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^d+.d+.d+(.[w-]+)?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` SET TAGS ('dbx_subdomain' = 'platform_registry');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Abr Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `cdn_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Configuration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `dai_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Dai Configuration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Policy Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `encoder_config_id` SET TAGS ('dbx_business_glossary_term' = 'Encoder Config Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `failover_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Failover Endpoint Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `failover_endpoint_id` SET TAGS ('dbx_self_ref_fk_reviewed' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `network_circuit_id` SET TAGS ('dbx_business_glossary_term' = 'Network Circuit Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `noc_monitor_id` SET TAGS ('dbx_business_glossary_term' = 'Noc Monitor Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `outage_record_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `software_license_id` SET TAGS ('dbx_business_glossary_term' = 'Software License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `tech_project_id` SET TAGS ('dbx_business_glossary_term' = 'Tech Project Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `tech_sla_id` SET TAGS ('dbx_business_glossary_term' = 'Tech Sla Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `technical_standard_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Standard Cert Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Equipment Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` SET TAGS ('dbx_subdomain' = 'platform_registry');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `broadcast_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Standard Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `encoder_config_id` SET TAGS ('dbx_business_glossary_term' = 'Encoder Config Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Format Specification Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `technical_standard_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Standard Cert Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Audio Bitrate (Kbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_channel_config` SET TAGS ('dbx_business_glossary_term' = 'Audio Channel Configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_channel_config` SET TAGS ('dbx_value_regex' = 'mono|stereo|5.1|7.1|Atmos');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_codec` SET TAGS ('dbx_value_regex' = 'AAC|HE-AAC|AC-3|E-AC-3|Opus');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `cdn_optimization_flag` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Optimization Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `color_space` SET TAGS ('dbx_business_glossary_term' = 'Color Space');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `color_space` SET TAGS ('dbx_value_regex' = 'BT.709|BT.2020|DCI-P3');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `container_format` SET TAGS ('dbx_business_glossary_term' = 'Container Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `container_format` SET TAGS ('dbx_value_regex' = 'fMP4|TS|MP4|WebM');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `drm_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Support Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `drm_system` SET TAGS ('dbx_business_glossary_term' = 'DRM System');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `drm_system` SET TAGS ('dbx_value_regex' = 'Widevine|PlayReady|FairPlay|Multi-DRM');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `encoding_preset` SET TAGS ('dbx_business_glossary_term' = 'Encoding Preset');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `encoding_preset` SET TAGS ('dbx_value_regex' = 'fast|medium|slow|veryslow');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `hdr_format` SET TAGS ('dbx_business_glossary_term' = 'HDR Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `hdr_format` SET TAGS ('dbx_value_regex' = 'HDR10|HDR10+|Dolby Vision|HLG');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `hdr_support_flag` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Support Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `keyframe_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Keyframe Interval (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `manifest_template_reference` SET TAGS ('dbx_business_glossary_term' = 'Manifest Template Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `max_bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bitrate (Kbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `max_resolution` SET TAGS ('dbx_business_glossary_term' = 'Maximum Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `min_bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Minimum Bitrate (Kbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `min_resolution` SET TAGS ('dbx_business_glossary_term' = 'Minimum Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `owner_team` SET TAGS ('dbx_business_glossary_term' = 'Owner Team');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'ABR Profile Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `profile_description` SET TAGS ('dbx_business_glossary_term' = 'ABR Profile Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'ABR Profile Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'ABR Profile Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|testing|inactive');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `qos_tier` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `qos_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|basic');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `rendition_count` SET TAGS ('dbx_business_glossary_term' = 'Rendition Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `segment_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Segment Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'HLS|MPEG-DASH|CMAF|Smooth Streaming');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `target_device_class` SET TAGS ('dbx_business_glossary_term' = 'Target Device Class');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `target_device_class` SET TAGS ('dbx_value_regex' = 'mobile|tablet|desktop|smart_tv|set_top_box|gaming_console');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `video_codec` SET TAGS ('dbx_value_regex' = 'H.264|H.265|HEVC|AV1|VP9');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` SET TAGS ('dbx_subdomain' = 'streaming_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_business_glossary_term' = 'Playback Session ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Abr Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `app_version_id` SET TAGS ('dbx_business_glossary_term' = 'App Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `closed_caption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `compliance_consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Policy Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `device_type_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `device_type_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `device_type_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_device_type_id` SET TAGS ('dbx_business_glossary_term' = 'Device Type Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `device_device_type_id` SET TAGS ('dbx_business_role_fk' = 'true');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` SET TAGS ('dbx_subdomain' = 'streaming_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `qos_event_id` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Event ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `closed_caption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `noc_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Noc Alert Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_business_glossary_term' = 'Playback Session ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Equipment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `ad_pod_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Bitrate (Kilobits Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `buffer_level_seconds` SET TAGS ('dbx_business_glossary_term' = 'Buffer Level (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `cdn_cache_status` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Cache Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `cdn_cache_status` SET TAGS ('dbx_value_regex' = 'hit|miss|stale|bypass');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `download_throughput_kbps` SET TAGS ('dbx_business_glossary_term' = 'Download Throughput (Kilobits Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `drm_system` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) System');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `drm_system` SET TAGS ('dbx_value_regex' = 'Widevine|FairPlay|PlayReady|None');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `dropped_frames_count` SET TAGS ('dbx_business_glossary_term' = 'Dropped Frames Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `event_severity` SET TAGS ('dbx_business_glossary_term' = 'Event Severity');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `event_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|info');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `isp_name` SET TAGS ('dbx_business_glossary_term' = 'Internet Service Provider (ISP) Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `network_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Network Latency (Milliseconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `new_bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'New Bitrate (Kilobits Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `origin_server_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Origin Server Response Time (Milliseconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `playback_position_seconds` SET TAGS ('dbx_business_glossary_term' = 'Playback Position (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `player_state` SET TAGS ('dbx_business_glossary_term' = 'Player State');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `player_state` SET TAGS ('dbx_value_regex' = 'playing|paused|buffering|seeking|idle|error');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `player_version` SET TAGS ('dbx_business_glossary_term' = 'Player Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `previous_bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Previous Bitrate (Kilobits Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `seek_position_seconds` SET TAGS ('dbx_business_glossary_term' = 'Seek Position (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `stall_duration_ms` SET TAGS ('dbx_business_glossary_term' = 'Stall Duration (Milliseconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'HLS|MPEG-DASH|RTMP|WebRTC|Smooth Streaming');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Viewer IP Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` SET TAGS ('dbx_subdomain' = 'streaming_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Definition Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `applicable_platform` SET TAGS ('dbx_business_glossary_term' = 'Applicable Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `breach_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Breach Penalty Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `breach_penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Breach Penalty Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `breach_penalty_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `breach_penalty_type` SET TAGS ('dbx_business_glossary_term' = 'Breach Penalty Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `breach_penalty_type` SET TAGS ('dbx_value_regex' = 'credit|refund|none|custom');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `critical_threshold` SET TAGS ('dbx_business_glossary_term' = 'Critical Threshold');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `sla_definition_description` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `escalation_procedure` SET TAGS ('dbx_business_glossary_term' = 'Escalation Procedure');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|monthly');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `measurement_window` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Metric Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `metric_type` SET TAGS ('dbx_business_glossary_term' = 'Metric Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `metric_type` SET TAGS ('dbx_value_regex' = 'uptime|latency|throughput|error_rate|response_time|availability');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'real_time|daily|weekly|monthly|quarterly');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `service_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `service_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|basic|enterprise');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `sla_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `sla_definition_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `sla_definition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|superseded|retired');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `sla_type` SET TAGS ('dbx_value_regex' = 'availability|performance|quality|capacity|support|security');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ALTER COLUMN `warning_threshold` SET TAGS ('dbx_business_glossary_term' = 'Warning Threshold');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` SET TAGS ('dbx_subdomain' = 'streaming_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `sla_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Performance ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `credit_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Penalty Credit Memo Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Definition ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `tech_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Ticket ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Metric Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `affected_platform` SET TAGS ('dbx_business_glossary_term' = 'Affected Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `affected_region` SET TAGS ('dbx_business_glossary_term' = 'Affected Geographic Region');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `breach_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Breach Duration in Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Breach Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'none|minor|moderate|major|critical');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Provider');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `contract_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `device_category` SET TAGS ('dbx_business_glossary_term' = 'Device Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `measurement_granularity` SET TAGS ('dbx_business_glossary_term' = 'Measurement Granularity');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `measurement_granularity` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly|quarterly|annual');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source System');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'draft|validated|disputed|approved|closed');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Performance Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `partner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `penalty_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Taken');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `remediation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Remediation Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'HLS|MPEG-DASH|RTMP|WebRTC|Smooth Streaming');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Metric Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `validated_by` SET TAGS ('dbx_business_glossary_term' = 'Validated By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `validated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ALTER COLUMN `variance_value` SET TAGS ('dbx_business_glossary_term' = 'Variance Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` SET TAGS ('dbx_subdomain' = 'streaming_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `api_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'API (Application Programming Interface) Endpoint ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `noc_monitor_id` SET TAGS ('dbx_business_glossary_term' = 'Noc Monitor Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `tech_project_id` SET TAGS ('dbx_business_glossary_term' = 'Tech Project Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `tech_sla_id` SET TAGS ('dbx_business_glossary_term' = 'Tech Sla Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `allowed_origins` SET TAGS ('dbx_business_glossary_term' = 'Allowed Origins');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `api_version` SET TAGS ('dbx_business_glossary_term' = 'API (Application Programming Interface) Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `api_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `authentication_scheme` SET TAGS ('dbx_business_glossary_term' = 'Authentication Scheme');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `authentication_scheme` SET TAGS ('dbx_value_regex' = 'oauth2|api_key|jwt|basic_auth|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `authorization_scope` SET TAGS ('dbx_business_glossary_term' = 'Authorization Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `cache_strategy` SET TAGS ('dbx_business_glossary_term' = 'Cache Strategy');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `cache_strategy` SET TAGS ('dbx_value_regex' = 'no_cache|private|public|cdn');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `cache_ttl_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cache TTL (Time To Live) Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `cors_enabled` SET TAGS ('dbx_business_glossary_term' = 'CORS (Cross-Origin Resource Sharing) Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL (Uniform Resource Locator)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `documentation_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `endpoint_description` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `endpoint_path` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Path');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `endpoint_path` SET TAGS ('dbx_value_regex' = '^/[a-zA-Z0-9/_-]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `endpoint_status` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `endpoint_status` SET TAGS ('dbx_value_regex' = 'active|inactive|beta|alpha|maintenance');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `functional_category` SET TAGS ('dbx_business_glossary_term' = 'Functional Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `http_method` SET TAGS ('dbx_business_glossary_term' = 'HTTP (Hypertext Transfer Protocol) Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Is Deprecated');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `is_public` SET TAGS ('dbx_business_glossary_term' = 'Is Public');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `owning_service` SET TAGS ('dbx_business_glossary_term' = 'Owning Service');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `rate_limit_requests_per_day` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Requests Per Day');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `rate_limit_requests_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Requests Per Minute');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `rate_limit_tier` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `rate_limit_tier` SET TAGS ('dbx_value_regex' = 'public|standard|premium|enterprise|unlimited');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `replacement_endpoint_path` SET TAGS ('dbx_business_glossary_term' = 'Replacement Endpoint Path');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `request_content_type` SET TAGS ('dbx_business_glossary_term' = 'Request Content Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `request_content_type` SET TAGS ('dbx_value_regex' = 'application/json|application/xml|application/x-www-form-urlencoded|multipart/form-data|text/plain');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `response_content_type` SET TAGS ('dbx_business_glossary_term' = 'Response Content Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `response_content_type` SET TAGS ('dbx_value_regex' = 'application/json|application/xml|text/html|text/plain|application/octet-stream');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `sla_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Response Time Milliseconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|mission_critical');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Uptime Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `sunset_date` SET TAGS ('dbx_business_glossary_term' = 'Sunset Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `supports_filtering` SET TAGS ('dbx_business_glossary_term' = 'Supports Filtering');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `supports_pagination` SET TAGS ('dbx_business_glossary_term' = 'Supports Pagination');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ALTER COLUMN `supports_sorting` SET TAGS ('dbx_business_glossary_term' = 'Supports Sorting');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` SET TAGS ('dbx_subdomain' = 'streaming_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `personalization_engine_id` SET TAGS ('dbx_business_glossary_term' = 'Personalization Engine ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `compliance_consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `fallback_engine_personalization_engine_id` SET TAGS ('dbx_business_glossary_term' = 'Fallback Engine ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `software_license_id` SET TAGS ('dbx_business_glossary_term' = 'Software License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `tech_project_id` SET TAGS ('dbx_business_glossary_term' = 'Tech Project Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `algorithm_type` SET TAGS ('dbx_business_glossary_term' = 'Algorithm Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `algorithm_type` SET TAGS ('dbx_value_regex' = 'collaborative_filtering|content_based|hybrid|matrix_factorization|deep_learning|contextual_bandit');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'API Endpoint URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `cache_ttl_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cache Time-To-Live (TTL) Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `ccpa_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Compliant Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `cold_start_strategy` SET TAGS ('dbx_business_glossary_term' = 'Cold Start Strategy');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `cold_start_strategy` SET TAGS ('dbx_value_regex' = 'popularity_based|content_similarity|demographic_default|hybrid_fallback|random_exploration');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `confidence_threshold` SET TAGS ('dbx_business_glossary_term' = 'Confidence Threshold');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `content_filter_rules` SET TAGS ('dbx_business_glossary_term' = 'Content Filter Rules');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `deployment_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `diversity_threshold` SET TAGS ('dbx_business_glossary_term' = 'Diversity Threshold');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `engine_code` SET TAGS ('dbx_business_glossary_term' = 'Engine Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `engine_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `engine_name` SET TAGS ('dbx_business_glossary_term' = 'Engine Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `feature_set_configuration` SET TAGS ('dbx_business_glossary_term' = 'Feature Set Configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `gdpr_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `last_training_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Training Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `model_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|testing|deprecated|maintenance');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `owner_team` SET TAGS ('dbx_business_glossary_term' = 'Owner Team');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `performance_metric_target` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric Target');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `performance_metric_target` SET TAGS ('dbx_value_regex' = 'click_through_rate|watch_time|completion_rate|engagement_score|revenue_per_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `personalization_scope` SET TAGS ('dbx_business_glossary_term' = 'Personalization Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `personalization_scope` SET TAGS ('dbx_value_regex' = 'user_level|segment_level|household_level|device_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `recommendation_count_limit` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Count Limit');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `refresh_cadence` SET TAGS ('dbx_business_glossary_term' = 'Refresh Cadence');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `refresh_cadence` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|on_demand');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `response_time_sla_ms` SET TAGS ('dbx_business_glossary_term' = 'Response Time Service Level Agreement (SLA) Milliseconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ALTER COLUMN `training_data_window_days` SET TAGS ('dbx_business_glossary_term' = 'Training Data Window Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` SET TAGS ('dbx_subdomain' = 'advertising_insertion');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `dai_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Configuration ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `abr_profile_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile Compatibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `ad_decision_server_url` SET TAGS ('dbx_business_glossary_term' = 'Ad Decision Server (ADS) URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `ad_decision_server_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+(/.*)?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `ad_format_support` SET TAGS ('dbx_business_glossary_term' = 'Supported Ad Formats');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `ad_pod_placement_rules` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Placement Rules');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `ad_server_timeout_milliseconds` SET TAGS ('dbx_business_glossary_term' = 'Ad Server Timeout (Milliseconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `backup_ad_server_url` SET TAGS ('dbx_business_glossary_term' = 'Backup Ad Decision Server URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `backup_ad_server_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+(/.*)?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `blackout_override_enabled` SET TAGS ('dbx_business_glossary_term' = 'Blackout Override Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `cdn_integration_mode` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Integration Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `cdn_integration_mode` SET TAGS ('dbx_value_regex' = 'direct|proxied|edge_decisioning');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `companion_ads_enabled` SET TAGS ('dbx_business_glossary_term' = 'Companion Ads Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `configuration_code` SET TAGS ('dbx_business_glossary_term' = 'Configuration Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `configuration_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `configuration_name` SET TAGS ('dbx_business_glossary_term' = 'Configuration Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `configuration_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `configuration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|testing|deprecated');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `configuration_version` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `content_type` SET TAGS ('dbx_value_regex' = 'vod|live|linear|fast');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `device_targeting_enabled` SET TAGS ('dbx_business_glossary_term' = 'Device Targeting Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `drm_enforcement_mode` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Enforcement Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `drm_enforcement_mode` SET TAGS ('dbx_value_regex' = 'strict|lenient|disabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `fallback_creative_strategy` SET TAGS ('dbx_business_glossary_term' = 'Fallback Creative Strategy');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `fallback_creative_strategy` SET TAGS ('dbx_value_regex' = 'house_ad|slate|content_continuation|repeat_last');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `fill_rate_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Target Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `frequency_cap_enabled` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `geo_targeting_enabled` SET TAGS ('dbx_business_glossary_term' = 'Geographic Targeting Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `max_ad_pod_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Maximum Ad Pod Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `max_impressions_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Maximum Impressions Per Hour');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `max_impressions_per_session` SET TAGS ('dbx_business_glossary_term' = 'Maximum Impressions Per Session');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `min_ad_pod_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Minimum Ad Pod Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Configuration Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Configuration Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `scte35_signal_handling` SET TAGS ('dbx_business_glossary_term' = 'SCTE-35 Signal Handling Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `scte35_signal_handling` SET TAGS ('dbx_value_regex' = 'enabled|disabled|passthrough');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `stitching_mode` SET TAGS ('dbx_business_glossary_term' = 'Ad Stitching Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `stitching_mode` SET TAGS ('dbx_value_regex' = 'server_side|client_side|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ALTER COLUMN `tracking_events_enabled` SET TAGS ('dbx_business_glossary_term' = 'Ad Tracking Events Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` SET TAGS ('dbx_subdomain' = 'advertising_insertion');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `feature_flag_id` SET TAGS ('dbx_business_glossary_term' = 'Feature Flag ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `app_version_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Application Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `app_version_max` SET TAGS ('dbx_value_regex' = '^d+.d+.d+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `app_version_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Application Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `app_version_min` SET TAGS ('dbx_value_regex' = '^d+.d+.d+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `dependency_flags` SET TAGS ('dbx_business_glossary_term' = 'Dependency Flags');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `feature_flag_description` SET TAGS ('dbx_business_glossary_term' = 'Feature Flag Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `evaluation_count` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `experiment_hypothesis` SET TAGS ('dbx_business_glossary_term' = 'Experiment Hypothesis');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `flag_key` SET TAGS ('dbx_business_glossary_term' = 'Feature Flag Key');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `flag_key` SET TAGS ('dbx_value_regex' = '^[a-z0-9_-]{3,64}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `flag_name` SET TAGS ('dbx_business_glossary_term' = 'Feature Flag Display Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `flag_status` SET TAGS ('dbx_business_glossary_term' = 'Feature Flag Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `flag_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|deprecated');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `flag_type` SET TAGS ('dbx_business_glossary_term' = 'Feature Flag Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `flag_type` SET TAGS ('dbx_value_regex' = 'release_toggle|experiment|ops_toggle|permission_toggle|ux_variant|kill_switch');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `kill_switch_enabled` SET TAGS ('dbx_business_glossary_term' = 'Kill Switch Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `last_evaluation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Evaluation Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `owning_product_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Product Team');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `rollout_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rollout Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Feature Flag Tags');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `target_audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `target_platform` SET TAGS ('dbx_business_glossary_term' = 'Target Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `traffic_split_percentage` SET TAGS ('dbx_business_glossary_term' = 'Traffic Split Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `ux_configuration_json` SET TAGS ('dbx_business_glossary_term' = 'User Experience (UX) Configuration JSON');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `variant_a_config` SET TAGS ('dbx_business_glossary_term' = 'Variant A Configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `variant_b_config` SET TAGS ('dbx_business_glossary_term' = 'Variant B Configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` SET TAGS ('dbx_subdomain' = 'partner_carriage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `sales_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Sales Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `network_circuit_id` SET TAGS ('dbx_business_glossary_term' = 'Network Circuit Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `partner_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Name');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` SET TAGS ('dbx_subdomain' = 'partner_carriage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Master Invoice Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `network_circuit_id` SET TAGS ('dbx_business_glossary_term' = 'Network Circuit Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` SET TAGS ('dbx_subdomain' = 'partner_carriage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `distribution_carriage_fee_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Carriage Fee Invoice Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `subscriber_count_report_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Count Report Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `base_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `fee_basis` SET TAGS ('dbx_business_glossary_term' = 'Fee Basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `fee_basis` SET TAGS ('dbx_value_regex' = 'per_subscriber|flat_rate|tiered|revenue_share|hybrid|minimum_guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `general_ledger_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|direct_debit|other');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|paid|partially_paid|overdue|disputed|waived');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|discrepancy|under_review');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Invoice Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` SET TAGS ('dbx_subdomain' = 'signal_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Abr Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `cdn_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Configuration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Policy Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `encoder_config_id` SET TAGS ('dbx_business_glossary_term' = 'Encoder Config Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `outage_record_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `ad_insertion_method` SET TAGS ('dbx_business_glossary_term' = 'Ad Insertion Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `ad_insertion_method` SET TAGS ('dbx_value_regex' = 'server-side|client-side|dai|scte-35|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '4:3|16:9|21:9');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `audio_format` SET TAGS ('dbx_business_glossary_term' = 'Audio Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `audio_format` SET TAGS ('dbx_value_regex' = 'stereo|dolby-digital|dolby-atmos|dts|aac');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `blackout_rules_enabled` SET TAGS ('dbx_business_glossary_term' = 'Blackout Rules Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee United States Dollars (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_number` SET TAGS ('dbx_business_glossary_term' = 'Channel Number');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `secondary_language` SET TAGS ('dbx_business_glossary_term' = 'Secondary Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `secondary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `sla_uptime_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `streaming_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `streaming_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_market` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` SET TAGS ('dbx_subdomain' = 'signal_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Policy Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `technical_standard_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Standard Cert Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `airplay_enabled` SET TAGS ('dbx_business_glossary_term' = 'AirPlay Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `allowed_countries` SET TAGS ('dbx_business_glossary_term' = 'Allowed Countries');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `analog_output_control` SET TAGS ('dbx_business_glossary_term' = 'Analog Output Control');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `analog_output_control` SET TAGS ('dbx_value_regex' = 'allowed|restricted|blocked');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `analog_sunset_enabled` SET TAGS ('dbx_business_glossary_term' = 'Analog Sunset Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `blocked_countries` SET TAGS ('dbx_business_glossary_term' = 'Blocked Countries');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `chromecast_enabled` SET TAGS ('dbx_business_glossary_term' = 'Chromecast Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `concurrent_stream_limit` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Stream Limit');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `content_key_reference` SET TAGS ('dbx_business_glossary_term' = 'Content Key ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `content_key_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `device_binding_enabled` SET TAGS ('dbx_business_glossary_term' = 'Device Binding Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `drm_system` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) System');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `drm_system` SET TAGS ('dbx_value_regex' = 'widevine|playready|fairplay|primetime|marlin|clearkey');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `drm_vendor` SET TAGS ('dbx_business_glossary_term' = 'DRM Vendor');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `encryption_scheme` SET TAGS ('dbx_business_glossary_term' = 'Encryption Scheme');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `encryption_scheme` SET TAGS ('dbx_value_regex' = 'cenc|cbc1|cens|cbcs');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `geo_restriction_enabled` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `hdcp_level_required` SET TAGS ('dbx_business_glossary_term' = 'High-bandwidth Digital Content Protection (HDCP) Level Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `key_rotation_interval_hours` SET TAGS ('dbx_business_glossary_term' = 'Key Rotation Interval (Hours)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `license_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'License Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `license_server_endpoint` SET TAGS ('dbx_business_glossary_term' = 'License Server Endpoint URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `license_server_endpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `max_device_registrations` SET TAGS ('dbx_business_glossary_term' = 'Maximum Device Registrations');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `offline_license_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Offline License Duration (Hours)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `offline_playback_enabled` SET TAGS ('dbx_business_glossary_term' = 'Offline Playback Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `offline_playback_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Offline Playback Window (Hours)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `persistent_license_enabled` SET TAGS ('dbx_business_glossary_term' = 'Persistent License Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `playback_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Playback Duration (Hours)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'DRM Policy Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'DRM Policy Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `policy_priority` SET TAGS ('dbx_business_glossary_term' = 'Policy Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'DRM Policy Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|deprecated|retired');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `rental_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Rental Duration (Hours)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `screen_capture_blocked` SET TAGS ('dbx_business_glossary_term' = 'Screen Capture Blocked');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'sw_secure_crypto|sw_secure_decode|hw_secure_crypto|hw_secure_decode|hw_secure_all');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `token_expiry_seconds` SET TAGS ('dbx_business_glossary_term' = 'Token Expiry (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `widevine_security_level` SET TAGS ('dbx_business_glossary_term' = 'Widevine Security Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `widevine_security_level` SET TAGS ('dbx_value_regex' = 'L1|L2|L3');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` SET TAGS ('dbx_subdomain' = 'signal_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `cdn_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Configuration ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `bandwidth_limit_gbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Limit Gigabits Per Second (Gbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `cache_control_header` SET TAGS ('dbx_business_glossary_term' = 'Cache-Control Header');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `cache_ttl_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cache Time-To-Live (TTL) Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_business_glossary_term' = 'CDN Provider');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_value_regex' = 'akamai|cloudflare|cloudfront|fastly|limelight|level3');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `compression_enabled` SET TAGS ('dbx_business_glossary_term' = 'Compression Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `configuration_name` SET TAGS ('dbx_business_glossary_term' = 'CDN Configuration Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `cost_per_gb` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Gigabyte (GB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `cost_per_gb` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deactivated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `failover_origin_url` SET TAGS ('dbx_business_glossary_term' = 'Failover Origin URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `geo_blocking_countries` SET TAGS ('dbx_business_glossary_term' = 'Geo-Blocking Countries');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `geo_blocking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Geo-Blocking Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `geo_blocking_mode` SET TAGS ('dbx_business_glossary_term' = 'Geo-Blocking Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `geo_blocking_mode` SET TAGS ('dbx_value_regex' = 'allow_list|deny_list');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Health Check Interval Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `health_check_url` SET TAGS ('dbx_business_glossary_term' = 'Health Check URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `health_check_url` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `health_check_url` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `http2_enabled` SET TAGS ('dbx_business_glossary_term' = 'HTTP/2 Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `ipv6_enabled` SET TAGS ('dbx_business_glossary_term' = 'IPv6 Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Health Check Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|testing');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `origin_pull_url` SET TAGS ('dbx_business_glossary_term' = 'Origin Pull URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `prefetch_enabled` SET TAGS ('dbx_business_glossary_term' = 'Prefetch Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `property_hostname` SET TAGS ('dbx_business_glossary_term' = 'CDN Property Hostname');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_business_glossary_term' = 'Provisioned Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `query_string_caching_mode` SET TAGS ('dbx_business_glossary_term' = 'Query String Caching Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `query_string_caching_mode` SET TAGS ('dbx_value_regex' = 'ignore_all|include_all|include_specified');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|basic');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_business_glossary_term' = 'SLA Uptime Target Percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `ssl_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'SSL Certificate Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `ssl_certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'SSL Certificate Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `token_authentication_enabled` SET TAGS ('dbx_business_glossary_term' = 'Token Authentication Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `token_authentication_scheme` SET TAGS ('dbx_business_glossary_term' = 'Token Authentication Scheme');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `token_authentication_scheme` SET TAGS ('dbx_value_regex' = 'query_string|cookie|header');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `token_secret_key` SET TAGS ('dbx_business_glossary_term' = 'Token Secret Key');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `token_secret_key` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `token_secret_key` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` SET TAGS ('dbx_subdomain' = 'signal_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `delivery_sla_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Service Level Agreement (SLA) ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `applicable_platform` SET TAGS ('dbx_business_glossary_term' = 'Applicable Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|under_review');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `cdn_availability_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Availability Target Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `delivery_sla_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `delivery_sla_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|expired|draft|pending_approval');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `delivery_sla_description` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = 'linear|ott|mvpd|vmvpd|fast|cdn');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `error_rate_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Error Rate Threshold Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Email');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `max_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Maximum Latency Milliseconds (ms)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_value_regex' = 'real-time|hourly|daily|weekly|monthly');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `measurement_window` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `measurement_window` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly|quarterly');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'real-time|daily|weekly|monthly|quarterly');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `service_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `service_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|basic|enterprise');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `sla_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard|basic');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `stream_start_time_target_ms` SET TAGS ('dbx_business_glossary_term' = 'Stream Start Time Target Milliseconds (ms)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `uptime_commitment_percent` SET TAGS ('dbx_business_glossary_term' = 'Uptime Commitment Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` SET TAGS ('dbx_subdomain' = 'signal_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `signal_route_id` SET TAGS ('dbx_business_glossary_term' = 'Signal Route ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `cdn_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Configuration ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `network_circuit_id` SET TAGS ('dbx_business_glossary_term' = 'Network Circuit Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Playout Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `satellite_transponder_id` SET TAGS ('dbx_business_glossary_term' = 'Satellite Transponder ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Definition ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `backup_path_description` SET TAGS ('dbx_business_glossary_term' = 'Backup Path Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `bandwidth_mbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth (Mbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Provider');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deactivated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `destination_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Destination Endpoint URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `destination_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `downlink_frequency_mhz` SET TAGS ('dbx_business_glossary_term' = 'Downlink Frequency (MHz)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `drm_license_server_url` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) License Server URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `drm_license_server_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `drm_system` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) System');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `encryption_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Encryption Algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `failover_mode` SET TAGS ('dbx_business_glossary_term' = 'Failover Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `failover_mode` SET TAGS ('dbx_value_regex' = 'automatic|manual|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `failover_priority` SET TAGS ('dbx_business_glossary_term' = 'Failover Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `failover_threshold_seconds` SET TAGS ('dbx_business_glossary_term' = 'Failover Threshold (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `ird_model` SET TAGS ('dbx_business_glossary_term' = 'Integrated Receiver Decoder (IRD) Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `ird_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Integrated Receiver Decoder (IRD) Serial Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `latency_target_ms` SET TAGS ('dbx_business_glossary_term' = 'Latency Target (Milliseconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|standby|inactive|maintenance|testing|decommissioned');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `playout_system_code` SET TAGS ('dbx_business_glossary_term' = 'Playout System ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `polarization` SET TAGS ('dbx_business_glossary_term' = 'Signal Polarization');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `polarization` SET TAGS ('dbx_value_regex' = 'horizontal|vertical|left_circular|right_circular');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `primary_path_description` SET TAGS ('dbx_business_glossary_term' = 'Primary Path Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_business_glossary_term' = 'Provisioned Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `qos_tier` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `qos_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|basic');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Signal Route Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `route_name` SET TAGS ('dbx_business_glossary_term' = 'Signal Route Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `route_type` SET TAGS ('dbx_business_glossary_term' = 'Signal Route Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `route_type` SET TAGS ('dbx_value_regex' = 'linear_broadcast|ott_streaming|hybrid|satellite_uplink|terrestrial|ip_interconnect');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `transport_protocol` SET TAGS ('dbx_business_glossary_term' = 'Transport Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ALTER COLUMN `uplink_frequency_mhz` SET TAGS ('dbx_business_glossary_term' = 'Uplink Frequency (MHz)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` SET TAGS ('dbx_subdomain' = 'signal_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `release_window_id` SET TAGS ('dbx_business_glossary_term' = 'Release Window Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `coppa_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Coppa Declaration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Policy Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Windowing Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` SET TAGS ('dbx_subdomain' = 'signal_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_event_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Event ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `device_type_id` SET TAGS ('dbx_business_glossary_term' = 'Device Type ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `eas_log_id` SET TAGS ('dbx_business_glossary_term' = 'Eas Log Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_business_glossary_term' = 'Playback Session ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Equipment Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_channel_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ALTER COLUMN `delivery_channel_type` SET TAGS ('dbx_value_regex' = 'linear_broadcast|ott_streaming|vod|fast_channel|mvpd|vmvpd');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` SET TAGS ('dbx_subdomain' = 'signal_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `sla_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `noc_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Noc Alert Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Definition Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `affected_platform` SET TAGS ('dbx_business_glossary_term' = 'Affected Distribution Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `affected_region` SET TAGS ('dbx_business_glossary_term' = 'Affected Geographic Region');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `breach_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Breach Duration in Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `breach_status` SET TAGS ('dbx_business_glossary_term' = 'Breach Lifecycle Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `breach_status` SET TAGS ('dbx_value_regex' = 'open|acknowledged|investigating|resolved|closed|disputed');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `breach_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Breach Occurrence Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Provider');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `contract_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Breach Detection Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'automated_monitoring|customer_report|manual_audit|health_check|synthetic_test');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|tier_1|tier_2|tier_3|executive');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `makegood_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Triggered Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Performance Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Metric Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `metric_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Metric Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `metric_type` SET TAGS ('dbx_value_regex' = 'availability|latency|throughput|error_rate|response_time|packet_loss');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Breach Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `partner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `penalty_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Taken');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Breach Resolution Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'cdn_failure|origin_failure|network_congestion|ddos_attack|configuration_error|capacity_exceeded');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Detailed Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'HLS|MPEG-DASH|Smooth Streaming|RTMP|WebRTC');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Threshold Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Metric Unit of Measure');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `validated_by` SET TAGS ('dbx_business_glossary_term' = 'Validated By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `validated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Performance Variance Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ALTER COLUMN `variance_value` SET TAGS ('dbx_business_glossary_term' = 'Performance Variance Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` SET TAGS ('dbx_subdomain' = 'advertising_insertion');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `dai_session_id` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Session Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `dai_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Dai Configuration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_business_glossary_term' = 'Playback Session Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `political_ad_record_id` SET TAGS ('dbx_business_glossary_term' = 'Political Ad Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `ad_decision_server_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Ad Decision Server Response Time in Milliseconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `ad_decision_server_url` SET TAGS ('dbx_business_glossary_term' = 'Ad Decision Server Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `ad_pod_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Duration in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_value_regex' = 'pre_roll|mid_roll|post_roll|overlay|pause_ad|companion');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `ad_pod_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Sequence Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `ad_targeting_segment_ids` SET TAGS ('dbx_business_glossary_term' = 'Ad Targeting Segment Identifiers');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `ads_fallback_count` SET TAGS ('dbx_business_glossary_term' = 'Fallback Ads Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `ads_inserted_count` SET TAGS ('dbx_business_glossary_term' = 'Ads Inserted Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `ads_requested_count` SET TAGS ('dbx_business_glossary_term' = 'Ads Requested Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `app_version` SET TAGS ('dbx_business_glossary_term' = 'Application Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `blackout_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Blackout Override Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `drm_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Enforcement Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `fill_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `frequency_cap_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Applied Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `geographic_dma_code` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `scte35_cue_type` SET TAGS ('dbx_business_glossary_term' = 'Society of Cable Telecommunications Engineers (SCTE) 35 Cue Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `scte35_signal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Society of Cable Telecommunications Engineers (SCTE) 35 Signal Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Session End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Session Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `session_status` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Session Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `session_status` SET TAGS ('dbx_value_regex' = 'completed|partial|failed|timeout|abandoned');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `stitching_mode` SET TAGS ('dbx_business_glossary_term' = 'Ad Stitching Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `stitching_mode` SET TAGS ('dbx_value_regex' = 'server_side|client_side|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'hls|dash|smooth_streaming|hds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `total_ad_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Ad Duration in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Viewer Internet Protocol (IP) Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` SET TAGS ('dbx_subdomain' = 'partner_carriage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `retransmission_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Negotiator Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcaster ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Source Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `authorized_dma_list` SET TAGS ('dbx_business_glossary_term' = 'Authorized Designated Market Area (DMA) List');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `blackout_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Blackout Provision Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `blackout_terms` SET TAGS ('dbx_business_glossary_term' = 'Blackout Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `cash_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Compensation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `cash_compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `channel_carriage_commitment` SET TAGS ('dbx_business_glossary_term' = 'Channel Carriage Commitment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|one_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `compensation_type` SET TAGS ('dbx_value_regex' = 'cash|reverse_compensation|channel_carriage|promotional|hybrid|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `consent_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Agreement Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `consent_agreement_number` SET TAGS ('dbx_value_regex' = '^RTC-[0-9]{8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'retransmission_consent|must_carry');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'arbitration|mediation|litigation|FCC_complaint');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `fcc_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Federal Communications Commission (FCC) Filing Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'local|regional|national');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `good_faith_negotiation_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Faith Negotiation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `must_carry_election_date` SET TAGS ('dbx_business_glossary_term' = 'Must-Carry Election Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `must_carry_election_flag` SET TAGS ('dbx_business_glossary_term' = 'Must-Carry Election Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `mvpd_type` SET TAGS ('dbx_business_glossary_term' = 'Multichannel Video Programming Distributor (MVPD) Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `mvpd_type` SET TAGS ('dbx_value_regex' = 'cable|satellite|telco|vMVPD|IPTV');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `negotiation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Completion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `negotiation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `promotional_commitment` SET TAGS ('dbx_business_glossary_term' = 'Promotional Commitment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` SET TAGS ('dbx_subdomain' = 'partner_carriage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `subscriber_count_report_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Count Report ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|disputed|under_review|conditionally_approved');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `audit_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `audit_rights_exercised` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Exercised');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `auditor_notes` SET TAGS ('dbx_business_glossary_term' = 'Auditor Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `carriage_fee_per_subscriber` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Per Subscriber');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `carriage_fee_per_subscriber` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `dispute_resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `dispute_resolution_status` SET TAGS ('dbx_value_regex' = 'open|in_negotiation|resolved|escalated|arbitration');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `invoice_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Generated Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `invoice_reference` SET TAGS ('dbx_business_glossary_term' = 'Invoice Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Report Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `report_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_verification|verified|invoiced|archived');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `reported_subscriber_count` SET TAGS ('dbx_business_glossary_term' = 'Reported Subscriber Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `reporting_period_type` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `reporting_period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|custom');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `third_party_auditor` SET TAGS ('dbx_business_glossary_term' = 'Third Party Auditor');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `variance_count` SET TAGS ('dbx_business_glossary_term' = 'Variance Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `variance_explanation` SET TAGS ('dbx_business_glossary_term' = 'Variance Explanation');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `variance_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'automated|manual|third_party_audit|sampling|full_audit');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ALTER COLUMN `verified_subscriber_count` SET TAGS ('dbx_business_glossary_term' = 'Verified Subscriber Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` SET TAGS ('dbx_subdomain' = 'partner_carriage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `channel_lineup_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Lineup Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` SET TAGS ('dbx_subdomain' = 'playout_compliance');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `playout_feed_id` SET TAGS ('dbx_business_glossary_term' = 'Playout Feed Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Abr Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Policy Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `encoder_config_id` SET TAGS ('dbx_business_glossary_term' = 'Encoder Config Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `failover_feed_id` SET TAGS ('dbx_business_glossary_term' = 'Failover Feed Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Playout Engineer Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `signal_route_id` SET TAGS ('dbx_business_glossary_term' = 'Signal Route Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Equipment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '4:3|16:9|21:9');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `audio_bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Audio Bitrate (Kilobits Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `audio_channel_config` SET TAGS ('dbx_business_glossary_term' = 'Audio Channel Configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `audio_channel_config` SET TAGS ('dbx_value_regex' = 'mono|stereo|5.1|7.1|Dolby Atmos');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `audio_codec` SET TAGS ('dbx_value_regex' = 'AAC|AC-3|E-AC-3|MPEG-1 Layer II|Opus');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `automation_mode` SET TAGS ('dbx_business_glossary_term' = 'Automation Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `automation_mode` SET TAGS ('dbx_value_regex' = 'fully_automated|semi_automated|manual');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `branding_profile` SET TAGS ('dbx_business_glossary_term' = 'Branding Profile');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `closed_caption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deactivated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `failover_trigger_mode` SET TAGS ('dbx_business_glossary_term' = 'Failover Trigger Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `failover_trigger_mode` SET TAGS ('dbx_value_regex' = 'automatic|manual|scheduled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `feed_code` SET TAGS ('dbx_business_glossary_term' = 'Playout Feed Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `feed_name` SET TAGS ('dbx_business_glossary_term' = 'Playout Feed Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `feed_type` SET TAGS ('dbx_business_glossary_term' = 'Playout Feed Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `feed_type` SET TAGS ('dbx_value_regex' = 'primary|backup|redundant|test|preview');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate (Frames Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `graphics_overlay_enabled` SET TAGS ('dbx_business_glossary_term' = 'Graphics Overlay Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `graphics_template_code` SET TAGS ('dbx_business_glossary_term' = 'Graphics Template Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Health Check Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `multicast_address` SET TAGS ('dbx_business_glossary_term' = 'Multicast Internet Protocol (IP) Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `multicast_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `multicast_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|standby|offline|maintenance|error|testing');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `output_format` SET TAGS ('dbx_business_glossary_term' = 'Output Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `output_format` SET TAGS ('dbx_value_regex' = 'SDI|IP|ASI|SRT|RIST|NDI');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `playout_server_code` SET TAGS ('dbx_business_glossary_term' = 'Playout Server Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `port_number` SET TAGS ('dbx_business_glossary_term' = 'Network Port Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_business_glossary_term' = 'Provisioned Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `redundancy_mode` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `redundancy_mode` SET TAGS ('dbx_value_regex' = 'none|hot_standby|active_active|N+1');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `scte35_enabled` SET TAGS ('dbx_business_glossary_term' = 'Society of Cable Telecommunications Engineers (SCTE) 35 Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `service_identifier` SET TAGS ('dbx_business_glossary_term' = 'Service Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `subtitle_format` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `subtitle_format` SET TAGS ('dbx_value_regex' = 'DVB|Teletext|CEA-608|CEA-708|TTML|WebVTT');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `transport_stream_identifier` SET TAGS ('dbx_business_glossary_term' = 'Transport Stream Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `uptime_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Uptime Target Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `video_bitrate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Video Bitrate (Megabits Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `video_codec` SET TAGS ('dbx_value_regex' = 'H.264|H.265|MPEG-2|AV1|VP9');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ALTER COLUMN `video_resolution` SET TAGS ('dbx_value_regex' = 'SD|HD|FHD|UHD|4K|8K');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` SET TAGS ('dbx_subdomain' = 'partner_carriage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Source Opportunity Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` SET TAGS ('dbx_subdomain' = 'signal_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `content_delivery_order_id` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Order Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Policy Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Coordinator Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `rights_availability_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Window Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Service Invoice Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Source Opportunity Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `target_platform` SET TAGS ('dbx_business_glossary_term' = 'Target Distribution Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `target_platform` SET TAGS ('dbx_value_regex' = 'linear_broadcast|ott_streaming|mvpd|vmvpd|fast_channel|cdn');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `transcode_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Transcode Profile Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ALTER COLUMN `video_resolution` SET TAGS ('dbx_value_regex' = 'sd|hd_720p|hd_1080p|uhd_4k|uhd_8k');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` SET TAGS ('dbx_subdomain' = 'partner_carriage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` SET TAGS ('dbx_association_edges' = 'distribution.ott_platform,partner.partner_partner');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `platform_distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Distribution Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Distribution Agreement - Ott Platform Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Distribution Agreement - Partner Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `carriage_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `distribution_territories` SET TAGS ('dbx_business_glossary_term' = 'Distribution Territories');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `exclusivity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `exclusivity_end_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `exclusivity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `exclusivity_start_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `minimum_subscriber_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Subscriber Commitment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `minimum_subscriber_commitment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `platform_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Platform Launch Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'SLA Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`endpoint_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`endpoint_allocation` SET TAGS ('dbx_subdomain' = 'partner_carriage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`endpoint_allocation` SET TAGS ('dbx_association_edges' = 'distribution.streaming_endpoint,partner.partner_partner');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`endpoint_allocation` ALTER COLUMN `endpoint_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Allocation Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`endpoint_allocation` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Allocation - Partner Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`endpoint_allocation` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Allocation - Streaming Endpoint Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`endpoint_allocation` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Activated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`endpoint_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`endpoint_allocation` ALTER COLUMN `bandwidth_allocation_gbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Allocation');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`endpoint_allocation` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`endpoint_allocation` ALTER COLUMN `cost_per_gb` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Gigabyte');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`endpoint_allocation` ALTER COLUMN `cost_per_gb` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`endpoint_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`endpoint_allocation` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Deactivated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`endpoint_allocation` ALTER COLUMN `geo_restriction_rules` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Rules');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`endpoint_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`endpoint_allocation` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Provisioned Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`endpoint_allocation` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` SET TAGS ('dbx_subdomain' = 'playout_compliance');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` SET TAGS ('dbx_association_edges' = 'distribution.delivery_channel,mediaasset.media_asset');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` ALTER COLUMN `playout_id` SET TAGS ('dbx_business_glossary_term' = 'Playout Event Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Playout - Delivery Channel Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Playout - Media Asset Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Transmission End');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Transmission Start');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` ALTER COLUMN `ad_insertion_enabled` SET TAGS ('dbx_business_glossary_term' = 'Ad Insertion Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` ALTER COLUMN `blackout_applied` SET TAGS ('dbx_business_glossary_term' = 'Blackout Restriction Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Scheduler User');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Entry Creation Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Playout End Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` ALTER COLUMN `playout_status` SET TAGS ('dbx_business_glossary_term' = 'Playout Event Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` ALTER COLUMN `preemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Preemption Justification');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Playout Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Playout Sequence Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Playout Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` SET TAGS ('dbx_subdomain' = 'playout_compliance');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` SET TAGS ('dbx_association_edges' = 'distribution.delivery_channel,compliance.regulatory_obligation');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` ALTER COLUMN `channel_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Compliance Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Compliance - Delivery Channel Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Compliance - Regulatory Obligation Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` ALTER COLUMN `exemption_basis` SET TAGS ('dbx_business_glossary_term' = 'Exemption Basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` ALTER COLUMN `last_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` ALTER COLUMN `next_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Next Filing Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` ALTER COLUMN `responsible_contact` SET TAGS ('dbx_business_glossary_term' = 'Responsible Contact');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
