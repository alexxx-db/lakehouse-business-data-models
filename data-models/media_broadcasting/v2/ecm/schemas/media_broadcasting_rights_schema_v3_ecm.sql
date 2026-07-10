-- Schema for Domain: rights | Business:  | Version: v3_ecm
-- Generated on: 2026-07-10 19:30:39

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`rights` COMMENT 'Single source of truth for all intellectual property rights, licensing agreements, and royalty obligations. Manages content windows (theatrical, SVOD, AVOD, TVOD, linear), holdback periods, territory restrictions, talent residuals, music synchronization licenses, clearance workflows, and royalty calculations. Powered by Rightsline, this domain enforces windowing strategies and feeds availability data to scheduling and distribution.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` (
    `license_agreement_id` BIGINT COMMENT 'Unique system identifier for the license agreement record. Primary key. Role: MASTER_AGREEMENT.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: License agreements for broadcast content must reference the FCC broadcast license under which content is distributed. Required for regulatory compliance and public inspection file documentation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: License agreements are managed by specific business units with dedicated cost centers for budget tracking and expense allocation. Required for departmental P&L reporting, budget variance analysis, and',
    `sales_account_id` BIGINT COMMENT 'Foreign key linking to sales.sales_account. Business justification: License agreements are negotiated with sales accounts (distributors, broadcasters, platforms). Real-world licensing operations require tracking which sales account is the licensee for revenue recognit',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: License agreements require tracking the business affairs executive who negotiated the deal for accountability, commission calculations, workload balancing, and routing renewal negotiations to the rela',
    `holder_id` BIGINT COMMENT 'Reference to the party granting rights under this agreement (studio, distributor, music publisher, talent guild, production company).',
    `partner_id` BIGINT COMMENT 'FK to partner.partner_partner',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: License agreements generate revenue streams and incur costs tracked to profit centers for segment reporting. Required for segment profitability analysis, EBITDA reporting by business unit, and managem',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Material license agreements (ownership changes, political advertising contracts, significant territory expansions) trigger FCC regulatory filings. Tracks which agreements require public disclosure or ',
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
    `coppa_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.coppa_declaration. Business justification: Rights grants for childrens content require verified COPPA compliance before exploitation. Links grant to the COPPA declaration that authorizes distribution to child audiences.',
    `license_agreement_id` BIGINT COMMENT 'Reference to the parent license agreement from which this grant is derived.',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset (film, series, episode, music track) to which this grant applies.',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Rights grants apply to specific territories. Each rights grant covers one territory. Normalizing to territory reference eliminates redundant territory string storage and enables consistent territory m',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` (
    `rights_content_window_id` BIGINT COMMENT 'Unique identifier for the content window record. Primary key for the rights content window entity.',
    `closed_caption_record_id` BIGINT COMMENT 'Foreign key linking to compliance.closed_caption_record. Business justification: Content windows must track closed captioning compliance for each distribution window. Links rights availability to the captioning record that proves FCC accessibility compliance for that window.',
    `license_agreement_id` BIGINT COMMENT 'Reference to the parent rights agreement or license contract that governs this window. Links to the master rights agreement.',
    `media_asset_id` BIGINT COMMENT 'Reference to the specific content asset (film, series, episode, program) to which this window applies. Links to the content master record.',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Content windows apply to specific territories. Each window covers one territory. Normalizing to territory reference eliminates redundant territory string storage and enables consistent territory metad',
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
    CONSTRAINT pk_rights_content_window PRIMARY KEY(`rights_content_window_id`)
) COMMENT 'Defines the sequential release window strategy (windowing) for a specific content asset across exploitation platforms, and computes the net availability status. Each record captures the window type (theatrical, PVOD, TVOD, SVOD, AVOD, linear, FAST, home video, syndication), platform or channel scope, window open and close dates, holdback start and end dates, territory, exclusivity tier, and computed availability status (available, held-back, blacked-out, expired). Enforces the windowing hierarchy that prevents simultaneous exploitation across competing platforms. The net availability (considering holdbacks and blackouts) is refreshed whenever upstream rights or holdback records change. Directly consumed by scheduling and distribution domains to validate playout eligibility. Powered by Rightsline Windows module.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` (
    `holdback_id` BIGINT COMMENT 'Unique identifier for the holdback restriction record. Primary key.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Holdbacks restrict specific rights grants. Each holdback applies to one rights grant, establishing which exploitation rights are being restricted. This FK enables tracing holdback restrictions back to',
    `license_agreement_id` BIGINT COMMENT 'Reference to the source license agreement that establishes this holdback restriction.',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset subject to this holdback restriction.',
    `partner_content_window_id` BIGINT COMMENT 'Reference to the triggering content window that activates this holdback restriction.',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Holdbacks apply to specific territories. Each holdback restricts one territory. Normalizing to territory reference eliminates redundant territory string storage and enables consistent territory metada',
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
    `restricted_platform` STRING COMMENT 'Name or identifier of the platform, distributor, or service that is restricted from exploiting the content during the holdback period. Applies to platform_holdback restriction types.',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` (
    `rights_territory_id` BIGINT COMMENT 'Unique identifier for the geographic territory. Primary key.',
    `employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - territory definitions need an owner for rights administration',
    `blackout_restricted_flag` BOOLEAN COMMENT 'Indicates whether the territory is subject to geographic blackout restrictions for certain content (e.g., sports events, theatrical windows). True if blackouts apply, False otherwise.',
    `broadcast_standard` STRING COMMENT 'Technical broadcast television standard used in the territory (e.g., ATSC for North America, DVB for Europe, ISDB for Japan). Determines encoding and transmission requirements for linear distribution. [ENUM-REF-CANDIDATE: atsc|dvb|isdb|dtmb|ntsc|pal|secam — 7 candidates stripped; promote to reference product]',
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
    `notes` STRING COMMENT 'Free-text field for additional territory-specific information, special handling instructions, or regulatory nuances (e.g., Requires local dubbing for theatrical release, Subject to military censorship).',
    `ott_market_maturity` STRING COMMENT 'Classification of the territorys OTT streaming market maturity: mature (high penetration, competitive), developing (growing adoption), emerging (early stage), nascent (minimal infrastructure). Informs distribution strategy and rights pricing.. Valid values are `mature|developing|emerging|nascent`',
    `population` BIGINT COMMENT 'Total population of the territory. Used for audience reach estimation, market sizing, and rights valuation.',
    `quota_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage of local or regional content required by regulation in the territory (e.g., 30.00 for EU, 0.00 for territories without quotas). Used for compliance reporting and content acquisition planning.',
    `quota_requirement_flag` BOOLEAN COMMENT 'Indicates whether the territory mandates local content quotas for broadcasters and streaming platforms (e.g., EU Audiovisual Media Services Directive requiring 30% European content). True if quotas apply, False otherwise.',
    `regulatory_body` STRING COMMENT 'Primary broadcast and media regulatory authority governing the territory (e.g., FCC for USA, Ofcom for UK, CRTC for Canada). Enforces content standards, licensing, and compliance requirements.',
    `rights_territory_status` STRING COMMENT 'Current operational status of the territory in the rights management system: active (available for licensing), inactive (not currently used), restricted (subject to special clearance), pending (under review for activation).. Valid values are `active|inactive|restricted|pending`',
    `territory_code` STRING COMMENT 'ISO 3166-1 alpha-2 or alpha-3 country code representing the territory (e.g., US, USA, GB, GBR). Standardized identifier used in rights grants and distribution agreements.. Valid values are `^[A-Z]{2,3}$`',
    `territory_group` STRING COMMENT 'Regional grouping of the territory used for rights aggregation and windowing strategies (e.g., EMEA, LATAM, North America, Worldwide, APAC). Enables multi-territory licensing and holdback management. [ENUM-REF-CANDIDATE: worldwide|north_america|latin_america|emea|apac|europe|asia|africa|middle_east|oceania — 10 candidates stripped; promote to reference product]',
    `territory_name` STRING COMMENT 'Full official name of the territory (e.g., United States, United Kingdom, Canada). Human-readable identifier used in contracts and reporting.',
    `territory_type` STRING COMMENT 'Classification of the territory scope: country (single nation), region (multi-country group), worldwide (global rights), or custom (bespoke territory definition).. Valid values are `country|region|worldwide|custom`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the territory (e.g., America/New_York, Europe/London, Asia/Tokyo). Used for scheduling, playout, and live event coordination.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the territory record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `vat_applicable_flag` BOOLEAN COMMENT 'Indicates whether Value-Added Tax (VAT) or Goods and Services Tax (GST) applies to transactions in the territory. True if VAT/GST applies, False otherwise. Used for royalty and subscription billing calculations.',
    `vat_rate_percent` DECIMAL(18,2) COMMENT 'Standard VAT or GST rate percentage applicable in the territory (e.g., 20.00 for UK, 19.00 for Germany, 0.00 for territories without VAT). Used for financial reconciliation and revenue recognition.',
    `withholding_tax_rate_percent` DECIMAL(18,2) COMMENT 'Standard withholding tax rate percentage applied to royalty payments to rights holders in the territory (e.g., 30.00 for USA non-resident aliens, 0.00 for domestic). Used for talent residuals and royalty calculations.',
    CONSTRAINT pk_rights_territory PRIMARY KEY(`rights_territory_id`)
) COMMENT 'Reference master for geographic territories and territory groups used in rights grants, holdbacks, and royalty calculations. Each record defines a territory by ISO country code, territory name, territory group (e.g., EMEA, LATAM, North America, Worldwide), broadcast regulatory body (FCC, Ofcom, etc.), currency, and whether the territory is subject to blackout restrictions. Provides the standardized territory taxonomy consumed by all rights, scheduling, and distribution products.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` (
    `royalty_rule_id` BIGINT COMMENT 'Unique identifier for the royalty calculation rule. Primary key.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Royalty rules may apply to specific rights grants. Each rule may apply to one rights grant, defining how royalties are calculated for that grant. This FK enables tracing royalty rules back to the spec',
    `license_agreement_id` BIGINT COMMENT 'Reference to the parent license agreement or rights grant to which this royalty rule applies. Links this rule to the contract context in Rightsline.',
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
    `territory_scope` STRING COMMENT 'Geographic territory or territories to which this royalty rule applies. May be a single country code, region, or comma-separated list of territories.',
    `threshold_unit` STRING COMMENT 'The unit of measure for the threshold value (e.g., revenue, subscriber count, stream count, unit count, GRP).. Valid values are `revenue|subscriber_count|stream_count|unit_count|grp`',
    `threshold_value` DECIMAL(18,2) COMMENT 'The threshold value that triggers a rate tier change or special calculation logic (e.g., revenue threshold for tiered royalty rates).',
    CONSTRAINT pk_royalty_rule PRIMARY KEY(`royalty_rule_id`)
) COMMENT 'Defines the royalty calculation rules and rate structures associated with a license agreement or rights grant. Captures royalty type (flat fee, revenue share percentage, per-stream rate, per-unit rate, residual formula), calculation basis (gross revenue, net revenue, subscriber count, stream count, GRP), applicable platform or exploitation type, rate tiers and thresholds, minimum guarantee amounts, and effective date range. Serves as the configuration engine for the royalty calculation process in Rightsline. Distinct from actual royalty payment transactions.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` (
    `royalty_statement_id` BIGINT COMMENT 'Unique identifier for the royalty statement. Primary key.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Royalty statements with net amounts due create accounts payable entries for payment to rights holders. Required for vendor payment processing, cash management, financial close, and reconciliation of r',
    `holder_id` BIGINT COMMENT 'Identifier of the rights holder (licensor, talent guild, music publisher, or syndication partner) to whom this statement is issued. Links to the party receiving royalty payments.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Royalty statements trigger GL postings for royalty expense accrual, payment processing, and advance recoupment. Required for month-end close, royalty expense recognition, and financial audit trail lin',
    `license_agreement_id` BIGINT COMMENT 'Identifier of the underlying rights agreement or contract that governs the royalty terms for this statement.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Royalty statements require tracking the royalty analyst who prepared the statement for quality control, dispute resolution, and workload management. When rights holders dispute calculations, business ',
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
    `holder_id` BIGINT COMMENT 'Reference to the party (talent, studio, licensor) entitled to receive the royalty payment for this line. Links to the rights holder master data.',
    `license_agreement_id` BIGINT COMMENT 'Reference to the underlying rights agreement or contract that governs this royalty calculation. Links to the master rights contract data.',
    `media_asset_id` BIGINT COMMENT 'Reference to the specific content asset (program, episode, film, music track) that generated this royalty line. Links to the content master data.',
    `revenue_recognition_event_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_recognition_event. Business justification: Royalty statement lines represent content exploitation that triggers revenue recognition events when content is sublicensed. Required for ASC 606/IFRS 15 compliance for content licensing revenue and p',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Royalty statement lines track exploitation by territory. Each line relates to one territory. Normalizing to territory reference eliminates redundant territory code storage and enables consistent terri',
    `royalty_rule_id` BIGINT COMMENT 'Foreign key linking to rights.royalty_rule. Business justification: Statement lines are calculated using royalty rules. Each line uses one royalty rule that defines the calculation formula. This FK enables tracing royalty calculations back to the authoritative royalty',
    `royalty_statement_id` BIGINT COMMENT 'Reference to the parent royalty statement that contains this line item. Links this line to the header-level statement issued to a rights holder.',
    `adjustments_amount` DECIMAL(18,2) COMMENT 'Additional adjustments applied to the royalty calculation, such as corrections from prior periods, contractual bonuses, penalties, or dispute resolutions. Can be positive or negative.',
    `advance_recoupment_amount` DECIMAL(18,2) COMMENT 'Portion of the calculated royalty that is applied against outstanding advances previously paid to the rights holder. Reduces the net payable amount.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this royalty line to source exploitation data, usage reports, or billing records. Enables granular audit trail and dispute resolution.',
    `calculated_royalty_amount` DECIMAL(18,2) COMMENT 'Royalty amount calculated by applying the royalty rate to the net revenue. Represents the gross royalty obligation before advance recoupment or adjustments.',
    `content_title` STRING COMMENT 'Human-readable title of the content asset for which royalties are being calculated. Denormalized for reporting convenience.',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` (
    `residual_id` BIGINT COMMENT 'Unique identifier for the residual payment obligation record. Primary key.',
    `contract_id` BIGINT COMMENT 'Reference to the underlying rights contract or license agreement that governs this residual obligation.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Residuals arise from specific rights grants. Each residual traces to one rights grant that authorized the exploitation triggering the residual. This FK enables tracing residual obligations back to the',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Residual payments trigger GL postings for expense recognition, liability accrual, and payment clearing. Required for payroll accounting, guild reporting, financial statement preparation, and audit tra',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Residual obligations arise from license agreements. Each residual payment traces to one license agreement that defines the residual terms. This FK enables tracing residual obligations back to the sour',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset (program, episode, film) whose exploitation triggered this residual payment.',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Residuals are calculated by territory. Each residual relates to one territory. Normalizing to territory reference eliminates redundant territory code storage and enables consistent territory metadata ',
    `royalty_rule_id` BIGINT COMMENT 'Foreign key linking to rights.royalty_rule. Business justification: Residuals are calculated using royalty rules. Each residual uses one royalty rule that defines the calculation formula. This FK enables tracing residual calculations back to the authoritative royalty ',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent (actor, writer, director, crew member) entitled to receive this residual payment.',
    `calculated_residual_amount` DECIMAL(18,2) COMMENT 'The computed residual payment amount owed to the talent based on the formula type, calculation basis, and applicable rates.',
    `calculation_basis_amount` DECIMAL(18,2) COMMENT 'The base revenue or gross receipts amount used as the input to the residual formula calculation.',
    `calculation_basis_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the calculation basis amount (e.g., USD, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    `calculation_date` DATE COMMENT 'The date when the residual amount was calculated by the royalty system.',
    `contract_cycle` STRING COMMENT 'The collective bargaining agreement cycle or contract period under which this residual is calculated (e.g., 2020-2023, 2023-2026).',
    `created_by_user` STRING COMMENT 'The user identifier or system account that created this residual payment record.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this residual payment record was first created in the system.',
    `currency` STRING COMMENT 'ISO 4217 three-letter currency code for the calculated residual amount (e.g., USD, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    `dispute_date` DATE COMMENT 'The date when the residual payment was flagged as disputed. Nullable if never disputed.',
    `dispute_reason` STRING COMMENT 'Description of the reason for payment dispute if status is DISPUTED (e.g., calculation error, missing exhibition data, contract interpretation disagreement).',
    `exhibition_count` STRING COMMENT 'The number of times the content was exhibited or broadcast during the residual calculation period, used for per-exhibition or tiered formulas.',
    `exploitation_end_date` DATE COMMENT 'The date when the content exploitation period that triggered this residual ended. Nullable for ongoing exploitation.',
    `exploitation_start_date` DATE COMMENT 'The date when the content exploitation period that triggered this residual began (e.g., first streaming availability date, first rerun air date).',
    `exploitation_type` STRING COMMENT 'The type of content reuse or re-exploitation that triggered this residual payment obligation (rerun, streaming, foreign broadcast, home video, SVOD, AVOD, TVOD, syndication, theatrical re-release, clip licensing). [ENUM-REF-CANDIDATE: RERUN|STREAMING|FOREIGN_BROADCAST|HOME_VIDEO|SVOD|AVOD|TVOD|SYNDICATION|THEATRICAL_RERELEASE|CLIP_LICENSING — 10 candidates stripped; promote to reference product]',
    `formula_type` STRING COMMENT 'The calculation method used to determine the residual amount (fixed amount, percentage of gross receipts, percentage of distributor gross, tiered scale based on exhibition count, per-exhibition fee, minimum guarantee).. Valid values are `FIXED_AMOUNT|PERCENTAGE_OF_GROSS|PERCENTAGE_OF_DISTRIBUTOR_GROSS|TIERED_SCALE|PER_EXHIBITION|MINIMUM_GUARANTEE`',
    `guild_report_submission_date` DATE COMMENT 'The date when the residual payment was reported to the guild or union. Nullable if not yet reported.',
    `guild_report_submitted_flag` BOOLEAN COMMENT 'Indicates whether this residual payment has been included in the mandatory guild reporting submission (True/False).',
    `guild_union_code` STRING COMMENT 'The guild or union governing this residual obligation (SAG-AFTRA for actors, WGA for writers, DGA for directors, IATSE for crew, AFM for musicians, ACTRA for Canadian talent). [ENUM-REF-CANDIDATE: SAG-AFTRA|WGA|DGA|IATSE|AFM|ACTRA|OTHER — 7 candidates stripped; promote to reference product]',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The net residual payment amount disbursed to the talent after withholding taxes and any other deductions.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this residual payment, including special circumstances, calculation adjustments, or dispute details.',
    `payment_date` DATE COMMENT 'The date when the residual payment was actually disbursed to the talent or guild. Nullable if not yet paid.',
    `payment_due_date` DATE COMMENT 'The date by which the residual payment must be made to the talent or guild, per the collective bargaining agreement payment schedule.',
    `payment_method` STRING COMMENT 'The method by which the residual payment is disbursed (direct deposit, check, wire transfer, guild trust fund, payroll integration).. Valid values are `DIRECT_DEPOSIT|CHECK|WIRE_TRANSFER|GUILD_TRUST|PAYROLL`',
    `payment_reference_number` STRING COMMENT 'External payment system reference number or transaction identifier for the disbursed residual payment.',
    `payment_status` STRING COMMENT 'Current status of the residual payment obligation (pending calculation approval, approved for payment, paid, disputed by talent or guild, withheld pending resolution, cancelled).. Valid values are `PENDING|APPROVED|PAID|DISPUTED|WITHHELD|CANCELLED`',
    `percentage` DECIMAL(18,2) COMMENT 'The percentage rate applied to the calculation basis when the formula type is percentage-based (e.g., 0.0350 for 3.5%).',
    `reporting_period` STRING COMMENT 'The financial or royalty reporting period to which this residual obligation belongs (e.g., Q1-2024, 2024-H1), used for guild reporting and financial reconciliation.',
    `resolution_date` DATE COMMENT 'The date when a disputed residual payment was resolved. Nullable if dispute is unresolved or no dispute occurred.',
    `updated_by_user` STRING COMMENT 'The user identifier or system account that last modified this residual payment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this residual payment record was last modified in the system.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of tax withheld from the residual payment per applicable tax regulations (federal, state, foreign withholding).',
    CONSTRAINT pk_residual PRIMARY KEY(`residual_id`)
) COMMENT 'Tracks talent residual payment obligations arising from the reuse or re-exploitation of content under guild agreements (SAG-AFTRA, WGA, DGA, IATSE). Each record captures the guild or union, contract cycle, content asset, exploitation type triggering the residual (rerun, streaming, foreign broadcast, home video), residual formula type, calculated residual amount, payment due date, and payment status. Residuals are distinct from general royalties — they are talent-specific reuse payments governed by collective bargaining agreements. Feeds talent and billing domains.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` (
    `music_sync_license_id` BIGINT COMMENT 'Unique identifier for the music synchronization license record. Primary key.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Music sync license fees create payables to music rights holders (composers, publishers, PROs). Required for music clearance cost tracking, payment processing, and reconciliation of music licensing obl',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Music clearance workflows require tracking which music clearance coordinator negotiated and approved each sync license for accountability, performance metrics, and routing follow-up issues. Standard p',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Music sync licenses may derive from broader rights grants. Each sync license may reference one rights grant that authorized the music usage. This FK enables tracing sync licenses back to the authorita',
    `license_agreement_id` BIGINT COMMENT 'Reference to the master rights contract or agreement under which this music synchronization license is granted.',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset (program, episode, film, promo) in which the licensed music is synchronized and embedded.',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Music sync licenses apply to specific territories. Each license covers one territory. Normalizing to territory reference eliminates redundant territory string storage and enables consistent territory ',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Music sync licenses require talent approval when performers have contractual rights over music usage in their performances. Real business process: talent approval workflow for music clearances in cont',
    `clearance_approved_date` DATE COMMENT 'Date when the music synchronization license was officially cleared and approved for use. Nullable if not yet approved.',
    `clearance_notes` STRING COMMENT 'Free-text notes documenting clearance workflow details, restrictions, special conditions, or communications with rights holders during the licensing process.',
    `clearance_requested_date` DATE COMMENT 'Date when the music synchronization license clearance was initially requested from the rights holder or clearance team.',
    `clearance_status` STRING COMMENT 'Current state of the music synchronization license clearance workflow indicating whether the license has been approved for use in content.. Valid values are `pending|cleared|rejected|expired|under_review|conditional`',
    `composer_name` STRING COMMENT 'Name of the composer or songwriter who created the musical composition.',
    `composition_title` STRING COMMENT 'The title of the musical composition or work being licensed for synchronization use.',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this music synchronization license record in the rights management system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this music synchronization license record was first created in the rights management system.',
    `cue_sheet_required_flag` BOOLEAN COMMENT 'Indicates whether a cue sheet (detailed music usage report) must be filed with performance rights organizations for this license, typically required for broadcast and public performance.',
    `duration_seconds` STRING COMMENT 'Length of the music excerpt or cue being licensed, measured in seconds. Used for calculating royalties and determining fair use considerations.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this synchronization license grants exclusive rights to use the music in the specified territory and platforms, preventing the rights holder from licensing the same music to competitors during the license period.',
    `isrc_code` STRING COMMENT 'International Standard Recording Code uniquely identifying the sound recording being licensed. Format: 2-letter country code + 3-character registrant code + 2-digit year + 5-digit designation.. Valid values are `^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$`',
    `iswc_code` STRING COMMENT 'International Standard Musical Work Code uniquely identifying the musical composition being licensed. Format: T-NNNNNNNNN-C where N is digit and C is check digit.. Valid values are `^T-[0-9]{9}-[0-9]$`',
    `license_end_date` DATE COMMENT 'The date when the music synchronization license expires and the right to use the licensed music terminates. Nullable for perpetual licenses.',
    `license_fee_amount` DECIMAL(18,2) COMMENT 'One-time or upfront fee paid to the rights holder for the synchronization license. Does not include ongoing royalties.',
    `license_fee_currency` STRING COMMENT 'Three-letter ISO currency code for the license fee amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `license_number` STRING COMMENT 'Externally-known unique identifier or reference number for this music synchronization license, typically assigned by the rights management system or licensing authority.',
    `license_start_date` DATE COMMENT 'The date when the music synchronization license becomes effective and the licensed music may be used in the specified content.',
    `license_type` STRING COMMENT 'Classification of the music synchronization license indicating the scope and nature of rights granted (master use for sound recording, synchronization for composition, blanket for multiple works, per-title for single work, mechanical for reproduction, performance for public performance).. Valid values are `master_use|synchronization|blanket|per_title|mechanical|performance`',
    `licensed_platforms` STRING COMMENT 'Comma-separated list of distribution platforms and channels where the licensed music may be used (e.g., linear broadcast, SVOD, AVOD, TVOD, theatrical, home video, social media).',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment to the rights holder regardless of actual usage or revenue. Nullable if no minimum guarantee applies.',
    `pro_affiliation` STRING COMMENT 'Name of the Performance Rights Organization (e.g., ASCAP, BMI, SESAC, PRS, SOCAN) with which the composer or publisher is affiliated for performance royalty collection.',
    `restrictions` STRING COMMENT 'Free-text description of any restrictions, limitations, or special conditions attached to this music synchronization license (e.g., no use in advertising, no use with controversial content, limited to specific episodes).',
    `rights_holder_name` STRING COMMENT 'Name of the entity (publisher, record label, production company) that owns or controls the rights to the musical work or sound recording.',
    `rights_holder_type` STRING COMMENT 'Classification of the rights holder entity (publisher for composition rights, record label for master recording rights, PRO for performance rights organization, independent artist for self-owned rights, production company for commissioned works, collective for rights societies).. Valid values are `publisher|record_label|pro|independent_artist|production_company|collective`',
    `royalty_basis` STRING COMMENT 'The metric or revenue base upon which ongoing royalties are calculated (gross revenue, net revenue, per-stream count, per-download, per-unit sold, or flat fee with no ongoing royalties).. Valid values are `gross_revenue|net_revenue|per_stream|per_download|per_unit|flat_fee`',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Percentage rate applied to revenue or usage metrics for calculating ongoing royalty payments to the rights holder. Nullable if license is flat-fee only.',
    `sublicense_permitted_flag` BOOLEAN COMMENT 'Indicates whether the licensee is permitted to sublicense the music synchronization rights to third parties (e.g., for syndication or international distribution partners).',
    `updated_by_user` STRING COMMENT 'Username or identifier of the user who last updated this music synchronization license record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this music synchronization license record was last modified or updated.',
    `usage_type` STRING COMMENT 'Classification of how the music is used within the content asset (background music, theme song, featured performance, promotional use, trailer, opening/closing credits).. Valid values are `background|theme|featured|promotional|trailer|credits`',
    CONSTRAINT pk_music_sync_license PRIMARY KEY(`music_sync_license_id`)
) COMMENT 'Master record for music synchronization licenses that authorize the use of a specific musical composition or sound recording within a content asset. Captures the music work (composition title, ISRC, ISWC), rights holder (publisher, label, PRO), sync license type (master use, synchronization, blanket, per-title), licensed territory, licensed platforms, license fee, royalty rate, license period, and clearance status. Music sync licenses are a distinct rights category from content licenses and are required for every piece of music embedded in a broadcast or streaming asset.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` (
    `clearance_request_id` BIGINT COMMENT 'Unique identifier for the rights clearance request. Primary key for the clearance request workflow record.',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Clearance analysts must verify which broadcast facility will transmit content to assess technical compliance with license terms, geographic blackout rules, and transmission standards. Critical for pre',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Clearance workflow validates content rating before approving distribution. Analysts check that requested platform/daypart matches rating restrictions (e.g., TV-14 content not cleared for daytime child',
    `conflict_id` BIGINT COMMENT 'Foreign key linking to rights.rights_conflict. Business justification: Clearance requests may be blocked by detected conflicts. Each clearance request may reference one blocking conflict that prevents exploitation. This FK enables tracing clearance denials back to the sp',
    `coppa_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.coppa_declaration. Business justification: Clearance requests for childrens content must verify COPPA declaration status before approval. Ensures data collection and advertising practices comply with COPPA before content goes live.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Clearance requests validate against specific rights grants to determine if exploitation is permitted. Each clearance request checks one rights grant for authorization. This FK enables validation of ex',
    `guarantee_id` BIGINT COMMENT 'Foreign key linking to audience.audience_guarantee. Business justification: Clearance analysts must verify that content substitutions or schedule changes wont breach advertiser audience guarantees (GRP/TRP commitments). Real business process: when makegoods are required, cle',
    `holdback_id` BIGINT COMMENT 'Foreign key linking to rights.holdback. Business justification: Clearance requests may be blocked by specific holdbacks. Each clearance request may reference one blocking holdback that prevents exploitation. This FK enables tracing clearance denials back to the sp',
    `license_agreement_id` BIGINT COMMENT 'Reference to the primary licensing agreement that governs the requested exploitation. Links to the contract record in Rightsline that defines available windows, territories, and restrictions.',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset requiring clearance verification before broadcast, streaming, or distribution. Links to the digital asset managed in Dalet Galaxy MAM.',
    `music_sync_license_id` BIGINT COMMENT 'Foreign key linking to rights.music_sync_license. Business justification: Clearance requests may require music sync licenses. Each request may reference one music sync license that must be validated. This FK enables tracing clearance requirements back to the specific music ',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Clearance requests are triggered by sales opportunities requiring content availability verification before deal closure. Ad sales and content licensing workflows require rights clearance to confirm no',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or system user who submitted the clearance request. Enables accountability and follow-up communication.',
    `rights_availability_window_id` BIGINT COMMENT 'Reference to the specific rights window (theatrical, SVOD, AVOD, linear, etc.) being verified for availability. Links to windowing strategy definitions in Rightsline.',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Clearance requests are for specific territories. Each request relates to one territory. Normalizing to territory reference eliminates redundant territory code storage and enables consistent territory ',
    `blocking_category_ref_id` BIGINT COMMENT 'Classification of the primary reason for clearance denial. Enables reporting on common rights obstacles and process improvement. [ENUM-REF-CANDIDATE: holdback_period|territory_restriction|window_unavailable|rights_expired|music_sync_missing|talent_approval_required|residuals_unpaid|clearance_incomplete — promote to reference product]',
    `analyst_notes` STRING COMMENT 'Free-text notes and observations recorded by the clearance analyst during review. May include references to specific contract clauses, communications with rights holders, or special handling instructions.',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` (
    `rights_availability_window_id` BIGINT COMMENT 'Unique identifier for the computed rights availability window record. Primary key.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Availability windows must comply with accessibility obligations (captioning, audio description, video description) per platform and content type. Links distribution windows to the specific accessibili',
    `grant_id` BIGINT COMMENT 'Reference to the source rights grant record from which this availability window is derived. Links to the upstream rights grant agreement.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Availability windows derive from license agreements. Each computed availability window traces back to one license agreement that defines the underlying rights. This FK enables tracing availability bac',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset for which this availability window is computed. Links to the content master record.',
    `partner_content_window_id` BIGINT COMMENT 'Reference to the content window record (theatrical, SVOD, AVOD, TVOD, linear) that defines the release strategy for this availability period.',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Availability windows apply to specific territories. Each window covers one territory. Normalizing to territory reference eliminates redundant territory code storage and enables consistent territory me',
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
    CONSTRAINT pk_rights_availability_window PRIMARY KEY(`rights_availability_window_id`)
) COMMENT 'Computed availability record representing the net exploitable window for a content asset on a specific platform and territory, derived from the intersection of rights grants, holdbacks, and content windows. Captures asset reference, platform type (SVOD, AVOD, TVOD, linear, FAST, MVPD), territory, availability start and end dates, exclusivity flag, blackout indicator, and the source rights grant and window records. This is the actionable availability feed consumed by scheduling and distribution domains to determine what can be programmed or published. Refreshed whenever upstream rights or window records change.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` (
    `conflict_id` BIGINT COMMENT 'Unique identifier for the rights conflict record. Primary key.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: Rights conflicts (overlapping grants, blackout violations, unauthorized distribution) escalate to compliance incidents when they breach regulatory obligations or trigger FCC complaints. Links rights v',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Conflicts arise from overlapping license agreements. Each conflict relates to one primary license agreement that is the source of the conflict. This FK enables tracing conflicts back to the source agr',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset (film, series, episode) that is subject to the conflicting rights.',
    `employee_id` BIGINT COMMENT 'Reference to the rights analyst or user responsible for reviewing and resolving this conflict.',
    `grant_id` BIGINT COMMENT 'Reference to the first rights grant involved in the conflict.',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Conflicts occur in specific territories. Each conflict relates to one territory. Normalizing to territory reference eliminates redundant territory code storage and enables consistent territory metadat',
    `tertiary_conflict_resolved_by_analyst_employee_id` BIGINT COMMENT 'Reference to the rights analyst or user who ultimately resolved or closed the conflict. Null if conflict remains open.',
    `affected_distribution_partners` STRING COMMENT 'Comma-separated list of distribution partner names or identifiers affected by this conflict (e.g., streaming platforms, broadcasters, MVPD partners).',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking to detailed audit trail records for all actions taken on this conflict, supporting compliance and legal review requirements.',
    `business_priority` STRING COMMENT 'Business priority classification for resolving the conflict: critical (blocks major release or high-value content), high (impacts significant revenue or strategic content), medium (standard business impact), or low (minimal business impact).. Valid values are `critical|high|medium|low`',
    `conflict_type` STRING COMMENT 'Classification of the type of rights conflict detected: territorial overlap (same territory granted to multiple parties), platform overlap (same platform rights conflict), holdback violation (content released during holdback period), window gap (gap between sequential windows), exclusivity breach (non-exclusive grant conflicts with exclusive grant), or duration overlap (time period overlap).. Valid values are `territorial_overlap|platform_overlap|holdback_violation|window_gap|exclusivity_breach|duration_overlap`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this conflict record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `detected_timestamp` TIMESTAMP COMMENT 'The precise date and time when the rights conflict was first detected by the system or identified by a rights analyst.',
    `detection_method` STRING COMMENT 'The method by which the conflict was identified: automated system scan (scheduled batch validation), manual review (analyst-identified), contract ingestion (detected during contract entry), scheduling validation (found during program scheduling), distribution check (identified during content delivery preparation), or clearance workflow (discovered during rights clearance process).. Valid values are `automated_system_scan|manual_review|contract_ingestion|scheduling_validation|distribution_check|clearance_workflow`',
    `end_date` DATE COMMENT 'The date when the rights conflict period ends, representing the last point of overlap between the conflicting grants. Null if conflict is ongoing or indefinite.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact of the conflict in USD, including potential revenue loss, penalty costs, or settlement amounts. Negative values represent costs; positive values represent avoided losses.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this conflict record was most recently updated.',
    `legal_opinion_summary` STRING COMMENT 'Summary of the legal departments assessment and recommendations regarding the conflict. Contains privileged attorney-client communication.',
    `legal_review_date` DATE COMMENT 'The date when legal department completed their review of the conflict. Null if no legal review was performed.',
    `legal_review_required_flag` BOOLEAN COMMENT 'Indicates whether the conflict requires legal department review before resolution. True if legal review is mandatory, False otherwise.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether stakeholder notifications have been sent regarding this conflict. True if notifications were dispatched, False otherwise.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'The date and time when stakeholder notifications were sent. Null if no notifications have been sent.',
    `platform_type` STRING COMMENT 'The distribution platform type where the conflict occurs: linear broadcast (traditional scheduled TV), SVOD (Subscription Video On Demand), AVOD (Advertising-Supported Video On Demand), TVOD (Transactional Video On Demand), theatrical (cinema release), home video (physical media), syndication (content resale), FAST (Free Ad-Supported Streaming Television), or VOD (Video On Demand generic). [ENUM-REF-CANDIDATE: linear_broadcast|svod|avod|tvod|theatrical|home_video|syndication|fast|vod — 9 candidates stripped; promote to reference product]',
    `reference_number` STRING COMMENT 'Business-facing unique reference number for the conflict, used in communications and reporting. Format: RC-YYYYMMDD-XXXXXX.. Valid values are `^RC-[0-9]{8}-[A-Z0-9]{6}$`',
    `resolution_date` DATE COMMENT 'The date when the conflict was officially resolved, waived, or closed. Null if conflict remains open.',
    `resolution_method` STRING COMMENT 'The approach used to resolve the conflict: contract amendment (modify existing agreement terms), rights buyback (purchase back conflicting rights), window adjustment (change release timing), territory restriction (limit geographic availability), platform exclusion (remove platform from grant), holdback extension (extend exclusivity period), or negotiated settlement (mutual agreement between parties). [ENUM-REF-CANDIDATE: contract_amendment|rights_buyback|window_adjustment|territory_restriction|platform_exclusion|holdback_extension|negotiated_settlement — 7 candidates stripped; promote to reference product]',
    `resolution_notes` STRING COMMENT 'Detailed narrative explanation of how the conflict was resolved, including business rationale, stakeholder decisions, and any special conditions or agreements reached. May contain sensitive business information.',
    `resolution_status` STRING COMMENT 'Current status of the conflict resolution workflow: open (newly detected, not yet reviewed), under review (being analyzed by rights team), pending legal (requires legal department review), resolved (conflict has been addressed and closed), waived (conflict acknowledged but approved for business reasons), or escalated (elevated to senior management for decision).. Valid values are `open|under_review|pending_legal|resolved|waived|escalated`',
    `severity` STRING COMMENT 'Severity classification of the conflict: blocking (prevents content distribution, must be resolved before release), warning (potential issue requiring review but not blocking), or informational (noted for awareness, no immediate action required).. Valid values are `blocking|warning|informational`',
    `sla_resolution_deadline` TIMESTAMP COMMENT 'The target date and time by which the conflict must be resolved according to internal service level agreements, based on business priority and content release schedules.',
    `start_date` DATE COMMENT 'The date when the rights conflict period begins, representing the earliest point of overlap between the conflicting grants.',
    `window_type` STRING COMMENT 'The content distribution window type involved in the conflict, representing the sequential release strategy phase. [ENUM-REF-CANDIDATE: theatrical|home_entertainment|pay_per_view|premium_svod|basic_cable|broadcast|syndication|free_streaming — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_conflict PRIMARY KEY(`conflict_id`)
) COMMENT 'Records detected conflicts between overlapping rights grants, holdbacks, or content windows for the same content asset, territory, and platform. Captures conflict type (territorial overlap, platform overlap, holdback violation, window gap, exclusivity breach), the two conflicting rights records, detection timestamp, conflict severity (blocking, warning), resolution status (open, resolved, waived), resolution notes, and the analyst who resolved it. Supports the rights conflict resolution workflow and provides an audit trail for compliance and legal review.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` (
    `license_amendment_id` BIGINT COMMENT 'Unique identifier for the license amendment record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Amendments require structured employee tracking (beyond generic created_by_user string) for approval workflows, audit trails, and legal accountability. Business affairs teams need to track who initiat',
    `license_agreement_id` BIGINT COMMENT 'Reference to the parent license agreement being amended. Links to the original executed agreement in the rights management system.',
    `partner_id` BIGINT COMMENT 'Reference to the rights holder or content owner party executing this amendment. Typically the same as the original agreement but may change in assignment scenarios.',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.rights_holder. Business justification: Amendments track licensor party changes. Each amendment relates to one licensor rights holder. This FK enables tracing amendment parties back to the authoritative rights holder record. Using licensor_',
    `primary_licensee_party_partner_id` BIGINT COMMENT 'Reference to the content distributor or broadcaster party executing this amendment. Represents the organization acquiring or modifying rights.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Material amendments (ownership changes, territory expansions, fee restructures) require FCC disclosure filings. Tracks which amendments triggered regulatory notification or public inspection file upda',
    `superseded_by_amendment_license_amendment_id` BIGINT COMMENT 'Reference to a subsequent amendment that supersedes or replaces this one. Null if this is the current active amendment.',
    `licensee_party_partner_id` BIGINT COMMENT '',
    `amended_license_fee_amount` DECIMAL(18,2) COMMENT 'The new total license fee or minimum guarantee amount after this amendment. Null if the amendment does not modify financial terms.',
    `amended_term_end_date` DATE COMMENT 'The new license agreement end date after this amendment takes effect. Null if the amendment does not modify term duration.',
    `amendment_number` STRING COMMENT 'Business identifier for the amendment, typically sequential or alphanumeric code (e.g., AMD-001, A1, Amendment-2023-05). Used for external reference and legal documentation.. Valid values are `^[A-Z0-9]{2,20}$`',
    `amendment_reason` STRING COMMENT 'Business justification or trigger for the amendment. Examples: market opportunity, performance renegotiation, rights holder request, regulatory change, strategic partnership expansion.',
    `amendment_status` STRING COMMENT 'Current lifecycle state of the amendment: draft (being prepared), pending_review (under legal review), pending_approval (awaiting executive sign-off), executed (fully signed and active), rejected (not approved), superseded (replaced by newer amendment).. Valid values are `draft|pending_review|pending_approval|executed|rejected|superseded`',
    `amendment_type` STRING COMMENT 'Classification of the amendment based on the nature of the change: term extension (extending license duration), territory expansion (adding geographic markets), platform addition (adding distribution channels such as SVOD, AVOD, linear), fee renegotiation (changing financial terms), rights_modification (altering content usage rights), or termination (early contract end).. Valid values are `term_extension|territory_expansion|platform_addition|fee_renegotiation|rights_modification|termination`',
    `approval_authority` STRING COMMENT 'Name or title of the executive or committee that approved this amendment (e.g., VP Rights Acquisition, Legal Counsel, CFO, Board of Directors).',
    `changed_terms_summary` STRING COMMENT 'Narrative summary of the specific terms modified by this amendment. Captures key changes for quick reference without requiring full legal document review. Examples: Extended term by 24 months, Added AVOD rights for UK territory, Reduced minimum guarantee by 15%.',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created this amendment record. Audit trail for accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this amendment record was first created in the system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this amendment (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date when the amendment terms become legally binding and operational. May be retroactive or future-dated depending on negotiation.',
    `execution_date` DATE COMMENT 'Date when all parties signed the amendment, making it legally executed. Distinct from effective_date which may differ based on contract terms.',
    `expiration_date` DATE COMMENT 'Date when the amendment terms expire or sunset, if applicable. Null for amendments that permanently modify the agreement.',
    `fee_adjustment_amount` DECIMAL(18,2) COMMENT 'The incremental change in license fee resulting from this amendment. Positive for increases, negative for reductions. Calculated as amended_license_fee_amount minus original_license_fee_amount.',
    `holdback_period_change_days` STRING COMMENT 'Change in holdback or exclusivity period measured in days. Positive for extensions, negative for reductions. Null if holdback terms unchanged.',
    `internal_notes` STRING COMMENT 'Confidential internal commentary on the amendment negotiation, business context, or special handling instructions. Not shared with external parties.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this amendment record. Audit trail for accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this amendment record. Audit trail for change tracking.',
    `legal_document_reference` STRING COMMENT 'Reference identifier or file path to the executed legal amendment document stored in the document management system or MAM.',
    `original_license_fee_amount` DECIMAL(18,2) COMMENT 'The total license fee or minimum guarantee amount before this amendment. Captured for financial audit and royalty recalculation.',
    `original_term_end_date` DATE COMMENT 'The license agreement end date before this amendment. Captured for audit trail and to calculate term extension impact.',
    `platforms_added` STRING COMMENT 'Comma-separated list of distribution platforms or windows added by this amendment. Examples: SVOD, AVOD, TVOD, Linear, FAST, Theatrical. Empty if no platform expansion.',
    `platforms_removed` STRING COMMENT 'Comma-separated list of distribution platforms or windows removed or restricted by this amendment. Empty if no platform reduction.',
    `requires_royalty_recalculation` BOOLEAN COMMENT 'Indicates whether this amendment triggers retroactive royalty recalculation for past periods. True when financial terms are modified with retroactive effective dates.',
    `royalty_rate_change_percent` DECIMAL(18,2) COMMENT 'Percentage point change in royalty rate resulting from this amendment. Positive for increases, negative for decreases. Null if royalty terms unchanged.',
    `territories_added` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes for territories added by this amendment. Empty if no territory expansion.',
    `territories_removed` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes for territories removed or restricted by this amendment. Empty if no territory reduction.',
    CONSTRAINT pk_license_amendment PRIMARY KEY(`license_amendment_id`)
) COMMENT 'Tracks formal amendments, modifications, and extensions to executed license agreements. Each record captures the parent agreement reference, amendment number, amendment type (term extension, territory expansion, platform addition, fee renegotiation, termination), effective date of amendment, changed terms summary, amendment status (draft, executed, rejected), and the executing parties. Maintains a complete amendment history for each agreement to support audit, legal review, and royalty recalculation when terms change mid-term.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` (
    `exploitation_report_id` BIGINT COMMENT 'Unique identifier for the exploitation report. Primary key for this entity.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Exploitation reports submitted to rights holders must identify broadcast channel for royalty calculation, territory compliance verification, and per-channel revenue attribution. Channel is mandatory d',
    `cross_platform_measurement_id` BIGINT COMMENT 'Foreign key linking to audience.cross_platform_measurement. Business justification: Modern exploitation reports must account for deduplicated cross-platform viewing (linear + OTT + MVPD) to accurately report total content usage. Rights holders require comprehensive cross-platform met',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Exploitation reports document usage under specific rights grants. Each report relates to one rights grant that authorized the exploitation. This FK enables tracing reported usage back to the authorita',
    `holder_id` BIGINT COMMENT 'Reference to the rights holder or licensor to whom this exploitation report is being submitted, identifying the recipient of royalty payments.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the organization or business unit that generated and submitted this exploitation report (typically the distributor or platform operator).',
    `license_agreement_id` BIGINT COMMENT 'Reference to the specific license agreement under which this exploitation occurred, linking usage to contractual terms and royalty rates.',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset (film, series, episode, music track) that was exploited during the reporting period.',
    `nielsen_rating_id` BIGINT COMMENT 'Foreign key linking to audience.nielsen_rating. Business justification: Exploitation reports cite Nielsen ratings for broadcast performance metrics in royalty calculations. Rights holders receive exploitation reports showing Nielsen data to validate usage-based payments. ',
    `ott_platform_id` BIGINT COMMENT 'Reference to the distribution platform or channel where the content was exploited (e.g., streaming service, broadcast network, theatrical chain).',
    `reach_frequency_report_id` BIGINT COMMENT 'Foreign key linking to audience.reach_frequency_report. Business justification: Exploitation reports for advertiser-supported content reference reach/frequency reports to demonstrate audience delivery performance. Rights holders use reach/frequency data to validate that content a',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: Exploitation reports break down viewership by DMA (market coverage) for territory-specific license agreements and royalty calculations. Real business process: rights holders receive market-level explo',
    `revenue_recognition_event_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_recognition_event. Business justification: Exploitation reports from distribution partners provide usage data that triggers revenue recognition events under ASC 606. Required for revenue assurance, performance obligation satisfaction, and fina',
    `rights_content_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_content_window. Business justification: Exploitation reports document usage within specific content windows. Each report may relate to one rights content window that defines the exploitation parameters. This FK enables tracing exploitation ',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Exploitation reports track usage by territory. Each report relates to one territory. Normalizing to territory reference eliminates redundant territory code and name storage and enables consistent terr',
    `royalty_statement_id` BIGINT COMMENT 'Foreign key linking to rights.royalty_statement. Business justification: Exploitation reports feed into royalty statements. Each report may feed one statement, providing the raw usage data for royalty calculation. This FK enables tracing exploitation data to the resulting ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Exploitation reports from distribution partners require validation by royalty analysts before acceptance for payment processing. Business needs to track who validated each report for quality control, ',
    `acceptance_date` DATE COMMENT 'Date when the rights holder formally accepted the exploitation report, closing the dispute window and confirming the usage data.',
    `amendment_notes` STRING COMMENT 'Documentation of changes made to the exploitation report after initial submission, typically in response to disputes or data corrections.',
    `audit_reference_number` STRING COMMENT 'External audit identifier linking this exploitation report to a formal rights holder audit request, enabling traceability during royalty audits.',
    `content_title` STRING COMMENT 'The title of the content asset being reported, captured for readability and quick reference without requiring joins to the content master.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the exploitation report record was first created in the system, supporting audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this report, ensuring consistent financial interpretation.. Valid values are `^[A-Z]{3}$`',
    `data_source_system` STRING COMMENT 'Name of the operational system from which the exploitation usage data was extracted (e.g., Dalet Galaxy, Ericsson MediaFirst, Adobe Experience Platform), supporting data lineage and audit requirements.',
    `dispute_reason` STRING COMMENT 'Explanation provided by the rights holder when disputing the exploitation report, documenting discrepancies in usage counts, revenue attribution, or territorial compliance.',
    `due_date` DATE COMMENT 'Contractual deadline by which the exploitation report must be submitted to the rights holder, derived from license agreement reporting terms.',
    `eidr_identifier` STRING COMMENT 'Universal unique identifier for the audiovisual content asset as registered with EIDR, enabling global content identification across rights holders and distributors.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `exploitation_type` STRING COMMENT 'The method by which the content was exploited: linear broadcast (traditional TV), SVOD streaming (subscription video on demand), AVOD streaming (advertising-supported video on demand), TVOD rental (transactional rental), TVOD purchase (transactional purchase), theatrical exhibition, or home video (physical media). [ENUM-REF-CANDIDATE: linear_broadcast|svod_streaming|avod_streaming|tvod_rental|tvod_purchase|theatrical|home_video — 7 candidates stripped; promote to reference product]',
    `gross_revenue_amount` DECIMAL(18,2) COMMENT 'Total revenue attributed to the exploitation of this content during the reporting period before any deductions, used as the basis for royalty calculations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the exploitation report record, tracking changes through the report lifecycle from draft to final acceptance.',
    `net_revenue_amount` DECIMAL(18,2) COMMENT 'Revenue after contractually defined deductions (distribution fees, marketing costs, platform fees) that forms the royalty calculation base per the license agreement.',
    `report_format_version` STRING COMMENT 'Version number of the exploitation report template or schema used, ensuring compatibility and correct interpretation of report fields over time.. Valid values are `^[0-9]+.[0-9]+$`',
    `report_number` STRING COMMENT 'Business identifier for the exploitation report, typically formatted as EXP-YYYYMMDD-XXXXXX for external reference and audit tracking.. Valid values are `^EXP-[0-9]{8}-[A-Z0-9]{6}$`',
    `report_status` STRING COMMENT 'Current lifecycle status of the exploitation report: draft (in preparation), submitted (sent to rights holder), accepted (acknowledged by rights holder), disputed (under review for discrepancies), amended (revised after dispute), withdrawn (cancelled), or archived (finalized and stored). [ENUM-REF-CANDIDATE: draft|submitted|accepted|disputed|amended|withdrawn|archived — 7 candidates stripped; promote to reference product]',
    `report_type` STRING COMMENT 'Classification of the exploitation report indicating its purpose: usage submission to rights holders, usage receipt from distributors, royalty evidence documentation, audit support materials, reconciliation reports, or ad-hoc custom reports.. Valid values are `usage_submission|usage_receipt|royalty_evidence|audit_support|reconciliation|ad_hoc`',
    `reporting_entity_name` STRING COMMENT 'Name of the organization that submitted the report, captured for audit trail and report header display.',
    `reporting_period_end_date` DATE COMMENT 'The last date of the period covered by this exploitation report, defining the end of the usage window being documented.',
    `reporting_period_start_date` DATE COMMENT 'The first date of the period covered by this exploitation report, defining the beginning of the usage window being documented.',
    `rights_holder_name` STRING COMMENT 'Name of the rights holder receiving the report, captured for report header and audit purposes.',
    `submission_date` DATE COMMENT 'Date when the exploitation report was formally submitted to the rights holder, marking the start of the acceptance or dispute period.',
    `total_broadcasts` STRING COMMENT 'Total number of linear broadcast transmissions of the content during the reporting period. Null for on-demand exploitation.',
    `total_streams` BIGINT COMMENT 'Total number of individual stream starts or playback initiations for on-demand content during the reporting period. Null for linear broadcast exploitation.',
    `total_viewing_hours` DECIMAL(18,2) COMMENT 'Aggregate number of hours that audiences spent viewing the content during the reporting period, calculated as sum of all viewing durations.',
    `unique_viewers` BIGINT COMMENT 'Count of distinct individual viewers or households that accessed the content during the reporting period, representing reach metric.',
    CONSTRAINT pk_exploitation_report PRIMARY KEY(`exploitation_report_id`)
) COMMENT 'Periodic exploitation usage report submitted to or received from rights holders, documenting actual content usage across platforms and territories for royalty calculation purposes. Captures reporting period, content asset, exploitation type, platform, territory, total streams or broadcasts, total viewing hours, gross revenue attributed, reporting entity, submission date, and report status (draft, submitted, accepted, disputed). Serves as the evidentiary basis for royalty statement generation and licensor audit requests. Distinct from royalty statements — this is the raw usage evidence, not the calculated payment.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` (
    `holder_id` BIGINT COMMENT 'Unique identifier for the rights holder entity. Primary key for the rights holder master record.',
    `partner_id` BIGINT COMMENT 'Foreign key reference to partner entity',
    `employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - rights holder records need a relationship manager',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` (
    `rights_blackout_rule_id` BIGINT COMMENT 'Unique identifier for the blackout rule record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Blackout rules (especially sports/regulatory) require approval authority tracking for compliance audits and dispute resolution. When blackouts are challenged by distribution partners or regulators, bu',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Geographic blackout enforcement requires identifying which transmission facilities serve restricted DMAs/territories. Essential for sports rights compliance where home-market blackouts must be enforce',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Blackout rules restrict specific rights grants. Each blackout rule applies to one rights grant, defining geographic or temporal restrictions on exploitation. This FK enables tracing blackout restricti',
    `license_agreement_id` BIGINT COMMENT 'Reference to the license agreement that mandates this blackout restriction.',
    `media_asset_id` BIGINT COMMENT 'Reference to the specific content asset subject to blackout restriction.',
    `rights_syndication_deal_id` BIGINT COMMENT 'Foreign key linking to rights.syndication_deal. Business justification: Blackout rules may arise from syndication deals. Each blackout rule may reference one syndication deal that defines the blackout restrictions. This FK enables tracing blackout rules back to the source',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Blackout rules apply to specific territories. Each blackout rule restricts one territory. Normalizing to territory reference eliminates redundant territory string storage and enables consistent territ',
    `applicable_platform` STRING COMMENT 'Distribution platform or channel type to which this blackout rule applies: linear (traditional broadcast), OTT (over-the-top streaming), MVPD (multichannel video programming distributor), vMVPD (virtual MVPD), SVOD (subscription video on demand), AVOD (ad-supported video on demand), TVOD (transactional video on demand), FAST (free ad-supported streaming TV), broadcast, cable, satellite, or streaming. [ENUM-REF-CANDIDATE: linear|ott|mvpd|vmvpd|svod|avod|tvod|fast|broadcast|cable|satellite|streaming — 12 candidates stripped; promote to reference product]',
    `automated_enforcement_flag` BOOLEAN COMMENT 'Indicates whether this blackout rule is enforced automatically by distribution systems (True) or requires manual operator intervention (False).',
    `blackout_duration_hours` DECIMAL(18,2) COMMENT 'Calculated duration of the blackout period in hours, derived from start and end datetime. Used for reporting and analytics.',
    `blackout_end_datetime` TIMESTAMP COMMENT 'Precise date and time when the blackout restriction expires. Nullable for indefinite blackouts. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `blackout_message_text` STRING COMMENT 'Viewer-facing message or notification text to be displayed when content is unavailable due to this blackout restriction. Used for customer communication and transparency.',
    `blackout_rule_code` STRING COMMENT 'Business-assigned unique code identifying this blackout rule for operational reference and reporting.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `blackout_start_datetime` TIMESTAMP COMMENT 'Precise date and time when the blackout restriction becomes effective. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `blackout_type` STRING COMMENT 'Classification of the blackout restriction: sports local market blackout (home team market protection), affiliate exclusivity blackout (local station rights), regulatory blackout (government-mandated restriction), territorial holdback (geographic windowing), competitive protection (anti-siphoning), or league-imposed (sports league rule).. Valid values are `sports_local_market|affiliate_exclusivity|regulatory|territorial_holdback|competitive_protection|league_imposed`',
    `conflict_resolution_notes` STRING COMMENT 'Free-text notes documenting how conflicts with other blackout rules, rights grants, or distribution agreements were resolved for this rule.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this blackout rule record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `dma_code` STRING COMMENT 'Nielsen Designated Market Area three-digit code identifying the specific local television market subject to blackout.. Valid values are `^[0-9]{3}$`',
    `enforcement_method` STRING COMMENT 'Technical mechanism used to enforce the blackout: geo-blocking (IP-based restriction), content suppression (removal from catalog), redirect (alternate content substitution), alternate feed (different broadcast signal), or manual override (operator intervention).. Valid values are `geo_blocking|content_suppression|redirect|alternate_feed|manual_override`',
    `enforcement_status` STRING COMMENT 'Current operational status of the blackout rule: active (currently enforced), suspended (temporarily disabled), expired (past end datetime), waived (exception granted), pending activation (scheduled future), or overridden (superseded by business decision).. Valid values are `active|suspended|expired|waived|pending_activation|overridden`',
    `home_team_market_flag` BOOLEAN COMMENT 'Indicates whether this blackout applies to the home teams local market to protect local broadcast rights. True for home market blackouts, False otherwise. Applicable to sports content.',
    `last_modified_by` STRING COMMENT 'User identifier or system account that most recently modified this blackout rule record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this blackout rule record was most recently updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notification_sent_datetime` TIMESTAMP COMMENT 'Date and time when automated notifications about this blackout rule were dispatched to downstream systems and stakeholders. Nullable if notifications not yet sent. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether automated notifications have been sent to affected distribution partners, scheduling systems, and stakeholders about this blackout rule. True if notifications dispatched, False otherwise.',
    `priority_level` STRING COMMENT 'Business priority assigned to this blackout rule for conflict resolution and enforcement sequencing. Critical rules override lower-priority rules when conflicts occur.. Valid values are `critical|high|medium|low`',
    `regulatory_authority` STRING COMMENT 'Name of the government or regulatory body that mandates this blackout restriction (e.g., FCC, Ofcom, CRTC). Applicable only for regulatory blackouts.',
    `regulatory_reference_number` STRING COMMENT 'Official reference number, docket number, or citation of the regulatory ruling or statute that mandates this blackout. Applicable only for regulatory blackouts.',
    `sports_league_code` STRING COMMENT 'Code identifying the sports league or governing body that mandates this blackout rule (e.g., NFL, NBA, MLB, NHL, MLS, NCAA). Applicable only for sports-related blackouts.. Valid values are `^[A-Z]{2,6}$`',
    `triggering_rights_clause` STRING COMMENT 'Reference to the specific contractual clause, section, or provision in the license agreement that mandates this blackout restriction. May include clause number and brief description.',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the authorized person who approved the blackout waiver. Nullable if no waiver granted.',
    `waiver_approved_date` DATE COMMENT 'Date on which the blackout waiver was officially approved. Nullable if no waiver granted. Format: yyyy-MM-dd.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether an exception or waiver has been granted to bypass this blackout rule. True if waiver approved, False otherwise.',
    `waiver_reason` STRING COMMENT 'Business justification or explanation for granting a waiver to this blackout rule. Nullable if no waiver granted.',
    `created_by` STRING COMMENT 'User identifier or system account that created this blackout rule record.',
    CONSTRAINT pk_rights_blackout_rule PRIMARY KEY(`rights_blackout_rule_id`)
) COMMENT 'Defines geographic broadcast blackout restrictions for specific content assets, typically driven by sports rights agreements, local affiliate exclusivity, or regulatory requirements. Captures content asset reference, blackout type (sports local market blackout, affiliate exclusivity blackout, regulatory blackout), blacked-out territory or DMA (Designated Market Area), applicable platform (linear, OTT, MVPD), blackout start and end datetime, triggering rights clause, and enforcement status. Consumed by distribution and scheduling domains to suppress or redirect content delivery in restricted zones.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` (
    `rights_syndication_deal_id` BIGINT COMMENT 'Unique identifier for the syndication deal record. Primary key.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Syndication deals must reference the broadcast license of the syndicating station. Required for FCC ownership attribution rules and public inspection file documentation of syndicated content agreement',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Syndication deals require tracking the syndication sales executive responsible for the deal for commission calculations, territory assignment, renewal routing, and performance management. Standard pra',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.rights_holder. Business justification: Syndication deals involve rights holders as licensees. Each deal involves one rights holder. Normalizing to rights_holder reference eliminates redundant licensee_name storage and enables consistent ri',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Syndication deals are specialized license agreements. Each syndication deal may reference a parent license agreement that defines the underlying rights being syndicated. This FK enables tracing syndic',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Syndication deals apply to specific territories. Each deal covers one territory. Normalizing to territory reference eliminates redundant territory string storage and enables consistent territory metad',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Syndication deals are partner-facing distribution agreements requiring direct FK to identify the syndication partner (licensee). Enables partner-centric syndication reporting, partner performance anal',
    `auto_renewal_indicator` BOOLEAN COMMENT 'Indicates whether the deal automatically renews for an additional term unless either party provides notice (True) or requires explicit renewal negotiation (False).',
    `blackout_applicable` BOOLEAN COMMENT 'Indicates whether geographic or temporal blackout restrictions apply to this syndication deal (True) or not (False).',
    `blackout_description` STRING COMMENT 'Detailed description of any blackout restrictions, including affected territories, time periods, or triggering events.',
    `clearance_status` STRING COMMENT 'Status of rights clearance verification for the syndication deal: pending (not yet started), in-progress (clearance checks underway), cleared (all rights verified), blocked (clearance issue identified), conditional (cleared with restrictions).. Valid values are `pending|in-progress|cleared|blocked|conditional`',
    `content_package_description` STRING COMMENT 'Detailed description of the content included in the syndication deal, including titles, episode counts, and any exclusions.',
    `content_scope` STRING COMMENT 'Defines whether the deal covers a single title, an entire series, a specific season, a curated package of multiple titles, or a content library.. Valid values are `single-title|series|season|package|library`',
    `contract_document_reference` STRING COMMENT 'Reference identifier or file path to the signed syndication contract document stored in the document management system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this syndication deal record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this deal (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `deal_end_date` DATE COMMENT 'Date on which the syndication rights expire and the licensee must cease distribution. Null indicates an open-ended or perpetual deal.',
    `deal_notes` STRING COMMENT 'Free-text field for additional notes, special terms, or contextual information about the syndication deal.',
    `deal_number` STRING COMMENT 'Externally-known business identifier for the syndication deal, used in contracts and communications with licensees.',
    `deal_start_date` DATE COMMENT 'Date on which the syndication rights become effective and the licensee may begin distribution.',
    `deal_status` STRING COMMENT 'Current lifecycle state of the syndication deal: draft (initial creation), negotiation (under discussion), approved (signed but not yet active), active (currently in effect), suspended (temporarily paused), expired (term ended naturally), terminated (ended early), renewed (extended for additional term). [ENUM-REF-CANDIDATE: draft|negotiation|approved|active|suspended|expired|terminated|renewed — 8 candidates stripped; promote to reference product]',
    `deal_term_months` STRING COMMENT 'Duration of the syndication deal in months, calculated from start date to end date. Facilitates term-based reporting and renewal planning.',
    `drm_required` BOOLEAN COMMENT 'Indicates whether the licensee must implement Digital Rights Management (DRM) technology to protect the content (True) or not (False).',
    `exclusivity_indicator` BOOLEAN COMMENT 'Indicates whether the licensee has exclusive syndication rights in the specified territory (True) or non-exclusive rights (False).',
    `exclusivity_scope` STRING COMMENT 'Detailed description of the exclusivity terms, including any platform-specific, daypart-specific, or window-specific exclusivity conditions.',
    `fee_structure_type` STRING COMMENT 'Model for syndication compensation: flat fee (single payment for entire deal), per-episode (payment per episode delivered), per-run (payment per broadcast), revenue share (percentage of licensee revenue), barter (ad inventory exchange), or hybrid (combination of models).. Valid values are `flat-fee|per-episode|per-run|revenue-share|barter|hybrid`',
    `flat_fee_amount` DECIMAL(18,2) COMMENT 'Total flat fee amount for the syndication deal, if applicable. Null if fee structure is not flat-fee based.',
    `format_restrictions` STRING COMMENT 'Restrictions on the format or presentation of the content (e.g., no-editing, no-dubbing, original-aspect-ratio-only).',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified this syndication deal record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this syndication deal record was last updated.',
    `licensee_type` STRING COMMENT 'Classification of the licensee organization: broadcast station (local terrestrial), cable network, streaming platform (OTT/SVOD/AVOD), digital publisher, MVPD (Multichannel Video Programming Distributor), vMVPD (Virtual MVPD), or international broadcaster. [ENUM-REF-CANDIDATE: broadcast-station|cable-network|streaming-platform|digital-publisher|mvpd|vmvpd|international-broadcaster — 7 candidates stripped; promote to reference product]',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment amount that the licensee must pay regardless of actual usage or revenue. Null if no minimum guarantee applies.',
    `music_sync_license_required` BOOLEAN COMMENT 'Indicates whether separate music synchronization licenses must be secured for the syndicated content (True) or music rights are already cleared (False).',
    `notice_period_days` STRING COMMENT 'Number of days advance notice required for termination or non-renewal of the syndication deal. Null if not applicable.',
    `per_episode_fee_amount` DECIMAL(18,2) COMMENT 'Fee amount charged per episode, if applicable. Null if fee structure is not per-episode based.',
    `platform_restrictions` STRING COMMENT 'Comma-separated list of platforms or distribution channels where the licensee is restricted from distributing the content (e.g., linear-only, no-streaming, no-mobile).',
    `revenue_share_percent` DECIMAL(18,2) COMMENT 'Percentage of licensee revenue shared with Media Broadcasting under a revenue-share fee structure. Null if not applicable.',
    `run_limit` STRING COMMENT 'Maximum number of times the licensee is permitted to broadcast each episode or title under this syndication deal. Null indicates unlimited runs.',
    `runs_used` STRING COMMENT 'Cumulative count of runs (broadcasts) executed by the licensee to date. Used to track compliance with run limits.',
    `sublicense_permitted` BOOLEAN COMMENT 'Indicates whether the licensee is permitted to sublicense the content to other distributors (True) or must distribute directly (False).',
    `syndication_type` STRING COMMENT 'Classification of the syndication arrangement: first-run syndication (original content distributed directly to local stations), off-network syndication (previously aired network content), international syndication (cross-border distribution), digital syndication (online/streaming platforms), barter (ad inventory exchange), or cash-plus-barter (hybrid model).. Valid values are `first-run|off-network|international|digital|barter|cash-plus-barter`',
    `talent_residuals_applicable` BOOLEAN COMMENT 'Indicates whether talent residual payments (reuse payments to actors, writers, directors) are triggered by this syndication deal (True) or not (False).',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this syndication deal record.',
    CONSTRAINT pk_rights_syndication_deal PRIMARY KEY(`rights_syndication_deal_id`)
) COMMENT 'Master record for content syndication agreements under which Media Broadcasting licenses content to third-party broadcasters, streaming platforms, or digital publishers for redistribution. Captures syndication type (first-run syndication, off-network syndication, international syndication, digital syndication), licensee identity, content package or individual title scope, territory, syndication fee structure (flat fee, per-episode, revenue share), run limitations (number of permitted broadcasts), exclusivity, deal start and end dates, and deal status. Distinct from general license agreements — syndication deals have specific run-count and redistribution mechanics.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` (
    `license_fee_schedule_id` BIGINT COMMENT 'Unique identifier for the license fee schedule entry. Primary key.',
    `license_agreement_id` BIGINT COMMENT 'Reference to the parent license agreement under which this payment schedule is defined.',
    `accounting_period` STRING COMMENT 'The financial accounting period (e.g., 2024-Q1, 2024-03) to which this payment obligation is allocated for budgeting and forecasting purposes.',
    `actual_payment_date` DATE COMMENT 'The date on which the payment was actually made to the licensor. Null if payment has not yet been completed.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the payment for execution. Null if not yet approved.',
    `approved_date` DATE COMMENT 'Date on which the payment was approved for execution. Null if not yet approved.',
    `cost_center` STRING COMMENT 'The organizational cost center or department responsible for this payment obligation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this license fee schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `general_ledger_account` STRING COMMENT 'The general ledger account code to which this payment expense is posted.',
    `grace_period_days` STRING COMMENT 'Number of days after the scheduled payment date before the payment is considered overdue.',
    `installment_number` STRING COMMENT 'Sequential installment number for multi-installment payment schedules (e.g., 1 of 4, 2 of 4). Null for single payments.',
    `invoice_number` STRING COMMENT 'Reference to the invoice document generated for this payment obligation. Null if not yet invoiced.',
    `last_modified_by` STRING COMMENT 'User or system identifier that last modified this license fee schedule record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this license fee schedule record was last updated.',
    `late_fee_applicable` BOOLEAN COMMENT 'Indicates whether late fees or penalties apply if payment is not made by the scheduled date.',
    `late_fee_percentage` DECIMAL(18,2) COMMENT 'Percentage rate applied to the payment amount for late payment penalties. Null if late fees are not applicable.',
    `milestone_description` STRING COMMENT 'Detailed description of the payment milestone or trigger event, such as contract signing, delivery of content, broadcast commencement, or anniversary date.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'Net amount paid to the licensor after deducting withholding tax and any other adjustments.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The monetary value of the scheduled payment obligation.',
    `payment_approval_status` STRING COMMENT 'Internal approval workflow status for the payment: pending approval (awaiting authorization), approved (cleared for payment), or rejected (payment denied).. Valid values are `pending_approval|approved|rejected`',
    `payment_method` STRING COMMENT 'The instrument or mechanism used to execute the payment: wire transfer, check, ACH (Automated Clearing House), credit card, PayPal, or other.. Valid values are `wire_transfer|check|ach|credit_card|paypal|other`',
    `payment_notes` STRING COMMENT 'Free-text notes or comments regarding the payment schedule entry, including special instructions, dispute details, or waiver justifications.',
    `payment_reference_number` STRING COMMENT 'External payment transaction reference or confirmation number from the payment system or bank. Null if payment not yet executed.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment: scheduled (not yet due), invoiced (invoice generated), paid (payment completed), overdue (past due date), waived (obligation forgiven), or disputed (under review).. Valid values are `scheduled|invoiced|paid|overdue|waived|disputed`',
    `payment_type` STRING COMMENT 'Classification of the payment obligation: advance (upfront payment), minimum guarantee installment (periodic MG payment), per-episode fee (unit-based payment), annual license fee (recurring annual payment), milestone payment (event-triggered payment), or royalty payment (revenue-share payment).. Valid values are `advance|minimum_guarantee_installment|per_episode_fee|annual_license_fee|milestone_payment|royalty_payment`',
    `schedule_number` STRING COMMENT 'Business identifier for the payment schedule entry, typically a sequential or hierarchical code within the agreement.',
    `scheduled_payment_date` DATE COMMENT 'The contractually agreed date on which the payment is due to the licensor.',
    `total_installments` STRING COMMENT 'Total number of installments in the payment schedule. Null for single payments.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Calculated withholding tax amount deducted from the payment. Null if no withholding applies.',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'Percentage of the payment amount subject to withholding tax as required by jurisdiction or treaty. Null if no withholding applies.',
    `created_by` STRING COMMENT 'User or system identifier that created this license fee schedule record.',
    CONSTRAINT pk_license_fee_schedule PRIMARY KEY(`license_fee_schedule_id`)
) COMMENT 'Defines the structured payment schedule for license fees owed under a license agreement, including upfront advances, milestone payments, and periodic installments. Captures the parent agreement reference, payment milestone description, scheduled payment date, payment amount, currency, payment type (advance, minimum guarantee installment, per-episode fee, annual license fee), payment status (scheduled, invoiced, paid, overdue), and actual payment date. Enables cash flow forecasting for rights expenditure and feeds the billing domain for invoice generation.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` (
    `rights_audit_event_id` BIGINT COMMENT 'Unique identifier for the rights audit event record. Primary key.',
    `employee_id` BIGINT COMMENT 'The system user identifier of the person who approved the rights change. NULL if approval not required or still pending.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Rights audit events (unauthorized fee changes, missing clearances, contract breaches) trigger compliance audit findings. Links rights system changes to formal audit findings for SOX and regulatory rev',
    `media_asset_id` BIGINT COMMENT 'Identifier of the content asset affected by this rights change. Links to the content domain for cross-domain audit trail analysis.',
    `primary_rights_employee_id` BIGINT COMMENT 'The system user identifier of the person or service account that initiated the rights change. May reference an employee ID, service account, or external system identifier.',
    `rights_audit_session_id` BIGINT COMMENT 'Unique identifier for the user session or API session during which the rights change occurred. Supports forensic analysis of user activity patterns.',
    `affected_entity_business_key` STRING COMMENT 'The human-readable business identifier of the affected entity (e.g., agreement number, grant number, window name) for easier audit trail interpretation.',
    `affected_entity_reference` BIGINT COMMENT 'The unique identifier of the specific rights domain entity that was modified (e.g., the rights_grant_id, license_agreement_id, or holdback_id).',
    `affected_entity_type` STRING COMMENT 'The type of rights domain entity that was modified by this audit event (e.g., rights grant, license agreement, content window, holdback record).. Valid values are `rights_grant|license_agreement|content_window|holdback|royalty_statement|clearance_record`',
    `approval_reference_number` STRING COMMENT 'Unique reference number or workflow ticket ID associated with the approval process for cross-system traceability.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether the rights change required formal approval before being committed. True if approval workflow was triggered, False otherwise.',
    `approval_status` STRING COMMENT 'Current approval status of the rights change event. Tracks whether the change has been reviewed and authorized per governance policies.. Valid values are `pending|approved|rejected|not_required|auto_approved`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the rights change was formally approved. NULL if approval not required or still pending. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    `approver_user_name` STRING COMMENT 'The full name or display name of the approver for human-readable audit trail reporting. NULL if approval not required or still pending.',
    `audit_retention_period_days` STRING COMMENT 'Number of days this audit record must be retained per regulatory or legal requirements. Drives data lifecycle management policies.',
    `change_reason_code` STRING COMMENT 'Standardized code indicating the business reason for the rights change. [ENUM-REF-CANDIDATE: contract_amendment|rights_expiration|territory_expansion|territory_restriction|holdback_negotiation|clearance_issue|royalty_adjustment|windowing_strategy_update|compliance_requirement|legal_dispute|system_correction|data_migration — promote to reference product]. Valid values are `contract_amendment|rights_expiration|territory_expansion|holdback_negotiation|clearance_issue|royalty_adjustment`',
    `change_reason_description` STRING COMMENT 'Free-text explanation providing additional context and business justification for the rights change event.',
    `changed_field_name` STRING COMMENT 'The name of the specific attribute or field within the affected entity that was modified (e.g., grant_end_date, holdback_start_date, royalty_rate_percent).',
    `compliance_framework` STRING COMMENT 'The regulatory or compliance framework that mandates audit logging of this rights change event (e.g., SOX for financial controls, FCC for broadcast licensing, Ofcom for UK broadcasting standards).. Valid values are `SOX|FCC|Ofcom|GDPR|CCPA|MPA`',
    `content_title` STRING COMMENT 'Human-readable title of the content asset affected by this rights change, denormalized for audit report readability.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this audit event record was created in the lakehouse. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Distinct from event_timestamp which captures the source system event time.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount (e.g., USD, GBP, EUR). NULL if no financial impact.. Valid values are `^[A-Z]{3}$`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this rights change is associated with a legal dispute or rights conflict. True if dispute exists, False otherwise.',
    `dispute_reference_number` STRING COMMENT 'Reference number or case identifier for any legal dispute or rights conflict associated with this change. NULL if no dispute exists.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the rights change event occurred in the source system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    `event_type` STRING COMMENT 'Classification of the audit event indicating the nature of the change to the rights domain entity. [ENUM-REF-CANDIDATE: rights_grant_created|rights_grant_modified|rights_grant_terminated|window_created|window_modified|window_deleted|holdback_added|holdback_modified|holdback_removed|agreement_created|agreement_amended|agreement_terminated|clearance_overridden|royalty_adjusted|territory_restriction_added|territory_restriction_removed|exclusivity_changed|sublicense_granted|run_limit_modified — promote to reference product]',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated monetary impact of the rights change in the agreement currency. Positive for revenue increases, negative for decreases. NULL if no direct financial impact.',
    `financial_impact_flag` BOOLEAN COMMENT 'Indicates whether this rights change has direct financial implications (e.g., royalty rate change, license fee adjustment, minimum guarantee modification). True if financial impact exists, False otherwise.',
    `initiating_system` STRING COMMENT 'The source system or application that generated the rights change event (e.g., Rightsline, SAP, manual entry, API integration).. Valid values are `Rightsline|SAP_S4HANA|Manual_Entry|API_Integration|Batch_Process|Data_Migration`',
    `initiating_user_name` STRING COMMENT 'The full name or display name of the user who initiated the rights change, for human-readable audit trail reporting.',
    `ip_address` STRING COMMENT 'The IP address from which the rights change was initiated. Supports security audit and geographic access analysis. May be IPv4 or IPv6 format.',
    `new_value` DECIMAL(18,2) COMMENT 'The value of the changed field after the modification occurred. Stored as string representation to accommodate all data types. NULL for deletion events.',
    `previous_value` DECIMAL(18,2) COMMENT 'The value of the changed field before the modification occurred. Stored as string representation to accommodate all data types. NULL for new record creation events.',
    `record_hash` STRING COMMENT 'Cryptographic hash (e.g., SHA-256) of the audit event record to ensure immutability and detect tampering. Supports forensic integrity verification.',
    `territory_affected` STRING COMMENT 'Geographic territory or market affected by the rights change (e.g., USA, GBR, Worldwide). Uses three-letter ISO 3166-1 alpha-3 country codes or territory groupings.',
    `transaction_reference` STRING COMMENT 'Unique identifier for the database transaction or batch operation that committed this change. Enables grouping of related audit events within a single transaction.',
    `window_type_affected` STRING COMMENT 'The content distribution window type affected by this rights change (e.g., theatrical, SVOD, AVOD, TVOD, linear broadcast, syndication). NULL if change does not affect windowing. [ENUM-REF-CANDIDATE: theatrical|SVOD|AVOD|TVOD|linear|syndication|home_video — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_rights_audit_event PRIMARY KEY(`rights_audit_event_id`)
) COMMENT 'Immutable audit log of all material changes to rights grants, license agreements, content windows, and holdback records within the rights domain. Captures event type (rights grant created, window modified, holdback added, agreement terminated, clearance overridden), the affected entity type and ID, previous and new values of changed fields, change timestamp, initiating user or system, change reason, and approval reference if applicable. Supports regulatory compliance (FCC, Ofcom), legal dispute resolution, and SOX financial audit trails for rights expenditure.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` (
    `rights_audit_session_id` BIGINT COMMENT 'Primary key for rights_audit_session',
    `content_portfolio_id` BIGINT COMMENT 'Identifier of the specific content portfolio or catalog being audited, if the audit is scoped to a particular content grouping.',
    `previous_rights_audit_session_id` BIGINT COMMENT 'Self-referencing FK on rights_audit_session (previous_rights_audit_session_id)',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or executive who approved the audit session findings and report.',
    `rights_created_by_employee_id` BIGINT COMMENT 'Identifier of the user or system process that created this audit session record.',
    `rights_employee_id` BIGINT COMMENT 'Identifier of the primary auditor responsible for conducting and overseeing this audit session.',
    `holder_id` BIGINT COMMENT 'Identifier of the rights holder or licensor whose rights portfolio is being audited in this session.',
    `rights_modified_by_employee_id` BIGINT COMMENT 'Identifier of the user or system process that last modified this audit session record.',
    `auditor_employee_id` BIGINT COMMENT '',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the audit session was actually completed or closed.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the audit session actually commenced, capturing the real-world event time of audit initiation.',
    `approval_status` STRING COMMENT 'Management approval status for the audit session and its findings: pending approval, approved and accepted, rejected, or revision requested before approval.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit session was formally approved by management.',
    `audit_methodology` STRING COMMENT 'Approach used to conduct the audit: manual review by auditors, automated system-driven analysis, hybrid combination of manual and automated, or statistical sampling methodology.',
    `audit_period_end_date` DATE COMMENT 'Ending date of the time period covered by this audit session (the data/transactions being audited).',
    `audit_period_start_date` DATE COMMENT 'Beginning date of the time period covered by this audit session (the data/transactions being audited).',
    `audit_report_url` STRING COMMENT 'URL or file path to the detailed audit report document generated for this session.',
    `audit_scope` STRING COMMENT 'Defines the breadth of the audit session: full comprehensive review, partial subset review, targeted specific-issue investigation, or sample-based statistical audit.',
    `audit_team_size` STRING COMMENT 'Number of auditors and support personnel assigned to this audit session.',
    `audit_type` STRING COMMENT 'Classification of the audit session by its primary focus area: compliance verification, financial reconciliation, operational review, contractual adherence, territory restriction validation, windowing strategy verification, or royalty calculation audit.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Overall compliance score for this audit session, expressed as a percentage (0.00 to 100.00) representing the degree of adherence to rights management policies and contractual obligations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit session record was first created in the system.',
    `critical_findings_count` STRING COMMENT 'Number of critical-severity findings that require immediate remediation or represent significant compliance risks.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for financial amounts reported in this audit session.',
    `distribution_channel_scope` STRING COMMENT 'Distribution channels included in the audit scope (e.g., theatrical, SVOD, AVOD, TVOD, linear television, home video).',
    `financial_discrepancy_amount` DECIMAL(18,2) COMMENT 'Total monetary value of financial discrepancies identified during the audit, representing under-payments, over-payments, or unreconciled amounts. Expressed in the reporting currency.',
    `findings_count` STRING COMMENT 'Total number of audit findings, discrepancies, or issues identified during this audit session.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit session record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text notes and observations recorded by auditors during the session, including context, special circumstances, or additional commentary.',
    `remediation_deadline_date` DATE COMMENT 'Target date by which all identified audit findings must be remediated and corrective actions completed.',
    `remediation_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this audit session identified issues requiring formal remediation actions (True) or no remediation is needed (False).',
    `rightsline_sync_status` STRING COMMENT 'Status of data synchronization with the Rightsline rights management system for this audit session: successfully synced, sync pending, sync failed, or not applicable for this audit type.',
    `rightsline_sync_timestamp` TIMESTAMP COMMENT 'Timestamp of the last successful synchronization of audit findings with the Rightsline rights management platform.',
    `scheduled_end_date` DATE COMMENT 'Planned date when the audit session is scheduled to conclude.',
    `scheduled_start_date` DATE COMMENT 'Planned date when the audit session is scheduled to begin.',
    `session_number` STRING COMMENT 'Business-facing unique identifier for the audit session, used for external reference and reporting.',
    `rights_audit_session_status` STRING COMMENT 'Current lifecycle state of the audit session: scheduled for future execution, actively in progress, under management review, completed with findings documented, cancelled before completion, or temporarily suspended.',
    `territory_scope` STRING COMMENT 'Geographic territories included in the audit scope, specified as comma-separated ISO 3166-1 alpha-3 country codes or territory groupings.',
    `total_records_reviewed` BIGINT COMMENT 'Total number of rights records, transactions, or data points examined during this audit session.',
    CONSTRAINT pk_rights_audit_session PRIMARY KEY(`rights_audit_session_id`)
) COMMENT 'Master reference table for rights_audit_session. Referenced by session_id.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`blocking_category_ref` (
    `blocking_category_ref_id` BIGINT COMMENT '',
    `blocking_category_ref_code` STRING COMMENT '',
    `blocking_category_ref_description` STRING COMMENT '',
    CONSTRAINT pk_blocking_category_ref PRIMARY KEY(`blocking_category_ref_id`)
) COMMENT '';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ADD CONSTRAINT `fk_rights_rights_content_window_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ADD CONSTRAINT `fk_rights_rights_content_window_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ADD CONSTRAINT `fk_rights_royalty_rule_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ADD CONSTRAINT `fk_rights_royalty_rule_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_royalty_rule_id` FOREIGN KEY (`royalty_rule_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`royalty_rule`(`royalty_rule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_royalty_statement_id` FOREIGN KEY (`royalty_statement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`royalty_statement`(`royalty_statement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_royalty_rule_id` FOREIGN KEY (`royalty_rule_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`royalty_rule`(`royalty_rule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_conflict_id` FOREIGN KEY (`conflict_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`conflict`(`conflict_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_holdback_id` FOREIGN KEY (`holdback_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holdback`(`holdback_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_music_sync_license_id` FOREIGN KEY (`music_sync_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`music_sync_license`(`music_sync_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_rights_availability_window_id` FOREIGN KEY (`rights_availability_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window`(`rights_availability_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_blocking_category_ref_id` FOREIGN KEY (`blocking_category_ref_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`blocking_category_ref`(`blocking_category_ref_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ADD CONSTRAINT `fk_rights_rights_availability_window_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ADD CONSTRAINT `fk_rights_rights_availability_window_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ADD CONSTRAINT `fk_rights_rights_availability_window_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ADD CONSTRAINT `fk_rights_conflict_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ADD CONSTRAINT `fk_rights_conflict_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ADD CONSTRAINT `fk_rights_conflict_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ADD CONSTRAINT `fk_rights_license_amendment_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ADD CONSTRAINT `fk_rights_license_amendment_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ADD CONSTRAINT `fk_rights_license_amendment_superseded_by_amendment_license_amendment_id` FOREIGN KEY (`superseded_by_amendment_license_amendment_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_amendment`(`license_amendment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_rights_content_window_id` FOREIGN KEY (`rights_content_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_content_window`(`rights_content_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_royalty_statement_id` FOREIGN KEY (`royalty_statement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`royalty_statement`(`royalty_statement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ADD CONSTRAINT `fk_rights_rights_blackout_rule_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ADD CONSTRAINT `fk_rights_rights_blackout_rule_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ADD CONSTRAINT `fk_rights_rights_blackout_rule_rights_syndication_deal_id` FOREIGN KEY (`rights_syndication_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal`(`rights_syndication_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ADD CONSTRAINT `fk_rights_rights_blackout_rule_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ADD CONSTRAINT `fk_rights_rights_syndication_deal_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ADD CONSTRAINT `fk_rights_rights_syndication_deal_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ADD CONSTRAINT `fk_rights_rights_syndication_deal_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ADD CONSTRAINT `fk_rights_license_fee_schedule_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ADD CONSTRAINT `fk_rights_rights_audit_event_rights_audit_session_id` FOREIGN KEY (`rights_audit_session_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session`(`rights_audit_session_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ADD CONSTRAINT `fk_rights_rights_audit_session_previous_rights_audit_session_id` FOREIGN KEY (`previous_rights_audit_session_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session`(`rights_audit_session_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ADD CONSTRAINT `fk_rights_rights_audit_session_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`rights` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`rights` SET TAGS ('dbx_domain' = 'rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` SET TAGS ('dbx_subdomain' = 'license_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Sales Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Negotiator Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Licensor Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Licensee Partner Partner Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` SET TAGS ('dbx_subdomain' = 'license_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `coppa_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Coppa Declaration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` SET TAGS ('dbx_subdomain' = 'availability_control');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `rights_content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Content Window Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `closed_caption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'available|held_back|blacked_out|expired|pending');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_business_glossary_term' = 'Blackout Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `blackout_reason` SET TAGS ('dbx_business_glossary_term' = 'Blackout Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `clearance_notes` SET TAGS ('dbx_business_glossary_term' = 'Clearance Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|rejected|conditional');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `drm_requirement` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Requirement');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `drm_requirement` SET TAGS ('dbx_value_regex' = 'widevine|fairplay|playready|none|multi_drm');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `exclusivity_tier` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `exclusivity_tier` SET TAGS ('dbx_value_regex' = 'exclusive|non_exclusive|first_window|second_window');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `geo_blocking_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Geo-Blocking Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `holdback_end_date` SET TAGS ('dbx_business_glossary_term' = 'Holdback End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `holdback_start_date` SET TAGS ('dbx_business_glossary_term' = 'Holdback Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `last_availability_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Availability Refresh Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'License Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `license_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'License Fee Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `platform_scope` SET TAGS ('dbx_business_glossary_term' = 'Platform Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `sublicense_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicense Permitted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `usage_cap_type` SET TAGS ('dbx_business_glossary_term' = 'Usage Cap Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `usage_cap_type` SET TAGS ('dbx_value_regex' = 'streams|downloads|broadcasts|screenings|impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `usage_cap_units` SET TAGS ('dbx_business_glossary_term' = 'Usage Cap Units');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `window_close_date` SET TAGS ('dbx_business_glossary_term' = 'Window Close Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `window_extension_count` SET TAGS ('dbx_business_glossary_term' = 'Window Extension Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `window_open_date` SET TAGS ('dbx_business_glossary_term' = 'Window Open Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `window_priority` SET TAGS ('dbx_business_glossary_term' = 'Window Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ALTER COLUMN `window_type` SET TAGS ('dbx_business_glossary_term' = 'Window Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` SET TAGS ('dbx_subdomain' = 'availability_control');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `holdback_id` SET TAGS ('dbx_business_glossary_term' = 'Holdback Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `partner_content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Content Window Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restricted_platform` SET TAGS ('dbx_business_glossary_term' = 'Restricted Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'platform_holdback|territory_holdback|channel_holdback|format_holdback|daypart_holdback|exclusive_holdback');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Holdback Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `triggering_window_type` SET TAGS ('dbx_business_glossary_term' = 'Triggering Window Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `windowing_strategy_notes` SET TAGS ('dbx_business_glossary_term' = 'Windowing Strategy Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` SET TAGS ('dbx_subdomain' = 'availability_control');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `blackout_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Blackout Restricted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `broadcast_standard` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_business_glossary_term' = 'Content Rating System');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `coppa_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `gdpr_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `holdback_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Holdback Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `internet_penetration_percent` SET TAGS ('dbx_business_glossary_term' = 'Internet Penetration Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `iso_alpha_2_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Alpha-2 Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `iso_alpha_2_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `iso_alpha_3_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Alpha-3 Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `iso_alpha_3_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `iso_numeric_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Numeric Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `iso_numeric_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `language_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `language_primary` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `language_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `language_secondary` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Territory Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `ott_market_maturity` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Top (OTT) Market Maturity');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `ott_market_maturity` SET TAGS ('dbx_value_regex' = 'mature|developing|emerging|nascent');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `population` SET TAGS ('dbx_business_glossary_term' = 'Population');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `quota_percentage` SET TAGS ('dbx_business_glossary_term' = 'Content Quota Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `quota_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Content Quota Requirement Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `rights_territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `rights_territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|restricted|pending');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `territory_group` SET TAGS ('dbx_business_glossary_term' = 'Territory Group');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'country|region|worldwide|custom');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `vat_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Value-Added Tax (VAT) Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `vat_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Value-Added Tax (VAT) Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ALTER COLUMN `withholding_tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` SET TAGS ('dbx_subdomain' = 'royalty_settlement');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier (ID)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'revenue|subscriber_count|stream_count|unit_count|grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` SET TAGS ('dbx_subdomain' = 'royalty_settlement');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `royalty_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Statement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` SET TAGS ('dbx_subdomain' = 'royalty_settlement');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_statement_line_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Statement Line ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Statement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `adjustments_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustments Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `advance_recoupment_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Recoupment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `calculated_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Calculated Royalty Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `content_title` SET TAGS ('dbx_business_glossary_term' = 'Content Title');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` SET TAGS ('dbx_subdomain' = 'royalty_settlement');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `residual_id` SET TAGS ('dbx_business_glossary_term' = 'Residual Payment Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `calculated_residual_amount` SET TAGS ('dbx_business_glossary_term' = 'Calculated Residual Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `calculation_basis_amount` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `calculation_basis_currency` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `calculation_basis_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Residual Calculation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `contract_cycle` SET TAGS ('dbx_business_glossary_term' = 'Contract Cycle Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Residual Payment Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exhibition_count` SET TAGS ('dbx_business_glossary_term' = 'Exhibition Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exploitation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Exploitation End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exploitation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Exploitation Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_business_glossary_term' = 'Exploitation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `formula_type` SET TAGS ('dbx_business_glossary_term' = 'Residual Formula Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `formula_type` SET TAGS ('dbx_value_regex' = 'FIXED_AMOUNT|PERCENTAGE_OF_GROSS|PERCENTAGE_OF_DISTRIBUTOR_GROSS|TIERED_SCALE|PER_EXHIBITION|MINIMUM_GUARANTEE');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `guild_report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Guild Report Submission Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `guild_report_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Guild Report Submitted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `guild_union_code` SET TAGS ('dbx_business_glossary_term' = 'Guild or Union Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Residual Payment Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'DIRECT_DEPOSIT|CHECK|WIRE_TRANSFER|GUILD_TRUST|PAYROLL');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'PENDING|APPROVED|PAID|DISPUTED|WITHHELD|CANCELLED');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Residual Percentage Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` SET TAGS ('dbx_subdomain' = 'license_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `music_sync_license_id` SET TAGS ('dbx_business_glossary_term' = 'Music Synchronization License ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cleared By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Approved Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_notes` SET TAGS ('dbx_business_glossary_term' = 'Clearance Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_requested_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Requested Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|rejected|expired|under_review|conditional');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `composer_name` SET TAGS ('dbx_business_glossary_term' = 'Composer Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `composition_title` SET TAGS ('dbx_business_glossary_term' = 'Composition Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `cue_sheet_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cue Sheet Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `isrc_code` SET TAGS ('dbx_business_glossary_term' = 'International Standard Recording Code (ISRC)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `isrc_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `iswc_code` SET TAGS ('dbx_business_glossary_term' = 'International Standard Musical Work Code (ISWC)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `iswc_code` SET TAGS ('dbx_value_regex' = '^T-[0-9]{9}-[0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_end_date` SET TAGS ('dbx_business_glossary_term' = 'License End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'License Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'License Fee Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_start_date` SET TAGS ('dbx_business_glossary_term' = 'License Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'master_use|synchronization|blanket|per_title|mechanical|performance');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `licensed_platforms` SET TAGS ('dbx_business_glossary_term' = 'Licensed Platforms');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `pro_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Performance Rights Organization (PRO) Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `restrictions` SET TAGS ('dbx_business_glossary_term' = 'License Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `rights_holder_type` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `rights_holder_type` SET TAGS ('dbx_value_regex' = 'publisher|record_label|pro|independent_artist|production_company|collective');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `royalty_basis` SET TAGS ('dbx_business_glossary_term' = 'Royalty Basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `royalty_basis` SET TAGS ('dbx_value_regex' = 'gross_revenue|net_revenue|per_stream|per_download|per_unit|flat_fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `sublicense_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicense Permitted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `usage_type` SET TAGS ('dbx_business_glossary_term' = 'Usage Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `usage_type` SET TAGS ('dbx_value_regex' = 'background|theme|featured|promotional|trailer|credits');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` SET TAGS ('dbx_subdomain' = 'clearance_audit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_request_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `conflict_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Conflict Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `coppa_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Coppa Declaration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `guarantee_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Guarantee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `holdback_id` SET TAGS ('dbx_business_glossary_term' = 'Holdback Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `music_sync_license_id` SET TAGS ('dbx_business_glossary_term' = 'Music Sync License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `rights_availability_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Window ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `blocking_category_ref_id` SET TAGS ('dbx_business_glossary_term' = 'Blocking Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_business_glossary_term' = 'Analyst Notes');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` SET TAGS ('dbx_subdomain' = 'availability_control');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `rights_availability_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Availability Window ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `partner_content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Content Window ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `advertising_allowed` SET TAGS ('dbx_business_glossary_term' = 'Advertising Allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `availability_end_date` SET TAGS ('dbx_business_glossary_term' = 'Availability End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `availability_start_date` SET TAGS ('dbx_business_glossary_term' = 'Availability Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `blackout_indicator` SET TAGS ('dbx_business_glossary_term' = 'Blackout Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `carriage_fee_applicable` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|blocked|conditional');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `computed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Computed Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `download_to_own_allowed` SET TAGS ('dbx_business_glossary_term' = 'Download to Own Allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `drm_requirement` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Requirement');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `drm_requirement` SET TAGS ('dbx_value_regex' = 'none|basic|standard|premium');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `expiration_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Expiration Notification Sent');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `max_resolution` SET TAGS ('dbx_business_glossary_term' = 'Maximum Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `max_resolution` SET TAGS ('dbx_value_regex' = 'SD|HD|FHD|UHD|4K|8K');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `offline_viewing_allowed` SET TAGS ('dbx_business_glossary_term' = 'Offline Viewing Allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `platform_type` SET TAGS ('dbx_value_regex' = 'SVOD|AVOD|TVOD|linear|FAST|MVPD');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `simulcast_allowed` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'HLS|MPEG-DASH|RTMP|smooth|progressive');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `subtitle_requirement` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Requirement');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `subtitle_requirement` SET TAGS ('dbx_value_regex' = 'none|optional|mandatory|closed_caption');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `syndication_allowed` SET TAGS ('dbx_business_glossary_term' = 'Syndication Allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `window_status` SET TAGS ('dbx_business_glossary_term' = 'Window Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ALTER COLUMN `window_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|suspended|revoked|extended');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` SET TAGS ('dbx_subdomain' = 'availability_control');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `conflict_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Conflict Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Analyst Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Rights Grant Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `tertiary_conflict_resolved_by_analyst_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Resolved By Analyst Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `tertiary_conflict_resolved_by_analyst_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `tertiary_conflict_resolved_by_analyst_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `affected_distribution_partners` SET TAGS ('dbx_business_glossary_term' = 'Affected Distribution Partners');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `affected_distribution_partners` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `business_priority` SET TAGS ('dbx_business_glossary_term' = 'Business Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `business_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `conflict_type` SET TAGS ('dbx_business_glossary_term' = 'Conflict Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `conflict_type` SET TAGS ('dbx_value_regex' = 'territorial_overlap|platform_overlap|holdback_violation|window_gap|exclusivity_breach|duration_overlap');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conflict Detection Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'automated_system_scan|manual_review|contract_ingestion|scheduling_validation|distribution_check|clearance_workflow');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `legal_opinion_summary` SET TAGS ('dbx_business_glossary_term' = 'Legal Opinion Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `legal_opinion_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `legal_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Conflict Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^RC-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Resolution Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|under_review|pending_legal|resolved|waived|escalated');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Conflict Severity Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'blocking|warning|informational');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `sla_resolution_deadline` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Resolution Deadline');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ALTER COLUMN `window_type` SET TAGS ('dbx_business_glossary_term' = 'Window Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` SET TAGS ('dbx_subdomain' = 'license_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `license_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'License Amendment Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Licensor Party Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Licensor Rights Holder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `primary_licensee_party_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Party Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `superseded_by_amendment_license_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Amendment Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `licensee_party_partner_id` SET TAGS ('dbx_business_role_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `amended_license_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Amended License Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `amended_term_end_date` SET TAGS ('dbx_business_glossary_term' = 'Amended Term End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|pending_approval|executed|rejected|superseded');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'term_extension|territory_expansion|platform_addition|fee_renegotiation|rights_modification|termination');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `changed_terms_summary` SET TAGS ('dbx_business_glossary_term' = 'Changed Terms Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Execution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `fee_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Adjustment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `holdback_period_change_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period Change Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `legal_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Document Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `original_license_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Original License Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `original_term_end_date` SET TAGS ('dbx_business_glossary_term' = 'Original Term End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `platforms_added` SET TAGS ('dbx_business_glossary_term' = 'Platforms Added');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `platforms_removed` SET TAGS ('dbx_business_glossary_term' = 'Platforms Removed');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `requires_royalty_recalculation` SET TAGS ('dbx_business_glossary_term' = 'Requires Royalty Recalculation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `royalty_rate_change_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Change Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `territories_added` SET TAGS ('dbx_business_glossary_term' = 'Territories Added');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ALTER COLUMN `territories_removed` SET TAGS ('dbx_business_glossary_term' = 'Territories Removed');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` SET TAGS ('dbx_subdomain' = 'royalty_settlement');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `exploitation_report_id` SET TAGS ('dbx_business_glossary_term' = 'Exploitation Report ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `cross_platform_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Cross Platform Measurement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Entity ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `nielsen_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `reach_frequency_report_id` SET TAGS ('dbx_business_glossary_term' = 'Reach Frequency Report Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Market Coverage Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `rights_content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Content Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `royalty_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Statement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validated By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `amendment_notes` SET TAGS ('dbx_business_glossary_term' = 'Amendment Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `audit_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `content_title` SET TAGS ('dbx_business_glossary_term' = 'Content Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_business_glossary_term' = 'Exploitation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `gross_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Revenue Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `report_format_version` SET TAGS ('dbx_business_glossary_term' = 'Report Format Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `report_format_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Exploitation Report Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `report_number` SET TAGS ('dbx_value_regex' = '^EXP-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Exploitation Report Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Exploitation Report Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'usage_submission|usage_receipt|royalty_evidence|audit_support|reconciliation|ad_hoc');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `reporting_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Reporting Entity Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `total_broadcasts` SET TAGS ('dbx_business_glossary_term' = 'Total Broadcasts');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `total_streams` SET TAGS ('dbx_business_glossary_term' = 'Total Streams');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `total_viewing_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Viewing Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ALTER COLUMN `unique_viewers` SET TAGS ('dbx_business_glossary_term' = 'Unique Viewers');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` SET TAGS ('dbx_subdomain' = 'clearance_audit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` SET TAGS ('dbx_subdomain' = 'availability_control');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `rights_blackout_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Blackout Rule Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `rights_syndication_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `applicable_platform` SET TAGS ('dbx_business_glossary_term' = 'Applicable Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `automated_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Enforcement Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `blackout_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Blackout Duration in Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `blackout_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Blackout End Date and Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `blackout_message_text` SET TAGS ('dbx_business_glossary_term' = 'Blackout Message Text');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `blackout_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Blackout Rule Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `blackout_rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `blackout_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Blackout Start Date and Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `blackout_type` SET TAGS ('dbx_business_glossary_term' = 'Blackout Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `blackout_type` SET TAGS ('dbx_value_regex' = 'sports_local_market|affiliate_exclusivity|regulatory|territorial_holdback|competitive_protection|league_imposed');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `conflict_resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Conflict Resolution Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `dma_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `enforcement_method` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `enforcement_method` SET TAGS ('dbx_value_regex' = 'geo_blocking|content_suppression|redirect|alternate_feed|manual_override');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|waived|pending_activation|overridden');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `home_team_market_flag` SET TAGS ('dbx_business_glossary_term' = 'Home Team Market Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `notification_sent_datetime` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date and Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `sports_league_code` SET TAGS ('dbx_business_glossary_term' = 'Sports League Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `sports_league_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `triggering_rights_clause` SET TAGS ('dbx_business_glossary_term' = 'Triggering Rights Clause');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `triggering_rights_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `waiver_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` SET TAGS ('dbx_subdomain' = 'license_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `rights_syndication_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Deal Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Executive Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `auto_renewal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `blackout_applicable` SET TAGS ('dbx_business_glossary_term' = 'Blackout Applicable Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `blackout_description` SET TAGS ('dbx_business_glossary_term' = 'Blackout Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'pending|in-progress|cleared|blocked|conditional');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `content_package_description` SET TAGS ('dbx_business_glossary_term' = 'Content Package Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `content_scope` SET TAGS ('dbx_business_glossary_term' = 'Content Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `content_scope` SET TAGS ('dbx_value_regex' = 'single-title|series|season|package|library');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `deal_end_date` SET TAGS ('dbx_business_glossary_term' = 'Syndication Deal End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `deal_notes` SET TAGS ('dbx_business_glossary_term' = 'Syndication Deal Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_business_glossary_term' = 'Syndication Deal Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `deal_start_date` SET TAGS ('dbx_business_glossary_term' = 'Syndication Deal Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_business_glossary_term' = 'Syndication Deal Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `deal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Deal Term in Months');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `drm_required` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Required Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `exclusivity_indicator` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `fee_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Structure Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `fee_structure_type` SET TAGS ('dbx_value_regex' = 'flat-fee|per-episode|per-run|revenue-share|barter|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `format_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Format Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `licensee_type` SET TAGS ('dbx_business_glossary_term' = 'Licensee Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `music_sync_license_required` SET TAGS ('dbx_business_glossary_term' = 'Music Synchronization License Required Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `per_episode_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Per-Episode Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `per_episode_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `platform_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Platform Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `run_limit` SET TAGS ('dbx_business_glossary_term' = 'Run Limit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `runs_used` SET TAGS ('dbx_business_glossary_term' = 'Runs Used');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `sublicense_permitted` SET TAGS ('dbx_business_glossary_term' = 'Sublicense Permitted Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `syndication_type` SET TAGS ('dbx_business_glossary_term' = 'Syndication Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `syndication_type` SET TAGS ('dbx_value_regex' = 'first-run|off-network|international|digital|barter|cash-plus-barter');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `talent_residuals_applicable` SET TAGS ('dbx_business_glossary_term' = 'Talent Residuals Applicable Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` SET TAGS ('dbx_subdomain' = 'license_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `license_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'License Fee Schedule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `actual_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `installment_number` SET TAGS ('dbx_business_glossary_term' = 'Installment Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `late_fee_applicable` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `late_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `payment_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `payment_approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|check|ach|credit_card|paypal|other');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `payment_notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'scheduled|invoiced|paid|overdue|waived|disputed');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'advance|minimum_guarantee_installment|per_episode_fee|annual_license_fee|milestone_payment|royalty_payment');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `scheduled_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `total_installments` SET TAGS ('dbx_business_glossary_term' = 'Total Installments');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` SET TAGS ('dbx_subdomain' = 'clearance_audit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `rights_audit_event_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Audit Event ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `primary_rights_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `primary_rights_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `rights_audit_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `affected_entity_business_key` SET TAGS ('dbx_business_glossary_term' = 'Affected Entity Business Key');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `affected_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Affected Entity ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `affected_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Affected Entity Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `affected_entity_type` SET TAGS ('dbx_value_regex' = 'rights_grant|license_agreement|content_window|holdback|royalty_statement|clearance_record');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `approval_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required|auto_approved');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `approver_user_name` SET TAGS ('dbx_business_glossary_term' = 'Approver User Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `approver_user_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `audit_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Audit Retention Period Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_value_regex' = 'contract_amendment|rights_expiration|territory_expansion|holdback_negotiation|clearance_issue|royalty_adjustment');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `change_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `changed_field_name` SET TAGS ('dbx_business_glossary_term' = 'Changed Field Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_value_regex' = 'SOX|FCC|Ofcom|GDPR|CCPA|MPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `content_title` SET TAGS ('dbx_business_glossary_term' = 'Content Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `dispute_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `dispute_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `financial_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `initiating_system` SET TAGS ('dbx_business_glossary_term' = 'Initiating System');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `initiating_system` SET TAGS ('dbx_value_regex' = 'Rightsline|SAP_S4HANA|Manual_Entry|API_Integration|Batch_Process|Data_Migration');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `initiating_user_name` SET TAGS ('dbx_business_glossary_term' = 'Initiating User Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `initiating_user_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `new_value` SET TAGS ('dbx_business_glossary_term' = 'New Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `previous_value` SET TAGS ('dbx_business_glossary_term' = 'Previous Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `record_hash` SET TAGS ('dbx_business_glossary_term' = 'Record Hash');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `territory_affected` SET TAGS ('dbx_business_glossary_term' = 'Territory Affected');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ALTER COLUMN `window_type_affected` SET TAGS ('dbx_business_glossary_term' = 'Window Type Affected');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` SET TAGS ('dbx_subdomain' = 'clearance_audit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `rights_audit_session_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Audit Session Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `content_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Content Portfolio Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `previous_rights_audit_session_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Rights Audit Session Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `previous_rights_audit_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `rights_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `rights_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `rights_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `rights_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `rights_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `rights_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `rights_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By Employee Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `rights_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `rights_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `auditor_employee_id` SET TAGS ('dbx_business_role_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `audit_methodology` SET TAGS ('dbx_business_glossary_term' = 'Audit Methodology');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `audit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `audit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `audit_report_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Url');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `audit_report_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `audit_team_size` SET TAGS ('dbx_business_glossary_term' = 'Audit Team Size');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `distribution_channel_scope` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `financial_discrepancy_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Discrepancy Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `financial_discrepancy_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `findings_count` SET TAGS ('dbx_business_glossary_term' = 'Findings Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `remediation_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Deadline Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `rightsline_sync_status` SET TAGS ('dbx_business_glossary_term' = 'Rightsline Sync Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `rightsline_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rightsline Sync Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `session_number` SET TAGS ('dbx_business_glossary_term' = 'Session Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `rights_audit_session_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ALTER COLUMN `total_records_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Total Records Reviewed');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`blocking_category_ref` SET TAGS ('dbx_data_type' = 'reference_data');
