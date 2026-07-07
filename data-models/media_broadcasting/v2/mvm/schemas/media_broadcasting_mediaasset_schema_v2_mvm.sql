-- Schema for Domain: mediaasset | Business: Media_Broadcasting | Version: v2_mvm
-- Generated on: 2026-06-30 06:39:03

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`mediaasset` COMMENT 'Authoritative repository for all managed media files and digital objects — raw camera footage, mezzanine masters, proxy files, graphics, music beds, and archived assets. Implements MAM (Media Asset Management) via Dalet Galaxy, enforcing storage tiering, format standards (MPEG-4 ISO 14496), checksum integrity, retention policies, format migrations, and chain-of-custody audit trails for regulatory and legal hold compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` (
    `media_asset_id` BIGINT COMMENT 'Unique identifier for the media asset record in the MAM (Media Asset Management) system. Primary key for all digital objects managed by Dalet Galaxy. | Column media_asset_id (BIGINT) in mediaasset.media_asset',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.holder. Business justification: Asset-level rights holder identification: asset managers and legal teams need to immediately identify the rights holder for legal hold decisions, clearance escalation, and licensing negotiations witho',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to mediaasset.storage_location. Business justification: media_asset.storage_location_uri is a free-text field capturing where the master asset file resides. storage_location is the authoritative master reference for all physical and logical storage locatio',
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
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.media_asset',
    `storage_tier` STRING COMMENT 'Current storage tier assignment based on access frequency and retention policy. Hot=online high-performance, Warm=nearline, Cold=offline tape, Deep-archive=long-term preservation, Glacier=regulatory hold. | Column storage_tier (STRING) in mediaasset.media_asset. Valid values are `hot|warm|cold|deep_archive|glacier`',
    `timecode_start` STRING COMMENT 'SMPTE timecode of the first frame in HH:MM:SS:FF format. Essential for frame-accurate editing and playout synchronization. | Column timecode_start (STRING) in mediaasset.media_asset. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9][:;][0-9]{2}$`',
    `umid` STRING COMMENT 'SMPTE 330M globally unique identifier for the media essence. 64-character hexadecimal string providing universal identification across systems and organizations. | Column umid (STRING) in mediaasset.media_asset. Valid values are `^[0-9A-F]{64}$`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.media_asset',
    CONSTRAINT pk_media_asset PRIMARY KEY(`media_asset_id`)
) COMMENT 'Core master record for every managed digital object in the MAM (Dalet Galaxy) — raw camera footage, mezzanine masters, graphics, music beds, and archived assets. Stores canonical asset identity, technical format metadata (codec, resolution, duration, bit-rate, aspect ratio, color space, audio channels, frame rate), asset class (raw/mezzanine/proxy/archive), storage tier (hot/warm/cold/deep-archive), lifecycle status (ingest/QC/approved/archived/purged), industry identifiers (ISAN/EIDR/ISRC/UMID), originating system reference, and content classification tags. Single source of truth for all digital object identities and their technical characteristics across the enterprise. | Unity Catalog table: media_broadcasting_ecm.mediaasset.media_asset';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` (
    `asset_version_id` BIGINT COMMENT 'Unique identifier for the asset version record. Primary key. | Column asset_version_id (BIGINT) in mediaasset.asset_version',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Per-version delivery rights validation: a specific asset_version (language dub, resolution rendition) is governed by a specific grant defining territory, language, and media_type. Broadcast delivery w',
    `media_asset_id` BIGINT COMMENT 'Reference to the parent media asset of which this is a version or rendition. | Column media_asset_id (BIGINT) in mediaasset.asset_version',
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
    `ad_order_id` BIGINT COMMENT 'Foreign key linking to sales.ad_order. Business justification: In broadcast ad operations, creative submission/ingest is triggered by an ad order — the advertiser delivers the creative against a specific order. Linking ingest_job to ad_order enables creative rece',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Ingest job creates a specific version (typically the mezzanine or raw master). This FK links the ingest job to the version it produced. Populated upon successful ingest completion. | Column created_asset_version_id (BIGINT) in mediaasset.ingest_job',
    `creative_id` BIGINT COMMENT 'Foreign key linking to advertising.creative. Business justification: Ad Material Ingest workflow: when advertisers deliver creative materials, broadcast operations run an ingest_job for that specific creative. This FK enables delivery confirmation reporting, material r',
    `media_asset_id` BIGINT COMMENT 'Reference to the resulting media asset record created upon successful completion of the ingest job. Establishes chain-of-custody linkage. | Column media_asset_id (BIGINT) in mediaasset.ingest_job',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Ingest jobs in broadcast MAM systems are tied to specific episodes being ingested from production. This link enables episode-level asset provenance, ingest status reporting per episode, and automated ',
    `project_id` BIGINT COMMENT 'Foreign key linking to production.project. Business justification: Ingest jobs are triggered by production deliveries. Linking ingest_job to the originating production project enables provenance tracking, cost allocation to WBS elements, and production-to-MAM workflo',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to mediaasset.storage_location. Business justification: ingest_job.target_storage_location is a free-text field capturing the destination storage location for ingested content. storage_location is the authoritative master reference for all storage location',
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
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.ingest_job',
    `target_format` STRING COMMENT 'Desired output format for the ingested media. May differ from source format if transcoding is required during ingest. | Column target_format (STRING) in mediaasset.ingest_job',
    `timecode_start` STRING COMMENT 'Starting timecode of the ingested media in SMPTE format (HH:MM:SS:FF). Used for frame-accurate editing and synchronization. | Column timecode_start (STRING) in mediaasset.ingest_job',
    `transfer_rate_mbps` DECIMAL(18,2) COMMENT 'Average data transfer rate achieved during ingest, measured in megabits per second. Key performance indicator for ingest infrastructure. | Column transfer_rate_mbps (DECIMAL(10,2)) in mediaasset.ingest_job',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.ingest_job',
    CONSTRAINT pk_ingest_job PRIMARY KEY(`ingest_job_id`)
) COMMENT 'Transactional record of every media ingest operation executed in Dalet Galaxy — capturing ingest source (tape, file transfer, satellite feed, cloud upload), ingest start/end timestamps, operator identity, source format, target storage location, ingest status (queued/running/completed/failed), bytes transferred, transfer rate, and any error codes encountered. Provides the chain-of-custody entry point for all assets entering the MAM. Links to the resulting media_asset record upon successful completion. | Unity Catalog table: media_broadcasting_ecm.mediaasset.ingest_job';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` (
    `transcode_job_id` BIGINT COMMENT 'Primary key for transcode_job | Column transcode_job_id (BIGINT) in mediaasset.transcode_job',
    `deliverable_id` BIGINT COMMENT 'Foreign key linking to production.deliverable. Business justification: Transcode jobs are initiated to fulfill specific production deliverables (e.g., creating a platform-specific rendition per delivery spec). This link enables delivery status tracking, cost attribution ',
    `media_asset_id` BIGINT COMMENT 'Reference to the source media asset being transcoded. | Column media_asset_id (BIGINT) in mediaasset.transcode_job',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to mediaasset.storage_location. Business justification: transcode_job.output_storage_uri is a free-text URI capturing where the transcoded output file is written. storage_location is the authoritative master reference for all storage locations in the MAM. ',
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
    `processing_duration_seconds` STRING COMMENT 'Total elapsed time in seconds from processing start to completion, used for performance monitoring and capacity planning. | Column processing_duration_seconds (INT) in mediaasset.transcode_job',
    `processing_end_timestamp` TIMESTAMP COMMENT 'Date and time when the transcoding engine completed or terminated processing of this job. | Column processing_end_timestamp (TIMESTAMP) in mediaasset.transcode_job',
    `processing_start_timestamp` TIMESTAMP COMMENT 'Date and time when the transcoding engine began processing this job. | Column processing_start_timestamp (TIMESTAMP) in mediaasset.transcode_job',
    `quality_validation_result` STRING COMMENT 'Outcome of automated quality validation checks performed on the transcoded output, including video integrity, audio sync, and compliance with target specifications. | Column quality_validation_result (STRING) in mediaasset.transcode_job. Valid values are `passed|failed|warning|not_validated`',
    `quality_validation_score` DECIMAL(18,2) COMMENT 'Numeric quality score (0-100) assigned by automated validation tools, measuring output fidelity against source and target specifications. | Column quality_validation_score (DECIMAL(5,2)) in mediaasset.transcode_job',
    `queue_entry_timestamp` TIMESTAMP COMMENT 'Date and time when the transcode job was submitted to the processing queue. | Column queue_entry_timestamp (TIMESTAMP) in mediaasset.transcode_job',
    `retry_count` STRING COMMENT 'Number of times this job has been automatically retried after failure, used to prevent infinite retry loops. | Column retry_count (INT) in mediaasset.transcode_job',
    `source_bitrate_mbps` DECIMAL(18,2) COMMENT 'Average bitrate of the source asset in megabits per second. | Column source_bitrate_mbps (DECIMAL(10,2)) in mediaasset.transcode_job',
    `source_codec` STRING COMMENT 'Video codec of the source asset (e.g., H.264, H.265/HEVC, MPEG-2, ProRes, DNxHD). | Column source_codec (STRING) in mediaasset.transcode_job',
    `source_duration_seconds` STRING COMMENT 'Duration of the source media asset in seconds. | Column source_duration_seconds (INT) in mediaasset.transcode_job',
    `source_file_size_gb` DECIMAL(18,2) COMMENT 'File size of the source asset in gigabytes. | Column source_file_size_gb (DECIMAL(12,3)) in mediaasset.transcode_job',
    `source_format` STRING COMMENT 'Original format specification of the source asset, including container format and codec (e.g., MXF/MPEG-2, MOV/ProRes, MP4/H.264). | Column source_format (STRING) in mediaasset.transcode_job',
    `source_resolution` STRING COMMENT 'Video resolution of the source asset in pixels (e.g., 1920x1080, 3840x2160, 1280x720). | Column source_resolution (STRING) in mediaasset.transcode_job',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.transcode_job',
    `transcoding_engine` STRING COMMENT 'Name and version of the transcoding engine or software used to perform the conversion (e.g., FFmpeg 5.1.2, AWS Elemental MediaConvert, Dalet Brio). | Column transcoding_engine (STRING) in mediaasset.transcode_job',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.transcode_job',
    CONSTRAINT pk_transcode_job PRIMARY KEY(`transcode_job_id`)
) COMMENT 'Transactional record of every format conversion operation performed on a media asset — including standard transcodes (ABR ladder generation, proxy creation, delivery package preparation) and format migrations (obsolescence-driven conversions such as MPEG-2 to H.265, tape digitisation, analogue-to-digital). Captures source asset version, target format specification, codec parameters, bitrate ladder configuration, output storage URI, job type (transcode/migration), migration reason (if applicable: format obsolescence/storage optimisation/distribution requirement), job priority, queue entry time, processing start/end timestamps, transcoding engine used, output file size, checksum, quality validation result, and job status (queued/processing/completed/failed/retrying). Single source of truth for all format conversion operations in the MAM. | Unity Catalog table: media_broadcasting_ecm.mediaasset.transcode_job';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` (
    `qc_inspection_id` BIGINT COMMENT 'Unique identifier for the quality control inspection record. Primary key. | Column qc_inspection_id (BIGINT) in mediaasset.qc_inspection',
    `deliverable_id` BIGINT COMMENT 'Foreign key linking to production.deliverable. Business justification: MAM QC inspections validate that a media asset meets the technical specs of a production deliverable. Without this FK, QC pass/fail results cannot be reconciled against delivery requirements — a criti',
    `asset_version_id` BIGINT COMMENT 'Reference to the specific version of the media asset that underwent this quality control inspection. | Column media_asset_version_id (BIGINT) in mediaasset.qc_inspection',
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
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.qc_inspection',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.qc_inspection',
    `video_codec_compliance_result` STRING COMMENT 'Result of video codec format compliance check. Verifies that video encoding conforms to expected codec standard (e.g., H.264/AVC, H.265/HEVC, MPEG-2, AV1). | Column video_codec_compliance_result (STRING) in mediaasset.qc_inspection. Valid values are `pass|fail|not_tested`',
    CONSTRAINT pk_qc_inspection PRIMARY KEY(`qc_inspection_id`)
) COMMENT 'Records the quality control inspection result for each media asset version — capturing QC type (automated/manual/hybrid), inspection timestamp, operator or automated QC tool identity, pass/fail status, loudness compliance result (EBU R128 / ATSC A/85), black frame detection, freeze frame detection, audio sync check, caption/subtitle validation, aspect ratio compliance, HDR metadata validation, and a structured list of detected defects with timecode references. Mandatory gate before asset is approved for playout or distribution. | Unity Catalog table: media_broadcasting_ecm.mediaasset.qc_inspection';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` (
    `storage_location_id` BIGINT COMMENT 'Unique identifier for the storage location within the Media Asset Management (MAM) infrastructure. Primary key. | Column storage_location_id (BIGINT) in mediaasset.storage_location',
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
    `media_asset_id` BIGINT COMMENT 'Reference to the media asset that is being stored. Links to the master media asset record in the MAM (Media Asset Management) system. | Column media_asset_id (BIGINT) in mediaasset.asset_storage_assignment',
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
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.asset_storage_assignment',
    `storage_cost_per_gb` DECIMAL(18,2) COMMENT 'Cost per gigabyte for this storage tier at the time of assignment. Used for storage cost allocation and financial reporting. | Column storage_cost_per_gb (DECIMAL(10,4)) in mediaasset.asset_storage_assignment',
    `storage_tier` STRING COMMENT 'Storage tier classification at the time of assignment. Indicates performance and cost characteristics: hot (high-performance online), warm (standard online), cold (infrequent access), archive (long-term preservation), nearline (tape/optical near-online), offline (physical media vault). | Column storage_tier (STRING) in mediaasset.asset_storage_assignment. Valid values are `hot|warm|cold|archive|nearline|offline`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.asset_storage_assignment',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage assignment record was last modified. Used for change tracking and audit trails. | Column updated_timestamp (TIMESTAMP) in mediaasset.asset_storage_assignment',
    `verification_status` STRING COMMENT 'Status of file integrity verification at this storage location. Indicates whether checksum validation has been performed and passed. | Column verification_status (STRING) in mediaasset.asset_storage_assignment. Valid values are `pending|verified|failed|not_verified`',
    `verification_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent integrity verification check. Used to track compliance with periodic verification policies. | Column verification_timestamp (TIMESTAMP) in mediaasset.asset_storage_assignment',
    CONSTRAINT pk_asset_storage_assignment PRIMARY KEY(`asset_storage_assignment_id`)
) COMMENT 'Tracks the complete storage placement history for every media asset version — recording which file resides at which storage location, when it was placed there, and why it moved. Captures storage location reference, file path/URI, storage tier at time of assignment, assignment start date, end date (if migrated or purged), file size, checksum at placement, migration trigger (tiering policy/legal hold/cost optimisation/format migration/capacity rebalance), and verification status. Provides the authoritative chain-of-custody for physical file placement, drives storage capacity reporting, enables restore path resolution, and supports legal discovery by proving where a file was at any point in time. | Unity Catalog table: media_broadcasting_ecm.mediaasset.asset_storage_assignment';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` (
    `archive_record_id` BIGINT COMMENT 'Primary key for archive_record | Column archive_record_id (BIGINT) in mediaasset.archive_record',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Archive operations target specific versions (mezzanine, proxy, master) not just the abstract asset. This FK allows tracking which exact rendition was archived. Nullable initially, populated during arc | Column asset_version_id (BIGINT) in mediaasset.archive_record',
    `media_asset_id` BIGINT COMMENT 'Reference to the media asset being archived. Links to the source digital asset in the Media Asset Management (MAM) system. | Column media_asset_id (BIGINT) in mediaasset.archive_record',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to mediaasset.storage_location. Business justification: archive_record.archive_destination_identifier is a free-text field capturing the identifier of the archive destination (LTO tape barcode, cloud vault ID, offsite facility). storage_location is the aut',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in mediaasset.archive_record',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in mediaasset.archive_record',
    `archive_cost_per_gb` DECIMAL(18,2) COMMENT 'The cost per gigabyte for storing the asset in the archive destination, used for financial planning and cost allocation. | Column archive_cost_per_gb (DECIMAL(10,4)) in mediaasset.archive_record',
    `archive_date` DATE COMMENT 'The date when the media asset was formally archived to long-term storage. | Column archive_date (DATE) in mediaasset.archive_record',
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
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in mediaasset.archive_record',
    `storage_tier` STRING COMMENT 'The storage tier classification indicating access frequency and cost structure (hot for frequent access, deep archive for infrequent access). | Column storage_tier (STRING) in mediaasset.archive_record. Valid values are `hot|warm|cold|deep_archive`',
    `tape_barcode` STRING COMMENT 'Physical barcode identifier on the LTO tape cartridge used for archival, enabling physical inventory tracking. | Column tape_barcode (STRING) in mediaasset.archive_record',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in mediaasset.archive_record',
    CONSTRAINT pk_archive_record PRIMARY KEY(`archive_record_id`)
) COMMENT 'Tracks the formal archival of media assets to long-term storage — capturing archive date, archive destination (LTO tape generation, cloud deep-archive vault, off-site facility), archive job reference, tape barcode or vault identifier, restore SLA tier, restore test date, restore test result, retention policy applied, archival operator, and archive status (archived/restore-requested/restored/purge-pending). Supports ISO 14721 OAIS compliance and provides the authoritative record for asset archival and retrieval operations. | Unity Catalog table: media_broadcasting_ecm.mediaasset.archive_record';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ADD CONSTRAINT `fk_mediaasset_media_asset_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ADD CONSTRAINT `fk_mediaasset_asset_version_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ADD CONSTRAINT `fk_mediaasset_transcode_job_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ADD CONSTRAINT `fk_mediaasset_transcode_job_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ADD CONSTRAINT `fk_mediaasset_qc_inspection_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ADD CONSTRAINT `fk_mediaasset_asset_storage_assignment_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ADD CONSTRAINT `fk_mediaasset_asset_storage_assignment_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ADD CONSTRAINT `fk_mediaasset_asset_storage_assignment_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ADD CONSTRAINT `fk_mediaasset_archive_record_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ADD CONSTRAINT `fk_mediaasset_archive_record_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ADD CONSTRAINT `fk_mediaasset_archive_record_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location`(`storage_location_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`mediaasset` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`mediaasset` SET TAGS ('dbx_domain' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Holder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.media_asset.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.media_asset.source_id');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_version.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_version.media_asset_id');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` SET TAGS ('dbx_subdomain' = 'content_processing');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_job_id` SET TAGS ('dbx_business_glossary_term' = 'Ingest Job Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_job_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_job_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.ingest_job_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_job_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.ingest_job_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Created Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.created_asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.created_asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `creative_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `target_format` SET TAGS ('dbx_business_glossary_term' = 'Target Media Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `target_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `target_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.ingest_job.target_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `target_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.ingest_job.target_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `target_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` SET TAGS ('dbx_subdomain' = 'content_processing');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `transcode_job_id` SET TAGS ('dbx_business_glossary_term' = 'Transcode Job Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `transcode_job_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `transcode_job_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.transcode_job_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `transcode_job_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.transcode_job_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Source Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.transcode_job.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.transcode_job.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Output Storage Location Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` SET TAGS ('dbx_subdomain' = 'content_processing');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Inspection ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_inspection_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_inspection_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.qc_inspection_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_inspection_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.qc_inspection_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Version ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.qc_inspection.media_asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.qc_inspection.media_asset_version_id');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` SET TAGS ('dbx_subdomain' = 'asset_registry');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_storage_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Storage Assignment ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_storage_assignment_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_storage_assignment_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.asset_storage_assignment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_storage_assignment_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.asset_storage_assignment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.asset_storage_assignment.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.asset_storage_assignment.media_asset_id');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` SET TAGS ('dbx_subdomain' = 'storage_archival');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_record_id` SET TAGS ('dbx_business_glossary_term' = 'Archive Record Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_record_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_record_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.archive_record_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `archive_record_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.archive_record_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.asset_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.mediaasset.archive_record.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.mediaasset.archive_record.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
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
