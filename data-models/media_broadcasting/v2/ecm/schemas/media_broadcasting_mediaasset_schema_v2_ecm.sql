-- Schema for Domain: mediaasset | Business:  | Version: v2_ecm
-- Generated on: 2026-06-30 04:18:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`mediaasset` COMMENT 'Authoritative repository for all managed media files and digital objects — raw camera footage, mezzanine masters, proxy files, graphics, music beds, and archived assets. Implements MAM (Media Asset Management) via Dalet Galaxy, enforcing storage tiering, format standards (MPEG-4 ISO 14496), checksum integrity, retention policies, format migrations, and chain-of-custody audit trails for regulatory and legal hold compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` (
    `media_asset_id` BIGINT COMMENT 'Unique identifier for the media asset record in the MAM (Media Asset Management) system. Primary key for all digital objects managed by Dalet Galaxy. | Column media_asset_id (BIGINT) in mediaasset.media_asset',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production assets are charged to cost centers for budget tracking and cost allocation. Essential for production accounting, variance analysis, and departmental P&L reporting in media operations. | Column cost_center_id (BIGINT) in finance.media_asset',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Assets generate revenue through distribution channels (theatrical, streaming, syndication) tracked by profit center. Required for content P&L reporting, ROI analysis, and segment performance measureme | Column profit_center_id (BIGINT) in finance.media_asset',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.media_asset',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.media_asset',
    `archived_timestamp` TIMESTAMP COMMENT 'Date and time when the asset was moved to archive storage tier. Null if asset has never been archived. | Column archived_timestamp (TIMESTAMP) in mediaasset.media_asset',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the video content. Determines letterboxing and pillarboxing requirements for different distribution channels. | Column aspect_ratio (NUMERIC) in mediaasset.media_asset',
    `asset_class` STRING COMMENT 'Classification of the asset based on its production workflow stage and quality level. Raw=unprocessed camera footage, Mezzanine=high-quality intermediate, Proxy=low-res preview, Archive=long-term preservation, Master=final approved version. | Column asset_class (STRING) in mediaasset.media_asset. Valid values are `raw|mezzanine|proxy|archive|master`',
    `asset_title` STRING COMMENT 'Primary human-readable title or name of the media asset. Used for search, cataloging, and display in MAM interfaces. | Column asset_title (STRING) in mediaasset.media_asset',
    `asset_type` STRING COMMENT 'Primary media type classification of the digital object. Determines handling, playback, and workflow routing in the MAM system. [ENUM-REF-CANDIDATE: video|audio|image|graphics|document|subtitle|caption — 7 candidates stripped; promote to reference product] | Column asset_type (STRING) in mediaasset.media_asset',
    `audio_bit_depth` STRING COMMENT 'Audio bit depth in bits per sample (e.g., 16, 24). Higher bit depth provides greater dynamic range and lower quantization noise. | Column audio_bit_depth (INT) in mediaasset.media_asset',
    `audio_channels` STRING COMMENT 'Number of discrete audio channels in the asset (e.g., 2 for stereo, 6 for 5.1 surround, 8 for 7.1, 16 for multi-language tracks). Determines audio routing and mixing requirements. | Column audio_channels (INT) in mediaasset.media_asset',
    `audio_sample_rate_khz` DECIMAL(18,2) COMMENT 'Audio sampling frequency in kilohertz (e.g., 48.000 for broadcast, 44.100 for CD quality). Indicates audio quality and broadcast compliance. | Column audio_sample_rate_khz (DECIMAL(6,3)) in mediaasset.media_asset',
    `bit_rate_mbps` DECIMAL(18,2) COMMENT 'Average bit rate of the encoded media in megabits per second. Indicates quality level and bandwidth requirements for streaming and playout. | Column bit_rate_mbps (DECIMAL(10,3)) in mediaasset.media_asset',
    `checksum_md5` STRING COMMENT 'MD5 hash of the file content for integrity verification. Used to detect corruption during transfer, storage, and archival operations. | Column checksum_md5 (STRING) in mediaasset.media_asset. Valid values are `^[a-f0-9]{32}$`',
    `checksum_sha256` STRING COMMENT 'SHA-256 cryptographic hash for enhanced integrity verification and chain-of-custody audit trails. Required for regulatory compliance and legal hold. | Column checksum_sha256 (STRING) in mediaasset.media_asset. Valid values are `^[a-f0-9]{64}$`',
    `codec` STRING COMMENT 'Video or audio compression codec used for encoding (e.g., H.264, H.265/HEVC, ProRes, DNxHD, AAC, PCM). Critical for quality assessment and transcoding decisions. | Column codec (STRING) in mediaasset.media_asset',
    `color_space` STRING COMMENT 'Color space standard used for encoding (e.g., BT.709 for HD, BT.2020 for UHD/HDR). Critical for color accuracy across distribution platforms. | Column color_space (STRING) in mediaasset.media_asset. Valid values are `BT.709|BT.2020|DCI-P3|sRGB|Adobe RGB`',
    `content_classification` STRING COMMENT 'Business classification tags for content categorization (e.g., news, sports, drama, documentary, commercial, promo). Supports search, rights management, and workflow routing. Pipe-separated list for multiple classifications. | Column content_classification (STRING) in mediaasset.media_asset',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in mediaasset.media_asset',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Total playback duration of the media asset in seconds with millisecond precision. Used for scheduling, ad insertion planning, and rights windowing calculations. | Column duration_seconds (DECIMAL(12,3)) in mediaasset.media_asset',
    `eidr` STRING COMMENT 'Universal unique identifier for film and television assets. Enables global content identification for distribution and rights management. | Column eidr (STRING) in mediaasset.media_asset. Valid values are `^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$`',
    `file_format` STRING COMMENT 'Container format of the media file (e.g., MXF, MP4, MOV, AVI, WAV). Determines compatibility with playout and editing systems. | Column file_format (STRING) in mediaasset.media_asset',
    `file_size_bytes` BIGINT COMMENT 'Total file size in bytes. Used for storage capacity planning, transfer time estimation, and billing calculations. | Column file_size_bytes (BIGINT) in mediaasset.media_asset',
    `frame_rate` DECIMAL(18,2) COMMENT 'Video frame rate in frames per second (e.g., 23.976, 24.000, 25.000, 29.970, 30.000, 50.000, 59.940, 60.000). Critical for broadcast standards compliance and motion quality. | Column frame_rate (DECIMAL(6,3)) in mediaasset.media_asset',
    `hdr_format` STRING COMMENT 'HDR encoding format if applicable. SDR=Standard Dynamic Range, HDR10/HDR10+/Dolby Vision=High Dynamic Range variants, HLG=Hybrid Log-Gamma for broadcast. | Column hdr_format (STRING) in mediaasset.media_asset. Valid values are `SDR|HDR10|HDR10+|Dolby Vision|HLG`',
    `ingest_timestamp` TIMESTAMP COMMENT 'Date and time when the asset was first ingested into the MAM system. Marks the beginning of the assets lifecycle in the enterprise repository. | Column ingest_timestamp (TIMESTAMP) in mediaasset.media_asset',
    `isan` STRING COMMENT 'ISO 15706 international identifier for audiovisual works. Used for content registration and rights management across territories. | Column isan (STRING) in mediaasset.media_asset. Valid values are `^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]$`',
    `isrc` STRING COMMENT 'ISO 3901 unique identifier for sound recordings and music video recordings. Used for music beds, audio tracks, and music-related assets. | Column isrc (STRING) in mediaasset.media_asset. Valid values are `^[A-Z]{2}-[A-Z0-9]{3}-[0-9]{2}-[0-9]{5}$`',
    `last_accessed_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent access or playback of the asset. Used for storage tier optimization and usage analytics. | Column last_accessed_timestamp (TIMESTAMP) in mediaasset.media_asset',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether the asset is under legal hold and must not be modified or deleted. Overrides retention policies until hold is released. | Column legal_hold_flag (BOOLEAN) in mediaasset.media_asset',
    `lifecycle_status` STRING COMMENT 'Current state of the asset in its operational lifecycle. Tracks progression from ingest through quality control, active use, archival, and eventual purge. Drives workflow automation and access control. [ENUM-REF-CANDIDATE: ingest|qc_pending|qc_approved|qc_rejected|available|in_use|archived|purged|quarantined — 9 candidates stripped; promote to reference product] | Column lifecycle_status (STRING) in mediaasset.media_asset',
    `originating_system` STRING COMMENT 'Source system or device that created or ingested the asset (e.g., camera model, editing suite, ingest station, external vendor). Provides provenance for chain-of-custody tracking. | Column originating_system (STRING) in mediaasset.media_asset',
    `qc_completed_timestamp` TIMESTAMP COMMENT 'Date and time when quality control review was completed. Null if QC is pending or not required. | Column qc_completed_timestamp (TIMESTAMP) in mediaasset.media_asset',
    `qc_operator` STRING COMMENT 'User ID or name of the operator who performed quality control review. Used for accountability and audit trails. | Column qc_operator (STRING) in mediaasset.media_asset',
    `resolution` STRING COMMENT 'Video frame resolution in pixels (e.g., 1920x1080, 3840x2160, 1280x720). Indicates quality tier and delivery format compatibility. | Column resolution (STRING) in mediaasset.media_asset',
    `retention_expiry_date` DATE COMMENT 'Date when the asset becomes eligible for purge based on retention policy. Null indicates indefinite retention or active legal hold. | Column retention_expiry_date (DATE) in mediaasset.media_asset',
    `retention_policy_code` STRING COMMENT 'Code identifying the retention policy governing lifecycle and purge rules for this asset. Drives automated archival and deletion workflows per regulatory and business requirements. | Column retention_policy_code (STRING) in mediaasset.media_asset',
    `rights_restriction` STRING COMMENT 'Rights and usage restrictions governing distribution and use of the asset. Enforces compliance with licensing agreements, territorial restrictions, and legal holds. | Column rights_restriction (STRING) in mediaasset.media_asset. Valid values are `unrestricted|internal_only|licensed|embargoed|restricted_territory|legal_hold`',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in mediaasset.media_asset',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.media_asset',
    `storage_location_uri` STRING COMMENT 'Full URI path to the physical storage location of the media file (e.g., s3://bucket/path, file://server/share/path). Used by MAM for retrieval and playout automation. | Column storage_location_uri (STRING) in mediaasset.media_asset',
    `storage_tier` STRING COMMENT 'Current storage tier assignment based on access frequency and retention policy. Hot=online high-performance, Warm=nearline, Cold=offline tape, Deep-archive=long-term preservation, Glacier=regulatory hold. | Column storage_tier (STRING) in mediaasset.media_asset. Valid values are `hot|warm|cold|deep_archive|glacier`',
    `timecode_start` STRING COMMENT 'SMPTE timecode of the first frame in HH:MM:SS:FF format. Essential for frame-accurate editing and playout synchronization. | Column timecode_start (STRING) in mediaasset.media_asset. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9][:;][0-9]{2}$`',
    `umid` STRING COMMENT 'SMPTE 330M globally unique identifier for the media essence. 64-character hexadecimal string providing universal identification across systems and organizations. | Column umid (STRING) in mediaasset.media_asset. Valid values are `^[0-9A-F]{64}$`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.media_asset',
    CONSTRAINT pk_media_asset PRIMARY KEY(`media_asset_id`)
) COMMENT 'Core master record for every managed digital object in the MAM (Dalet Galaxy) — raw camera footage, mezzanine masters, graphics, music beds, and archived assets. Stores canonical asset identity, technical format metadata (codec, resolution, duration, bit-rate, aspect ratio, color space, audio channels, frame rate), asset class (raw/mezzanine/proxy/archive), storage tier (hot/warm/cold/deep-archive), lifecycle status (ingest/QC/approved/archived/purged), industry identifiers (ISAN/EIDR/ISRC/UMID), originating system reference, and content classification tags. Single source of truth for all digital object identities and their technical characteristics across the enterprise. | Unity Catalog table: media_broadcasting_ecm.mediaasset.media_asset';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` (
    `asset_version_id` BIGINT COMMENT 'Unique identifier for the asset version record. Primary key. | Column asset_version_id (BIGINT) in mediaasset.asset_version',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Specific versions may be delivered by different partners (e.g., international dub from foreign partner, localized version from regional distributor). Tracks provenance for quality issues, delivery acc | Column delivery_partner_partner_partner_id (BIGINT) in partner.asset_version',
    `format_specification_id` BIGINT COMMENT 'Foreign key linking to mediaasset.format_specification. Business justification: Normalization: each version conforms to a format specification from the catalog. The format_specification STRING attribute becomes a FK. Format details (codec, resolution, bitrate, etc.) retrieved via | Column format_specification_id (BIGINT) in mediaasset.asset_version',
    `media_asset_id` BIGINT COMMENT 'Reference to the parent media asset of which this is a version or rendition. | Column media_asset_id (BIGINT) in mediaasset.asset_version',
    `transcode_job_id` BIGINT COMMENT 'Reference to the transcode or encoding job that created this version. Links to workflow orchestration system (Dalet Galaxy) for lineage tracking and troubleshooting. | Column transcode_job_id (STRING) in mediaasset.asset_version',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.asset_version',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.asset_version',
    `abr_ladder_rung` STRING COMMENT 'Position in the ABR ladder for HLS or DASH streaming (e.g., 1 for lowest quality, 5 for highest). Enables adaptive streaming based on viewer bandwidth. Null if not part of an ABR ladder. | Column abr_ladder_rung (INT) in mediaasset.asset_version',
    `archived_timestamp` TIMESTAMP COMMENT 'Timestamp when this version was moved to archive storage tier. Null if not yet archived. Supports retention policy enforcement and cost optimization. | Column archived_timestamp (TIMESTAMP) in mediaasset.asset_version',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the video (e.g., 16:9, 4:3, 21:9, 1:1). Determines how content is displayed on different screens and platforms. | Column aspect_ratio (NUMERIC) in mediaasset.asset_version',
    `audio_channels` STRING COMMENT 'Number of audio channels in this version (e.g., 2 for stereo, 6 for 5.1 surround, 8 for 7.1 surround). Determines audio format and playback capability requirements. | Column audio_channels (INT) in mediaasset.asset_version',
    `audio_codec` STRING COMMENT 'Audio compression codec used in this version (e.g., AAC, AC-3, Dolby Digital, Opus, MP3). Determines audio quality, compatibility, and decoding requirements. | Column audio_codec (STRING) in mediaasset.asset_version',
    `bitrate_kbps` STRING COMMENT 'Average bitrate of the encoded media in kilobits per second. Critical for ABR (Adaptive Bitrate Streaming) ladder configuration, CDN bandwidth planning, and QoS (Quality of Service) management. | Column bitrate_kbps (INT) in mediaasset.asset_version',
    `checksum_algorithm` STRING COMMENT 'Algorithm used to generate the checksum value (MD5, SHA-256, SHA-512). Identifies the hashing method for integrity verification. | Column checksum_algorithm (STRING) in mediaasset.asset_version. Valid values are `MD5|SHA-256|SHA-512`',
    `checksum_value` DECIMAL(18,2) COMMENT 'Cryptographic hash (MD5 or SHA-256) of the file content. Ensures integrity verification, detects corruption during transfer or storage, and supports chain-of-custody audit trails for legal hold and regulatory compliance. | Column checksum_value (DECIMAL(18,2)) in mediaasset.asset_version',
    `color_space` STRING COMMENT 'Color space and gamut specification for this version (e.g., Rec. 709, Rec. 2020, DCI-P3, sRGB). Critical for HDR (High Dynamic Range) content and color accuracy across distribution channels. | Column color_space (STRING) in mediaasset.asset_version',
    `container_format` STRING COMMENT 'File container format wrapping the audio and video streams (e.g., MP4, MOV, MXF, TS, WebM). Determines file compatibility and metadata support. | Column container_format (STRING) in mediaasset.asset_version',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in mediaasset.asset_version',
    `created_by_user` STRING COMMENT 'Username or identifier of the user or system that created this version. Supports chain-of-custody audit trails for legal hold and regulatory compliance. | Column created_by_user (STRING) in mediaasset.asset_version',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this version record was first created in the MAM (Media Asset Management) system. Supports audit trails and chain-of-custody for regulatory compliance. | Column created_timestamp (TIMESTAMP) in mediaasset.asset_version',
    `drm_protection` BOOLEAN COMMENT 'Indicates whether this version is protected by DRM encryption (True/False). DRM systems include Widevine, PlayReady, FairPlay. Supports content security and anti-piracy. | Column drm_protection (BOOLEAN) in mediaasset.asset_version',
    `drm_system` STRING COMMENT 'DRM system used to protect this version if drm_protection is True (e.g., Widevine, PlayReady, FairPlay, AES-128). Identifies the encryption and key management system. | Column drm_system (STRING) in mediaasset.asset_version',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Total playback duration of this version in seconds. Used for scheduling, ad pod placement, and content inventory management. | Column duration_seconds (DECIMAL(10,2)) in mediaasset.asset_version',
    `file_size_bytes` BIGINT COMMENT 'Size of the media file in bytes. Used for storage capacity planning, CDN (Content Delivery Network) bandwidth estimation, and archive cost calculation. | Column file_size_bytes (BIGINT) in mediaasset.asset_version',
    `frame_rate` DECIMAL(18,2) COMMENT 'Video frame rate in frames per second (e.g., 23.98, 25.00, 29.97, 59.94). Determines playback smoothness and broadcast standard compliance (NTSC, PAL, ATSC). | Column frame_rate (DECIMAL(5,2)) in mediaasset.asset_version',
    `hdr_format` STRING COMMENT 'HDR format specification if applicable (e.g., HDR10, HDR10+, Dolby Vision, HLG). Indicates enhanced brightness and color range capabilities. | Column hdr_format (STRING) in mediaasset.asset_version',
    `language_code` STRING COMMENT 'ISO 639-2 three-letter language code for the primary audio or subtitle track in this version (e.g., eng, spa, fra, deu). Supports localized dub and multi-language distribution. | Column language_code (STRING) in mediaasset.asset_version',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this version record was last modified. Tracks updates to metadata, status changes, or re-transcoding events. | Column modified_timestamp (TIMESTAMP) in mediaasset.asset_version',
    `notes` STRING COMMENT 'Free-text notes or comments about this version. Used for QC feedback, production notes, or special handling instructions. | Column notes (STRING) in mediaasset.asset_version',
    `proxy_expiry_date` DATE COMMENT 'Date when this proxy or preview version expires and should be purged from storage. Applicable only when rendition_purpose is proxy or preview. Supports storage cost optimization and compliance with retention policies. | Column proxy_expiry_date (DATE) in mediaasset.asset_version',
    `rendition_purpose` STRING COMMENT 'Business purpose or use case for this version: playout (broadcast transmission), distribution (delivery to platforms), archive (long-term preservation), preview (review/approval), proxy (low-res editing), watermark (forensic tracking), mezzanine (high-quality master), localized_dub (language variant), thumbnail (visual reference). [ENUM-REF-CANDIDATE: playout|distribution|archive|preview|proxy|watermark|mezzanine|localized_dub|thumbnail — 9 candidates stripped; promote to reference product] | Column rendition_purpose (STRING) in mediaasset.asset_version',
    `resolution_height` STRING COMMENT 'Vertical resolution of the video frame in pixels (e.g., 1080 for 1080p, 2160 for 4K). Used for format classification and quality assessment. | Column resolution_height (INT) in mediaasset.asset_version',
    `resolution_width` STRING COMMENT 'Horizontal resolution of the video frame in pixels (e.g., 1920 for 1080p, 3840 for 4K). Used for format classification and quality assessment. | Column resolution_width (INT) in mediaasset.asset_version',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in mediaasset.asset_version',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.asset_version',
    `storage_tier` STRING COMMENT 'Storage tier classification indicating access frequency and cost: hot (frequent access, high cost), warm (occasional access), cold (infrequent access), archive (long-term preservation), glacier (deep archive). Aligns with retention policies and cost optimization. | Column storage_tier (STRING) in mediaasset.asset_version. Valid values are `hot|warm|cold|archive|glacier`',
    `storage_uri` STRING COMMENT 'Full storage path or URI where this version is physically stored (e.g., s3://bucket/path, file://nas/volume/path, https://cdn.example.com/asset). Supports multi-tier storage (hot/warm/cold/archive) and CDN distribution via Akamai. | Column storage_uri (STRING) in mediaasset.asset_version',
    `subtitle_tracks` STRING COMMENT 'Comma-separated list of ISO 639-2 language codes for embedded subtitle or closed caption tracks (e.g., eng,spa,fra). Supports accessibility compliance (COPPA, FCC) and multi-language distribution. | Column subtitle_tracks (STRING) in mediaasset.asset_version',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.asset_version',
    `validated_timestamp` TIMESTAMP COMMENT 'Timestamp when this version passed quality control (QC) validation and was approved for use. Null if validation is pending or failed. | Column validated_timestamp (TIMESTAMP) in mediaasset.asset_version',
    `version_number` STRING COMMENT 'Sequential or semantic version identifier for this rendition (e.g., v1.0, v2.3, proxy_01). Tracks lineage from camera original through derivatives. | Column version_number (STRING) in mediaasset.asset_version',
    `version_status` STRING COMMENT 'Current lifecycle status of this version: active (available for use), archived (moved to long-term storage), deprecated (superseded by newer version), corrupted (integrity check failed), pending_validation (awaiting QC approval), deleted (marked for removal). | Column version_status (STRING) in mediaasset.asset_version. Valid values are `active|archived|deprecated|corrupted|pending_validation|deleted`',
    `video_codec` STRING COMMENT 'Video compression codec used in this version (e.g., H.264/AVC, H.265/HEVC, VP9, AV1, ProRes). Determines video quality, file size, and decoding requirements. | Column video_codec (STRING) in mediaasset.asset_version',
    `watermark_payload` STRING COMMENT 'Forensic watermark identifier or payload embedded in this version for anti-piracy tracking and content protection. Applicable only when rendition_purpose is watermark. Supports DRM (Digital Rights Management) and content security. | Column watermark_payload (STRING) in mediaasset.asset_version',
    CONSTRAINT pk_asset_version PRIMARY KEY(`asset_version_id`)
) COMMENT 'Tracks every distinct version, rendition, or derivative of a media asset — including mezzanine, proxy (low-res preview/edit proxy/thumbnail), HLS/DASH adaptive bitrate ladder rungs, watermarked forensic copies, and localized dubs. Each version captures version number, rendition purpose (playout/distribution/archive/preview/proxy/watermark), format specification reference, file size, checksum (MD5/SHA-256), storage URI, transcode job reference, watermark payload (if applicable), proxy expiry date (if applicable), and version status. Enables full version lineage from camera original through every derivative to final delivery rendition. | Unity Catalog table: media_broadcasting_ecm.mediaasset.asset_version';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` (
    `ingest_job_id` BIGINT COMMENT 'Unique identifier for the media ingest job. Primary key for the ingest_job data product. | Column ingest_job_id (BIGINT) in mediaasset.ingest_job',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Ingest operations incur labor, storage, and infrastructure costs allocated to technical operations cost centers. Enables operational cost tracking, budget variance analysis, and capacity planning. | Column cost_center_id (BIGINT) in finance.ingest_job',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Ingest job creates a specific version (typically the mezzanine or raw master). This FK links the ingest job to the version it produced. Populated upon successful ingest completion. | Column created_asset_version_id (BIGINT) in mediaasset.ingest_job',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or operator who initiated or is responsible for the ingest job. Used for audit trail and accountability. | Column employee_id (BIGINT) in workforce.ingest_job',
    `media_asset_id` BIGINT COMMENT 'Reference to the resulting media asset record created upon successful completion of the ingest job. Establishes chain-of-custody linkage. | Column media_asset_id (BIGINT) in mediaasset.ingest_job',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Content ingested from partner feeds (satellite, FTP, aspera) requires tracking source partner for SLA compliance monitoring, billing reconciliation, delivery acceptance workflows, and automated partne | Column source_partner_partner_partner_id (BIGINT) in partner.ingest_job',
    `tech_change_request_id` BIGINT COMMENT 'Reference to the automated workflow or orchestration process that triggered or manages this ingest job. Used for end-to-end process tracking. | Column tech_change_request_id (BIGINT) in technology.ingest_job',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.ingest_job',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.ingest_job',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the ingested video content. Determines presentation format and compatibility with distribution channels. | Column aspect_ratio (NUMERIC) in mediaasset.ingest_job',
    `audio_channels` STRING COMMENT 'Number of audio channels in the ingested media (e.g., 2 for stereo, 6 for 5.1 surround). Used for audio processing and compliance validation. | Column audio_channels (INT) in mediaasset.ingest_job',
    `bitrate_kbps` STRING COMMENT 'Average bitrate of the ingested media in kilobits per second. Indicator of media quality and storage requirements. | Column bitrate_kbps (INT) in mediaasset.ingest_job',
    `bytes_transferred` BIGINT COMMENT 'Total number of bytes successfully transferred during the ingest operation. Used for capacity planning and performance monitoring. | Column bytes_transferred (BIGINT) in mediaasset.ingest_job',
    `checksum_algorithm` STRING COMMENT 'Cryptographic hash algorithm used to verify file integrity during and after ingest. Critical for chain-of-custody and regulatory compliance. | Column checksum_algorithm (STRING) in mediaasset.ingest_job. Valid values are `MD5|SHA-256|SHA-512|CRC32`',
    `checksum_value` DECIMAL(18,2) COMMENT 'Computed checksum hash of the ingested media file. Used to verify data integrity and detect corruption or tampering. | Column checksum_value (DECIMAL(18,2)) in mediaasset.ingest_job',
    `closed_caption_present` BOOLEAN COMMENT 'Indicates whether closed captions or subtitles are embedded in the ingested media. Required for FCC accessibility compliance validation. | Column closed_caption_present (BOOLEAN) in mediaasset.ingest_job',
    `codec` STRING COMMENT 'Video or audio codec used in the ingested media (e.g., H.264, H.265/HEVC, ProRes, AAC, AC-3). Critical for playback compatibility and transcoding decisions. | Column codec (STRING) in mediaasset.ingest_job',
    `color_space` STRING COMMENT 'Color space standard of the ingested video content. Determines color accuracy and compatibility with HDR/SDR workflows. | Column color_space (STRING) in mediaasset.ingest_job. Valid values are `BT.709|BT.2020|DCI-P3|sRGB`',
    `content_type` STRING COMMENT 'Classification of the media content being ingested. Determines storage tier, retention policy, and downstream workflow routing. [ENUM-REF-CANDIDATE: raw_footage|mezzanine|proxy|graphics|music_bed|archived_asset|master — 7 candidates stripped; promote to reference product] | Column content_type (STRING) in mediaasset.ingest_job',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in mediaasset.ingest_job',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ingest job record was first created in the MAM system. Audit trail entry point for chain-of-custody. | Column created_timestamp (TIMESTAMP) in mediaasset.ingest_job',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Total duration of the ingested media content in seconds. Null for non-time-based media such as still images or graphics. | Column duration_seconds (DECIMAL(12,3)) in mediaasset.ingest_job',
    `error_code` STRING COMMENT 'System-generated error code if the ingest job failed or encountered issues. Null for successful jobs. Maps to error catalog for troubleshooting. | Column error_code (STRING) in mediaasset.ingest_job',
    `error_message` STRING COMMENT 'Human-readable description of any error encountered during ingest. Provides operational context for failure analysis and remediation. | Column error_message (STRING) in mediaasset.ingest_job',
    `frame_rate` DECIMAL(18,2) COMMENT 'Frame rate of the ingested video content in frames per second (e.g., 23.976, 25, 29.97, 50, 59.94). Critical for format compatibility and playout. | Column frame_rate (DECIMAL(6,3)) in mediaasset.ingest_job',
    `hdr_format` STRING COMMENT 'HDR format of the ingested video content. Null or SDR for standard dynamic range content. Critical for premium content workflows. | Column hdr_format (STRING) in mediaasset.ingest_job. Valid values are `SDR|HDR10|HDR10+|Dolby_Vision|HLG`',
    `ingest_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the ingest job completed or terminated. Null for jobs still in progress. | Column ingest_end_timestamp (TIMESTAMP) in mediaasset.ingest_job',
    `ingest_source_type` STRING COMMENT 'Classification of the media source from which content is being ingested. Determines handling protocols and validation rules. | Column ingest_source_type (STRING) in mediaasset.ingest_job. Valid values are `tape|file_transfer|satellite_feed|cloud_upload|live_capture|ftp`',
    `ingest_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the ingest job began processing. Represents the actual start of media transfer, not the queued time. | Column ingest_start_timestamp (TIMESTAMP) in mediaasset.ingest_job',
    `job_number` STRING COMMENT 'Human-readable business identifier for the ingest job, typically formatted as prefix-date-sequence (e.g., ING-20240115-0042). Used for operational tracking and reference. | Column job_number (STRING) in mediaasset.ingest_job. Valid values are `^[A-Z]{3}-[0-9]{8}-[0-9]{4}$`',
    `job_status` STRING COMMENT 'Current lifecycle status of the ingest job. Tracks progression from queued through execution to final disposition. | Column job_status (STRING) in mediaasset.ingest_job. Valid values are `queued|running|completed|failed|cancelled|paused`',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether the ingested media is subject to legal hold and must be preserved for litigation or regulatory investigation. Prevents deletion. | Column legal_hold_flag (BOOLEAN) in mediaasset.ingest_job',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the ingest job record was last modified. Tracks updates to job status, metadata corrections, or error resolution. | Column modified_timestamp (TIMESTAMP) in mediaasset.ingest_job',
    `notes` STRING COMMENT 'Free-text field for operator notes, special handling instructions, or contextual information about the ingest job. Used for operational communication. | Column notes (STRING) in mediaasset.ingest_job',
    `priority_level` STRING COMMENT 'Business priority assigned to the ingest job. Determines queue position and resource allocation for time-sensitive content. | Column priority_level (STRING) in mediaasset.ingest_job. Valid values are `urgent|high|normal|low`',
    `resolution` STRING COMMENT 'Spatial resolution of the ingested video content (e.g., 1920x1080, 3840x2160, 1280x720). Used for quality assessment and distribution planning. | Column resolution (STRING) in mediaasset.ingest_job',
    `retention_policy_code` STRING COMMENT 'Code identifying the retention policy applied to the ingested media. Determines archival tier and deletion schedule per regulatory and business requirements. | Column retention_policy_code (STRING) in mediaasset.ingest_job',
    `source_format` STRING COMMENT 'Technical format of the source media file or stream (e.g., MPEG-4, ProRes, MXF, H.264). Used for transcode planning and compatibility validation. | Column source_format (STRING) in mediaasset.ingest_job',
    `source_location` STRING COMMENT 'Physical or logical location of the source media. May be a tape ID, file path, URL, satellite transponder identifier, or cloud storage bucket path. | Column source_location (STRING) in mediaasset.ingest_job',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in mediaasset.ingest_job',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.ingest_job',
    `target_format` STRING COMMENT 'Desired output format for the ingested media. May differ from source format if transcoding is required during ingest. | Column target_format (STRING) in mediaasset.ingest_job',
    `target_storage_location` STRING COMMENT 'Destination storage path or tier where the ingested media asset will be stored. May reference nearline, online, or archive storage systems. | Column target_storage_location (STRING) in mediaasset.ingest_job',
    `timecode_start` STRING COMMENT 'Starting timecode of the ingested media in SMPTE format (HH:MM:SS:FF). Used for frame-accurate editing and synchronization. | Column timecode_start (STRING) in mediaasset.ingest_job',
    `transfer_rate_mbps` DECIMAL(18,2) COMMENT 'Average data transfer rate achieved during ingest, measured in megabits per second. Key performance indicator for ingest infrastructure. | Column transfer_rate_mbps (DECIMAL(10,2)) in mediaasset.ingest_job',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.ingest_job',
    CONSTRAINT pk_ingest_job PRIMARY KEY(`ingest_job_id`)
) COMMENT 'Transactional record of every media ingest operation executed in Dalet Galaxy — capturing ingest source (tape, file transfer, satellite feed, cloud upload), ingest start/end timestamps, operator identity, source format, target storage location, ingest status (queued/running/completed/failed), bytes transferred, transfer rate, and any error codes encountered. Provides the chain-of-custody entry point for all assets entering the MAM. Links to the resulting media_asset record upon successful completion. | Unity Catalog table: media_broadcasting_ecm.mediaasset.ingest_job';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` (
    `transcode_job_id` BIGINT COMMENT 'Primary key for transcode_job | Column transcode_job_id (BIGINT) in mediaasset.transcode_job',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Transcoding consumes compute resources and labor charged to post-production or technical operations cost centers. Required for project costing, vendor invoice reconciliation, and operational budgeting | Column cost_center_id (BIGINT) in finance.transcode_job',
    `employee_id` BIGINT COMMENT 'Reference to the user or system account that initiated the transcode job request. | Column employee_id (BIGINT) in workforce.transcode_job',
    `it_asset_id` BIGINT COMMENT 'Identifier of the physical or virtual processing node that executed the transcode job, used for troubleshooting and resource tracking. | Column it_asset_id (BIGINT) in technology.transcode_job',
    `media_asset_id` BIGINT COMMENT 'Reference to the source media asset being transcoded. | Column media_asset_id (BIGINT) in mediaasset.transcode_job',
    `format_specification_id` BIGINT COMMENT 'Foreign key linking to mediaasset.format_specification. Business justification: Normalization: transcode job targets an approved format specification from the catalog. The target_format_specification STRING attribute becomes a FK. Format details retrieved via JOIN. | Column target_format_specification_id (BIGINT) in mediaasset.transcode_job',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.transcode_job',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.transcode_job',
    `abr_ladder_configuration` STRING COMMENT 'Configuration specification for ABR ladder generation, defining the set of bitrate/resolution variants to be created for adaptive streaming (e.g., 240p@400kbps, 360p@800kbps, 480p@1.2Mbps, 720p@2.5Mbps, 1080p@5Mbps). Applicable when job_type is abr_ladder_generation. | Column abr_ladder_configuration (STRING) in mediaasset.transcode_job',
    `checksum_algorithm` STRING COMMENT 'Algorithm used to generate the output checksum. | Column checksum_algorithm (STRING) in mediaasset.transcode_job. Valid values are `MD5|SHA-256|SHA-512`',
    `codec_parameters` STRING COMMENT 'Detailed codec encoding parameters including profile, level, GOP structure, B-frames, reference frames, and other encoder-specific settings (e.g., x264 preset=medium, crf=23, profile=high, level=4.1). | Column codec_parameters (STRING) in mediaasset.transcode_job',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated processing cost in US dollars for this transcode job, based on compute time, storage, and resource utilization. Used for chargeback and budget tracking. | Column cost_estimate_usd (DECIMAL(10,2)) in mediaasset.transcode_job',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in mediaasset.transcode_job',
    `error_code` STRING COMMENT 'System error code if the job failed, used for troubleshooting and automated retry logic. | Column error_code (STRING) in mediaasset.transcode_job',
    `error_message` STRING COMMENT 'Human-readable error message describing the failure reason if job_status is failed. | Column error_message (STRING) in mediaasset.transcode_job',
    `job_number` STRING COMMENT 'Human-readable business identifier for the transcode job, used for tracking and reference across systems. | Column job_number (STRING) in mediaasset.transcode_job. Valid values are `^TJ-[0-9]{8}-[A-Z0-9]{6}$`',
    `job_priority` STRING COMMENT 'Processing priority level for the transcode job, determining queue position and resource allocation. Critical jobs are processed immediately, batch jobs during off-peak hours. | Column job_priority (STRING) in mediaasset.transcode_job. Valid values are `critical|high|normal|low|batch`',
    `job_status` STRING COMMENT 'Current lifecycle state of the transcode job. Tracks progression from queue entry through processing to completion or failure. [ENUM-REF-CANDIDATE: queued|processing|completed|failed|retrying|cancelled|paused — 7 candidates stripped; promote to reference product] | Column job_status (STRING) in mediaasset.transcode_job',
    `job_type` STRING COMMENT 'Classification of the transcode operation: standard transcode for routine format conversion, ABR (Adaptive Bitrate) ladder generation for streaming, proxy creation for editing workflows, delivery package preparation for distribution, or format migration for obsolescence-driven conversions. [ENUM-REF-CANDIDATE: standard_transcode|abr_ladder_generation|proxy_creation|delivery_package|format_migration|tape_digitization|analogue_to_digital — 7 candidates stripped; promote to reference product] | Column job_type (STRING) in mediaasset.transcode_job',
    `migration_reason` STRING COMMENT 'Business justification for format migration jobs. Applicable only when job_type is format_migration, tape_digitization, or analogue_to_digital. Captures whether the conversion is driven by format obsolescence (e.g., MPEG-2 to H.265), storage optimization, distribution requirements, or regulatory compliance. [ENUM-REF-CANDIDATE: format_obsolescence|storage_optimization|distribution_requirement|quality_enhancement|compliance_mandate|archive_preservation|not_applicable — 7 candidates stripped; promote to reference product] | Column migration_reason (STRING) in mediaasset.transcode_job',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or contextual information about the transcode job. | Column notes (STRING) in mediaasset.transcode_job',
    `output_checksum` STRING COMMENT 'Cryptographic checksum (MD5, SHA-256, or SHA-512) of the output file for integrity verification and chain-of-custody audit trails. | Column output_checksum (STRING) in mediaasset.transcode_job',
    `output_file_size_gb` DECIMAL(18,2) COMMENT 'Total file size of the transcoded output in gigabytes. Populated upon job completion. | Column output_file_size_gb (DECIMAL(12,3)) in mediaasset.transcode_job',
    `output_storage_uri` STRING COMMENT 'Storage location URI for the transcoded output file(s), including protocol, bucket/path, and filename pattern (e.g., s3://media-archive/transcoded/2024/01/asset_12345_1080p.mp4). | Column output_storage_uri (STRING) in mediaasset.transcode_job',
    `processing_duration_seconds` STRING COMMENT 'Total elapsed time in seconds from processing start to completion, used for performance monitoring and capacity planning. | Column processing_duration_seconds (INT) in mediaasset.transcode_job',
    `processing_end_timestamp` TIMESTAMP COMMENT 'Date and time when the transcoding engine completed or terminated processing of this job. | Column processing_end_timestamp (TIMESTAMP) in mediaasset.transcode_job',
    `processing_start_timestamp` TIMESTAMP COMMENT 'Date and time when the transcoding engine began processing this job. | Column processing_start_timestamp (TIMESTAMP) in mediaasset.transcode_job',
    `quality_validation_result` STRING COMMENT 'Outcome of automated quality validation checks performed on the transcoded output, including video integrity, audio sync, and compliance with target specifications. | Column quality_validation_result (STRING) in mediaasset.transcode_job. Valid values are `passed|failed|warning|not_validated`',
    `quality_validation_score` DECIMAL(18,2) COMMENT 'Numeric quality score (0-100) assigned by automated validation tools, measuring output fidelity against source and target specifications. | Column quality_validation_score (DECIMAL(5,2)) in mediaasset.transcode_job',
    `queue_entry_timestamp` TIMESTAMP COMMENT 'Date and time when the transcode job was submitted to the processing queue. | Column queue_entry_timestamp (TIMESTAMP) in mediaasset.transcode_job',
    `retry_count` STRING COMMENT 'Number of times this job has been automatically retried after failure, used to prevent infinite retry loops. | Column retry_count (INT) in mediaasset.transcode_job',
    `source_asset_version_id` BIGINT COMMENT 'Reference to the specific version of the source asset used for this transcode operation. | Column source_asset_version_id (BIGINT) in mediaasset.transcode_job',
    `source_bitrate_mbps` DECIMAL(18,2) COMMENT 'Average bitrate of the source asset in megabits per second. | Column source_bitrate_mbps (DECIMAL(10,2)) in mediaasset.transcode_job',
    `source_codec` STRING COMMENT 'Video codec of the source asset (e.g., H.264, H.265/HEVC, MPEG-2, ProRes, DNxHD). | Column source_codec (STRING) in mediaasset.transcode_job',
    `source_duration_seconds` STRING COMMENT 'Duration of the source media asset in seconds. | Column source_duration_seconds (INT) in mediaasset.transcode_job',
    `source_file_size_gb` DECIMAL(18,2) COMMENT 'File size of the source asset in gigabytes. | Column source_file_size_gb (DECIMAL(12,3)) in mediaasset.transcode_job',
    `source_format` STRING COMMENT 'Original format specification of the source asset, including container format and codec (e.g., MXF/MPEG-2, MOV/ProRes, MP4/H.264). | Column source_format (STRING) in mediaasset.transcode_job',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in mediaasset.transcode_job',
    `source_resolution` STRING COMMENT 'Video resolution of the source asset in pixels (e.g., 1920x1080, 3840x2160, 1280x720). | Column source_resolution (STRING) in mediaasset.transcode_job',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.transcode_job',
    `transcoding_engine` STRING COMMENT 'Name and version of the transcoding engine or software used to perform the conversion (e.g., FFmpeg 5.1.2, AWS Elemental MediaConvert, Dalet Brio). | Column transcoding_engine (STRING) in mediaasset.transcode_job',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.transcode_job',
    CONSTRAINT pk_transcode_job PRIMARY KEY(`transcode_job_id`)
) COMMENT 'Transactional record of every format conversion operation performed on a media asset — including standard transcodes (ABR ladder generation, proxy creation, delivery package preparation) and format migrations (obsolescence-driven conversions such as MPEG-2 to H.265, tape digitisation, analogue-to-digital). Captures source asset version, target format specification, codec parameters, bitrate ladder configuration, output storage URI, job type (transcode/migration), migration reason (if applicable: format obsolescence/storage optimisation/distribution requirement), job priority, queue entry time, processing start/end timestamps, transcoding engine used, output file size, checksum, quality validation result, and job status (queued/processing/completed/failed/retrying). Single source of truth for all format conversion operations in the MAM. | Unity Catalog table: media_broadcasting_ecm.mediaasset.transcode_job';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` (
    `qc_inspection_id` BIGINT COMMENT 'Unique identifier for the quality control inspection record. Primary key. | Column qc_inspection_id (BIGINT) in mediaasset.qc_inspection',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: QC activities incur labor and tooling costs allocated to quality assurance cost centers. Supports QC budget management, headcount planning, and cost-per-inspection metrics for operational efficiency. | Column cost_center_id (BIGINT) in finance.qc_inspection',
    `format_specification_id` BIGINT COMMENT 'Foreign key linking to mediaasset.format_specification. Business justification: QC inspections validate technical compliance (loudness LUFS, aspect ratio, codec) against format specifications. Broadcasters define acceptance criteria in format specs; QC tools reference these for p | Column format_specification_id (BIGINT) in mediaasset.qc_inspection',
    `asset_version_id` BIGINT COMMENT 'Reference to the specific version of the media asset that underwent this quality control inspection. | Column media_asset_version_id (BIGINT) in mediaasset.qc_inspection',
    `employee_id` BIGINT COMMENT 'Reference to the human operator who performed or supervised the manual or hybrid quality control inspection. Null for fully automated inspections. | Column primary_qc_employee_id (BIGINT) in workforce.qc_inspection',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.qc_inspection',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.qc_inspection',
    `approval_status` STRING COMMENT 'Final approval decision for the media asset version based on QC inspection results. Approved assets are cleared for playout or distribution; rejected assets require remediation. | Column approval_status (STRING) in mediaasset.qc_inspection. Valid values are `approved|rejected|pending_review|conditional_approval`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the asset was approved for playout or distribution following QC inspection. Null if not yet approved. | Column approval_timestamp (TIMESTAMP) in mediaasset.qc_inspection',
    `aspect_ratio_compliance_result` STRING COMMENT 'Result of aspect ratio compliance check. Verifies that video aspect ratio (e.g., 16:9, 4:3, 21:9) matches expected format and Active Format Description (AFD) metadata is correct. | Column aspect_ratio_compliance_result (STRING) in mediaasset.qc_inspection. Valid values are `pass|fail|not_tested`',
    `audio_codec_compliance_result` STRING COMMENT 'Result of audio codec format compliance check. Verifies that audio encoding conforms to expected codec standard (e.g., AAC, Dolby Digital, Dolby Atmos, MPEG-1 Layer II). | Column audio_codec_compliance_result (STRING) in mediaasset.qc_inspection. Valid values are `pass|fail|not_tested`',
    `audio_sync_offset_ms` STRING COMMENT 'Measured audio-to-video synchronization offset in milliseconds. Positive values indicate audio leads video; negative values indicate audio lags video. Null if sync check not performed. | Column audio_sync_offset_ms (INT) in mediaasset.qc_inspection',
    `audio_sync_result` STRING COMMENT 'Result of audio-to-video synchronization check. Detects lip-sync errors or audio drift. | Column audio_sync_result (STRING) in mediaasset.qc_inspection. Valid values are `pass|fail|not_tested`',
    `black_frame_count` STRING COMMENT 'Total number of black frames detected in the media asset. Zero if none detected. | Column black_frame_count (INT) in mediaasset.qc_inspection',
    `black_frame_detected` BOOLEAN COMMENT 'Indicates whether unintended black frames (video signal dropout or encoding error) were detected during inspection. | Column black_frame_detected (BOOLEAN) in mediaasset.qc_inspection',
    `caption_validation_result` STRING COMMENT 'Result of closed caption (CEA-608, CEA-708) or subtitle validation check. Verifies presence, format compliance, and synchronization of captions. | Column caption_validation_result (STRING) in mediaasset.qc_inspection. Valid values are `pass|fail|not_tested`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in mediaasset.qc_inspection',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this QC inspection record was first created in the system. Audit trail field. | Column created_timestamp (TIMESTAMP) in mediaasset.qc_inspection',
    `critical_defect_count` STRING COMMENT 'Number of critical-severity defects that block asset approval for playout or distribution. Critical defects require remediation. | Column critical_defect_count (INT) in mediaasset.qc_inspection',
    `defect_count` STRING COMMENT 'Total number of quality defects detected during inspection. Zero indicates no defects found. | Column defect_count (INT) in mediaasset.qc_inspection',
    `defect_summary` STRING COMMENT 'Structured JSON or delimited text summary of all detected defects with timecode references, severity levels, and defect type codes. Detailed defect records may be stored in a separate qc_defect child table. | Column defect_summary (STRING) in mediaasset.qc_inspection',
    `detected_aspect_ratio` STRING COMMENT 'Actual aspect ratio detected in the video stream (e.g., 16:9, 4:3, 1.85:1, 2.39:1). Null if aspect ratio check not performed. | Column detected_aspect_ratio (NUMERIC) in mediaasset.qc_inspection',
    `freeze_frame_count` STRING COMMENT 'Total number of freeze frame incidents detected in the media asset. Zero if none detected. | Column freeze_frame_count (INT) in mediaasset.qc_inspection',
    `freeze_frame_detected` BOOLEAN COMMENT 'Indicates whether freeze frames (static video for extended duration) were detected during inspection. | Column freeze_frame_detected (BOOLEAN) in mediaasset.qc_inspection',
    `hdr_format` STRING COMMENT 'Detected High Dynamic Range format or Standard Dynamic Range designation. HLG = Hybrid Log-Gamma, SDR = Standard Dynamic Range. | Column hdr_format (STRING) in mediaasset.qc_inspection. Valid values are `HDR10|HDR10+|Dolby Vision|HLG|SDR|unknown`',
    `hdr_metadata_validation_result` STRING COMMENT 'Result of High Dynamic Range (HDR) metadata validation check. Verifies presence and correctness of HDR10, HDR10+, Dolby Vision, or HLG metadata. Not applicable for Standard Dynamic Range (SDR) content. | Column hdr_metadata_validation_result (STRING) in mediaasset.qc_inspection. Valid values are `pass|fail|not_applicable|not_tested`',
    `inspection_duration_seconds` STRING COMMENT 'Total elapsed time in seconds required to complete the quality control inspection process. | Column inspection_duration_seconds (INT) in mediaasset.qc_inspection',
    `inspection_number` STRING COMMENT 'Human-readable business identifier for the inspection record, formatted as QC-YYYYMMDD-NNNNNN. | Column inspection_number (STRING) in mediaasset.qc_inspection. Valid values are `^QC-[0-9]{8}-[0-9]{6}$`',
    `inspection_status` STRING COMMENT 'Current lifecycle state of the quality control inspection process. | Column inspection_status (STRING) in mediaasset.qc_inspection. Valid values are `pending|in_progress|completed|failed|cancelled`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date and time when the quality control inspection was performed or completed. Primary business event timestamp. | Column inspection_timestamp (TIMESTAMP) in mediaasset.qc_inspection',
    `loudness_compliance_result` STRING COMMENT 'Result of audio loudness compliance check against regulatory standards (EBU R128 for Europe, ATSC A/85 for North America, ITU-R BS.1770 globally). | Column loudness_compliance_result (STRING) in mediaasset.qc_inspection. Valid values are `pass|fail|not_tested`',
    `loudness_lufs` DECIMAL(18,2) COMMENT 'Measured integrated loudness level in LUFS (Loudness Units relative to Full Scale) or LKFS. Typical broadcast target is -23 LUFS (EBU R128) or -24 LKFS (ATSC A/85). | Column loudness_lufs (DECIMAL(5,2)) in mediaasset.qc_inspection',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this QC inspection record was last updated. Audit trail field. | Column modified_timestamp (TIMESTAMP) in mediaasset.qc_inspection',
    `notes` STRING COMMENT 'Free-text notes or comments from the QC operator or automated tool regarding the inspection, including observations, context, or recommendations. | Column notes (STRING) in mediaasset.qc_inspection',
    `overall_result` STRING COMMENT 'Final pass/fail determination for the quality control inspection. Conditional pass indicates minor issues that do not block playout. Review required indicates human escalation needed. | Column overall_result (STRING) in mediaasset.qc_inspection. Valid values are `pass|fail|conditional_pass|review_required`',
    `qc_tool_name` STRING COMMENT 'Name and version of the automated quality control software or tool used for inspection (e.g., Baton, Interra, Venera, Dalet QC Module). | Column qc_tool_name (STRING) in mediaasset.qc_inspection',
    `qc_type` STRING COMMENT 'Classification of the quality control inspection method: automated (software-based), manual (human operator), or hybrid (combination of both). | Column qc_type (STRING) in mediaasset.qc_inspection. Valid values are `automated|manual|hybrid`',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the asset was rejected, including references to specific defects or compliance failures. Null if asset was approved. | Column rejection_reason (STRING) in mediaasset.qc_inspection',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in mediaasset.qc_inspection',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.qc_inspection',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.qc_inspection',
    `video_codec_compliance_result` STRING COMMENT 'Result of video codec format compliance check. Verifies that video encoding conforms to expected codec standard (e.g., H.264/AVC, H.265/HEVC, MPEG-2, AV1). | Column video_codec_compliance_result (STRING) in mediaasset.qc_inspection. Valid values are `pass|fail|not_tested`',
    CONSTRAINT pk_qc_inspection PRIMARY KEY(`qc_inspection_id`)
) COMMENT 'Records the quality control inspection result for each media asset version — capturing QC type (automated/manual/hybrid), inspection timestamp, operator or automated QC tool identity, pass/fail status, loudness compliance result (EBU R128 / ATSC A/85), black frame detection, freeze frame detection, audio sync check, caption/subtitle validation, aspect ratio compliance, HDR metadata validation, and a structured list of detected defects with timecode references. Mandatory gate before asset is approved for playout or distribution. | Unity Catalog table: media_broadcasting_ecm.mediaasset.qc_inspection';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` (
    `storage_location_id` BIGINT COMMENT 'Unique identifier for the storage location within the Media Asset Management (MAM) infrastructure. Primary key. | Column storage_location_id (BIGINT) in mediaasset.storage_location',
    `broadcast_facility_id` BIGINT COMMENT 'FK added per VREQ',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.storage_location',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.storage_location',
    `access_protocol` STRING COMMENT 'Network protocol or interface used to access the storage location (NFS = Network File System, SMB = Server Message Block, S3 = Amazon S3 API, SFTP = Secure File Transfer Protocol, iSCSI = Internet Small Computer Systems Interface, Fibre_Channel = FC SAN protocol). [ENUM-REF-CANDIDATE: NFS|SMB|S3|SFTP|iSCSI|Fibre_Channel|HTTP|HTTPS — 8 candidates stripped; promote to reference product] | Column access_protocol (STRING) in mediaasset.storage_location',
    `available_capacity_tb` DECIMAL(18,2) COMMENT 'Remaining available storage capacity (total minus used), measured in terabytes (TB). Drives automated alerts and provisioning workflows. | Column available_capacity_tb (DECIMAL(18,3)) in mediaasset.storage_location',
    `checksum_algorithm` STRING COMMENT 'Hashing algorithm used for checksum validation (MD5 = Message Digest 5, SHA = Secure Hash Algorithm, CRC32 = Cyclic Redundancy Check). Null if checksum validation is not enabled. | Column checksum_algorithm (STRING) in mediaasset.storage_location. Valid values are `MD5|SHA-1|SHA-256|SHA-512|CRC32`',
    `checksum_validation_enabled` BOOLEAN COMMENT 'Indicates whether automated checksum integrity validation is performed on assets stored at this location (True = enabled, False = disabled). Critical for ensuring asset integrity and detecting corruption. | Column checksum_validation_enabled (BOOLEAN) in mediaasset.storage_location',
    `contact_email` STRING COMMENT 'Primary email address for the technical or operational contact responsible for this storage location. Used for alerts, maintenance coordination, and incident response. | Column contact_email (STRING) in mediaasset.storage_location. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `cost_per_tb_per_month` DECIMAL(18,2) COMMENT 'Monthly cost per terabyte of storage at this location, used for cost allocation and financial reporting. Includes infrastructure, licensing, and operational costs. | Column cost_per_tb_per_month (DECIMAL(12,2)) in mediaasset.storage_location',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in mediaasset.storage_location',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location record was first created in the MAM system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. | Column created_timestamp (TIMESTAMP) in mediaasset.storage_location',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost and financial reporting (e.g., USD = US Dollar, EUR = Euro, GBP = British Pound). | Column currency_code (STRING) in mediaasset.storage_location. Valid values are `USD|EUR|GBP|JPY|AUD|CAD`',
    `data_center_name` STRING COMMENT 'Name or identifier of the physical data center or facility housing the storage infrastructure (e.g., NYC-DC1, AWS-US-East-1, Azure-WestEurope). | Column data_center_name (STRING) in mediaasset.storage_location',
    `decommission_date` DATE COMMENT 'Date when the storage location was or is planned to be decommissioned and removed from service. Null if still active. Format: yyyy-MM-dd. | Column decommission_date (DATE) in mediaasset.storage_location',
    `encryption_enabled` BOOLEAN COMMENT 'Indicates whether data-at-rest encryption is enabled for this storage location (True = encrypted, False = not encrypted). Critical for compliance with data protection regulations. | Column encryption_enabled (BOOLEAN) in mediaasset.storage_location',
    `encryption_method` STRING COMMENT 'Encryption algorithm or method applied to data at rest (e.g., AES-256, AES-128, RSA-2048). Null if encryption is not enabled. | Column encryption_method (STRING) in mediaasset.storage_location',
    `geographic_region` STRING COMMENT 'Geographic region or data center location where the storage is physically or logically hosted (e.g., US-East, EU-West, APAC-Singapore, On-Premise-NYC). | Column geographic_region (STRING) in mediaasset.storage_location',
    `last_capacity_check_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent capacity measurement or audit for this storage location. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. | Column last_capacity_check_timestamp (TIMESTAMP) in mediaasset.storage_location',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. | Column last_modified_timestamp (TIMESTAMP) in mediaasset.storage_location',
    `legal_hold_capable` BOOLEAN COMMENT 'Indicates whether this storage location supports legal hold functionality to prevent deletion or modification of assets under litigation or regulatory investigation (True = capable, False = not capable). | Column legal_hold_capable (BOOLEAN) in mediaasset.storage_location',
    `location_code` STRING COMMENT 'Short alphanumeric code or identifier used for operational reference and system integration (e.g., SAN-PROD-01, LTO-ARCH-02, S3-USEAST). | Column location_code (STRING) in mediaasset.storage_location',
    `location_name` STRING COMMENT 'Human-readable name or label for the storage location (e.g., Production SAN Array 01, Archive LTO Tape Library, AWS S3 US-East Bucket). | Column location_name (STRING) in mediaasset.storage_location',
    `mount_point` STRING COMMENT 'File system mount point, UNC path, or object storage URI used by MAM systems to access the location (e.g., /mnt/production_san, nas01media, s3://bucket-name/prefix). | Column mount_point (STRING) in mediaasset.storage_location',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, configuration details, or special instructions related to this storage location. | Column notes (STRING) in mediaasset.storage_location',
    `operational_status` STRING COMMENT 'Current operational state of the storage location (Active = in production use, Inactive = temporarily offline, Maintenance = undergoing service, Decommissioned = retired, Provisioning = being set up). | Column operational_status (STRING) in mediaasset.storage_location. Valid values are `Active|Inactive|Maintenance|Decommissioned|Provisioning`',
    `provisioned_date` DATE COMMENT 'Date when the storage location was initially provisioned and made available for use. Format: yyyy-MM-dd. | Column provisioned_date (DATE) in mediaasset.storage_location',
    `replication_enabled` BOOLEAN COMMENT 'Indicates whether this storage location is replicated to another location for redundancy and disaster recovery (True = replicated, False = not replicated). | Column replication_enabled (BOOLEAN) in mediaasset.storage_location',
    `restore_time_objective_hours` DECIMAL(18,2) COMMENT 'Maximum acceptable time to restore or retrieve assets from this storage location, measured in hours. Critical for disaster recovery and operational planning. | Column restore_time_objective_hours (DECIMAL(10,2)) in mediaasset.storage_location',
    `retention_policy_days` STRING COMMENT 'Default retention period in days for assets stored at this location, after which assets may be migrated or purged per policy. Null if no default retention applies. | Column retention_policy_days (INT) in mediaasset.storage_location',
    `sla_tier` STRING COMMENT 'Service level tier defining performance, availability, and support commitments (Platinum = highest availability and fastest restore, Bronze = basic service with extended restore times). | Column sla_tier (STRING) in mediaasset.storage_location. Valid values are `Platinum|Gold|Silver|Bronze`',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in mediaasset.storage_location',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.storage_location',
    `storage_tier` STRING COMMENT 'Tiering classification based on access frequency and retrieval speed requirements (Hot = immediate access for active production, Warm = nearline for recent content, Cold = infrequent access for older assets, Deep_Archive = long-term archival with extended retrieval time). | Column storage_tier (STRING) in mediaasset.storage_location. Valid values are `Hot|Warm|Cold|Deep_Archive`',
    `storage_type` STRING COMMENT 'Classification of the physical or logical storage technology (SAN = Storage Area Network, NAS = Network Attached Storage, LTO_Tape = Linear Tape-Open, Cloud_Object_Storage = S3/Azure Blob/GCS, CDN_Origin = Content Delivery Network origin store, Deep_Archive = long-term cold storage vault). | Column storage_type (STRING) in mediaasset.storage_location. Valid values are `SAN|NAS|LTO_Tape|Cloud_Object_Storage|CDN_Origin|Deep_Archive`',
    `storage_vendor` STRING COMMENT 'Name of the storage hardware or cloud service provider (e.g., Dell EMC, NetApp, AWS, Azure, Google Cloud, IBM Spectrum Archive). | Column storage_vendor (STRING) in mediaasset.storage_location',
    `total_capacity_tb` DECIMAL(18,2) COMMENT 'Total storage capacity of the location measured in terabytes (TB). Used for capacity planning and allocation reporting. | Column total_capacity_tb (DECIMAL(18,3)) in mediaasset.storage_location',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.storage_location',
    `used_capacity_tb` DECIMAL(18,2) COMMENT 'Current amount of storage capacity consumed or allocated, measured in terabytes (TB). Updated periodically to reflect actual usage. | Column used_capacity_tb (DECIMAL(18,3)) in mediaasset.storage_location',
    CONSTRAINT pk_storage_location PRIMARY KEY(`storage_location_id`)
) COMMENT 'Master reference for all physical and logical storage locations in the MAM infrastructure — on-premise SAN/NAS arrays, nearline LTO tape libraries, cloud object storage (S3, Azure Blob, GCS), CDN origin stores, and deep-archive vaults. Captures location name, storage type, tier classification (hot/warm/cold/deep-archive), geographic region/data centre, total capacity, used capacity, storage vendor, access protocol (NFS/SMB/S3/SFTP), SLA tier (restore time objective), and operational status. Drives automated storage tiering policy enforcement, capacity planning, and cost allocation reporting. | Unity Catalog table: media_broadcasting_ecm.mediaasset.storage_location';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` (
    `asset_storage_assignment_id` BIGINT COMMENT 'Unique identifier for the asset storage assignment record. Primary key for tracking storage placement history. | Column asset_storage_assignment_id (BIGINT) in mediaasset.asset_storage_assignment',
    `asset_version_id` BIGINT COMMENT 'Reference to the specific version of the media asset being stored. Tracks mezzanine, proxy, master, or archived versions. | Column asset_version_id (BIGINT) in mediaasset.asset_storage_assignment',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that initiated this storage assignment. Used for accountability and audit trails. | Column employee_id (BIGINT) in workforce.asset_storage_assignment',
    `legal_hold_id` BIGINT COMMENT 'Identifier of the legal case or matter requiring this file to be preserved. Used for legal discovery and compliance tracking. | Column legal_hold_id (BIGINT) in mediaasset.asset_storage_assignment',
    `media_asset_id` BIGINT COMMENT 'Reference to the media asset that is being stored. Links to the master media asset record in the MAM (Media Asset Management) system. | Column media_asset_id (BIGINT) in mediaasset.asset_storage_assignment',
    `retention_policy_id` BIGINT COMMENT 'Reference to the retention policy governing this storage assignment. Determines how long the file must be retained and when it can be purged. | Column retention_policy_id (BIGINT) in mediaasset.asset_storage_assignment',
    `storage_location_id` BIGINT COMMENT 'Reference to the physical or logical storage location where the asset file resides. Links to storage infrastructure registry. | Column storage_location_id (BIGINT) in mediaasset.asset_storage_assignment',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.asset_storage_assignment',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.asset_storage_assignment',
    `access_frequency` STRING COMMENT 'Number of times this file has been accessed since assignment to this storage location. Used to inform tiering and migration decisions. | Column access_frequency (INT) in mediaasset.asset_storage_assignment',
    `assignment_end_date` DATE COMMENT 'Date when the asset file was migrated, purged, or removed from this storage location. Null if still active at this location. | Column assignment_end_date (DATE) in mediaasset.asset_storage_assignment',
    `assignment_end_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the asset file was migrated, purged, or removed from this storage location. Null if still active. | Column assignment_end_timestamp (TIMESTAMP) in mediaasset.asset_storage_assignment',
    `assignment_start_date` DATE COMMENT 'Date when the asset file was placed at this storage location. Marks the beginning of the storage assignment period. | Column assignment_start_date (DATE) in mediaasset.asset_storage_assignment',
    `assignment_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the asset file was placed at this storage location. Provides exact time for chain-of-custody audit trails. | Column assignment_start_timestamp (TIMESTAMP) in mediaasset.asset_storage_assignment',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this storage assignment. Indicates whether the file is actively stored, has been moved, or has been deleted. | Column assignment_status (STRING) in mediaasset.asset_storage_assignment. Valid values are `active|migrated|purged|archived|failed|pending`',
    `checksum_algorithm` STRING COMMENT 'Algorithm used to generate the checksum value. Common algorithms include MD5, SHA-1, SHA-256, SHA-512, and CRC32. | Column checksum_algorithm (STRING) in mediaasset.asset_storage_assignment. Valid values are `MD5|SHA-1|SHA-256|SHA-512|CRC32`',
    `checksum_value` DECIMAL(18,2) COMMENT 'Cryptographic hash or checksum of the file at placement time. Ensures file integrity verification and detects corruption or tampering. | Column checksum_value (DECIMAL(18,2)) in mediaasset.asset_storage_assignment',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in mediaasset.asset_storage_assignment',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage assignment record was first created in the system. Used for audit trails and data lineage. | Column created_timestamp (TIMESTAMP) in mediaasset.asset_storage_assignment',
    `file_path` STRING COMMENT 'Complete file system path or URI where the asset file is physically stored. Enables restore path resolution and file retrieval. | Column file_path (STRING) in mediaasset.asset_storage_assignment',
    `file_size_bytes` BIGINT COMMENT 'Size of the asset file in bytes at the time of storage assignment. Used for capacity planning and storage cost allocation. | Column file_size_bytes (BIGINT) in mediaasset.asset_storage_assignment',
    `geographic_region` STRING COMMENT 'Geographic region or data center location where the storage resides. Used for data sovereignty compliance and disaster recovery planning. | Column geographic_region (STRING) in mediaasset.asset_storage_assignment',
    `last_access_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent access to this file at this storage location. Used for tiering policy enforcement and usage analytics. | Column last_access_timestamp (TIMESTAMP) in mediaasset.asset_storage_assignment',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether this storage assignment is subject to a legal hold. When true, the file cannot be deleted or modified regardless of retention policy. | Column legal_hold_flag (BOOLEAN) in mediaasset.asset_storage_assignment',
    `migration_trigger` STRING COMMENT 'Reason why the asset was moved to or from this storage location. Captures business or technical driver for storage placement decisions. | Column migration_trigger (STRING) in mediaasset.asset_storage_assignment. Valid values are `tiering_policy|legal_hold|cost_optimization|format_migration|capacity_rebalance|manual_request`',
    `notes` STRING COMMENT 'Free-text notes or comments about this storage assignment. Captures context, special handling instructions, or migration rationale. | Column notes (STRING) in mediaasset.asset_storage_assignment',
    `replication_count` STRING COMMENT 'Number of redundant copies of this file maintained at this storage location. Used for disaster recovery and high availability planning. | Column replication_count (INT) in mediaasset.asset_storage_assignment',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in mediaasset.asset_storage_assignment',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.asset_storage_assignment',
    `storage_cost_per_gb` DECIMAL(18,2) COMMENT 'Cost per gigabyte for this storage tier at the time of assignment. Used for storage cost allocation and financial reporting. | Column storage_cost_per_gb (DECIMAL(10,4)) in mediaasset.asset_storage_assignment',
    `storage_tier` STRING COMMENT 'Storage tier classification at the time of assignment. Indicates performance and cost characteristics: hot (high-performance online), warm (standard online), cold (infrequent access), archive (long-term preservation), nearline (tape/optical near-online), offline (physical media vault). | Column storage_tier (STRING) in mediaasset.asset_storage_assignment. Valid values are `hot|warm|cold|archive|nearline|offline`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.asset_storage_assignment',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage assignment record was last modified. Used for change tracking and audit trails. | Column updated_timestamp (TIMESTAMP) in mediaasset.asset_storage_assignment',
    `verification_status` STRING COMMENT 'Status of file integrity verification at this storage location. Indicates whether checksum validation has been performed and passed. | Column verification_status (STRING) in mediaasset.asset_storage_assignment. Valid values are `pending|verified|failed|not_verified`',
    `verification_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent integrity verification check. Used to track compliance with periodic verification policies. | Column verification_timestamp (TIMESTAMP) in mediaasset.asset_storage_assignment',
    CONSTRAINT pk_asset_storage_assignment PRIMARY KEY(`asset_storage_assignment_id`)
) COMMENT 'Tracks the complete storage placement history for every media asset version — recording which file resides at which storage location, when it was placed there, and why it moved. Captures storage location reference, file path/URI, storage tier at time of assignment, assignment start date, end date (if migrated or purged), file size, checksum at placement, migration trigger (tiering policy/legal hold/cost optimisation/format migration/capacity rebalance), and verification status. Provides the authoritative chain-of-custody for physical file placement, drives storage capacity reporting, enables restore path resolution, and supports legal discovery by proving where a file was at any point in time. | Unity Catalog table: media_broadcasting_ecm.mediaasset.asset_storage_assignment';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` (
    `retention_policy_id` BIGINT COMMENT 'Unique identifier for the retention policy record. Primary key. | Column retention_policy_id (BIGINT) in mediaasset.retention_policy',
    `supersedes_policy_retention_policy_id` BIGINT COMMENT 'Reference to the previous retention policy that this policy replaces. Null if this is the first version. Supports policy lineage and historical analysis. | Column supersedes_policy_retention_policy_id (BIGINT) in mediaasset.retention_policy',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.retention_policy',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.retention_policy',
    `applies_to_legal_hold` BOOLEAN COMMENT 'Indicates whether this retention policy applies to assets under legal hold. If false, legal hold assets are exempt from automated lifecycle actions governed by this policy. | Column applies_to_legal_hold (BOOLEAN) in mediaasset.retention_policy',
    `applies_to_syndication_content` BOOLEAN COMMENT 'Indicates whether this retention policy applies to syndicated content (content resold to multiple outlets). Syndication agreements may impose distinct retention obligations. | Column applies_to_syndication_content (BOOLEAN) in mediaasset.retention_policy',
    `asset_class_scope` STRING COMMENT 'The category of media assets to which this retention policy applies. Aligns with MAM (Media Asset Management) asset classification in Dalet Galaxy. [ENUM-REF-CANDIDATE: raw|mezzanine|proxy|archive|master|graphics|audio|metadata — 8 candidates stripped; promote to reference product] | Column asset_class_scope (STRING) in mediaasset.retention_policy',
    `audit_trail_required` BOOLEAN COMMENT 'Indicates whether a full chain-of-custody audit trail must be maintained for assets governed by this policy. Critical for regulatory compliance and legal hold scenarios. | Column audit_trail_required (BOOLEAN) in mediaasset.retention_policy',
    `checksum_verification_required` BOOLEAN COMMENT 'Indicates whether checksum integrity verification is mandatory before executing post-retention actions. Ensures asset integrity throughout the retention lifecycle. | Column checksum_verification_required (BOOLEAN) in mediaasset.retention_policy',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in mediaasset.retention_policy',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this retention policy record was first created in the system. | Column created_timestamp (TIMESTAMP) in mediaasset.retention_policy',
    `effective_date` DATE COMMENT 'The date on which this retention policy becomes enforceable. Assets ingested or classified on or after this date are subject to the policy. | Column effective_date (DATE) in mediaasset.retention_policy',
    `expiry_date` DATE COMMENT 'The date on which this retention policy ceases to be enforceable. Null indicates the policy remains in effect indefinitely until explicitly retired. | Column expiry_date (DATE) in mediaasset.retention_policy',
    `format_migration_allowed` BOOLEAN COMMENT 'Indicates whether format migration (transcoding to newer codecs or containers) is permitted during the retention period. Supports long-term preservation and format obsolescence mitigation. | Column format_migration_allowed (BOOLEAN) in mediaasset.retention_policy',
    `geographic_scope` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes indicating the geographic jurisdictions to which this policy applies (e.g., USA,GBR,CAN). Supports multi-jurisdictional compliance. | Column geographic_scope (STRING) in mediaasset.retention_policy',
    `last_modified_by` STRING COMMENT 'The user ID or system identifier that last modified this retention policy record. | Column last_modified_by (STRING) in mediaasset.retention_policy',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this retention policy record was last updated. | Column last_modified_timestamp (TIMESTAMP) in mediaasset.retention_policy',
    `maximum_retention_period_days` STRING COMMENT 'The maximum number of days an asset may be retained before mandatory action (purge or archive migration). Null indicates indefinite retention. | Column maximum_retention_period_days (INT) in mediaasset.retention_policy',
    `minimum_retention_period_days` STRING COMMENT 'The minimum number of days an asset must be retained before any deletion or migration action can occur. Enforces regulatory and contractual obligations. | Column minimum_retention_period_days (INT) in mediaasset.retention_policy',
    `notification_recipients` STRING COMMENT 'Comma-separated list of email addresses or role identifiers to be notified when retention actions are triggered (e.g., legal@mediabroadcasting.com, content-ops-team). | Column notification_recipients (STRING) in mediaasset.retention_policy',
    `policy_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the policy for system integration and reporting (e.g., RET-MAST-7Y, RET-RAW-90D). | Column policy_code (STRING) in mediaasset.retention_policy. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `policy_description` STRING COMMENT 'Detailed business description of the retention policy, including rationale, scope, and any special handling instructions. | Column policy_description (STRING) in mediaasset.retention_policy',
    `policy_name` STRING COMMENT 'Business-friendly name of the retention policy (e.g., Broadcast Master Archive Policy, Raw Footage 90-Day Purge). | Column policy_name (STRING) in mediaasset.retention_policy',
    `policy_owner` STRING COMMENT 'The business role, department, or individual responsible for defining and maintaining this retention policy (e.g., Legal & Compliance, Media Operations Director, Chief Content Officer). | Column policy_owner (STRING) in mediaasset.retention_policy',
    `policy_status` STRING COMMENT 'Current lifecycle state of the retention policy. Only active policies are enforced by automated lifecycle management workflows. | Column policy_status (STRING) in mediaasset.retention_policy. Valid values are `draft|active|suspended|retired|under_review`',
    `post_retention_action` STRING COMMENT 'The action to be taken when the retention period expires. Drives automated lifecycle workflows in MAM (Media Asset Management) systems. | Column post_retention_action (STRING) in mediaasset.retention_policy. Valid values are `purge|migrate_to_deep_archive|notify_rights_owner|manual_review|transfer_to_external_archive`',
    `priority_level` STRING COMMENT 'The business priority of this retention policy. Critical policies (e.g., legal hold, regulatory mandate) take precedence over lower-priority policies when conflicts arise. | Column priority_level (STRING) in mediaasset.retention_policy. Valid values are `critical|high|medium|low`',
    `regulatory_basis` STRING COMMENT 'The regulatory framework, statute, or compliance requirement that mandates or informs this retention policy (e.g., FCC 47 CFR 73.1840, Ofcom Section 11, GDPR Article 5, SOX Section 802, Legal Hold Case #12345). | Column regulatory_basis (STRING) in mediaasset.retention_policy',
    `retention_trigger` STRING COMMENT 'The business event that starts the retention clock for this policy (e.g., when the asset was ingested, when it was first broadcast, when the licensing contract expires, or when a legal hold is placed). | Column retention_trigger (STRING) in mediaasset.retention_policy. Valid values are `ingest_date|broadcast_date|contract_expiry|legal_hold|last_access_date|rights_expiry`',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in mediaasset.retention_policy',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.retention_policy',
    `storage_tier_target` STRING COMMENT 'The target storage tier for assets governed by this policy after the retention period. Aligns with tiered storage strategies in MAM (Media Asset Management) and CDN (Content Delivery Network) architectures. | Column storage_tier_target (STRING) in mediaasset.retention_policy. Valid values are `hot|warm|cold|deep_archive|glacier`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.retention_policy',
    `version_number` STRING COMMENT 'Sequential version number of this retention policy. Incremented each time the policy is revised. Supports policy change tracking and audit compliance. | Column version_number (INT) in mediaasset.retention_policy',
    `created_by` STRING COMMENT 'The user ID or system identifier that created this retention policy record. | Column created_by (STRING) in mediaasset.retention_policy',
    CONSTRAINT pk_retention_policy PRIMARY KEY(`retention_policy_id`)
) COMMENT 'Defines the business retention rules applied to media assets — capturing policy name, asset class scope (raw/mezzanine/proxy/archive), minimum retention period, maximum retention period, retention trigger (ingest date / broadcast date / contract expiry / legal hold), post-retention action (purge/migrate-to-deep-archive/notify-rights-owner), regulatory basis (FCC, Ofcom, GDPR, SOX, legal hold), policy owner, effective date, and expiry date. Drives automated lifecycle management and ensures regulatory compliance for asset archival and deletion. | Unity Catalog table: media_broadcasting_ecm.mediaasset.retention_policy';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` (
    `asset_lifecycle_event_id` BIGINT COMMENT 'Unique identifier for the asset lifecycle event record. Primary key. Inferred role: EVENT_LOG. This entity represents an immutable audit log of state transitions for media assets, capturing the complete chain-of-custody trail required for regulatory, legal, and rights compliance in media asset management systems. | Column asset_lifecycle_event_id (BIGINT) in mediaasset.asset_lifecycle_event',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Lifecycle events (QC passed, transcoded, archived, migrated) apply to specific versions, not just the asset concept. This FK allows tracking version-specific state transitions. Nullable for asset-leve | Column asset_version_id (BIGINT) in mediaasset.asset_lifecycle_event',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Lifecycle events (migration, restoration, format conversion) trigger cost-bearing activities allocated to technical operations cost centers. Enables event-based cost tracking and lifecycle cost analys | Column cost_center_id (BIGINT) in finance.asset_lifecycle_event',
    `legal_hold_id` BIGINT COMMENT 'Reference identifier for the legal case or matter that triggered a legal hold event. Applicable for legal_hold_applied and legal_hold_released events. Used to track preservation obligations for litigation, regulatory investigation, or compliance requirements. | Column legal_hold_id (BIGINT) in mediaasset.asset_lifecycle_event',
    `media_asset_id` BIGINT COMMENT 'Reference to the media asset that experienced this lifecycle event. Links to the master media asset record in the MAM (Media Asset Management) system. This is the EVENT_SOURCE_REFERENCE required for EVENT_LOG role. | Column media_asset_id (BIGINT) in mediaasset.asset_lifecycle_event',
    `retention_policy_id` BIGINT COMMENT 'Reference to the data retention policy that governs this assets lifecycle. Links to the retention policy master table that defines minimum and maximum retention periods, purge rules, and regulatory compliance requirements. | Column retention_policy_id (BIGINT) in mediaasset.asset_lifecycle_event',
    `tech_change_request_id` BIGINT COMMENT 'Identifier for the Dalet Galaxy workflow instance that triggered or processed this lifecycle event. Used to trace events back to specific automated workflow executions for troubleshooting and audit purposes. | Column tech_change_request_id (BIGINT) in technology.asset_lifecycle_event',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.asset_lifecycle_event',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.asset_lifecycle_event',
    `approval_authority` STRING COMMENT 'The name or identifier of the person or role that provided approval for this lifecycle event, applicable for approval, publish, and legal_hold_released events. Used for accountability and compliance documentation. | Column approval_authority (STRING) in mediaasset.asset_lifecycle_event',
    `audit_trail_reference` STRING COMMENT 'External reference identifier linking this lifecycle event to broader audit trail systems, compliance documentation, or regulatory filing records. Used to connect MAM (Media Asset Management) events to enterprise audit and compliance frameworks. | Column audit_trail_reference (STRING) in mediaasset.asset_lifecycle_event',
    `checksum_after` STRING COMMENT 'The cryptographic checksum (MD5, SHA-256, or other hash) of the media file after this event. Used to verify file integrity and detect unauthorized modifications. Critical for chain-of-custody audit trail. | Column checksum_after (STRING) in mediaasset.asset_lifecycle_event',
    `checksum_before` STRING COMMENT 'The cryptographic checksum (MD5, SHA-256, or other hash) of the media file before this event. Used to verify file integrity and detect unauthorized modifications. Critical for chain-of-custody audit trail. | Column checksum_before (STRING) in mediaasset.asset_lifecycle_event',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether this lifecycle event was executed in compliance with applicable regulatory, legal, and internal policy requirements. True indicates compliant execution; False indicates a compliance violation or exception that requires review. | Column compliance_flag (BOOLEAN) in mediaasset.asset_lifecycle_event',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in mediaasset.asset_lifecycle_event',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this lifecycle event record was created in the data warehouse. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Distinct from event_timestamp which captures the business event time. Used for data lineage and ETL (Extract Transform Load) audit purposes. | Column created_timestamp (TIMESTAMP) in mediaasset.asset_lifecycle_event',
    `duration_seconds` DECIMAL(18,2) COMMENT 'The playback duration of the media asset in seconds at the time of this lifecycle event. Used to verify content integrity after format migrations and to track asset characteristics over time. | Column duration_seconds (DECIMAL(10,3)) in mediaasset.asset_lifecycle_event',
    `error_code` STRING COMMENT 'System error code or exception identifier if this lifecycle event encountered an error or failure. Used for troubleshooting, root cause analysis, and system reliability monitoring. Typically populated for qc_fail, transcode failure, or migration failure events. | Column error_code (STRING) in mediaasset.asset_lifecycle_event',
    `error_message` STRING COMMENT 'Human-readable error message or exception description if this lifecycle event encountered an error or failure. Provides detailed context for troubleshooting and incident resolution. | Column error_message (STRING) in mediaasset.asset_lifecycle_event',
    `event_duration_milliseconds` BIGINT COMMENT 'The elapsed time in milliseconds that this lifecycle event took to complete. Used for performance monitoring, SLA (Service Level Agreement) tracking, and workflow optimization. Applicable for transcode, migration, and ingest events. | Column event_duration_milliseconds (BIGINT) in mediaasset.asset_lifecycle_event',
    `event_reason` STRING COMMENT 'Free-text explanation or justification for why this lifecycle event occurred. May include business context, regulatory requirement, editorial decision rationale, or technical reason. Critical for audit trail and compliance documentation. | Column event_reason (STRING) in mediaasset.asset_lifecycle_event',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the lifecycle event occurred in the media asset management workflow. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. This is the EVENT_TIMESTAMP required for EVENT_LOG role. | Column event_timestamp (TIMESTAMP) in mediaasset.asset_lifecycle_event',
    `event_type` STRING COMMENT 'The type of lifecycle state transition or significant event that occurred. Represents the EVENT_TYPE_OR_CHANNEL required for EVENT_LOG role. Values include: ingest (asset ingested into MAM), qc_pass (quality control passed), qc_fail (quality control failed), approval (editorial approval granted), publish (asset published to distribution), archive (moved to archive storage), storage_tier_migration (moved between storage tiers), legal_hold_applied (legal preservation hold placed), legal_hold_released (legal hold removed), format_migration (transcoded to new format), purge (permanently deleted), restore (recovered from archive), transcode_initiated (format conversion started), transcode_completed (format conversion finished), metadata_update (descriptive metadata changed), rights_clearance (usage rights verified), expiration (asset reached end of retention period). [ENUM-REF-CANDIDATE: ingest|qc_pass|qc_fail|approval|publish|archive|storage_tier_migration|legal_hold_applied|legal_hold_released|format_migration|purge|restore|transcode_initiated|transcode_completed|metadata_update|rights_clearance|expiration — 17 candidates stripped; promote to reference product] | Column event_type (STRING) in mediaasset.asset_lifecycle_event',
    `file_size_bytes` BIGINT COMMENT 'The size of the media file in bytes at the time of this lifecycle event. Used to track storage consumption, validate successful transfers, and monitor format migration efficiency. | Column file_size_bytes (BIGINT) in mediaasset.asset_lifecycle_event',
    `metadata_version` STRING COMMENT 'Version number of the assets descriptive metadata at the time of this lifecycle event. Incremented with each metadata_update event. Used to track metadata evolution and support rollback scenarios. | Column metadata_version (INT) in mediaasset.asset_lifecycle_event',
    `new_state` STRING COMMENT 'The lifecycle state of the media asset immediately after this event occurred. Captures the to state in the state transition. Uses the same value set as previous_state. This is the EVENT_PAYLOAD_OR_VALUE required for EVENT_LOG role. [ENUM-REF-CANDIDATE: raw|ingested|qc_pending|qc_approved|qc_rejected|approved|published|archived|on_legal_hold|migrated|purged|active|inactive — 13 candidates stripped; promote to reference product] | Column new_state (STRING) in mediaasset.asset_lifecycle_event',
    `operator_identity` STRING COMMENT 'The identity of the human operator or automated system that triggered or executed this lifecycle event. May be a user ID, system account name, or automated workflow identifier. Used for accountability and audit trail purposes. | Column operator_identity (STRING) in mediaasset.asset_lifecycle_event',
    `operator_type` STRING COMMENT 'Classification of the entity that initiated the lifecycle event. Values: human (manual user action), automated_workflow (Dalet Galaxy workflow automation), scheduled_job (time-based system task), api_integration (external system integration), system_process (internal MAM process). | Column operator_type (STRING) in mediaasset.asset_lifecycle_event. Valid values are `human|automated_workflow|scheduled_job|api_integration|system_process`',
    `previous_state` STRING COMMENT 'The lifecycle state of the media asset immediately before this event occurred. Captures the from state in the state transition. Values include: raw (unprocessed footage), ingested (imported into MAM), qc_pending (awaiting quality control), qc_approved (passed quality control), qc_rejected (failed quality control), approved (editorially approved), published (available for distribution), archived (moved to long-term storage), on_legal_hold (preservation hold active), migrated (format converted), purged (deleted), active (in use), inactive (not in use). [ENUM-REF-CANDIDATE: raw|ingested|qc_pending|qc_approved|qc_rejected|approved|published|archived|on_legal_hold|migrated|purged|active|inactive — 13 candidates stripped; promote to reference product] | Column previous_state (STRING) in mediaasset.asset_lifecycle_event',
    `qc_defect_count` STRING COMMENT 'Number of quality defects identified during quality control inspection, applicable for qc_fail events. Defects may include video artifacts, audio issues, metadata errors, or format compliance violations. | Column qc_defect_count (INT) in mediaasset.asset_lifecycle_event',
    `qc_score` DECIMAL(18,2) COMMENT 'Numeric quality control score assigned during qc_pass or qc_fail events. Scale typically 0-100, representing technical quality assessment of video, audio, and metadata completeness. Used to track asset quality metrics over time. | Column qc_score (DECIMAL(5,2)) in mediaasset.asset_lifecycle_event',
    `rights_clearance_status` STRING COMMENT 'The status of usage rights clearance for the media asset at the time of this lifecycle event. Values: cleared (all rights verified and approved), pending (rights verification in progress), restricted (usage limitations apply), expired (rights period ended), unknown (rights status not determined). Critical for compliance with licensing agreements and copyright law. | Column rights_clearance_status (STRING) in mediaasset.asset_lifecycle_event. Valid values are `cleared|pending|restricted|expired|unknown`',
    `source_format` STRING COMMENT 'The media file format or codec of the asset before this event, applicable for format_migration and transcode events. Examples: MPEG-4, ProRes, H.264, H.265, MXF, MOV, AVI. Follows ISO 14496 MPEG-4 and related video format standards. | Column source_format (STRING) in mediaasset.asset_lifecycle_event',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in mediaasset.asset_lifecycle_event',
    `source_storage_tier` STRING COMMENT 'The storage tier where the asset resided before this event, applicable for storage_tier_migration events. Values: hot (high-performance online storage), warm (standard online storage), cold (infrequent access storage), archive (long-term preservation), glacier (deep archive), nearline (tape-based near-online), offline (physical media storage). [ENUM-REF-CANDIDATE: hot|warm|cold|archive|glacier|nearline|offline — 7 candidates stripped; promote to reference product] | Column source_storage_tier (STRING) in mediaasset.asset_lifecycle_event',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.asset_lifecycle_event',
    `target_format` STRING COMMENT 'The media file format or codec of the asset after this event, applicable for format_migration and transcode events. Examples: MPEG-4, ProRes, H.264, H.265, MXF, MOV, AVI. Follows ISO 14496 MPEG-4 and related video format standards. | Column target_format (STRING) in mediaasset.asset_lifecycle_event',
    `target_storage_tier` STRING COMMENT 'The storage tier where the asset was moved to during this event, applicable for storage_tier_migration events. Uses the same value set as source_storage_tier. [ENUM-REF-CANDIDATE: hot|warm|cold|archive|glacier|nearline|offline — 7 candidates stripped; promote to reference product] | Column target_storage_tier (STRING) in mediaasset.asset_lifecycle_event',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.asset_lifecycle_event',
    CONSTRAINT pk_asset_lifecycle_event PRIMARY KEY(`asset_lifecycle_event_id`)
) COMMENT 'Immutable audit log of every significant lifecycle state transition for a media asset — ingest, QC pass, QC fail, approval, publish, archive, storage tier migration, legal hold applied, legal hold released, format migration, and purge. Each record captures the event type, previous state, new state, event timestamp, operator or automated system identity, and a free-text reason. Provides the complete chain-of-custody audit trail required for regulatory, legal, and rights compliance. | Unity Catalog table: media_broadcasting_ecm.mediaasset.asset_lifecycle_event';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` (
    `legal_hold_id` BIGINT COMMENT 'Unique identifier for the legal hold record. Primary key. | Column legal_hold_id (BIGINT) in mediaasset.legal_hold',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Legal holds triggered by talent-related litigation (contract disputes, likeness rights claims, guild grievances) require tracking which talent is the subject. Essential for legal compliance and discov | Column subject_talent_profile_id (BIGINT) in talent.legal_hold',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.legal_hold',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.legal_hold',
    `acknowledgment_deadline_date` DATE COMMENT 'Deadline by which custodians must acknowledge the legal hold order. Nullable if acknowledgment is not required. Format: yyyy-MM-dd. | Column acknowledgment_deadline_date (DATE) in mediaasset.legal_hold',
    `acknowledgment_required` BOOLEAN COMMENT 'Indicates whether custodians and stakeholders are required to formally acknowledge receipt and understanding of the legal hold order. | Column acknowledgment_required (BOOLEAN) in mediaasset.legal_hold',
    `asset_count` STRING COMMENT 'Total number of media assets currently under this legal hold. Updated as assets are added or removed from hold scope. | Column asset_count (INT) in mediaasset.legal_hold',
    `audit_trail_required` BOOLEAN COMMENT 'Indicates whether a detailed chain-of-custody audit trail must be maintained for all access, modification, and preservation actions on assets under this legal hold. | Column audit_trail_required (BOOLEAN) in mediaasset.legal_hold',
    `case_number` STRING COMMENT 'Official case, docket, or investigation number associated with the legal matter requiring the hold. Used for cross-referencing with legal case management systems. | Column case_number (STRING) in mediaasset.legal_hold',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in mediaasset.legal_hold',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this legal hold record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. | Column created_timestamp (TIMESTAMP) in mediaasset.legal_hold',
    `custodian_email` STRING COMMENT 'Primary email address of the legal hold custodian for communication regarding hold status, scope changes, and release authorization. | Column custodian_email (STRING) in mediaasset.legal_hold. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `custodian_name` STRING COMMENT 'Full name of the individual responsible for managing and enforcing this legal hold order, typically a legal counsel or compliance officer. | Column custodian_name (STRING) in mediaasset.legal_hold',
    `custodian_phone` STRING COMMENT 'Primary contact phone number for the legal hold custodian. | Column custodian_phone (STRING) in mediaasset.legal_hold',
    `external_counsel_contact` STRING COMMENT 'Full name of the primary contact person at the external counsel firm managing this legal hold matter. | Column external_counsel_contact (STRING) in mediaasset.legal_hold',
    `external_counsel_firm` STRING COMMENT 'Name of the external law firm or legal counsel representing the organization in the matter associated with this legal hold. | Column external_counsel_firm (STRING) in mediaasset.legal_hold',
    `hold_end_date` DATE COMMENT 'Date when the legal hold order was formally released or expired, allowing normal retention policies to resume. Nullable for active holds. Format: yyyy-MM-dd. | Column hold_end_date (DATE) in mediaasset.legal_hold',
    `hold_priority` STRING COMMENT 'Priority level assigned to this legal hold, indicating urgency and importance for compliance and enforcement purposes. | Column hold_priority (STRING) in mediaasset.legal_hold. Valid values are `critical|high|medium|low`',
    `hold_reason` STRING COMMENT 'Detailed explanation of the legal matter, dispute, investigation, or regulatory inquiry that necessitates preservation of media assets under this hold. | Column hold_reason (STRING) in mediaasset.legal_hold',
    `hold_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this legal hold order for tracking and citation purposes. Format: LH-YYYY-NNNNNN. | Column hold_reference_number (STRING) in mediaasset.legal_hold. Valid values are `^LH-[0-9]{4}-[0-9]{6}$`',
    `hold_start_date` DATE COMMENT 'Date when the legal hold order became effective and preservation obligations commenced. Format: yyyy-MM-dd. | Column hold_start_date (DATE) in mediaasset.legal_hold',
    `hold_status` STRING COMMENT 'Current lifecycle status of the legal hold order. Active holds prevent automated retention policy actions (purge, tier migration) on in-scope assets. | Column hold_status (STRING) in mediaasset.legal_hold. Valid values are `active|released|expired|suspended|pending_review`',
    `hold_type` STRING COMMENT 'Classification of the legal hold based on the nature of the legal matter requiring preservation of media assets. | Column hold_type (STRING) in mediaasset.legal_hold. Valid values are `litigation|regulatory_investigation|rights_dispute|fcc_inquiry|internal_investigation|audit`',
    `issuing_authority` STRING COMMENT 'The entity or department that issued the legal hold order, such as internal legal department, court, Federal Communications Commission (FCC), or other regulatory body. | Column issuing_authority (STRING) in mediaasset.legal_hold. Valid values are `legal_department|court_order|fcc|regulatory_body|external_counsel|internal_audit`',
    `issuing_authority_name` STRING COMMENT 'Full name of the specific authority, court, or regulatory body that issued the legal hold order. | Column issuing_authority_name (STRING) in mediaasset.legal_hold',
    `last_modified_by` STRING COMMENT 'Username or identifier of the individual who last modified this legal hold record. | Column last_modified_by (STRING) in mediaasset.legal_hold',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this legal hold record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. | Column last_modified_timestamp (TIMESTAMP) in mediaasset.legal_hold',
    `mam_system_lock_enabled` BOOLEAN COMMENT 'Indicates whether a system-level lock has been applied in the Media Asset Management (MAM) system (Dalet Galaxy) to prevent modification or deletion of held assets. | Column mam_system_lock_enabled (BOOLEAN) in mediaasset.legal_hold',
    `notes` STRING COMMENT 'Additional notes, instructions, or context regarding the legal hold order, including special handling requirements, scope clarifications, or communication history. | Column notes (STRING) in mediaasset.legal_hold',
    `notification_sent_date` DATE COMMENT 'Date when formal notification of the legal hold was sent to relevant custodians, stakeholders, and Media Asset Management (MAM) system administrators. Format: yyyy-MM-dd. | Column notification_sent_date (DATE) in mediaasset.legal_hold',
    `release_authorization_date` DATE COMMENT 'Date when formal authorization was granted to release the legal hold, allowing normal retention policies to resume on previously held assets. Format: yyyy-MM-dd. | Column release_authorization_date (DATE) in mediaasset.legal_hold',
    `release_authorized_by` STRING COMMENT 'Full name of the individual or authority who formally authorized the release of this legal hold order. | Column release_authorized_by (STRING) in mediaasset.legal_hold',
    `retention_override_flag` BOOLEAN COMMENT 'Indicates whether this legal hold overrides standard retention policies and prevents automated purge, archival tier migration, or deletion actions on in-scope assets. | Column retention_override_flag (BOOLEAN) in mediaasset.legal_hold',
    `scope_description` STRING COMMENT 'Detailed description of the media assets, content types, date ranges, and metadata criteria that define which assets are subject to this legal hold. | Column scope_description (STRING) in mediaasset.legal_hold',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in mediaasset.legal_hold',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.legal_hold',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.legal_hold',
    `created_by` STRING COMMENT 'Username or identifier of the individual who created this legal hold record in the system. | Column created_by (STRING) in mediaasset.legal_hold',
    CONSTRAINT pk_legal_hold PRIMARY KEY(`legal_hold_id`)
) COMMENT 'Records active and historical legal hold orders applied to media assets — capturing hold reference number, issuing authority (legal department, court order, regulatory body), hold reason (litigation, regulatory investigation, rights dispute, FCC inquiry), assets in scope, hold start date, hold end date, hold status (active/released/expired), and the identity of the legal hold custodian. Prevents automated retention policy actions (purge, tier migration) from executing on held assets until the hold is formally released. | Unity Catalog table: media_broadcasting_ecm.mediaasset.legal_hold';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` (
    `format_specification_id` BIGINT COMMENT 'Unique identifier for the format specification record. Primary key. | Column format_specification_id (BIGINT) in mediaasset.format_specification',
    `broadcast_standard_id` BIGINT COMMENT 'FK added per VREQ',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.format_specification',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.format_specification',
    `approval_date` DATE COMMENT 'Date when this format specification was officially approved for production use. | Column approval_date (DATE) in mediaasset.format_specification',
    `approved_by` STRING COMMENT 'Name or identifier of the technical authority or committee that approved this format specification for production use. | Column approved_by (STRING) in mediaasset.format_specification',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the video frame (e.g., 16:9 for widescreen, 4:3 for standard, 21:9 for cinematic). | Column aspect_ratio (NUMERIC) in mediaasset.format_specification',
    `audio_bit_depth` STRING COMMENT 'Audio bit depth in bits per sample (e.g., 16-bit for standard, 24-bit for professional, 32-bit float for mastering). | Column audio_bit_depth (INT) in mediaasset.format_specification',
    `audio_channel_configuration` STRING COMMENT 'Audio channel layout and count (e.g., stereo 2.0, surround 5.1, immersive 7.1.4 Dolby Atmos, mono 1.0). | Column audio_channel_configuration (STRING) in mediaasset.format_specification',
    `audio_codec` STRING COMMENT 'Audio compression codec used for encoding (e.g., AAC, PCM, Dolby AC-3, Dolby E, Dolby Atmos, MPEG-1 Layer II). | Column audio_codec (STRING) in mediaasset.format_specification',
    `audio_sample_rate_khz` DECIMAL(18,2) COMMENT 'Audio sampling frequency in kilohertz (e.g., 48.000 kHz for broadcast, 44.100 kHz for CD quality, 96.000 kHz for high-resolution). | Column audio_sample_rate_khz (DECIMAL(6,3)) in mediaasset.format_specification',
    `bit_rate_mbps` DECIMAL(18,2) COMMENT 'Target video bit rate in megabits per second (Mbps) for encoding, determining quality and file size. | Column bit_rate_mbps (DECIMAL(10,3)) in mediaasset.format_specification',
    `bit_rate_mode` STRING COMMENT 'Encoding bit rate control mode: CBR (Constant Bit Rate), VBR (Variable Bit Rate), or ABR (Average Bit Rate / Adaptive Bitrate Streaming). | Column bit_rate_mode (STRING) in mediaasset.format_specification. Valid values are `CBR|VBR|ABR`',
    `checksum_algorithm` STRING COMMENT 'Cryptographic hash algorithm used for file integrity verification and chain-of-custody audit (MD5, SHA-1, SHA-256, SHA-512, xxHash). | Column checksum_algorithm (STRING) in mediaasset.format_specification. Valid values are `MD5|SHA1|SHA256|SHA512|xxHash`',
    `color_space` STRING COMMENT 'Color space standard used for video encoding (e.g., BT.709 for HD, BT.2020 for UHD, DCI-P3 for cinema). | Column color_space (STRING) in mediaasset.format_specification',
    `container_format` STRING COMMENT 'File container format that wraps the encoded video and audio streams (MXF for broadcast, MP4 for web, MOV for production, TS for streaming, AVI legacy, MKV open-source). | Column container_format (STRING) in mediaasset.format_specification. Valid values are `MXF|MP4|MOV|TS|AVI|MKV`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in mediaasset.format_specification',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this format specification record was first created in the system. | Column created_timestamp (TIMESTAMP) in mediaasset.format_specification',
    `drm_compatibility` STRING COMMENT 'Digital Rights Management systems compatible with this format (e.g., Widevine, FairPlay, PlayReady, none for unencrypted). | Column drm_compatibility (STRING) in mediaasset.format_specification',
    `effective_from_date` DATE COMMENT 'Date from which this format specification becomes active and available for use in production workflows. | Column effective_from_date (DATE) in mediaasset.format_specification',
    `effective_until_date` DATE COMMENT 'Date when this format specification is scheduled to be deprecated or retired. Null for formats with no planned end date. | Column effective_until_date (DATE) in mediaasset.format_specification',
    `file_extension` STRING COMMENT 'Standard file extension for files encoded in this format (e.g., .mxf, .mp4, .mov, .ts, .m3u8). | Column file_extension (STRING) in mediaasset.format_specification',
    `format_category` STRING COMMENT 'Classification of the format by its intended use case in the media workflow: ingest (acquisition), mezzanine (high-quality intermediate), proxy (low-res editing), playout (broadcast transmission), OTT delivery (streaming), or archive (long-term preservation). | Column format_category (STRING) in mediaasset.format_specification. Valid values are `ingest|mezzanine|proxy|playout|ott_delivery|archive`',
    `format_code` STRING COMMENT 'Unique business identifier code for the format specification used across systems and workflows. | Column format_code (STRING) in mediaasset.format_specification',
    `format_name` STRING COMMENT 'Human-readable name of the media format specification (e.g., HD 1080p H.264 AAC, 4K UHD HEVC Dolby Atmos). | Column format_name (STRING) in mediaasset.format_specification',
    `frame_rate` DECIMAL(18,2) COMMENT 'Video frame rate in frames per second (fps), e.g., 23.976, 24.000, 25.000, 29.970, 30.000, 50.000, 59.940, 60.000. | Column frame_rate (DECIMAL(6,3)) in mediaasset.format_specification',
    `governing_standard` STRING COMMENT 'Primary industry or regulatory standard governing this format specification (e.g., ATSC 3.0, DVB-T2, SMPTE ST 2110, ISO/IEC 14496, ITU-R BT.2020). | Column governing_standard (STRING) in mediaasset.format_specification',
    `hdr_standard` STRING COMMENT 'High Dynamic Range standard applied to the format (e.g., HDR10, HDR10+, HLG (Hybrid Log-Gamma), Dolby Vision, none for SDR). | Column hdr_standard (STRING) in mediaasset.format_specification',
    `horizontal_resolution` STRING COMMENT 'Horizontal pixel count of the video frame (e.g., 1920 for Full HD, 3840 for UHD). | Column horizontal_resolution (INT) in mediaasset.format_specification',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this format specification record was last updated or modified. | Column last_modified_timestamp (TIMESTAMP) in mediaasset.format_specification',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the format specification: active (in production use), deprecated (phasing out), retired (no longer used), draft (under development), under_review (pending approval), or approved (ready for deployment). | Column lifecycle_status (STRING) in mediaasset.format_specification. Valid values are `active|deprecated|retired|draft|under_review|approved`',
    `loudness_standard` STRING COMMENT 'Audio loudness normalization standard applied (e.g., ITU-R BS.1770-4 LKFS, EBU R128 LUFS, ATSC A/85 for broadcast). | Column loudness_standard (STRING) in mediaasset.format_specification',
    `mime_type` STRING COMMENT 'MIME (Multipurpose Internet Mail Extensions) type for HTTP delivery and content negotiation (e.g., video/mp4, application/mxf, video/MP2T). | Column mime_type (STRING) in mediaasset.format_specification',
    `qc_profile` STRING COMMENT 'Quality control validation profile applied to assets in this format, defining automated checks for technical compliance (e.g., video levels, audio loudness, format conformance). | Column qc_profile (STRING) in mediaasset.format_specification',
    `resolution_class` STRING COMMENT 'Video resolution classification: SD (Standard Definition 480/576), HD (720p), FHD (Full HD 1080p), UHD (Ultra HD 2160p), 4K (4096x2160), 8K (7680x4320). | Column resolution_class (STRING) in mediaasset.format_specification. Valid values are `SD|HD|FHD|UHD|4K|8K`',
    `retention_period_years` STRING COMMENT 'Minimum retention period in years for assets encoded in this format, driven by regulatory, legal hold, or business requirements. | Column retention_period_years (INT) in mediaasset.format_specification',
    `scan_type` STRING COMMENT 'Video scanning method: progressive (all lines scanned sequentially, denoted p) or interlaced (alternating fields, denoted i). | Column scan_type (STRING) in mediaasset.format_specification. Valid values are `progressive|interlaced`',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in mediaasset.format_specification',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.format_specification',
    `storage_tier` STRING COMMENT 'Recommended storage tier for assets in this format based on access frequency and retention policy: hot (frequent access), warm (occasional access), cold (infrequent access), archive (long-term preservation), glacier (deep archive). | Column storage_tier (STRING) in mediaasset.format_specification. Valid values are `hot|warm|cold|archive|glacier`',
    `streaming_protocol` STRING COMMENT 'Streaming delivery protocol supported by this format (e.g., HLS (HTTP Live Streaming), MPEG-DASH (Dynamic Adaptive Streaming over HTTP), RTMP, SRT, none for file-based). | Column streaming_protocol (STRING) in mediaasset.format_specification',
    `subtitle_format` STRING COMMENT 'Subtitle or closed caption format supported (e.g., SRT, WebVTT, TTML, CEA-608, CEA-708, EBU-TT-D, none if not applicable). | Column subtitle_format (STRING) in mediaasset.format_specification',
    `target_loudness_lufs` DECIMAL(18,2) COMMENT 'Target integrated loudness level in LUFS (Loudness Units relative to Full Scale) or LKFS, typically -23 LUFS for broadcast, -14 LUFS for streaming. | Column target_loudness_lufs (DECIMAL(5,2)) in mediaasset.format_specification',
    `transcode_priority` STRING COMMENT 'Default processing priority for transcode jobs targeting this format: critical (immediate), high (expedited), normal (standard queue), low (off-peak), batch (scheduled bulk processing). | Column transcode_priority (STRING) in mediaasset.format_specification. Valid values are `critical|high|normal|low|batch`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.format_specification',
    `vertical_resolution` STRING COMMENT 'Vertical pixel count of the video frame (e.g., 1080 for Full HD, 2160 for UHD). | Column vertical_resolution (INT) in mediaasset.format_specification',
    `video_codec` STRING COMMENT 'Video compression codec used for encoding (e.g., H.264/AVC, H.265/HEVC, AV1, Apple ProRes, Avid DNxHD, MPEG-2). | Column video_codec (STRING) in mediaasset.format_specification',
    CONSTRAINT pk_format_specification PRIMARY KEY(`format_specification_id`)
) COMMENT 'Reference catalogue of all approved media format specifications used across the enterprise — capturing format name, container format (MXF, MP4, MOV, TS), video codec (H.264, H.265/HEVC, AV1, ProRes, DNxHD), audio codec (AAC, PCM, Dolby AC-3, Dolby Atmos), resolution class (SD/HD/UHD/4K/8K), frame rate, scan type (progressive/interlaced), HDR standard (HDR10, HLG, Dolby Vision), audio loudness spec, subtitle/caption format, intended use case (ingest/mezzanine/proxy/playout/OTT-delivery/archive), and governing standard reference (ATSC, DVB, HLS, MPEG-DASH). Drives transcode job configuration and QC compliance checks. | Unity Catalog table: media_broadcasting_ecm.mediaasset.format_specification';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` (
    `asset_collection_id` BIGINT COMMENT 'Unique identifier for the asset collection. Primary key. | Column asset_collection_id (BIGINT) in mediaasset.asset_collection',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Collections (series, franchises) are managed under specific cost centers for production and library management budgets. Enables portfolio-level cost tracking and multi-title project accounting. | Column cost_center_id (BIGINT) in finance.asset_collection',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Collections drive revenue streams (box sets, franchise licensing, library sales) tracked by profit center. Critical for franchise P&L reporting, content portfolio valuation, and strategic investment d | Column profit_center_id (BIGINT) in finance.asset_collection',
    `retention_policy_id` BIGINT COMMENT 'Foreign key linking to mediaasset.retention_policy. Business justification: Normalization: asset_collection has retention_policy_code STRING which should be FK to retention_policy catalog. This connects asset_collection to the relational graph and allows retrieving full polic | Column retention_policy_id (BIGINT) in mediaasset.asset_collection',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.asset_collection',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.asset_collection',
    `archive_tier` STRING COMMENT 'Storage tier classification for the collection: hot (frequent access), warm (occasional access), cold (rare access), glacier (long-term preservation), or deep-archive (regulatory retention). | Column archive_tier (STRING) in mediaasset.asset_collection. Valid values are `hot|warm|cold|glacier|deep-archive`',
    `asset_collection_status` STRING COMMENT 'Current lifecycle status of the collection: draft (being assembled), active (available for use), archived (preserved but not active), deprecated (superseded), under-review (pending approval), or locked (no modifications allowed). | Column asset_collection_status (STRING) in mediaasset.asset_collection. Valid values are `draft|active|archived|deprecated|under-review|locked`',
    `audio_description_available_flag` BOOLEAN COMMENT 'Indicates whether audio description tracks are available for visually impaired audiences (true) or not (false). Required for accessibility compliance. | Column audio_description_available_flag (BOOLEAN) in mediaasset.asset_collection',
    `bulk_operation_enabled` BOOLEAN COMMENT 'Indicates whether bulk operations (bulk QC, bulk rights check, bulk archive, bulk transcode) are enabled for this collection (true) or must be performed individually (false). | Column bulk_operation_enabled (BOOLEAN) in mediaasset.asset_collection',
    `checksum_algorithm` STRING COMMENT 'Algorithm used to generate checksums for integrity verification of the collection package (MD5, SHA-1, SHA-256, SHA-512, or xxHash). | Column checksum_algorithm (STRING) in mediaasset.asset_collection. Valid values are `MD5|SHA-1|SHA-256|SHA-512|xxHash`',
    `checksum_value` DECIMAL(18,2) COMMENT 'Computed checksum value for the collection package, used to verify data integrity during transfer, storage, and archival. | Column checksum_value (DECIMAL(18,2)) in mediaasset.asset_collection',
    `closed_caption_available_flag` BOOLEAN COMMENT 'Indicates whether closed captions are available for all time-based assets in the collection (true) or not (false). Required for FCC compliance. | Column closed_caption_available_flag (BOOLEAN) in mediaasset.asset_collection',
    `collection_code` STRING COMMENT 'Business identifier or code for the collection, used for external reference and cataloging (e.g., GOT-S08-PKG, NEWS-ELEC24-001). | Column collection_code (STRING) in mediaasset.asset_collection',
    `collection_name` STRING COMMENT 'Human-readable name of the asset collection (e.g., Breaking News Package - Election 2024, Game of Thrones Season 8 Bundle, Super Bowl LVIII Highlights). | Column collection_name (STRING) in mediaasset.asset_collection',
    `collection_type` STRING COMMENT 'Classification of the collection by content grouping purpose: series (episodic television), film-franchise (related films), news-package (story bundle), sports-event (game/match clips), music-album (music tracks), campaign-creative (advertising assets), documentary-series, special-event, archive-bundle, or promo-package. [ENUM-REF-CANDIDATE: series|film-franchise|news-package|sports-event|music-album|campaign-creative|documentary-series|special-event|archive-bundle|promo-package — 10 candidates stripped; promote to reference product] | Column collection_type (STRING) in mediaasset.asset_collection',
    `content_rating` STRING COMMENT 'Age-appropriateness or content rating for the collection (e.g., TV-PG, TV-14, TV-MA, G, PG, PG-13, R). Used for compliance and scheduling. | Column content_rating (STRING) in mediaasset.asset_collection',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in mediaasset.asset_collection',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created the collection record in the MAM system. Used for audit trail and accountability. | Column created_by_user (STRING) in mediaasset.asset_collection',
    `curator_name` STRING COMMENT 'Name of the individual or team responsible for curating and maintaining the collection. | Column curator_name (STRING) in mediaasset.asset_collection',
    `asset_collection_description` STRING COMMENT 'Detailed narrative description of the collections content, purpose, and editorial context. Used for cataloging and discovery. | Column asset_collection_description (STRING) in mediaasset.asset_collection',
    `distribution_window_end` DATE COMMENT 'End date of the distribution window after which the collection may no longer be distributed or broadcast. Part of windowing strategy. | Column distribution_window_end (DATE) in mediaasset.asset_collection',
    `distribution_window_start` DATE COMMENT 'Start date of the distribution window during which the collection may be distributed or broadcast. Part of windowing strategy. | Column distribution_window_start (DATE) in mediaasset.asset_collection',
    `eidr_identifier` STRING COMMENT 'Globally unique EIDR identifier for the collection, used for rights management and content identification across the industry. | Column eidr_identifier (STRING) in mediaasset.asset_collection. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `language_code` STRING COMMENT 'Primary language of the collection content, using ISO 639-3 three-letter language codes (e.g., eng for English, spa for Spanish, fra for French). | Column language_code (STRING) in mediaasset.asset_collection. Valid values are `^[a-z]{3}$`',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified the collection record. Used for audit trail and accountability. | Column last_modified_by_user (STRING) in mediaasset.asset_collection',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the collection or its membership (asset added, removed, or metadata updated). | Column last_modified_timestamp (TIMESTAMP) in mediaasset.asset_collection',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether the collection is under legal hold (true) or not (false). Assets under legal hold cannot be deleted or modified. | Column legal_hold_flag (BOOLEAN) in mediaasset.asset_collection',
    `metadata_completeness_score` DECIMAL(18,2) COMMENT 'Percentage score (0.00 to 100.00) indicating the completeness of metadata across all assets in the collection. Used for quality assurance and discoverability. | Column metadata_completeness_score (DECIMAL(5,2)) in mediaasset.asset_collection',
    `notes` STRING COMMENT 'Free-form notes or comments about the collection, used for internal communication, special handling instructions, or editorial context. | Column notes (STRING) in mediaasset.asset_collection',
    `owner_department` STRING COMMENT 'Business unit or department responsible for the collection (e.g., News Editorial, Sports Production, Entertainment Programming, Marketing Creative Services). | Column owner_department (STRING) in mediaasset.asset_collection',
    `packaging_format` STRING COMMENT 'Technical packaging format used for distribution (e.g., IMF, DPP, AS-11, ProRes Package, MPEG-DASH Manifest). Relevant for distribution deals. | Column packaging_format (STRING) in mediaasset.asset_collection',
    `primary_genre` STRING COMMENT 'Primary content genre or category for the collection (e.g., Drama, News, Sports, Documentary, Comedy, Music, Reality). | Column primary_genre (STRING) in mediaasset.asset_collection',
    `qc_status` STRING COMMENT 'Quality control status for the collection as a whole: not-started, in-progress, passed (all assets QC approved), failed (one or more assets failed QC), or waived (QC not required). | Column qc_status (STRING) in mediaasset.asset_collection. Valid values are `not-started|in-progress|passed|failed|waived`',
    `rights_clearance_status` STRING COMMENT 'Status of rights clearance for the entire collection: cleared (all rights verified), pending (clearance in progress), restricted (usage limitations), expired (rights lapsed), or not-required (no clearance needed). | Column rights_clearance_status (STRING) in mediaasset.asset_collection. Valid values are `cleared|pending|restricted|expired|not-required`',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in mediaasset.asset_collection',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.asset_collection',
    `syndication_eligible_flag` BOOLEAN COMMENT 'Indicates whether the collection is eligible for syndication (resale to multiple outlets) based on rights and content suitability (true) or not (false). | Column syndication_eligible_flag (BOOLEAN) in mediaasset.asset_collection',
    `target_audience` STRING COMMENT 'Intended audience demographic or segment for the collection (e.g., Adults 18-49, Children 6-11, General Audience, Sports Enthusiasts). | Column target_audience (STRING) in mediaasset.asset_collection',
    `territory_code` STRING COMMENT 'Geographic territory or market for which the collection is intended, using ISO 3166-1 alpha-3 country codes (e.g., USA, GBR, CAN). | Column territory_code (STRING) in mediaasset.asset_collection. Valid values are `^[A-Z]{3}$`',
    `total_asset_count` STRING COMMENT 'Total number of media assets currently included in the collection. | Column total_asset_count (INT) in mediaasset.asset_collection',
    `total_duration_seconds` BIGINT COMMENT 'Cumulative playback duration of all time-based assets in the collection, measured in seconds. | Column total_duration_seconds (BIGINT) in mediaasset.asset_collection',
    `total_storage_size_bytes` BIGINT COMMENT 'Total storage footprint of all assets in the collection, measured in bytes. Used for capacity planning and archival costing. | Column total_storage_size_bytes (BIGINT) in mediaasset.asset_collection',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.asset_collection',
    `creation_date` DATE COMMENT 'Date when the collection was first created in the MAM (Media Asset Management) system. | Column creation_date (DATE) in mediaasset.asset_collection',
    CONSTRAINT pk_asset_collection PRIMARY KEY(`asset_collection_id`)
) COMMENT 'Defines logical groupings of media assets for editorial, distribution, or archival purposes — such as a series package, film franchise bundle, news story package, sports event clip collection, or music album. Captures collection name, type (series/film/news-package/sports-event/music-album/campaign-creative), description, creation date, owner department, status, and an ordered member list with membership role (primary/supplemental/bonus/trailer/promo), sequence position, and inclusion dates. Enables bulk operations (bulk QC, bulk rights check, bulk archive) and supports content packaging for distribution deals. | Unity Catalog table: media_broadcasting_ecm.mediaasset.asset_collection';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` (
    `archive_record_id` BIGINT COMMENT 'Primary key for archive_record | Column archive_record_id (BIGINT) in mediaasset.archive_record',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Archive operations target specific versions (mezzanine, proxy, master) not just the abstract asset. This FK allows tracking which exact rendition was archived. Nullable initially, populated during arc | Column asset_version_id (BIGINT) in mediaasset.archive_record',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Archive operations (tape handling, vault storage, retrieval) incur costs allocated to archive management cost centers. Supports archive budget tracking, cost-per-asset metrics, and storage tier optimi | Column cost_center_id (BIGINT) in finance.archive_record',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Archives may be held at partner facilities (Iron Mountain, AWS Glacier, offsite vaults). Tracks custodian partner for retrieval requests, audit compliance, disaster recovery planning, and vendor perfo | Column custodian_partner_partner_partner_id (BIGINT) in partner.archive_record',
    `employee_id` BIGINT COMMENT 'Identifier of the operator or system user who initiated or supervised the archival process, supporting chain-of-custody audit trails. | Column employee_id (BIGINT) in workforce.archive_record',
    `media_asset_id` BIGINT COMMENT 'Reference to the media asset being archived. Links to the source digital asset in the Media Asset Management (MAM) system. | Column media_asset_id (BIGINT) in mediaasset.archive_record',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.archive_record',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.archive_record',
    `archive_cost_per_gb` DECIMAL(18,2) COMMENT 'The cost per gigabyte for storing the asset in the archive destination, used for financial planning and cost allocation. | Column archive_cost_per_gb (DECIMAL(10,4)) in mediaasset.archive_record',
    `archive_date` DATE COMMENT 'The date when the media asset was formally archived to long-term storage. | Column archive_date (DATE) in mediaasset.archive_record',
    `archive_destination_identifier` STRING COMMENT 'Specific identifier for the archive destination such as LTO (Linear Tape-Open) tape barcode, cloud vault identifier, or off-site facility location code. | Column archive_destination_identifier (STRING) in mediaasset.archive_record',
    `archive_destination_type` STRING COMMENT 'The type of long-term storage destination where the asset was archived. | Column archive_destination_type (STRING) in mediaasset.archive_record. Valid values are `lto_tape|cloud_deep_archive|offsite_facility|nearline_storage|optical_media|hybrid_archive`',
    `archive_file_size_bytes` BIGINT COMMENT 'The size of the archived media file in bytes, used for storage capacity planning and billing. | Column archive_file_size_bytes (BIGINT) in mediaasset.archive_record',
    `archive_format` STRING COMMENT 'The file format or container format of the archived asset (e.g., MXF, MOV, MP4, ProRes, DNxHD) as stored in the archive. | Column archive_format (STRING) in mediaasset.archive_record',
    `archive_job_reference` STRING COMMENT 'Unique reference number assigned to the archival job or batch process that created this archive record. | Column archive_job_reference (STRING) in mediaasset.archive_record',
    `archive_notes` STRING COMMENT 'Free-text notes or comments about the archival process, special handling instructions, or any issues encountered during archival. | Column archive_notes (STRING) in mediaasset.archive_record',
    `archive_status` STRING COMMENT 'Current lifecycle status of the archived asset indicating its availability and operational state. [ENUM-REF-CANDIDATE: archived|restore_requested|restore_in_progress|restored|purge_pending|purged|failed — 7 candidates stripped; promote to reference product] | Column archive_status (STRING) in mediaasset.archive_record',
    `archive_system_name` STRING COMMENT 'Name of the archival system or MAM module that performed the archival operation (e.g., Dalet Galaxy Archive, Spectra Logic). | Column archive_system_name (STRING) in mediaasset.archive_record',
    `archive_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the archival process completed and the asset was committed to long-term storage. | Column archive_timestamp (TIMESTAMP) in mediaasset.archive_record',
    `checksum_algorithm` STRING COMMENT 'The cryptographic hash algorithm used to generate the checksum for verifying asset integrity during archival and restore operations. | Column checksum_algorithm (STRING) in mediaasset.archive_record. Valid values are `md5|sha256|sha512|xxhash`',
    `checksum_value` DECIMAL(18,2) COMMENT 'The computed checksum hash value of the archived media asset, used to verify data integrity and detect corruption. | Column checksum_value (DECIMAL(18,2)) in mediaasset.archive_record',
    `cloud_vault_identifier` STRING COMMENT 'Unique identifier for the cloud deep-archive vault or bucket where the asset is stored (e.g., AWS Glacier vault ARN, Azure Archive Storage container). | Column cloud_vault_identifier (STRING) in mediaasset.archive_record',
    `compression_codec` STRING COMMENT 'The compression codec applied to the media asset for archival storage (e.g., H.264, H.265, JPEG2000, uncompressed). | Column compression_codec (STRING) in mediaasset.archive_record',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in mediaasset.archive_record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this archive record was first created in the system. | Column created_timestamp (TIMESTAMP) in mediaasset.archive_record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this archive record was last updated or modified. | Column last_modified_timestamp (TIMESTAMP) in mediaasset.archive_record',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether the archived asset is under legal hold, preventing deletion or modification regardless of retention policy. | Column legal_hold_flag (BOOLEAN) in mediaasset.archive_record',
    `lto_tape_generation` STRING COMMENT 'The LTO tape generation standard used for archival (e.g., LTO-8, LTO-9) if the destination is tape-based storage. | Column lto_tape_generation (STRING) in mediaasset.archive_record',
    `oais_compliance_flag` BOOLEAN COMMENT 'Indicates whether this archive record complies with ISO 14721 OAIS reference model standards for long-term digital preservation. | Column oais_compliance_flag (BOOLEAN) in mediaasset.archive_record',
    `offsite_facility_code` STRING COMMENT 'Code identifying the physical off-site archival facility or vault location where the media is stored. | Column offsite_facility_code (STRING) in mediaasset.archive_record',
    `purge_approval_status` STRING COMMENT 'Approval status for purging the archived asset, ensuring compliance with retention and legal hold requirements before deletion. | Column purge_approval_status (STRING) in mediaasset.archive_record. Valid values are `pending|approved|rejected|not_required`',
    `purge_scheduled_date` DATE COMMENT 'The scheduled date for purging or permanently deleting the archived asset, based on retention policy expiration. | Column purge_scheduled_date (DATE) in mediaasset.archive_record',
    `restore_completion_date` DATE COMMENT 'The date when the restore operation was completed and the asset was made available for use. | Column restore_completion_date (DATE) in mediaasset.archive_record',
    `restore_request_date` DATE COMMENT 'The date when a restore request was submitted for this archived asset, if applicable. | Column restore_request_date (DATE) in mediaasset.archive_record',
    `restore_sla_tier` STRING COMMENT 'The service level tier defining the expected restore time for retrieving this archived asset (e.g., expedited within hours, standard within days, bulk within weeks). | Column restore_sla_tier (STRING) in mediaasset.archive_record. Valid values are `expedited|standard|bulk|emergency`',
    `restore_test_date` DATE COMMENT 'The date when the last restore test was performed to verify the integrity and retrievability of the archived asset. | Column restore_test_date (DATE) in mediaasset.archive_record',
    `restore_test_result` STRING COMMENT 'Outcome of the most recent restore test indicating whether the asset was successfully retrieved and validated. | Column restore_test_result (STRING) in mediaasset.archive_record. Valid values are `passed|failed|partial|not_tested`',
    `retention_expiry_date` DATE COMMENT 'The date when the retention period expires and the asset becomes eligible for purging or disposition review. | Column retention_expiry_date (DATE) in mediaasset.archive_record',
    `retention_policy_code` STRING COMMENT 'Code identifying the retention policy applied to this archived asset, governing how long it must be preserved and under what conditions it may be purged. | Column retention_policy_code (STRING) in mediaasset.archive_record',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in mediaasset.archive_record',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.archive_record',
    `storage_tier` STRING COMMENT 'The storage tier classification indicating access frequency and cost structure (hot for frequent access, deep archive for infrequent access). | Column storage_tier (STRING) in mediaasset.archive_record. Valid values are `hot|warm|cold|deep_archive`',
    `tape_barcode` STRING COMMENT 'Physical barcode identifier on the LTO tape cartridge used for archival, enabling physical inventory tracking. | Column tape_barcode (STRING) in mediaasset.archive_record',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.archive_record',
    CONSTRAINT pk_archive_record PRIMARY KEY(`archive_record_id`)
) COMMENT 'Tracks the formal archival of media assets to long-term storage — capturing archive date, archive destination (LTO tape generation, cloud deep-archive vault, off-site facility), archive job reference, tape barcode or vault identifier, restore SLA tier, restore test date, restore test result, retention policy applied, archival operator, and archive status (archived/restore-requested/restored/purge-pending). Supports ISO 14721 OAIS compliance and provides the authoritative record for asset archival and retrieval operations. | Unity Catalog table: media_broadcasting_ecm.mediaasset.archive_record';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` (
    `format_migration_id` BIGINT COMMENT 'Unique identifier for the format migration operation. Primary key. | Column format_migration_id (BIGINT) in mediaasset.format_migration',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Format migration projects incur transcoding, QC, and storage costs allocated to technical infrastructure cost centers. Required for migration project accounting, ROI analysis, and capital vs. operatio | Column cost_center_id (BIGINT) in finance.format_migration',
    `employee_id` BIGINT COMMENT 'Reference to the user or system account that initiated or executed the migration job. Supports chain-of-custody audit trail. | Column employee_id (BIGINT) in workforce.format_migration',
    `media_asset_id` BIGINT COMMENT 'Reference to the media asset being migrated. Links to the source digital object in the MAM (Media Asset Management) system. | Column media_asset_id (BIGINT) in mediaasset.format_migration',
    `retention_policy_id` BIGINT COMMENT 'Reference to the retention policy governing the migrated asset. Determines minimum and maximum retention periods. | Column retention_policy_id (BIGINT) in mediaasset.format_migration',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Format migration converts a specific source version to a target version. This FK identifies the source version being migrated. Distinct from the existing media_asset_id FK which identifies the asset c | Column source_asset_version_id (BIGINT) in mediaasset.format_migration',
    `format_specification_id` BIGINT COMMENT 'Foreign key linking to mediaasset.format_specification. Business justification: Normalization: source format details should be retrieved from format_specification catalog via JOIN. Removes redundant format attributes. The source_format STRING becomes a FK to the authoritative for | Column source_format_specification_id (BIGINT) in mediaasset.format_migration',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.format_migration',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.format_migration',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in mediaasset.format_migration',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this migration record was first created in the system. Audit trail timestamp for record creation. | Column created_timestamp (TIMESTAMP) in mediaasset.format_migration',
    `error_code` STRING COMMENT 'System error code returned if the migration job failed. Used for troubleshooting and root cause analysis. | Column error_code (STRING) in mediaasset.format_migration',
    `error_message` STRING COMMENT 'Detailed error message describing the failure reason if the migration job did not complete successfully. | Column error_message (STRING) in mediaasset.format_migration',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether the asset is subject to legal hold or preservation order. Prevents deletion and enforces chain-of-custody requirements. | Column legal_hold_flag (BOOLEAN) in mediaasset.format_migration',
    `migration_duration_seconds` DECIMAL(18,2) COMMENT 'Total elapsed time for the migration operation in seconds. Used for performance monitoring and capacity planning. | Column migration_duration_seconds (DECIMAL(12,2)) in mediaasset.format_migration',
    `migration_end_timestamp` TIMESTAMP COMMENT 'Date and time when the format migration job completed or terminated. Used to calculate migration duration and throughput. | Column migration_end_timestamp (TIMESTAMP) in mediaasset.format_migration',
    `migration_engine` STRING COMMENT 'Name and version of the transcoding or migration software used to perform the format conversion (e.g., FFmpeg 5.1, Telestream Vantage 8.2, AWS MediaConvert). | Column migration_engine (STRING) in mediaasset.format_migration',
    `migration_job_number` STRING COMMENT 'Business identifier for the migration job. Externally-known unique code used for tracking and reporting. | Column migration_job_number (STRING) in mediaasset.format_migration. Valid values are `^MIG-[0-9]{8}-[A-Z0-9]{6}$`',
    `migration_notes` STRING COMMENT 'Free-text notes and comments about the migration operation. Captures operator observations, special handling instructions, or business context. | Column migration_notes (STRING) in mediaasset.format_migration',
    `migration_priority` STRING COMMENT 'Business priority assigned to the migration job. Determines queue position and resource allocation. | Column migration_priority (STRING) in mediaasset.format_migration. Valid values are `critical|high|normal|low`',
    `migration_reason` STRING COMMENT 'Business justification for the format migration operation. Indicates why the asset required conversion. | Column migration_reason (STRING) in mediaasset.format_migration. Valid values are `format_obsolescence|distribution_requirement|storage_optimisation|quality_enhancement|compliance_mandate|platform_compatibility`',
    `migration_start_timestamp` TIMESTAMP COMMENT 'Date and time when the format migration job began processing. Principal business event timestamp for the migration operation. | Column migration_start_timestamp (TIMESTAMP) in mediaasset.format_migration',
    `migration_status` STRING COMMENT 'Current state of the migration job in its workflow lifecycle. | Column migration_status (STRING) in mediaasset.format_migration. Valid values are `queued|in_progress|completed|failed|cancelled|validation_pending`',
    `migration_type` STRING COMMENT 'Technical classification of the migration operation performed on the asset. | Column migration_type (STRING) in mediaasset.format_migration. Valid values are `transcode|upscale|downscale|digitisation|rewrap|restoration`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this migration record was last updated. Audit trail timestamp for record modification. | Column modified_timestamp (TIMESTAMP) in mediaasset.format_migration',
    `operator_name` STRING COMMENT 'Full name of the operator who initiated the migration job. Denormalized for reporting and audit purposes. | Column operator_name (STRING) in mediaasset.format_migration',
    `quality_validation_notes` STRING COMMENT 'Detailed findings from quality validation process. Includes warnings, errors, or observations about the migrated asset quality. | Column quality_validation_notes (STRING) in mediaasset.format_migration',
    `quality_validation_result` STRING COMMENT 'Outcome of automated quality assurance checks performed on the migrated asset. Indicates whether the migration met technical quality standards. | Column quality_validation_result (STRING) in mediaasset.format_migration. Valid values are `passed|failed|warning|not_performed`',
    `quality_validation_score` DECIMAL(18,2) COMMENT 'Numeric quality score (0-100) assigned by automated validation tools. Measures technical fidelity of the migrated asset against the source. | Column quality_validation_score (DECIMAL(5,2)) in mediaasset.format_migration',
    `retry_count` STRING COMMENT 'Number of times the migration job was automatically retried after failure. Used to identify problematic assets or systemic issues. | Column retry_count (INT) in mediaasset.format_migration',
    `source_checksum` STRING COMMENT 'Cryptographic hash (MD5, SHA-256, or SHA-512) of the source file before migration. Ensures file integrity and supports chain-of-custody verification. | Column source_checksum (STRING) in mediaasset.format_migration. Valid values are `^[a-fA-F0-9]{32,128}$`',
    `source_file_size_bytes` BIGINT COMMENT 'Size of the original media file in bytes before migration. Used for storage impact analysis and migration planning. | Column source_file_size_bytes (BIGINT) in mediaasset.format_migration',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in mediaasset.format_migration',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.format_migration',
    `storage_tier_source` STRING COMMENT 'Storage tier classification of the source asset before migration. Indicates retrieval latency and cost profile. | Column storage_tier_source (STRING) in mediaasset.format_migration. Valid values are `online|nearline|archive|glacier`',
    `storage_tier_target` STRING COMMENT 'Storage tier classification of the migrated asset after conversion. Indicates where the new asset will be stored. | Column storage_tier_target (STRING) in mediaasset.format_migration. Valid values are `online|nearline|archive|glacier`',
    `target_bitrate_kbps` DECIMAL(18,2) COMMENT 'Average bitrate of the migrated media file in kilobits per second. Indicates encoding quality and bandwidth requirements after migration. | Column target_bitrate_kbps (DECIMAL(12,2)) in mediaasset.format_migration',
    `target_checksum` STRING COMMENT 'Cryptographic hash (MD5, SHA-256, or SHA-512) of the migrated file after conversion. Validates successful migration and file integrity. | Column target_checksum (STRING) in mediaasset.format_migration. Valid values are `^[a-fA-F0-9]{32,128}$`',
    `target_codec` STRING COMMENT 'Video and audio codec specifications of the migrated asset (e.g., H.264 + AAC, H.265/HEVC + Dolby AC-3). | Column target_codec (STRING) in mediaasset.format_migration',
    `target_file_size_bytes` BIGINT COMMENT 'Size of the migrated media file in bytes after conversion. Used to measure storage optimisation achieved. | Column target_file_size_bytes (BIGINT) in mediaasset.format_migration',
    `target_format` STRING COMMENT 'Destination format of the media asset after migration. Includes codec, container, resolution, and frame rate specifications (e.g., H.264 HD 1920x1080 50fps, ProRes MOV, MPEG-4 AVC). | Column target_format (STRING) in mediaasset.format_migration',
    `target_resolution` STRING COMMENT 'Pixel dimensions of the migrated video (e.g., 1920x1080, 3840x2160, 7680x4320). | Column target_resolution (STRING) in mediaasset.format_migration. Valid values are `^[0-9]{3,4}x[0-9]{3,4}$`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.format_migration',
    CONSTRAINT pk_format_migration PRIMARY KEY(`format_migration_id`)
) COMMENT 'Transactional record of every format migration operation — converting assets from obsolete or deprecated formats to current approved specifications (e.g., SD to HD upscale, MPEG-2 to H.264, tape digitisation, analogue-to-digital conversion). Captures source format, target format, migration reason (format obsolescence / distribution requirement / storage optimisation), migration job start/end timestamps, operator, quality validation result, and migration status. Ensures long-term asset accessibility as format standards evolve. | Unity Catalog table: media_broadcasting_ecm.mediaasset.format_migration';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` (
    `asset_access_request_id` BIGINT COMMENT 'Unique identifier for the asset access request. Primary key. | Column asset_access_request_id (BIGINT) in mediaasset.asset_access_request',
    `employee_id` BIGINT COMMENT 'Identifier of the individual who approved or rejected the access request. Null if request is pending or auto-approved. | Column approver_employee_id (BIGINT) in workforce.asset_access_request',
    `asset_version_id` BIGINT COMMENT 'Identifier of the specific version of the asset being requested. Supports versioned asset management where multiple iterations or edits of the same asset exist. | Column asset_version_id (BIGINT) in mediaasset.asset_access_request',
    `media_asset_id` BIGINT COMMENT 'Identifier of the media asset being requested for access. References the specific digital object (footage, master, proxy, graphic, music bed, or archived asset) managed in the MAM system. | Column media_asset_id (BIGINT) in mediaasset.asset_access_request',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Partners request access to assets for promotional use, quality review, co-production workflows, or syndication preview. Tracks external requestor for security audit, rights compliance verification, an | Column partner_id (BIGINT) in partner.asset_access_request',
    `primary_asset_employee_id` BIGINT COMMENT 'Identifier of the individual or system user who submitted the access request. Supports chain-of-custody tracking and accountability. | Column primary_asset_employee_id (BIGINT) in workforce.asset_access_request',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.asset_access_request',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.asset_access_request',
    `access_duration_hours` STRING COMMENT 'Number of hours for which access is granted, calculated from access_granted_timestamp to access_expiry_timestamp. Used for policy enforcement and reporting. | Column access_duration_hours (INT) in mediaasset.asset_access_request',
    `access_expiry_timestamp` TIMESTAMP COMMENT 'Date and time when the granted access expires and the URI or checkout lock is automatically revoked. Enforces time-bound access for security and rights compliance. | Column access_expiry_timestamp (TIMESTAMP) in mediaasset.asset_access_request',
    `access_granted_timestamp` TIMESTAMP COMMENT 'Date and time when access was actually granted and the URI or download became available to the requestor. May differ from approval_timestamp if provisioning delay exists. | Column access_granted_timestamp (TIMESTAMP) in mediaasset.asset_access_request',
    `access_granted_uri` STRING COMMENT 'Secure URL or file path provided to the requestor for accessing the approved asset. Generated upon approval and may include time-limited token or DRM protection. | Column access_granted_uri (STRING) in mediaasset.asset_access_request',
    `access_purpose` STRING COMMENT 'Business reason for requesting access to the asset. Determines approval workflow and usage restrictions applied. [ENUM-REF-CANDIDATE: editing|review|distribution|legal|compliance|research|archival|rights_clearance|promotional|internal_use — 10 candidates stripped; promote to reference product] | Column access_purpose (STRING) in mediaasset.asset_access_request',
    `access_type` STRING COMMENT 'Type of access being requested: stream (view-only online), download (local copy), checkout (exclusive edit lock), preview (low-res proxy), or metadata-only (descriptive information without media file). | Column access_type (STRING) in mediaasset.asset_access_request. Valid values are `stream|download|checkout|preview|metadata_only`',
    `approval_notes` STRING COMMENT 'Free-text comments or justification provided by the approver explaining the approval or rejection decision. Supports audit trail and dispute resolution. | Column approval_notes (STRING) in mediaasset.asset_access_request',
    `approval_required` BOOLEAN COMMENT 'Indicates whether the request requires explicit approval (true) or is auto-approved based on policy rules (false). Determined by asset sensitivity, rights restrictions, and requestor role. | Column approval_required (BOOLEAN) in mediaasset.asset_access_request',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the request was approved or rejected. Null if request is still pending. Recorded in ISO 8601 format for audit and SLA measurement. | Column approval_timestamp (TIMESTAMP) in mediaasset.asset_access_request',
    `approver_name` STRING COMMENT 'Full name of the individual who approved or rejected the request. Captured for audit trail and accountability. | Column approver_name (STRING) in mediaasset.asset_access_request',
    `checkout_lock_active` BOOLEAN COMMENT 'Indicates whether an exclusive checkout lock is currently active on the asset (true) or not (false). Prevents concurrent editing and ensures version control integrity. | Column checkout_lock_active (BOOLEAN) in mediaasset.asset_access_request',
    `compliance_classification` STRING COMMENT 'Data classification level of the asset being accessed, determining approval workflow rigor and access logging requirements. | Column compliance_classification (STRING) in mediaasset.asset_access_request. Valid values are `public|internal|confidential|restricted|highly_restricted`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in mediaasset.asset_access_request',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this access request record was first created in the system. Recorded in ISO 8601 format for audit trail. | Column created_timestamp (TIMESTAMP) in mediaasset.asset_access_request',
    `download_count` STRING COMMENT 'Number of times the asset was downloaded by the requestor under this access grant. Supports usage tracking and compliance auditing. | Column download_count (INT) in mediaasset.asset_access_request',
    `drm_applied` BOOLEAN COMMENT 'Indicates whether DRM protection was applied to the accessed asset (true) or not (false). Supports rights protection and anti-piracy compliance. | Column drm_applied (BOOLEAN) in mediaasset.asset_access_request',
    `last_accessed_timestamp` TIMESTAMP COMMENT 'Date and time when the requestor last accessed (streamed or downloaded) the asset under this grant. Supports usage monitoring and inactive access cleanup. | Column last_accessed_timestamp (TIMESTAMP) in mediaasset.asset_access_request',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether the asset is under legal hold (true) or not (false). When true, access requests may require additional legal approval and all access is logged for litigation support. | Column legal_hold_flag (BOOLEAN) in mediaasset.asset_access_request',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this access request record was last modified. Recorded in ISO 8601 format for audit trail and change tracking. | Column modified_timestamp (TIMESTAMP) in mediaasset.asset_access_request',
    `priority_level` STRING COMMENT 'Business priority assigned to the access request, influencing approval SLA and queue position. Urgent requests may trigger expedited approval workflows. | Column priority_level (STRING) in mediaasset.asset_access_request. Valid values are `low|normal|high|urgent`',
    `rejection_reason` STRING COMMENT 'Explanation for why the access request was rejected. Populated only when request_status is rejected. Supports transparency and requestor feedback. | Column rejection_reason (STRING) in mediaasset.asset_access_request',
    `request_number` STRING COMMENT 'Human-readable business identifier for the access request, formatted as REQ-YYYYMMDD-XXXXXX for tracking and reference purposes. | Column request_number (STRING) in mediaasset.asset_access_request. Valid values are `^REQ-[0-9]{8}-[A-Z0-9]{6}$`',
    `request_source` STRING COMMENT 'System or interface through which the access request was submitted. Supports usage analytics and integration monitoring. | Column request_source (STRING) in mediaasset.asset_access_request. Valid values are `mam_portal|api|mobile_app|workflow_automation|third_party_integration`',
    `request_status` STRING COMMENT 'Current lifecycle status of the access request. Tracks progression through approval workflow and final disposition. | Column request_status (STRING) in mediaasset.asset_access_request. Valid values are `pending|approved|rejected|cancelled|expired|revoked`',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the access request was submitted. Recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX) for audit trail and SLA tracking. | Column request_timestamp (TIMESTAMP) in mediaasset.asset_access_request',
    `requestor_department` STRING COMMENT 'Business unit or department of the requestor (e.g., News, Sports, Production, Legal, Compliance, Marketing). Used for access policy enforcement and usage analytics. | Column requestor_department (STRING) in mediaasset.asset_access_request',
    `requestor_email` STRING COMMENT 'Email address of the requestor for notification and communication regarding the access request status and approval. | Column requestor_email (STRING) in mediaasset.asset_access_request. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requestor_name` STRING COMMENT 'Full name of the individual who submitted the access request. Captured for audit trail and human-readable reporting. | Column requestor_name (STRING) in mediaasset.asset_access_request',
    `rights_clearance_required` BOOLEAN COMMENT 'Indicates whether the requested access purpose requires explicit rights clearance verification (true) or not (false). Applies to distribution, promotional, and external use cases. | Column rights_clearance_required (BOOLEAN) in mediaasset.asset_access_request',
    `rights_clearance_status` STRING COMMENT 'Status of rights clearance verification for this access request. Blocked status prevents access grant even if otherwise approved. | Column rights_clearance_status (STRING) in mediaasset.asset_access_request. Valid values are `not_required|pending|cleared|blocked`',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in mediaasset.asset_access_request',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.asset_access_request',
    `stream_count` STRING COMMENT 'Number of times the asset was streamed by the requestor under this access grant. Supports usage tracking and analytics. | Column stream_count (INT) in mediaasset.asset_access_request',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.asset_access_request',
    `usage_restrictions` STRING COMMENT 'Free-text description of any usage restrictions or conditions applied to the granted access (e.g., internal use only, no redistribution, watermarked, editorial use only). Enforces rights and compliance requirements. | Column usage_restrictions (STRING) in mediaasset.asset_access_request',
    `watermark_applied` BOOLEAN COMMENT 'Indicates whether a forensic or visible watermark was applied to the accessed asset (true) or not (false). Supports leak tracing and chain-of-custody enforcement. | Column watermark_applied (BOOLEAN) in mediaasset.asset_access_request',
    CONSTRAINT pk_asset_access_request PRIMARY KEY(`asset_access_request_id`)
) COMMENT 'Records every formal request to access, download, or check out a media asset — capturing requestor identity, requestor department, requested asset and version, access purpose (editing/review/distribution/legal/compliance/research), requested access type (stream/download/checkout), request timestamp, approval status (pending/approved/rejected), approver identity, approval timestamp, access granted URI, access expiry, and any usage restrictions applied. Supports controlled access governance and chain-of-custody tracking for sensitive or rights-restricted assets. | Unity Catalog table: media_broadcasting_ecm.mediaasset.asset_access_request';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` (
    `asset_rights_grant_id` BIGINT COMMENT 'Unique identifier for this specific rights grant record | Column asset_rights_grant_id (BIGINT) in mediaasset.asset_rights_grant',
    `employee_id` BIGINT COMMENT 'Reference to the internal user who created this rights grant record, for audit and accountability purposes. | Column employee_id (BIGINT) in workforce.asset_rights_grant',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to the media asset for which rights are being granted | Column media_asset_id (BIGINT) in mediaasset.asset_rights_grant',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the partner receiving the rights grant | Column partner_id (BIGINT) in partner.asset_rights_grant',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.asset_rights_grant',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.asset_rights_grant',
    `contract_reference` STRING COMMENT 'Reference to the master licensing agreement or contract under which this specific rights grant is issued. | Column contract_reference (STRING) in mediaasset.asset_rights_grant',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in mediaasset.asset_rights_grant',
    `effective_end_date` DATE COMMENT 'Date when the rights grant expires and the partner must cease exploitation. Null indicates perpetual rights. | Column effective_end_date (DATE) in mediaasset.asset_rights_grant',
    `effective_start_date` DATE COMMENT 'Date when the rights grant becomes active and the partner may begin exploiting the asset in the specified territory and manner. | Column effective_start_date (DATE) in mediaasset.asset_rights_grant',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this rights grant is exclusive (true) or non-exclusive (false) within the specified territory and rights type. Exclusive grants prevent other partners from receiving the same rights. | Column exclusivity_flag (BOOLEAN) in mediaasset.asset_rights_grant',
    `grant_status` STRING COMMENT 'Current lifecycle status of the rights grant. Tracks whether the grant is pending activation, currently active, temporarily suspended, naturally expired, or contractually terminated. | Column grant_status (STRING) in mediaasset.asset_rights_grant',
    `granted_date` TIMESTAMP COMMENT 'Timestamp when this rights grant record was created in the system, representing when the business agreement was executed. | Column granted_date (TIMESTAMP) in mediaasset.asset_rights_grant',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue that the partner remits back to the content owner for exploitation of this asset. Null if fixed-fee licensing model. | Column revenue_share_percentage (DECIMAL(5,2)) in mediaasset.asset_rights_grant',
    `rights_type` STRING COMMENT 'Type of distribution rights granted (linear broadcast, video-on-demand, streaming, theatrical, etc.). Determines how the partner may exploit the asset. | Column rights_type (STRING) in mediaasset.asset_rights_grant',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in mediaasset.asset_rights_grant',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.asset_rights_grant',
    `territory_scope` STRING COMMENT 'Geographic territories or markets where the partner holds distribution rights. May be country codes, regions, or worldwide. | Column territory_scope (STRING) in mediaasset.asset_rights_grant',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.asset_rights_grant',
    `usage_restrictions` STRING COMMENT 'Additional contractual restrictions on how the partner may use the asset (e.g., no editing, must include credits, advertising limitations, platform restrictions). | Column usage_restrictions (STRING) in mediaasset.asset_rights_grant',
    CONSTRAINT pk_asset_rights_grant PRIMARY KEY(`asset_rights_grant_id`)
) COMMENT 'This association product represents the licensing contract between media_asset and partner_partner. It captures the specific rights granted to a partner for a media asset, including territorial scope, distribution windows, exclusivity terms, and revenue arrangements. Each record links one media_asset to one partner_partner with attributes that exist only in the context of this specific rights grant.. Existence Justification: In media broadcasting, a single media asset (film, episode, music track) is routinely licensed to multiple partners simultaneously under different terms - one partner may hold linear broadcast rights in North America, another holds streaming rights in Europe, and a third holds FAST channel rights globally. Conversely, each partner (studio, MVPD, streaming platform) holds rights to many assets in their content portfolio. The relationship itself carries critical business data including rights type, territorial scope, distribution windows, exclusivity terms, and revenue arrangements that cannot logically reside on either the asset or partner entity alone. | Unity Catalog table: media_broadcasting_ecm.mediaasset.asset_rights_grant';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` (
    `deal_asset_license_id` BIGINT COMMENT 'Unique identifier for this specific asset license within an acquisition deal | Column deal_asset_license_id (BIGINT) in mediaasset.deal_asset_license',
    `acquisition_deal_id` BIGINT COMMENT 'Foreign key linking to the acquisition deal under which this asset is licensed | Column acquisition_deal_id (BIGINT) in partner.deal_asset_license',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to the specific media asset being licensed under this deal | Column media_asset_id (BIGINT) in mediaasset.deal_asset_license',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.deal_asset_license',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.deal_asset_license',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in mediaasset.deal_asset_license',
    `delivery_date` DATE COMMENT 'Date when the asset was delivered by the content provider and accepted by the broadcaster | Column delivery_date (DATE) in mediaasset.deal_asset_license',
    `delivery_status` STRING COMMENT 'Current status of the physical or digital delivery of this asset from the content provider to the broadcaster | Column delivery_status (STRING) in mediaasset.deal_asset_license',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this specific asset is licensed exclusively within the specified territories, may differ from overall deal exclusivity | Column exclusivity_flag (BOOLEAN) in mediaasset.deal_asset_license',
    `license_fee_amount` DECIMAL(18,2) COMMENT 'The specific fee paid for licensing this individual asset as part of the deal, may be allocated from package pricing or individually negotiated | Column license_fee_amount (DECIMAL(18,2)) in mediaasset.deal_asset_license',
    `license_term_end_date` DATE COMMENT 'The date when the license rights for this specific asset expire, may differ from overall deal expiration for asset-specific terms | Column license_term_end_date (DATE) in mediaasset.deal_asset_license',
    `license_term_start_date` DATE COMMENT 'The date when the license rights for this specific asset become effective, may differ from overall deal effective date for staggered releases | Column license_term_start_date (DATE) in mediaasset.deal_asset_license',
    `rights_restrictions` STRING COMMENT 'Specific usage restrictions or limitations for this asset beyond the general deal terms, such as platform restrictions, time-of-day limitations, or promotional restrictions | Column rights_restrictions (STRING) in mediaasset.deal_asset_license',
    `runs_allowed` STRING COMMENT 'Maximum number of times this asset can be broadcast or made available under the license terms, null indicates unlimited runs | Column runs_allowed (INT) in mediaasset.deal_asset_license',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in mediaasset.deal_asset_license',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.deal_asset_license',
    `territory_code` STRING COMMENT 'ISO 3166-1 alpha-2 country codes specifying the geographic territories where this asset can be distributed under this deal, may be subset of overall deal territory coverage | Column territory_code (STRING) in mediaasset.deal_asset_license',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.deal_asset_license',
    CONSTRAINT pk_deal_asset_license PRIMARY KEY(`deal_asset_license_id`)
) COMMENT 'This association product represents the licensing relationship between individual media assets and acquisition deals. Each record captures the specific terms under which a single media asset is licensed as part of an acquisition deal, including territory-specific rights, financial terms, usage restrictions, and delivery status. This is the operational record that rights management, finance, and content operations teams use to track what content was acquired under which deals and the specific terms governing each assets use.. Existence Justification: In media broadcasting operations, acquisition deals routinely license content packages containing multiple media assets (film libraries, TV series, documentary collections), and individual high-value assets (blockbuster films, premium sports content) are frequently licensed through multiple deals covering different territories, windows, or platforms. The detection phase explicitly identified an existing association product (acquisition_deal_line) that already implements this M:N relationship with deal-asset-specific attributes including license fees, territory codes, term dates, runs allowed, and delivery status. | Unity Catalog table: media_broadcasting_ecm.mediaasset.deal_asset_license';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` (
    `collection_membership_id` BIGINT COMMENT 'Unique identifier for this collection membership record. Primary key. | Column collection_membership_id (BIGINT) in mediaasset.collection_membership',
    `asset_collection_id` BIGINT COMMENT 'Foreign key linking to the asset collection that contains the media asset | Column asset_collection_id (BIGINT) in mediaasset.collection_membership',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to the media asset that is a member of the collection | Column media_asset_id (BIGINT) in mediaasset.collection_membership',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.collection_membership',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.collection_membership',
    `added_by_user` STRING COMMENT 'Username or identifier of the user who added this asset to the collection. Supports audit trail and accountability. | Column added_by_user (STRING) in mediaasset.collection_membership',
    `added_date` DATE COMMENT 'Date when the media asset was added to this collection. Tracks membership history and supports temporal queries. | Column added_date (DATE) in mediaasset.collection_membership',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in mediaasset.collection_membership',
    `curator_notes` STRING COMMENT 'Free-text notes from the curator about this specific membership, such as editorial decisions, version notes, or special handling instructions. | Column curator_notes (STRING) in mediaasset.collection_membership',
    `inclusion_reason` STRING COMMENT 'Business justification or editorial rationale for including this asset in the collection. Supports curatorial decision tracking. | Column inclusion_reason (STRING) in mediaasset.collection_membership',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this membership record. Supports change tracking and synchronization. | Column last_modified_timestamp (TIMESTAMP) in mediaasset.collection_membership',
    `membership_role` STRING COMMENT 'Role or purpose of this asset within the collection context. Values: primary (main content), supplemental (supporting material), bonus (extra content), trailer (preview), promo (promotional), archive (historical reference). | Column membership_role (STRING) in mediaasset.collection_membership',
    `membership_status` STRING COMMENT 'Current lifecycle status of this membership. Values: active (currently included), pending (queued for inclusion), removed (no longer included), archived (historical record). | Column membership_status (STRING) in mediaasset.collection_membership',
    `removed_by_user` STRING COMMENT 'Username or identifier of the user who removed this asset from the collection. Null if still active. Supports audit trail. | Column removed_by_user (STRING) in mediaasset.collection_membership',
    `removed_date` DATE COMMENT 'Date when the media asset was removed from this collection. Null if still active. Enables tracking of membership lifecycle. | Column removed_date (DATE) in mediaasset.collection_membership',
    `sequence_number` STRING COMMENT 'Ordinal position of this asset within the collection for playback or presentation ordering. Supports ordered collections like series episodes or album tracks. | Column sequence_number (INT) in mediaasset.collection_membership',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in mediaasset.collection_membership',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.collection_membership',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.collection_membership',
    CONSTRAINT pk_collection_membership PRIMARY KEY(`collection_membership_id`)
) COMMENT 'This association product represents the membership relationship between asset collections and media assets. It captures which assets belong to which collections, when they were added, their sequence/ordering within the collection, their role (primary/supplemental/bonus/trailer/promo), and their membership status. Each record links one asset collection to one media asset with attributes that exist only in the context of this membership relationship. Enables curators to actively manage collection composition, track membership history, and support bulk operations on grouped assets.. Existence Justification: In media asset management operations, curators actively manage collection membership as a distinct business concept. A single media asset (e.g., a news clip, music track, or video segment) can simultaneously belong to multiple collections (e.g., a breaking news package, a year-end retrospective, and a topic-specific archive). Conversely, each collection contains many assets organized with specific sequencing, roles, and inclusion rationale. This is not a simple reference but a managed relationship with its own lifecycle, tracked through dates, statuses, and curator notes. | Unity Catalog table: media_broadcasting_ecm.mediaasset.collection_membership';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` (
    `asset_legal_hold_id` BIGINT COMMENT 'Unique identifier for this specific assignment of a legal hold to a media asset. Primary key. | Column asset_legal_hold_id (BIGINT) in mediaasset.asset_legal_hold',
    `employee_id` BIGINT COMMENT 'Employee identifier of the custodian responsible for managing this specific asset under this specific legal hold. May differ from the overall legal hold custodian for specialized asset types. | Column custodian_employee_id (BIGINT) in workforce.asset_legal_hold',
    `legal_hold_id` BIGINT COMMENT 'Foreign key linking to the legal hold order | Column legal_hold_id (BIGINT) in mediaasset.asset_legal_hold',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to the media asset under legal hold | Column media_asset_id (BIGINT) in mediaasset.asset_legal_hold',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.asset_legal_hold',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.asset_legal_hold',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in mediaasset.asset_legal_hold',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset legal hold assignment record was first created in the system. Format: yyyy-MM-dd HH:mm:ss | Column created_timestamp (TIMESTAMP) in mediaasset.asset_legal_hold',
    `custodian_acknowledgment_date` DATE COMMENT 'Date when the assigned custodian formally acknowledged responsibility for preserving this specific asset under this legal hold. | Column custodian_acknowledgment_date (DATE) in mediaasset.asset_legal_hold',
    `hold_application_notes` STRING COMMENT 'Detailed notes regarding the application of this legal hold to this specific asset, including any special handling instructions, relevance to the case, or preservation requirements. | Column hold_application_notes (STRING) in mediaasset.asset_legal_hold',
    `hold_applied_date` DATE COMMENT 'Date when this specific legal hold was applied to this specific media asset. Marks the beginning of preservation obligations for this asset under this hold. | Column hold_applied_date (DATE) in mediaasset.asset_legal_hold',
    `hold_released_date` DATE COMMENT 'Date when this specific legal hold was released from this specific media asset, allowing normal retention policies to resume. Nullable while hold is active. | Column hold_released_date (DATE) in mediaasset.asset_legal_hold',
    `hold_status` STRING COMMENT 'Current status of this specific hold assignment. Active=hold in effect, Released=formally released, Expired=hold period ended, Superseded=replaced by another hold. | Column hold_status (STRING) in mediaasset.asset_legal_hold',
    `last_modified_by` STRING COMMENT 'Username or identifier of the individual who last modified this asset legal hold assignment record. | Column last_modified_by (STRING) in mediaasset.asset_legal_hold',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset legal hold assignment record was last updated or modified. Format: yyyy-MM-dd HH:mm:ss | Column last_modified_timestamp (TIMESTAMP) in mediaasset.asset_legal_hold',
    `mam_lock_applied` BOOLEAN COMMENT 'Indicates whether a system-level lock has been successfully applied in the Media Asset Management system to prevent automated retention actions on this specific asset. | Column mam_lock_applied (BOOLEAN) in mediaasset.asset_legal_hold',
    `release_authorization_reference` STRING COMMENT 'Reference number or document identifier for the formal authorization to release this specific asset from this legal hold. Required for audit trail and compliance verification. | Column release_authorization_reference (STRING) in mediaasset.asset_legal_hold',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in mediaasset.asset_legal_hold',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.asset_legal_hold',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.asset_legal_hold',
    `created_by` STRING COMMENT 'Username or identifier of the individual who created this asset legal hold assignment record. | Column created_by (STRING) in mediaasset.asset_legal_hold',
    CONSTRAINT pk_asset_legal_hold PRIMARY KEY(`asset_legal_hold_id`)
) COMMENT 'This association product represents the legal preservation obligation between a media asset and a legal hold order. It captures the application and release of legal holds on specific media assets, tracking custodian acknowledgment, authorization details, and audit trail requirements. Each record links one media asset to one legal hold with attributes that exist only in the context of this specific hold assignment, enabling compliance tracking and preventing automated retention actions on held assets.. Existence Justification: In media broadcasting operations, a single media asset can be subject to multiple legal holds simultaneously (e.g., one asset relevant to both an FCC investigation and a copyright dispute), and a single legal hold order typically covers multiple media assets matching the scope criteria (date ranges, content types, metadata tags). Legal/compliance teams actively manage the assignment of holds to assets, track application and release dates per asset, assign custodians, apply MAM system locks, and maintain detailed audit trails for each asset-hold combination. This is an operational business process with its own lifecycle, not a derived analytical correlation. | Unity Catalog table: media_broadcasting_ecm.mediaasset.asset_legal_hold';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` (
    `syndication_inventory_id` BIGINT COMMENT 'Unique identifier for this syndication inventory record. Primary key. | Column syndication_inventory_id (BIGINT) in mediaasset.syndication_inventory',
    `asset_collection_id` BIGINT COMMENT 'Foreign key linking to the asset collection being syndicated in this deal | Column asset_collection_id (BIGINT) in mediaasset.syndication_inventory',
    `sales_syndication_deal_id` BIGINT COMMENT 'Foreign key linking to the syndication deal that includes this collection | Column sales_syndication_deal_id (BIGINT) in sales.syndication_inventory',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.syndication_inventory',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.syndication_inventory',
    `actual_clearance_percentage` DECIMAL(18,2) COMMENT 'Actual percentage of target market coverage achieved for this collection within this syndication deal. Compared against the deal-level clearance_percentage_target to determine if the collection meets clearance requirements. | Column actual_clearance_percentage (DECIMAL(5,2)) in mediaasset.syndication_inventory',
    `barter_inventory_allocation` STRING COMMENT 'Specific allocation of advertising inventory slots for this collection within this barter or cash-plus-barter syndication deal. Details which ad breaks are retained by syndicator vs. sold by stations for this specific content package. | Column barter_inventory_allocation (STRING) in mediaasset.syndication_inventory',
    `clearance_status` STRING COMMENT 'Current status of market clearance for this collection within this syndication deal. Tracks whether the required percentage of stations/markets have committed to airing this content package. Values: pending, in-progress, cleared, failed, partial. | Column clearance_status (STRING) in mediaasset.syndication_inventory',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in mediaasset.syndication_inventory',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this syndication inventory record was first created in the system. | Column created_timestamp (TIMESTAMP) in mediaasset.syndication_inventory',
    `delivery_date` DATE COMMENT 'Scheduled or actual date when this collection was or will be delivered to the syndicator or station group for this specific deal. Delivery dates vary by deal even for the same collection. | Column delivery_date (DATE) in mediaasset.syndication_inventory',
    `episode_sequence` STRING COMMENT 'Sequential order in which episodes from this collection should be delivered or aired within this specific syndication deal. Controls the strip schedule for the station group. | Column episode_sequence (INT) in mediaasset.syndication_inventory',
    `exclusion_date` DATE COMMENT 'Date when this collection was removed from this syndication deal, if applicable. Null if still active. Supports tracking of deal amendments and content package changes. | Column exclusion_date (DATE) in mediaasset.syndication_inventory',
    `format_specification` STRING COMMENT 'Technical format requirements for delivery of this collection under this syndication deal (e.g., HD 1080i, 4K, specific codec, closed captioning requirements). Format specs are deal-specific as different station groups may have different technical requirements. | Column format_specification (STRING) in mediaasset.syndication_inventory',
    `inclusion_date` DATE COMMENT 'Date when this collection was added to this syndication deal. Supports tracking of deal amendments and content package changes over the deal lifecycle. | Column inclusion_date (DATE) in mediaasset.syndication_inventory',
    `inclusion_status` STRING COMMENT 'Current status of this collections inclusion in the syndication deal. Values: active (currently included), removed (was included but removed), suspended (temporarily not available), pending-approval (proposed but not yet confirmed). | Column inclusion_status (STRING) in mediaasset.syndication_inventory',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this syndication inventory record was most recently updated. | Column last_modified_timestamp (TIMESTAMP) in mediaasset.syndication_inventory',
    `notes` STRING COMMENT 'Free-form notes about this specific collections inclusion in this syndication deal, including special terms, delivery issues, or clearance challenges. | Column notes (STRING) in mediaasset.syndication_inventory',
    `runs_per_episode` STRING COMMENT 'Number of times each episode in this collection may be broadcast by stations under this specific syndication deal. This is deal-and-collection-specific, as different deals may grant different run counts for the same content. | Column runs_per_episode (INT) in mediaasset.syndication_inventory',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in mediaasset.syndication_inventory',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.syndication_inventory',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.syndication_inventory',
    CONSTRAINT pk_syndication_inventory PRIMARY KEY(`syndication_inventory_id`)
) COMMENT 'This association product represents the operational inventory relationship between asset collections and syndication deals. It captures the specific content packages included in each syndication agreement, tracking episode-level delivery schedules, run counts per episode, market-specific clearances, and format requirements that exist only in the context of a specific collection being syndicated through a specific deal. Each record links one asset collection to one syndication deal with attributes that govern how that content is delivered and cleared in that specific deal.. Existence Justification: In media broadcasting syndication operations, asset collections (series packages, film libraries, content bundles) are licensed through multiple syndication deals to different station groups and markets, and each syndication deal includes multiple collections to create attractive programming packages. The relationship between a specific collection and a specific deal carries operational data including episode delivery sequences, run counts per episode, market clearance status, delivery dates, and format specifications that vary by deal even for the same collection. | Unity Catalog table: media_broadcasting_ecm.mediaasset.syndication_inventory';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` (
    `asset_status_ref_id` BIGINT COMMENT 'Column asset_status_ref_id in media_broadcasting.mediaasset.asset_status_ref',
    `media_asset_id` BIGINT COMMENT '',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.asset_status_ref',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.asset_status_ref',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in mediaasset.asset_status_ref',
    `created_timestamp` TIMESTAMP COMMENT 'Column created_timestamp in media_broadcasting.mediaasset.asset_status_ref',
    `is_active_flag` BOOLEAN COMMENT 'Column is_active_flag in media_broadcasting.mediaasset.asset_status_ref',
    `is_available_flag` BOOLEAN COMMENT 'Column is_available_flag in media_broadcasting.mediaasset.asset_status_ref',
    `is_terminal_flag` BOOLEAN COMMENT 'Column is_terminal_flag in media_broadcasting.mediaasset.asset_status_ref',
    `sort_order` STRING COMMENT 'Column sort_order in media_broadcasting.mediaasset.asset_status_ref',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in mediaasset.asset_status_ref',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.asset_status_ref',
    `status_code` STRING COMMENT 'Column status_code in media_broadcasting.mediaasset.asset_status_ref',
    `status_description` STRING COMMENT 'Column status_description in media_broadcasting.mediaasset.asset_status_ref',
    `status_name` STRING COMMENT 'Column status_name in media_broadcasting.mediaasset.asset_status_ref',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.asset_status_ref',
    `updated_timestamp` TIMESTAMP COMMENT 'Column updated_timestamp in media_broadcasting.mediaasset.asset_status_ref',
    CONSTRAINT pk_asset_status_ref PRIMARY KEY(`asset_status_ref_id`)
) COMMENT 'Reference table for media asset statuses | Unity Catalog table: media_broadcasting_ecm.mediaasset.asset_status_ref';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` (
    `storage_tier_ref_id` BIGINT COMMENT 'Column storage_tier_ref_id in media_broadcasting.mediaasset.storage_tier_ref',
    `media_asset_id` BIGINT COMMENT '',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.storage_tier_ref',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.storage_tier_ref',
    `access_latency_ms` STRING COMMENT 'Column access_latency_ms in media_broadcasting.mediaasset.storage_tier_ref',
    `cost_per_gb_monthly` DECIMAL(18,2) COMMENT 'Column cost_per_gb_monthly in media_broadcasting.mediaasset.storage_tier_ref',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in mediaasset.storage_tier_ref',
    `created_timestamp` TIMESTAMP COMMENT 'Column created_timestamp in media_broadcasting.mediaasset.storage_tier_ref',
    `is_active_flag` BOOLEAN COMMENT 'Column is_active_flag in media_broadcasting.mediaasset.storage_tier_ref',
    `sort_order` STRING COMMENT 'Column sort_order in media_broadcasting.mediaasset.storage_tier_ref',
    `source_record_id` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in mediaasset.storage_tier_ref',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.storage_tier_ref',
    `tier_code` STRING COMMENT 'Column tier_code in media_broadcasting.mediaasset.storage_tier_ref',
    `tier_description` STRING COMMENT 'Column tier_description in media_broadcasting.mediaasset.storage_tier_ref',
    `tier_name` STRING COMMENT 'Column tier_name in media_broadcasting.mediaasset.storage_tier_ref',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.storage_tier_ref',
    `updated_timestamp` TIMESTAMP COMMENT 'Column updated_timestamp in media_broadcasting.mediaasset.storage_tier_ref',
    CONSTRAINT pk_storage_tier_ref PRIMARY KEY(`storage_tier_ref_id`)
) COMMENT 'Reference table for storage tiers (hot, warm, cold, archive) | Unity Catalog table: media_broadcasting_ecm.mediaasset.storage_tier_ref';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`mediaasset_watermark_forensic_match` (
    `mediaasset_watermark_forensic_match_id` BIGINT COMMENT 'Primary key for watermark match',
    `anti_piracy_takedown_id` BIGINT COMMENT 'FK to related takedown if applicable',
    `media_asset_id` BIGINT COMMENT 'FK to original media asset',
    `subscriber_id` BIGINT COMMENT 'FK to subscriber if watermark traced to account',
    `employee_id` BIGINT COMMENT 'FK to employee who verified match',
    `action_taken` STRING COMMENT 'Action taken (none, warning, account_suspension, legal)',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `detected_platform` STRING COMMENT 'Platform where content was detected',
    `detected_url` STRING COMMENT 'URL where watermarked content was found',
    `detection_timestamp` TIMESTAMP COMMENT 'When watermark was detected',
    `match_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score of watermark match (0-1)',
    `sample_file_url` STRING COMMENT 'URL to sample of detected content',
    `source_device_code` STRING COMMENT 'Device ID from watermark if available',
    `source_session_code` STRING COMMENT 'Session ID embedded in watermark',
    `source_timestamp` TIMESTAMP COMMENT 'Timestamp embedded in watermark',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `verification_date` DATE COMMENT 'Date of verification',
    `verification_status` STRING COMMENT 'Verification status (pending, verified, false_positive)',
    `watermark_payload` STRING COMMENT 'Decoded watermark payload/identifier',
    `watermark_type` STRING COMMENT 'Type of watermark (video, audio, forensic, visible)',
    `watermark_vendor` STRING COMMENT 'Watermarking technology vendor',
    CONSTRAINT pk_mediaasset_watermark_forensic_match PRIMARY KEY(`mediaasset_watermark_forensic_match_id`)
) COMMENT 'Forensic watermark detection matches linking pirated content back to source through embedded watermarks.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ADD CONSTRAINT `fk_mediaasset_asset_version_format_specification_id` FOREIGN KEY (`format_specification_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification`(`format_specification_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ADD CONSTRAINT `fk_mediaasset_asset_version_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ADD CONSTRAINT `fk_mediaasset_asset_version_transcode_job_id` FOREIGN KEY (`transcode_job_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job`(`transcode_job_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ADD CONSTRAINT `fk_mediaasset_transcode_job_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ADD CONSTRAINT `fk_mediaasset_transcode_job_format_specification_id` FOREIGN KEY (`format_specification_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification`(`format_specification_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ADD CONSTRAINT `fk_mediaasset_qc_inspection_format_specification_id` FOREIGN KEY (`format_specification_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification`(`format_specification_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ADD CONSTRAINT `fk_mediaasset_qc_inspection_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ADD CONSTRAINT `fk_mediaasset_asset_storage_assignment_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ADD CONSTRAINT `fk_mediaasset_asset_storage_assignment_legal_hold_id` FOREIGN KEY (`legal_hold_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold`(`legal_hold_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ADD CONSTRAINT `fk_mediaasset_asset_storage_assignment_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ADD CONSTRAINT `fk_mediaasset_asset_storage_assignment_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ADD CONSTRAINT `fk_mediaasset_asset_storage_assignment_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ADD CONSTRAINT `fk_mediaasset_retention_policy_supersedes_policy_retention_policy_id` FOREIGN KEY (`supersedes_policy_retention_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ADD CONSTRAINT `fk_mediaasset_asset_lifecycle_event_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ADD CONSTRAINT `fk_mediaasset_asset_lifecycle_event_legal_hold_id` FOREIGN KEY (`legal_hold_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold`(`legal_hold_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ADD CONSTRAINT `fk_mediaasset_asset_lifecycle_event_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ADD CONSTRAINT `fk_mediaasset_asset_lifecycle_event_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ADD CONSTRAINT `fk_mediaasset_asset_collection_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ADD CONSTRAINT `fk_mediaasset_archive_record_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ADD CONSTRAINT `fk_mediaasset_archive_record_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ADD CONSTRAINT `fk_mediaasset_format_migration_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ADD CONSTRAINT `fk_mediaasset_format_migration_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ADD CONSTRAINT `fk_mediaasset_format_migration_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ADD CONSTRAINT `fk_mediaasset_format_migration_format_specification_id` FOREIGN KEY (`format_specification_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification`(`format_specification_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ADD CONSTRAINT `fk_mediaasset_asset_access_request_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ADD CONSTRAINT `fk_mediaasset_asset_access_request_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ADD CONSTRAINT `fk_mediaasset_asset_rights_grant_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ADD CONSTRAINT `fk_mediaasset_deal_asset_license_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ADD CONSTRAINT `fk_mediaasset_collection_membership_asset_collection_id` FOREIGN KEY (`asset_collection_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection`(`asset_collection_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ADD CONSTRAINT `fk_mediaasset_collection_membership_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ADD CONSTRAINT `fk_mediaasset_asset_legal_hold_legal_hold_id` FOREIGN KEY (`legal_hold_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold`(`legal_hold_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ADD CONSTRAINT `fk_mediaasset_asset_legal_hold_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ADD CONSTRAINT `fk_mediaasset_syndication_inventory_asset_collection_id` FOREIGN KEY (`asset_collection_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection`(`asset_collection_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ADD CONSTRAINT `fk_mediaasset_asset_status_ref_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ADD CONSTRAINT `fk_mediaasset_storage_tier_ref_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`mediaasset_watermark_forensic_match` ADD CONSTRAINT `fk_mediaasset_mediaasset_watermark_forensic_match_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`mediaasset` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`mediaasset` SET TAGS ('dbx_domain' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` SET TAGS ('dbx_subdomain' = 'asset_catalog');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` SET TAGS ('dbx_star_schema_role' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` SET TAGS ('dbx_data_type' = 'dimension_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.mediaasset.media_asset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.mediaasset.media_asset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` SET TAGS ('dbx_mediaasset_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` SET TAGS ('dbx_domain_ownership' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.cost_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.cost_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.profit_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.profit_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.archived_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.archived_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'raw|mezzanine|proxy|archive|master');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.asset_class');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.asset_class');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_title` SET TAGS ('dbx_business_glossary_term' = 'Asset Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_title` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_title` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.asset_title');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_title` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.asset_title');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.asset_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.asset_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_bit_depth` SET TAGS ('dbx_business_glossary_term' = 'Audio Bit Depth');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_bit_depth` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_bit_depth` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.audio_bit_depth');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_bit_depth` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.audio_bit_depth');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_channels` SET TAGS ('dbx_business_glossary_term' = 'Audio Channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_channels` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_channels` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.audio_channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_channels` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.audio_channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_sample_rate_khz` SET TAGS ('dbx_business_glossary_term' = 'Audio Sample Rate Kilohertz (kHz)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_sample_rate_khz` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_sample_rate_khz` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.audio_sample_rate_khz');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_sample_rate_khz` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.audio_sample_rate_khz');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `bit_rate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Bit Rate Megabits Per Second (Mbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `bit_rate_mbps` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `bit_rate_mbps` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.bit_rate_mbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `bit_rate_mbps` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.bit_rate_mbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'Checksum Message Digest 5 (MD5)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{32}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_validation_regex' = '^[a-fA-F0-9]{32}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.checksum_md5');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.checksum_md5');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_business_glossary_term' = 'Checksum Secure Hash Algorithm 256 (SHA-256)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{64}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_validation_regex' = '^[a-fA-F0-9]{64}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.checksum_sha256');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.checksum_sha256');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `codec` SET TAGS ('dbx_business_glossary_term' = 'Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `codec` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `codec` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `codec` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `color_space` SET TAGS ('dbx_business_glossary_term' = 'Color Space');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `color_space` SET TAGS ('dbx_value_regex' = 'BT.709|BT.2020|DCI-P3|sRGB|Adobe RGB');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `color_space` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `color_space` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.color_space');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `color_space` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.color_space');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `color_space` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `content_classification` SET TAGS ('dbx_business_glossary_term' = 'Content Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `content_classification` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `content_classification` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.content_classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `content_classification` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.content_classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `eidr` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `eidr` SET TAGS ('dbx_value_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `eidr` SET TAGS ('dbx_validation_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `eidr` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `eidr` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.eidr');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `eidr` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.eidr');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `file_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `file_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.file_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `file_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.file_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `file_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size Bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.file_size_bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.file_size_bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `frame_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `frame_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.frame_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `frame_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.frame_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `hdr_format` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `hdr_format` SET TAGS ('dbx_value_regex' = 'SDR|HDR10|HDR10+|Dolby Vision|HLG');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `hdr_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `hdr_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.hdr_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `hdr_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.hdr_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `hdr_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `ingest_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingest Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `ingest_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `ingest_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.ingest_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `ingest_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.ingest_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isan` SET TAGS ('dbx_value_regex' = '^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isan` SET TAGS ('dbx_validation_regex' = '^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isan` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isan` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.isan');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isan` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.isan');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isrc` SET TAGS ('dbx_business_glossary_term' = 'International Standard Recording Code (ISRC)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isrc` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}-[A-Z0-9]{3}-[0-9]{2}-[0-9]{5}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isrc` SET TAGS ('dbx_validation_regex' = '^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isrc` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isrc` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.isrc');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isrc` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.isrc');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Accessed Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.last_accessed_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.last_accessed_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.legal_hold_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.legal_hold_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.lifecycle_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.lifecycle_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `originating_system` SET TAGS ('dbx_business_glossary_term' = 'Originating System');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `originating_system` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `originating_system` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.originating_system');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `originating_system` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.originating_system');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `qc_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Completed Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `qc_completed_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `qc_completed_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.qc_completed_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `qc_completed_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.qc_completed_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `qc_operator` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Operator');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `qc_operator` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `qc_operator` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.qc_operator');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `qc_operator` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.qc_operator');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `resolution` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `resolution` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `resolution` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.retention_expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.retention_expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `retention_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `retention_policy_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `retention_policy_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.retention_policy_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `retention_policy_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.retention_policy_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `retention_policy_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `rights_restriction` SET TAGS ('dbx_business_glossary_term' = 'Rights Restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `rights_restriction` SET TAGS ('dbx_value_regex' = 'unrestricted|internal_only|licensed|embargoed|restricted_territory|legal_hold');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `rights_restriction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `rights_restriction` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `rights_restriction` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.rights_restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `rights_restriction` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.rights_restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `storage_location_uri` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Uniform Resource Identifier (URI)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `storage_location_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `storage_location_uri` SET TAGS ('dbx_validation_regex_^https?' = '//[^s]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `storage_location_uri` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `storage_location_uri` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.storage_location_uri');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `storage_location_uri` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.storage_location_uri');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `storage_tier` SET TAGS ('dbx_business_glossary_term' = 'Storage Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `storage_tier` SET TAGS ('dbx_value_regex' = 'hot|warm|cold|deep_archive|glacier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `storage_tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `storage_tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.storage_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `storage_tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.storage_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `storage_tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `timecode_start` SET TAGS ('dbx_business_glossary_term' = 'Timecode Start');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `timecode_start` SET TAGS ('dbx_value_regex' = '^([0-1][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9][:;][0-9]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `timecode_start` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `timecode_start` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.timecode_start');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `timecode_start` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.timecode_start');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `umid` SET TAGS ('dbx_business_glossary_term' = 'Unique Material Identifier (UMID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `umid` SET TAGS ('dbx_value_regex' = '^[0-9A-F]{64}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `umid` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `umid` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.umid');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `umid` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.umid');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` SET TAGS ('dbx_subdomain' = 'asset_catalog');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` SET TAGS ('dbx_data_type' = 'dimension_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.mediaasset.asset_version');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.mediaasset.asset_version');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` SET TAGS ('dbx_mediaasset_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` SET TAGS ('dbx_domain_ownership' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `partner_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `partner_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.delivery_partner_partner_partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `partner_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.delivery_partner_partner_partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Format Specification Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.format_specification_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.format_specification_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `transcode_job_id` SET TAGS ('dbx_business_glossary_term' = 'Transcode Job ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `transcode_job_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `transcode_job_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.transcode_job_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `transcode_job_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.transcode_job_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `abr_ladder_rung` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Ladder Rung');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `abr_ladder_rung` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `abr_ladder_rung` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.abr_ladder_rung');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `abr_ladder_rung` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.abr_ladder_rung');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.archived_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.archived_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_channels` SET TAGS ('dbx_business_glossary_term' = 'Audio Channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_channels` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_channels` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.audio_channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_channels` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.audio_channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.audio_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.audio_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Bitrate (Kilobits Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.bitrate_kbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.bitrate_kbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA-256|SHA-512');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.checksum_algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.checksum_algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `checksum_value` SET TAGS ('dbx_business_glossary_term' = 'Checksum Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `checksum_value` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `checksum_value` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.checksum_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `checksum_value` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.checksum_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `color_space` SET TAGS ('dbx_business_glossary_term' = 'Color Space');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `color_space` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `color_space` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.color_space');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `color_space` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.color_space');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `color_space` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `container_format` SET TAGS ('dbx_business_glossary_term' = 'Container Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `container_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `container_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.container_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `container_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.container_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `container_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `created_by_user` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `created_by_user` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.created_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `created_by_user` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.created_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `drm_protection` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Protection');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `drm_protection` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `drm_protection` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.drm_protection');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `drm_protection` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.drm_protection');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `drm_system` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) System');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `drm_system` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `drm_system` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.drm_system');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `drm_system` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.drm_system');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.file_size_bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.file_size_bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate (Frames Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.frame_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.frame_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `hdr_format` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `hdr_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `hdr_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.hdr_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `hdr_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.hdr_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `hdr_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `language_code` SET TAGS ('dbx_validation_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `language_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `language_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.language_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `language_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.language_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `language_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `proxy_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Proxy Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `proxy_expiry_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `proxy_expiry_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.proxy_expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `proxy_expiry_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.proxy_expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_business_glossary_term' = 'Rendition Purpose');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.rendition_purpose');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.rendition_purpose');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `resolution_height` SET TAGS ('dbx_business_glossary_term' = 'Resolution Height (Pixels)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `resolution_height` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `resolution_height` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.resolution_height');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `resolution_height` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.resolution_height');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `resolution_width` SET TAGS ('dbx_business_glossary_term' = 'Resolution Width (Pixels)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `resolution_width` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `resolution_width` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.resolution_width');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `resolution_width` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.resolution_width');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `storage_tier` SET TAGS ('dbx_business_glossary_term' = 'Storage Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `storage_tier` SET TAGS ('dbx_value_regex' = 'hot|warm|cold|archive|glacier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `storage_tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `storage_tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.storage_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `storage_tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.storage_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `storage_tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `storage_uri` SET TAGS ('dbx_business_glossary_term' = 'Storage Uniform Resource Identifier (URI)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `storage_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `storage_uri` SET TAGS ('dbx_validation_regex_^https?' = '//[^s]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `storage_uri` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `storage_uri` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.storage_uri');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `storage_uri` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.storage_uri');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `subtitle_tracks` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Tracks');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `subtitle_tracks` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `subtitle_tracks` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.subtitle_tracks');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `subtitle_tracks` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.subtitle_tracks');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `validated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `validated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `validated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.validated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `validated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.validated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `version_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `version_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.version_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `version_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.version_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `version_status` SET TAGS ('dbx_value_regex' = 'active|archived|deprecated|corrupted|pending_validation|deleted');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `version_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `version_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.version_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `version_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.version_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `version_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `video_codec` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `video_codec` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.video_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `video_codec` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.video_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `video_codec` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `watermark_payload` SET TAGS ('dbx_business_glossary_term' = 'Watermark Payload');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `watermark_payload` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `watermark_payload` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `watermark_payload` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.watermark_payload');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `watermark_payload` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.watermark_payload');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` SET TAGS ('dbx_subdomain' = 'media_processing');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` SET TAGS ('dbx_fact_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.mediaasset.ingest_job');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.mediaasset.ingest_job');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` SET TAGS ('dbx_mediaasset_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` SET TAGS ('dbx_domain_ownership' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` SET TAGS ('dbx_data_type' = 'fact_transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` SET TAGS ('dbx_fact_dim_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` SET TAGS ('dbx_star_schema' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_job_id` SET TAGS ('dbx_business_glossary_term' = 'Ingest Job Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_job_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_job_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.ingest_job_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_job_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.ingest_job_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.cost_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.cost_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Created Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.created_asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.created_asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `employee_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `employee_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `employee_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Source Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `partner_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `partner_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.source_partner_partner_partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `partner_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.source_partner_partner_partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `tech_change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Workflow Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `tech_change_request_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `tech_change_request_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.tech_change_request_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `tech_change_request_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.tech_change_request_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `audio_channels` SET TAGS ('dbx_business_glossary_term' = 'Audio Channel Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `audio_channels` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `audio_channels` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.audio_channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `audio_channels` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.audio_channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Bitrate (Kilobits Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.bitrate_kbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.bitrate_kbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `bytes_transferred` SET TAGS ('dbx_business_glossary_term' = 'Bytes Transferred');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `bytes_transferred` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `bytes_transferred` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.bytes_transferred');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `bytes_transferred` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.bytes_transferred');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA-256|SHA-512|CRC32');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.checksum_algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.checksum_algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `checksum_value` SET TAGS ('dbx_business_glossary_term' = 'Checksum Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `checksum_value` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `checksum_value` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.checksum_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `checksum_value` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.checksum_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `closed_caption_present` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Present Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `closed_caption_present` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `closed_caption_present` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.closed_caption_present');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `closed_caption_present` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.closed_caption_present');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `codec` SET TAGS ('dbx_business_glossary_term' = 'Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `codec` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `codec` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `codec` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `color_space` SET TAGS ('dbx_business_glossary_term' = 'Color Space');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `color_space` SET TAGS ('dbx_value_regex' = 'BT.709|BT.2020|DCI-P3|sRGB');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `color_space` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `color_space` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.color_space');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `color_space` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.color_space');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `color_space` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `content_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `content_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.content_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `content_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.content_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `content_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Media Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `error_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `error_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.error_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `error_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.error_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `error_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `error_message` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `error_message` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.error_message');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `error_message` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.error_message');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate (Frames Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `frame_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `frame_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.frame_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `frame_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.frame_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `hdr_format` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `hdr_format` SET TAGS ('dbx_value_regex' = 'SDR|HDR10|HDR10+|Dolby_Vision|HLG');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `hdr_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `hdr_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.hdr_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `hdr_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.hdr_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `hdr_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingest End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_end_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_end_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.ingest_end_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_end_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.ingest_end_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_source_type` SET TAGS ('dbx_business_glossary_term' = 'Ingest Source Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_source_type` SET TAGS ('dbx_value_regex' = 'tape|file_transfer|satellite_feed|cloud_upload|live_capture|ftp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_source_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_source_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.ingest_source_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_source_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.ingest_source_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_source_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingest Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_start_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_start_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.ingest_start_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_start_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.ingest_start_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `job_number` SET TAGS ('dbx_business_glossary_term' = 'Ingest Job Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `job_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `job_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `job_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.job_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `job_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.job_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `job_status` SET TAGS ('dbx_business_glossary_term' = 'Ingest Job Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `job_status` SET TAGS ('dbx_value_regex' = 'queued|running|completed|failed|cancelled|paused');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `job_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `job_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.job_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `job_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.job_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `job_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.legal_hold_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.legal_hold_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Ingest Job Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `priority_level` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `priority_level` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.priority_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `priority_level` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.priority_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `priority_level` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `resolution` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `resolution` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `resolution` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `retention_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `retention_policy_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `retention_policy_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.retention_policy_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `retention_policy_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.retention_policy_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `retention_policy_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_format` SET TAGS ('dbx_business_glossary_term' = 'Source Media Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.source_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.source_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_location` SET TAGS ('dbx_business_glossary_term' = 'Source Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_location` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_location` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.source_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_location` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.source_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `target_format` SET TAGS ('dbx_business_glossary_term' = 'Target Media Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `target_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `target_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.target_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `target_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.target_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `target_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `target_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Target Storage Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `target_storage_location` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `target_storage_location` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.target_storage_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `target_storage_location` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.target_storage_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `timecode_start` SET TAGS ('dbx_business_glossary_term' = 'Timecode Start');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `timecode_start` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `timecode_start` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.timecode_start');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `timecode_start` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.timecode_start');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `transfer_rate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Transfer Rate (Megabits Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `transfer_rate_mbps` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `transfer_rate_mbps` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.transfer_rate_mbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `transfer_rate_mbps` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.transfer_rate_mbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` SET TAGS ('dbx_subdomain' = 'media_processing');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` SET TAGS ('dbx_fact_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.mediaasset.transcode_job');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.mediaasset.transcode_job');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` SET TAGS ('dbx_mediaasset_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` SET TAGS ('dbx_domain_ownership' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` SET TAGS ('dbx_data_type' = 'fact_transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` SET TAGS ('dbx_fact_dim_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` SET TAGS ('dbx_star_schema' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `transcode_job_id` SET TAGS ('dbx_business_glossary_term' = 'Transcode Job Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `transcode_job_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `transcode_job_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.transcode_job_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `transcode_job_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.transcode_job_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.cost_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.cost_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `employee_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `employee_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `employee_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transcoding Node ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.it_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.it_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Source Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Target Format Specification Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.target_format_specification_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.target_format_specification_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `abr_ladder_configuration` SET TAGS ('dbx_business_glossary_term' = 'ABR (Adaptive Bitrate) Ladder Configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `abr_ladder_configuration` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `abr_ladder_configuration` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.abr_ladder_configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `abr_ladder_configuration` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.abr_ladder_configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA-256|SHA-512');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.checksum_algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.checksum_algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `codec_parameters` SET TAGS ('dbx_business_glossary_term' = 'Codec Parameters');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `codec_parameters` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `codec_parameters` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.codec_parameters');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `codec_parameters` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.codec_parameters');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.cost_estimate_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.cost_estimate_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `error_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `error_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.error_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `error_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.error_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `error_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `error_message` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `error_message` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.error_message');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `error_message` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.error_message');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_number` SET TAGS ('dbx_business_glossary_term' = 'Transcode Job Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_number` SET TAGS ('dbx_value_regex' = '^TJ-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.job_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.job_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_priority` SET TAGS ('dbx_business_glossary_term' = 'Job Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low|batch');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_priority` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_priority` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.job_priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_priority` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.job_priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_status` SET TAGS ('dbx_business_glossary_term' = 'Job Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.job_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.job_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_type` SET TAGS ('dbx_business_glossary_term' = 'Job Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.job_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.job_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `migration_reason` SET TAGS ('dbx_business_glossary_term' = 'Migration Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `migration_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `migration_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.migration_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `migration_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.migration_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_checksum` SET TAGS ('dbx_business_glossary_term' = 'Output Checksum');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_checksum` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_checksum` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.output_checksum');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_checksum` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.output_checksum');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_file_size_gb` SET TAGS ('dbx_business_glossary_term' = 'Output File Size (GB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_file_size_gb` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_file_size_gb` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.output_file_size_gb');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_file_size_gb` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.output_file_size_gb');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_storage_uri` SET TAGS ('dbx_business_glossary_term' = 'Output Storage URI (Uniform Resource Identifier)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_storage_uri` SET TAGS ('dbx_validation_regex_^https?' = '//[^s]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_storage_uri` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_storage_uri` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.output_storage_uri');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_storage_uri` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.output_storage_uri');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Processing Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.processing_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.processing_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_end_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_end_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.processing_end_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_end_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.processing_end_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_start_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_start_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.processing_start_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_start_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.processing_start_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `quality_validation_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Validation Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `quality_validation_result` SET TAGS ('dbx_value_regex' = 'passed|failed|warning|not_validated');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `quality_validation_result` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `quality_validation_result` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.quality_validation_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `quality_validation_result` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.quality_validation_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `quality_validation_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Validation Score');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `quality_validation_score` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `quality_validation_score` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.quality_validation_score');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `quality_validation_score` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.quality_validation_score');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `queue_entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Queue Entry Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `queue_entry_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `queue_entry_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.queue_entry_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `queue_entry_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.queue_entry_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `retry_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `retry_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.retry_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `retry_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.retry_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Source Asset Version ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_asset_version_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_asset_version_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.source_asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_asset_version_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.source_asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_bitrate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Source Bitrate (Mbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_bitrate_mbps` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_bitrate_mbps` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.source_bitrate_mbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_bitrate_mbps` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.source_bitrate_mbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_codec` SET TAGS ('dbx_business_glossary_term' = 'Source Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_codec` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_codec` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.source_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_codec` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.source_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Source Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.source_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.source_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_file_size_gb` SET TAGS ('dbx_business_glossary_term' = 'Source File Size (GB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_file_size_gb` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_file_size_gb` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.source_file_size_gb');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_file_size_gb` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.source_file_size_gb');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_format` SET TAGS ('dbx_business_glossary_term' = 'Source Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.source_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.source_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_resolution` SET TAGS ('dbx_business_glossary_term' = 'Source Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_resolution` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_resolution` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.source_resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_resolution` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.source_resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `transcoding_engine` SET TAGS ('dbx_business_glossary_term' = 'Transcoding Engine');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `transcoding_engine` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `transcoding_engine` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.transcoding_engine');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `transcoding_engine` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.transcoding_engine');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` SET TAGS ('dbx_subdomain' = 'media_processing');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` SET TAGS ('dbx_fact_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` SET TAGS ('dbx_data_type' = 'fact_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.mediaasset.qc_inspection');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.mediaasset.qc_inspection');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` SET TAGS ('dbx_mediaasset_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` SET TAGS ('dbx_domain_ownership' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` SET TAGS ('dbx_fact_dim_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` SET TAGS ('dbx_star_schema' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Inspection ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_inspection_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_inspection_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.qc_inspection_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_inspection_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.qc_inspection_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.cost_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.cost_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Format Specification Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.format_specification_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.format_specification_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Version ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.media_asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.media_asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'QC Operator ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.primary_qc_employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.primary_qc_employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending_review|conditional_approval');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `approval_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `approval_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.approval_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `approval_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.approval_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `approval_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.approval_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.approval_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `aspect_ratio_compliance_result` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio Compliance Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `aspect_ratio_compliance_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `aspect_ratio_compliance_result` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `aspect_ratio_compliance_result` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.aspect_ratio_compliance_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `aspect_ratio_compliance_result` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.aspect_ratio_compliance_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_codec_compliance_result` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec Compliance Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_codec_compliance_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_codec_compliance_result` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_codec_compliance_result` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.audio_codec_compliance_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_codec_compliance_result` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.audio_codec_compliance_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_sync_offset_ms` SET TAGS ('dbx_business_glossary_term' = 'Audio Sync Offset (Milliseconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_sync_offset_ms` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_sync_offset_ms` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.audio_sync_offset_ms');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_sync_offset_ms` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.audio_sync_offset_ms');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_sync_result` SET TAGS ('dbx_business_glossary_term' = 'Audio Sync Check Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_sync_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_sync_result` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_sync_result` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.audio_sync_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_sync_result` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.audio_sync_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `black_frame_count` SET TAGS ('dbx_business_glossary_term' = 'Black Frame Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `black_frame_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `black_frame_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.black_frame_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `black_frame_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.black_frame_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `black_frame_detected` SET TAGS ('dbx_business_glossary_term' = 'Black Frame Detected');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `black_frame_detected` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `black_frame_detected` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.black_frame_detected');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `black_frame_detected` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.black_frame_detected');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `caption_validation_result` SET TAGS ('dbx_business_glossary_term' = 'Caption/Subtitle Validation Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `caption_validation_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `caption_validation_result` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `caption_validation_result` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.caption_validation_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `caption_validation_result` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.caption_validation_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `critical_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Defect Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `critical_defect_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `critical_defect_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.critical_defect_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `critical_defect_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.critical_defect_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `defect_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `defect_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.defect_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `defect_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.defect_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `defect_summary` SET TAGS ('dbx_business_glossary_term' = 'Defect Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `defect_summary` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `defect_summary` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.defect_summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `defect_summary` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.defect_summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `detected_aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Detected Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `detected_aspect_ratio` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `detected_aspect_ratio` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.detected_aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `detected_aspect_ratio` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.detected_aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `freeze_frame_count` SET TAGS ('dbx_business_glossary_term' = 'Freeze Frame Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `freeze_frame_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `freeze_frame_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.freeze_frame_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `freeze_frame_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.freeze_frame_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `freeze_frame_detected` SET TAGS ('dbx_business_glossary_term' = 'Freeze Frame Detected');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `freeze_frame_detected` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `freeze_frame_detected` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.freeze_frame_detected');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `freeze_frame_detected` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.freeze_frame_detected');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `hdr_format` SET TAGS ('dbx_business_glossary_term' = 'HDR Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `hdr_format` SET TAGS ('dbx_value_regex' = 'HDR10|HDR10+|Dolby Vision|HLG|SDR|unknown');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `hdr_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `hdr_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.hdr_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `hdr_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.hdr_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `hdr_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `hdr_metadata_validation_result` SET TAGS ('dbx_business_glossary_term' = 'HDR Metadata Validation Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `hdr_metadata_validation_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable|not_tested');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `hdr_metadata_validation_result` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `hdr_metadata_validation_result` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.hdr_metadata_validation_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `hdr_metadata_validation_result` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.hdr_metadata_validation_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.inspection_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.inspection_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'QC Inspection Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_value_regex' = '^QC-[0-9]{8}-[0-9]{6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.inspection_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.inspection_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed|cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.inspection_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.inspection_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.inspection_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.inspection_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `loudness_compliance_result` SET TAGS ('dbx_business_glossary_term' = 'Loudness Compliance Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `loudness_compliance_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `loudness_compliance_result` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `loudness_compliance_result` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.loudness_compliance_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `loudness_compliance_result` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.loudness_compliance_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `loudness_lufs` SET TAGS ('dbx_business_glossary_term' = 'Loudness Level (LUFS)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `loudness_lufs` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `loudness_lufs` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.loudness_lufs');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `loudness_lufs` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.loudness_lufs');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'QC Inspection Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `overall_result` SET TAGS ('dbx_business_glossary_term' = 'Overall QC Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `overall_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|review_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `overall_result` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `overall_result` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.overall_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `overall_result` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.overall_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_tool_name` SET TAGS ('dbx_business_glossary_term' = 'QC Tool Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_tool_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_tool_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_tool_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.qc_tool_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_tool_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.qc_tool_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_type` SET TAGS ('dbx_business_glossary_term' = 'QC Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_type` SET TAGS ('dbx_value_regex' = 'automated|manual|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.qc_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.qc_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.rejection_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.rejection_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `video_codec_compliance_result` SET TAGS ('dbx_business_glossary_term' = 'Video Codec Compliance Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `video_codec_compliance_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `video_codec_compliance_result` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `video_codec_compliance_result` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.video_codec_compliance_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `video_codec_compliance_result` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.video_codec_compliance_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` SET TAGS ('dbx_subdomain' = 'storage_archival');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` SET TAGS ('dbx_star_schema_role' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` SET TAGS ('dbx_data_type' = 'dimension_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.mediaasset.storage_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.mediaasset.storage_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` SET TAGS ('dbx_mediaasset_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` SET TAGS ('dbx_domain_ownership' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.storage_location_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.storage_location_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `access_protocol` SET TAGS ('dbx_business_glossary_term' = 'Storage Access Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `access_protocol` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `access_protocol` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.access_protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `access_protocol` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.access_protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `available_capacity_tb` SET TAGS ('dbx_business_glossary_term' = 'Available Storage Capacity in Terabytes (TB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `available_capacity_tb` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `available_capacity_tb` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.available_capacity_tb');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `available_capacity_tb` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.available_capacity_tb');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA-1|SHA-256|SHA-512|CRC32');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.checksum_algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.checksum_algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `checksum_validation_enabled` SET TAGS ('dbx_business_glossary_term' = 'Checksum Validation Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `checksum_validation_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `checksum_validation_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.checksum_validation_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `checksum_validation_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.checksum_validation_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Contact Email');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_validation_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.contact_email');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.contact_email');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `cost_per_tb_per_month` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Terabyte (TB) Per Month');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `cost_per_tb_per_month` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `cost_per_tb_per_month` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `cost_per_tb_per_month` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.cost_per_tb_per_month');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `cost_per_tb_per_month` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.cost_per_tb_per_month');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|AUD|CAD');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `data_center_name` SET TAGS ('dbx_business_glossary_term' = 'Data Center Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `data_center_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `data_center_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `data_center_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.data_center_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `data_center_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.data_center_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `decommission_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `decommission_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.decommission_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `decommission_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.decommission_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.encryption_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.encryption_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `encryption_method` SET TAGS ('dbx_business_glossary_term' = 'Encryption Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `encryption_method` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `encryption_method` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.encryption_method');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `encryption_method` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.encryption_method');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `encryption_method` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `geographic_region` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `geographic_region` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.geographic_region');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `geographic_region` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.geographic_region');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `last_capacity_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Capacity Check Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `last_capacity_check_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `last_capacity_check_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.last_capacity_check_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `last_capacity_check_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.last_capacity_check_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `legal_hold_capable` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Capable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `legal_hold_capable` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `legal_hold_capable` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.legal_hold_capable');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `legal_hold_capable` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.legal_hold_capable');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.location_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.location_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.location_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.location_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `mount_point` SET TAGS ('dbx_business_glossary_term' = 'Storage Mount Point or Path');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `mount_point` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `mount_point` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.mount_point');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `mount_point` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.mount_point');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Maintenance|Decommissioned|Provisioning');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.operational_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.operational_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_business_glossary_term' = 'Provisioned Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.provisioned_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.provisioned_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `replication_enabled` SET TAGS ('dbx_business_glossary_term' = 'Replication Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `replication_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `replication_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.replication_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `replication_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.replication_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `restore_time_objective_hours` SET TAGS ('dbx_business_glossary_term' = 'Restore Time Objective (RTO) in Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `restore_time_objective_hours` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `restore_time_objective_hours` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.restore_time_objective_hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `restore_time_objective_hours` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.restore_time_objective_hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `retention_policy_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `retention_policy_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `retention_policy_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.retention_policy_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `retention_policy_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.retention_policy_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'Platinum|Gold|Silver|Bronze');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `sla_tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `sla_tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.sla_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `sla_tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.sla_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `sla_tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_tier` SET TAGS ('dbx_business_glossary_term' = 'Storage Tier Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_tier` SET TAGS ('dbx_value_regex' = 'Hot|Warm|Cold|Deep_Archive');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.storage_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.storage_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_type` SET TAGS ('dbx_value_regex' = 'SAN|NAS|LTO_Tape|Cloud_Object_Storage|CDN_Origin|Deep_Archive');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.storage_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.storage_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_vendor` SET TAGS ('dbx_business_glossary_term' = 'Storage Vendor');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_vendor` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_vendor` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.storage_vendor');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_vendor` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.storage_vendor');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `total_capacity_tb` SET TAGS ('dbx_business_glossary_term' = 'Total Storage Capacity in Terabytes (TB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `total_capacity_tb` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `total_capacity_tb` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.total_capacity_tb');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `total_capacity_tb` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.total_capacity_tb');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `used_capacity_tb` SET TAGS ('dbx_business_glossary_term' = 'Used Storage Capacity in Terabytes (TB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `used_capacity_tb` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `used_capacity_tb` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_location.used_capacity_tb');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `used_capacity_tb` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_location.used_capacity_tb');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` SET TAGS ('dbx_subdomain' = 'storage_archival');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` SET TAGS ('dbx_fact_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` SET TAGS ('dbx_data_type' = 'bridge_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.mediaasset.asset_storage_assignment');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` SET TAGS ('dbx_mediaasset_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` SET TAGS ('dbx_domain_ownership' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` SET TAGS ('dbx_fact_dim_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` SET TAGS ('dbx_star_schema' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_storage_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Storage Assignment ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_storage_assignment_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_storage_assignment_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.asset_storage_assignment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_storage_assignment_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.asset_storage_assignment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Case ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.legal_hold_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.legal_hold_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.retention_policy_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.retention_policy_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.storage_location_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.storage_location_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `access_frequency` SET TAGS ('dbx_business_glossary_term' = 'Access Frequency Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `access_frequency` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `access_frequency` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.access_frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `access_frequency` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.access_frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.assignment_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.assignment_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_end_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_end_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.assignment_end_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_end_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.assignment_end_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.assignment_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.assignment_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_start_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_start_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.assignment_start_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_start_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.assignment_start_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|migrated|purged|archived|failed|pending');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.assignment_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.assignment_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA-1|SHA-256|SHA-512|CRC32');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.checksum_algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.checksum_algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `checksum_value` SET TAGS ('dbx_business_glossary_term' = 'Checksum Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `checksum_value` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `checksum_value` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.checksum_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `checksum_value` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.checksum_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Path or Uniform Resource Identifier (URI)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `file_path` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `file_path` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.file_path');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `file_path` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.file_path');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.file_size_bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.file_size_bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `geographic_region` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `geographic_region` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.geographic_region');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `geographic_region` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.geographic_region');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `last_access_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Access Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `last_access_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `last_access_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.last_access_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `last_access_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.last_access_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.legal_hold_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.legal_hold_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `migration_trigger` SET TAGS ('dbx_business_glossary_term' = 'Migration Trigger');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `migration_trigger` SET TAGS ('dbx_value_regex' = 'tiering_policy|legal_hold|cost_optimization|format_migration|capacity_rebalance|manual_request');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `migration_trigger` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `migration_trigger` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.migration_trigger');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `migration_trigger` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.migration_trigger');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `replication_count` SET TAGS ('dbx_business_glossary_term' = 'Replication Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `replication_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `replication_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.replication_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `replication_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.replication_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_cost_per_gb` SET TAGS ('dbx_business_glossary_term' = 'Storage Cost Per Gigabyte (GB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_cost_per_gb` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_cost_per_gb` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_cost_per_gb` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.storage_cost_per_gb');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_cost_per_gb` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.storage_cost_per_gb');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_tier` SET TAGS ('dbx_business_glossary_term' = 'Storage Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_tier` SET TAGS ('dbx_value_regex' = 'hot|warm|cold|archive|nearline|offline');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.storage_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.storage_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|failed|not_verified');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `verification_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `verification_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.verification_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `verification_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.verification_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `verification_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.verification_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.verification_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` SET TAGS ('dbx_subdomain' = 'storage_archival');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` SET TAGS ('dbx_star_schema_role' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` SET TAGS ('dbx_data_type' = 'dimension_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.mediaasset.retention_policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.mediaasset.retention_policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` SET TAGS ('dbx_mediaasset_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` SET TAGS ('dbx_domain_ownership' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.retention_policy_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.retention_policy_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `supersedes_policy_retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Retention Policy ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `supersedes_policy_retention_policy_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `supersedes_policy_retention_policy_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.supersedes_policy_retention_policy_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `supersedes_policy_retention_policy_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.supersedes_policy_retention_policy_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `applies_to_legal_hold` SET TAGS ('dbx_business_glossary_term' = 'Applies to Legal Hold Assets');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `applies_to_legal_hold` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `applies_to_legal_hold` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.applies_to_legal_hold');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `applies_to_legal_hold` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.applies_to_legal_hold');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `applies_to_syndication_content` SET TAGS ('dbx_business_glossary_term' = 'Applies to Syndication Content');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `applies_to_syndication_content` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `applies_to_syndication_content` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.applies_to_syndication_content');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `applies_to_syndication_content` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.applies_to_syndication_content');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `asset_class_scope` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `asset_class_scope` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `asset_class_scope` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.asset_class_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `asset_class_scope` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.asset_class_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.audit_trail_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.audit_trail_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `checksum_verification_required` SET TAGS ('dbx_business_glossary_term' = 'Checksum Verification Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `checksum_verification_required` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `checksum_verification_required` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.checksum_verification_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `checksum_verification_required` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.checksum_verification_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.effective_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.effective_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `expiry_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `expiry_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `expiry_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `format_migration_allowed` SET TAGS ('dbx_business_glossary_term' = 'Format Migration Allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `format_migration_allowed` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `format_migration_allowed` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.format_migration_allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `format_migration_allowed` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.format_migration_allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.geographic_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.geographic_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.last_modified_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.last_modified_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `maximum_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retention Period (Days)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `maximum_retention_period_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `maximum_retention_period_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.maximum_retention_period_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `maximum_retention_period_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.maximum_retention_period_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `minimum_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Retention Period (Days)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `minimum_retention_period_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `minimum_retention_period_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.minimum_retention_period_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `minimum_retention_period_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.minimum_retention_period_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `notification_recipients` SET TAGS ('dbx_business_glossary_term' = 'Notification Recipients');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `notification_recipients` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `notification_recipients` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `notification_recipients` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.notification_recipients');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `notification_recipients` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.notification_recipients');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.policy_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.policy_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.policy_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.policy_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.policy_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.policy_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_owner` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_owner` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_owner` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.policy_owner');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_owner` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.policy_owner');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|retired|under_review');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.policy_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.policy_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `post_retention_action` SET TAGS ('dbx_business_glossary_term' = 'Post-Retention Action');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `post_retention_action` SET TAGS ('dbx_value_regex' = 'purge|migrate_to_deep_archive|notify_rights_owner|manual_review|transfer_to_external_archive');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `post_retention_action` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `post_retention_action` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.post_retention_action');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `post_retention_action` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.post_retention_action');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Policy Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `priority_level` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `priority_level` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.priority_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `priority_level` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.priority_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `priority_level` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.regulatory_basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.regulatory_basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `retention_trigger` SET TAGS ('dbx_business_glossary_term' = 'Retention Trigger Event');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `retention_trigger` SET TAGS ('dbx_value_regex' = 'ingest_date|broadcast_date|contract_expiry|legal_hold|last_access_date|rights_expiry');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `retention_trigger` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `retention_trigger` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.retention_trigger');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `retention_trigger` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.retention_trigger');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `storage_tier_target` SET TAGS ('dbx_business_glossary_term' = 'Storage Tier Target');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `storage_tier_target` SET TAGS ('dbx_value_regex' = 'hot|warm|cold|deep_archive|glacier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `storage_tier_target` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `storage_tier_target` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.storage_tier_target');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `storage_tier_target` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.storage_tier_target');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.version_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.version_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `created_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `created_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.retention_policy.created_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `created_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.retention_policy.created_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` SET TAGS ('dbx_subdomain' = 'media_processing');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` SET TAGS ('dbx_fact_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.mediaasset.asset_lifecycle_event');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` SET TAGS ('dbx_mediaasset_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` SET TAGS ('dbx_domain_ownership' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` SET TAGS ('dbx_data_type' = 'fact_transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` SET TAGS ('dbx_fact_dim_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` SET TAGS ('dbx_star_schema' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `asset_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Lifecycle Event ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `asset_lifecycle_event_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `asset_lifecycle_event_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.asset_lifecycle_event_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `asset_lifecycle_event_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.asset_lifecycle_event_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.cost_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.cost_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Case ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.legal_hold_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.legal_hold_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.retention_policy_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.retention_policy_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `tech_change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Workflow Instance ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `tech_change_request_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `tech_change_request_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.tech_change_request_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `tech_change_request_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.tech_change_request_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `approval_authority` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `approval_authority` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `approval_authority` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.approval_authority');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `approval_authority` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.approval_authority');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.audit_trail_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.audit_trail_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `checksum_after` SET TAGS ('dbx_business_glossary_term' = 'Checksum After Event');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `checksum_after` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `checksum_after` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.checksum_after');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `checksum_after` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.checksum_after');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `checksum_before` SET TAGS ('dbx_business_glossary_term' = 'Checksum Before Event');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `checksum_before` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `checksum_before` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.checksum_before');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `checksum_before` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.checksum_before');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.compliance_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.compliance_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Media Duration in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `error_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `error_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.error_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `error_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.error_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `error_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `error_message` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `error_message` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.error_message');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `error_message` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.error_message');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_duration_milliseconds` SET TAGS ('dbx_business_glossary_term' = 'Event Processing Duration in Milliseconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_duration_milliseconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_duration_milliseconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.event_duration_milliseconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_duration_milliseconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.event_duration_milliseconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_reason` SET TAGS ('dbx_business_glossary_term' = 'Event Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.event_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.event_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.event_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.event_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Event Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.event_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.event_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.file_size_bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.file_size_bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `metadata_version` SET TAGS ('dbx_business_glossary_term' = 'Metadata Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `metadata_version` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `metadata_version` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.metadata_version');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `metadata_version` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.metadata_version');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `new_state` SET TAGS ('dbx_business_glossary_term' = 'New Asset State');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `new_state` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `new_state` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.new_state');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `new_state` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.new_state');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `operator_identity` SET TAGS ('dbx_business_glossary_term' = 'Operator Identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `operator_identity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `operator_identity` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `operator_identity` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.operator_identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `operator_identity` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.operator_identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `operator_type` SET TAGS ('dbx_business_glossary_term' = 'Operator Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `operator_type` SET TAGS ('dbx_value_regex' = 'human|automated_workflow|scheduled_job|api_integration|system_process');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `operator_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `operator_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.operator_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `operator_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.operator_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `operator_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `previous_state` SET TAGS ('dbx_business_glossary_term' = 'Previous Asset State');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `previous_state` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `previous_state` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.previous_state');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `previous_state` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.previous_state');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `qc_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Defect Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `qc_defect_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `qc_defect_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.qc_defect_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `qc_defect_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.qc_defect_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `qc_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Score');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `qc_score` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `qc_score` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.qc_score');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `qc_score` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.qc_score');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|restricted|expired|unknown');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.rights_clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.rights_clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `source_format` SET TAGS ('dbx_business_glossary_term' = 'Source Media Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `source_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `source_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.source_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `source_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.source_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `source_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `source_storage_tier` SET TAGS ('dbx_business_glossary_term' = 'Source Storage Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `source_storage_tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `source_storage_tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.source_storage_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `source_storage_tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.source_storage_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `source_storage_tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `target_format` SET TAGS ('dbx_business_glossary_term' = 'Target Media Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `target_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `target_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.target_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `target_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.target_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `target_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `target_storage_tier` SET TAGS ('dbx_business_glossary_term' = 'Target Storage Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `target_storage_tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `target_storage_tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.target_storage_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `target_storage_tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.target_storage_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `target_storage_tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_lifecycle_event.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_lifecycle_event.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` SET TAGS ('dbx_subdomain' = 'rights_compliance');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` SET TAGS ('dbx_data_type' = 'fact_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.mediaasset.legal_hold');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.mediaasset.legal_hold');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` SET TAGS ('dbx_mediaasset_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` SET TAGS ('dbx_domain_ownership' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` SET TAGS ('dbx_fact_dim_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` SET TAGS ('dbx_star_schema' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.legal_hold_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.legal_hold_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.subject_talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.subject_talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `acknowledgment_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Deadline Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `acknowledgment_deadline_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `acknowledgment_deadline_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.acknowledgment_deadline_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `acknowledgment_deadline_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.acknowledgment_deadline_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `acknowledgment_required` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `acknowledgment_required` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `acknowledgment_required` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.acknowledgment_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `acknowledgment_required` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.acknowledgment_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `asset_count` SET TAGS ('dbx_business_glossary_term' = 'Asset Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `asset_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `asset_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.asset_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `asset_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.asset_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.audit_trail_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.audit_trail_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `case_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `case_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `case_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.case_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `case_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.case_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_email` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Custodian Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_email` SET TAGS ('dbx_validation_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_email` SET TAGS ('dbx_}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_email` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_email` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.custodian_email');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_email` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.custodian_email');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Custodian Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.custodian_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.custodian_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_phone` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Custodian Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_phone` SET TAGS ('dbx_validation_regex' = '^+?[1-9]d{1');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_phone` SET TAGS ('dbx_14}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_phone` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_phone` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.custodian_phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `custodian_phone` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.custodian_phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `external_counsel_contact` SET TAGS ('dbx_business_glossary_term' = 'External Counsel Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `external_counsel_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `external_counsel_contact` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `external_counsel_contact` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `external_counsel_contact` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.external_counsel_contact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `external_counsel_contact` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.external_counsel_contact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `external_counsel_firm` SET TAGS ('dbx_business_glossary_term' = 'External Counsel Firm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `external_counsel_firm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `external_counsel_firm` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `external_counsel_firm` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.external_counsel_firm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `external_counsel_firm` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.external_counsel_firm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_end_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.hold_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.hold_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_priority` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_priority` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_priority` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.hold_priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_priority` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.hold_priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.hold_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.hold_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_reference_number` SET TAGS ('dbx_value_regex' = '^LH-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_reference_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_reference_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.hold_reference_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_reference_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.hold_reference_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_start_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.hold_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.hold_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|released|expired|suspended|pending_review');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.hold_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.hold_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'litigation|regulatory_investigation|rights_dispute|fcc_inquiry|internal_investigation|audit');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.hold_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.hold_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_value_regex' = 'legal_department|court_order|fcc|regulatory_body|external_counsel|internal_audit');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.issuing_authority');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.issuing_authority');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.issuing_authority_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.issuing_authority_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.last_modified_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.last_modified_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `mam_system_lock_enabled` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Management (MAM) System Lock Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `mam_system_lock_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `mam_system_lock_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.mam_system_lock_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `mam_system_lock_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.mam_system_lock_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.notification_sent_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.notification_sent_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `release_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Release Authorization Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `release_authorization_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `release_authorization_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.release_authorization_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `release_authorization_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.release_authorization_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `release_authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Release Authorized By');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `release_authorized_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `release_authorized_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `release_authorized_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.release_authorized_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `release_authorized_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.release_authorized_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `retention_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Retention Override Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `retention_override_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `retention_override_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.retention_override_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `retention_override_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.retention_override_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Scope Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `scope_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `scope_description` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `scope_description` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.scope_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `scope_description` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.scope_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `created_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `created_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.legal_hold.created_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ALTER COLUMN `created_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.legal_hold.created_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` SET TAGS ('dbx_subdomain' = 'asset_catalog');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` SET TAGS ('dbx_star_schema_role' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` SET TAGS ('dbx_data_type' = 'dimension_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.mediaasset.format_specification');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.mediaasset.format_specification');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` SET TAGS ('dbx_mediaasset_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` SET TAGS ('dbx_domain_ownership' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Format Specification ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.format_specification_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.format_specification_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.approval_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.approval_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `approved_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `approved_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.approved_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `approved_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.approved_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `audio_bit_depth` SET TAGS ('dbx_business_glossary_term' = 'Audio Bit Depth');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `audio_bit_depth` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `audio_bit_depth` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.audio_bit_depth');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `audio_bit_depth` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.audio_bit_depth');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `audio_channel_configuration` SET TAGS ('dbx_business_glossary_term' = 'Audio Channel Configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `audio_channel_configuration` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `audio_channel_configuration` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.audio_channel_configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `audio_channel_configuration` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.audio_channel_configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `audio_codec` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `audio_codec` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.audio_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `audio_codec` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.audio_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `audio_codec` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `audio_sample_rate_khz` SET TAGS ('dbx_business_glossary_term' = 'Audio Sample Rate (kHz)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `audio_sample_rate_khz` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `audio_sample_rate_khz` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.audio_sample_rate_khz');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `audio_sample_rate_khz` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.audio_sample_rate_khz');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `bit_rate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Bit Rate (Mbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `bit_rate_mbps` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `bit_rate_mbps` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.bit_rate_mbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `bit_rate_mbps` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.bit_rate_mbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `bit_rate_mode` SET TAGS ('dbx_business_glossary_term' = 'Bit Rate Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `bit_rate_mode` SET TAGS ('dbx_value_regex' = 'CBR|VBR|ABR');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `bit_rate_mode` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `bit_rate_mode` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.bit_rate_mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `bit_rate_mode` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.bit_rate_mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA1|SHA256|SHA512|xxHash');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.checksum_algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.checksum_algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `color_space` SET TAGS ('dbx_business_glossary_term' = 'Color Space');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `color_space` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `color_space` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.color_space');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `color_space` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.color_space');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `color_space` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `container_format` SET TAGS ('dbx_business_glossary_term' = 'Container Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `container_format` SET TAGS ('dbx_value_regex' = 'MXF|MP4|MOV|TS|AVI|MKV');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `container_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `container_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.container_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `container_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.container_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `container_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `drm_compatibility` SET TAGS ('dbx_business_glossary_term' = 'DRM (Digital Rights Management) Compatibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `drm_compatibility` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `drm_compatibility` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.drm_compatibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `drm_compatibility` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.drm_compatibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.effective_from_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.effective_from_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.effective_until_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.effective_until_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `file_extension` SET TAGS ('dbx_business_glossary_term' = 'File Extension');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `file_extension` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `file_extension` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.file_extension');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `file_extension` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.file_extension');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `format_category` SET TAGS ('dbx_business_glossary_term' = 'Format Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `format_category` SET TAGS ('dbx_value_regex' = 'ingest|mezzanine|proxy|playout|ott_delivery|archive');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `format_category` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `format_category` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.format_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `format_category` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.format_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `format_category` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `format_code` SET TAGS ('dbx_business_glossary_term' = 'Format Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `format_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `format_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.format_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `format_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.format_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `format_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `format_name` SET TAGS ('dbx_business_glossary_term' = 'Format Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `format_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `format_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `format_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.format_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `format_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.format_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `frame_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `frame_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.frame_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `frame_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.frame_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `governing_standard` SET TAGS ('dbx_business_glossary_term' = 'Governing Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `governing_standard` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `governing_standard` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.governing_standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `governing_standard` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.governing_standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `hdr_standard` SET TAGS ('dbx_business_glossary_term' = 'HDR (High Dynamic Range) Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `hdr_standard` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `hdr_standard` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.hdr_standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `hdr_standard` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.hdr_standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `horizontal_resolution` SET TAGS ('dbx_business_glossary_term' = 'Horizontal Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `horizontal_resolution` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `horizontal_resolution` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.horizontal_resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `horizontal_resolution` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.horizontal_resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|retired|draft|under_review|approved');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.lifecycle_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.lifecycle_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `loudness_standard` SET TAGS ('dbx_business_glossary_term' = 'Loudness Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `loudness_standard` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `loudness_standard` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.loudness_standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `loudness_standard` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.loudness_standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `mime_type` SET TAGS ('dbx_business_glossary_term' = 'MIME Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `mime_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `mime_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.mime_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `mime_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.mime_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `mime_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `qc_profile` SET TAGS ('dbx_business_glossary_term' = 'QC (Quality Control) Profile');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `qc_profile` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `qc_profile` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.qc_profile');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `qc_profile` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.qc_profile');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `resolution_class` SET TAGS ('dbx_business_glossary_term' = 'Resolution Class');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `resolution_class` SET TAGS ('dbx_value_regex' = 'SD|HD|FHD|UHD|4K|8K');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `resolution_class` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `resolution_class` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.resolution_class');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `resolution_class` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.resolution_class');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Years)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.retention_period_years');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.retention_period_years');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `scan_type` SET TAGS ('dbx_business_glossary_term' = 'Scan Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `scan_type` SET TAGS ('dbx_value_regex' = 'progressive|interlaced');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `scan_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `scan_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.scan_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `scan_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.scan_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `scan_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `storage_tier` SET TAGS ('dbx_business_glossary_term' = 'Storage Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `storage_tier` SET TAGS ('dbx_value_regex' = 'hot|warm|cold|archive|glacier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `storage_tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `storage_tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.storage_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `storage_tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.storage_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `storage_tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.streaming_protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.streaming_protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `subtitle_format` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `subtitle_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `subtitle_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.subtitle_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `subtitle_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.subtitle_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `subtitle_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `target_loudness_lufs` SET TAGS ('dbx_business_glossary_term' = 'Target Loudness (LUFS)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `target_loudness_lufs` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `target_loudness_lufs` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.target_loudness_lufs');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `target_loudness_lufs` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.target_loudness_lufs');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `transcode_priority` SET TAGS ('dbx_business_glossary_term' = 'Transcode Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `transcode_priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low|batch');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `transcode_priority` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `transcode_priority` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.transcode_priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `transcode_priority` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.transcode_priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `vertical_resolution` SET TAGS ('dbx_business_glossary_term' = 'Vertical Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `vertical_resolution` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `vertical_resolution` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.vertical_resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `vertical_resolution` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.vertical_resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `video_codec` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `video_codec` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_specification.video_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `video_codec` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_specification.video_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ALTER COLUMN `video_codec` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` SET TAGS ('dbx_subdomain' = 'asset_catalog');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` SET TAGS ('dbx_data_type' = 'dimension_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.mediaasset.asset_collection');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.mediaasset.asset_collection');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` SET TAGS ('dbx_mediaasset_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` SET TAGS ('dbx_domain_ownership' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `asset_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Collection Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `asset_collection_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `asset_collection_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.asset_collection_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `asset_collection_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.asset_collection_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.cost_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.cost_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.profit_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.profit_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.retention_policy_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.retention_policy_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `archive_tier` SET TAGS ('dbx_business_glossary_term' = 'Archive Storage Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `archive_tier` SET TAGS ('dbx_value_regex' = 'hot|warm|cold|glacier|deep-archive');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `archive_tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `archive_tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.archive_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `archive_tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.archive_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `archive_tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `asset_collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `asset_collection_status` SET TAGS ('dbx_value_regex' = 'draft|active|archived|deprecated|under-review|locked');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `asset_collection_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `asset_collection_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.asset_collection_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `asset_collection_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.asset_collection_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `asset_collection_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.audio_description_available_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.audio_description_available_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `bulk_operation_enabled` SET TAGS ('dbx_business_glossary_term' = 'Bulk Operation Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `bulk_operation_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `bulk_operation_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.bulk_operation_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `bulk_operation_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.bulk_operation_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA-1|SHA-256|SHA-512|xxHash');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.checksum_algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.checksum_algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `checksum_value` SET TAGS ('dbx_business_glossary_term' = 'Checksum Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `checksum_value` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `checksum_value` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.checksum_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `checksum_value` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.checksum_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.closed_caption_available_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.closed_caption_available_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `collection_code` SET TAGS ('dbx_business_glossary_term' = 'Collection Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `collection_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `collection_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.collection_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `collection_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.collection_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `collection_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `collection_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `collection_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `collection_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `collection_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.collection_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `collection_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.collection_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `collection_type` SET TAGS ('dbx_business_glossary_term' = 'Collection Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `collection_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `collection_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.collection_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `collection_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.collection_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `collection_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `content_rating` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `content_rating` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.content_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `content_rating` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.content_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `content_rating` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `created_by_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `created_by_user` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `created_by_user` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.created_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `created_by_user` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.created_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `curator_name` SET TAGS ('dbx_business_glossary_term' = 'Curator Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `curator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `curator_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `curator_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `curator_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.curator_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `curator_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.curator_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `asset_collection_description` SET TAGS ('dbx_business_glossary_term' = 'Collection Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `asset_collection_description` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `asset_collection_description` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.asset_collection_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `asset_collection_description` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.asset_collection_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `distribution_window_end` SET TAGS ('dbx_business_glossary_term' = 'Distribution Window End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `distribution_window_end` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `distribution_window_end` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.distribution_window_end');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `distribution_window_end` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.distribution_window_end');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `distribution_window_start` SET TAGS ('dbx_business_glossary_term' = 'Distribution Window Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `distribution_window_start` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `distribution_window_start` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.distribution_window_start');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `distribution_window_start` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.distribution_window_start');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_validation_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.eidr_identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.eidr_identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `language_code` SET TAGS ('dbx_validation_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `language_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `language_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.language_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `language_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.language_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `language_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.last_modified_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.last_modified_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.legal_hold_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.legal_hold_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `metadata_completeness_score` SET TAGS ('dbx_business_glossary_term' = 'Metadata Completeness Score');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `metadata_completeness_score` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `metadata_completeness_score` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.metadata_completeness_score');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `metadata_completeness_score` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.metadata_completeness_score');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Collection Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `owner_department` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `owner_department` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.owner_department');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `owner_department` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.owner_department');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `packaging_format` SET TAGS ('dbx_business_glossary_term' = 'Packaging Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `packaging_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `packaging_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.packaging_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `packaging_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.packaging_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `packaging_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `primary_genre` SET TAGS ('dbx_business_glossary_term' = 'Primary Genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `primary_genre` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `primary_genre` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.primary_genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `primary_genre` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.primary_genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `qc_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `qc_status` SET TAGS ('dbx_value_regex' = 'not-started|in-progress|passed|failed|waived');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `qc_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `qc_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.qc_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `qc_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.qc_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `qc_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|restricted|expired|not-required');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.rights_clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.rights_clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `syndication_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Syndication Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `syndication_eligible_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `syndication_eligible_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.syndication_eligible_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `syndication_eligible_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.syndication_eligible_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `target_audience` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `target_audience` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.target_audience');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `target_audience` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.target_audience');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `territory_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `territory_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.territory_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `territory_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.territory_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `territory_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `total_asset_count` SET TAGS ('dbx_business_glossary_term' = 'Total Asset Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `total_asset_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `total_asset_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.total_asset_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `total_asset_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.total_asset_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `total_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Duration in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `total_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `total_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.total_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `total_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.total_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `total_storage_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Total Storage Size in Bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `total_storage_size_bytes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `total_storage_size_bytes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.total_storage_size_bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `total_storage_size_bytes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.total_storage_size_bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Creation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `creation_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `creation_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_collection.creation_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ALTER COLUMN `creation_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_collection.creation_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` SET TAGS ('dbx_subdomain' = 'storage_archival');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` SET TAGS ('dbx_fact_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` SET TAGS ('dbx_data_type' = 'fact_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.mediaasset.archive_record');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.mediaasset.archive_record');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` SET TAGS ('dbx_mediaasset_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` SET TAGS ('dbx_domain_ownership' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` SET TAGS ('dbx_fact_dim_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` SET TAGS ('dbx_star_schema' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_record_id` SET TAGS ('dbx_business_glossary_term' = 'Archive Record Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.archive_record_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.archive_record_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.cost_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.cost_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `partner_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `partner_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.custodian_partner_partner_partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `partner_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.custodian_partner_partner_partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Archive Operator ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_cost_per_gb` SET TAGS ('dbx_business_glossary_term' = 'Archive Cost Per Gigabyte (GB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_cost_per_gb` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_cost_per_gb` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_cost_per_gb` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.archive_cost_per_gb');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_cost_per_gb` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.archive_cost_per_gb');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.archive_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.archive_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_destination_identifier` SET TAGS ('dbx_business_glossary_term' = 'Archive Destination Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_destination_identifier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_destination_identifier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.archive_destination_identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_destination_identifier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.archive_destination_identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_destination_type` SET TAGS ('dbx_business_glossary_term' = 'Archive Destination Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_destination_type` SET TAGS ('dbx_value_regex' = 'lto_tape|cloud_deep_archive|offsite_facility|nearline_storage|optical_media|hybrid_archive');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_destination_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_destination_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.archive_destination_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_destination_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.archive_destination_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_destination_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Archive File Size in Bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_file_size_bytes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_file_size_bytes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.archive_file_size_bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_file_size_bytes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.archive_file_size_bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_format` SET TAGS ('dbx_business_glossary_term' = 'Archive Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.archive_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.archive_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_job_reference` SET TAGS ('dbx_business_glossary_term' = 'Archive Job Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_job_reference` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_job_reference` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.archive_job_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_job_reference` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.archive_job_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_notes` SET TAGS ('dbx_business_glossary_term' = 'Archive Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.archive_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.archive_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_status` SET TAGS ('dbx_business_glossary_term' = 'Archive Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.archive_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.archive_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_system_name` SET TAGS ('dbx_business_glossary_term' = 'Archive System Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_system_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_system_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_system_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.archive_system_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_system_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.archive_system_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archive Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.archive_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.archive_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'md5|sha256|sha512|xxhash');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.checksum_algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.checksum_algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `checksum_value` SET TAGS ('dbx_business_glossary_term' = 'Checksum Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `checksum_value` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `checksum_value` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.checksum_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `checksum_value` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.checksum_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `cloud_vault_identifier` SET TAGS ('dbx_business_glossary_term' = 'Cloud Vault Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `cloud_vault_identifier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `cloud_vault_identifier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.cloud_vault_identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `cloud_vault_identifier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.cloud_vault_identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `compression_codec` SET TAGS ('dbx_business_glossary_term' = 'Compression Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `compression_codec` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `compression_codec` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.compression_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `compression_codec` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.compression_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.legal_hold_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.legal_hold_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `lto_tape_generation` SET TAGS ('dbx_business_glossary_term' = 'Linear Tape-Open (LTO) Tape Generation');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `lto_tape_generation` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `lto_tape_generation` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.lto_tape_generation');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `lto_tape_generation` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.lto_tape_generation');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `oais_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Archival Information System (OAIS) Compliance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `oais_compliance_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `oais_compliance_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.oais_compliance_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `oais_compliance_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.oais_compliance_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `offsite_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Off-Site Facility Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `offsite_facility_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `offsite_facility_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.offsite_facility_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `offsite_facility_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.offsite_facility_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `offsite_facility_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `purge_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Purge Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `purge_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `purge_approval_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `purge_approval_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.purge_approval_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `purge_approval_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.purge_approval_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `purge_approval_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `purge_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Purge Scheduled Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `purge_scheduled_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `purge_scheduled_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.purge_scheduled_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `purge_scheduled_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.purge_scheduled_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Restore Completion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_completion_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_completion_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.restore_completion_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_completion_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.restore_completion_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_request_date` SET TAGS ('dbx_business_glossary_term' = 'Restore Request Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_request_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_request_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.restore_request_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_request_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.restore_request_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Restore Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_sla_tier` SET TAGS ('dbx_value_regex' = 'expedited|standard|bulk|emergency');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_sla_tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_sla_tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.restore_sla_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_sla_tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.restore_sla_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_sla_tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_test_date` SET TAGS ('dbx_business_glossary_term' = 'Restore Test Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_test_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_test_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.restore_test_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_test_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.restore_test_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_test_result` SET TAGS ('dbx_business_glossary_term' = 'Restore Test Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_test_result` SET TAGS ('dbx_value_regex' = 'passed|failed|partial|not_tested');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_test_result` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_test_result` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.restore_test_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `restore_test_result` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.restore_test_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.retention_expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.retention_expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `retention_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `retention_policy_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `retention_policy_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.retention_policy_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `retention_policy_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.retention_policy_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `retention_policy_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `storage_tier` SET TAGS ('dbx_business_glossary_term' = 'Storage Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `storage_tier` SET TAGS ('dbx_value_regex' = 'hot|warm|cold|deep_archive');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `storage_tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `storage_tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.storage_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `storage_tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.storage_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `storage_tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `tape_barcode` SET TAGS ('dbx_business_glossary_term' = 'Tape Barcode');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `tape_barcode` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `tape_barcode` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.tape_barcode');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `tape_barcode` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.tape_barcode');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` SET TAGS ('dbx_subdomain' = 'asset_catalog');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` SET TAGS ('dbx_data_type' = 'fact_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.mediaasset.format_migration');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.mediaasset.format_migration');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` SET TAGS ('dbx_mediaasset_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` SET TAGS ('dbx_domain_ownership' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` SET TAGS ('dbx_fact_dim_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` SET TAGS ('dbx_star_schema' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `format_migration_id` SET TAGS ('dbx_business_glossary_term' = 'Format Migration ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `format_migration_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `format_migration_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.format_migration_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `format_migration_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.format_migration_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.cost_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.cost_center_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `employee_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `employee_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `employee_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.retention_policy_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.retention_policy_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Source Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.source_asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.source_asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Source Format Specification Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.source_format_specification_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.source_format_specification_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `error_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `error_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.error_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `error_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.error_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `error_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `error_message` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `error_message` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.error_message');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `error_message` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.error_message');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.legal_hold_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.legal_hold_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Migration Duration Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.migration_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.migration_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Migration End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_end_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_end_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.migration_end_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_end_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.migration_end_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_engine` SET TAGS ('dbx_business_glossary_term' = 'Migration Engine');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_engine` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_engine` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.migration_engine');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_engine` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.migration_engine');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_job_number` SET TAGS ('dbx_business_glossary_term' = 'Migration Job Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_job_number` SET TAGS ('dbx_value_regex' = '^MIG-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_job_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_job_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.migration_job_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_job_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.migration_job_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_notes` SET TAGS ('dbx_business_glossary_term' = 'Migration Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.migration_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.migration_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_priority` SET TAGS ('dbx_business_glossary_term' = 'Migration Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_priority` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_priority` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.migration_priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_priority` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.migration_priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_reason` SET TAGS ('dbx_business_glossary_term' = 'Migration Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_reason` SET TAGS ('dbx_value_regex' = 'format_obsolescence|distribution_requirement|storage_optimisation|quality_enhancement|compliance_mandate|platform_compatibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.migration_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.migration_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Migration Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_start_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_start_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.migration_start_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_start_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.migration_start_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_status` SET TAGS ('dbx_business_glossary_term' = 'Migration Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_status` SET TAGS ('dbx_value_regex' = 'queued|in_progress|completed|failed|cancelled|validation_pending');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.migration_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.migration_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_type` SET TAGS ('dbx_business_glossary_term' = 'Migration Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_type` SET TAGS ('dbx_value_regex' = 'transcode|upscale|downscale|digitisation|rewrap|restoration');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.migration_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.migration_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `migration_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `operator_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `operator_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `operator_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.operator_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `operator_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.operator_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `quality_validation_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Validation Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `quality_validation_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `quality_validation_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.quality_validation_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `quality_validation_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.quality_validation_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `quality_validation_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Validation Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `quality_validation_result` SET TAGS ('dbx_value_regex' = 'passed|failed|warning|not_performed');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `quality_validation_result` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `quality_validation_result` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.quality_validation_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `quality_validation_result` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.quality_validation_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `quality_validation_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Validation Score');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `quality_validation_score` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `quality_validation_score` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.quality_validation_score');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `quality_validation_score` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.quality_validation_score');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `retry_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `retry_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.retry_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `retry_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.retry_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `source_checksum` SET TAGS ('dbx_business_glossary_term' = 'Source Checksum');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `source_checksum` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{32,128}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `source_checksum` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `source_checksum` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.source_checksum');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `source_checksum` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.source_checksum');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `source_file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Source File Size Bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `source_file_size_bytes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `source_file_size_bytes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.source_file_size_bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `source_file_size_bytes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.source_file_size_bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `storage_tier_source` SET TAGS ('dbx_business_glossary_term' = 'Storage Tier Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `storage_tier_source` SET TAGS ('dbx_value_regex' = 'online|nearline|archive|glacier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `storage_tier_source` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `storage_tier_source` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.storage_tier_source');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `storage_tier_source` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.storage_tier_source');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `storage_tier_target` SET TAGS ('dbx_business_glossary_term' = 'Storage Tier Target');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `storage_tier_target` SET TAGS ('dbx_value_regex' = 'online|nearline|archive|glacier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `storage_tier_target` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `storage_tier_target` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.storage_tier_target');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `storage_tier_target` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.storage_tier_target');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Target Bitrate Kilobits Per Second (Kbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_bitrate_kbps` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_bitrate_kbps` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.target_bitrate_kbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_bitrate_kbps` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.target_bitrate_kbps');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_checksum` SET TAGS ('dbx_business_glossary_term' = 'Target Checksum');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_checksum` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{32,128}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_checksum` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_checksum` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.target_checksum');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_checksum` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.target_checksum');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_codec` SET TAGS ('dbx_business_glossary_term' = 'Target Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_codec` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_codec` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.target_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_codec` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.target_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Target File Size Bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_file_size_bytes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_file_size_bytes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.target_file_size_bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_file_size_bytes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.target_file_size_bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_format` SET TAGS ('dbx_business_glossary_term' = 'Target Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.target_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.target_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_resolution` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_resolution` SET TAGS ('dbx_value_regex' = '^[0-9]{3,4}x[0-9]{3,4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_resolution` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_resolution` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.target_resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `target_resolution` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.target_resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.format_migration.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.format_migration.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` SET TAGS ('dbx_subdomain' = 'media_processing');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` SET TAGS ('dbx_fact_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` SET TAGS ('dbx_data_type' = 'bridge_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.mediaasset.asset_access_request');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.mediaasset.asset_access_request');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` SET TAGS ('dbx_mediaasset_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` SET TAGS ('dbx_domain_ownership' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` SET TAGS ('dbx_fact_dim_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` SET TAGS ('dbx_star_schema' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `asset_access_request_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Access Request ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `asset_access_request_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `asset_access_request_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.asset_access_request_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `asset_access_request_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.asset_access_request_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.approver_employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.approver_employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `partner_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `partner_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `partner_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `primary_asset_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `primary_asset_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `primary_asset_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `primary_asset_employee_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `primary_asset_employee_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.primary_asset_employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `primary_asset_employee_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.primary_asset_employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Access Duration Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_duration_hours` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_duration_hours` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.access_duration_hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_duration_hours` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.access_duration_hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Access Expiry Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_expiry_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_expiry_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.access_expiry_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_expiry_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.access_expiry_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_granted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Access Granted Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_granted_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_granted_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.access_granted_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_granted_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.access_granted_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_granted_uri` SET TAGS ('dbx_business_glossary_term' = 'Access Granted Uniform Resource Identifier (URI)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_granted_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_granted_uri` SET TAGS ('dbx_validation_regex_^https?' = '//[^s]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_granted_uri` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_granted_uri` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.access_granted_uri');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_granted_uri` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.access_granted_uri');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_purpose` SET TAGS ('dbx_business_glossary_term' = 'Access Purpose');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_purpose` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_purpose` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.access_purpose');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_purpose` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.access_purpose');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_type` SET TAGS ('dbx_business_glossary_term' = 'Access Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_type` SET TAGS ('dbx_value_regex' = 'stream|download|checkout|preview|metadata_only');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.access_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.access_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `access_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `approval_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `approval_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.approval_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `approval_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.approval_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `approval_required` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `approval_required` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.approval_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `approval_required` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.approval_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.approval_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.approval_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Full Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `approver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `approver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `approver_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `approver_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `approver_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.approver_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `approver_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.approver_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `checkout_lock_active` SET TAGS ('dbx_business_glossary_term' = 'Checkout Lock Active Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `checkout_lock_active` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `checkout_lock_active` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.checkout_lock_active');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `checkout_lock_active` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.checkout_lock_active');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `compliance_classification` SET TAGS ('dbx_business_glossary_term' = 'Compliance Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `compliance_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted|highly_restricted');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `compliance_classification` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `compliance_classification` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.compliance_classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `compliance_classification` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.compliance_classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `download_count` SET TAGS ('dbx_business_glossary_term' = 'Download Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `download_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `download_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.download_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `download_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.download_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `drm_applied` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Applied Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `drm_applied` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `drm_applied` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.drm_applied');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `drm_applied` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.drm_applied');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Accessed Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.last_accessed_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.last_accessed_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.legal_hold_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.legal_hold_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.priority_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.priority_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.rejection_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.rejection_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `request_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `request_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.request_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `request_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.request_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `request_source` SET TAGS ('dbx_business_glossary_term' = 'Request Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `request_source` SET TAGS ('dbx_value_regex' = 'mam_portal|api|mobile_app|workflow_automation|third_party_integration');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `request_source` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `request_source` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.request_source');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `request_source` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.request_source');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled|expired|revoked');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `request_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `request_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.request_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `request_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.request_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `request_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.request_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.request_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `requestor_department` SET TAGS ('dbx_business_glossary_term' = 'Requestor Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `requestor_department` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `requestor_department` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.requestor_department');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `requestor_department` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.requestor_department');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_business_glossary_term' = 'Requestor Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_validation_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.requestor_email');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.requestor_email');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Full Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.requestor_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.requestor_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `rights_clearance_required` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `rights_clearance_required` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `rights_clearance_required` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.rights_clearance_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `rights_clearance_required` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.rights_clearance_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|cleared|blocked');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.rights_clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.rights_clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `stream_count` SET TAGS ('dbx_business_glossary_term' = 'Stream Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `stream_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `stream_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.stream_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `stream_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.stream_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `usage_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Usage Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `usage_restrictions` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `usage_restrictions` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.usage_restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `usage_restrictions` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.usage_restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `watermark_applied` SET TAGS ('dbx_business_glossary_term' = 'Watermark Applied Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `watermark_applied` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `watermark_applied` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_access_request.watermark_applied');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ALTER COLUMN `watermark_applied` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_access_request.watermark_applied');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` SET TAGS ('dbx_subdomain' = 'rights_compliance');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` SET TAGS ('dbx_association_edges' = 'mediaasset.media_asset,partner.partner_partner');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` SET TAGS ('dbx_data_type' = 'bridge_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.mediaasset.asset_rights_grant');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.mediaasset.asset_rights_grant');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` SET TAGS ('dbx_mediaasset_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` SET TAGS ('dbx_domain_ownership' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `asset_rights_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Rights Grant ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `asset_rights_grant_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `asset_rights_grant_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_rights_grant.asset_rights_grant_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `asset_rights_grant_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_rights_grant.asset_rights_grant_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Granted By User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_rights_grant.employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_rights_grant.employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Rights Grant - Media Asset Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_rights_grant.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_rights_grant.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Rights Grant - Partner Partner Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `partner_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `partner_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_rights_grant.partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `partner_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_rights_grant.partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_rights_grant._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_rights_grant._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_rights_grant._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_rights_grant._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `contract_reference` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `contract_reference` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_rights_grant.contract_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `contract_reference` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_rights_grant.contract_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_rights_grant.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_rights_grant.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_rights_grant.effective_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_rights_grant.effective_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_rights_grant.effective_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_rights_grant.effective_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_rights_grant.exclusivity_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_rights_grant.exclusivity_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_business_glossary_term' = 'Grant Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_rights_grant.grant_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_rights_grant.grant_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `granted_date` SET TAGS ('dbx_business_glossary_term' = 'Granted Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `granted_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `granted_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_rights_grant.granted_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `granted_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_rights_grant.granted_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_rights_grant.revenue_share_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_rights_grant.revenue_share_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `rights_type` SET TAGS ('dbx_business_glossary_term' = 'Rights Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `rights_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `rights_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_rights_grant.rights_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `rights_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_rights_grant.rights_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `rights_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_rights_grant._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_rights_grant._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_rights_grant.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_rights_grant.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `territory_scope` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `territory_scope` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_rights_grant.territory_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `territory_scope` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_rights_grant.territory_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_rights_grant.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_rights_grant.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `usage_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Usage Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `usage_restrictions` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `usage_restrictions` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_rights_grant.usage_restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ALTER COLUMN `usage_restrictions` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_rights_grant.usage_restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` SET TAGS ('dbx_subdomain' = 'rights_compliance');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` SET TAGS ('dbx_association_edges' = 'mediaasset.media_asset,partner.acquisition_deal');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` SET TAGS ('dbx_star_schema_role' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` SET TAGS ('dbx_data_type' = 'dimension_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.mediaasset.deal_asset_license');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.mediaasset.deal_asset_license');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` SET TAGS ('dbx_mediaasset_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` SET TAGS ('dbx_domain_ownership' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `deal_asset_license_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Asset License ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `deal_asset_license_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `deal_asset_license_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.deal_asset_license.deal_asset_license_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `deal_asset_license_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.deal_asset_license.deal_asset_license_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Asset License - Acquisition Deal Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.deal_asset_license.acquisition_deal_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.deal_asset_license.acquisition_deal_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Asset License - Media Asset Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.deal_asset_license.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.deal_asset_license.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.deal_asset_license._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.deal_asset_license._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.deal_asset_license._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.deal_asset_license._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.deal_asset_license.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.deal_asset_license.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `delivery_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `delivery_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.deal_asset_license.delivery_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `delivery_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.deal_asset_license.delivery_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `delivery_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `delivery_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.deal_asset_license.delivery_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `delivery_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.deal_asset_license.delivery_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `delivery_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.deal_asset_license.exclusivity_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.deal_asset_license.exclusivity_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'License Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.deal_asset_license.license_fee_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.deal_asset_license.license_fee_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `license_term_end_date` SET TAGS ('dbx_business_glossary_term' = 'License Term End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `license_term_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `license_term_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.deal_asset_license.license_term_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `license_term_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.deal_asset_license.license_term_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `license_term_start_date` SET TAGS ('dbx_business_glossary_term' = 'License Term Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `license_term_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `license_term_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.deal_asset_license.license_term_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `license_term_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.deal_asset_license.license_term_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `rights_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Rights Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `rights_restrictions` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `rights_restrictions` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.deal_asset_license.rights_restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `rights_restrictions` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.deal_asset_license.rights_restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `runs_allowed` SET TAGS ('dbx_business_glossary_term' = 'Runs Allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `runs_allowed` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `runs_allowed` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.deal_asset_license.runs_allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `runs_allowed` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.deal_asset_license.runs_allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.deal_asset_license._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.deal_asset_license._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.deal_asset_license.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.deal_asset_license.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `territory_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `territory_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.deal_asset_license.territory_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `territory_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.deal_asset_license.territory_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `territory_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.deal_asset_license.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.deal_asset_license.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` SET TAGS ('dbx_subdomain' = 'asset_catalog');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` SET TAGS ('dbx_association_edges' = 'mediaasset.asset_collection,mediaasset.media_asset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` SET TAGS ('dbx_data_type' = 'bridge_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.mediaasset.collection_membership');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.mediaasset.collection_membership');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` SET TAGS ('dbx_bridge_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` SET TAGS ('dbx_mediaasset_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` SET TAGS ('dbx_domain_ownership' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `collection_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Membership Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `collection_membership_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `collection_membership_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.collection_membership.collection_membership_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `collection_membership_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.collection_membership.collection_membership_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `asset_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Membership - Asset Collection Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `asset_collection_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `asset_collection_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.collection_membership.asset_collection_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `asset_collection_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.collection_membership.asset_collection_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `asset_collection_id` SET TAGS ('dbx_bridge_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Membership - Media Asset Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.collection_membership.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.collection_membership.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_bridge_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.collection_membership._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.collection_membership._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.collection_membership._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.collection_membership._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `added_by_user` SET TAGS ('dbx_business_glossary_term' = 'Added By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `added_by_user` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `added_by_user` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.collection_membership.added_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `added_by_user` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.collection_membership.added_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `added_date` SET TAGS ('dbx_business_glossary_term' = 'Date Added to Collection');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `added_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `added_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.collection_membership.added_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `added_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.collection_membership.added_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.collection_membership.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.collection_membership.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `curator_notes` SET TAGS ('dbx_business_glossary_term' = 'Curator Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `curator_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `curator_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.collection_membership.curator_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `curator_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.collection_membership.curator_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `inclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `inclusion_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `inclusion_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.collection_membership.inclusion_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `inclusion_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.collection_membership.inclusion_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.collection_membership.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.collection_membership.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `membership_role` SET TAGS ('dbx_business_glossary_term' = 'Membership Role');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `membership_role` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `membership_role` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.collection_membership.membership_role');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `membership_role` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.collection_membership.membership_role');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.collection_membership.membership_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.collection_membership.membership_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `removed_by_user` SET TAGS ('dbx_business_glossary_term' = 'Removed By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `removed_by_user` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `removed_by_user` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.collection_membership.removed_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `removed_by_user` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.collection_membership.removed_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `removed_date` SET TAGS ('dbx_business_glossary_term' = 'Date Removed from Collection');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `removed_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `removed_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.collection_membership.removed_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `removed_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.collection_membership.removed_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `sequence_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `sequence_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.collection_membership.sequence_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `sequence_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.collection_membership.sequence_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.collection_membership._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.collection_membership._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.collection_membership.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.collection_membership.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.collection_membership.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`collection_membership` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.collection_membership.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` SET TAGS ('dbx_subdomain' = 'rights_compliance');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` SET TAGS ('dbx_association_edges' = 'mediaasset.media_asset,mediaasset.legal_hold');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` SET TAGS ('dbx_star_schema_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` SET TAGS ('dbx_data_type' = 'fact_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.mediaasset.asset_legal_hold');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.mediaasset.asset_legal_hold');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` SET TAGS ('dbx_mediaasset_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` SET TAGS ('dbx_domain_ownership' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` SET TAGS ('dbx_fact_dim_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` SET TAGS ('dbx_star_schema' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `asset_legal_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Legal Hold Assignment Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `asset_legal_hold_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `asset_legal_hold_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_legal_hold.asset_legal_hold_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `asset_legal_hold_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_legal_hold.asset_legal_hold_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Hold Custodian');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_legal_hold.custodian_employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_legal_hold.custodian_employee_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Legal Hold - Legal Hold Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_legal_hold.legal_hold_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_legal_hold.legal_hold_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Legal Hold - Media Asset Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_legal_hold.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_legal_hold.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_legal_hold._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_legal_hold._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_legal_hold._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_legal_hold._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_legal_hold.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_legal_hold.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_legal_hold.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_legal_hold.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `custodian_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Custodian Acknowledgment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `custodian_acknowledgment_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `custodian_acknowledgment_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_legal_hold.custodian_acknowledgment_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `custodian_acknowledgment_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_legal_hold.custodian_acknowledgment_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `hold_application_notes` SET TAGS ('dbx_business_glossary_term' = 'Hold Application Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `hold_application_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `hold_application_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_legal_hold.hold_application_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `hold_application_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_legal_hold.hold_application_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `hold_applied_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Application Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `hold_applied_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `hold_applied_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_legal_hold.hold_applied_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `hold_applied_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_legal_hold.hold_applied_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `hold_released_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `hold_released_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `hold_released_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_legal_hold.hold_released_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `hold_released_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_legal_hold.hold_released_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Hold Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_legal_hold.hold_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_legal_hold.hold_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_legal_hold.last_modified_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_legal_hold.last_modified_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_legal_hold.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_legal_hold.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `mam_lock_applied` SET TAGS ('dbx_business_glossary_term' = 'MAM System Lock Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `mam_lock_applied` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `mam_lock_applied` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_legal_hold.mam_lock_applied');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `mam_lock_applied` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_legal_hold.mam_lock_applied');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `release_authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'Release Authorization Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `release_authorization_reference` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `release_authorization_reference` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_legal_hold.release_authorization_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `release_authorization_reference` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_legal_hold.release_authorization_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_legal_hold._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_legal_hold._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_legal_hold.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_legal_hold.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_legal_hold.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_legal_hold.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Creator');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `created_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `created_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_legal_hold.created_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ALTER COLUMN `created_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_legal_hold.created_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` SET TAGS ('dbx_subdomain' = 'rights_compliance');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` SET TAGS ('dbx_association_edges' = 'mediaasset.asset_collection,sales.sales_syndication_deal');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` SET TAGS ('dbx_star_schema_role' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` SET TAGS ('dbx_data_type' = 'dimension_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.mediaasset.syndication_inventory');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.mediaasset.syndication_inventory');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` SET TAGS ('dbx_in_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` SET TAGS ('dbx_mediaasset_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` SET TAGS ('dbx_domain_ownership' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `syndication_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Inventory ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `syndication_inventory_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `syndication_inventory_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.syndication_inventory.syndication_inventory_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `syndication_inventory_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.syndication_inventory.syndication_inventory_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `asset_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Inventory - Asset Collection Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `asset_collection_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `asset_collection_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.syndication_inventory.asset_collection_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `asset_collection_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.syndication_inventory.asset_collection_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `sales_syndication_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Inventory - Sales Syndication Deal Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `sales_syndication_deal_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `sales_syndication_deal_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.syndication_inventory.sales_syndication_deal_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `sales_syndication_deal_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.syndication_inventory.sales_syndication_deal_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.syndication_inventory._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.syndication_inventory._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.syndication_inventory._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.syndication_inventory._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `actual_clearance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Actual Clearance Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `actual_clearance_percentage` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `actual_clearance_percentage` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.syndication_inventory.actual_clearance_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `actual_clearance_percentage` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.syndication_inventory.actual_clearance_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `barter_inventory_allocation` SET TAGS ('dbx_business_glossary_term' = 'Barter Inventory Allocation');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `barter_inventory_allocation` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `barter_inventory_allocation` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.syndication_inventory.barter_inventory_allocation');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `barter_inventory_allocation` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.syndication_inventory.barter_inventory_allocation');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `clearance_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `clearance_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.syndication_inventory.clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `clearance_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.syndication_inventory.clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `clearance_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.syndication_inventory.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.syndication_inventory.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.syndication_inventory.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.syndication_inventory.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `delivery_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `delivery_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.syndication_inventory.delivery_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `delivery_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.syndication_inventory.delivery_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `episode_sequence` SET TAGS ('dbx_business_glossary_term' = 'Episode Sequence');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `episode_sequence` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `episode_sequence` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.syndication_inventory.episode_sequence');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `episode_sequence` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.syndication_inventory.episode_sequence');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `exclusion_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `exclusion_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `exclusion_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.syndication_inventory.exclusion_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `exclusion_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.syndication_inventory.exclusion_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `format_specification` SET TAGS ('dbx_business_glossary_term' = 'Format Specification');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `format_specification` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `format_specification` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.syndication_inventory.format_specification');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `format_specification` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.syndication_inventory.format_specification');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `inclusion_date` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `inclusion_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `inclusion_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.syndication_inventory.inclusion_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `inclusion_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.syndication_inventory.inclusion_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `inclusion_status` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `inclusion_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `inclusion_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.syndication_inventory.inclusion_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `inclusion_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.syndication_inventory.inclusion_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `inclusion_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.syndication_inventory.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.syndication_inventory.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.syndication_inventory.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.syndication_inventory.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `runs_per_episode` SET TAGS ('dbx_business_glossary_term' = 'Runs Per Episode');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `runs_per_episode` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `runs_per_episode` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.syndication_inventory.runs_per_episode');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `runs_per_episode` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.syndication_inventory.runs_per_episode');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.syndication_inventory._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.syndication_inventory._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.syndication_inventory.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.syndication_inventory.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.syndication_inventory.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.syndication_inventory.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` SET TAGS ('dbx_subdomain' = 'asset_catalog');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` SET TAGS ('dbx_reference_data' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` SET TAGS ('dbx_lookup' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` SET TAGS ('dbx_enum_materialized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` SET TAGS ('dbx_star_schema_role' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` SET TAGS ('dbx_data_type' = 'dimension_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.mediaasset.asset_status_ref');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.mediaasset.asset_status_ref');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `asset_status_ref_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `asset_status_ref_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_status_ref.asset_status_ref_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `asset_status_ref_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_status_ref.asset_status_ref_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_relationship' = 'fix_siloed');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_status_ref._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_status_ref._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_status_ref._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_status_ref._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_status_ref.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_status_ref.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_status_ref.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_status_ref.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `is_active_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_status_ref.is_active_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `is_active_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_status_ref.is_active_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `is_available_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_status_ref.is_available_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `is_available_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_status_ref.is_available_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `is_terminal_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_status_ref.is_terminal_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `is_terminal_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_status_ref.is_terminal_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `sort_order` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_status_ref.sort_order');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `sort_order` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_status_ref.sort_order');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_status_ref._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_status_ref._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_status_ref.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_status_ref.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `status_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_status_ref.status_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `status_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_status_ref.status_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `status_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `status_description` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_status_ref.status_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `status_description` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_status_ref.status_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `status_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `status_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_status_ref.status_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `status_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_status_ref.status_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_status_ref.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_status_ref.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_status_ref.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_status_ref` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_status_ref.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` SET TAGS ('dbx_subdomain' = 'storage_archival');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` SET TAGS ('dbx_reference_data' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` SET TAGS ('dbx_lookup' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` SET TAGS ('dbx_enum_materialized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` SET TAGS ('dbx_dim_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` SET TAGS ('dbx_star_schema_role' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` SET TAGS ('dbx_data_type' = 'dimension_table');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` SET TAGS ('dbx_ebu_ccdm_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` SET TAGS ('dbx_ddl_table_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` SET TAGS ('dbx_unity_catalog' = 'media_broadcasting.mediaasset.storage_tier_ref');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.mediaasset.storage_tier_ref');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` SET TAGS ('dbx_fact_dim_role' = 'dim');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `storage_tier_ref_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `storage_tier_ref_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_tier_ref.storage_tier_ref_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `storage_tier_ref_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_tier_ref.storage_tier_ref_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_relationship' = 'created_by_fix_siloed');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_tier_ref._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_tier_ref._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_tier_ref._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_tier_ref._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `access_latency_ms` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_tier_ref.access_latency_ms');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `access_latency_ms` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_tier_ref.access_latency_ms');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `cost_per_gb_monthly` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_tier_ref.cost_per_gb_monthly');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `cost_per_gb_monthly` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_tier_ref.cost_per_gb_monthly');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_tier_ref.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_tier_ref.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_tier_ref.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_tier_ref.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `is_active_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_tier_ref.is_active_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `is_active_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_tier_ref.is_active_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `sort_order` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_tier_ref.sort_order');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `sort_order` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_tier_ref.sort_order');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `source_record_id` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `source_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `source_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_tier_ref._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `source_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_tier_ref._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_tier_ref.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_tier_ref.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `tier_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_tier_ref.tier_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `tier_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_tier_ref.tier_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `tier_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `tier_description` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_tier_ref.tier_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `tier_description` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_tier_ref.tier_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `tier_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `tier_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_tier_ref.tier_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `tier_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_tier_ref.tier_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_tier_ref.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_tier_ref.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.storage_tier_ref.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_tier_ref` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.storage_tier_ref.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`mediaasset_watermark_forensic_match` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`mediaasset_watermark_forensic_match` SET TAGS ('dbx_subdomain' = 'rights_compliance');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`mediaasset_watermark_forensic_match` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`mediaasset_watermark_forensic_match` SET TAGS ('dbx_fact_dim_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`mediaasset_watermark_forensic_match` SET TAGS ('dbx_star_schema' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`mediaasset_watermark_forensic_match` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`mediaasset_watermark_forensic_match` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`mediaasset_watermark_forensic_match` ALTER COLUMN `source_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`mediaasset_watermark_forensic_match` ALTER COLUMN `source_device_code` SET TAGS ('dbx_pii' = 'true');
