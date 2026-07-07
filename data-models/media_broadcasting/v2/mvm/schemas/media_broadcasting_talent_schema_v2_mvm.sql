-- Schema for Domain: talent | Business: Media_Broadcasting | Version: v2_mvm
-- Generated on: 2026-06-30 06:39:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`talent` COMMENT 'Manages all on-screen and off-screen talent relationships — actors, directors, writers, producers, hosts, correspondents, and crew. Tracks talent contracts, guild affiliations (SAG-AFTRA, WGA, DGA), residual payment eligibility, exclusivity clauses, compensation structures, usage rights, appearance schedules, and credit attribution. Serves as the authoritative source for talent identity referenced by production, rights, and royalty workflows.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` (
    `talent_profile_id` BIGINT COMMENT 'Unique identifier for the talent profile record. Primary key for the talent master entity. | Column talent_profile_id (BIGINT) in talent.talent_profile',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: In media broadcasting, talent profiles reference a demo reel or sizzle reel stored as a managed media asset. Casting directors and production teams access these reels directly from the talent profile ',
    `talent_agency_id` BIGINT COMMENT 'FK to talent.talent_agency | Column talent_agency_id (BIGINT) in talent.talent_profile',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in talent.talent_profile',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in talent.talent_profile',
    `biometric_consent_flag` BOOLEAN COMMENT 'Indicates whether the talent has provided consent for collection and use of biometric data (facial recognition, voice prints) for digital effects, deepfake prevention, and AI training. Required for GDPR and CCPA compliance. | Column biometric_consent_flag (BOOLEAN) in talent.talent_profile',
    `ccpa_opt_out_flag` BOOLEAN COMMENT 'Indicates whether the talent has opted out of the sale or sharing of their personal information under CCPA. Required for California-based talent or productions. | Column ccpa_opt_out_flag (BOOLEAN) in talent.talent_profile',
    `clearance_expiration_date` DATE COMMENT 'The date when the talents current clearance status expires and requires renewal. Used for compliance tracking and production eligibility verification. | Column clearance_expiration_date (DATE) in talent.talent_profile',
    `clearance_status` STRING COMMENT 'The current clearance status of the talent for production work. Indicates whether background checks, work authorization, insurance verification, and legal clearances are complete and current. | Column clearance_status (STRING) in talent.talent_profile. Valid values are `cleared|pending|restricted|blocked|expired`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in talent.talent_profile',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the talent profile record was first created in the system. Used for audit trail and data lineage tracking. | Column created_timestamp (TIMESTAMP) in talent.talent_profile',
    `date_of_birth` DATE COMMENT 'The talents date of birth. Required for age verification, child labor law compliance (COPPA), insurance underwriting, and residual payment calculations. | Column date_of_birth (DATE) in talent.talent_profile',
    `email_address` STRING COMMENT 'The primary email address for talent communication, contract delivery, and digital correspondence. | Column email_address (STRING) in talent.talent_profile. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `exclusivity_clause_flag` BOOLEAN COMMENT 'Indicates whether the talent is currently bound by an exclusivity clause that restricts their ability to work with competing networks, studios, or brands. Used for conflict checking during casting and booking. | Column exclusivity_clause_flag (BOOLEAN) in talent.talent_profile',
    `gdpr_consent_status` STRING COMMENT 'The current status of the talents GDPR consent for data processing. Tracks whether the talent has provided, withdrawn, or is pending consent for personal data usage under EU regulations. | Column gdpr_consent_status (STRING) in talent.talent_profile. Valid values are `consented|withdrawn|not_applicable|pending`',
    `gender_identity` STRING COMMENT 'The talents self-identified gender. Used for diversity reporting, casting analytics, and compliance with equal opportunity regulations. | Column gender_identity (STRING) in talent.talent_profile. Valid values are `male|female|non_binary|prefer_not_to_say|other`',
    `imdb_identifier` STRING COMMENT 'The talents unique identifier in the Internet Movie Database (IMDb). Used for cross-referencing filmography, public profile linking, and industry data integration. | Column imdb_identifier (STRING) in talent.talent_profile. Valid values are `^nm[0-9]{7,8}$`',
    `insurance_coverage_flag` BOOLEAN COMMENT 'Indicates whether the talent is currently covered by production insurance (liability, workers compensation, errors and omissions). Required for on-set work authorization. | Column insurance_coverage_flag (BOOLEAN) in talent.talent_profile',
    `insurance_policy_number` STRING COMMENT 'The policy number for the talents production insurance coverage. Used for claims processing and certificate of insurance verification. | Column insurance_policy_number (STRING) in talent.talent_profile',
    `isni_code` STRING COMMENT 'The International Standard Name Identifier (ISNI) for the talent. A globally unique identifier for creators used in rights management and royalty distribution systems. | Column isni_code (STRING) in talent.talent_profile. Valid values are `^[0-9]{4} [0-9]{4} [0-9]{4} [0-9]{3}[0-9X]$`',
    `legal_name` STRING COMMENT 'The full legal name of the talent as it appears on official documents and contracts. Used for contract execution, payroll, and legal compliance. | Column legal_name (STRING) in talent.talent_profile',
    `nationality` STRING COMMENT 'The talents nationality represented as a 3-letter ISO country code. Used for work authorization, tax treaty eligibility, and international co-production compliance. | Column nationality (STRING) in talent.talent_profile. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special requirements, or contextual information about the talent. Used for casting notes, production preferences, and internal communication. | Column notes (STRING) in talent.talent_profile',
    `phone_number` STRING COMMENT 'The primary contact phone number for the talent. Used for production scheduling, emergency contact, and direct communication. | Column phone_number (STRING) in talent.talent_profile',
    `primary_language` STRING COMMENT 'The talents primary working language represented as a 2-letter ISO language code. Used for casting, dubbing, and localization workflows. | Column primary_language (STRING) in talent.talent_profile. Valid values are `^[a-z]{2}$`',
    `profile_status` STRING COMMENT 'The current lifecycle status of the talent profile. Determines availability for casting, contract execution, and system access. | Column profile_status (STRING) in talent.talent_profile. Valid values are `active|inactive|suspended|retired|deceased`',
    `residual_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the talent is eligible to receive residual payments for reuse of their work in syndication, streaming, or international distribution. Determined by union status and contract terms. | Column residual_eligibility_flag (BOOLEAN) in talent.talent_profile',
    `source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in talent.talent_profile',
    `stage_name` STRING COMMENT 'The professional or stage name used by the talent for public appearances, credits, and marketing materials. May differ from legal name. | Column stage_name (STRING) in talent.talent_profile',
    `talent_tier` STRING COMMENT 'The classification tier of the talent based on industry recognition, box office draw, and compensation level. Used for budgeting, marketing strategy, and billing rate determination. | Column talent_tier (STRING) in talent.talent_profile. Valid values are `a_list|b_list|c_list|emerging|supporting|background`',
    `talent_type` STRING COMMENT 'The primary professional category or role type of the talent. Determines applicable guild rules, contract templates, and credit attribution standards. [ENUM-REF-CANDIDATE: actor|director|writer|producer|host|correspondent|crew|voice_artist|composer|cinematographer — 10 candidates stripped; promote to reference product] | Column talent_type (STRING) in talent.talent_profile',
    `tax_id_number` STRING COMMENT 'The talents tax identification number (SSN, EIN, or international equivalent). Required for payroll processing, tax withholding, and IRS 1099 reporting. | Column tax_id_number (STRING) in talent.talent_profile',
    `union_affiliation` STRING COMMENT 'The primary labor union or guild affiliation of the talent. Determines contract terms, minimum compensation, residual eligibility, and working conditions. | Column union_affiliation (STRING) in talent.talent_profile. Valid values are `sag_aftra|wga|dga|iatse|non_union|multiple`',
    `union_member_number` STRING COMMENT 'The talents membership identifier within their primary union or guild. Required for residual payment processing and contract compliance verification. | Column union_member_number (STRING) in talent.talent_profile',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in talent.talent_profile',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when the talent profile record was last modified. Used for change tracking and data freshness verification. | Column updated_timestamp (TIMESTAMP) in talent.talent_profile',
    `work_authorization_status` STRING COMMENT 'The talents current work authorization status in the primary production jurisdiction. Determines eligibility for employment and production participation. | Column work_authorization_status (STRING) in talent.talent_profile. Valid values are `citizen|permanent_resident|work_visa|pending|expired`',
    `work_visa_expiration_date` DATE COMMENT 'The expiration date of the talents work visa. Critical for production scheduling and compliance with immigration regulations. | Column work_visa_expiration_date (DATE) in talent.talent_profile',
    `work_visa_type` STRING COMMENT 'The specific type of work visa held by the talent (e.g., O-1, P-1, H-1B). Used for compliance tracking and production planning for international talent. | Column work_visa_type (STRING) in talent.talent_profile',
    CONSTRAINT pk_talent_profile PRIMARY KEY(`talent_profile_id`)
) COMMENT 'Master identity record for all on-screen and off-screen talent — actors, directors, writers, producers, hosts, correspondents, crew, and voice artists. Stores legal name, stage name, date of birth, nationality, gender identity, primary language, union membership references, talent tier classification, representation agency references, IMDb/ISNI identifiers, biometric consent flags, data privacy status (GDPR/CCPA), clearance status, and active/inactive lifecycle state. Serves as the authoritative SSOT for talent identity referenced by production, rights, royalty, and scheduling workflows across the enterprise. | Unity Catalog table: media_broadcasting_ecm.talent.talent_profile Talent/residuals entity supporting contract+compensation_structure+guild_affiliation+cba_rate_card+residual_payment flows.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` (
    `contract_id` BIGINT COMMENT 'Unique identifier for the talent contract record. Primary key for the talent contract entity. | Column contract_id (BIGINT) in talent.contract',
    `representation_agreement_id` BIGINT COMMENT 'Foreign key linking to talent.representation_agreement. Business justification: contract currently stores denormalized talent_representative_agency (STRING) and talent_representative_name (STRING) to identify the agency and agent involved in the contract negotiation. The represen',
    `royalty_rule_id` BIGINT COMMENT 'Foreign key linking to rights.royalty_rule. Business justification: Talent contracts with backend participation and residual eligibility flags must reference the governing royalty rule for consistent calculation. Direct FK enables finance teams to apply the correct ro',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Season-specific contract management — talent contracts frequently cover a single season (option exercise per season, guaranteed episode counts per season). Production legal teams track option exercise',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Talent contracts for episodic content are series-level agreements with episode guarantees, option periods, and multi-season terms. Fundamental to TV production contracting and long-form content busine | Column series_id (BIGINT) in content.contract',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent (actor, director, writer, producer, host, correspondent, crew member) engaged under this contract. | Column talent_profile_id (BIGINT) in talent.contract',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in talent.contract',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in talent.contract',
    `adjusted_gross_participation_flag` BOOLEAN COMMENT 'Indicates if talent has adjusted gross participation',
    `amendment_count` STRING COMMENT 'The total number of formal amendments made to this contract since initial execution. Tracks contract modification history. | Column amendment_count (INT) in talent.contract',
    `backend_participation_percentage` DECIMAL(18,2) COMMENT 'The percentage of net profits, adjusted gross, or other revenue streams the talent is entitled to receive after recoupment of production costs. Common for above-the-line talent. | Column backend_participation_percentage (DECIMAL(5,2)) in talent.contract',
    `backend_participation_type` STRING COMMENT 'The revenue calculation basis for backend participation. Net profits are after all costs; adjusted gross is after specific deductions; gross receipts are from first dollar. None indicates no backend participation. | Column backend_participation_type (STRING) in talent.contract. Valid values are `net_profits|adjusted_gross|gross_receipts|none`',
    `base_compensation_amount` DECIMAL(18,2) COMMENT 'The guaranteed base fee or salary payable to the talent for services rendered under this contract, excluding bonuses, backend participation, and residuals. | Column base_compensation_amount (DECIMAL(18,2)) in talent.contract',
    `billing_credit_position` STRING COMMENT 'The contractually specified position and format of the talents on-screen credit (e.g., First Position Main Title, Shared Card, Single Card, Above the Title). Critical for talent reputation and guild compliance. | Column billing_credit_position (STRING) in talent.contract',
    `compensation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the base compensation amount (e.g., USD, GBP, EUR). | Column compensation_currency (STRING) in talent.contract. Valid values are `^[A-Z]{3}$`',
    `compensation_structure` STRING COMMENT 'The payment model for the base compensation. Flat fee is a single lump sum; per-episode is paid per episode produced; weekly/annual/day/hourly rates define periodic payment schedules. | Column compensation_structure (STRING) in talent.contract. Valid values are `flat_fee|per_episode|weekly_rate|annual_salary|day_rate|hourly_rate`',
    `contingent_compensation_flag` BOOLEAN COMMENT 'Indicates if contract includes contingent compensation terms',
    `contract_number` STRING COMMENT 'Business identifier for the contract, typically assigned by legal or business affairs. Used for external reference and tracking. | Column contract_number (STRING) in talent.contract',
    `contract_status` STRING COMMENT 'Current stage of the contract in its lifecycle. Deal memo represents initial short-form agreement; countersigned indicates mutual acceptance; long-form executed is the final detailed contract; amended reflects modifications; suspended indicates temporary hold; terminated is early cancellation; expired is natural end. [ENUM-REF-CANDIDATE: deal_memo|countersigned|long_form_executed|amended|suspended|terminated|expired — 7 candidates stripped; promote to reference product] | Column contract_status (STRING) in talent.contract',
    `contract_type` STRING COMMENT 'Classification of the talent engagement type. Series regular deals cover multi-episode commitments; episodic guest agreements are single or limited appearances; overall deals provide exclusive services across multiple projects; first-look deals grant priority rights to talent-developed content; crew contracts cover technical and production staff; talent holding deals reserve talent availability; development deals fund content creation. [ENUM-REF-CANDIDATE: series_regular|episodic_guest|overall_deal|first_look_deal|crew_contract|talent_holding_deal|development_deal — 7 candidates stripped; promote to reference product] | Column contract_type (STRING) in talent.contract',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in talent.contract',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this contract record was first created in the system. | Column created_timestamp (TIMESTAMP) in talent.contract',
    `credit_placement_requirements` STRING COMMENT 'Detailed contractual requirements for credit placement, including main title vs end credits, paid advertising inclusion, promotional materials, and any special formatting or adjacency requirements. | Column credit_placement_requirements (STRING) in talent.contract',
    `credit_size_percentage` DECIMAL(18,2) COMMENT 'The minimum size of the talents on-screen credit as a percentage of the title or other reference credit size. Null if not contractually specified. | Column credit_size_percentage (DECIMAL(5,2)) in talent.contract',
    `document_reference_uri` STRING COMMENT 'The storage location or document management system URI for the executed contract document and all amendments. Used for legal reference and audit. | Column document_reference_uri (STRING) in talent.contract',
    `effective_end_date` DATE COMMENT 'The date on which the contract expires or the engagement period ends. Nullable for open-ended overall deals or holding deals with option-based extensions. | Column effective_end_date (DATE) in talent.contract',
    `effective_start_date` DATE COMMENT 'The date on which the contract becomes binding and the talent engagement period begins. | Column effective_start_date (DATE) in talent.contract',
    `engagement_role` STRING COMMENT 'The specific role or position the talent is contracted to perform (e.g., Lead Actor, Director, Showrunner, Writer, Executive Producer, Director of Photography, Host). | Column engagement_role (STRING) in talent.contract',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the contract includes exclusivity restrictions preventing the talent from working on competing projects or for other networks/studios during the contract period. | Column exclusivity_flag (BOOLEAN) in talent.contract',
    `exclusivity_scope` STRING COMMENT 'Detailed description of the exclusivity restrictions, including prohibited activities, competing platforms, genre restrictions, and geographic scope. Null if exclusivity_flag is false. | Column exclusivity_scope (STRING) in talent.contract',
    `governing_cba` STRING COMMENT 'The specific collective bargaining agreement that governs this contract, including version and effective date (e.g., SAG-AFTRA Television Agreement 2020-2023). Defines minimum compensation, working conditions, and residual structures. | Column governing_cba (STRING) in talent.contract',
    `gross_participation_flag` BOOLEAN COMMENT 'Indicates if talent has gross participation in revenues',
    `guaranteed_episodes` STRING COMMENT 'The minimum number of episodes for which the talent is guaranteed compensation, regardless of actual production. Common in series regular deals. Null for non-episodic contracts. | Column guaranteed_episodes (INT) in talent.contract',
    `guild_affiliation` STRING COMMENT 'The labor union or guild to which the talent belongs. SAG-AFTRA covers actors and broadcasters; WGA covers writers; DGA covers directors; IATSE covers crew and technical staff. Multiple indicates membership in more than one guild. Non-union indicates no guild membership. | Column guild_affiliation (STRING) in talent.contract. Valid values are `SAG-AFTRA|WGA|DGA|IATSE|non_union|multiple`',
    `holdback_period_days` STRING COMMENT 'The number of days after contract end during which the talent is restricted from working on similar projects or for competing entities. Common in overall deals and first-look agreements. | Column holdback_period_days (INT) in talent.contract',
    `last_amendment_date` DATE COMMENT 'The date of the most recent contract amendment. Null if no amendments have been made. | Column last_amendment_date (DATE) in talent.contract',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this contract record was most recently updated in the system. | Column last_modified_timestamp (TIMESTAMP) in talent.contract',
    `net_participation_flag` BOOLEAN COMMENT 'Indicates if talent has net participation in revenues',
    `option_exercise_deadline` DATE COMMENT 'The date by which the company must notify the talent of its decision to exercise or decline the next option period. Null if no active option exists. | Column option_exercise_deadline (DATE) in talent.contract',
    `option_exercise_status` STRING COMMENT 'Current status of the most recent option period. Not applicable if no options exist; pending if decision deadline has not passed; exercised if company extended; declined if company chose not to extend; expired if deadline passed without action. | Column option_exercise_status (STRING) in talent.contract. Valid values are `not_applicable|pending|exercised|declined|expired`',
    `option_periods_count` STRING COMMENT 'The number of option periods (typically annual) the company holds to extend the contract beyond the initial term. Common in series regular and overall deals. | Column option_periods_count (INT) in talent.contract',
    `pay_or_play_flag` BOOLEAN COMMENT 'Indicates whether the contract includes a pay-or-play provision, guaranteeing full compensation even if the talent services are not ultimately used or the production is cancelled. | Column pay_or_play_flag (BOOLEAN) in talent.contract',
    `residual_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the talent is eligible to receive residual payments for reuse of the content (reruns, streaming, international distribution, home video). Governed by guild CBAs. | Column residual_eligibility_flag (BOOLEAN) in talent.contract',
    `source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in talent.contract',
    `step_up_amount` DECIMAL(18,2) COMMENT 'The incremental increase in base compensation for each exercised option period or season renewal. Null if no step-up provision exists. | Column step_up_amount (DECIMAL(18,2)) in talent.contract',
    `termination_date` DATE COMMENT 'The date on which the contract was terminated prior to its natural expiration. Null if contract was not terminated early. | Column termination_date (DATE) in talent.contract',
    `termination_reason` STRING COMMENT 'The primary reason for early contract termination. Null if contract was not terminated early. [ENUM-REF-CANDIDATE: mutual_agreement|breach_of_contract|force_majeure|production_cancellation|talent_unavailability|company_convenience|talent_request|other — 8 candidates stripped; promote to reference product] | Column termination_reason (STRING) in talent.contract',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in talent.contract',
    CONSTRAINT pk_contract PRIMARY KEY(`contract_id`)
) COMMENT 'Authoritative record of each talent engagement from initial deal memo through executed long-form contract — covering series regular deals, episodic guest agreements, overall deals, first-look deals, and crew contracts. Captures contract lifecycle stage (deal memo, countersigned, long-form executed), compensation structure (base fee, guarantees, backend participation, step-ups, pay-or-play), exclusivity and holdback restrictions, option periods with exercise status, amendment history, billing credit position, governing CBA, and document references. Source of truth for all commercial terms, obligations, and contractual modifications throughout the talent engagement lifecycle. | Unity Catalog table: media_broadcasting_ecm.talent.contract Talent/residuals entity supporting contract+compensation_structure+guild_affiliation+cba_rate_card+residual_payment flows.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` (
    `compensation_structure_id` BIGINT COMMENT 'Unique identifier for the compensation structure record. Primary key. | Column compensation_structure_id (BIGINT) in talent.compensation_structure',
    `contract_id` BIGINT COMMENT 'Reference to the parent talent contract to which this compensation structure is attached. | Column contract_id (BIGINT) in talent.compensation_structure',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in talent.compensation_structure',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in talent.compensation_structure',
    `backend_gross_participation_pct` DECIMAL(18,2) COMMENT 'The percentage of adjusted gross receipts or backend profits the talent is entitled to receive (e.g., 0.05 for 5% backend participation). Null if no backend participation is granted. | Column backend_gross_participation_pct (DECIMAL(5,4)) in talent.compensation_structure',
    `base_episode_fee` DECIMAL(18,2) COMMENT 'The guaranteed compensation amount per episode for episodic talent (actors, writers, directors). Expressed in the contract currency. | Column base_episode_fee (DECIMAL(15,2)) in talent.compensation_structure',
    `bonus_amount` DECIMAL(18,2) COMMENT 'The fixed or maximum bonus amount payable when the bonus threshold is met. Expressed in the contract currency. Null if no bonus provision exists. | Column bonus_amount (DECIMAL(15,2)) in talent.compensation_structure',
    `bonus_threshold_description` STRING COMMENT 'Textual description of the performance or milestone thresholds that trigger bonus payments (e.g., Nielsen rating above 2.0 in key demo, box office exceeds $100M domestic). | Column bonus_threshold_description (STRING) in talent.compensation_structure',
    `breakeven_definition` STRING COMMENT 'Definition of breakeven point for net participation calculations',
    `compensation_type` STRING COMMENT 'Classification of the compensation arrangement: union scale (SAG-AFTRA, WGA, DGA minimum), over-scale (above union minimum), flat fee, episodic rate, weekly guarantee, daily rate, backend gross participation, deferred compensation, or residual-only deal. [ENUM-REF-CANDIDATE: union_scale|over_scale|flat_fee|episodic|weekly|daily|backend_participation|deferred|residual_only — 9 candidates stripped; promote to reference product] | Column compensation_type (STRING) in talent.compensation_structure',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in talent.compensation_structure',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this compensation structure record was first created in the system. | Column created_timestamp (TIMESTAMP) in talent.compensation_structure',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all monetary amounts in this compensation structure are denominated (e.g., USD, GBP, CAD). | Column currency_code (STRING) in talent.compensation_structure. Valid values are `^[A-Z]{3}$`',
    `daily_rate` DECIMAL(18,2) COMMENT 'The guaranteed daily compensation amount for talent engaged on a day-player or daily basis. Expressed in the contract currency. | Column daily_rate (DECIMAL(15,2)) in talent.compensation_structure',
    `deferred_compensation_amount` DECIMAL(18,2) COMMENT 'The total amount of compensation deferred to a future payment date or contingent event (e.g., series pickup, profitability milestone). Expressed in the contract currency. | Column deferred_compensation_amount (DECIMAL(15,2)) in talent.compensation_structure',
    `deferred_payment_trigger` STRING COMMENT 'The business event or milestone that triggers payment of deferred compensation (e.g., series_pickup, profitability_threshold_met, syndication_sale, specific_date). | Column deferred_payment_trigger (STRING) in talent.compensation_structure',
    `effective_end_date` DATE COMMENT 'The date on which this compensation structure ceases to be effective. Null for open-ended structures or those tied to contract termination. | Column effective_end_date (DATE) in talent.compensation_structure',
    `effective_start_date` DATE COMMENT 'The date on which this compensation structure becomes effective and applicable to the talent contract. | Column effective_start_date (DATE) in talent.compensation_structure',
    `exclusivity_clause_flag` BOOLEAN COMMENT 'Indicates whether this compensation structure includes an exclusivity provision restricting the talent from working on competing projects (True) or not (False). | Column exclusivity_clause_flag (BOOLEAN) in talent.compensation_structure',
    `guild_affiliation` STRING COMMENT 'The labor union or guild governing this compensation structure: SAG-AFTRA (Screen Actors Guild - American Federation of Television and Radio Artists), WGA (Writers Guild of America), DGA (Directors Guild of America), IATSE (International Alliance of Theatrical Stage Employees), or non-union. | Column guild_affiliation (STRING) in talent.compensation_structure. Valid values are `SAG-AFTRA|WGA|DGA|IATSE|non_union`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this compensation structure record was last updated or modified. | Column last_modified_timestamp (TIMESTAMP) in talent.compensation_structure',
    `notes` STRING COMMENT 'Free-text field for additional notes, special provisions, or clarifications regarding this compensation structure that do not fit into structured fields. | Column notes (STRING) in talent.compensation_structure',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'The multiplier applied to the base rate for overtime hours worked (e.g., 1.5 for time-and-a-half, 2.0 for double-time). Null if overtime is not applicable. | Column overtime_multiplier (DECIMAL(5,2)) in talent.compensation_structure',
    `participation_ceiling_amount` DECIMAL(18,2) COMMENT 'Maximum participation amount cap',
    `participation_definition_type` STRING COMMENT 'Type of participation: gross, adjusted_gross, net',
    `participation_floor_amount` DECIMAL(18,2) COMMENT 'Minimum participation amount guaranteed',
    `participation_percentage` DECIMAL(18,2) COMMENT 'Percentage of participation in revenues',
    `pay_or_play_flag` BOOLEAN COMMENT 'Indicates whether this compensation structure includes a pay-or-play provision, guaranteeing payment even if the talent is not used (True) or not (False). | Column pay_or_play_flag (BOOLEAN) in talent.compensation_structure',
    `pension_health_rate` DECIMAL(18,2) COMMENT 'The percentage rate of gross compensation contributed to the guild pension and health plan (e.g., 0.185 for 18.5% SAG-AFTRA P&H). Used to calculate employer contributions. | Column pension_health_rate (DECIMAL(5,4)) in talent.compensation_structure',
    `residual_base_formula` STRING COMMENT 'The formula or method used to calculate the residual base for reuse payments (e.g., initial_compensation, applicable_minimum, pro_rata_share). Defines how residuals are computed per guild rules. | Column residual_base_formula (STRING) in talent.compensation_structure',
    `residual_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the talent is eligible to receive residual payments for reuse of the content under this compensation structure (True) or not (False). Typically True for union deals, may be False for buyouts. | Column residual_eligibility_flag (BOOLEAN) in talent.compensation_structure',
    `source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in talent.compensation_structure',
    `step_up_amount` DECIMAL(18,2) COMMENT 'The incremental compensation increase amount when the step-up trigger is met. Expressed in the contract currency. Null if no step-up provision exists. | Column step_up_amount (DECIMAL(15,2)) in talent.compensation_structure',
    `step_up_trigger` STRING COMMENT 'The condition or event that triggers an automatic increase in compensation (e.g., season_2_pickup, episode_13_renewal, ratings_threshold). Null if no step-up provision exists. | Column step_up_trigger (STRING) in talent.compensation_structure',
    `structure_name` STRING COMMENT 'Business-friendly name or label for this compensation structure (e.g., Series Regular Season 1, Guest Star Rate Card). | Column structure_name (STRING) in talent.compensation_structure',
    `structure_status` STRING COMMENT 'Current lifecycle status of the compensation structure: draft (under negotiation), active (in force), amended (modified after execution), superseded (replaced by a newer structure), or terminated (no longer applicable). | Column structure_status (STRING) in talent.compensation_structure. Valid values are `draft|active|amended|superseded|terminated`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in talent.compensation_structure',
    `usage_rights_scope` STRING COMMENT 'Description of the media usage rights covered by this compensation structure (e.g., initial broadcast only, all media in perpetuity, theatrical and SVOD, domestic free television). Defines what exploitation is covered by the base compensation. | Column usage_rights_scope (STRING) in talent.compensation_structure',
    `weekly_guarantee` DECIMAL(18,2) COMMENT 'The guaranteed weekly compensation amount for talent engaged on a weekly basis (e.g., series regulars, production staff). Expressed in the contract currency. | Column weekly_guarantee (DECIMAL(15,2)) in talent.compensation_structure',
    CONSTRAINT pk_compensation_structure PRIMARY KEY(`compensation_structure_id`)
) COMMENT 'Defines the detailed compensation terms attached to a talent contract — including base episode fee, weekly guarantee, daily rate, overtime multipliers, pension and health (P&H) contribution rates, residual base formula, backend gross participation percentage, deferred compensation schedule, and currency. Supports both union scale (SAG-AFTRA scale, DGA scale) and over-scale deals. Tracks step-up triggers (e.g., series pickup escalators), bonus thresholds, and pay-or-play provisions. Used by payroll and royalty workflows to calculate gross compensation and residual bases. | Unity Catalog table: media_broadcasting_ecm.talent.compensation_structure Talent/residuals entity supporting contract+compensation_structure+guild_affiliation+cba_rate_card+residual_payment flows.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` (
    `residual_eligibility_id` BIGINT COMMENT 'Unique identifier for the residual eligibility record. | Column residual_eligibility_id (BIGINT) in talent.residual_eligibility',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Guild residual calculations (SAG-AFTRA, WGA, DGA) are version-specific — a 30-second edit, extended cut, or dubbed version each triggers different residual rates. Linking residual_eligibility to asset',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: SAG-AFTRA and WGA guild compliance requires residual eligibility to be tracked at the episode level per exhibition window. Auditors trace eligibility records to specific episodes. Existing media_asset',
    `contract_id` BIGINT COMMENT 'Reference to the talent contract that governs the residual terms and eligibility rules. | Column contract_id (BIGINT) in talent.residual_eligibility',
    `media_asset_id` BIGINT COMMENT 'Reference to the specific content asset (episode, film, program) for which residual eligibility applies. | Column media_asset_id (BIGINT) in mediaasset.residual_eligibility',
    `role_id` BIGINT COMMENT 'Foreign key linking to talent.role. Business justification: residual_eligibility determines a talents eligibility for residual payments on a per-content-asset basis. The role table defines the specific function a talent performs within a production — includin',
    `royalty_rule_id` BIGINT COMMENT 'Foreign key linking to rights.royalty_rule. Business justification: Talent residual eligibility records must reference the governing rights royalty rule to ensure consistent formula application. Direct FK enables audit compliance — verifying that residual_formula_type',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent (actor, director, writer, producer, host, correspondent, crew member) for whom residual eligibility is being determined. | Column talent_profile_id (BIGINT) in talent.residual_eligibility',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in talent.residual_eligibility',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in talent.residual_eligibility',
    `backend_participation_type` STRING COMMENT 'Type of backend participation: gross, net, adjusted_gross',
    `buyout_amount` DECIMAL(18,2) COMMENT 'The one-time payment amount paid to the talent in lieu of ongoing residual payments for specified uses, if a buyout was applied. | Column buyout_amount (DECIMAL(15,2)) in talent.residual_eligibility',
    `buyout_applied` BOOLEAN COMMENT 'Indicates whether a residual buyout was negotiated and applied, eliminating ongoing residual payment obligations for specified uses. | Column buyout_applied (BOOLEAN) in talent.residual_eligibility',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in talent.residual_eligibility',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this residual eligibility record was first created in the system. | Column created_timestamp (TIMESTAMP) in talent.residual_eligibility',
    `distribution_window` STRING COMMENT 'The specific distribution window or release period during which this residual eligibility applies (e.g., First Run, Second Run, Theatrical Window, SVOD Window). | Column distribution_window (STRING) in talent.residual_eligibility',
    `effective_end_date` DATE COMMENT 'The date on which this residual eligibility expires or is no longer applicable, nullable for open-ended eligibility. | Column effective_end_date (DATE) in talent.residual_eligibility',
    `effective_start_date` DATE COMMENT 'The date from which this residual eligibility becomes active and applicable for payment calculation. | Column effective_start_date (DATE) in talent.residual_eligibility',
    `eligibility_determination_date` DATE COMMENT 'The date on which residual eligibility was determined and recorded for this talent and content asset. | Column eligibility_determination_date (DATE) in talent.residual_eligibility',
    `eligibility_status` STRING COMMENT 'Current status of the residual eligibility determination for this talent-content-use combination. | Column eligibility_status (STRING) in talent.residual_eligibility. Valid values are `Eligible|Ineligible|Pending Review|Disputed|Waived|Expired`',
    `exclusivity_clause_applies` BOOLEAN COMMENT 'Indicates whether an exclusivity clause in the talent contract affects residual eligibility or payment terms for this content asset. | Column exclusivity_clause_applies (BOOLEAN) in talent.residual_eligibility',
    `guild_affiliation` STRING COMMENT 'The guild or union to which the talent belongs, determining applicable residual formulas and rates (Screen Actors Guild - American Federation of Television and Radio Artists, Writers Guild of America, Directors Guild of America, International Alliance of Theatrical Stage Employees, American Federation of Musicians, or Non-Guild). | Column guild_affiliation (STRING) in talent.residual_eligibility. Valid values are `SAG-AFTRA|WGA|DGA|IATSE|AFM|Non-Guild`',
    `health_contribution_applicable` BOOLEAN COMMENT 'Indicates whether health and welfare contributions are required to be calculated and remitted based on this residual payment per guild agreement. | Column health_contribution_applicable (BOOLEAN) in talent.residual_eligibility',
    `health_contribution_rate` DECIMAL(18,2) COMMENT 'The percentage rate applied to the residual payment for health and welfare fund contribution calculation. | Column health_contribution_rate (DECIMAL(5,2)) in talent.residual_eligibility',
    `minimum_residual_threshold` DECIMAL(18,2) COMMENT 'The minimum payment amount below which residuals are not processed or paid, as defined by guild rules or contract terms. | Column minimum_residual_threshold (DECIMAL(15,2)) in talent.residual_eligibility',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or clarifications regarding this residual eligibility determination. | Column notes (STRING) in talent.residual_eligibility',
    `participation_eligible_flag` BOOLEAN COMMENT 'Indicates if talent is eligible for participation beyond residuals',
    `payment_frequency` STRING COMMENT 'The frequency at which residual payments are calculated and disbursed for this eligibility record. | Column payment_frequency (STRING) in talent.residual_eligibility. Valid values are `Per Use|Quarterly|Semi-Annual|Annual|One-Time`',
    `pension_contribution_applicable` BOOLEAN COMMENT 'Indicates whether pension contributions are required to be calculated and remitted based on this residual payment per guild agreement. | Column pension_contribution_applicable (BOOLEAN) in talent.residual_eligibility',
    `pension_contribution_rate` DECIMAL(18,2) COMMENT 'The percentage rate applied to the residual payment for pension fund contribution calculation. | Column pension_contribution_rate (DECIMAL(5,2)) in talent.residual_eligibility',
    `residual_base_amount` DECIMAL(18,2) COMMENT 'The base monetary amount used as the foundation for residual calculation, typically derived from the original compensation or a guild-defined minimum. | Column residual_base_amount (DECIMAL(15,2)) in talent.residual_eligibility',
    `residual_formula_type` STRING COMMENT 'The specific residual calculation formula applicable to this eligibility record, determined by guild agreement, content type, and distribution channel. | Column residual_formula_type (STRING) in talent.residual_eligibility. Valid values are `SAG-AFTRA TV Residuals|Theatrical Residuals|New Media Residuals|Streaming Supplemental|Foreign Broadcast Residuals|Home Video Residuals`',
    `residual_percentage` DECIMAL(18,2) COMMENT 'The percentage of the base amount payable as residual for this specific use, as defined by guild agreement or contract negotiation. | Column residual_percentage (DECIMAL(5,2)) in talent.residual_eligibility',
    `rightsline_integration_code` STRING COMMENT 'External identifier used to link this residual eligibility record to the Rightsline rights and royalties management system for automated royalty calculation workflow. | Column rightsline_integration_code (STRING) in talent.residual_eligibility',
    `sap_payables_reference` STRING COMMENT 'Reference identifier linking this residual eligibility to SAP S/4HANA accounts payable processing for payment execution. | Column sap_payables_reference (STRING) in talent.residual_eligibility',
    `source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in talent.residual_eligibility',
    `territory` STRING COMMENT 'The geographic territory or market for which this residual eligibility applies (e.g., USA, CAN, GBR, Worldwide). | Column territory (STRING) in talent.residual_eligibility',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in talent.residual_eligibility',
    `updated_by` STRING COMMENT 'The user or system identifier of the person or process that last updated this residual eligibility record. | Column updated_by (STRING) in talent.residual_eligibility',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this residual eligibility record was last modified or updated. | Column updated_timestamp (TIMESTAMP) in talent.residual_eligibility',
    `use_type` STRING COMMENT 'The type of content usage that triggers residual payment eligibility (Rerun, Foreign Broadcast, Home Video, Subscription Video On Demand, Advertising-Supported Video On Demand, Transactional Video On Demand, Free Ad-Supported Streaming Television, Theatrical, Syndication, or Clip Use). [ENUM-REF-CANDIDATE: Rerun|Foreign Broadcast|Home Video|SVOD|AVOD|TVOD|FAST|Theatrical|Syndication|Clip Use — 10 candidates stripped; promote to reference product] | Column use_type (STRING) in talent.residual_eligibility',
    `created_by` STRING COMMENT 'The user or system identifier of the person or process that created this residual eligibility record. | Column created_by (STRING) in talent.residual_eligibility',
    CONSTRAINT pk_residual_eligibility PRIMARY KEY(`residual_eligibility_id`)
) COMMENT 'Determines and records each talents eligibility for residual payments on a per-content-asset basis — capturing the applicable residual formula (SAG-AFTRA TV residuals, theatrical residuals, new media residuals, streaming supplemental), residual base amount, use type triggering residual (rerun, foreign broadcast, home video, SVOD, AVOD, TVOD, FAST), minimum residual threshold, pension and health contribution applicability, and eligibility determination date. Feeds directly into the Rightsline royalty calculation workflow and SAP S/4HANA payables processing. | Unity Catalog table: media_broadcasting_ecm.talent.residual_eligibility Talent/residuals entity supporting contract+compensation_structure+guild_affiliation+cba_rate_card+residual_payment flows.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` (
    `residual_payment_id` BIGINT COMMENT 'Unique identifier for the residual payment transaction. | Column residual_payment_id (BIGINT) in talent.residual_payment',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Guild audit requirements mandate documenting the exact version exhibited that triggered a residual payment. Linking residual_payment to asset_version supports WGA/SAG-AFTRA audit trails and remittance',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: SAG-AFTRA/WGA require residual payment records traceable to specific episode exhibitions for guild audit reports. Finance teams reconcile payments against episode broadcast logs. Existing media_asset_',
    `contract_id` BIGINT COMMENT 'Reference to the talent contract governing this residual payment. | Column contract_id (BIGINT) in talent.residual_payment',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset (title, episode, or version) for which the residual is being paid. | Column media_asset_id (BIGINT) in mediaasset.residual_payment',
    `residual_eligibility_id` BIGINT COMMENT 'Foreign key linking to talent.residual_eligibility. Business justification: residual_payment is the transactional record of payments issued based on eligibility determinations. Currently both products independently reference talent_profile, content_asset_id, and contract_id.  | Column residual_eligibility_id (BIGINT) in talent.residual_payment',
    `royalty_statement_id` BIGINT COMMENT 'Foreign key linking to rights.royalty_statement. Business justification: Talent residual payments must be reconciled against rights royalty statements for finance audit and guild reporting. royalty_calculation_reference (plain text) is a denormalized reference to royalty_s',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent receiving the residual payment. | Column talent_profile_id (BIGINT) in talent.residual_payment',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in talent.residual_payment',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in talent.residual_payment',
    `ach_trace_number` STRING COMMENT 'The ACH trace number if the payment method is ACH or direct deposit, used for reconciliation and audit. | Column ach_trace_number (STRING) in talent.residual_payment',
    `agent_commission_amount` DECIMAL(18,2) COMMENT 'The agent or manager commission amount deducted from the residual payment, if applicable. | Column agent_commission_amount (DECIMAL(15,2)) in talent.residual_payment',
    `audit_report_date` DATE COMMENT 'The date on which this residual payment was included in a guild audit report. | Column audit_report_date (DATE) in talent.residual_payment',
    `audit_report_flag` BOOLEAN COMMENT 'Indicates whether this residual payment has been included in a guild audit report (SAG-AFTRA, WGA, DGA). | Column audit_report_flag (BOOLEAN) in talent.residual_payment',
    `check_number` STRING COMMENT 'The check number if the payment method is check, used for reconciliation and audit. | Column check_number (STRING) in talent.residual_payment',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in talent.residual_payment',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this residual payment record was first created in the system. | Column created_timestamp (TIMESTAMP) in talent.residual_payment',
    `distribution_window` STRING COMMENT 'The specific distribution window or platform for which the residual is being paid (e.g., Network Prime Time, Basic Cable, Netflix SVOD, International Theatrical). | Column distribution_window (STRING) in talent.residual_payment',
    `exhibition_end_date` DATE COMMENT 'The end date of the exhibition period for which this residual is calculated. | Column exhibition_end_date (DATE) in talent.residual_payment',
    `exhibition_start_date` DATE COMMENT 'The start date of the exhibition period for which this residual is calculated. | Column exhibition_start_date (DATE) in talent.residual_payment',
    `gross_residual_amount` DECIMAL(18,2) COMMENT 'The gross residual amount calculated before deductions, in the payment currency. | Column gross_residual_amount (DECIMAL(15,2)) in talent.residual_payment',
    `guild_affiliation` STRING COMMENT 'The guild or union affiliation governing this residual payment (SAG-AFTRA, WGA, DGA, IATSE, AFM, or non-union). | Column guild_affiliation (STRING) in talent.residual_payment. Valid values are `SAG-AFTRA|WGA|DGA|IATSE|AFM|non_union`',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The net residual payment amount after all deductions, paid to the talent. | Column net_payment_amount (DECIMAL(15,2)) in talent.residual_payment',
    `payment_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the residual payment (e.g., USD, GBP, EUR). | Column payment_currency_code (STRING) in talent.residual_payment. Valid values are `^[A-Z]{3}$`',
    `payment_date` DATE COMMENT 'The date on which the residual payment was issued or disbursed to the talent. | Column payment_date (DATE) in talent.residual_payment',
    `payment_method` STRING COMMENT 'The method used to disburse the residual payment to the talent. | Column payment_method (STRING) in talent.residual_payment. Valid values are `check|ACH|wire_transfer|direct_deposit|payroll`',
    `payment_notes` STRING COMMENT 'Free-text notes or comments related to this residual payment, including special circumstances, adjustments, or exceptions. | Column payment_notes (STRING) in talent.residual_payment',
    `payment_number` STRING COMMENT 'Business identifier for the residual payment, used for external reference and reconciliation. | Column payment_number (STRING) in talent.residual_payment',
    `payment_status` STRING COMMENT 'Current lifecycle status of the residual payment transaction. | Column payment_status (STRING) in talent.residual_payment. Valid values are `pending|approved|processed|paid|cancelled|on_hold`',
    `pension_health_amount` DECIMAL(18,2) COMMENT 'The pension and health contribution amount deducted from the gross residual, as required by guild agreements. | Column pension_health_amount (DECIMAL(15,2)) in talent.residual_payment',
    `remittance_advice_sent_date` DATE COMMENT 'The date on which the remittance advice was sent to the talent. | Column remittance_advice_sent_date (DATE) in talent.residual_payment',
    `remittance_advice_sent_flag` BOOLEAN COMMENT 'Indicates whether a remittance advice document was sent to the talent for this payment. | Column remittance_advice_sent_flag (BOOLEAN) in talent.residual_payment',
    `source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in talent.residual_payment',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in talent.residual_payment',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this residual payment record was last modified. | Column updated_timestamp (TIMESTAMP) in talent.residual_payment',
    `use_type` STRING COMMENT 'The type of content reuse triggering the residual payment (broadcast, cable, SVOD, AVOD, TVOD, FAST, home video, foreign distribution, theatrical). [ENUM-REF-CANDIDATE: broadcast|cable|SVOD|AVOD|TVOD|FAST|home_video|foreign|theatrical — 9 candidates stripped; promote to reference product] | Column use_type (STRING) in talent.residual_payment',
    `wire_reference_number` STRING COMMENT 'The wire transfer reference number if the payment method is wire transfer, used for reconciliation and audit. | Column wire_reference_number (STRING) in talent.residual_payment',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The tax amount withheld from the residual payment for federal, state, or foreign tax obligations. | Column withholding_tax_amount (DECIMAL(15,2)) in talent.residual_payment',
    CONSTRAINT pk_residual_payment PRIMARY KEY(`residual_payment_id`)
) COMMENT 'Transactional record of each residual payment issued to talent for reuse of content across broadcast, home video, streaming (SVOD, AVOD, TVOD), FAST, and foreign distribution windows. Captures payment cycle, content asset reference, use type, distribution window, gross residual amount, P&H contribution amount, withholding tax amount, net payment amount, payment method, payment date, check or ACH reference, and remittance advice sent flag. Reconciles against Rightsline royalty calculations and SAP S/4HANA AP postings. Supports SAG-AFTRA and WGA audit requirements. | Unity Catalog table: media_broadcasting_ecm.talent.residual_payment Talent/residuals entity supporting contract+compensation_structure+guild_affiliation+cba_rate_card+residual_payment flows.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` (
    `deal_memo_id` BIGINT COMMENT 'Unique identifier for the talent deal memo record. Primary key. | Column deal_memo_id (BIGINT) in talent.deal_memo',
    `advertising_campaign_id` BIGINT COMMENT 'Foreign key linking to advertising.campaign. Business justification: In media broadcasting, talent deal memos are executed for specific advertising campaigns (brand ambassador, campaign spokesperson roles). Linking deal_memo to campaign enables campaign budget reconcil',
    `contract_id` BIGINT COMMENT 'Reference to the executed long-form talent contract that supersedes this deal memo. Null if the long-form contract has not yet been executed. | Column long_form_contract_id (BIGINT) in talent.deal_memo',
    `title_id` BIGINT COMMENT 'Reference to the production title (series, episode, film, special) for which the talent is engaged. | Column production_title_id (BIGINT) in content.deal_memo',
    `representation_agreement_id` BIGINT COMMENT 'Foreign key linking to talent.representation_agreement. Business justification: deal_memo currently stores denormalized agent contact information (agent_name, agent_contact_email, agent_contact_phone) as free-text strings. The representation_agreement table is the authoritative r',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Season option exercise tracking — deal memos for option periods reference specific seasons with distinct guaranteed episode counts and compensation terms. Production legal teams need season-scoped dea',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Deal memos for episodic content reference series for series commitment tracking, multi-season option terms, and episode count guarantees. Essential for TV talent deal management. | Column series_id (BIGINT) in content.deal_memo',
    `opportunity_id` BIGINT COMMENT 'The Salesforce Media Cloud opportunity or proposal record identifier from which this deal memo was generated. | Column source_opportunity_id (BIGINT) in sales.deal_memo',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent (actor, director, writer, producer, host, correspondent, crew member) engaged under this deal memo. | Column talent_profile_id (BIGINT) in talent.deal_memo',
    `upfront_deal_id` BIGINT COMMENT 'Foreign key linking to sales.upfront_deal. Business justification: Deal memos for talent are frequently created to staff programming sold during upfront season. Linking deal_memo to upfront_deal allows production and sales operations to track which talent deal memos ',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in talent.deal_memo',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in talent.deal_memo',
    `compensation_amount` DECIMAL(18,2) COMMENT 'The primary monetary compensation amount agreed in the deal memo (e.g., total fee, per-episode rate, or guaranteed minimum). | Column compensation_amount (DECIMAL(15,2)) in talent.deal_memo',
    `compensation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation amount (e.g., USD, GBP, EUR). | Column compensation_currency (STRING) in talent.deal_memo. Valid values are `^[A-Z]{3}$`',
    `compensation_summary` STRING COMMENT 'High-level summary of the compensation structure agreed in the deal memo (e.g., per-episode fee, flat fee, day rate, backend participation). Detailed breakdowns are captured in the long-form contract. | Column compensation_summary (STRING) in talent.deal_memo',
    `countersigned_date` DATE COMMENT 'The date on which the deal memo was countersigned by both the talent (or agent) and the production company, making it a binding interim agreement. Null if not yet countersigned. | Column countersigned_date (DATE) in talent.deal_memo',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in talent.deal_memo',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the deal memo record was first created in the system. | Column created_timestamp (TIMESTAMP) in talent.deal_memo',
    `credit_position` STRING COMMENT 'The agreed on-screen or off-screen credit position and format (e.g., Main Title Card, Opening Credits, End Crawl, Shared Card, Single Card). | Column credit_position (STRING) in talent.deal_memo',
    `deal_date` DATE COMMENT 'The date on which the deal terms were verbally agreed or the deal memo was initially drafted. | Column deal_date (DATE) in talent.deal_memo',
    `deal_memo_number` STRING COMMENT 'Externally-known unique business identifier for the deal memo, typically generated by the CRM or legal system. | Column deal_memo_number (STRING) in talent.deal_memo. Valid values are `^DM-[0-9]{6,10}$`',
    `deal_memo_status` STRING COMMENT 'Current lifecycle status of the deal memo: draft (under negotiation), countersigned (binding interim agreement), superseded_by_long_form (replaced by executed contract), expired (lapsed without execution), cancelled (deal fell through). | Column deal_memo_status (STRING) in talent.deal_memo. Valid values are `draft|countersigned|superseded_by_long_form|expired|cancelled`',
    `effective_date` DATE COMMENT 'The date on which the deal memo becomes binding (typically the date of countersignature by both parties). | Column effective_date (DATE) in talent.deal_memo',
    `engagement_end_date` DATE COMMENT 'The date on which the talent engagement is scheduled to end. Null for open-ended or option-based engagements. | Column engagement_end_date (DATE) in talent.deal_memo',
    `engagement_start_date` DATE COMMENT 'The date on which the talent engagement is scheduled to begin (first day of work, rehearsal, or availability). | Column engagement_start_date (DATE) in talent.deal_memo',
    `episode_count` STRING COMMENT 'Number of episodes or production units covered by this deal memo. Null if the engagement is for a single film or special. | Column episode_count (INT) in talent.deal_memo',
    `exclusivity_summary` STRING COMMENT 'High-level summary of exclusivity terms (e.g., exclusive to network during production, non-exclusive, first-look, holdback period). Detailed clauses are in the long-form contract. | Column exclusivity_summary (STRING) in talent.deal_memo',
    `expiration_date` DATE COMMENT 'The date by which the deal memo must be superseded by a long-form contract or it will expire. Null if no expiration is set. | Column expiration_date (DATE) in talent.deal_memo',
    `guild_affiliation` STRING COMMENT 'The guild or union to which the talent belongs: SAG-AFTRA (Screen Actors Guild - American Federation of Television and Radio Artists), DGA (Directors Guild of America), WGA (Writers Guild of America), IATSE (International Alliance of Theatrical Stage Employees), or non_union. | Column guild_affiliation (STRING) in talent.deal_memo. Valid values are `SAG-AFTRA|DGA|WGA|IATSE|non_union`',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified the deal memo record. | Column last_modified_by_user (STRING) in talent.deal_memo',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the deal memo record was last modified in the system. | Column last_modified_timestamp (TIMESTAMP) in talent.deal_memo',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special provisions, or negotiation history relevant to the deal memo. | Column notes (STRING) in talent.deal_memo',
    `option_terms` STRING COMMENT 'Summary of any option clauses (e.g., network option for additional seasons, talent option to extend, mutual option). Null if no options are included. | Column option_terms (STRING) in talent.deal_memo',
    `residual_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the talent is eligible for residual payments under guild agreements for reuse, syndication, or secondary distribution. True if eligible, False otherwise. | Column residual_eligibility_flag (BOOLEAN) in talent.deal_memo',
    `role_function` STRING COMMENT 'The specific role or function the talent will perform (e.g., Lead Actor, Director, Writer, Executive Producer, Host, Correspondent, Camera Operator). | Column role_function (STRING) in talent.deal_memo',
    `source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in talent.deal_memo',
    `superseded_date` DATE COMMENT 'The date on which the deal memo was superseded by the execution of a long-form contract. Null if not yet superseded. | Column superseded_date (DATE) in talent.deal_memo',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in talent.deal_memo',
    CONSTRAINT pk_deal_memo PRIMARY KEY(`deal_memo_id`)
) COMMENT 'Pre-contract deal memo capturing the agreed commercial terms for a talent engagement before the formal long-form contract is executed — including deal date, production title, role or function, episode count, start date, compensation summary, credit position, exclusivity summary, option terms, and deal memo status (draft, countersigned, superseded by long-form). Serves as the binding interim agreement used by production and legal teams during the gap between verbal deal and executed contract. Sourced from Salesforce Media Cloud opportunity and proposal records. | Unity Catalog table: media_broadcasting_ecm.talent.deal_memo Talent/residuals entity supporting contract+compensation_structure+guild_affiliation+cba_rate_card+residual_payment flows.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`role` (
    `role_id` BIGINT COMMENT 'Unique identifier for the talent role assignment. Primary key for the talent role entity. | Column role_id (BIGINT) in talent.role',
    `contract_id` BIGINT COMMENT 'Reference to the talent contract governing the terms of this role engagement, including compensation, usage rights, and obligations. | Column contract_id (BIGINT) in talent.role',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Roles often span specific seasons requiring season-level tracking for season-specific compensation, per-season credits, and availability scheduling. Eliminates denormalized season_number and provides  | Column season_id (BIGINT) in content.role',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Roles in episodic content must link to series for multi-season contract tracking, series-level residuals, and long-term talent availability management. Essential for TV production business model. | Column series_id (BIGINT) in content.role',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent individual performing this role. Links to the talent master entity. | Column talent_profile_id (BIGINT) in talent.role',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in talent.role',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in talent.role',
    `above_the_line_flag` BOOLEAN COMMENT 'Indicates whether this role is classified as above-the-line (creative principals: actors, directors, writers, producers) or below-the-line (technical crew and support staff). Impacts budget allocation and residual calculations. | Column above_the_line_flag (BOOLEAN) in talent.role',
    `appearance_count` STRING COMMENT 'Total number of episodes, segments, or appearances in which this talent role is featured. Used for episodic and recurring roles. | Column appearance_count (INT) in talent.role',
    `billing_position` STRING COMMENT 'The numerical order in which the talent appears in the credits (1 = first billed, 2 = second billed, etc.). Determines prominence in marketing materials and on-screen credits. | Column billing_position (INT) in talent.role',
    `role_category` STRING COMMENT 'Classification of the role type indicating the nature and scope of the talents engagement. Determines compensation structure, credit placement, and residual eligibility. [ENUM-REF-CANDIDATE: series_regular|recurring|guest_star|day_player|featured_extra|host|correspondent|narrator|voice_artist|director|writer|showrunner|executive_producer|line_producer|cinematographer|editor|composer|production_designer|costume_designer|makeup_artist|stunt_coordinator|other — promote to reference product] | Column role_category (STRING) in talent.role',
    `character_name` STRING COMMENT 'The name of the character portrayed by the talent for on-screen roles. Null for off-screen roles such as crew, directors, or producers. | Column character_name (STRING) in talent.role',
    `compensation_amount` DECIMAL(18,2) COMMENT 'The monetary compensation amount for this role engagement in the contract currency. Excludes residuals and backend participation. | Column compensation_amount (DECIMAL(15,2)) in talent.role',
    `compensation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation amount (e.g., USD, GBP, EUR). | Column compensation_currency (STRING) in talent.role. Valid values are `^[A-Z]{3}$`',
    `compensation_type` STRING COMMENT 'The structure of compensation for this role (flat fee, daily rate, weekly rate, episodic fee, backend participation, royalty, deferred payment). [ENUM-REF-CANDIDATE: flat_fee|daily_rate|weekly_rate|episodic_fee|backend_participation|royalty|deferred|other — 8 candidates stripped; promote to reference product] | Column compensation_type (STRING) in talent.role',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in talent.role',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this talent role record was first created in the system. | Column created_timestamp (TIMESTAMP) in talent.role',
    `credit_text` STRING COMMENT 'The exact text of the credit as it appears on-screen or in marketing materials, including any special formatting or possessory credits (e.g., A Film By, Created By). | Column credit_text (STRING) in talent.role',
    `credit_type` STRING COMMENT 'Specifies where and how the talents credit appears in the production (opening credits, closing credits, main titles, end titles, special thanks, or no credit). | Column credit_type (STRING) in talent.role. Valid values are `opening_credits|closing_credits|main_titles|end_titles|special_thanks|no_credit`',
    `end_date` DATE COMMENT 'The date on which the talents engagement for this role concludes. Null for ongoing or open-ended engagements. | Column end_date (DATE) in talent.role',
    `episode_scope_end` STRING COMMENT 'The last episode number in which this talent role appears. Null indicates ongoing engagement or single-episode appearance. | Column episode_scope_end (INT) in talent.role',
    `episode_scope_start` STRING COMMENT 'The first episode number in which this talent role appears. Used for episodic content to define the scope of the talents engagement. | Column episode_scope_start (INT) in talent.role',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the talent is bound by exclusivity clauses preventing them from performing similar roles for competing productions during the engagement period. | Column exclusivity_flag (BOOLEAN) in talent.role',
    `exclusivity_scope` STRING COMMENT 'Description of the scope and limitations of any exclusivity clause (e.g., No competing streaming series, No theatrical films during production). | Column exclusivity_scope (STRING) in talent.role',
    `guild_affiliation` STRING COMMENT 'The labor union or guild under whose jurisdiction this role falls (SAG-AFTRA for actors, WGA for writers, DGA for directors, IATSE for crew). Determines minimum compensation, working conditions, and residual eligibility. [ENUM-REF-CANDIDATE: sag_aftra|wga|dga|iatse|mpeg|non_union|other — 7 candidates stripped; promote to reference product] | Column guild_affiliation (STRING) in talent.role',
    `role_name` STRING COMMENT 'The specific role or function the talent is engaged to perform (e.g., Lead Actor, Director, Executive Producer, Cinematographer, Script Supervisor). | Column role_name (STRING) in talent.role',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or contextual information about this talent role assignment (e.g., special credit requirements, scheduling constraints, performance notes). | Column notes (STRING) in talent.role',
    `residual_eligible_flag` BOOLEAN COMMENT 'Indicates whether this role is eligible for residual payments based on subsequent distribution, reuse, or syndication of the content. Determined by guild agreements and contract terms. | Column residual_eligible_flag (BOOLEAN) in talent.role',
    `residual_rate_code` STRING COMMENT 'Code identifying the residual payment rate schedule applicable to this role based on guild agreements, role category, and distribution windows. | Column residual_rate_code (STRING) in talent.role',
    `role_status` STRING COMMENT 'Current lifecycle status of the talent role assignment indicating the stage of engagement from negotiation through completion. [ENUM-REF-CANDIDATE: confirmed|tentative|in_negotiation|contracted|active|completed|cancelled|suspended — 8 candidates stripped; promote to reference product] | Column role_status (STRING) in talent.role',
    `screen_time_minutes` DECIMAL(18,2) COMMENT 'Total on-screen time in minutes for this talent role across all appearances. Used for on-screen talent to measure prominence and for residual calculations. | Column screen_time_minutes (DECIMAL(8,2)) in talent.role',
    `source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in talent.role',
    `start_date` DATE COMMENT 'The date on which the talents engagement for this role begins, typically the first day of principal photography, recording, or production work. | Column start_date (DATE) in talent.role',
    `stunt_double_flag` BOOLEAN COMMENT 'Indicates whether this role involves stunt work or if a stunt double is used for this character. Impacts insurance, safety protocols, and credit attribution. | Column stunt_double_flag (BOOLEAN) in talent.role',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in talent.role',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this talent role record was last modified in the system. | Column updated_timestamp (TIMESTAMP) in talent.role',
    `usage_rights_duration_years` STRING COMMENT 'Number of years for which usage rights are granted. Null indicates perpetual rights. | Column usage_rights_duration_years (INT) in talent.role',
    `usage_rights_media` STRING COMMENT 'Media platforms and formats for which usage rights are granted (e.g., Theatrical, Home Video, Streaming, Broadcast TV). | Column usage_rights_media (STRING) in talent.role',
    `usage_rights_territory` STRING COMMENT 'Geographic territories in which the content featuring this talent role may be distributed and exploited (e.g., Worldwide, North America, USA and Canada). | Column usage_rights_territory (STRING) in talent.role',
    `voice_only_flag` BOOLEAN COMMENT 'Indicates whether this is a voice-only role (voice-over, narration, animation, ADR) with no on-screen physical appearance by the talent. | Column voice_only_flag (BOOLEAN) in talent.role',
    CONSTRAINT pk_role PRIMARY KEY(`role_id`)
) COMMENT 'Defines the specific role or function a talent is engaged to perform within a production or content asset — capturing role name, character name (for on-screen talent), role category (series regular, recurring, guest star, day player, featured extra, host, correspondent, narrator, voice artist, director, writer, showrunner, executive producer, line producer, DP, editor), above-the-line or below-the-line classification, episode or segment scope, and role status. Provides the granular link between talent identity and their specific creative contribution to each content asset. | Unity Catalog table: media_broadcasting_ecm.talent.role Talent/residuals entity supporting contract+compensation_structure+guild_affiliation+cba_rate_card+residual_payment flows.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` (
    `talent_agency_id` BIGINT COMMENT 'Unique identifier for the talent agency or management company. Primary key for the talent_agency product. | Column talent_agency_id (BIGINT) in talent.talent_agency',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in talent.talent_agency',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in talent.talent_agency',
    `address_line_1` STRING COMMENT 'The first line of the agencys primary business address, typically containing street number and street name. | Column address_line_1 (STRING) in talent.talent_agency',
    `address_line_2` STRING COMMENT 'The second line of the agencys primary business address, typically containing suite, floor, or building information. | Column address_line_2 (STRING) in talent.talent_agency',
    `agency_type` STRING COMMENT 'Classification of the representation entity: talent agency (licensed to procure employment), literary agency (represents writers), management company (career guidance), law firm (legal representation), publicity firm (public relations), or hybrid (multiple services). | Column agency_type (STRING) in talent.talent_agency. Valid values are `talent_agency|literary_agency|management_company|law_firm|publicity_firm|hybrid`',
    `bank_account_name` STRING COMMENT 'The name on the bank account used for commission and residual payments to the agency. | Column bank_account_name (STRING) in talent.talent_agency',
    `bank_account_number` STRING COMMENT 'The bank account number for electronic funds transfer of commissions and residuals to the agency. | Column bank_account_number (STRING) in talent.talent_agency',
    `bank_routing_number` STRING COMMENT 'The bank routing number (ABA number in the US, sort code in UK, or equivalent) for electronic funds transfer of commissions and residuals. | Column bank_routing_number (STRING) in talent.talent_agency',
    `city` STRING COMMENT 'The city or municipality where the agencys primary office is located. | Column city (STRING) in talent.talent_agency',
    `country_code` STRING COMMENT 'The three-letter ISO country code for the country where the agencys primary office is located (e.g., USA, GBR, CAN). | Column country_code (STRING) in talent.talent_agency. Valid values are `^[A-Z]{3}$`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in talent.talent_agency',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this talent agency record was first created in the system. Immutable audit field. | Column created_timestamp (TIMESTAMP) in talent.talent_agency',
    `dba_name` STRING COMMENT 'The trade name or doing-business-as name under which the agency operates, if different from the legal name. | Column dba_name (STRING) in talent.talent_agency',
    `established_date` DATE COMMENT 'The date on which the talent agency was originally established or incorporated. | Column established_date (DATE) in talent.talent_agency',
    `fax_number` STRING COMMENT 'The fax number for the agency, used for contract transmission and official correspondence in jurisdictions where fax is still required. | Column fax_number (STRING) in talent.talent_agency',
    `franchise_effective_date` DATE COMMENT 'The date on which the SAG-AFTRA franchise agreement became effective for this agency. | Column franchise_effective_date (DATE) in talent.talent_agency',
    `franchise_expiration_date` DATE COMMENT 'The date on which the current SAG-AFTRA franchise agreement expires and must be renewed. | Column franchise_expiration_date (DATE) in talent.talent_agency',
    `franchise_number` STRING COMMENT 'The unique franchise identification number issued by SAG-AFTRA to franchised talent agencies. | Column franchise_number (STRING) in talent.talent_agency',
    `franchise_status` STRING COMMENT 'Indicates whether the agency holds a valid SAG-AFTRA franchise agreement, which authorizes the agency to represent union talent. Franchised agencies agree to standard commission rates and contract terms. | Column franchise_status (STRING) in talent.talent_agency. Valid values are `franchised|non_franchised|pending|revoked|expired`',
    `legal_name` STRING COMMENT 'The full legal registered name of the talent agency or management company as it appears on contracts and official documents. | Column legal_name (STRING) in talent.talent_agency',
    `license_effective_date` DATE COMMENT 'The date on which the state talent agency license became effective. | Column license_effective_date (DATE) in talent.talent_agency',
    `license_expiration_date` DATE COMMENT 'The date on which the state talent agency license expires and must be renewed. | Column license_expiration_date (DATE) in talent.talent_agency',
    `license_number` STRING COMMENT 'The state-issued license number authorizing the agency to operate as a talent agency. Required in jurisdictions such as California under the Talent Agencies Act. | Column license_number (STRING) in talent.talent_agency',
    `license_state` STRING COMMENT 'The state or province that issued the talent agency license. Use standard two-letter state/province codes. | Column license_state (STRING) in talent.talent_agency',
    `notes` STRING COMMENT 'Free-form notes field for additional context, special handling instructions, historical information, or relationship management details relevant to the agency. | Column notes (STRING) in talent.talent_agency',
    `payment_terms` STRING COMMENT 'The standard payment terms and conditions for commission remittance, including timing and method of payment (e.g., net 30 days, upon talent payment receipt). | Column payment_terms (STRING) in talent.talent_agency',
    `postal_code` STRING COMMENT 'The postal or ZIP code for the agencys primary business address. | Column postal_code (STRING) in talent.talent_agency',
    `primary_contact_name` STRING COMMENT 'The name of the primary contact person at the agency for contract negotiations, deal correspondence, and residual remittances. | Column primary_contact_name (STRING) in talent.talent_agency',
    `primary_contact_title` STRING COMMENT 'The job title or role of the primary contact person (e.g., President, Partner, Agent, Business Affairs Manager). | Column primary_contact_title (STRING) in talent.talent_agency',
    `primary_email` STRING COMMENT 'The primary email address for official correspondence, contract delivery, and residual payment notifications. | Column primary_email (STRING) in talent.talent_agency. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'The primary telephone number for the agency, including country and area codes. | Column primary_phone (STRING) in talent.talent_agency',
    `roster_size` STRING COMMENT 'The approximate number of talent clients currently represented by the agency. Used for agency scale assessment and negotiation context. | Column roster_size (INT) in talent.talent_agency',
    `source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in talent.talent_agency',
    `specialization` STRING COMMENT 'The primary area of talent specialization or focus for the agency (e.g., film and television actors, commercial talent, voice-over artists, writers, directors, below-the-line crew, music artists). Free-text field to accommodate multiple specializations. | Column specialization (STRING) in talent.talent_agency',
    `standard_commission_rate` DECIMAL(18,2) COMMENT 'The standard commission rate percentage that the agency charges for talent representation, typically 10% for franchised agencies under SAG-AFTRA rules. Expressed as a percentage (e.g., 10.00 for 10%). | Column standard_commission_rate (DECIMAL(5,2)) in talent.talent_agency',
    `state_province` STRING COMMENT 'The state, province, or region where the agencys primary office is located. Use standard two-letter codes where applicable. | Column state_province (STRING) in talent.talent_agency',
    `status_effective_date` DATE COMMENT 'The date on which the current status became effective. | Column status_effective_date (DATE) in talent.talent_agency',
    `talent_agency_status` STRING COMMENT 'The current operational status of the talent agency: active (currently representing talent), inactive (not currently operating), suspended (temporarily not authorized), pending_verification (under review), or dissolved (permanently closed). | Column talent_agency_status (STRING) in talent.talent_agency. Valid values are `active|inactive|suspended|pending_verification|dissolved`',
    `tax_identifier` STRING COMMENT 'The tax identification number (EIN in the US, VAT number in EU) for the agency, used for tax reporting and residual payment processing. | Column tax_identifier (STRING) in talent.talent_agency',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in talent.talent_agency',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this talent agency record was last modified. Updated automatically on any change to the record. | Column updated_timestamp (TIMESTAMP) in talent.talent_agency',
    `verification_date` DATE COMMENT 'The date on which the agency information was last verified for accuracy and currency, typically through direct contact or regulatory registry check. | Column verification_date (DATE) in talent.talent_agency',
    `website_url` STRING COMMENT 'The primary website URL for the talent agency, used for public information and talent roster visibility. | Column website_url (STRING) in talent.talent_agency',
    CONSTRAINT pk_talent_agency PRIMARY KEY(`talent_agency_id`)
) COMMENT 'Master record for talent representation agencies and management companies — capturing agency legal name, agency type (talent agency, literary agency, management company, law firm), primary contact, address, phone, email, franchise status (SAG-AFTRA franchised agency flag), commission rate standard, and active/inactive status. Serves as the reference for routing deal negotiations, contract correspondence, and residual remittances to the correct representative. Distinct from the partner domain which manages distribution and content partners. | Unity Catalog table: media_broadcasting_ecm.talent.talent_agency Talent/residuals entity supporting contract+compensation_structure+guild_affiliation+cba_rate_card+residual_payment flows.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` (
    `representation_agreement_id` BIGINT COMMENT 'Unique identifier for the representation agreement record. Primary key. | Column representation_agreement_id (BIGINT) in talent.representation_agreement',
    `talent_agency_id` BIGINT COMMENT 'Foreign key linking to talent.talent_agency. Business justification: representation_agreement currently has agency_name (STRING) duplicating data from talent_agency. Adding FK enables normalization - agency legal name, DBA name, contact details, and franchise status sh | Column talent_agency_id (BIGINT) in talent.representation_agreement',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent being represented under this agreement. | Column talent_profile_id (BIGINT) in talent.representation_agreement',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in talent.representation_agreement',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in talent.representation_agreement',
    `agent_contact_email` STRING COMMENT 'Primary email address for the agent or representative, used for deal negotiation and residual routing communications. | Column agent_contact_email (STRING) in talent.representation_agreement. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `agent_contact_phone` STRING COMMENT 'Primary phone number for the agent or representative. | Column agent_contact_phone (STRING) in talent.representation_agreement',
    `agent_name` STRING COMMENT 'Full name of the individual agent, manager, or attorney assigned as primary contact for this representation. | Column agent_name (STRING) in talent.representation_agreement',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for this representation agreement, used for contract reference and audit trails. | Column agreement_number (STRING) in talent.representation_agreement',
    `commission_cap_amount` DECIMAL(18,2) COMMENT 'Maximum commission amount per engagement or per year, if a cap is specified in the agreement. Null if no cap applies. | Column commission_cap_amount (DECIMAL(15,2)) in talent.representation_agreement',
    `commission_percentage` DECIMAL(18,2) COMMENT 'Percentage of talent earnings paid to the representative as commission (typically 10% for agents, 15% for managers per industry standards). | Column commission_percentage (DECIMAL(5,2)) in talent.representation_agreement',
    `contract_document_uri` STRING COMMENT 'URI or file path to the signed representation agreement contract document stored in the Media Asset Management (MAM) system or document repository. | Column contract_document_uri (STRING) in talent.representation_agreement',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in talent.representation_agreement',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this representation agreement record was first created in the system. | Column created_timestamp (TIMESTAMP) in talent.representation_agreement',
    `effective_end_date` DATE COMMENT 'Date when the representation agreement expires or terminates. Null for open-ended agreements. | Column effective_end_date (DATE) in talent.representation_agreement',
    `effective_start_date` DATE COMMENT 'Date when the representation agreement becomes binding and the representative begins acting on behalf of the talent. | Column effective_start_date (DATE) in talent.representation_agreement',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this representation is exclusive (true) or non-exclusive (false). Exclusive agreements prohibit the talent from engaging other representatives in the same category and territory. | Column exclusivity_flag (BOOLEAN) in talent.representation_agreement',
    `guild_franchise_flag` BOOLEAN COMMENT 'Indicates whether the agency or representative is franchised by a talent guild (SAG-AFTRA, WGA, DGA). Franchised agents must comply with guild-mandated commission caps and contract terms. | Column guild_franchise_flag (BOOLEAN) in talent.representation_agreement',
    `notes` STRING COMMENT 'Free-text notes capturing special clauses, amendments, or contextual information about the representation agreement. | Column notes (STRING) in talent.representation_agreement',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes an automatic renewal option or requires explicit renegotiation at expiration. | Column renewal_option_flag (BOOLEAN) in talent.representation_agreement',
    `renewal_terms` STRING COMMENT 'Description of renewal terms if renewal_option_flag is true, including renewal period length and any modified commission rates. | Column renewal_terms (STRING) in talent.representation_agreement',
    `representation_agreement_status` STRING COMMENT 'Current lifecycle status of the representation agreement: active (in force), expired (end date reached), terminated (ended early by either party), suspended (temporarily inactive), or pending (signed but not yet effective). | Column representation_agreement_status (STRING) in talent.representation_agreement. Valid values are `active|expired|terminated|suspended|pending`',
    `representation_type` STRING COMMENT 'Classification of the representation relationship: exclusive agent (sole representation), co-agent (shared representation), manager (career management), entertainment attorney (legal counsel), business manager (financial management), or publicist (public relations). | Column representation_type (STRING) in talent.representation_agreement. Valid values are `exclusive_agent|co_agent|manager|entertainment_attorney|business_manager|publicist`',
    `residual_routing_flag` BOOLEAN COMMENT 'Indicates whether residual payments for work performed during this representation period should be routed through this representative for commission deduction. | Column residual_routing_flag (BOOLEAN) in talent.representation_agreement',
    `scope_of_services` STRING COMMENT 'Detailed description of services the representative will provide: deal negotiation, career guidance, audition scheduling, contract review, brand partnerships, etc. | Column scope_of_services (STRING) in talent.representation_agreement',
    `signing_date` DATE COMMENT 'Date when the representation agreement was signed by both parties. | Column signing_date (DATE) in talent.representation_agreement',
    `source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in talent.representation_agreement',
    `termination_date` DATE COMMENT 'Actual date the representation agreement was terminated, if applicable. Used for residual routing cutoff and historical audit trails. | Column termination_date (DATE) in talent.representation_agreement',
    `termination_notice_period_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the representation agreement (commonly 30, 60, or 90 days). | Column termination_notice_period_days (INT) in talent.representation_agreement',
    `termination_reason` STRING COMMENT 'Reason for early termination of the representation agreement, if applicable. [ENUM-REF-CANDIDATE: mutual_agreement|talent_initiated|agent_initiated|breach_of_contract|expiration|non_performance|conflict_of_interest — 7 candidates stripped; promote to reference product] | Column termination_reason (STRING) in talent.representation_agreement',
    `territory_scope` STRING COMMENT 'Geographic territory or market scope covered by this representation agreement (e.g., worldwide, North America, USA, specific states). Multiple territories may be comma-separated. | Column territory_scope (STRING) in talent.representation_agreement',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in talent.representation_agreement',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this representation agreement record was last modified. | Column updated_timestamp (TIMESTAMP) in talent.representation_agreement',
    CONSTRAINT pk_representation_agreement PRIMARY KEY(`representation_agreement_id`)
) COMMENT 'Records the formal representation relationship between a talent and their agency or management company — capturing representation type (exclusive agent, co-agent, manager, entertainment attorney), territory scope, commission percentage, agreement start and end dates, exclusivity flag, termination notice period, and current status. Tracks historical representation changes to support residual routing and deal negotiation audit trails. A talent may have multiple concurrent representation agreements across different territories or function types. | Unity Catalog table: media_broadcasting_ecm.talent.representation_agreement Talent/residuals entity supporting contract+compensation_structure+guild_affiliation+cba_rate_card+residual_payment flows.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` (
    `clearance_id` BIGINT COMMENT 'Unique identifier for the talent clearance record. Primary key. | Column talent_clearance_id (BIGINT) in talent.talent_clearance',
    `ad_order_id` BIGINT COMMENT 'Foreign key linking to sales.ad_order. Business justification: Ad orders featuring talent likeness, name, or performance require talent clearance before airing. Linking talent_clearance to ad_order enables compliance teams to confirm clearance status before order',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Talent clearances are often asset-specific (theatrical cut vs TV edit, domestic vs international versions, trailer vs feature). Different assets may require separate clearances based on usage rights,  | Column cleared_media_asset_id (BIGINT) in mediaasset.talent_clearance',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Season-level talent clearance for broadcast scheduling and international distribution — clearance teams track whether talent is cleared for each seasons broadcast window separately, particularly for ',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.contract. Business justification: talent_clearance currently stores a denormalized contract_reference_number (STRING) to identify the governing talent engagement contract. Adding a proper contract_id FK normalizes this relationship, e',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Talent clearance is window/platform-specific in broadcast — a talent may be cleared for streaming but not theatrical. Direct FK to grant_id (which defines platform/window scope) enables grant-specific',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Talent clearances verify that talent usage complies with underlying content license agreement restrictions (territory, platform, window restrictions). Real business process: ensuring talent usage in p | Column license_agreement_id (BIGINT) in rights.talent_clearance',
    `project_id` BIGINT COMMENT 'Reference to the production or content title for which clearance is being requested. | Column production_project_id (BIGINT) in production.talent_clearance',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent whose usage rights are being cleared. | Column talent_profile_id (BIGINT) in talent.talent_clearance',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in talent.talent_clearance',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in talent.talent_clearance',
    `air_date` DATE COMMENT 'Scheduled broadcast or distribution date for the content requiring clearance. | Column air_date (DATE) in talent.talent_clearance',
    `blocking_reason` STRING COMMENT 'Explanation for why clearance was blocked or denied, including contractual, guild, or legal constraints. | Column blocking_reason (STRING) in talent.talent_clearance',
    `clearance_status` STRING COMMENT 'Current state of the clearance request in the approval workflow. | Column clearance_status (STRING) in talent.talent_clearance. Valid values are `pending|cleared|conditionally cleared|blocked|expired|withdrawn`',
    `clearance_type` STRING COMMENT 'Category of clearance being requested based on the intended usage channel and distribution method. | Column clearance_type (STRING) in talent.talent_clearance. Valid values are `broadcast clearance|promotional clearance|social media clearance|international clearance|theatrical clearance|home video clearance`',
    `conditional_terms` STRING COMMENT 'Specific conditions, restrictions, or requirements that must be met for the clearance to remain valid. | Column conditional_terms (STRING) in talent.talent_clearance',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in talent.talent_clearance',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the clearance record was first created in the system. | Column created_timestamp (TIMESTAMP) in talent.talent_clearance',
    `exclusivity_conflict_flag` BOOLEAN COMMENT 'Indicates whether the requested usage conflicts with existing exclusivity clauses in the talent contract. | Column exclusivity_conflict_flag (BOOLEAN) in talent.talent_clearance',
    `expiry_date` DATE COMMENT 'Date when the granted clearance expires and usage rights are no longer valid. | Column expiry_date (DATE) in talent.talent_clearance',
    `granted_by` STRING COMMENT 'Name or identifier of the individual or department who authorized the clearance. | Column granted_by (STRING) in talent.talent_clearance',
    `granted_date` DATE COMMENT 'Date when the clearance was officially approved and granted for the specified usage. | Column granted_date (DATE) in talent.talent_clearance',
    `guild_clearance_required_flag` BOOLEAN COMMENT 'Indicates whether guild or union clearance is required based on collective bargaining agreement terms. | Column guild_clearance_required_flag (BOOLEAN) in talent.talent_clearance',
    `guild_clearance_status` STRING COMMENT 'Current status of guild or union clearance verification for this usage. | Column guild_clearance_status (STRING) in talent.talent_clearance. Valid values are `not required|pending|approved|denied`',
    `guild_reference_number` STRING COMMENT 'Reference or tracking number provided by the guild or union for this clearance request. | Column guild_reference_number (STRING) in talent.talent_clearance',
    `legal_review_date` DATE COMMENT 'Date when the legal department completed their review of the clearance request. | Column legal_review_date (DATE) in talent.talent_clearance',
    `likeness_usage_flag` BOOLEAN COMMENT 'Indicates whether the clearance includes usage of the talents physical likeness or image. | Column likeness_usage_flag (BOOLEAN) in talent.talent_clearance',
    `name_usage_flag` BOOLEAN COMMENT 'Indicates whether the clearance includes usage of the talents name in promotional or marketing materials. | Column name_usage_flag (BOOLEAN) in talent.talent_clearance',
    `notes` STRING COMMENT 'Additional comments, context, or special instructions related to the clearance request and approval process. | Column notes (STRING) in talent.talent_clearance',
    `performance_usage_flag` BOOLEAN COMMENT 'Indicates whether the clearance includes usage of the talents recorded performance or voice. | Column performance_usage_flag (BOOLEAN) in talent.talent_clearance',
    `priority_level` STRING COMMENT 'Business priority assigned to the clearance request based on production schedules and air dates. | Column priority_level (STRING) in talent.talent_clearance. Valid values are `low|medium|high|urgent`',
    `request_date` DATE COMMENT 'Date when the clearance request was initiated by the production or rights team. | Column request_date (DATE) in talent.talent_clearance',
    `request_number` STRING COMMENT 'Business identifier for the clearance request, used for tracking and reference across systems. | Column request_number (STRING) in talent.talent_clearance',
    `residual_payment_triggered_flag` BOOLEAN COMMENT 'Indicates whether this clearance triggers residual payment obligations under guild agreements. | Column residual_payment_triggered_flag (BOOLEAN) in talent.talent_clearance',
    `reviewed_by_legal_flag` BOOLEAN COMMENT 'Indicates whether the clearance request has been reviewed and approved by the legal department. | Column reviewed_by_legal_flag (BOOLEAN) in talent.talent_clearance',
    `source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in talent.talent_clearance',
    `talent_approval_date` DATE COMMENT 'Date when the talent provided their explicit approval or consent for the specified usage. | Column talent_approval_date (DATE) in talent.talent_clearance',
    `talent_approval_received_flag` BOOLEAN COMMENT 'Indicates whether the required talent approval has been obtained and documented. | Column talent_approval_received_flag (BOOLEAN) in talent.talent_clearance',
    `talent_approval_required_flag` BOOLEAN COMMENT 'Indicates whether explicit talent consent or approval is required before usage can proceed. | Column talent_approval_required_flag (BOOLEAN) in talent.talent_clearance',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in talent.talent_clearance',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the clearance record was last modified or updated. | Column updated_timestamp (TIMESTAMP) in talent.talent_clearance',
    `usage_category` STRING COMMENT 'Classification of the intended usage based on broadcast and distribution business models. | Column usage_category (STRING) in talent.talent_clearance. Valid values are `primary broadcast|rerun|syndication|promotional|archival|clip licensing`',
    CONSTRAINT pk_clearance PRIMARY KEY(`clearance_id`)
) COMMENT 'Records the rights clearance verification process for talent likeness, name, and performance usage in a specific production or campaign — capturing clearance request date, clearance type (broadcast clearance, promotional clearance, social media clearance, international clearance), clearance status (pending, cleared, conditionally cleared, blocked), blocking reason, clearance granted by, clearance expiry date, and any required talent approval or consent. Ensures talent usage complies with contractual, guild, and regulatory obligations before content goes to air or distribution. | Unity Catalog table: media_broadcasting_ecm.talent.talent_clearance Talent/residuals entity supporting contract+compensation_structure+guild_affiliation+cba_rate_card+residual_payment flows.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ADD CONSTRAINT `fk_talent_talent_profile_talent_agency_id` FOREIGN KEY (`talent_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_agency`(`talent_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_representation_agreement_id` FOREIGN KEY (`representation_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`representation_agreement`(`representation_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ADD CONSTRAINT `fk_talent_compensation_structure_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ADD CONSTRAINT `fk_talent_residual_eligibility_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ADD CONSTRAINT `fk_talent_residual_eligibility_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`role`(`role_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ADD CONSTRAINT `fk_talent_residual_eligibility_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_residual_eligibility_id` FOREIGN KEY (`residual_eligibility_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility`(`residual_eligibility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_representation_agreement_id` FOREIGN KEY (`representation_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`representation_agreement`(`representation_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ADD CONSTRAINT `fk_talent_representation_agreement_talent_agency_id` FOREIGN KEY (`talent_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_agency`(`talent_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ADD CONSTRAINT `fk_talent_representation_agreement_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ADD CONSTRAINT `fk_talent_clearance_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ADD CONSTRAINT `fk_talent_clearance_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`talent` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`talent` SET TAGS ('dbx_domain' = 'talent');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` SET TAGS ('dbx_subdomain' = 'talent_identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Demo Reel Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Agency Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.talent_agency_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.talent_agency_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `biometric_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Biometric Data Consent Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `biometric_consent_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `biometric_consent_flag` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `biometric_consent_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `biometric_consent_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.biometric_consent_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `biometric_consent_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.biometric_consent_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.ccpa_opt_out_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.ccpa_opt_out_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `clearance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `clearance_expiration_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `clearance_expiration_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.clearance_expiration_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `clearance_expiration_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.clearance_expiration_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Talent Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|restricted|blocked|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `clearance_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `clearance_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `clearance_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `clearance_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.date_of_birth');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.date_of_birth');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_validation_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.email_address');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.email_address');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `exclusivity_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Clause Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `exclusivity_clause_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `exclusivity_clause_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.exclusivity_clause_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `exclusivity_clause_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.exclusivity_clause_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `gdpr_consent_status` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `gdpr_consent_status` SET TAGS ('dbx_value_regex' = 'consented|withdrawn|not_applicable|pending');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `gdpr_consent_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `gdpr_consent_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.gdpr_consent_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `gdpr_consent_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.gdpr_consent_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `gdpr_consent_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_business_glossary_term' = 'Gender Identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say|other');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.gender_identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.gender_identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `imdb_identifier` SET TAGS ('dbx_business_glossary_term' = 'Internet Movie Database (IMDb) Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `imdb_identifier` SET TAGS ('dbx_value_regex' = '^nm[0-9]{7,8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `imdb_identifier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `imdb_identifier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.imdb_identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `imdb_identifier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.imdb_identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `insurance_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `insurance_coverage_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `insurance_coverage_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.insurance_coverage_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `insurance_coverage_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.insurance_coverage_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.insurance_policy_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.insurance_policy_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `isni_code` SET TAGS ('dbx_business_glossary_term' = 'International Standard Name Identifier (ISNI) Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `isni_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4} [0-9]{4} [0-9]{4} [0-9]{3}[0-9X]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `isni_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `isni_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.isni_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `isni_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.isni_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `isni_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Full Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.legal_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.legal_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Nationality Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `nationality` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `nationality` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `nationality` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.nationality');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `nationality` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.nationality');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_validation_regex' = '^+?[1-9]d{1');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_14}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.phone_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.phone_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `primary_language` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `primary_language` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.primary_language');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `primary_language` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.primary_language');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `primary_language` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|retired|deceased');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.profile_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.profile_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Payment Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.residual_eligibility_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.residual_eligibility_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `stage_name` SET TAGS ('dbx_business_glossary_term' = 'Stage Name or Professional Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `stage_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `stage_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `stage_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.stage_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `stage_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.stage_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_tier` SET TAGS ('dbx_business_glossary_term' = 'Talent Tier Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_tier` SET TAGS ('dbx_value_regex' = 'a_list|b_list|c_list|emerging|supporting|background');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.talent_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.talent_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_type` SET TAGS ('dbx_business_glossary_term' = 'Talent Type or Role Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.talent_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.talent_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.tax_id_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.tax_id_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union or Guild Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_value_regex' = 'sag_aftra|wga|dga|iatse|non_union|multiple');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.union_affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.union_affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `union_member_number` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `union_member_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `union_member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `union_member_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `union_member_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.union_member_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `union_member_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.union_member_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_value_regex' = 'citizen|permanent_resident|work_visa|pending|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.work_authorization_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.work_authorization_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `work_visa_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Work Visa Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `work_visa_expiration_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `work_visa_expiration_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.work_visa_expiration_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `work_visa_expiration_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.work_visa_expiration_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `work_visa_type` SET TAGS ('dbx_business_glossary_term' = 'Work Visa Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `work_visa_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `work_visa_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_profile.work_visa_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `work_visa_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_profile.work_visa_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `work_visa_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` SET TAGS ('dbx_subdomain' = 'contract_engagement');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.contract_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.contract_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `representation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Representation Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `series_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `series_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.series_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `series_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.series_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `adjusted_gross_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Gross Participation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.amendment_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.amendment_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `backend_participation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Backend Participation Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `backend_participation_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `backend_participation_percentage` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `backend_participation_percentage` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.backend_participation_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `backend_participation_percentage` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.backend_participation_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `backend_participation_type` SET TAGS ('dbx_business_glossary_term' = 'Backend Participation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `backend_participation_type` SET TAGS ('dbx_value_regex' = 'net_profits|adjusted_gross|gross_receipts|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `backend_participation_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `backend_participation_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.backend_participation_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `backend_participation_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.backend_participation_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `backend_participation_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `base_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Compensation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `base_compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `base_compensation_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `base_compensation_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.base_compensation_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `base_compensation_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.base_compensation_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `billing_credit_position` SET TAGS ('dbx_business_glossary_term' = 'Billing Credit Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `billing_credit_position` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `billing_credit_position` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.billing_credit_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `billing_credit_position` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.billing_credit_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.compensation_currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.compensation_currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_value_regex' = 'flat_fee|per_episode|weekly_rate|annual_salary|day_rate|hourly_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.compensation_structure');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.compensation_structure');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contingent_compensation_flag` SET TAGS ('dbx_business_glossary_term' = 'Contingent Compensation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contingent_compensation_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contingent_compensation_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.contract_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.contract_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Lifecycle Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.contract_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.contract_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.contract_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.contract_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `credit_placement_requirements` SET TAGS ('dbx_business_glossary_term' = 'Credit Placement Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `credit_placement_requirements` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `credit_placement_requirements` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.credit_placement_requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `credit_placement_requirements` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.credit_placement_requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `credit_size_percentage` SET TAGS ('dbx_business_glossary_term' = 'Credit Size Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `credit_size_percentage` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `credit_size_percentage` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.credit_size_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `credit_size_percentage` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.credit_size_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `document_reference_uri` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference Uniform Resource Identifier (URI)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `document_reference_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `document_reference_uri` SET TAGS ('dbx_validation_regex_^https?' = '//[^s]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `document_reference_uri` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `document_reference_uri` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.document_reference_uri');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `document_reference_uri` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.document_reference_uri');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.effective_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.effective_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.effective_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.effective_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `engagement_role` SET TAGS ('dbx_business_glossary_term' = 'Engagement Role');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `engagement_role` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `engagement_role` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.engagement_role');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `engagement_role` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.engagement_role');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Clause Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.exclusivity_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.exclusivity_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.exclusivity_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.exclusivity_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `governing_cba` SET TAGS ('dbx_business_glossary_term' = 'Governing Collective Bargaining Agreement (CBA)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `governing_cba` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `governing_cba` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.governing_cba');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `governing_cba` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.governing_cba');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `gross_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Gross Participation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `guaranteed_episodes` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Episode Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `guaranteed_episodes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `guaranteed_episodes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.guaranteed_episodes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `guaranteed_episodes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.guaranteed_episodes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_value_regex' = 'SAG-AFTRA|WGA|DGA|IATSE|non_union|multiple');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.guild_affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.guild_affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.holdback_period_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.holdback_period_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.last_amendment_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.last_amendment_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `net_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Participation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `option_exercise_deadline` SET TAGS ('dbx_business_glossary_term' = 'Option Exercise Deadline Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `option_exercise_deadline` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `option_exercise_deadline` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.option_exercise_deadline');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `option_exercise_deadline` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.option_exercise_deadline');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `option_exercise_status` SET TAGS ('dbx_business_glossary_term' = 'Option Exercise Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `option_exercise_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|exercised|declined|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `option_exercise_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `option_exercise_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.option_exercise_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `option_exercise_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.option_exercise_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `option_exercise_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `option_periods_count` SET TAGS ('dbx_business_glossary_term' = 'Option Periods Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `option_periods_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `option_periods_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.option_periods_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `option_periods_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.option_periods_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `pay_or_play_flag` SET TAGS ('dbx_business_glossary_term' = 'Pay-or-Play Clause Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `pay_or_play_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `pay_or_play_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.pay_or_play_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `pay_or_play_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.pay_or_play_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.residual_eligibility_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.residual_eligibility_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_business_glossary_term' = 'Step-Up Compensation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.step_up_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.step_up_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.termination_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.termination_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.termination_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.termination_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.contract.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.contract.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` SET TAGS ('dbx_subdomain' = 'contract_engagement');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.compensation_structure_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.compensation_structure_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `contract_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `contract_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.contract_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `contract_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.contract_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `backend_gross_participation_pct` SET TAGS ('dbx_business_glossary_term' = 'Backend Gross Participation Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `backend_gross_participation_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `backend_gross_participation_pct` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `backend_gross_participation_pct` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.backend_gross_participation_pct');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `backend_gross_participation_pct` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.backend_gross_participation_pct');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `base_episode_fee` SET TAGS ('dbx_business_glossary_term' = 'Base Episode Fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `base_episode_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `base_episode_fee` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `base_episode_fee` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.base_episode_fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `base_episode_fee` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.base_episode_fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.bonus_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.bonus_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `bonus_threshold_description` SET TAGS ('dbx_business_glossary_term' = 'Bonus Threshold Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `bonus_threshold_description` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `bonus_threshold_description` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.bonus_threshold_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `bonus_threshold_description` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.bonus_threshold_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `breakeven_definition` SET TAGS ('dbx_business_glossary_term' = 'Breakeven Definition');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.compensation_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.compensation_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `daily_rate` SET TAGS ('dbx_business_glossary_term' = 'Daily Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `daily_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `daily_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `daily_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.daily_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `daily_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.daily_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Compensation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_compensation_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_compensation_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.deferred_compensation_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_compensation_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.deferred_compensation_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_payment_trigger` SET TAGS ('dbx_business_glossary_term' = 'Deferred Payment Trigger');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_payment_trigger` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_payment_trigger` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.deferred_payment_trigger');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_payment_trigger` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.deferred_payment_trigger');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.effective_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.effective_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.effective_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.effective_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `exclusivity_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Clause Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `exclusivity_clause_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `exclusivity_clause_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.exclusivity_clause_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `exclusivity_clause_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.exclusivity_clause_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_value_regex' = 'SAG-AFTRA|WGA|DGA|IATSE|non_union');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.guild_affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.guild_affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Multiplier');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.overtime_multiplier');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.overtime_multiplier');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `participation_ceiling_amount` SET TAGS ('dbx_business_glossary_term' = 'Participation Ceiling Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `participation_definition_type` SET TAGS ('dbx_business_glossary_term' = 'Participation Definition Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `participation_floor_amount` SET TAGS ('dbx_business_glossary_term' = 'Participation Floor Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `participation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Participation Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pay_or_play_flag` SET TAGS ('dbx_business_glossary_term' = 'Pay-or-Play Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pay_or_play_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pay_or_play_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.pay_or_play_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pay_or_play_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.pay_or_play_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pension_health_rate` SET TAGS ('dbx_business_glossary_term' = 'Pension and Health (P&H) Contribution Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pension_health_rate` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pension_health_rate` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pension_health_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pension_health_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.pension_health_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pension_health_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.pension_health_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `residual_base_formula` SET TAGS ('dbx_business_glossary_term' = 'Residual Base Formula');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `residual_base_formula` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `residual_base_formula` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.residual_base_formula');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `residual_base_formula` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.residual_base_formula');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.residual_eligibility_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.residual_eligibility_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_business_glossary_term' = 'Step-Up Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.step_up_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.step_up_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `step_up_trigger` SET TAGS ('dbx_business_glossary_term' = 'Step-Up Trigger');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `step_up_trigger` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `step_up_trigger` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.step_up_trigger');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `step_up_trigger` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.step_up_trigger');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `structure_name` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `structure_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `structure_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `structure_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.structure_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `structure_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.structure_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `structure_status` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `structure_status` SET TAGS ('dbx_value_regex' = 'draft|active|amended|superseded|terminated');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `structure_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `structure_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.structure_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `structure_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.structure_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `structure_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `usage_rights_scope` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `usage_rights_scope` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `usage_rights_scope` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.usage_rights_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `usage_rights_scope` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.usage_rights_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `weekly_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Weekly Guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `weekly_guarantee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `weekly_guarantee` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `weekly_guarantee` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.compensation_structure.weekly_guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `weekly_guarantee` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.compensation_structure.weekly_guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` SET TAGS ('dbx_subdomain' = 'residual_payments');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_eligibility_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_eligibility_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.residual_eligibility_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_eligibility_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.residual_eligibility_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `contract_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `contract_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.contract_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `contract_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.contract_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Role Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `backend_participation_type` SET TAGS ('dbx_business_glossary_term' = 'Backend Participation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `buyout_amount` SET TAGS ('dbx_business_glossary_term' = 'Buyout Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `buyout_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `buyout_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.buyout_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `buyout_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.buyout_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `buyout_applied` SET TAGS ('dbx_business_glossary_term' = 'Buyout Applied');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `buyout_applied` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `buyout_applied` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.buyout_applied');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `buyout_applied` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.buyout_applied');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `distribution_window` SET TAGS ('dbx_business_glossary_term' = 'Distribution Window');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `distribution_window` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `distribution_window` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.distribution_window');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `distribution_window` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.distribution_window');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.effective_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.effective_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.effective_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.effective_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `eligibility_determination_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Determination Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `eligibility_determination_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `eligibility_determination_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.eligibility_determination_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `eligibility_determination_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.eligibility_determination_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'Eligible|Ineligible|Pending Review|Disputed|Waived|Expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.eligibility_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.eligibility_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `exclusivity_clause_applies` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Clause Applies');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `exclusivity_clause_applies` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `exclusivity_clause_applies` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.exclusivity_clause_applies');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `exclusivity_clause_applies` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.exclusivity_clause_applies');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_value_regex' = 'SAG-AFTRA|WGA|DGA|IATSE|AFM|Non-Guild');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.guild_affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.guild_affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `health_contribution_applicable` SET TAGS ('dbx_business_glossary_term' = 'Health Contribution Applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `health_contribution_applicable` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `health_contribution_applicable` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `health_contribution_applicable` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `health_contribution_applicable` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.health_contribution_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `health_contribution_applicable` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.health_contribution_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `health_contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Health Contribution Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `health_contribution_rate` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `health_contribution_rate` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `health_contribution_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `health_contribution_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.health_contribution_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `health_contribution_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.health_contribution_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `minimum_residual_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Residual Threshold');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `minimum_residual_threshold` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `minimum_residual_threshold` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.minimum_residual_threshold');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `minimum_residual_threshold` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.minimum_residual_threshold');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `participation_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Participation Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'Per Use|Quarterly|Semi-Annual|Annual|One-Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.payment_frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.payment_frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `pension_contribution_applicable` SET TAGS ('dbx_business_glossary_term' = 'Pension Contribution Applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `pension_contribution_applicable` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `pension_contribution_applicable` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.pension_contribution_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `pension_contribution_applicable` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.pension_contribution_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `pension_contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Pension Contribution Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `pension_contribution_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `pension_contribution_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.pension_contribution_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `pension_contribution_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.pension_contribution_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Residual Base Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_base_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_base_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.residual_base_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_base_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.residual_base_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_formula_type` SET TAGS ('dbx_business_glossary_term' = 'Residual Formula Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_formula_type` SET TAGS ('dbx_value_regex' = 'SAG-AFTRA TV Residuals|Theatrical Residuals|New Media Residuals|Streaming Supplemental|Foreign Broadcast Residuals|Home Video Residuals');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_formula_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_formula_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.residual_formula_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_formula_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.residual_formula_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_formula_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_percentage` SET TAGS ('dbx_business_glossary_term' = 'Residual Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_percentage` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_percentage` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.residual_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_percentage` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.residual_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `rightsline_integration_code` SET TAGS ('dbx_business_glossary_term' = 'Rightsline Integration ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `rightsline_integration_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `rightsline_integration_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.rightsline_integration_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `rightsline_integration_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.rightsline_integration_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `rightsline_integration_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `sap_payables_reference` SET TAGS ('dbx_business_glossary_term' = 'SAP Payables Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `sap_payables_reference` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `sap_payables_reference` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.sap_payables_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `sap_payables_reference` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.sap_payables_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `territory` SET TAGS ('dbx_business_glossary_term' = 'Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `territory` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `territory` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `territory` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `updated_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `updated_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.updated_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `updated_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.updated_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `use_type` SET TAGS ('dbx_business_glossary_term' = 'Use Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `use_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `use_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.use_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `use_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.use_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `use_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `created_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `created_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_eligibility.created_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `created_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_eligibility.created_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` SET TAGS ('dbx_subdomain' = 'residual_payments');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `residual_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Residual Payment ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `residual_payment_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `residual_payment_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.residual_payment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `residual_payment_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.residual_payment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `contract_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `contract_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.contract_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `contract_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.contract_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `residual_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `residual_eligibility_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `residual_eligibility_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.residual_eligibility_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `residual_eligibility_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.residual_eligibility_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `royalty_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Statement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_business_glossary_term' = 'Automated Clearing House (ACH) Trace Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.ach_trace_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.ach_trace_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `agent_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Agent Commission Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `agent_commission_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `agent_commission_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.agent_commission_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `agent_commission_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.agent_commission_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `audit_report_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `audit_report_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `audit_report_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.audit_report_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `audit_report_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.audit_report_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `audit_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `audit_report_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `audit_report_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.audit_report_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `audit_report_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.audit_report_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.check_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.check_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `distribution_window` SET TAGS ('dbx_business_glossary_term' = 'Distribution Window');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `distribution_window` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `distribution_window` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.distribution_window');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `distribution_window` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.distribution_window');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `exhibition_end_date` SET TAGS ('dbx_business_glossary_term' = 'Exhibition End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `exhibition_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `exhibition_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.exhibition_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `exhibition_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.exhibition_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `exhibition_start_date` SET TAGS ('dbx_business_glossary_term' = 'Exhibition Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `exhibition_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `exhibition_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.exhibition_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `exhibition_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.exhibition_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `gross_residual_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Residual Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `gross_residual_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `gross_residual_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.gross_residual_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `gross_residual_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.gross_residual_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_value_regex' = 'SAG-AFTRA|WGA|DGA|IATSE|AFM|non_union');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.guild_affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.guild_affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.net_payment_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.net_payment_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.payment_currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.payment_currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.payment_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.payment_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|ACH|wire_transfer|direct_deposit|payroll');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.payment_method');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.payment_method');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.payment_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.payment_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.payment_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.payment_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|processed|paid|cancelled|on_hold');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.payment_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.payment_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `pension_health_amount` SET TAGS ('dbx_business_glossary_term' = 'Pension and Health (P&H) Contribution Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `pension_health_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `pension_health_amount` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `pension_health_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `pension_health_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.pension_health_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `pension_health_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.pension_health_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `remittance_advice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Sent Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `remittance_advice_sent_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `remittance_advice_sent_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.remittance_advice_sent_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `remittance_advice_sent_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.remittance_advice_sent_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `remittance_advice_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Sent Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `remittance_advice_sent_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `remittance_advice_sent_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.remittance_advice_sent_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `remittance_advice_sent_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.remittance_advice_sent_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `use_type` SET TAGS ('dbx_business_glossary_term' = 'Use Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `use_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `use_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.use_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `use_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.use_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `use_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `wire_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Wire Transfer Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `wire_reference_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `wire_reference_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.wire_reference_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `wire_reference_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.wire_reference_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.residual_payment.withholding_tax_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.residual_payment.withholding_tax_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` SET TAGS ('dbx_subdomain' = 'contract_engagement');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Deal Memo ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.deal_memo_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.deal_memo_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `advertising_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Long-Form Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `contract_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `contract_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.long_form_contract_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `contract_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.long_form_contract_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Production Title ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `title_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `title_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.production_title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `title_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.production_title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `representation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Representation Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `series_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `series_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.series_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `series_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.series_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Source Opportunity ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.source_opportunity_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.source_opportunity_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.compensation_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.compensation_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.compensation_currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.compensation_currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_summary` SET TAGS ('dbx_business_glossary_term' = 'Compensation Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_summary` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_summary` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.compensation_summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_summary` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.compensation_summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `countersigned_date` SET TAGS ('dbx_business_glossary_term' = 'Countersigned Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `countersigned_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `countersigned_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.countersigned_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `countersigned_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.countersigned_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `credit_position` SET TAGS ('dbx_business_glossary_term' = 'Credit Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `credit_position` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `credit_position` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.credit_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `credit_position` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.credit_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.deal_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.deal_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Deal Memo Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_number` SET TAGS ('dbx_value_regex' = '^DM-[0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.deal_memo_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.deal_memo_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_status` SET TAGS ('dbx_business_glossary_term' = 'Deal Memo Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_status` SET TAGS ('dbx_value_regex' = 'draft|countersigned|superseded_by_long_form|expired|cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.deal_memo_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.deal_memo_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Memo Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `effective_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `effective_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.effective_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `effective_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.effective_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.engagement_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.engagement_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.engagement_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.engagement_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `episode_count` SET TAGS ('dbx_business_glossary_term' = 'Episode Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `episode_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `episode_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.episode_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `episode_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.episode_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `exclusivity_summary` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `exclusivity_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `exclusivity_summary` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `exclusivity_summary` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.exclusivity_summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `exclusivity_summary` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.exclusivity_summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Memo Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `expiration_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `expiration_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.expiration_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `expiration_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.expiration_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_value_regex' = 'SAG-AFTRA|DGA|WGA|IATSE|non_union');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.guild_affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.guild_affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.last_modified_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.last_modified_by_user');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deal Memo Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `option_terms` SET TAGS ('dbx_business_glossary_term' = 'Option Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `option_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `option_terms` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `option_terms` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.option_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `option_terms` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.option_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.residual_eligibility_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.residual_eligibility_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `role_function` SET TAGS ('dbx_business_glossary_term' = 'Role or Function');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `role_function` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `role_function` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.role_function');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `role_function` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.role_function');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Superseded Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `superseded_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `superseded_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.superseded_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `superseded_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.superseded_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.deal_memo.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.deal_memo.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` SET TAGS ('dbx_subdomain' = 'talent_identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Role ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.role_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.role_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `contract_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `contract_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.contract_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `contract_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.contract_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `season_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `season_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.season_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `season_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.season_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `series_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `series_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.series_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `series_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.series_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `above_the_line_flag` SET TAGS ('dbx_business_glossary_term' = 'Above-The-Line Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `above_the_line_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `above_the_line_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.above_the_line_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `above_the_line_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.above_the_line_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `appearance_count` SET TAGS ('dbx_business_glossary_term' = 'Appearance Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `appearance_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `appearance_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.appearance_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `appearance_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.appearance_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `billing_position` SET TAGS ('dbx_business_glossary_term' = 'Billing Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `billing_position` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `billing_position` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.billing_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `billing_position` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.billing_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_category` SET TAGS ('dbx_business_glossary_term' = 'Role Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_category` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_category` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.role_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_category` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.role_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_category` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `character_name` SET TAGS ('dbx_business_glossary_term' = 'Character Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `character_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `character_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `character_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.character_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `character_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.character_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.compensation_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.compensation_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.compensation_currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.compensation_currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.compensation_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.compensation_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `credit_text` SET TAGS ('dbx_business_glossary_term' = 'Credit Text');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `credit_text` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `credit_text` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.credit_text');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `credit_text` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.credit_text');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `credit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `credit_type` SET TAGS ('dbx_value_regex' = 'opening_credits|closing_credits|main_titles|end_titles|special_thanks|no_credit');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `credit_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `credit_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.credit_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `credit_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.credit_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `credit_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Role End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `episode_scope_end` SET TAGS ('dbx_business_glossary_term' = 'Episode Scope End');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `episode_scope_end` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `episode_scope_end` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.episode_scope_end');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `episode_scope_end` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.episode_scope_end');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `episode_scope_start` SET TAGS ('dbx_business_glossary_term' = 'Episode Scope Start');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `episode_scope_start` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `episode_scope_start` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.episode_scope_start');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `episode_scope_start` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.episode_scope_start');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.exclusivity_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.exclusivity_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.exclusivity_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.exclusivity_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.guild_affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.guild_affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_name` SET TAGS ('dbx_business_glossary_term' = 'Role Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.role_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.role_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Role Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `residual_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `residual_eligible_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `residual_eligible_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.residual_eligible_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `residual_eligible_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.residual_eligible_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `residual_rate_code` SET TAGS ('dbx_business_glossary_term' = 'Residual Rate Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `residual_rate_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `residual_rate_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.residual_rate_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `residual_rate_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.residual_rate_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `residual_rate_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_status` SET TAGS ('dbx_business_glossary_term' = 'Role Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.role_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.role_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `screen_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Screen Time Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `screen_time_minutes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `screen_time_minutes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.screen_time_minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `screen_time_minutes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.screen_time_minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Role Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `stunt_double_flag` SET TAGS ('dbx_business_glossary_term' = 'Stunt Double Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `stunt_double_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `stunt_double_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.stunt_double_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `stunt_double_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.stunt_double_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_duration_years` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Duration Years');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_duration_years` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_duration_years` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.usage_rights_duration_years');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_duration_years` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.usage_rights_duration_years');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_media` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Media');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_media` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_media` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.usage_rights_media');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_media` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.usage_rights_media');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_territory` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_territory` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_territory` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.usage_rights_territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_territory` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.usage_rights_territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `voice_only_flag` SET TAGS ('dbx_business_glossary_term' = 'Voice Only Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `voice_only_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `voice_only_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.role.voice_only_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `voice_only_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.role.voice_only_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` SET TAGS ('dbx_subdomain' = 'talent_identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Agency Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.talent_agency_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.talent_agency_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.address_line_1');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.address_line_1');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.address_line_2');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.address_line_2');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_business_glossary_term' = 'Agency Type Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_value_regex' = 'talent_agency|literary_agency|management_company|law_firm|publicity_firm|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.agency_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.agency_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.bank_account_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.bank_account_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.bank_account_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.bank_account_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.bank_routing_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.bank_routing_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `city` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `city` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.city');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `city` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.city');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `country_code` SET TAGS ('dbx_validation_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `country_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `country_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.country_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `country_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.country_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `country_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `dba_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `dba_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `dba_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.dba_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `dba_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.dba_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Established Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `established_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `established_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.established_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `established_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.established_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_validation_regex' = '^+?[1-9]d{1');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_14}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.fax_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.fax_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_effective_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_effective_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.franchise_effective_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_effective_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.franchise_effective_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_expiration_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_expiration_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.franchise_expiration_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_expiration_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.franchise_expiration_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_number` SET TAGS ('dbx_business_glossary_term' = 'SAG-AFTRA Franchise Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.franchise_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.franchise_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_status` SET TAGS ('dbx_business_glossary_term' = 'SAG-AFTRA Franchise Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_status` SET TAGS ('dbx_value_regex' = 'franchised|non_franchised|pending|revoked|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.franchise_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.franchise_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Legal Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `legal_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `legal_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `legal_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.legal_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `legal_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.legal_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_effective_date` SET TAGS ('dbx_business_glossary_term' = 'License Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_effective_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_effective_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.license_effective_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_effective_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.license_effective_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.license_expiration_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.license_expiration_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'State Talent Agency License Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.license_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.license_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_state` SET TAGS ('dbx_business_glossary_term' = 'Licensing State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_state` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_state` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.license_state');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_state` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.license_state');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agency Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `payment_terms` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `payment_terms` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.payment_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `payment_terms` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.payment_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.postal_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.postal_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.primary_contact_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.primary_contact_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.primary_contact_title');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.primary_contact_title');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_validation_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.primary_email');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.primary_email');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_validation_regex' = '^+?[1-9]d{1');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_14}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.primary_phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.primary_phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `roster_size` SET TAGS ('dbx_business_glossary_term' = 'Talent Roster Size');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `roster_size` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `roster_size` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.roster_size');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `roster_size` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.roster_size');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `specialization` SET TAGS ('dbx_business_glossary_term' = 'Agency Specialization');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `specialization` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `specialization` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.specialization');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `specialization` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.specialization');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `standard_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Standard Commission Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `standard_commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `standard_commission_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `standard_commission_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.standard_commission_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `standard_commission_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.standard_commission_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.state_province');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.state_province');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `status_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `status_effective_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `status_effective_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.status_effective_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `status_effective_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.status_effective_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `talent_agency_status` SET TAGS ('dbx_business_glossary_term' = 'Agency Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `talent_agency_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_verification|dissolved');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `talent_agency_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `talent_agency_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.talent_agency_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `talent_agency_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.talent_agency_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `talent_agency_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.tax_identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.tax_identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `verification_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `verification_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.verification_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `verification_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.verification_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `website_url` SET TAGS ('dbx_validation_regex_^https?' = '//[^s]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `website_url` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `website_url` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_agency.website_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `website_url` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_agency.website_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` SET TAGS ('dbx_subdomain' = 'talent_identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Representation Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.representation_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.representation_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Agency Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.talent_agency_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.talent_agency_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Agent Contact Email');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_validation_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.agent_contact_email');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.agent_contact_email');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Agent Contact Phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_validation_regex' = '^+?[1-9]d{1');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_14}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.agent_contact_phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.agent_contact_phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_name` SET TAGS ('dbx_business_glossary_term' = 'Agent Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.agent_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.agent_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.agreement_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.agreement_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Cap Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_cap_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_cap_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.commission_cap_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_cap_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.commission_cap_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.commission_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.commission_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `contract_document_uri` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Uniform Resource Identifier (URI)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `contract_document_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `contract_document_uri` SET TAGS ('dbx_validation_regex_^https?' = '//[^s]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `contract_document_uri` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `contract_document_uri` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.contract_document_uri');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `contract_document_uri` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.contract_document_uri');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.effective_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.effective_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.effective_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.effective_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.exclusivity_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.exclusivity_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `guild_franchise_flag` SET TAGS ('dbx_business_glossary_term' = 'Guild Franchise Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `guild_franchise_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `guild_franchise_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.guild_franchise_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `guild_franchise_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.guild_franchise_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.renewal_option_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.renewal_option_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.renewal_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.renewal_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Representation Agreement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_agreement_status` SET TAGS ('dbx_value_regex' = 'active|expired|terminated|suspended|pending');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_agreement_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_agreement_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.representation_agreement_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_agreement_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.representation_agreement_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_agreement_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_type` SET TAGS ('dbx_business_glossary_term' = 'Representation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_type` SET TAGS ('dbx_value_regex' = 'exclusive_agent|co_agent|manager|entertainment_attorney|business_manager|publicist');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.representation_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.representation_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `residual_routing_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Routing Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `residual_routing_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `residual_routing_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.residual_routing_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `residual_routing_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.residual_routing_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_business_glossary_term' = 'Scope of Services');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.scope_of_services');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.scope_of_services');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `signing_date` SET TAGS ('dbx_business_glossary_term' = 'Signing Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `signing_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `signing_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.signing_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `signing_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.signing_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.termination_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.termination_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.termination_notice_period_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.termination_notice_period_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.termination_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.termination_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.territory_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.territory_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.representation_agreement.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.representation_agreement.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` SET TAGS ('dbx_subdomain' = 'contract_engagement');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Clearance ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `clearance_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `clearance_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.talent_clearance_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `clearance_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.talent_clearance_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cleared Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.cleared_media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.cleared_media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Cleared Season Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `project_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `project_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.production_project_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `project_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.production_project_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `air_date` SET TAGS ('dbx_business_glossary_term' = 'Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `air_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `air_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.air_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `air_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.air_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.blocking_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.blocking_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|conditionally cleared|blocked|expired|withdrawn');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `clearance_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `clearance_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `clearance_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `clearance_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `clearance_type` SET TAGS ('dbx_business_glossary_term' = 'Clearance Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `clearance_type` SET TAGS ('dbx_value_regex' = 'broadcast clearance|promotional clearance|social media clearance|international clearance|theatrical clearance|home video clearance');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `clearance_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `clearance_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.clearance_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `clearance_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.clearance_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `clearance_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `conditional_terms` SET TAGS ('dbx_business_glossary_term' = 'Conditional Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `conditional_terms` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `conditional_terms` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.conditional_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `conditional_terms` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.conditional_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `exclusivity_conflict_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Conflict Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `exclusivity_conflict_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `exclusivity_conflict_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.exclusivity_conflict_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `exclusivity_conflict_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.exclusivity_conflict_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `expiry_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `expiry_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `expiry_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `granted_by` SET TAGS ('dbx_business_glossary_term' = 'Clearance Granted By');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `granted_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `granted_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.granted_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `granted_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.granted_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `granted_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Granted Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `granted_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `granted_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.granted_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `granted_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.granted_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `guild_clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Guild Clearance Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `guild_clearance_required_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `guild_clearance_required_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.guild_clearance_required_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `guild_clearance_required_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.guild_clearance_required_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `guild_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Guild Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `guild_clearance_status` SET TAGS ('dbx_value_regex' = 'not required|pending|approved|denied');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `guild_clearance_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `guild_clearance_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.guild_clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `guild_clearance_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.guild_clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `guild_clearance_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `guild_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Guild Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `guild_reference_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `guild_reference_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.guild_reference_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `guild_reference_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.guild_reference_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.legal_review_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.legal_review_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `likeness_usage_flag` SET TAGS ('dbx_business_glossary_term' = 'Likeness Usage Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `likeness_usage_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `likeness_usage_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.likeness_usage_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `likeness_usage_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.likeness_usage_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `name_usage_flag` SET TAGS ('dbx_business_glossary_term' = 'Name Usage Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `name_usage_flag` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `name_usage_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `name_usage_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.name_usage_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `name_usage_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.name_usage_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Clearance Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `performance_usage_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Usage Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `performance_usage_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `performance_usage_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.performance_usage_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `performance_usage_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.performance_usage_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `priority_level` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `priority_level` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.priority_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `priority_level` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.priority_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `priority_level` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `request_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `request_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.request_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `request_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.request_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `request_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `request_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.request_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `request_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.request_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `residual_payment_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Payment Triggered Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `residual_payment_triggered_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `residual_payment_triggered_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.residual_payment_triggered_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `residual_payment_triggered_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.residual_payment_triggered_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `reviewed_by_legal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Legal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `reviewed_by_legal_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `reviewed_by_legal_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.reviewed_by_legal_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `reviewed_by_legal_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.reviewed_by_legal_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `talent_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Talent Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `talent_approval_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `talent_approval_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.talent_approval_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `talent_approval_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.talent_approval_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `talent_approval_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Talent Approval Received Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `talent_approval_received_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `talent_approval_received_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.talent_approval_received_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `talent_approval_received_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.talent_approval_received_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `talent_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Talent Approval Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `talent_approval_required_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `talent_approval_required_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.talent_approval_required_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `talent_approval_required_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.talent_approval_required_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `usage_category` SET TAGS ('dbx_business_glossary_term' = 'Usage Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `usage_category` SET TAGS ('dbx_value_regex' = 'primary broadcast|rerun|syndication|promotional|archival|clip licensing');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `usage_category` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `usage_category` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.talent.talent_clearance.usage_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `usage_category` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.talent.talent_clearance.usage_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ALTER COLUMN `usage_category` SET TAGS ('dbx_enum_ref_candidate' = 'true');
