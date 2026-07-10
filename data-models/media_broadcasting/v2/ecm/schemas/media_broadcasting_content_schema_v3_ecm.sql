-- Schema for Domain: content | Business:  | Version: v3_ecm
-- Generated on: 2026-07-10 19:30:35

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`content` COMMENT 'Single source of truth for all content assets across the enterprise — covering titles, episodes, series, films, clips, music, news segments, and live events. Manages content metadata (EIDR, ISAN, ISRC identifiers), format specifications, versioning, localization, MPA ratings, genre classification, and content lifecycle from acquisition through archival. Serves as the master catalog referenced by scheduling, distribution, rights, and digital asset domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`title` (
    `title_id` BIGINT COMMENT 'Unique identifier for the content title. Primary key for the title master catalog. Serves as the universal join point referenced by scheduling, distribution, rights, digital asset, and advertising domains.',
    `genre_id` BIGINT COMMENT 'FK to content.genre',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Every titles distribution rights are governed by license agreements. Broadcast scheduling, windowing decisions, and royalty calculations require knowing which agreement controls each titles exploita',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.rights_holder. Business justification: Tracks who owns/controls rights to each title - essential for royalty payments, clearance workflows, and determining who must approve licensing deals. Rights holder is the starting point for all right',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Titles have primary production/distribution territories that affect rights clearance, regulatory compliance (content ratings), and default licensing assumptions. Clearance workflows validate against t',
    `series_id` BIGINT COMMENT 'Foreign key reference to the parent series for episodic content. Null for standalone films, clips, and non-episodic content.',
    `acquisition_date` DATE COMMENT 'Date when the content rights were acquired by the organization. Used for rights lifecycle tracking, amortization calculations, and contract management.',
    `archive_date` DATE COMMENT 'Date when the content was moved to archived status. Used for content lifecycle management and digital asset retention policies.',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the content. Determines presentation format for broadcast, streaming, and theatrical distribution.. Valid values are `4:3|16:9|21:9|1.85:1|2.39:1`',
    `audio_description_available_flag` BOOLEAN COMMENT 'Indicates whether audio description track is available for visually impaired audiences. Required for accessibility compliance and inclusive broadcasting.',
    `closed_caption_available_flag` BOOLEAN COMMENT 'Indicates whether closed captioning is available for the content. Required for FCC compliance and accessibility standards.',
    `color_format` STRING COMMENT 'Indicates whether the content is in color, black and white, or has been colorized. Used for archival classification and presentation metadata.. Valid values are `color|black_and_white|colorized`',
    `content_rating` STRING COMMENT 'Official content rating assigned by the Motion Picture Association or television rating authority. Determines audience suitability, broadcast restrictions, and parental control settings. [ENUM-REF-CANDIDATE: G|PG|PG-13|R|NC-17|TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA|NR — 12 candidates stripped; promote to reference product]',
    `content_status` STRING COMMENT 'Current lifecycle status of the content asset. Determines availability for scheduling, distribution, and monetization. Active content is available for use; archived content is retained but not actively distributed; restricted content has legal or rights limitations.. Valid values are `active|archived|restricted|pending|expired|withdrawn`',
    `content_type` STRING COMMENT 'Discriminator classifying the fundamental type of content asset. Determines applicable business rules for scheduling, rights windowing, and distribution strategies. [ENUM-REF-CANDIDATE: film|series|episode|clip|music|news|live_event|documentary — 8 candidates stripped; promote to reference product]',
    `coppa_child_directed_flag` BOOLEAN COMMENT 'Indicates whether the content is directed to children under 13 years of age. Triggers COPPA compliance requirements for data collection, advertising restrictions, and privacy protections.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 code representing the country where the content was originally produced. Used for rights management, regulatory compliance, and content origin reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the title record was first created in the system. Used for audit trails, data lineage tracking, and operational reporting.',
    `distributor_name` STRING COMMENT 'Name of the primary distributor or licensor of the content. Used for rights management, financial reconciliation, and contract tracking.',
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
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Series-level rights deals are standard in TV distribution. Multi-season acquisitions and franchise licensing require tracking which agreement governs the entire series for royalty allocation and clear',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Series-level licensing deals (multi-season packages, format rights, international distribution) are common in media sales. Real business process: series licensing negotiations and format sales trackin',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.rights_holder. Business justification: Series-level rights ownership (studio/production company) drives all downstream licensing and royalty flows. Franchise management and multi-season deal negotiations require knowing the primary rights ',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Series production is facility-based; long-running shows are tied to specific studio facilities for multi-year scheduling, crew allocation, facility cost allocation, and production continuity. Essentia',
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
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Seasons have content ratings. Normalizes content_rating string column to reference the enterprise rating taxonomy.',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Seasons have genre classification. Normalizes genre_primary/genre_secondary string columns to reference the enterprise genre taxonomy.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Season-specific licensing (e.g., Season 1 to Netflix, Season 2 to Hulu) is common in streaming. Clearance and windowing decisions require knowing which agreement controls each seasons distribution ri',
    `media_asset_id` BIGINT COMMENT 'Reference to the season trailer asset in the MAM system. Used for promotional campaigns and platform previews.',
    `production_budget_id` BIGINT COMMENT 'Foreign key linking to finance.production_budget. Business justification: Seasons often have dedicated budgets separate from series-level allocations. Network finance teams approve and monitor season budgets independently for greenlight decisions, mid-season adjustments, an',
    `series_id` BIGINT COMMENT 'Reference to the parent series to which this season belongs.',
    `studio_facility_id` BIGINT COMMENT 'Foreign key linking to technology.studio_facility. Business justification: Seasons are shot in specific studios over production blocks. Studio booking systems, production accounting, wrap reports, and facility utilization dashboards require season-to-studio linkage. Critical',
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
    `rights_holder` STRING COMMENT 'Name of the entity holding primary distribution and exploitation rights for the season. Essential for clearance and licensing.',
    `rights_territory` STRING COMMENT 'Geographic territories where distribution rights are held, using ISO 3166-1 alpha-3 country codes or regional groupings. Critical for windowing and blackout enforcement.',
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
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Episode-specific promotional campaigns (weekly tune-in ads, event episodes). Business process: weekly marketing planning, special episode promotion (finales, crossovers), episode-level campaign perfor [FK namespace reconciled: points to sales.campaign]',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Episodes have content ratings (TV-PG, TV-MA). Normalizes content_rating string column to reference the enterprise rating taxonomy.',
    `season_id` BIGINT COMMENT 'Reference to the specific season within the series to which this episode belongs. Enables season-level grouping and rights management.',
    `series_id` BIGINT COMMENT 'Reference to the parent series to which this episode belongs. Links episode to its series container.',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Episodes have genre classification. Normalizes genre_primary/genre_secondary string columns to reference the enterprise genre taxonomy.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Episode-level syndication deals (especially for high-value episodes like finales or specials) require direct linkage to license agreements for run-count tracking and residual calculations.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Broadcast playout and VOD distribution require direct lookup of the master media asset file for each episode. Traffic systems and playout automation depend on episode-to-asset mapping for scheduling a',
    `production_budget_id` BIGINT COMMENT 'Foreign key linking to finance.production_budget. Business justification: High-cost episodes (pilots, finales, VFX-heavy episodes) often have dedicated budget line items. Production accountants track episodic costs for above-the-line talent overages, location expenses, and ',
    `studio_facility_id` BIGINT COMMENT 'Foreign key linking to technology.studio_facility. Business justification: Episodes are recorded in specific studios. Daily production logs, studio utilization reports, post-production workflows, and per-episode cost accounting require episode-to-studio linkage. Essential fo',
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
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: Content versions are encoded to specific ABR profiles (HLS ladder, DASH manifest). Essential for transcode workflow, QC validation, and ensuring version matches target platforms adaptive bitrate stre',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Versions have MPA and TV ratings. Normalizes mpa_rating/tv_rating string columns to reference the enterprise rating taxonomy.',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Each content version is protected by specific DRM policy (Widevine L1, HDCP 2.2 requirements). Required for rights enforcement, device compatibility validation, and studio compliance in premium conten',
    `encoder_config_id` BIGINT COMMENT 'Foreign key linking to technology.encoder_config. Business justification: Each content version is encoded using specific encoder configurations. QC workflows, bitrate ladder validation, delivery troubleshooting, and platform certification require knowing which encoder profi',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Version-specific grants (4K rights vs HD rights, dubbed vs subtitled) are tracked separately in modern distribution. Clearance systems must validate that the specific version has an active grant.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Different versions (theatrical cut, directors cut, TV edit, international dub) often have separate rights agreements with distinct terms. Clearance and distribution workflows require version-specific',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Each content version (territory/platform-specific cut) references its master media asset for distribution. Fulfillment workflows require version-to-asset mapping to deliver correct files to platforms ',
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
    `target_platform` STRING COMMENT 'Distribution platform or window this version is optimized for (e.g., linear broadcast, SVOD, AVOD, theatrical). [ENUM-REF-CANDIDATE: linear_broadcast|svod|avod|tvod|theatrical|home_video|syndication|fast|mvpd|vmvpd — 10 candidates stripped; promote to reference product]',
    `target_territory` STRING COMMENT 'Three-letter ISO country code indicating the primary geographic territory this version is intended for (e.g., USA, GBR, FRA).. Valid values are `^[A-Z]{3}$`',
    `version_status` STRING COMMENT 'Current lifecycle status of the version indicating its readiness for distribution and playout. [ENUM-REF-CANDIDATE: draft|in_production|qc_pending|approved|active|archived|deprecated|rejected — 8 candidates stripped; promote to reference product]',
    `version_type` STRING COMMENT 'Classification of the version type indicating the nature of the edit or adaptation. [ENUM-REF-CANDIDATE: theatrical|broadcast|director|extended|unrated|censored|dubbed|subtitled|localized|preview|trailer — 11 candidates stripped; promote to reference product]',
    `video_codec` STRING COMMENT 'Video compression codec used for this version (e.g., H.264, H.265/HEVC, VP9, AV1, MPEG-2).',
    CONSTRAINT pk_version PRIMARY KEY(`version_id`)
) COMMENT 'Tracks every distinct version of a title — including edits, cuts, localized dubs, censored versions, broadcast-safe edits, theatrical vs. extended cuts, and format variants (SD/HD/4K). Each version record carries version type (theatrical/broadcast/director/unrated/censored/dubbed/subtitled), version label, target territory, target platform, runtime delta from master, language track configuration, subtitle language list, aspect ratio override, and version status. Enables multi-platform distribution where different versions are delivered to different windows and territories.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`genre` (
    `genre_id` BIGINT COMMENT 'Unique identifier for the genre. Primary key for the genre reference taxonomy.',
    `parent_genre_id` BIGINT COMMENT 'Reference to the parent genre in the hierarchical taxonomy, enabling multi-level classification such as Drama > Legal Drama or Sports > Football. Null for top-level genres.',
    `employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - genre taxonomy needs a curator for metadata governance',
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
    `regulatory_obligation_id` BIGINT COMMENT 'add column compliance_regulatory_obligation_id (BIGINT) with FK to compliance.regulatory_obligation.regulatory_obligation_id - content rating systems are mandated by regulatory obligations',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`localization` (
    `localization_id` BIGINT COMMENT 'Unique identifier for the localization work product record.',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Localized content versions require territory-specific ratings (BBFC for UK, FSK for Germany, MPAA for US). Localization workflow must track rating submission, approval, and certificate for regulatory ',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Localized audio tracks and subtitle files are delivered as media assets. Distribution workflows require linking localization records to their delivered asset files for QC, versioning, and platform del',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Localizations are prepared for specific platform technical specs (Netflix TDF, iTunes metadata format). Platform-specific subtitle formats, audio track configurations, and metadata requirements drive ',
    `partner_id` BIGINT COMMENT 'Reference to the external vendor or internal facility performing the localization work.',
    `version_id` BIGINT COMMENT 'Reference to the specific title version being localized.',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Dubbing and voice localization require tracking which talent performed the localized version for residual payments, credit attribution, and guild reporting. Essential for international content distrib',
    `accessibility_standard_met` STRING COMMENT 'Specific accessibility standard that the localization work product complies with (e.g., WCAG 2.1 AA, FCC CVAA).. Valid values are `WCAG_2.1_AA|WCAG_2.2_AA|FCC_CVAA|EAA|ADA|none`',
    `actual_delivery_date` DATE COMMENT 'Actual date when the localization work product was delivered by the vendor or internal team.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the localization work product received final approval for distribution.',
    `approved_by_name` STRING COMMENT 'Name of the individual or role who provided final approval for the localization work product.',
    `asset_file_path` STRING COMMENT 'Storage location or URI path to the delivered localization asset file in the Media Asset Management (MAM) system or Content Delivery Network (CDN).',
    `character_count` STRING COMMENT 'Total number of characters in the subtitle or metadata translation work product, used for billing and capacity planning.',
    `compliance_certification_flag` BOOLEAN COMMENT 'Indicates whether the localization meets regulatory compliance requirements for the target territory (e.g., local content quotas, language laws, accessibility standards).',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for this localization work product, including vendor fees, studio costs, and internal labor.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this localization record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the localization cost amount.. Valid values are `^[A-Z]{3}$`',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Total runtime duration in minutes of the content being localized, relevant for dubbing and subtitling scope.',
    `eidr_code` STRING COMMENT 'EIDR unique identifier linking this localization to the global content registry for the underlying title.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `localization_status` STRING COMMENT 'Current workflow status of the localization work product. [ENUM-REF-CANDIDATE: ordered|in_progress|delivered|qc_review|approved|rejected|revision_required — 7 candidates stripped; promote to reference product]',
    `localization_type` STRING COMMENT 'The type of localization work being performed on the content asset.. Valid values are `dubbing|subtitling|metadata_translation|forced_narrative|audio_description|closed_caption`',
    `order_date` DATE COMMENT 'Date when the localization work was ordered from the vendor or internal team.',
    `purchase_order_number` STRING COMMENT 'Purchase order number issued to the localization vendor for this work product.',
    `qc_notes` STRING COMMENT 'Detailed notes and findings from the quality control review process, including any defects or issues identified.',
    `qc_pass_flag` BOOLEAN COMMENT 'Boolean indicator of whether the localization work product passed quality control review.',
    `qc_review_date` DATE COMMENT 'Date when quality control review of the localization work product was completed.',
    `qc_reviewer_name` STRING COMMENT 'Name of the individual or team who performed the quality control review.',
    `revision_reason` STRING COMMENT 'Business reason or description for why a revision of the localization work product was required.',
    `scheduled_delivery_date` DATE COMMENT 'Contractually agreed or planned delivery date for the completed localization work product.',
    `subtitle_format` STRING COMMENT 'Technical format specification for subtitle files (SRT, TTML, WebVTT, etc.). [ENUM-REF-CANDIDATE: SRT|TTML|WebVTT|EBU-STL|SMPTE-TT|SCC|DFXP — 7 candidates stripped; promote to reference product]',
    `target_language_code` STRING COMMENT 'ISO 639 language code for the target localization language (e.g., es-MX for Mexican Spanish, fr-CA for Canadian French).. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `target_territory_code` STRING COMMENT 'ISO 3166 three-letter country code representing the target distribution territory for this localization.. Valid values are `^[A-Z]{3}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this localization record was last modified.',
    `version_number` STRING COMMENT 'Version identifier for this localization work product, supporting iterative revisions and updates.',
    CONSTRAINT pk_localization PRIMARY KEY(`localization_id`)
) COMMENT 'Tracks the localization work product for a specific title version in a target language and territory — covering dubbing, subtitling, metadata translation, and compliance adaptation. Captures localization type (dub/subtitle/metadata/forced-narrative), target language, target territory, localization vendor, delivery date, localization status (ordered/in-progress/delivered/approved/rejected), QC pass flag, subtitle format (SRT/TTML/WebVTT), and dubbing studio reference. Supports multi-territory distribution and regulatory compliance for local-language requirements.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` (
    `identifier_id` BIGINT COMMENT 'Primary key for identifier',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Identifiers like EIDR can be version-specific (different EIDR for theatrical vs broadcast version). Allows version-level identifier tracking.',
    `title_id` BIGINT COMMENT 'Reference to the parent content asset (title, episode, series, film, clip, music track, news segment, or live event) that this identifier is associated with.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this identifier record was first created in the system. Represents the audit trail for record creation.',
    `expiry_date` DATE COMMENT 'The date on which this identifier expires or is no longer valid. Nullable for identifiers that do not expire.',
    `external_reference_url` STRING COMMENT 'A URL or web link to the external registry or system where this identifier can be looked up or verified (e.g., EIDR registry lookup page, ISAN database).',
    `identifier_type` STRING COMMENT 'The type or classification of the identifier. Indicates the issuing authority or system that generated the identifier. [ENUM-REF-CANDIDATE: EIDR|ISAN|ISRC|ISCI|MAM_ID|DISTRIBUTOR_ID|PLATFORM_ID|INTERNAL_ID|VENDOR_ID|RIGHTS_ID|ARCHIVE_ID — promote to reference product]. Valid values are `EIDR|ISAN|ISRC|ISCI|MAM_ID|DISTRIBUTOR_ID`',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this identifier is currently active and in use. Inactive identifiers are retained for historical reference but not used in operational processes.',
    `is_primary` BOOLEAN COMMENT 'Boolean flag indicating whether this identifier is the primary or preferred identifier for the content asset within its type category. Used to prioritize identifiers when multiple exist.',
    `issuing_authority` STRING COMMENT 'The organization, system, or registry that issued or assigned this identifier (e.g., Entertainment Identifier Registry, Dalet Galaxy MAM, distributor name, platform name).',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this identifier record was last modified or updated. Represents the audit trail for record changes.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the identifier. May include information about special handling, known issues, or historical context.',
    `registration_date` DATE COMMENT 'The date on which this identifier was officially registered or assigned to the content asset by the issuing authority.',
    `scope` STRING COMMENT 'The geographic or organizational scope of the identifier. Indicates whether the identifier is globally recognized, region-specific, platform-specific, or internal to the organization.. Valid values are `global|regional|national|internal|platform_specific|distributor_specific`',
    `usage_context` STRING COMMENT 'The primary business context or use case for which this identifier is utilized (e.g., rights clearance, royalty calculation, metadata syndication to downstream platforms, distribution tracking, archival reference).. Valid values are `rights_clearance|royalty_calculation|metadata_syndication|distribution|archival|reporting`',
    `value` DECIMAL(18,2) COMMENT 'The actual identifier string or code assigned to the content asset. This is the unique value issued by the external or internal system (e.g., EIDR ID, ISAN number, ISRC code, MAM asset ID).',
    `verification_date` DATE COMMENT 'The date on which the identifier was last verified or validated against the issuing authority or source system.',
    `verification_status` STRING COMMENT 'The current verification or validation status of the identifier. Indicates whether the identifier has been confirmed as accurate and active by the issuing authority or internal validation process.. Valid values are `verified|pending|failed|expired|revoked|unverified`',
    `version` STRING COMMENT 'Version number or revision indicator for the identifier, if applicable. Used when identifiers are updated or reissued by the authority.',
    CONSTRAINT pk_identifier PRIMARY KEY(`identifier_id`)
) COMMENT 'Stores all external and internal identifiers associated with a title — EIDR, ISAN, ISRC, ISCI, proprietary MAM IDs, distributor IDs, and platform-specific content IDs. Each record captures identifier type, identifier value, issuing authority, registration date, expiry date, and verification status. Enables cross-system content matching, rights clearance, royalty calculation, and metadata syndication to downstream platforms without ambiguity.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` (
    `talent_credit_id` BIGINT COMMENT 'Unique identifier for the talent credit record. Primary key for the talent credit association entity.',
    `content_episode_id` BIGINT COMMENT 'Reference to the specific episode within a series for which the talent is credited. Nullable for non-episodic content such as films or specials.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.talent_contract. Business justification: Credits must link to contracts for residual calculation, compensation verification, guild compliance reporting, and billing position validation. Fundamental to talent payment and rights management pro',
    `role_id` BIGINT COMMENT 'Foreign key linking to talent.talent_role. Business justification: Credits reference specific roles for character attribution, billing position validation, and role-specific residual eligibility. Eliminates denormalized role/character data and ensures single source o',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent master record in the talent domain. Links to the individual or entity receiving credit for their contribution to the content.',
    `title_id` BIGINT COMMENT 'Reference to the content title (film, series, special, documentary) for which the talent is credited. Links to the content master catalog.',
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
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Content acquisition deals create payment obligations to licensors/distributors. AP tracks amounts owed under acquisition agreements for cash flow forecasting, payment scheduling, and vendor relationsh',
    `acquisition_deal_id` BIGINT COMMENT 'Reference to the originating rights deal or contract under which this content was acquired. Links to the master rights agreement.',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Content acquisitions must verify existing ratings or budget for rating submissions (MPAA, TV Parental Guidelines) as part of deal clearance and distribution planning. Links acquisition to rating certi',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Acquisitions often specify which version was acquired (theatrical vs broadcast cut, localized version). This FK allows tracking version-specific acquisition terms and rights.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Acquisition records must reference the underlying license agreement that enabled the acquisition. Financial reconciliation, audit trails, and rights validation require linking acquisitions to their go',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Content acquisition deals require tracking the employee who negotiated and manages the deal for accountability, commission calculation, and workload balancing. Critical for rights management operation',
    `partner_id` BIGINT COMMENT 'Reference to the external party from whom the content was acquired (studio, independent producer, syndicator, distributor, or content aggregator).',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Content acquisition deals generate payable invoices to rights holders. Accounts payable teams track which invoices correspond to acquisition agreements for payment scheduling, rights verification, cos',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Content acquisition deals define licensing terms that determine revenue recognition treatment. Acquired content flows through specific revenue streams based on deal structure (output deals, first-run ',
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
    `territory_scope` STRING COMMENT 'Geographic territories or markets for which the content rights were acquired. May be specified as country codes (ISO 3166), regional groupings, or worldwide. Examples: USA, GBR, North America, EMEA, Worldwide.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this acquisition record was last modified. Audit field for change tracking and data governance.',
    CONSTRAINT pk_acquisition PRIMARY KEY(`acquisition_id`)
) COMMENT 'Transactional record capturing the business event of acquiring content from an external source — studio, independent producer, syndicator, or distributor. Tracks acquisition type (purchase/license/co-production/commission), acquisition date, source party, acquisition cost, currency, content window acquired, territory scope, exclusivity flag, holdback period, acquisition status (negotiating/committed/delivered/cancelled), and originating deal reference. Serves as the financial and operational anchor for content entering the enterprise catalog from external sources.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` (
    `windowing_plan_id` BIGINT COMMENT 'Unique identifier for the windowing plan record. Primary key for the windowing plan entity.',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Windowing plans specify rating requirements for distribution windows. Normalizes rating_code string column to reference the enterprise rating taxonomy.',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Windowing plans are version-specific (theatrical version has different windows than broadcast version). Links distribution strategy to specific version.',
    `coppa_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.coppa_declaration. Business justification: Windowing plans targeting childrens platforms (Nick Jr., Disney+, YouTube Kids) require COPPA compliance declarations before distribution. Links distribution window to child-directed content determin',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Each window has specific DRM requirements based on rights agreements (theatrical requires HDCP 2.2, rental allows offline). DRM policy enforcement varies by window type and revenue model.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Windowing plans specify distribution partners for each window (theatrical exhibitor, streaming platform, broadcast network). Partner performance tracking, holdback enforcement, exclusivity compliance ',
    `encoder_config_id` BIGINT COMMENT 'Foreign key linking to technology.encoder_config. Business justification: Streaming windows use specific encoder profiles for platform-specific delivery. ABR ladder selection, platform certification, and delivery QC require encoder configuration per window. Essential for mu',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Windowing strategies must comply with license agreement terms (holdbacks, exclusivity windows, platform restrictions). Windowing plan validation and conflict detection require checking against the gov',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Each window must map to a specific rights grant that authorizes that exploitation type (SVOD, AVOD, linear broadcast). Clearance systems validate that the windows dates and platform fall within grant',
    `campaign_id` BIGINT COMMENT 'Reference identifier for the marketing campaign associated with this window release. Links to promotional activities, advertising spend, and audience acquisition efforts.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Windowing plans define which platform receives content in each release window (theatrical → premium VOD → SVOD → AVOD). Core to revenue maximization strategy and rights holder agreements.',
    `employee_id` BIGINT COMMENT 'Identifier of the content planning or distribution strategy team member who created this windowing plan. Used for accountability and workflow tracking.',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Windowing plans define how content monetizes across distribution windows (theatrical, SVOD, AVOD, linear). Each window maps to specific revenue streams for ASC 606 performance obligation identificatio',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Windows are territory-specific - geo-blocking, regional release strategies, and regulatory compliance require linking each window to its target territory. Clearance validates territorial rights before',
    `satellite_transponder_id` BIGINT COMMENT 'Foreign key linking to technology.satellite_transponder. Business justification: Linear broadcast windows are delivered via specific satellite transponders. Transmission scheduling, transponder capacity planning, regulatory filings, and uplink coordination require transponder assi',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: Each distribution window may use specific streaming endpoints (regional CDN POPs, premium tier endpoints). Required for geo-restriction enforcement, SLA tier assignment, and CDN cost allocation per wi',
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
    `daypart_restriction` STRING COMMENT 'Time-of-day broadcast restrictions for linear windows, defining when content may air (e.g., prime time only, late night only, daytime safe). Applies primarily to linear broadcast and cable windows.',
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
    `territory_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country or territory code where this windowing plan applies (e.g., USA, GBR, CAN, AUS). Defines geographic scope of the release window.. Valid values are `^[A-Z]{3}$`',
    `viewing_window_hours` STRING COMMENT 'For TVOD/rental windows, the number of hours a viewer has to complete watching the content after initiating playback (e.g., 48-hour rental window).',
    `window_sequence_number` STRING COMMENT 'Sequential ordering of this window within the overall release strategy for the content. Lower numbers indicate earlier windows (e.g., 1=theatrical, 2=SVOD, 3=AVOD).',
    `window_status` STRING COMMENT 'Current lifecycle status of the windowing plan. Planned=initial strategy, Confirmed=approved by stakeholders, Active=currently in release window, Completed=window has closed, Cancelled=window will not execute, Postponed=delayed to future date.. Valid values are `planned|confirmed|active|completed|cancelled|postponed`',
    `window_type` STRING COMMENT 'The distribution window category defining the release channel type. Theatrical=cinema release, SVOD=subscription video on demand, AVOD=advertising-supported video on demand, TVOD=transactional video on demand, Linear Broadcast=traditional scheduled TV, Home Video=physical media, Syndication=content resale to multiple outlets, FAST=free ad-supported streaming television, PPV=pay-per-view, EST=electronic sell-through. [ENUM-REF-CANDIDATE: theatrical|svod|avod|tvod|linear_broadcast|home_video|syndication|fast|vod|ppv|est — 11 candidates stripped; promote to reference product]',
    CONSTRAINT pk_windowing_plan PRIMARY KEY(`windowing_plan_id`)
) COMMENT 'Defines the content-side release sequencing strategy for a title across distribution channels — theatrical, SVOD, AVOD, TVOD, linear broadcast, home video, and syndication. Each record captures window type, platform/channel, territory, planned open date, planned close date, holdback duration, exclusivity tier, and window status. Represents the content teams intended release plan that feeds into the rights domain for contractual enforcement and the distribution domain for operational execution. Distinct from rights windows (which are contractual) — this is the editorial/commercial planning artifact.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` (
    `lifecycle_event_id` BIGINT COMMENT 'Primary key for lifecycle_event',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Content lifecycle transitions (ingest, QC, archive) occur at specific facilities. Audit trails, compliance reporting, operational metrics, and facility performance dashboards require facility attribut',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Lifecycle events track version-specific status transitions (version approved for broadcast, version archived). Critical for version-level workflow tracking.',
    `employee_id` BIGINT COMMENT 'The system identifier of the user who initiated or approved this lifecycle transition. Used for accountability and audit purposes.',
    `title_id` BIGINT COMMENT 'Reference to the content asset (title, episode, series, film, clip, music, news segment, or live event) undergoing this lifecycle transition.',
    `automated_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle transition was triggered automatically by the workflow system (True) or manually by a user (False).',
    `blocking_condition` STRING COMMENT 'Any condition, issue, or dependency that is blocking or delaying the content from progressing to the next lifecycle stage (e.g., pending rights clearance, QC failure, missing metadata, technical issue). Null if no blocking condition exists.',
    `blocking_resolved_flag` BOOLEAN COMMENT 'Indicates whether any previously identified blocking condition has been resolved. True if resolved, False if still blocking, Null if no blocking condition was present.',
    `compliance_checkpoint_passed` BOOLEAN COMMENT 'Indicates whether all regulatory and compliance checkpoints required for this lifecycle stage were successfully passed (e.g., content rating verification, rights clearance, broadcast standards review). True if passed, False if failed, Null if not applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this lifecycle event record was first created in the system. Audit field for data lineage and record provenance.',
    `delivery_platform` STRING COMMENT 'The target delivery platform or distribution channel for which this lifecycle stage is being prepared (e.g., Linear Broadcast, OTT, VOD, SVOD, AVOD, Theatrical, Syndication). Applicable primarily for distribution-related lifecycle stages.',
    `event_sequence_number` STRING COMMENT 'The sequential order of this lifecycle event within the complete lifecycle history of the content asset. Used to reconstruct the chronological audit trail.',
    `lifecycle_stage` STRING COMMENT 'The operational lifecycle stage of the content asset at the time of this event. Represents the major phase in the content workflow from acquisition through archival. [ENUM-REF-CANDIDATE: acquisition|commission|development|pre_production|production|post_production|clearance|mastering|distribution|archival|retired — 11 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this lifecycle event record was last modified. Audit field for tracking updates to the event record.',
    `new_status` STRING COMMENT 'The status of the content asset immediately after this lifecycle transition. Represents the current state following the event.',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the responsible user or system regarding this lifecycle transition. Captures context, issues, or special handling instructions.',
    `previous_status` STRING COMMENT 'The status of the content asset immediately before this lifecycle transition. Captures the prior state for audit trail and provenance.',
    `qc_status` STRING COMMENT 'The quality control review status associated with this lifecycle transition. Indicates whether technical and editorial quality standards were met.. Valid values are `passed|failed|pending|not_required|conditional_pass`',
    `responsible_team` STRING COMMENT 'The business unit, department, or team responsible for executing or approving this lifecycle transition (e.g., Production, Post-Production, Rights Management, Quality Control, Distribution).',
    `rollback_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event represents a rollback to a previous stage due to failure, rejection, or rework requirement. True if rollback, False for forward progression.',
    `rollback_reason` STRING COMMENT 'The reason or justification for rolling back the content to a previous lifecycle stage. Null if rollback_flag is False.',
    `sla_actual_date` DATE COMMENT 'The actual date when this lifecycle stage was completed. Used to measure SLA compliance by comparing against sla_target_date.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle transition breached the defined SLA target. True if actual date exceeded target date, False otherwise.',
    `sla_target_date` DATE COMMENT 'The target date by which this lifecycle stage should be completed, as defined by internal SLA or contractual delivery commitment. Used for SLA monitoring and performance tracking.',
    `system_source` STRING COMMENT 'The name of the source system or module that generated this lifecycle event record (e.g., Dalet Galaxy, Ericsson MediaFirst, Rightsline, manual entry).',
    `transition_duration_hours` DECIMAL(18,2) COMMENT 'The elapsed time in hours between the previous lifecycle event and this event. Measures the duration spent in the previous stage. Used for operational efficiency analysis.',
    `transition_timestamp` TIMESTAMP COMMENT 'The precise date and time when the lifecycle stage transition occurred. This is the business event timestamp, distinct from audit timestamps.',
    `triggered_by_event` STRING COMMENT 'The specific event or action that triggered this lifecycle transition (e.g., QC approval, rights clearance, ingest completion, delivery confirmation, manual override).',
    `version_number` STRING COMMENT 'The version identifier of the content asset at the time of this lifecycle event. Tracks iterations, edits, and revisions through the production and post-production workflow.',
    `workflow_instance_code` STRING COMMENT 'The unique identifier of the workflow instance in the Media Asset Management (MAM) system that orchestrated this lifecycle transition. Links to Dalet Galaxy workflow execution.',
    CONSTRAINT pk_lifecycle_event PRIMARY KEY(`lifecycle_event_id`)
) COMMENT 'Transactional audit trail of status transitions for a title through its operational lifecycle — from acquisition/commission through production, post-production, clearance, mastering, distribution, and archival. Each record captures the lifecycle stage, transition date, triggered-by event, responsible team, previous status, new status, and any blocking conditions. Enables operational tracking of content readiness, supports SLA monitoring for delivery commitments, and provides a complete provenance trail for compliance and audit purposes.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` (
    `content_clearance_id` BIGINT COMMENT 'Unique identifier for the content clearance record. Primary key for the content clearance entity.',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Rights clearances are version-specific (theatrical version may have different music rights than broadcast version). Critical for version-level rights management.',
    `employee_id` BIGINT COMMENT 'Reference to the clearance officer or rights specialist responsible for verifying and approving this clearance. Links to the talent or employee master data.',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Clearance is territory-specific - must validate that territorial rights exist for the intended broadcast/distribution territory. Geo-blocking and regulatory compliance depend on this link.',
    `title_id` BIGINT COMMENT 'Reference to the content asset (title, episode, series, film, clip, music, news segment, or live event) that is subject to clearance verification. Links to the master content catalog.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Clearance requests validate against license agreement terms before approving content for air. Automated clearance systems check holdbacks, exclusivity, and platform restrictions defined in the agreeme',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Clearance validates specific grant permissions (run counts, platforms, dates, territories). Automated clearance workflows check that the requested exploitation falls within an active grants scope.',
    `windowing_plan_id` BIGINT COMMENT 'Foreign key linking to content.windowing_plan. Business justification: Clearances are tied to specific distribution windows (theatrical, SVOD, linear broadcast). Links clearance verification to the intended window.',
    `blocking_reason` STRING COMMENT 'Detailed explanation of why the clearance was blocked or denied. Captures the specific legal, contractual, or rights-related issue preventing broadcast or distribution.',
    `broadcast_ready_flag` BOOLEAN COMMENT 'Boolean indicator of whether the content has passed all clearance requirements and is approved for broadcast or distribution. True indicates the content is ready; false indicates clearance is incomplete or blocked.',
    `clearance_date` DATE COMMENT 'Date when the clearance was officially approved and the content was deemed ready for broadcast or distribution. Null if clearance has not yet been granted.',
    `clearance_status` STRING COMMENT 'Current state of the clearance verification process. Indicates whether the content has been approved for broadcast/distribution, is awaiting approval, has been denied, or requires conditional approval.. Valid values are `pending|cleared|blocked|conditional|expired|waived`',
    `clearance_type` STRING COMMENT 'Category of rights clearance being verified. Identifies the specific type of intellectual property or usage right that requires clearance before broadcast or distribution. [ENUM-REF-CANDIDATE: music_sync|music_master_use|talent_residuals|third_party_footage|archive_clips|stock_footage|trademark|logo|product_placement — 9 candidates stripped; promote to reference product]',
    `conditional_terms` STRING COMMENT 'Specific conditions or restrictions attached to the clearance approval. Examples include geographic blackouts, time-of-day restrictions, or required attribution statements.',
    `contract_reference` STRING COMMENT 'Reference to the underlying rights contract or licensing agreement that governs this clearance. Links to the contract management system for full terms and conditions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the clearance record was first created in the system. Supports audit trail and data lineage tracking.',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator of whether the clearance request has been escalated to senior management or legal counsel due to complexity, cost, or urgency. True indicates escalation is active.',
    `expiry_date` DATE COMMENT 'Date when the clearance approval expires and the content can no longer be broadcast or distributed without re-clearance. Supports windowing and holdback strategies.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Monetary amount paid or payable to the rights holder for clearance approval. Represents the cost of securing the right to use the intellectual property in the specified territory, platform, and window.',
    `fee_currency` STRING COMMENT 'Three-letter ISO currency code for the clearance fee amount. Supports multi-currency rights transactions.. Valid values are `^[A-Z]{3}$`',
    `intended_platform` STRING COMMENT 'Target platform or distribution channel for which the clearance is being verified. Clearance requirements vary by platform due to different rights agreements and territorial restrictions. [ENUM-REF-CANDIDATE: linear_broadcast|svod|avod|tvod|fast|ott|theatrical|home_video|syndication — 9 candidates stripped; promote to reference product]',
    `intended_territory` STRING COMMENT 'Geographic territory or market for which the clearance is being verified, represented as a three-letter ISO country code. Rights clearance is often territory-specific due to licensing agreements.. Valid values are `^[A-Z]{3}$`',
    `intended_window` STRING COMMENT 'Sequential release window for which the clearance is being verified. Windowing strategy determines when and where content can be distributed, and clearance requirements differ by window. [ENUM-REF-CANDIDATE: theatrical|home_video|pay_per_view|premium_cable|basic_cable|broadcast|streaming|syndication — 8 candidates stripped; promote to reference product]',
    `legal_review_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the clearance requires formal legal review before approval. True indicates legal counsel must review and sign off on the clearance.',
    `notes` STRING COMMENT 'Free-text notes and comments related to the clearance process. Captures additional context, negotiation history, or special instructions for scheduling and distribution teams.',
    `priority` STRING COMMENT 'Priority level assigned to the clearance request. Urgent and high-priority clearances are expedited to meet tight broadcast schedules or upfront commitments.. Valid values are `urgent|high|normal|low`',
    `reference_number` STRING COMMENT 'Business identifier for the clearance verification process. Externally-known unique code used for tracking and communication with rights holders, legal teams, and clearance officers.. Valid values are `^CLR-[A-Z0-9]{8,12}$`',
    `request_date` DATE COMMENT 'Date when the clearance verification request was initiated. Marks the beginning of the clearance workflow and is used to track turnaround time and service level agreement (SLA) compliance.',
    `rights_holder_contact` STRING COMMENT 'Primary contact information (email, phone, or address) for the rights holder. Used for clearance negotiation and communication.',
    `rights_holder_name` STRING COMMENT 'Name of the individual or organization that holds the intellectual property rights requiring clearance. May be a music publisher, talent agent, stock footage provider, or other rights owner.',
    `sla_target_date` DATE COMMENT 'Target date by which the clearance must be completed to meet scheduling and distribution commitments. Used to track SLA compliance and escalate overdue clearances.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the clearance record was last modified. Supports audit trail and change tracking for compliance and operational monitoring.',
    CONSTRAINT pk_content_clearance PRIMARY KEY(`content_clearance_id`)
) COMMENT 'Tracks the rights clearance verification process for a title prior to broadcast or distribution — confirming that all necessary rights (music sync, master use, talent residuals, third-party footage, archive clips) have been cleared for the intended platform, territory, and window. Captures clearance type, clearance status (pending/cleared/blocked/conditional), clearance date, blocking reason, responsible clearance officer, and clearance expiry. Directly supports the Clearance business process and feeds the scheduling and distribution domains with broadcast-readiness signals.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` (
    `metadata_profile_id` BIGINT COMMENT 'Unique identifier for the metadata profile record. Primary key.',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Metadata profiles delivered to distribution platforms (Netflix, Hulu, linear broadcast) must include certified content rating for parental control systems and regulatory display requirements. Links pr',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Metadata profiles are version-specific (different metadata for theatrical vs broadcast version, localized versions). Links metadata delivery to specific version.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Metadata profiles require employee accountability for quality control, audit trails, and platform compliance. Broadcasting operations need to track who created/modified metadata for error resolution a',
    `encoder_config_id` BIGINT COMMENT 'Foreign key linking to technology.encoder_config. Business justification: Metadata profiles are encoder-specific; different platforms require different encoding + metadata combinations. Delivery validation, platform certification, and QC workflows require encoder linkage. E',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Metadata profiles are formatted for specific platform ingestion specs (Netflix TDF, iTunes XML, Roku feed). Each platform has unique metadata schema, image specs, and validation rules for content cata',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Metadata packages for platform delivery often include preview clips or thumbnail assets. Distribution systems require linking metadata profiles to their associated preview/promo assets for bundled del',
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
    `distributor` STRING COMMENT 'Name of the distributor responsible for delivering the content to platforms and audiences. Used for rights management and business intelligence.',
    `episode_number` STRING COMMENT 'Episode number within a series or season, if applicable. Used for episodic content organization in EPG (Electronic Program Guide) and streaming platforms.',
    `expiration_date` DATE COMMENT 'Date on which this metadata profile expires or is no longer valid for the target platform. Used for metadata lifecycle management and rights windowing.',
    `genre_classification` STRING COMMENT 'Genre or category classification specific to the target platform. May differ from the master title genre to align with platform-specific taxonomies (e.g., Netflix genres vs. broadcast EPG genres).',
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
    `season_number` STRING COMMENT 'Season number within a series, if applicable. Used for episodic content organization in EPG (Electronic Program Guide) and streaming platforms.',
    `short_synopsis` STRING COMMENT 'Brief narrative description of the content title. Typically 50-150 words, used for EPG (Electronic Program Guide) listings, mobile apps, and quick reference.',
    `thumbnail_url` STRING COMMENT 'URL (Uniform Resource Locator) to the thumbnail image associated with this metadata profile. Used for EPG (Electronic Program Guide) display, streaming platform UI, and promotional materials.',
    `trailer_url` STRING COMMENT 'URL (Uniform Resource Locator) to the trailer or preview video associated with this content. Used for promotional campaigns and streaming platform previews.',
    `validation_errors` STRING COMMENT 'Detailed list of validation errors or warnings encountered during metadata quality checks. Used for troubleshooting and metadata remediation.',
    `validation_status` STRING COMMENT 'Result of automated or manual validation checks against the target metadata standard. Indicates whether the profile meets all required schema and business rules.. Valid values are `pending|passed|failed|warning`',
    `version_number` STRING COMMENT 'Version number of this metadata profile. Incremented with each update to track metadata evolution and support rollback if needed.',
    CONSTRAINT pk_metadata_profile PRIMARY KEY(`metadata_profile_id`)
) COMMENT 'Stores the full descriptive metadata set for a title as delivered to a specific platform or metadata standard — EPG, streaming platform, MVPD, search index, or press/publicity. Captures metadata standard (EIDR/Dublin Core/EBUCore/TVAnytime/schema.org), target platform, long synopsis, short synopsis, keyword tags, cast summary, director credit, production company, distributor, promotional tagline, metadata language, delivery date, and validation status. Enables platform-specific metadata packaging without polluting the core title master record.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` (
    `artwork_id` BIGINT COMMENT 'Unique identifier for the artwork asset record. Primary key for the artwork catalog.',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Artwork is often version-specific (theatrical poster vs TV key art, localized artwork with different ratings/text). Links artwork to the specific version it represents.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Artwork ingestion and approval requires employee tracking for rights clearance accountability, quality control, and creative approval workflows. Critical for resolving copyright disputes and tracking ',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Artwork files (posters, thumbnails, key art) are managed media assets in DAM systems. Asset lifecycle management, storage tier assignment, and delivery workflows require linking artwork records to the',
    `title_id` BIGINT COMMENT 'Reference to the content title (series, film, episode, or other content asset) that this artwork represents. Links artwork to the master content catalog.',
    `approval_date` DATE COMMENT 'Date on which the artwork received final approval for distribution and use. Marks the transition from draft/review to production-ready status. Format: yyyy-MM-dd.',
    `approved_for_use_flag` BOOLEAN COMMENT 'Boolean indicator of whether the artwork has passed legal, brand, and creative approval processes and is authorized for public distribution. True indicates approved and ready for use, False indicates pending approval or rejected.',
    `archive_location` STRING COMMENT 'Physical or logical storage location identifier for the high-resolution master artwork file in the enterprise archive system. May reference tape library, cloud object storage bucket, or network-attached storage (NAS) path. Supports long-term preservation and disaster recovery.',
    `artwork_type` STRING COMMENT 'Classification of the artwork asset by its intended use and format. Key-art is primary promotional image, thumbnail for Electronic Program Guide (EPG) and streaming UI, banner for web headers, poster for theatrical/retail, logo for branding, still for scene captures.. Valid values are `key-art|thumbnail|banner|poster|logo|still`',
    `aspect_ratio` STRING COMMENT 'Proportional relationship between width and height of the artwork. 16:9 for widescreen HD, 4:3 for standard definition, 1:1 for square social media, 2:3 for portrait poster, 3:4 for mobile portrait, 21:9 for ultra-widescreen, 9:16 for vertical mobile video. [ENUM-REF-CANDIDATE: 16:9|4:3|1:1|2:3|3:4|21:9|9:16 — 7 candidates stripped; promote to reference product]',
    `color_profile` STRING COMMENT 'Color space standard applied to the artwork for accurate color reproduction across devices and platforms. sRGB for web/digital, Adobe RGB for professional photography, CMYK for print, Rec. 709 for HD broadcast, Rec. 2020 for Ultra HD (UHD) broadcast.. Valid values are `sRGB|Adobe RGB|ProPhoto RGB|CMYK|Rec. 709|Rec. 2020`',
    `content_rating_displayed_flag` BOOLEAN COMMENT 'Boolean indicator of whether the artwork includes a visible Motion Picture Association (MPA) or equivalent content rating badge (G, PG, PG-13, R, NC-17, TV-Y, TV-PG, TV-14, TV-MA). True indicates rating is burned into the image, False indicates clean artwork without rating overlay.',
    `copyright_holder` STRING COMMENT 'Legal entity or organization that owns the copyright to the artwork asset. May be the production company, studio, distributor, or external agency. Critical for rights clearance and syndication.',
    `copyright_year` STRING COMMENT 'Year in which the artwork was created and copyright was established. Used for copyright notice display and rights duration calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the artwork record was first created in the enterprise catalog system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage tracking.',
    `eidr` STRING COMMENT 'Universal unique identifier from the Entertainment Identifier Registry for the associated content title. Enables global interoperability and metadata exchange across distribution partners, rights holders, and platforms.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `expiry_date` DATE COMMENT 'Date on which the artwork rights or usage authorization expires and the asset should no longer be used for promotional or distribution purposes. Supports rights management and holdback compliance. Nullable for perpetual-use artwork. Format: yyyy-MM-dd.',
    `file_format` STRING COMMENT 'Image file format of the artwork asset. JPEG for compressed photos, PNG for transparency support, TIFF for high-resolution archival, PSD for Adobe Photoshop source files, SVG for vector graphics, WebP for modern web delivery.. Valid values are `JPEG|PNG|TIFF|PSD|SVG|WebP`',
    `file_size_bytes` BIGINT COMMENT 'Storage size of the artwork file measured in bytes. Used for Content Delivery Network (CDN) optimization, bandwidth planning, and storage capacity management.',
    `height_pixels` STRING COMMENT 'Vertical dimension of the artwork image measured in pixels. Used to determine display suitability and resolution quality for various distribution channels.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language of any text overlay or localization present in the artwork. Used for multi-territory distribution and localization workflows.. Valid values are `^[a-z]{2}$`',
    `language_overlay_flag` BOOLEAN COMMENT 'Boolean indicator of whether the artwork contains burned-in text, titles, or language-specific graphic elements. True indicates localized artwork requiring territory-specific versions, False indicates language-neutral artwork suitable for all markets.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the artwork record was last updated or modified in the enterprise catalog system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for change tracking and synchronization workflows.',
    `photographer_credit` STRING COMMENT 'Name or attribution of the photographer, artist, or creative agency responsible for creating the artwork. Used for copyright attribution, residuals tracking, and legal compliance with talent agreements.',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the preferred display order or priority of this artwork when multiple artwork assets exist for the same title and type. Lower numbers indicate higher priority. Used by Electronic Program Guide (EPG) and streaming platform UI to select the primary artwork.',
    `resolution_dpi` STRING COMMENT 'Image resolution measured in dots per inch. 72 DPI for web/screen display, 300 DPI for high-quality print, 150 DPI for standard print. Critical for determining print suitability and image quality.',
    `source_system_code` STRING COMMENT 'Unique identifier or reference key for the artwork asset in the originating source system. Enables traceability and synchronization with upstream Digital Asset Management (DAM) or creative management platforms.',
    `territory_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the geographic territory for which this artwork is approved and licensed. Supports windowing and territorial rights management strategies.. Valid values are `^[A-Z]{3}$`',
    `title` STRING COMMENT 'Human-readable descriptive title or label for the artwork asset. Used for internal cataloging and search within the Media Asset Management (MAM) system.',
    `usage_rights` STRING COMMENT 'Scope of authorized usage channels and media types for the artwork. All-media for unrestricted use, digital-only for Over-The-Top (OTT) and web, print-only for press kits and retail, broadcast-only for linear television, theatrical-only for cinema, promotional-only for advertising and marketing campaigns.. Valid values are `all-media|digital-only|print-only|broadcast-only|theatrical-only|promotional-only`',
    `width_pixels` STRING COMMENT 'Horizontal dimension of the artwork image measured in pixels. Used to determine display suitability and resolution quality for various distribution channels.',
    CONSTRAINT pk_artwork PRIMARY KEY(`artwork_id`)
) COMMENT 'Master catalog of promotional and editorial artwork assets associated with a title — key art, thumbnail images, banner graphics, poster images, and logo treatments. Captures artwork type (key-art/thumbnail/banner/poster/logo/still), image dimensions, aspect ratio, file format, color profile, territory applicability, language overlay flag, approved-for-use flag, approval date, expiry date, and source system reference (Dalet Galaxy DAM). Supports EPG display, streaming platform UI, press kits, and advertising creative without duplicating the binary asset record owned by the digital asset domain.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`tag` (
    `tag_id` BIGINT COMMENT 'Primary key for tag',
    `parent_tag_id` BIGINT COMMENT 'Reference to a parent tag in a hierarchical taxonomy structure. Enables multi-level tag classification (e.g., Action as parent, Car Chase as child). Null for top-level tags.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that applied this tag. Supports audit trails and editorial accountability. May reference internal staff, partner systems, or automated processes.',
    `taxonomy_id` BIGINT COMMENT 'External identifier linking this tag to a standardized industry taxonomy or controlled vocabulary system (e.g., IAB Content Taxonomy, Gracenote Video Descriptors, EIDR Content Identifiers). Enables interoperability and consistent metadata across platforms.',
    `title_id` BIGINT COMMENT 'Reference to the content title (film, series, episode, clip, music track, news segment, or live event) to which this tag is applied.',
    `advertiser_safe` BOOLEAN COMMENT 'Indicates whether content with this tag is suitable for advertising placement according to brand safety guidelines. False may indicate sensitive or controversial content that requires restricted ad inventory.',
    `applied_date` DATE COMMENT 'Date when the tag was first applied to the content asset. Tracks the temporal evolution of content metadata and editorial curation.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Confidence level for algorithmically-generated tags, expressed as a decimal between 0.0000 and 1.0000. A score of 1.0000 indicates highest confidence. Null for manually-applied editorial tags.',
    `coppa_compliant` BOOLEAN COMMENT 'Indicates whether this tag and its associated content comply with COPPA regulations for childrens content. True indicates the tag is appropriate for content directed at children under 13.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tag record was first created in the system. Supports audit trails and data lineage tracking.',
    `expiry_date` DATE COMMENT 'Date when the tag assignment expires or is no longer valid. Used for time-bound campaign tags, seasonal collections, or promotional initiatives. Null for permanent tags.',
    `hierarchy_level` STRING COMMENT 'Depth level of this tag within a hierarchical taxonomy structure. Level 1 represents top-level categories, with increasing numbers indicating deeper nesting. Supports faceted navigation and drill-down discovery.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the tag is currently active and should be used in content discovery, recommendation engines, and advertising contextual targeting. False indicates the tag has been deprecated or removed.',
    `is_displayable` BOOLEAN COMMENT 'Indicates whether this tag should be displayed to end users in content detail pages, Electronic Program Guides (EPG), or Over-The-Top (OTT) platform interfaces. Some tags are for backend analytics only.',
    `is_searchable` BOOLEAN COMMENT 'Indicates whether this tag should be indexed and surfaced in user-facing search interfaces. Some tags may be used for internal classification or algorithmic purposes only.',
    `language` STRING COMMENT 'ISO 639-2/T three-letter language code indicating the language in which the tag value is expressed. Supports multilingual tagging for international content catalogs.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tag record was last modified. Tracks the evolution of tag metadata and supports change data capture processes.',
    `review_date` DATE COMMENT 'Date when the tag assignment was reviewed by editorial staff. Null if no review has occurred.',
    `review_notes` STRING COMMENT 'Free-text notes or comments from the editorial reviewer regarding the tag assignment. May include rationale for approval or rejection, suggested alternatives, or quality feedback.',
    `review_status` STRING COMMENT 'Editorial review and approval status for the tag assignment. Supports quality control workflows where algorithmically-generated or partner-supplied tags require human validation before publication.. Valid values are `pending|approved|rejected|under_review`',
    `source` STRING COMMENT 'Origin of the tag assignment. Indicates whether the tag was applied by internal editorial staff, generated by machine learning algorithms, provided by a content partner or rights holder, contributed by users, or supplied by the production team.. Valid values are `editorial|algorithmic|partner|user_generated|rights_holder|production`',
    `tag_type` STRING COMMENT 'Category of the tag applied to the content. Defines the semantic purpose of the tag (e.g., mood for emotional tone, theme for subject matter, setting for location context, era for time period, franchise for brand universe, content_warning for viewer advisories, editorial_collection for curated groupings, campaign for promotional initiatives). [ENUM-REF-CANDIDATE: mood|theme|setting|era|franchise|universe|content_warning|editorial_collection|campaign|keyword — 10 candidates stripped; promote to reference product]',
    `taxonomy_version` STRING COMMENT 'Version number of the external taxonomy or controlled vocabulary system referenced by taxonomy_id. Tracks schema evolution and ensures backward compatibility.',
    `usage_context` STRING COMMENT 'Primary business context or application domain for which this tag is intended. Defines how the tag should be leveraged across the content lifecycle (e.g., recommendation engines, contextual advertising targeting, editorial curation, regulatory compliance reporting).. Valid values are `recommendation|search|advertising|editorial|analytics|compliance`',
    `value` DECIMAL(18,2) COMMENT 'The specific controlled vocabulary term or label applied to the content. Examples: suspenseful, family-friendly, urban, 1980s, Marvel Cinematic Universe, violence, holiday-special, summer-blockbuster.',
    `weight` DECIMAL(18,2) COMMENT 'Relative importance or prominence of this tag for the content asset, expressed as a decimal between 0.0000 and 1.0000. Higher weights indicate more central or defining characteristics. Used to prioritize tags in recommendation and discovery algorithms.',
    CONSTRAINT pk_tag PRIMARY KEY(`tag_id`)
) COMMENT 'Flexible editorial and operational tagging of titles with controlled vocabulary terms beyond genre — mood, theme, setting, era, franchise, universe, content warning, editorial collection, and campaign tag. Each record captures tag type, tag value, tag source (editorial/algorithmic/partner), confidence score for algorithmic tags, applied date, and active status. Powers content discovery, recommendation engines, advertising contextual targeting, and editorial curation across OTT and linear platforms.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` (
    `ingest_event_id` BIGINT COMMENT 'Unique identifier for the content ingest event. Primary key for the ingest_event product.',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Ingest events create or update specific versions. Links the ingest operation to the version record it produced or modified.',
    `employee_id` BIGINT COMMENT 'The user or system account that initiated or supervised the ingest operation. Used for operational audit and accountability.',
    `encoder_config_id` BIGINT COMMENT 'Foreign key linking to technology.encoder_config. Business justification: Ingest events trigger encoding workflows. Automated transcode job tracking, QC pipelines, and delivery validation require linking ingest to specific encoder configurations. Essential for end-to-end wo',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Ingest operations occur at specific facilities with dedicated ingest infrastructure. Operational dashboards, capacity planning, SLA tracking, and facility performance metrics require facility attribut',
    `media_asset_id` BIGINT COMMENT 'The unique identifier of the digital asset created in the MAM (Media Asset Management) system as a result of this ingest. Null if ingest failed before asset creation.',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: Ingest events for live/near-live content target specific streaming endpoints for immediate distribution. Required for live sports, news, and event streaming where ingest directly feeds distribution wi',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Third-party vendors deliver content for ingest. Delivery acceptance tracking, technical QC dispute resolution, redelivery cost allocation, and vendor performance scorecarding require partner attributi',
    `title_id` BIGINT COMMENT 'Reference to the content title that was ingested. Links to the master content catalog.',
    `archive_location` STRING COMMENT 'The storage tier or archive location where the ingested content was placed (e.g., online storage, nearline, deep archive, tape library identifier).',
    `audio_description_detected_flag` BOOLEAN COMMENT 'Indicates whether an audio description track for visually impaired audiences was detected in the ingested content. True if audio description present, False otherwise.',
    `automated_qc_result` STRING COMMENT 'The outcome of automated quality control checks performed during or immediately after ingest (e.g., technical compliance, audio/video sync, black frames, silence detection).. Valid values are `pass|fail|warning|not_performed`',
    `checksum_md5` STRING COMMENT 'MD5 hash of the ingested file for integrity verification and duplicate detection. Calculated at ingest time.. Valid values are `^[a-f0-9]{32}$`',
    `checksum_sha256` STRING COMMENT 'SHA-256 hash of the ingested file for enhanced integrity verification and forensic audit. Calculated at ingest time.. Valid values are `^[a-f0-9]{64}$`',
    `closed_caption_detected_flag` BOOLEAN COMMENT 'Indicates whether closed caption or subtitle tracks were detected in the ingested content. True if captions present, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this ingest event record was first created in the data system. Used for audit trail and data lineage tracking.',
    `delivery_method` STRING COMMENT 'The specific protocol or service used for content delivery (e.g., Aspera, FTP, SFTP, AWS S3, physical courier). Provides additional detail beyond ingest_source_type.',
    `ingest_completion_timestamp` TIMESTAMP COMMENT 'The date and time when the ingest operation reached a terminal state (completed, failed, or cancelled). Null for in-progress operations.',
    `ingest_error_code` STRING COMMENT 'Machine-readable error code generated when the ingest operation fails. Null for successful ingests.',
    `ingest_error_description` STRING COMMENT 'Human-readable description of the failure reason when ingest status is failed or quarantined. Null for successful ingests.',
    `ingest_job_number` STRING COMMENT 'Externally-known unique job identifier assigned by the MAM (Media Asset Management) system for tracking and audit purposes.. Valid values are `^[A-Z0-9]{8,20}$`',
    `ingest_source_location` STRING COMMENT 'The physical or logical location from which the content was ingested (e.g., file path, tape library slot, satellite feed identifier, cloud bucket URI).',
    `ingest_source_type` STRING COMMENT 'The delivery mechanism or medium through which the content was received into the MAM (Media Asset Management) system. [ENUM-REF-CANDIDATE: tape|file|satellite|ip_stream|cloud|ftp|aspera|physical_media — 8 candidates stripped; promote to reference product]',
    `ingest_status` STRING COMMENT 'Current lifecycle status of the ingest operation. Tracks progression from queued through completion or failure states.. Valid values are `queued|in_progress|completed|failed|quarantined|cancelled`',
    `ingest_timestamp` TIMESTAMP COMMENT 'The date and time when the content ingest operation was initiated. Represents the principal business event time for this transaction.',
    `ingest_workflow_code` STRING COMMENT 'Reference to the specific workflow template or automation rule that governed this ingest operation in the MAM (Media Asset Management) system.',
    `metadata_package_received_flag` BOOLEAN COMMENT 'Indicates whether accompanying metadata (EIDR, ISAN, descriptive metadata, rights information) was received with the media file. True if metadata was included, False otherwise.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this ingest event record was last updated. Tracks status changes and data corrections throughout the ingest lifecycle.',
    `priority_level` STRING COMMENT 'The processing priority assigned to this ingest operation. Determines queue position and resource allocation for time-sensitive content.. Valid values are `urgent|high|normal|low`',
    `qc_error_code` STRING COMMENT 'Machine-readable error code generated by the automated QC system when issues are detected. Null if QC passed or was not performed.',
    `qc_error_description` STRING COMMENT 'Human-readable description of quality control issues detected during ingest. Null if QC passed or was not performed.',
    `retry_count` STRING COMMENT 'The number of times this ingest operation has been retried after initial failure. Zero for first-attempt ingests.',
    `source_aspect_ratio` STRING COMMENT 'The aspect ratio of the ingested video content (e.g., 16:9, 4:3, 21:9). Null for audio-only content.',
    `source_audio_channels` STRING COMMENT 'The number of audio channels in the ingested content (e.g., 2 for stereo, 6 for 5.1 surround). Null for video-only content.',
    `source_audio_codec` STRING COMMENT 'The audio codec used in the ingested content (e.g., AAC, AC-3, PCM, Dolby Digital). Null for video-only content.',
    `source_duration_seconds` DECIMAL(18,2) COMMENT 'The runtime duration of the ingested media content in seconds. Null for still images or non-time-based assets.',
    `source_file_size_bytes` BIGINT COMMENT 'The size of the ingested media file in bytes. Used for storage planning, bandwidth analysis, and integrity verification.',
    `source_format` STRING COMMENT 'The technical format and codec of the ingested media file (e.g., MPEG-4, ProRes, MXF, H.264, HEVC). Captured as received before any transcoding.',
    `source_frame_rate` DECIMAL(18,2) COMMENT 'The frame rate of the ingested video content in frames per second (e.g., 23.976, 25.000, 29.970, 59.940). Null for audio-only content.',
    `source_resolution` STRING COMMENT 'The video resolution of the ingested content (e.g., 1920x1080, 3840x2160, 1280x720). Null for audio-only content.',
    CONSTRAINT pk_ingest_event PRIMARY KEY(`ingest_event_id`)
) COMMENT 'Transactional record of each content ingest operation — capturing the arrival of a new media file or metadata package into the enterprise MAM system (e.g., Dalet Galaxy). Tracks ingest source (tape/file/satellite/IP/cloud), ingest timestamp, ingest operator, source format, file size, ingest status (queued/in-progress/completed/failed/quarantined), automated QC result, error description, and resulting asset reference. Provides the operational audit trail for content entering the enterprise from production, acquisition, or third-party delivery and triggers downstream lifecycle events.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`package` (
    `package_id` BIGINT COMMENT 'Primary key for package',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Packages have content rating (highest rating of included titles). Normalizes content_rating string column to reference the enterprise rating taxonomy.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Content packages represent syndication and licensing deals requiring employee accountability for deal structuring, approval workflows, and commission tracking. Critical for sales operations and rights',
    `distribution_partner_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_partner. Business justification: Packages are sold to distribution partners (cable operators, MVPD aggregators, international distributors). Package-level licensing agreements and carriage fees are negotiated at partner level for bul',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Packages have primary genre classification. Normalizes genre_primary string column to reference the enterprise genre taxonomy.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Content packages (e.g., Summer Action Bundle, Kids Library) are licensed as units to distributors. Package-level royalty calculations and clearance workflows require linking packages to their gove',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Content packages are sold as bundled offerings in syndication, international distribution, and SVOD licensing. Real business process: package-level deal tracking where multiple titles are sold togethe',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Content packages (bundles, collections) are licensed to specific platforms. Package-level deals are common in SVOD (entire studio catalog to Netflix) and require platform-specific availability trackin',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Content packages (bundles sold to distributors/platforms) represent distinct revenue streams with specific recognition patterns. Package deals require revenue allocation across titles and performance ',
    `audio_description_available_flag` BOOLEAN COMMENT 'Indicates whether audio description tracks are available for the majority of content in the package (True/False). Required for accessibility compliance.',
    `closed_caption_available_flag` BOOLEAN COMMENT 'Indicates whether closed captioning is available for the majority of content in the package (True/False). Required for FCC compliance and accessibility standards.',
    `package_code` STRING COMMENT 'The externally-known unique business identifier or code for the package used in contracts, invoicing, and distribution systems.',
    `commercial_context` STRING COMMENT 'Free-text description of the business purpose or deal context for which the package was assembled, such as upfront sales event, scatter market offering, MVPD (Multichannel Video Programming Distributor) carriage negotiation, or international syndication deal.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the package record was first created in the system. Used for audit trail and data lineage.',
    `package_description` STRING COMMENT 'A detailed narrative description of the package content, target audience, and commercial positioning. Used for marketing, sales proposals, and catalog listings.',
    `drm_required_flag` BOOLEAN COMMENT 'Indicates whether Digital Rights Management (DRM) protection is required for distribution of this package (True/False). Critical for rights enforcement and anti-piracy compliance.',
    `effective_date` DATE COMMENT 'The date from which the package becomes available for distribution or licensing. Marks the start of the packages commercial availability window.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the package is offered on an exclusive basis to a single distributor or platform (True) or is available for non-exclusive multi-platform distribution (False). Critical for rights and holdback management.',
    `expiry_date` DATE COMMENT 'The date on which the package ceases to be available for distribution or licensing. Nullable for open-ended packages. Defines the end of the windowing or holdback period.',
    `hd_available_flag` BOOLEAN COMMENT 'Indicates whether the package content is available in high-definition (HD) format (True/False). Used for distribution planning and quality assurance.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags associated with the package for search, discovery, and recommendation purposes.',
    `language_primary` STRING COMMENT 'The primary language of the content in the package, expressed as ISO 639-2 three-letter language code (e.g., eng, spa, fra). Critical for localization and international distribution.',
    `modified_by` STRING COMMENT 'The username or identifier of the user or system that last modified the package record. Used for change accountability and audit trail.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the package record was last modified. Used for change tracking and audit compliance.',
    `package_name` STRING COMMENT 'The business name or title of the content package as recognized in commercial agreements and distribution deals.',
    `package_status` STRING COMMENT 'Current lifecycle status of the package: draft (under construction), active (available for distribution), suspended (temporarily unavailable), expired (past effective period), terminated (cancelled before expiry), or archived (historical record).. Valid values are `draft|active|suspended|expired|terminated|archived`',
    `package_type` STRING COMMENT 'The classification of the package based on its commercial or distribution purpose: syndication (content resale to multiple outlets), SVOD (Subscription Video On Demand) library (subscription-based catalog), AVOD (Advertising-Supported Video On Demand) catalog (ad-supported offering), FAST (Free Ad-Supported Streaming Television) channel (linear streaming channel), educational (academic or training content bundle), or international (cross-border distribution bundle).. Valid values are `syndication|svod-library|avod-catalog|fast-channel|educational|international`',
    `rights_holder` STRING COMMENT 'The name of the organization or entity that holds the distribution rights for the package. May be a studio, distributor, or licensor.',
    `territory_scope` STRING COMMENT 'Geographic territories or markets where the package is licensed for distribution, expressed as comma-separated ISO 3166-1 alpha-3 country codes or regional groupings (e.g., USA, GBR, CAN or EMEA, APAC). Defines the carriage or clearance geography.',
    `thumbnail_url` STRING COMMENT 'The URL or path to the thumbnail image representing the package in catalogs, EPG (Electronic Program Guide) listings, and user interfaces.',
    `total_runtime_hours` DECIMAL(18,2) COMMENT 'The aggregate runtime of all content in the package, expressed in hours. Used for programming and scheduling calculations.',
    `total_title_count` STRING COMMENT 'The total number of distinct titles (episodes, films, clips, or other content assets) included in the package. Used for inventory reporting and deal valuation.',
    `uhd_4k_available_flag` BOOLEAN COMMENT 'Indicates whether the package content is available in ultra-high-definition 4K format (True/False). Used for premium distribution and OTT platform requirements.',
    `value_usd` DECIMAL(18,2) COMMENT 'The estimated or contracted commercial value of the package in United States Dollars (USD). Used for revenue forecasting, deal valuation, and financial reporting.',
    CONSTRAINT pk_package PRIMARY KEY(`package_id`)
) COMMENT 'Defines a curated bundle of titles assembled for a specific commercial or distribution purpose — a syndication package, SVOD library deal, MVPD carriage bundle, or FAST channel lineup. Captures package name, package type (syndication/svod-library/avod-catalog/fast-channel/educational/international), package status, effective date, expiry date, territory scope, exclusivity flag, and the commercial context it was assembled for. Acts as the content-side counterpart to distribution and rights deal structures.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` (
    `compliance_finding_id` BIGINT COMMENT 'Primary key for compliance_finding',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Content compliance findings discovered during SOX, FCC, or internal audits are recorded as audit findings for remediation tracking, management response, and auditor verification. Essential for audit c',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Compliance violations are facility-specific (wrong content aired from a facility). Regulatory reporting, corrective action tracking, facility audits, and FCC incident reports require facility attribut',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: Content compliance findings are compliance incidents requiring incident management workflow (root cause analysis, corrective action, regulatory notification). Links finding to enterprise incident trac',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Compliance findings can be episode-specific (specific episode violated broadcast standards). Allows tracking compliance at episode granularity.',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Compliance findings are version-specific (broadcast-safe edit vs theatrical cut). Different versions may have different compliance status.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Compliance violations may involve partner-delivered content or co-produced material. Liability allocation per contract indemnification clauses, remediation cost recovery, and partner performance impac',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Content compliance findings (broadcast standards violations, content rating disputes) trigger FCC/regulatory filings. Broadcasters must link findings to formal regulatory submissions for audit trail a',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory compliance findings must link to the responsible compliance officer for FCC/regulatory reporting, escalation workflows, and accountability tracking. Essential for broadcast license maintena',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Regulatory compliance findings are territory-specific and tied to territorial rights. Fines, makegoods, and remediation are calculated based on the affected territorys regulatory framework.',
    `title_id` BIGINT COMMENT 'Reference to the content title that is the subject of this compliance finding.',
    `transmission_equipment_id` BIGINT COMMENT 'Foreign key linking to technology.transmission_equipment. Business justification: Technical compliance issues (closed captioning failure, audio levels) are equipment-specific. FCC incident reports, equipment maintenance triggers, root cause analysis, and corrective action tracking ',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Compliance violations often stem from license agreement breaches (unauthorized territory, expired rights, platform violations). Audit trails and remediation workflows require linking findings to the v',
    `affected_broadcast_date` DATE COMMENT 'The date on which the content was broadcast or distributed when the compliance issue occurred. Nullable if the finding relates to pre-broadcast content or non-time-specific violations.',
    `affected_daypart` STRING COMMENT 'The broadcast daypart (time segment of broadcast day) during which the compliance issue occurred, relevant for content standards and audience protection regulations (e.g., prime time, childrens programming hours, late night).',
    `affected_platform` STRING COMMENT 'The distribution platform or channel type where the compliance issue was identified: linear (traditional broadcast), OTT (Over-The-Top), VOD (Video On Demand), SVOD (Subscription Video On Demand), AVOD (Advertising-Supported Video On Demand), TVOD (Transactional Video On Demand), FAST (Free Ad-Supported Streaming Television), streaming, mobile, web. [ENUM-REF-CANDIDATE: linear|OTT|VOD|SVOD|AVOD|TVOD|FAST|streaming|mobile|web — 10 candidates stripped; promote to reference product]',
    `affidavit_reference` STRING COMMENT 'Reference number or identifier for the broadcast affidavit (proof of broadcast) associated with this compliance finding, if applicable.',
    `audit_trail` STRING COMMENT 'Comprehensive audit trail documenting all actions, decisions, communications, and status changes related to this compliance finding throughout its lifecycle.',
    `compliance_type` STRING COMMENT 'Category of compliance finding: broadcast_standard (FCC technical violations), content_standard (Ofcom content breach), rating_dispute (MPA rating challenge), accessibility (closed-caption or audio description QC), privacy (COPPA, GDPR violations), blackout_restriction (geographic restriction enforcement).. Valid values are `broadcast_standard|content_standard|rating_dispute|accessibility|privacy|blackout_restriction`',
    `corrective_action` STRING COMMENT 'Description of the corrective action plan or measures implemented to address the root cause and prevent recurrence of the compliance issue.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance finding record was first created in the system.',
    `department` STRING COMMENT 'The business department or organizational unit responsible for addressing the compliance finding (e.g., Legal, Compliance, Content Operations, Broadcast Engineering, Digital Distribution).',
    `due_date` DATE COMMENT 'The deadline or target date by which the compliance finding must be resolved or remediated, as mandated by regulatory requirements or internal policy.',
    `escalation_date` DATE COMMENT 'The date on which the compliance finding was escalated to senior management, legal counsel, or external regulatory authority. Nullable if no escalation occurred.',
    `external_case_number` STRING COMMENT 'Case number or reference identifier assigned by the external regulatory body or governing authority for tracking this compliance matter in their system.',
    `finding_date` DATE COMMENT 'The date on which the compliance finding was identified, logged, or officially reported by the regulatory body or internal compliance team.',
    `finding_number` STRING COMMENT 'Business identifier for the compliance finding, typically assigned by the compliance system or regulatory body for tracking and reference purposes.',
    `fine_amount` DECIMAL(18,2) COMMENT 'Monetary fine or penalty amount assessed by the regulatory body for this compliance violation. Nullable if no financial penalty was imposed.',
    `fine_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the fine amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `geographic_scope` STRING COMMENT 'The geographic region, territory, or jurisdiction to which this compliance finding applies, using 3-letter ISO country codes or regional identifiers (e.g., USA, GBR, EUR). Relevant for blackout restrictions, regional content standards, and jurisdiction-specific regulations.',
    `makegoods_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether compensatory ad spots (makegoods) are required as part of the resolution for advertising-related compliance issues.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance finding record was last modified or updated.',
    `preventive_action` STRING COMMENT 'Description of preventive measures, process improvements, or controls implemented to reduce the likelihood of similar compliance issues occurring in the future.',
    `recurrence_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this compliance finding is a recurrence of a previously identified issue for the same title or similar content.',
    `regulatory_body` STRING COMMENT 'The governing body or regulatory authority that issued or is associated with this compliance finding: FCC (Federal Communications Commission), Ofcom (UK Office of Communications), MPA (Motion Picture Association), ATSC (Advanced Television Systems Committee), DVB (Digital Video Broadcasting), ISO (International Organization for Standardization), GDPR (General Data Protection Regulation), CCPA (California Consumer Privacy Act), COPPA (Childrens Online Privacy Protection Act), PCI_DSS (Payment Card Industry Data Security Standard), or Internal (self-identified compliance issue). [ENUM-REF-CANDIDATE: FCC|Ofcom|MPA|ATSC|DVB|ISO|GDPR|CCPA|COPPA|PCI_DSS|Internal — 11 candidates stripped; promote to reference product]',
    `remediation_cost` DECIMAL(18,2) COMMENT 'Estimated or actual cost incurred by the organization to remediate the compliance issue, including labor, technology, content rework, and process improvements. Nullable if not tracked or not applicable.',
    `resolution_date` DATE COMMENT 'The date on which the compliance finding was resolved, remediated, or formally closed. Nullable if the finding is still open or in progress.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the resolution actions taken, corrective measures implemented, or explanations for closure of the compliance finding.',
    `resolution_status` STRING COMMENT 'Current status of the compliance finding in its resolution lifecycle: open (newly identified, not yet addressed), in_progress (remediation underway), resolved (corrective action completed), closed (finding formally closed and archived), escalated (elevated to higher authority), pending_review (awaiting regulatory or management review).. Valid values are `open|in_progress|resolved|closed|escalated|pending_review`',
    `root_cause` STRING COMMENT 'Identified root cause of the compliance violation, documenting the underlying process failure, system defect, human error, or policy gap that led to the non-compliance.',
    `severity_level` STRING COMMENT 'The severity classification of the compliance finding indicating the level of risk, impact, or urgency: critical (immediate action required, significant regulatory or reputational risk), high (prompt action needed), medium (moderate impact), low (minor issue), informational (advisory or observation).. Valid values are `critical|high|medium|low|informational`',
    `violation_description` STRING COMMENT 'Detailed narrative description of the compliance violation, including the specific standard or regulation breached, the nature of the non-compliance, and any relevant context or circumstances.',
    CONSTRAINT pk_compliance_finding PRIMARY KEY(`compliance_finding_id`)
) COMMENT 'Transactional record of a compliance-related action or finding against a specific title — FCC broadcast standard violation, Ofcom content standards breach, MPA rating dispute, COPPA flag, accessibility compliance check (closed-caption QC, audio description verification), or blackout restriction enforcement. Captures compliance type, regulatory body, finding date, severity, resolution status, resolution date, and responsible compliance officer. Feeds the compliance domain with content-specific regulatory events while keeping the authoritative compliance case record in the compliance domain.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` (
    `title_relationship_id` BIGINT COMMENT 'Unique identifier for the title relationship record. Primary key.',
    `parent_title_relationship_id` BIGINT COMMENT 'Self-referencing FK on title_relationship (parent_title_relationship_id)',
    `title_id` BIGINT COMMENT 'The originating content title in the relationship. References the title that serves as the starting point of the relationship (e.g., the original film in a sequel relationship, the parent series in a spin-off).',
    `target_title_id` BIGINT COMMENT 'The destination content title in the relationship. References the title that is the result or endpoint of the relationship (e.g., the sequel film, the spin-off series, the remake).',
    `bidirectional_flag` BOOLEAN COMMENT 'Indicates whether the relationship should be surfaced in both directions (e.g., show sequel on original AND show original on sequel). True for symmetric relationships like franchise siblings or crossovers, false for asymmetric relationships like clip-of or compilation.',
    `canonical_order` STRING COMMENT 'The sequence position of the target title within a series or franchise when viewed in canonical order (e.g., Episode IV is canonical_order 4 in Star Wars franchise). Null for non-sequential relationships like remakes or crossovers.',
    `chronological_order` STRING COMMENT 'The sequence position of the target title when viewed in story chronological order (e.g., Episode I is chronological_order 1 in Star Wars despite being released later). Null for non-sequential relationships.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this relationship record was first created in the system. Supports audit trail and data lineage tracking.',
    `display_priority` STRING COMMENT 'Numeric ranking (lower numbers = higher priority) controlling the order in which related titles are displayed in user interfaces, Electronic Program Guides (EPG), and recommendation carousels. Enables editorial control over content discovery presentation.',
    `editorial_notes` STRING COMMENT 'Free-text notes from content editors or curators explaining the nature, context, or nuances of the relationship. May include information about shared characters, plot connections, or reasons for the relationship classification.',
    `effective_date` DATE COMMENT 'The date when this relationship became valid and should be recognized by content discovery, recommendation engines, and editorial systems. Typically aligns with the target titles release or announcement date.',
    `expiration_date` DATE COMMENT 'The date when this relationship is no longer valid or should no longer be surfaced in content discovery. Null for permanent relationships. Used when relationships are time-bound due to rights, promotional windows, or editorial decisions.',
    `external_reference_code` STRING COMMENT 'Identifier for this relationship in an external system or metadata provider (e.g., EIDR relationship ID, ISAN linkage ID, third-party content graph ID). Enables cross-system reconciliation and metadata enrichment.',
    `franchise_name` STRING COMMENT 'The overarching franchise or intellectual property umbrella that both source and target titles belong to (e.g., Marvel Cinematic Universe, Star Trek, Law & Order). Enables franchise-level content discovery and curation.',
    `modified_by` STRING COMMENT 'Identifier or name of the user, system, or process that last modified this relationship record. Supports audit trail and change management.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this relationship record was last updated or modified. Supports change tracking and audit trail.',
    `platform_visibility` STRING COMMENT 'Comma-separated list of platforms or distribution channels where this relationship should be surfaced (e.g., OTT, Linear, SVOD, AVOD, FAST). Enables platform-specific content discovery strategies. Empty or null indicates visibility across all platforms.',
    `recommendation_weight` DECIMAL(18,2) COMMENT 'Numeric weight (0.00 to 100.00) indicating the priority or relevance of this relationship for recommendation engine algorithms. Higher weights indicate stronger recommendation signals. Used to tune content discovery and auto-play sequences.',
    `relationship_direction` STRING COMMENT 'Indicates the directionality of the relationship. Forward means source points to target, reverse means target points back to source, bidirectional means the relationship is mutual and non-hierarchical (e.g., franchise siblings).. Valid values are `forward|reverse|bidirectional`',
    `relationship_status` STRING COMMENT 'Current lifecycle status of the relationship. Active relationships are live and used by recommendation engines. Pending relationships are scheduled but not yet effective. Inactive relationships are temporarily disabled. Deprecated relationships are historical and no longer relevant.. Valid values are `active|inactive|pending|deprecated`',
    `relationship_strength` STRING COMMENT 'Indicates the strength or importance of the relationship for content discovery and recommendation purposes. Primary relationships are direct and essential (e.g., direct sequel), secondary are significant but less direct (e.g., shared universe), tertiary are weak connections (e.g., cameo appearance), tangential are loosely related (e.g., similar theme).. Valid values are `primary|secondary|tertiary|tangential`',
    `relationship_type` STRING COMMENT 'The nature of the relationship between the source and target titles. Defines how the two content assets are connected (e.g., sequel indicates target follows source chronologically, spin-off indicates target derives characters/universe from source, remake indicates target is a new version of source). [ENUM-REF-CANDIDATE: sequel|prequel|remake|reboot|spin-off|compilation|clip-of|franchise-sibling|crossover|adaptation|parody|documentary-of|behind-the-scenes — promote to reference product]. Valid values are `sequel|prequel|remake|reboot|spin-off|compilation`',
    `release_order` STRING COMMENT 'The sequence position of the target title in the order of original release or premiere dates within the franchise or relationship set. Supports viewing content in historical release sequence.',
    `territory_scope` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes indicating the geographic territories where this relationship is valid and should be surfaced. Supports rights-aware content discovery. Empty or null indicates global applicability.',
    `verification_date` DATE COMMENT 'The date when this relationship was verified or last reviewed for accuracy. Null for unverified relationships. Enables periodic re-verification workflows.',
    `verification_status` STRING COMMENT 'Indicates whether the relationship has been verified by editorial staff or subject matter experts. Verified relationships have been confirmed accurate, unverified are system-generated or user-submitted, disputed have conflicting information, pending_review are queued for editorial review.. Valid values are `verified|unverified|disputed|pending_review`',
    `verified_by` STRING COMMENT 'Name or identifier of the user, editor, or system that verified the accuracy of this relationship. Null for unverified relationships. Supports audit trail and quality assurance.',
    `created_by` STRING COMMENT 'Identifier or name of the user, system, or process that created this relationship record. Supports audit trail and accountability.',
    CONSTRAINT pk_title_relationship PRIMARY KEY(`title_relationship_id`)
) COMMENT 'Defines typed relationships between content assets — remakes, sequels, prequels, spin-offs, compilations, clip-parent associations, franchise linkages, and cross-promotional pairings. Captures source title, target title, relationship type (sequel/prequel/remake/spin-off/compilation/clip-of/franchise-sibling/crossover), relationship direction, canonical order, effective date, and active status. Supports content discovery, recommendation engines, franchise management, and editorial curation across linear and OTT platforms.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` (
    `series_talent_credit_id` BIGINT COMMENT 'Unique identifier for this series talent credit record. Primary key for the association.',
    `contract_id` BIGINT COMMENT 'Reference to the series-level contract governing this talents engagement. Links to contract management system for terms, exclusivity, and residual rights. Derived from detection phase relationship data.',
    `series_id` BIGINT COMMENT 'Foreign key linking to the series master record. Identifies which series this talent credit applies to.',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to the talent profile master record. Identifies which talent is credited in this series.',
    `billing_position` STRING COMMENT 'The ordinal position of this talent in the series credits (1 = top billing). Determines on-screen credit order and contractual obligations. Derived from detection phase relationship data.',
    `character_name` STRING COMMENT 'The name of the character portrayed by the talent in this series, if applicable. Null for non-acting roles. Derived from detection phase relationship data.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'The total compensation amount for this talents series-level engagement. May represent per-episode rate or series total depending on contract structure. Sensitive financial data. Derived from detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this series talent credit record was first created in the system. Audit trail for data lineage.',
    `credit_end_date` DATE COMMENT 'The date when this talents credited involvement in the series ended. Null for ongoing roles. Used for residual eligibility windows.',
    `credit_start_date` DATE COMMENT 'The date when this talents credited involvement in the series began. Used for tenure calculation and anniversary tracking.',
    `episode_scope_end` STRING COMMENT 'The last episode identifier where this talents involvement ends in the series. Null for ongoing roles. Supports character arc tracking and residual calculation. Derived from detection phase relationship data.',
    `episode_scope_start` STRING COMMENT 'The first episode identifier where this talents involvement begins in the series. Supports partial-series engagements and guest appearances. Derived from detection phase relationship data.',
    `role_category` STRING COMMENT 'High-level classification of the talents role in the series. Used for credit sequencing and union reporting. Derived from detection phase relationship data.',
    `role_name` STRING COMMENT 'The specific role or job function the talent performed in this series (e.g., Lead Actor, Director, Executive Producer, Writer). Derived from detection phase relationship data.',
    `role_status` STRING COMMENT 'The current status of this talents role in the series. Indicates whether the role is ongoing, completed, or recurring across seasons. Derived from detection phase relationship data.',
    `season_number` STRING COMMENT 'The season number(s) in which this talent participated. May represent a starting season if the role spans multiple seasons. Derived from detection phase relationship data.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this series talent credit record was last modified. Audit trail for change tracking.',
    CONSTRAINT pk_series_talent_credit PRIMARY KEY(`series_talent_credit_id`)
) COMMENT 'This association product represents the credited participation of talent in a series. It captures the specific role, character, billing position, and contractual terms for each talents involvement in a series across one or more seasons. Each record links one series to one talent_profile with attributes that exist only in the context of this series-level engagement, supporting production planning, rights management, royalty calculation, and on-screen credit generation.. Existence Justification: In media broadcasting, a series engages multiple talent across various roles (actors, directors, writers, producers) simultaneously, and talent work on multiple series throughout their careers. The business actively manages series-talent credits as operational records with specific billing positions, character assignments, episode scopes, season spans, contract references, and compensation terms. Production teams, rights managers, and royalty systems query and maintain these credits as distinct business entities for EPG generation, union reporting, residual calculation, and syndication licensing.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`credit` (
    `credit_id` BIGINT COMMENT 'Unique identifier for this talent credit record. Primary key for the credit association.',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to the talent profile receiving this credit',
    `title_id` BIGINT COMMENT 'Foreign key linking to the content title for which this credit applies',
    `approval_status` STRING COMMENT 'Current approval workflow state for this credit. Tracks whether the talent and legal have approved the credit wording, billing position, and character name.',
    `billing_position` STRING COMMENT 'The ordinal position of this credit within its credit type category. Lower numbers indicate higher billing prominence. Used to enforce contractual billing requirements.',
    `character_name` STRING COMMENT 'The name of the character portrayed by the talent (applicable for actors). Null for non-acting roles. Used for cast lists and promotional materials.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this credit record was first created in the system. Used for audit trail and workflow tracking.',
    `credit_type` STRING COMMENT 'Classification of the credit indicating the level and nature of the talents contribution. Determines billing tier and residual calculation rules.',
    `display_order` STRING COMMENT 'The absolute display order of this credit in the end credits sequence. Determines the exact position in the credit roll for broadcast and streaming.',
    `end_timestamp` TIMESTAMP COMMENT 'The date and time when this credit relationship ended or was completed. Used for tracking production timelines and contract fulfillment.',
    `residuals_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this specific credit qualifies for residual payments upon content reuse. Determined by contract terms, union status, and credit type for this title-talent combination.',
    `role_name` STRING COMMENT 'The professional role or capacity in which the talent contributed to the title. Determines credit category placement in end credits and EPG metadata.',
    `start_timestamp` TIMESTAMP COMMENT 'The date and time when this credit relationship became effective. Typically corresponds to the start of the talents work on this title.',
    `union_affiliation_flag` BOOLEAN COMMENT 'Indicates whether this specific credit was performed under union/guild jurisdiction. Determines residual calculation rules and credit format requirements per guild agreements.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this credit record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_credit PRIMARY KEY(`credit_id`)
) COMMENT 'This association product represents the Credit relationship between title and talent_profile. It captures the specific role, character, and billing information for each talents participation in a content title. Each record links one title to one talent_profile with attributes that exist only in the context of this professional credit relationship, including role classification, character portrayal, billing position, credit display order, union affiliation status, residuals eligibility, and credit approval workflow state.. Existence Justification: In media broadcasting operations, a single content title (film, series episode, news segment) has many talent contributors across multiple roles (actors, directors, writers, producers, crew), and each talent professional works on many titles throughout their career. The business actively manages these credit relationships as operational entities with specific attributes including role classification, character name, billing position, credit display order, union affiliation status, residuals eligibility, and approval workflow state. Credits are created during production, approved through legal and talent review processes, and published in end credits, EPG metadata, guild reports, and residual payment systems.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` (
    `title_rights_grant_id` BIGINT COMMENT 'Unique identifier for this title-grant association record. Primary key.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to the rights grant bundle being applied to this title',
    `title_id` BIGINT COMMENT 'Foreign key linking to the content title receiving rights under this grant',
    `clearance_status` STRING COMMENT 'Current clearance status for this specific title under this grant. Tracks whether all rights verification and music clearances are complete for this title-grant combination.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this title-grant association was first created in the system.',
    `exclusivity_tier` STRING COMMENT 'The exclusivity level for this specific title under this grant. Titles within a package grant may have different exclusivity terms.',
    `grant_effective_date` DATE COMMENT 'The date on which this specific title became available under this rights grant. May differ from the grants overall start date if titles are added to an existing grant.',
    `grant_expiry_date` DATE COMMENT 'The date on which rights for this specific title expire under this grant. May differ from the grants overall end date if titles have different term lengths.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this title-grant association was last modified.',
    `platform_type` STRING COMMENT 'The specific platform or distribution channel for which this title is cleared under this grant. A single grant may cover multiple platforms, each tracked separately per title.',
    `run_limit` STRING COMMENT 'Maximum number of times the content may be broadcast or streamed under this grant. Nullable if unlimited runs are permitted. [Moved from rights_grant: Run limits are often title-specific within a grant (e.g., a catalog grant may allow 10 runs for blockbuster titles but unlimited runs for library content). This should move to runs_allocated in the association.]',
    `runs_allocated` STRING COMMENT 'Number of broadcast or streaming runs allocated for this specific title under this grant. Titles within the same grant may have different run limits.',
    `runs_consumed` STRING COMMENT 'Number of runs already consumed for this specific title under this grant. Tracked at the title level for availability enforcement.',
    `runs_used` STRING COMMENT 'Number of runs already consumed against the run limit. Used for availability tracking and compliance. [Moved from rights_grant: Run consumption must be tracked per title-grant combination, not at the grant level. A grant covering 100 titles needs separate run tracking for each title. This becomes runs_consumed in the association.]',
    `window_type` STRING COMMENT 'The distribution window classification for this title-grant pairing. Determines sequencing and holdback enforcement in the availability engine.',
    CONSTRAINT pk_title_rights_grant PRIMARY KEY(`title_rights_grant_id`)
) COMMENT 'This association product represents the grant of specific distribution and exploitation rights for a content title. It captures the operational relationship between a content asset and the legal rights bundle that permits its distribution. Each record links one title to one rights grant with attributes that track usage, availability windows, and platform-specific restrictions that exist only in the context of this specific title-grant pairing.. Existence Justification: In media broadcasting operations, a single content title receives multiple distinct rights grants (e.g., a film has separate grants for theatrical, broadcast, SVOD, international distribution), and each rights grant covers multiple titles (catalog grants, package deals, library acquisitions). The business actively manages these title-grant pairings through clearance workflows, availability engines, and usage tracking systems. Each pairing has operational data (run counts, platform restrictions, window assignments, clearance status) that belongs to neither the title nor the grant alone.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`title_asset_usage` (
    `title_asset_usage_id` BIGINT COMMENT 'Unique identifier for this title-to-asset usage relationship record. Primary key.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to the media asset management record',
    `title_id` BIGINT COMMENT 'Foreign key linking to the content title master catalog record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this usage relationship record was created in the system. Used for audit trail and operational analytics.',
    `effective_date` DATE COMMENT 'Date from which this asset-title usage relationship becomes active and valid for distribution. Used for windowing strategy and rights management.',
    `expiry_date` DATE COMMENT 'Date after which this asset-title usage relationship is no longer valid for distribution. Null indicates indefinite validity. Used for rights expiration and content lifecycle management.',
    `last_modified_by` STRING COMMENT 'User or system identifier that last modified this usage relationship record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this usage relationship record. Used for change tracking and synchronization.',
    `platform_target` STRING COMMENT 'Target distribution platform or channel for this asset-title pairing. Examples: Linear Broadcast, Netflix, Hulu, Theatrical, YouTube, Social Media. Used for format optimization and delivery workflow routing.',
    `primary_flag` BOOLEAN COMMENT 'Indicates whether this asset is the primary or canonical representation of the title for the given usage context and territory. Used to identify the default asset when multiple options exist (e.g., primary broadcast master vs. backup).',
    `territory_scope` STRING COMMENT 'Geographic territory or market for which this asset-title pairing is valid. ISO 3166-1 alpha-3 country codes or regional codes (e.g., USA, EUR, GLOBAL). Drives rights clearance and distribution routing decisions.',
    `usage_context` STRING COMMENT 'Business purpose or context for which this asset serves this title. Determines distribution channel and rights requirements. Examples: theatrical (cinema release), broadcast (linear TV), streaming (OTT platforms), promotional (trailers/clips), archive (preservation master), international (dubbed/subtitled versions), accessibility (audio description/closed caption versions).',
    `usage_status` STRING COMMENT 'Current lifecycle status of this asset-title usage relationship. Active=currently valid for distribution, Pending=scheduled for future activation, Expired=past expiry_date, Suspended=temporarily disabled, Archived=historical record only.',
    `version_label` STRING COMMENT 'Human-readable label identifying the specific version or cut of the title represented by this asset. Examples: Theatrical Cut, Directors Cut, TV Edit, International Version, Trailer 1, Teaser, Behind the Scenes. Used for editorial tracking and distribution planning.',
    `created_by` STRING COMMENT 'User or system identifier that created this usage relationship record. Used for audit trail and accountability.',
    CONSTRAINT pk_title_asset_usage PRIMARY KEY(`title_asset_usage_id`)
) COMMENT 'This association product represents the operational linkage between content titles and their physical media assets in the MAM system. It captures which specific media asset (cut, version, format) serves which title for which business purpose, territory, platform, and time window. Each record links one title to one media asset with contextual metadata that exists only in the relationship — the same asset may serve multiple titles (stock footage, shared trailers) and the same title is represented by multiple assets (theatrical cut, TV edit, international versions, promotional clips). This is the authoritative record for asset-to-title mappings used by scheduling, distribution, and rights clearance systems.. Existence Justification: In media broadcasting operations, a single content title (e.g., feature film) is represented by multiple media assets serving different business purposes: theatrical cut, directors cut, TV edit, international versions, trailers, promotional clips, and accessibility versions. Conversely, a single media asset can be reused across multiple titles — stock footage appears in multiple documentaries, franchise trailers serve multiple films in a series, and shared promotional content supports multiple titles. The business actively manages these asset-to-title mappings with contextual metadata (usage purpose, territory, platform, time windows) that belongs to neither the title nor the asset alone.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement` (
    `genre_buy_agreement_id` BIGINT COMMENT 'Unique identifier for this advertiser-genre buy agreement record. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Foreign key linking to the advertiser who has negotiated terms for this genre',
    `genre_id` BIGINT COMMENT 'Foreign key linking to the content genre covered by this buy agreement',
    `employee_id` BIGINT COMMENT 'The identifier of the sales account executive who negotiated and owns this genre buy agreement. Links to employee master data.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of this genre buy agreement (active, pending, expired, suspended, terminated). Tracks the operational state of the commercial relationship.',
    `category_exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this advertiser has purchased category exclusivity within this genre, preventing direct competitors from advertising in the same genre during the contract period. Explicitly identified in detection phase relationship data.',
    `contract_end_date` DATE COMMENT 'The expiration date when this advertiser-genre buy agreement terminates and the negotiated terms no longer apply. Null indicates an evergreen agreement. Explicitly identified in detection phase relationship data.',
    `contract_start_date` DATE COMMENT 'The effective start date when this advertiser-genre buy agreement becomes active and the negotiated terms apply. Explicitly identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this genre buy agreement record was first created in the system.',
    `genre_cpm_premium_percent` DECIMAL(18,2) COMMENT 'The percentage premium (or discount if negative) applied to the base CPM rate for this advertiser when buying inventory within this specific genre. Reflects negotiated pricing that varies by advertiser-genre combination. Explicitly identified in detection phase relationship data.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this genre buy agreement record was last updated. Used for change tracking and audit.',
    `minimum_spend_commitment` DECIMAL(18,2) COMMENT 'The contractually committed minimum advertising spend amount for this advertiser within this genre over the contract period. Used for upfront deal tracking and revenue forecasting. Explicitly identified in detection phase relationship data.',
    `preferred_genre_flag` BOOLEAN COMMENT 'Indicates whether this genre has been designated as a preferred or priority genre for this advertiser, typically resulting in preferential ad placement, first-right-of-refusal on premium inventory, or priority scheduling. Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_genre_buy_agreement PRIMARY KEY(`genre_buy_agreement_id`)
) COMMENT 'This association product represents the contractual agreement between an advertiser and specific content genres for media buying. It captures advertiser-specific pricing premiums, exclusivity arrangements, spend commitments, and preferred genre status that exist only in the context of this advertiser-genre relationship. Each record links one advertiser to one genre with commercial terms negotiated for that specific combination.. Existence Justification: In media broadcasting advertising sales, advertisers negotiate commercial terms for buying inventory across multiple genres (e.g., an automotive advertiser buys sports, news, and drama), and each genre attracts multiple advertisers with different negotiated terms. The relationship represents a Genre Buy Agreement—a recognized commercial contract that captures advertiser-specific pricing premiums, category exclusivity deals, preferred genre status, and minimum spend commitments that vary by advertiser-genre combination.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`package_inclusion` (
    `package_inclusion_id` BIGINT COMMENT 'Unique identifier for this package inclusion record. Primary key.',
    `package_id` BIGINT COMMENT 'Foreign key to content.package. Identifies which package this inclusion belongs to.',
    `title_id` BIGINT COMMENT 'Foreign key to content.title. Identifies which title is included in the package.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this inclusion record was first created in the system. Used for audit and change tracking.',
    `effective_date` DATE COMMENT 'The date from which this title becomes available within the package for distribution. May differ from package-level effective date to support phased content rollouts or rights windows.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this specific title is offered on an exclusive basis within this package context. Title-level exclusivity may differ from package-level exclusivity terms.',
    `expiry_date` DATE COMMENT 'The date on which this title is removed from the package or its inclusion expires. Used for rights window management and automatic package composition updates.',
    `inclusion_date` DATE COMMENT 'The date when this title was added to the package. Used for tracking package evolution and audit purposes.',
    `inclusion_status` STRING COMMENT 'Current lifecycle status of this title within the package: active (currently included), pending (scheduled for inclusion), expired (inclusion window ended), removed (manually removed), suspended (temporarily unavailable).',
    `license_fee_allocated_usd` DECIMAL(18,2) COMMENT 'The portion of the package license fee allocated to this specific title. Used for revenue allocation, royalty calculations, and content valuation within package deals.',
    `modified_by` STRING COMMENT 'The username or identifier of the user or system that last modified this inclusion record. Used for audit and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this inclusion record was last modified. Used for change tracking and synchronization.',
    `priority_rank` STRING COMMENT 'The promotional or commercial priority of this title within the package. Used to determine featured content, hero placement, and marketing emphasis. Lower numbers indicate higher priority.',
    `sequence_number` STRING COMMENT 'The ordinal position of this title within the package for display purposes in EPG, catalog listings, or playlists. Used for FAST channel lineups and syndication package ordering.',
    CONSTRAINT pk_package_inclusion PRIMARY KEY(`package_inclusion_id`)
) COMMENT 'This association product represents the inclusion of a title within a content package. It captures the business rules and metadata governing how each title is positioned within a package for distribution or licensing purposes. Each record links one package to one title with attributes that exist only in the context of this relationship, such as sequencing for EPG display, exclusivity terms, effective windows, and priority ranking for promotional purposes.. Existence Justification: In media broadcasting, content packages are curated bundles assembled for distribution deals (SVOD libraries, syndication packages, FAST channel lineups, MVPD carriage bundles). A single package contains many titles (films, episodes, clips), and a single title can be included in multiple packages simultaneously (e.g., a popular film appears in both a premium SVOD package and a syndication package for international markets). Content operations teams actively manage package composition, adjusting title inclusions based on rights windows, commercial priorities, and distribution requirements.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` (
    `series_crew_assignment_id` BIGINT COMMENT 'Unique identifier for this series crew assignment record. Primary key for the association.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee master record. Identifies which internal employee is assigned to this series production role.',
    `series_id` BIGINT COMMENT 'Foreign key linking to the series master record. Identifies which series this crew assignment is for.',
    `assignment_end_date` DATE COMMENT 'Date when the crew member completed or left this series assignment. Null for ongoing assignments. Used for crew availability and historical tracking.',
    `assignment_start_date` DATE COMMENT 'Date when the crew member began work on this series assignment. Used for scheduling, availability tracking, and contract compliance.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this crew assignment. Indicates whether the crew member is actively working, has completed their work, or the assignment is paused/terminated.',
    `compensation_structure` STRING COMMENT 'The payment model for this crew assignment. Determines how the employee is compensated for their work on this series. Critical for payroll processing and residuals calculation. Explicitly identified in detection reasoning.',
    `contract_type` STRING COMMENT 'Classification of the employment contract structure for this crew assignment. Determines payment schedule, exclusivity terms, and renewal options. Critical for union compliance and residuals calculation. Explicitly identified in detection reasoning.',
    `credit_name` STRING COMMENT 'The name to be used in on-screen credits for this crew member on this series. May differ from legal name per union rules or professional preference.',
    `credit_position` STRING COMMENT 'The order/position of this crew members credit within their role category. Determines credit sequence in opening/closing titles per union rules.',
    `episode_range_end` STRING COMMENT 'Ending episode number within the season scope for this crew assignment. Null if assignment covers entire season or is ongoing. Used for episodic directors, writers, and guest crew. Explicitly identified in detection reasoning.',
    `episode_range_start` STRING COMMENT 'Starting episode number within the season scope for this crew assignment. Null if assignment covers entire season. Used for episodic directors, writers, and guest crew. Explicitly identified in detection reasoning.',
    `residuals_eligible` BOOLEAN COMMENT 'Indicates whether this crew assignment qualifies for residual payments based on contract type, union rules, and distribution windows. Critical for long-term compensation tracking.',
    `role_type` STRING COMMENT 'The specific production role the employee performs on this series. Determines union jurisdiction, credit placement, and compensation structure. Explicitly identified in detection reasoning.',
    `season_scope` STRING COMMENT 'Identifies which season(s) this crew assignment applies to. May be all, a specific season number, or a range (e.g., S1-S3). Critical for tracking crew continuity and contract scope. Explicitly identified in detection reasoning.',
    `union_affiliation` STRING COMMENT 'The labor union governing this crew assignment. Determines contract terms, minimum compensation, working conditions, and residuals eligibility.',
    CONSTRAINT pk_series_crew_assignment PRIMARY KEY(`series_crew_assignment_id`)
) COMMENT 'This association product represents the assignment relationship between series and employee. It captures the operational reality that production crew members (showrunners, producers, editors, directors, writers) work on multiple series throughout their careers, and each series employs multiple crew members across different roles and time periods. Each record links one series to one employee with attributes that exist only in the context of this specific assignment: the role they performed, the scope of their work (which seasons/episodes), contract terms, and compensation structure. This is critical for union contract compliance, residuals calculation, production scheduling, and crew availability management.. Existence Justification: In media broadcasting production operations, series crew assignments represent a genuine operational many-to-many relationship. Production crew members (showrunners, producers, directors, editors, writers) work on multiple series throughout their careers, and each series employs multiple crew members across different roles, seasons, and episode ranges. The business actively manages these assignments with role-specific data (role_type, season_scope, episode_range), contract terms (contract_type, compensation_structure), and credit information. This is not a derived correlation but an operational entity that production coordinators create, update, and query daily for scheduling, union compliance, and residuals calculation.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`distribution_package` (
    `distribution_package_id` BIGINT COMMENT 'Unique identifier for each title-partner distribution package record. Primary key for the association.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the distribution partner receiving this content package',
    `title_id` BIGINT COMMENT 'Foreign key linking to the content title included in this distribution package',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this package record was created. Used for audit trail and package composition tracking.',
    `exclusion_date` DATE COMMENT 'Date when this title was removed from the distribution package for this partner. Null indicates the title is currently active in the package. Used for windowing strategy and rights expiration tracking.',
    `format_rights` STRING COMMENT 'Distribution format rights granted to the partner for this title. Defines whether the partner can distribute via linear broadcast, video-on-demand, streaming, download, or multiple formats.',
    `inclusion_date` DATE COMMENT 'Date when this title was added to the distribution package for this partner. Used for tracking package composition history and effective date of distribution rights.',
    `package_status` STRING COMMENT 'Current lifecycle status of this title-partner package relationship. Determines whether the title is currently available for distribution to this partner.',
    `pricing_tier` STRING COMMENT 'Pricing tier classification for this title within the partner package. Determines royalty rates, licensing fees, and revenue share terms specific to this title-partner combination.',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the priority or prominence of this title within the partner-specific package. Used for featured content positioning, promotional planning, and partner-specific merchandising strategies.',
    `territory_scope` STRING COMMENT 'Geographic territories or markets where this title is licensed to this partner. Comma-separated ISO country codes or region identifiers. Supports territory-specific bundling and rights management.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this package record was last modified. Used for change tracking and synchronization with downstream distribution systems.',
    CONSTRAINT pk_distribution_package PRIMARY KEY(`distribution_package_id`)
) COMMENT 'This association product represents the packaging relationship between titles and distribution partners in the media broadcasting ecosystem. It captures how content assets are bundled, priced, and scoped for distribution to external partners including studios, syndicators, MVPDs, vMVPDs, and FAST channel operators. Each record links one title to one partner with attributes that define the commercial and territorial terms of that specific title-partner distribution arrangement.. Existence Justification: In media broadcasting operations, a single content title (film, series episode, music track) is distributed to multiple partners through different package configurations (theatrical package, streaming package, international syndication package), and each distribution partner receives multiple titles in their content packages. The business actively manages these distribution packages with partner-specific pricing tiers, territory scopes, format rights, and inclusion/exclusion dates as part of content licensing and syndication operations.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`episode_transmission` (
    `episode_transmission_id` BIGINT COMMENT 'Unique identifier for this specific transmission event. Primary key for the episode_transmission association.',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to the episode that was transmitted in this broadcast event',
    `transmission_equipment_id` BIGINT COMMENT 'Foreign key linking to the transmission equipment that broadcast this episode',
    `air_date` DATE COMMENT 'The calendar date when this episode was transmitted via this equipment. Critical for as-run logs and regulatory compliance reporting.',
    `air_time` TIMESTAMP COMMENT 'The precise timestamp when this episode transmission began. Used for FCC as-run logs, program schedule verification, and audience measurement correlation.',
    `signal_strength_dbm` DECIMAL(18,2) COMMENT 'Measured signal strength in dBm for this transmission event. Technical performance metric used for coverage analysis and equipment health monitoring.',
    `technical_issues_flag` BOOLEAN COMMENT 'Flag indicating whether technical issues occurred during this transmission event (signal loss, quality degradation, interruption). Triggers incident investigation and maintenance review.',
    `transmission_duration_seconds` STRING COMMENT 'Actual duration of this transmission event in seconds. May differ from episode runtime due to technical issues or scheduling adjustments. Used for as-run log reconciliation.',
    `transmission_quality` STRING COMMENT 'Quality assessment of this specific transmission event based on signal strength, error rates, and technical monitoring. Used for performance analysis and maintenance planning.',
    `transmission_status` STRING COMMENT 'Final status of this transmission event. Used for as-run log completion verification and incident tracking.',
    `viewer_count` BIGINT COMMENT 'Estimated or measured viewer count for this specific transmission event. Used for audience measurement, advertising rate justification, and content performance analysis.',
    CONSTRAINT pk_episode_transmission PRIMARY KEY(`episode_transmission_id`)
) COMMENT 'This association product represents the transmission event between content_episode and transmission_equipment. It captures each instance when a specific episode is broadcast via specific transmission equipment, recording air date/time, transmission quality metrics, viewer counts, and technical issues. Each record links one content_episode to one transmission_equipment with attributes that exist only in the context of this specific broadcast transmission event.. Existence Justification: In broadcast operations, a single episode is transmitted via multiple equipment instances across different times, channels, and geographic regions (multi-channel broadcast, regional transmitters, redundancy failover, rerun schedules). Conversely, each transmission equipment asset broadcasts thousands of different episodes over its operational lifetime. Broadcasters actively manage and track each transmission event as a distinct operational record for FCC as-run logs, regulatory compliance, technical performance monitoring, and audience measurement.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` (
    `taxonomy_id` BIGINT COMMENT 'Primary key for taxonomy',
    `parent_taxonomy_id` BIGINT COMMENT 'Reference to the parent taxonomy entry for hierarchical classification structures. Null for top-level taxonomy entries.',
    `employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - taxonomies need a governance owner for metadata quality',
    `allows_multiple_assignment` BOOLEAN COMMENT 'Indicates whether content assets can be tagged with multiple taxonomy entries of this type simultaneously.',
    `approval_status` STRING COMMENT 'Current approval status for new or modified taxonomy entries requiring governance review.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this taxonomy entry for use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this taxonomy entry was approved for use.',
    `taxonomy_code` STRING COMMENT 'Unique business code for the taxonomy entry used for external reference and integration.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this taxonomy entry was first created in the system.',
    `taxonomy_description` STRING COMMENT 'Detailed description of the taxonomy entry explaining its meaning, scope, and usage guidelines.',
    `display_order` STRING COMMENT 'Numeric sort order for displaying taxonomy entries within the same parent or type grouping.',
    `effective_end_date` DATE COMMENT 'Date when this taxonomy entry is no longer effective. Null for entries with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this taxonomy entry becomes effective and available for content classification.',
    `external_code` STRING COMMENT 'External or industry-standard taxonomy code for interoperability with third-party systems and content metadata standards.',
    `hierarchy_level` STRING COMMENT 'Numeric level in the taxonomy hierarchy where 1 is the top level and higher numbers represent deeper nesting.',
    `hierarchy_path` STRING COMMENT 'Full hierarchical path from root to current taxonomy entry, typically represented as a delimited string (e.g., /Drama/Crime/Detective).',
    `is_active` BOOLEAN COMMENT 'Indicates whether the taxonomy entry is currently active and available for content classification. Inactive entries are retained for historical reference.',
    `is_leaf_node` BOOLEAN COMMENT 'Indicates whether this taxonomy entry is a leaf node (has no children) in the hierarchy. True for leaf nodes, false for parent nodes.',
    `language_code` STRING COMMENT 'ISO 639 language code indicating the language of the taxonomy entry name and description.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this taxonomy entry was last updated.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the taxonomy entry indicating its operational status and availability for use.',
    `metadata_tags` STRING COMMENT 'Additional metadata tags or keywords associated with this taxonomy entry for search and discovery, stored as comma-separated values.',
    `taxonomy_name` STRING COMMENT 'Human-readable name of the taxonomy entry.',
    `notes` STRING COMMENT 'Additional notes, comments, or usage guidelines for this taxonomy entry.',
    `owner_department` STRING COMMENT 'Business department or team responsible for maintaining and governing this taxonomy entry.',
    `region_code` STRING COMMENT 'ISO 3166 three-letter country or region code indicating geographic applicability of this taxonomy entry.',
    `standard_reference` STRING COMMENT 'Reference to the industry standard or classification system this taxonomy entry aligns with (e.g., EIDR Genre, ISO 639 Language Code).',
    `taxonomy_type` STRING COMMENT 'Classification type of the taxonomy entry indicating the categorization dimension (e.g., genre, theme, mood, audience segment, format, language).',
    `usage_count` BIGINT COMMENT 'Number of content assets currently tagged with this taxonomy entry, used for analytics and taxonomy optimization.',
    `version_number` STRING COMMENT 'Version number of this taxonomy entry, incremented with each modification for change tracking.',
    CONSTRAINT pk_taxonomy PRIMARY KEY(`taxonomy_id`)
) COMMENT 'Master reference table for taxonomy. Referenced by taxonomy_id.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` (
    `content_library_id` BIGINT COMMENT 'Primary key for content_library',
    `parent_content_library_id` BIGINT COMMENT 'Self-referencing FK on content_library (parent_content_library_id)',
    `employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - content libraries need a curator/owner for governance',
    `acquisition_date` DATE COMMENT 'Date when the content asset was acquired or licensed by the organization for distribution.',
    `archive_location` STRING COMMENT 'Physical or digital storage location identifier for the master content asset. Used for asset retrieval and disaster recovery.',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the content asset. Critical for proper presentation across distribution platforms.',
    `audio_description_available` BOOLEAN COMMENT 'Indicates whether audio description track is available for visually impaired audiences. Supports accessibility compliance.',
    `audio_tracks_available` STRING COMMENT 'Comma-separated list of ISO 639-3 language codes for available audio tracks. Supports multi-language distribution.',
    `closed_caption_available` BOOLEAN COMMENT 'Indicates whether closed captioning is available for the content asset. Required for FCC compliance and accessibility.',
    `content_format` STRING COMMENT 'Technical format specification of the content asset including resolution and dynamic range characteristics.',
    `content_owner` STRING COMMENT 'Legal entity that owns the intellectual property rights to the content asset. Critical for rights management and licensing.',
    `content_status` STRING COMMENT 'Current lifecycle status of the content asset indicating availability and distribution eligibility.',
    `content_type` STRING COMMENT 'Primary classification of the content asset by format and structure. Determines applicable metadata schemas and distribution rules.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the content library record was first created in the system. Used for audit trail and data lineage.',
    `distributor` STRING COMMENT 'Name of the distributor or rights holder authorized to license the content for broadcast or streaming.',
    `duration_seconds` STRING COMMENT 'Total runtime duration of the content asset measured in seconds. Used for scheduling and inventory management.',
    `eidr_identifier` STRING COMMENT 'Globally unique identifier for audiovisual content registered with the Entertainment Identifier Registry. Used for content identification across distribution platforms.',
    `episode_number` STRING COMMENT 'Episode number within a season for episodic content. Null for non-episodic content.',
    `file_size_gb` DECIMAL(18,2) COMMENT 'Total file size of the master content asset measured in gigabytes. Used for storage planning and bandwidth estimation.',
    `frame_rate` DECIMAL(18,2) COMMENT 'Frame rate of the content asset measured in frames per second. Standard values include 23.976, 24, 25, 29.97, 30, 50, 59.94, 60.',
    `genre_primary` STRING COMMENT 'Primary genre classification for content categorization and discovery. Used for programming and recommendation engines.',
    `genre_secondary` STRING COMMENT 'Secondary genre classification providing additional categorization dimension for multi-genre content.',
    `isan_identifier` STRING COMMENT 'International standard identifier for audiovisual works as defined by ISO 15706. Used primarily for film and television content registration.',
    `isrc_identifier` STRING COMMENT 'International standard code for sound recordings and music video recordings as defined by ISO 3901. Used for music content identification.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords and tags for content discovery, search optimization, and recommendation algorithms.',
    `language_primary` STRING COMMENT 'ISO 639-3 three-letter code representing the primary language of the content audio track.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the content library record was last updated. Used for change tracking and synchronization.',
    `mpa_rating` STRING COMMENT 'Content rating assigned by the Motion Picture Association indicating age-appropriateness and content advisory.',
    `production_company` STRING COMMENT 'Name of the primary production company or studio responsible for creating the content asset.',
    `production_year` STRING COMMENT 'Year in which the content was originally produced or completed. Used for cataloging and rights management.',
    `release_date` DATE COMMENT 'Date when the content was first released or made available to audiences through any distribution channel.',
    `season_number` STRING COMMENT 'Season number for episodic content within a series. Null for non-episodic content.',
    `series_title` STRING COMMENT 'Title of the parent series for episodic content. Null for standalone content assets.',
    `subtitle_languages_available` STRING COMMENT 'Comma-separated list of ISO 639-3 language codes for available subtitle tracks. Supports localization and accessibility requirements.',
    `synopsis_long` STRING COMMENT 'Detailed summary of the content asset typically 200-500 words. Used for detailed program information and marketing.',
    `synopsis_short` STRING COMMENT 'Brief summary of the content asset typically 50-100 words. Used for program guides and promotional materials.',
    `territory_restrictions` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where content distribution is restricted due to licensing agreements.',
    `title` STRING COMMENT 'The official title or name of the content asset as registered in the master catalog.',
    `tv_rating` STRING COMMENT 'Television content rating as defined by the TV Parental Guidelines system for broadcast and streaming content.',
    `version_number` STRING COMMENT 'Version identifier for the content asset tracking edits, cuts, and revisions. Supports multiple versions of the same title.',
    CONSTRAINT pk_content_library PRIMARY KEY(`content_library_id`)
) COMMENT 'Master reference table for content_library. Referenced by content_library_id.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` (
    `vod_library_id` BIGINT COMMENT 'Primary key for vod_library',
    `parent_vod_library_id` BIGINT COMMENT 'Self-referencing FK on vod_library (parent_vod_library_id)',
    `series_id` BIGINT COMMENT 'Reference to the parent series if this content is an episode or part of a series collection.',
    `acquisition_type` STRING COMMENT 'Classification of how the content was acquired by the organization.',
    `archive_date` DATE COMMENT 'The date when the content was moved to archived status and removed from active distribution.',
    `aspect_ratio` STRING COMMENT 'The proportional relationship between width and height of the video frame.',
    `audio_description_available` BOOLEAN COMMENT 'Indicates whether audio description track is available for visually impaired audiences.',
    `audio_format` STRING COMMENT 'Audio channel configuration and encoding format of the content asset.',
    `availability_end_date` DATE COMMENT 'The date when this content is scheduled to be removed from VOD availability, typically driven by licensing agreements.',
    `availability_start_date` DATE COMMENT 'The date when this content becomes available for distribution and viewing on VOD platforms.',
    `closed_caption_available` BOOLEAN COMMENT 'Indicates whether closed captioning is available for this content asset, supporting accessibility requirements.',
    `content_status` STRING COMMENT 'Current lifecycle status of the VOD content asset within the library catalog.',
    `content_type` STRING COMMENT 'Classification of the VOD content asset by its primary format and structure.',
    `content_version` STRING COMMENT 'Version identifier for the content asset, tracking theatrical cuts, directors cuts, extended editions, and other variants.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 code representing the primary country where the content was produced.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this VOD library record was first created in the content management system.',
    `distributor_name` STRING COMMENT 'Name of the distribution company or entity that holds distribution rights.',
    `dubbed_languages` STRING COMMENT 'Comma-separated list of ISO 639-3 language codes for available dubbed audio tracks.',
    `duration_seconds` STRING COMMENT 'Total runtime of the VOD content asset measured in seconds.',
    `eidr_code` STRING COMMENT 'Universal unique identifier for audiovisual content registered with the Entertainment Identifier Registry, enabling global content identification and rights management.',
    `episode_number` STRING COMMENT 'Episode number within a season, applicable for episodic content.',
    `format_specification` STRING COMMENT 'Technical video resolution and format specification of the master content asset.',
    `genre_primary` STRING COMMENT 'The primary genre classification for the content asset, used for content discovery and recommendation.',
    `genre_secondary` STRING COMMENT 'Optional secondary genre classification for content with multiple genre characteristics.',
    `isan` STRING COMMENT 'ISO standard identifier for audiovisual works, used for cataloging and rights management of films and television content.',
    `language_original` STRING COMMENT 'ISO 639-3 three-letter code representing the original production language of the content.',
    `language_primary` STRING COMMENT 'ISO 639-3 three-letter code representing the primary language of the content audio track.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this VOD library record was last modified or updated.',
    `mpa_rating` STRING COMMENT 'Content rating assigned by the Motion Picture Association indicating age-appropriateness and content advisory.',
    `production_year` STRING COMMENT 'The year in which the content was produced or completed.',
    `release_date` DATE COMMENT 'The original theatrical, broadcast, or digital release date of the content asset.',
    `season_number` STRING COMMENT 'Season number within a series, applicable for episodic content.',
    `studio_name` STRING COMMENT 'Name of the primary production studio or company that produced the content.',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of ISO 639-3 language codes for available subtitle tracks.',
    `synopsis_long` STRING COMMENT 'Detailed narrative summary of the content, used for detailed program information and marketing materials.',
    `synopsis_short` STRING COMMENT 'Brief summary of the content, typically 50-150 characters, used for program guides and mobile displays.',
    `title` STRING COMMENT 'The official title of the VOD content asset as registered in the content catalog.',
    `tv_rating` STRING COMMENT 'Television content rating indicating age-appropriateness and content advisory for broadcast and streaming content.',
    CONSTRAINT pk_vod_library PRIMARY KEY(`vod_library_id`)
) COMMENT 'Master reference table for vod_library. Referenced by vod_library_id.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` (
    `content_portfolio_id` BIGINT COMMENT 'Primary key for content_portfolio',
    `parent_content_portfolio_id` BIGINT COMMENT 'Self-referencing FK on content_portfolio (parent_content_portfolio_id)',
    `series_id` BIGINT COMMENT 'Reference to the parent series if this content is an episode or part of a series.',
    `employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - content portfolios need a portfolio manager for strategic oversight',
    `acquisition_date` DATE COMMENT 'Date when the content rights were acquired or the content was added to the portfolio.',
    `acquisition_type` STRING COMMENT 'Method by which the content was acquired (original production, licensed, co-production, acquired).',
    `archive_date` DATE COMMENT 'Date when the content was moved to archived status and removed from active distribution.',
    `aspect_ratio` STRING COMMENT 'The proportional relationship between width and height of the video frame (e.g., 16:9, 4:3, 21:9).',
    `audio_description_available` BOOLEAN COMMENT 'Indicates whether audio description track for visually-impaired audiences is available for this content.',
    `audio_format` STRING COMMENT 'Audio channel configuration and format specification (e.g., stereo, 5.1, 7.1, Dolby Atmos).',
    `available_languages` STRING COMMENT 'Comma-separated list of ISO 639-2 language codes for which localized versions (dubbed or subtitled) are available.',
    `closed_captioning_available` BOOLEAN COMMENT 'Indicates whether closed captioning for hearing-impaired audiences is available for this content.',
    `content_type` STRING COMMENT 'Classification of the content asset by format and structure (e.g., film, series, episode, clip, music, news segment, live event).',
    `content_version` STRING COMMENT 'Version identifier for the content asset, used to track theatrical cuts, directors cuts, extended editions, and other variations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this content portfolio record was first created in the system.',
    `distributor` STRING COMMENT 'Name of the distribution company responsible for content distribution and licensing.',
    `eidr_identifier` STRING COMMENT 'Globally unique identifier for audiovisual content registered with the Entertainment Identifier Registry, used for content identification across distribution platforms.',
    `episode_number` STRING COMMENT 'Episode number within a season for episodic content.',
    `genre_primary` STRING COMMENT 'The primary genre classification of the content (e.g., drama, comedy, action, documentary, news, sports). [ENUM-REF-CANDIDATE: drama|comedy|action|thriller|horror|documentary|news|sports|music|children|reality — promote to reference product]',
    `genre_secondary` STRING COMMENT 'The secondary or sub-genre classification providing additional categorization detail for the content.',
    `internal_catalog_number` STRING COMMENT 'Internal business identifier or catalog number assigned to the content asset for operational tracking and reference.',
    `isan_identifier` STRING COMMENT 'International standard identifier for audiovisual works, particularly used for film and television content registration.',
    `isrc_identifier` STRING COMMENT 'International standard code for uniquely identifying sound recordings and music video recordings, used for music content assets.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords and tags for content discovery, search optimization, and metadata enrichment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this content portfolio record was last updated or modified.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the content asset (in production, post-production, active, archived, retired, expired).',
    `mpa_rating` STRING COMMENT 'Content rating assigned by the Motion Picture Association indicating age-appropriateness and content advisory (G, PG, PG-13, R, NC-17, NR).',
    `original_language` STRING COMMENT 'The primary language in which the content was originally produced, using ISO 639-2 three-letter language codes.',
    `original_title` STRING COMMENT 'The original title of the content in its source language before localization or translation.',
    `production_company` STRING COMMENT 'Name of the primary production company or studio that produced the content.',
    `production_year` STRING COMMENT 'The year in which the content was originally produced or completed.',
    `release_date` DATE COMMENT 'The official date when the content was first released or made available to audiences.',
    `resolution_standard` STRING COMMENT 'Video resolution quality standard of the content (SD, HD, FHD, UHD, 4K, 8K).',
    `runtime_minutes` STRING COMMENT 'Total runtime duration of the content asset measured in minutes.',
    `season_number` STRING COMMENT 'Season number within a series for episodic content.',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of ISO 639-2 language codes for which subtitle tracks are available.',
    `synopsis_long` STRING COMMENT 'Detailed summary or description of the content, providing comprehensive plot or content overview.',
    `synopsis_short` STRING COMMENT 'Brief summary or description of the content, typically 100-200 characters, used for program guides and listings.',
    `title` STRING COMMENT 'The official title or name of the content asset as registered in the master catalog.',
    `tv_parental_rating` STRING COMMENT 'Television content rating indicating age-appropriateness for broadcast content (TV-Y, TV-Y7, TV-G, TV-PG, TV-14, TV-MA).',
    CONSTRAINT pk_content_portfolio PRIMARY KEY(`content_portfolio_id`)
) COMMENT 'Master reference table for content_portfolio. Referenced by content_portfolio_id.';

-- ========= FOREIGN KEYS =========
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
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ADD CONSTRAINT `fk_content_identifier_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ADD CONSTRAINT `fk_content_identifier_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ADD CONSTRAINT `fk_content_lifecycle_event_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ADD CONSTRAINT `fk_content_lifecycle_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ADD CONSTRAINT `fk_content_content_clearance_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ADD CONSTRAINT `fk_content_content_clearance_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ADD CONSTRAINT `fk_content_content_clearance_windowing_plan_id` FOREIGN KEY (`windowing_plan_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`windowing_plan`(`windowing_plan_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ADD CONSTRAINT `fk_content_tag_parent_tag_id` FOREIGN KEY (`parent_tag_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`tag`(`tag_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ADD CONSTRAINT `fk_content_tag_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ADD CONSTRAINT `fk_content_tag_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ADD CONSTRAINT `fk_content_ingest_event_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ADD CONSTRAINT `fk_content_ingest_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ADD CONSTRAINT `fk_content_compliance_finding_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ADD CONSTRAINT `fk_content_compliance_finding_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ADD CONSTRAINT `fk_content_compliance_finding_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ADD CONSTRAINT `fk_content_title_relationship_parent_title_relationship_id` FOREIGN KEY (`parent_title_relationship_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title_relationship`(`title_relationship_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ADD CONSTRAINT `fk_content_title_relationship_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ADD CONSTRAINT `fk_content_title_relationship_target_title_id` FOREIGN KEY (`target_title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` ADD CONSTRAINT `fk_content_series_talent_credit_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`credit` ADD CONSTRAINT `fk_content_credit_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ADD CONSTRAINT `fk_content_title_rights_grant_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_asset_usage` ADD CONSTRAINT `fk_content_title_asset_usage_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement` ADD CONSTRAINT `fk_content_genre_buy_agreement_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_inclusion` ADD CONSTRAINT `fk_content_package_inclusion_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`package`(`package_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_inclusion` ADD CONSTRAINT `fk_content_package_inclusion_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` ADD CONSTRAINT `fk_content_series_crew_assignment_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`distribution_package` ADD CONSTRAINT `fk_content_distribution_package_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode_transmission` ADD CONSTRAINT `fk_content_episode_transmission_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ADD CONSTRAINT `fk_content_taxonomy_parent_taxonomy_id` FOREIGN KEY (`parent_taxonomy_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ADD CONSTRAINT `fk_content_content_library_parent_content_library_id` FOREIGN KEY (`parent_content_library_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_library`(`content_library_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ADD CONSTRAINT `fk_content_vod_library_parent_vod_library_id` FOREIGN KEY (`parent_vod_library_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`vod_library`(`vod_library_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ADD CONSTRAINT `fk_content_vod_library_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ADD CONSTRAINT `fk_content_content_portfolio_parent_content_portfolio_id` FOREIGN KEY (`parent_content_portfolio_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_portfolio`(`content_portfolio_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ADD CONSTRAINT `fk_content_content_portfolio_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`content` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`content` SET TAGS ('dbx_domain' = 'content');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_id` SET TAGS ('dbx_value_regex_removed' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `genre_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `genre_id` SET TAGS ('dbx_value_regex_removed' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Rights Holder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Content Acquisition Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '4:3|16:9|21:9|1.85:1|2.39:1');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `color_format` SET TAGS ('dbx_business_glossary_term' = 'Color Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `color_format` SET TAGS ('dbx_value_regex' = 'color|black_and_white|colorized');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Motion Picture Association (MPA) Content Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `content_status` SET TAGS ('dbx_business_glossary_term' = 'Content Lifecycle Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `content_status` SET TAGS ('dbx_value_regex' = 'active|archived|restricted|pending|expired|withdrawn');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `coppa_child_directed_flag` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Child-Directed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `distributor_name` SET TAGS ('dbx_business_glossary_term' = 'Distributor Name');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Rights Holder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Broadcast Facility Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Trailer Asset Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `production_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Production Budget Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `studio_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Studio Facility Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_holder` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_territory` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_status` SET TAGS ('dbx_business_glossary_term' = 'Season Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Long Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Short Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Season Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Runtime Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Content Season Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Content Series Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Master Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `production_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Production Budget Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ALTER COLUMN `studio_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Studio Facility Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Version Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Abr Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Drm Policy Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `encoder_config_id` SET TAGS ('dbx_business_glossary_term' = 'Encoder Config Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Master Media Asset Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `target_platform` SET TAGS ('dbx_business_glossary_term' = 'Target Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `target_territory` SET TAGS ('dbx_business_glossary_term' = 'Target Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `target_territory` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Version Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` SET TAGS ('dbx_subdomain' = 'editorial_classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `parent_genre_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Genre Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` SET TAGS ('dbx_subdomain' = 'editorial_classification');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` SET TAGS ('dbx_subdomain' = 'editorial_classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `localization_id` SET TAGS ('dbx_business_glossary_term' = 'Localization ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Localized Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Localization Vendor ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Title Version ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Voice Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `accessibility_standard_met` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Standard Met');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `accessibility_standard_met` SET TAGS ('dbx_value_regex' = 'WCAG_2.1_AA|WCAG_2.2_AA|FCC_CVAA|EAA|ADA|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `asset_file_path` SET TAGS ('dbx_business_glossary_term' = 'Asset File Path');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `character_count` SET TAGS ('dbx_business_glossary_term' = 'Character Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `compliance_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Localization Cost Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `eidr_code` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `eidr_code` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `localization_status` SET TAGS ('dbx_business_glossary_term' = 'Localization Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `localization_type` SET TAGS ('dbx_business_glossary_term' = 'Localization Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `localization_type` SET TAGS ('dbx_value_regex' = 'dubbing|subtitling|metadata_translation|forced_narrative|audio_description|closed_caption');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `qc_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `qc_pass_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Pass Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `qc_review_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `qc_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Reviewer Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `subtitle_format` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `target_language_code` SET TAGS ('dbx_business_glossary_term' = 'Target Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `target_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `target_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Target Territory Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `target_territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Identifier Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `external_reference_url` SET TAGS ('dbx_business_glossary_term' = 'External Reference URL (Uniform Resource Locator)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Identifier Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `identifier_type` SET TAGS ('dbx_value_regex' = 'EIDR|ISAN|ISRC|ISCI|MAM_ID|DISTRIBUTOR_ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Identifier Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Identifier Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `scope` SET TAGS ('dbx_value_regex' = 'global|regional|national|internal|platform_specific|distributor_specific');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `usage_context` SET TAGS ('dbx_business_glossary_term' = 'Usage Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `usage_context` SET TAGS ('dbx_value_regex' = 'rights_clearance|royalty_calculation|metadata_syndication|distribution|archival|reporting');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `value` SET TAGS ('dbx_business_glossary_term' = 'Identifier Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|expired|revoked|unverified');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`identifier` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Identifier Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` SET TAGS ('dbx_subdomain' = 'talent_association');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `talent_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Credit Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Episode Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Role Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Identifier (ID)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` SET TAGS ('dbx_subdomain' = 'rights_lifecycle');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Payable Invoice Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` SET TAGS ('dbx_subdomain' = 'rights_lifecycle');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `windowing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Windowing Plan ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `coppa_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Coppa Declaration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Drm Policy Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `encoder_config_id` SET TAGS ('dbx_business_glossary_term' = 'Encoder Config Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Governing License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planned By User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `satellite_transponder_id` SET TAGS ('dbx_business_glossary_term' = 'Satellite Transponder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `daypart_restriction` SET TAGS ('dbx_business_glossary_term' = 'Daypart Restriction');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `viewing_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Viewing Window Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `window_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Window Sequence Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `window_status` SET TAGS ('dbx_business_glossary_term' = 'Window Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `window_status` SET TAGS ('dbx_value_regex' = 'planned|confirmed|active|completed|cancelled|postponed');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `window_type` SET TAGS ('dbx_business_glossary_term' = 'Window Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` SET TAGS ('dbx_subdomain' = 'rights_lifecycle');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Event Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `automated_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Transition Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `blocking_condition` SET TAGS ('dbx_business_glossary_term' = 'Blocking Condition');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `blocking_resolved_flag` SET TAGS ('dbx_business_glossary_term' = 'Blocking Resolved Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `compliance_checkpoint_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Checkpoint Passed');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_business_glossary_term' = 'Delivery Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `event_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Event Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `qc_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `qc_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_required|conditional_pass');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `responsible_team` SET TAGS ('dbx_business_glossary_term' = 'Responsible Team');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `rollback_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollback Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `rollback_reason` SET TAGS ('dbx_business_glossary_term' = 'Rollback Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `sla_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `sla_target_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `system_source` SET TAGS ('dbx_business_glossary_term' = 'System Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `transition_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Transition Duration Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `transition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transition Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `triggered_by_event` SET TAGS ('dbx_business_glossary_term' = 'Triggered By Event');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Content Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ALTER COLUMN `workflow_instance_code` SET TAGS ('dbx_business_glossary_term' = 'Workflow Instance ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` SET TAGS ('dbx_subdomain' = 'rights_lifecycle');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `content_clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Content Clearance Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Officer Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Validating License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Validating Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `windowing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Windowing Plan Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Clearance Blocking Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `broadcast_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Ready Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|blocked|conditional|expired|waived');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `clearance_type` SET TAGS ('dbx_business_glossary_term' = 'Clearance Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `conditional_terms` SET TAGS ('dbx_business_glossary_term' = 'Conditional Clearance Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Clearance Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Clearance Fee Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `intended_platform` SET TAGS ('dbx_business_glossary_term' = 'Intended Distribution Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `intended_territory` SET TAGS ('dbx_business_glossary_term' = 'Intended Distribution Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `intended_territory` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `intended_window` SET TAGS ('dbx_business_glossary_term' = 'Intended Release Window');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `legal_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Clearance Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Clearance Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Clearance Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^CLR-[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `rights_holder_contact` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Contact Information');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `rights_holder_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `sla_target_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `metadata_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Metadata Profile ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `encoder_config_id` SET TAGS ('dbx_business_glossary_term' = 'Encoder Config Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Preview Media Asset Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `distributor` SET TAGS ('dbx_business_glossary_term' = 'Distributor');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `episode_number` SET TAGS ('dbx_business_glossary_term' = 'Episode Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `genre_classification` SET TAGS ('dbx_business_glossary_term' = 'Genre Classification');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `short_synopsis` SET TAGS ('dbx_business_glossary_term' = 'Short Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail URL (Uniform Resource Locator)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `trailer_url` SET TAGS ('dbx_business_glossary_term' = 'Trailer URL (Uniform Resource Locator)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `validation_errors` SET TAGS ('dbx_business_glossary_term' = 'Validation Errors');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|warning');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` SET TAGS ('dbx_subdomain' = 'editorial_classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `artwork_id` SET TAGS ('dbx_business_glossary_term' = 'Artwork Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `approved_for_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Approved for Use Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'Archive Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `artwork_type` SET TAGS ('dbx_business_glossary_term' = 'Artwork Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `artwork_type` SET TAGS ('dbx_value_regex' = 'key-art|thumbnail|banner|poster|logo|still');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `color_profile` SET TAGS ('dbx_business_glossary_term' = 'Color Profile');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `color_profile` SET TAGS ('dbx_value_regex' = 'sRGB|Adobe RGB|ProPhoto RGB|CMYK|Rec. 709|Rec. 2020');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `content_rating_displayed_flag` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Displayed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_business_glossary_term' = 'Copyright Holder');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `copyright_year` SET TAGS ('dbx_business_glossary_term' = 'Copyright Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `eidr` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `eidr` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'JPEG|PNG|TIFF|PSD|SVG|WebP');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `height_pixels` SET TAGS ('dbx_business_glossary_term' = 'Height in Pixels');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `language_overlay_flag` SET TAGS ('dbx_business_glossary_term' = 'Language Overlay Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `photographer_credit` SET TAGS ('dbx_business_glossary_term' = 'Photographer Credit');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `resolution_dpi` SET TAGS ('dbx_business_glossary_term' = 'Resolution in Dots Per Inch (DPI)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Artwork Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `usage_rights` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `usage_rights` SET TAGS ('dbx_value_regex' = 'all-media|digital-only|print-only|broadcast-only|theatrical-only|promotional-only');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `width_pixels` SET TAGS ('dbx_business_glossary_term' = 'Width in Pixels');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` SET TAGS ('dbx_subdomain' = 'editorial_classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `tag_id` SET TAGS ('dbx_business_glossary_term' = 'Tag Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `parent_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Tag ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Applied By User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `advertiser_safe` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Safe');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `applied_date` SET TAGS ('dbx_business_glossary_term' = 'Applied Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `coppa_compliant` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Compliant');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Tag Hierarchy Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `is_displayable` SET TAGS ('dbx_business_glossary_term' = 'Is Displayable');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `is_searchable` SET TAGS ('dbx_business_glossary_term' = 'Is Searchable');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Tag Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Tag Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'editorial|algorithmic|partner|user_generated|rights_holder|production');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `tag_type` SET TAGS ('dbx_business_glossary_term' = 'Tag Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `taxonomy_version` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `usage_context` SET TAGS ('dbx_business_glossary_term' = 'Usage Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `usage_context` SET TAGS ('dbx_value_regex' = 'recommendation|search|advertising|editorial|analytics|compliance');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `value` SET TAGS ('dbx_business_glossary_term' = 'Tag Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ALTER COLUMN `weight` SET TAGS ('dbx_business_glossary_term' = 'Tag Weight');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `ingest_event_id` SET TAGS ('dbx_business_glossary_term' = 'Ingest Event Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Ingest Operator Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `encoder_config_id` SET TAGS ('dbx_business_glossary_term' = 'Encoder Config Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Ingest Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Asset Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Vendor Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'Archive Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `audio_description_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Detected Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `automated_qc_result` SET TAGS ('dbx_business_glossary_term' = 'Automated Quality Control (QC) Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `automated_qc_result` SET TAGS ('dbx_value_regex' = 'pass|fail|warning|not_performed');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'Checksum Message Digest 5 (MD5)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{32}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_business_glossary_term' = 'Checksum Secure Hash Algorithm 256 (SHA-256)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{64}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `closed_caption_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Detected Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `ingest_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingest Completion Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `ingest_error_code` SET TAGS ('dbx_business_glossary_term' = 'Ingest Error Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `ingest_error_description` SET TAGS ('dbx_business_glossary_term' = 'Ingest Error Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `ingest_job_number` SET TAGS ('dbx_business_glossary_term' = 'Ingest Job Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `ingest_job_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `ingest_source_location` SET TAGS ('dbx_business_glossary_term' = 'Ingest Source Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `ingest_source_type` SET TAGS ('dbx_business_glossary_term' = 'Ingest Source Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `ingest_status` SET TAGS ('dbx_business_glossary_term' = 'Ingest Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `ingest_status` SET TAGS ('dbx_value_regex' = 'queued|in_progress|completed|failed|quarantined|cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `ingest_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingest Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `ingest_workflow_code` SET TAGS ('dbx_business_glossary_term' = 'Ingest Workflow Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `metadata_package_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Metadata Package Received Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `qc_error_code` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Error Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `qc_error_description` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Error Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `source_aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Source Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `source_audio_channels` SET TAGS ('dbx_business_glossary_term' = 'Source Audio Channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `source_audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Source Audio Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `source_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Source Duration in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `source_file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Source File Size in Bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `source_format` SET TAGS ('dbx_business_glossary_term' = 'Source Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `source_frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Source Frame Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ALTER COLUMN `source_resolution` SET TAGS ('dbx_business_glossary_term' = 'Source Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` SET TAGS ('dbx_subdomain' = 'distribution_packaging');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_code` SET TAGS ('dbx_business_glossary_term' = 'Package Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `commercial_context` SET TAGS ('dbx_business_glossary_term' = 'Commercial Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_description` SET TAGS ('dbx_business_glossary_term' = 'Package Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `drm_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `hd_available_flag` SET TAGS ('dbx_business_glossary_term' = 'High Definition (HD) Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `language_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_name` SET TAGS ('dbx_business_glossary_term' = 'Package Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_status` SET TAGS ('dbx_business_glossary_term' = 'Package Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|archived');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'syndication|svod-library|avod-catalog|fast-channel|educational|international');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `rights_holder` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `total_runtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Runtime Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `total_title_count` SET TAGS ('dbx_business_glossary_term' = 'Total Title Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `uhd_4k_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Ultra High Definition (UHD) 4K Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `value_usd` SET TAGS ('dbx_business_glossary_term' = 'Package Value United States Dollars (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` SET TAGS ('dbx_subdomain' = 'rights_lifecycle');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `compliance_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Finding Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Equipment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Violated License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `affected_broadcast_date` SET TAGS ('dbx_business_glossary_term' = 'Affected Broadcast Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `affected_daypart` SET TAGS ('dbx_business_glossary_term' = 'Affected Daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `affected_platform` SET TAGS ('dbx_business_glossary_term' = 'Affected Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `affidavit_reference` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `compliance_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `compliance_type` SET TAGS ('dbx_value_regex' = 'broadcast_standard|content_standard|rating_dispute|accessibility|privacy|blackout_restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `external_case_number` SET TAGS ('dbx_business_glossary_term' = 'External Case Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `finding_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Finding Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `fine_amount` SET TAGS ('dbx_business_glossary_term' = 'Fine Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `fine_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `fine_currency` SET TAGS ('dbx_business_glossary_term' = 'Fine Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `fine_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `makegoods_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegoods Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `remediation_cost` SET TAGS ('dbx_business_glossary_term' = 'Remediation Cost');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `remediation_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|escalated|pending_review');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `title_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Title Relationship Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `parent_title_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Title Relationship Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `parent_title_relationship_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Source Title Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `target_title_id` SET TAGS ('dbx_business_glossary_term' = 'Target Title Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `bidirectional_flag` SET TAGS ('dbx_business_glossary_term' = 'Bidirectional Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `canonical_order` SET TAGS ('dbx_business_glossary_term' = 'Canonical Order');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `chronological_order` SET TAGS ('dbx_business_glossary_term' = 'Chronological Order');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `display_priority` SET TAGS ('dbx_business_glossary_term' = 'Display Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `editorial_notes` SET TAGS ('dbx_business_glossary_term' = 'Editorial Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `franchise_name` SET TAGS ('dbx_business_glossary_term' = 'Franchise Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `platform_visibility` SET TAGS ('dbx_business_glossary_term' = 'Platform Visibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `recommendation_weight` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Weight');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `relationship_direction` SET TAGS ('dbx_business_glossary_term' = 'Relationship Direction');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `relationship_direction` SET TAGS ('dbx_value_regex' = 'forward|reverse|bidirectional');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|deprecated');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `relationship_strength` SET TAGS ('dbx_business_glossary_term' = 'Relationship Strength');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `relationship_strength` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary|tangential');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'sequel|prequel|remake|reboot|spin-off|compilation');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `release_order` SET TAGS ('dbx_business_glossary_term' = 'Release Order');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|disputed|pending_review');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_relationship` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` SET TAGS ('dbx_subdomain' = 'talent_association');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` SET TAGS ('dbx_association_edges' = 'content.series,talent.talent_profile');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` ALTER COLUMN `series_talent_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Series Talent Credit Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Talent Credit - Series Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Series Talent Credit - Talent Profile Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` ALTER COLUMN `billing_position` SET TAGS ('dbx_business_glossary_term' = 'Billing Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` ALTER COLUMN `character_name` SET TAGS ('dbx_business_glossary_term' = 'Character Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` ALTER COLUMN `credit_end_date` SET TAGS ('dbx_business_glossary_term' = 'Credit End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` ALTER COLUMN `credit_start_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` ALTER COLUMN `episode_scope_end` SET TAGS ('dbx_business_glossary_term' = 'Episode Scope End');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` ALTER COLUMN `episode_scope_start` SET TAGS ('dbx_business_glossary_term' = 'Episode Scope Start');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` ALTER COLUMN `role_category` SET TAGS ('dbx_business_glossary_term' = 'Role Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` ALTER COLUMN `role_name` SET TAGS ('dbx_business_glossary_term' = 'Role Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` ALTER COLUMN `role_status` SET TAGS ('dbx_business_glossary_term' = 'Role Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`credit` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`credit` SET TAGS ('dbx_subdomain' = 'talent_association');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`credit` SET TAGS ('dbx_association_edges' = 'content.title,talent.talent_profile');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`credit` ALTER COLUMN `credit_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`credit` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit - Talent Profile Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`credit` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Credit - Title Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`credit` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`credit` ALTER COLUMN `billing_position` SET TAGS ('dbx_business_glossary_term' = 'Billing Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`credit` ALTER COLUMN `character_name` SET TAGS ('dbx_business_glossary_term' = 'Character Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`credit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Credit Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`credit` ALTER COLUMN `credit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`credit` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Credit Display Order');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`credit` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Credit End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`credit` ALTER COLUMN `residuals_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residuals Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`credit` ALTER COLUMN `role_name` SET TAGS ('dbx_business_glossary_term' = 'Credit Role');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`credit` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Credit Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`credit` ALTER COLUMN `union_affiliation_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`credit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Credit Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` SET TAGS ('dbx_subdomain' = 'rights_lifecycle');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` SET TAGS ('dbx_association_edges' = 'content.title,rights.rights_grant');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `title_rights_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Title Rights Grant Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Title Rights Grant - Rights Grant Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Rights Grant - Title Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `exclusivity_tier` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `grant_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Grant Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `grant_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Grant Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `run_limit` SET TAGS ('dbx_business_glossary_term' = 'Run Limit');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `runs_allocated` SET TAGS ('dbx_business_glossary_term' = 'Runs Allocated');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `runs_consumed` SET TAGS ('dbx_business_glossary_term' = 'Runs Consumed');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `runs_used` SET TAGS ('dbx_business_glossary_term' = 'Runs Used');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `window_type` SET TAGS ('dbx_business_glossary_term' = 'Window Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_asset_usage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_asset_usage` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_asset_usage` SET TAGS ('dbx_association_edges' = 'content.title,mediaasset.media_asset');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_asset_usage` ALTER COLUMN `title_asset_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Title Asset Usage Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_asset_usage` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Title Asset Usage - Media Asset Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_asset_usage` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Asset Usage - Title Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_asset_usage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_asset_usage` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_asset_usage` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_asset_usage` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_asset_usage` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_asset_usage` ALTER COLUMN `platform_target` SET TAGS ('dbx_business_glossary_term' = 'Platform Target');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_asset_usage` ALTER COLUMN `primary_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Asset Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_asset_usage` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_asset_usage` ALTER COLUMN `usage_context` SET TAGS ('dbx_business_glossary_term' = 'Usage Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_asset_usage` ALTER COLUMN `usage_status` SET TAGS ('dbx_business_glossary_term' = 'Usage Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_asset_usage` ALTER COLUMN `version_label` SET TAGS ('dbx_business_glossary_term' = 'Version Label');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_asset_usage` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement` SET TAGS ('dbx_subdomain' = 'distribution_packaging');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement` SET TAGS ('dbx_association_edges' = 'content.genre,advertising.advertiser');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement` ALTER COLUMN `genre_buy_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Buy Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Buy Agreement - Advertiser Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Buy Agreement - Genre Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement` ALTER COLUMN `category_exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Category Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement` ALTER COLUMN `genre_cpm_premium_percent` SET TAGS ('dbx_business_glossary_term' = 'Genre CPM Premium Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement` ALTER COLUMN `minimum_spend_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Spend Commitment');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement` ALTER COLUMN `preferred_genre_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Genre Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_inclusion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_inclusion` SET TAGS ('dbx_subdomain' = 'distribution_packaging');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_inclusion` SET TAGS ('dbx_association_edges' = 'content.package,content.title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_inclusion` ALTER COLUMN `package_inclusion_id` SET TAGS ('dbx_business_glossary_term' = 'Package Inclusion ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_inclusion` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_inclusion` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_inclusion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_inclusion` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_inclusion` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_inclusion` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_inclusion` ALTER COLUMN `inclusion_date` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_inclusion` ALTER COLUMN `inclusion_status` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_inclusion` ALTER COLUMN `license_fee_allocated_usd` SET TAGS ('dbx_business_glossary_term' = 'License Fee Allocated USD');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_inclusion` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_inclusion` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_inclusion` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package_inclusion` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` SET TAGS ('dbx_subdomain' = 'talent_association');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` SET TAGS ('dbx_association_edges' = 'content.series,workforce.employee');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` ALTER COLUMN `series_crew_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Series Crew Assignment Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Series Crew Assignment - Employee Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Crew Assignment - Series Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` ALTER COLUMN `credit_name` SET TAGS ('dbx_business_glossary_term' = 'Credit Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` ALTER COLUMN `credit_position` SET TAGS ('dbx_business_glossary_term' = 'Credit Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` ALTER COLUMN `episode_range_end` SET TAGS ('dbx_business_glossary_term' = 'Episode Range End');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` ALTER COLUMN `episode_range_start` SET TAGS ('dbx_business_glossary_term' = 'Episode Range Start');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` ALTER COLUMN `residuals_eligible` SET TAGS ('dbx_business_glossary_term' = 'Residuals Eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Production Role Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` ALTER COLUMN `season_scope` SET TAGS ('dbx_business_glossary_term' = 'Season Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`distribution_package` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`distribution_package` SET TAGS ('dbx_subdomain' = 'distribution_packaging');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`distribution_package` SET TAGS ('dbx_association_edges' = 'content.title,partner.partner_partner');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`distribution_package` ALTER COLUMN `distribution_package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Distribution Package Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`distribution_package` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Content Distribution Package - Partner Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`distribution_package` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Distribution Package - Title Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`distribution_package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Package Creation Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`distribution_package` ALTER COLUMN `exclusion_date` SET TAGS ('dbx_business_glossary_term' = 'Package Exclusion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`distribution_package` ALTER COLUMN `format_rights` SET TAGS ('dbx_business_glossary_term' = 'Package Format Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`distribution_package` ALTER COLUMN `inclusion_date` SET TAGS ('dbx_business_glossary_term' = 'Package Inclusion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`distribution_package` ALTER COLUMN `package_status` SET TAGS ('dbx_business_glossary_term' = 'Package Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`distribution_package` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Package Pricing Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`distribution_package` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Package Priority Rank');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`distribution_package` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Package Territory Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`distribution_package` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Package Update Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode_transmission` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode_transmission` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode_transmission` SET TAGS ('dbx_association_edges' = 'content.content_episode,technology.transmission_equipment');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode_transmission` ALTER COLUMN `episode_transmission_id` SET TAGS ('dbx_business_glossary_term' = 'Episode Transmission Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode_transmission` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Episode Transmission - Content Episode Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode_transmission` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Episode Transmission - Transmission Equipment Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode_transmission` ALTER COLUMN `air_date` SET TAGS ('dbx_business_glossary_term' = 'Transmission Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode_transmission` ALTER COLUMN `air_time` SET TAGS ('dbx_business_glossary_term' = 'Transmission Air Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode_transmission` ALTER COLUMN `signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode_transmission` ALTER COLUMN `technical_issues_flag` SET TAGS ('dbx_business_glossary_term' = 'Technical Issues Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode_transmission` ALTER COLUMN `transmission_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Actual Transmission Duration');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode_transmission` ALTER COLUMN `transmission_quality` SET TAGS ('dbx_business_glossary_term' = 'Transmission Quality Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode_transmission` ALTER COLUMN `transmission_status` SET TAGS ('dbx_business_glossary_term' = 'Transmission Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode_transmission` ALTER COLUMN `viewer_count` SET TAGS ('dbx_business_glossary_term' = 'Viewer Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` SET TAGS ('dbx_subdomain' = 'editorial_classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `parent_taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Taxonomy Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `allows_multiple_assignment` SET TAGS ('dbx_business_glossary_term' = 'Allows Multiple Assignment');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `taxonomy_code` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `taxonomy_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `external_code` SET TAGS ('dbx_business_glossary_term' = 'External Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `is_leaf_node` SET TAGS ('dbx_business_glossary_term' = 'Is Leaf Node');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `metadata_tags` SET TAGS ('dbx_business_glossary_term' = 'Metadata Tags');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `taxonomy_name` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Standard Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `taxonomy_type` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`taxonomy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `content_library_id` SET TAGS ('dbx_business_glossary_term' = 'Content Library Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `parent_content_library_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Content Library Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `parent_content_library_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'Archive Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `archive_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `audio_tracks_available` SET TAGS ('dbx_business_glossary_term' = 'Audio Tracks Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `content_format` SET TAGS ('dbx_business_glossary_term' = 'Content Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `content_owner` SET TAGS ('dbx_business_glossary_term' = 'Content Owner');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `content_owner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `content_status` SET TAGS ('dbx_business_glossary_term' = 'Content Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `distributor` SET TAGS ('dbx_business_glossary_term' = 'Distributor');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_business_glossary_term' = 'Eidr Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `episode_number` SET TAGS ('dbx_business_glossary_term' = 'Episode Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `file_size_gb` SET TAGS ('dbx_business_glossary_term' = 'File Size Gb');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `genre_primary` SET TAGS ('dbx_business_glossary_term' = 'Genre Primary');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `genre_secondary` SET TAGS ('dbx_business_glossary_term' = 'Genre Secondary');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `isan_identifier` SET TAGS ('dbx_business_glossary_term' = 'Isan Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `isrc_identifier` SET TAGS ('dbx_business_glossary_term' = 'Isrc Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `language_primary` SET TAGS ('dbx_business_glossary_term' = 'Language Primary');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `mpa_rating` SET TAGS ('dbx_business_glossary_term' = 'Mpa Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `production_company` SET TAGS ('dbx_business_glossary_term' = 'Production Company');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `production_year` SET TAGS ('dbx_business_glossary_term' = 'Production Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `series_title` SET TAGS ('dbx_business_glossary_term' = 'Series Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `subtitle_languages_available` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Languages Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Synopsis Long');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Synopsis Short');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `territory_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Territory Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `tv_rating` SET TAGS ('dbx_business_glossary_term' = 'Tv Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_library` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `vod_library_id` SET TAGS ('dbx_business_glossary_term' = 'Vod Library Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `parent_vod_library_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Vod Library Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `parent_vod_library_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `audio_format` SET TAGS ('dbx_business_glossary_term' = 'Audio Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `availability_end_date` SET TAGS ('dbx_business_glossary_term' = 'Availability End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `availability_start_date` SET TAGS ('dbx_business_glossary_term' = 'Availability Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `content_status` SET TAGS ('dbx_business_glossary_term' = 'Content Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `content_version` SET TAGS ('dbx_business_glossary_term' = 'Content Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country Of Origin');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `distributor_name` SET TAGS ('dbx_business_glossary_term' = 'Distributor Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `dubbed_languages` SET TAGS ('dbx_business_glossary_term' = 'Dubbed Languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `eidr_code` SET TAGS ('dbx_business_glossary_term' = 'Eidr Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `episode_number` SET TAGS ('dbx_business_glossary_term' = 'Episode Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `format_specification` SET TAGS ('dbx_business_glossary_term' = 'Format Specification');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `genre_primary` SET TAGS ('dbx_business_glossary_term' = 'Genre Primary');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `genre_secondary` SET TAGS ('dbx_business_glossary_term' = 'Genre Secondary');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'Isan');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `language_original` SET TAGS ('dbx_business_glossary_term' = 'Language Original');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `language_primary` SET TAGS ('dbx_business_glossary_term' = 'Language Primary');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `mpa_rating` SET TAGS ('dbx_business_glossary_term' = 'Mpa Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `production_year` SET TAGS ('dbx_business_glossary_term' = 'Production Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `studio_name` SET TAGS ('dbx_business_glossary_term' = 'Studio Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Synopsis Long');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Synopsis Short');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`vod_library` ALTER COLUMN `tv_rating` SET TAGS ('dbx_business_glossary_term' = 'Tv Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `content_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Content Portfolio Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `parent_content_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Content Portfolio Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `parent_content_portfolio_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `audio_format` SET TAGS ('dbx_business_glossary_term' = 'Audio Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `available_languages` SET TAGS ('dbx_business_glossary_term' = 'Available Languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `closed_captioning_available` SET TAGS ('dbx_business_glossary_term' = 'Closed Captioning Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `content_version` SET TAGS ('dbx_business_glossary_term' = 'Content Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `distributor` SET TAGS ('dbx_business_glossary_term' = 'Distributor');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_business_glossary_term' = 'Eidr Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `episode_number` SET TAGS ('dbx_business_glossary_term' = 'Episode Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `genre_primary` SET TAGS ('dbx_business_glossary_term' = 'Genre Primary');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `genre_secondary` SET TAGS ('dbx_business_glossary_term' = 'Genre Secondary');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `internal_catalog_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Catalog Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `isan_identifier` SET TAGS ('dbx_business_glossary_term' = 'Isan Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `isrc_identifier` SET TAGS ('dbx_business_glossary_term' = 'Isrc Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `mpa_rating` SET TAGS ('dbx_business_glossary_term' = 'Mpa Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `original_language` SET TAGS ('dbx_business_glossary_term' = 'Original Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `original_title` SET TAGS ('dbx_business_glossary_term' = 'Original Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `production_company` SET TAGS ('dbx_business_glossary_term' = 'Production Company');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `production_year` SET TAGS ('dbx_business_glossary_term' = 'Production Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `resolution_standard` SET TAGS ('dbx_business_glossary_term' = 'Resolution Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Runtime Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Synopsis Long');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Synopsis Short');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_portfolio` ALTER COLUMN `tv_parental_rating` SET TAGS ('dbx_business_glossary_term' = 'Tv Parental Rating');
