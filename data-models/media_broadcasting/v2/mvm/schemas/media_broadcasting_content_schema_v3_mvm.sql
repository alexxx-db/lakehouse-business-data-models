-- Schema for Domain: content | Business: Media_Broadcasting | Version: v3_mvm
-- Generated on: 2026-07-10 21:14:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`content` COMMENT 'Single source of truth for all content assets across the enterprise — covering titles, episodes, series, films, clips, music, news segments, and live events. Manages content metadata (EIDR, ISAN, ISRC identifiers), format specifications, versioning, localization, MPA ratings, genre classification, and content lifecycle from acquisition through archival. Serves as the master catalog referenced by scheduling, distribution, rights, and digital asset domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`title` (
    `title_id` BIGINT COMMENT 'Unique identifier for the content title. Primary key for the title master catalog. Serves as the universal join point referenced by scheduling, distribution, rights, digital asset, and advertising domains.',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: title is the master catalog record for all content assets, yet it stores content_rating as a denormalized STRING while every other major content entity (series, season, content_episode, version, windo',
    `genre_id` BIGINT COMMENT 'FK to content.genre',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.rights_holder. Business justification: Tracks who owns/controls rights to each title - essential for royalty payments, clearance workflows, and determining who must approve licensing deals. Rights holder is the starting point for all right',
    `series_id` BIGINT COMMENT 'Foreign key reference to the parent series for episodic content. Null for standalone films, clips, and non-episodic content.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Titles have primary production/distribution territories that affect rights clearance, regulatory compliance (content ratings), and default licensing assumptions. Clearance workflows validate against t',
    `acquisition_date` DATE COMMENT 'Date when the content rights were acquired by the organization. Used for rights lifecycle tracking, amortization calculations, and contract management.',
    `archive_date` DATE COMMENT 'Date when the content was moved to archived status. Used for content lifecycle management and digital asset retention policies.',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the content. Determines presentation format for broadcast, streaming, and theatrical distribution.. Valid values are `4:3|16:9|21:9|1.85:1|2.39:1`',
    `audio_description_available_flag` BOOLEAN COMMENT 'Indicates whether audio description track is available for visually impaired audiences. Required for accessibility compliance and inclusive broadcasting.',
    `closed_caption_available_flag` BOOLEAN COMMENT 'Indicates whether closed captioning is available for the content. Required for FCC compliance and accessibility standards.',
    `color_format` STRING COMMENT 'Indicates whether the content is in color, black and white, or has been colorized. Used for archival classification and presentation metadata.. Valid values are `color|black_and_white|colorized`',
    `content_status` STRING COMMENT 'Current lifecycle status of the content asset. Determines availability for scheduling, distribution, and monetization. Active content is available for use; archived content is retained but not actively distributed; restricted content has legal or rights limitations.. Valid values are `active|archived|restricted|pending|expired|withdrawn`',
    `content_type` STRING COMMENT 'Discriminator classifying the fundamental type of content asset. Determines applicable business rules for scheduling, rights windowing, and distribution strategies. [ENUM-REF-CANDIDATE: film|series|episode|clip|music|news|live_event|documentary — 8 candidates stripped; promote to reference product]',
    `coppa_child_directed_flag` BOOLEAN COMMENT 'Indicates whether the content is directed to children under 13 years of age. Triggers COPPA compliance requirements for data collection, advertising restrictions, and privacy protections.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 code representing the country where the content was originally produced. Used for rights management, regulatory compliance, and content origin reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the title record was first created in the system. Used for audit trails, data lineage tracking, and operational reporting.',
    `eidr_code` STRING COMMENT 'Universal unique identifier for audiovisual content assigned by the Entertainment Identifier Registry. Used for global content identification and rights management across the media supply chain.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `episode_number` STRING COMMENT 'Episode number within the season for episodic content. Null for non-episodic content. Used for sequential ordering in playout and Electronic Program Guide (EPG) systems.',
    `hd_available_flag` BOOLEAN COMMENT 'Indicates whether a high-definition version of the content is available. Used for channel playout decisions and quality-tier distribution strategies.',
    `isan` STRING COMMENT 'International standard identifier for audiovisual works. Primarily used for films and television programs for rights management and distribution tracking.. Valid values are `^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `isrc` STRING COMMENT 'International standard code for uniquely identifying sound recordings and music video recordings. Used for music tracks and audio content royalty tracking.. Valid values are `^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$`',
    `keywords` STRING COMMENT 'Comma-separated list of keywords and tags describing content themes, subjects, and topics. Used for search optimization, content discovery, and recommendation algorithms.',
    `title_name` STRING COMMENT 'Primary display name of the content title. The human-readable identifier used across all systems and customer-facing platforms.',
    `original_language` STRING COMMENT 'ISO 639-2 three-letter code representing the original language of the content production. Used for localization planning, dubbing, and subtitle workflows.. Valid values are `^[A-Z]{3}$`',
    `original_title` STRING COMMENT 'Original title name in the native language of production. Preserved for rights management, archival, and international distribution purposes.',
    `parental_advisory_flag` BOOLEAN COMMENT 'Indicates whether the content carries a parental advisory warning for explicit content, violence, or mature themes. Used for compliance with broadcast standards and platform content policies.',
    `premiere_flag` BOOLEAN COMMENT 'Indicates whether the content is a premiere or first-run broadcast. Used for promotional scheduling, advertising premium pricing, and audience measurement reporting.',
    `production_year` STRING COMMENT 'Calendar year in which the content was originally produced or completed. Used for catalog organization, rights windowing calculations, and archival classification.',
    `release_date` DATE COMMENT 'Date when the content was first released to the public or premiered. Used for rights availability calculations, windowing strategies, and anniversary programming.',
    `rights_status` STRING COMMENT 'Current rights availability status indicating whether the content can be legally broadcast or distributed. Drives scheduling decisions and geographic blackout enforcement.. Valid values are `available|restricted|expired|pending_clearance|blackout`',
    `runtime_seconds` STRING COMMENT 'Total duration of the content in seconds. Used for program scheduling, ad pod allocation, playout automation, and Electronic Program Guide (EPG) generation.',
    `season_number` STRING COMMENT 'Season number within the parent series for episodic content. Null for non-episodic content. Used for catalog organization and Electronic Program Guide (EPG) display.',
    `studio_name` STRING COMMENT 'Name of the studio or production company that produced the content. Used for rights attribution, royalty calculations, and catalog organization.',
    `sub_genre` STRING COMMENT 'Secondary or more granular genre classification providing additional content categorization for advanced audience segmentation and personalization.',
    `synopsis_long` STRING COMMENT 'Detailed narrative description of the content. Used for promotional materials, streaming platform detail pages, and comprehensive program guides.',
    `synopsis_short` STRING COMMENT 'Brief summary of the content, typically 50-100 characters. Used for Electronic Program Guide (EPG) listings, mobile applications, and quick reference displays.',
    `theatrical_release_flag` BOOLEAN COMMENT 'Indicates whether the content had a theatrical release. Used for windowing strategy, rights holdback periods, and marketing classification.',
    `uhd_4k_available_flag` BOOLEAN COMMENT 'Indicates whether an Ultra HD 4K version of the content is available. Used for premium streaming tiers and next-generation broadcast services.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the title record was last modified. Used for change tracking, data synchronization, and audit compliance.',
    CONSTRAINT pk_title PRIMARY KEY(`title_id`)
) COMMENT 'Master catalog record for every content asset across the enterprise — films, series, episodes, clips, music tracks, news segments, and live events. Serves as the authoritative SSOT for content identity, carrying EIDR, ISAN, and ISRC identifiers, MPA content rating, genre classification, original language, country of origin, production year, content type discriminator (film/series/episode/clip/music/news/live), runtime in seconds, content status (active/archived/restricted), parental advisory flags, COPPA child-directed flag, and lifecycle timestamps. Acts as the universal join point referenced by scheduling, distribution, rights, digital asset, and advertising domains. Format-level technical specifications are managed by the version and digital asset domains.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`series` (
    `series_id` BIGINT COMMENT 'Unique identifier for the series. Primary key for the series master record.',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Series have content ratings. Normalizes content_rating string column to reference the enterprise rating taxonomy.',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Series have genre classification. Normalizes genre_primary/genre_secondary string columns to reference the enterprise genre taxonomy.',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.rights_holder. Business justification: Series-level rights ownership (studio/production company) drives all downstream licensing and royalty flows. Franchise management and multi-season deal negotiations require knowing the primary rights ',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Series production is facility-based; long-running shows are tied to specific studio facilities for multi-year scheduling, crew allocation, facility cost allocation, and production continuity. Essentia',
    `archive_location` STRING COMMENT 'Physical or logical location identifier where the series master content and metadata are archived. Used for Digital Asset Management (DAM) and Media Asset Management (MAM) retrieval.',
    `aspect_ratio` STRING COMMENT 'Standard aspect ratio for the series video format. Critical for playout configuration, transcoding workflows, and multi-platform distribution.. Valid values are `16:9|4:3|21:9|2.39:1|1.85:1`',
    `audio_description_available` BOOLEAN COMMENT 'Indicates whether audio description track is available for visually impaired viewers. Required for accessibility compliance in many jurisdictions.',
    `audio_format` STRING COMMENT 'Standard audio format and channel configuration for the series. Determines audio encoding requirements for distribution and playout.. Valid values are `stereo|surround_5_1|surround_7_1|dolby_atmos|dts_x`',
    `closed_caption_available` BOOLEAN COMMENT 'Indicates whether closed captioning is available for the series. Required for regulatory compliance under FCC accessibility rules and international broadcasting standards.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the series was originally produced. Used for content quotas, regulatory compliance, and international rights management.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the series record was first created in the system. Used for audit trail and data lineage tracking.',
    `distributor` STRING COMMENT 'Name of the distribution company responsible for licensing and distributing the series to secondary markets and platforms.',
    `eidr_code` STRING COMMENT 'Universal unique identifier for the series registered with EIDR. Enables global content identification and rights management across the entertainment industry supply chain.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `episode_runtime_minutes` STRING COMMENT 'Standard runtime duration in minutes for a typical episode of the series, excluding commercials. Used for scheduling, ad pod planning, and playout automation.',
    `finale_date` DATE COMMENT 'Date when the final episode of the series aired or was released. Null for ongoing series. Used for syndication eligibility and rights holdback period calculations.',
    `franchise_name` STRING COMMENT 'Brand name of the content franchise or show brand. Used for grouping related series, spin-offs, and reboots under a common brand umbrella.',
    `hdr_format` STRING COMMENT 'High Dynamic Range format specification for the series. Impacts content delivery network configuration and device compatibility.. Valid values are `SDR|HDR10|HDR10_PLUS|DOLBY_VISION|HLG`',
    `isan_code` STRING COMMENT 'International standard audiovisual number for the series. Used for audiovisual work identification in rights management and distribution.. Valid values are `^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `keywords` STRING COMMENT 'Comma-separated list of searchable keywords and tags for content discovery, Electronic Program Guide (EPG) search, and recommendation engine optimization.',
    `language_original` STRING COMMENT 'ISO 639-3 three-letter code for the original production language of the series. Used for localization planning and international distribution.. Valid values are `^[a-z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the series record was last modified. Used for change tracking, audit compliance, and data synchronization across systems.',
    `original_network` STRING COMMENT 'Name of the original broadcast network or streaming platform that first aired or released the series. Critical for rights management and syndication deals.',
    `premiere_date` DATE COMMENT 'Date when the first episode of the series originally aired or was released. Marks the beginning of the series lifecycle and is used for rights windowing calculations.',
    `production_company` STRING COMMENT 'Name of the primary production company or studio that produced the series. Critical for rights ownership, residuals calculations, and syndication negotiations.',
    `resolution_standard` STRING COMMENT 'Standard video resolution for the series master content. Determines transcoding requirements and Adaptive Bitrate (ABR) streaming profile generation.. Valid values are `SD|HD|FHD|UHD|4K|8K`',
    `series_status` STRING COMMENT 'Current lifecycle status of the series. Indicates whether the series is actively producing new content, has concluded, or is temporarily paused.. Valid values are `ongoing|ended|cancelled|hiatus|in_development|pre_production`',
    `series_type` STRING COMMENT 'Classification of the series format and production style. Determines scheduling strategy, audience targeting, and production workflow. [ENUM-REF-CANDIDATE: scripted|unscripted|documentary|news|sports|reality|talk_show|game_show|variety|animated|miniseries|anthology — 12 candidates stripped; promote to reference product]',
    `syndication_eligible` BOOLEAN COMMENT 'Indicates whether the series meets the minimum episode threshold and rights clearance requirements for syndication to secondary markets and broadcast stations.',
    `synopsis_long` STRING COMMENT 'Detailed multi-paragraph description of the series premise, themes, and narrative arc. Used for marketing materials, press releases, and content catalogs.',
    `synopsis_short` STRING COMMENT 'Brief one-sentence description of the series premise. Used for Electronic Program Guide (EPG) listings, mobile applications, and social media promotion.',
    `target_demographic` STRING COMMENT 'Primary audience demographic segment the series is designed to reach. Used for advertising sales, scheduling strategy, and Target Rating Point (TRP) calculations. [ENUM-REF-CANDIDATE: adults_18_49|adults_25_54|adults_18_34|children_2_11|teens_12_17|women_18_49|men_18_49|total_viewers — promote to reference product]',
    `title` STRING COMMENT 'Official title of the series as registered and marketed. Primary human-readable identifier for the content franchise.',
    `title_original` STRING COMMENT 'Original title of the series in its native language and market before localization or translation.',
    `total_episode_count` STRING COMMENT 'Cumulative count of all episodes produced across all seasons. Includes specials and pilot episodes.',
    `total_season_count` STRING COMMENT 'Total number of seasons produced for the series to date. Updated as new seasons are commissioned and produced.',
    CONSTRAINT pk_series PRIMARY KEY(`series_id`)
) COMMENT 'Master record for a serialized content franchise or show brand — the parent container above seasons and episodes. Captures series title, franchise identifier, series type (scripted/unscripted/documentary/news/sports/reality), total season count, original network/platform, premiere date, finale date, series status (ongoing/ended/cancelled/hiatus), genre taxonomy, target demographic, content rating band, and brand metadata. Enables hierarchical content navigation from series → season → episode and supports scheduling, rights windowing, and syndication deal structures.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`season` (
    `season_id` BIGINT COMMENT 'Unique identifier for the season record. Primary key.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Seasons are independently licensed and billed (e.g., a broadcaster licenses Season 2 separately from Season 1). Season-level billing account assignment enables season-specific revenue attribution, AP ',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Seasons have content ratings. Normalizes content_rating string column to reference the enterprise rating taxonomy.',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Seasons have genre classification. Normalizes genre_primary/genre_secondary string columns to reference the enterprise genre taxonomy.',
    `project_id` BIGINT COMMENT 'Foreign key linking to production.project. Business justification: Seasons often have dedicated budgets separate from series-level allocations. Network finance teams approve and monitor season budgets independently for greenlight decisions, mid-season adjustments, an',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.holder. Business justification: Season-level rights holder identification is required for royalty calculation and residuals management. rights_holder is a plain-text denormalization; a proper FK to holder enables royalty statement g',
    `series_id` BIGINT COMMENT 'Reference to the parent series to which this season belongs.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Season-level rights are territory-specific in broadcasting; rights clearance, holdback enforcement, and distribution planning all require knowing which rights_territory governs a season. rights_territ',
    `archive_date` DATE COMMENT 'Date when the season was moved to archival storage. Used for asset lifecycle management and retrieval planning.',
    `archive_location` STRING COMMENT 'Physical or digital archive location where the seasons master assets are stored. Critical for long-term preservation and retrieval.',
    `awards_nominated` STRING COMMENT 'Comma-separated list of major award nominations received by the season. Supports promotional messaging and content valuation.',
    `awards_won` STRING COMMENT 'Comma-separated list of major awards won by the season (e.g., Emmy, Golden Globe). Used for marketing and promotional value enhancement.',
    `banner_artwork_url` STRING COMMENT 'URL reference to the seasons banner or hero image for wide-format displays on streaming platforms and websites.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the season record was first created in the system. Used for audit trail and data lineage.',
    `distributor` STRING COMMENT 'Name of the primary distributor handling the seasons commercial distribution. Key for carriage agreements and revenue sharing.',
    `eidr` STRING COMMENT 'Globally unique EIDR identifier for the season, enabling cross-platform content identification and rights management.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `episode_count_aired` STRING COMMENT 'Number of episodes that have been broadcast or released to audiences. Used for tracking release progress.',
    `episode_count_ordered` STRING COMMENT 'Number of episodes originally ordered or commissioned for this season by the network or platform.',
    `episode_count_produced` STRING COMMENT 'Actual number of episodes produced and delivered for this season. May differ from ordered count due to production changes.',
    `finale_date` DATE COMMENT 'Date when the final episode of the season was broadcast or released. Marks the end of the seasons linear run.',
    `isan` STRING COMMENT 'International standard identifier for audiovisual works, used for season-level identification in global distribution and rights management.. Valid values are `^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `language_original` STRING COMMENT 'ISO 639-3 three-letter code for the original production language of the season. Critical for localization and distribution planning.. Valid values are `^[a-z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the season record was last modified. Supports change tracking and audit compliance.',
    `network_original` STRING COMMENT 'Name of the network or platform that originally commissioned or first aired the season. Used for windowing and exclusivity tracking.',
    `original_air_date` DATE COMMENT 'Date when the first episode of the season was originally broadcast or released. Key for windowing and rights calculations.',
    `poster_artwork_url` STRING COMMENT 'URL reference to the seasons primary poster artwork stored in the Media Asset Management (MAM) system. Used for EPG, VOD, and promotional displays.',
    `production_company` STRING COMMENT 'Name of the primary production company responsible for creating the season. Used for rights attribution and royalty calculations.',
    `production_year` STRING COMMENT 'Calendar year in which the season was produced. Used for cataloging, rights management, and archival purposes.',
    `rights_expiry_date` DATE COMMENT 'Date when current distribution rights for the season expire. Triggers rights renewal workflows and availability restrictions.',
    `season_number` STRING COMMENT 'Sequential number of the season within the series (e.g., 1 for Season 1, 2 for Season 2). Used for ordering and identification.',
    `season_status` STRING COMMENT 'Current lifecycle status of the season. Tracks progression from development through archival or cancellation. [ENUM-REF-CANDIDATE: in-development|in-production|post-production|completed|airing|aired|archived|cancelled — 8 candidates stripped; promote to reference product]',
    `synopsis_long` STRING COMMENT 'Detailed season-level synopsis providing comprehensive narrative overview. Used for promotional materials, VOD platforms, and press releases.',
    `synopsis_short` STRING COMMENT 'Brief season-level synopsis (typically 50-150 characters) used for Electronic Program Guide (EPG) listings and mobile displays.',
    `title` STRING COMMENT 'Official title or name of the season. May include thematic or marketing names (e.g., The Final Season, Season of Secrets).',
    `total_runtime_minutes` STRING COMMENT 'Cumulative runtime of all episodes in the season, measured in minutes. Used for scheduling blocks and VOD packaging.',
    CONSTRAINT pk_season PRIMARY KEY(`season_id`)
) COMMENT 'Master record representing a discrete production cycle of a series, grouping episodes into an ordered season. Tracks season number, season title, episode count (ordered and total), production year, original air year, season status (in-production/completed/archived), season-level content rating, season-level synopsis, and promotional artwork references. Bridges the series-to-episode hierarchy and supports season-level rights licensing, scheduling blocks, and VOD packaging.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` (
    `content_episode_id` BIGINT COMMENT 'Unique identifier for the episode within the content management system. Primary key for the content episode entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Episode-specific promotional campaigns (weekly tune-in ads, event episodes). Business process: weekly marketing planning, special episode promotion (finales, crossovers), episode-level campaign perfor; FK references sales domain entity; namespace reconciled from advertising context',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Episodes have content ratings (TV-PG, TV-MA). Normalizes content_rating string column to reference the enterprise rating taxonomy.',
    `season_id` BIGINT COMMENT 'Reference to the specific season within the series to which this episode belongs. Enables season-level grouping and rights management.',
    `series_id` BIGINT COMMENT 'Reference to the parent series to which this episode belongs. Links episode to its series container.',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Episodes have genre classification. Normalizes genre_primary/genre_secondary string columns to reference the enterprise genre taxonomy.',
    `project_id` BIGINT COMMENT 'Foreign key linking to production.project. Business justification: High-cost episodes (pilots, finales, VFX-heavy episodes) often have dedicated budget line items. Production accountants track episodic costs for above-the-line talent overages, location expenses, and ',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Episodes ARE titles in the master catalog. Every episode should reference its title record for unified content identification and metadata management.',
    `archive_date` DATE COMMENT 'Date when the episode master was moved to long-term archive storage. Used for asset lifecycle management and storage optimization.',
    `archive_location` STRING COMMENT 'Physical or logical location identifier for the archived master copy in the Media Asset Management (MAM) system. Supports long-term preservation and retrieval.',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the episode video. Affects playout configuration, transcoding profiles, and distribution format specifications.. Valid values are `4:3|16:9|21:9|1.85:1|2.39:1`',
    `audio_description_available` BOOLEAN COMMENT 'Indicates whether audio description track is available for visually impaired viewers. Required for accessibility compliance.',
    `audio_format` STRING COMMENT 'Audio channel configuration and encoding format. Affects playout system configuration and premium content positioning.. Valid values are `stereo|5.1|7.1|dolby_atmos|dts_x`',
    `broadcast_count` STRING COMMENT 'Total number of times this episode has been broadcast on linear television. Used for residuals calculation and syndication rights management.',
    `closed_caption_available` BOOLEAN COMMENT 'Indicates whether closed captioning is available for this episode. Required for FCC compliance and accessibility standards.',
    `content_advisory` STRING COMMENT 'Specific content warnings or advisories for viewer guidance (e.g., violence, language, adult themes). Displayed in Electronic Program Guide (EPG) and Video On Demand (VOD) interfaces.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the episode record was first created in the content management system. Used for audit trail and data lineage tracking.',
    `eidr_identifier` STRING COMMENT 'Globally unique identifier for the episode registered with the Entertainment Identifier Registry. Enables universal content identification across distribution platforms and rights management systems.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `episode_number` STRING COMMENT 'Sequential number of the episode within its season. Used for ordering and identification in Electronic Program Guide (EPG) and Video On Demand (VOD) catalogs.',
    `episode_status` STRING COMMENT 'Current lifecycle state of the episode. Determines availability for scheduling, playout automation, and distribution to Over-The-Top (OTT) platforms.. Valid values are `in_production|post_production|ready_for_broadcast|aired|archived|withdrawn`',
    `episode_type` STRING COMMENT 'Classification of the episode format and purpose within the series. Affects scheduling strategy, promotional treatment, and rights valuation. [ENUM-REF-CANDIDATE: standard|special|pilot|finale|recap|bonus|behind_the_scenes — 7 candidates stripped; promote to reference product]',
    `keywords` STRING COMMENT 'Comma-separated list of keywords and tags describing episode themes, topics, and notable elements. Supports content search, discovery, and metadata enrichment.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the episode record was last modified. Supports change tracking and data quality monitoring.',
    `music_cue_sheet_submitted` BOOLEAN COMMENT 'Indicates whether the music cue sheet has been submitted for royalty collection. Required for music rights compliance and royalty distribution.',
    `original_air_date` DATE COMMENT 'The date when the episode was first broadcast on linear television. Critical for rights windowing, residuals calculation, and syndication eligibility.',
    `premiere_flag` BOOLEAN COMMENT 'Indicates whether this is a premiere episode (first broadcast). Used for promotional planning, upfront advertising sales, and Nielsen sweeps period strategy.',
    `primary_language` STRING COMMENT 'ISO 639-3 three-letter code for the primary audio language of the episode. Used for content cataloging, rights clearance, and distribution targeting.. Valid values are `^[a-z]{3}$`',
    `production_code` STRING COMMENT 'Internal production identifier assigned during content creation. Used for tracking production workflow, post-production tasks, and archival reference.',
    `rerun_flag` BOOLEAN COMMENT 'Indicates whether this broadcast is a rerun. Affects advertising rates, Cost Per Rating Point (CPRP) calculations, and residuals payments to talent.',
    `rights_clearance_status` STRING COMMENT 'Current status of rights clearance for broadcast and distribution. Determines whether episode can be scheduled for playout or made available on Over-The-Top (OTT) platforms.. Valid values are `cleared|pending|restricted|expired`',
    `runtime_seconds` STRING COMMENT 'Total duration of the episode content in seconds, excluding commercial breaks. Used for playout scheduling, ad pod allocation, and Electronic Program Guide (EPG) display.',
    `runtime_with_ads_seconds` STRING COMMENT 'Total broadcast duration including commercial ad breaks. Used for linear scheduling and daypart planning.',
    `subtitles_available` BOOLEAN COMMENT 'Indicates whether subtitle tracks are available for this episode. Supports international distribution and localization strategies.',
    `synopsis_long` STRING COMMENT 'Detailed description of the episode plot, themes, and key moments. Used for Video On Demand (VOD) platforms, promotional materials, and content discovery.',
    `synopsis_short` STRING COMMENT 'Brief summary of the episode content, typically 50-100 characters. Used for Electronic Program Guide (EPG) listings and mobile applications with limited display space.',
    `title` STRING COMMENT 'The official title or name of the episode. Displayed in Electronic Program Guide (EPG), Video On Demand (VOD) interfaces, and promotional materials.',
    `video_resolution` STRING COMMENT 'Maximum video resolution available for this episode. Determines distribution channel eligibility and Adaptive Bitrate Streaming (ABR) profile selection.. Valid values are `SD|HD|FHD|UHD|4K|8K`',
    `vod_available_from_date` DATE COMMENT 'Date when the episode becomes available on Video On Demand (VOD) platforms. Part of windowing strategy and rights holdback management.',
    `vod_available_until_date` DATE COMMENT 'Date when the episode is removed from Video On Demand (VOD) platforms. Enforces rights windows and exclusivity periods.',
    CONSTRAINT pk_content_episode PRIMARY KEY(`content_episode_id`)
) COMMENT 'Master record for an individual episode within a series season. Captures episode number, episode title, production code, original broadcast date, runtime, episode type (standard/special/pilot/finale/recap), episode synopsis, content rating, EIDR episode identifier, closed-caption availability flag, audio description flag, and episode status. Supports EPG scheduling, VOD availability windows, rights clearance at episode level, and residuals calculation for talent reuse payments.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`version` (
    `version_id` BIGINT COMMENT 'Primary key for version',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Each content version is encoded using specific encoder configurations. QC workflows, bitrate ladder validation, delivery troubleshooting, and platform certification require knowing which encoder profi',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: A version tracks every distinct cut, dub, or localized edit of a content asset. In media broadcasting, versions are frequently episode-specific — a dubbed Spanish version of Episode 3, a censored broa',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Versions have MPA and TV ratings. Normalizes mpa_rating/tv_rating string columns to reference the enterprise rating taxonomy.',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Content versions are encoded and QCd to meet specific delivery channel technical requirements (bitrate, codec, resolution). version has channel_id (scheduling.channel) but not delivery_channel. Deliv',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Content versions are created for specific distribution partners (partner-specific encodes, DRM configurations, watermarking). Linking version to partner enables partner-specific QC workflows, delivery',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Content versions are prepared for specific OTT platforms with platform-specific encoding, DRM, and QC requirements. version.target_platform is a plain-text denormalization of ott_platform. Platform-sp',
    `title_id` BIGINT COMMENT 'Reference to the master content asset (title, episode, series, film, clip, music, news segment, or live event) that this version belongs to.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this version was approved for distribution and playout.',
    `archived_timestamp` TIMESTAMP COMMENT 'Timestamp when this version was moved to long-term archive storage.',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of this version (e.g., 16:9, 4:3, 21:9, 2.39:1).. Valid values are `^[0-9]+:[0-9]+$`',
    `audio_codec` STRING COMMENT 'Audio compression codec used for this version (e.g., AAC, AC-3, E-AC-3, Dolby Atmos, DTS).',
    `audio_description_available` BOOLEAN COMMENT 'Indicates whether audio description track is available for visually impaired audiences, supporting accessibility compliance.',
    `audio_track_configuration` STRING COMMENT 'Comma-separated list of audio track languages and types available in this version (e.g., en:stereo,es:5.1,fr:stereo,en:descriptive).',
    `broadcast_safe` BOOLEAN COMMENT 'Indicates whether this version has been certified as broadcast-safe, meeting technical standards for linear transmission (audio levels, video levels, closed captioning).',
    `checksum_md5` STRING COMMENT 'MD5 hash checksum of the version file, used for integrity verification during transfer and archival.. Valid values are `^[a-f0-9]{32}$`',
    `closed_caption_available` BOOLEAN COMMENT 'Indicates whether closed captioning (CC) is available for this version, supporting accessibility compliance.',
    `color_space` STRING COMMENT 'Color space standard used for this version (Rec. 709, Rec. 2020, DCI-P3, sRGB).. Valid values are `rec_709|rec_2020|dci_p3|srgb`',
    `content_advisory` STRING COMMENT 'Comma-separated list of content advisory flags for this version (e.g., violence, language, sexual_content, drug_use, nudity).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this version record was first created in the system.',
    `eidr_code` STRING COMMENT 'Unique EIDR identifier for this specific version, enabling global content identification and rights management.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `file_format` STRING COMMENT 'Container file format for this version (e.g., MP4, MXF, MOV, TS, WebM).',
    `file_size_bytes` BIGINT COMMENT 'Total file size of this version in bytes, used for storage planning and delivery bandwidth estimation.',
    `frame_rate` DECIMAL(18,2) COMMENT 'Frame rate of this version in frames per second (e.g., 23.98, 24.00, 25.00, 29.97, 30.00, 50.00, 59.94, 60.00).',
    `hdr_format` STRING COMMENT 'High Dynamic Range format used for this version (SDR, HDR10, HDR10+, Dolby Vision, HLG).. Valid values are `sdr|hdr10|hdr10_plus|dolby_vision|hlg`',
    `isan_code` STRING COMMENT 'International Standard Audiovisual Number uniquely identifying this audiovisual work version.. Valid values are `^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `isrc_code` STRING COMMENT 'International Standard Recording Code for music or audio content versions, enabling tracking and royalty distribution.. Valid values are `^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$`',
    `label` STRING COMMENT 'Human-readable label identifying this version (e.g., Theatrical Cut, Directors Cut, Broadcast Safe, Spanish Dub, UK Censored).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this version record was last modified.',
    `primary_language_code` STRING COMMENT 'ISO 639 two or three-letter code for the primary audio language of this version (e.g., en, es, fr).. Valid values are `^[a-z]{2,3}$`',
    `qc_completed_date` DATE COMMENT 'Date when quality control review was completed for this version.',
    `qc_status` STRING COMMENT 'Quality control review status for this version, indicating whether it has passed technical and content quality checks.. Valid values are `not_started|in_progress|passed|failed|conditional_pass`',
    `resolution` STRING COMMENT 'Video resolution classification for this version (SD, HD 720p, HD 1080p, UHD 4K, UHD 8K).. Valid values are `sd|hd_720p|hd_1080p|uhd_4k|uhd_8k`',
    `runtime_delta_seconds` STRING COMMENT 'Difference in runtime (in seconds) between this version and the master version. Positive values indicate longer runtime, negative indicate shorter.',
    `runtime_seconds` STRING COMMENT 'Total runtime of this version in seconds, representing the complete playback duration.',
    `storage_location` STRING COMMENT 'Physical or logical storage location identifier where this version is archived (e.g., tape library ID, cloud bucket path, MAM archive reference).',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of ISO 639 language codes for subtitle tracks included in this version (e.g., en,es,fr,de).',
    `target_territory` STRING COMMENT 'Three-letter ISO country code indicating the primary geographic territory this version is intended for (e.g., USA, GBR, FRA).. Valid values are `^[A-Z]{3}$`',
    `version_status` STRING COMMENT 'Current lifecycle status of the version indicating its readiness for distribution and playout. [ENUM-REF-CANDIDATE: draft|in_production|qc_pending|approved|active|archived|deprecated|rejected — 8 candidates stripped; promote to reference product]',
    `version_type` STRING COMMENT 'Classification of the version type indicating the nature of the edit or adaptation. [ENUM-REF-CANDIDATE: theatrical|broadcast|director|extended|unrated|censored|dubbed|subtitled|localized|preview|trailer — 11 candidates stripped; promote to reference product]',
    `video_codec` STRING COMMENT 'Video compression codec used for this version (e.g., H.264, H.265/HEVC, VP9, AV1, MPEG-2).',
    CONSTRAINT pk_version PRIMARY KEY(`version_id`)
) COMMENT 'Tracks every distinct version of a title — including edits, cuts, localized dubs, censored versions, broadcast-safe edits, theatrical vs. extended cuts, and format variants (SD/HD/4K). Each version record carries version type (theatrical/broadcast/director/unrated/censored/dubbed/subtitled), version label, target territory, target platform, runtime delta from master, language track configuration, subtitle language list, aspect ratio override, and version status. Enables multi-platform distribution where different versions are delivered to different windows and territories.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`genre` (
    `genre_id` BIGINT COMMENT 'Unique identifier for the genre. Primary key for the genre reference taxonomy.',
    `parent_genre_id` BIGINT COMMENT 'Reference to the parent genre in the hierarchical taxonomy, enabling multi-level classification such as Drama > Legal Drama or Sports > Football. Null for top-level genres.',
    `ad_pod_compatibility` BOOLEAN COMMENT 'Indicates whether content in this genre is compatible with Dynamic Ad Insertion (DAI) and ad pod placement. False for genres requiring uninterrupted viewing (e.g., live sports critical moments, news breaking coverage).',
    `applicable_content_types` STRING COMMENT 'Comma-separated list of content types to which this genre applies (e.g., series, film, clip, live_event, news_segment, music_video). Enables content-type-specific genre filtering.',
    `archive_retention_policy` STRING COMMENT 'Digital asset archival retention policy for content in this genre. Permanent retention for high-value evergreen genres; short-term for time-sensitive news and event content.. Valid values are `permanent|long_term|standard|short_term`',
    `avod_monetization_potential` STRING COMMENT 'Revenue generation potential for this genre on Advertising-Supported Video On Demand (AVOD) platforms, based on Cost Per Mille (CPM) rates and advertiser demand. High-potential genres command premium ad rates.. Valid values are `high|medium|low`',
    `genre_code` STRING COMMENT 'Short alphanumeric code representing the genre for system integration and Electronic Program Guide (EPG) feeds. Used as a business key across scheduling, distribution, and metadata systems.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this genre record was first created in the enterprise content taxonomy system.',
    `daypart_affinity` STRING COMMENT 'Comma-separated list of broadcast dayparts where this genre typically performs best (e.g., prime_time, late_night, early_morning, daytime, weekend). Informs program scheduling and playout automation strategies.',
    `genre_description` STRING COMMENT 'Detailed textual description of the genre, including defining characteristics, typical content examples, and audience expectations. Used for editorial guidance and content acquisition briefings.',
    `effective_end_date` DATE COMMENT 'Date when this genre classification was retired or superseded. Null for currently active genres. Used for historical content classification and reporting continuity.',
    `effective_start_date` DATE COMMENT 'Date when this genre classification became effective and available for use in content metadata and scheduling systems.',
    `eidr_genre_mapping` STRING COMMENT 'Mapping to Entertainment Identifier Registry (EIDR) genre taxonomy for cross-industry content identification and rights management interoperability.',
    `fast_channel_applicability` BOOLEAN COMMENT 'Indicates whether this genre is suitable for Free Ad-Supported Streaming Television (FAST) linear channel programming. FAST channels require genres with deep catalog availability and consistent audience appeal.',
    `geographic_restriction_applicability` BOOLEAN COMMENT 'Indicates whether content in this genre is subject to geographic blackout restrictions or regional licensing constraints. Common for sports genres with territorial rights and retransmission consent agreements.',
    `iab_content_category` STRING COMMENT 'Mapping to Interactive Advertising Bureau (IAB) content taxonomy for programmatic advertising and contextual ad targeting. Enables Share of Voice (SOV) optimization and Cost Per Mille (CPM) rate alignment.. Valid values are `^IAB[0-9]{1,2}(-[0-9]{1,2})?$`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this genre is currently active and available for content classification. Inactive genres are retained for historical content but not used for new acquisitions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this genre record was last updated. Used for change tracking and metadata synchronization across Electronic Program Guide (EPG), Media Asset Management (MAM), and distribution systems.',
    `linear_broadcast_suitability` BOOLEAN COMMENT 'Indicates whether this genre is suitable for traditional linear scheduled broadcasting. Some genres (e.g., interactive, choose-your-own-adventure) are non-linear only.',
    `localization_priority` STRING COMMENT 'Priority level for content localization (dubbing, subtitling, cultural adaptation) for this genre. High-priority genres justify investment in multi-language versions for international distribution.. Valid values are `high|medium|low`',
    `metadata_enrichment_priority` STRING COMMENT 'Priority level for metadata enrichment and tagging in Media Asset Management (MAM) systems. Critical genres require comprehensive metadata for content discovery and personalization.. Valid values are `critical|standard|minimal`',
    `mpa_rating_applicability` STRING COMMENT 'Comma-separated list of Motion Picture Association (MPA) ratings typically associated with this genre (e.g., G, PG, PG-13, R, NC-17). Used for content clearance and daypart scheduling compliance.',
    `genre_name` STRING COMMENT 'Full display name of the genre as presented to audiences in Electronic Program Guides (EPG), streaming platform interfaces, and content discovery systems.',
    `nielsen_genre_code` STRING COMMENT 'Nielsen Media Research genre classification code used for audience measurement, ratings analysis, and Gross Rating Point (GRP) reporting alignment.',
    `ott_platform_priority` STRING COMMENT 'Priority level for featuring this genre on Over-The-Top (OTT) streaming platforms and Video On Demand (VOD) services. High priority genres receive prominent placement in content discovery and recommendation engines.. Valid values are `high|medium|low`',
    `parental_guidance_flag` BOOLEAN COMMENT 'Indicates whether content in this genre typically requires parental guidance warnings or viewer discretion advisories. Used for compliance with Federal Communications Commission (FCC) broadcast standards and Childrens Online Privacy Protection Act (COPPA) requirements.',
    `svod_performance_tier` STRING COMMENT 'Performance classification for this genre on Subscription Video On Demand (SVOD) platforms. Premium genres drive subscriber acquisition and reduce churn rate; catalog genres provide library depth.. Valid values are `premium|standard|catalog`',
    `syndication_eligibility` BOOLEAN COMMENT 'Indicates whether content in this genre is typically eligible for syndication to multiple outlets and resale. Used in rights and royalties management and windowing strategy planning.',
    `target_demographic` STRING COMMENT 'Primary audience demographic segment targeted by this genre, expressed in Nielsen demographic notation (e.g., A18-49, M25-54, W18-34). Used for Target Rating Point (TRP) and Gross Rating Point (GRP) planning.',
    `tier` STRING COMMENT 'Hierarchical level of the genre within the taxonomy. Primary represents top-level genres, secondary represents sub-genres, and tertiary represents granular classifications.. Valid values are `primary|secondary|tertiary`',
    `usage_notes` STRING COMMENT 'Internal notes and guidelines for content producers, schedulers, and metadata specialists on proper application of this genre classification. Includes edge cases and disambiguation rules.',
    CONSTRAINT pk_genre PRIMARY KEY(`genre_id`)
) COMMENT 'Enterprise reference taxonomy for content genre and sub-genre classification. Captures genre code, genre name, parent genre reference (enabling hierarchical sub-genres like Drama > Legal Drama), genre tier (primary/secondary), applicable content types, IAB content category mapping for ad targeting, and active status. Standardizes genre labeling across EPG systems, streaming platform metadata feeds, and advertising contextual targeting to ensure consistent audience segmentation and content discovery.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`rating` (
    `rating_id` BIGINT COMMENT 'Primary key for rating',
    `appeal_status` STRING COMMENT 'The current status of any appeal filed by the content producer or distributor to challenge or modify the assigned rating classification.. Valid values are `not_appealed|appeal_pending|appeal_approved|appeal_denied`',
    `body` STRING COMMENT 'The official name of the regulatory or industry body that issued the rating (e.g., Motion Picture Association, TV Parental Guidelines Monitoring Board, British Board of Film Classification, Freiwillige Selbstkontrolle der Filmwirtschaft).',
    `certificate_number` STRING COMMENT 'The unique certificate or reference number issued by the rating body upon classification approval. Used for audit and compliance verification.',
    `rating_code` STRING COMMENT 'The official rating classification code assigned to the content (e.g., G, PG, PG-13, R, NC-17 for MPA film ratings; TV-Y, TV-Y7, TV-G, TV-PG, TV-14, TV-MA for TV Parental Guidelines; or international equivalents such as BBFC, FSK, OFLC codes). [ENUM-REF-CANDIDATE: G|PG|PG-13|R|NC-17|TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA — 11 candidates stripped; promote to reference product]',
    `content_descriptor_drug_use` BOOLEAN COMMENT 'Boolean flag indicating whether the rating includes a content descriptor for drug use or substance abuse.',
    `content_descriptor_fear` BOOLEAN COMMENT 'Boolean flag indicating whether the rating includes a content descriptor for frightening or intense scenes that may be unsuitable for younger audiences.',
    `content_descriptor_language` BOOLEAN COMMENT 'Boolean flag indicating whether the rating includes a content descriptor for strong or offensive language.',
    `content_descriptor_nudity` BOOLEAN COMMENT 'Boolean flag indicating whether the rating includes a content descriptor for nudity or sexual content.',
    `content_descriptor_violence` BOOLEAN COMMENT 'Boolean flag indicating whether the rating includes a content descriptor for violence or intense action.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this rating record was first created in the system.',
    `rating_description` STRING COMMENT 'Detailed textual description of the rating, including the rationale for the classification and any additional context provided by the rating body (e.g., Rated PG-13 for intense sequences of violence and action, some suggestive content, and brief strong language).',
    `effective_date` DATE COMMENT 'The date on which this rating classification became effective and applicable to the content asset.',
    `expiration_date` DATE COMMENT 'The date on which this rating classification expires or is no longer valid. Null if the rating does not expire.',
    `minimum_age` STRING COMMENT 'The minimum recommended or legally mandated age (in years) for viewers of content with this rating. Null if no specific age restriction applies.',
    `notes` STRING COMMENT 'Additional internal notes or comments regarding the rating classification, including any special considerations, conditional approvals, or compliance requirements.',
    `parental_control_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether this rating is used to enforce parental control features on linear broadcast, OTT (Over-The-Top), or MVPD (Multichannel Video Programming Distributor) platforms.',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the rating is legally mandated by a regulatory body (e.g., FCC, Ofcom) or is a voluntary industry classification.',
    `submission_date` DATE COMMENT 'The date on which the content was submitted to the rating body for classification review.',
    `system` STRING COMMENT 'The rating system or classification framework under which the rating was assigned (e.g., MPA for Motion Picture Association, TVPG for TV Parental Guidelines, BBFC for British Board of Film Classification, FSK for Freiwillige Selbstkontrolle der Filmwirtschaft, OFLC for Australian Classification Board, CBFC for Central Board of Film Certification India).. Valid values are `MPA|TVPG|BBFC|FSK|OFLC|CBFC`',
    `territory_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country or territory code indicating the geographic jurisdiction where this rating applies (e.g., USA, GBR, DEU, AUS, IND).. Valid values are `^[A-Z]{3}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this rating record was last modified or updated.',
    `version` STRING COMMENT 'Version number of the rating record, incremented when the rating is re-evaluated or updated due to content edits, appeals, or regulatory changes.',
    CONSTRAINT pk_rating PRIMARY KEY(`rating_id`)
) COMMENT 'Reference table for MPA, TV Parental Guidelines, and international content rating classifications applied to titles. Captures rating code (G/PG/PG-13/R/NC-17/TV-Y/TV-G/TV-PG/TV-14/TV-MA and international equivalents), rating system (MPA/TVPG/BBFC/FSK/etc.), rating body, applicable territory, minimum age indicator, content descriptor codes (violence/language/nudity/drug-use), and regulatory mandate flags. Supports FCC compliance, COPPA enforcement, and parental control features across linear and OTT platforms.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` (
    `talent_credit_id` BIGINT COMMENT 'Unique identifier for the talent credit record. Primary key for the talent credit association entity.',
    `content_episode_id` BIGINT COMMENT 'Reference to the specific episode within a series for which the talent is credited. Nullable for non-episodic content such as films or specials.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.talent_contract. Business justification: Credits must link to contracts for residual calculation, compensation verification, guild compliance reporting, and billing position validation. Fundamental to talent payment and rights management pro',
    `role_id` BIGINT COMMENT 'Foreign key linking to talent.talent_role. Business justification: Credits reference specific roles for character attribution, billing position validation, and role-specific residual eligibility. Eliminates denormalized role/character data and ensures single source o',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: talent_credit currently links talent to titles and episodes but lacks a season-level association. In media broadcasting, season-level credits are a standard business concept — showrunners, executive p',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: talent_credit currently links talent to titles and episodes but lacks a series-level association. In media broadcasting, series-level credits are a fundamental business concept — series creators, fran',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent master record in the talent domain. Links to the individual or entity receiving credit for their contribution to the content.',
    `title_id` BIGINT COMMENT 'Reference to the content title (film, series, special, documentary) for which the talent is credited. Links to the content master catalog.',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: talent_credit links talent identities to specific titles and episodes. In media broadcasting, certain talent credits are version-specific — dubbing actors are credited on specific localized versions, ',
    `billing_position` STRING COMMENT 'The ordinal position of the talent in the credit sequence, determining the order in which credits are displayed. Lower numbers indicate higher prominence (e.g., 1 = top billing). Used for EPG display and contractual compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this talent credit record was first created in the system. Used for audit trails and data lineage tracking.',
    `credit_approval_date` DATE COMMENT 'The date on which the credit was officially approved for publication. Used for audit trails and compliance with guild credit determination timelines.',
    `credit_approval_status` STRING COMMENT 'Current approval state of the credit. Pending indicates awaiting review; Approved indicates credit is finalized and ready for publication; Disputed indicates a challenge has been raised; Rejected indicates credit was not approved; Arbitration indicates the credit is under formal guild arbitration process.. Valid values are `pending|approved|disputed|rejected|arbitration`',
    `credit_category` STRING COMMENT 'High-level categorization of the credit by functional area or department. Used for grouping credits in EPG displays, streaming platform interfaces, and analytics. [ENUM-REF-CANDIDATE: cast|director|producer|writer|cinematography|editing|music|sound|production_design|costume|makeup|visual_effects|executive|other — 14 candidates stripped; promote to reference product]',
    `credit_display_name` STRING COMMENT 'The exact name as it should appear in credits, EPG metadata, and streaming platform displays. May differ from the talents legal name if a pseudonym or stage name is used. This is the authoritative display value for all public-facing credit presentations.',
    `credit_display_order` STRING COMMENT 'The sequence number for displaying this credit within its credit type or section (e.g., within the cast section or crew section). Used for rendering credits in EPG, streaming platforms, and promotional materials.',
    `credit_end_timestamp` TIMESTAMP COMMENT 'The timestamp marking when this credit ceases to be effective or visible. Nullable for credits that remain active indefinitely. Used for managing credit corrections, disputes, or contractual credit windows.',
    `credit_notes` STRING COMMENT 'Free-text field for additional context, special credit requirements, contractual stipulations, or notes related to credit disputes, arbitration outcomes, or special billing arrangements.',
    `credit_start_timestamp` TIMESTAMP COMMENT 'The timestamp marking when this credit becomes effective or visible in EPG and streaming platform metadata. Used for managing credit changes over time and versioning.',
    `credit_type` STRING COMMENT 'Classification of the credit based on how the talent contribution is presented. On-screen credits appear in the visual content; off-screen credits appear in end titles or metadata only; voice credits are for voice-over or dubbing; stunt credits are for stunt performers; archive credits are for archival footage appearances.. Valid values are `on-screen|off-screen|voice|stunt|archive`',
    `pseudonym_flag` BOOLEAN COMMENT 'Indicates whether the talent is credited under a pseudonym or stage name rather than their legal name. True if pseudonym is used; False if legal name is used. Relevant for guild compliance and contractual credit requirements.',
    `residuals_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this credit qualifies the talent for residual payments based on content reuse, syndication, or secondary distribution. True if eligible; False otherwise. Triggers residuals calculation workflows in the rights and royalties domain.',
    `union_affiliation_flag` BOOLEAN COMMENT 'Indicates whether the talent is affiliated with a recognized industry union (SAG-AFTRA, DGA, WGA, IATSE) for this credit. True if union-affiliated; False otherwise. Used for residuals eligibility determination and compliance reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this talent credit record was last modified. Used for audit trails, change tracking, and data quality monitoring.',
    CONSTRAINT pk_talent_credit PRIMARY KEY(`talent_credit_id`)
) COMMENT 'Association entity linking talent identities (owned by the talent domain) to specific titles and episodes with their credited role, billing position, character name, credit type (on-screen/off-screen), and credit display order. Captures SAG-AFTRA/WGA/DGA union affiliation flag, residuals eligibility flag, and credit approval status. Serves as the content domains authoritative credit roll for EPG metadata delivery, streaming platform cast display, and residuals calculation triggers. Does not duplicate the talent master record — references it via FK to the talent domain.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` (
    `acquisition_id` BIGINT COMMENT 'Primary key for acquisition',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Content acquisitions for broadcast must be validated against the acquiring stations broadcast license to confirm acquired rights match the licenses service area, frequency band, and conditions. Righ',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Content acquisitions must verify existing ratings or budget for rating submissions (MPAA, TV Parental Guidelines) as part of deal clearance and distribution planning. Links acquisition to rating certi',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Acquisitions can be episode-specific in media broadcasting — a broadcaster may acquire rights to specific episodes within a season (e.g., acquiring only the first 3 episodes of a series for a promotio',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Acquisitions often specify which version was acquired (theatrical vs broadcast cut, localized version). This FK allows tracking version-specific acquisition terms and rights.',
    `partner_id` BIGINT COMMENT 'Reference to the external party from whom the content was acquired (studio, independent producer, syndicator, distributor, or content aggregator).',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: acquisition records the business event of acquiring content from an external source. In media broadcasting, content is frequently acquired at the series level (e.g., acquiring all rights to a complete',
    `title_id` BIGINT COMMENT 'Reference to the content asset being acquired. Links to the master content catalog entry for the title, episode, series, film, clip, or other content asset.',
    `acquisition_date` DATE COMMENT 'The date on which the acquisition transaction was executed and the content rights were legally transferred or licensed to the enterprise. Represents the principal business event timestamp for this transaction.',
    `acquisition_status` STRING COMMENT 'Current lifecycle state of the acquisition. Negotiating = deal in discussion; Committed = contract signed but content not yet delivered; Delivered = content received and ingested; Active = content in use; Cancelled = deal terminated before delivery; Expired = license period ended.. Valid values are `negotiating|committed|delivered|active|cancelled|expired`',
    `acquisition_type` STRING COMMENT 'Classification of the acquisition method. Purchase = outright ownership transfer; License = time-limited rights; Co-production = joint production investment; Commission = original content commissioned from producer; Barter = content exchanged for advertising inventory; Syndication = content licensed from syndicator for regional broadcast.. Valid values are `purchase|license|co-production|commission|barter|syndication`',
    `ancillary_rights_flag` BOOLEAN COMMENT 'Indicates whether ancillary rights (merchandising, soundtrack, publishing, remake, sequel, spin-off, clip licensing) are included in the acquisition (True) or retained by the supplier (False).',
    `clearance_status` STRING COMMENT 'Rights verification status confirming that all necessary clearances (music rights, talent rights, third-party content, trademarks) have been obtained for broadcast or distribution. Pending = verification in progress; Cleared = all rights confirmed; Restricted = partial clearance with limitations; Failed = clearance issues prevent exploitation.. Valid values are `pending|cleared|restricted|failed`',
    `content_window_type` STRING COMMENT 'The distribution window or rights category acquired. Windowing refers to the sequential release strategy where content is made available through different channels over time. Theatrical = cinema release; Home Video = physical/digital sell-through; SVOD = Subscription Video On Demand; AVOD = Advertising-Supported Video On Demand; TVOD = Transactional Video On Demand; Linear Broadcast = traditional scheduled TV; Syndication = resale to multiple outlets; All Rights = comprehensive rights across all windows. [ENUM-REF-CANDIDATE: theatrical|home_video|svod|avod|tvod|linear_broadcast|syndication|all_rights — 8 candidates stripped; promote to reference product]',
    `cost_amount` DECIMAL(18,2) COMMENT 'The total monetary value paid or committed for acquiring the content rights. Represents the base acquisition cost before taxes, fees, or adjustments. For licenses, this is the total license fee; for purchases, the purchase price; for commissions, the production budget committed.',
    `cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the acquisition cost amount (e.g., USD, GBP, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this acquisition record was first created in the system. Audit field for data lineage and compliance tracking.',
    `delivery_date` DATE COMMENT 'The date on which the content master files and associated materials (metadata, artwork, closed captions, promotional assets) were delivered by the supplier and ingested into the enterprise Media Asset Management (MAM) system.',
    `delivery_format` STRING COMMENT 'The technical format and delivery method used by the supplier to provide the content. Examples: ProRes 422 HQ via FTP, IMF package via Aspera, DCP hard drive, MPEG-4 via CDN, tape (legacy).',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the acquired rights are exclusive (True) or non-exclusive (False) within the specified territory and window. Exclusive rights prevent the supplier from licensing the same content to competitors in the same territory/window.',
    `format_rights` STRING COMMENT 'The technical formats or delivery specifications covered by the acquisition. May include SD, HD, 4K, HDR, theatrical DCP, broadcast master, streaming-optimized, etc. Defines the quality and format tiers the enterprise is authorized to distribute.',
    `holdback_period_days` STRING COMMENT 'The number of days during which the content cannot be exploited in certain windows or territories as stipulated by the acquisition agreement. Holdback periods protect prior windows (e.g., theatrical holdback prevents SVOD release for 90 days post-theatrical).',
    `language_rights` STRING COMMENT 'The languages or language versions for which rights were acquired. May specify original language only, dubbed versions, subtitled versions, or all language adaptations. Examples: English, Spanish, French; All Languages; Original + Subtitles.',
    `license_end_date` DATE COMMENT 'The date on which the acquired content rights expire and the enterprise must cease exploitation. Null for perpetual purchases. For time-limited licenses, this defines the end of the license term.',
    `license_start_date` DATE COMMENT 'The date from which the enterprise is authorized to begin exploiting the acquired content rights. For licenses, this is the effective start of the license term; for purchases, typically the acquisition date.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'The minimum guaranteed payment to the supplier regardless of actual revenue performance. Common in revenue-sharing deals where the enterprise commits to a floor payment even if royalties do not reach this threshold.',
    `notes` STRING COMMENT 'Free-text field for additional context, special terms, restrictions, or operational notes related to the acquisition. May include information on promotional obligations, credit requirements, or unique contractual stipulations.',
    `payment_terms` STRING COMMENT 'Contractual payment schedule and conditions for the acquisition cost. May include milestone-based payments, installment schedules, advance payments, or revenue-sharing arrangements.',
    `reference_number` STRING COMMENT 'External business identifier for this acquisition transaction. May be a purchase order number, deal reference, or contract line item identifier used in communications with the supplier.',
    `residuals_obligation_flag` BOOLEAN COMMENT 'Indicates whether the enterprise has an obligation to pay residuals (talent reuse payments) to performers, writers, directors, or other rights holders each time the content is rebroadcast or redistributed (True) or if residuals are the suppliers responsibility (False).',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of revenue or receipts that must be paid to the supplier as ongoing royalties under a revenue-sharing acquisition model. Null if the acquisition is a flat-fee structure with no revenue share.',
    `runs_allowed` STRING COMMENT 'The maximum number of times the content may be broadcast or streamed under the acquisition agreement. Common in linear broadcast licenses (e.g., 3 runs over 2 years). Null indicates unlimited runs within the license period.',
    `runs_consumed` STRING COMMENT 'The number of runs (broadcasts or streams) that have been executed to date against the runs_allowed limit. Tracked to ensure compliance with contractual run restrictions.',
    `sublicensing_allowed_flag` BOOLEAN COMMENT 'Indicates whether the enterprise is permitted to sublicense the acquired content to third parties (True) or must exploit the content directly only (False). Sublicensing enables syndication and secondary distribution deals.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this acquisition record was last modified. Audit field for change tracking and data governance.',
    CONSTRAINT pk_acquisition PRIMARY KEY(`acquisition_id`)
) COMMENT 'Transactional record capturing the business event of acquiring content from an external source — studio, independent producer, syndicator, or distributor. Tracks acquisition type (purchase/license/co-production/commission), acquisition date, source party, acquisition cost, currency, content window acquired, territory scope, exclusivity flag, holdback period, acquisition status (negotiating/committed/delivered/cancelled), and originating deal reference. Serves as the financial and operational anchor for content entering the enterprise catalog from external sources.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` (
    `windowing_plan_id` BIGINT COMMENT 'Unique identifier for the windowing plan record. Primary key for the windowing plan entity.',
    `acquisition_deal_id` BIGINT COMMENT 'Foreign key linking to partner.acquisition_deal. Business justification: Windowing plans are derived from acquisition deals that define runs allowed, holdback periods, and window types. Linking windowing_plan to acquisition_deal enables runs-consumed tracking, holdback enf',
    `availability_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_availability_window. Business justification: A windowing plan must be grounded in a confirmed rights availability window; distribution teams verify that planned windows fall within rights-available periods. This link supports availability valida',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Linear broadcast windowing plans must reference the broadcast license under which content will air. Rights clearance teams verify the license is valid, active, and covers the planned windows territor',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Windowing plans govern when and on which channels content can air. Schedulers must validate schedule slots against active windowing plans for a channel. Direct channel_id FK enables channel-level wind',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Windowing plans can be episode-specific in media broadcasting — a series finale or pilot episode may have unique windowing terms (e.g., premiere episode available free on AVOD while remaining episodes',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Windowing plans specify rating requirements for distribution windows. Normalizes rating_code string column to reference the enterprise rating taxonomy.',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Windowing plans are version-specific (theatrical version has different windows than broadcast version). Links distribution strategy to specific version.',
    `content_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_content_window. Business justification: A windowing plan operationalizes a rights content window; distribution planners must verify that planned windows align with rights-granted windows. Linking windowing_plan to rights_content_window enab',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Windowing plans must specify the delivery channel (FAST, linear, SVOD) through which content is distributed in each window. This is a core content distribution planning requirement — windowing_plan al',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Windowing plans are governed by distribution agreements that define platform rights, territory scope, and window durations. This link enables windowing plan validation against contractual terms, SLA c',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Windowing plans specify distribution partners for each window (theatrical exhibitor, streaming platform, broadcast network). Partner performance tracking, holdback enforcement, exclusivity compliance ',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Windowing strategies must comply with license agreement terms (holdbacks, exclusivity windows, platform restrictions). Windowing plan validation and conflict detection require checking against the gov',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Each window must map to a specific rights grant that authorizes that exploitation type (SVOD, AVOD, linear broadcast). Clearance systems validate that the windows dates and platform fall within grant',
    `holdback_id` BIGINT COMMENT 'Foreign key linking to rights.holdback. Business justification: Windowing plans must respect holdback restrictions; planners need to reference the specific holdback that constrains a windows open date or platform scope. This link enables automated holdback enforc',
    `campaign_id` BIGINT COMMENT 'Reference identifier for the marketing campaign associated with this window release. Links to promotional activities, advertising spend, and audience acquisition efforts.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Windowing plans define which platform receives content in each release window (theatrical → premium VOD → SVOD → AVOD). Core to revenue maximization strategy and rights holder agreements.',
    `release_window_id` BIGINT COMMENT 'Foreign key linking to distribution.release_window. Business justification: A windowing plan is the planning artifact that defines and sequences release windows. Linking windowing_plan to the specific release_window it governs enables content ops to track plan-to-execution al',
    `royalty_rule_id` BIGINT COMMENT 'Foreign key linking to rights.royalty_rule. Business justification: Revenue planning for a windowing plan requires knowing which royalty rule governs the window type and platform. Linking windowing_plan to royalty_rule enables automated royalty accrual forecasting and',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Windowing plans in media broadcasting are commonly defined at the season level — a specific season of a series may have different windowing terms than other seasons (e.g., Season 1 available on AVOD w',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: windowing_plan defines the content-side release sequencing strategy across distribution channels. In media broadcasting, windowing plans are frequently negotiated and applied at the series level (e.g.',
    `syndication_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.syndication_agreement. Business justification: Windowing plans must enforce holdback windows and exclusivity terms defined in syndication agreements. Linking windowing_plan to syndication_agreement enables automated holdback enforcement, window se',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Windows are territory-specific - geo-blocking, regional release strategies, and regulatory compliance require linking each window to its target territory. Clearance validates territorial rights before',
    `title_id` BIGINT COMMENT 'Reference to the content asset (title, episode, series, film, clip) for which this windowing plan is defined. Links to the master content catalog.',
    `abr_enabled` BOOLEAN COMMENT 'Indicates whether adaptive bitrate streaming is enabled for this window, allowing dynamic quality adjustment based on viewer bandwidth. True=ABR enabled, False=fixed bitrate.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this windowing plan was formally approved by authorized stakeholders. Marks transition from draft to confirmed status.',
    `audio_configuration` STRING COMMENT 'The audio format specification for this window. Stereo=2-channel, Surround 5.1=5.1 channel surround, Surround 7.1=7.1 channel surround, Dolby Atmos=object-based audio, DTS:X=immersive audio format.. Valid values are `stereo|surround_5_1|surround_7_1|dolby_atmos|dts_x`',
    `blackout_restrictions` STRING COMMENT 'Geographic or temporal blackout rules that restrict content availability in specific regions or time periods within the territory (e.g., sports blackouts, regional exclusions).',
    `bundle_eligibility` BOOLEAN COMMENT 'Indicates whether this content is eligible for inclusion in subscription bundles or multi-title packages during this window. True=bundle eligible, False=standalone only.',
    `concurrent_streams_limit` STRING COMMENT 'Maximum number of simultaneous streams allowed per subscriber account for this content in this window. Used for subscription service tier management.',
    `content_format` STRING COMMENT 'The technical format specification for content delivery in this window. SD=standard definition, HD=high definition 1080p, 4K=ultra high definition, 8K=8K resolution, HDR=high dynamic range, Dolby Vision=premium HDR format.. Valid values are `sd|hd|4k|8k|hdr|dolby_vision`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this windowing plan record was first created in the system. Audit trail for record lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this windowing plan (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `download_to_go_enabled` BOOLEAN COMMENT 'Indicates whether offline download capability is enabled for this window, allowing viewers to download content for offline viewing. True=downloads allowed, False=streaming only.',
    `dubbing_availability` BOOLEAN COMMENT 'Indicates whether dubbed audio tracks in alternate languages are available for this window release. True=dubbing provided, False=original language only.',
    `exclusivity_tier` STRING COMMENT 'The level of exclusivity granted to the platform during this window. Exclusive=sole distribution rights, Non-Exclusive=concurrent availability on multiple platforms, Shared Exclusive=limited to a defined group of platforms, First Run=premiere window, Second Run=subsequent availability.. Valid values are `exclusive|non_exclusive|shared_exclusive|first_run|second_run`',
    `holdback_duration_days` STRING COMMENT 'The number of days between the close of the previous window and the open of this window, representing the exclusivity period or gap between release phases.',
    `language_version` STRING COMMENT 'ISO 639-2 or ISO 639-3 language code for the primary audio/subtitle language version to be released in this window (e.g., eng, spa, fra, deu).. Valid values are `^[a-z]{2,3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this windowing plan record was last updated. Audit trail for change tracking.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'The minimum guaranteed revenue amount (in base currency) that the platform has committed to pay for this window, regardless of actual performance. Used in licensing negotiations.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or strategic rationale for this windowing plan. Used for internal communication and documentation.',
    `planned_close_date` DATE COMMENT 'The intended end date when the content will no longer be available on the specified platform/channel in the specified territory. Nullable for open-ended windows.',
    `planned_open_date` DATE COMMENT 'The intended start date when the content becomes available on the specified platform/channel in the specified territory. Represents the editorial/commercial release plan.',
    `price_point` DECIMAL(18,2) COMMENT 'The consumer-facing price for transactional windows (TVOD, EST, PPV) in the specified currency. Represents the retail price charged to end viewers.',
    `promotional_pricing_flag` BOOLEAN COMMENT 'Indicates whether promotional or discounted pricing is applied for this window. True=promotional pricing active, False=standard pricing.',
    `revenue_model` STRING COMMENT 'The monetization approach for this window. Subscription=SVOD model, Advertising=AVOD model, Transactional=TVOD/PPV/EST, Hybrid=combination of models, Free=no direct revenue.. Valid values are `subscription|advertising|transactional|hybrid|free`',
    `streaming_protocol` STRING COMMENT 'The streaming delivery protocol used for OTT windows. HLS=HTTP Live Streaming (Apple), DASH=Dynamic Adaptive Streaming over HTTP (MPEG-DASH), Smooth Streaming=Microsoft, RTMP=Real-Time Messaging Protocol, WebRTC=real-time communication.. Valid values are `hls|dash|smooth_streaming|rtmp|webrtc`',
    `subtitle_availability` BOOLEAN COMMENT 'Indicates whether subtitles or closed captions are available for this window release. True=subtitles provided, False=no subtitles.',
    `viewing_window_hours` STRING COMMENT 'For TVOD/rental windows, the number of hours a viewer has to complete watching the content after initiating playback (e.g., 48-hour rental window).',
    `window_sequence_number` STRING COMMENT 'Sequential ordering of this window within the overall release strategy for the content. Lower numbers indicate earlier windows (e.g., 1=theatrical, 2=SVOD, 3=AVOD).',
    `window_status` STRING COMMENT 'Current lifecycle status of the windowing plan. Planned=initial strategy, Confirmed=approved by stakeholders, Active=currently in release window, Completed=window has closed, Cancelled=window will not execute, Postponed=delayed to future date.. Valid values are `planned|confirmed|active|completed|cancelled|postponed`',
    `window_type` STRING COMMENT 'The distribution window category defining the release channel type. Theatrical=cinema release, SVOD=subscription video on demand, AVOD=advertising-supported video on demand, TVOD=transactional video on demand, Linear Broadcast=traditional scheduled TV, Home Video=physical media, Syndication=content resale to multiple outlets, FAST=free ad-supported streaming television, PPV=pay-per-view, EST=electronic sell-through. [ENUM-REF-CANDIDATE: theatrical|svod|avod|tvod|linear_broadcast|home_video|syndication|fast|vod|ppv|est — 11 candidates stripped; promote to reference product]',
    CONSTRAINT pk_windowing_plan PRIMARY KEY(`windowing_plan_id`)
) COMMENT 'Defines the content-side release sequencing strategy for a title across distribution channels — theatrical, SVOD, AVOD, TVOD, linear broadcast, home video, and syndication. Each record captures window type, platform/channel, territory, planned open date, planned close date, holdback duration, exclusivity tier, and window status. Represents the content teams intended release plan that feeds into the rights domain for contractual enforcement and the distribution domain for operational execution. Distinct from rights windows (which are contractual) — this is the editorial/commercial planning artifact.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` (
    `metadata_profile_id` BIGINT COMMENT 'Unique identifier for the metadata profile record. Primary key.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Metadata profiles are encoder-specific; different platforms require different encoding + metadata combinations. Delivery validation, platform certification, and QC workflows require encoder linkage. E',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Metadata profiles delivered to distribution platforms (Netflix, Hulu, linear broadcast) must include certified content rating for parental control systems and regulatory display requirements. Links pr',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: metadata_profile contains a denormalized episode_number INT column. Metadata profiles are commonly delivered at the episode level for streaming platforms (e.g., episode-level metadata packages with sy',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Metadata profiles are version-specific (different metadata for theatrical vs broadcast version, localized versions). Links metadata delivery to specific version.',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Metadata profiles are prepared per delivery channel — FAST channel metadata differs from SVOD metadata in format, field requirements, and artwork specs. metadata_profile has channel_id (scheduling dom',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: metadata_profile stores genre_classification as a denormalized STRING. The enterprise genre taxonomy is managed in content.genre, and all other content entities (title, series, season, content_episode',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Metadata profiles are formatted for specific platform ingestion specs (Netflix TDF, iTunes XML, Roku feed). Each platform has unique metadata schema, image specs, and validation rules for content cata',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Metadata profiles are created to partner-specific specifications (different partners require different metadata standards, field mappings, and delivery formats). Linking metadata_profile to partner en',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: metadata_profile contains a denormalized season_number INT column. In media broadcasting, metadata profiles are delivered at the season level (e.g., a season metadata package for a streaming platform)',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: metadata_profile stores the full descriptive metadata set delivered to a specific platform. Metadata profiles are frequently created at the series level (e.g., a series-level metadata package delivere',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Metadata profiles are territory-specific in broadcasting; different territories require localized metadata (language, ratings, regulatory compliance). Linking metadata_profile to rights_territory enab',
    `title_id` BIGINT COMMENT 'Reference to the core content title for which this metadata profile is created. Links to the master title catalog.',
    `aspect_ratio` STRING COMMENT 'Visual aspect ratio of the content. Common values include 4:3 (standard definition), 16:9 (HD/widescreen), 21:9 (ultra-widescreen), 1.85:1, 2.39:1 (cinema formats).. Valid values are `4:3|16:9|21:9|1.85:1|2.39:1`',
    `audio_description_available` BOOLEAN COMMENT 'Indicates whether audio description (narration for visually impaired viewers) is available for this content. Used for accessibility compliance and platform requirements.',
    `audio_format` STRING COMMENT 'Audio format and channel configuration of the content. Examples: Stereo, 5.1 surround, 7.1 surround, Dolby Atmos, DTS:X, Mono.. Valid values are `Stereo|5.1|7.1|Dolby Atmos|DTS:X|Mono`',
    `cast_summary` STRING COMMENT 'Summarized list of principal cast members and their roles. Used for promotional materials and EPG (Electronic Program Guide) displays where full cast lists are impractical.',
    `closed_caption_available` BOOLEAN COMMENT 'Indicates whether closed captions (subtitles for the deaf and hard of hearing) are available for this content. Used for accessibility compliance and platform requirements.',
    `content_rating` STRING COMMENT 'Age or content rating assigned by the Motion Picture Association (MPA) or equivalent rating body, formatted for the target platform. Examples: G, PG, PG-13, R, TV-Y, TV-14.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this metadata profile record was first created in the system. Used for audit trails and metadata lifecycle tracking.',
    `delivery_date` DATE COMMENT 'The date on which this metadata profile was delivered or published to the target platform. Used for tracking metadata distribution and compliance with delivery schedules.',
    `director_credit` STRING COMMENT 'Name(s) of the director(s) of the content. Used for attribution, promotional materials, and search/discovery.',
    `expiration_date` DATE COMMENT 'Date on which this metadata profile expires or is no longer valid for the target platform. Used for metadata lifecycle management and rights windowing.',
    `keyword_tags` STRING COMMENT 'Comma-separated list of keyword tags for content discovery, search indexing, and recommendation engines. Includes themes, topics, moods, and contextual descriptors.',
    `long_synopsis` STRING COMMENT 'Extended narrative description of the content title. Typically 200-500 words, used for detailed program guides, press releases, and promotional materials.',
    `metadata_language` STRING COMMENT 'ISO 639 language code (2 or 3 letters) with optional ISO 3166 country code for the language in which this metadata profile is written. Examples: en, en-US, fr, es-MX.. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `metadata_standard` STRING COMMENT 'The metadata standard or schema used for this profile. Defines the structure and vocabulary of the metadata package.. Valid values are `EIDR|Dublin Core|EBUCore|TVAnytime|schema.org|MPEG-7`',
    `modified_by` STRING COMMENT 'User or system identifier of the person or process that last modified this metadata profile. Used for audit trails and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this metadata profile record was last modified. Used for audit trails, change tracking, and metadata version control.',
    `original_air_date` DATE COMMENT 'The date on which the content was originally broadcast or released. Used for historical context, rights windowing, and promotional materials.',
    `parental_guidance_notes` STRING COMMENT 'Detailed notes explaining the content rating, including specific content descriptors (violence, language, sexual content, etc.). Used for parental controls and compliance.',
    `platform_specific_code` STRING COMMENT 'Unique identifier assigned by the target platform for this metadata profile. Used for cross-referencing and reconciliation with external systems.',
    `poster_url` STRING COMMENT 'URL (Uniform Resource Locator) to the poster or cover art image associated with this metadata profile. Used for streaming platform UI, marketing, and promotional materials.',
    `production_company` STRING COMMENT 'Name of the production company or studio that produced the content. Used for rights attribution and promotional materials.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the metadata profile. Indicates whether the profile is in draft, has been validated, is published to the target platform, rejected due to validation errors, archived, or expired.. Valid values are `draft|validated|published|rejected|archived|expired`',
    `promotional_tagline` STRING COMMENT 'Short, catchy promotional phrase or slogan used in marketing campaigns, social media, and advertising. Typically 10-30 words.',
    `runtime_minutes` STRING COMMENT 'Total runtime of the content in minutes. Used for scheduling, EPG (Electronic Program Guide) display, and audience planning.',
    `short_synopsis` STRING COMMENT 'Brief narrative description of the content title. Typically 50-150 words, used for EPG (Electronic Program Guide) listings, mobile apps, and quick reference.',
    `thumbnail_url` STRING COMMENT 'URL (Uniform Resource Locator) to the thumbnail image associated with this metadata profile. Used for EPG (Electronic Program Guide) display, streaming platform UI, and promotional materials.',
    `trailer_url` STRING COMMENT 'URL (Uniform Resource Locator) to the trailer or preview video associated with this content. Used for promotional campaigns and streaming platform previews.',
    `validation_errors` STRING COMMENT 'Detailed list of validation errors or warnings encountered during metadata quality checks. Used for troubleshooting and metadata remediation.',
    `validation_status` STRING COMMENT 'Result of automated or manual validation checks against the target metadata standard. Indicates whether the profile meets all required schema and business rules.. Valid values are `pending|passed|failed|warning`',
    `version_number` STRING COMMENT 'Version number of this metadata profile. Incremented with each update to track metadata evolution and support rollback if needed.',
    CONSTRAINT pk_metadata_profile PRIMARY KEY(`metadata_profile_id`)
) COMMENT 'Stores the full descriptive metadata set for a title as delivered to a specific platform or metadata standard — EPG, streaming platform, MVPD, search index, or press/publicity. Captures metadata standard (EIDR/Dublin Core/EBUCore/TVAnytime/schema.org), target platform, long synopsis, short synopsis, keyword tags, cast summary, director credit, production company, distributor, promotional tagline, metadata language, delivery date, and validation status. Enables platform-specific metadata packaging without polluting the core title master record.';

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
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ADD CONSTRAINT `fk_content_genre_parent_genre_id` FOREIGN KEY (`parent_genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`content` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`content` SET TAGS ('dbx_domain' = 'content');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` SET TAGS ('dbx_subdomain' = 'asset_catalog');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `genre_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Rights Holder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Content Acquisition Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '4:3|16:9|21:9|1.85:1|2.39:1');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `color_format` SET TAGS ('dbx_business_glossary_term' = 'Color Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `color_format` SET TAGS ('dbx_value_regex' = 'color|black_and_white|colorized');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `content_status` SET TAGS ('dbx_business_glossary_term' = 'Content Lifecycle Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `content_status` SET TAGS ('dbx_value_regex' = 'active|archived|restricted|pending|expired|withdrawn');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `coppa_child_directed_flag` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Child-Directed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `eidr_code` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `eidr_code` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `episode_number` SET TAGS ('dbx_business_glossary_term' = 'Episode Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `hd_available_flag` SET TAGS ('dbx_business_glossary_term' = 'High Definition (HD) Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_value_regex' = '^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_business_glossary_term' = 'International Standard Recording Code (ISRC)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Content Keywords');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_name` SET TAGS ('dbx_business_glossary_term' = 'Title Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_language` SET TAGS ('dbx_business_glossary_term' = 'Original Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_title` SET TAGS ('dbx_business_glossary_term' = 'Original Title Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `parental_advisory_flag` SET TAGS ('dbx_business_glossary_term' = 'Parental Advisory Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `premiere_flag` SET TAGS ('dbx_business_glossary_term' = 'Premiere Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `production_year` SET TAGS ('dbx_business_glossary_term' = 'Production Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Original Release Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rights_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Availability Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rights_status` SET TAGS ('dbx_value_regex' = 'available|restricted|expired|pending_clearance|blackout');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_business_glossary_term' = 'Runtime in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `studio_name` SET TAGS ('dbx_business_glossary_term' = 'Production Studio Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `sub_genre` SET TAGS ('dbx_business_glossary_term' = 'Sub-Genre Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Long Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Short Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `theatrical_release_flag` SET TAGS ('dbx_business_glossary_term' = 'Theatrical Release Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `uhd_4k_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Ultra High Definition (UHD) 4K Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` SET TAGS ('dbx_subdomain' = 'asset_catalog');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Rights Holder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Production Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'Archive Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '16:9|4:3|21:9|2.39:1|1.85:1');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `audio_format` SET TAGS ('dbx_business_glossary_term' = 'Audio Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `audio_format` SET TAGS ('dbx_value_regex' = 'stereo|surround_5_1|surround_7_1|dolby_atmos|dts_x');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `distributor` SET TAGS ('dbx_business_glossary_term' = 'Distributor');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `eidr_code` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `eidr_code` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `episode_runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Episode Runtime Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `finale_date` SET TAGS ('dbx_business_glossary_term' = 'Finale Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `franchise_name` SET TAGS ('dbx_business_glossary_term' = 'Franchise Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `hdr_format` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `hdr_format` SET TAGS ('dbx_value_regex' = 'SDR|HDR10|HDR10_PLUS|DOLBY_VISION|HLG');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `isan_code` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `isan_code` SET TAGS ('dbx_value_regex' = '^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `language_original` SET TAGS ('dbx_business_glossary_term' = 'Original Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `language_original` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `original_network` SET TAGS ('dbx_business_glossary_term' = 'Original Network');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `premiere_date` SET TAGS ('dbx_business_glossary_term' = 'Premiere Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `production_company` SET TAGS ('dbx_business_glossary_term' = 'Production Company');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `resolution_standard` SET TAGS ('dbx_business_glossary_term' = 'Resolution Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `resolution_standard` SET TAGS ('dbx_value_regex' = 'SD|HD|FHD|UHD|4K|8K');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `series_status` SET TAGS ('dbx_business_glossary_term' = 'Series Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `series_status` SET TAGS ('dbx_value_regex' = 'ongoing|ended|cancelled|hiatus|in_development|pre_production');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `series_type` SET TAGS ('dbx_business_glossary_term' = 'Series Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `syndication_eligible` SET TAGS ('dbx_business_glossary_term' = 'Syndication Eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Long Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Short Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Series Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `title_original` SET TAGS ('dbx_business_glossary_term' = 'Original Series Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `total_episode_count` SET TAGS ('dbx_business_glossary_term' = 'Total Episode Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `total_season_count` SET TAGS ('dbx_business_glossary_term' = 'Total Season Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` SET TAGS ('dbx_subdomain' = 'asset_catalog');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Budget Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'Archive Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `awards_nominated` SET TAGS ('dbx_business_glossary_term' = 'Awards Nominated');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `awards_won` SET TAGS ('dbx_business_glossary_term' = 'Awards Won');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `banner_artwork_url` SET TAGS ('dbx_business_glossary_term' = 'Banner Artwork Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `distributor` SET TAGS ('dbx_business_glossary_term' = 'Distributor');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `eidr` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `eidr` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `episode_count_aired` SET TAGS ('dbx_business_glossary_term' = 'Episode Count Aired');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `episode_count_ordered` SET TAGS ('dbx_business_glossary_term' = 'Episode Count Ordered');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `episode_count_produced` SET TAGS ('dbx_business_glossary_term' = 'Episode Count Produced');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `finale_date` SET TAGS ('dbx_business_glossary_term' = 'Season Finale Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `isan` SET TAGS ('dbx_value_regex' = '^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `language_original` SET TAGS ('dbx_business_glossary_term' = 'Original Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `language_original` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `network_original` SET TAGS ('dbx_business_glossary_term' = 'Original Network');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `original_air_date` SET TAGS ('dbx_business_glossary_term' = 'Original Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `poster_artwork_url` SET TAGS ('dbx_business_glossary_term' = 'Poster Artwork Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `production_company` SET TAGS ('dbx_business_glossary_term' = 'Production Company');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `production_year` SET TAGS ('dbx_business_glossary_term' = 'Production Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Rights Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_status` SET TAGS ('dbx_business_glossary_term' = 'Season Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Long Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Short Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Season Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Runtime Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` SET TAGS ('dbx_subdomain' = 'asset_catalog');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_ssot_owner' = 'episode');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Content Season Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Content Series Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Budget Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'Archive Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '4:3|16:9|21:9|1.85:1|2.39:1');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `audio_format` SET TAGS ('dbx_business_glossary_term' = 'Audio Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `audio_format` SET TAGS ('dbx_value_regex' = 'stereo|5.1|7.1|dolby_atmos|dts_x');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `broadcast_count` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `content_advisory` SET TAGS ('dbx_business_glossary_term' = 'Content Advisory');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `episode_number` SET TAGS ('dbx_business_glossary_term' = 'Episode Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `episode_status` SET TAGS ('dbx_business_glossary_term' = 'Episode Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `episode_status` SET TAGS ('dbx_value_regex' = 'in_production|post_production|ready_for_broadcast|aired|archived|withdrawn');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `episode_type` SET TAGS ('dbx_business_glossary_term' = 'Episode Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Content Keywords');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `music_cue_sheet_submitted` SET TAGS ('dbx_business_glossary_term' = 'Music Cue Sheet Submitted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `original_air_date` SET TAGS ('dbx_business_glossary_term' = 'Original Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `premiere_flag` SET TAGS ('dbx_business_glossary_term' = 'Premiere Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `production_code` SET TAGS ('dbx_business_glossary_term' = 'Production Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `rerun_flag` SET TAGS ('dbx_business_glossary_term' = 'Rerun Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|restricted|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_business_glossary_term' = 'Runtime in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `runtime_with_ads_seconds` SET TAGS ('dbx_business_glossary_term' = 'Runtime With Advertisements in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `subtitles_available` SET TAGS ('dbx_business_glossary_term' = 'Subtitles Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Episode Synopsis Long');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Episode Synopsis Short');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Episode Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `video_resolution` SET TAGS ('dbx_value_regex' = 'SD|HD|FHD|UHD|4K|8K');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `vod_available_from_date` SET TAGS ('dbx_business_glossary_term' = 'Video On Demand (VOD) Available From Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `vod_available_until_date` SET TAGS ('dbx_business_glossary_term' = 'Video On Demand (VOD) Available Until Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` SET TAGS ('dbx_subdomain' = 'asset_catalog');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Version Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Encoder Config Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '^[0-9]+:[0-9]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_track_configuration` SET TAGS ('dbx_business_glossary_term' = 'Audio Track Configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `broadcast_safe` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Safe');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'Checksum Message Digest 5 (MD5)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{32}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `color_space` SET TAGS ('dbx_business_glossary_term' = 'Color Space');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `color_space` SET TAGS ('dbx_value_regex' = 'rec_709|rec_2020|dci_p3|srgb');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `content_advisory` SET TAGS ('dbx_business_glossary_term' = 'Content Advisory');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `eidr_code` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `eidr_code` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `hdr_format` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `hdr_format` SET TAGS ('dbx_value_regex' = 'sdr|hdr10|hdr10_plus|dolby_vision|hlg');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `isan_code` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN) Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `isan_code` SET TAGS ('dbx_value_regex' = '^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `isrc_code` SET TAGS ('dbx_business_glossary_term' = 'International Standard Recording Code (ISRC) Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `isrc_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `label` SET TAGS ('dbx_business_glossary_term' = 'Version Label');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `qc_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Completed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `qc_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `qc_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed|conditional_pass');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `resolution` SET TAGS ('dbx_value_regex' = 'sd|hd_720p|hd_1080p|uhd_4k|uhd_8k');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `runtime_delta_seconds` SET TAGS ('dbx_business_glossary_term' = 'Runtime Delta in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_business_glossary_term' = 'Runtime in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `target_territory` SET TAGS ('dbx_business_glossary_term' = 'Target Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `target_territory` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Version Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` SET TAGS ('dbx_subdomain' = 'asset_catalog');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `parent_genre_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Genre Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `ad_pod_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Compatibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `applicable_content_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Content Types');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `archive_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Archive Retention Policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `archive_retention_policy` SET TAGS ('dbx_value_regex' = 'permanent|long_term|standard|short_term');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `avod_monetization_potential` SET TAGS ('dbx_business_glossary_term' = 'Advertising-Supported Video On Demand (AVOD) Monetization Potential');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `avod_monetization_potential` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_code` SET TAGS ('dbx_business_glossary_term' = 'Genre Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `daypart_affinity` SET TAGS ('dbx_business_glossary_term' = 'Daypart Affinity');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_description` SET TAGS ('dbx_business_glossary_term' = 'Genre Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `eidr_genre_mapping` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Genre Mapping');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `fast_channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Free Ad-Supported Streaming Television (FAST) Channel Applicability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `geographic_restriction_applicability` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Applicability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `iab_content_category` SET TAGS ('dbx_business_glossary_term' = 'Interactive Advertising Bureau (IAB) Content Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `iab_content_category` SET TAGS ('dbx_value_regex' = '^IAB[0-9]{1,2}(-[0-9]{1,2})?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `linear_broadcast_suitability` SET TAGS ('dbx_business_glossary_term' = 'Linear Broadcast Suitability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `localization_priority` SET TAGS ('dbx_business_glossary_term' = 'Localization Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `localization_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `metadata_enrichment_priority` SET TAGS ('dbx_business_glossary_term' = 'Metadata Enrichment Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `metadata_enrichment_priority` SET TAGS ('dbx_value_regex' = 'critical|standard|minimal');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `mpa_rating_applicability` SET TAGS ('dbx_business_glossary_term' = 'Motion Picture Association (MPA) Rating Applicability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_name` SET TAGS ('dbx_business_glossary_term' = 'Genre Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `nielsen_genre_code` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Genre Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `ott_platform_priority` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Top (OTT) Platform Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `ott_platform_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `parental_guidance_flag` SET TAGS ('dbx_business_glossary_term' = 'Parental Guidance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `svod_performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Subscription Video On Demand (SVOD) Performance Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `svod_performance_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|catalog');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `syndication_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Syndication Eligibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Genre Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `usage_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` SET TAGS ('dbx_subdomain' = 'asset_catalog');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Rating Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_appealed|appeal_pending|appeal_approved|appeal_denied');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `body` SET TAGS ('dbx_business_glossary_term' = 'Rating Body');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Rating Certificate Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `rating_code` SET TAGS ('dbx_business_glossary_term' = 'Rating Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_drug_use` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptor Drug Use');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_fear` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptor Fear');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_language` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptor Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_nudity` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptor Nudity');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_descriptor_violence` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptor Violence');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `rating_description` SET TAGS ('dbx_business_glossary_term' = 'Rating Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `minimum_age` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rating Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `parental_control_enabled` SET TAGS ('dbx_business_glossary_term' = 'Parental Control Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Submission Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `system` SET TAGS ('dbx_business_glossary_term' = 'Rating System');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `system` SET TAGS ('dbx_value_regex' = 'MPA|TVPG|BBFC|FSK|OFLC|CBFC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Rating Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` SET TAGS ('dbx_subdomain' = 'rights_distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `talent_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Credit Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Episode Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Role Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `billing_position` SET TAGS ('dbx_business_glossary_term' = 'Billing Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|disputed|rejected|arbitration');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_category` SET TAGS ('dbx_business_glossary_term' = 'Credit Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_name` SET TAGS ('dbx_business_glossary_term' = 'Credit Display Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_order` SET TAGS ('dbx_business_glossary_term' = 'Credit Display Order');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Credit End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_notes` SET TAGS ('dbx_business_glossary_term' = 'Credit Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Credit Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_type` SET TAGS ('dbx_value_regex' = 'on-screen|off-screen|voice|stunt|archive');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `pseudonym_flag` SET TAGS ('dbx_business_glossary_term' = 'Pseudonym Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `residuals_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residuals Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `union_affiliation_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` SET TAGS ('dbx_subdomain' = 'rights_distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_value_regex' = 'negotiating|committed|delivered|active|cancelled|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_value_regex' = 'purchase|license|co-production|commission|barter|syndication');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `ancillary_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Rights Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|restricted|failed');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `content_window_type` SET TAGS ('dbx_business_glossary_term' = 'Content Window Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Delivery Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `format_rights` SET TAGS ('dbx_business_glossary_term' = 'Format Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `language_rights` SET TAGS ('dbx_business_glossary_term' = 'Language Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_end_date` SET TAGS ('dbx_business_glossary_term' = 'License End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_start_date` SET TAGS ('dbx_business_glossary_term' = 'License Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `residuals_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Residuals Obligation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `runs_allowed` SET TAGS ('dbx_business_glossary_term' = 'Runs Allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `runs_consumed` SET TAGS ('dbx_business_glossary_term' = 'Runs Consumed');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Allowed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` SET TAGS ('dbx_subdomain' = 'rights_distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `windowing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Windowing Plan ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `availability_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Availability Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Content Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Governing License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `holdback_id` SET TAGS ('dbx_business_glossary_term' = 'Holdback Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `release_window_id` SET TAGS ('dbx_business_glossary_term' = 'Release Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `abr_enabled` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_business_glossary_term' = 'Audio Configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_value_regex' = 'stereo|surround_5_1|surround_7_1|dolby_atmos|dts_x');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Blackout Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `bundle_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Bundle Eligibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `concurrent_streams_limit` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Streams Limit');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `content_format` SET TAGS ('dbx_business_glossary_term' = 'Content Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `content_format` SET TAGS ('dbx_value_regex' = 'sd|hd|4k|8k|hdr|dolby_vision');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `download_to_go_enabled` SET TAGS ('dbx_business_glossary_term' = 'Download-to-Go Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `dubbing_availability` SET TAGS ('dbx_business_glossary_term' = 'Dubbing Availability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `exclusivity_tier` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `exclusivity_tier` SET TAGS ('dbx_value_regex' = 'exclusive|non_exclusive|shared_exclusive|first_run|second_run');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `holdback_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Duration Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `language_version` SET TAGS ('dbx_business_glossary_term' = 'Language Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `language_version` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `planned_close_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Close Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `planned_open_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Open Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `price_point` SET TAGS ('dbx_business_glossary_term' = 'Price Point');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `price_point` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `promotional_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Pricing Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `revenue_model` SET TAGS ('dbx_business_glossary_term' = 'Revenue Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `revenue_model` SET TAGS ('dbx_value_regex' = 'subscription|advertising|transactional|hybrid|free');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'hls|dash|smooth_streaming|rtmp|webrtc');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `subtitle_availability` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Availability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `viewing_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Viewing Window Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `window_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Window Sequence Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `window_status` SET TAGS ('dbx_business_glossary_term' = 'Window Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `window_status` SET TAGS ('dbx_value_regex' = 'planned|confirmed|active|completed|cancelled|postponed');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `window_type` SET TAGS ('dbx_business_glossary_term' = 'Window Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` SET TAGS ('dbx_subdomain' = 'asset_catalog');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `metadata_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Metadata Profile ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Encoder Config Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '4:3|16:9|21:9|1.85:1|2.39:1');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `audio_format` SET TAGS ('dbx_business_glossary_term' = 'Audio Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `audio_format` SET TAGS ('dbx_value_regex' = 'Stereo|5.1|7.1|Dolby Atmos|DTS:X|Mono');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `cast_summary` SET TAGS ('dbx_business_glossary_term' = 'Cast Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `director_credit` SET TAGS ('dbx_business_glossary_term' = 'Director Credit');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `keyword_tags` SET TAGS ('dbx_business_glossary_term' = 'Keyword Tags');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `long_synopsis` SET TAGS ('dbx_business_glossary_term' = 'Long Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `metadata_language` SET TAGS ('dbx_business_glossary_term' = 'Metadata Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `metadata_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `metadata_standard` SET TAGS ('dbx_business_glossary_term' = 'Metadata Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `metadata_standard` SET TAGS ('dbx_value_regex' = 'EIDR|Dublin Core|EBUCore|TVAnytime|schema.org|MPEG-7');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `original_air_date` SET TAGS ('dbx_business_glossary_term' = 'Original Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `parental_guidance_notes` SET TAGS ('dbx_business_glossary_term' = 'Parental Guidance Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `platform_specific_code` SET TAGS ('dbx_business_glossary_term' = 'Platform-Specific ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `poster_url` SET TAGS ('dbx_business_glossary_term' = 'Poster URL (Uniform Resource Locator)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `production_company` SET TAGS ('dbx_business_glossary_term' = 'Production Company');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Profile Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'draft|validated|published|rejected|archived|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `promotional_tagline` SET TAGS ('dbx_business_glossary_term' = 'Promotional Tagline');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Runtime Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `short_synopsis` SET TAGS ('dbx_business_glossary_term' = 'Short Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail URL (Uniform Resource Locator)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `trailer_url` SET TAGS ('dbx_business_glossary_term' = 'Trailer URL (Uniform Resource Locator)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `validation_errors` SET TAGS ('dbx_business_glossary_term' = 'Validation Errors');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|warning');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
