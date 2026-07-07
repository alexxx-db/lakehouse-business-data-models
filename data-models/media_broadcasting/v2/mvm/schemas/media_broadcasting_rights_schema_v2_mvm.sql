-- Schema for Domain: rights | Business: Media_Broadcasting | Version: v2_mvm
-- Generated on: 2026-06-30 06:39:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`rights` COMMENT 'Single source of truth for all intellectual property rights, licensing agreements, and royalty obligations. Manages content windows (theatrical, SVOD, AVOD, TVOD, linear), holdback periods, territory restrictions, talent residuals, music synchronization licenses, clearance workflows, and royalty calculations. Powered by Rightsline, this domain enforces windowing strategies and feeds availability data to scheduling and distribution.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` (
    `license_agreement_id` BIGINT COMMENT 'Unique system identifier for the license agreement record. Primary key. Role: MASTER_AGREEMENT. | Column license_agreement_id (BIGINT) in rights.license_agreement',
    `account_id` BIGINT COMMENT 'Foreign key linking to sales.sales_account. Business justification: License agreements are negotiated with sales accounts (distributors, broadcasters, platforms). Real-world licensing operations require tracking which sales account is the licensee for revenue recognit | Column licensee_sales_account_id (BIGINT) in sales.license_agreement',
    `holder_id` BIGINT COMMENT 'Reference to the party granting rights under this agreement (studio, distributor, music publisher, talent guild, production company). | Column primary_license_holder_id (BIGINT) in rights.license_agreement',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in rights.license_agreement',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in rights.license_agreement',
    `advance_payment_amount` DECIMAL(18,2) COMMENT 'Upfront payment made upon execution of the agreement, typically recoupable against future royalties or license fees. | Column advance_payment_amount (DECIMAL(18,2)) in rights.license_agreement',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the license agreement, used in contracts and communications with rights holders and licensees. | Column agreement_number (STRING) in rights.license_agreement',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the license agreement. Controls whether rights are available for scheduling and distribution. | Column agreement_status (STRING) in rights.license_agreement. Valid values are `draft|executed|active|expired|terminated|suspended`',
    `agreement_type` STRING COMMENT 'Classification of the license agreement based on the nature of the rights transaction. Determines workflow, royalty calculation rules, and windowing strategies. [ENUM-REF-CANDIDATE: acquisition|co-production|syndication|first-run syndication|off-network syndication|international syndication|music sync|output deal — 8 candidates stripped; promote to reference product] | Column agreement_type (STRING) in rights.license_agreement',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews at expiry unless terminated by either party. True = auto-renews, False = expires at term end. | Column auto_renewal_flag (BOOLEAN) in rights.license_agreement',
    `blackout_restrictions` STRING COMMENT 'Geographic or temporal restrictions on content availability (e.g., no broadcast in certain markets during specific events, sports blackout rules). Free-text description. | Column blackout_restrictions (STRING) in rights.license_agreement',
    `clearance_required_flag` BOOLEAN COMMENT 'Indicates whether additional rights clearance verification is required before content can be broadcast or distributed under this agreement. True = clearance workflow required, False = no additional clearance needed. | Column clearance_required_flag (BOOLEAN) in rights.license_agreement',
    `content_rating_restriction` STRING COMMENT 'Content rating limitations imposed by this agreement (e.g., PG-13 and below only, no R-rated content). Comma-separated list of allowed ratings per MPA or TV Parental Guidelines. | Column content_rating_restriction (STRING) in rights.license_agreement',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in rights.license_agreement',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this license agreement record was first created in Rightsline. | Column created_timestamp (TIMESTAMP) in rights.license_agreement',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this agreement (e.g., USD, GBP, EUR). | Column currency_code (STRING) in rights.license_agreement. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date when the license agreement becomes legally binding and rights become available for exploitation. Start of the agreement term. | Column effective_date (DATE) in rights.license_agreement',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the license grants exclusive rights within the territory and media windows. True = exclusive, False = non-exclusive. | Column exclusivity_flag (BOOLEAN) in rights.license_agreement',
    `expiry_date` DATE COMMENT 'Date when the license agreement terminates and rights revert to the licensor. End of the agreement term. Nullable for perpetual agreements. | Column expiry_date (DATE) in rights.license_agreement',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction whose laws govern the interpretation and enforcement of this agreement (e.g., State of California, England and Wales, New York). | Column governing_law_jurisdiction (STRING) in rights.license_agreement',
    `holdback_period_days` STRING COMMENT 'Number of days during which content must be withheld from certain distribution windows to protect exclusivity in other windows (e.g., theatrical holdback before SVOD release). | Column holdback_period_days (INT) in rights.license_agreement',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this license agreement record was last updated in Rightsline. | Column last_modified_timestamp (TIMESTAMP) in rights.license_agreement',
    `media_rights_granted` STRING COMMENT 'Comma-separated list of media exploitation rights included in this agreement (e.g., linear broadcast, SVOD, AVOD, TVOD, theatrical, home video, digital download, mobile streaming). | Column media_rights_granted (STRING) in rights.license_agreement',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment to the licensor regardless of actual usage or revenue performance. Common in output deals and syndication agreements. | Column minimum_guarantee_amount (DECIMAL(18,2)) in rights.license_agreement',
    `music_sync_license_flag` BOOLEAN COMMENT 'Indicates whether this agreement includes music synchronization rights for use of musical compositions in audiovisual content. True = music sync rights included, False = no music sync rights. | Column music_sync_license_flag (BOOLEAN) in rights.license_agreement',
    `notes` STRING COMMENT 'Free-text field for additional contractual terms, special conditions, or internal comments about the agreement. | Column notes (STRING) in rights.license_agreement',
    `payment_schedule_type` STRING COMMENT 'Structure of the payment obligation. Determines how total_license_fee is disbursed over time. | Column payment_schedule_type (STRING) in rights.license_agreement. Valid values are `lump sum|installments|per-episode|annual|milestone-based|revenue share`',
    `per_episode_fee` DECIMAL(18,2) COMMENT 'License fee charged per episode for episodic content. Applicable to syndication and first-run syndication agreements. | Column per_episode_fee (DECIMAL(18,2)) in rights.license_agreement',
    `renewal_term_months` STRING COMMENT 'Duration in months of each automatic renewal period if auto_renewal_flag is true. Null if agreement does not auto-renew. | Column renewal_term_months (INT) in rights.license_agreement',
    `residuals_obligation_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes obligations to pay talent residuals for reuse of content. True = residuals required, False = no residuals. | Column residuals_obligation_flag (BOOLEAN) in rights.license_agreement',
    `royalty_calculation_method` STRING COMMENT 'Method used to calculate ongoing royalty payments to the licensor. Determines how revenue is shared or how usage is monetized. | Column royalty_calculation_method (STRING) in rights.license_agreement. Valid values are `flat fee|percentage of revenue|tiered percentage|per-unit|hybrid`',
    `royalty_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue or receipts paid to the licensor as ongoing royalties. Applicable when royalty_calculation_method is percentage-based. | Column royalty_percentage (DECIMAL(5,2)) in rights.license_agreement',
    `run_count_limit` STRING COMMENT 'Maximum number of times each episode or program may be broadcast or streamed under this agreement. Common in syndication deals. Null indicates unlimited runs. | Column run_count_limit (INT) in rights.license_agreement',
    `signed_date` DATE COMMENT 'Date when the agreement was executed by all parties. May differ from effective_date. | Column signed_date (DATE) in rights.license_agreement',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in rights.license_agreement',
    `sublicensing_allowed_flag` BOOLEAN COMMENT 'Indicates whether the licensee is permitted to sublicense the rights to third parties. True = sublicensing allowed, False = sublicensing prohibited. | Column sublicensing_allowed_flag (BOOLEAN) in rights.license_agreement',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the agreement before expiry or renewal. | Column termination_notice_days (INT) in rights.license_agreement',
    `territory_scope` STRING COMMENT 'Geographic territories covered by this license agreement. Comma-separated list of ISO 3166-1 alpha-3 country codes or region identifiers (e.g., USA,CAN,MEX or WORLDWIDE or EMEA). | Column territory_scope (STRING) in rights.license_agreement',
    `total_license_fee` DECIMAL(18,2) COMMENT 'Total contractual payment obligation for the license rights over the full term of the agreement. Sum of all payment milestones. | Column total_license_fee (DECIMAL(18,2)) in rights.license_agreement',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in rights.license_agreement',
    `windowing_strategy` STRING COMMENT 'Sequential release strategy defining the order and timing of content availability across distribution channels (theatrical, SVOD, AVOD, TVOD, linear, syndication). Free-text description of the windowing plan. | Column windowing_strategy (STRING) in rights.license_agreement',
    CONSTRAINT pk_license_agreement PRIMARY KEY(`license_agreement_id`)
) COMMENT 'Master record for all content licensing, acquisition, and syndication agreements managed in Rightsline. Captures the full contractual relationship between Media Broadcasting and rights grantors or licensees (studios, distributors, music publishers, talent guilds, syndication partners). Stores agreement type (acquisition, co-production, syndication, first-run syndication, off-network syndication, international syndication, music sync, output deal), licensor and licensee identities, effective and expiry dates, territory scope, exclusivity flags, total license fee, payment schedule with milestone detail (advances, minimum guarantees, per-episode fees, annual installments), run count limitations for syndication, governing law jurisdiction, and agreement status (draft, executed, expired, terminated). This is the SSOT for all rights-bearing contracts and the anchor entity for all downstream window, royalty, and clearance records. | Unity Catalog table: media_broadcasting_ecm.rights.license_agreement Aligned with EBU CCDM Tech 3351 (http://www.ebu.ch/metadata/ontologies/ebucore).';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` (
    `grant_id` BIGINT COMMENT 'Unique identifier for the rights grant record. Primary key. | Column grant_id (BIGINT) in rights.grant',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Rights grants in broadcasting are scoped to audience segments — childrens programming rights, adult content grants, and demographic-windowed exclusivity deals all require linking a grant to its targe',
    `license_agreement_id` BIGINT COMMENT 'Reference to the parent license agreement from which this grant is derived. | Column license_agreement_id (BIGINT) in rights.grant',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset (film, series, episode, music track) to which this grant applies. | Column media_asset_id (BIGINT) in mediaasset.grant',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: grant.talent_residuals_applicable (plain attr) signals talent-specific residual obligations on this grant. Direct FK to talent_profile_id supports residual calculation workflows and talent-specific ri',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in rights.grant',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in rights.grant',
    `blackout_applicable` BOOLEAN COMMENT 'Indicates whether geographic or temporal blackout restrictions apply to this grant (e.g., sports blackouts, regional restrictions). | Column blackout_applicable (BOOLEAN) in rights.grant',
    `carriage_fee_applicable` BOOLEAN COMMENT 'Indicates whether a carriage fee (distribution payment) is associated with this grant. | Column carriage_fee_applicable (BOOLEAN) in rights.grant',
    `clearance_status` STRING COMMENT 'Current clearance status of the grant. Indicates whether all rights verification and legal clearances have been completed. | Column clearance_status (STRING) in rights.grant. Valid values are `pending|cleared|blocked|conditional`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in rights.grant',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rights grant record was first created in the system. | Column created_timestamp (TIMESTAMP) in rights.grant',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for financial amounts in this grant (e.g., USD, GBP, EUR). | Column currency_code (STRING) in rights.grant. Valid values are `^[A-Z]{3}$`',
    `drm_required` BOOLEAN COMMENT 'Indicates whether DRM protection is mandated for content distributed under this grant. | Column drm_required (BOOLEAN) in rights.grant',
    `end_date` DATE COMMENT 'The date on which the rights grant expires and exploitation must cease. Nullable for perpetual grants. | Column end_date (DATE) in rights.grant',
    `exclusivity_indicator` BOOLEAN COMMENT 'Indicates whether the grant is exclusive (true) or non-exclusive (false). Exclusive grants prevent other parties from exploiting the same rights in the same territory and window. | Column exclusivity_indicator (BOOLEAN) in rights.grant',
    `grant_number` STRING COMMENT 'Business identifier for the rights grant, typically a human-readable code used in Rightsline and operational workflows. | Column grant_number (STRING) in rights.grant',
    `grant_status` STRING COMMENT 'Current lifecycle status of the rights grant. Reflects whether the grant is currently in force, expired, or otherwise inactive. | Column grant_status (STRING) in rights.grant. Valid values are `active|expired|suspended|terminated|pending`',
    `holdback_applicable` BOOLEAN COMMENT 'Indicates whether a holdback period applies to this grant. Holdbacks restrict exploitation during specific windows to protect other distribution channels. | Column holdback_applicable (BOOLEAN) in rights.grant',
    `holdback_end_date` DATE COMMENT 'The end date of the holdback period, after which exploitation may resume. Nullable if no holdback applies. | Column holdback_end_date (DATE) in rights.grant',
    `holdback_start_date` DATE COMMENT 'The start date of any holdback period during which exploitation is restricted. Nullable if no holdback applies. | Column holdback_start_date (DATE) in rights.grant',
    `language_version` STRING COMMENT 'Language version of the content covered by this grant (e.g., English, Spanish, French). May reference dubbed, subtitled, or original language versions. | Column language_version (STRING) in rights.grant',
    `media_type` STRING COMMENT 'The media format or delivery mechanism covered by this grant (e.g., television, film, digital streaming, audio). | Column media_type (STRING) in rights.grant. Valid values are `television|film|digital|audio|print|mobile`',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment amount for this grant, regardless of actual revenue. Nullable if no MG applies. | Column minimum_guarantee_amount (DECIMAL(15,2)) in rights.grant',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rights grant record was last modified. | Column modified_timestamp (TIMESTAMP) in rights.grant',
    `music_sync_license_required` BOOLEAN COMMENT 'Indicates whether a separate music synchronization license is required for the music tracks embedded in the content. | Column music_sync_license_required (BOOLEAN) in rights.grant',
    `notes` STRING COMMENT 'Free-text notes capturing additional terms, conditions, or operational instructions related to this grant. | Column notes (STRING) in rights.grant',
    `right_type` STRING COMMENT 'Type of distribution or exploitation right granted. Defines the platform or medium for which the content may be used. [ENUM-REF-CANDIDATE: broadcast|svod|avod|tvod|theatrical|home_video|music_sync|podcast|linear|non_linear|vod — 11 candidates stripped; promote to reference product] | Column right_type (STRING) in rights.grant',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Percentage royalty rate applied to revenue generated under this grant. Used for royalty calculations. | Column royalty_rate_percent (DECIMAL(5,2)) in rights.grant',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in rights.grant',
    `start_date` DATE COMMENT 'The date on which the rights grant becomes effective and exploitation may begin. | Column start_date (DATE) in rights.grant',
    `sublicense_permitted` BOOLEAN COMMENT 'Indicates whether the licensee is permitted to sublicense the rights to third parties. | Column sublicense_permitted (BOOLEAN) in rights.grant',
    `talent_residuals_applicable` BOOLEAN COMMENT 'Indicates whether talent residual payments (reuse payments to actors, directors, writers) are triggered by this grant. | Column talent_residuals_applicable (BOOLEAN) in rights.grant',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in rights.grant',
    `window_name` STRING COMMENT 'Named distribution window (e.g., Theatrical, Premium VOD, Pay-TV, Free-TV) that this grant falls within. Used for windowing strategy enforcement. | Column window_name (STRING) in rights.grant',
    CONSTRAINT pk_grant PRIMARY KEY(`grant_id`)
) COMMENT 'Granular rights entitlement record derived from a license agreement. Each row represents a specific bundle of rights granted for a content asset — capturing right type (broadcast, SVOD, AVOD, TVOD, theatrical, home video, music sync, podcast), media type, territory or territory group, language version, exclusivity indicator, holdback applicability, and the grant period (start and end dates). Multiple grants can exist per agreement and per content asset. Feeds the availability engine in scheduling and distribution domains. Powered by Rightsline availabilities module. | Unity Catalog table: media_broadcasting_ecm.rights.grant Aligned with EBU CCDM Tech 3351 (http://www.ebu.ch/metadata/ontologies/ebucore). COPPA child-directed content compliance applicable.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` (
    `holdback_id` BIGINT COMMENT 'Unique identifier for the holdback restriction record. Primary key. | Column holdback_id (BIGINT) in rights.holdback',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Holdbacks can restrict specific episodes from airing on certain platforms (e.g., a streaming holdback on a specific episode due to talent dispute). Episode-level holdback enforcement is required for s',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Holdbacks restrict specific rights grants. Each holdback applies to one rights grant, establishing which exploitation rights are being restricted. This FK enables tracing holdback restrictions back to | Column grant_id (BIGINT) in rights.holdback',
    `license_agreement_id` BIGINT COMMENT 'Reference to the source license agreement that establishes this holdback restriction. | Column license_agreement_id (BIGINT) in rights.holdback',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset subject to this holdback restriction. | Column media_asset_id (BIGINT) in mediaasset.holdback',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Rights teams enforce platform-specific holdbacks during content windowing. holdback.restricted_platform is a denormalized text field; normalizing it to ott_platform_id enables automated holdback enfor',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in rights.holdback',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in rights.holdback',
    `automated_enforcement_flag` BOOLEAN COMMENT 'Indicates whether this holdback restriction is automatically enforced by scheduling and distribution systems or requires manual review. | Column automated_enforcement_flag (BOOLEAN) in rights.holdback',
    `carriage_negotiation_reference` STRING COMMENT 'Reference identifier to the MVPD or vMVPD carriage negotiation that established this holdback restriction. | Column carriage_negotiation_reference (STRING) in rights.holdback',
    `clearance_workflow_status` STRING COMMENT 'Status of the clearance workflow process that validates whether content can be scheduled or distributed despite this holdback restriction. | Column clearance_workflow_status (STRING) in rights.holdback. Valid values are `not_submitted|pending_review|approved|rejected|escalated`',
    `holdback_code` STRING COMMENT 'Business identifier code for the holdback restriction, used for external reference and clearance workflows. | Column holdback_code (STRING) in rights.holdback. Valid values are `^HB-[A-Z0-9]{6,12}$`',
    `conflict_resolution_notes` STRING COMMENT 'Documentation of any conflicts with other rights, windows, or holdbacks and how they were resolved. | Column conflict_resolution_notes (STRING) in rights.holdback',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in rights.holdback',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this holdback restriction record was first created in the system. | Column created_timestamp (TIMESTAMP) in rights.holdback',
    `duration_days` STRING COMMENT 'Total number of days the holdback restriction is in effect, calculated from start to end date. | Column duration_days (INT) in rights.holdback',
    `end_date` DATE COMMENT 'Date when the holdback restriction expires and the content becomes available for exploitation on the previously restricted platform, territory, channel, or format. | Column end_date (DATE) in rights.holdback',
    `enforcement_status` STRING COMMENT 'Current enforcement state of the holdback restriction, indicating whether it is actively blocking content exploitation or has been modified. | Column enforcement_status (STRING) in rights.holdback. Valid values are `active|expired|waived|overridden|pending|suspended`',
    `exclusivity_scope` STRING COMMENT 'Scope of exclusivity granted by this holdback, defining whether the restriction is absolute or allows limited exploitation. | Column exclusivity_scope (STRING) in rights.holdback. Valid values are `full_exclusive|partial_exclusive|non_exclusive`',
    `last_modified_by` STRING COMMENT 'User or system identifier that last modified this holdback restriction record. | Column last_modified_by (STRING) in rights.holdback',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this holdback restriction record was last updated or modified. | Column last_modified_timestamp (TIMESTAMP) in rights.holdback',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether notification of this holdback restriction has been sent to relevant scheduling, distribution, and operations teams. | Column notification_sent_flag (BOOLEAN) in rights.holdback',
    `priority_level` STRING COMMENT 'Business priority assigned to this holdback restriction, indicating its importance in windowing strategy and enforcement. | Column priority_level (STRING) in rights.holdback. Valid values are `critical|high|medium|low`',
    `restricted_format` STRING COMMENT 'Distribution format or delivery method that is restricted during the holdback period, supporting windowing strategies. [ENUM-REF-CANDIDATE: theatrical|linear_tv|svod|avod|tvod|vod|physical_media|syndication|streaming|broadcast — 10 candidates stripped; promote to reference product] | Column restricted_format (STRING) in rights.holdback',
    `restriction_type` STRING COMMENT 'Classification of the holdback restriction type that defines the nature of the exclusivity period. | Column restriction_type (STRING) in rights.holdback. Valid values are `platform_holdback|territory_holdback|channel_holdback|format_holdback|daypart_holdback|exclusive_holdback`',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in rights.holdback',
    `start_date` DATE COMMENT 'Date when the holdback restriction becomes effective and the content is blocked from the specified platform, territory, channel, or format. | Column start_date (DATE) in rights.holdback',
    `triggering_window_type` STRING COMMENT 'Type of content window that triggers or activates this holdback restriction, defining the sequential release strategy. [ENUM-REF-CANDIDATE: theatrical|svod|avod|tvod|linear|syndication|home_video|pay_per_view|free_tv|premium_tv — 10 candidates stripped; promote to reference product] | Column triggering_window_type (STRING) in rights.holdback',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in rights.holdback',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the person or role who authorized the waiver or override of the holdback restriction. | Column waiver_approved_by (STRING) in rights.holdback',
    `waiver_approved_date` DATE COMMENT 'Date when the waiver or override of the holdback restriction was officially approved. | Column waiver_approved_date (DATE) in rights.holdback',
    `waiver_reason` STRING COMMENT 'Business justification or explanation for waiving or overriding the holdback restriction, if applicable. | Column waiver_reason (STRING) in rights.holdback',
    `windowing_strategy_notes` STRING COMMENT 'Additional notes or context explaining how this holdback fits into the overall content windowing and sequential release strategy. | Column windowing_strategy_notes (STRING) in rights.holdback',
    `created_by` STRING COMMENT 'User or system identifier that created this holdback restriction record. | Column created_by (STRING) in rights.holdback',
    CONSTRAINT pk_holdback PRIMARY KEY(`holdback_id`)
) COMMENT 'Records exclusivity holdback restrictions that prevent a content asset from being exploited on a specific platform, territory, or channel during a defined period. Each holdback captures the restriction type (platform holdback, territory holdback, channel holdback, format holdback), the restricted platform or distributor, holdback start and end dates, the triggering window type and source window reference, the source license agreement, and enforcement status (active, expired, waived, overridden). Holdbacks are enforced by the clearance workflow before any scheduling or distribution action is approved. Critical for MVPD carriage negotiations, OTT windowing compliance, and theatrical-to-home-video sequencing. Links to rights_content_window and license_agreement. | Unity Catalog table: media_broadcasting_ecm.rights.holdback Aligned with EBU CCDM Tech 3351 (http://www.ebu.ch/metadata/ontologies/ebucore). Rightsline rights management integration supported.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` (
    `royalty_rule_id` BIGINT COMMENT 'Unique identifier for the royalty calculation rule. Primary key. | Column royalty_rule_id (BIGINT) in rights.royalty_rule',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Royalty rules may apply to specific rights grants. Each rule may apply to one rights grant, defining how royalties are calculated for that grant. This FK enables tracing royalty rules back to the spec | Column grant_id (BIGINT) in rights.royalty_rule',
    `license_agreement_id` BIGINT COMMENT 'Reference to the parent license agreement or rights grant to which this royalty rule applies. Links this rule to the contract context in Rightsline. | Column license_agreement_id (BIGINT) in rights.royalty_rule',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in rights.royalty_rule',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in rights.royalty_rule',
    `approval_status` STRING COMMENT 'Approval status of the royalty rule within the rights management workflow (e.g., pending, approved, rejected). | Column approval_status (STRING) in rights.royalty_rule. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this royalty rule. Nullable if not yet approved. | Column approved_by (STRING) in rights.royalty_rule',
    `approved_date` DATE COMMENT 'Date on which this royalty rule was approved. Nullable if not yet approved. | Column approved_date (DATE) in rights.royalty_rule',
    `audit_rights_flag` BOOLEAN COMMENT 'Indicates whether the rights holder has audit rights to verify royalty calculations under this rule. True if audit rights are granted, False otherwise. | Column audit_rights_flag (BOOLEAN) in rights.royalty_rule',
    `calculation_basis` STRING COMMENT 'The financial or usage metric upon which the royalty calculation is based (e.g., gross revenue, net revenue, subscriber count, stream count, GRP). [ENUM-REF-CANDIDATE: gross_revenue|net_revenue|subscriber_count|stream_count|grp|unit_sales|advertising_revenue — 7 candidates stripped; promote to reference product] | Column calculation_basis (STRING) in rights.royalty_rule',
    `content_type` STRING COMMENT 'The type of content to which this royalty rule applies (e.g., film, series, episode, music, documentary, sports, news, short-form). [ENUM-REF-CANDIDATE: film|series|episode|music|documentary|sports|news|short_form — 8 candidates stripped; promote to reference product] | Column content_type (STRING) in rights.royalty_rule',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in rights.royalty_rule',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this royalty rule record was first created in the system. | Column created_timestamp (TIMESTAMP) in rights.royalty_rule',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary amounts in this royalty rule (e.g., USD, GBP, EUR). | Column currency_code (STRING) in rights.royalty_rule. Valid values are `^[A-Z]{3}$`',
    `deduction_allowed_flag` BOOLEAN COMMENT 'Indicates whether deductions (e.g., distribution costs, marketing expenses) are allowed before calculating the royalty. True if deductions are permitted, False otherwise. | Column deduction_allowed_flag (BOOLEAN) in rights.royalty_rule',
    `deduction_percentage` DECIMAL(18,2) COMMENT 'The percentage of revenue or basis that may be deducted before applying the royalty rate. Nullable if no deduction applies. | Column deduction_percentage (DECIMAL(5,2)) in rights.royalty_rule',
    `effective_end_date` DATE COMMENT 'The date on which this royalty rule ceases to be active. Nullable for open-ended rules. | Column effective_end_date (DATE) in rights.royalty_rule',
    `effective_start_date` DATE COMMENT 'The date from which this royalty rule becomes active and applicable to royalty calculations. | Column effective_start_date (DATE) in rights.royalty_rule',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this royalty rule record was last updated or modified. | Column last_modified_timestamp (TIMESTAMP) in rights.royalty_rule',
    `maximum_cap_amount` DECIMAL(18,2) COMMENT 'The maximum royalty payment cap for this rule. Royalty calculations will not exceed this amount. Nullable if no cap applies. | Column maximum_cap_amount (DECIMAL(18,2)) in rights.royalty_rule',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'The minimum guaranteed royalty payment amount for this rule, regardless of calculated royalty. Nullable if no minimum guarantee applies. | Column minimum_guarantee_amount (DECIMAL(18,2)) in rights.royalty_rule',
    `notes` STRING COMMENT 'Free-text notes or comments about this royalty rule, including special conditions, exceptions, or clarifications. | Column notes (STRING) in rights.royalty_rule',
    `payment_frequency` STRING COMMENT 'The frequency at which royalty payments calculated by this rule are made (e.g., monthly, quarterly, semi-annually, annually, per event, on demand). | Column payment_frequency (STRING) in rights.royalty_rule. Valid values are `monthly|quarterly|semi_annually|annually|per_event|on_demand`',
    `payment_timing` STRING COMMENT 'The timing of royalty payments relative to the calculation period (e.g., advance, arrears, upon delivery, upon release, milestone-based). | Column payment_timing (STRING) in rights.royalty_rule. Valid values are `advance|arrears|upon_delivery|upon_release|milestone_based`',
    `rate_unit` STRING COMMENT 'The unit of measure for the rate value (e.g., percentage, per stream, per subscriber, per unit, per GRP, flat amount). | Column rate_unit (STRING) in rights.royalty_rule. Valid values are `percentage|per_stream|per_subscriber|per_unit|per_grp|flat_amount`',
    `rate_value` DECIMAL(18,2) COMMENT 'The numeric rate or percentage applied in the royalty calculation. For percentage-based royalties, this is the percentage (e.g., 15.5 for 15.5%). For per-unit rates, this is the amount per unit. | Column rate_value (DECIMAL(18,6)) in rights.royalty_rule',
    `recoupment_flag` BOOLEAN COMMENT 'Indicates whether this royalty rule includes recoupment provisions (e.g., advance payments must be recouped before additional royalties are paid). True if recoupment applies, False otherwise. | Column recoupment_flag (BOOLEAN) in rights.royalty_rule',
    `recoupment_threshold` DECIMAL(18,2) COMMENT 'The monetary threshold that must be recouped before additional royalty payments are made. Nullable if no recoupment applies. | Column recoupment_threshold (DECIMAL(18,2)) in rights.royalty_rule',
    `residual_formula` STRING COMMENT 'The formula or calculation logic for residual payments to talent (actors, directors, writers) based on reuse, reruns, or secondary exploitation. Nullable if not applicable. | Column residual_formula (STRING) in rights.royalty_rule',
    `royalty_rule_status` STRING COMMENT 'Current lifecycle status of the royalty rule (e.g., draft, active, suspended, expired, terminated). | Column royalty_rule_status (STRING) in rights.royalty_rule. Valid values are `draft|active|suspended|expired|terminated`',
    `royalty_type` STRING COMMENT 'The type of royalty calculation method applied by this rule. Determines how the royalty amount is computed. | Column royalty_type (STRING) in rights.royalty_rule. Valid values are `flat_fee|revenue_share_percentage|per_stream_rate|per_unit_rate|residual_formula|minimum_guarantee`',
    `rule_code` STRING COMMENT 'Business-assigned unique code or identifier for this royalty rule, used for reference in contracts and reporting. | Column rule_code (STRING) in rights.royalty_rule. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `rule_name` STRING COMMENT 'Human-readable name or title of the royalty rule, describing its purpose or scope (e.g., SVOD Revenue Share - Tier 1, Per-Stream Rate - Music Sync). | Column rule_name (STRING) in rights.royalty_rule',
    `rule_priority` STRING COMMENT 'The priority or precedence of this royalty rule when multiple rules may apply to the same content or transaction. Lower numbers indicate higher priority. | Column rule_priority (INT) in rights.royalty_rule',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in rights.royalty_rule',
    `territory_scope` STRING COMMENT 'Geographic territory or territories to which this royalty rule applies. May be a single country code, region, or comma-separated list of territories. | Column territory_scope (STRING) in rights.royalty_rule',
    `threshold_unit` STRING COMMENT 'The unit of measure for the threshold value (e.g., revenue, subscriber count, stream count, unit count, GRP). | Column threshold_unit (STRING) in rights.royalty_rule. Valid values are `revenue|subscriber_count|stream_count|unit_count|grp`',
    `threshold_value` DECIMAL(18,2) COMMENT 'The threshold value that triggers a rate tier change or special calculation logic (e.g., revenue threshold for tiered royalty rates). | Column threshold_value (DECIMAL(18,2)) in rights.royalty_rule',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in rights.royalty_rule',
    CONSTRAINT pk_royalty_rule PRIMARY KEY(`royalty_rule_id`)
) COMMENT 'Defines the royalty calculation rules and rate structures associated with a license agreement or rights grant. Captures royalty type (flat fee, revenue share percentage, per-stream rate, per-unit rate, residual formula), calculation basis (gross revenue, net revenue, subscriber count, stream count, GRP), applicable platform or exploitation type, rate tiers and thresholds, minimum guarantee amounts, and effective date range. Serves as the configuration engine for the royalty calculation process in Rightsline. Distinct from actual royalty payment transactions. | Unity Catalog table: media_broadcasting_ecm.rights.royalty_rule Aligned with EBU CCDM Tech 3351 (http://www.ebu.ch/metadata/ontologies/ebucore).';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` (
    `royalty_statement_id` BIGINT COMMENT 'Unique identifier for the royalty statement. Primary key. | Column royalty_statement_id (BIGINT) in rights.royalty_statement',
    `holder_id` BIGINT COMMENT 'Identifier of the rights holder (licensor, talent guild, music publisher, or syndication partner) to whom this statement is issued. Links to the party receiving royalty payments. | Column holder_id (BIGINT) in rights.royalty_statement',
    `license_agreement_id` BIGINT COMMENT 'Identifier of the underlying rights agreement or contract that governs the royalty terms for this statement. | Column license_agreement_id (BIGINT) in rights.royalty_statement',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in rights.royalty_statement',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in rights.royalty_statement',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Net adjustment amount applied to this statement for corrections, credits, or debits from prior periods. | Column adjustment_amount (DECIMAL(18,2)) in rights.royalty_statement',
    `advance_recoupment_amount` DECIMAL(18,2) COMMENT 'Amount deducted from gross royalties to recoup advances previously paid to the rights holder under the agreement. | Column advance_recoupment_amount (DECIMAL(18,2)) in rights.royalty_statement',
    `approved_by` STRING COMMENT 'Name or identifier of the person or system that approved this royalty statement for payment. | Column approved_by (STRING) in rights.royalty_statement',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this royalty statement was approved for payment. | Column approved_timestamp (TIMESTAMP) in rights.royalty_statement',
    `content_title_breakdown` STRING COMMENT 'Structured breakdown of royalties by content title or asset. Stored as JSON or delimited string for detailed reporting. | Column content_title_breakdown (STRING) in rights.royalty_statement',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in rights.royalty_statement',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this royalty statement record was first created in the system. | Column created_timestamp (TIMESTAMP) in rights.royalty_statement',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which royalty amounts are denominated. | Column currency_code (STRING) in rights.royalty_statement. Valid values are `^[A-Z]{3}$`',
    `dispute_date` DATE COMMENT 'The date on which the rights holder formally disputed this royalty statement. | Column dispute_date (DATE) in rights.royalty_statement',
    `dispute_reason` STRING COMMENT 'Explanation or reason provided by the rights holder if the statement status is disputed. Captures objections to calculations, missing revenues, or contractual interpretation issues. | Column dispute_reason (STRING) in rights.royalty_statement',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert foreign currency revenues to the statement currency, if applicable. Rate is typically the average rate for the statement period. | Column exchange_rate (DECIMAL(12,6)) in rights.royalty_statement',
    `exploitation_type_breakdown` STRING COMMENT 'Structured breakdown of royalties by exploitation type (theatrical, SVOD, AVOD, TVOD, linear, syndication, home video, etc.). Stored as JSON or delimited string for detailed reporting. | Column exploitation_type_breakdown (STRING) in rights.royalty_statement',
    `gross_royalty_amount` DECIMAL(18,2) COMMENT 'Total royalty amount earned by the rights holder before any deductions, recoupments, or adjustments. | Column gross_royalty_amount (DECIMAL(18,2)) in rights.royalty_statement',
    `minimum_guarantee_shortfall` DECIMAL(18,2) COMMENT 'The difference between the contractual minimum guarantee and actual royalties earned for the period. A positive value indicates the rights holder is entitled to a minimum guarantee payment. | Column minimum_guarantee_shortfall (DECIMAL(18,2)) in rights.royalty_statement',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this royalty statement record was last modified or updated. | Column modified_timestamp (TIMESTAMP) in rights.royalty_statement',
    `net_royalty_amount` DECIMAL(18,2) COMMENT 'Final royalty amount payable to the rights holder after all deductions, recoupments, taxes, and adjustments. This is the amount that will be paid. | Column net_royalty_amount (DECIMAL(18,2)) in rights.royalty_statement',
    `paid_timestamp` TIMESTAMP COMMENT 'Date and time when payment for this royalty statement was successfully processed and remitted to the rights holder. | Column paid_timestamp (TIMESTAMP) in rights.royalty_statement',
    `payment_method` STRING COMMENT 'The payment instrument or method that will be used to remit the net royalty amount to the rights holder. | Column payment_method (STRING) in rights.royalty_statement. Valid values are `wire_transfer|check|ach|paypal|direct_deposit`',
    `payment_reference_number` STRING COMMENT 'Reference number or transaction identifier for the payment associated with this statement, once payment has been processed. | Column payment_reference_number (STRING) in rights.royalty_statement',
    `resolution_date` DATE COMMENT 'The date on which a disputed statement was resolved and moved to approved or paid status. | Column resolution_date (DATE) in rights.royalty_statement',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in rights.royalty_statement',
    `statement_due_date` DATE COMMENT 'The date by which payment of the royalties on this statement is contractually due to the rights holder. | Column statement_due_date (DATE) in rights.royalty_statement',
    `statement_frequency` STRING COMMENT 'The reporting frequency for this royalty statement as defined in the underlying rights agreement. | Column statement_frequency (STRING) in rights.royalty_statement. Valid values are `monthly|quarterly|semi-annual|annual|ad-hoc`',
    `statement_issue_date` DATE COMMENT 'The date on which this royalty statement was officially issued to the rights holder. | Column statement_issue_date (DATE) in rights.royalty_statement',
    `statement_notes` STRING COMMENT 'Free-text notes or comments related to this royalty statement, including explanations of unusual adjustments, special circumstances, or clarifications for the rights holder. | Column statement_notes (STRING) in rights.royalty_statement',
    `statement_number` STRING COMMENT 'Externally-known unique business identifier for this royalty statement, used for reference in correspondence and payment processing. | Column statement_number (STRING) in rights.royalty_statement. Valid values are `^[A-Z0-9]{6,20}$`',
    `statement_period_end_date` DATE COMMENT 'The last date of the reporting period covered by this royalty statement. | Column statement_period_end_date (DATE) in rights.royalty_statement',
    `statement_period_start_date` DATE COMMENT 'The first date of the reporting period covered by this royalty statement. | Column statement_period_start_date (DATE) in rights.royalty_statement',
    `statement_status` STRING COMMENT 'Current lifecycle status of the royalty statement. Draft statements are under review, approved statements are ready for payment, disputed statements have objections from rights holders, paid statements have been settled, and cancelled statements have been voided. | Column statement_status (STRING) in rights.royalty_statement. Valid values are `draft|approved|disputed|paid|cancelled`',
    `territory_breakdown` STRING COMMENT 'Structured breakdown of royalties by geographic territory or market. Stored as JSON or delimited string for detailed reporting. | Column territory_breakdown (STRING) in rights.royalty_statement',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in rights.royalty_statement',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Tax amount withheld from royalty payment as required by applicable tax treaties and regulations. | Column withholding_tax_amount (DECIMAL(18,2)) in rights.royalty_statement',
    CONSTRAINT pk_royalty_statement PRIMARY KEY(`royalty_statement_id`)
) COMMENT 'Periodic royalty statement generated for a rights holder (licensor, talent guild, music publisher, or syndication partner) covering a specific reporting period. Captures statement period (monthly, quarterly, semi-annual), total royalties due, breakdown by exploitation type and territory, advance recoupment amounts, minimum guarantee shortfall, currency, exchange rate applied, and statement status (draft, approved, disputed, paid). The SSOT for royalty obligations owed to external rights holders. Feeds the billing domain for payment processing. | Unity Catalog table: media_broadcasting_ecm.rights.royalty_statement Aligned with EBU CCDM Tech 3351 (http://www.ebu.ch/metadata/ontologies/ebucore). Rightsline rights management integration supported.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` (
    `royalty_statement_line_id` BIGINT COMMENT 'Unique identifier for the royalty statement line item. Primary key for this entity. | Column royalty_statement_line_id (BIGINT) in rights.royalty_statement_line',
    `ad_order_line_id` BIGINT COMMENT 'Foreign key linking to sales.ad_order_line. Business justification: Per-airing royalty reconciliation: royalty statement lines must be reconciled against specific contracted ad order lines to validate units_exploited and gross_revenue_amount for guild reporting and au',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: A royalty statement line represents a single exploitation event tied to a specific rights grant. Adding grant_id to royalty_statement_line normalizes the relationship between the line-item detail and ',
    `holder_id` BIGINT COMMENT 'Reference to the party (talent, studio, licensor) entitled to receive the royalty payment for this line. Links to the rights holder master data. | Column holder_id (BIGINT) in rights.royalty_statement_line',
    `license_agreement_id` BIGINT COMMENT 'Reference to the underlying rights agreement or contract that governs this royalty calculation. Links to the master rights contract data. | Column license_agreement_id (BIGINT) in rights.royalty_statement_line',
    `media_asset_id` BIGINT COMMENT 'Reference to the specific content asset (program, episode, film, music track) that generated this royalty line. Links to the content master data. | Column media_asset_id (BIGINT) in mediaasset.royalty_statement_line',
    `royalty_rule_id` BIGINT COMMENT 'Foreign key linking to rights.royalty_rule. Business justification: Statement lines are calculated using royalty rules. Each line uses one royalty rule that defines the calculation formula. This FK enables tracing royalty calculations back to the authoritative royalty | Column royalty_rule_id (BIGINT) in rights.royalty_statement_line',
    `royalty_statement_id` BIGINT COMMENT 'Reference to the parent royalty statement that contains this line item. Links this line to the header-level statement issued to a rights holder. | Column royalty_statement_id (BIGINT) in rights.royalty_statement_line',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Royalty statement lines break down payments by title — a regulatory and contractual requirement for rights holders. The existing content_title column is a denormalized text field; replacing it with a ',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in rights.royalty_statement_line',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in rights.royalty_statement_line',
    `adjustments_amount` DECIMAL(18,2) COMMENT 'Additional adjustments applied to the royalty calculation, such as corrections from prior periods, contractual bonuses, penalties, or dispute resolutions. Can be positive or negative. | Column adjustments_amount (DECIMAL(18,2)) in rights.royalty_statement_line',
    `advance_recoupment_amount` DECIMAL(18,2) COMMENT 'Portion of the calculated royalty that is applied against outstanding advances previously paid to the rights holder. Reduces the net payable amount. | Column advance_recoupment_amount (DECIMAL(18,2)) in rights.royalty_statement_line',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this royalty line to source exploitation data, usage reports, or billing records. Enables granular audit trail and dispute resolution. | Column audit_trail_reference (STRING) in rights.royalty_statement_line',
    `calculated_royalty_amount` DECIMAL(18,2) COMMENT 'Royalty amount calculated by applying the royalty rate to the net revenue. Represents the gross royalty obligation before advance recoupment or adjustments. | Column calculated_royalty_amount (DECIMAL(18,2)) in rights.royalty_statement_line',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in rights.royalty_statement_line',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this royalty statement line record was first created in the system. Audit field for data lineage and compliance. | Column created_timestamp (TIMESTAMP) in rights.royalty_statement_line',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts on this line. All amounts (gross revenue, deductions, royalties, payable) are denominated in this currency. | Column currency_code (STRING) in rights.royalty_statement_line. Valid values are `^[A-Z]{3}$`',
    `deductions_amount` DECIMAL(18,2) COMMENT 'Total deductions applied to gross revenue before calculating royalty base. May include distribution fees, marketing costs, platform fees, or other contractually allowed deductions. | Column deductions_amount (DECIMAL(18,2)) in rights.royalty_statement_line',
    `dispute_status` STRING COMMENT 'Current status of any dispute or query raised by the rights holder regarding this royalty line. Tracks the resolution workflow for contested royalty calculations. | Column dispute_status (STRING) in rights.royalty_statement_line. Valid values are `none|under_review|disputed|resolved|adjusted`',
    `eidr_identifier` STRING COMMENT 'Globally unique identifier for the content asset following EIDR standard format. Used for cross-industry content identification and rights tracking. | Column eidr_identifier (STRING) in rights.royalty_statement_line. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `exploitation_period_end_date` DATE COMMENT 'End date of the period during which the exploitation activity occurred. Defines the end of the reporting window for this royalty line. | Column exploitation_period_end_date (DATE) in rights.royalty_statement_line',
    `exploitation_period_start_date` DATE COMMENT 'Start date of the period during which the exploitation activity occurred. Defines the beginning of the reporting window for this royalty line. | Column exploitation_period_start_date (DATE) in rights.royalty_statement_line',
    `exploitation_type` STRING COMMENT 'Type of content exploitation that generated this royalty. Indicates the distribution channel or business model under which the content was used. [ENUM-REF-CANDIDATE: linear_broadcast|svod|avod|tvod|theatrical|syndication|home_video|digital_download — 8 candidates stripped; promote to reference product] | Column exploitation_type (STRING) in rights.royalty_statement_line',
    `gross_revenue_amount` DECIMAL(18,2) COMMENT 'Total gross revenue generated from the exploitation activity before any deductions, adjustments, or royalty calculations. Represents the top-line revenue attributable to this content asset. | Column gross_revenue_amount (DECIMAL(18,2)) in rights.royalty_statement_line',
    `holdback_status` STRING COMMENT 'Status of any holdback or exclusivity period applicable to this exploitation. Indicates whether the content was exploited within or outside of contractual holdback restrictions. | Column holdback_status (STRING) in rights.royalty_statement_line. Valid values are `active|expired|waived|not_applicable`',
    `isrc_code` STRING COMMENT 'ISRC code for recording identification',
    `iswc_code` STRING COMMENT 'ISWC code for composition identification',
    `line_number` STRING COMMENT 'Sequential line number within the royalty statement, used for ordering and reference purposes. | Column line_number (INT) in rights.royalty_statement_line',
    `net_payable_amount` DECIMAL(18,2) COMMENT 'Final net amount payable to the rights holder for this line item after all deductions, advance recoupment, and adjustments. This is the amount that will be paid out. | Column net_payable_amount (DECIMAL(18,2)) in rights.royalty_statement_line',
    `net_revenue_amount` DECIMAL(18,2) COMMENT 'Net revenue after deductions, serving as the base for royalty calculation. Calculated as gross_revenue_amount minus deductions_amount. | Column net_revenue_amount (DECIMAL(18,2)) in rights.royalty_statement_line',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this royalty line. May include explanations of adjustments, dispute details, or special calculation circumstances. | Column notes (STRING) in rights.royalty_statement_line',
    `payment_date` DATE COMMENT 'Date on which the royalty payment for this line was or will be disbursed to the rights holder. Null if payment has not yet been scheduled. | Column payment_date (DATE) in rights.royalty_statement_line',
    `payment_status` STRING COMMENT 'Current payment status for this royalty line item. Indicates whether the net payable amount has been processed for payment. | Column payment_status (STRING) in rights.royalty_statement_line. Valid values are `pending|scheduled|paid|withheld|cancelled`',
    `platform_name` STRING COMMENT 'Name of the distribution platform or service where the content was exploited (e.g., Netflix, Hulu, linear network, theatrical chain). | Column platform_name (STRING) in rights.royalty_statement_line',
    `residual_type` STRING COMMENT 'Classification of residual payment type for talent royalties. Indicates the nature of the reuse payment under guild agreements (SAG-AFTRA, WGA, DGA). [ENUM-REF-CANDIDATE: initial_use|rerun|foreign|supplemental|new_media|streaming|not_applicable — 7 candidates stripped; promote to reference product] | Column residual_type (STRING) in rights.royalty_statement_line',
    `rights_holder_name` STRING COMMENT 'Name of the rights holder receiving the royalty. Denormalized for reporting and audit trail purposes. | Column rights_holder_name (STRING) in rights.royalty_statement_line',
    `royalty_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage rate applied to the royalty base to calculate the royalty amount. Derived from the underlying rights agreement and may vary by territory, platform, and exploitation type. | Column royalty_rate_percentage (DECIMAL(5,2)) in rights.royalty_statement_line',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in rights.royalty_statement_line',
    `unit_of_measure` STRING COMMENT 'Unit type for the units_exploited field. Clarifies how exploitation volume is measured for this line. | Column unit_of_measure (STRING) in rights.royalty_statement_line. Valid values are `streams|broadcasts|downloads|tickets|views|impressions`',
    `units_exploited` DECIMAL(18,2) COMMENT 'Quantity of exploitation units for this line item. Interpretation depends on exploitation type: streams for SVOD/AVOD, broadcasts for linear, downloads for TVOD, tickets for theatrical. | Column units_exploited (DECIMAL(18,2)) in rights.royalty_statement_line',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in rights.royalty_statement_line',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this royalty statement line record was last modified. Audit field for tracking changes and dispute resolution history. | Column updated_timestamp (TIMESTAMP) in rights.royalty_statement_line',
    `window_type` STRING COMMENT 'Distribution window classification under which this exploitation occurred. Reflects the sequential release strategy and holdback periods defined in the rights agreement. [ENUM-REF-CANDIDATE: theatrical|home_video|pay_per_view|premium_cable|basic_cable|broadcast|svod|avod|free_streaming — 9 candidates stripped; promote to reference product] | Column window_type (STRING) in rights.royalty_statement_line',
    CONSTRAINT pk_royalty_statement_line PRIMARY KEY(`royalty_statement_line_id`)
) COMMENT 'Line-item detail within a royalty statement, representing a single exploitation event or aggregated exploitation activity for a specific content asset, territory, platform, and period. Captures content asset reference, exploitation type, territory, platform, units exploited (streams, broadcasts, downloads), gross revenue, applicable royalty rate, calculated royalty amount, advance applied, and net payable. Enables granular royalty audit trails and dispute resolution at the asset and territory level. | Unity Catalog table: media_broadcasting_ecm.rights.royalty_statement_line Aligned with EBU CCDM Tech 3351 (http://www.ebu.ch/metadata/ontologies/ebucore). Rightsline rights management integration supported.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` (
    `residual_id` BIGINT COMMENT 'Unique identifier for the residual payment obligation record. Primary key. | Column residual_id (BIGINT) in rights.residual',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Guild residuals are calculated per episode airing (e.g., SAG-AFTRA requires per-episode residual payments for each broadcast). Episode-level residuals tracking is a mandatory guild compliance requirem',
    `contract_id` BIGINT COMMENT 'Reference to the underlying rights contract or license agreement that governs this residual obligation. | Column contract_id (BIGINT) in talent.residual',
    `crew_assignment_id` BIGINT COMMENT 'Foreign key linking to production.crew_assignment. Business justification: Guild residual calculation requires tracing the specific crew engagement that triggered the obligation. SAP residual payment processing and guild reporting (WGA, SAG-AFTRA) depend on knowing which cre',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Residuals arise from specific rights grants. Each residual traces to one rights grant that authorized the exploitation triggering the residual. This FK enables tracing residual obligations back to the | Column grant_id (BIGINT) in rights.residual',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.holder. Business justification: Residual payment obligations are owed to rights holders — specifically guilds, unions, and talent representatives (SAG-AFTRA, WGA, DGA, etc.). The holder table is the master record for all external IP',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Residual obligations arise from license agreements. Each residual payment traces to one license agreement that defines the residual terms. This FK enables tracing residual obligations back to the sour | Column license_agreement_id (BIGINT) in rights.residual',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset (program, episode, film) whose exploitation triggered this residual payment. | Column media_asset_id (BIGINT) in mediaasset.residual',
    `role_id` BIGINT COMMENT 'Foreign key linking to talent.role. Business justification: Guild residual formulas (SAG-AFTRA, WGA) are role-specific — above-the-line vs. below-the-line roles carry different residual rates. Direct FK to role_id enables role-specific residual calculation, a ',
    `royalty_rule_id` BIGINT COMMENT 'Foreign key linking to rights.royalty_rule. Business justification: Residuals are calculated using royalty rules. Each residual uses one royalty rule that defines the calculation formula. This FK enables tracing residual calculations back to the authoritative royalty  | Column royalty_rule_id (BIGINT) in rights.residual',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent (actor, writer, director, crew member) entitled to receive this residual payment. | Column talent_profile_id (BIGINT) in talent.residual',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Guild residuals (SAG-AFTRA, WGA, DGA) are calculated and reported per title. Residual payment records must reference the title for guild reporting submissions and audit. Residual has grant_id and tale',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in rights.residual',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in rights.residual',
    `backend_revenue_source` STRING COMMENT 'Source of backend revenue for participation calculation',
    `calculated_residual_amount` DECIMAL(18,2) COMMENT 'The computed residual payment amount owed to the talent based on the formula type, calculation basis, and applicable rates. | Column calculated_residual_amount (DECIMAL(18,2)) in rights.residual',
    `calculation_basis_amount` DECIMAL(18,2) COMMENT 'The base revenue or gross receipts amount used as the input to the residual formula calculation. | Column calculation_basis_amount (DECIMAL(18,2)) in rights.residual',
    `calculation_basis_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the calculation basis amount (e.g., USD, GBP, CAD). | Column calculation_basis_currency (STRING) in rights.residual. Valid values are `^[A-Z]{3}$`',
    `calculation_date` DATE COMMENT 'The date when the residual amount was calculated by the royalty system. | Column calculation_date (DATE) in rights.residual',
    `contract_cycle` STRING COMMENT 'The collective bargaining agreement cycle or contract period under which this residual is calculated (e.g., 2020-2023, 2023-2026). | Column contract_cycle (STRING) in rights.residual',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in rights.residual',
    `created_by_user` STRING COMMENT 'The user identifier or system account that created this residual payment record. | Column created_by_user (STRING) in rights.residual',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this residual payment record was first created in the system. | Column created_timestamp (TIMESTAMP) in rights.residual',
    `currency` STRING COMMENT 'ISO 4217 three-letter currency code for the calculated residual amount (e.g., USD, GBP, CAD). | Column currency (STRING) in rights.residual. Valid values are `^[A-Z]{3}$`',
    `dispute_date` DATE COMMENT 'The date when the residual payment was flagged as disputed. Nullable if never disputed. | Column dispute_date (DATE) in rights.residual',
    `dispute_reason` STRING COMMENT 'Description of the reason for payment dispute if status is DISPUTED (e.g., calculation error, missing exhibition data, contract interpretation disagreement). | Column dispute_reason (STRING) in rights.residual',
    `exhibition_count` STRING COMMENT 'The number of times the content was exhibited or broadcast during the residual calculation period, used for per-exhibition or tiered formulas. | Column exhibition_count (INT) in rights.residual',
    `exploitation_end_date` DATE COMMENT 'The date when the content exploitation period that triggered this residual ended. Nullable for ongoing exploitation. | Column exploitation_end_date (DATE) in rights.residual',
    `exploitation_start_date` DATE COMMENT 'The date when the content exploitation period that triggered this residual began (e.g., first streaming availability date, first rerun air date). | Column exploitation_start_date (DATE) in rights.residual',
    `exploitation_type` STRING COMMENT 'The type of content reuse or re-exploitation that triggered this residual payment obligation (rerun, streaming, foreign broadcast, home video, SVOD, AVOD, TVOD, syndication, theatrical re-release, clip licensing). [ENUM-REF-CANDIDATE: RERUN|STREAMING|FOREIGN_BROADCAST|HOME_VIDEO|SVOD|AVOD|TVOD|SYNDICATION|THEATRICAL_RERELEASE|CLIP_LICENSING — 10 candidates stripped; promote to reference product] | Column exploitation_type (STRING) in rights.residual',
    `formula_type` STRING COMMENT 'The calculation method used to determine the residual amount (fixed amount, percentage of gross receipts, percentage of distributor gross, tiered scale based on exhibition count, per-exhibition fee, minimum guarantee). | Column formula_type (STRING) in rights.residual. Valid values are `FIXED_AMOUNT|PERCENTAGE_OF_GROSS|PERCENTAGE_OF_DISTRIBUTOR_GROSS|TIERED_SCALE|PER_EXHIBITION|MINIMUM_GUARANTEE`',
    `guild_report_submission_date` DATE COMMENT 'The date when the residual payment was reported to the guild or union. Nullable if not yet reported. | Column guild_report_submission_date (DATE) in rights.residual',
    `guild_report_submitted_flag` BOOLEAN COMMENT 'Indicates whether this residual payment has been included in the mandatory guild reporting submission (True/False). | Column guild_report_submitted_flag (BOOLEAN) in rights.residual',
    `guild_union_code` STRING COMMENT 'The guild or union governing this residual obligation (SAG-AFTRA for actors, WGA for writers, DGA for directors, IATSE for crew, AFM for musicians, ACTRA for Canadian talent). [ENUM-REF-CANDIDATE: SAG-AFTRA|WGA|DGA|IATSE|AFM|ACTRA|OTHER — 7 candidates stripped; promote to reference product] | Column guild_union_code (STRING) in rights.residual',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The net residual payment amount disbursed to the talent after withholding taxes and any other deductions. | Column net_payment_amount (DECIMAL(18,2)) in rights.residual',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this residual payment, including special circumstances, calculation adjustments, or dispute details. | Column notes (STRING) in rights.residual',
    `participation_linked_flag` BOOLEAN COMMENT 'Indicates if residual is linked to a participation deal',
    `payment_date` DATE COMMENT 'The date when the residual payment was actually disbursed to the talent or guild. Nullable if not yet paid. | Column payment_date (DATE) in rights.residual',
    `payment_due_date` DATE COMMENT 'The date by which the residual payment must be made to the talent or guild, per the collective bargaining agreement payment schedule. | Column payment_due_date (DATE) in rights.residual',
    `payment_method` STRING COMMENT 'The method by which the residual payment is disbursed (direct deposit, check, wire transfer, guild trust fund, payroll integration). | Column payment_method (STRING) in rights.residual. Valid values are `DIRECT_DEPOSIT|CHECK|WIRE_TRANSFER|GUILD_TRUST|PAYROLL`',
    `payment_reference_number` STRING COMMENT 'External payment system reference number or transaction identifier for the disbursed residual payment. | Column payment_reference_number (STRING) in rights.residual',
    `payment_status` STRING COMMENT 'Current status of the residual payment obligation (pending calculation approval, approved for payment, paid, disputed by talent or guild, withheld pending resolution, cancelled). | Column payment_status (STRING) in rights.residual. Valid values are `PENDING|APPROVED|PAID|DISPUTED|WITHHELD|CANCELLED`',
    `percentage` DECIMAL(18,2) COMMENT 'The percentage rate applied to the calculation basis when the formula type is percentage-based (e.g., 0.0350 for 3.5%). | Column percentage (DECIMAL(5,4)) in rights.residual',
    `reporting_period` STRING COMMENT 'The financial or royalty reporting period to which this residual obligation belongs (e.g., Q1-2024, 2024-H1), used for guild reporting and financial reconciliation. | Column reporting_period (STRING) in rights.residual',
    `resolution_date` DATE COMMENT 'The date when a disputed residual payment was resolved. Nullable if dispute is unresolved or no dispute occurred. | Column resolution_date (DATE) in rights.residual',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in rights.residual',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in rights.residual',
    `updated_by_user` STRING COMMENT 'The user identifier or system account that last modified this residual payment record. | Column updated_by_user (STRING) in rights.residual',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this residual payment record was last modified in the system. | Column updated_timestamp (TIMESTAMP) in rights.residual',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of tax withheld from the residual payment per applicable tax regulations (federal, state, foreign withholding). | Column withholding_tax_amount (DECIMAL(18,2)) in rights.residual',
    CONSTRAINT pk_residual PRIMARY KEY(`residual_id`)
) COMMENT 'Tracks talent residual payment obligations arising from the reuse or re-exploitation of content under guild agreements (SAG-AFTRA, WGA, DGA, IATSE). Each record captures the guild or union, contract cycle, content asset, exploitation type triggering the residual (rerun, streaming, foreign broadcast, home video), residual formula type, calculated residual amount, payment due date, and payment status. Residuals are distinct from general royalties — they are talent-specific reuse payments governed by collective bargaining agreements. Feeds talent and billing domains. | Unity Catalog table: media_broadcasting_ecm.rights.residual Aligned with EBU CCDM Tech 3351 (http://www.ebu.ch/metadata/ontologies/ebucore). Rightsline rights management integration supported.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` (
    `music_sync_license_id` BIGINT COMMENT 'Unique identifier for the music synchronization license record. Primary key. | Column music_sync_license_id (BIGINT) in rights.music_sync_license',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.contract. Business justification: Music sync licenses involve composers/performers whose talent contracts govern residual obligations and sync fee terms. Direct FK enables lookup of the governing talent contract for sync residual form',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Music sync licenses may derive from broader rights grants. Each sync license may reference one rights grant that authorized the music usage. This FK enables tracing sync licenses back to the authorita | Column grant_id (BIGINT) in rights.music_sync_license',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.holder. Business justification: music_sync_license currently stores rights_holder_name and rights_holder_type as denormalized string fields. The holder table is the master record for all external entities holding IP rights, includin',
    `license_agreement_id` BIGINT COMMENT 'Reference to the master rights contract or agreement under which this music synchronization license is granted. | Column license_agreement_id (BIGINT) in rights.music_sync_license',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset (program, episode, film, promo) in which the licensed music is synchronized and embedded. | Column media_asset_id (BIGINT) in mediaasset.music_sync_license',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Music sync licenses require talent approval when performers have contractual rights over music usage in their performances. Real business process: talent approval workflow for music clearances in cont | Column talent_profile_id (BIGINT) in talent.music_sync_license',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in rights.music_sync_license',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in rights.music_sync_license',
    `clearance_approved_date` DATE COMMENT 'Date when the music synchronization license was officially cleared and approved for use. Nullable if not yet approved. | Column clearance_approved_date (DATE) in rights.music_sync_license',
    `clearance_notes` STRING COMMENT 'Free-text notes documenting clearance workflow details, restrictions, special conditions, or communications with rights holders during the licensing process. | Column clearance_notes (STRING) in rights.music_sync_license',
    `clearance_requested_date` DATE COMMENT 'Date when the music synchronization license clearance was initially requested from the rights holder or clearance team. | Column clearance_requested_date (DATE) in rights.music_sync_license',
    `clearance_status` STRING COMMENT 'Current state of the music synchronization license clearance workflow indicating whether the license has been approved for use in content. | Column clearance_status (STRING) in rights.music_sync_license. Valid values are `pending|cleared|rejected|expired|under_review|conditional`',
    `composer_name` STRING COMMENT 'Name of the composer or songwriter who created the musical composition. | Column composer_name (STRING) in rights.music_sync_license',
    `composition_title` STRING COMMENT 'The title of the musical composition or work being licensed for synchronization use. | Column composition_title (STRING) in rights.music_sync_license',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in rights.music_sync_license',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this music synchronization license record in the rights management system. | Column created_by_user (STRING) in rights.music_sync_license',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this music synchronization license record was first created in the rights management system. | Column created_timestamp (TIMESTAMP) in rights.music_sync_license',
    `cue_sheet_required_flag` BOOLEAN COMMENT 'Indicates whether a cue sheet (detailed music usage report) must be filed with performance rights organizations for this license, typically required for broadcast and public performance. | Column cue_sheet_required_flag (BOOLEAN) in rights.music_sync_license',
    `duration_seconds` STRING COMMENT 'Length of the music excerpt or cue being licensed, measured in seconds. Used for calculating royalties and determining fair use considerations. | Column duration_seconds (INT) in rights.music_sync_license',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this synchronization license grants exclusive rights to use the music in the specified territory and platforms, preventing the rights holder from licensing the same music to competitors during the license period. | Column exclusivity_flag (BOOLEAN) in rights.music_sync_license',
    `isrc_code` STRING COMMENT 'International Standard Recording Code uniquely identifying the sound recording being licensed. Format: 2-letter country code + 3-character registrant code + 2-digit year + 5-digit designation. | Column isrc_code (STRING) in rights.music_sync_license. Valid values are `^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$`',
    `iswc_code` STRING COMMENT 'International Standard Musical Work Code uniquely identifying the musical composition being licensed. Format: T-NNNNNNNNN-C where N is digit and C is check digit. | Column iswc_code (STRING) in rights.music_sync_license. Valid values are `^T-[0-9]{9}-[0-9]$`',
    `license_end_date` DATE COMMENT 'The date when the music synchronization license expires and the right to use the licensed music terminates. Nullable for perpetual licenses. | Column license_end_date (DATE) in rights.music_sync_license',
    `license_fee_amount` DECIMAL(18,2) COMMENT 'One-time or upfront fee paid to the rights holder for the synchronization license. Does not include ongoing royalties. | Column license_fee_amount (DECIMAL(15,2)) in rights.music_sync_license',
    `license_fee_currency` STRING COMMENT 'Three-letter ISO currency code for the license fee amount (e.g., USD, GBP, EUR). | Column license_fee_currency (STRING) in rights.music_sync_license. Valid values are `^[A-Z]{3}$`',
    `license_number` STRING COMMENT 'Externally-known unique identifier or reference number for this music synchronization license, typically assigned by the rights management system or licensing authority. | Column license_number (STRING) in rights.music_sync_license',
    `license_start_date` DATE COMMENT 'The date when the music synchronization license becomes effective and the licensed music may be used in the specified content. | Column license_start_date (DATE) in rights.music_sync_license',
    `license_type` STRING COMMENT 'Classification of the music synchronization license indicating the scope and nature of rights granted (master use for sound recording, synchronization for composition, blanket for multiple works, per-title for single work, mechanical for reproduction, performance for public performance). | Column license_type (STRING) in rights.music_sync_license. Valid values are `master_use|synchronization|blanket|per_title|mechanical|performance`',
    `licensed_platforms` STRING COMMENT 'Comma-separated list of distribution platforms and channels where the licensed music may be used (e.g., linear broadcast, SVOD, AVOD, TVOD, theatrical, home video, social media). | Column licensed_platforms (STRING) in rights.music_sync_license',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment to the rights holder regardless of actual usage or revenue. Nullable if no minimum guarantee applies. | Column minimum_guarantee_amount (DECIMAL(15,2)) in rights.music_sync_license',
    `pro_affiliation` STRING COMMENT 'Name of the Performance Rights Organization (e.g., ASCAP, BMI, SESAC, PRS, SOCAN) with which the composer or publisher is affiliated for performance royalty collection. | Column pro_affiliation (STRING) in rights.music_sync_license',
    `restrictions` STRING COMMENT 'Free-text description of any restrictions, limitations, or special conditions attached to this music synchronization license (e.g., no use in advertising, no use with controversial content, limited to specific episodes). | Column restrictions (STRING) in rights.music_sync_license',
    `royalty_basis` STRING COMMENT 'The metric or revenue base upon which ongoing royalties are calculated (gross revenue, net revenue, per-stream count, per-download, per-unit sold, or flat fee with no ongoing royalties). | Column royalty_basis (STRING) in rights.music_sync_license. Valid values are `gross_revenue|net_revenue|per_stream|per_download|per_unit|flat_fee`',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Percentage rate applied to revenue or usage metrics for calculating ongoing royalty payments to the rights holder. Nullable if license is flat-fee only. | Column royalty_rate_percent (DECIMAL(5,2)) in rights.music_sync_license',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in rights.music_sync_license',
    `sublicense_permitted_flag` BOOLEAN COMMENT 'Indicates whether the licensee is permitted to sublicense the music synchronization rights to third parties (e.g., for syndication or international distribution partners). | Column sublicense_permitted_flag (BOOLEAN) in rights.music_sync_license',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in rights.music_sync_license',
    `updated_by_user` STRING COMMENT 'Username or identifier of the user who last updated this music synchronization license record. | Column updated_by_user (STRING) in rights.music_sync_license',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this music synchronization license record was last modified or updated. | Column updated_timestamp (TIMESTAMP) in rights.music_sync_license',
    `usage_type` STRING COMMENT 'Classification of how the music is used within the content asset (background music, theme song, featured performance, promotional use, trailer, opening/closing credits). | Column usage_type (STRING) in rights.music_sync_license. Valid values are `background|theme|featured|promotional|trailer|credits`',
    CONSTRAINT pk_music_sync_license PRIMARY KEY(`music_sync_license_id`)
) COMMENT 'Master record for music synchronization licenses that authorize the use of a specific musical composition or sound recording within a content asset. Captures the music work (composition title, ISRC, ISWC), rights holder (publisher, label, PRO), sync license type (master use, synchronization, blanket, per-title), licensed territory, licensed platforms, license fee, royalty rate, license period, and clearance status. Music sync licenses are a distinct rights category from content licenses and are required for every piece of music embedded in a broadcast or streaming asset. | Unity Catalog table: media_broadcasting_ecm.rights.music_sync_license Aligned with EBU CCDM Tech 3351 (http://www.ebu.ch/metadata/ontologies/ebucore). Rightsline rights management integration supported.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` (
    `clearance_request_id` BIGINT COMMENT 'Unique identifier for the rights clearance request. Primary key for the clearance request workflow record. | Column clearance_request_id (BIGINT) in rights.clearance_request',
    `advertising_campaign_id` BIGINT COMMENT 'Foreign key linking to advertising.campaign. Business justification: Advertising campaigns booking licensed content trigger clearance requests for talent, music, and holdback compliance. Rights clearance teams need to know which campaign initiated the request to priori',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Clearance analysts evaluate content air requests against specific demographic targets — estimated_grp and estimated_audience_reach on clearance_request are demo-specific calculations. Linking to demog',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Clearance requests validate against specific rights grants to determine if exploitation is permitted. Each clearance request checks one rights grant for authorization. This FK enables validation of ex | Column grant_id (BIGINT) in rights.clearance_request',
    `holdback_id` BIGINT COMMENT 'Foreign key linking to rights.holdback. Business justification: Clearance requests may be blocked by specific holdbacks. Each clearance request may reference one blocking holdback that prevents exploitation. This FK enables tracing clearance denials back to the sp | Column holdback_id (BIGINT) in rights.clearance_request',
    `license_agreement_id` BIGINT COMMENT 'Reference to the primary licensing agreement that governs the requested exploitation. Links to the contract record in Rightsline that defines available windows, territories, and restrictions. | Column license_agreement_id (BIGINT) in rights.clearance_request',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset requiring clearance verification before broadcast, streaming, or distribution. Links to the digital asset managed in Dalet Galaxy MAM. | Column media_asset_id (BIGINT) in mediaasset.clearance_request',
    `music_sync_license_id` BIGINT COMMENT 'Foreign key linking to rights.music_sync_license. Business justification: Clearance requests may require music sync licenses. Each request may reference one music sync license that must be validated. This FK enables tracing clearance requirements back to the specific music  | Column music_sync_license_id (BIGINT) in rights.clearance_request',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Clearance requests are submitted for specific platforms before content can be distributed. clearance_request.platform_channel is a denormalized text field; a FK to ott_platform enables rights analysts',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Pre-production clearance workflow requires filing clearance requests per episode before air. Rights operations teams track episode-level clearance status to gate production milestones (picture lock, d',
    `qc_inspection_id` BIGINT COMMENT 'Foreign key linking to mediaasset.qc_inspection. Business justification: Broadcast clearance workflow requires QC pass before rights clearance is granted. Linking clearance_request to the specific qc_inspection that validated the asset enables clearance analysts to verify ',
    `reach_frequency_report_id` BIGINT COMMENT 'Foreign key linking to audience.reach_frequency_report. Business justification: Clearance analysts validate content placement against audience delivery thresholds before approving air. Linking clearance_request to reach_frequency_report allows the clearance workflow to reference ',
    `script_id` BIGINT COMMENT 'Foreign key linking to production.script. Business justification: Script underlying rights clearance is a named pre-production process — clearance requests are filed per script draft to clear underlying IP before production greenlights. Rights clearance teams track ',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: clearance_request.talent_approval_required (plain attr) signals a named talent approval workflow. Direct FK to talent_profile_id enables tracking which specific talent must approve a clearance — a sta',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in rights.clearance_request',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in rights.clearance_request',
    `analyst_notes` STRING COMMENT 'Free-text notes and observations recorded by the clearance analyst during review. May include references to specific contract clauses, communications with rights holders, or special handling instructions. | Column analyst_notes (STRING) in rights.clearance_request',
    `blocking_category` STRING COMMENT 'Classification of the primary reason for clearance denial. Enables reporting on common rights obstacles and process improvement. [ENUM-REF-CANDIDATE: holdback_period|territory_restriction|window_unavailable|rights_expired|music_sync_missing|talent_approval_required|residuals_unpaid|clearance_incomplete — promote to reference product] | Column blocking_category (STRING) in rights.clearance_request. Valid values are `holdback_period|territory_restriction|window_unavailable|rights_expired|music_sync_missing|talent_approval_required|[ENUM-REF-CANDIDATE: holdback_period|territory_restriction|window_unavailable|rights_expired|music_sync_missing|talent_approval_required|residuals_unpaid|clearance_incomplete — promote to reference product]`',
    `blocking_reason` STRING COMMENT 'Detailed explanation of why a clearance request was blocked or denied. May reference specific contract clauses, holdback periods, territorial restrictions, or missing rights. Null if request is cleared. | Column blocking_reason (STRING) in rights.clearance_request',
    `clearance_decision` STRING COMMENT 'Final determination made by the clearance analyst regarding whether the content may be exploited as requested. Approved with conditions may require specific usage restrictions or additional payments. | Column clearance_decision (STRING) in rights.clearance_request. Valid values are `approved|approved_with_conditions|denied|pending_review`',
    `clearance_status` STRING COMMENT 'Current state of the clearance request workflow. Tracks progression from submission through review to final disposition. Cleared status allows content to proceed to playout; blocked status prevents distribution. [ENUM-REF-CANDIDATE: pending|in_review|cleared|conditionally_cleared|blocked|escalated|expired|cancelled — 8 candidates stripped; promote to reference product] | Column clearance_status (STRING) in rights.clearance_request',
    `conditional_requirements` STRING COMMENT 'Specific conditions or restrictions that must be met for conditional clearance approval. May include required credits, usage limitations, geographic blackouts, or additional royalty payments. | Column conditional_requirements (STRING) in rights.clearance_request',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in rights.clearance_request',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the clearance request record was first created in the database. Part of standard audit trail for data lineage and compliance. | Column created_timestamp (TIMESTAMP) in rights.clearance_request',
    `escalation_reason` STRING COMMENT 'Explanation of why the clearance request required escalation beyond standard analyst review. May reference contract ambiguity, conflicting rights claims, or high-value strategic decisions. | Column escalation_reason (STRING) in rights.clearance_request',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the clearance request was escalated to senior rights management or legal counsel due to complexity, ambiguity, or high business impact. Null if no escalation occurred. | Column escalation_timestamp (TIMESTAMP) in rights.clearance_request',
    `estimated_audience_reach` BIGINT COMMENT 'Projected number of unique viewers or households expected to access the content in the requested exploitation. Used for royalty calculations and rights holder reporting. | Column estimated_audience_reach (BIGINT) in rights.clearance_request',
    `estimated_grp` DECIMAL(18,2) COMMENT 'Projected Gross Rating Point value for the scheduled broadcast or streaming event. GRP represents the sum of ratings achieved by the content and may trigger tiered royalty obligations. | Column estimated_grp (DECIMAL(10,2)) in rights.clearance_request',
    `estimated_residuals_amount` DECIMAL(18,2) COMMENT 'Projected total residual payments owed to talent if the clearance is approved and content is distributed. Used for financial planning and budget approval workflows. | Column estimated_residuals_amount (DECIMAL(15,2)) in rights.clearance_request',
    `exploitation_type` STRING COMMENT 'The intended method of content distribution or monetization requiring clearance. Defines the rights window and licensing requirements that must be verified (e.g., SVOD - Subscription Video On Demand, AVOD - Advertising-Supported Video On Demand, TVOD - Transactional Video On Demand). [ENUM-REF-CANDIDATE: linear_broadcast|svod|avod|tvod|theatrical|syndication|vod|simulcast|fast|digital_download — 10 candidates stripped; promote to reference product] | Column exploitation_type (STRING) in rights.clearance_request',
    `integration_status` STRING COMMENT 'Status of data synchronization between Rightsline clearance system and downstream scheduling and playout systems (Ericsson MediaFirst). Ensures cleared content is automatically released to scheduling workflows. | Column integration_status (STRING) in rights.clearance_request. Valid values are `pending_sync|synced_to_scheduling|synced_to_playout|sync_failed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to any field in the clearance request record. Enables change tracking and audit trail for compliance and operational monitoring. | Column last_modified_timestamp (TIMESTAMP) in rights.clearance_request',
    `music_clearance_required` BOOLEAN COMMENT 'Indicates whether separate music synchronization licenses must be verified before content can be cleared for distribution. True if content contains licensed music requiring additional clearance. | Column music_clearance_required (BOOLEAN) in rights.clearance_request',
    `priority_level` STRING COMMENT 'Business priority assigned to the clearance request based on scheduling urgency, revenue impact, or strategic importance. Urgent requests require expedited review to avoid schedule disruption. | Column priority_level (STRING) in rights.clearance_request. Valid values are `urgent|high|normal|low`',
    `request_number` STRING COMMENT 'Human-readable business identifier for the clearance request, typically formatted as CLR-YYYYMMDD sequence for tracking and reference in scheduling and distribution workflows. | Column request_number (STRING) in rights.clearance_request. Valid values are `^CLR-[0-9]{8}$`',
    `request_submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the clearance request was initially submitted into the workflow system. Marks the start of the clearance review lifecycle and SLA clock. | Column request_submitted_timestamp (TIMESTAMP) in rights.clearance_request',
    `requested_air_date` DATE COMMENT 'The target date when the content is scheduled to be broadcast, streamed, or published. Critical for verifying that rights are available within the requested window and that no holdback periods are violated. | Column requested_air_date (DATE) in rights.clearance_request',
    `requested_air_time` TIMESTAMP COMMENT 'Precise timestamp for the intended broadcast or streaming start time, including time zone. Used for daypart-specific rights verification and scheduling coordination. | Column requested_air_time (TIMESTAMP) in rights.clearance_request',
    `requesting_department` STRING COMMENT 'Business unit or department initiating the clearance request. Identifies which operational area needs rights verification before proceeding with content exploitation. | Column requesting_department (STRING) in rights.clearance_request. Valid values are `scheduling|distribution|production|programming|digital|syndication`',
    `residuals_triggered` BOOLEAN COMMENT 'Indicates whether the requested exploitation will trigger residual payments to talent per guild agreements. True if reuse payments are required for this distribution window. | Column residuals_triggered (BOOLEAN) in rights.clearance_request',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the clearance request was finalized with a cleared, blocked, or conditionally cleared decision. Marks the end of the clearance workflow and enables SLA compliance measurement. | Column resolution_timestamp (TIMESTAMP) in rights.clearance_request',
    `review_started_timestamp` TIMESTAMP COMMENT 'Date and time when a clearance analyst began active review of the request. Used to measure queue time and analyst response performance. | Column review_started_timestamp (TIMESTAMP) in rights.clearance_request',
    `sla_met` BOOLEAN COMMENT 'Indicates whether the clearance request was resolved within the defined SLA target hours. Used for operational performance reporting and process improvement. | Column sla_met (BOOLEAN) in rights.clearance_request',
    `sla_target_hours` STRING COMMENT 'Number of business hours within which the clearance request must be resolved per service level agreement. Varies by priority level (urgent requests have shorter SLA targets). | Column sla_target_hours (INT) in rights.clearance_request',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in rights.clearance_request',
    `talent_approval_required` BOOLEAN COMMENT 'Indicates whether talent (actors, directors, producers) approval or notification is contractually required before the requested exploitation. True if talent has approval rights per guild agreements or individual contracts. | Column talent_approval_required (BOOLEAN) in rights.clearance_request',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in rights.clearance_request',
    CONSTRAINT pk_clearance_request PRIMARY KEY(`clearance_request_id`)
) COMMENT 'Workflow record capturing a rights clearance request initiated before a content asset is scheduled for broadcast, streaming, or distribution. Tracks the requesting department (scheduling, distribution, production), content asset, intended exploitation type and platform, requested air or publish date, territory, clearance status (pending, cleared, conditionally cleared, blocked, escalated), blocking reason if applicable, assigned clearance analyst, and resolution date. Enforces the clearance gate that prevents unlicensed content from reaching playout or distribution systems. Integrates with Ericsson MediaFirst scheduling and Rightsline availabilities. | Unity Catalog table: media_broadcasting_ecm.rights.clearance_request COPPA child-directed content compliance applicable. Aligned with EBU CCDM (Tech 3351) Class Conceptual Data Model semantics.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` (
    `holder_id` BIGINT COMMENT 'Unique identifier for the rights holder entity. Primary key for the rights holder master record. | Column holder_id (BIGINT) in rights.holder',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in rights.holder',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in rights.holder',
    `audit_rights_flag` BOOLEAN COMMENT 'Indicates whether this rights holder has contractual audit rights to review revenue reporting and royalty calculations. True requires enhanced documentation retention. | Column audit_rights_flag (BOOLEAN) in rights.holder',
    `bank_account_name` STRING COMMENT 'Name on the bank account designated for royalty payments. Must match legal entity name for payment processing compliance. | Column bank_account_name (STRING) in rights.holder',
    `bank_account_number` STRING COMMENT 'Bank account number for royalty payment remittance. Encrypted at rest and in transit per PCI DSS requirements. | Column bank_account_number (STRING) in rights.holder',
    `bank_routing_number` STRING COMMENT 'Bank routing number or SWIFT/BIC code for international wire transfers. Used for automated royalty payment processing. | Column bank_routing_number (STRING) in rights.holder',
    `clearance_priority_level` STRING COMMENT 'Priority level assigned to clearance requests for content from this rights holder. VIP and critical levels receive accelerated processing. | Column clearance_priority_level (STRING) in rights.holder. Valid values are `standard|expedited|vip|critical`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in rights.holder',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rights holder record was first created in the system. Used for audit trail and data lineage tracking. | Column created_timestamp (TIMESTAMP) in rights.holder',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit exposure allowed for advance payments or minimum guarantees to this rights holder. Used for financial risk management. | Column credit_limit_amount (DECIMAL(15,2)) in rights.holder',
    `default_royalty_rate` DECIMAL(18,2) COMMENT 'Default royalty rate percentage applied to new agreements with this rights holder. Can be overridden at the contract level. | Column default_royalty_rate (DECIMAL(5,2)) in rights.holder',
    `entity_type` STRING COMMENT 'Classification of the rights holder by organizational type. Determines applicable contract templates, royalty calculation methods, and clearance workflows. [ENUM-REF-CANDIDATE: film_studio|production_company|music_publisher|performing_rights_organization|talent_guild|record_label|news_agency|individual_creator — 8 candidates stripped; promote to reference product] | Column entity_type (STRING) in rights.holder',
    `exclusivity_preference` STRING COMMENT 'Rights holders stated preference for exclusivity terms in licensing agreements. Influences windowing strategy and holdback negotiations. | Column exclusivity_preference (STRING) in rights.holder. Valid values are `exclusive_only|non_exclusive_preferred|flexible|no_preference`',
    `guild_affiliation` STRING COMMENT 'Name of talent guild or performing rights organization (PRO) that this rights holder is affiliated with. Determines residual payment rules and reporting requirements. [ENUM-REF-CANDIDATE: sag_aftra|wga|dga|afm|ascap|bmi|sesac|gema|prs|socan — promote to reference product] | Column guild_affiliation (STRING) in rights.holder',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified this rights holder record. Used for audit trail and change accountability. | Column last_modified_by (STRING) in rights.holder',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rights holder record was last updated. Used for change tracking and data synchronization. | Column last_modified_timestamp (TIMESTAMP) in rights.holder',
    `minimum_guarantee_threshold` DECIMAL(18,2) COMMENT 'Minimum guarantee amount threshold below which this rights holder will not enter licensing agreements. Used for deal structuring and negotiation. | Column minimum_guarantee_threshold (DECIMAL(15,2)) in rights.holder',
    `most_favored_nations_flag` BOOLEAN COMMENT 'Indicates whether this rights holder has most favored nations clause requiring rate parity with other similar rights holders. True triggers rate comparison workflows. | Column most_favored_nations_flag (BOOLEAN) in rights.holder',
    `notes` STRING COMMENT 'Free-text notes capturing special handling instructions, negotiation history, relationship nuances, or other contextual information for this rights holder. | Column notes (STRING) in rights.holder',
    `payment_method` STRING COMMENT 'Preferred payment method for royalty disbursements. Determines processing fees and settlement timelines. | Column payment_method (STRING) in rights.holder. Valid values are `wire_transfer|ach|check|paypal|international_wire`',
    `payment_terms_days` STRING COMMENT 'Standard payment terms in days from invoice date for royalty payments to this rights holder. Typical values include 30, 60, or 90 days net. | Column payment_terms_days (INT) in rights.holder',
    `preferred_currency` STRING COMMENT 'Three-letter ISO currency code representing the rights holders preferred currency for royalty payments and contract valuations. | Column preferred_currency (STRING) in rights.holder. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'Primary email address for the rights holder contact. Used for contract notifications, clearance communications, and royalty statements. | Column primary_contact_email (STRING) in rights.holder. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the rights holder organization for licensing negotiations, clearance requests, and royalty inquiries. | Column primary_contact_name (STRING) in rights.holder',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the rights holder contact. Used for urgent clearance issues and contract negotiations. | Column primary_contact_phone (STRING) in rights.holder',
    `registrant_identifier` STRING COMMENT 'The ISAN or ISRC registrant identifier assigned to the rights holder by the respective international registration authority. Used for global rights tracking and content identification. | Column registrant_identifier (STRING) in rights.holder',
    `relationship_end_date` DATE COMMENT 'Date when the business relationship with this rights holder was terminated or suspended. Null for active relationships. | Column relationship_end_date (DATE) in rights.holder',
    `relationship_start_date` DATE COMMENT 'Date when the business relationship with this rights holder was established. Used for historical reporting and relationship tenure analysis. | Column relationship_start_date (DATE) in rights.holder',
    `rights_holder_code` STRING COMMENT 'Internal business identifier code assigned to the rights holder for operational reference and system integration across Rightsline and billing systems. | Column rights_holder_code (STRING) in rights.holder',
    `rights_holder_name` STRING COMMENT 'The full legal name of the rights holder entity as registered in their territory of incorporation. Used for contract execution and royalty payment identification. | Column rights_holder_name (STRING) in rights.holder',
    `rights_holder_status` STRING COMMENT 'Current lifecycle status of the rights holder relationship. Active status is required for new license agreements and royalty payments. | Column rights_holder_status (STRING) in rights.holder. Valid values are `active|inactive|suspended|pending_approval|terminated`',
    `royalty_calculation_method` STRING COMMENT 'Standard royalty calculation methodology applied to this rights holders agreements. Determines how residuals and royalties are computed. | Column royalty_calculation_method (STRING) in rights.holder. Valid values are `percentage_of_revenue|flat_fee|tiered_percentage|per_unit|hybrid`',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in rights.holder',
    `tax_identification_number` STRING COMMENT 'Tax identification number for the rights holder in their jurisdiction of incorporation. Required for tax reporting and withholding compliance. | Column tax_identification_number (STRING) in rights.holder',
    `tax_withholding_classification` STRING COMMENT 'Tax withholding classification for royalty payments. Determines applicable withholding rates based on tax treaties and domestic regulations. | Column tax_withholding_classification (STRING) in rights.holder. Valid values are `domestic|treaty_exempt|treaty_reduced_rate|non_treaty_foreign|exempt_organization`',
    `tax_withholding_rate` DECIMAL(18,2) COMMENT 'Applicable tax withholding rate percentage for royalty payments to this rights holder. Derived from tax treaties and domestic law based on withholding classification. | Column tax_withholding_rate (DECIMAL(5,2)) in rights.holder',
    `territory_of_incorporation` STRING COMMENT 'Three-letter ISO country code representing the legal jurisdiction where the rights holder entity is incorporated or registered. Determines applicable tax treaties and withholding requirements. | Column territory_of_incorporation (STRING) in rights.holder',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in rights.holder',
    `use_case_fitness_gaps` STRING COMMENT 'Documents analytics use-case fitness gaps requiring A1 (news), A2 (sports), A3 (music) entity additions: Sports right-holder analytics (2-star): A2 sports entities (sports_league, sports_event, sports_team, athlete, event_blackout_rule); Newsroom analytics (2-star): A1 news entities (news_story, wire_ingest, byline_credit, breaking_news_event, editorial_workflow_state); Music label catalog & royalties (2-star): A3 composition/master split (composition, master_recording, release, publisher, pro_affiliation)',
    `created_by` STRING COMMENT 'User identifier of the person who created this rights holder record. Used for audit trail and accountability. | Column created_by (STRING) in rights.holder',
    CONSTRAINT pk_holder PRIMARY KEY(`holder_id`)
) COMMENT 'Master record for all external entities that hold intellectual property rights licensed to or from Media Broadcasting — including film studios, independent production companies, music publishers, performing rights organizations (PROs), talent guilds, record labels, news agencies, and individual creators. Captures rights holder name, entity type, ISAN or ISRC registrant identifier, primary contact, territory of incorporation, preferred currency, payment terms, and tax withholding classification. This is the SSOT for rights grantor and grantee identity within the rights domain, distinct from the partner domain which manages broader commercial relationships. | Unity Catalog table: media_broadcasting_ecm.rights.holder Aligned with EBU CCDM (Tech 3351) Class Conceptual Data Model semantics. Integrates with Rightsline (rights management).';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ADD CONSTRAINT `fk_rights_royalty_rule_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ADD CONSTRAINT `fk_rights_royalty_rule_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_royalty_rule_id` FOREIGN KEY (`royalty_rule_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`royalty_rule`(`royalty_rule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_royalty_statement_id` FOREIGN KEY (`royalty_statement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`royalty_statement`(`royalty_statement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_royalty_rule_id` FOREIGN KEY (`royalty_rule_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`royalty_rule`(`royalty_rule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_holdback_id` FOREIGN KEY (`holdback_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holdback`(`holdback_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_music_sync_license_id` FOREIGN KEY (`music_sync_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`music_sync_license`(`music_sync_license_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`rights` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`rights` SET TAGS ('dbx_domain' = 'rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` SET TAGS ('dbx_subdomain' = 'license_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Sales Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.licensee_sales_account_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.licensee_sales_account_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Licensor Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `holder_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `holder_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.primary_license_holder_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `holder_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.primary_license_holder_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `advance_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `advance_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `advance_payment_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `advance_payment_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.advance_payment_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `advance_payment_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.advance_payment_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.agreement_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.agreement_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|executed|active|expired|terminated|suspended');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.agreement_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.agreement_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.agreement_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.agreement_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.auto_renewal_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.auto_renewal_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Blackout Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.blackout_restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.blackout_restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Clearance Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `clearance_required_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `clearance_required_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.clearance_required_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `clearance_required_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.clearance_required_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `content_rating_restriction` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `content_rating_restriction` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `content_rating_restriction` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.content_rating_restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `content_rating_restriction` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.content_rating_restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.effective_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.effective_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#TemporalCoverage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.exclusivity_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.exclusivity_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#TemporalCoverage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.governing_law_jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.governing_law_jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period (Days)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.holdback_period_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.holdback_period_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `media_rights_granted` SET TAGS ('dbx_business_glossary_term' = 'Media Rights Granted');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `media_rights_granted` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `media_rights_granted` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.media_rights_granted');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `media_rights_granted` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.media_rights_granted');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.minimum_guarantee_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.minimum_guarantee_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `music_sync_license_flag` SET TAGS ('dbx_business_glossary_term' = 'Music Synchronization (Sync) License Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `music_sync_license_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `music_sync_license_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.music_sync_license_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `music_sync_license_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.music_sync_license_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `payment_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `payment_schedule_type` SET TAGS ('dbx_value_regex' = 'lump sum|installments|per-episode|annual|milestone-based|revenue share');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `payment_schedule_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `payment_schedule_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.payment_schedule_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `payment_schedule_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.payment_schedule_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `payment_schedule_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `per_episode_fee` SET TAGS ('dbx_business_glossary_term' = 'Per-Episode Fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `per_episode_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `per_episode_fee` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `per_episode_fee` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.per_episode_fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `per_episode_fee` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.per_episode_fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term (Months)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.renewal_term_months');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.renewal_term_months');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `residuals_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Residuals Obligation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `residuals_obligation_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `residuals_obligation_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.residuals_obligation_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `residuals_obligation_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.residuals_obligation_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Royalty Calculation Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_value_regex' = 'flat fee|percentage of revenue|tiered percentage|per-unit|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.royalty_calculation_method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.royalty_calculation_method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_percentage` SET TAGS ('dbx_business_glossary_term' = 'Royalty Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_percentage` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_percentage` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.royalty_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_percentage` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.royalty_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `run_count_limit` SET TAGS ('dbx_business_glossary_term' = 'Run Count Limit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `run_count_limit` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `run_count_limit` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.run_count_limit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `run_count_limit` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.run_count_limit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.signed_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.signed_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Allowed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.sublicensing_allowed_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.sublicensing_allowed_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.termination_notice_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.termination_notice_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.territory_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.territory_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `total_license_fee` SET TAGS ('dbx_business_glossary_term' = 'Total License Fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `total_license_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `total_license_fee` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `total_license_fee` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.total_license_fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `total_license_fee` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.total_license_fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Windowing Strategy');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.license_agreement.windowing_strategy');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.license_agreement.windowing_strategy');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` SET TAGS ('dbx_subdomain' = 'license_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.grant_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.grant_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `blackout_applicable` SET TAGS ('dbx_business_glossary_term' = 'Blackout Applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `blackout_applicable` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `blackout_applicable` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.blackout_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `blackout_applicable` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.blackout_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `carriage_fee_applicable` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `carriage_fee_applicable` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `carriage_fee_applicable` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.carriage_fee_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `carriage_fee_applicable` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.carriage_fee_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|blocked|conditional');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `clearance_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `clearance_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `clearance_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `clearance_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `clearance_status` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `clearance_status` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `drm_required` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `drm_required` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `drm_required` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.drm_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `drm_required` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.drm_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Grant End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `end_date` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#TemporalCoverage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `end_date` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `exclusivity_indicator` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `exclusivity_indicator` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `exclusivity_indicator` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.exclusivity_indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `exclusivity_indicator` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.exclusivity_indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_number` SET TAGS ('dbx_business_glossary_term' = 'Grant Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.grant_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.grant_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_business_glossary_term' = 'Grant Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|terminated|pending');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.grant_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.grant_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_applicable` SET TAGS ('dbx_business_glossary_term' = 'Holdback Applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_applicable` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_applicable` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.holdback_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_applicable` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.holdback_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_end_date` SET TAGS ('dbx_business_glossary_term' = 'Holdback End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.holdback_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.holdback_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_end_date` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#TemporalCoverage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_end_date` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_start_date` SET TAGS ('dbx_business_glossary_term' = 'Holdback Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.holdback_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.holdback_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_start_date` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#TemporalCoverage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_start_date` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `language_version` SET TAGS ('dbx_business_glossary_term' = 'Language Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `language_version` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `language_version` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.language_version');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `language_version` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.language_version');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `media_type` SET TAGS ('dbx_business_glossary_term' = 'Media Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `media_type` SET TAGS ('dbx_value_regex' = 'television|film|digital|audio|print|mobile');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `media_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `media_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.media_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `media_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.media_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `media_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `media_type` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `media_type` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.minimum_guarantee_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.minimum_guarantee_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `music_sync_license_required` SET TAGS ('dbx_business_glossary_term' = 'Music Synchronization (Sync) License Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `music_sync_license_required` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `music_sync_license_required` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.music_sync_license_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `music_sync_license_required` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.music_sync_license_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Grant Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `right_type` SET TAGS ('dbx_business_glossary_term' = 'Right Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `right_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `right_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.right_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `right_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.right_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `right_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `right_type` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `right_type` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.royalty_rate_percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.royalty_rate_percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Grant Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `start_date` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#TemporalCoverage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `start_date` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `sublicense_permitted` SET TAGS ('dbx_business_glossary_term' = 'Sublicense Permitted');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `sublicense_permitted` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `sublicense_permitted` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.sublicense_permitted');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `sublicense_permitted` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.sublicense_permitted');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `talent_residuals_applicable` SET TAGS ('dbx_business_glossary_term' = 'Talent Residuals Applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `talent_residuals_applicable` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `talent_residuals_applicable` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.talent_residuals_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `talent_residuals_applicable` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.talent_residuals_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `window_name` SET TAGS ('dbx_business_glossary_term' = 'Window Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `window_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `window_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `window_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.grant.window_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `window_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.grant.window_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` SET TAGS ('dbx_subdomain' = 'license_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `holdback_id` SET TAGS ('dbx_business_glossary_term' = 'Holdback Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `holdback_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `holdback_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.holdback_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `holdback_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.holdback_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `grant_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `grant_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.grant_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `grant_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.grant_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Restricted Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `automated_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Enforcement Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `automated_enforcement_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `automated_enforcement_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.automated_enforcement_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `automated_enforcement_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.automated_enforcement_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `carriage_negotiation_reference` SET TAGS ('dbx_business_glossary_term' = 'Carriage Negotiation Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `carriage_negotiation_reference` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `carriage_negotiation_reference` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.carriage_negotiation_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `carriage_negotiation_reference` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.carriage_negotiation_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `clearance_workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Workflow Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `clearance_workflow_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_review|approved|rejected|escalated');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `clearance_workflow_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `clearance_workflow_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.clearance_workflow_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `clearance_workflow_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.clearance_workflow_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `clearance_workflow_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `holdback_code` SET TAGS ('dbx_business_glossary_term' = 'Holdback Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `holdback_code` SET TAGS ('dbx_value_regex' = '^HB-[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `holdback_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `holdback_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.holdback_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `holdback_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.holdback_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `holdback_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `holdback_code` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `holdback_code` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `conflict_resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Conflict Resolution Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `conflict_resolution_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `conflict_resolution_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.conflict_resolution_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `conflict_resolution_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.conflict_resolution_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Duration in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `duration_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `duration_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.duration_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `duration_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.duration_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Holdback End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `end_date` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#TemporalCoverage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `end_date` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_value_regex' = 'active|expired|waived|overridden|pending|suspended');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.enforcement_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.enforcement_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_value_regex' = 'full_exclusive|partial_exclusive|non_exclusive');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.exclusivity_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.exclusivity_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.last_modified_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.last_modified_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.notification_sent_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.notification_sent_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `priority_level` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `priority_level` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.priority_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `priority_level` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.priority_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `priority_level` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restricted_format` SET TAGS ('dbx_business_glossary_term' = 'Restricted Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restricted_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restricted_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.restricted_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restricted_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.restricted_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restricted_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'platform_holdback|territory_holdback|channel_holdback|format_holdback|daypart_holdback|exclusive_holdback');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restriction_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restriction_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.restriction_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restriction_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.restriction_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restriction_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restriction_type` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restriction_type` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Holdback Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `start_date` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#TemporalCoverage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `start_date` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `triggering_window_type` SET TAGS ('dbx_business_glossary_term' = 'Triggering Window Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `triggering_window_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `triggering_window_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.triggering_window_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `triggering_window_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.triggering_window_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `triggering_window_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.waiver_approved_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.waiver_approved_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_approved_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_approved_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.waiver_approved_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_approved_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.waiver_approved_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.waiver_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.waiver_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `windowing_strategy_notes` SET TAGS ('dbx_business_glossary_term' = 'Windowing Strategy Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `windowing_strategy_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `windowing_strategy_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.windowing_strategy_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `windowing_strategy_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.windowing_strategy_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `created_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `created_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holdback.created_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `created_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holdback.created_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` SET TAGS ('dbx_subdomain' = 'royalty_obligations');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.royalty_rule_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.royalty_rule_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `grant_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `grant_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.grant_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `grant_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.grant_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.approval_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.approval_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approved_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approved_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.approved_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approved_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.approved_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approved_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approved_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.approved_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approved_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.approved_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.audit_rights_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.audit_rights_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.calculation_basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.calculation_basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `content_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `content_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.content_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `content_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.content_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `content_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `deduction_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Deduction Allowed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `deduction_allowed_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `deduction_allowed_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.deduction_allowed_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `deduction_allowed_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.deduction_allowed_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `deduction_percentage` SET TAGS ('dbx_business_glossary_term' = 'Deduction Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `deduction_percentage` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `deduction_percentage` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.deduction_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `deduction_percentage` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.deduction_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.effective_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.effective_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.effective_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.effective_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `maximum_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Cap Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `maximum_cap_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `maximum_cap_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.maximum_cap_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `maximum_cap_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.maximum_cap_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.minimum_guarantee_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.minimum_guarantee_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|per_event|on_demand');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.payment_frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.payment_frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_timing` SET TAGS ('dbx_business_glossary_term' = 'Payment Timing');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_timing` SET TAGS ('dbx_value_regex' = 'advance|arrears|upon_delivery|upon_release|milestone_based');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_timing` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_timing` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.payment_timing');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_timing` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.payment_timing');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_unit` SET TAGS ('dbx_value_regex' = 'percentage|per_stream|per_subscriber|per_unit|per_grp|flat_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_unit` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_unit` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.rate_unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_unit` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.rate_unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_value` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_value` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_value` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.rate_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_value` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.rate_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `recoupment_flag` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `recoupment_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `recoupment_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.recoupment_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `recoupment_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.recoupment_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `recoupment_threshold` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Threshold');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `recoupment_threshold` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `recoupment_threshold` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.recoupment_threshold');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `recoupment_threshold` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.recoupment_threshold');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `residual_formula` SET TAGS ('dbx_business_glossary_term' = 'Residual Formula');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `residual_formula` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `residual_formula` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.residual_formula');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `residual_formula` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.residual_formula');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.royalty_rule_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.royalty_rule_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_type` SET TAGS ('dbx_business_glossary_term' = 'Royalty Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_type` SET TAGS ('dbx_value_regex' = 'flat_fee|revenue_share_percentage|per_stream_rate|per_unit_rate|residual_formula|minimum_guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.royalty_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.royalty_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_type` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_type` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.rule_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.rule_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.rule_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.rule_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_priority` SET TAGS ('dbx_business_glossary_term' = 'Rule Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_priority` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_priority` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.rule_priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_priority` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.rule_priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `territory_scope` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `territory_scope` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.territory_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `territory_scope` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.territory_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'revenue|subscriber_count|stream_count|unit_count|grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.threshold_unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.threshold_unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_value` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_value` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.threshold_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_value` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.threshold_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_rule.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_rule.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` SET TAGS ('dbx_subdomain' = 'royalty_obligations');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `royalty_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Statement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `royalty_statement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `royalty_statement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.royalty_statement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `royalty_statement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.royalty_statement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `holder_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `holder_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.holder_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `holder_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.holder_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.adjustment_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.adjustment_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `advance_recoupment_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Recoupment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `advance_recoupment_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `advance_recoupment_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.advance_recoupment_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `advance_recoupment_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.advance_recoupment_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `approved_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `approved_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.approved_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `approved_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.approved_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.approved_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.approved_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `content_title_breakdown` SET TAGS ('dbx_business_glossary_term' = 'Content Title Breakdown');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `content_title_breakdown` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `content_title_breakdown` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.content_title_breakdown');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `content_title_breakdown` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.content_title_breakdown');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `dispute_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `dispute_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.dispute_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `dispute_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.dispute_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.dispute_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.dispute_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.exchange_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.exchange_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exploitation_type_breakdown` SET TAGS ('dbx_business_glossary_term' = 'Exploitation Type Breakdown');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exploitation_type_breakdown` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exploitation_type_breakdown` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.exploitation_type_breakdown');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exploitation_type_breakdown` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.exploitation_type_breakdown');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `gross_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Royalty Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `gross_royalty_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `gross_royalty_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.gross_royalty_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `gross_royalty_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.gross_royalty_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `minimum_guarantee_shortfall` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Shortfall');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `minimum_guarantee_shortfall` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `minimum_guarantee_shortfall` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.minimum_guarantee_shortfall');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `minimum_guarantee_shortfall` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.minimum_guarantee_shortfall');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `net_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Royalty Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `net_royalty_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `net_royalty_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.net_royalty_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `net_royalty_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.net_royalty_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `paid_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Paid Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `paid_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `paid_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.paid_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `paid_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.paid_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|check|ach|paypal|direct_deposit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `payment_method` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `payment_method` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.payment_method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `payment_method` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.payment_method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `payment_method` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.payment_reference_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.payment_reference_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `resolution_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `resolution_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.resolution_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `resolution_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.resolution_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_due_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Payment Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_due_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_due_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.statement_due_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_due_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.statement_due_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Statement Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annual|annual|ad-hoc');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.statement_frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.statement_frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Issue Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_issue_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_issue_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.statement_issue_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_issue_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.statement_issue_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_notes` SET TAGS ('dbx_business_glossary_term' = 'Statement Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.statement_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.statement_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Royalty Statement Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.statement_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.statement_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_period_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_period_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.statement_period_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_period_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.statement_period_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_period_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_period_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.statement_period_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_period_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.statement_period_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_business_glossary_term' = 'Statement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_value_regex' = 'draft|approved|disputed|paid|cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.statement_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.statement_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `territory_breakdown` SET TAGS ('dbx_business_glossary_term' = 'Territory Breakdown');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `territory_breakdown` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `territory_breakdown` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.territory_breakdown');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `territory_breakdown` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.territory_breakdown');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement.withholding_tax_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement.withholding_tax_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` SET TAGS ('dbx_subdomain' = 'royalty_obligations');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_statement_line_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Statement Line ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_statement_line_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_statement_line_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.royalty_statement_line_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_statement_line_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.royalty_statement_line_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `ad_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Line Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `holder_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `holder_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.holder_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `holder_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.holder_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.royalty_rule_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.royalty_rule_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Statement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_statement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_statement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.royalty_statement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_statement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.royalty_statement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `adjustments_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustments Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `adjustments_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `adjustments_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.adjustments_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `adjustments_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.adjustments_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `advance_recoupment_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Recoupment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `advance_recoupment_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `advance_recoupment_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.advance_recoupment_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `advance_recoupment_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.advance_recoupment_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.audit_trail_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.audit_trail_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `calculated_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Calculated Royalty Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `calculated_royalty_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `calculated_royalty_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.calculated_royalty_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `calculated_royalty_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.calculated_royalty_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductions Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `deductions_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `deductions_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.deductions_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `deductions_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.deductions_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'none|under_review|disputed|resolved|adjusted');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `dispute_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `dispute_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.dispute_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `dispute_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.dispute_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `dispute_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_validation_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.eidr_identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.eidr_identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `exploitation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Exploitation Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `exploitation_period_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `exploitation_period_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.exploitation_period_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `exploitation_period_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.exploitation_period_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `exploitation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Exploitation Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `exploitation_period_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `exploitation_period_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.exploitation_period_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `exploitation_period_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.exploitation_period_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_business_glossary_term' = 'Exploitation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.exploitation_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.exploitation_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `gross_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Revenue Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `gross_revenue_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `gross_revenue_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.gross_revenue_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `gross_revenue_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.gross_revenue_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `holdback_status` SET TAGS ('dbx_business_glossary_term' = 'Holdback Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `holdback_status` SET TAGS ('dbx_value_regex' = 'active|expired|waived|not_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `holdback_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `holdback_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.holdback_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `holdback_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.holdback_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `holdback_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `isrc_code` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `isrc_code` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `iswc_code` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `iswc_code` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `line_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `line_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.line_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `line_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.line_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `net_payable_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payable Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `net_payable_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `net_payable_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.net_payable_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `net_payable_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.net_payable_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.net_revenue_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.net_revenue_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `payment_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `payment_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.payment_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `payment_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.payment_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|scheduled|paid|withheld|cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `payment_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `payment_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.payment_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `payment_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.payment_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `payment_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `platform_name` SET TAGS ('dbx_business_glossary_term' = 'Platform Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `platform_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `platform_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `platform_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.platform_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `platform_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.platform_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `residual_type` SET TAGS ('dbx_business_glossary_term' = 'Residual Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `residual_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `residual_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.residual_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `residual_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.residual_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `residual_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.rights_holder_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.rights_holder_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_rate_percentage` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_rate_percentage` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.royalty_rate_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `royalty_rate_percentage` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.royalty_rate_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'streams|broadcasts|downloads|tickets|views|impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.unit_of_measure');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.unit_of_measure');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `units_exploited` SET TAGS ('dbx_business_glossary_term' = 'Units Exploited');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `units_exploited` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `units_exploited` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.units_exploited');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `units_exploited` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.units_exploited');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `window_type` SET TAGS ('dbx_business_glossary_term' = 'Window Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `window_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `window_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.royalty_statement_line.window_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `window_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.royalty_statement_line.window_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ALTER COLUMN `window_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` SET TAGS ('dbx_subdomain' = 'royalty_obligations');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `residual_id` SET TAGS ('dbx_business_glossary_term' = 'Residual Payment Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `residual_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `residual_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.residual_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `residual_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.residual_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `contract_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `contract_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.contract_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `contract_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.contract_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `crew_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `grant_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `grant_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.grant_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `grant_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.grant_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Holder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Role Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.royalty_rule_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.royalty_rule_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `backend_revenue_source` SET TAGS ('dbx_business_glossary_term' = 'Backend Revenue Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `calculated_residual_amount` SET TAGS ('dbx_business_glossary_term' = 'Calculated Residual Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `calculated_residual_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `calculated_residual_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.calculated_residual_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `calculated_residual_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.calculated_residual_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `calculation_basis_amount` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `calculation_basis_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `calculation_basis_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.calculation_basis_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `calculation_basis_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.calculation_basis_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `calculation_basis_currency` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `calculation_basis_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `calculation_basis_currency` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `calculation_basis_currency` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.calculation_basis_currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `calculation_basis_currency` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.calculation_basis_currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Residual Calculation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `calculation_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `calculation_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.calculation_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `calculation_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.calculation_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `contract_cycle` SET TAGS ('dbx_business_glossary_term' = 'Contract Cycle Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `contract_cycle` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `contract_cycle` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.contract_cycle');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `contract_cycle` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.contract_cycle');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `created_by_user` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `created_by_user` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.created_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `created_by_user` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.created_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Residual Payment Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `currency` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `currency` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `currency` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `dispute_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `dispute_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.dispute_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `dispute_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.dispute_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.dispute_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.dispute_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exhibition_count` SET TAGS ('dbx_business_glossary_term' = 'Exhibition Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exhibition_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exhibition_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.exhibition_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exhibition_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.exhibition_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exploitation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Exploitation End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exploitation_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exploitation_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.exploitation_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exploitation_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.exploitation_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exploitation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Exploitation Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exploitation_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exploitation_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.exploitation_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exploitation_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.exploitation_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_business_glossary_term' = 'Exploitation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.exploitation_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.exploitation_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `formula_type` SET TAGS ('dbx_business_glossary_term' = 'Residual Formula Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `formula_type` SET TAGS ('dbx_value_regex' = 'FIXED_AMOUNT|PERCENTAGE_OF_GROSS|PERCENTAGE_OF_DISTRIBUTOR_GROSS|TIERED_SCALE|PER_EXHIBITION|MINIMUM_GUARANTEE');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `formula_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `formula_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.formula_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `formula_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.formula_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `formula_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `guild_report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Guild Report Submission Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `guild_report_submission_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `guild_report_submission_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.guild_report_submission_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `guild_report_submission_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.guild_report_submission_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `guild_report_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Guild Report Submitted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `guild_report_submitted_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `guild_report_submitted_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.guild_report_submitted_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `guild_report_submitted_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.guild_report_submitted_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `guild_union_code` SET TAGS ('dbx_business_glossary_term' = 'Guild or Union Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `guild_union_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `guild_union_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.guild_union_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `guild_union_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.guild_union_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `guild_union_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.net_payment_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.net_payment_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Residual Payment Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `participation_linked_flag` SET TAGS ('dbx_business_glossary_term' = 'Participation Linked Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.payment_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.payment_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.payment_due_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.payment_due_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'DIRECT_DEPOSIT|CHECK|WIRE_TRANSFER|GUILD_TRUST|PAYROLL');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_method` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_method` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.payment_method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_method` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.payment_method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_method` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.payment_reference_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.payment_reference_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'PENDING|APPROVED|PAID|DISPUTED|WITHHELD|CANCELLED');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.payment_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.payment_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `payment_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Residual Percentage Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `percentage` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `percentage` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `percentage` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `reporting_period` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `reporting_period` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.reporting_period');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `reporting_period` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.reporting_period');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `resolution_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `resolution_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.resolution_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `resolution_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.resolution_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.updated_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.updated_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.residual.withholding_tax_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.residual.withholding_tax_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` SET TAGS ('dbx_subdomain' = 'license_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `music_sync_license_id` SET TAGS ('dbx_business_glossary_term' = 'Music Synchronization License ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `music_sync_license_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `music_sync_license_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.music_sync_license_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `music_sync_license_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.music_sync_license_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `grant_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `grant_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.grant_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `grant_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.grant_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Holder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Approved Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_approved_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_approved_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.clearance_approved_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_approved_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.clearance_approved_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_notes` SET TAGS ('dbx_business_glossary_term' = 'Clearance Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.clearance_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.clearance_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_requested_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Requested Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_requested_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_requested_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.clearance_requested_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_requested_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.clearance_requested_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|rejected|expired|under_review|conditional');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_status` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `clearance_status` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `composer_name` SET TAGS ('dbx_business_glossary_term' = 'Composer Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `composer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `composer_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `composer_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.composer_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `composer_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.composer_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `composition_title` SET TAGS ('dbx_business_glossary_term' = 'Composition Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `composition_title` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `composition_title` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.composition_title');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `composition_title` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.composition_title');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `composition_title` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `composition_title` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `created_by_user` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `created_by_user` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.created_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `created_by_user` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.created_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `cue_sheet_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cue Sheet Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `cue_sheet_required_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `cue_sheet_required_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.cue_sheet_required_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `cue_sheet_required_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.cue_sheet_required_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.exclusivity_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.exclusivity_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `isrc_code` SET TAGS ('dbx_business_glossary_term' = 'International Standard Recording Code (ISRC)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `isrc_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `isrc_code` SET TAGS ('dbx_validation_regex' = '^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `isrc_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `isrc_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.isrc_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `isrc_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.isrc_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `isrc_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `isrc_code` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `isrc_code` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `iswc_code` SET TAGS ('dbx_business_glossary_term' = 'International Standard Musical Work Code (ISWC)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `iswc_code` SET TAGS ('dbx_value_regex' = '^T-[0-9]{9}-[0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `iswc_code` SET TAGS ('dbx_validation_regex' = '^T-[0-9]{9}-[0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `iswc_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `iswc_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.iswc_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `iswc_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.iswc_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `iswc_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `iswc_code` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `iswc_code` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_end_date` SET TAGS ('dbx_business_glossary_term' = 'License End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.license_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.license_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_end_date` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#TemporalCoverage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_end_date` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'License Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.license_fee_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.license_fee_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'License Fee Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_fee_currency` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_fee_currency` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.license_fee_currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_fee_currency` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.license_fee_currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.license_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.license_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_start_date` SET TAGS ('dbx_business_glossary_term' = 'License Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.license_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.license_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_start_date` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#TemporalCoverage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_start_date` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'master_use|synchronization|blanket|per_title|mechanical|performance');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.license_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.license_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_type` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `license_type` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `licensed_platforms` SET TAGS ('dbx_business_glossary_term' = 'Licensed Platforms');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `licensed_platforms` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `licensed_platforms` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.licensed_platforms');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `licensed_platforms` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.licensed_platforms');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.minimum_guarantee_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.minimum_guarantee_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `pro_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Performance Rights Organization (PRO) Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `pro_affiliation` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `pro_affiliation` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.pro_affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `pro_affiliation` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.pro_affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `restrictions` SET TAGS ('dbx_business_glossary_term' = 'License Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `restrictions` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `restrictions` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `restrictions` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `royalty_basis` SET TAGS ('dbx_business_glossary_term' = 'Royalty Basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `royalty_basis` SET TAGS ('dbx_value_regex' = 'gross_revenue|net_revenue|per_stream|per_download|per_unit|flat_fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `royalty_basis` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `royalty_basis` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.royalty_basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `royalty_basis` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.royalty_basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.royalty_rate_percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.royalty_rate_percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `sublicense_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicense Permitted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `sublicense_permitted_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `sublicense_permitted_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.sublicense_permitted_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `sublicense_permitted_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.sublicense_permitted_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.updated_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.updated_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `usage_type` SET TAGS ('dbx_business_glossary_term' = 'Usage Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `usage_type` SET TAGS ('dbx_value_regex' = 'background|theme|featured|promotional|trailer|credits');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `usage_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `usage_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.music_sync_license.usage_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `usage_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.music_sync_license.usage_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ALTER COLUMN `usage_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` SET TAGS ('dbx_subdomain' = 'license_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_request_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_request_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_request_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.clearance_request_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_request_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.clearance_request_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `advertising_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `grant_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `grant_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.grant_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `grant_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.grant_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `holdback_id` SET TAGS ('dbx_business_glossary_term' = 'Holdback Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `holdback_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `holdback_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.holdback_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `holdback_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.holdback_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `music_sync_license_id` SET TAGS ('dbx_business_glossary_term' = 'Music Sync License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `music_sync_license_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `music_sync_license_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.music_sync_license_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `music_sync_license_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.music_sync_license_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `qc_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Qc Inspection Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `reach_frequency_report_id` SET TAGS ('dbx_business_glossary_term' = 'Reach Frequency Report Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `script_id` SET TAGS ('dbx_business_glossary_term' = 'Script Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_business_glossary_term' = 'Analyst Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.analyst_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.analyst_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `blocking_category` SET TAGS ('dbx_business_glossary_term' = 'Blocking Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `blocking_category` SET TAGS ('dbx_value_regex' = 'holdback_period|territory_restriction|window_unavailable|rights_expired|music_sync_missing|talent_approval_required|[ENUM-REF-CANDIDATE: holdback_period|territory_restriction|window_unavailable|rights_expired|music_sync_missing|talent_approval_req...');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `blocking_category` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `blocking_category` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.blocking_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `blocking_category` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.blocking_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `blocking_category` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.blocking_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.blocking_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_decision` SET TAGS ('dbx_business_glossary_term' = 'Clearance Decision');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_decision` SET TAGS ('dbx_value_regex' = 'approved|approved_with_conditions|denied|pending_review');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_decision` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_decision` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.clearance_decision');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_decision` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.clearance_decision');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_status` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_status` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `conditional_requirements` SET TAGS ('dbx_business_glossary_term' = 'Conditional Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `conditional_requirements` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `conditional_requirements` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.conditional_requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `conditional_requirements` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.conditional_requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.escalation_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.escalation_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.escalation_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.escalation_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_audience_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Audience Reach');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_audience_reach` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_audience_reach` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.estimated_audience_reach');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_audience_reach` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.estimated_audience_reach');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_grp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Gross Rating Point (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_grp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_grp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.estimated_grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_grp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.estimated_grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_residuals_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Residuals Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_residuals_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_residuals_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_residuals_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.estimated_residuals_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_residuals_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.estimated_residuals_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_business_glossary_term' = 'Exploitation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.exploitation_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.exploitation_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_ebu_ccdm_class_http' = '//www.ebu.ch/metadata/ontologies/ebucore#Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `exploitation_type` SET TAGS ('dbx_ebu_namespace_http' = '//www.ebu.ch/metadata/ontologies/ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `integration_status` SET TAGS ('dbx_business_glossary_term' = 'Integration Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `integration_status` SET TAGS ('dbx_value_regex' = 'pending_sync|synced_to_scheduling|synced_to_playout|sync_failed');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `integration_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `integration_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.integration_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `integration_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.integration_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `integration_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `music_clearance_required` SET TAGS ('dbx_business_glossary_term' = 'Music Synchronization Clearance Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `music_clearance_required` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `music_clearance_required` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.music_clearance_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `music_clearance_required` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.music_clearance_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.priority_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.priority_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^CLR-[0-9]{8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `request_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `request_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.request_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `request_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.request_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `request_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Submitted Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `request_submitted_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `request_submitted_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.request_submitted_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `request_submitted_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.request_submitted_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requested_air_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Air or Publish Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requested_air_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requested_air_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.requested_air_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requested_air_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.requested_air_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requested_air_time` SET TAGS ('dbx_business_glossary_term' = 'Requested Air or Publish Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requested_air_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requested_air_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.requested_air_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requested_air_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.requested_air_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requesting_department` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requesting_department` SET TAGS ('dbx_value_regex' = 'scheduling|distribution|production|programming|digital|syndication');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requesting_department` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requesting_department` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.requesting_department');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requesting_department` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.requesting_department');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `residuals_triggered` SET TAGS ('dbx_business_glossary_term' = 'Residuals Triggered');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `residuals_triggered` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `residuals_triggered` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.residuals_triggered');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `residuals_triggered` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.residuals_triggered');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.resolution_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.resolution_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `review_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Started Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `review_started_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `review_started_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.review_started_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `review_started_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.review_started_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `sla_met` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `sla_met` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `sla_met` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.sla_met');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `sla_met` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.sla_met');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.sla_target_hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.sla_target_hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `talent_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Talent Approval Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `talent_approval_required` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `talent_approval_required` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.talent_approval_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `talent_approval_required` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.talent_approval_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.clearance_request.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.clearance_request.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` SET TAGS ('dbx_subdomain' = 'license_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `holder_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `holder_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.holder_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `holder_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.holder_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.audit_rights_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.audit_rights_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.bank_account_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.bank_account_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.bank_account_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.bank_account_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.bank_routing_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.bank_routing_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `clearance_priority_level` SET TAGS ('dbx_business_glossary_term' = 'Clearance Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `clearance_priority_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|vip|critical');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `clearance_priority_level` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `clearance_priority_level` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.clearance_priority_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `clearance_priority_level` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.clearance_priority_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `clearance_priority_level` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.credit_limit_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.credit_limit_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `default_royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Default Royalty Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `default_royalty_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `default_royalty_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `default_royalty_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.default_royalty_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `default_royalty_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.default_royalty_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Entity Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `entity_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `entity_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.entity_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `entity_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.entity_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `entity_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `exclusivity_preference` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Preference');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `exclusivity_preference` SET TAGS ('dbx_value_regex' = 'exclusive_only|non_exclusive_preferred|flexible|no_preference');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `exclusivity_preference` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `exclusivity_preference` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.exclusivity_preference');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `exclusivity_preference` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.exclusivity_preference');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Talent Guild Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.guild_affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.guild_affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.last_modified_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.last_modified_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `minimum_guarantee_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Threshold Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `minimum_guarantee_threshold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `minimum_guarantee_threshold` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `minimum_guarantee_threshold` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.minimum_guarantee_threshold');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `minimum_guarantee_threshold` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.minimum_guarantee_threshold');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `most_favored_nations_flag` SET TAGS ('dbx_business_glossary_term' = 'Most Favored Nations (MFN) Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `most_favored_nations_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `most_favored_nations_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.most_favored_nations_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `most_favored_nations_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.most_favored_nations_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|paypal|international_wire');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `payment_method` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `payment_method` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.payment_method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `payment_method` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.payment_method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `payment_method` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.payment_terms_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.payment_terms_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.preferred_currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.preferred_currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_validation_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.primary_contact_email');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.primary_contact_email');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Full Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.primary_contact_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.primary_contact_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_validation_regex' = '^+?[1-9]d{1');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_14}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.primary_contact_phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.primary_contact_phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `registrant_identifier` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN) or International Standard Recording Code (ISRC) Registrant Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `registrant_identifier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `registrant_identifier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.registrant_identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `registrant_identifier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.registrant_identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.relationship_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.relationship_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.relationship_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.relationship_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_code` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Business Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.rights_holder_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.rights_holder_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Legal Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.rights_holder_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.rights_holder_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.rights_holder_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.rights_holder_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Royalty Calculation Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_value_regex' = 'percentage_of_revenue|flat_fee|tiered_percentage|per_unit|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.royalty_calculation_method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.royalty_calculation_method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.tax_identification_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.tax_identification_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_withholding_classification` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_withholding_classification` SET TAGS ('dbx_value_regex' = 'domestic|treaty_exempt|treaty_reduced_rate|non_treaty_foreign|exempt_organization');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_withholding_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_withholding_classification` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_withholding_classification` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.tax_withholding_classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_withholding_classification` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.tax_withholding_classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_withholding_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_withholding_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_withholding_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_withholding_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.tax_withholding_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_withholding_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.tax_withholding_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `territory_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'Territory of Incorporation');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `territory_of_incorporation` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `territory_of_incorporation` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.territory_of_incorporation');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `territory_of_incorporation` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.territory_of_incorporation');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `use_case_fitness_gaps` SET TAGS ('dbx_business_glossary_term' = 'Use Case Fitness Gap Analysis');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `use_case_fitness_gaps` SET TAGS ('dbx_analytics_gap_documentation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `created_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `created_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.rights.holder.created_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `created_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.rights.holder.created_by');
