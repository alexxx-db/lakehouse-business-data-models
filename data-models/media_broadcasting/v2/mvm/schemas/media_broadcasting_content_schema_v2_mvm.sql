-- Schema for Domain: content | Business: Media_Broadcasting | Version: v2_mvm
-- Generated on: 2026-06-30 06:39:02

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`content` COMMENT 'Single source of truth for all content assets across the enterprise — covering titles, episodes, series, films, clips, music, news segments, and live events. Manages content metadata (EIDR, ISAN, ISRC identifiers), format specifications, versioning, localization, MPA ratings, genre classification, and content lifecycle from acquisition through archival. Serves as the master catalog referenced by scheduling, distribution, rights, and digital asset domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`title` (
    `title_id` BIGINT COMMENT 'Unique identifier for the content title. Primary key for the title master catalog. Serves as the universal join point referenced by scheduling, distribution, rights, digital asset, and advertising domains. | Column title_id (BIGINT) in content.title',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: The title table carries a denormalized content_rating STRING column but lacks a proper FK to the content.rating reference table. Every other major content entity (series, season, content_episode, vers',
    `genre_id` BIGINT COMMENT 'FK to content.genre | Column genre_id (BIGINT) in content.title',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: A titles exploitation is authorized by a specific grant (territory, media type, run count). Rights managers query grants by title for clearance decisions and rights expiry monitoring. Title is the pr',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Every titles distribution rights are governed by license agreements. Broadcast scheduling, windowing decisions, and royalty calculations require knowing which agreement controls each titles exploita | Column license_agreement_id (BIGINT) in rights.title',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Standalone titles (films, specials) require a master media asset reference for broadcast playout scheduling, delivery manifest generation, and QC workflows. content_episode and version have this FK bu',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.rights_holder. Business justification: Tracks who owns/controls rights to each title - essential for royalty payments, clearance workflows, and determining who must approve licensing deals. Rights holder is the starting point for all right | Column primary_rights_holder_id (BIGINT) in rights.title',
    `series_id` BIGINT COMMENT 'Foreign key reference to the parent series for episodic content. Null for standalone films, clips, and non-episodic content. | Column series_id (BIGINT) in content.title',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in content.title',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in content.title',
    `acquisition_date` DATE COMMENT 'Date when the content rights were acquired by the organization. Used for rights lifecycle tracking, amortization calculations, and contract management. | Column acquisition_date (DATE) in content.title',
    `archive_date` DATE COMMENT 'Date when the content was moved to archived status. Used for content lifecycle management and digital asset retention policies. | Column archive_date (DATE) in content.title',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the content. Determines presentation format for broadcast, streaming, and theatrical distribution. | Column aspect_ratio (NUMERIC) in content.title',
    `audio_description_available_flag` BOOLEAN COMMENT 'Indicates whether audio description track is available for visually impaired audiences. Required for accessibility compliance and inclusive broadcasting. | Column audio_description_available_flag (BOOLEAN) in content.title',
    `closed_caption_available_flag` BOOLEAN COMMENT 'Indicates whether closed captioning is available for the content. Required for FCC compliance and accessibility standards. | Column closed_caption_available_flag (BOOLEAN) in content.title',
    `color_format` STRING COMMENT 'Indicates whether the content is in color, black and white, or has been colorized. Used for archival classification and presentation metadata. | Column color_format (STRING) in content.title. Valid values are `color|black_and_white|colorized`',
    `content_status` STRING COMMENT 'Current lifecycle status of the content asset. Determines availability for scheduling, distribution, and monetization. Active content is available for use; archived content is retained but not actively distributed; restricted content has legal or rights limitations. | Column content_status (STRING) in content.title. Valid values are `active|archived|restricted|pending|expired|withdrawn`',
    `content_type` STRING COMMENT 'Discriminator classifying the fundamental type of content asset. Determines applicable business rules for scheduling, rights windowing, and distribution strategies. [ENUM-REF-CANDIDATE: film|series|episode|clip|music|news|live_event|documentary — 8 candidates stripped; promote to reference product] | Column content_type (STRING) in content.title',
    `coppa_child_directed_flag` BOOLEAN COMMENT 'Indicates whether the content is directed to children under 13 years of age. Triggers COPPA compliance requirements for data collection, advertising restrictions, and privacy protections. | Column coppa_child_directed_flag (BOOLEAN) in content.title',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 code representing the country where the content was originally produced. Used for rights management, regulatory compliance, and content origin reporting. | Column country_of_origin (STRING) in content.title. Valid values are `^[A-Z]{3}$`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in content.title',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the title record was first created in the system. Used for audit trails, data lineage tracking, and operational reporting. | Column created_timestamp (TIMESTAMP) in content.title',
    `distributor_name` STRING COMMENT 'Name of the primary distributor or licensor of the content. Used for rights management, financial reconciliation, and contract tracking. | Column distributor_name (STRING) in content.title',
    `dummy_flag` BOOLEAN COMMENT 'Generated flag to ensure model change',
    `eidr_code` STRING COMMENT 'Universal unique identifier for audiovisual content assigned by the Entertainment Identifier Registry. Used for global content identification and rights management across the media supply chain. | Column eidr_code (STRING) in content.title. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `episode_number` STRING COMMENT 'Episode number within the season for episodic content. Null for non-episodic content. Used for sequential ordering in playout and Electronic Program Guide (EPG) systems. | Column episode_number (INT) in content.title',
    `hd_available_flag` BOOLEAN COMMENT 'Indicates whether a high-definition version of the content is available. Used for channel playout decisions and quality-tier distribution strategies. | Column hd_available_flag (BOOLEAN) in content.title',
    `isan` STRING COMMENT 'International standard identifier for audiovisual works. Primarily used for films and television programs for rights management and distribution tracking. | Column isan (STRING) in content.title. Valid values are `^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `isrc` STRING COMMENT 'International standard code for uniquely identifying sound recordings and music video recordings. Used for music tracks and audio content royalty tracking. | Column isrc (STRING) in content.title. Valid values are `^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$`',
    `keywords` STRING COMMENT 'Comma-separated list of keywords and tags describing content themes, subjects, and topics. Used for search optimization, content discovery, and recommendation algorithms. | Column keywords (STRING) in content.title',
    `title_name` STRING COMMENT 'Primary display name of the content title. The human-readable identifier used across all systems and customer-facing platforms. | Column title_name (STRING) in content.title',
    `original_language` STRING COMMENT 'ISO 639-2 three-letter code representing the original language of the content production. Used for localization planning, dubbing, and subtitle workflows. | Column original_language (STRING) in content.title. Valid values are `^[A-Z]{3}$`',
    `original_title` STRING COMMENT 'Original title name in the native language of production. Preserved for rights management, archival, and international distribution purposes. | Column original_title (STRING) in content.title',
    `parental_advisory_flag` BOOLEAN COMMENT 'Indicates whether the content carries a parental advisory warning for explicit content, violence, or mature themes. Used for compliance with broadcast standards and platform content policies. | Column parental_advisory_flag (BOOLEAN) in content.title',
    `premiere_flag` BOOLEAN COMMENT 'Indicates whether the content is a premiere or first-run broadcast. Used for promotional scheduling, advertising premium pricing, and audience measurement reporting. | Column premiere_flag (BOOLEAN) in content.title',
    `production_year` STRING COMMENT 'Calendar year in which the content was originally produced or completed. Used for catalog organization, rights windowing calculations, and archival classification. | Column production_year (INT) in content.title',
    `release_date` DATE COMMENT 'Date when the content was first released to the public or premiered. Used for rights availability calculations, windowing strategies, and anniversary programming. | Column release_date (DATE) in content.title',
    `rights_status` STRING COMMENT 'Current rights availability status indicating whether the content can be legally broadcast or distributed. Drives scheduling decisions and geographic blackout enforcement. | Column rights_status (STRING) in content.title. Valid values are `available|restricted|expired|pending_clearance|blackout`',
    `runtime_seconds` STRING COMMENT 'Total duration of the content in seconds. Used for program scheduling, ad pod allocation, playout automation, and Electronic Program Guide (EPG) generation. | Column runtime_seconds (INT) in content.title',
    `season_number` STRING COMMENT 'Season number within the parent series for episodic content. Null for non-episodic content. Used for catalog organization and Electronic Program Guide (EPG) display. | Column season_number (INT) in content.title',
    `source_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in content.title',
    `studio_name` STRING COMMENT 'Name of the studio or production company that produced the content. Used for rights attribution, royalty calculations, and catalog organization. | Column studio_name (STRING) in content.title',
    `sub_genre` STRING COMMENT 'Secondary or more granular genre classification providing additional content categorization for advanced audience segmentation and personalization. | Column sub_genre (STRING) in content.title',
    `synopsis_long` STRING COMMENT 'Detailed narrative description of the content. Used for promotional materials, streaming platform detail pages, and comprehensive program guides. | Column synopsis_long (STRING) in content.title',
    `synopsis_short` STRING COMMENT 'Brief summary of the content, typically 50-100 characters. Used for Electronic Program Guide (EPG) listings, mobile applications, and quick reference displays. | Column synopsis_short (STRING) in content.title',
    `theatrical_release_flag` BOOLEAN COMMENT 'Indicates whether the content had a theatrical release. Used for windowing strategy, rights holdback periods, and marketing classification. | Column theatrical_release_flag (BOOLEAN) in content.title',
    `uhd_4k_available_flag` BOOLEAN COMMENT 'Indicates whether an Ultra HD 4K version of the content is available. Used for premium streaming tiers and next-generation broadcast services. | Column uhd_4k_available_flag (BOOLEAN) in content.title',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in content.title',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the title record was last modified. Used for change tracking, data synchronization, and audit compliance. | Column updated_timestamp (TIMESTAMP) in content.title',
    CONSTRAINT pk_title PRIMARY KEY(`title_id`)
) COMMENT 'Master catalog record for every content asset across the enterprise — films, series, episodes, clips, music tracks, news segments, and live events. Serves as the authoritative SSOT for content identity, carrying EIDR, ISAN, and ISRC identifiers, MPA content rating, genre classification, original language, country of origin, production year, content type discriminator (film/series/episode/clip/music/news/live), runtime in seconds, content status (active/archived/restricted), parental advisory flags, COPPA child-directed flag, and lifecycle timestamps. Acts as the universal join point referenced by scheduling, distribution, rights, digital asset, and advertising domains. Format-level technical specifications are managed by the version and digital asset domains. | Unity Catalog table: media_broadcasting_ecm.content.title Aligned with EBU CCDM Tech 3351 (http://www.ebu.ch/metadata/ontologies/ebucore).';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`series` (
    `series_id` BIGINT COMMENT 'Unique identifier for the series. Primary key for the series master record. | Column series_id (BIGINT) in content.series',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Series have content ratings. Normalizes content_rating string column to reference the enterprise rating taxonomy. | Column content_rating_id (BIGINT) in content.series',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: audience.series.target_demographic is a denormalized plain-text column. Normalizing to audience.demographic_segment enables proper series-to-audience targeting for ad sales, scheduling decisions, and N',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Series have genre classification. Normalizes genre_primary/genre_secondary string columns to reference the enterprise genre taxonomy. | Column genre_id (BIGINT) in content.series',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Series-level grants are standard in syndication and SVOD deals (e.g., Netflix licenses an entire series). Rights compliance reports and windowing strategy decisions require the series-to-grant link. S',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Series-level rights deals are standard in TV distribution. Multi-season acquisitions and franchise licensing require tracking which agreement governs the entire series for royalty allocation and clear | Column license_agreement_id (BIGINT) in rights.series',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.rights_holder. Business justification: Series-level rights ownership (studio/production company) drives all downstream licensing and royalty flows. Franchise management and multi-season deal negotiations require knowing the primary rights  | Column primary_rights_holder_id (BIGINT) in rights.series',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Showrunner/creator identification for WGA credits and series-level backend participation deals — series backend participation calculations and WGA separated rights determinations require the primary c',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in content.series',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in content.series',
    `archive_location` STRING COMMENT 'Physical or logical location identifier where the series master content and metadata are archived. Used for Digital Asset Management (DAM) and Media Asset Management (MAM) retrieval. | Column archive_location (STRING) in content.series',
    `aspect_ratio` STRING COMMENT 'Standard aspect ratio for the series video format. Critical for playout configuration, transcoding workflows, and multi-platform distribution. | Column aspect_ratio (NUMERIC) in content.series',
    `audio_description_available` BOOLEAN COMMENT 'Indicates whether audio description track is available for visually impaired viewers. Required for accessibility compliance in many jurisdictions. | Column audio_description_available (BOOLEAN) in content.series',
    `audio_format` STRING COMMENT 'Standard audio format and channel configuration for the series. Determines audio encoding requirements for distribution and playout. | Column audio_format (STRING) in content.series. Valid values are `stereo|surround_5_1|surround_7_1|dolby_atmos|dts_x`',
    `closed_caption_available` BOOLEAN COMMENT 'Indicates whether closed captioning is available for the series. Required for regulatory compliance under FCC accessibility rules and international broadcasting standards. | Column closed_caption_available (BOOLEAN) in content.series',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the series was originally produced. Used for content quotas, regulatory compliance, and international rights management. | Column country_of_origin (STRING) in content.series. Valid values are `^[A-Z]{3}$`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in content.series',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the series record was first created in the system. Used for audit trail and data lineage tracking. | Column created_timestamp (TIMESTAMP) in content.series',
    `distributor` STRING COMMENT 'Name of the distribution company responsible for licensing and distributing the series to secondary markets and platforms. | Column distributor (STRING) in content.series',
    `dummy_flag` BOOLEAN COMMENT 'Generated flag to ensure model change',
    `eidr_code` STRING COMMENT 'Universal unique identifier for the series registered with EIDR. Enables global content identification and rights management across the entertainment industry supply chain. | Column eidr_code (STRING) in content.series. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `episode_runtime_minutes` STRING COMMENT 'Standard runtime duration in minutes for a typical episode of the series, excluding commercials. Used for scheduling, ad pod planning, and playout automation. | Column episode_runtime_minutes (INT) in content.series',
    `finale_date` DATE COMMENT 'Date when the final episode of the series aired or was released. Null for ongoing series. Used for syndication eligibility and rights holdback period calculations. | Column finale_date (DATE) in content.series',
    `franchise_name` STRING COMMENT 'Brand name of the content franchise or show brand. Used for grouping related series, spin-offs, and reboots under a common brand umbrella. | Column franchise_name (STRING) in content.series',
    `hdr_format` STRING COMMENT 'High Dynamic Range format specification for the series. Impacts content delivery network configuration and device compatibility. | Column hdr_format (STRING) in content.series. Valid values are `SDR|HDR10|HDR10_PLUS|DOLBY_VISION|HLG`',
    `isan_code` STRING COMMENT 'International standard audiovisual number for the series. Used for audiovisual work identification in rights management and distribution. | Column isan_code (STRING) in content.series. Valid values are `^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `keywords` STRING COMMENT 'Comma-separated list of searchable keywords and tags for content discovery, Electronic Program Guide (EPG) search, and recommendation engine optimization. | Column keywords (STRING) in content.series',
    `language_original` STRING COMMENT 'ISO 639-3 three-letter code for the original production language of the series. Used for localization planning and international distribution. | Column language_original (STRING) in content.series. Valid values are `^[a-z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the series record was last modified. Used for change tracking, audit compliance, and data synchronization across systems. | Column modified_timestamp (TIMESTAMP) in content.series',
    `news_wire_source` STRING COMMENT 'Wire agency source code for news series per VREQ-019',
    `original_network` STRING COMMENT 'Name of the original broadcast network or streaming platform that first aired or released the series. Critical for rights management and syndication deals. | Column original_network (STRING) in content.series',
    `premiere_date` DATE COMMENT 'Date when the first episode of the series originally aired or was released. Marks the beginning of the series lifecycle and is used for rights windowing calculations. | Column premiere_date (DATE) in content.series',
    `production_company` STRING COMMENT 'Name of the primary production company or studio that produced the series. Critical for rights ownership, residuals calculations, and syndication negotiations. | Column production_company (STRING) in content.series',
    `resolution_standard` STRING COMMENT 'Standard video resolution for the series master content. Determines transcoding requirements and Adaptive Bitrate (ABR) streaming profile generation. | Column resolution_standard (STRING) in content.series. Valid values are `SD|HD|FHD|UHD|4K|8K`',
    `series_status` STRING COMMENT 'Current lifecycle status of the series. Indicates whether the series is actively producing new content, has concluded, or is temporarily paused. | Column series_status (STRING) in content.series. Valid values are `ongoing|ended|cancelled|hiatus|in_development|pre_production`',
    `series_type` STRING COMMENT 'Classification of the series format and production style. Determines scheduling strategy, audience targeting, and production workflow. [ENUM-REF-CANDIDATE: scripted|unscripted|documentary|news|sports|reality|talk_show|game_show|variety|animated|miniseries|anthology — 12 candidates stripped; promote to reference product] | Column series_type (STRING) in content.series',
    `source_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in content.series',
    `syndication_eligible` BOOLEAN COMMENT 'Indicates whether the series meets the minimum episode threshold and rights clearance requirements for syndication to secondary markets and broadcast stations. | Column syndication_eligible (BOOLEAN) in content.series',
    `synopsis_long` STRING COMMENT 'Detailed multi-paragraph description of the series premise, themes, and narrative arc. Used for marketing materials, press releases, and content catalogs. | Column synopsis_long (STRING) in content.series',
    `synopsis_short` STRING COMMENT 'Brief one-sentence description of the series premise. Used for Electronic Program Guide (EPG) listings, mobile applications, and social media promotion. | Column synopsis_short (STRING) in content.series',
    `title` STRING COMMENT 'Official title of the series as registered and marketed. Primary human-readable identifier for the content franchise. | Column title (STRING) in content.series',
    `title_original` STRING COMMENT 'Original title of the series in its native language and market before localization or translation. | Column title_original (STRING) in content.series',
    `total_episode_count` STRING COMMENT 'Cumulative count of all episodes produced across all seasons. Includes specials and pilot episodes. | Column total_episode_count (INT) in content.series',
    `total_season_count` STRING COMMENT 'Total number of seasons produced for the series to date. Updated as new seasons are commissioned and produced. | Column total_season_count (INT) in content.series',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in content.series',
    CONSTRAINT pk_series PRIMARY KEY(`series_id`)
) COMMENT 'Master record for a serialized content franchise or show brand — the parent container above seasons and episodes. Captures series title, franchise identifier, series type (scripted/unscripted/documentary/news/sports/reality), total season count, original network/platform, premiere date, finale date, series status (ongoing/ended/cancelled/hiatus), genre taxonomy, target demographic, content rating band, and brand metadata. Enables hierarchical content navigation from series → season → episode and supports scheduling, rights windowing, and syndication deal structures. | Unity Catalog table: media_broadcasting_ecm.content.series Aligned with EBU CCDM (Tech 3351) Class Conceptual Data Model semantics.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`season` (
    `season_id` BIGINT COMMENT 'Unique identifier for the season record. Primary key. | Column season_id (BIGINT) in content.season',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Seasons have content ratings. Normalizes content_rating string column to reference the enterprise rating taxonomy. | Column content_rating_id (BIGINT) in content.season',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Seasons have genre classification. Normalizes genre_primary/genre_secondary string columns to reference the enterprise genre taxonomy. | Column genre_id (BIGINT) in content.season',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: TV licensing commonly grants rights at the season level (e.g., broadcaster licenses Season 2 for 3 runs in a territory). Season scheduling, rights expiry alerts, and holdback enforcement all require t',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Season-specific licensing (e.g., Season 1 to Netflix, Season 2 to Hulu) is common in streaming. Clearance and windowing decisions require knowing which agreement controls each seasons distribution ri | Column license_agreement_id (BIGINT) in rights.season',
    `media_asset_id` BIGINT COMMENT 'Reference to the season trailer asset in the MAM system. Used for promotional campaigns and platform previews. | Column media_asset_id (BIGINT) in mediaasset.season',
    `holder_id` BIGINT COMMENT 'FK to rights holder, normalizing the denormalized rights_holder column | Column primary_rights_holder_id (BIGINT) in rights.season',
    `series_id` BIGINT COMMENT 'Reference to the parent series to which this season belongs. | Column series_id (BIGINT) in content.season',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in content.season',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in content.season',
    `archive_date` DATE COMMENT 'Date when the season was moved to archival storage. Used for asset lifecycle management and retrieval planning. | Column archive_date (DATE) in content.season',
    `archive_location` STRING COMMENT 'Physical or digital archive location where the seasons master assets are stored. Critical for long-term preservation and retrieval. | Column archive_location (STRING) in content.season',
    `awards_nominated` STRING COMMENT 'Comma-separated list of major award nominations received by the season. Supports promotional messaging and content valuation. | Column awards_nominated (STRING) in content.season',
    `awards_won` STRING COMMENT 'Comma-separated list of major awards won by the season (e.g., Emmy, Golden Globe). Used for marketing and promotional value enhancement. | Column awards_won (STRING) in content.season',
    `banner_artwork_url` STRING COMMENT 'URL reference to the seasons banner or hero image for wide-format displays on streaming platforms and websites. | Column banner_artwork_url (STRING) in content.season',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in content.season',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the season record was first created in the system. Used for audit trail and data lineage. | Column created_timestamp (TIMESTAMP) in content.season',
    `distributor` STRING COMMENT 'Name of the primary distributor handling the seasons commercial distribution. Key for carriage agreements and revenue sharing. | Column distributor (STRING) in content.season',
    `dummy_flag` BOOLEAN COMMENT 'Generated flag to ensure model change',
    `eidr` STRING COMMENT 'Globally unique EIDR identifier for the season, enabling cross-platform content identification and rights management. | Column eidr (STRING) in content.season. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `episode_count_aired` STRING COMMENT 'Number of episodes that have been broadcast or released to audiences. Used for tracking release progress. | Column episode_count_aired (INT) in content.season',
    `episode_count_ordered` STRING COMMENT 'Number of episodes originally ordered or commissioned for this season by the network or platform. | Column episode_count_ordered (INT) in content.season',
    `episode_count_produced` STRING COMMENT 'Actual number of episodes produced and delivered for this season. May differ from ordered count due to production changes. | Column episode_count_produced (INT) in content.season',
    `finale_date` DATE COMMENT 'Date when the final episode of the season was broadcast or released. Marks the end of the seasons linear run. | Column finale_date (DATE) in content.season',
    `isan` STRING COMMENT 'International standard identifier for audiovisual works, used for season-level identification in global distribution and rights management. | Column isan (STRING) in content.season. Valid values are `^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `language_original` STRING COMMENT 'ISO 639-3 three-letter code for the original production language of the season. Critical for localization and distribution planning. | Column language_original (STRING) in content.season. Valid values are `^[a-z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the season record was last modified. Supports change tracking and audit compliance. | Column modified_timestamp (TIMESTAMP) in content.season',
    `network_original` STRING COMMENT 'Name of the network or platform that originally commissioned or first aired the season. Used for windowing and exclusivity tracking. | Column network_original (STRING) in content.season',
    `original_air_date` DATE COMMENT 'Date when the first episode of the season was originally broadcast or released. Key for windowing and rights calculations. | Column original_air_date (DATE) in content.season',
    `poster_artwork_url` STRING COMMENT 'URL reference to the seasons primary poster artwork stored in the Media Asset Management (MAM) system. Used for EPG, VOD, and promotional displays. | Column poster_artwork_url (STRING) in content.season',
    `production_company` STRING COMMENT 'Name of the primary production company responsible for creating the season. Used for rights attribution and royalty calculations. | Column production_company (STRING) in content.season',
    `production_year` STRING COMMENT 'Calendar year in which the season was produced. Used for cataloging, rights management, and archival purposes. | Column production_year (INT) in content.season',
    `rights_expiry_date` DATE COMMENT 'Date when current distribution rights for the season expire. Triggers rights renewal workflows and availability restrictions. | Column rights_expiry_date (DATE) in content.season',
    `rights_holder` STRING COMMENT 'Name of the entity holding primary distribution and exploitation rights for the season. Essential for clearance and licensing. | Column rights_holder (STRING) in content.season',
    `rights_territory` STRING COMMENT 'Geographic territories where distribution rights are held, using ISO 3166-1 alpha-3 country codes or regional groupings. Critical for windowing and blackout enforcement. | Column rights_territory (STRING) in content.season',
    `season_number` STRING COMMENT 'Sequential number of the season within the series (e.g., 1 for Season 1, 2 for Season 2). Used for ordering and identification. | Column season_number (INT) in content.season',
    `season_status` STRING COMMENT 'Current lifecycle status of the season. Tracks progression from development through archival or cancellation. [ENUM-REF-CANDIDATE: in-development|in-production|post-production|completed|airing|aired|archived|cancelled — 8 candidates stripped; promote to reference product] | Column season_status (STRING) in content.season',
    `source_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in content.season',
    `synopsis_long` STRING COMMENT 'Detailed season-level synopsis providing comprehensive narrative overview. Used for promotional materials, VOD platforms, and press releases. | Column synopsis_long (STRING) in content.season',
    `synopsis_short` STRING COMMENT 'Brief season-level synopsis (typically 50-150 characters) used for Electronic Program Guide (EPG) listings and mobile displays. | Column synopsis_short (STRING) in content.season',
    `title` STRING COMMENT 'Official title or name of the season. May include thematic or marketing names (e.g., The Final Season, Season of Secrets). | Column title (STRING) in content.season',
    `total_runtime_minutes` STRING COMMENT 'Cumulative runtime of all episodes in the season, measured in minutes. Used for scheduling blocks and VOD packaging. | Column total_runtime_minutes (INT) in content.season',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in content.season',
    CONSTRAINT pk_season PRIMARY KEY(`season_id`)
) COMMENT 'Master record representing a discrete production cycle of a series, grouping episodes into an ordered season. Tracks season number, season title, episode count (ordered and total), production year, original air year, season status (in-production/completed/archived), season-level content rating, season-level synopsis, and promotional artwork references. Bridges the series-to-episode hierarchy and supports season-level rights licensing, scheduling blocks, and VOD packaging. | Unity Catalog table: media_broadcasting_ecm.content.season Aligned with EBU CCDM (Tech 3351) Class Conceptual Data Model semantics.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` (
    `content_episode_id` BIGINT COMMENT 'Unique identifier for the episode within the content management system. Primary key for the content episode entity. | Column content_episode_id (BIGINT) in content.content_episode',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Episodes have content ratings (TV-PG, TV-MA). Normalizes content_rating string column to reference the enterprise rating taxonomy. | Column content_rating_id (BIGINT) in content.content_episode',
    `season_id` BIGINT COMMENT 'Reference to the specific season within the series to which this episode belongs. Enables season-level grouping and rights management. | Column content_season_id (BIGINT) in content.content_episode',
    `series_id` BIGINT COMMENT 'Reference to the parent series to which this episode belongs. Links episode to its series container. | Column content_series_id (BIGINT) in content.content_episode',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Episodes have genre classification. Normalizes genre_primary/genre_secondary string columns to reference the enterprise genre taxonomy. | Column genre_id (BIGINT) in content.content_episode',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Episode-level rights clearance and scheduling require knowing which specific grant authorizes each episodes broadcast. Rights operations teams run episode-by-grant clearance reports daily; the grant ',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Episode-level syndication deals (especially for high-value episodes like finales or specials) require direct linkage to license agreements for run-count tracking and residual calculations. | Column license_agreement_id (BIGINT) in rights.content_episode',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Broadcast playout and VOD distribution require direct lookup of the master media asset file for each episode. Traffic systems and playout automation depend on episode-to-asset mapping for scheduling a | Column master_media_asset_id (BIGINT) in mediaasset.content_episode',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Episodes ARE titles in the master catalog. Every episode should reference its title record for unified content identification and metadata management. | Column title_id (BIGINT) in content.content_episode',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in content.content_episode',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in content.content_episode',
    `archive_date` DATE COMMENT 'Date when the episode master was moved to long-term archive storage. Used for asset lifecycle management and storage optimization. | Column archive_date (DATE) in content.content_episode',
    `archive_location` STRING COMMENT 'Physical or logical location identifier for the archived master copy in the Media Asset Management (MAM) system. Supports long-term preservation and retrieval. | Column archive_location (STRING) in content.content_episode',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the episode video. Affects playout configuration, transcoding profiles, and distribution format specifications. | Column aspect_ratio (NUMERIC) in content.content_episode',
    `audio_description_available` BOOLEAN COMMENT 'Indicates whether audio description track is available for visually impaired viewers. Required for accessibility compliance. | Column audio_description_available (BOOLEAN) in content.content_episode',
    `audio_format` STRING COMMENT 'Audio channel configuration and encoding format. Affects playout system configuration and premium content positioning. | Column audio_format (STRING) in content.content_episode. Valid values are `stereo|5.1|7.1|dolby_atmos|dts_x`',
    `breaking_news_flag` BOOLEAN COMMENT 'Indicates if episode is breaking news content per VREQ-019',
    `broadcast_count` STRING COMMENT 'Total number of times this episode has been broadcast on linear television. Used for residuals calculation and syndication rights management. | Column broadcast_count (INT) in content.content_episode',
    `closed_caption_available` BOOLEAN COMMENT 'Indicates whether closed captioning is available for this episode. Required for FCC compliance and accessibility standards. | Column closed_caption_available (BOOLEAN) in content.content_episode',
    `content_advisory` STRING COMMENT 'Specific content warnings or advisories for viewer guidance (e.g., violence, language, adult themes). Displayed in Electronic Program Guide (EPG) and Video On Demand (VOD) interfaces. | Column content_advisory (STRING) in content.content_episode',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in content.content_episode',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the episode record was first created in the content management system. Used for audit trail and data lineage tracking. | Column created_timestamp (TIMESTAMP) in content.content_episode',
    `dummy_flag` BOOLEAN COMMENT 'Generated flag to ensure model change',
    `eidr_identifier` STRING COMMENT 'Globally unique identifier for the episode registered with the Entertainment Identifier Registry. Enables universal content identification across distribution platforms and rights management systems. | Column eidr_identifier (STRING) in content.content_episode. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `episode_number` STRING COMMENT 'Sequential number of the episode within its season. Used for ordering and identification in Electronic Program Guide (EPG) and Video On Demand (VOD) catalogs. | Column episode_number (INT) in content.content_episode',
    `episode_status` STRING COMMENT 'Current lifecycle state of the episode. Determines availability for scheduling, playout automation, and distribution to Over-The-Top (OTT) platforms. | Column episode_status (STRING) in content.content_episode. Valid values are `in_production|post_production|ready_for_broadcast|aired|archived|withdrawn`',
    `episode_type` STRING COMMENT 'Classification of the episode format and purpose within the series. Affects scheduling strategy, promotional treatment, and rights valuation. [ENUM-REF-CANDIDATE: standard|special|pilot|finale|recap|bonus|behind_the_scenes — 7 candidates stripped; promote to reference product] | Column episode_type (STRING) in content.content_episode',
    `keywords` STRING COMMENT 'Comma-separated list of keywords and tags describing episode themes, topics, and notable elements. Supports content search, discovery, and metadata enrichment. | Column keywords (STRING) in content.content_episode',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the episode record was last modified. Supports change tracking and data quality monitoring. | Column modified_timestamp (TIMESTAMP) in content.content_episode',
    `music_cue_sheet_submitted` BOOLEAN COMMENT 'Indicates whether the music cue sheet has been submitted for royalty collection. Required for music rights compliance and royalty distribution. | Column music_cue_sheet_submitted (BOOLEAN) in content.content_episode',
    `original_air_date` DATE COMMENT 'The date when the episode was first broadcast on linear television. Critical for rights windowing, residuals calculation, and syndication eligibility. | Column original_air_date (DATE) in content.content_episode',
    `premiere_flag` BOOLEAN COMMENT 'Indicates whether this is a premiere episode (first broadcast). Used for promotional planning, upfront advertising sales, and Nielsen sweeps period strategy. | Column premiere_flag (BOOLEAN) in content.content_episode',
    `primary_language` STRING COMMENT 'ISO 639-3 three-letter code for the primary audio language of the episode. Used for content cataloging, rights clearance, and distribution targeting. | Column primary_language (STRING) in content.content_episode. Valid values are `^[a-z]{3}$`',
    `production_code` STRING COMMENT 'Internal production identifier assigned during content creation. Used for tracking production workflow, post-production tasks, and archival reference. | Column production_code (STRING) in content.content_episode',
    `rerun_flag` BOOLEAN COMMENT 'Indicates whether this broadcast is a rerun. Affects advertising rates, Cost Per Rating Point (CPRP) calculations, and residuals payments to talent. | Column rerun_flag (BOOLEAN) in content.content_episode',
    `rights_clearance_status` STRING COMMENT 'Current status of rights clearance for broadcast and distribution. Determines whether episode can be scheduled for playout or made available on Over-The-Top (OTT) platforms. | Column rights_clearance_status (STRING) in content.content_episode. Valid values are `cleared|pending|restricted|expired`',
    `runtime_seconds` STRING COMMENT 'Total duration of the episode content in seconds, excluding commercial breaks. Used for playout scheduling, ad pod allocation, and Electronic Program Guide (EPG) display. | Column runtime_seconds (INT) in content.content_episode',
    `runtime_with_ads_seconds` STRING COMMENT 'Total broadcast duration including commercial ad breaks. Used for linear scheduling and daypart planning. | Column runtime_with_ads_seconds (INT) in content.content_episode',
    `source_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in content.content_episode',
    `subtitles_available` BOOLEAN COMMENT 'Indicates whether subtitle tracks are available for this episode. Supports international distribution and localization strategies. | Column subtitles_available (BOOLEAN) in content.content_episode',
    `synopsis_long` STRING COMMENT 'Detailed description of the episode plot, themes, and key moments. Used for Video On Demand (VOD) platforms, promotional materials, and content discovery. | Column synopsis_long (STRING) in content.content_episode',
    `synopsis_short` STRING COMMENT 'Brief summary of the episode content, typically 50-100 characters. Used for Electronic Program Guide (EPG) listings and mobile applications with limited display space. | Column synopsis_short (STRING) in content.content_episode',
    `title` STRING COMMENT 'The official title or name of the episode. Displayed in Electronic Program Guide (EPG), Video On Demand (VOD) interfaces, and promotional materials. | Column title (STRING) in content.content_episode',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in content.content_episode',
    `video_resolution` STRING COMMENT 'Maximum video resolution available for this episode. Determines distribution channel eligibility and Adaptive Bitrate Streaming (ABR) profile selection. | Column video_resolution (STRING) in content.content_episode. Valid values are `SD|HD|FHD|UHD|4K|8K`',
    `vod_available_from_date` DATE COMMENT 'Date when the episode becomes available on Video On Demand (VOD) platforms. Part of windowing strategy and rights holdback management. | Column vod_available_from_date (DATE) in content.content_episode',
    `vod_available_until_date` DATE COMMENT 'Date when the episode is removed from Video On Demand (VOD) platforms. Enforces rights windows and exclusivity periods. | Column vod_available_until_date (DATE) in content.content_episode',
    CONSTRAINT pk_content_episode PRIMARY KEY(`content_episode_id`)
) COMMENT 'Master record for an individual episode within a series season. Captures episode number, episode title, production code, original broadcast date, runtime, episode type (standard/special/pilot/finale/recap), episode synopsis, content rating, EIDR episode identifier, closed-caption availability flag, audio description flag, and episode status. Supports EPG scheduling, VOD availability windows, rights clearance at episode level, and residuals calculation for talent reuse payments. SSOT for episode content metadata. Production.production_episode references this for production workflow. | Unity Catalog table: media_broadcasting_ecm.content.content_episode Aligned with EBU CCDM (Tech 3351) Class Conceptual Data Model semantics.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`version` (
    `version_id` BIGINT COMMENT 'Primary key for version | Column version_id (BIGINT) in content.version',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Versions have MPA and TV ratings. Normalizes mpa_rating/tv_rating string columns to reference the enterprise rating taxonomy. | Column content_rating_id (BIGINT) in content.version',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Version-specific grants (4K rights vs HD rights, dubbed vs subtitled) are tracked separately in modern distribution. Clearance systems must validate that the specific version has an active grant. | Column grant_id (BIGINT) in rights.version',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Different versions (theatrical cut, directors cut, TV edit, international dub) often have separate rights agreements with distinct terms. Clearance and distribution workflows require version-specific | Column license_agreement_id (BIGINT) in rights.version',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Each content version (territory/platform-specific cut) references its master media asset for distribution. Fulfillment workflows require version-to-asset mapping to deliver correct files to platforms  | Column master_media_asset_id (BIGINT) in mediaasset.version',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Content versions are encoded with platform-specific DRM, codec, and resolution requirements. Linking version to ott_platform enables platform-specific versioning workflows, QC sign-off per platform, a',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: A content version corresponds to a specific production episodes output (e.g., directors cut, broadcast master). Direct FK enables episode-level version lineage for delivery, archive, and QC traceabi',
    `project_id` BIGINT COMMENT 'Foreign key linking to production.project. Business justification: For original productions, a content version is created by a specific production project. Linking version to project enables production cost allocation to specific deliverable versions, QC workflow ini',
    `title_id` BIGINT COMMENT 'Reference to the master content asset (title, episode, series, film, clip, music, news segment, or live event) that this version belongs to. | Column title_id (BIGINT) in content.version',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in content.version',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in content.version',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this version was approved for distribution and playout. | Column approved_timestamp (TIMESTAMP) in content.version',
    `archived_timestamp` TIMESTAMP COMMENT 'Timestamp when this version was moved to long-term archive storage. | Column archived_timestamp (TIMESTAMP) in content.version',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of this version (e.g., 16:9, 4:3, 21:9, 2.39:1). | Column aspect_ratio (NUMERIC) in content.version',
    `audio_codec` STRING COMMENT 'Audio compression codec used for this version (e.g., AAC, AC-3, E-AC-3, Dolby Atmos, DTS). | Column audio_codec (STRING) in content.version',
    `audio_description_available` BOOLEAN COMMENT 'Indicates whether audio description track is available for visually impaired audiences, supporting accessibility compliance. | Column audio_description_available (BOOLEAN) in content.version',
    `audio_track_configuration` STRING COMMENT 'Comma-separated list of audio track languages and types available in this version (e.g., en:stereo,es:5.1,fr:stereo,en:descriptive). | Column audio_track_configuration (STRING) in content.version',
    `broadcast_safe` BOOLEAN COMMENT 'Indicates whether this version has been certified as broadcast-safe, meeting technical standards for linear transmission (audio levels, video levels, closed captioning). | Column broadcast_safe (BOOLEAN) in content.version',
    `checksum_md5` STRING COMMENT 'MD5 hash checksum of the version file, used for integrity verification during transfer and archival. | Column checksum_md5 (STRING) in content.version. Valid values are `^[a-f0-9]{32}$`',
    `closed_caption_available` BOOLEAN COMMENT 'Indicates whether closed captioning (CC) is available for this version, supporting accessibility compliance. | Column closed_caption_available (BOOLEAN) in content.version',
    `color_space` STRING COMMENT 'Color space standard used for this version (Rec. 709, Rec. 2020, DCI-P3, sRGB). | Column color_space (STRING) in content.version. Valid values are `rec_709|rec_2020|dci_p3|srgb`',
    `content_advisory` STRING COMMENT 'Comma-separated list of content advisory flags for this version (e.g., violence, language, sexual_content, drug_use, nudity). | Column content_advisory (STRING) in content.version',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in content.version',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this version record was first created in the system. | Column created_timestamp (TIMESTAMP) in content.version',
    `dummy_flag` BOOLEAN COMMENT 'Generated flag to ensure model change',
    `editorial_workflow_state` STRING COMMENT 'Current editorial workflow state (draft/assigned/filed/edited/cleared/published) per VREQ-019',
    `eidr_code` STRING COMMENT 'Unique EIDR identifier for this specific version, enabling global content identification and rights management. | Column eidr_code (STRING) in content.version. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `file_format` STRING COMMENT 'Container file format for this version (e.g., MP4, MXF, MOV, TS, WebM). | Column file_format (STRING) in content.version',
    `file_size_bytes` BIGINT COMMENT 'Total file size of this version in bytes, used for storage planning and delivery bandwidth estimation. | Column file_size_bytes (BIGINT) in content.version',
    `frame_rate` DECIMAL(18,2) COMMENT 'Frame rate of this version in frames per second (e.g., 23.98, 24.00, 25.00, 29.97, 30.00, 50.00, 59.94, 60.00). | Column frame_rate (DECIMAL(5,2)) in content.version',
    `hdr_format` STRING COMMENT 'High Dynamic Range format used for this version (SDR, HDR10, HDR10+, Dolby Vision, HLG). | Column hdr_format (STRING) in content.version. Valid values are `sdr|hdr10|hdr10_plus|dolby_vision|hlg`',
    `isan_code` STRING COMMENT 'International Standard Audiovisual Number uniquely identifying this audiovisual work version. | Column isan_code (STRING) in content.version. Valid values are `^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `isrc_code` STRING COMMENT 'International Standard Recording Code for music or audio content versions, enabling tracking and royalty distribution. | Column isrc_code (STRING) in content.version. Valid values are `^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$`',
    `label` STRING COMMENT 'Human-readable label identifying this version (e.g., Theatrical Cut, Directors Cut, Broadcast Safe, Spanish Dub, UK Censored). | Column label (STRING) in content.version',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this version record was last modified. | Column modified_timestamp (TIMESTAMP) in content.version',
    `primary_language_code` STRING COMMENT 'ISO 639 two or three-letter code for the primary audio language of this version (e.g., en, es, fr). | Column primary_language_code (STRING) in content.version. Valid values are `^[a-z]{2,3}$`',
    `qc_completed_date` DATE COMMENT 'Date when quality control review was completed for this version. | Column qc_completed_date (DATE) in content.version',
    `qc_status` STRING COMMENT 'Quality control review status for this version, indicating whether it has passed technical and content quality checks. | Column qc_status (STRING) in content.version. Valid values are `not_started|in_progress|passed|failed|conditional_pass`',
    `resolution` STRING COMMENT 'Video resolution classification for this version (SD, HD 720p, HD 1080p, UHD 4K, UHD 8K). | Column resolution (STRING) in content.version. Valid values are `sd|hd_720p|hd_1080p|uhd_4k|uhd_8k`',
    `runtime_delta_seconds` STRING COMMENT 'Difference in runtime (in seconds) between this version and the master version. Positive values indicate longer runtime, negative indicate shorter. | Column runtime_delta_seconds (INT) in content.version',
    `runtime_seconds` STRING COMMENT 'Total runtime of this version in seconds, representing the complete playback duration. | Column runtime_seconds (INT) in content.version',
    `source_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in content.version',
    `storage_location` STRING COMMENT 'Physical or logical storage location identifier where this version is archived (e.g., tape library ID, cloud bucket path, MAM archive reference). | Column storage_location (STRING) in content.version',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of ISO 639 language codes for subtitle tracks included in this version (e.g., en,es,fr,de). | Column subtitle_languages (STRING) in content.version',
    `target_territory` STRING COMMENT 'Three-letter ISO country code indicating the primary geographic territory this version is intended for (e.g., USA, GBR, FRA). | Column target_territory (STRING) in content.version. Valid values are `^[A-Z]{3}$`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in content.version',
    `version_status` STRING COMMENT 'Current lifecycle status of the version indicating its readiness for distribution and playout. [ENUM-REF-CANDIDATE: draft|in_production|qc_pending|approved|active|archived|deprecated|rejected — 8 candidates stripped; promote to reference product] | Column version_status (STRING) in content.version',
    `version_type` STRING COMMENT 'Classification of the version type indicating the nature of the edit or adaptation. [ENUM-REF-CANDIDATE: theatrical|broadcast|director|extended|unrated|censored|dubbed|subtitled|localized|preview|trailer — 11 candidates stripped; promote to reference product] | Column version_type (STRING) in content.version',
    `video_codec` STRING COMMENT 'Video compression codec used for this version (e.g., H.264, H.265/HEVC, VP9, AV1, MPEG-2). | Column video_codec (STRING) in content.version',
    CONSTRAINT pk_version PRIMARY KEY(`version_id`)
) COMMENT 'Tracks every distinct version of a title — including edits, cuts, localized dubs, censored versions, broadcast-safe edits, theatrical vs. extended cuts, and format variants (SD/HD/4K). Each version record carries version type (theatrical/broadcast/director/unrated/censored/dubbed/subtitled), version label, target territory, target platform, runtime delta from master, language track configuration, subtitle language list, aspect ratio override, and version status. Enables multi-platform distribution where different versions are delivered to different windows and territories. | Unity Catalog table: media_broadcasting_ecm.content.version Aligned with EBU CCDM Tech 3351 (http://www.ebu.ch/metadata/ontologies/ebucore).';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`genre` (
    `genre_id` BIGINT COMMENT 'Unique identifier for the genre. Primary key for the genre reference taxonomy. | Column genre_id (BIGINT) in content.genre',
    `parent_genre_id` BIGINT COMMENT 'Reference to the parent genre in the hierarchical taxonomy, enabling multi-level classification such as Drama > Legal Drama or Sports > Football. Null for top-level genres. | Column parent_genre_id (BIGINT) in content.genre',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in content.genre',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in content.genre',
    `ad_pod_compatibility` BOOLEAN COMMENT 'Indicates whether content in this genre is compatible with Dynamic Ad Insertion (DAI) and ad pod placement. False for genres requiring uninterrupted viewing (e.g., live sports critical moments, news breaking coverage). | Column ad_pod_compatibility (BOOLEAN) in content.genre',
    `applicable_content_types` STRING COMMENT 'Comma-separated list of content types to which this genre applies (e.g., series, film, clip, live_event, news_segment, music_video). Enables content-type-specific genre filtering. | Column applicable_content_types (STRING) in content.genre',
    `archive_retention_policy` STRING COMMENT 'Digital asset archival retention policy for content in this genre. Permanent retention for high-value evergreen genres; short-term for time-sensitive news and event content. | Column archive_retention_policy (STRING) in content.genre. Valid values are `permanent|long_term|standard|short_term`',
    `avod_monetization_potential` STRING COMMENT 'Revenue generation potential for this genre on Advertising-Supported Video On Demand (AVOD) platforms, based on Cost Per Mille (CPM) rates and advertiser demand. High-potential genres command premium ad rates. | Column avod_monetization_potential (STRING) in content.genre. Valid values are `high|medium|low`',
    `genre_code` STRING COMMENT 'Short alphanumeric code representing the genre for system integration and Electronic Program Guide (EPG) feeds. Used as a business key across scheduling, distribution, and metadata systems. | Column genre_code (STRING) in content.genre. Valid values are `^[A-Z0-9_]{2,20}$`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in content.genre',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this genre record was first created in the enterprise content taxonomy system. | Column created_timestamp (TIMESTAMP) in content.genre',
    `daypart_affinity` STRING COMMENT 'Comma-separated list of broadcast dayparts where this genre typically performs best (e.g., prime_time, late_night, early_morning, daytime, weekend). Informs program scheduling and playout automation strategies. | Column daypart_affinity (STRING) in content.genre',
    `genre_description` STRING COMMENT 'Detailed textual description of the genre, including defining characteristics, typical content examples, and audience expectations. Used for editorial guidance and content acquisition briefings. | Column genre_description (STRING) in content.genre',
    `dummy_flag` BOOLEAN COMMENT 'Generated flag to ensure model change',
    `effective_end_date` DATE COMMENT 'Date when this genre classification was retired or superseded. Null for currently active genres. Used for historical content classification and reporting continuity. | Column effective_end_date (DATE) in content.genre',
    `effective_start_date` DATE COMMENT 'Date when this genre classification became effective and available for use in content metadata and scheduling systems. | Column effective_start_date (DATE) in content.genre',
    `eidr_genre_mapping` STRING COMMENT 'Mapping to Entertainment Identifier Registry (EIDR) genre taxonomy for cross-industry content identification and rights management interoperability. | Column eidr_genre_mapping (STRING) in content.genre',
    `fast_channel_applicability` BOOLEAN COMMENT 'Indicates whether this genre is suitable for Free Ad-Supported Streaming Television (FAST) linear channel programming. FAST channels require genres with deep catalog availability and consistent audience appeal. | Column fast_channel_applicability (BOOLEAN) in content.genre',
    `geographic_restriction_applicability` BOOLEAN COMMENT 'Indicates whether content in this genre is subject to geographic blackout restrictions or regional licensing constraints. Common for sports genres with territorial rights and retransmission consent agreements. | Column geographic_restriction_applicability (BOOLEAN) in content.genre',
    `iab_content_category` STRING COMMENT 'Mapping to Interactive Advertising Bureau (IAB) content taxonomy for programmatic advertising and contextual ad targeting. Enables Share of Voice (SOV) optimization and Cost Per Mille (CPM) rate alignment. | Column iab_content_category (STRING) in content.genre. Valid values are `^IAB[0-9]{1,2}(-[0-9]{1,2})?$`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this genre is currently active and available for content classification. Inactive genres are retained for historical content but not used for new acquisitions. | Column is_active (BOOLEAN) in content.genre',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this genre record was last updated. Used for change tracking and metadata synchronization across Electronic Program Guide (EPG), Media Asset Management (MAM), and distribution systems. | Column last_modified_timestamp (TIMESTAMP) in content.genre',
    `linear_broadcast_suitability` BOOLEAN COMMENT 'Indicates whether this genre is suitable for traditional linear scheduled broadcasting. Some genres (e.g., interactive, choose-your-own-adventure) are non-linear only. | Column linear_broadcast_suitability (BOOLEAN) in content.genre',
    `localization_priority` STRING COMMENT 'Priority level for content localization (dubbing, subtitling, cultural adaptation) for this genre. High-priority genres justify investment in multi-language versions for international distribution. | Column localization_priority (STRING) in content.genre. Valid values are `high|medium|low`',
    `metadata_enrichment_priority` STRING COMMENT 'Priority level for metadata enrichment and tagging in Media Asset Management (MAM) systems. Critical genres require comprehensive metadata for content discovery and personalization. | Column metadata_enrichment_priority (STRING) in content.genre. Valid values are `critical|standard|minimal`',
    `mpa_rating_applicability` STRING COMMENT 'Comma-separated list of Motion Picture Association (MPA) ratings typically associated with this genre (e.g., G, PG, PG-13, R, NC-17). Used for content clearance and daypart scheduling compliance. | Column mpa_rating_applicability (STRING) in content.genre',
    `genre_name` STRING COMMENT 'Full display name of the genre as presented to audiences in Electronic Program Guides (EPG), streaming platform interfaces, and content discovery systems. | Column genre_name (STRING) in content.genre',
    `nielsen_genre_code` STRING COMMENT 'Nielsen Media Research genre classification code used for audience measurement, ratings analysis, and Gross Rating Point (GRP) reporting alignment. | Column nielsen_genre_code (STRING) in content.genre',
    `ott_platform_priority` STRING COMMENT 'Priority level for featuring this genre on Over-The-Top (OTT) streaming platforms and Video On Demand (VOD) services. High priority genres receive prominent placement in content discovery and recommendation engines. | Column ott_platform_priority (STRING) in content.genre. Valid values are `high|medium|low`',
    `parental_guidance_flag` BOOLEAN COMMENT 'Indicates whether content in this genre typically requires parental guidance warnings or viewer discretion advisories. Used for compliance with Federal Communications Commission (FCC) broadcast standards and Childrens Online Privacy Protection Act (COPPA) requirements. | Column parental_guidance_flag (BOOLEAN) in content.genre',
    `source_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in content.genre',
    `svod_performance_tier` STRING COMMENT 'Performance classification for this genre on Subscription Video On Demand (SVOD) platforms. Premium genres drive subscriber acquisition and reduce churn rate; catalog genres provide library depth. | Column svod_performance_tier (STRING) in content.genre. Valid values are `premium|standard|catalog`',
    `syndication_eligibility` BOOLEAN COMMENT 'Indicates whether content in this genre is typically eligible for syndication to multiple outlets and resale. Used in rights and royalties management and windowing strategy planning. | Column syndication_eligibility (BOOLEAN) in content.genre',
    `target_demographic` STRING COMMENT 'Primary audience demographic segment targeted by this genre, expressed in Nielsen demographic notation (e.g., A18-49, M25-54, W18-34). Used for Target Rating Point (TRP) and Gross Rating Point (GRP) planning. | Column target_demographic (STRING) in content.genre',
    `tier` STRING COMMENT 'Hierarchical level of the genre within the taxonomy. Primary represents top-level genres, secondary represents sub-genres, and tertiary represents granular classifications. | Column genre_tier (STRING) in content.genre. Valid values are `primary|secondary|tertiary`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in content.genre',
    `usage_notes` STRING COMMENT 'Internal notes and guidelines for content producers, schedulers, and metadata specialists on proper application of this genre classification. Includes edge cases and disambiguation rules. | Column usage_notes (STRING) in content.genre',
    CONSTRAINT pk_genre PRIMARY KEY(`genre_id`)
) COMMENT 'Enterprise reference taxonomy for content genre and sub-genre classification. Captures genre code, genre name, parent genre reference (enabling hierarchical sub-genres like Drama > Legal Drama), genre tier (primary/secondary), applicable content types, IAB content category mapping for ad targeting, and active status. Standardizes genre labeling across EPG systems, streaming platform metadata feeds, and advertising contextual targeting to ensure consistent audience segmentation and content discovery. | Unity Catalog table: media_broadcasting_ecm.content.genre Aligned with EBU CCDM (Tech 3351) Class Conceptual Data Model semantics.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`rating` (
    `rating_id` BIGINT COMMENT 'Primary key for rating | Column rating_id (BIGINT) in content.rating',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in content.rating',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in content.rating',
    `appeal_status` STRING COMMENT 'The current status of any appeal filed by the content producer or distributor to challenge or modify the assigned rating classification. | Column appeal_status (STRING) in content.rating. Valid values are `not_appealed|appeal_pending|appeal_approved|appeal_denied`',
    `body` STRING COMMENT 'The official name of the regulatory or industry body that issued the rating (e.g., Motion Picture Association, TV Parental Guidelines Monitoring Board, British Board of Film Classification, Freiwillige Selbstkontrolle der Filmwirtschaft). | Column body (STRING) in content.rating',
    `certificate_number` STRING COMMENT 'The unique certificate or reference number issued by the rating body upon classification approval. Used for audit and compliance verification. | Column certificate_number (STRING) in content.rating',
    `rating_code` STRING COMMENT 'The official rating classification code assigned to the content (e.g., G, PG, PG-13, R, NC-17 for MPA film ratings; TV-Y, TV-Y7, TV-G, TV-PG, TV-14, TV-MA for TV Parental Guidelines; or international equivalents such as BBFC, FSK, OFLC codes). [ENUM-REF-CANDIDATE: G|PG|PG-13|R|NC-17|TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA — 11 candidates stripped; promote to reference product] | Column rating_code (STRING) in content.rating',
    `content_descriptor_drug_use` BOOLEAN COMMENT 'Boolean flag indicating whether the rating includes a content descriptor for drug use or substance abuse. | Column content_descriptor_drug_use (BOOLEAN) in content.rating',
    `content_descriptor_fear` BOOLEAN COMMENT 'Boolean flag indicating whether the rating includes a content descriptor for frightening or intense scenes that may be unsuitable for younger audiences. | Column content_descriptor_fear (BOOLEAN) in content.rating',
    `content_descriptor_language` BOOLEAN COMMENT 'Boolean flag indicating whether the rating includes a content descriptor for strong or offensive language. | Column content_descriptor_language (BOOLEAN) in content.rating',
    `content_descriptor_nudity` BOOLEAN COMMENT 'Boolean flag indicating whether the rating includes a content descriptor for nudity or sexual content. | Column content_descriptor_nudity (BOOLEAN) in content.rating',
    `content_descriptor_violence` BOOLEAN COMMENT 'Boolean flag indicating whether the rating includes a content descriptor for violence or intense action. | Column content_descriptor_violence (BOOLEAN) in content.rating',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in content.rating',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this rating record was first created in the system. | Column created_timestamp (TIMESTAMP) in content.rating',
    `rating_description` STRING COMMENT 'Detailed textual description of the rating, including the rationale for the classification and any additional context provided by the rating body (e.g., Rated PG-13 for intense sequences of violence and action, some suggestive content, and brief strong language). | Column rating_description (STRING) in content.rating',
    `dummy_flag` BOOLEAN COMMENT 'Generated flag to ensure model change',
    `effective_date` DATE COMMENT 'The date on which this rating classification became effective and applicable to the content asset. | Column effective_date (DATE) in content.rating',
    `expiration_date` DATE COMMENT 'The date on which this rating classification expires or is no longer valid. Null if the rating does not expire. | Column expiration_date (DATE) in content.rating',
    `minimum_age` STRING COMMENT 'The minimum recommended or legally mandated age (in years) for viewers of content with this rating. Null if no specific age restriction applies. | Column minimum_age (INT) in content.rating',
    `notes` STRING COMMENT 'Additional internal notes or comments regarding the rating classification, including any special considerations, conditional approvals, or compliance requirements. | Column notes (STRING) in content.rating',
    `parental_control_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether this rating is used to enforce parental control features on linear broadcast, OTT (Over-The-Top), or MVPD (Multichannel Video Programming Distributor) platforms. | Column parental_control_enabled (BOOLEAN) in content.rating',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the rating is legally mandated by a regulatory body (e.g., FCC, Ofcom) or is a voluntary industry classification. | Column regulatory_mandate_flag (BOOLEAN) in content.rating',
    `source_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in content.rating',
    `submission_date` DATE COMMENT 'The date on which the content was submitted to the rating body for classification review. | Column submission_date (DATE) in content.rating',
    `system` STRING COMMENT 'The rating system or classification framework under which the rating was assigned (e.g., MPA for Motion Picture Association, TVPG for TV Parental Guidelines, BBFC for British Board of Film Classification, FSK for Freiwillige Selbstkontrolle der Filmwirtschaft, OFLC for Australian Classification Board, CBFC for Central Board of Film Certification India). | Column system (STRING) in content.rating. Valid values are `MPA|TVPG|BBFC|FSK|OFLC|CBFC`',
    `territory_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country or territory code indicating the geographic jurisdiction where this rating applies (e.g., USA, GBR, DEU, AUS, IND). | Column territory_code (STRING) in content.rating. Valid values are `^[A-Z]{3}$`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in content.rating',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this rating record was last modified or updated. | Column updated_timestamp (TIMESTAMP) in content.rating',
    `version` STRING COMMENT 'Version number of the rating record, incremented when the rating is re-evaluated or updated due to content edits, appeals, or regulatory changes. | Column version (INT) in content.rating',
    CONSTRAINT pk_rating PRIMARY KEY(`rating_id`)
) COMMENT 'Reference table for MPA, TV Parental Guidelines, and international content rating classifications applied to titles. Captures rating code (G/PG/PG-13/R/NC-17/TV-Y/TV-G/TV-PG/TV-14/TV-MA and international equivalents), rating system (MPA/TVPG/BBFC/FSK/etc.), rating body, applicable territory, minimum age indicator, content descriptor codes (violence/language/nudity/drug-use), and regulatory mandate flags. Supports FCC compliance, COPPA enforcement, and parental control features across linear and OTT platforms. | Unity Catalog table: media_broadcasting_ecm.content.rating Aligned with EBU CCDM (Tech 3351) Class Conceptual Data Model semantics.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` (
    `talent_credit_id` BIGINT COMMENT 'Unique identifier for the talent credit record. Primary key for the talent credit association entity. | Column talent_credit_id (BIGINT) in content.talent_credit',
    `content_episode_id` BIGINT COMMENT 'Reference to the specific episode within a series for which the talent is credited. Nullable for non-episodic content such as films or specials. | Column content_episode_id (BIGINT) in content.talent_credit',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.talent_contract. Business justification: Credits must link to contracts for residual calculation, compensation verification, guild compliance reporting, and billing position validation. Fundamental to talent payment and rights management pro | Column contract_id (BIGINT) in talent.talent_credit',
    `crew_assignment_id` BIGINT COMMENT 'Foreign key linking to production.crew_assignment. Business justification: Reconciling on-screen credits with production crew assignments is required for SAG-AFTRA compliance and residuals audits. Both records reference the same talent; linking them enables automated credit ',
    `project_id` BIGINT COMMENT 'Foreign key linking to production.project. Business justification: Residuals calculation and SAG-AFTRA/WGA union reporting require knowing which production project generated each talent credit. talent_credit links to title and episode but not the production project; ',
    `role_id` BIGINT COMMENT 'Foreign key linking to talent.talent_role. Business justification: Credits reference specific roles for character attribution, billing position validation, and role-specific residual eligibility. Eliminates denormalized role/character data and ensures single source o | Column role_id (BIGINT) in talent.talent_credit',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent master record in the talent domain. Links to the individual or entity receiving credit for their contribution to the content. | Column talent_profile_id (BIGINT) in talent.talent_credit',
    `title_id` BIGINT COMMENT 'Reference to the content title (film, series, special, documentary) for which the talent is credited. Links to the content master catalog. | Column title_id (BIGINT) in content.talent_credit',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in content.talent_credit',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in content.talent_credit',
    `billing_position` STRING COMMENT 'The ordinal position of the talent in the credit sequence, determining the order in which credits are displayed. Lower numbers indicate higher prominence (e.g., 1 = top billing). Used for EPG display and contractual compliance. | Column billing_position (INT) in content.talent_credit',
    `byline_text` STRING COMMENT 'Byline credit text for news reporter/photographer per VREQ-019',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in content.talent_credit',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this talent credit record was first created in the system. Used for audit trails and data lineage tracking. | Column created_timestamp (TIMESTAMP) in content.talent_credit',
    `credit_approval_date` DATE COMMENT 'The date on which the credit was officially approved for publication. Used for audit trails and compliance with guild credit determination timelines. | Column credit_approval_date (DATE) in content.talent_credit',
    `credit_approval_status` STRING COMMENT 'Current approval state of the credit. Pending indicates awaiting review; Approved indicates credit is finalized and ready for publication; Disputed indicates a challenge has been raised; Rejected indicates credit was not approved; Arbitration indicates the credit is under formal guild arbitration process. | Column credit_approval_status (STRING) in content.talent_credit. Valid values are `pending|approved|disputed|rejected|arbitration`',
    `credit_category` STRING COMMENT 'High-level categorization of the credit by functional area or department. Used for grouping credits in EPG displays, streaming platform interfaces, and analytics. [ENUM-REF-CANDIDATE: cast|director|producer|writer|cinematography|editing|music|sound|production_design|costume|makeup|visual_effects|executive|other — 14 candidates stripped; promote to reference product] | Column credit_category (STRING) in content.talent_credit',
    `credit_display_name` STRING COMMENT 'The exact name as it should appear in credits, EPG metadata, and streaming platform displays. May differ from the talents legal name if a pseudonym or stage name is used. This is the authoritative display value for all public-facing credit presentations. | Column credit_display_name (STRING) in content.talent_credit',
    `credit_display_order` STRING COMMENT 'The sequence number for displaying this credit within its credit type or section (e.g., within the cast section or crew section). Used for rendering credits in EPG, streaming platforms, and promotional materials. | Column credit_display_order (INT) in content.talent_credit',
    `credit_end_timestamp` TIMESTAMP COMMENT 'The timestamp marking when this credit ceases to be effective or visible. Nullable for credits that remain active indefinitely. Used for managing credit corrections, disputes, or contractual credit windows. | Column credit_end_timestamp (TIMESTAMP) in content.talent_credit',
    `credit_notes` STRING COMMENT 'Free-text field for additional context, special credit requirements, contractual stipulations, or notes related to credit disputes, arbitration outcomes, or special billing arrangements. | Column credit_notes (STRING) in content.talent_credit',
    `credit_start_timestamp` TIMESTAMP COMMENT 'The timestamp marking when this credit becomes effective or visible in EPG and streaming platform metadata. Used for managing credit changes over time and versioning. | Column credit_start_timestamp (TIMESTAMP) in content.talent_credit',
    `credit_type` STRING COMMENT 'Classification of the credit based on how the talent contribution is presented. On-screen credits appear in the visual content; off-screen credits appear in end titles or metadata only; voice credits are for voice-over or dubbing; stunt credits are for stunt performers; archive credits are for archival footage appearances. | Column credit_type (STRING) in content.talent_credit. Valid values are `on-screen|off-screen|voice|stunt|archive`',
    `dummy_flag` BOOLEAN COMMENT 'Generated flag to ensure model change',
    `pseudonym_flag` BOOLEAN COMMENT 'Indicates whether the talent is credited under a pseudonym or stage name rather than their legal name. True if pseudonym is used; False if legal name is used. Relevant for guild compliance and contractual credit requirements. | Column pseudonym_flag (BOOLEAN) in content.talent_credit',
    `residuals_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this credit qualifies the talent for residual payments based on content reuse, syndication, or secondary distribution. True if eligible; False otherwise. Triggers residuals calculation workflows in the rights and royalties domain. | Column residuals_eligibility_flag (BOOLEAN) in content.talent_credit',
    `source_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in content.talent_credit',
    `union_affiliation_flag` BOOLEAN COMMENT 'Indicates whether the talent is affiliated with a recognized industry union (SAG-AFTRA, DGA, WGA, IATSE) for this credit. True if union-affiliated; False otherwise. Used for residuals eligibility determination and compliance reporting. | Column union_affiliation_flag (BOOLEAN) in content.talent_credit',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in content.talent_credit',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this talent credit record was last modified. Used for audit trails, change tracking, and data quality monitoring. | Column updated_timestamp (TIMESTAMP) in content.talent_credit',
    CONSTRAINT pk_talent_credit PRIMARY KEY(`talent_credit_id`)
) COMMENT 'Association entity linking talent identities (owned by the talent domain) to specific titles and episodes with their credited role, billing position, character name, credit type (on-screen/off-screen), and credit display order. Captures SAG-AFTRA/WGA/DGA union affiliation flag, residuals eligibility flag, and credit approval status. Serves as the content domains authoritative credit roll for EPG metadata delivery, streaming platform cast display, and residuals calculation triggers. Does not duplicate the talent master record — references it via FK to the talent domain. | Unity Catalog table: media_broadcasting_ecm.content.talent_credit Aligned with EBU CCDM (Tech 3351) Class Conceptual Data Model semantics.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` (
    `acquisition_id` BIGINT COMMENT 'Primary key for acquisition | Column acquisition_id (BIGINT) in content.acquisition',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Acquisitions often specify which version was acquired (theatrical vs broadcast cut, localized version). This FK allows tracking version-specific acquisition terms and rights. | Column content_version_id (BIGINT) in content.acquisition',
    `deal_id` BIGINT COMMENT 'Foreign key linking to distribution.deal. Business justification: Content acquisitions are executed under distribution deals that define commercial terms, revenue share, and exclusivity. Linking acquisition to deal enables deal-level cost tracking, minimum guarantee',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: An acquisition results in or is governed by a specific rights grant. Rights operations must link each acquisition record to its authorizing grant for run-count tracking, royalty calculation, and audit',
    `ingest_job_id` BIGINT COMMENT 'Foreign key linking to mediaasset.ingest_job. Business justification: Content acquisition results in a physical media delivery that must be ingested. Procurement and operations teams need to verify acquired titles were successfully ingested by linking the acquisition re',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Acquisition records must reference the underlying license agreement that enabled the acquisition. Financial reconciliation, audit trails, and rights validation require linking acquisitions to their go | Column license_agreement_id (BIGINT) in rights.acquisition',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Content acquisitions in broadcasting are directly triggered by sales opportunities — a broadcaster acquires a title because a distribution or licensing deal is in the pipeline. Linking acquisition to ',
    `title_id` BIGINT COMMENT 'Reference to the content asset being acquired. Links to the master content catalog entry for the title, episode, series, film, clip, or other content asset. | Column title_id (BIGINT) in content.acquisition',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in content.acquisition',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in content.acquisition',
    `acquisition_date` DATE COMMENT 'The date on which the acquisition transaction was executed and the content rights were legally transferred or licensed to the enterprise. Represents the principal business event timestamp for this transaction. | Column acquisition_date (DATE) in content.acquisition',
    `acquisition_status` STRING COMMENT 'Current lifecycle state of the acquisition. Negotiating = deal in discussion; Committed = contract signed but content not yet delivered; Delivered = content received and ingested; Active = content in use; Cancelled = deal terminated before delivery; Expired = license period ended. | Column acquisition_status (STRING) in content.acquisition. Valid values are `negotiating|committed|delivered|active|cancelled|expired`',
    `acquisition_type` STRING COMMENT 'Classification of the acquisition method. Purchase = outright ownership transfer; License = time-limited rights; Co-production = joint production investment; Commission = original content commissioned from producer; Barter = content exchanged for advertising inventory; Syndication = content licensed from syndicator for regional broadcast. | Column acquisition_type (STRING) in content.acquisition. Valid values are `purchase|license|co-production|commission|barter|syndication`',
    `ancillary_rights_flag` BOOLEAN COMMENT 'Indicates whether ancillary rights (merchandising, soundtrack, publishing, remake, sequel, spin-off, clip licensing) are included in the acquisition (True) or retained by the supplier (False). | Column ancillary_rights_flag (BOOLEAN) in content.acquisition',
    `clearance_status` STRING COMMENT 'Rights verification status confirming that all necessary clearances (music rights, talent rights, third-party content, trademarks) have been obtained for broadcast or distribution. Pending = verification in progress; Cleared = all rights confirmed; Restricted = partial clearance with limitations; Failed = clearance issues prevent exploitation. | Column clearance_status (STRING) in content.acquisition. Valid values are `pending|cleared|restricted|failed`',
    `content_window_type` STRING COMMENT 'The distribution window or rights category acquired. Windowing refers to the sequential release strategy where content is made available through different channels over time. Theatrical = cinema release; Home Video = physical/digital sell-through; SVOD = Subscription Video On Demand; AVOD = Advertising-Supported Video On Demand; TVOD = Transactional Video On Demand; Linear Broadcast = traditional scheduled TV; Syndication = resale to multiple outlets; All Rights = comprehensive rights across all windows. [ENUM-REF-CANDIDATE: theatrical|home_video|svod|avod|tvod|linear_broadcast|syndication|all_rights — 8 candidates stripped; promote to reference product] | Column content_window_type (STRING) in content.acquisition',
    `cost_amount` DECIMAL(18,2) COMMENT 'The total monetary value paid or committed for acquiring the content rights. Represents the base acquisition cost before taxes, fees, or adjustments. For licenses, this is the total license fee; for purchases, the purchase price; for commissions, the production budget committed. | Column cost_amount (DECIMAL(18,2)) in content.acquisition',
    `cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the acquisition cost amount (e.g., USD, GBP, EUR, JPY). | Column cost_currency (STRING) in content.acquisition. Valid values are `^[A-Z]{3}$`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in content.acquisition',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this acquisition record was first created in the system. Audit field for data lineage and compliance tracking. | Column created_timestamp (TIMESTAMP) in content.acquisition',
    `delivery_date` DATE COMMENT 'The date on which the content master files and associated materials (metadata, artwork, closed captions, promotional assets) were delivered by the supplier and ingested into the enterprise Media Asset Management (MAM) system. | Column delivery_date (DATE) in content.acquisition',
    `delivery_format` STRING COMMENT 'The technical format and delivery method used by the supplier to provide the content. Examples: ProRes 422 HQ via FTP, IMF package via Aspera, DCP hard drive, MPEG-4 via CDN, tape (legacy). | Column delivery_format (STRING) in content.acquisition',
    `dummy_flag` BOOLEAN COMMENT 'Generated flag to ensure model change',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the acquired rights are exclusive (True) or non-exclusive (False) within the specified territory and window. Exclusive rights prevent the supplier from licensing the same content to competitors in the same territory/window. | Column exclusivity_flag (BOOLEAN) in content.acquisition',
    `format_rights` STRING COMMENT 'The technical formats or delivery specifications covered by the acquisition. May include SD, HD, 4K, HDR, theatrical DCP, broadcast master, streaming-optimized, etc. Defines the quality and format tiers the enterprise is authorized to distribute. | Column format_rights (STRING) in content.acquisition',
    `holdback_period_days` STRING COMMENT 'The number of days during which the content cannot be exploited in certain windows or territories as stipulated by the acquisition agreement. Holdback periods protect prior windows (e.g., theatrical holdback prevents SVOD release for 90 days post-theatrical). | Column holdback_period_days (INT) in content.acquisition',
    `language_rights` STRING COMMENT 'The languages or language versions for which rights were acquired. May specify original language only, dubbed versions, subtitled versions, or all language adaptations. Examples: English, Spanish, French; All Languages; Original + Subtitles. | Column language_rights (STRING) in content.acquisition',
    `license_end_date` DATE COMMENT 'The date on which the acquired content rights expire and the enterprise must cease exploitation. Null for perpetual purchases. For time-limited licenses, this defines the end of the license term. | Column license_end_date (DATE) in content.acquisition',
    `license_start_date` DATE COMMENT 'The date from which the enterprise is authorized to begin exploiting the acquired content rights. For licenses, this is the effective start of the license term; for purchases, typically the acquisition date. | Column license_start_date (DATE) in content.acquisition',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'The minimum guaranteed payment to the supplier regardless of actual revenue performance. Common in revenue-sharing deals where the enterprise commits to a floor payment even if royalties do not reach this threshold. | Column minimum_guarantee_amount (DECIMAL(18,2)) in content.acquisition',
    `notes` STRING COMMENT 'Free-text field for additional context, special terms, restrictions, or operational notes related to the acquisition. May include information on promotional obligations, credit requirements, or unique contractual stipulations. | Column notes (STRING) in content.acquisition',
    `payment_terms` STRING COMMENT 'Contractual payment schedule and conditions for the acquisition cost. May include milestone-based payments, installment schedules, advance payments, or revenue-sharing arrangements. | Column payment_terms (STRING) in content.acquisition',
    `reference_number` STRING COMMENT 'External business identifier for this acquisition transaction. May be a purchase order number, deal reference, or contract line item identifier used in communications with the supplier. | Column reference_number (STRING) in content.acquisition',
    `residuals_obligation_flag` BOOLEAN COMMENT 'Indicates whether the enterprise has an obligation to pay residuals (talent reuse payments) to performers, writers, directors, or other rights holders each time the content is rebroadcast or redistributed (True) or if residuals are the suppliers responsibility (False). | Column residuals_obligation_flag (BOOLEAN) in content.acquisition',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of revenue or receipts that must be paid to the supplier as ongoing royalties under a revenue-sharing acquisition model. Null if the acquisition is a flat-fee structure with no revenue share. | Column royalty_rate_percent (DECIMAL(5,2)) in content.acquisition',
    `runs_allowed` STRING COMMENT 'The maximum number of times the content may be broadcast or streamed under the acquisition agreement. Common in linear broadcast licenses (e.g., 3 runs over 2 years). Null indicates unlimited runs within the license period. | Column runs_allowed (INT) in content.acquisition',
    `runs_consumed` STRING COMMENT 'The number of runs (broadcasts or streams) that have been executed to date against the runs_allowed limit. Tracked to ensure compliance with contractual run restrictions. | Column runs_consumed (INT) in content.acquisition',
    `source_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in content.acquisition',
    `sublicensing_allowed_flag` BOOLEAN COMMENT 'Indicates whether the enterprise is permitted to sublicense the acquired content to third parties (True) or must exploit the content directly only (False). Sublicensing enables syndication and secondary distribution deals. | Column sublicensing_allowed_flag (BOOLEAN) in content.acquisition',
    `territory_scope` STRING COMMENT 'Geographic territories or markets for which the content rights were acquired. May be specified as country codes (ISO 3166), regional groupings, or worldwide. Examples: USA, GBR, North America, EMEA, Worldwide. | Column territory_scope (STRING) in content.acquisition',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in content.acquisition',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this acquisition record was last modified. Audit field for change tracking and data governance. | Column updated_timestamp (TIMESTAMP) in content.acquisition',
    CONSTRAINT pk_acquisition PRIMARY KEY(`acquisition_id`)
) COMMENT 'Transactional record capturing the business event of acquiring content from an external source — studio, independent producer, syndicator, or distributor. Tracks acquisition type (purchase/license/co-production/commission), acquisition date, source party, acquisition cost, currency, content window acquired, territory scope, exclusivity flag, holdback period, acquisition status (negotiating/committed/delivered/cancelled), and originating deal reference. Serves as the financial and operational anchor for content entering the enterprise catalog from external sources. | Unity Catalog table: media_broadcasting_ecm.content.acquisition Aligned with EBU CCDM (Tech 3351) Class Conceptual Data Model semantics.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` (
    `lifecycle_event_id` BIGINT COMMENT 'Primary key for lifecycle_event | Column lifecycle_event_id (BIGINT) in content.lifecycle_event',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Lifecycle events track version-specific status transitions (version approved for broadcast, version archived). Critical for version-level workflow tracking. | Column content_version_id (BIGINT) in content.lifecycle_event',
    `ingest_job_id` BIGINT COMMENT 'Foreign key linking to mediaasset.ingest_job. Business justification: Ingest job completion is a primary trigger for content lifecycle stage transitions (e.g., Received → Awaiting QC). Content operations teams need to trace which ingest_job initiated a lifecycle eve',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Episode-level lifecycle events (picture lock, QC pass, delivery) are triggered by production episode milestones. Direct FK enables episode-level SLA breach reporting and delivery compliance tracking —',
    `project_id` BIGINT COMMENT 'Foreign key linking to production.project. Business justification: Content lifecycle events (greenlight, delivery, archive) are triggered by production project milestones. Linking lifecycle_event to production.project enables end-to-end content lifecycle reporting fr',
    `title_id` BIGINT COMMENT 'Reference to the content asset (title, episode, series, film, clip, music, news segment, or live event) undergoing this lifecycle transition. | Column title_id (BIGINT) in content.lifecycle_event',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in content.lifecycle_event',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in content.lifecycle_event',
    `automated_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle transition was triggered automatically by the workflow system (True) or manually by a user (False). | Column automated_flag (BOOLEAN) in content.lifecycle_event',
    `blocking_condition` STRING COMMENT 'Any condition, issue, or dependency that is blocking or delaying the content from progressing to the next lifecycle stage (e.g., pending rights clearance, QC failure, missing metadata, technical issue). Null if no blocking condition exists. | Column blocking_condition (STRING) in content.lifecycle_event',
    `blocking_resolved_flag` BOOLEAN COMMENT 'Indicates whether any previously identified blocking condition has been resolved. True if resolved, False if still blocking, Null if no blocking condition was present. | Column blocking_resolved_flag (BOOLEAN) in content.lifecycle_event',
    `compliance_checkpoint_passed` BOOLEAN COMMENT 'Indicates whether all regulatory and compliance checkpoints required for this lifecycle stage were successfully passed (e.g., content rating verification, rights clearance, broadcast standards review). True if passed, False if failed, Null if not applicable. | Column compliance_checkpoint_passed (BOOLEAN) in content.lifecycle_event',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in content.lifecycle_event',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this lifecycle event record was first created in the system. Audit field for data lineage and record provenance. | Column created_timestamp (TIMESTAMP) in content.lifecycle_event',
    `delivery_platform` STRING COMMENT 'The target delivery platform or distribution channel for which this lifecycle stage is being prepared (e.g., Linear Broadcast, OTT, VOD, SVOD, AVOD, Theatrical, Syndication). Applicable primarily for distribution-related lifecycle stages. | Column delivery_platform (STRING) in content.lifecycle_event',
    `dummy_flag` BOOLEAN COMMENT 'Generated flag to ensure model change',
    `event_sequence_number` STRING COMMENT 'The sequential order of this lifecycle event within the complete lifecycle history of the content asset. Used to reconstruct the chronological audit trail. | Column event_sequence_number (INT) in content.lifecycle_event',
    `lifecycle_stage` STRING COMMENT 'The operational lifecycle stage of the content asset at the time of this event. Represents the major phase in the content workflow from acquisition through archival. [ENUM-REF-CANDIDATE: acquisition|commission|development|pre_production|production|post_production|clearance|mastering|distribution|archival|retired — 11 candidates stripped; promote to reference product] | Column lifecycle_stage (STRING) in content.lifecycle_event',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this lifecycle event record was last modified. Audit field for tracking updates to the event record. | Column modified_timestamp (TIMESTAMP) in content.lifecycle_event',
    `new_status` STRING COMMENT 'The status of the content asset immediately after this lifecycle transition. Represents the current state following the event. | Column new_status (STRING) in content.lifecycle_event',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the responsible user or system regarding this lifecycle transition. Captures context, issues, or special handling instructions. | Column notes (STRING) in content.lifecycle_event',
    `previous_status` STRING COMMENT 'The status of the content asset immediately before this lifecycle transition. Captures the prior state for audit trail and provenance. | Column previous_status (STRING) in content.lifecycle_event',
    `qc_status` STRING COMMENT 'The quality control review status associated with this lifecycle transition. Indicates whether technical and editorial quality standards were met. | Column qc_status (STRING) in content.lifecycle_event. Valid values are `passed|failed|pending|not_required|conditional_pass`',
    `responsible_team` STRING COMMENT 'The business unit, department, or team responsible for executing or approving this lifecycle transition (e.g., Production, Post-Production, Rights Management, Quality Control, Distribution). | Column responsible_team (STRING) in content.lifecycle_event',
    `rollback_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event represents a rollback to a previous stage due to failure, rejection, or rework requirement. True if rollback, False for forward progression. | Column rollback_flag (BOOLEAN) in content.lifecycle_event',
    `rollback_reason` STRING COMMENT 'The reason or justification for rolling back the content to a previous lifecycle stage. Null if rollback_flag is False. | Column rollback_reason (STRING) in content.lifecycle_event',
    `sla_actual_date` DATE COMMENT 'The actual date when this lifecycle stage was completed. Used to measure SLA compliance by comparing against sla_target_date. | Column sla_actual_date (DATE) in content.lifecycle_event',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle transition breached the defined SLA target. True if actual date exceeded target date, False otherwise. | Column sla_breach_flag (BOOLEAN) in content.lifecycle_event',
    `sla_target_date` DATE COMMENT 'The target date by which this lifecycle stage should be completed, as defined by internal SLA or contractual delivery commitment. Used for SLA monitoring and performance tracking. | Column sla_target_date (DATE) in content.lifecycle_event',
    `source_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in content.lifecycle_event',
    `system_source` STRING COMMENT 'The name of the source system or module that generated this lifecycle event record (e.g., Dalet Galaxy, Ericsson MediaFirst, Rightsline, manual entry). | Column system_source (STRING) in content.lifecycle_event',
    `transition_duration_hours` DECIMAL(18,2) COMMENT 'The elapsed time in hours between the previous lifecycle event and this event. Measures the duration spent in the previous stage. Used for operational efficiency analysis. | Column transition_duration_hours (DECIMAL(10,2)) in content.lifecycle_event',
    `transition_timestamp` TIMESTAMP COMMENT 'The precise date and time when the lifecycle stage transition occurred. This is the business event timestamp, distinct from audit timestamps. | Column transition_timestamp (TIMESTAMP) in content.lifecycle_event',
    `triggered_by_event` STRING COMMENT 'The specific event or action that triggered this lifecycle transition (e.g., QC approval, rights clearance, ingest completion, delivery confirmation, manual override). | Column triggered_by_event (STRING) in content.lifecycle_event',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in content.lifecycle_event',
    `version_number` STRING COMMENT 'The version identifier of the content asset at the time of this lifecycle event. Tracks iterations, edits, and revisions through the production and post-production workflow. | Column version_number (STRING) in content.lifecycle_event',
    `workflow_instance_code` STRING COMMENT 'The unique identifier of the workflow instance in the Media Asset Management (MAM) system that orchestrated this lifecycle transition. Links to Dalet Galaxy workflow execution. | Column workflow_instance_code (STRING) in content.lifecycle_event',
    CONSTRAINT pk_lifecycle_event PRIMARY KEY(`lifecycle_event_id`)
) COMMENT 'Transactional audit trail of status transitions for a title through its operational lifecycle — from acquisition/commission through production, post-production, clearance, mastering, distribution, and archival. Each record captures the lifecycle stage, transition date, triggered-by event, responsible team, previous status, new status, and any blocking conditions. Enables operational tracking of content readiness, supports SLA monitoring for delivery commitments, and provides a complete provenance trail for compliance and audit purposes. | Unity Catalog table: media_broadcasting_ecm.content.lifecycle_event Aligned with EBU CCDM (Tech 3351) Class Conceptual Data Model semantics.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` (
    `artwork_id` BIGINT COMMENT 'Unique identifier for the artwork asset record. Primary key for the artwork catalog. | Column artwork_id (BIGINT) in content.artwork',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Artwork is often version-specific (theatrical poster vs TV key art, localized artwork with different ratings/text). Links artwork to the specific version it represents. | Column content_version_id (BIGINT) in content.artwork',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Talent likeness approval workflow — talent contracts require explicit approval before a talents likeness is used in promotional artwork. Legal/clearance teams must trace key art and promotional image',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Artwork files (posters, thumbnails, key art) are managed media assets in DAM systems. Asset lifecycle management, storage tier assignment, and delivery workflows require linking artwork records to the | Column media_asset_id (BIGINT) in mediaasset.artwork',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: OTT platforms have specific artwork specifications (aspect ratios, resolutions, branding guidelines). Linking artwork to ott_platform enables platform-specific asset management, artwork compliance val',
    `project_id` BIGINT COMMENT 'Foreign key linking to production.project. Business justification: Key art and promotional artwork are commissioned as part of a production project. Linking artwork to its originating project enables production cost allocation for marketing deliverables and project c',
    `title_id` BIGINT COMMENT 'Reference to the content title (series, film, episode, or other content asset) that this artwork represents. Links artwork to the master content catalog. | Column title_id (BIGINT) in content.artwork',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in content.artwork',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in content.artwork',
    `approval_date` DATE COMMENT 'Date on which the artwork received final approval for distribution and use. Marks the transition from draft/review to production-ready status. Format: yyyy-MM-dd. | Column approval_date (DATE) in content.artwork',
    `approved_for_use_flag` BOOLEAN COMMENT 'Boolean indicator of whether the artwork has passed legal, brand, and creative approval processes and is authorized for public distribution. True indicates approved and ready for use, False indicates pending approval or rejected. | Column approved_for_use_flag (BOOLEAN) in content.artwork',
    `archive_location` STRING COMMENT 'Physical or logical storage location identifier for the high-resolution master artwork file in the enterprise archive system. May reference tape library, cloud object storage bucket, or network-attached storage (NAS) path. Supports long-term preservation and disaster recovery. | Column archive_location (STRING) in content.artwork',
    `artwork_type` STRING COMMENT 'Classification of the artwork asset by its intended use and format. Key-art is primary promotional image, thumbnail for Electronic Program Guide (EPG) and streaming UI, banner for web headers, poster for theatrical/retail, logo for branding, still for scene captures. | Column artwork_type (STRING) in content.artwork. Valid values are `key-art|thumbnail|banner|poster|logo|still`',
    `aspect_ratio` STRING COMMENT 'Proportional relationship between width and height of the artwork. 16:9 for widescreen HD, 4:3 for standard definition, 1:1 for square social media, 2:3 for portrait poster, 3:4 for mobile portrait, 21:9 for ultra-widescreen, 9:16 for vertical mobile video. [ENUM-REF-CANDIDATE: 16:9|4:3|1:1|2:3|3:4|21:9|9:16 — 7 candidates stripped; promote to reference product] | Column aspect_ratio (NUMERIC) in content.artwork',
    `color_profile` STRING COMMENT 'Color space standard applied to the artwork for accurate color reproduction across devices and platforms. sRGB for web/digital, Adobe RGB for professional photography, CMYK for print, Rec. 709 for HD broadcast, Rec. 2020 for Ultra HD (UHD) broadcast. | Column color_profile (STRING) in content.artwork. Valid values are `sRGB|Adobe RGB|ProPhoto RGB|CMYK|Rec. 709|Rec. 2020`',
    `content_rating_displayed_flag` BOOLEAN COMMENT 'Boolean indicator of whether the artwork includes a visible Motion Picture Association (MPA) or equivalent content rating badge (G, PG, PG-13, R, NC-17, TV-Y, TV-PG, TV-14, TV-MA). True indicates rating is burned into the image, False indicates clean artwork without rating overlay. | Column content_rating_displayed_flag (BOOLEAN) in content.artwork',
    `copyright_holder` STRING COMMENT 'Legal entity or organization that owns the copyright to the artwork asset. May be the production company, studio, distributor, or external agency. Critical for rights clearance and syndication. | Column copyright_holder (STRING) in content.artwork',
    `copyright_year` STRING COMMENT 'Year in which the artwork was created and copyright was established. Used for copyright notice display and rights duration calculation. | Column copyright_year (INT) in content.artwork',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in content.artwork',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the artwork record was first created in the enterprise catalog system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage tracking. | Column created_timestamp (TIMESTAMP) in content.artwork',
    `dummy_flag` BOOLEAN COMMENT 'Generated flag to ensure model change',
    `eidr` STRING COMMENT 'Universal unique identifier from the Entertainment Identifier Registry for the associated content title. Enables global interoperability and metadata exchange across distribution partners, rights holders, and platforms. | Column eidr (STRING) in content.artwork. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `expiry_date` DATE COMMENT 'Date on which the artwork rights or usage authorization expires and the asset should no longer be used for promotional or distribution purposes. Supports rights management and holdback compliance. Nullable for perpetual-use artwork. Format: yyyy-MM-dd. | Column expiry_date (DATE) in content.artwork',
    `file_format` STRING COMMENT 'Image file format of the artwork asset. JPEG for compressed photos, PNG for transparency support, TIFF for high-resolution archival, PSD for Adobe Photoshop source files, SVG for vector graphics, WebP for modern web delivery. | Column file_format (STRING) in content.artwork. Valid values are `JPEG|PNG|TIFF|PSD|SVG|WebP`',
    `file_size_bytes` BIGINT COMMENT 'Storage size of the artwork file measured in bytes. Used for Content Delivery Network (CDN) optimization, bandwidth planning, and storage capacity management. | Column file_size_bytes (BIGINT) in content.artwork',
    `height_pixels` STRING COMMENT 'Vertical dimension of the artwork image measured in pixels. Used to determine display suitability and resolution quality for various distribution channels. | Column height_pixels (INT) in content.artwork',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language of any text overlay or localization present in the artwork. Used for multi-territory distribution and localization workflows. | Column language_code (STRING) in content.artwork. Valid values are `^[a-z]{2}$`',
    `language_overlay_flag` BOOLEAN COMMENT 'Boolean indicator of whether the artwork contains burned-in text, titles, or language-specific graphic elements. True indicates localized artwork requiring territory-specific versions, False indicates language-neutral artwork suitable for all markets. | Column language_overlay_flag (BOOLEAN) in content.artwork',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the artwork record was last updated or modified in the enterprise catalog system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for change tracking and synchronization workflows. | Column modified_timestamp (TIMESTAMP) in content.artwork',
    `photographer_credit` STRING COMMENT 'Name or attribution of the photographer, artist, or creative agency responsible for creating the artwork. Used for copyright attribution, residuals tracking, and legal compliance with talent agreements. | Column photographer_credit (STRING) in content.artwork',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the preferred display order or priority of this artwork when multiple artwork assets exist for the same title and type. Lower numbers indicate higher priority. Used by Electronic Program Guide (EPG) and streaming platform UI to select the primary artwork. | Column priority_rank (INT) in content.artwork',
    `resolution_dpi` STRING COMMENT 'Image resolution measured in dots per inch. 72 DPI for web/screen display, 300 DPI for high-quality print, 150 DPI for standard print. Critical for determining print suitability and image quality. | Column resolution_dpi (INT) in content.artwork',
    `source_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in content.artwork',
    `source_system_code` STRING COMMENT 'Unique identifier or reference key for the artwork asset in the originating source system. Enables traceability and synchronization with upstream Digital Asset Management (DAM) or creative management platforms. | Column source_system_code (STRING) in content.artwork',
    `territory_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the geographic territory for which this artwork is approved and licensed. Supports windowing and territorial rights management strategies. | Column territory_code (STRING) in content.artwork. Valid values are `^[A-Z]{3}$`',
    `title` STRING COMMENT 'Human-readable descriptive title or label for the artwork asset. Used for internal cataloging and search within the Media Asset Management (MAM) system. | Column title (STRING) in content.artwork',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in content.artwork',
    `usage_rights` STRING COMMENT 'Scope of authorized usage channels and media types for the artwork. All-media for unrestricted use, digital-only for Over-The-Top (OTT) and web, print-only for press kits and retail, broadcast-only for linear television, theatrical-only for cinema, promotional-only for advertising and marketing campaigns. | Column usage_rights (STRING) in content.artwork. Valid values are `all-media|digital-only|print-only|broadcast-only|theatrical-only|promotional-only`',
    `width_pixels` STRING COMMENT 'Horizontal dimension of the artwork image measured in pixels. Used to determine display suitability and resolution quality for various distribution channels. | Column width_pixels (INT) in content.artwork',
    CONSTRAINT pk_artwork PRIMARY KEY(`artwork_id`)
) COMMENT 'Master catalog of promotional and editorial artwork assets associated with a title — key art, thumbnail images, banner graphics, poster images, and logo treatments. Captures artwork type (key-art/thumbnail/banner/poster/logo/still), image dimensions, aspect ratio, file format, color profile, territory applicability, language overlay flag, approved-for-use flag, approval date, expiry date, and source system reference (Dalet Galaxy DAM). Supports EPG display, streaming platform UI, press kits, and advertising creative without duplicating the binary asset record owned by the digital asset domain. | Unity Catalog table: media_broadcasting_ecm.content.artwork Aligned with EBU CCDM (Tech 3351) Class Conceptual Data Model semantics.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`package` (
    `package_id` BIGINT COMMENT 'Primary key for package | Column package_id (BIGINT) in content.package',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Packages have content rating (highest rating of included titles). Normalizes content_rating string column to reference the enterprise rating taxonomy. | Column content_rating_id (BIGINT) in content.package',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Content packages are assigned to specific delivery channels (FAST channels, linear feeds, VOD storefronts). This link enables channel-level package inventory management, FAST channel programming, and ',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Content packages are assembled and priced targeting specific demographic segments (e.g., kids package targeting K2-11, news package targeting A25-54). Linking to demographic_segment enables proper pac',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Packages have primary genre classification. Normalizes genre_primary string column to reference the enterprise genre taxonomy. | Column genre_id (BIGINT) in content.package',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Content packages (e.g., Summer Action Bundle, Kids Library) are licensed as units to distributors. Package-level royalty calculations and clearance workflows require linking packages to their gove | Column license_agreement_id (BIGINT) in rights.package',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Content packages (bundles, collections) are licensed to specific platforms. Package-level deals are common in SVOD (entire studio catalog to Netflix) and require platform-specific availability trackin | Column ott_platform_id (BIGINT) in distribution.package',
    `partner_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_partner. Business justification: Packages are sold to distribution partners (cable operators, MVPD aggregators, international distributors). Package-level licensing agreements and carriage fees are negotiated at partner level for bul | Column distribution_partner_id (BIGINT) in distribution.package',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in content.package',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in content.package',
    `audio_description_available_flag` BOOLEAN COMMENT 'Indicates whether audio description tracks are available for the majority of content in the package (True/False). Required for accessibility compliance. | Column audio_description_available_flag (BOOLEAN) in content.package',
    `closed_caption_available_flag` BOOLEAN COMMENT 'Indicates whether closed captioning is available for the majority of content in the package (True/False). Required for FCC compliance and accessibility standards. | Column closed_caption_available_flag (BOOLEAN) in content.package',
    `package_code` STRING COMMENT 'The externally-known unique business identifier or code for the package used in contracts, invoicing, and distribution systems. | Column package_code (STRING) in content.package',
    `commercial_context` STRING COMMENT 'Free-text description of the business purpose or deal context for which the package was assembled, such as upfront sales event, scatter market offering, MVPD (Multichannel Video Programming Distributor) carriage negotiation, or international syndication deal. | Column commercial_context (STRING) in content.package',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in content.package',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the package record was first created in the system. Used for audit trail and data lineage. | Column created_timestamp (TIMESTAMP) in content.package',
    `package_description` STRING COMMENT 'A detailed narrative description of the package content, target audience, and commercial positioning. Used for marketing, sales proposals, and catalog listings. | Column package_description (STRING) in content.package',
    `drm_required_flag` BOOLEAN COMMENT 'Indicates whether Digital Rights Management (DRM) protection is required for distribution of this package (True/False). Critical for rights enforcement and anti-piracy compliance. | Column drm_required_flag (BOOLEAN) in content.package',
    `dummy_flag` BOOLEAN COMMENT 'Generated flag to ensure model change',
    `effective_date` DATE COMMENT 'The date from which the package becomes available for distribution or licensing. Marks the start of the packages commercial availability window. | Column effective_date (DATE) in content.package',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the package is offered on an exclusive basis to a single distributor or platform (True) or is available for non-exclusive multi-platform distribution (False). Critical for rights and holdback management. | Column exclusivity_flag (BOOLEAN) in content.package',
    `expiry_date` DATE COMMENT 'The date on which the package ceases to be available for distribution or licensing. Nullable for open-ended packages. Defines the end of the windowing or holdback period. | Column expiry_date (DATE) in content.package',
    `hd_available_flag` BOOLEAN COMMENT 'Indicates whether the package content is available in high-definition (HD) format (True/False). Used for distribution planning and quality assurance. | Column hd_available_flag (BOOLEAN) in content.package',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags associated with the package for search, discovery, and recommendation purposes. | Column keywords (STRING) in content.package',
    `language_primary` STRING COMMENT 'The primary language of the content in the package, expressed as ISO 639-2 three-letter language code (e.g., eng, spa, fra). Critical for localization and international distribution. | Column language_primary (STRING) in content.package',
    `modified_by` STRING COMMENT 'The username or identifier of the user or system that last modified the package record. Used for change accountability and audit trail. | Column modified_by (STRING) in content.package',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the package record was last modified. Used for change tracking and audit compliance. | Column modified_timestamp (TIMESTAMP) in content.package',
    `package_name` STRING COMMENT 'The business name or title of the content package as recognized in commercial agreements and distribution deals. | Column package_name (STRING) in content.package',
    `package_status` STRING COMMENT 'Current lifecycle status of the package: draft (under construction), active (available for distribution), suspended (temporarily unavailable), expired (past effective period), terminated (cancelled before expiry), or archived (historical record). | Column package_status (STRING) in content.package. Valid values are `draft|active|suspended|expired|terminated|archived`',
    `package_type` STRING COMMENT 'The classification of the package based on its commercial or distribution purpose: syndication (content resale to multiple outlets), SVOD (Subscription Video On Demand) library (subscription-based catalog), AVOD (Advertising-Supported Video On Demand) catalog (ad-supported offering), FAST (Free Ad-Supported Streaming Television) channel (linear streaming channel), educational (academic or training content bundle), or international (cross-border distribution bundle). | Column package_type (STRING) in content.package. Valid values are `syndication|svod-library|avod-catalog|fast-channel|educational|international`',
    `rights_holder` STRING COMMENT 'The name of the organization or entity that holds the distribution rights for the package. May be a studio, distributor, or licensor. | Column rights_holder (STRING) in content.package',
    `source_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in content.package',
    `territory_scope` STRING COMMENT 'Geographic territories or markets where the package is licensed for distribution, expressed as comma-separated ISO 3166-1 alpha-3 country codes or regional groupings (e.g., USA, GBR, CAN or EMEA, APAC). Defines the carriage or clearance geography. | Column territory_scope (STRING) in content.package',
    `thumbnail_url` STRING COMMENT 'The URL or path to the thumbnail image representing the package in catalogs, EPG (Electronic Program Guide) listings, and user interfaces. | Column thumbnail_url (STRING) in content.package',
    `total_runtime_hours` DECIMAL(18,2) COMMENT 'The aggregate runtime of all content in the package, expressed in hours. Used for programming and scheduling calculations. | Column total_runtime_hours (DECIMAL(10,2)) in content.package',
    `total_title_count` STRING COMMENT 'The total number of distinct titles (episodes, films, clips, or other content assets) included in the package. Used for inventory reporting and deal valuation. | Column total_title_count (INT) in content.package',
    `uhd_4k_available_flag` BOOLEAN COMMENT 'Indicates whether the package content is available in ultra-high-definition 4K format (True/False). Used for premium distribution and OTT platform requirements. | Column uhd_4k_available_flag (BOOLEAN) in content.package',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in content.package',
    `value_usd` DECIMAL(18,2) COMMENT 'The estimated or contracted commercial value of the package in United States Dollars (USD). Used for revenue forecasting, deal valuation, and financial reporting. | Column value_usd (DECIMAL(15,2)) in content.package',
    CONSTRAINT pk_package PRIMARY KEY(`package_id`)
) COMMENT 'Defines a curated bundle of titles assembled for a specific commercial or distribution purpose — a syndication package, SVOD library deal, MVPD carriage bundle, or FAST channel lineup. Captures package name, package type (syndication/svod-library/avod-catalog/fast-channel/educational/international), package status, effective date, expiry date, territory scope, exclusivity flag, and the commercial context it was assembled for. Acts as the content-side counterpart to distribution and rights deal structures. | Unity Catalog table: media_broadcasting_ecm.content.package Aligned with EBU CCDM (Tech 3351) Class Conceptual Data Model semantics.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`package_title` (
    `package_title_id` BIGINT COMMENT 'Primary key for the package_title association',
    `package_id` BIGINT COMMENT 'Foreign key linking to the parent package that contains this title inclusion record',
    `title_id` BIGINT COMMENT 'Foreign key linking to the content title included in the package',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this specific titles inclusion in this package is on an exclusive basis. Distinct from the package-level exclusivity_flag on content.package, which applies to the entire package. A package may be non-exclusive overall but contain individual titles with exclusive inclusion terms.',
    `inclusion_date` DATE COMMENT 'The date on which this title was formally added to the package. Used for rights tracking, royalty calculation start points, and inclusion history auditing. Belongs to the relationship, not to either parent entity.',
    `inclusion_status` STRING COMMENT 'Current lifecycle status of this titles inclusion in the package. Tracks whether the inclusion is active, pending rights clearance, suspended, or expired. Enables distribution teams to manage partial package availability when individual titles have rights issues.',
    `rights_window_end` DATE COMMENT 'The end date of the rights window for this specific title within this specific package. May differ from the packages overall expiry_date when per-title rights are negotiated separately. Derived from the title_specific_rights_window identified in the detection phase.',
    `rights_window_start` DATE COMMENT 'The start date of the rights window for this specific title within this specific package. May differ from the packages overall effective_date when per-title rights are negotiated separately. Derived from the title_specific_rights_window identified in the detection phase.',
    `sequence_number` BIGINT COMMENT 'The ordered position of this title within the package lineup. Used for FAST channel scheduling order, catalog display order, and syndication slot assignment. Belongs to the inclusion relationship, not to the title or package independently.',
    CONSTRAINT pk_package_title PRIMARY KEY(`package_title_id`)
) COMMENT 'This association product represents the Contract between package and title in media broadcasting distribution operations. It captures the operational record of which titles are included in which packages, along with the per-title commercial and rights terms that govern each inclusion. Each record links one package to one title and carries attributes — sequence position, inclusion date, per-title exclusivity, and title-specific rights window — that exist only in the context of this package-title relationship and cannot reside on either parent entity alone.. Existence Justification: In media broadcasting, a package is explicitly defined as a curated bundle of titles — meaning a package contains multiple titles, and a single title (e.g., a film or episode) can appear in multiple packages simultaneously (e.g., an SVOD library deal, a syndication package, and a FAST channel lineup). Distribution teams actively manage which titles are included in which packages, negotiate per-title terms within a package, and track inclusion history for rights and royalty purposes. This is a genuine operational M:N relationship that the business creates, updates, and deletes as part of its core distribution workflow.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ADD CONSTRAINT `fk_content_title_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ADD CONSTRAINT `fk_content_title_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ADD CONSTRAINT `fk_content_title_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ADD CONSTRAINT `fk_content_series_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ADD CONSTRAINT `fk_content_series_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ADD CONSTRAINT `fk_content_genre_parent_genre_id` FOREIGN KEY (`parent_genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ADD CONSTRAINT `fk_content_lifecycle_event_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ADD CONSTRAINT `fk_content_lifecycle_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_title` ADD CONSTRAINT `fk_content_package_title_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`package`(`package_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_title` ADD CONSTRAINT `fk_content_package_title_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`content` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`content` SET TAGS ('dbx_domain' = 'content');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `genre_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `genre_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `genre_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.genre_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `genre_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.genre_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Master Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Rights Holder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `holder_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `holder_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.primary_rights_holder_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `holder_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.primary_rights_holder_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `series_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `series_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.series_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `series_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.series_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Content Acquisition Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.acquisition_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.acquisition_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `archive_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `archive_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.archive_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `archive_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.archive_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.audio_description_available_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.audio_description_available_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.closed_caption_available_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.closed_caption_available_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `color_format` SET TAGS ('dbx_business_glossary_term' = 'Color Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `color_format` SET TAGS ('dbx_value_regex' = 'color|black_and_white|colorized');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `color_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `color_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.color_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `color_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.color_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `color_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `content_status` SET TAGS ('dbx_business_glossary_term' = 'Content Lifecycle Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `content_status` SET TAGS ('dbx_value_regex' = 'active|archived|restricted|pending|expired|withdrawn');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `content_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `content_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.content_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `content_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.content_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `content_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `content_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `content_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.content_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `content_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.content_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `content_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `coppa_child_directed_flag` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Child-Directed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `coppa_child_directed_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `coppa_child_directed_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.coppa_child_directed_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `coppa_child_directed_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.coppa_child_directed_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.country_of_origin');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.country_of_origin');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `distributor_name` SET TAGS ('dbx_business_glossary_term' = 'Distributor Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `distributor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `distributor_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `distributor_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.distributor_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `distributor_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.distributor_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `dummy_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `eidr_code` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `eidr_code` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `eidr_code` SET TAGS ('dbx_validation_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `eidr_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `eidr_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.eidr_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `eidr_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.eidr_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `eidr_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `eidr_code` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `eidr_code` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `episode_number` SET TAGS ('dbx_business_glossary_term' = 'Episode Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `episode_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `episode_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.episode_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `episode_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.episode_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `hd_available_flag` SET TAGS ('dbx_business_glossary_term' = 'High Definition (HD) Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `hd_available_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `hd_available_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.hd_available_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `hd_available_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.hd_available_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_value_regex' = '^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_validation_regex' = '^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.isan');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.isan');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_business_glossary_term' = 'International Standard Recording Code (ISRC)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_validation_regex' = '^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.isrc');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.isrc');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Content Keywords');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `keywords` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `keywords` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.keywords');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `keywords` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.keywords');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_name` SET TAGS ('dbx_business_glossary_term' = 'Title Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.title_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.title_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_name` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_name` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_language` SET TAGS ('dbx_business_glossary_term' = 'Original Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_language` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_language` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.original_language');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_language` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.original_language');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_language` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_title` SET TAGS ('dbx_business_glossary_term' = 'Original Title Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_title` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_title` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.original_title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_title` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.original_title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_title` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_title` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `parental_advisory_flag` SET TAGS ('dbx_business_glossary_term' = 'Parental Advisory Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `parental_advisory_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `parental_advisory_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.parental_advisory_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `parental_advisory_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.parental_advisory_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `premiere_flag` SET TAGS ('dbx_business_glossary_term' = 'Premiere Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `premiere_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `premiere_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.premiere_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `premiere_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.premiere_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `production_year` SET TAGS ('dbx_business_glossary_term' = 'Production Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `production_year` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `production_year` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.production_year');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `production_year` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.production_year');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Original Release Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `release_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `release_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.release_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `release_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.release_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rights_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Availability Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rights_status` SET TAGS ('dbx_value_regex' = 'available|restricted|expired|pending_clearance|blackout');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rights_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rights_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.rights_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rights_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.rights_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rights_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_business_glossary_term' = 'Runtime in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.runtime_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.runtime_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `season_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `season_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.season_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `season_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.season_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `studio_name` SET TAGS ('dbx_business_glossary_term' = 'Production Studio Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `studio_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `studio_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `studio_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.studio_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `studio_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.studio_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `sub_genre` SET TAGS ('dbx_business_glossary_term' = 'Sub-Genre Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `sub_genre` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `sub_genre` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.sub_genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `sub_genre` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.sub_genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Long Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.synopsis_long');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.synopsis_long');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Short Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.synopsis_short');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.synopsis_short');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `theatrical_release_flag` SET TAGS ('dbx_business_glossary_term' = 'Theatrical Release Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `theatrical_release_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `theatrical_release_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.theatrical_release_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `theatrical_release_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.theatrical_release_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `uhd_4k_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Ultra High Definition (UHD) 4K Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `uhd_4k_available_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `uhd_4k_available_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.uhd_4k_available_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `uhd_4k_available_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.uhd_4k_available_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.title.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.title.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `series_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `series_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.series_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `series_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.series_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `rating_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `rating_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.content_rating_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `rating_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.content_rating_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `genre_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `genre_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.genre_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `genre_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.genre_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Rights Holder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `holder_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `holder_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.primary_rights_holder_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `holder_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.primary_rights_holder_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Showrunner Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'Archive Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `archive_location` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `archive_location` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.archive_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `archive_location` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.archive_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.audio_description_available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.audio_description_available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `audio_format` SET TAGS ('dbx_business_glossary_term' = 'Audio Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `audio_format` SET TAGS ('dbx_value_regex' = 'stereo|surround_5_1|surround_7_1|dolby_atmos|dts_x');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `audio_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `audio_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.audio_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `audio_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.audio_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `audio_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.closed_caption_available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.closed_caption_available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.country_of_origin');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.country_of_origin');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `distributor` SET TAGS ('dbx_business_glossary_term' = 'Distributor');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `distributor` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `distributor` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.distributor');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `distributor` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.distributor');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `dummy_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `eidr_code` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `eidr_code` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `eidr_code` SET TAGS ('dbx_validation_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `eidr_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `eidr_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.eidr_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `eidr_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.eidr_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `eidr_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `episode_runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Episode Runtime Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `episode_runtime_minutes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `episode_runtime_minutes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.episode_runtime_minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `episode_runtime_minutes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.episode_runtime_minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `finale_date` SET TAGS ('dbx_business_glossary_term' = 'Finale Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `finale_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `finale_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.finale_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `finale_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.finale_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `franchise_name` SET TAGS ('dbx_business_glossary_term' = 'Franchise Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `franchise_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `franchise_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `franchise_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.franchise_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `franchise_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.franchise_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `hdr_format` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `hdr_format` SET TAGS ('dbx_value_regex' = 'SDR|HDR10|HDR10_PLUS|DOLBY_VISION|HLG');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `hdr_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `hdr_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.hdr_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `hdr_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.hdr_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `hdr_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `isan_code` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `isan_code` SET TAGS ('dbx_value_regex' = '^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `isan_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `isan_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.isan_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `isan_code` SET TAGS ('dbx_regex' = '^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}(-[0-9A-F]{4}-[0-9A-F]{4})?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `isan_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.isan_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `isan_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `keywords` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `keywords` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.keywords');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `keywords` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.keywords');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `language_original` SET TAGS ('dbx_business_glossary_term' = 'Original Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `language_original` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `language_original` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `language_original` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.language_original');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `language_original` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.language_original');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `language_original` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `news_wire_source` SET TAGS ('dbx_business_glossary_term' = 'News Wire Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `original_network` SET TAGS ('dbx_business_glossary_term' = 'Original Network');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `original_network` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `original_network` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.original_network');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `original_network` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.original_network');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `premiere_date` SET TAGS ('dbx_business_glossary_term' = 'Premiere Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `premiere_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `premiere_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.premiere_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `premiere_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.premiere_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `production_company` SET TAGS ('dbx_business_glossary_term' = 'Production Company');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `production_company` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `production_company` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.production_company');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `production_company` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.production_company');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `resolution_standard` SET TAGS ('dbx_business_glossary_term' = 'Resolution Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `resolution_standard` SET TAGS ('dbx_value_regex' = 'SD|HD|FHD|UHD|4K|8K');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `resolution_standard` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `resolution_standard` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.resolution_standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `resolution_standard` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.resolution_standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `resolution_standard` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `series_status` SET TAGS ('dbx_business_glossary_term' = 'Series Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `series_status` SET TAGS ('dbx_value_regex' = 'ongoing|ended|cancelled|hiatus|in_development|pre_production');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `series_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `series_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.series_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `series_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.series_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `series_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `series_type` SET TAGS ('dbx_business_glossary_term' = 'Series Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `series_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `series_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.series_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `series_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.series_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `series_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `syndication_eligible` SET TAGS ('dbx_business_glossary_term' = 'Syndication Eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `syndication_eligible` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `syndication_eligible` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.syndication_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `syndication_eligible` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.syndication_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Long Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.synopsis_long');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.synopsis_long');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Short Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.synopsis_short');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.synopsis_short');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Series Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `title` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `title` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `title` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `title_original` SET TAGS ('dbx_business_glossary_term' = 'Original Series Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `title_original` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `title_original` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.title_original');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `title_original` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.title_original');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `total_episode_count` SET TAGS ('dbx_business_glossary_term' = 'Total Episode Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `total_episode_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `total_episode_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.total_episode_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `total_episode_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.total_episode_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `total_season_count` SET TAGS ('dbx_business_glossary_term' = 'Total Season Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `total_season_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `total_season_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.total_season_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `total_season_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.total_season_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.series.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.series.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.season_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.season_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rating_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rating_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.content_rating_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rating_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.content_rating_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `genre_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `genre_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.genre_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `genre_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.genre_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Trailer Asset Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `holder_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `holder_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.primary_rights_holder_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `holder_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.primary_rights_holder_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `series_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `series_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.series_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `series_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.series_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `archive_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `archive_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.archive_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `archive_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.archive_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'Archive Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `archive_location` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `archive_location` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.archive_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `archive_location` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.archive_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `awards_nominated` SET TAGS ('dbx_business_glossary_term' = 'Awards Nominated');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `awards_nominated` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `awards_nominated` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.awards_nominated');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `awards_nominated` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.awards_nominated');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `awards_won` SET TAGS ('dbx_business_glossary_term' = 'Awards Won');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `awards_won` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `awards_won` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.awards_won');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `awards_won` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.awards_won');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `banner_artwork_url` SET TAGS ('dbx_business_glossary_term' = 'Banner Artwork Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `banner_artwork_url` SET TAGS ('dbx_validation_regex_^https?' = '//[^s]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `banner_artwork_url` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `banner_artwork_url` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.banner_artwork_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `banner_artwork_url` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.banner_artwork_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `distributor` SET TAGS ('dbx_business_glossary_term' = 'Distributor');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `distributor` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `distributor` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.distributor');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `distributor` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.distributor');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `dummy_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `eidr` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `eidr` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `eidr` SET TAGS ('dbx_validation_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `eidr` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `eidr` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.eidr');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `eidr` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.eidr');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `episode_count_aired` SET TAGS ('dbx_business_glossary_term' = 'Episode Count Aired');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `episode_count_aired` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `episode_count_aired` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.episode_count_aired');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `episode_count_aired` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.episode_count_aired');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `episode_count_ordered` SET TAGS ('dbx_business_glossary_term' = 'Episode Count Ordered');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `episode_count_ordered` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `episode_count_ordered` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.episode_count_ordered');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `episode_count_ordered` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.episode_count_ordered');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `episode_count_produced` SET TAGS ('dbx_business_glossary_term' = 'Episode Count Produced');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `episode_count_produced` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `episode_count_produced` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.episode_count_produced');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `episode_count_produced` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.episode_count_produced');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `finale_date` SET TAGS ('dbx_business_glossary_term' = 'Season Finale Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `finale_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `finale_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.finale_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `finale_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.finale_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `isan` SET TAGS ('dbx_value_regex' = '^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `isan` SET TAGS ('dbx_validation_regex' = '^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `isan` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `isan` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.isan');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `isan` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.isan');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `language_original` SET TAGS ('dbx_business_glossary_term' = 'Original Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `language_original` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `language_original` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `language_original` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.language_original');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `language_original` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.language_original');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `language_original` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `network_original` SET TAGS ('dbx_business_glossary_term' = 'Original Network');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `network_original` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `network_original` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.network_original');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `network_original` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.network_original');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `original_air_date` SET TAGS ('dbx_business_glossary_term' = 'Original Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `original_air_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `original_air_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.original_air_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `original_air_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.original_air_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `poster_artwork_url` SET TAGS ('dbx_business_glossary_term' = 'Poster Artwork Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `poster_artwork_url` SET TAGS ('dbx_validation_regex_^https?' = '//[^s]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `poster_artwork_url` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `poster_artwork_url` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.poster_artwork_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `poster_artwork_url` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.poster_artwork_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `production_company` SET TAGS ('dbx_business_glossary_term' = 'Production Company');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `production_company` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `production_company` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.production_company');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `production_company` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.production_company');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `production_year` SET TAGS ('dbx_business_glossary_term' = 'Production Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `production_year` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `production_year` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.production_year');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `production_year` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.production_year');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Rights Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_expiry_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_expiry_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.rights_expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_expiry_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.rights_expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_holder` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_holder` SET TAGS ('dbx_denormalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_holder` SET TAGS ('dbx_normalize_to' = 'primary_rights_holder_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_holder` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_holder` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.rights_holder');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_holder` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.rights_holder');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_territory` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_territory` SET TAGS ('dbx_denormalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_territory` SET TAGS ('dbx_normalize_to' = 'rights_territory_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_territory` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_territory` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.rights_territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_territory` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.rights_territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_territory` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.season_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.season_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_status` SET TAGS ('dbx_business_glossary_term' = 'Season Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.season_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.season_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Long Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.synopsis_long');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.synopsis_long');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Short Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.synopsis_short');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.synopsis_short');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Season Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `title` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `title` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `title` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Runtime Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.total_runtime_minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.total_runtime_minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.season.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.season.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.content_episode_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.content_episode_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `rating_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `rating_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.content_rating_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `rating_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.content_rating_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Content Season Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `season_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `season_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.content_season_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `season_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.content_season_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Content Series Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `series_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `series_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.content_series_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `series_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.content_series_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `genre_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `genre_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.genre_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `genre_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.genre_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Master Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.master_media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.master_media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `title_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `title_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `title_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `archive_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `archive_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.archive_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `archive_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.archive_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'Archive Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `archive_location` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `archive_location` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.archive_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `archive_location` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.archive_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.audio_description_available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.audio_description_available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `audio_format` SET TAGS ('dbx_business_glossary_term' = 'Audio Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `audio_format` SET TAGS ('dbx_value_regex' = 'stereo|5.1|7.1|dolby_atmos|dts_x');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `audio_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `audio_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.audio_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `audio_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.audio_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `audio_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `breaking_news_flag` SET TAGS ('dbx_business_glossary_term' = 'Breaking News Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `broadcast_count` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `broadcast_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `broadcast_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.broadcast_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `broadcast_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.broadcast_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.closed_caption_available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.closed_caption_available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `content_advisory` SET TAGS ('dbx_business_glossary_term' = 'Content Advisory');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `content_advisory` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `content_advisory` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.content_advisory');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `content_advisory` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.content_advisory');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `content_advisory` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `dummy_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_validation_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.eidr_identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.eidr_identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `episode_number` SET TAGS ('dbx_business_glossary_term' = 'Episode Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `episode_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `episode_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.episode_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `episode_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.episode_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `episode_status` SET TAGS ('dbx_business_glossary_term' = 'Episode Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `episode_status` SET TAGS ('dbx_value_regex' = 'in_production|post_production|ready_for_broadcast|aired|archived|withdrawn');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `episode_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `episode_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.episode_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `episode_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.episode_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `episode_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `episode_type` SET TAGS ('dbx_business_glossary_term' = 'Episode Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `episode_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `episode_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.episode_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `episode_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.episode_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `episode_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Content Keywords');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `keywords` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `keywords` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.keywords');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `keywords` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.keywords');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `music_cue_sheet_submitted` SET TAGS ('dbx_business_glossary_term' = 'Music Cue Sheet Submitted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `music_cue_sheet_submitted` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `music_cue_sheet_submitted` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.music_cue_sheet_submitted');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `music_cue_sheet_submitted` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.music_cue_sheet_submitted');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `original_air_date` SET TAGS ('dbx_business_glossary_term' = 'Original Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `original_air_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `original_air_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.original_air_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `original_air_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.original_air_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `premiere_flag` SET TAGS ('dbx_business_glossary_term' = 'Premiere Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `premiere_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `premiere_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.premiere_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `premiere_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.premiere_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `primary_language` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `primary_language` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.primary_language');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `primary_language` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.primary_language');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `primary_language` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `production_code` SET TAGS ('dbx_business_glossary_term' = 'Production Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `production_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `production_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.production_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `production_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.production_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `production_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `rerun_flag` SET TAGS ('dbx_business_glossary_term' = 'Rerun Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `rerun_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `rerun_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.rerun_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `rerun_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.rerun_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|restricted|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.rights_clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.rights_clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_business_glossary_term' = 'Runtime in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.runtime_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.runtime_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `runtime_with_ads_seconds` SET TAGS ('dbx_business_glossary_term' = 'Runtime With Advertisements in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `runtime_with_ads_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `runtime_with_ads_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.runtime_with_ads_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `runtime_with_ads_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.runtime_with_ads_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `subtitles_available` SET TAGS ('dbx_business_glossary_term' = 'Subtitles Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `subtitles_available` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `subtitles_available` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.subtitles_available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `subtitles_available` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.subtitles_available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Episode Synopsis Long');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.synopsis_long');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.synopsis_long');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Episode Synopsis Short');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.synopsis_short');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.synopsis_short');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Episode Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `title` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `title` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `title` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `video_resolution` SET TAGS ('dbx_value_regex' = 'SD|HD|FHD|UHD|4K|8K');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `video_resolution` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `video_resolution` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.video_resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `video_resolution` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.video_resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `video_resolution` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `vod_available_from_date` SET TAGS ('dbx_business_glossary_term' = 'Video On Demand (VOD) Available From Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `vod_available_from_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `vod_available_from_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.vod_available_from_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `vod_available_from_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.vod_available_from_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `vod_available_until_date` SET TAGS ('dbx_business_glossary_term' = 'Video On Demand (VOD) Available Until Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `vod_available_until_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `vod_available_until_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.content_episode.vod_available_until_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `vod_available_until_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.content_episode.vod_available_until_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Version Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `rating_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `rating_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.content_rating_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `rating_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.content_rating_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `grant_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `grant_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.grant_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `grant_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.grant_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Master Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.master_media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.master_media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `title_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `title_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `title_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.approved_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.approved_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.archived_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.archived_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.audio_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.audio_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.audio_description_available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.audio_description_available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_track_configuration` SET TAGS ('dbx_business_glossary_term' = 'Audio Track Configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_track_configuration` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_track_configuration` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.audio_track_configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_track_configuration` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.audio_track_configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `broadcast_safe` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Safe');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `broadcast_safe` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `broadcast_safe` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.broadcast_safe');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `broadcast_safe` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.broadcast_safe');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'Checksum Message Digest 5 (MD5)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{32}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_validation_regex' = '^[a-fA-F0-9]{32}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.checksum_md5');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.checksum_md5');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.closed_caption_available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.closed_caption_available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `color_space` SET TAGS ('dbx_business_glossary_term' = 'Color Space');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `color_space` SET TAGS ('dbx_value_regex' = 'rec_709|rec_2020|dci_p3|srgb');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `color_space` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `color_space` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.color_space');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `color_space` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.color_space');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `color_space` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `content_advisory` SET TAGS ('dbx_business_glossary_term' = 'Content Advisory');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `content_advisory` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `content_advisory` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.content_advisory');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `content_advisory` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.content_advisory');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `content_advisory` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `dummy_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `editorial_workflow_state` SET TAGS ('dbx_business_glossary_term' = 'Editorial Workflow State');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `eidr_code` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `eidr_code` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `eidr_code` SET TAGS ('dbx_validation_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `eidr_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `eidr_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.eidr_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `eidr_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.eidr_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `eidr_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `eidr_code` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `eidr_code` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `file_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `file_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.file_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `file_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.file_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `file_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.file_size_bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.file_size_bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.frame_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.frame_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `hdr_format` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `hdr_format` SET TAGS ('dbx_value_regex' = 'sdr|hdr10|hdr10_plus|dolby_vision|hlg');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `hdr_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `hdr_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.hdr_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `hdr_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.hdr_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `hdr_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `isan_code` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN) Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `isan_code` SET TAGS ('dbx_value_regex' = '^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `isan_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `isan_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.isan_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `isan_code` SET TAGS ('dbx_regex' = '^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}(-[0-9A-F]{4}-[0-9A-F]{4})?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `isan_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.isan_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `isan_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `isan_code` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `isan_code` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `isrc_code` SET TAGS ('dbx_business_glossary_term' = 'International Standard Recording Code (ISRC) Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `isrc_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `isrc_code` SET TAGS ('dbx_validation_regex' = '^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `isrc_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `isrc_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.isrc_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `isrc_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.isrc_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `isrc_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `isrc_code` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `isrc_code` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `label` SET TAGS ('dbx_business_glossary_term' = 'Version Label');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `label` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `label` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.label');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `label` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.label');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `label` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `label` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_validation_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.primary_language_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.primary_language_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `qc_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Completed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `qc_completed_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `qc_completed_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.qc_completed_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `qc_completed_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.qc_completed_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `qc_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `qc_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed|conditional_pass');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `qc_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `qc_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.qc_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `qc_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.qc_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `qc_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `resolution` SET TAGS ('dbx_value_regex' = 'sd|hd_720p|hd_1080p|uhd_4k|uhd_8k');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `resolution` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `resolution` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `resolution` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `runtime_delta_seconds` SET TAGS ('dbx_business_glossary_term' = 'Runtime Delta in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `runtime_delta_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `runtime_delta_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.runtime_delta_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `runtime_delta_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.runtime_delta_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_business_glossary_term' = 'Runtime in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.runtime_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.runtime_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `storage_location` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `storage_location` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.storage_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `storage_location` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.storage_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.subtitle_languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.subtitle_languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `target_territory` SET TAGS ('dbx_business_glossary_term' = 'Target Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `target_territory` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `target_territory` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `target_territory` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.target_territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `target_territory` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.target_territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.version_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.version_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_status` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_status` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Version Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.version_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.version_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_type` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_type` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `video_codec` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `video_codec` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.version.video_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `video_codec` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.version.video_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `video_codec` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.genre_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.genre_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `parent_genre_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Genre Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `parent_genre_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `parent_genre_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.parent_genre_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `parent_genre_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.parent_genre_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `ad_pod_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Compatibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `ad_pod_compatibility` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `ad_pod_compatibility` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.ad_pod_compatibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `ad_pod_compatibility` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.ad_pod_compatibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `applicable_content_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Content Types');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `applicable_content_types` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `applicable_content_types` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.applicable_content_types');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `applicable_content_types` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.applicable_content_types');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `archive_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Archive Retention Policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `archive_retention_policy` SET TAGS ('dbx_value_regex' = 'permanent|long_term|standard|short_term');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `archive_retention_policy` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `archive_retention_policy` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.archive_retention_policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `archive_retention_policy` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.archive_retention_policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `avod_monetization_potential` SET TAGS ('dbx_business_glossary_term' = 'Advertising-Supported Video On Demand (AVOD) Monetization Potential');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `avod_monetization_potential` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `avod_monetization_potential` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `avod_monetization_potential` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.avod_monetization_potential');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `avod_monetization_potential` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.avod_monetization_potential');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_code` SET TAGS ('dbx_business_glossary_term' = 'Genre Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.genre_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.genre_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `daypart_affinity` SET TAGS ('dbx_business_glossary_term' = 'Daypart Affinity');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `daypart_affinity` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `daypart_affinity` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.daypart_affinity');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `daypart_affinity` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.daypart_affinity');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_description` SET TAGS ('dbx_business_glossary_term' = 'Genre Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_description` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_description` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.genre_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_description` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.genre_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `dummy_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.effective_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.effective_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.effective_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.effective_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `eidr_genre_mapping` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Genre Mapping');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `eidr_genre_mapping` SET TAGS ('dbx_validation_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `eidr_genre_mapping` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `eidr_genre_mapping` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.eidr_genre_mapping');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `eidr_genre_mapping` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.eidr_genre_mapping');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `fast_channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Free Ad-Supported Streaming Television (FAST) Channel Applicability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `fast_channel_applicability` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `fast_channel_applicability` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.fast_channel_applicability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `fast_channel_applicability` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.fast_channel_applicability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `geographic_restriction_applicability` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Applicability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `geographic_restriction_applicability` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `geographic_restriction_applicability` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.geographic_restriction_applicability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `geographic_restriction_applicability` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.geographic_restriction_applicability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `iab_content_category` SET TAGS ('dbx_business_glossary_term' = 'Interactive Advertising Bureau (IAB) Content Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `iab_content_category` SET TAGS ('dbx_value_regex' = '^IAB[0-9]{1,2}(-[0-9]{1,2})?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `iab_content_category` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `iab_content_category` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.iab_content_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `iab_content_category` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.iab_content_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `iab_content_category` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `is_active` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `is_active` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.is_active');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `is_active` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.is_active');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `linear_broadcast_suitability` SET TAGS ('dbx_business_glossary_term' = 'Linear Broadcast Suitability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `linear_broadcast_suitability` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `linear_broadcast_suitability` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.linear_broadcast_suitability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `linear_broadcast_suitability` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.linear_broadcast_suitability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `localization_priority` SET TAGS ('dbx_business_glossary_term' = 'Localization Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `localization_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `localization_priority` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `localization_priority` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.localization_priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `localization_priority` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.localization_priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `metadata_enrichment_priority` SET TAGS ('dbx_business_glossary_term' = 'Metadata Enrichment Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `metadata_enrichment_priority` SET TAGS ('dbx_value_regex' = 'critical|standard|minimal');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `metadata_enrichment_priority` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `metadata_enrichment_priority` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.metadata_enrichment_priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `metadata_enrichment_priority` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.metadata_enrichment_priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `mpa_rating_applicability` SET TAGS ('dbx_business_glossary_term' = 'Motion Picture Association (MPA) Rating Applicability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `mpa_rating_applicability` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `mpa_rating_applicability` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.mpa_rating_applicability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `mpa_rating_applicability` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.mpa_rating_applicability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_name` SET TAGS ('dbx_business_glossary_term' = 'Genre Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.genre_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.genre_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `nielsen_genre_code` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Genre Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `nielsen_genre_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `nielsen_genre_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.nielsen_genre_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `nielsen_genre_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.nielsen_genre_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `nielsen_genre_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `ott_platform_priority` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Top (OTT) Platform Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `ott_platform_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `ott_platform_priority` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `ott_platform_priority` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.ott_platform_priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `ott_platform_priority` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.ott_platform_priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `parental_guidance_flag` SET TAGS ('dbx_business_glossary_term' = 'Parental Guidance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `parental_guidance_flag` SET TAGS ('dbx_validation_regex' = '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `parental_guidance_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `parental_guidance_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.parental_guidance_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `parental_guidance_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.parental_guidance_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `svod_performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Subscription Video On Demand (SVOD) Performance Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `svod_performance_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|catalog');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `svod_performance_tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `svod_performance_tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.svod_performance_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `svod_performance_tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.svod_performance_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `svod_performance_tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `syndication_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Syndication Eligibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `syndication_eligibility` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `syndication_eligibility` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.syndication_eligibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `syndication_eligibility` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.syndication_eligibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `target_demographic` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `target_demographic` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.target_demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `target_demographic` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.target_demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `target_demographic` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Genre Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.genre_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.genre_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `usage_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `usage_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `usage_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.genre.usage_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `usage_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.genre.usage_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Rating Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `rating_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `rating_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.rating_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `rating_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.rating_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_appealed|appeal_pending|appeal_approved|appeal_denied');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `appeal_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `appeal_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.appeal_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `appeal_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.appeal_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `appeal_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `body` SET TAGS ('dbx_business_glossary_term' = 'Rating Body');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `body` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `body` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.body');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `body` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.body');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Rating Certificate Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `certificate_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `certificate_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.certificate_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `certificate_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.certificate_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `rating_code` SET TAGS ('dbx_business_glossary_term' = 'Rating Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `rating_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `rating_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.rating_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `rating_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.rating_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `rating_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_drug_use` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptor Drug Use');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_drug_use` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_drug_use` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.content_descriptor_drug_use');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_drug_use` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.content_descriptor_drug_use');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_fear` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptor Fear');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_fear` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_fear` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.content_descriptor_fear');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_fear` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.content_descriptor_fear');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_language` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptor Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_language` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_language` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.content_descriptor_language');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_language` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.content_descriptor_language');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_nudity` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptor Nudity');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_nudity` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_nudity` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.content_descriptor_nudity');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_nudity` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.content_descriptor_nudity');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_violence` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptor Violence');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_violence` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_violence` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.content_descriptor_violence');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_violence` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.content_descriptor_violence');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `rating_description` SET TAGS ('dbx_business_glossary_term' = 'Rating Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `rating_description` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `rating_description` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.rating_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `rating_description` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.rating_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `dummy_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `effective_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `effective_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.effective_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `effective_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.effective_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `expiration_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `expiration_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.expiration_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `expiration_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.expiration_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `minimum_age` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `minimum_age` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `minimum_age` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.minimum_age');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `minimum_age` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.minimum_age');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rating Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `parental_control_enabled` SET TAGS ('dbx_business_glossary_term' = 'Parental Control Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `parental_control_enabled` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `parental_control_enabled` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.parental_control_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `parental_control_enabled` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.parental_control_enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.regulatory_mandate_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.regulatory_mandate_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Submission Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `submission_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `submission_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.submission_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `submission_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.submission_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `system` SET TAGS ('dbx_business_glossary_term' = 'Rating System');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `system` SET TAGS ('dbx_value_regex' = 'MPA|TVPG|BBFC|FSK|OFLC|CBFC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `system` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `system` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.system');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `system` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.system');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `territory_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `territory_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.territory_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `territory_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.territory_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `territory_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Rating Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `version` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `version` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.rating.version');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `version` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.rating.version');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `talent_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Credit Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `talent_credit_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `talent_credit_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.talent_credit_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `talent_credit_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.talent_credit_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Episode Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.content_episode_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.content_episode_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `contract_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `contract_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.contract_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `contract_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.contract_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `crew_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Role Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `role_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `role_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.role_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `role_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.role_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `title_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `title_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `title_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `billing_position` SET TAGS ('dbx_business_glossary_term' = 'Billing Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `billing_position` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `billing_position` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.billing_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `billing_position` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.billing_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `byline_text` SET TAGS ('dbx_business_glossary_term' = 'Byline Text');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_approval_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_approval_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.credit_approval_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_approval_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.credit_approval_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|disputed|rejected|arbitration');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_approval_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_approval_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.credit_approval_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_approval_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.credit_approval_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_approval_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_category` SET TAGS ('dbx_business_glossary_term' = 'Credit Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_category` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_category` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.credit_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_category` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.credit_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_category` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_name` SET TAGS ('dbx_business_glossary_term' = 'Credit Display Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.credit_display_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.credit_display_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_order` SET TAGS ('dbx_business_glossary_term' = 'Credit Display Order');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_order` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_order` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.credit_display_order');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_order` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.credit_display_order');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Credit End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_end_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_end_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.credit_end_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_end_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.credit_end_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_notes` SET TAGS ('dbx_business_glossary_term' = 'Credit Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.credit_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.credit_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Credit Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_start_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_start_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.credit_start_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_start_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.credit_start_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_type` SET TAGS ('dbx_value_regex' = 'on-screen|off-screen|voice|stunt|archive');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.credit_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.credit_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `dummy_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `pseudonym_flag` SET TAGS ('dbx_business_glossary_term' = 'Pseudonym Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `pseudonym_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `pseudonym_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.pseudonym_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `pseudonym_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.pseudonym_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `residuals_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residuals Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `residuals_eligibility_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `residuals_eligibility_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.residuals_eligibility_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `residuals_eligibility_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.residuals_eligibility_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `union_affiliation_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `union_affiliation_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `union_affiliation_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.union_affiliation_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `union_affiliation_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.union_affiliation_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.talent_credit.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.talent_credit.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` SET TAGS ('dbx_subdomain' = 'distribution_packaging');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.acquisition_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.acquisition_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `version_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `version_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.content_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `version_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.content_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `ingest_job_id` SET TAGS ('dbx_business_glossary_term' = 'Ingest Job Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `title_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `title_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `title_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.acquisition_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.acquisition_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_value_regex' = 'negotiating|committed|delivered|active|cancelled|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.acquisition_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.acquisition_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_value_regex' = 'purchase|license|co-production|commission|barter|syndication');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.acquisition_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.acquisition_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `ancillary_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Rights Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `ancillary_rights_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `ancillary_rights_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.ancillary_rights_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `ancillary_rights_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.ancillary_rights_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|restricted|failed');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `clearance_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `clearance_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `clearance_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `clearance_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `content_window_type` SET TAGS ('dbx_business_glossary_term' = 'Content Window Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `content_window_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `content_window_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.content_window_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `content_window_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.content_window_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `content_window_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.cost_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.cost_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_currency` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_currency` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.cost_currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_currency` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.cost_currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `delivery_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `delivery_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.delivery_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `delivery_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.delivery_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Delivery Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `delivery_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `delivery_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.delivery_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `delivery_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.delivery_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `delivery_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `dummy_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.exclusivity_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.exclusivity_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `format_rights` SET TAGS ('dbx_business_glossary_term' = 'Format Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `format_rights` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `format_rights` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.format_rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `format_rights` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.format_rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.holdback_period_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.holdback_period_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `language_rights` SET TAGS ('dbx_business_glossary_term' = 'Language Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `language_rights` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `language_rights` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.language_rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `language_rights` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.language_rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_end_date` SET TAGS ('dbx_business_glossary_term' = 'License End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.license_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.license_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_start_date` SET TAGS ('dbx_business_glossary_term' = 'License Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.license_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.license_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.minimum_guarantee_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.minimum_guarantee_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `payment_terms` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `payment_terms` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.payment_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `payment_terms` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.payment_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `reference_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `reference_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.reference_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `reference_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.reference_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `residuals_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Residuals Obligation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `residuals_obligation_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `residuals_obligation_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.residuals_obligation_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `residuals_obligation_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.residuals_obligation_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.royalty_rate_percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.royalty_rate_percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `runs_allowed` SET TAGS ('dbx_business_glossary_term' = 'Runs Allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `runs_allowed` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `runs_allowed` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.runs_allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `runs_allowed` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.runs_allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `runs_consumed` SET TAGS ('dbx_business_glossary_term' = 'Runs Consumed');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `runs_consumed` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `runs_consumed` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.runs_consumed');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `runs_consumed` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.runs_consumed');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Allowed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.sublicensing_allowed_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.sublicensing_allowed_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `territory_scope` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `territory_scope` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.territory_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `territory_scope` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.territory_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.acquisition.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.acquisition.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` SET TAGS ('dbx_subdomain' = 'distribution_packaging');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Event Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `lifecycle_event_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `lifecycle_event_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.lifecycle_event_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `lifecycle_event_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.lifecycle_event_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `version_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `version_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.content_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `version_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.content_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `ingest_job_id` SET TAGS ('dbx_business_glossary_term' = 'Ingest Job Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `title_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `title_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `title_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `automated_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Transition Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `automated_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `automated_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.automated_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `automated_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.automated_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `blocking_condition` SET TAGS ('dbx_business_glossary_term' = 'Blocking Condition');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `blocking_condition` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `blocking_condition` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.blocking_condition');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `blocking_condition` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.blocking_condition');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `blocking_resolved_flag` SET TAGS ('dbx_business_glossary_term' = 'Blocking Resolved Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `blocking_resolved_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `blocking_resolved_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.blocking_resolved_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `blocking_resolved_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.blocking_resolved_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `compliance_checkpoint_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Checkpoint Passed');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `compliance_checkpoint_passed` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `compliance_checkpoint_passed` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.compliance_checkpoint_passed');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `compliance_checkpoint_passed` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.compliance_checkpoint_passed');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_business_glossary_term' = 'Delivery Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.delivery_platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.delivery_platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `dummy_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `event_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `event_sequence_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `event_sequence_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.event_sequence_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `event_sequence_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.event_sequence_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.lifecycle_stage');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.lifecycle_stage');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `new_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `new_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.new_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `new_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.new_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `new_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Event Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `previous_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `previous_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.previous_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `previous_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.previous_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `previous_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `qc_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `qc_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_required|conditional_pass');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `qc_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `qc_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.qc_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `qc_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.qc_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `qc_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `responsible_team` SET TAGS ('dbx_business_glossary_term' = 'Responsible Team');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `responsible_team` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `responsible_team` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.responsible_team');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `responsible_team` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.responsible_team');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `rollback_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollback Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `rollback_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `rollback_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.rollback_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `rollback_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.rollback_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `rollback_reason` SET TAGS ('dbx_business_glossary_term' = 'Rollback Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `rollback_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `rollback_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.rollback_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `rollback_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.rollback_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `sla_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `sla_actual_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `sla_actual_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.sla_actual_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `sla_actual_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.sla_actual_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.sla_breach_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.sla_breach_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `sla_target_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `sla_target_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `sla_target_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.sla_target_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `sla_target_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.sla_target_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `system_source` SET TAGS ('dbx_business_glossary_term' = 'System Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `system_source` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `system_source` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.system_source');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `system_source` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.system_source');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `transition_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Transition Duration Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `transition_duration_hours` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `transition_duration_hours` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.transition_duration_hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `transition_duration_hours` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.transition_duration_hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `transition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transition Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `transition_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `transition_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.transition_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `transition_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.transition_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `triggered_by_event` SET TAGS ('dbx_business_glossary_term' = 'Triggered By Event');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `triggered_by_event` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `triggered_by_event` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.triggered_by_event');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `triggered_by_event` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.triggered_by_event');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Content Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `version_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `version_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.version_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `version_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.version_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `workflow_instance_code` SET TAGS ('dbx_business_glossary_term' = 'Workflow Instance ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `workflow_instance_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `workflow_instance_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.lifecycle_event.workflow_instance_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `workflow_instance_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.lifecycle_event.workflow_instance_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `workflow_instance_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `artwork_id` SET TAGS ('dbx_business_glossary_term' = 'Artwork Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `artwork_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `artwork_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.artwork_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `artwork_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.artwork_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `version_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `version_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.content_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `version_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.content_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Featured Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `title_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `title_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `title_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `approval_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `approval_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.approval_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `approval_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.approval_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `approved_for_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Approved for Use Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `approved_for_use_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `approved_for_use_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.approved_for_use_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `approved_for_use_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.approved_for_use_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'Archive Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `archive_location` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `archive_location` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.archive_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `archive_location` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.archive_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `artwork_type` SET TAGS ('dbx_business_glossary_term' = 'Artwork Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `artwork_type` SET TAGS ('dbx_value_regex' = 'key-art|thumbnail|banner|poster|logo|still');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `artwork_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `artwork_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.artwork_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `artwork_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.artwork_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `artwork_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `color_profile` SET TAGS ('dbx_business_glossary_term' = 'Color Profile');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `color_profile` SET TAGS ('dbx_value_regex' = 'sRGB|Adobe RGB|ProPhoto RGB|CMYK|Rec. 709|Rec. 2020');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `color_profile` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `color_profile` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.color_profile');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `color_profile` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.color_profile');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `content_rating_displayed_flag` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Displayed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `content_rating_displayed_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `content_rating_displayed_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.content_rating_displayed_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `content_rating_displayed_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.content_rating_displayed_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_business_glossary_term' = 'Copyright Holder');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.copyright_holder');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.copyright_holder');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `copyright_year` SET TAGS ('dbx_business_glossary_term' = 'Copyright Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `copyright_year` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `copyright_year` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.copyright_year');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `copyright_year` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.copyright_year');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `dummy_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `eidr` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `eidr` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `eidr` SET TAGS ('dbx_validation_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `eidr` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `eidr` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.eidr');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `eidr` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.eidr');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `expiry_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `expiry_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `expiry_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'JPEG|PNG|TIFF|PSD|SVG|WebP');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `file_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `file_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.file_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `file_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.file_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `file_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.file_size_bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.file_size_bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `height_pixels` SET TAGS ('dbx_business_glossary_term' = 'Height in Pixels');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `height_pixels` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `height_pixels` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.height_pixels');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `height_pixels` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.height_pixels');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `language_code` SET TAGS ('dbx_validation_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `language_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `language_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.language_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `language_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.language_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `language_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `language_overlay_flag` SET TAGS ('dbx_business_glossary_term' = 'Language Overlay Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `language_overlay_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `language_overlay_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.language_overlay_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `language_overlay_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.language_overlay_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `photographer_credit` SET TAGS ('dbx_business_glossary_term' = 'Photographer Credit');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `photographer_credit` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `photographer_credit` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.photographer_credit');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `photographer_credit` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.photographer_credit');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `priority_rank` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `priority_rank` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.priority_rank');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `priority_rank` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.priority_rank');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `resolution_dpi` SET TAGS ('dbx_business_glossary_term' = 'Resolution in Dots Per Inch (DPI)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `resolution_dpi` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `resolution_dpi` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.resolution_dpi');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `resolution_dpi` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.resolution_dpi');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.source_system_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.source_system_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `source_system_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `territory_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `territory_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.territory_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `territory_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.territory_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `territory_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Artwork Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `title` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `title` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `title` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `usage_rights` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `usage_rights` SET TAGS ('dbx_value_regex' = 'all-media|digital-only|print-only|broadcast-only|theatrical-only|promotional-only');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `usage_rights` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `usage_rights` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.usage_rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `usage_rights` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.usage_rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `width_pixels` SET TAGS ('dbx_business_glossary_term' = 'Width in Pixels');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `width_pixels` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `width_pixels` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.artwork.width_pixels');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `width_pixels` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.artwork.width_pixels');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` SET TAGS ('dbx_subdomain' = 'distribution_packaging');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.package_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.package_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `rating_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `rating_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.content_rating_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `rating_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.content_rating_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `genre_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `genre_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.genre_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `genre_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.genre_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.ott_platform_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.ott_platform_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `partner_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `partner_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.distribution_partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `partner_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.distribution_partner_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.audio_description_available_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.audio_description_available_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.closed_caption_available_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.closed_caption_available_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_code` SET TAGS ('dbx_business_glossary_term' = 'Package Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.package_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.package_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `commercial_context` SET TAGS ('dbx_business_glossary_term' = 'Commercial Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `commercial_context` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `commercial_context` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.commercial_context');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `commercial_context` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.commercial_context');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_description` SET TAGS ('dbx_business_glossary_term' = 'Package Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_description` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_description` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.package_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_description` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.package_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `drm_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `drm_required_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `drm_required_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.drm_required_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `drm_required_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.drm_required_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `dummy_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `effective_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `effective_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.effective_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `effective_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.effective_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.exclusivity_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.exclusivity_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `expiry_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `expiry_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `expiry_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `hd_available_flag` SET TAGS ('dbx_business_glossary_term' = 'High Definition (HD) Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `hd_available_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `hd_available_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.hd_available_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `hd_available_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.hd_available_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `keywords` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `keywords` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.keywords');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `keywords` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.keywords');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `language_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `language_primary` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `language_primary` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.language_primary');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `language_primary` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.language_primary');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `modified_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `modified_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.modified_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `modified_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.modified_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_name` SET TAGS ('dbx_business_glossary_term' = 'Package Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.package_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.package_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_status` SET TAGS ('dbx_business_glossary_term' = 'Package Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|archived');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.package_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.package_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'syndication|svod-library|avod-catalog|fast-channel|educational|international');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.package_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.package_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `rights_holder` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `rights_holder` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `rights_holder` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.rights_holder');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `rights_holder` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.rights_holder');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `territory_scope` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `territory_scope` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.territory_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `territory_scope` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.territory_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_validation_regex_^https?' = '//[^s]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.thumbnail_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.thumbnail_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `total_runtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Runtime Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `total_runtime_hours` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `total_runtime_hours` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.total_runtime_hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `total_runtime_hours` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.total_runtime_hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `total_title_count` SET TAGS ('dbx_business_glossary_term' = 'Total Title Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `total_title_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `total_title_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.total_title_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `total_title_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.total_title_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `uhd_4k_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Ultra High Definition (UHD) 4K Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `uhd_4k_available_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `uhd_4k_available_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.uhd_4k_available_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `uhd_4k_available_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.uhd_4k_available_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `value_usd` SET TAGS ('dbx_business_glossary_term' = 'Package Value United States Dollars (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `value_usd` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `value_usd` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.content.package.value_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `value_usd` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.content.package.value_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_title` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_title` SET TAGS ('dbx_subdomain' = 'distribution_packaging');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_title` SET TAGS ('dbx_association_edges' = 'content.package,content.title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_title` ALTER COLUMN `package_title_id` SET TAGS ('dbx_business_glossary_term' = 'Package Title - Package Title Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_title` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Title - Package Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_title` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Package Title - Title Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_title` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Per-Title Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_title` ALTER COLUMN `inclusion_date` SET TAGS ('dbx_business_glossary_term' = 'Title Inclusion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_title` ALTER COLUMN `inclusion_status` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_title` ALTER COLUMN `rights_window_end` SET TAGS ('dbx_business_glossary_term' = 'Title Rights Window End');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_title` ALTER COLUMN `rights_window_start` SET TAGS ('dbx_business_glossary_term' = 'Title Rights Window Start');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_title` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Title Sequence Number');
