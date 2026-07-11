-- Schema for Domain: rights | Business: Media_Broadcasting | Version: v3_mvm
-- Generated on: 2026-07-10 21:14:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`rights` COMMENT 'Single source of truth for all intellectual property rights, licensing agreements, and royalty obligations. Manages content windows (theatrical, SVOD, AVOD, TVOD, linear), holdback periods, territory restrictions, talent residuals, music synchronization licenses, clearance workflows, and royalty calculations. Powered by Rightsline, this domain enforces windowing strategies and feeds availability data to scheduling and distribution.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` (
    `license_agreement_id` BIGINT COMMENT 'Unique system identifier for the license agreement record. Primary key. Role: MASTER_AGREEMENT.',
    `acquisition_deal_id` BIGINT COMMENT 'Foreign key linking to partner.acquisition_deal. Business justification: License agreements are the legal formalization of acquisition deals. Deal-to-license traceability is required for MG recoupment audits, deal performance reporting, and regulatory compliance — rights t',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: License agreements for broadcast content must reference the FCC broadcast license under which content is distributed. Required for regulatory compliance and public inspection file documentation.',
    `sales_account_id` BIGINT COMMENT 'Foreign key linking to sales.sales_account. Business justification: License agreements are negotiated with sales accounts (distributors, broadcasters, platforms). Real-world licensing operations require tracking which sales account is the licensee for revenue recognit',
    `holder_id` BIGINT COMMENT 'Reference to the party granting rights under this agreement (studio, distributor, music publisher, talent guild, production company).',
    `partner_id` BIGINT COMMENT 'FK to partner.partner_partner',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Material license agreements (ownership changes, political advertising contracts, significant territory expansions) trigger FCC regulatory filings. Tracks which agreements require public disclosure or ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: License agreements are governed by specific regulatory obligations (guild residual mandates, music sync rules, FCC licensing requirements). Flags like residuals_obligation_flag and music_sync_license_',
    `advance_payment_amount` DECIMAL(18,2) COMMENT 'Upfront payment made upon execution of the agreement, typically recoupable against future royalties or license fees.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the license agreement, used in contracts and communications with rights holders and licensees.',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the license agreement. Controls whether rights are available for scheduling and distribution.. Valid values are `draft|executed|active|expired|terminated|suspended`',
    `agreement_type` STRING COMMENT 'Classification of the license agreement based on the nature of the rights transaction. Determines workflow, royalty calculation rules, and windowing strategies. [ENUM-REF-CANDIDATE: acquisition|co-production|syndication|first-run syndication|off-network syndication|international syndication|music sync|output deal — 8 candidates stripped; promote to reference product]',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews at expiry unless terminated by either party. True = auto-renews, False = expires at term end.',
    `blackout_restrictions` STRING COMMENT 'Geographic or temporal restrictions on content availability (e.g., no broadcast in certain markets during specific events, sports blackout rules). Free-text description.',
    `clearance_required_flag` BOOLEAN COMMENT 'Indicates whether additional rights clearance verification is required before content can be broadcast or distributed under this agreement. True = clearance workflow required, False = no additional clearance needed.',
    `content_rating_restriction` STRING COMMENT 'Content rating limitations imposed by this agreement (e.g., PG-13 and below only, no R-rated content). Comma-separated list of allowed ratings per MPA or TV Parental Guidelines.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this license agreement record was first created in Rightsline.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this agreement (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date when the license agreement becomes legally binding and rights become available for exploitation. Start of the agreement term.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the license grants exclusive rights within the territory and media windows. True = exclusive, False = non-exclusive.',
    `expiry_date` DATE COMMENT 'Date when the license agreement terminates and rights revert to the licensor. End of the agreement term. Nullable for perpetual agreements.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction whose laws govern the interpretation and enforcement of this agreement (e.g., State of California, England and Wales, New York).',
    `holdback_period_days` STRING COMMENT 'Number of days during which content must be withheld from certain distribution windows to protect exclusivity in other windows (e.g., theatrical holdback before SVOD release).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this license agreement record was last updated in Rightsline.',
    `media_rights_granted` STRING COMMENT 'Comma-separated list of media exploitation rights included in this agreement (e.g., linear broadcast, SVOD, AVOD, TVOD, theatrical, home video, digital download, mobile streaming).',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment to the licensor regardless of actual usage or revenue performance. Common in output deals and syndication agreements.',
    `music_sync_license_flag` BOOLEAN COMMENT 'Indicates whether this agreement includes music synchronization rights for use of musical compositions in audiovisual content. True = music sync rights included, False = no music sync rights.',
    `notes` STRING COMMENT 'Free-text field for additional contractual terms, special conditions, or internal comments about the agreement.',
    `payment_schedule_type` STRING COMMENT 'Structure of the payment obligation. Determines how total_license_fee is disbursed over time.. Valid values are `lump sum|installments|per-episode|annual|milestone-based|revenue share`',
    `per_episode_fee` DECIMAL(18,2) COMMENT 'License fee charged per episode for episodic content. Applicable to syndication and first-run syndication agreements.',
    `renewal_term_months` STRING COMMENT 'Duration in months of each automatic renewal period if auto_renewal_flag is true. Null if agreement does not auto-renew.',
    `residuals_obligation_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes obligations to pay talent residuals for reuse of content. True = residuals required, False = no residuals.',
    `royalty_calculation_method` STRING COMMENT 'Method used to calculate ongoing royalty payments to the licensor. Determines how revenue is shared or how usage is monetized.. Valid values are `flat fee|percentage of revenue|tiered percentage|per-unit|hybrid`',
    `royalty_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue or receipts paid to the licensor as ongoing royalties. Applicable when royalty_calculation_method is percentage-based.',
    `run_count_limit` STRING COMMENT 'Maximum number of times each episode or program may be broadcast or streamed under this agreement. Common in syndication deals. Null indicates unlimited runs.',
    `signed_date` DATE COMMENT 'Date when the agreement was executed by all parties. May differ from effective_date.',
    `sublicensing_allowed_flag` BOOLEAN COMMENT 'Indicates whether the licensee is permitted to sublicense the rights to third parties. True = sublicensing allowed, False = sublicensing prohibited.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the agreement before expiry or renewal.',
    `territory_scope` STRING COMMENT 'Geographic territories covered by this license agreement. Comma-separated list of ISO 3166-1 alpha-3 country codes or region identifiers (e.g., USA,CAN,MEX or WORLDWIDE or EMEA).',
    `total_license_fee` DECIMAL(18,2) COMMENT 'Total contractual payment obligation for the license rights over the full term of the agreement. Sum of all payment milestones.',
    `windowing_strategy` STRING COMMENT 'Sequential release strategy defining the order and timing of content availability across distribution channels (theatrical, SVOD, AVOD, TVOD, linear, syndication). Free-text description of the windowing plan.',
    CONSTRAINT pk_license_agreement PRIMARY KEY(`license_agreement_id`)
) COMMENT 'Master record for all content licensing, acquisition, and syndication agreements managed in Rightsline. Captures the full contractual relationship between Media Broadcasting and rights grantors or licensees (studios, distributors, music publishers, talent guilds, syndication partners). Stores agreement type (acquisition, co-production, syndication, first-run syndication, off-network syndication, international syndication, music sync, output deal), licensor and licensee identities, effective and expiry dates, territory scope, exclusivity flags, total license fee, payment schedule with milestone detail (advances, minimum guarantees, per-episode fees, annual installments), run count limitations for syndication, governing law jurisdiction, and agreement status (draft, executed, expired, terminated). This is the SSOT for all rights-bearing contracts and the anchor entity for all downstream window, royalty, and clearance records.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` (
    `grant_id` BIGINT COMMENT 'Unique identifier for the rights grant record. Primary key.',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Rights grants must enforce content rating restrictions by territory. Clearance workflow validates that granted rights comply with rating-based distribution restrictions (e.g., TV-MA content on childre',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Distribution agreements authorize specific rights grants for carriage and streaming. Distribution rights teams need to trace which distribution agreement authorized each grant for carriage fee reconci',
    `license_agreement_id` BIGINT COMMENT 'Reference to the parent license agreement from which this grant is derived.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Rights grants for childrens content require verified COPPA compliance before exploitation. Links grant to the COPPA declaration that authorizes distribution to child audiences.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Rights grants must comply with regulatory obligations such as territorial quota requirements and must-carry mandates. Grant-level clearance_status and drm_required are driven by specific regulatory ob',
    `syndication_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.syndication_agreement. Business justification: Syndication agreements grant specific exploitation rights to syndication partners. Linking grant to syndication_agreement enables per-agreement royalty calculation, run-limit enforcement, and syndicat',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Rights grants apply to specific territories. Each rights grant covers one territory. Normalizing to territory reference eliminates redundant territory string storage and enables consistent territory m',
    `blackout_applicable` BOOLEAN COMMENT 'Indicates whether geographic or temporal blackout restrictions apply to this grant (e.g., sports blackouts, regional restrictions).',
    `carriage_fee_applicable` BOOLEAN COMMENT 'Indicates whether a carriage fee (distribution payment) is associated with this grant.',
    `clearance_status` STRING COMMENT 'Current clearance status of the grant. Indicates whether all rights verification and legal clearances have been completed.. Valid values are `pending|cleared|blocked|conditional`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rights grant record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for financial amounts in this grant (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `drm_required` BOOLEAN COMMENT 'Indicates whether DRM protection is mandated for content distributed under this grant.',
    `end_date` DATE COMMENT 'The date on which the rights grant expires and exploitation must cease. Nullable for perpetual grants.',
    `exclusivity_indicator` BOOLEAN COMMENT 'Indicates whether the grant is exclusive (true) or non-exclusive (false). Exclusive grants prevent other parties from exploiting the same rights in the same territory and window.',
    `grant_number` STRING COMMENT 'Business identifier for the rights grant, typically a human-readable code used in Rightsline and operational workflows.',
    `grant_status` STRING COMMENT 'Current lifecycle status of the rights grant. Reflects whether the grant is currently in force, expired, or otherwise inactive.. Valid values are `active|expired|suspended|terminated|pending`',
    `holdback_applicable` BOOLEAN COMMENT 'Indicates whether a holdback period applies to this grant. Holdbacks restrict exploitation during specific windows to protect other distribution channels.',
    `holdback_end_date` DATE COMMENT 'The end date of the holdback period, after which exploitation may resume. Nullable if no holdback applies.',
    `holdback_start_date` DATE COMMENT 'The start date of any holdback period during which exploitation is restricted. Nullable if no holdback applies.',
    `language_version` STRING COMMENT 'Language version of the content covered by this grant (e.g., English, Spanish, French). May reference dubbed, subtitled, or original language versions.',
    `media_type` STRING COMMENT 'The media format or delivery mechanism covered by this grant (e.g., television, film, digital streaming, audio).. Valid values are `television|film|digital|audio|print|mobile`',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment amount for this grant, regardless of actual revenue. Nullable if no MG applies.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rights grant record was last modified.',
    `music_sync_license_required` BOOLEAN COMMENT 'Indicates whether a separate music synchronization license is required for the music tracks embedded in the content.',
    `notes` STRING COMMENT 'Free-text notes capturing additional terms, conditions, or operational instructions related to this grant.',
    `right_type` STRING COMMENT 'Type of distribution or exploitation right granted. Defines the platform or medium for which the content may be used. [ENUM-REF-CANDIDATE: broadcast|svod|avod|tvod|theatrical|home_video|music_sync|podcast|linear|non_linear|vod — 11 candidates stripped; promote to reference product]',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Percentage royalty rate applied to revenue generated under this grant. Used for royalty calculations.',
    `start_date` DATE COMMENT 'The date on which the rights grant becomes effective and exploitation may begin.',
    `sublicense_permitted` BOOLEAN COMMENT 'Indicates whether the licensee is permitted to sublicense the rights to third parties.',
    `talent_residuals_applicable` BOOLEAN COMMENT 'Indicates whether talent residual payments (reuse payments to actors, directors, writers) are triggered by this grant.',
    `window_name` STRING COMMENT 'Named distribution window (e.g., Theatrical, Premium VOD, Pay-TV, Free-TV) that this grant falls within. Used for windowing strategy enforcement.',
    CONSTRAINT pk_grant PRIMARY KEY(`grant_id`)
) COMMENT 'Granular rights entitlement record derived from a license agreement. Each row represents a specific bundle of rights granted for a content asset — capturing right type (broadcast, SVOD, AVOD, TVOD, theatrical, home video, music sync, podcast), media type, territory or territory group, language version, exclusivity indicator, holdback applicability, and the grant period (start and end dates). Multiple grants can exist per agreement and per content asset. Feeds the availability engine in scheduling and distribution domains. Powered by Rightsline availabilities module.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` (
    `content_window_id` BIGINT COMMENT 'Unique identifier for the content window record. Primary key for the rights content window entity.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: A rights_content_window defines the sequential release window strategy derived from a specific grant (the granular rights entitlement). While rights_content_window already links to license_agreement a',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Content windows define platform-specific availability ("Hulu exclusive 45-day window"); direct platform FK required for platform availability APIs, automated clearance in release planning, and platfor',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Content windows apply to specific territories. Each window covers one territory. Normalizing to territory reference eliminates redundant territory string storage and enables consistent territory metad',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this window record is currently active and should be considered in availability calculations. False if the window has been superseded, cancelled, or archived.',
    `availability_status` STRING COMMENT 'The computed net availability status of the content for this window, considering window dates, holdbacks, and blackouts. Refreshed whenever upstream rights or holdback records change. Directly consumed by scheduling and distribution domains to validate playout eligibility.. Valid values are `available|held_back|blacked_out|expired|pending`',
    `blackout_flag` BOOLEAN COMMENT 'Indicates whether a geographic or temporal blackout restriction is currently active for this window. True if content is blacked out and cannot be distributed; false otherwise.',
    `blackout_reason` STRING COMMENT 'The business or regulatory reason for the blackout restriction (e.g., sports event local blackout, contractual exclusivity, regulatory compliance). Populated only when blackout_flag is true.',
    `clearance_notes` STRING COMMENT 'Free-text notes documenting clearance issues, pending approvals, conditional restrictions, or special instructions related to rights clearance for this window.',
    `clearance_status` STRING COMMENT 'The current status of the rights clearance workflow for this window. Indicates whether all necessary rights, music licenses, talent approvals, and regulatory clearances have been obtained to authorize distribution.. Valid values are `cleared|pending|rejected|conditional`',
    `created_by_user` STRING COMMENT 'The username or identifier of the user who created this window record. Audit field for accountability and compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this window record was first created in the system. Audit field for data lineage and compliance.',
    `drm_requirement` STRING COMMENT 'The DRM technology or protection scheme required for content distribution during this window. Enforces content protection and anti-piracy requirements specified in the rights agreement.. Valid values are `widevine|fairplay|playready|none|multi_drm`',
    `exclusivity_tier` STRING COMMENT 'The level of exclusivity granted for this window. Exclusive windows prevent simultaneous distribution on competing platforms; non-exclusive allows parallel exploitation. First and second window designations indicate priority in the windowing hierarchy.. Valid values are `exclusive|non_exclusive|first_window|second_window`',
    `geo_blocking_required_flag` BOOLEAN COMMENT 'Indicates whether geographic blocking technology must be enforced to restrict access to the specified territory. True if geo-blocking is mandatory; false if not required.',
    `holdback_end_date` DATE COMMENT 'The date when a holdback period ends and distribution is re-authorized. Marks the conclusion of the exclusivity restriction.',
    `holdback_start_date` DATE COMMENT 'The date when a holdback period begins, temporarily restricting distribution even within an open window. Used to enforce exclusivity periods and prevent simultaneous exploitation across competing platforms.',
    `last_availability_refresh_timestamp` TIMESTAMP COMMENT 'The timestamp when the availability_status was last recalculated. Updated whenever upstream rights, holdback, or blackout records change. Used to track data freshness for scheduling and distribution systems.',
    `license_fee_amount` DECIMAL(18,2) COMMENT 'The monetary fee paid by the platform or distributor for the rights to exploit the content during this window. May be a flat fee, minimum guarantee, or advance against royalties.',
    `license_fee_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the license fee amount (e.g., USD, GBP, EUR).',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'The minimum guaranteed payment amount that the distributor or platform must pay regardless of actual revenue or usage. Common in SVOD and licensing deals.',
    `modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this window record. Audit field for accountability and compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this window record was last modified. Audit field for change tracking and data lineage.',
    `platform_scope` STRING COMMENT 'The specific platform, channel, service, or outlet authorized for distribution during this window (e.g., Netflix, HBO Max, ABC Network, theatrical chain). May be a single platform or a platform group.',
    `revenue_share_percent` DECIMAL(18,2) COMMENT 'The percentage of gross or net revenue that the rights holder receives from exploitation during this window. Common in TVOD, AVOD, and theatrical windows.',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'The percentage rate applied to revenue or usage to calculate royalty payments for this window. Used when the window operates under a revenue-sharing or usage-based royalty model.',
    `sublicense_permitted_flag` BOOLEAN COMMENT 'Indicates whether the platform or distributor is authorized to sublicense the content to third parties during this window. True if sublicensing is permitted; false if prohibited.',
    `usage_cap_type` STRING COMMENT 'The unit of measure for the usage cap (e.g., streams for SVOD, broadcasts for linear, screenings for theatrical). Defines how usage is counted against the cap.. Valid values are `streams|downloads|broadcasts|screenings|impressions`',
    `usage_cap_units` STRING COMMENT 'The maximum number of usage units (streams, downloads, broadcasts, screenings) permitted during this window. Used to enforce contractual usage limits.',
    `window_close_date` DATE COMMENT 'The date when this exploitation window ends and the content is no longer authorized for distribution on the specified platform. End of the availability period. Nullable for perpetual windows.',
    `window_extension_count` STRING COMMENT 'The number of times this window has been extended beyond its original close date. Tracks amendments and extensions to the original window terms.',
    `window_open_date` DATE COMMENT 'The date when this exploitation window becomes active and the content is authorized for distribution on the specified platform. Start of the availability period.',
    `window_priority` STRING COMMENT 'The numeric priority or sequence order of this window in the overall windowing strategy. Lower numbers indicate earlier windows in the release hierarchy (e.g., 1 for theatrical, 2 for PVOD, 3 for SVOD). Used to enforce windowing hierarchy rules.',
    `window_type` STRING COMMENT 'The exploitation window category defining the distribution model and platform type. Determines the sequential release strategy position in the windowing hierarchy. [ENUM-REF-CANDIDATE: theatrical|pvod|tvod|svod|avod|linear|fast|home_video|syndication|vod — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_content_window PRIMARY KEY(`content_window_id`)
) COMMENT 'Defines the sequential release window strategy (windowing) for a specific content asset across exploitation platforms, and computes the net availability status. Each record captures the window type (theatrical, PVOD, TVOD, SVOD, AVOD, linear, FAST, home video, syndication), platform or channel scope, window open and close dates, holdback start and end dates, territory, exclusivity tier, and computed availability status (available, held-back, blacked-out, expired). Enforces the windowing hierarchy that prevents simultaneous exploitation across competing platforms. The net availability (considering holdbacks and blackouts) is refreshed whenever upstream rights or holdback records change. Directly consumed by scheduling and distribution domains to validate playout eligibility. Powered by Rightsline Windows module.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` (
    `holdback_id` BIGINT COMMENT 'Unique identifier for the holdback restriction record. Primary key.',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Distribution agreements impose exclusivity-based holdbacks on competing platforms and channels. Rights enforcement teams must link holdbacks to the triggering distribution agreement to enforce blackou',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Holdbacks restrict specific rights grants. Each holdback applies to one rights grant, establishing which exploitation rights are being restricted. This FK enables tracing holdback restrictions back to',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Holdbacks frequently restrict specific platforms ("no Netflix for 90 days post-theatrical"); direct platform FK required for automated enforcement in clearance workflows, platform availability filteri',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Holdbacks are frequently mandated by regulatory obligations (e.g., FCC sports blackout rules, syndication exclusivity regulations). holdback.enforcement_status and automated_enforcement_flag require t',
    `subscription_plan_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscription_plan. Business justification: Holdbacks restrict content from specific subscription tiers (e.g., content held back from basic tier during premium window). Linking holdback to subscription_plan enables tier-level holdback enforceme',
    `sweeps_period_id` BIGINT COMMENT 'Foreign key linking to audience.sweeps_period. Business justification: Sweeps holdback enforcement: holdbacks are frequently triggered or extended during sweeps periods to protect ratings by blocking competitor content. Rights operations teams need to identify holdbacks ',
    `syndication_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.syndication_agreement. Business justification: Syndication agreements impose holdbacks on competing broadcast windows during exclusivity periods. Rights teams must reference the syndication agreement to enforce holdback_period_days, validate exclu',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Holdbacks apply to specific territories. Each holdback restricts one territory. Normalizing to territory reference eliminates redundant territory string storage and enables consistent territory metada',
    `content_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_content_window. Business justification: holdback already has a triggering_window_type STRING attribute that captures the type of window that triggered the holdback (e.g., theatrical window triggers SVOD holdback). Adding triggering_rights_c',
    `automated_enforcement_flag` BOOLEAN COMMENT 'Indicates whether this holdback restriction is automatically enforced by scheduling and distribution systems or requires manual review.',
    `carriage_negotiation_reference` STRING COMMENT 'Reference identifier to the MVPD or vMVPD carriage negotiation that established this holdback restriction.',
    `clearance_workflow_status` STRING COMMENT 'Status of the clearance workflow process that validates whether content can be scheduled or distributed despite this holdback restriction.. Valid values are `not_submitted|pending_review|approved|rejected|escalated`',
    `holdback_code` STRING COMMENT 'Business identifier code for the holdback restriction, used for external reference and clearance workflows.. Valid values are `^HB-[A-Z0-9]{6,12}$`',
    `conflict_resolution_notes` STRING COMMENT 'Documentation of any conflicts with other rights, windows, or holdbacks and how they were resolved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this holdback restriction record was first created in the system.',
    `duration_days` STRING COMMENT 'Total number of days the holdback restriction is in effect, calculated from start to end date.',
    `end_date` DATE COMMENT 'Date when the holdback restriction expires and the content becomes available for exploitation on the previously restricted platform, territory, channel, or format.',
    `enforcement_status` STRING COMMENT 'Current enforcement state of the holdback restriction, indicating whether it is actively blocking content exploitation or has been modified.. Valid values are `active|expired|waived|overridden|pending|suspended`',
    `exclusivity_scope` STRING COMMENT 'Scope of exclusivity granted by this holdback, defining whether the restriction is absolute or allows limited exploitation.. Valid values are `full_exclusive|partial_exclusive|non_exclusive`',
    `last_modified_by` STRING COMMENT 'User or system identifier that last modified this holdback restriction record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this holdback restriction record was last updated or modified.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether notification of this holdback restriction has been sent to relevant scheduling, distribution, and operations teams.',
    `priority_level` STRING COMMENT 'Business priority assigned to this holdback restriction, indicating its importance in windowing strategy and enforcement.. Valid values are `critical|high|medium|low`',
    `restricted_channel` STRING COMMENT 'Specific broadcast or distribution channel that is restricted from airing or distributing the content during the holdback period.',
    `restricted_format` STRING COMMENT 'Distribution format or delivery method that is restricted during the holdback period, supporting windowing strategies. [ENUM-REF-CANDIDATE: theatrical|linear_tv|svod|avod|tvod|vod|physical_media|syndication|streaming|broadcast — 10 candidates stripped; promote to reference product]',
    `restriction_type` STRING COMMENT 'Classification of the holdback restriction type that defines the nature of the exclusivity period.. Valid values are `platform_holdback|territory_holdback|channel_holdback|format_holdback|daypart_holdback|exclusive_holdback`',
    `start_date` DATE COMMENT 'Date when the holdback restriction becomes effective and the content is blocked from the specified platform, territory, channel, or format.',
    `triggering_window_type` STRING COMMENT 'Type of content window that triggers or activates this holdback restriction, defining the sequential release strategy. [ENUM-REF-CANDIDATE: theatrical|svod|avod|tvod|linear|syndication|home_video|pay_per_view|free_tv|premium_tv — 10 candidates stripped; promote to reference product]',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the person or role who authorized the waiver or override of the holdback restriction.',
    `waiver_approved_date` DATE COMMENT 'Date when the waiver or override of the holdback restriction was officially approved.',
    `waiver_reason` STRING COMMENT 'Business justification or explanation for waiving or overriding the holdback restriction, if applicable.',
    `windowing_strategy_notes` STRING COMMENT 'Additional notes or context explaining how this holdback fits into the overall content windowing and sequential release strategy.',
    `created_by` STRING COMMENT 'User or system identifier that created this holdback restriction record.',
    CONSTRAINT pk_holdback PRIMARY KEY(`holdback_id`)
) COMMENT 'Records exclusivity holdback restrictions that prevent a content asset from being exploited on a specific platform, territory, or channel during a defined period. Each holdback captures the restriction type (platform holdback, territory holdback, channel holdback, format holdback), the restricted platform or distributor, holdback start and end dates, the triggering window type and source window reference, the source license agreement, and enforcement status (active, expired, waived, overridden). Holdbacks are enforced by the clearance workflow before any scheduling or distribution action is approved. Critical for MVPD carriage negotiations, OTT windowing compliance, and theatrical-to-home-video sequencing. Links to rights_content_window and license_agreement.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` (
    `territory_id` BIGINT COMMENT 'Unique identifier for the geographic territory. Primary key.',
    `broadcast_license_id` BIGINT COMMENT '',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Territory-level rights are governed by specific regulatory obligations (GDPR, COPPA, quota requirements, broadcast standards). rights_territory.regulatory_body is a denormalized string reference to th',
    `blackout_restricted_flag` BOOLEAN COMMENT 'Indicates whether the territory is subject to geographic blackout restrictions for certain content (e.g., sports events, theatrical windows). True if blackouts apply, False otherwise.',
    `broadcast_standard` STRING COMMENT 'Technical broadcast television standard used in the territory (e.g., ATSC for North America, DVB for Europe, ISDB for Japan). Determines encoding and transmission requirements for linear distribution. [ENUM-REF-CANDIDATE: atsc|dvb|isdb|dtmb|ntsc|pal|secam — 7 candidates stripped; promote to reference product]',
    `territory_code` STRING COMMENT 'ISO 3166-1 alpha-2 or alpha-3 country code representing the territory (e.g., US, USA, GB, GBR). Standardized identifier used in rights grants and distribution agreements.. Valid values are `^[A-Z]{2,3}$`',
    `content_rating_system` STRING COMMENT 'Official content classification and rating system used in the territory (e.g., TV-MA/TV-PG for USA, BBFC for UK, FSK for Germany). Governs age-appropriate content labeling and parental controls.',
    `coppa_applicable_flag` BOOLEAN COMMENT 'Indicates whether the territory is subject to COPPA regulations governing childrens data privacy (USA). True if COPPA applies, False otherwise. Enforces parental consent for childrens content and data collection.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the territory record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the territory (e.g., USD, GBP, EUR, JPY). Used for royalty calculations, license fee invoicing, and revenue reporting.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date when the territory record became active and available for rights grants and distribution agreements. Format: yyyy-MM-dd.',
    `expiration_date` DATE COMMENT 'Date when the territory record expires or is no longer valid for new rights grants (nullable for indefinite territories). Format: yyyy-MM-dd.',
    `gdpr_applicable_flag` BOOLEAN COMMENT 'Indicates whether the territory is subject to GDPR data privacy regulations (EU member states and EEA). True if GDPR applies, False otherwise. Governs audience data collection and consent management.',
    `holdback_eligible_flag` BOOLEAN COMMENT 'Indicates whether the territory is eligible for holdback periods in windowing strategies (e.g., delaying SVOD release to protect theatrical revenue). True if holdbacks apply, False otherwise.',
    `internet_penetration_percent` DECIMAL(18,2) COMMENT 'Percentage of the population with internet access in the territory (e.g., 95.00 for USA, 60.00 for India). Used for OTT and streaming market opportunity assessment.',
    `iso_alpha_2_code` STRING COMMENT 'Two-letter ISO 3166-1 alpha-2 country code (e.g., US, GB, CA). Used for system integrations and data exchange with distribution platforms.. Valid values are `^[A-Z]{2}$`',
    `iso_alpha_3_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code (e.g., USA, GBR, CAN). Provides additional clarity for territories with similar two-letter codes.. Valid values are `^[A-Z]{3}$`',
    `iso_numeric_code` STRING COMMENT 'Three-digit ISO 3166-1 numeric country code (e.g., 840 for USA, 826 for GBR). Language-independent identifier for international systems.. Valid values are `^[0-9]{3}$`',
    `language_primary` STRING COMMENT 'ISO 639-1 or ISO 639-2 code for the primary language spoken in the territory (e.g., en for English, es for Spanish, fr for French). Used for metadata localization and subtitle requirements.. Valid values are `^[a-z]{2,3}$`',
    `language_secondary` STRING COMMENT 'ISO 639-1 or ISO 639-2 code for a secondary or co-official language in the territory (e.g., fr for Canada, ca for Spain). Supports multi-language content delivery and compliance.. Valid values are `^[a-z]{2,3}$`',
    `territory_name` STRING COMMENT 'Full official name of the territory (e.g., United States, United Kingdom, Canada). Human-readable identifier used in contracts and reporting.',
    `notes` STRING COMMENT 'Free-text field for additional territory-specific information, special handling instructions, or regulatory nuances (e.g., Requires local dubbing for theatrical release, Subject to military censorship).',
    `ott_market_maturity` STRING COMMENT 'Classification of the territorys OTT streaming market maturity: mature (high penetration, competitive), developing (growing adoption), emerging (early stage), nascent (minimal infrastructure). Informs distribution strategy and rights pricing.. Valid values are `mature|developing|emerging|nascent`',
    `population` BIGINT COMMENT 'Total population of the territory. Used for audience reach estimation, market sizing, and rights valuation.',
    `quota_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage of local or regional content required by regulation in the territory (e.g., 30.00 for EU, 0.00 for territories without quotas). Used for compliance reporting and content acquisition planning.',
    `quota_requirement_flag` BOOLEAN COMMENT 'Indicates whether the territory mandates local content quotas for broadcasters and streaming platforms (e.g., EU Audiovisual Media Services Directive requiring 30% European content). True if quotas apply, False otherwise.',
    `rights_territory_status` STRING COMMENT 'Current operational status of the territory in the rights management system: active (available for licensing), inactive (not currently used), restricted (subject to special clearance), pending (under review for activation).. Valid values are `active|inactive|restricted|pending`',
    `territory_group` STRING COMMENT 'Regional grouping of the territory used for rights aggregation and windowing strategies (e.g., EMEA, LATAM, North America, Worldwide, APAC). Enables multi-territory licensing and holdback management. [ENUM-REF-CANDIDATE: worldwide|north_america|latin_america|emea|apac|europe|asia|africa|middle_east|oceania — 10 candidates stripped; promote to reference product]',
    `territory_type` STRING COMMENT 'Classification of the territory scope: country (single nation), region (multi-country group), worldwide (global rights), or custom (bespoke territory definition).. Valid values are `country|region|worldwide|custom`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the territory (e.g., America/New_York, Europe/London, Asia/Tokyo). Used for scheduling, playout, and live event coordination.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the territory record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `vat_applicable_flag` BOOLEAN COMMENT 'Indicates whether Value-Added Tax (VAT) or Goods and Services Tax (GST) applies to transactions in the territory. True if VAT/GST applies, False otherwise. Used for royalty and subscription billing calculations.',
    `vat_rate_percent` DECIMAL(18,2) COMMENT 'Standard VAT or GST rate percentage applicable in the territory (e.g., 20.00 for UK, 19.00 for Germany, 0.00 for territories without VAT). Used for financial reconciliation and revenue recognition.',
    `withholding_tax_rate_percent` DECIMAL(18,2) COMMENT 'Standard withholding tax rate percentage applied to royalty payments to rights holders in the territory (e.g., 30.00 for USA non-resident aliens, 0.00 for domestic). Used for talent residuals and royalty calculations.',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'Reference master for geographic territories and territory groups used in rights grants, holdbacks, and royalty calculations. Each record defines a territory by ISO country code, territory name, territory group (e.g., EMEA, LATAM, North America, Worldwide), broadcast regulatory body (FCC, Ofcom, etc.), currency, and whether the territory is subject to blackout restrictions. Provides the standardized territory taxonomy consumed by all rights, scheduling, and distribution products.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` (
    `royalty_rule_id` BIGINT COMMENT 'Unique identifier for the royalty calculation rule. Primary key.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Royalty rules may apply to specific rights grants. Each rule may apply to one rights grant, defining how royalties are calculated for that grant. This FK enables tracing royalty rules back to the spec',
    `guild_affiliation_id` BIGINT COMMENT 'Foreign key linking to talent.guild_affiliation. Business justification: Guild CBAs (SAG-AFTRA, WGA, DGA) directly dictate royalty calculation formulas and residual rates. Linking royalty_rule to the governing guild_affiliation enables CBA-compliant royalty computation, gu',
    `license_agreement_id` BIGINT COMMENT 'Reference to the parent license agreement or rights grant to which this royalty rule applies. Links this rule to the contract context in Rightsline.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Royalty rules in broadcasting are mandated by regulatory obligations (SAG-AFTRA guild agreements, ASCAP/BMI statutory licensing, compulsory license rate schedules). royalty_rule.audit_rights_flag and ',
    `subscription_plan_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscription_plan. Business justification: Royalty rates differ by subscription tier (AVOD vs. SVOD vs. premium). Linking royalty_rule to subscription_plan enables precise per-tier royalty calculation — a contractual requirement in streaming r',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Royalty rates vary by territory per license agreements (UK 15%, US 20%, Canada 18%); direct territory FK required for automated royalty calculation engine, territory-based royalty reporting, and curre',
    `approval_status` STRING COMMENT 'Approval status of the royalty rule within the rights management workflow (e.g., pending, approved, rejected).. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this royalty rule. Nullable if not yet approved.',
    `approved_date` DATE COMMENT 'Date on which this royalty rule was approved. Nullable if not yet approved.',
    `audit_rights_flag` BOOLEAN COMMENT 'Indicates whether the rights holder has audit rights to verify royalty calculations under this rule. True if audit rights are granted, False otherwise.',
    `calculation_basis` STRING COMMENT 'The financial or usage metric upon which the royalty calculation is based (e.g., gross revenue, net revenue, subscriber count, stream count, GRP). [ENUM-REF-CANDIDATE: gross_revenue|net_revenue|subscriber_count|stream_count|grp|unit_sales|advertising_revenue — 7 candidates stripped; promote to reference product]',
    `content_type` STRING COMMENT 'The type of content to which this royalty rule applies (e.g., film, series, episode, music, documentary, sports, news, short-form). [ENUM-REF-CANDIDATE: film|series|episode|music|documentary|sports|news|short_form — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this royalty rule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary amounts in this royalty rule (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `deduction_allowed_flag` BOOLEAN COMMENT 'Indicates whether deductions (e.g., distribution costs, marketing expenses) are allowed before calculating the royalty. True if deductions are permitted, False otherwise.',
    `deduction_percentage` DECIMAL(18,2) COMMENT 'The percentage of revenue or basis that may be deducted before applying the royalty rate. Nullable if no deduction applies.',
    `effective_end_date` DATE COMMENT 'The date on which this royalty rule ceases to be active. Nullable for open-ended rules.',
    `effective_start_date` DATE COMMENT 'The date from which this royalty rule becomes active and applicable to royalty calculations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this royalty rule record was last updated or modified.',
    `maximum_cap_amount` DECIMAL(18,2) COMMENT 'The maximum royalty payment cap for this rule. Royalty calculations will not exceed this amount. Nullable if no cap applies.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'The minimum guaranteed royalty payment amount for this rule, regardless of calculated royalty. Nullable if no minimum guarantee applies.',
    `notes` STRING COMMENT 'Free-text notes or comments about this royalty rule, including special conditions, exceptions, or clarifications.',
    `payment_frequency` STRING COMMENT 'The frequency at which royalty payments calculated by this rule are made (e.g., monthly, quarterly, semi-annually, annually, per event, on demand).. Valid values are `monthly|quarterly|semi_annually|annually|per_event|on_demand`',
    `payment_timing` STRING COMMENT 'The timing of royalty payments relative to the calculation period (e.g., advance, arrears, upon delivery, upon release, milestone-based).. Valid values are `advance|arrears|upon_delivery|upon_release|milestone_based`',
    `platform_type` STRING COMMENT 'The distribution platform or exploitation type to which this royalty rule applies (e.g., SVOD, AVOD, TVOD, linear, theatrical, syndication). [ENUM-REF-CANDIDATE: svod|avod|tvod|linear|theatrical|syndication|vod|ott|fast — 9 candidates stripped; promote to reference product]',
    `rate_unit` STRING COMMENT 'The unit of measure for the rate value (e.g., percentage, per stream, per subscriber, per unit, per GRP, flat amount).. Valid values are `percentage|per_stream|per_subscriber|per_unit|per_grp|flat_amount`',
    `rate_value` DECIMAL(18,2) COMMENT 'The numeric rate or percentage applied in the royalty calculation. For percentage-based royalties, this is the percentage (e.g., 15.5 for 15.5%). For per-unit rates, this is the amount per unit.',
    `recoupment_flag` BOOLEAN COMMENT 'Indicates whether this royalty rule includes recoupment provisions (e.g., advance payments must be recouped before additional royalties are paid). True if recoupment applies, False otherwise.',
    `recoupment_threshold` DECIMAL(18,2) COMMENT 'The monetary threshold that must be recouped before additional royalty payments are made. Nullable if no recoupment applies.',
    `residual_formula` STRING COMMENT 'The formula or calculation logic for residual payments to talent (actors, directors, writers) based on reuse, reruns, or secondary exploitation. Nullable if not applicable.',
    `royalty_rule_status` STRING COMMENT 'Current lifecycle status of the royalty rule (e.g., draft, active, suspended, expired, terminated).. Valid values are `draft|active|suspended|expired|terminated`',
    `royalty_type` STRING COMMENT 'The type of royalty calculation method applied by this rule. Determines how the royalty amount is computed.. Valid values are `flat_fee|revenue_share_percentage|per_stream_rate|per_unit_rate|residual_formula|minimum_guarantee`',
    `rule_code` STRING COMMENT 'Business-assigned unique code or identifier for this royalty rule, used for reference in contracts and reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `rule_name` STRING COMMENT 'Human-readable name or title of the royalty rule, describing its purpose or scope (e.g., SVOD Revenue Share - Tier 1, Per-Stream Rate - Music Sync).',
    `rule_priority` STRING COMMENT 'The priority or precedence of this royalty rule when multiple rules may apply to the same content or transaction. Lower numbers indicate higher priority.',
    `threshold_unit` STRING COMMENT 'The unit of measure for the threshold value (e.g., revenue, subscriber count, stream count, unit count, GRP).. Valid values are `revenue|subscriber_count|stream_count|unit_count|grp`',
    `threshold_value` DECIMAL(18,2) COMMENT 'The threshold value that triggers a rate tier change or special calculation logic (e.g., revenue threshold for tiered royalty rates).',
    CONSTRAINT pk_royalty_rule PRIMARY KEY(`royalty_rule_id`)
) COMMENT 'Defines the royalty calculation rules and rate structures associated with a license agreement or rights grant. Captures royalty type (flat fee, revenue share percentage, per-stream rate, per-unit rate, residual formula), calculation basis (gross revenue, net revenue, subscriber count, stream count, GRP), applicable platform or exploitation type, rate tiers and thresholds, minimum guarantee amounts, and effective date range. Serves as the configuration engine for the royalty calculation process in Rightsline. Distinct from actual royalty payment transactions.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` (
    `royalty_statement_id` BIGINT COMMENT 'Unique identifier for the royalty statement. Primary key.',
    `acquisition_deal_id` BIGINT COMMENT 'Foreign key linking to partner.acquisition_deal. Business justification: Royalty statements report exploitation of content acquired under specific acquisition deals. Finance teams reconcile statement gross royalties against deal MG amounts and recoupment thresholds — direc',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Royalty statements are financial obligations issued to rights holders with billing accounts. The royalty operations and AR teams need this link for payment processing, dunning, and outstanding balance',
    `guild_affiliation_id` BIGINT COMMENT 'Foreign key linking to talent.guild_affiliation. Business justification: Guild residual statements (SAG-AFTRA, WGA, DGA) require identification of the applicable guild for pension/health contribution calculations and CBA-mandated residual distribution. This is a direct reg',
    `holder_id` BIGINT COMMENT 'Identifier of the rights holder (licensor, talent guild, music publisher, or syndication partner) to whom this statement is issued. Links to the party receiving royalty payments.',
    `license_agreement_id` BIGINT COMMENT 'Identifier of the underlying rights agreement or contract that governs the royalty terms for this statement.',
    `minimum_guarantee_id` BIGINT COMMENT 'Foreign key linking to partner.minimum_guarantee. Business justification: Royalty statements directly drive MG recoupment calculations — each statement periods net royalties reduce the outstanding MG balance. Finance teams must link statements to the specific MG instrument',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Royalty statements trigger GL postings for royalty expense accrual, payment processing, and advance recoupment. Required for month-end close, royalty expense recognition, and financial audit trail lin',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Royalty statements must satisfy specific regulatory obligations governing reporting frequency, documentation retention, and financial disclosure (e.g., guild residual reporting mandates, statutory lic',
    `sweeps_period_id` BIGINT COMMENT 'Foreign key linking to audience.sweeps_period. Business justification: Sweeps royalty reconciliation: royalty statements covering sweeps periods have distinct calculation bases and elevated exploitation values. Rights accountants need to identify sweeps-period statements',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Net adjustment amount applied to this statement for corrections, credits, or debits from prior periods.',
    `advance_recoupment_amount` DECIMAL(18,2) COMMENT 'Amount deducted from gross royalties to recoup advances previously paid to the rights holder under the agreement.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or system that approved this royalty statement for payment.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this royalty statement was approved for payment.',
    `content_title_breakdown` STRING COMMENT 'Structured breakdown of royalties by content title or asset. Stored as JSON or delimited string for detailed reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this royalty statement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which royalty amounts are denominated.. Valid values are `^[A-Z]{3}$`',
    `dispute_date` DATE COMMENT 'The date on which the rights holder formally disputed this royalty statement.',
    `dispute_reason` STRING COMMENT 'Explanation or reason provided by the rights holder if the statement status is disputed. Captures objections to calculations, missing revenues, or contractual interpretation issues.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert foreign currency revenues to the statement currency, if applicable. Rate is typically the average rate for the statement period.',
    `exploitation_type_breakdown` STRING COMMENT 'Structured breakdown of royalties by exploitation type (theatrical, SVOD, AVOD, TVOD, linear, syndication, home video, etc.). Stored as JSON or delimited string for detailed reporting.',
    `gross_royalty_amount` DECIMAL(18,2) COMMENT 'Total royalty amount earned by the rights holder before any deductions, recoupments, or adjustments.',
    `minimum_guarantee_shortfall` DECIMAL(18,2) COMMENT 'The difference between the contractual minimum guarantee and actual royalties earned for the period. A positive value indicates the rights holder is entitled to a minimum guarantee payment.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this royalty statement record was last modified or updated.',
    `net_royalty_amount` DECIMAL(18,2) COMMENT 'Final royalty amount payable to the rights holder after all deductions, recoupments, taxes, and adjustments. This is the amount that will be paid.',
    `paid_timestamp` TIMESTAMP COMMENT 'Date and time when payment for this royalty statement was successfully processed and remitted to the rights holder.',
    `payment_method` STRING COMMENT 'The payment instrument or method that will be used to remit the net royalty amount to the rights holder.. Valid values are `wire_transfer|check|ach|paypal|direct_deposit`',
    `payment_reference_number` STRING COMMENT 'Reference number or transaction identifier for the payment associated with this statement, once payment has been processed.',
    `resolution_date` DATE COMMENT 'The date on which a disputed statement was resolved and moved to approved or paid status.',
    `statement_due_date` DATE COMMENT 'The date by which payment of the royalties on this statement is contractually due to the rights holder.',
    `statement_frequency` STRING COMMENT 'The reporting frequency for this royalty statement as defined in the underlying rights agreement.. Valid values are `monthly|quarterly|semi-annual|annual|ad-hoc`',
    `statement_issue_date` DATE COMMENT 'The date on which this royalty statement was officially issued to the rights holder.',
    `statement_notes` STRING COMMENT 'Free-text notes or comments related to this royalty statement, including explanations of unusual adjustments, special circumstances, or clarifications for the rights holder.',
    `statement_number` STRING COMMENT 'Externally-known unique business identifier for this royalty statement, used for reference in correspondence and payment processing.. Valid values are `^[A-Z0-9]{6,20}$`',
    `statement_period_end_date` DATE COMMENT 'The last date of the reporting period covered by this royalty statement.',
    `statement_period_start_date` DATE COMMENT 'The first date of the reporting period covered by this royalty statement.',
    `statement_status` STRING COMMENT 'Current lifecycle status of the royalty statement. Draft statements are under review, approved statements are ready for payment, disputed statements have objections from rights holders, paid statements have been settled, and cancelled statements have been voided.. Valid values are `draft|approved|disputed|paid|cancelled`',
    `territory_breakdown` STRING COMMENT 'Structured breakdown of royalties by geographic territory or market. Stored as JSON or delimited string for detailed reporting.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Tax amount withheld from royalty payment as required by applicable tax treaties and regulations.',
    CONSTRAINT pk_royalty_statement PRIMARY KEY(`royalty_statement_id`)
) COMMENT 'Periodic royalty statement generated for a rights holder (licensor, talent guild, music publisher, or syndication partner) covering a specific reporting period. Captures statement period (monthly, quarterly, semi-annual), total royalties due, breakdown by exploitation type and territory, advance recoupment amounts, minimum guarantee shortfall, currency, exchange rate applied, and statement status (draft, approved, disputed, paid). The SSOT for royalty obligations owed to external rights holders. Feeds the billing domain for payment processing.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` (
    `royalty_statement_line_id` BIGINT COMMENT 'Unique identifier for the royalty statement line item. Primary key for this entity.',
    `ad_order_id` BIGINT COMMENT 'Foreign key linking to sales.ad_order. Business justification: Royalty statement lines represent per-exploitation-event royalty calculations. Auditors and rights holders require traceability from each royalty line to the specific ad order that generated the comme',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: royalty_statement_line represents a single exploitation event or aggregated exploitation period. Each exploitation event occurs under a specific grant (the granular rights entitlement that authorized ',
    `holder_id` BIGINT COMMENT 'Reference to the party (talent, studio, licensor) entitled to receive the royalty payment for this line. Links to the rights holder master data.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Royalty statement lines represent content exploitation that triggers revenue recognition events when content is sublicensed. Required for ASC 606/IFRS 15 compliance for content licensing revenue and p',
    `license_agreement_id` BIGINT COMMENT 'Reference to the underlying rights agreement or contract that governs this royalty calculation. Links to the master rights contract data.',
    `nielsen_rating_id` BIGINT COMMENT 'Foreign key linking to audience.nielsen_rating. Business justification: Impression-based royalty calculation: rights accountants reconcile each royalty line item against the Nielsen audience measurement for that specific air date/episode to validate units_exploited and gr',
    `role_id` BIGINT COMMENT 'Foreign key linking to talent.role. Business justification: Guild CBA residual calculations depend on the specific role category performed (series regular, guest star, day player, stunt performer). Linking statement lines to roles enables accurate CBA-complian',
    `royalty_rule_id` BIGINT COMMENT 'Foreign key linking to rights.royalty_rule. Business justification: Statement lines are calculated using royalty rules. Each line uses one royalty rule that defines the calculation formula. This FK enables tracing royalty calculations back to the authoritative royalty',
    `royalty_statement_id` BIGINT COMMENT 'Reference to the parent royalty statement that contains this line item. Links this line to the header-level statement issued to a rights holder.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Royalty statement lines track exploitation by territory. Each line relates to one territory. Normalizing to territory reference eliminates redundant territory code storage and enables consistent terri',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Royalty statements are broken down by title for rights holder reporting and audit. content_title is a plain-text denormalization; replacing with title_id enforces referential integrity and enables tit',
    `adjustments_amount` DECIMAL(18,2) COMMENT 'Additional adjustments applied to the royalty calculation, such as corrections from prior periods, contractual bonuses, penalties, or dispute resolutions. Can be positive or negative.',
    `advance_recoupment_amount` DECIMAL(18,2) COMMENT 'Portion of the calculated royalty that is applied against outstanding advances previously paid to the rights holder. Reduces the net payable amount.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this royalty line to source exploitation data, usage reports, or billing records. Enables granular audit trail and dispute resolution.',
    `calculated_royalty_amount` DECIMAL(18,2) COMMENT 'Royalty amount calculated by applying the royalty rate to the net revenue. Represents the gross royalty obligation before advance recoupment or adjustments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this royalty statement line record was first created in the system. Audit field for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts on this line. All amounts (gross revenue, deductions, royalties, payable) are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `deductions_amount` DECIMAL(18,2) COMMENT 'Total deductions applied to gross revenue before calculating royalty base. May include distribution fees, marketing costs, platform fees, or other contractually allowed deductions.',
    `dispute_status` STRING COMMENT 'Current status of any dispute or query raised by the rights holder regarding this royalty line. Tracks the resolution workflow for contested royalty calculations.. Valid values are `none|under_review|disputed|resolved|adjusted`',
    `eidr_identifier` STRING COMMENT 'Globally unique identifier for the content asset following EIDR standard format. Used for cross-industry content identification and rights tracking.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `exploitation_period_end_date` DATE COMMENT 'End date of the period during which the exploitation activity occurred. Defines the end of the reporting window for this royalty line.',
    `exploitation_period_start_date` DATE COMMENT 'Start date of the period during which the exploitation activity occurred. Defines the beginning of the reporting window for this royalty line.',
    `exploitation_type` STRING COMMENT 'Type of content exploitation that generated this royalty. Indicates the distribution channel or business model under which the content was used. [ENUM-REF-CANDIDATE: linear_broadcast|svod|avod|tvod|theatrical|syndication|home_video|digital_download — 8 candidates stripped; promote to reference product]',
    `gross_revenue_amount` DECIMAL(18,2) COMMENT 'Total gross revenue generated from the exploitation activity before any deductions, adjustments, or royalty calculations. Represents the top-line revenue attributable to this content asset.',
    `holdback_status` STRING COMMENT 'Status of any holdback or exclusivity period applicable to this exploitation. Indicates whether the content was exploited within or outside of contractual holdback restrictions.. Valid values are `active|expired|waived|not_applicable`',
    `line_number` STRING COMMENT 'Sequential line number within the royalty statement, used for ordering and reference purposes.',
    `net_payable_amount` DECIMAL(18,2) COMMENT 'Final net amount payable to the rights holder for this line item after all deductions, advance recoupment, and adjustments. This is the amount that will be paid out.',
    `net_revenue_amount` DECIMAL(18,2) COMMENT 'Net revenue after deductions, serving as the base for royalty calculation. Calculated as gross_revenue_amount minus deductions_amount.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this royalty line. May include explanations of adjustments, dispute details, or special calculation circumstances.',
    `payment_date` DATE COMMENT 'Date on which the royalty payment for this line was or will be disbursed to the rights holder. Null if payment has not yet been scheduled.',
    `payment_status` STRING COMMENT 'Current payment status for this royalty line item. Indicates whether the net payable amount has been processed for payment.. Valid values are `pending|scheduled|paid|withheld|cancelled`',
    `platform_name` STRING COMMENT 'Name of the distribution platform or service where the content was exploited (e.g., Netflix, Hulu, linear network, theatrical chain).',
    `residual_type` STRING COMMENT 'Classification of residual payment type for talent royalties. Indicates the nature of the reuse payment under guild agreements (SAG-AFTRA, WGA, DGA). [ENUM-REF-CANDIDATE: initial_use|rerun|foreign|supplemental|new_media|streaming|not_applicable — 7 candidates stripped; promote to reference product]',
    `rights_holder_name` STRING COMMENT 'Name of the rights holder receiving the royalty. Denormalized for reporting and audit trail purposes.',
    `royalty_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage rate applied to the royalty base to calculate the royalty amount. Derived from the underlying rights agreement and may vary by territory, platform, and exploitation type.',
    `unit_of_measure` STRING COMMENT 'Unit type for the units_exploited field. Clarifies how exploitation volume is measured for this line.. Valid values are `streams|broadcasts|downloads|tickets|views|impressions`',
    `units_exploited` DECIMAL(18,2) COMMENT 'Quantity of exploitation units for this line item. Interpretation depends on exploitation type: streams for SVOD/AVOD, broadcasts for linear, downloads for TVOD, tickets for theatrical.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this royalty statement line record was last modified. Audit field for tracking changes and dispute resolution history.',
    `window_type` STRING COMMENT 'Distribution window classification under which this exploitation occurred. Reflects the sequential release strategy and holdback periods defined in the rights agreement. [ENUM-REF-CANDIDATE: theatrical|home_video|pay_per_view|premium_cable|basic_cable|broadcast|svod|avod|free_streaming — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_royalty_statement_line PRIMARY KEY(`royalty_statement_line_id`)
) COMMENT 'Line-item detail within a royalty statement, representing a single exploitation event or aggregated exploitation activity for a specific content asset, territory, platform, and period. Captures content asset reference, exploitation type, territory, platform, units exploited (streams, broadcasts, downloads), gross revenue, applicable royalty rate, calculated royalty amount, advance applied, and net payable. Enables granular royalty audit trails and dispute resolution at the asset and territory level.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` (
    `clearance_request_id` BIGINT COMMENT 'Unique identifier for the rights clearance request. Primary key for the clearance request workflow record.',
    `availability_window_id` BIGINT COMMENT 'Reference to the specific rights window (theatrical, SVOD, AVOD, linear, etc.) being verified for availability. Links to windowing strategy definitions in Rightsline.',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Clearance workflow validates content rating before approving distribution. Analysts check that requested platform/daypart matches rating restrictions (e.g., TV-14 content not cleared for daytime child',
    `distribution_partner_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_partner. Business justification: Clearance requests often partner-specific ("can we clear this title for Comcast carriage?"); direct partner FK required for partner-level clearance tracking, carriage negotiation support, and dispute ',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Clearance requests validate against specific rights grants to determine if exploitation is permitted. Each clearance request checks one rights grant for authorization. This FK enables validation of ex',
    `holdback_id` BIGINT COMMENT 'Foreign key linking to rights.holdback. Business justification: Clearance requests may be blocked by specific holdbacks. Each clearance request may reference one blocking holdback that prevents exploitation. This FK enables tracing clearance denials back to the sp',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Clearance requests for childrens content must verify COPPA declaration status before approval. Ensures data collection and advertising practices comply with COPPA before content goes live.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Clearance decisions are driven by specific regulatory obligations (music clearance mandates, talent residual rules, FCC content restrictions). clearance_request.music_clearance_required and residuals_',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Clearance requests may require music sync licenses. Each request may reference one music sync license that must be validated. This FK enables tracing clearance requirements back to the specific music ',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Clearance requests are for specific territories. Each request relates to one territory. Normalizing to territory reference eliminates redundant territory code storage and enables consistent territory ',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Clearance requests are filed for specific content versions (e.g., dubbed, HD, edited-for-broadcast). Version-level clearance is a standard broadcasting workflow; without version_id, clearance records ',
    `analyst_notes` STRING COMMENT 'Free-text notes and observations recorded by the clearance analyst during review. May include references to specific contract clauses, communications with rights holders, or special handling instructions.',
    `blocking_category` STRING COMMENT 'Classification of the primary reason for clearance denial. Enables reporting on common rights obstacles and process improvement. [ENUM-REF-CANDIDATE: holdback_period|territory_restriction|window_unavailable|rights_expired|music_sync_missing|talent_approval_required|residuals_unpaid|clearance_incomplete — promote to reference product]. Valid values are `holdback_period|territory_restriction|window_unavailable|rights_expired|music_sync_missing|talent_approval_required|[ENUM-REF-CANDIDATE: holdback_period|territory_restriction|window_unavailable|rights_expired|music_sync_missing|talent_approval_required|residuals_unpaid|clearance_incomplete — promote to reference product]`',
    `blocking_reason` STRING COMMENT 'Detailed explanation of why a clearance request was blocked or denied. May reference specific contract clauses, holdback periods, territorial restrictions, or missing rights. Null if request is cleared.',
    `clearance_decision` STRING COMMENT 'Final determination made by the clearance analyst regarding whether the content may be exploited as requested. Approved with conditions may require specific usage restrictions or additional payments.. Valid values are `approved|approved_with_conditions|denied|pending_review`',
    `clearance_status` STRING COMMENT 'Current state of the clearance request workflow. Tracks progression from submission through review to final disposition. Cleared status allows content to proceed to playout; blocked status prevents distribution. [ENUM-REF-CANDIDATE: pending|in_review|cleared|conditionally_cleared|blocked|escalated|expired|cancelled — 8 candidates stripped; promote to reference product]',
    `conditional_requirements` STRING COMMENT 'Specific conditions or restrictions that must be met for conditional clearance approval. May include required credits, usage limitations, geographic blackouts, or additional royalty payments.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the clearance request record was first created in the database. Part of standard audit trail for data lineage and compliance.',
    `escalation_reason` STRING COMMENT 'Explanation of why the clearance request required escalation beyond standard analyst review. May reference contract ambiguity, conflicting rights claims, or high-value strategic decisions.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the clearance request was escalated to senior rights management or legal counsel due to complexity, ambiguity, or high business impact. Null if no escalation occurred.',
    `estimated_audience_reach` BIGINT COMMENT 'Projected number of unique viewers or households expected to access the content in the requested exploitation. Used for royalty calculations and rights holder reporting.',
    `estimated_grp` DECIMAL(18,2) COMMENT 'Projected Gross Rating Point value for the scheduled broadcast or streaming event. GRP represents the sum of ratings achieved by the content and may trigger tiered royalty obligations.',
    `estimated_residuals_amount` DECIMAL(18,2) COMMENT 'Projected total residual payments owed to talent if the clearance is approved and content is distributed. Used for financial planning and budget approval workflows.',
    `exploitation_type` STRING COMMENT 'The intended method of content distribution or monetization requiring clearance. Defines the rights window and licensing requirements that must be verified (e.g., SVOD - Subscription Video On Demand, AVOD - Advertising-Supported Video On Demand, TVOD - Transactional Video On Demand). [ENUM-REF-CANDIDATE: linear_broadcast|svod|avod|tvod|theatrical|syndication|vod|simulcast|fast|digital_download — 10 candidates stripped; promote to reference product]',
    `integration_status` STRING COMMENT 'Status of data synchronization between Rightsline clearance system and downstream scheduling and playout systems (Ericsson MediaFirst). Ensures cleared content is automatically released to scheduling workflows.. Valid values are `pending_sync|synced_to_scheduling|synced_to_playout|sync_failed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to any field in the clearance request record. Enables change tracking and audit trail for compliance and operational monitoring.',
    `music_clearance_required` BOOLEAN COMMENT 'Indicates whether separate music synchronization licenses must be verified before content can be cleared for distribution. True if content contains licensed music requiring additional clearance.',
    `platform_channel` STRING COMMENT 'Specific platform, channel, or outlet where the content is intended to be distributed (e.g., HBO Max, NBC Network, YouTube, Hulu). Used to verify platform-specific licensing restrictions.',
    `priority_level` STRING COMMENT 'Business priority assigned to the clearance request based on scheduling urgency, revenue impact, or strategic importance. Urgent requests require expedited review to avoid schedule disruption.. Valid values are `urgent|high|normal|low`',
    `request_number` STRING COMMENT 'Human-readable business identifier for the clearance request, typically formatted as CLR-YYYYMMDD sequence for tracking and reference in scheduling and distribution workflows.. Valid values are `^CLR-[0-9]{8}$`',
    `request_submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the clearance request was initially submitted into the workflow system. Marks the start of the clearance review lifecycle and SLA clock.',
    `requested_air_date` DATE COMMENT 'The target date when the content is scheduled to be broadcast, streamed, or published. Critical for verifying that rights are available within the requested window and that no holdback periods are violated.',
    `requested_air_time` TIMESTAMP COMMENT 'Precise timestamp for the intended broadcast or streaming start time, including time zone. Used for daypart-specific rights verification and scheduling coordination.',
    `requesting_department` STRING COMMENT 'Business unit or department initiating the clearance request. Identifies which operational area needs rights verification before proceeding with content exploitation.. Valid values are `scheduling|distribution|production|programming|digital|syndication`',
    `residuals_triggered` BOOLEAN COMMENT 'Indicates whether the requested exploitation will trigger residual payments to talent per guild agreements. True if reuse payments are required for this distribution window.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the clearance request was finalized with a cleared, blocked, or conditionally cleared decision. Marks the end of the clearance workflow and enables SLA compliance measurement.',
    `review_started_timestamp` TIMESTAMP COMMENT 'Date and time when a clearance analyst began active review of the request. Used to measure queue time and analyst response performance.',
    `sla_met` BOOLEAN COMMENT 'Indicates whether the clearance request was resolved within the defined SLA target hours. Used for operational performance reporting and process improvement.',
    `sla_target_hours` STRING COMMENT 'Number of business hours within which the clearance request must be resolved per service level agreement. Varies by priority level (urgent requests have shorter SLA targets).',
    `talent_approval_required` BOOLEAN COMMENT 'Indicates whether talent (actors, directors, producers) approval or notification is contractually required before the requested exploitation. True if talent has approval rights per guild agreements or individual contracts.',
    CONSTRAINT pk_clearance_request PRIMARY KEY(`clearance_request_id`)
) COMMENT 'Workflow record capturing a rights clearance request initiated before a content asset is scheduled for broadcast, streaming, or distribution. Tracks the requesting department (scheduling, distribution, production), content asset, intended exploitation type and platform, requested air or publish date, territory, clearance status (pending, cleared, conditionally cleared, blocked, escalated), blocking reason if applicable, assigned clearance analyst, and resolution date. Enforces the clearance gate that prevents unlicensed content from reaching playout or distribution systems. Integrates with Ericsson MediaFirst scheduling and Rightsline availabilities.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` (
    `availability_window_id` BIGINT COMMENT 'Unique identifier for the computed rights availability window record. Primary key.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Availability windows must comply with accessibility obligations (captioning, audio description, video description) per platform and content type. Links distribution windows to the specific accessibili',
    `content_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_content_window. Business justification: rights_availability_window is the computed net exploitable window derived from the windowing strategy defined in rights_content_window. The availability window is the output of applying holdback, terr',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Distribution availability windows are governed by distribution agreement terms (VOD windows, streaming rights, carriage terms). Distribution operations teams must verify availability windows against t',
    `grant_id` BIGINT COMMENT 'Reference to the source rights grant record from which this availability window is derived. Links to the upstream rights grant agreement.',
    `holdback_id` BIGINT COMMENT 'Foreign key linking to rights.holdback. Business justification: rights_availability_window is the computed net exploitable window. Holdback records directly constrain availability by imposing exclusivity restrictions on specific platforms, channels, and formats. r',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Availability windows derive from license agreements. Each computed availability window traces back to one license agreement that defines the underlying rights. This FK enables tracing availability bac',
    `subscription_plan_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscription_plan. Business justification: Rights availability windows define platform_type scope; subscription plans define the service tier on that platform. Linking availability windows to subscription plans enables tier-specific rights enf',
    `sweeps_period_id` BIGINT COMMENT 'Foreign key linking to audience.sweeps_period. Business justification: Availability window planning: rights availability windows are operationally scheduled around sweeps periods for premium content. rights_availability_window is the scheduling artifact (distinct from ri',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Availability windows apply to specific territories. Each window covers one territory. Normalizing to territory reference eliminates redundant territory code storage and enables consistent territory me',
    `advertising_allowed` BOOLEAN COMMENT 'Indicates whether advertising insertion (pre-roll, mid-roll, post-roll) is permitted during content playback for this availability window. True = ads allowed, False = ad-free distribution only.',
    `availability_end_date` DATE COMMENT 'The date when the content asset is no longer available for exploitation on the specified platform and territory. Represents the end of the net exploitable window. Nullable for perpetual rights.',
    `availability_start_date` DATE COMMENT 'The date when the content asset becomes available for exploitation on the specified platform and territory. Represents the beginning of the net exploitable window.',
    `blackout_indicator` BOOLEAN COMMENT 'Indicates whether a geographic broadcast restriction (blackout) applies to this availability window. True = blackout in effect, False = no blackout restriction.',
    `carriage_fee_applicable` BOOLEAN COMMENT 'Indicates whether a carriage fee (distribution payment to the content provider) applies to this availability window. True = carriage fee required, False = no carriage fee.',
    `clearance_status` STRING COMMENT 'Rights verification status indicating whether all necessary clearances (music synchronization, talent, third-party IP) have been obtained for broadcast. Cleared = all rights verified, Pending = clearance in progress, Blocked = clearance denied, Conditional = clearance with restrictions.. Valid values are `cleared|pending|blocked|conditional`',
    `computed_timestamp` TIMESTAMP COMMENT 'The timestamp when this availability window record was computed from the intersection of upstream rights grants, holdbacks, and content windows. Represents the calculation execution time.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for financial amounts associated with this availability window (royalties, minimum guarantees). Defines the monetary unit for rights payments.. Valid values are `^[A-Z]{3}$`',
    `dai_enabled` BOOLEAN COMMENT 'Indicates whether Dynamic Ad Insertion technology is enabled for this availability window, allowing server-side ad stitching into the content stream. True = DAI enabled, False = DAI not permitted.',
    `download_to_own_allowed` BOOLEAN COMMENT 'Indicates whether permanent download (download-to-own, DTO) is permitted during this availability window. True = DTO allowed, False = streaming-only distribution.',
    `drm_requirement` STRING COMMENT 'The level of Digital Rights Management protection required for this availability window. None = no DRM, Basic = minimal protection, Standard = industry-standard encryption, Premium = highest security level.. Valid values are `none|basic|standard|premium`',
    `effective_timestamp` TIMESTAMP COMMENT 'The timestamp when this availability window record became effective and actionable for scheduling and distribution systems. May differ from computed_timestamp if there is a delay before activation.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this availability window grants exclusive distribution rights on the specified platform and territory. True = exclusive rights, False = non-exclusive rights.',
    `expiration_notification_sent` BOOLEAN COMMENT 'Indicates whether an expiration notification has been sent to scheduling and distribution systems alerting them that this availability window is approaching its end date. True = notification sent, False = not yet notified.',
    `holdback_period_days` STRING COMMENT 'The number of days representing the holdback exclusivity period during which the content cannot be exploited on other platforms. Used to enforce windowing strategies.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code representing the primary language for which this availability window is licensed. Defines the audio/subtitle language requirement.. Valid values are `^[a-z]{2}$`',
    `last_verified_timestamp` TIMESTAMP COMMENT 'The timestamp when this availability window was last verified against upstream rights and clearance records. Used for audit and compliance tracking.',
    `max_resolution` STRING COMMENT 'The maximum video resolution permitted for distribution during this availability window. SD = Standard Definition (480p), HD = High Definition (720p), FHD = Full HD (1080p), UHD = Ultra HD (2160p), 4K = 4K resolution, 8K = 8K resolution.. Valid values are `SD|HD|FHD|UHD|4K|8K`',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'The minimum guaranteed payment amount owed to the rights holder for this availability window, regardless of actual revenue performance. Expressed in the contract currency.',
    `notes` STRING COMMENT 'Free-text field for additional notes, exceptions, or special conditions related to this availability window. Used for documenting non-standard terms or manual overrides.',
    `offline_viewing_allowed` BOOLEAN COMMENT 'Indicates whether temporary offline viewing (download for offline playback with expiration) is permitted during this availability window. True = offline viewing allowed, False = online streaming only.',
    `platform_type` STRING COMMENT 'The distribution platform type for which this availability window applies. SVOD = Subscription Video On Demand, AVOD = Advertising-Supported Video On Demand, TVOD = Transactional Video On Demand, linear = traditional scheduled broadcasting, FAST = Free Ad-Supported Streaming Television, MVPD = Multichannel Video Programming Distributor.. Valid values are `SVOD|AVOD|TVOD|linear|FAST|MVPD`',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'The percentage royalty rate applicable to revenue generated during this availability window. Used for royalty calculations and residuals payments to rights holders and talent.',
    `simulcast_allowed` BOOLEAN COMMENT 'Indicates whether simultaneous multi-platform broadcast (simulcast) is permitted during this availability window. True = simulcast allowed, False = platform-exclusive distribution only.',
    `streaming_protocol` STRING COMMENT 'The technical streaming protocol authorized for content delivery during this availability window. HLS = HTTP Live Streaming, MPEG-DASH = Dynamic Adaptive Streaming over HTTP, RTMP = Real-Time Messaging Protocol, smooth = Microsoft Smooth Streaming, progressive = progressive download.. Valid values are `HLS|MPEG-DASH|RTMP|smooth|progressive`',
    `subtitle_requirement` STRING COMMENT 'Indicates the subtitle or closed captioning requirement for this availability window. None = no subtitles required, Optional = subtitles available but not mandatory, Mandatory = subtitles must be provided, Closed_caption = closed captioning required for accessibility compliance.. Valid values are `none|optional|mandatory|closed_caption`',
    `syndication_allowed` BOOLEAN COMMENT 'Indicates whether the content can be syndicated (resold to multiple outlets) during this availability window. True = syndication permitted, False = syndication prohibited.',
    `window_status` STRING COMMENT 'Current lifecycle status of the availability window. Active = currently exploitable, Pending = future window not yet started, Expired = window has ended, Suspended = temporarily unavailable, Revoked = rights withdrawn, Extended = window duration increased.. Valid values are `active|pending|expired|suspended|revoked|extended`',
    CONSTRAINT pk_availability_window PRIMARY KEY(`availability_window_id`)
) COMMENT 'Computed availability record representing the net exploitable window for a content asset on a specific platform and territory, derived from the intersection of rights grants, holdbacks, and content windows. Captures asset reference, platform type (SVOD, AVOD, TVOD, linear, FAST, MVPD), territory, availability start and end dates, exclusivity flag, blackout indicator, and the source rights grant and window records. This is the actionable availability feed consumed by scheduling and distribution domains to determine what can be programmed or published. Refreshed whenever upstream rights or window records change.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` (
    `holder_id` BIGINT COMMENT 'Unique identifier for the rights holder entity. Primary key for the rights holder master record.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Rights holders (studios, guilds, talent) have billing accounts for receiving royalty payments. Finance teams need this link to route royalty disbursements, manage credit limits, and perform AR reconci',
    `partner_id` BIGINT COMMENT 'Foreign key reference to partner entity',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Rights holders are subject to regulatory obligations such as foreign ownership restrictions, guild affiliation reporting requirements, and tax withholding mandates. holder.guild_affiliation, tax_withh',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: In media broadcasting, talent (actors, writers, directors) frequently hold rights to their performances and creative works. Linking rights holder to talent_profile enables unified royalty-plus-residua',
    `audit_rights_flag` BOOLEAN COMMENT 'Indicates whether this rights holder has contractual audit rights to review revenue reporting and royalty calculations. True requires enhanced documentation retention.',
    `bank_account_name` STRING COMMENT 'Name on the bank account designated for royalty payments. Must match legal entity name for payment processing compliance.',
    `bank_account_number` STRING COMMENT 'Bank account number for royalty payment remittance. Encrypted at rest and in transit per PCI DSS requirements.',
    `bank_routing_number` STRING COMMENT 'Bank routing number or SWIFT/BIC code for international wire transfers. Used for automated royalty payment processing.',
    `clearance_priority_level` STRING COMMENT 'Priority level assigned to clearance requests for content from this rights holder. VIP and critical levels receive accelerated processing.. Valid values are `standard|expedited|vip|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rights holder record was first created in the system. Used for audit trail and data lineage tracking.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit exposure allowed for advance payments or minimum guarantees to this rights holder. Used for financial risk management.',
    `default_royalty_rate` DECIMAL(18,2) COMMENT 'Default royalty rate percentage applied to new agreements with this rights holder. Can be overridden at the contract level.',
    `entity_type` STRING COMMENT 'Classification of the rights holder by organizational type. Determines applicable contract templates, royalty calculation methods, and clearance workflows. [ENUM-REF-CANDIDATE: film_studio|production_company|music_publisher|performing_rights_organization|talent_guild|record_label|news_agency|individual_creator — 8 candidates stripped; promote to reference product]',
    `exclusivity_preference` STRING COMMENT 'Rights holders stated preference for exclusivity terms in licensing agreements. Influences windowing strategy and holdback negotiations.. Valid values are `exclusive_only|non_exclusive_preferred|flexible|no_preference`',
    `guild_affiliation` STRING COMMENT 'Name of talent guild or performing rights organization (PRO) that this rights holder is affiliated with. Determines residual payment rules and reporting requirements. [ENUM-REF-CANDIDATE: sag_aftra|wga|dga|afm|ascap|bmi|sesac|gema|prs|socan — promote to reference product]',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified this rights holder record. Used for audit trail and change accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rights holder record was last updated. Used for change tracking and data synchronization.',
    `minimum_guarantee_threshold` DECIMAL(18,2) COMMENT 'Minimum guarantee amount threshold below which this rights holder will not enter licensing agreements. Used for deal structuring and negotiation.',
    `most_favored_nations_flag` BOOLEAN COMMENT 'Indicates whether this rights holder has most favored nations clause requiring rate parity with other similar rights holders. True triggers rate comparison workflows.',
    `notes` STRING COMMENT 'Free-text notes capturing special handling instructions, negotiation history, relationship nuances, or other contextual information for this rights holder.',
    `payment_method` STRING COMMENT 'Preferred payment method for royalty disbursements. Determines processing fees and settlement timelines.. Valid values are `wire_transfer|ach|check|paypal|international_wire`',
    `payment_terms_days` STRING COMMENT 'Standard payment terms in days from invoice date for royalty payments to this rights holder. Typical values include 30, 60, or 90 days net.',
    `preferred_currency` STRING COMMENT 'Three-letter ISO currency code representing the rights holders preferred currency for royalty payments and contract valuations.. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'Primary email address for the rights holder contact. Used for contract notifications, clearance communications, and royalty statements.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the rights holder organization for licensing negotiations, clearance requests, and royalty inquiries.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the rights holder contact. Used for urgent clearance issues and contract negotiations.',
    `registrant_identifier` STRING COMMENT 'The ISAN or ISRC registrant identifier assigned to the rights holder by the respective international registration authority. Used for global rights tracking and content identification.',
    `relationship_end_date` DATE COMMENT 'Date when the business relationship with this rights holder was terminated or suspended. Null for active relationships.',
    `relationship_start_date` DATE COMMENT 'Date when the business relationship with this rights holder was established. Used for historical reporting and relationship tenure analysis.',
    `rights_holder_code` STRING COMMENT 'Internal business identifier code assigned to the rights holder for operational reference and system integration across Rightsline and billing systems.',
    `rights_holder_name` STRING COMMENT 'The full legal name of the rights holder entity as registered in their territory of incorporation. Used for contract execution and royalty payment identification.',
    `rights_holder_status` STRING COMMENT 'Current lifecycle status of the rights holder relationship. Active status is required for new license agreements and royalty payments.. Valid values are `active|inactive|suspended|pending_approval|terminated`',
    `royalty_calculation_method` STRING COMMENT 'Standard royalty calculation methodology applied to this rights holders agreements. Determines how residuals and royalties are computed.. Valid values are `percentage_of_revenue|flat_fee|tiered_percentage|per_unit|hybrid`',
    `tax_identification_number` STRING COMMENT 'Tax identification number for the rights holder in their jurisdiction of incorporation. Required for tax reporting and withholding compliance.',
    `tax_withholding_classification` STRING COMMENT 'Tax withholding classification for royalty payments. Determines applicable withholding rates based on tax treaties and domestic regulations.. Valid values are `domestic|treaty_exempt|treaty_reduced_rate|non_treaty_foreign|exempt_organization`',
    `tax_withholding_rate` DECIMAL(18,2) COMMENT 'Applicable tax withholding rate percentage for royalty payments to this rights holder. Derived from tax treaties and domestic law based on withholding classification.',
    `territory_of_incorporation` STRING COMMENT 'Three-letter ISO country code representing the legal jurisdiction where the rights holder entity is incorporated or registered. Determines applicable tax treaties and withholding requirements.',
    `created_by` STRING COMMENT 'User identifier of the person who created this rights holder record. Used for audit trail and accountability.',
    CONSTRAINT pk_holder PRIMARY KEY(`holder_id`)
) COMMENT 'Master record for all external entities that hold intellectual property rights licensed to or from Media Broadcasting — including film studios, independent production companies, music publishers, performing rights organizations (PROs), talent guilds, record labels, news agencies, and individual creators. Captures rights holder name, entity type, ISAN or ISRC registrant identifier, primary contact, territory of incorporation, preferred currency, payment terms, and tax withholding classification. This is the SSOT for rights grantor and grantee identity within the rights domain, distinct from the partner domain which manages broader commercial relationships.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ADD CONSTRAINT `fk_rights_content_window_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ADD CONSTRAINT `fk_rights_content_window_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_content_window_id` FOREIGN KEY (`content_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`content_window`(`content_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ADD CONSTRAINT `fk_rights_royalty_rule_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ADD CONSTRAINT `fk_rights_royalty_rule_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ADD CONSTRAINT `fk_rights_royalty_rule_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_royalty_rule_id` FOREIGN KEY (`royalty_rule_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`royalty_rule`(`royalty_rule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_royalty_statement_id` FOREIGN KEY (`royalty_statement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`royalty_statement`(`royalty_statement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_availability_window_id` FOREIGN KEY (`availability_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`availability_window`(`availability_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_holdback_id` FOREIGN KEY (`holdback_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holdback`(`holdback_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ADD CONSTRAINT `fk_rights_availability_window_content_window_id` FOREIGN KEY (`content_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`content_window`(`content_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ADD CONSTRAINT `fk_rights_availability_window_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ADD CONSTRAINT `fk_rights_availability_window_holdback_id` FOREIGN KEY (`holdback_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holdback`(`holdback_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ADD CONSTRAINT `fk_rights_availability_window_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ADD CONSTRAINT `fk_rights_availability_window_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`rights` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`rights` SET TAGS ('dbx_domain' = 'rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Sales Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Licensor Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Licensee Partner Partner Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `advance_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `advance_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|executed|active|expired|terminated|suspended');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Blackout Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Clearance Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `content_rating_restriction` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period (Days)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `media_rights_granted` SET TAGS ('dbx_business_glossary_term' = 'Media Rights Granted');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `music_sync_license_flag` SET TAGS ('dbx_business_glossary_term' = 'Music Synchronization (Sync) License Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `payment_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `payment_schedule_type` SET TAGS ('dbx_value_regex' = 'lump sum|installments|per-episode|annual|milestone-based|revenue share');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `per_episode_fee` SET TAGS ('dbx_business_glossary_term' = 'Per-Episode Fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `per_episode_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term (Months)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `residuals_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Residuals Obligation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Royalty Calculation Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_value_regex' = 'flat fee|percentage of revenue|tiered percentage|per-unit|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_percentage` SET TAGS ('dbx_business_glossary_term' = 'Royalty Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `run_count_limit` SET TAGS ('dbx_business_glossary_term' = 'Run Count Limit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Allowed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `total_license_fee` SET TAGS ('dbx_business_glossary_term' = 'Total License Fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `total_license_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Windowing Strategy');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Coppa Declaration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `blackout_applicable` SET TAGS ('dbx_business_glossary_term' = 'Blackout Applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `carriage_fee_applicable` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|blocked|conditional');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `drm_required` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Grant End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `exclusivity_indicator` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_number` SET TAGS ('dbx_business_glossary_term' = 'Grant Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_business_glossary_term' = 'Grant Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|terminated|pending');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_applicable` SET TAGS ('dbx_business_glossary_term' = 'Holdback Applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_end_date` SET TAGS ('dbx_business_glossary_term' = 'Holdback End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_start_date` SET TAGS ('dbx_business_glossary_term' = 'Holdback Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `language_version` SET TAGS ('dbx_business_glossary_term' = 'Language Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `media_type` SET TAGS ('dbx_business_glossary_term' = 'Media Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `media_type` SET TAGS ('dbx_value_regex' = 'television|film|digital|audio|print|mobile');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `music_sync_license_required` SET TAGS ('dbx_business_glossary_term' = 'Music Synchronization (Sync) License Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Grant Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `right_type` SET TAGS ('dbx_business_glossary_term' = 'Right Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Grant Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `sublicense_permitted` SET TAGS ('dbx_business_glossary_term' = 'Sublicense Permitted');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `talent_residuals_applicable` SET TAGS ('dbx_business_glossary_term' = 'Talent Residuals Applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `window_name` SET TAGS ('dbx_business_glossary_term' = 'Window Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` SET TAGS ('dbx_subdomain' = 'availability_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Content Window Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'available|held_back|blacked_out|expired|pending');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_business_glossary_term' = 'Blackout Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `blackout_reason` SET TAGS ('dbx_business_glossary_term' = 'Blackout Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `clearance_notes` SET TAGS ('dbx_business_glossary_term' = 'Clearance Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|rejected|conditional');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `drm_requirement` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Requirement');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `drm_requirement` SET TAGS ('dbx_value_regex' = 'widevine|fairplay|playready|none|multi_drm');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `exclusivity_tier` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `exclusivity_tier` SET TAGS ('dbx_value_regex' = 'exclusive|non_exclusive|first_window|second_window');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `geo_blocking_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Geo-Blocking Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `holdback_end_date` SET TAGS ('dbx_business_glossary_term' = 'Holdback End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `holdback_start_date` SET TAGS ('dbx_business_glossary_term' = 'Holdback Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `last_availability_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Availability Refresh Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'License Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `license_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'License Fee Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `platform_scope` SET TAGS ('dbx_business_glossary_term' = 'Platform Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `sublicense_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicense Permitted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `usage_cap_type` SET TAGS ('dbx_business_glossary_term' = 'Usage Cap Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `usage_cap_type` SET TAGS ('dbx_value_regex' = 'streams|downloads|broadcasts|screenings|impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `usage_cap_units` SET TAGS ('dbx_business_glossary_term' = 'Usage Cap Units');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `window_close_date` SET TAGS ('dbx_business_glossary_term' = 'Window Close Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `window_extension_count` SET TAGS ('dbx_business_glossary_term' = 'Window Extension Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `window_open_date` SET TAGS ('dbx_business_glossary_term' = 'Window Open Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `window_priority` SET TAGS ('dbx_business_glossary_term' = 'Window Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `window_type` SET TAGS ('dbx_business_glossary_term' = 'Window Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` SET TAGS ('dbx_subdomain' = 'availability_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `holdback_id` SET TAGS ('dbx_business_glossary_term' = 'Holdback Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `subscription_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `sweeps_period_id` SET TAGS ('dbx_business_glossary_term' = 'Sweeps Period Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Rights Content Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `automated_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Enforcement Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `carriage_negotiation_reference` SET TAGS ('dbx_business_glossary_term' = 'Carriage Negotiation Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `clearance_workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Workflow Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `clearance_workflow_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_review|approved|rejected|escalated');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `holdback_code` SET TAGS ('dbx_business_glossary_term' = 'Holdback Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `holdback_code` SET TAGS ('dbx_value_regex' = '^HB-[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `conflict_resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Conflict Resolution Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Duration in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Holdback End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_value_regex' = 'active|expired|waived|overridden|pending|suspended');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_value_regex' = 'full_exclusive|partial_exclusive|non_exclusive');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restricted_channel` SET TAGS ('dbx_business_glossary_term' = 'Restricted Channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restricted_format` SET TAGS ('dbx_business_glossary_term' = 'Restricted Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'platform_holdback|territory_holdback|channel_holdback|format_holdback|daypart_holdback|exclusive_holdback');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Holdback Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `triggering_window_type` SET TAGS ('dbx_business_glossary_term' = 'Triggering Window Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `windowing_strategy_notes` SET TAGS ('dbx_business_glossary_term' = 'Windowing Strategy Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` SET TAGS ('dbx_subdomain' = 'availability_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `blackout_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Blackout Restricted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `broadcast_standard` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_business_glossary_term' = 'Content Rating System');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `coppa_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `gdpr_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `holdback_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Holdback Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `internet_penetration_percent` SET TAGS ('dbx_business_glossary_term' = 'Internet Penetration Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `iso_alpha_2_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Alpha-2 Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `iso_alpha_2_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `iso_alpha_3_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Alpha-3 Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `iso_alpha_3_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `iso_numeric_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Numeric Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `iso_numeric_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `language_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `language_primary` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `language_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `language_secondary` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Territory Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `ott_market_maturity` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Top (OTT) Market Maturity');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `ott_market_maturity` SET TAGS ('dbx_value_regex' = 'mature|developing|emerging|nascent');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `population` SET TAGS ('dbx_business_glossary_term' = 'Population');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `quota_percentage` SET TAGS ('dbx_business_glossary_term' = 'Content Quota Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `quota_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Content Quota Requirement Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `rights_territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `rights_territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|restricted|pending');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_group` SET TAGS ('dbx_business_glossary_term' = 'Territory Group');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'country|region|worldwide|custom');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `vat_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Value-Added Tax (VAT) Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `vat_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Value-Added Tax (VAT) Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `withholding_tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` SET TAGS ('dbx_subdomain' = 'royalty_processing');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `subscription_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `deduction_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Deduction Allowed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `deduction_percentage` SET TAGS ('dbx_business_glossary_term' = 'Deduction Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `maximum_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Cap Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|per_event|on_demand');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_timing` SET TAGS ('dbx_business_glossary_term' = 'Payment Timing');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_timing` SET TAGS ('dbx_value_regex' = 'advance|arrears|upon_delivery|upon_release|milestone_based');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_unit` SET TAGS ('dbx_value_regex' = 'percentage|per_stream|per_subscriber|per_unit|per_grp|flat_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_value` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `recoupment_flag` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `recoupment_threshold` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Threshold');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `residual_formula` SET TAGS ('dbx_business_glossary_term' = 'Residual Formula');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_type` SET TAGS ('dbx_business_glossary_term' = 'Royalty Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_type` SET TAGS ('dbx_value_regex' = 'flat_fee|revenue_share_percentage|per_stream_rate|per_unit_rate|residual_formula|minimum_guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_priority` SET TAGS ('dbx_business_glossary_term' = 'Rule Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'revenue|subscriber_count|stream_count|unit_count|grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` SET TAGS ('dbx_subdomain' = 'royalty_processing');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `royalty_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Statement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `minimum_guarantee_id` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `sweeps_period_id` SET TAGS ('dbx_business_glossary_term' = 'Sweeps Period Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `advance_recoupment_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Recoupment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `content_title_breakdown` SET TAGS ('dbx_business_glossary_term' = 'Content Title Breakdown');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exploitation_type_breakdown` SET TAGS ('dbx_business_glossary_term' = 'Exploitation Type Breakdown');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `gross_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Royalty Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `minimum_guarantee_shortfall` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Shortfall');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `net_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Royalty Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `paid_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Paid Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|check|ach|paypal|direct_deposit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_due_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Payment Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Statement Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annual|annual|ad-hoc');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Issue Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_notes` SET TAGS ('dbx_business_glossary_term' = 'Statement Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Royalty Statement Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_business_glossary_term' = 'Statement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_value_regex' = 'draft|approved|disputed|paid|cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `territory_breakdown` SET TAGS ('dbx_business_glossary_term' = 'Territory Breakdown');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` SET TAGS ('dbx_subdomain' = 'royalty_processing');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_statement_line_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Statement Line ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `nielsen_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Role Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Statement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `adjustments_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustments Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `advance_recoupment_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Recoupment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `calculated_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Calculated Royalty Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductions Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'none|under_review|disputed|resolved|adjusted');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `exploitation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Exploitation Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `exploitation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Exploitation Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_business_glossary_term' = 'Exploitation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `gross_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Revenue Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `holdback_status` SET TAGS ('dbx_business_glossary_term' = 'Holdback Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `holdback_status` SET TAGS ('dbx_value_regex' = 'active|expired|waived|not_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `net_payable_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payable Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|scheduled|paid|withheld|cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `platform_name` SET TAGS ('dbx_business_glossary_term' = 'Platform Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `residual_type` SET TAGS ('dbx_business_glossary_term' = 'Residual Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'streams|broadcasts|downloads|tickets|views|impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `units_exploited` SET TAGS ('dbx_business_glossary_term' = 'Units Exploited');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `window_type` SET TAGS ('dbx_business_glossary_term' = 'Window Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` SET TAGS ('dbx_subdomain' = 'royalty_processing');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_request_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `availability_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Window ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `holdback_id` SET TAGS ('dbx_business_glossary_term' = 'Holdback Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Coppa Declaration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Music Sync License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_business_glossary_term' = 'Analyst Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `blocking_category` SET TAGS ('dbx_business_glossary_term' = 'Blocking Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `blocking_category` SET TAGS ('dbx_value_regex' = 'holdback_period|territory_restriction|window_unavailable|rights_expired|music_sync_missing|talent_approval_required|[ENUM-REF-CANDIDATE: holdback_period|territory_restriction|window_unavailable|rights_expired|music_sync_missing|talent_approval_req...');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_decision` SET TAGS ('dbx_business_glossary_term' = 'Clearance Decision');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_decision` SET TAGS ('dbx_value_regex' = 'approved|approved_with_conditions|denied|pending_review');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `conditional_requirements` SET TAGS ('dbx_business_glossary_term' = 'Conditional Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_audience_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Audience Reach');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_grp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Gross Rating Point (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_residuals_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Residuals Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_residuals_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_business_glossary_term' = 'Exploitation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `integration_status` SET TAGS ('dbx_business_glossary_term' = 'Integration Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `integration_status` SET TAGS ('dbx_value_regex' = 'pending_sync|synced_to_scheduling|synced_to_playout|sync_failed');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `music_clearance_required` SET TAGS ('dbx_business_glossary_term' = 'Music Synchronization Clearance Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `platform_channel` SET TAGS ('dbx_business_glossary_term' = 'Platform or Channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^CLR-[0-9]{8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `request_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Submitted Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requested_air_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Air or Publish Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requested_air_time` SET TAGS ('dbx_business_glossary_term' = 'Requested Air or Publish Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requesting_department` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requesting_department` SET TAGS ('dbx_value_regex' = 'scheduling|distribution|production|programming|digital|syndication');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `residuals_triggered` SET TAGS ('dbx_business_glossary_term' = 'Residuals Triggered');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `review_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Started Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `sla_met` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `talent_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Talent Approval Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` SET TAGS ('dbx_subdomain' = 'availability_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `availability_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Availability Window ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Content Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `holdback_id` SET TAGS ('dbx_business_glossary_term' = 'Holdback Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `subscription_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `sweeps_period_id` SET TAGS ('dbx_business_glossary_term' = 'Sweeps Period Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `advertising_allowed` SET TAGS ('dbx_business_glossary_term' = 'Advertising Allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `availability_end_date` SET TAGS ('dbx_business_glossary_term' = 'Availability End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `availability_start_date` SET TAGS ('dbx_business_glossary_term' = 'Availability Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `blackout_indicator` SET TAGS ('dbx_business_glossary_term' = 'Blackout Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `carriage_fee_applicable` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|blocked|conditional');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `computed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Computed Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `download_to_own_allowed` SET TAGS ('dbx_business_glossary_term' = 'Download to Own Allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `drm_requirement` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Requirement');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `drm_requirement` SET TAGS ('dbx_value_regex' = 'none|basic|standard|premium');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `expiration_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Expiration Notification Sent');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `max_resolution` SET TAGS ('dbx_business_glossary_term' = 'Maximum Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `max_resolution` SET TAGS ('dbx_value_regex' = 'SD|HD|FHD|UHD|4K|8K');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `offline_viewing_allowed` SET TAGS ('dbx_business_glossary_term' = 'Offline Viewing Allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `platform_type` SET TAGS ('dbx_value_regex' = 'SVOD|AVOD|TVOD|linear|FAST|MVPD');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `simulcast_allowed` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'HLS|MPEG-DASH|RTMP|smooth|progressive');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `subtitle_requirement` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Requirement');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `subtitle_requirement` SET TAGS ('dbx_value_regex' = 'none|optional|mandatory|closed_caption');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `syndication_allowed` SET TAGS ('dbx_business_glossary_term' = 'Syndication Allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `window_status` SET TAGS ('dbx_business_glossary_term' = 'Window Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ALTER COLUMN `window_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|suspended|revoked|extended');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `clearance_priority_level` SET TAGS ('dbx_business_glossary_term' = 'Clearance Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `clearance_priority_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|vip|critical');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `default_royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Default Royalty Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `default_royalty_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Entity Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `exclusivity_preference` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Preference');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `exclusivity_preference` SET TAGS ('dbx_value_regex' = 'exclusive_only|non_exclusive_preferred|flexible|no_preference');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Talent Guild Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `minimum_guarantee_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Threshold Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `minimum_guarantee_threshold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `most_favored_nations_flag` SET TAGS ('dbx_business_glossary_term' = 'Most Favored Nations (MFN) Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|paypal|international_wire');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Full Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `registrant_identifier` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN) or International Standard Recording Code (ISRC) Registrant Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_code` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Business Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Legal Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Royalty Calculation Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_value_regex' = 'percentage_of_revenue|flat_fee|tiered_percentage|per_unit|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_withholding_classification` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_withholding_classification` SET TAGS ('dbx_value_regex' = 'domestic|treaty_exempt|treaty_reduced_rate|non_treaty_foreign|exempt_organization');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_withholding_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_withholding_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_withholding_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `territory_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'Territory of Incorporation');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
