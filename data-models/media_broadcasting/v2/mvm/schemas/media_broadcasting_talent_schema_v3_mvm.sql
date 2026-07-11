-- Schema for Domain: talent | Business: Media_Broadcasting | Version: v3_mvm
-- Generated on: 2026-07-10 21:14:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`talent` COMMENT 'Manages all on-screen and off-screen talent relationships — actors, directors, writers, producers, hosts, correspondents, and crew. Tracks talent contracts, guild affiliations (SAG-AFTRA, WGA, DGA), residual payment eligibility, exclusivity clauses, compensation structures, usage rights, appearance schedules, and credit attribution. Serves as the authoritative source for talent identity referenced by production, rights, and royalty workflows.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` (
    `talent_profile_id` BIGINT COMMENT 'Unique identifier for the talent profile record. Primary key for the talent master entity.',
    `talent_agency_id` BIGINT COMMENT 'FK to talent.talent_agency',
    `biometric_consent_flag` BOOLEAN COMMENT 'Indicates whether the talent has provided consent for collection and use of biometric data (facial recognition, voice prints) for digital effects, deepfake prevention, and AI training. Required for GDPR and CCPA compliance.',
    `ccpa_opt_out_flag` BOOLEAN COMMENT 'Indicates whether the talent has opted out of the sale or sharing of their personal information under CCPA. Required for California-based talent or productions.',
    `clearance_expiration_date` DATE COMMENT 'The date when the talents current clearance status expires and requires renewal. Used for compliance tracking and production eligibility verification.',
    `clearance_status` STRING COMMENT 'The current clearance status of the talent for production work. Indicates whether background checks, work authorization, insurance verification, and legal clearances are complete and current.. Valid values are `cleared|pending|restricted|blocked|expired`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the talent profile record was first created in the system. Used for audit trail and data lineage tracking.',
    `date_of_birth` DATE COMMENT 'The talents date of birth. Required for age verification, child labor law compliance (COPPA), insurance underwriting, and residual payment calculations.',
    `email_address` STRING COMMENT 'The primary email address for talent communication, contract delivery, and digital correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `exclusivity_clause_flag` BOOLEAN COMMENT 'Indicates whether the talent is currently bound by an exclusivity clause that restricts their ability to work with competing networks, studios, or brands. Used for conflict checking during casting and booking.',
    `gdpr_consent_status` STRING COMMENT 'The current status of the talents GDPR consent for data processing. Tracks whether the talent has provided, withdrawn, or is pending consent for personal data usage under EU regulations.. Valid values are `consented|withdrawn|not_applicable|pending`',
    `gender_identity` STRING COMMENT 'The talents self-identified gender. Used for diversity reporting, casting analytics, and compliance with equal opportunity regulations.. Valid values are `male|female|non_binary|prefer_not_to_say|other`',
    `imdb_identifier` STRING COMMENT 'The talents unique identifier in the Internet Movie Database (IMDb). Used for cross-referencing filmography, public profile linking, and industry data integration.. Valid values are `^nm[0-9]{7,8}$`',
    `insurance_coverage_flag` BOOLEAN COMMENT 'Indicates whether the talent is currently covered by production insurance (liability, workers compensation, errors and omissions). Required for on-set work authorization.',
    `insurance_policy_number` STRING COMMENT 'The policy number for the talents production insurance coverage. Used for claims processing and certificate of insurance verification.',
    `isni_code` STRING COMMENT 'The International Standard Name Identifier (ISNI) for the talent. A globally unique identifier for creators used in rights management and royalty distribution systems.. Valid values are `^[0-9]{4} [0-9]{4} [0-9]{4} [0-9]{3}[0-9X]$`',
    `legal_name` STRING COMMENT 'The full legal name of the talent as it appears on official documents and contracts. Used for contract execution, payroll, and legal compliance.',
    `nationality` STRING COMMENT 'The talents nationality represented as a 3-letter ISO country code. Used for work authorization, tax treaty eligibility, and international co-production compliance.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special requirements, or contextual information about the talent. Used for casting notes, production preferences, and internal communication.',
    `phone_number` STRING COMMENT 'The primary contact phone number for the talent. Used for production scheduling, emergency contact, and direct communication.',
    `primary_language` STRING COMMENT 'The talents primary working language represented as a 2-letter ISO language code. Used for casting, dubbing, and localization workflows.. Valid values are `^[a-z]{2}$`',
    `profile_status` STRING COMMENT 'The current lifecycle status of the talent profile. Determines availability for casting, contract execution, and system access.. Valid values are `active|inactive|suspended|retired|deceased`',
    `residual_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the talent is eligible to receive residual payments for reuse of their work in syndication, streaming, or international distribution. Determined by union status and contract terms.',
    `stage_name` STRING COMMENT 'The professional or stage name used by the talent for public appearances, credits, and marketing materials. May differ from legal name.',
    `talent_tier` STRING COMMENT 'The classification tier of the talent based on industry recognition, box office draw, and compensation level. Used for budgeting, marketing strategy, and billing rate determination.. Valid values are `a_list|b_list|c_list|emerging|supporting|background`',
    `talent_type` STRING COMMENT 'The primary professional category or role type of the talent. Determines applicable guild rules, contract templates, and credit attribution standards. [ENUM-REF-CANDIDATE: actor|director|writer|producer|host|correspondent|crew|voice_artist|composer|cinematographer — 10 candidates stripped; promote to reference product]',
    `tax_id_number` STRING COMMENT 'The talents tax identification number (SSN, EIN, or international equivalent). Required for payroll processing, tax withholding, and IRS 1099 reporting.',
    `union_affiliation` STRING COMMENT 'The primary labor union or guild affiliation of the talent. Determines contract terms, minimum compensation, residual eligibility, and working conditions.. Valid values are `sag_aftra|wga|dga|iatse|non_union|multiple`',
    `union_member_number` STRING COMMENT 'The talents membership identifier within their primary union or guild. Required for residual payment processing and contract compliance verification.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when the talent profile record was last modified. Used for change tracking and data freshness verification.',
    `work_authorization_status` STRING COMMENT 'The talents current work authorization status in the primary production jurisdiction. Determines eligibility for employment and production participation.. Valid values are `citizen|permanent_resident|work_visa|pending|expired`',
    `work_visa_expiration_date` DATE COMMENT 'The expiration date of the talents work visa. Critical for production scheduling and compliance with immigration regulations.',
    `work_visa_type` STRING COMMENT 'The specific type of work visa held by the talent (e.g., O-1, P-1, H-1B). Used for compliance tracking and production planning for international talent.',
    CONSTRAINT pk_talent_profile PRIMARY KEY(`talent_profile_id`)
) COMMENT 'Master identity record for all on-screen and off-screen talent — actors, directors, writers, producers, hosts, correspondents, crew, and voice artists. Stores legal name, stage name, date of birth, nationality, gender identity, primary language, union membership references, talent tier classification, representation agency references, IMDb/ISNI identifiers, biometric consent flags, data privacy status (GDPR/CCPA), clearance status, and active/inactive lifecycle state. Serves as the authoritative SSOT for talent identity referenced by production, rights, royalty, and scheduling workflows across the enterprise.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` (
    `guild_affiliation_id` BIGINT COMMENT 'Unique identifier for the guild affiliation record. Primary key.',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent (actor, director, writer, producer, crew member) who holds this guild membership.',
    `cba_effective_date` DATE COMMENT 'Date when the current collective bargaining agreement became effective for this membership.',
    `cba_expiration_date` DATE COMMENT 'Date when the current collective bargaining agreement expires. Used to track contract renewal cycles and potential rate changes.',
    `cba_version` STRING COMMENT 'Version or year identifier of the collective bargaining agreement that governs this membership. Critical for determining applicable residual rates, working conditions, and compensation structures.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this guild affiliation record was first created in the system.',
    `dues_payment_status` STRING COMMENT 'Current status of membership dues payment obligations. Current (all dues paid up to date), overdue (payment past due but within grace period), delinquent (significantly past due, may affect standing), exempt (not required to pay dues), waived (dues forgiven by guild).. Valid values are `current|overdue|delinquent|exempt|waived`',
    `guild_code` STRING COMMENT 'Standardized code identifying the entertainment industry guild or union. SAG-AFTRA (Screen Actors Guild - American Federation of Television and Radio Artists), WGA (Writers Guild of America), DGA (Directors Guild of America), IATSE (International Alliance of Theatrical Stage Employees), AFM (American Federation of Musicians), BECTU (Broadcasting Entertainment Communications and Theatre Union - UK), ACTRA (Alliance of Canadian Cinema Television and Radio Artists). [ENUM-REF-CANDIDATE: SAG-AFTRA|WGA|DGA|IATSE|AFM|BECTU|ACTRA|OTHER — 8 candidates stripped; promote to reference product]',
    `guild_name` STRING COMMENT 'Full legal name of the guild or union organization.',
    `health_benefits_eligible_flag` BOOLEAN COMMENT 'Indicates whether the talent is eligible for guild-provided health insurance benefits based on this membership and earnings thresholds. True if eligible, false otherwise.',
    `join_date` DATE COMMENT 'Date when the talent officially became a member of this guild. Used to determine seniority and eligibility for certain benefits.',
    `jurisdiction` STRING COMMENT 'Geographic jurisdiction or country where this guild membership is registered and governed. USA (United States), CAN (Canada), GBR (United Kingdom), AUS (Australia), NZL (New Zealand), IRL (Ireland). [ENUM-REF-CANDIDATE: USA|CAN|GBR|AUS|NZL|IRL|OTHER — 7 candidates stripped; promote to reference product]',
    `last_dues_payment_date` DATE COMMENT 'Date of the most recent membership dues payment received by the guild.',
    `local_chapter` STRING COMMENT 'Local chapter, branch, or regional division of the guild to which this membership is assigned. Used for regional governance and event coordination.',
    `membership_number` STRING COMMENT 'Unique membership identifier assigned by the guild to the talent member. Required for residual payment processing and production compliance verification.',
    `membership_status` STRING COMMENT 'Current standing of the talent within the guild. Good standing (active member in compliance), suspended (temporarily barred due to dues or violations), resigned (voluntarily terminated membership), expelled (involuntarily removed), inactive (not currently active but not terminated), pending (application under review).. Valid values are `good_standing|suspended|resigned|expelled|inactive|pending`',
    `membership_tier` STRING COMMENT 'Classification of membership level within the guild. Full member (standard active membership with full benefits), fi-core (financial core member with limited participation), apprentice (trainee or provisional member), honorary (recognition membership), lifetime (permanent membership status), emeritus (retired member with recognition).. Valid values are `full_member|fi_core|apprentice|honorary|lifetime|emeritus`',
    `next_dues_payment_date` DATE COMMENT 'Date when the next membership dues payment is due.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or remarks about this guild membership. May include information about membership restrictions, special accommodations, or historical context.',
    `pension_eligible_flag` BOOLEAN COMMENT 'Indicates whether the talent is eligible for guild pension plan contributions and benefits. True if eligible, false otherwise.',
    `residual_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this guild membership makes the talent eligible to receive residual payments for reuse of their work. True if eligible, false otherwise. Critical for royalty calculation workflows.',
    `termination_date` DATE COMMENT 'Date when the guild membership ended, whether through resignation, expulsion, or other termination. Null for active memberships.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this guild affiliation record was last modified in the system.',
    `verification_date` DATE COMMENT 'Date when the guild membership status was last verified with the guild organization. Used to ensure data accuracy for production compliance.',
    `verification_method` STRING COMMENT 'Method used to verify the guild membership status. API (automated guild system integration), manual (direct guild contact), document (membership card or certificate scan), self-reported (talent declaration), third-party (verification service).. Valid values are `api|manual|document|self_reported|third_party`',
    CONSTRAINT pk_guild_affiliation PRIMARY KEY(`guild_affiliation_id`)
) COMMENT 'Tracks each talents formal membership and standing within entertainment industry guilds and unions — SAG-AFTRA, WGA (Writers Guild of America), DGA (Directors Guild of America), IATSE, AFM (American Federation of Musicians), and international equivalents (BECTU, ACTRA). Records membership number, guild code, membership tier (full member, fi-core, apprentice), join date, current standing (good standing, suspended, resigned), dues payment status, and applicable collective bargaining agreement (CBA) version. Critical for residual eligibility determination and production compliance.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` (
    `contract_id` BIGINT COMMENT 'Unique identifier for the talent contract record. Primary key for the talent contract entity.',
    `coproduction_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.coproduction_agreement. Business justification: Talent contracts in co-productions must be attributed to the specific co-production agreement for budget allocation, credit obligation enforcement, and residuals-sharing formula application. Co-produc',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Talent contracts are executed with production partners (studios, networks, streamers) as the contracting entity. Essential for contract administration, payment routing, rights clearance, and partner r',
    `project_id` BIGINT COMMENT 'Reference to the production (series, film, episode, special) for which this talent is contracted. Nullable for overall deals and first-look deals not tied to a specific production.',
    `representation_agreement_id` BIGINT COMMENT 'Foreign key linking to talent.representation_agreement. Business justification: Every talent contract is negotiated through the talents representation agreement with their agency. The contract currently stores talent_representative_agency and talent_representative_name as denorm',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent (actor, director, writer, producer, host, correspondent, crew member) engaged under this contract.',
    `amendment_count` STRING COMMENT 'The total number of formal amendments made to this contract since initial execution. Tracks contract modification history.',
    `backend_participation_percentage` DECIMAL(18,2) COMMENT 'The percentage of net profits, adjusted gross, or other revenue streams the talent is entitled to receive after recoupment of production costs. Common for above-the-line talent.',
    `backend_participation_type` STRING COMMENT 'The revenue calculation basis for backend participation. Net profits are after all costs; adjusted gross is after specific deductions; gross receipts are from first dollar. None indicates no backend participation.. Valid values are `net_profits|adjusted_gross|gross_receipts|none`',
    `base_compensation_amount` DECIMAL(18,2) COMMENT 'The guaranteed base fee or salary payable to the talent for services rendered under this contract, excluding bonuses, backend participation, and residuals.',
    `billing_credit_position` STRING COMMENT 'The contractually specified position and format of the talents on-screen credit (e.g., First Position Main Title, Shared Card, Single Card, Above the Title). Critical for talent reputation and guild compliance.',
    `compensation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the base compensation amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `compensation_structure` STRING COMMENT 'The payment model for the base compensation. Flat fee is a single lump sum; per-episode is paid per episode produced; weekly/annual/day/hourly rates define periodic payment schedules.. Valid values are `flat_fee|per_episode|weekly_rate|annual_salary|day_rate|hourly_rate`',
    `contract_number` STRING COMMENT 'Business identifier for the contract, typically assigned by legal or business affairs. Used for external reference and tracking.',
    `contract_status` STRING COMMENT 'Current stage of the contract in its lifecycle. Deal memo represents initial short-form agreement; countersigned indicates mutual acceptance; long-form executed is the final detailed contract; amended reflects modifications; suspended indicates temporary hold; terminated is early cancellation; expired is natural end. [ENUM-REF-CANDIDATE: deal_memo|countersigned|long_form_executed|amended|suspended|terminated|expired — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the talent engagement type. Series regular deals cover multi-episode commitments; episodic guest agreements are single or limited appearances; overall deals provide exclusive services across multiple projects; first-look deals grant priority rights to talent-developed content; crew contracts cover technical and production staff; talent holding deals reserve talent availability; development deals fund content creation. [ENUM-REF-CANDIDATE: series_regular|episodic_guest|overall_deal|first_look_deal|crew_contract|talent_holding_deal|development_deal — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this contract record was first created in the system.',
    `credit_placement_requirements` STRING COMMENT 'Detailed contractual requirements for credit placement, including main title vs end credits, paid advertising inclusion, promotional materials, and any special formatting or adjacency requirements.',
    `credit_size_percentage` DECIMAL(18,2) COMMENT 'The minimum size of the talents on-screen credit as a percentage of the title or other reference credit size. Null if not contractually specified.',
    `document_reference_uri` STRING COMMENT 'The storage location or document management system URI for the executed contract document and all amendments. Used for legal reference and audit.',
    `effective_end_date` DATE COMMENT 'The date on which the contract expires or the engagement period ends. Nullable for open-ended overall deals or holding deals with option-based extensions.',
    `effective_start_date` DATE COMMENT 'The date on which the contract becomes binding and the talent engagement period begins.',
    `engagement_role` STRING COMMENT 'The specific role or position the talent is contracted to perform (e.g., Lead Actor, Director, Showrunner, Writer, Executive Producer, Director of Photography, Host).',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the contract includes exclusivity restrictions preventing the talent from working on competing projects or for other networks/studios during the contract period.',
    `exclusivity_scope` STRING COMMENT 'Detailed description of the exclusivity restrictions, including prohibited activities, competing platforms, genre restrictions, and geographic scope. Null if exclusivity_flag is false.',
    `governing_cba` STRING COMMENT 'The specific collective bargaining agreement that governs this contract, including version and effective date (e.g., SAG-AFTRA Television Agreement 2020-2023). Defines minimum compensation, working conditions, and residual structures.',
    `guaranteed_episodes` STRING COMMENT 'The minimum number of episodes for which the talent is guaranteed compensation, regardless of actual production. Common in series regular deals. Null for non-episodic contracts.',
    `guild_affiliation` STRING COMMENT 'The labor union or guild to which the talent belongs. SAG-AFTRA covers actors and broadcasters; WGA covers writers; DGA covers directors; IATSE covers crew and technical staff. Multiple indicates membership in more than one guild. Non-union indicates no guild membership.. Valid values are `SAG-AFTRA|WGA|DGA|IATSE|non_union|multiple`',
    `holdback_period_days` STRING COMMENT 'The number of days after contract end during which the talent is restricted from working on similar projects or for competing entities. Common in overall deals and first-look agreements.',
    `last_amendment_date` DATE COMMENT 'The date of the most recent contract amendment. Null if no amendments have been made.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this contract record was most recently updated in the system.',
    `option_exercise_deadline` DATE COMMENT 'The date by which the company must notify the talent of its decision to exercise or decline the next option period. Null if no active option exists.',
    `option_exercise_status` STRING COMMENT 'Current status of the most recent option period. Not applicable if no options exist; pending if decision deadline has not passed; exercised if company extended; declined if company chose not to extend; expired if deadline passed without action.. Valid values are `not_applicable|pending|exercised|declined|expired`',
    `option_periods_count` STRING COMMENT 'The number of option periods (typically annual) the company holds to extend the contract beyond the initial term. Common in series regular and overall deals.',
    `pay_or_play_flag` BOOLEAN COMMENT 'Indicates whether the contract includes a pay-or-play provision, guaranteeing full compensation even if the talent services are not ultimately used or the production is cancelled.',
    `residual_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the talent is eligible to receive residual payments for reuse of the content (reruns, streaming, international distribution, home video). Governed by guild CBAs.',
    `step_up_amount` DECIMAL(18,2) COMMENT 'The incremental increase in base compensation for each exercised option period or season renewal. Null if no step-up provision exists.',
    `termination_date` DATE COMMENT 'The date on which the contract was terminated prior to its natural expiration. Null if contract was not terminated early.',
    `termination_reason` STRING COMMENT 'The primary reason for early contract termination. Null if contract was not terminated early. [ENUM-REF-CANDIDATE: mutual_agreement|breach_of_contract|force_majeure|production_cancellation|talent_unavailability|company_convenience|talent_request|other — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_contract PRIMARY KEY(`contract_id`)
) COMMENT 'Authoritative record of each talent engagement from initial deal memo through executed long-form contract — covering series regular deals, episodic guest agreements, overall deals, first-look deals, and crew contracts. Captures contract lifecycle stage (deal memo, countersigned, long-form executed), compensation structure (base fee, guarantees, backend participation, step-ups, pay-or-play), exclusivity and holdback restrictions, option periods with exercise status, amendment history, billing credit position, governing CBA, and document references. Source of truth for all commercial terms, obligations, and contractual modifications throughout the talent engagement lifecycle.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` (
    `compensation_structure_id` BIGINT COMMENT 'Unique identifier for the compensation structure record. Primary key.',
    `contract_id` BIGINT COMMENT 'Reference to the parent talent contract to which this compensation structure is attached.',
    `guild_affiliation_id` BIGINT COMMENT 'Foreign key linking to talent.guild_affiliation. Business justification: Compensation structures in the entertainment industry are heavily governed by guild/union CBAs. The guild_affiliation record contains the authoritative cba_version, pension_health_rate eligibility, an',
    `role_id` BIGINT COMMENT 'Foreign key linking to talent.role. Business justification: A compensation structure is attached to a contract, but for multi-role contracts (e.g., a talent contracted as both actor and executive producer), each role may have a distinct compensation structure.',
    `backend_gross_participation_pct` DECIMAL(18,2) COMMENT 'The percentage of adjusted gross receipts or backend profits the talent is entitled to receive (e.g., 0.05 for 5% backend participation). Null if no backend participation is granted.',
    `base_episode_fee` DECIMAL(18,2) COMMENT 'The guaranteed compensation amount per episode for episodic talent (actors, writers, directors). Expressed in the contract currency.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'The fixed or maximum bonus amount payable when the bonus threshold is met. Expressed in the contract currency. Null if no bonus provision exists.',
    `bonus_threshold_description` STRING COMMENT 'Textual description of the performance or milestone thresholds that trigger bonus payments (e.g., Nielsen rating above 2.0 in key demo, box office exceeds $100M domestic).',
    `compensation_type` STRING COMMENT 'Classification of the compensation arrangement: union scale (SAG-AFTRA, WGA, DGA minimum), over-scale (above union minimum), flat fee, episodic rate, weekly guarantee, daily rate, backend gross participation, deferred compensation, or residual-only deal. [ENUM-REF-CANDIDATE: union_scale|over_scale|flat_fee|episodic|weekly|daily|backend_participation|deferred|residual_only — 9 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this compensation structure record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all monetary amounts in this compensation structure are denominated (e.g., USD, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    `daily_rate` DECIMAL(18,2) COMMENT 'The guaranteed daily compensation amount for talent engaged on a day-player or daily basis. Expressed in the contract currency.',
    `deferred_compensation_amount` DECIMAL(18,2) COMMENT 'The total amount of compensation deferred to a future payment date or contingent event (e.g., series pickup, profitability milestone). Expressed in the contract currency.',
    `deferred_payment_trigger` STRING COMMENT 'The business event or milestone that triggers payment of deferred compensation (e.g., series_pickup, profitability_threshold_met, syndication_sale, specific_date).',
    `effective_end_date` DATE COMMENT 'The date on which this compensation structure ceases to be effective. Null for open-ended structures or those tied to contract termination.',
    `effective_start_date` DATE COMMENT 'The date on which this compensation structure becomes effective and applicable to the talent contract.',
    `exclusivity_clause_flag` BOOLEAN COMMENT 'Indicates whether this compensation structure includes an exclusivity provision restricting the talent from working on competing projects (True) or not (False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this compensation structure record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special provisions, or clarifications regarding this compensation structure that do not fit into structured fields.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'The multiplier applied to the base rate for overtime hours worked (e.g., 1.5 for time-and-a-half, 2.0 for double-time). Null if overtime is not applicable.',
    `pay_or_play_flag` BOOLEAN COMMENT 'Indicates whether this compensation structure includes a pay-or-play provision, guaranteeing payment even if the talent is not used (True) or not (False).',
    `pension_health_rate` DECIMAL(18,2) COMMENT 'The percentage rate of gross compensation contributed to the guild pension and health plan (e.g., 0.185 for 18.5% SAG-AFTRA P&H). Used to calculate employer contributions.',
    `residual_base_formula` STRING COMMENT 'The formula or method used to calculate the residual base for reuse payments (e.g., initial_compensation, applicable_minimum, pro_rata_share). Defines how residuals are computed per guild rules.',
    `residual_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the talent is eligible to receive residual payments for reuse of the content under this compensation structure (True) or not (False). Typically True for union deals, may be False for buyouts.',
    `step_up_amount` DECIMAL(18,2) COMMENT 'The incremental compensation increase amount when the step-up trigger is met. Expressed in the contract currency. Null if no step-up provision exists.',
    `step_up_trigger` STRING COMMENT 'The condition or event that triggers an automatic increase in compensation (e.g., season_2_pickup, episode_13_renewal, ratings_threshold). Null if no step-up provision exists.',
    `structure_name` STRING COMMENT 'Business-friendly name or label for this compensation structure (e.g., Series Regular Season 1, Guest Star Rate Card).',
    `structure_status` STRING COMMENT 'Current lifecycle status of the compensation structure: draft (under negotiation), active (in force), amended (modified after execution), superseded (replaced by a newer structure), or terminated (no longer applicable).. Valid values are `draft|active|amended|superseded|terminated`',
    `usage_rights_scope` STRING COMMENT 'Description of the media usage rights covered by this compensation structure (e.g., initial broadcast only, all media in perpetuity, theatrical and SVOD, domestic free television). Defines what exploitation is covered by the base compensation.',
    `weekly_guarantee` DECIMAL(18,2) COMMENT 'The guaranteed weekly compensation amount for talent engaged on a weekly basis (e.g., series regulars, production staff). Expressed in the contract currency.',
    CONSTRAINT pk_compensation_structure PRIMARY KEY(`compensation_structure_id`)
) COMMENT 'Defines the detailed compensation terms attached to a talent contract — including base episode fee, weekly guarantee, daily rate, overtime multipliers, pension and health (P&H) contribution rates, residual base formula, backend gross participation percentage, deferred compensation schedule, and currency. Supports both union scale (SAG-AFTRA scale, DGA scale) and over-scale deals. Tracks step-up triggers (e.g., series pickup escalators), bonus thresholds, and pay-or-play provisions. Used by payroll and royalty workflows to calculate gross compensation and residual bases.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` (
    `appearance_schedule_id` BIGINT COMMENT 'Unique identifier for the appearance schedule record. Primary key for the appearance schedule entity.',
    `ad_order_id` BIGINT COMMENT 'Foreign key linking to sales.ad_order. Business justification: Sponsored segment and branded integration appearances are commissioned via ad orders. Traffic and scheduling teams must confirm talent availability against the specific ad order driving the appearance',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Per-appearance fee invoicing: in live, talk, and variety production, talent is billed per appearance rather than per contract. Billing teams generate and reconcile appearance-specific invoices against',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Talent booking must track which channel the appearance is scheduled for to enforce exclusivity clauses, detect multi-channel conflicts, coordinate travel logistics, and apply channel-specific producti',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Appearance schedules for episodic content must specify exact episode for production call sheets, per-episode compensation tracking, and daily production scheduling. Critical for episodic production op',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.contract. Business justification: An appearance schedule entry represents a talent booking that is governed by a specific contract. The contract defines the terms, exclusivity clauses, and compensation under which the talent appears. ',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Talent compensation and availability vary by daypart (primetime vs. daytime rates, union rules). Booking systems must track daypart for rate calculation, availability matching, and contract compliance',
    `project_id` BIGINT COMMENT 'Reference to the production (film, television episode, live broadcast, promotional event) for which the talent is scheduled.',
    `program_schedule_id` BIGINT COMMENT 'Foreign key linking to scheduling.program_schedule. Business justification: Appearance bookings must link to the specific daily program schedule for production coordination, call-time synchronization, and rundown integration. Enables talent department to track which broadcast',
    `rescheduled_from_appearance_schedule_id` BIGINT COMMENT 'Reference to the original appearance schedule record if this schedule is a rescheduled version of a previous booking.',
    `role_id` BIGINT COMMENT 'Foreign key linking to talent.role. Business justification: Each appearance schedule entry is for a talent performing a specific role (character, host, correspondent, etc.). The role record defines the character_name, role_category, billing_position, and usage',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: Each appearance booking must reference the specific schedule slot for precise timing, conflict detection, playout system integration, and as-run confirmation. Enables bidirectional sync between talent',
    `sweeps_period_id` BIGINT COMMENT 'Foreign key linking to audience.sweeps_period. Business justification: Programming strategy concentrates high-profile talent appearances during Nielsen sweeps periods to maximize ratings that set advertising rates. Production schedulers coordinate talent bookings with sw',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent (actor, director, writer, producer, host, correspondent, crew member) associated with this appearance schedule.',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Talent bookings are made to serve specific demographic targets (e.g., guest booked to lift W25-54). Programming and sales operations track the intended demographic for each appearance to validate guar',
    `title_id` BIGINT COMMENT 'Reference to the content title (series, film, special) associated with this appearance.',
    `actual_duration_hours` DECIMAL(18,2) COMMENT 'The actual number of hours the talent was engaged for this appearance, recorded after completion for payroll and residual calculation purposes.',
    `appearance_type` STRING COMMENT 'Classification of the type of appearance or activity scheduled for the talent. ADR (Automated Dialogue Replacement) refers to post-production voice recording sessions. [ENUM-REF-CANDIDATE: principal_photography|adr_session|promotional_appearance|press_junket|live_broadcast|table_read|rehearsal|wardrobe_fitting|makeup_test|screen_test — 10 candidates stripped; promote to reference product]',
    `availability_window_end` DATE COMMENT 'The end date of the period during which the talent has indicated availability for scheduling.',
    `availability_window_start` DATE COMMENT 'The start date of the period during which the talent has indicated availability for scheduling.',
    `booking_reference` STRING COMMENT 'Externally-known unique booking reference code assigned to this appearance schedule by the production scheduling system.. Valid values are `^[A-Z0-9]{8,20}$`',
    `call_date` DATE COMMENT 'The scheduled date on which the talent is required to appear for the activity. Follows yyyy-MM-dd format.',
    `call_time` TIMESTAMP COMMENT 'The specific date and time when the talent must report to the location. Follows yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation of why the appearance schedule was cancelled, such as production delays, talent unavailability, or budget constraints.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'The date and time when this appearance schedule was cancelled, if applicable.',
    `confirmation_status` STRING COMMENT 'Current lifecycle status of the appearance schedule indicating whether the booking is pending confirmation, confirmed, cancelled, rescheduled, completed, or resulted in a no-show.. Valid values are `pending|confirmed|cancelled|rescheduled|completed|no_show`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this appearance schedule record was first created in the system.',
    `daypart` STRING COMMENT 'The time segment of the broadcast day during which the appearance is scheduled, relevant for live broadcast appearances and promotional activities. [ENUM-REF-CANDIDATE: early_morning|morning|midday|afternoon|prime_time|late_night|overnight — 7 candidates stripped; promote to reference product]',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'The estimated number of hours the talent is expected to be engaged for this appearance, used for scheduling and compensation planning.',
    `exclusivity_conflict_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this appearance schedule conflicts with any exclusivity clauses in the talents contract.',
    `guild_notification_required` BOOLEAN COMMENT 'Boolean flag indicating whether guild notification is required for this appearance per union agreements (SAG-AFTRA, WGA, DGA).',
    `guild_notification_sent_timestamp` TIMESTAMP COMMENT 'The date and time when notification was sent to the relevant guild regarding this appearance schedule.',
    `hold_level` STRING COMMENT 'Priority level of the talent booking indicating the strength of the commitment. First hold is highest priority, second and third holds are lower priority backups, first refusal gives talent right to accept or decline before offering to others.. Valid values are `confirmed|first_hold|second_hold|third_hold|first_refusal|tentative`',
    `last_modified_by_user` STRING COMMENT 'The username or identifier of the user who most recently modified this appearance schedule record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this appearance schedule record was most recently updated.',
    `playout_system_sync_status` STRING COMMENT 'Status indicating whether this appearance schedule has been synchronized with the playout and channel management system (Ericsson MediaFirst) for live broadcast coordination.. Valid values are `not_synced|pending|synced|sync_failed`',
    `playout_system_sync_timestamp` TIMESTAMP COMMENT 'The date and time when this appearance schedule was last synchronized with the playout system.',
    `release_tracking_status` STRING COMMENT 'Status of obtaining necessary talent releases, waivers, or permissions required for the appearance, particularly for promotional and publicity activities.. Valid values are `not_required|pending|obtained|expired|declined`',
    `scheduling_notes` STRING COMMENT 'Free-text field for additional scheduling information, special requirements, or coordination notes relevant to this appearance.',
    `unavailability_reason` STRING COMMENT 'Free-text explanation of why the talent is unavailable during certain periods, such as personal commitments, conflicting bookings, or contractual exclusivity.',
    `wrap_time` TIMESTAMP COMMENT 'The actual or estimated date and time when the talent completed their scheduled activity and was released from the set or location.',
    CONSTRAINT pk_appearance_schedule PRIMARY KEY(`appearance_schedule_id`)
) COMMENT 'Operational schedule of talent time allocation — covering confirmed bookings, holds (first/second/third), first refusals, availability windows, and personal unavailability alongside specific call times for principal photography, ADR sessions, promotional appearances, press junkets, and live broadcast slots. Records production reference, call date/time, wrap time, location, appearance type, hold level, confirmation status, and release tracking. Integrates with production scheduling and playout systems to ensure talent availability aligns with broadcast calendars.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` (
    `credit_attribution_id` BIGINT COMMENT 'Unique identifier for the credit attribution record. Primary key.',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Episode-level credits are the most granular operational unit for EPG metadata, streaming platform delivery (streaming_metadata_flag), and guild credit arbitration. credit_attribution already links to ',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.contract. Business justification: Credit attribution defines on-screen and promotional credit entitlements that are contractually mandated. The contract contains credit_placement_requirements and credit_size_percentage which are the s',
    `coproduction_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.coproduction_agreement. Business justification: Co-production agreements specify contractual credit obligations (possessory credits, billing positions, card sizes). Credit attribution must be directly traceable to the co-production agreement to ver',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Credit display requirements vary by delivery channel — broadcast EPG credits differ from FAST channel metadata and VOD platform credits. Guild contracts specify channel-type-specific credit obligation',
    `role_id` BIGINT COMMENT 'Foreign key linking to talent.talent_role. Business justification: credit_attribution defines on-screen and promotional credits for a talent on a specific production. talent_role defines the role/function performed (role_name, character_name, role_category). Currentl',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Season-specific credits (e.g., season showrunner changes, guest producers) require season-level attribution for accurate metadata, season-specific residuals, and platform EPG data.',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Series-level credits (Created by, Executive Producer) require direct series link for proper attribution across all episodes, series-level residuals, and metadata distribution to platforms.',
    `syndication_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.syndication_agreement. Business justification: Syndication agreements contain specific credit placement and billing block requirements. Credit attribution records must be verifiable against the syndication agreements credit obligations for partne',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent (actor, director, writer, producer, host, correspondent, crew member) receiving this credit.',
    `title_id` BIGINT COMMENT 'Reference to the content asset (title, episode, series, production) for which this credit is attributed.',
    `approval_date` DATE COMMENT 'The date on which this credit attribution was formally approved by all relevant parties (talent, guild, production company).',
    `billing_block` STRING COMMENT 'The section or block within the credits where this attribution appears: above title, title card, opening sequence, closing sequence, end crawl, or promotional materials.. Valid values are `above_title|title_card|opening_sequence|closing_sequence|end_crawl|promotional`',
    `billing_position` STRING COMMENT 'The numerical position of this credit in the credit sequence. Lower numbers indicate higher prominence (e.g., 1 = first position, 2 = second position). Null indicates alphabetical or unordered placement.',
    `card_size_percentage` DECIMAL(18,2) COMMENT 'The size of the talent credit card relative to the title card, expressed as a percentage (e.g., 100.00 means same size as title, 75.00 means 75% of title size). Contractually mandated for high-profile talent.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this credit attribution record was first created in the system.',
    `credit_approval_status` STRING COMMENT 'The current approval status of this credit attribution: draft (not finalized), pending approval (awaiting talent or guild review), approved (finalized and contractually binding), disputed (under arbitration), or waived (talent declined credit).. Valid values are `draft|pending_approval|approved|disputed|waived`',
    `credit_determination_method` STRING COMMENT 'The method by which this credit was determined: contractual (per talent agreement), guild arbitration (resolved by guild dispute process), mutual agreement (negotiated between parties), or statutory (mandated by regulation).. Valid values are `contractual|guild_arbitration|mutual_agreement|statutory`',
    `credit_duration_seconds` DECIMAL(18,2) COMMENT 'The minimum duration in seconds that the credit card must be displayed on screen, as contractually required.',
    `credit_format` STRING COMMENT 'The format in which the credit is displayed: single card (talent alone), shared card (multiple talents on one card), alphabetical (ordered alphabetically with peers), or separate card (dedicated card for this talent).. Valid values are `single_card|shared_card|alphabetical|separate_card`',
    `credit_notes` STRING COMMENT 'Additional notes or comments regarding this credit attribution, including special instructions, historical context, or clarifications for production and distribution teams.',
    `credit_placement` STRING COMMENT 'Specifies where the credit must appear: opening credits, closing credits, both, or promotional materials only.. Valid values are `opening|closing|both|promotional_only`',
    `credit_source_system` STRING COMMENT 'The operational system of record from which this credit attribution was sourced (e.g., Dalet Galaxy, Rightsline, production management system).',
    `credit_text` STRING COMMENT 'The exact contractually mandated credit language or text that must appear on screen or in promotional materials (e.g., Directed by, Written by, Starring, A Film By, Executive Producer).',
    `credit_type` STRING COMMENT 'The type of credit being attributed: main title (opening credits), end title (closing credits), possessory credit (e.g., A Film By), and credit, with credit, special appearance, or guest star designation. [ENUM-REF-CANDIDATE: main_title|end_title|possessory_credit|and_credit|with_credit|special_appearance|guest_star — 7 candidates stripped; promote to reference product]',
    `credit_waiver_flag` BOOLEAN COMMENT 'Indicates whether the talent has waived their contractual right to receive this credit (e.g., for creative or personal reasons).',
    `credit_waiver_reason` STRING COMMENT 'The documented reason for the credit waiver, if applicable (e.g., Creative decision, Pseudonym requested, Guild arbitration outcome).',
    `effective_end_date` DATE COMMENT 'The date on which this credit attribution expires or is superseded (e.g., due to contract renegotiation, credit correction, or content retirement). Null indicates indefinite validity.',
    `effective_start_date` DATE COMMENT 'The date from which this credit attribution becomes effective and must be applied to all content distributions and promotional materials.',
    `epg_display_flag` BOOLEAN COMMENT 'Indicates whether this credit should be displayed in the Electronic Program Guide (EPG) metadata for linear and on-demand platforms.',
    `possessory_credit_flag` BOOLEAN COMMENT 'Indicates whether this is a possessory credit (e.g., A Film By [Name]), which is a special contractual entitlement typically reserved for directors or executive producers with significant creative control.',
    `promotional_materials_flag` BOOLEAN COMMENT 'Indicates whether this credit must appear in promotional materials (posters, trailers, advertisements) as contractually required.',
    `pseudonym` STRING COMMENT 'The pseudonym or stage name to be used in the credit if the talent does not wish to use their legal name (e.g., Alan Smithee for directors, pen names for writers).',
    `residual_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this credit attribution makes the talent eligible for residual payments (reuse payments) under guild agreements when the content is rebroadcast, syndicated, or distributed on secondary platforms.',
    `streaming_metadata_flag` BOOLEAN COMMENT 'Indicates whether this credit should be included in streaming platform metadata (e.g., Netflix, Hulu, Disney+) for title cards and cast/crew information.',
    `updated_by` STRING COMMENT 'The user or system identifier that last modified this credit attribution record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this credit attribution record was last modified.',
    `created_by` STRING COMMENT 'The user or system identifier that created this credit attribution record.',
    CONSTRAINT pk_credit_attribution PRIMARY KEY(`credit_attribution_id`)
) COMMENT 'Defines the on-screen and promotional credit entitlements for each talent on a specific production or content asset — capturing credit type (main title, end title, possessory credit, and credit, with credit), billing position (first position, second position, alphabetical), credit card size relative to title card, credit placement (opening, closing, both), contractually mandated credit language, and any approved credit waivers. Feeds EPG metadata, digital asset packaging, and streaming platform title cards. Governed by DGA, WGA, and SAG-AFTRA credit determination rules.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` (
    `residual_payment_id` BIGINT COMMENT 'Unique identifier for the residual payment transaction.',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Residual payment reconciliation: residual_payment tracks the talent-domain disbursement record while billing.payment tracks the actual financial transaction. Media broadcasting finance teams reconcile',
    `carriage_agreement_id` BIGINT COMMENT 'Foreign key linking to distribution.carriage_agreement. Business justification: Cable and satellite retransmission residuals (required under WGA, SAG-AFTRA CBAs) are calculated per carriage agreement. Linking residual payments to the specific carriage agreement enables per-agreem',
    `contract_id` BIGINT COMMENT 'Reference to the talent contract governing this residual payment.',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Residual payments for new media and streaming windows are calculated based on distribution agreement terms (SVOD, AVOD, TVOD windows). Guild audit reports require tracing residuals to the specific dis',
    `guild_affiliation_id` BIGINT COMMENT 'Foreign key linking to talent.guild_affiliation. Business justification: Residual payments are governed by guild/union Collective Bargaining Agreements (CBAs). The guild_affiliation record contains the authoritative cba_version, cba_effective_date, cba_expiration_date, res',
    `playout_event_id` BIGINT COMMENT 'Foreign key linking to scheduling.playout_event. Business justification: Residual calculations are triggered by actual transmissions. Linking payments to specific playout events provides audit trail for exhibition dates, territories, transmission types, and usage required ',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Residual calculations for episodic talent (actors, directors, writers) are computed per episode for reruns, streaming, and syndication. Guild reporting and payment processing require episode-level gra',
    `project_id` BIGINT COMMENT 'Foreign key linking to production.project. Business justification: Residual payments triggered by content licensing deals (SVOD/AVOD distribution). Real business process: when content is licensed via sales deal, residuals calculated based on deals distribution metri',
    `release_window_id` BIGINT COMMENT 'Foreign key linking to distribution.release_window. Business justification: Guild residual calculation (SAG-AFTRA, WGA) requires linking each payment to the specific release window (theatrical, SVOD, AVOD) that triggered it. Residual rates differ by window type. The plain-tex',
    `representation_agreement_id` BIGINT COMMENT 'Foreign key linking to talent.representation_agreement. Business justification: Residual payments are routed through talent agencies based on the active representation agreement (representation_agreement.residual_routing_flag). The agent_commission_amount on residual_payment is c',
    `role_id` BIGINT COMMENT 'Foreign key linking to talent.role. Business justification: Residual payments are calculated based on the specific role a talent performed — the role determines the residual_rate_code, usage_rights_media, and usage_rights_territory that govern the payment calc',
    `syndication_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.syndication_agreement. Business justification: Guild-mandated residual payment calculation (SAG-AFTRA, WGA) requires tracing which syndication agreement triggered the exhibition event. Residual rates and use-type classifications are determined by ',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent receiving the residual payment.',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: SAG-AFTRA/WGA residual reporting requires direct linkage between a residual payment and the specific title whose reuse triggered it. Residual auditors and guild compliance officers need title-level tr',
    `ach_trace_number` STRING COMMENT 'The ACH trace number if the payment method is ACH or direct deposit, used for reconciliation and audit.',
    `agent_commission_amount` DECIMAL(18,2) COMMENT 'The agent or manager commission amount deducted from the residual payment, if applicable.',
    `audit_report_date` DATE COMMENT 'The date on which this residual payment was included in a guild audit report.',
    `audit_report_flag` BOOLEAN COMMENT 'Indicates whether this residual payment has been included in a guild audit report (SAG-AFTRA, WGA, DGA).',
    `check_number` STRING COMMENT 'The check number if the payment method is check, used for reconciliation and audit.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this residual payment record was first created in the system.',
    `exhibition_end_date` DATE COMMENT 'The end date of the exhibition period for which this residual is calculated.',
    `exhibition_start_date` DATE COMMENT 'The start date of the exhibition period for which this residual is calculated.',
    `gross_residual_amount` DECIMAL(18,2) COMMENT 'The gross residual amount calculated before deductions, in the payment currency.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The net residual payment amount after all deductions, paid to the talent.',
    `payment_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the residual payment (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `payment_date` DATE COMMENT 'The date on which the residual payment was issued or disbursed to the talent.',
    `payment_method` STRING COMMENT 'The method used to disburse the residual payment to the talent.. Valid values are `check|ACH|wire_transfer|direct_deposit|payroll`',
    `payment_notes` STRING COMMENT 'Free-text notes or comments related to this residual payment, including special circumstances, adjustments, or exceptions.',
    `payment_number` STRING COMMENT 'Business identifier for the residual payment, used for external reference and reconciliation.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the residual payment transaction.. Valid values are `pending|approved|processed|paid|cancelled|on_hold`',
    `pension_health_amount` DECIMAL(18,2) COMMENT 'The pension and health contribution amount deducted from the gross residual, as required by guild agreements.',
    `remittance_advice_sent_date` DATE COMMENT 'The date on which the remittance advice was sent to the talent.',
    `remittance_advice_sent_flag` BOOLEAN COMMENT 'Indicates whether a remittance advice document was sent to the talent for this payment.',
    `royalty_calculation_reference` BIGINT COMMENT 'Reference to the Rightsline royalty calculation record that generated this residual payment.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this residual payment record was last modified.',
    `use_type` STRING COMMENT 'The type of content reuse triggering the residual payment (broadcast, cable, SVOD, AVOD, TVOD, FAST, home video, foreign distribution, theatrical). [ENUM-REF-CANDIDATE: broadcast|cable|SVOD|AVOD|TVOD|FAST|home_video|foreign|theatrical — 9 candidates stripped; promote to reference product]',
    `wire_reference_number` STRING COMMENT 'The wire transfer reference number if the payment method is wire transfer, used for reconciliation and audit.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The tax amount withheld from the residual payment for federal, state, or foreign tax obligations.',
    CONSTRAINT pk_residual_payment PRIMARY KEY(`residual_payment_id`)
) COMMENT 'Transactional record of each residual payment issued to talent for reuse of content across broadcast, home video, streaming (SVOD, AVOD, TVOD), FAST, and foreign distribution windows. Captures payment cycle, content asset reference, use type, distribution window, gross residual amount, P&H contribution amount, withholding tax amount, net payment amount, payment method, payment date, check or ACH reference, and remittance advice sent flag. Reconciles against Rightsline royalty calculations and SAP S/4HANA AP postings. Supports SAG-AFTRA and WGA audit requirements.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` (
    `deal_memo_id` BIGINT COMMENT 'Unique identifier for the talent deal memo record. Primary key.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Deal memo advance invoicing: deal memos frequently trigger advance or signing-bonus invoices before the long-form contract is executed. Billing teams in media broadcasting must trace which invoice was',
    `billing_account_id` BIGINT COMMENT 'The Salesforce Media Cloud opportunity or proposal record identifier from which this deal memo was generated.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: In AFP and branded content deals, the talent deal memo is directly funded by a specific advertiser campaign. Linking deal_memo to campaign enables campaign budget reconciliation against talent costs, ',
    `coproduction_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.coproduction_agreement. Business justification: Co-production deal memos must reference the co-production agreement to enforce credit obligations, compensation caps, and residuals-sharing formulas. Without this link, deal memo terms cannot be valid',
    `contract_id` BIGINT COMMENT 'Reference to the executed long-form talent contract that supersedes this deal memo. Null if the long-form contract has not yet been executed.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Talent deal memos in streaming-era broadcasting are frequently platform-specific (e.g., a Netflix exclusive deal memo, an Apple TV+ first-look deal). Deal memos precede formal contracts and must refer',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Deal memos reference the commissioning partner entity (studio, network, streamer) for deal tracking and relationship management. Critical for converting deal memos to long-form contracts and tracking ',
    `title_id` BIGINT COMMENT 'Reference to the production title (series, episode, film, special) for which the talent is engaged.',
    `role_id` BIGINT COMMENT 'Foreign key linking to talent.role. Business justification: A deal memo captures the agreed commercial terms for a talent engagement in a specific role. The role_function string on deal_memo is a denormalized description of the role being engaged. Once the for',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Season-level deal memos are standard in TV production — talent is frequently contracted for a specific season (e.g., series regular for Season 3 only). deal_memo already links to series but not season',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Deal memos for episodic content reference series for series commitment tracking, multi-season option terms, and episode count guarantees. Essential for TV talent deal management.',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent (actor, director, writer, producer, host, correspondent, crew member) engaged under this deal memo.',
    `agent_contact_email` STRING COMMENT 'Primary email address of the talent agent or representative for deal-related communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `agent_contact_phone` STRING COMMENT 'Primary phone number of the talent agent or representative for deal-related communication.',
    `agent_name` STRING COMMENT 'Name of the talent agent or representative who negotiated the deal memo on behalf of the talent.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'The primary monetary compensation amount agreed in the deal memo (e.g., total fee, per-episode rate, or guaranteed minimum).',
    `compensation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `compensation_summary` STRING COMMENT 'High-level summary of the compensation structure agreed in the deal memo (e.g., per-episode fee, flat fee, day rate, backend participation). Detailed breakdowns are captured in the long-form contract.',
    `countersigned_date` DATE COMMENT 'The date on which the deal memo was countersigned by both the talent (or agent) and the production company, making it a binding interim agreement. Null if not yet countersigned.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the deal memo record was first created in the system.',
    `credit_position` STRING COMMENT 'The agreed on-screen or off-screen credit position and format (e.g., Main Title Card, Opening Credits, End Crawl, Shared Card, Single Card).',
    `deal_date` DATE COMMENT 'The date on which the deal terms were verbally agreed or the deal memo was initially drafted.',
    `deal_memo_number` STRING COMMENT 'Externally-known unique business identifier for the deal memo, typically generated by the CRM or legal system.. Valid values are `^DM-[0-9]{6,10}$`',
    `deal_memo_status` STRING COMMENT 'Current lifecycle status of the deal memo: draft (under negotiation), countersigned (binding interim agreement), superseded_by_long_form (replaced by executed contract), expired (lapsed without execution), cancelled (deal fell through).. Valid values are `draft|countersigned|superseded_by_long_form|expired|cancelled`',
    `effective_date` DATE COMMENT 'The date on which the deal memo becomes binding (typically the date of countersignature by both parties).',
    `engagement_end_date` DATE COMMENT 'The date on which the talent engagement is scheduled to end. Null for open-ended or option-based engagements.',
    `engagement_start_date` DATE COMMENT 'The date on which the talent engagement is scheduled to begin (first day of work, rehearsal, or availability).',
    `episode_count` STRING COMMENT 'Number of episodes or production units covered by this deal memo. Null if the engagement is for a single film or special.',
    `exclusivity_summary` STRING COMMENT 'High-level summary of exclusivity terms (e.g., exclusive to network during production, non-exclusive, first-look, holdback period). Detailed clauses are in the long-form contract.',
    `expiration_date` DATE COMMENT 'The date by which the deal memo must be superseded by a long-form contract or it will expire. Null if no expiration is set.',
    `guild_affiliation` STRING COMMENT 'The guild or union to which the talent belongs: SAG-AFTRA (Screen Actors Guild - American Federation of Television and Radio Artists), DGA (Directors Guild of America), WGA (Writers Guild of America), IATSE (International Alliance of Theatrical Stage Employees), or non_union.. Valid values are `SAG-AFTRA|DGA|WGA|IATSE|non_union`',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified the deal memo record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the deal memo record was last modified in the system.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special provisions, or negotiation history relevant to the deal memo.',
    `option_terms` STRING COMMENT 'Summary of any option clauses (e.g., network option for additional seasons, talent option to extend, mutual option). Null if no options are included.',
    `residual_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the talent is eligible for residual payments under guild agreements for reuse, syndication, or secondary distribution. True if eligible, False otherwise.',
    `superseded_date` DATE COMMENT 'The date on which the deal memo was superseded by the execution of a long-form contract. Null if not yet superseded.',
    CONSTRAINT pk_deal_memo PRIMARY KEY(`deal_memo_id`)
) COMMENT 'Pre-contract deal memo capturing the agreed commercial terms for a talent engagement before the formal long-form contract is executed — including deal date, production title, role or function, episode count, start date, compensation summary, credit position, exclusivity summary, option terms, and deal memo status (draft, countersigned, superseded by long-form). Serves as the binding interim agreement used by production and legal teams during the gap between verbal deal and executed contract. Sourced from Salesforce Media Cloud opportunity and proposal records.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`role` (
    `role_id` BIGINT COMMENT 'Unique identifier for the talent role assignment. Primary key for the talent role entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: In advertiser-funded programming (AFP), a campaign directly commissions specific talent roles (e.g., brand spokesperson, host). Linking role to campaign enables AFP budget tracking, campaign performan',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Episode-specific role assignments (guest star in episode 5, day player) are a fundamental casting and guild reporting concept. role already links to season/series/title but not episode. Guild residual',
    `contract_id` BIGINT COMMENT 'Reference to the talent contract governing the terms of this role engagement, including compensation, usage rights, and obligations.',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent individual performing this role. Links to the talent master entity.',
    `above_the_line_flag` BOOLEAN COMMENT 'Indicates whether this role is classified as above-the-line (creative principals: actors, directors, writers, producers) or below-the-line (technical crew and support staff). Impacts budget allocation and residual calculations.',
    `appearance_count` STRING COMMENT 'Total number of episodes, segments, or appearances in which this talent role is featured. Used for episodic and recurring roles.',
    `billing_position` STRING COMMENT 'The numerical order in which the talent appears in the credits (1 = first billed, 2 = second billed, etc.). Determines prominence in marketing materials and on-screen credits.',
    `role_category` STRING COMMENT 'Classification of the role type indicating the nature and scope of the talents engagement. Determines compensation structure, credit placement, and residual eligibility. [ENUM-REF-CANDIDATE: series_regular|recurring|guest_star|day_player|featured_extra|host|correspondent|narrator|voice_artist|director|writer|showrunner|executive_producer|line_producer|cinematographer|editor|composer|production_designer|costume_designer|makeup_artist|stunt_coordinator|other — promote to reference product]',
    `character_name` STRING COMMENT 'The name of the character portrayed by the talent for on-screen roles. Null for off-screen roles such as crew, directors, or producers.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'The monetary compensation amount for this role engagement in the contract currency. Excludes residuals and backend participation.',
    `compensation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `compensation_type` STRING COMMENT 'The structure of compensation for this role (flat fee, daily rate, weekly rate, episodic fee, backend participation, royalty, deferred payment). [ENUM-REF-CANDIDATE: flat_fee|daily_rate|weekly_rate|episodic_fee|backend_participation|royalty|deferred|other — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this talent role record was first created in the system.',
    `credit_text` STRING COMMENT 'The exact text of the credit as it appears on-screen or in marketing materials, including any special formatting or possessory credits (e.g., A Film By, Created By).',
    `credit_type` STRING COMMENT 'Specifies where and how the talents credit appears in the production (opening credits, closing credits, main titles, end titles, special thanks, or no credit).. Valid values are `opening_credits|closing_credits|main_titles|end_titles|special_thanks|no_credit`',
    `end_date` DATE COMMENT 'The date on which the talents engagement for this role concludes. Null for ongoing or open-ended engagements.',
    `episode_scope_end` STRING COMMENT 'The last episode number in which this talent role appears. Null indicates ongoing engagement or single-episode appearance.',
    `episode_scope_start` STRING COMMENT 'The first episode number in which this talent role appears. Used for episodic content to define the scope of the talents engagement.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the talent is bound by exclusivity clauses preventing them from performing similar roles for competing productions during the engagement period.',
    `exclusivity_scope` STRING COMMENT 'Description of the scope and limitations of any exclusivity clause (e.g., No competing streaming series, No theatrical films during production).',
    `guild_affiliation` STRING COMMENT 'The labor union or guild under whose jurisdiction this role falls (SAG-AFTRA for actors, WGA for writers, DGA for directors, IATSE for crew). Determines minimum compensation, working conditions, and residual eligibility. [ENUM-REF-CANDIDATE: sag_aftra|wga|dga|iatse|mpeg|non_union|other — 7 candidates stripped; promote to reference product]',
    `role_name` STRING COMMENT 'The specific role or function the talent is engaged to perform (e.g., Lead Actor, Director, Executive Producer, Cinematographer, Script Supervisor).',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or contextual information about this talent role assignment (e.g., special credit requirements, scheduling constraints, performance notes).',
    `residual_eligible_flag` BOOLEAN COMMENT 'Indicates whether this role is eligible for residual payments based on subsequent distribution, reuse, or syndication of the content. Determined by guild agreements and contract terms.',
    `residual_rate_code` STRING COMMENT 'Code identifying the residual payment rate schedule applicable to this role based on guild agreements, role category, and distribution windows.',
    `role_status` STRING COMMENT 'Current lifecycle status of the talent role assignment indicating the stage of engagement from negotiation through completion. [ENUM-REF-CANDIDATE: confirmed|tentative|in_negotiation|contracted|active|completed|cancelled|suspended — 8 candidates stripped; promote to reference product]',
    `screen_time_minutes` DECIMAL(18,2) COMMENT 'Total on-screen time in minutes for this talent role across all appearances. Used for on-screen talent to measure prominence and for residual calculations.',
    `start_date` DATE COMMENT 'The date on which the talents engagement for this role begins, typically the first day of principal photography, recording, or production work.',
    `stunt_double_flag` BOOLEAN COMMENT 'Indicates whether this role involves stunt work or if a stunt double is used for this character. Impacts insurance, safety protocols, and credit attribution.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this talent role record was last modified in the system.',
    `usage_rights_duration_years` STRING COMMENT 'Number of years for which usage rights are granted. Null indicates perpetual rights.',
    `usage_rights_media` STRING COMMENT 'Media platforms and formats for which usage rights are granted (e.g., Theatrical, Home Video, Streaming, Broadcast TV).',
    `usage_rights_territory` STRING COMMENT 'Geographic territories in which the content featuring this talent role may be distributed and exploited (e.g., Worldwide, North America, USA and Canada).',
    `voice_only_flag` BOOLEAN COMMENT 'Indicates whether this is a voice-only role (voice-over, narration, animation, ADR) with no on-screen physical appearance by the talent.',
    CONSTRAINT pk_role PRIMARY KEY(`role_id`)
) COMMENT 'Defines the specific role or function a talent is engaged to perform within a production or content asset — capturing role name, character name (for on-screen talent), role category (series regular, recurring, guest star, day player, featured extra, host, correspondent, narrator, voice artist, director, writer, showrunner, executive producer, line producer, DP, editor), above-the-line or below-the-line classification, episode or segment scope, and role status. Provides the granular link between talent identity and their specific creative contribution to each content asset.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` (
    `talent_agency_id` BIGINT COMMENT 'Unique identifier for the talent agency or management company. Primary key for the talent_agency product.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Talent agencies are business partners in the media ecosystem, tracked for commission payment routing, franchise compliance verification, and strategic relationship management. Essential for partner pe',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Talent agencies are subject to state franchise and licensing regulatory obligations (e.g., California Talent Agencies Act, guild franchise rules). Compliance teams track which regulatory obligation go',
    `sales_account_id` BIGINT COMMENT 'Foreign key linking to sales.sales_account. Business justification: Talent agencies act as licensors/sellers of talent services to networks/advertisers, tracked as sales accounts for commission payments, contract management, and revenue recognition. Real business proc',
    `address_line_1` STRING COMMENT 'The first line of the agencys primary business address, typically containing street number and street name.',
    `address_line_2` STRING COMMENT 'The second line of the agencys primary business address, typically containing suite, floor, or building information.',
    `agency_type` STRING COMMENT 'Classification of the representation entity: talent agency (licensed to procure employment), literary agency (represents writers), management company (career guidance), law firm (legal representation), publicity firm (public relations), or hybrid (multiple services).. Valid values are `talent_agency|literary_agency|management_company|law_firm|publicity_firm|hybrid`',
    `bank_account_name` STRING COMMENT 'The name on the bank account used for commission and residual payments to the agency.',
    `bank_account_number` STRING COMMENT 'The bank account number for electronic funds transfer of commissions and residuals to the agency.',
    `bank_routing_number` STRING COMMENT 'The bank routing number (ABA number in the US, sort code in UK, or equivalent) for electronic funds transfer of commissions and residuals.',
    `city` STRING COMMENT 'The city or municipality where the agencys primary office is located.',
    `country_code` STRING COMMENT 'The three-letter ISO country code for the country where the agencys primary office is located (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this talent agency record was first created in the system. Immutable audit field.',
    `dba_name` STRING COMMENT 'The trade name or doing-business-as name under which the agency operates, if different from the legal name.',
    `established_date` DATE COMMENT 'The date on which the talent agency was originally established or incorporated.',
    `fax_number` STRING COMMENT 'The fax number for the agency, used for contract transmission and official correspondence in jurisdictions where fax is still required.',
    `franchise_effective_date` DATE COMMENT 'The date on which the SAG-AFTRA franchise agreement became effective for this agency.',
    `franchise_expiration_date` DATE COMMENT 'The date on which the current SAG-AFTRA franchise agreement expires and must be renewed.',
    `franchise_number` STRING COMMENT 'The unique franchise identification number issued by SAG-AFTRA to franchised talent agencies.',
    `franchise_status` STRING COMMENT 'Indicates whether the agency holds a valid SAG-AFTRA franchise agreement, which authorizes the agency to represent union talent. Franchised agencies agree to standard commission rates and contract terms.. Valid values are `franchised|non_franchised|pending|revoked|expired`',
    `legal_name` STRING COMMENT 'The full legal registered name of the talent agency or management company as it appears on contracts and official documents.',
    `license_effective_date` DATE COMMENT 'The date on which the state talent agency license became effective.',
    `license_expiration_date` DATE COMMENT 'The date on which the state talent agency license expires and must be renewed.',
    `license_number` STRING COMMENT 'The state-issued license number authorizing the agency to operate as a talent agency. Required in jurisdictions such as California under the Talent Agencies Act.',
    `license_state` STRING COMMENT 'The state or province that issued the talent agency license. Use standard two-letter state/province codes.',
    `notes` STRING COMMENT 'Free-form notes field for additional context, special handling instructions, historical information, or relationship management details relevant to the agency.',
    `payment_terms` STRING COMMENT 'The standard payment terms and conditions for commission remittance, including timing and method of payment (e.g., net 30 days, upon talent payment receipt).',
    `postal_code` STRING COMMENT 'The postal or ZIP code for the agencys primary business address.',
    `primary_contact_name` STRING COMMENT 'The name of the primary contact person at the agency for contract negotiations, deal correspondence, and residual remittances.',
    `primary_contact_title` STRING COMMENT 'The job title or role of the primary contact person (e.g., President, Partner, Agent, Business Affairs Manager).',
    `primary_email` STRING COMMENT 'The primary email address for official correspondence, contract delivery, and residual payment notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'The primary telephone number for the agency, including country and area codes.',
    `roster_size` STRING COMMENT 'The approximate number of talent clients currently represented by the agency. Used for agency scale assessment and negotiation context.',
    `specialization` STRING COMMENT 'The primary area of talent specialization or focus for the agency (e.g., film and television actors, commercial talent, voice-over artists, writers, directors, below-the-line crew, music artists). Free-text field to accommodate multiple specializations.',
    `standard_commission_rate` DECIMAL(18,2) COMMENT 'The standard commission rate percentage that the agency charges for talent representation, typically 10% for franchised agencies under SAG-AFTRA rules. Expressed as a percentage (e.g., 10.00 for 10%).',
    `state_province` STRING COMMENT 'The state, province, or region where the agencys primary office is located. Use standard two-letter codes where applicable.',
    `status_effective_date` DATE COMMENT 'The date on which the current status became effective.',
    `talent_agency_status` STRING COMMENT 'The current operational status of the talent agency: active (currently representing talent), inactive (not currently operating), suspended (temporarily not authorized), pending_verification (under review), or dissolved (permanently closed).. Valid values are `active|inactive|suspended|pending_verification|dissolved`',
    `tax_identifier` STRING COMMENT 'The tax identification number (EIN in the US, VAT number in EU) for the agency, used for tax reporting and residual payment processing.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this talent agency record was last modified. Updated automatically on any change to the record.',
    `verification_date` DATE COMMENT 'The date on which the agency information was last verified for accuracy and currency, typically through direct contact or regulatory registry check.',
    `website_url` STRING COMMENT 'The primary website URL for the talent agency, used for public information and talent roster visibility.',
    CONSTRAINT pk_talent_agency PRIMARY KEY(`talent_agency_id`)
) COMMENT 'Master record for talent representation agencies and management companies — capturing agency legal name, agency type (talent agency, literary agency, management company, law firm), primary contact, address, phone, email, franchise status (SAG-AFTRA franchised agency flag), commission rate standard, and active/inactive status. Serves as the reference for routing deal negotiations, contract correspondence, and residual remittances to the correct representative. Distinct from the partner domain which manages distribution and content partners.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` (
    `representation_agreement_id` BIGINT COMMENT 'Unique identifier for the representation agreement record. Primary key.',
    `talent_agency_id` BIGINT COMMENT 'Foreign key linking to talent.talent_agency. Business justification: representation_agreement currently has agency_name (STRING) duplicating data from talent_agency. Adding FK enables normalization - agency legal name, DBA name, contact details, and franchise status sh',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent being represented under this agreement.',
    `agent_contact_email` STRING COMMENT 'Primary email address for the agent or representative, used for deal negotiation and residual routing communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `agent_contact_phone` STRING COMMENT 'Primary phone number for the agent or representative.',
    `agent_name` STRING COMMENT 'Full name of the individual agent, manager, or attorney assigned as primary contact for this representation.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for this representation agreement, used for contract reference and audit trails.',
    `commission_cap_amount` DECIMAL(18,2) COMMENT 'Maximum commission amount per engagement or per year, if a cap is specified in the agreement. Null if no cap applies.',
    `commission_percentage` DECIMAL(18,2) COMMENT 'Percentage of talent earnings paid to the representative as commission (typically 10% for agents, 15% for managers per industry standards).',
    `contract_document_uri` STRING COMMENT 'URI or file path to the signed representation agreement contract document stored in the Media Asset Management (MAM) system or document repository.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this representation agreement record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the representation agreement expires or terminates. Null for open-ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the representation agreement becomes binding and the representative begins acting on behalf of the talent.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this representation is exclusive (true) or non-exclusive (false). Exclusive agreements prohibit the talent from engaging other representatives in the same category and territory.',
    `guild_franchise_flag` BOOLEAN COMMENT 'Indicates whether the agency or representative is franchised by a talent guild (SAG-AFTRA, WGA, DGA). Franchised agents must comply with guild-mandated commission caps and contract terms.',
    `notes` STRING COMMENT 'Free-text notes capturing special clauses, amendments, or contextual information about the representation agreement.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes an automatic renewal option or requires explicit renegotiation at expiration.',
    `renewal_terms` STRING COMMENT 'Description of renewal terms if renewal_option_flag is true, including renewal period length and any modified commission rates.',
    `representation_agreement_status` STRING COMMENT 'Current lifecycle status of the representation agreement: active (in force), expired (end date reached), terminated (ended early by either party), suspended (temporarily inactive), or pending (signed but not yet effective).. Valid values are `active|expired|terminated|suspended|pending`',
    `representation_type` STRING COMMENT 'Classification of the representation relationship: exclusive agent (sole representation), co-agent (shared representation), manager (career management), entertainment attorney (legal counsel), business manager (financial management), or publicist (public relations).. Valid values are `exclusive_agent|co_agent|manager|entertainment_attorney|business_manager|publicist`',
    `residual_routing_flag` BOOLEAN COMMENT 'Indicates whether residual payments for work performed during this representation period should be routed through this representative for commission deduction.',
    `scope_of_services` STRING COMMENT 'Detailed description of services the representative will provide: deal negotiation, career guidance, audition scheduling, contract review, brand partnerships, etc.',
    `signing_date` DATE COMMENT 'Date when the representation agreement was signed by both parties.',
    `termination_date` DATE COMMENT 'Actual date the representation agreement was terminated, if applicable. Used for residual routing cutoff and historical audit trails.',
    `termination_notice_period_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the representation agreement (commonly 30, 60, or 90 days).',
    `termination_reason` STRING COMMENT 'Reason for early termination of the representation agreement, if applicable. [ENUM-REF-CANDIDATE: mutual_agreement|talent_initiated|agent_initiated|breach_of_contract|expiration|non_performance|conflict_of_interest — 7 candidates stripped; promote to reference product]',
    `territory_scope` STRING COMMENT 'Geographic territory or market scope covered by this representation agreement (e.g., worldwide, North America, USA, specific states). Multiple territories may be comma-separated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this representation agreement record was last modified.',
    CONSTRAINT pk_representation_agreement PRIMARY KEY(`representation_agreement_id`)
) COMMENT 'Records the formal representation relationship between a talent and their agency or management company — capturing representation type (exclusive agent, co-agent, manager, entertainment attorney), territory scope, commission percentage, agreement start and end dates, exclusivity flag, termination notice period, and current status. Tracks historical representation changes to support residual routing and deal negotiation audit trails. A talent may have multiple concurrent representation agreements across different territories or function types.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ADD CONSTRAINT `fk_talent_talent_profile_talent_agency_id` FOREIGN KEY (`talent_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_agency`(`talent_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ADD CONSTRAINT `fk_talent_guild_affiliation_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_representation_agreement_id` FOREIGN KEY (`representation_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`representation_agreement`(`representation_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ADD CONSTRAINT `fk_talent_compensation_structure_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ADD CONSTRAINT `fk_talent_compensation_structure_guild_affiliation_id` FOREIGN KEY (`guild_affiliation_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation`(`guild_affiliation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ADD CONSTRAINT `fk_talent_compensation_structure_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`role`(`role_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_rescheduled_from_appearance_schedule_id` FOREIGN KEY (`rescheduled_from_appearance_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule`(`appearance_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`role`(`role_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ADD CONSTRAINT `fk_talent_credit_attribution_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ADD CONSTRAINT `fk_talent_credit_attribution_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`role`(`role_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ADD CONSTRAINT `fk_talent_credit_attribution_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_guild_affiliation_id` FOREIGN KEY (`guild_affiliation_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation`(`guild_affiliation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_representation_agreement_id` FOREIGN KEY (`representation_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`representation_agreement`(`representation_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`role`(`role_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`role`(`role_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ADD CONSTRAINT `fk_talent_representation_agreement_talent_agency_id` FOREIGN KEY (`talent_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_agency`(`talent_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ADD CONSTRAINT `fk_talent_representation_agreement_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`talent` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`talent` SET TAGS ('dbx_domain' = 'talent');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` SET TAGS ('dbx_subdomain' = 'workforce_identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Agency Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `biometric_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Biometric Data Consent Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `biometric_consent_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `biometric_consent_flag` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `clearance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Talent Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|restricted|blocked|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `exclusivity_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Clause Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `gdpr_consent_status` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `gdpr_consent_status` SET TAGS ('dbx_value_regex' = 'consented|withdrawn|not_applicable|pending');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_business_glossary_term' = 'Gender Identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say|other');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `imdb_identifier` SET TAGS ('dbx_business_glossary_term' = 'Internet Movie Database (IMDb) Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `imdb_identifier` SET TAGS ('dbx_value_regex' = '^nm[0-9]{7,8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `insurance_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `isni_code` SET TAGS ('dbx_business_glossary_term' = 'International Standard Name Identifier (ISNI) Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `isni_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4} [0-9]{4} [0-9]{4} [0-9]{3}[0-9X]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Full Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Nationality Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `nationality` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|retired|deceased');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Payment Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `stage_name` SET TAGS ('dbx_business_glossary_term' = 'Stage Name or Professional Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_tier` SET TAGS ('dbx_business_glossary_term' = 'Talent Tier Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_tier` SET TAGS ('dbx_value_regex' = 'a_list|b_list|c_list|emerging|supporting|background');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_type` SET TAGS ('dbx_business_glossary_term' = 'Talent Type or Role Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union or Guild Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_value_regex' = 'sag_aftra|wga|dga|iatse|non_union|multiple');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `union_member_number` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `union_member_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `union_member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_value_regex' = 'citizen|permanent_resident|work_visa|pending|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `work_visa_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Work Visa Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `work_visa_type` SET TAGS ('dbx_business_glossary_term' = 'Work Visa Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` SET TAGS ('dbx_subdomain' = 'workforce_identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `cba_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `cba_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `cba_version` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `dues_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Dues Payment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `dues_payment_status` SET TAGS ('dbx_value_regex' = 'current|overdue|delinquent|exempt|waived');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `guild_code` SET TAGS ('dbx_business_glossary_term' = 'Guild Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `guild_name` SET TAGS ('dbx_business_glossary_term' = 'Guild Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `health_benefits_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Benefits Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `health_benefits_eligible_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `health_benefits_eligible_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `join_date` SET TAGS ('dbx_business_glossary_term' = 'Guild Join Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Guild Jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `last_dues_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dues Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `local_chapter` SET TAGS ('dbx_business_glossary_term' = 'Local Chapter');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `membership_number` SET TAGS ('dbx_business_glossary_term' = 'Membership Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `membership_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `membership_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'good_standing|suspended|resigned|expelled|inactive|pending');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `membership_tier` SET TAGS ('dbx_business_glossary_term' = 'Membership Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `membership_tier` SET TAGS ('dbx_value_regex' = 'full_member|fi_core|apprentice|honorary|lifetime|emeritus');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `next_dues_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Dues Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `pension_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Pension Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Guild Membership Termination Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Verification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'api|manual|document|self_reported|third_party');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` SET TAGS ('dbx_subdomain' = 'engagement_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `coproduction_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Coproduction Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `representation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Representation Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `backend_participation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Backend Participation Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `backend_participation_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `backend_participation_type` SET TAGS ('dbx_business_glossary_term' = 'Backend Participation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `backend_participation_type` SET TAGS ('dbx_value_regex' = 'net_profits|adjusted_gross|gross_receipts|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `base_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Compensation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `base_compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `billing_credit_position` SET TAGS ('dbx_business_glossary_term' = 'Billing Credit Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_value_regex' = 'flat_fee|per_episode|weekly_rate|annual_salary|day_rate|hourly_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Lifecycle Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `credit_placement_requirements` SET TAGS ('dbx_business_glossary_term' = 'Credit Placement Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `credit_size_percentage` SET TAGS ('dbx_business_glossary_term' = 'Credit Size Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `document_reference_uri` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference Uniform Resource Identifier (URI)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `document_reference_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `engagement_role` SET TAGS ('dbx_business_glossary_term' = 'Engagement Role');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Clause Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `governing_cba` SET TAGS ('dbx_business_glossary_term' = 'Governing Collective Bargaining Agreement (CBA)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `guaranteed_episodes` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Episode Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_value_regex' = 'SAG-AFTRA|WGA|DGA|IATSE|non_union|multiple');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `option_exercise_deadline` SET TAGS ('dbx_business_glossary_term' = 'Option Exercise Deadline Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `option_exercise_status` SET TAGS ('dbx_business_glossary_term' = 'Option Exercise Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `option_exercise_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|exercised|declined|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `option_periods_count` SET TAGS ('dbx_business_glossary_term' = 'Option Periods Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `pay_or_play_flag` SET TAGS ('dbx_business_glossary_term' = 'Pay-or-Play Clause Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_business_glossary_term' = 'Step-Up Compensation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` SET TAGS ('dbx_subdomain' = 'engagement_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Role Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `backend_gross_participation_pct` SET TAGS ('dbx_business_glossary_term' = 'Backend Gross Participation Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `backend_gross_participation_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `base_episode_fee` SET TAGS ('dbx_business_glossary_term' = 'Base Episode Fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `base_episode_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `bonus_threshold_description` SET TAGS ('dbx_business_glossary_term' = 'Bonus Threshold Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `daily_rate` SET TAGS ('dbx_business_glossary_term' = 'Daily Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `daily_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Compensation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_payment_trigger` SET TAGS ('dbx_business_glossary_term' = 'Deferred Payment Trigger');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `exclusivity_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Clause Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Multiplier');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pay_or_play_flag` SET TAGS ('dbx_business_glossary_term' = 'Pay-or-Play Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pension_health_rate` SET TAGS ('dbx_business_glossary_term' = 'Pension and Health (P&H) Contribution Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pension_health_rate` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pension_health_rate` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `residual_base_formula` SET TAGS ('dbx_business_glossary_term' = 'Residual Base Formula');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_business_glossary_term' = 'Step-Up Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `step_up_trigger` SET TAGS ('dbx_business_glossary_term' = 'Step-Up Trigger');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `structure_name` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `structure_status` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `structure_status` SET TAGS ('dbx_value_regex' = 'draft|active|amended|superseded|terminated');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `usage_rights_scope` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `weekly_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Weekly Guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `weekly_guarantee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` SET TAGS ('dbx_subdomain' = 'performance_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `appearance_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Appearance Schedule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Appearance Invoice Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Program Schedule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `rescheduled_from_appearance_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rescheduled From Appearance Schedule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Role Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `sweeps_period_id` SET TAGS ('dbx_business_glossary_term' = 'Sweeps Period Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `actual_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration in Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `appearance_type` SET TAGS ('dbx_business_glossary_term' = 'Appearance Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `availability_window_end` SET TAGS ('dbx_business_glossary_term' = 'Availability Window End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `availability_window_start` SET TAGS ('dbx_business_glossary_term' = 'Availability Window Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `booking_reference` SET TAGS ('dbx_business_glossary_term' = 'Booking Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `booking_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `call_date` SET TAGS ('dbx_business_glossary_term' = 'Call Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `call_time` SET TAGS ('dbx_business_glossary_term' = 'Call Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|cancelled|rescheduled|completed|no_show');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration in Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `exclusivity_conflict_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Conflict Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `guild_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Guild Notification Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `guild_notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Guild Notification Sent Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `hold_level` SET TAGS ('dbx_business_glossary_term' = 'Hold Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `hold_level` SET TAGS ('dbx_value_regex' = 'confirmed|first_hold|second_hold|third_hold|first_refusal|tentative');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `playout_system_sync_status` SET TAGS ('dbx_business_glossary_term' = 'Playout System Sync Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `playout_system_sync_status` SET TAGS ('dbx_value_regex' = 'not_synced|pending|synced|sync_failed');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `playout_system_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Playout System Sync Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `release_tracking_status` SET TAGS ('dbx_business_glossary_term' = 'Release Tracking Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `release_tracking_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|obtained|expired|declined');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `scheduling_notes` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `unavailability_reason` SET TAGS ('dbx_business_glossary_term' = 'Unavailability Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `wrap_time` SET TAGS ('dbx_business_glossary_term' = 'Wrap Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` SET TAGS ('dbx_subdomain' = 'engagement_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `credit_attribution_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Attribution ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `coproduction_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Coproduction Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Role Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `billing_block` SET TAGS ('dbx_business_glossary_term' = 'Billing Block');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `billing_block` SET TAGS ('dbx_value_regex' = 'above_title|title_card|opening_sequence|closing_sequence|end_crawl|promotional');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `billing_position` SET TAGS ('dbx_business_glossary_term' = 'Billing Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `card_size_percentage` SET TAGS ('dbx_business_glossary_term' = 'Card Size Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `credit_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `credit_approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|disputed|waived');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `credit_determination_method` SET TAGS ('dbx_business_glossary_term' = 'Credit Determination Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `credit_determination_method` SET TAGS ('dbx_value_regex' = 'contractual|guild_arbitration|mutual_agreement|statutory');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `credit_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Credit Duration Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `credit_format` SET TAGS ('dbx_business_glossary_term' = 'Credit Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `credit_format` SET TAGS ('dbx_value_regex' = 'single_card|shared_card|alphabetical|separate_card');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `credit_notes` SET TAGS ('dbx_business_glossary_term' = 'Credit Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `credit_placement` SET TAGS ('dbx_business_glossary_term' = 'Credit Placement');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `credit_placement` SET TAGS ('dbx_value_regex' = 'opening|closing|both|promotional_only');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `credit_source_system` SET TAGS ('dbx_business_glossary_term' = 'Credit Source System');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `credit_text` SET TAGS ('dbx_business_glossary_term' = 'Credit Text');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `credit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `credit_waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Waiver Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `credit_waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Waiver Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `epg_display_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Program Guide (EPG) Display Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `possessory_credit_flag` SET TAGS ('dbx_business_glossary_term' = 'Possessory Credit Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `promotional_materials_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Materials Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `pseudonym` SET TAGS ('dbx_business_glossary_term' = 'Pseudonym');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `streaming_metadata_flag` SET TAGS ('dbx_business_glossary_term' = 'Streaming Metadata Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` SET TAGS ('dbx_subdomain' = 'performance_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `residual_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Residual Payment ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Payment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `playout_event_id` SET TAGS ('dbx_business_glossary_term' = 'Playout Event Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Content License Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `release_window_id` SET TAGS ('dbx_business_glossary_term' = 'Release Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `representation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Representation Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Role Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_business_glossary_term' = 'Automated Clearing House (ACH) Trace Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `agent_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Agent Commission Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `audit_report_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `audit_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `exhibition_end_date` SET TAGS ('dbx_business_glossary_term' = 'Exhibition End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `exhibition_start_date` SET TAGS ('dbx_business_glossary_term' = 'Exhibition Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `gross_residual_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Residual Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|ACH|wire_transfer|direct_deposit|payroll');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|processed|paid|cancelled|on_hold');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `pension_health_amount` SET TAGS ('dbx_business_glossary_term' = 'Pension and Health (P&H) Contribution Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `pension_health_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `pension_health_amount` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `remittance_advice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Sent Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `remittance_advice_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Sent Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `royalty_calculation_reference` SET TAGS ('dbx_business_glossary_term' = 'Royalty Calculation ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `use_type` SET TAGS ('dbx_business_glossary_term' = 'Use Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `wire_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Wire Transfer Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` SET TAGS ('dbx_subdomain' = 'engagement_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Deal Memo ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Advance Invoice Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Source Opportunity ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `coproduction_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Coproduction Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Long-Form Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Production Title ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Role Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Agent Contact Email');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Agent Contact Phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `agent_name` SET TAGS ('dbx_business_glossary_term' = 'Agent Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_summary` SET TAGS ('dbx_business_glossary_term' = 'Compensation Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `countersigned_date` SET TAGS ('dbx_business_glossary_term' = 'Countersigned Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `credit_position` SET TAGS ('dbx_business_glossary_term' = 'Credit Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Deal Memo Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_number` SET TAGS ('dbx_value_regex' = '^DM-[0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_status` SET TAGS ('dbx_business_glossary_term' = 'Deal Memo Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_status` SET TAGS ('dbx_value_regex' = 'draft|countersigned|superseded_by_long_form|expired|cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Memo Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `episode_count` SET TAGS ('dbx_business_glossary_term' = 'Episode Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `exclusivity_summary` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `exclusivity_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Memo Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_value_regex' = 'SAG-AFTRA|DGA|WGA|IATSE|non_union');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deal Memo Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `option_terms` SET TAGS ('dbx_business_glossary_term' = 'Option Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `option_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Superseded Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` SET TAGS ('dbx_subdomain' = 'workforce_identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Role ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `above_the_line_flag` SET TAGS ('dbx_business_glossary_term' = 'Above-The-Line Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `appearance_count` SET TAGS ('dbx_business_glossary_term' = 'Appearance Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `billing_position` SET TAGS ('dbx_business_glossary_term' = 'Billing Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_category` SET TAGS ('dbx_business_glossary_term' = 'Role Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `character_name` SET TAGS ('dbx_business_glossary_term' = 'Character Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `credit_text` SET TAGS ('dbx_business_glossary_term' = 'Credit Text');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `credit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `credit_type` SET TAGS ('dbx_value_regex' = 'opening_credits|closing_credits|main_titles|end_titles|special_thanks|no_credit');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Role End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `episode_scope_end` SET TAGS ('dbx_business_glossary_term' = 'Episode Scope End');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `episode_scope_start` SET TAGS ('dbx_business_glossary_term' = 'Episode Scope Start');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_name` SET TAGS ('dbx_business_glossary_term' = 'Role Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Role Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `residual_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `residual_rate_code` SET TAGS ('dbx_business_glossary_term' = 'Residual Rate Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_status` SET TAGS ('dbx_business_glossary_term' = 'Role Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `screen_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Screen Time Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Role Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `stunt_double_flag` SET TAGS ('dbx_business_glossary_term' = 'Stunt Double Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_duration_years` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Duration Years');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_media` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Media');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_territory` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `voice_only_flag` SET TAGS ('dbx_business_glossary_term' = 'Voice Only Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` SET TAGS ('dbx_subdomain' = 'workforce_identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Agency Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_business_glossary_term' = 'Agency Type Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_value_regex' = 'talent_agency|literary_agency|management_company|law_firm|publicity_firm|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Established Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_number` SET TAGS ('dbx_business_glossary_term' = 'SAG-AFTRA Franchise Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_status` SET TAGS ('dbx_business_glossary_term' = 'SAG-AFTRA Franchise Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_status` SET TAGS ('dbx_value_regex' = 'franchised|non_franchised|pending|revoked|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Legal Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_effective_date` SET TAGS ('dbx_business_glossary_term' = 'License Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'State Talent Agency License Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_state` SET TAGS ('dbx_business_glossary_term' = 'Licensing State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agency Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `roster_size` SET TAGS ('dbx_business_glossary_term' = 'Talent Roster Size');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `specialization` SET TAGS ('dbx_business_glossary_term' = 'Agency Specialization');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `standard_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Standard Commission Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `standard_commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `status_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `talent_agency_status` SET TAGS ('dbx_business_glossary_term' = 'Agency Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `talent_agency_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_verification|dissolved');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` SET TAGS ('dbx_subdomain' = 'workforce_identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Representation Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Agency Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Agent Contact Email');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Agent Contact Phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_name` SET TAGS ('dbx_business_glossary_term' = 'Agent Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Cap Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `contract_document_uri` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Uniform Resource Identifier (URI)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `contract_document_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `guild_franchise_flag` SET TAGS ('dbx_business_glossary_term' = 'Guild Franchise Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Representation Agreement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_agreement_status` SET TAGS ('dbx_value_regex' = 'active|expired|terminated|suspended|pending');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_type` SET TAGS ('dbx_business_glossary_term' = 'Representation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_type` SET TAGS ('dbx_value_regex' = 'exclusive_agent|co_agent|manager|entertainment_attorney|business_manager|publicist');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `residual_routing_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Routing Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_business_glossary_term' = 'Scope of Services');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `signing_date` SET TAGS ('dbx_business_glossary_term' = 'Signing Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
