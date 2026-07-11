-- Schema for Domain: talent | Business:  | Version: v3_ecm
-- Generated on: 2026-07-10 19:30:41

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`talent` COMMENT 'Manages all on-screen and off-screen talent relationships — actors, directors, writers, producers, hosts, correspondents, and crew. Tracks talent contracts, guild affiliations (SAG-AFTRA, WGA, DGA), residual payment eligibility, exclusivity clauses, compensation structures, usage rights, appearance schedules, and credit attribution. Serves as the authoritative source for talent identity referenced by production, rights, and royalty workflows.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` (
    `talent_profile_id` BIGINT COMMENT 'Unique identifier for the talent profile record. Primary key for the talent master entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Talent relations/artist development employees manage talent rosters in media orgs. Supports talent relations reporting, contract oversight workflows, internal escalation paths, and manager performance',
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
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Guild affiliations may require regulatory filings for membership verification, dues reporting, and CBA compliance documentation. HR teams file guild membership reports; compliance teams track guild re',
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
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Talent contracts require billing accounts for payment processing, AP/AR reconciliation, tax reporting, and financial audit trails. Standard production finance practice links contracts to billing accou',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Talent contracts reference content ratings for age-appropriate casting, union restrictions on minors, and compensation adjustments based on content maturity. Casting directors verify rating constraint',
    `coppa_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.coppa_declaration. Business justification: Contracts for child performers must reference COPPA declarations to ensure compliance with data collection, usage rights, and parental consent requirements. Business affairs includes COPPA compliance ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Talent costs must be allocated to cost centers for departmental P&L, overhead allocation, EBITDA reporting, and management accountability. Production companies track talent spend by cost center (Drama',
    `production_budget_id` BIGINT COMMENT 'Foreign key linking to finance.production_budget. Business justification: Talent contracts are charged against production budgets for cost control, variance analysis, and financial reporting. Every above-the-line deal must track to a specific budget for production accountin',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Business affairs employees negotiate talent contracts. Required for contract approval workflows, negotiator performance tracking, workload analysis, audit trails, and compliance documentation. Column ',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Talent contracts are executed with production partners (studios, networks, streamers) as the contracting entity. Essential for contract administration, payment routing, rights clearance, and partner r',
    `project_id` BIGINT COMMENT 'Reference to the production (series, film, episode, special) for which this talent is contracted. Nullable for overall deals and first-look deals not tied to a specific production.',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Talent contracts for episodic content are series-level agreements with episode guarantees, option periods, and multi-season terms. Fundamental to TV production contracting and long-form content busine',
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
    `talent_representative_agency` STRING COMMENT 'The name of the agency or firm representing the talent (e.g., CAA, WME, UTA, law firm name).',
    `talent_representative_name` STRING COMMENT 'The name of the talents agent, manager, or attorney who negotiated on behalf of the talent.',
    `termination_date` DATE COMMENT 'The date on which the contract was terminated prior to its natural expiration. Null if contract was not terminated early.',
    `termination_reason` STRING COMMENT 'The primary reason for early contract termination. Null if contract was not terminated early. [ENUM-REF-CANDIDATE: mutual_agreement|breach_of_contract|force_majeure|production_cancellation|talent_unavailability|company_convenience|talent_request|other — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_contract PRIMARY KEY(`contract_id`)
) COMMENT 'Authoritative record of each talent engagement from initial deal memo through executed long-form contract — covering series regular deals, episodic guest agreements, overall deals, first-look deals, and crew contracts. Captures contract lifecycle stage (deal memo, countersigned, long-form executed), compensation structure (base fee, guarantees, backend participation, step-ups, pay-or-play), exclusivity and holdback restrictions, option periods with exercise status, amendment history, billing credit position, governing CBA, and document references. Source of truth for all commercial terms, obligations, and contractual modifications throughout the talent engagement lifecycle.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` (
    `compensation_structure_id` BIGINT COMMENT 'Unique identifier for the compensation structure record. Primary key.',
    `cba_rate_card_id` BIGINT COMMENT 'Foreign key linking to talent.cba_rate_card. Business justification: compensation_structure defines detailed compensation terms for talent contracts. Currently has union_scale_tier (STRING) and guild_affiliation (STRING) but no FK to the CBA rate card that defines mini',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Compensation structures define GL account classification for talent payments. Different compensation types (base fee, residuals, backend participation) map to specific GL accounts for expense recognit',
    `contract_id` BIGINT COMMENT 'Reference to the parent talent contract to which this compensation structure is attached.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Business affairs employees modify compensation structures. Required for audit trails, approval workflows, financial controls, and compliance tracking. Column modified_by_user is denormalized employee ',
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
    `guild_affiliation` STRING COMMENT 'The labor union or guild governing this compensation structure: SAG-AFTRA (Screen Actors Guild - American Federation of Television and Radio Artists), WGA (Writers Guild of America), DGA (Directors Guild of America), IATSE (International Alliance of Theatrical Stage Employees), or non-union.. Valid values are `SAG-AFTRA|WGA|DGA|IATSE|non_union`',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` (
    `exclusivity_clause_id` BIGINT COMMENT 'Unique identifier for the exclusivity clause record. Primary key.',
    `contract_id` BIGINT COMMENT 'Reference to the parent talent contract to which this exclusivity clause is attached. Links this clause to the overarching contractual agreement.',
    `breach_incident_count` STRING COMMENT 'The cumulative number of times the talent has breached this exclusivity clause. Used to track compliance history and inform enforcement decisions.',
    `clause_number` STRING COMMENT 'The business identifier or reference number assigned to this exclusivity clause within the contract document (e.g., Section 5.2, Clause EX-001). Used for legal and operational reference.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this exclusivity clause record was first created in the system. Used for audit trail and data lineage purposes.',
    `effective_date` DATE COMMENT 'The date on which this exclusivity clause record became effective and enforceable within the talent contract. Represents the business event timestamp for this clause.',
    `enforcement_status` STRING COMMENT 'Current enforcement state of the exclusivity clause. Active indicates the clause is fully enforceable. Suspended indicates temporary non-enforcement. Waived indicates a waiver is in effect. Expired indicates the holdback window has ended. Terminated indicates the clause has been permanently voided.. Valid values are `active|suspended|waived|expired|terminated`',
    `exclusivity_scope` STRING COMMENT 'Detailed textual description of the scope and boundaries of the exclusivity restriction. Defines what activities, roles, or engagements are covered by the exclusivity clause.',
    `exclusivity_type` STRING COMMENT 'The category of exclusivity restriction imposed by this clause. Category exclusivity restricts talent from working in specific content genres or categories. Network exclusivity restricts talent from appearing on competing networks. Platform exclusivity restricts talent from appearing on competing streaming or distribution platforms. Geographic exclusivity restricts talent from working in specific territories. Time exclusivity restricts talent during specific dayparts or time windows. Project exclusivity restricts talent from working on competing projects or productions.. Valid values are `category_exclusivity|network_exclusivity|platform_exclusivity|geographic_exclusivity|time_exclusivity|project_exclusivity`',
    `geographic_restriction` STRING COMMENT 'Comma-separated list of three-letter ISO 3166-1 alpha-3 country codes or territory identifiers where the exclusivity restriction applies (e.g., USA, CAN, GBR). If empty or null, the exclusivity applies globally.',
    `holdback_window_end_date` DATE COMMENT 'The date on which the exclusivity or holdback restriction expires. After this date, the talent is no longer bound by the exclusivity terms of this clause. Nullable for open-ended or perpetual exclusivity.',
    `holdback_window_start_date` DATE COMMENT 'The date on which the exclusivity or holdback restriction becomes effective. Marks the beginning of the period during which the talent is bound by the exclusivity terms.',
    `last_breach_date` DATE COMMENT 'The date of the most recent breach of this exclusivity clause by the talent. Nullable if no breach has occurred.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this exclusivity clause record was most recently updated or modified. Used for audit trail and change tracking purposes.',
    `legal_review_completed_flag` BOOLEAN COMMENT 'Boolean indicator of whether this exclusivity clause has been reviewed and approved by legal counsel. True indicates legal review is complete; False indicates pending or no review.',
    `legal_review_date` DATE COMMENT 'The date on which legal counsel completed their review of this exclusivity clause. Nullable if legal review has not been completed.',
    `legal_reviewer_name` STRING COMMENT 'Name or identifier of the legal counsel or attorney who reviewed and approved this exclusivity clause. Used for audit and accountability purposes.',
    `negotiated_by` STRING COMMENT 'Name or identifier of the business affairs executive, legal counsel, or talent agent who negotiated the terms of this exclusivity clause. Used for accountability and future reference.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or context regarding this exclusivity clause. May include negotiation history, special conditions, or operational guidance.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The monetary penalty amount (in the contract currency) that the talent must pay if they breach the exclusivity clause. Represents liquidated damages or breach compensation. Nullable if penalty is non-monetary or not specified.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount (e.g., USD, GBP, EUR). Required if penalty_amount is populated.. Valid values are `^[A-Z]{3}$`',
    `penalty_provision` STRING COMMENT 'Detailed description of the financial or contractual penalties that apply if the talent breaches the exclusivity clause. May include liquidated damages amounts, contract termination rights, or other remedies available to the broadcaster.',
    `permitted_carveout_activities` STRING COMMENT 'Textual description of specific activities, roles, or engagements that are explicitly exempted or carved out from the exclusivity restriction. Examples include charity appearances, personal social media, pre-existing commitments, or non-competing content categories.',
    `restricted_competitor_list` STRING COMMENT 'Comma-separated or structured list of specific competitors, networks, platforms, or entities with whom the talent is prohibited from engaging during the exclusivity period. May include network names, streaming platform identifiers, production company names, or brand names.',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the executive, legal counsel, or business unit that approved the waiver to the exclusivity clause. Used for audit and accountability purposes.',
    `waiver_expiration_date` DATE COMMENT 'The date on which a granted waiver expires and the exclusivity clause becomes fully enforceable again. Nullable if the waiver is permanent or no waiver has been granted.',
    `waiver_granted_date` DATE COMMENT 'The date on which a waiver or exception to the exclusivity clause was officially granted. Nullable if no waiver has been granted.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Boolean indicator of whether a waiver or exception to this exclusivity clause has been granted by the broadcaster. True indicates a waiver is in effect; False indicates the clause is fully enforceable.',
    `waiver_reason` STRING COMMENT 'Textual explanation of the business or legal reason for granting a waiver to the exclusivity clause. Examples include strategic partnership, talent goodwill, promotional opportunity, or force majeure.',
    CONSTRAINT pk_exclusivity_clause PRIMARY KEY(`exclusivity_clause_id`)
) COMMENT 'Records the specific exclusivity and holdback restrictions embedded within or appended to a talent contract. Captures exclusivity type (category exclusivity, network exclusivity, platform exclusivity, geographic exclusivity), restricted competitor list, holdback window start and end dates, permitted carve-out activities, penalty provisions for breach, and waiver history. Enables rights and scheduling teams to validate talent availability for new productions and advertising campaigns without violating contractual obligations.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` (
    `appearance_schedule_id` BIGINT COMMENT 'Unique identifier for the appearance schedule record. Primary key for the appearance schedule entity.',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Talent appearances at broadcast facilities require facility access clearance, security badging, parking coordination, and insurance verification. Operations teams use this to manage facility access li',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Appearance schedules for episodic content must specify exact episode for production call sheets, per-episode compensation tracking, and daily production scheduling. Critical for episodic production op',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Production coordinators/schedulers create appearance schedules. Required for scheduling accountability, workload management, audit trails, and dispute resolution. Column created_by_user is denormalize',
    `project_id` BIGINT COMMENT 'Reference to the production (film, television episode, live broadcast, promotional event) for which the talent is scheduled.',
    `rescheduled_from_appearance_schedule_id` BIGINT COMMENT 'Reference to the original appearance schedule record if this schedule is a rescheduled version of a previous booking.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Links scheduled talent appearances (talk shows, live events, promotional shoots) to the resulting recorded media assets. Required for archival cross-reference, rights verification, and tracking which ',
    `studio_facility_id` BIGINT COMMENT 'Foreign key linking to technology.studio_facility. Business justification: Production scheduling systems book talent into specific studios for live shows, interviews, panel discussions. Studio booking workflow requires linking talent call sheets to physical studio resources ',
    `sweeps_period_id` BIGINT COMMENT 'Foreign key linking to audience.sweeps_period. Business justification: Programming strategy concentrates high-profile talent appearances during Nielsen sweeps periods to maximize ratings that set advertising rates. Production schedulers coordinate talent bookings with sw',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent (actor, director, writer, producer, host, correspondent, crew member) associated with this appearance schedule.',
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
    `role_id` BIGINT COMMENT 'Foreign key linking to talent.talent_role. Business justification: credit_attribution defines on-screen and promotional credits for a talent on a specific production. talent_role defines the role/function performed (role_name, character_name, role_category). Currentl',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Season-specific credits (e.g., season showrunner changes, guest producers) require season-level attribution for accurate metadata, season-specific residuals, and platform EPG data.',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Series-level credits (Created by, Executive Producer) require direct series link for proper attribution across all episodes, series-level residuals, and metadata distribution to platforms.',
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
    `guild_affiliation` STRING COMMENT 'The guild or union affiliation governing this credit (e.g., SAG-AFTRA, DGA, WGA, IATSE, PGA). Multiple affiliations may apply and should be comma-separated.',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` (
    `residual_eligibility_id` BIGINT COMMENT 'Unique identifier for the residual eligibility record.',
    `contract_id` BIGINT COMMENT 'Reference to the talent contract that governs the residual terms and eligibility rules.',
    `media_asset_id` BIGINT COMMENT 'Reference to the specific content asset (episode, film, program) for which residual eligibility applies.',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent (actor, director, writer, producer, host, correspondent, crew member) for whom residual eligibility is being determined.',
    `buyout_amount` DECIMAL(18,2) COMMENT 'The one-time payment amount paid to the talent in lieu of ongoing residual payments for specified uses, if a buyout was applied.',
    `buyout_applied` BOOLEAN COMMENT 'Indicates whether a residual buyout was negotiated and applied, eliminating ongoing residual payment obligations for specified uses.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this residual eligibility record was first created in the system.',
    `distribution_window` STRING COMMENT 'The specific distribution window or release period during which this residual eligibility applies (e.g., First Run, Second Run, Theatrical Window, SVOD Window).',
    `effective_end_date` DATE COMMENT 'The date on which this residual eligibility expires or is no longer applicable, nullable for open-ended eligibility.',
    `effective_start_date` DATE COMMENT 'The date from which this residual eligibility becomes active and applicable for payment calculation.',
    `eligibility_determination_date` DATE COMMENT 'The date on which residual eligibility was determined and recorded for this talent and content asset.',
    `eligibility_status` STRING COMMENT 'Current status of the residual eligibility determination for this talent-content-use combination.. Valid values are `Eligible|Ineligible|Pending Review|Disputed|Waived|Expired`',
    `exclusivity_clause_applies` BOOLEAN COMMENT 'Indicates whether an exclusivity clause in the talent contract affects residual eligibility or payment terms for this content asset.',
    `guild_affiliation` STRING COMMENT 'The guild or union to which the talent belongs, determining applicable residual formulas and rates (Screen Actors Guild - American Federation of Television and Radio Artists, Writers Guild of America, Directors Guild of America, International Alliance of Theatrical Stage Employees, American Federation of Musicians, or Non-Guild).. Valid values are `SAG-AFTRA|WGA|DGA|IATSE|AFM|Non-Guild`',
    `health_contribution_applicable` BOOLEAN COMMENT 'Indicates whether health and welfare contributions are required to be calculated and remitted based on this residual payment per guild agreement.',
    `health_contribution_rate` DECIMAL(18,2) COMMENT 'The percentage rate applied to the residual payment for health and welfare fund contribution calculation.',
    `minimum_residual_threshold` DECIMAL(18,2) COMMENT 'The minimum payment amount below which residuals are not processed or paid, as defined by guild rules or contract terms.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or clarifications regarding this residual eligibility determination.',
    `payment_frequency` STRING COMMENT 'The frequency at which residual payments are calculated and disbursed for this eligibility record.. Valid values are `Per Use|Quarterly|Semi-Annual|Annual|One-Time`',
    `pension_contribution_applicable` BOOLEAN COMMENT 'Indicates whether pension contributions are required to be calculated and remitted based on this residual payment per guild agreement.',
    `pension_contribution_rate` DECIMAL(18,2) COMMENT 'The percentage rate applied to the residual payment for pension fund contribution calculation.',
    `residual_base_amount` DECIMAL(18,2) COMMENT 'The base monetary amount used as the foundation for residual calculation, typically derived from the original compensation or a guild-defined minimum.',
    `residual_formula_type` STRING COMMENT 'The specific residual calculation formula applicable to this eligibility record, determined by guild agreement, content type, and distribution channel.. Valid values are `SAG-AFTRA TV Residuals|Theatrical Residuals|New Media Residuals|Streaming Supplemental|Foreign Broadcast Residuals|Home Video Residuals`',
    `residual_percentage` DECIMAL(18,2) COMMENT 'The percentage of the base amount payable as residual for this specific use, as defined by guild agreement or contract negotiation.',
    `rightsline_integration_code` STRING COMMENT 'External identifier used to link this residual eligibility record to the Rightsline rights and royalties management system for automated royalty calculation workflow.',
    `sap_payables_reference` STRING COMMENT 'Reference identifier linking this residual eligibility to SAP S/4HANA accounts payable processing for payment execution.',
    `territory` STRING COMMENT 'The geographic territory or market for which this residual eligibility applies (e.g., USA, CAN, GBR, Worldwide).',
    `updated_by` STRING COMMENT 'The user or system identifier of the person or process that last updated this residual eligibility record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this residual eligibility record was last modified or updated.',
    `use_type` STRING COMMENT 'The type of content usage that triggers residual payment eligibility (Rerun, Foreign Broadcast, Home Video, Subscription Video On Demand, Advertising-Supported Video On Demand, Transactional Video On Demand, Free Ad-Supported Streaming Television, Theatrical, Syndication, or Clip Use). [ENUM-REF-CANDIDATE: Rerun|Foreign Broadcast|Home Video|SVOD|AVOD|TVOD|FAST|Theatrical|Syndication|Clip Use — 10 candidates stripped; promote to reference product]',
    `created_by` STRING COMMENT 'The user or system identifier of the person or process that created this residual eligibility record.',
    CONSTRAINT pk_residual_eligibility PRIMARY KEY(`residual_eligibility_id`)
) COMMENT 'Determines and records each talents eligibility for residual payments on a per-content-asset basis — capturing the applicable residual formula (SAG-AFTRA TV residuals, theatrical residuals, new media residuals, streaming supplemental), residual base amount, use type triggering residual (rerun, foreign broadcast, home video, SVOD, AVOD, TVOD, FAST), minimum residual threshold, pension and health contribution applicability, and eligibility determination date. Feeds directly into the Rightsline royalty calculation workflow and SAP S/4HANA payables processing.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` (
    `residual_payment_id` BIGINT COMMENT 'Unique identifier for the residual payment transaction.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Residual payments flow through AP for payment processing, cash management, and financial reconciliation. Proper FK enables AP aging reports, payment status tracking, clearing reconciliation, and finan',
    `content_license_deal_id` BIGINT COMMENT 'Foreign key linking to sales.content_license_deal. Business justification: Residual payments triggered by content licensing deals (SVOD/AVOD distribution). Real business process: when content is licensed via sales deal, residuals calculated based on deals distribution metri',
    `contract_id` BIGINT COMMENT 'Reference to the talent contract governing this residual payment.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Residual payments must be charged to cost centers managing ongoing content exploitation. When titles generate residuals (syndication, streaming, international), costs are allocated to the responsible ',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Residual payments are invoiced line items requiring invoice-level tracking for revenue recognition, audit compliance, guild reporting, and payment reconciliation. Completes payment-to-invoice chain fo',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset (title, episode, or version) for which the residual is being paid.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Residual payments to talent may require regulatory filings for tax reporting, guild reporting, and pension/health fund contributions. Finance teams include residual payment data in quarterly guild fil',
    `residual_eligibility_id` BIGINT COMMENT 'Foreign key linking to talent.residual_eligibility. Business justification: residual_payment is the transactional record of payments issued based on eligibility determinations. Currently both products independently reference talent_profile, content_asset_id, and contract_id. ',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent receiving the residual payment.',
    `ach_trace_number` STRING COMMENT 'The ACH trace number if the payment method is ACH or direct deposit, used for reconciliation and audit.',
    `agent_commission_amount` DECIMAL(18,2) COMMENT 'The agent or manager commission amount deducted from the residual payment, if applicable.',
    `audit_report_date` DATE COMMENT 'The date on which this residual payment was included in a guild audit report.',
    `audit_report_flag` BOOLEAN COMMENT 'Indicates whether this residual payment has been included in a guild audit report (SAG-AFTRA, WGA, DGA).',
    `check_number` STRING COMMENT 'The check number if the payment method is check, used for reconciliation and audit.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this residual payment record was first created in the system.',
    `distribution_window` STRING COMMENT 'The specific distribution window or platform for which the residual is being paid (e.g., Network Prime Time, Basic Cable, Netflix SVOD, International Theatrical).',
    `exhibition_end_date` DATE COMMENT 'The end date of the exhibition period for which this residual is calculated.',
    `exhibition_start_date` DATE COMMENT 'The start date of the exhibition period for which this residual is calculated.',
    `gross_residual_amount` DECIMAL(18,2) COMMENT 'The gross residual amount calculated before deductions, in the payment currency.',
    `guild_affiliation` STRING COMMENT 'The guild or union affiliation governing this residual payment (SAG-AFTRA, WGA, DGA, IATSE, AFM, or non-union).. Valid values are `SAG-AFTRA|WGA|DGA|IATSE|AFM|non_union`',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The net residual payment amount after all deductions, paid to the talent.',
    `other_deductions_amount` DECIMAL(18,2) COMMENT 'Any other deductions applied to the residual payment (e.g., union dues, garnishments, advances).',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Business affairs or production employees create deal memos. Supports audit trails, approval workflows, workload tracking, and accountability. Column created_by_user is denormalized employee reference ',
    `guarantee_id` BIGINT COMMENT 'Foreign key linking to audience.audience_guarantee. Business justification: High-profile talent deals often include compensation contingent on audience delivery thresholds negotiated in advertising guarantees. Business affairs teams structure talent agreements referencing spe',
    `contract_id` BIGINT COMMENT 'Reference to the executed long-form talent contract that supersedes this deal memo. Null if the long-form contract has not yet been executed.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Deal memos reference the commissioning partner entity (studio, network, streamer) for deal tracking and relationship management. Critical for converting deal memos to long-form contracts and tracking ',
    `title_id` BIGINT COMMENT 'Reference to the production title (series, episode, film, special) for which the talent is engaged.',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Deal memos for episodic content reference series for series commitment tracking, multi-season option terms, and episode count guarantees. Essential for TV talent deal management.',
    `opportunity_id` BIGINT COMMENT 'The Salesforce Media Cloud opportunity or proposal record identifier from which this deal memo was generated.',
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
    `role_function` STRING COMMENT 'The specific role or function the talent will perform (e.g., Lead Actor, Director, Writer, Executive Producer, Host, Correspondent, Camera Operator).',
    `superseded_date` DATE COMMENT 'The date on which the deal memo was superseded by the execution of a long-form contract. Null if not yet superseded.',
    CONSTRAINT pk_deal_memo PRIMARY KEY(`deal_memo_id`)
) COMMENT 'Pre-contract deal memo capturing the agreed commercial terms for a talent engagement before the formal long-form contract is executed — including deal date, production title, role or function, episode count, start date, compensation summary, credit position, exclusivity summary, option terms, and deal memo status (draft, countersigned, superseded by long-form). Serves as the binding interim agreement used by production and legal teams during the gap between verbal deal and executed contract. Sourced from Salesforce Media Cloud opportunity and proposal records.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`role` (
    `role_id` BIGINT COMMENT 'Unique identifier for the talent role assignment. Primary key for the talent role entity.',
    `contract_id` BIGINT COMMENT 'Reference to the talent contract governing the terms of this role engagement, including compensation, usage rights, and obligations.',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Talent roles (character appearances) must track episode-level granularity for episodic series. Residual calculations, credit attribution per episode, and production scheduling all require knowing whic',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Roles often span specific seasons requiring season-level tracking for season-specific compensation, per-season credits, and availability scheduling. Eliminates denormalized season_number and provides ',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Roles in episodic content must link to series for multi-season contract tracking, series-level residuals, and long-term talent availability management. Essential for TV production business model.',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent individual performing this role. Links to the talent master entity.',
    `title_id` BIGINT COMMENT 'Reference to the content asset or production in which this role is performed. Links to the content master entity.',
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
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Agencies receive commission payments and residuals on behalf of talent rosters. Real business process: agency commission disbursement, residual routing, franchise fee billing, and financial reconcilia',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Talent agencies are business partners in the media ecosystem, tracked for commission payment routing, franchise compliance verification, and strategic relationship management. Essential for partner pe',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` (
    `usage_right_id` BIGINT COMMENT 'Unique identifier for the usage right record. Primary key.',
    `content_license_deal_id` BIGINT COMMENT 'Foreign key linking to sales.content_license_deal. Business justification: Usage rights define licensees permitted use of talents performance in licensed content (territory, platform, duration). Real business process: sales team must verify license deal terms align with ta',
    `contract_id` BIGINT COMMENT 'Reference to the talent contract under which this usage right is granted.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Talent usage rights are constrained by specific rights grant windows. If content can only be distributed in certain territories/platforms/windows per rights_grant, talent usage must comply. Real busin',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Talent usage rights must align with content license agreement terms. When content is licensed with territory/platform/window restrictions, talent usage rights inherit those constraints. Real business ',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Usage rights vary by asset version (master vs proxy, theatrical vs broadcast, original vs dubbed). Specific assets have different distribution rights, platforms, and territorial restrictions. Required',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent whose usage rights are being defined.',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Usage rights (likeness, performance, name) are granted per title for specific platforms and territories. Fundamental to rights management, clearance workflows, and promotional material approval.',
    `approval_authority` STRING COMMENT 'Name or role of the person or entity with authority to approve usage under this right (e.g., talent agent, legal department, talent themselves).',
    `blocking_reason` STRING COMMENT 'Reason why the usage right is blocked or conditionally cleared. Null if status is cleared or pending.',
    `clearance_granted_by` STRING COMMENT 'Name or identifier of the person or system that granted clearance for this usage right.',
    `clearance_granted_date` DATE COMMENT 'Date when clearance was granted for this usage right. Null if not yet cleared.',
    `clearance_requested_date` DATE COMMENT 'Date when clearance verification was requested for this usage right.',
    `clearance_status` STRING COMMENT 'Current clearance verification status of the usage right. Tracks operational approval workflow.. Valid values are `pending|cleared|conditionally_cleared|blocked|expired|revoked`',
    `consent_obtained_date` DATE COMMENT 'Date when talent consent was obtained for this usage right. Null if consent not obtained or not required.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether required consent has been obtained from the talent (True) or not (False). Null if consent not required.',
    `consent_required_flag` BOOLEAN COMMENT 'Indicates whether explicit talent consent is required for each use under this right (True) or if blanket consent was granted (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this usage right record was first created in the system.',
    `credit_attribution_required_flag` BOOLEAN COMMENT 'Indicates whether talent credit attribution is contractually required when this usage right is exercised (True) or not (False).',
    `credit_attribution_text` STRING COMMENT 'Specific credit text that must be displayed when this usage right is exercised (e.g., Starring John Doe). Null if not required.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this usage right is exclusive to Media Broadcasting (True) or non-exclusive (False).',
    `holdback_period_days` STRING COMMENT 'Number of days after initial use during which certain usage types are restricted (exclusivity period). Null if no holdback applies.',
    `language` STRING COMMENT 'Language(s) for which the usage right applies (e.g., English, Spanish, French).',
    `notes` STRING COMMENT 'Additional notes, conditions, or special instructions related to this usage right.',
    `platform` STRING COMMENT 'Distribution platform(s) covered by this usage right (e.g., linear TV, OTT, FAST, theatrical).',
    `residual_eligibility_flag` BOOLEAN COMMENT 'Indicates whether usage under this right triggers residual payments to the talent (True) or not (False).',
    `residual_rate_type` STRING COMMENT 'Type of residual payment structure for this usage right (e.g., flat fee, percentage of revenue, per-use rate, tiered schedule, or none).. Valid values are `flat_fee|percentage|per_use|tiered|none`',
    `right_type` STRING COMMENT 'Type of usage right granted. [ENUM-REF-CANDIDATE: broadcast|streaming|vod|svod|avod|tvod|fast|home_video|theatrical|promotional|social_media|out_of_home — promote to reference product]. Valid values are `broadcast|streaming|vod|svod|avod|tvod`',
    `territory` STRING COMMENT 'Geographic territory where the usage right is valid (e.g., USA, CAN, GBR, worldwide).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this usage right record was last updated in the system.',
    `usage_limit_type` STRING COMMENT 'Type of usage limitation applied to this right (e.g., unlimited, limited by number of runs, time duration, impressions, or revenue cap).. Valid values are `unlimited|run_count|time_duration|impression_count|revenue_cap`',
    `usage_limit_unit` STRING COMMENT 'Unit of measure for the usage limit value (e.g., runs, days, impressions, currency code). Null if unlimited.. Valid values are `runs|days|impressions|usd|eur|gbp`',
    `usage_limit_value` DECIMAL(18,2) COMMENT 'Numeric value of the usage limit (e.g., 10 runs, 365 days, 1000000 impressions, 50000 USD revenue cap). Null if unlimited.',
    `usage_scope` STRING COMMENT 'Detailed description of what the usage right covers (e.g., likeness, voice, name, performance, image).',
    `verification_method` STRING COMMENT 'Method used to verify and clear this usage right (e.g., contract review, legal clearance, agent confirmation, automated system check).. Valid values are `contract_review|legal_clearance|agent_confirmation|automated_system|manual_audit`',
    `window_end_date` DATE COMMENT 'End date of the usage rights window. Defines when the right expires. Nullable for perpetual rights.',
    `window_start_date` DATE COMMENT 'Start date of the usage rights window. Defines when the right becomes effective.',
    CONSTRAINT pk_usage_right PRIMARY KEY(`usage_right_id`)
) COMMENT 'Defines the specific usage rights granted to Media Broadcasting for a talents likeness, voice, name, and performance under a given contract, and tracks the clearance verification workflow for each right. Captures right type (broadcast, streaming, VOD, SVOD, AVOD, TVOD, FAST, home video, theatrical, promotional, social media, out-of-home), territory, language, platform, window dates, exclusivity flag, clearance status (pending, cleared, conditionally cleared, blocked), blocking reason, clearance granted by, and approval/consent tracking. Ensures talent usage is both contractually authorized and operationally verified before content goes to air or distribution.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` (
    `contract_option_id` BIGINT COMMENT 'Unique identifier for the contract option record. Primary key.',
    `contract_id` BIGINT COMMENT 'Reference to the parent talent contract that contains this option clause.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the option automatically renews or rolls over if not explicitly declined by the production company within the option window. True if auto-renewal applies, False if explicit exercise is required.',
    `business_affairs_contact` STRING COMMENT 'Name or identifier of the business affairs executive or legal representative responsible for managing this option and coordinating exercise decisions.',
    `compensation_step_up_percentage` DECIMAL(18,2) COMMENT 'Percentage increase in base compensation upon exercise of the option, relative to the prior contract period or base rate. Common in multi-season series deals where talent compensation escalates with each renewal.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this contract option record was first created in the system. Audit trail for record lifecycle tracking.',
    `exclusivity_clause_flag` BOOLEAN COMMENT 'Indicates whether the option includes an exclusivity provision that restricts the talent from accepting competing work during the option period or upon exercise. True if exclusivity applies, False otherwise.',
    `exclusivity_scope` STRING COMMENT 'Detailed description of the exclusivity restrictions, including prohibited activities, competing networks or platforms, genre restrictions, and geographic limitations. Only applicable if exclusivity_clause_flag is True.',
    `exercise_approval_date` DATE COMMENT 'The date on which the option exercise was formally approved by the authorized business affairs or executive authority. May differ from notification date in organizations requiring multi-level approval.',
    `exercise_compensation_amount` DECIMAL(18,2) COMMENT 'The base compensation amount payable to the talent if the option is exercised. Represents the step-up or incremental payment beyond the option fee for the additional work commitment.',
    `exercise_compensation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the exercise compensation (e.g., USD, GBP, EUR, CAD).. Valid values are `^[A-Z]{3}$`',
    `exercise_notification_date` DATE COMMENT 'The date on which the production company formally notified the talent (or their representative) of the decision to exercise the option. Triggers contractual obligations and payment schedules.',
    `exercise_notification_method` STRING COMMENT 'The communication channel or mechanism used to deliver the option exercise notification, as required by the contract terms. Important for legal compliance and dispute resolution.. Valid values are `written_notice|email|certified_mail|electronic_signature|verbal_confirmed|agent_notification`',
    `exercise_status` STRING COMMENT 'Current state of the option: unexercised (option window open, not yet acted upon), exercised (option formally invoked by production company), lapsed (option window closed without exercise), waived (option voluntarily released by production company), pending approval (exercise submitted awaiting legal or executive approval), or conditionally exercised (exercise subject to specific conditions being met).. Valid values are `unexercised|exercised|lapsed|waived|pending_approval|conditionally_exercised`',
    `guild_notification_date` DATE COMMENT 'The date on which the option exercise was reported to the applicable guild. Required for compliance audit trails when guild_notification_required_flag is True.',
    `guild_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the option exercise must be reported to the talents guild (SAG-AFTRA, WGA, DGA) for compliance and residual tracking purposes. True if guild notification is required, False otherwise.',
    `lapse_date` DATE COMMENT 'The actual date on which the option lapsed due to non-exercise within the option window. Recorded for audit and contract history purposes.',
    `lapse_reason` STRING COMMENT 'Business rationale or explanation for why the option was allowed to lapse without exercise. May include creative decisions, budget constraints, performance issues, or strategic pivots.',
    `notes` STRING COMMENT 'Free-form text field for additional context, special conditions, negotiation history, or operational notes related to the option. Used by business affairs and production teams for internal coordination.',
    `option_description` STRING COMMENT 'Detailed narrative description of the option terms, scope, and conditions. May include specific deliverables, performance triggers, or creative commitments associated with the option.',
    `option_fee_amount` DECIMAL(18,2) COMMENT 'The monetary consideration paid to the talent to secure the option right, regardless of whether the option is ultimately exercised. Typically non-refundable and may be applied against future compensation if exercised.',
    `option_fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the option fee (e.g., USD, GBP, EUR, CAD).. Valid values are `^[A-Z]{3}$`',
    `option_number` STRING COMMENT 'Sequential number of this option within the contract (e.g., 1 for first option, 2 for second option). Used to track multi-year or multi-project option sequences.',
    `option_type` STRING COMMENT 'Classification of the option based on its business purpose: series pickup option for additional seasons, sequel option for follow-on films, spin-off option for derivative content, overall deal extension for multi-project agreements, season renewal for episodic content, or project continuation for phased productions.. Valid values are `series_pickup|sequel|spin_off|overall_deal_extension|season_renewal|project_continuation`',
    `option_window_end_date` DATE COMMENT 'The final date by which the option must be exercised or it will lapse. Critical deadline for business affairs teams to track to avoid inadvertent loss of talent commitments.',
    `option_window_start_date` DATE COMMENT 'The earliest date on which the option can be exercised by the production company or network. Marks the beginning of the exercise window.',
    `performance_trigger_description` STRING COMMENT 'Description of any performance-based conditions or milestones that must be met before the option can be exercised (e.g., minimum ratings thresholds, box office targets, critical acclaim metrics, audience engagement benchmarks).',
    `performance_trigger_met_flag` BOOLEAN COMMENT 'Indicates whether all performance-based conditions have been satisfied, enabling the option to be exercised. True if triggers are met or not applicable, False if triggers exist but are not yet satisfied.',
    `residual_eligibility_flag` BOOLEAN COMMENT 'Indicates whether work performed under this option (if exercised) qualifies the talent for residual payments under guild collective bargaining agreements. True if residuals apply, False otherwise.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this contract option record was last modified. Audit trail for change tracking and compliance.',
    CONSTRAINT pk_contract_option PRIMARY KEY(`contract_option_id`)
) COMMENT 'Tracks option periods embedded in talent contracts — including option type (series pickup option, sequel option, spin-off option, overall deal extension), option number in sequence, option exercise window (start and end date), option fee, compensation step-up on exercise, exercise status (unexercised, exercised, lapsed, waived), and exercise notification date. Enables production and business affairs teams to proactively manage option deadlines and avoid inadvertent lapse of valuable talent commitments.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` (
    `availability_id` BIGINT COMMENT 'Unique identifier for the talent availability record. Primary key.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Talent availability holds placed for sales opportunities requiring specific talent (celebrity host for advertiser-sponsored special, talent-driven content pitch). Real business process: sales team pit',
    `project_id` BIGINT COMMENT 'Reference to the production requesting or holding this availability. Null if this is a general unavailability not tied to a specific production.',
    `studio_facility_id` BIGINT COMMENT 'Foreign key linking to technology.studio_facility. Business justification: Availability holds are placed against specific studio resources when booking talent. Studio booking systems check talent availability before confirming studio reservations to prevent double-booking an',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent (actor, director, writer, producer, host, correspondent, crew member) whose availability is being tracked.',
    `availability_type` STRING COMMENT 'Classification of the availability status: available (talent is free), hold (production has placed a hold), first_refusal (talent has granted first right to book), confirmed_booking (talent is booked), personal_unavailability (talent is unavailable for personal reasons), conflicting_production (talent is committed to another production).. Valid values are `available|hold|first_refusal|confirmed_booking|personal_unavailability|conflicting_production`',
    `booking_confirmed_date` DATE COMMENT 'The date when the booking was confirmed and the talent was officially committed to the production. Null if not yet confirmed.',
    `booking_status` STRING COMMENT 'Current lifecycle status of the availability record: tentative (hold placed but not confirmed), confirmed (booking finalized), cancelled (booking or hold cancelled), released (hold dropped by production), expired (hold expired without confirmation).. Valid values are `tentative|confirmed|cancelled|released|expired`',
    `conflict_production_network` STRING COMMENT 'Network or studio associated with the conflicting production. Used to identify potential exclusivity clause violations.',
    `conflict_production_title` STRING COMMENT 'Title of the conflicting production when availability_type is conflicting_production. Null if not applicable.',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created this availability record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this availability record was first created in the system.',
    `end_date` DATE COMMENT 'The end date of the availability or unavailability window. Represents the last day the talent is available or unavailable. Null for open-ended availability.',
    `exclusivity_conflict_flag` BOOLEAN COMMENT 'Indicates whether this availability record represents a conflict with an existing exclusivity clause in the talents contract. True if conflict exists, False otherwise.',
    `guild_notification_date` DATE COMMENT 'The date when the guild was notified of this booking. Null if notification not yet sent or not required.',
    `guild_notification_required_flag` BOOLEAN COMMENT 'Indicates whether guild notification is required for this booking per collective bargaining agreement rules (SAG-AFTRA, WGA, DGA). True if notification required, False otherwise.',
    `hold_expiration_date` DATE COMMENT 'The date by which the production must confirm the booking or the hold will expire. Null if not applicable.',
    `hold_level` STRING COMMENT 'Priority level of the hold when availability_type is hold or first_refusal. First hold has highest priority, second and third holds are backup options. Null if not a hold.. Valid values are `first_hold|second_hold|third_hold`',
    `hold_placed_date` DATE COMMENT 'The date when the hold was initially placed on the talent. Null if availability_type is not hold or first_refusal.',
    `hold_released_date` DATE COMMENT 'The date when the hold was released or dropped by the requesting production. Null if hold was not released.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special conditions, or instructions related to this availability record.',
    `priority_level` STRING COMMENT 'Business priority assigned to this availability request. High priority requests receive preferential treatment in conflict resolution.. Valid values are `high|medium|low`',
    `requesting_contact_email` STRING COMMENT 'Email address of the production contact who placed the availability request.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requesting_contact_phone` STRING COMMENT 'Phone number of the production contact who placed the availability request.',
    `requesting_department` STRING COMMENT 'The department or business unit that requested the availability hold or booking (e.g., Drama Production, News, Sports, Documentary Unit).',
    `requesting_producer_name` STRING COMMENT 'Name of the producer or production manager who requested the availability hold or booking.',
    `start_date` DATE COMMENT 'The start date of the availability or unavailability window. Represents the first day the talent is available or unavailable.',
    `unavailability_reason` STRING COMMENT 'Detailed explanation of why the talent is unavailable during this period (e.g., personal commitment, vacation, medical leave, prior contractual obligation).',
    `updated_by_user` STRING COMMENT 'Username or identifier of the system user who last updated this availability record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this availability record was last modified in the system.',
    CONSTRAINT pk_availability PRIMARY KEY(`availability_id`)
) COMMENT 'Operational record of a talents confirmed availability or unavailability for production bookings — capturing availability window start and end dates, availability type (available, hold, first refusal, confirmed booking, personal unavailability, conflicting production), hold level (first hold, second hold, third hold), requesting production, and release date if hold is dropped. Supports production scheduling, casting decisions, and conflict resolution across concurrent productions. Integrates with appearance_schedule and Dalet Galaxy workflow orchestration.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` (
    `pension_health_contribution_id` BIGINT COMMENT 'Unique identifier for the pension and health contribution record.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Guild pension/health contributions are processed through AP as vendor payments to guild trust funds. These regulatory-mandated payments require AP tracking for payment status, aging, compliance report',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Pension/health contributions must post to specific GL accounts (benefits expense) for financial reporting, tax compliance, and guild audit requirements. Different guild funds (SAG-AFTRA, DGA, WGA) may',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.talent_contract. Business justification: pension_health_contribution tracks P&H remittances for specific work engagements. Currently has production_title and production_code (STRING) but no FK to the governing contract. Adding talent_contrac',
    `guild_affiliation_id` BIGINT COMMENT 'Reference to the specific guild affiliation under which this contribution is made.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Guild pension/health contributions are billed to production companies as invoice line items. Real business process: remittances appear on production company bills, tracked for guild compliance audits,',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent for whom this pension and health contribution is remitted.',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Pension and health contributions are calculated per production title for guild fund remittance, cost allocation, and regulatory compliance reporting. Required for guild audit and financial reconciliat',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any adjustment amount applied to the contribution due to corrections, recalculations, or prior period adjustments.',
    `adjustment_reason` STRING COMMENT 'Explanation for any adjustment made to the contribution amount, including reference to prior period corrections or rate changes.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this contribution record to supporting audit documentation, payroll records, and source transactions.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether this contribution record meets all guild collective bargaining agreement requirements and regulatory compliance standards.',
    `contribution_period_end_date` DATE COMMENT 'The end date of the earnings period for which this pension and health contribution is calculated.',
    `contribution_period_start_date` DATE COMMENT 'The start date of the earnings period for which this pension and health contribution is calculated.',
    `contribution_reference_number` STRING COMMENT 'External reference number assigned by the guild benefit fund for tracking and reconciliation purposes.',
    `contribution_type` STRING COMMENT 'Classification of the contribution based on the nature of the underlying compensation (initial work, residual payment, reuse, etc.).. Valid values are `Initial Compensation|Residual|Reuse|Supplemental`',
    `cost_center` STRING COMMENT 'The cost center or department code to which this pension and health contribution expense is allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this pension and health contribution record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this contribution record.. Valid values are `USD|CAD|GBP|EUR`',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'The dollar amount withheld from the talents compensation and contributed to the guild benefit fund, if applicable.',
    `employee_contribution_rate` DECIMAL(18,2) COMMENT 'The percentage rate applied to the gross compensation base to calculate the employees (talents) pension and health contribution, if applicable.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'The dollar amount contributed by the employer to the guild benefit fund on behalf of the talent.',
    `employer_contribution_rate` DECIMAL(18,2) COMMENT 'The percentage rate applied to the gross compensation base to calculate the employers pension and health contribution obligation.',
    `general_ledger_account` STRING COMMENT 'The general ledger account code to which this contribution expense is posted in the financial system.',
    `gross_compensation_base` DECIMAL(18,2) COMMENT 'The gross earnings amount upon which the pension and health contribution is calculated, before any deductions or adjustments.',
    `guild_acknowledgment_number` STRING COMMENT 'Confirmation or acknowledgment number provided by the guild benefit fund upon receipt and processing of the contribution.',
    `guild_fund_code` STRING COMMENT 'Code identifying the specific guild benefit fund to which the contribution is remitted (e.g., SAG-AFTRA Health Plan, SAG-Producers Pension Plan, DGA-Producer Pension and Health Plan, WGA Pension Plan). [ENUM-REF-CANDIDATE: SAG_HEALTH|SAG_PENSION|DGA_PENSION_HEALTH|WGA_PENSION|WGA_HEALTH|IATSE_PENSION|IATSE_HEALTH|AFM_PENSION|AFM_HEALTH — 9 candidates stripped; promote to reference product]',
    `guild_fund_name` STRING COMMENT 'Full name of the guild benefit fund receiving the contribution.',
    `late_payment_penalty_amount` DECIMAL(18,2) COMMENT 'Penalty amount assessed by the guild benefit fund for late remittance of the contribution, if applicable.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special circumstances, or clarifications related to this contribution record.',
    `payment_method` STRING COMMENT 'The method used to remit the contribution payment to the guild benefit fund.. Valid values are `ACH|Wire Transfer|Check|EFT`',
    `payment_reference_number` STRING COMMENT 'The transaction reference number or check number associated with the remittance payment.',
    `reconciliation_date` DATE COMMENT 'The date on which this contribution record was successfully reconciled with the guild benefit funds records.',
    `reconciliation_status` STRING COMMENT 'Current status of the contribution record in the reconciliation process with the guild benefit fund.. Valid values are `Pending|Reconciled|Discrepancy|Under Review|Resolved`',
    `remittance_date` DATE COMMENT 'The date on which the contribution payment was remitted to the guild benefit fund.',
    `remittance_due_date` DATE COMMENT 'The contractual due date by which the contribution must be remitted to the guild benefit fund to avoid penalties.',
    `reporting_period` STRING COMMENT 'The fiscal or calendar reporting period (e.g., 2024-Q1, 2024-03) to which this contribution is assigned for financial and compliance reporting.',
    `total_contribution_amount` DECIMAL(18,2) COMMENT 'The combined total of employer and employee contributions remitted to the guild benefit fund for this contribution record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this pension and health contribution record was last modified.',
    `work_type` STRING COMMENT 'The type of work performed by the talent that generated the compensation base for this contribution.. Valid values are `Principal Photography|Post-Production|Voice Over|ADR|Residual|Reuse`',
    CONSTRAINT pk_pension_health_contribution PRIMARY KEY(`pension_health_contribution_id`)
) COMMENT 'Transactional record of Pension and Health (P&H) contributions remitted to guild benefit funds on behalf of talent — capturing contribution period, guild fund (SAG-AFTRA Health Plan, SAG-Producers Pension Plan, DGA-Producer Pension and Health Plan, WGA Pension Plan), gross compensation base, contribution rate, employer contribution amount, employee contribution amount, remittance date, fund reference number, and reconciliation status. Mandatory for SAG-AFTRA, DGA, and WGA compliance. Feeds SAP S/4HANA AP and HR payroll modules.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` (
    `talent_clearance_id` BIGINT COMMENT 'Unique identifier for the talent clearance record. Primary key.',
    `ad_sales_order_id` BIGINT COMMENT 'Foreign key linking to sales.ad_sales_order. Business justification: Talent clearance required before using talent likeness/performance in advertiser-sponsored content or integrated sponsorships. Real business process: advertiser purchases branded content requiring tal',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Talent clearances are often asset-specific (theatrical cut vs TV edit, domestic vs international versions, trailer vs feature). Different assets may require separate clearances based on usage rights, ',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Talent clearances verify that talent usage complies with underlying content license agreement restrictions (territory, platform, window restrictions). Real business process: ensuring talent usage in p',
    `project_id` BIGINT COMMENT 'Reference to the production or content title for which clearance is being requested.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Production or legal employees request talent clearances. Supports clearance workflow tracking, workload analysis, compliance audits, and accountability. Column requested_by_user is denormalized employ',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent whose usage rights are being cleared.',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Talent clearance requests must specify exact title for usage approval, exclusivity conflict checking, residual payment triggering, and guild clearance processing. Core to content release workflows.',
    `usage_right_id` BIGINT COMMENT 'Foreign key linking to talent.usage_right. Business justification: talent_clearance records the rights verification process for talent usage. usage_right defines the granted rights with usage_scope, territory, platform, and window dates. Currently clearance has usage',
    `air_date` DATE COMMENT 'Scheduled broadcast or distribution date for the content requiring clearance.',
    `blocking_reason` STRING COMMENT 'Explanation for why clearance was blocked or denied, including contractual, guild, or legal constraints.',
    `clearance_status` STRING COMMENT 'Current state of the clearance request in the approval workflow.. Valid values are `pending|cleared|conditionally cleared|blocked|expired|withdrawn`',
    `clearance_type` STRING COMMENT 'Category of clearance being requested based on the intended usage channel and distribution method.. Valid values are `broadcast clearance|promotional clearance|social media clearance|international clearance|theatrical clearance|home video clearance`',
    `conditional_terms` STRING COMMENT 'Specific conditions, restrictions, or requirements that must be met for the clearance to remain valid.',
    `contract_reference_number` STRING COMMENT 'Reference to the underlying talent contract that governs the usage rights being cleared.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the clearance record was first created in the system.',
    `exclusivity_conflict_flag` BOOLEAN COMMENT 'Indicates whether the requested usage conflicts with existing exclusivity clauses in the talent contract.',
    `expiry_date` DATE COMMENT 'Date when the granted clearance expires and usage rights are no longer valid.',
    `granted_by` STRING COMMENT 'Name or identifier of the individual or department who authorized the clearance.',
    `granted_date` DATE COMMENT 'Date when the clearance was officially approved and granted for the specified usage.',
    `guild_clearance_required_flag` BOOLEAN COMMENT 'Indicates whether guild or union clearance is required based on collective bargaining agreement terms.',
    `guild_clearance_status` STRING COMMENT 'Current status of guild or union clearance verification for this usage.. Valid values are `not required|pending|approved|denied`',
    `guild_reference_number` STRING COMMENT 'Reference or tracking number provided by the guild or union for this clearance request.',
    `legal_review_date` DATE COMMENT 'Date when the legal department completed their review of the clearance request.',
    `likeness_usage_flag` BOOLEAN COMMENT 'Indicates whether the clearance includes usage of the talents physical likeness or image.',
    `name_usage_flag` BOOLEAN COMMENT 'Indicates whether the clearance includes usage of the talents name in promotional or marketing materials.',
    `notes` STRING COMMENT 'Additional comments, context, or special instructions related to the clearance request and approval process.',
    `performance_usage_flag` BOOLEAN COMMENT 'Indicates whether the clearance includes usage of the talents recorded performance or voice.',
    `priority_level` STRING COMMENT 'Business priority assigned to the clearance request based on production schedules and air dates.. Valid values are `low|medium|high|urgent`',
    `request_date` DATE COMMENT 'Date when the clearance request was initiated by the production or rights team.',
    `request_number` STRING COMMENT 'Business identifier for the clearance request, used for tracking and reference across systems.',
    `residual_payment_triggered_flag` BOOLEAN COMMENT 'Indicates whether this clearance triggers residual payment obligations under guild agreements.',
    `reviewed_by_legal_flag` BOOLEAN COMMENT 'Indicates whether the clearance request has been reviewed and approved by the legal department.',
    `talent_approval_date` DATE COMMENT 'Date when the talent provided their explicit approval or consent for the specified usage.',
    `talent_approval_received_flag` BOOLEAN COMMENT 'Indicates whether the required talent approval has been obtained and documented.',
    `talent_approval_required_flag` BOOLEAN COMMENT 'Indicates whether explicit talent consent or approval is required before usage can proceed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the clearance record was last modified or updated.',
    `usage_category` STRING COMMENT 'Classification of the intended usage based on broadcast and distribution business models.. Valid values are `primary broadcast|rerun|syndication|promotional|archival|clip licensing`',
    CONSTRAINT pk_talent_clearance PRIMARY KEY(`talent_clearance_id`)
) COMMENT 'Records the rights clearance verification process for talent likeness, name, and performance usage in a specific production or campaign — capturing clearance request date, clearance type (broadcast clearance, promotional clearance, social media clearance, international clearance), clearance status (pending, cleared, conditionally cleared, blocked), blocking reason, clearance granted by, clearance expiry date, and any required talent approval or consent. Ensures talent usage complies with contractual, guild, and regulatory obligations before content goes to air or distribution.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` (
    `cba_rate_card_id` BIGINT COMMENT 'Unique identifier for the CBA rate card entry. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Labor relations employees create and maintain CBA rate cards. Required for rate card governance, compliance tracking, audit trails, and accountability. Column created_by_user is denormalized employee ',
    `superseded_by_rate_card_cba_rate_card_id` BIGINT COMMENT 'Reference to the newer CBA rate card entry that replaces this one, if applicable.',
    `budget_tier` STRING COMMENT 'Production budget classification that determines applicable rates (e.g., high budget, low budget, ultra-low budget, modified low budget).',
    `cba_code` STRING COMMENT 'Standardized code identifying the specific collective bargaining agreement (e.g., SAG_AFTRA_TV, DGA_BASIC, WGA_MBA, IATSE_BASIC).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `cba_name` STRING COMMENT 'Full legal name of the collective bargaining agreement (e.g., SAG-AFTRA Television Agreement, DGA Basic Agreement, WGA Minimum Basic Agreement).',
    `cba_ratification_date` DATE COMMENT 'Date when the CBA was ratified by the guild membership.',
    `cba_version` STRING COMMENT 'Version identifier of the CBA document (e.g., 2023-2026, v4.2).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CBA rate card record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the minimum scale rate (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date when this CBA rate becomes effective and enforceable.',
    `expiration_date` DATE COMMENT 'Date when this CBA rate expires and is no longer enforceable. Null if the rate remains in effect indefinitely or until superseded.',
    `forced_call_penalty_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied when talent is called back to work before the minimum turnaround period has elapsed.',
    `golden_time_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base rate for hours worked beyond double-time threshold (e.g., 3.0 for triple-time), applicable in certain guild agreements.',
    `guild_code` STRING COMMENT 'Code representing the labor guild or union that negotiated this CBA (SAG-AFTRA, DGA, WGA, IATSE, NABET, AFM, OTHER). [ENUM-REF-CANDIDATE: SAG-AFTRA|DGA|WGA|IATSE|NABET|AFM|OTHER — 7 candidates stripped; promote to reference product]',
    `job_classification` STRING COMMENT 'Specific job title or classification within the performer category (e.g., Series Regular, Guest Star, Co-Star, Director of Photography, Script Supervisor).',
    `jurisdiction` STRING COMMENT 'Geographic jurisdiction where this CBA rate applies, using three-letter country code (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `local_chapter` STRING COMMENT 'Local guild chapter or regional office that administers this rate (e.g., SAG-AFTRA Los Angeles, IATSE Local 600).',
    `meal_penalty_amount` DECIMAL(18,2) COMMENT 'Penalty payment owed to talent when meal breaks are not provided within the CBA-mandated timeframe.',
    `minimum_scale_rate` DECIMAL(18,2) COMMENT 'Minimum compensation amount defined by the CBA for this rate type and performer category.',
    `notes` STRING COMMENT 'Additional notes, clarifications, or special conditions related to this CBA rate card entry.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base rate for overtime hours (e.g., 1.5 for time-and-a-half, 2.0 for double-time).',
    `overtime_threshold_hours` DECIMAL(18,2) COMMENT 'Number of hours worked before overtime rates apply (e.g., 8.0 for daily overtime, 40.0 for weekly overtime).',
    `pension_health_contribution_rate` DECIMAL(18,2) COMMENT 'Percentage of gross compensation that the employer must contribute to pension and health funds as mandated by the CBA (e.g., 0.1850 for 18.5%).',
    `performer_category` STRING COMMENT 'Classification of the talent role covered by this rate (e.g., principal performer, day player, stunt performer, background actor, director, writer, producer, crew member).',
    `production_type` STRING COMMENT 'Type of production this rate applies to (e.g., theatrical motion picture, television series, television movie, new media, commercial, industrial).',
    `rate_status` STRING COMMENT 'Current lifecycle status of this rate card entry (active, expired, superseded, pending, draft).. Valid values are `active|expired|superseded|pending|draft`',
    `rate_type` STRING COMMENT 'Type of compensation rate defined in this CBA entry (day rate, weekly rate, episodic rate, theatrical rate, session rate, hourly rate).. Valid values are `day_rate|weekly_rate|episodic_rate|theatrical_rate|session_rate|hourly_rate`',
    `residual_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this rate category qualifies for residual payments under the CBA (True/False).',
    `residual_formula_code` STRING COMMENT 'Code identifying the residual calculation formula applicable to this rate (e.g., NETWORK_PRIME, BASIC_CABLE, SVOD_HIGH_BUDGET).',
    `turnaround_hours` DECIMAL(18,2) COMMENT 'Minimum rest period required between work days as mandated by the CBA (e.g., 12.0 hours).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this CBA rate card record was last modified in the system.',
    CONSTRAINT pk_cba_rate_card PRIMARY KEY(`cba_rate_card_id`)
) COMMENT 'Reference table of minimum scale rates and contribution percentages defined by each Collective Bargaining Agreement (CBA) applicable to Media Broadcasting — covering SAG-AFTRA Codified Basic Agreement, SAG-AFTRA Television Agreement, DGA Basic Agreement, WGA Minimum Basic Agreement, and IATSE Basic Agreement. Captures rate type (day rate, weekly rate, episodic rate, theatrical rate), performer category, effective date, expiration date, P&H contribution rate, and overtime multiplier. Used by compensation_structure and residual_eligibility to validate scale compliance.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` (
    `contract_amendment_id` BIGINT COMMENT 'Unique identifier for the contract amendment record. Primary key.',
    `contract_id` BIGINT COMMENT 'Reference to the original executed talent contract being amended. Links to the parent contract record in the talent contract system.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Business affairs employees modify contract amendments. Required for audit trails, approval workflows, compliance tracking, and change management. Column modified_by_user is denormalized employee refer',
    `superseded_by_amendment_contract_amendment_id` BIGINT COMMENT 'Reference to a subsequent amendment that replaces or supersedes this amendment. Used to maintain amendment version history and prevent application of outdated terms.',
    `amended_clause_reference` STRING COMMENT 'Specific section, paragraph, or clause number from the original contract that this amendment modifies (e.g., Section 3.2, Paragraph 5(a), Exhibit B).',
    `amended_term_value` DECIMAL(18,2) COMMENT 'The new contractual term or value established by this amendment. Replaces or supplements the original term value.',
    `amendment_description` STRING COMMENT 'Detailed narrative description of the contractual changes being made, including the business rationale and specific terms being modified or added.',
    `amendment_number` STRING COMMENT 'Sequential or hierarchical identifier for this amendment within the contract (e.g., Amendment 1, Amendment 2A). Used for tracking and referencing specific modifications.',
    `amendment_status` STRING COMMENT 'Current lifecycle state of the amendment. Tracks progression from drafting through execution or rejection. Only executed amendments are legally binding.. Valid values are `draft|pending_review|pending_signature|executed|rejected|superseded`',
    `amendment_type` STRING COMMENT 'Classification of the amendment by the primary contractual element being modified. Determines which business affairs and legal review workflows apply. [ENUM-REF-CANDIDATE: compensation_adjustment|credit_modification|exclusivity_scope_change|option_term_revision|force_majeure_addition|residual_formula_change|backend_participation_change|term_extension|role_scope_change|other — 10 candidates stripped; promote to reference product]',
    `business_affairs_approver_name` STRING COMMENT 'Name of the business affairs executive who reviewed and approved this amendment on behalf of the production company or network.',
    `company_signature_date` DATE COMMENT 'Date on which the authorized company representative signed the amendment. Execution date is typically the later of talent and company signature dates.',
    `compensation_impact_amount` DECIMAL(18,2) COMMENT 'Net financial impact of the amendment on total talent compensation. Positive values indicate increases, negative indicate reductions. Used for budget reconciliation and residual calculations.',
    `compensation_impact_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation impact amount (e.g., USD, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this amendment record was first created in the system. Used for audit trail and data lineage.',
    `document_reference_uri` STRING COMMENT 'URI or file path to the executed amendment document stored in the media asset management or document management system.',
    `effective_date` DATE COMMENT 'Date on which the amendment terms become legally binding and operationally effective. May be retroactive, concurrent with execution, or future-dated.',
    `execution_date` DATE COMMENT 'Date on which all required parties signed the amendment, making it legally enforceable. Distinct from effective date which may differ.',
    `guild_notification_date` DATE COMMENT 'Date on which the amendment was formally reported to the applicable talent guild. Required for compliance with CBA notification timelines.',
    `guild_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the amendment must be reported to the talent guild per collective bargaining agreement (CBA) requirements. True for material changes to compensation, credit, or working conditions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this amendment record was most recently updated. Tracks all modifications for compliance and audit purposes.',
    `legal_review_completed_date` DATE COMMENT 'Date on which legal review of the amendment was completed and approval granted. Required before execution.',
    `legal_reviewer_name` STRING COMMENT 'Name of the legal counsel who reviewed the amendment for compliance with guild rules, employment law, and corporate policy.',
    `notes` STRING COMMENT 'Free-form notes capturing additional context, negotiation history, special conditions, or operational instructions related to this amendment.',
    `original_term_value` DECIMAL(18,2) COMMENT 'The original contractual term or value being replaced or modified by this amendment. Captured for audit trail and comparison purposes.',
    `rejection_reason` STRING COMMENT 'Explanation of why the amendment was rejected by talent, company, or legal review. Captured for negotiation history and future reference.',
    `residual_calculation_impact_flag` BOOLEAN COMMENT 'Indicates whether this amendment affects residual payment calculations. True triggers recalculation of residual formulas and payment schedules.',
    `talent_representative_agency` STRING COMMENT 'Name of the talent agency or law firm representing the talent in this amendment negotiation.',
    `talent_representative_name` STRING COMMENT 'Name of the talent agent, manager, or attorney who negotiated and approved this amendment on behalf of the talent.',
    `talent_signature_date` DATE COMMENT 'Date on which the talent or their authorized representative signed the amendment.',
    CONSTRAINT pk_contract_amendment PRIMARY KEY(`contract_amendment_id`)
) COMMENT 'Records formal amendments and modifications to executed talent contracts — capturing amendment number, amendment type (compensation adjustment, credit modification, exclusivity scope change, option term revision, force majeure clause addition), amendment effective date, original contract reference, amended clause description, amendment status (draft, executed, rejected), and signatory confirmation. Maintains a complete audit trail of all contractual changes to support business affairs, legal, and residual calculation accuracy.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` (
    `talent_grievance_id` BIGINT COMMENT 'Unique identifier for the talent grievance record. Primary key.',
    `contract_id` BIGINT COMMENT 'Reference to the specific talent contract under which this grievance was filed, if applicable.',
    `guild_affiliation_id` BIGINT COMMENT 'Foreign key linking to talent.guild_affiliation. Business justification: talent_grievance currently has guild_code and guild_name (STRING) duplicating data from guild_affiliation. Grievances are filed in the context of a specific guild membership. Adding FK to guild_affili',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: HR or legal employees manage talent grievance records. Required for case management, workload tracking, compliance documentation, and audit trails. Column modified_by_user is denormalized employee ref',
    `project_id` BIGINT COMMENT 'Reference to the production entity associated with this grievance, if applicable.',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent individual who is party to this grievance (either filing party or responding party).',
    `appeal_date` DATE COMMENT 'Date on which an appeal was filed, if applicable.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether an appeal has been filed following the initial arbitration award or decision (True if appeal filed, False if not).',
    `arbitration_reference_number` STRING COMMENT 'Unique reference number assigned by the arbitration body or guild for tracking this grievance through the dispute resolution process.',
    `arbitrator_name` STRING COMMENT 'Name of the arbitrator or mediator assigned to hear and decide this grievance.',
    `cba_version` STRING COMMENT 'Version or year of the Collective Bargaining Agreement (CBA) under which this grievance was filed (e.g., 2020 SAG-AFTRA CBA, 2023 WGA MBA).',
    `confidentiality_flag` BOOLEAN COMMENT 'Indicates whether this grievance is subject to confidentiality or non-disclosure provisions (True if confidential, False if not).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this grievance record was first created in the system.',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Monetary amount in dispute, such as unpaid compensation, residuals, or damages claimed by the filing party.',
    `disputed_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the disputed amount (e.g., USD, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    `filing_date` DATE COMMENT 'Date on which the grievance was formally filed with the guild or arbitration body.',
    `filing_party_name` STRING COMMENT 'Name of the individual or organization that filed the grievance.',
    `filing_party_type` STRING COMMENT 'Type of entity that initiated the grievance: talent (individual), guild (on behalf of member), production company, network, or studio.. Valid values are `talent|guild|production company|network|studio`',
    `grievance_description` STRING COMMENT 'Detailed narrative description of the grievance, including the nature of the dispute, alleged violations, and relief sought.',
    `grievance_number` STRING COMMENT 'Externally-known unique business identifier for this grievance, used in legal correspondence and guild communications.',
    `grievance_type` STRING COMMENT 'Classification of the grievance by subject matter: compensation dispute, credit dispute, working condition violation, residual underpayment, exclusivity breach, or contract breach.. Valid values are `compensation dispute|credit dispute|working condition violation|residual underpayment|exclusivity breach|contract breach`',
    `guild_representative_contact` STRING COMMENT 'Contact information (email or phone) for the guild representative managing this grievance.',
    `guild_representative_name` STRING COMMENT 'Name of the guild representative or business agent handling this grievance on behalf of the talent.',
    `hearing_date` DATE COMMENT 'Scheduled or actual date of the arbitration hearing or mediation session for this grievance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this grievance record was last updated or modified.',
    `legal_counsel_name` STRING COMMENT 'Name of the legal counsel or attorney representing the filing party in this grievance.',
    `notes` STRING COMMENT 'Additional internal notes, comments, or context regarding the grievance, maintained by business affairs or legal teams.',
    `priority_level` STRING COMMENT 'Priority level assigned to this grievance by the guild or business affairs team: low, medium, high, or urgent.. Valid values are `low|medium|high|urgent`',
    `production_title` STRING COMMENT 'Title of the production (film, series, episode) to which this grievance relates, if applicable.',
    `resolution_date` DATE COMMENT 'Date on which the grievance was formally resolved, either through settlement, arbitration award, withdrawal, or dismissal.',
    `resolution_method` STRING COMMENT 'Method by which the grievance was resolved: negotiated settlement (parties agreed), arbitration award (arbitrator decided), mediation (facilitated agreement), withdrawal (filing party withdrew), or dismissal (rejected by arbitrator or guild).. Valid values are `negotiated settlement|arbitration award|mediation|withdrawal|dismissal`',
    `resolution_status` STRING COMMENT 'Current status of the grievance in its lifecycle: open (filed but not yet in arbitration), in arbitration (active proceedings), settled (parties reached agreement), withdrawn (filing party withdrew), arbitration award issued (arbitrator rendered decision), or dismissed (grievance rejected).. Valid values are `open|in arbitration|settled|withdrawn|arbitration award issued|dismissed`',
    `responding_party_name` STRING COMMENT 'Name of the individual or organization against whom the grievance was filed.',
    `responding_party_type` STRING COMMENT 'Type of entity against whom the grievance was filed: talent (individual), guild, production company, network, or studio.. Valid values are `talent|guild|production company|network|studio`',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Monetary amount agreed upon or awarded as part of the grievance settlement or arbitration award, if applicable.',
    `settlement_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the settlement amount (e.g., USD, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_talent_grievance PRIMARY KEY(`talent_grievance_id`)
) COMMENT 'Operational record of formal grievances, disputes, and arbitration proceedings filed by or against talent or their guild representatives — capturing grievance type (compensation dispute, credit dispute, working condition violation, residual underpayment, exclusivity breach), filing party, responding party, guild involved, grievance filing date, arbitration reference number, hearing date, resolution status (open, in arbitration, settled, withdrawn, arbitration award issued), settlement amount, and resolution date. Supports legal, business affairs, and compliance teams in managing guild relations.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`partner_relationship` (
    `partner_relationship_id` BIGINT COMMENT 'Unique identifier for this talent-partner relationship record. Primary key.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the partner entity in the partner master',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to the talent profile in the talent master',
    `conflict_of_interest_flag` BOOLEAN COMMENT 'Indicates whether there are known conflicts of interest between this talent and partner that require disclosure or management (e.g., competing projects, contractual restrictions).',
    `deal_count` STRING COMMENT 'Total number of individual deals or projects executed between this talent and partner under this relationship. Used for relationship strength assessment.',
    `effective_end_date` DATE COMMENT 'The date when this talent-partner relationship ended or is scheduled to end. Null for ongoing relationships.',
    `effective_start_date` DATE COMMENT 'The date when this talent-partner relationship became active. Used for exclusivity window tracking and deal history analysis.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this relationship includes exclusivity provisions that restrict the talent from working with competing partners during the relationship period.',
    `preferred_partner_flag` BOOLEAN COMMENT 'Indicates whether this partner has preferred status for this talent, meaning the talent or their representation prioritizes opportunities from this partner.',
    `relationship_created_timestamp` TIMESTAMP COMMENT 'The date and time when this talent-partner relationship record was first created in the system.',
    `relationship_status` STRING COMMENT 'Current lifecycle status of the talent-partner relationship. Active indicates ongoing business engagement.',
    `relationship_type` STRING COMMENT 'Classification of the business relationship type between talent and partner. Determines exclusivity scope and deal structure.',
    `relationship_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this talent-partner relationship record was last modified.',
    `total_deal_value` DECIMAL(18,2) COMMENT 'Cumulative monetary value of all deals executed between this talent and partner. Used for strategic tier assessment and relationship ROI analysis.',
    CONSTRAINT pk_partner_relationship PRIMARY KEY(`partner_relationship_id`)
) COMMENT 'This association product represents the ongoing business relationship between talent and external partners (studios, networks, streamers, syndicators). It captures deal history, exclusivity arrangements, preferred status, and conflict tracking that exist only in the context of this specific talent-partner pairing. Each record links one talent to one partner with relationship-specific metadata used for deal sourcing, conflict management, and strategic talent roster management.. Existence Justification: In media broadcasting, talent (actors, directors, writers, producers) routinely maintain simultaneous business relationships with multiple partners (studios, networks, streamers, syndicators) across their careers. Partners likewise maintain rosters of talent relationships spanning dozens to hundreds of individuals. The business actively manages these relationships as distinct entities with relationship-specific metadata including exclusivity windows, deal history, preferred status, and conflict tracking that cannot be attributed to either the talent or partner alone.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` (
    `endorsement_deal_id` BIGINT COMMENT 'Unique identifier for this endorsement deal record. Primary key for the association.',
    `employee_id` BIGINT COMMENT 'Reference to the sales representative or user who created this deal record. Used for sales attribution and commission tracking.',
    `sales_account_id` BIGINT COMMENT 'Foreign key linking to the sales account (advertiser/brand) who is party to this endorsement deal',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to the talent who is party to this endorsement deal',
    `commission_rate` DECIMAL(18,2) COMMENT 'The commission percentage paid to the talents agent or representation agency for this specific deal. This is deal-specific and may vary from the standard agency rate.',
    `contract_end_date` DATE COMMENT 'The expiration date of the endorsement contract. Defines when the talents endorsement obligations and usage rights terminate.',
    `contract_start_date` DATE COMMENT 'The effective start date of the endorsement contract. Defines when the talents endorsement obligations and usage rights begin.',
    `deal_created_timestamp` TIMESTAMP COMMENT 'The date and time when this endorsement deal record was first created in the system. Used for audit and deal pipeline tracking.',
    `deal_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the deal value is denominated (e.g., USD, EUR, GBP).',
    `deal_last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this endorsement deal record was last updated. Used for audit and change tracking.',
    `deal_status` STRING COMMENT 'The current lifecycle status of the endorsement deal. Tracks the deal from negotiation through active performance to completion or termination.',
    `deal_value_amount` DECIMAL(18,2) COMMENT 'The total monetary value of the endorsement deal. This is the contracted compensation amount for the talents endorsement services, which varies by talent-advertiser combination and belongs to the deal itself.',
    `exclusivity_period_end` DATE COMMENT 'The end date of the exclusivity period. After this date, the talent may be free to endorse competitors even if the contract is still active.',
    `exclusivity_period_start` DATE COMMENT 'The start date of any exclusivity period during which the talent cannot endorse competing brands in the same category. May differ from contract start date.',
    `exclusivity_scope` STRING COMMENT 'Defines the product category or competitive scope of the exclusivity clause (e.g., automotive, luxury watches, soft drinks). Determines which competing brands the talent cannot endorse during the exclusivity period.',
    `morals_clause_flag` BOOLEAN COMMENT 'Indicates whether the deal includes a morals clause allowing the advertiser to terminate if the talent engages in conduct that damages their brand reputation.',
    `payment_schedule` STRING COMMENT 'The agreed payment schedule for the deal value (e.g., Lump Sum on Signing, Quarterly Installments, 50% upfront, 50% on completion). Defines how the deal value is disbursed over time.',
    `performance_deliverables` STRING COMMENT 'Description of the specific deliverables the talent must provide (e.g., 2 TV commercials, 4 social media posts per month, 1 live event appearance). Defines the scope of work for this deal.',
    `renewal_deadline_date` DATE COMMENT 'The deadline by which the advertiser must exercise their renewal option, if applicable. After this date, the talent is free to negotiate with other advertisers.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the advertiser has an option to renew the endorsement deal under predefined terms. Used for pipeline forecasting and talent availability planning.',
    `usage_media_types` STRING COMMENT 'The media channels where the advertiser is permitted to use the talents endorsement (e.g., TV, Digital, Print, Social Media Only, All Media). Defines the scope of usage rights.',
    `usage_territory` STRING COMMENT 'The geographic territory or market where the advertiser has rights to use the talents likeness and endorsement (e.g., North America, Global, EU + UK). This is deal-specific and varies by advertiser.',
    CONSTRAINT pk_endorsement_deal PRIMARY KEY(`endorsement_deal_id`)
) COMMENT 'This association product represents the commercial contract between talent_profile and sales_account for endorsement, licensing, or brand ambassador arrangements. It captures the business terms, territorial scope, exclusivity constraints, and financial arrangements that exist only in the context of this specific talent-advertiser relationship. Each record links one talent to one sales account (advertiser/brand) with deal-specific attributes that belong to neither the talent profile nor the sales account alone.. Existence Justification: In the media broadcasting industry, talent can simultaneously hold endorsement deals with multiple non-competing advertisers (e.g., a celebrity endorses a car brand, a beverage brand, and a fashion brand at the same time), and each advertiser/sales account contracts with multiple talent for their campaigns. The business actively manages these endorsement deals as distinct commercial contracts with deal-specific terms including compensation, exclusivity scope, territorial rights, usage permissions, and performance deliverables that belong to neither the talent profile nor the sales account alone.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` (
    `facility_access_id` BIGINT COMMENT 'Unique identifier for this facility access authorization record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee who authorized this facility access. Used for accountability and audit trail purposes.',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to the broadcast facility where access is authorized',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to the talent profile being granted facility access',
    `access_level` STRING COMMENT 'The level of physical access granted to the talent at this facility. Determines which areas and zones within the facility the talent can enter. Values: public_areas, studio_floor, control_room, master_control, noc, restricted, executive.',
    `access_purpose` STRING COMMENT 'Business reason for granting facility access to this talent (e.g., production work, rehearsal, meeting, interview, tour). Used for compliance and security auditing.',
    `access_status` STRING COMMENT 'Current lifecycle status of this facility access authorization. Determines whether the access is currently valid and usable. Values: active, inactive, suspended, revoked.',
    `authorization_date` DATE COMMENT 'Date when this facility access authorization was granted.',
    `background_check_date` DATE COMMENT 'Date when the most recent background check was completed for this talent at this facility. Required for certain facility types with high security classification.',
    `badge_issue_date` DATE COMMENT 'Date when the access badge was issued to the talent for this facility.',
    `badge_number` STRING COMMENT 'Unique physical or digital badge identifier issued to the talent for access to this specific facility. Used by access control systems to grant entry and track movement within the facility.',
    `clearance_expiration_date` DATE COMMENT 'Date when the security clearance for this talent at this facility expires and requires renewal. Critical for maintaining continuous access authorization and compliance with security policies.',
    `clearance_status` STRING COMMENT 'Current security clearance status for this talent at this specific facility. Determines whether the talent is authorized to access the facility. Values: active, pending, expired, revoked, suspended.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility access authorization record was first created in the system.',
    `escort_required_flag` BOOLEAN COMMENT 'Indicates whether the talent must be accompanied by an authorized escort when accessing this facility. Used for visitors, contractors, or talent with limited clearance levels.',
    `insurance_verified_flag` BOOLEAN COMMENT 'Indicates whether production insurance coverage has been verified for this talent at this facility. Required before granting access for production work.',
    `last_access_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent physical access event when the talent entered this facility. Used for security auditing, compliance tracking, and identifying inactive access authorizations.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility access authorization record was most recently modified.',
    CONSTRAINT pk_facility_access PRIMARY KEY(`facility_access_id`)
) COMMENT 'This association product represents the access authorization relationship between talent and broadcast facilities. It captures security clearance, physical access permissions, and compliance tracking for talent working at or visiting specific facilities. Each record links one talent profile to one broadcast facility with attributes that govern access rights, badge issuance, and security compliance requirements specific to that talent-facility combination.. Existence Justification: In media broadcasting operations, talent routinely work across multiple facilities (studios, remote locations, network operations centers) throughout their careers and even within single production cycles. Each facility hosts hundreds of different talent over time. Facility management and security teams actively manage access authorizations as a distinct operational process, tracking clearance status, badge issuance, access levels, and expiration dates specific to each talent-facility pairing to ensure security compliance, insurance verification, and union requirements are met.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ADD CONSTRAINT `fk_talent_talent_profile_talent_agency_id` FOREIGN KEY (`talent_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_agency`(`talent_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ADD CONSTRAINT `fk_talent_guild_affiliation_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ADD CONSTRAINT `fk_talent_compensation_structure_cba_rate_card_id` FOREIGN KEY (`cba_rate_card_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card`(`cba_rate_card_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ADD CONSTRAINT `fk_talent_compensation_structure_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ADD CONSTRAINT `fk_talent_exclusivity_clause_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_rescheduled_from_appearance_schedule_id` FOREIGN KEY (`rescheduled_from_appearance_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule`(`appearance_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ADD CONSTRAINT `fk_talent_credit_attribution_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`role`(`role_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ADD CONSTRAINT `fk_talent_credit_attribution_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ADD CONSTRAINT `fk_talent_residual_eligibility_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ADD CONSTRAINT `fk_talent_residual_eligibility_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_residual_eligibility_id` FOREIGN KEY (`residual_eligibility_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility`(`residual_eligibility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ADD CONSTRAINT `fk_talent_representation_agreement_talent_agency_id` FOREIGN KEY (`talent_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_agency`(`talent_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ADD CONSTRAINT `fk_talent_representation_agreement_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ADD CONSTRAINT `fk_talent_usage_right_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ADD CONSTRAINT `fk_talent_usage_right_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ADD CONSTRAINT `fk_talent_contract_option_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ADD CONSTRAINT `fk_talent_availability_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ADD CONSTRAINT `fk_talent_pension_health_contribution_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ADD CONSTRAINT `fk_talent_pension_health_contribution_guild_affiliation_id` FOREIGN KEY (`guild_affiliation_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation`(`guild_affiliation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ADD CONSTRAINT `fk_talent_pension_health_contribution_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ADD CONSTRAINT `fk_talent_talent_clearance_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ADD CONSTRAINT `fk_talent_talent_clearance_usage_right_id` FOREIGN KEY (`usage_right_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`usage_right`(`usage_right_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ADD CONSTRAINT `fk_talent_cba_rate_card_superseded_by_rate_card_cba_rate_card_id` FOREIGN KEY (`superseded_by_rate_card_cba_rate_card_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card`(`cba_rate_card_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ADD CONSTRAINT `fk_talent_contract_amendment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ADD CONSTRAINT `fk_talent_contract_amendment_superseded_by_amendment_contract_amendment_id` FOREIGN KEY (`superseded_by_amendment_contract_amendment_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract_amendment`(`contract_amendment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ADD CONSTRAINT `fk_talent_talent_grievance_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ADD CONSTRAINT `fk_talent_talent_grievance_guild_affiliation_id` FOREIGN KEY (`guild_affiliation_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation`(`guild_affiliation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ADD CONSTRAINT `fk_talent_talent_grievance_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`partner_relationship` ADD CONSTRAINT `fk_talent_partner_relationship_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ADD CONSTRAINT `fk_talent_endorsement_deal_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ADD CONSTRAINT `fk_talent_facility_access_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`talent` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`talent` SET TAGS ('dbx_domain' = 'talent');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` SET TAGS ('dbx_subdomain' = 'talent_identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` SET TAGS ('dbx_subdomain' = 'talent_identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `coppa_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Coppa Declaration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `production_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Production Budget Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Negotiated By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `talent_representative_agency` SET TAGS ('dbx_business_glossary_term' = 'Talent Representative Agency Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `talent_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Talent Representative Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `cba_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Cba Rate Card Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_value_regex' = 'SAG-AFTRA|WGA|DGA|IATSE|non_union');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `exclusivity_clause_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Clause ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `breach_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Breach Incident Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `clause_number` SET TAGS ('dbx_business_glossary_term' = 'Clause Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_value_regex' = 'active|suspended|waived|expired|terminated');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `exclusivity_type` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `exclusivity_type` SET TAGS ('dbx_value_regex' = 'category_exclusivity|network_exclusivity|platform_exclusivity|geographic_exclusivity|time_exclusivity|project_exclusivity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `holdback_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Holdback Window End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `holdback_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Holdback Window Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `last_breach_date` SET TAGS ('dbx_business_glossary_term' = 'Last Breach Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `legal_review_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `legal_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `negotiated_by` SET TAGS ('dbx_business_glossary_term' = 'Negotiated By');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Clause Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `penalty_provision` SET TAGS ('dbx_business_glossary_term' = 'Penalty Provision');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `penalty_provision` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `permitted_carveout_activities` SET TAGS ('dbx_business_glossary_term' = 'Permitted Carve-Out Activities');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `restricted_competitor_list` SET TAGS ('dbx_business_glossary_term' = 'Restricted Competitor List');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `restricted_competitor_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `waiver_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `waiver_granted_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`exclusivity_clause` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` SET TAGS ('dbx_subdomain' = 'production_scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `appearance_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Appearance Schedule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `rescheduled_from_appearance_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rescheduled From Appearance Schedule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `studio_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Studio Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `sweeps_period_id` SET TAGS ('dbx_business_glossary_term' = 'Sweeps Period Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` SET TAGS ('dbx_subdomain' = 'rights_clearance');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `credit_attribution_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Attribution ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Role Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `possessory_credit_flag` SET TAGS ('dbx_business_glossary_term' = 'Possessory Credit Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `promotional_materials_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Materials Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `pseudonym` SET TAGS ('dbx_business_glossary_term' = 'Pseudonym');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `streaming_metadata_flag` SET TAGS ('dbx_business_glossary_term' = 'Streaming Metadata Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` SET TAGS ('dbx_subdomain' = 'residual_payments');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `buyout_amount` SET TAGS ('dbx_business_glossary_term' = 'Buyout Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `buyout_applied` SET TAGS ('dbx_business_glossary_term' = 'Buyout Applied');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `distribution_window` SET TAGS ('dbx_business_glossary_term' = 'Distribution Window');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `eligibility_determination_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Determination Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'Eligible|Ineligible|Pending Review|Disputed|Waived|Expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `exclusivity_clause_applies` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Clause Applies');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_value_regex' = 'SAG-AFTRA|WGA|DGA|IATSE|AFM|Non-Guild');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `health_contribution_applicable` SET TAGS ('dbx_business_glossary_term' = 'Health Contribution Applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `health_contribution_applicable` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `health_contribution_applicable` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `health_contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Health Contribution Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `health_contribution_rate` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `health_contribution_rate` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `minimum_residual_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Residual Threshold');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'Per Use|Quarterly|Semi-Annual|Annual|One-Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `pension_contribution_applicable` SET TAGS ('dbx_business_glossary_term' = 'Pension Contribution Applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `pension_contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Pension Contribution Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Residual Base Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_formula_type` SET TAGS ('dbx_business_glossary_term' = 'Residual Formula Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_formula_type` SET TAGS ('dbx_value_regex' = 'SAG-AFTRA TV Residuals|Theatrical Residuals|New Media Residuals|Streaming Supplemental|Foreign Broadcast Residuals|Home Video Residuals');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `residual_percentage` SET TAGS ('dbx_business_glossary_term' = 'Residual Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `rightsline_integration_code` SET TAGS ('dbx_business_glossary_term' = 'Rightsline Integration ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `sap_payables_reference` SET TAGS ('dbx_business_glossary_term' = 'SAP Payables Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `territory` SET TAGS ('dbx_business_glossary_term' = 'Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `use_type` SET TAGS ('dbx_business_glossary_term' = 'Use Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` SET TAGS ('dbx_subdomain' = 'residual_payments');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `residual_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Residual Payment ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `content_license_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Content License Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `residual_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_business_glossary_term' = 'Automated Clearing House (ACH) Trace Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `agent_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Agent Commission Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `audit_report_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `audit_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `distribution_window` SET TAGS ('dbx_business_glossary_term' = 'Distribution Window');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `exhibition_end_date` SET TAGS ('dbx_business_glossary_term' = 'Exhibition End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `exhibition_start_date` SET TAGS ('dbx_business_glossary_term' = 'Exhibition Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `gross_residual_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Residual Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_value_regex' = 'SAG-AFTRA|WGA|DGA|IATSE|AFM|non_union');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `other_deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Deductions Amount');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Deal Memo ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `guarantee_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Guarantee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Long-Form Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Production Title ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Source Opportunity ID');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `role_function` SET TAGS ('dbx_business_glossary_term' = 'Role or Function');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Superseded Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` SET TAGS ('dbx_subdomain' = 'production_scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Role ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` SET TAGS ('dbx_subdomain' = 'talent_identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Agency Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` SET TAGS ('dbx_subdomain' = 'talent_identity');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` SET TAGS ('dbx_subdomain' = 'rights_clearance');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `usage_right_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Right ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `content_license_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Content License Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `clearance_granted_by` SET TAGS ('dbx_business_glossary_term' = 'Clearance Granted By');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `clearance_granted_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Granted Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `clearance_requested_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Requested Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|conditionally_cleared|blocked|expired|revoked');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `consent_obtained_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `credit_attribution_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Attribution Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `credit_attribution_text` SET TAGS ('dbx_business_glossary_term' = 'Credit Attribution Text');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `residual_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Residual Rate Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `residual_rate_type` SET TAGS ('dbx_value_regex' = 'flat_fee|percentage|per_use|tiered|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `right_type` SET TAGS ('dbx_business_glossary_term' = 'Right Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `right_type` SET TAGS ('dbx_value_regex' = 'broadcast|streaming|vod|svod|avod|tvod');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `territory` SET TAGS ('dbx_business_glossary_term' = 'Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `usage_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Usage Limit Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `usage_limit_type` SET TAGS ('dbx_value_regex' = 'unlimited|run_count|time_duration|impression_count|revenue_cap');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `usage_limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Usage Limit Unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `usage_limit_unit` SET TAGS ('dbx_value_regex' = 'runs|days|impressions|usd|eur|gbp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `usage_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Usage Limit Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `usage_scope` SET TAGS ('dbx_business_glossary_term' = 'Usage Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'contract_review|legal_clearance|agent_confirmation|automated_system|manual_audit');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Window End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ALTER COLUMN `window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Window Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `contract_option_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Option ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `business_affairs_contact` SET TAGS ('dbx_business_glossary_term' = 'Business Affairs Contact');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `compensation_step_up_percentage` SET TAGS ('dbx_business_glossary_term' = 'Compensation Step-Up Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `compensation_step_up_percentage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `compensation_step_up_percentage` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `exclusivity_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Clause Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `exercise_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Exercise Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `exercise_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Exercise Compensation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `exercise_compensation_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `exercise_compensation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `exercise_compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Exercise Compensation Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `exercise_compensation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `exercise_compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `exercise_compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `exercise_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Exercise Notification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `exercise_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Exercise Notification Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `exercise_notification_method` SET TAGS ('dbx_value_regex' = 'written_notice|email|certified_mail|electronic_signature|verbal_confirmed|agent_notification');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `exercise_status` SET TAGS ('dbx_business_glossary_term' = 'Exercise Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `exercise_status` SET TAGS ('dbx_value_regex' = 'unexercised|exercised|lapsed|waived|pending_approval|conditionally_exercised');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `guild_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Guild Notification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `guild_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Guild Notification Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `lapse_date` SET TAGS ('dbx_business_glossary_term' = 'Lapse Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `lapse_reason` SET TAGS ('dbx_business_glossary_term' = 'Lapse Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `option_description` SET TAGS ('dbx_business_glossary_term' = 'Option Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `option_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Option Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `option_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Option Fee Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `option_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `option_number` SET TAGS ('dbx_business_glossary_term' = 'Option Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `option_type` SET TAGS ('dbx_business_glossary_term' = 'Option Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `option_type` SET TAGS ('dbx_value_regex' = 'series_pickup|sequel|spin_off|overall_deal_extension|season_renewal|project_continuation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `option_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Option Window End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `option_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Option Window Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `performance_trigger_description` SET TAGS ('dbx_business_glossary_term' = 'Performance Trigger Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `performance_trigger_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Trigger Met Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_option` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` SET TAGS ('dbx_subdomain' = 'production_scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `availability_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Availability ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `studio_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Studio Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `availability_type` SET TAGS ('dbx_business_glossary_term' = 'Availability Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `availability_type` SET TAGS ('dbx_value_regex' = 'available|hold|first_refusal|confirmed_booking|personal_unavailability|conflicting_production');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `booking_confirmed_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Confirmed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'tentative|confirmed|cancelled|released|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `conflict_production_network` SET TAGS ('dbx_business_glossary_term' = 'Conflict Production Network');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `conflict_production_title` SET TAGS ('dbx_business_glossary_term' = 'Conflict Production Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Availability End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `exclusivity_conflict_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Conflict Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `guild_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Guild Notification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `guild_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Guild Notification Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `hold_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `hold_level` SET TAGS ('dbx_business_glossary_term' = 'Hold Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `hold_level` SET TAGS ('dbx_value_regex' = 'first_hold|second_hold|third_hold');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `hold_placed_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Placed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `hold_released_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Released Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Availability Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `requesting_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Requesting Contact Email');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `requesting_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `requesting_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `requesting_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Requesting Contact Phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `requesting_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `requesting_department` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `requesting_producer_name` SET TAGS ('dbx_business_glossary_term' = 'Requesting Producer Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Availability Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `unavailability_reason` SET TAGS ('dbx_business_glossary_term' = 'Unavailability Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` SET TAGS ('dbx_subdomain' = 'residual_payments');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `pension_health_contribution_id` SET TAGS ('dbx_business_glossary_term' = 'Pension and Health (P&H) Contribution ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `pension_health_contribution_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `pension_health_contribution_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `contribution_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contribution Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `contribution_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contribution Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `contribution_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contribution Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `contribution_type` SET TAGS ('dbx_business_glossary_term' = 'Contribution Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `contribution_type` SET TAGS ('dbx_value_regex' = 'Initial Compensation|Residual|Reuse|Supplemental');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|GBP|EUR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `employee_contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `employer_contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `gross_compensation_base` SET TAGS ('dbx_business_glossary_term' = 'Gross Compensation Base');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `gross_compensation_base` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `gross_compensation_base` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `guild_acknowledgment_number` SET TAGS ('dbx_business_glossary_term' = 'Guild Acknowledgment Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `guild_fund_code` SET TAGS ('dbx_business_glossary_term' = 'Guild Fund Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `guild_fund_name` SET TAGS ('dbx_business_glossary_term' = 'Guild Fund Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `late_payment_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|Wire Transfer|Check|EFT');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'Pending|Reconciled|Discrepancy|Under Review|Resolved');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `remittance_date` SET TAGS ('dbx_business_glossary_term' = 'Remittance Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `remittance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remittance Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `total_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Contribution Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `work_type` SET TAGS ('dbx_business_glossary_term' = 'Work Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ALTER COLUMN `work_type` SET TAGS ('dbx_value_regex' = 'Principal Photography|Post-Production|Voice Over|ADR|Residual|Reuse');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` SET TAGS ('dbx_subdomain' = 'rights_clearance');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `talent_clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Clearance ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `ad_sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cleared Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By User Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `usage_right_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Right Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `air_date` SET TAGS ('dbx_business_glossary_term' = 'Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|conditionally cleared|blocked|expired|withdrawn');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `clearance_type` SET TAGS ('dbx_business_glossary_term' = 'Clearance Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `clearance_type` SET TAGS ('dbx_value_regex' = 'broadcast clearance|promotional clearance|social media clearance|international clearance|theatrical clearance|home video clearance');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `conditional_terms` SET TAGS ('dbx_business_glossary_term' = 'Conditional Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `exclusivity_conflict_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Conflict Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `granted_by` SET TAGS ('dbx_business_glossary_term' = 'Clearance Granted By');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `granted_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Granted Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `guild_clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Guild Clearance Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `guild_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Guild Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `guild_clearance_status` SET TAGS ('dbx_value_regex' = 'not required|pending|approved|denied');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `guild_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Guild Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `likeness_usage_flag` SET TAGS ('dbx_business_glossary_term' = 'Likeness Usage Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `name_usage_flag` SET TAGS ('dbx_business_glossary_term' = 'Name Usage Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Clearance Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `performance_usage_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Usage Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `residual_payment_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Payment Triggered Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `reviewed_by_legal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Legal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `talent_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Talent Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `talent_approval_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Talent Approval Received Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `talent_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Talent Approval Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `usage_category` SET TAGS ('dbx_business_glossary_term' = 'Usage Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ALTER COLUMN `usage_category` SET TAGS ('dbx_value_regex' = 'primary broadcast|rerun|syndication|promotional|archival|clip licensing');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `cba_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Rate Card ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `superseded_by_rate_card_cba_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Rate Card ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `budget_tier` SET TAGS ('dbx_business_glossary_term' = 'Budget Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `cba_code` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `cba_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `cba_name` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `cba_ratification_date` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Ratification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `cba_version` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `forced_call_penalty_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Forced Call Penalty Multiplier');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `golden_time_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Golden Time Multiplier');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `guild_code` SET TAGS ('dbx_business_glossary_term' = 'Guild Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `job_classification` SET TAGS ('dbx_business_glossary_term' = 'Job Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `local_chapter` SET TAGS ('dbx_business_glossary_term' = 'Local Chapter');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `meal_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Meal Penalty Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `minimum_scale_rate` SET TAGS ('dbx_business_glossary_term' = 'Minimum Scale Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Multiplier');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `overtime_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Threshold Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `pension_health_contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Pension and Health (P&H) Contribution Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `pension_health_contribution_rate` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `pension_health_contribution_rate` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `performer_category` SET TAGS ('dbx_business_glossary_term' = 'Performer Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `production_type` SET TAGS ('dbx_business_glossary_term' = 'Production Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'active|expired|superseded|pending|draft');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'day_rate|weekly_rate|episodic_rate|theatrical_rate|session_rate|hourly_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `residual_formula_code` SET TAGS ('dbx_business_glossary_term' = 'Residual Formula Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `turnaround_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `contract_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `superseded_by_amendment_contract_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Amendment Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `amended_clause_reference` SET TAGS ('dbx_business_glossary_term' = 'Amended Clause Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `amended_term_value` SET TAGS ('dbx_business_glossary_term' = 'Amended Term Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|pending_signature|executed|rejected|superseded');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `business_affairs_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Business Affairs Approver Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `company_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Company Signature Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `compensation_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Impact Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `compensation_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `compensation_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Impact Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `compensation_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `compensation_impact_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `compensation_impact_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `document_reference_uri` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Uniform Resource Identifier (URI)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Execution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `guild_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Guild Notification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `guild_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Guild Notification Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `legal_review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `legal_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Amendment Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `original_term_value` SET TAGS ('dbx_business_glossary_term' = 'Original Term Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Rejection Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `residual_calculation_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Calculation Impact Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `talent_representative_agency` SET TAGS ('dbx_business_glossary_term' = 'Talent Representative Agency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `talent_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Talent Representative Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `talent_representative_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ALTER COLUMN `talent_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Talent Signature Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` SET TAGS ('dbx_subdomain' = 'residual_payments');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `talent_grievance_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Grievance ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filing Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `arbitration_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `arbitrator_name` SET TAGS ('dbx_business_glossary_term' = 'Arbitrator Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `cba_version` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `disputed_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Disputed Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `disputed_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Grievance Filing Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `filing_party_name` SET TAGS ('dbx_business_glossary_term' = 'Filing Party Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `filing_party_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Party Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `filing_party_type` SET TAGS ('dbx_value_regex' = 'talent|guild|production company|network|studio');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `grievance_description` SET TAGS ('dbx_business_glossary_term' = 'Grievance Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `grievance_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `grievance_number` SET TAGS ('dbx_business_glossary_term' = 'Grievance Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `grievance_type` SET TAGS ('dbx_business_glossary_term' = 'Grievance Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `grievance_type` SET TAGS ('dbx_value_regex' = 'compensation dispute|credit dispute|working condition violation|residual underpayment|exclusivity breach|contract breach');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `guild_representative_contact` SET TAGS ('dbx_business_glossary_term' = 'Guild Representative Contact');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `guild_representative_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `guild_representative_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `guild_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Guild Representative Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `hearing_date` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Hearing Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `legal_counsel_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Grievance Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Grievance Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `production_title` SET TAGS ('dbx_business_glossary_term' = 'Production Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Grievance Resolution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Resolution Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `resolution_method` SET TAGS ('dbx_value_regex' = 'negotiated settlement|arbitration award|mediation|withdrawal|dismissal');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Grievance Resolution Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|in arbitration|settled|withdrawn|arbitration award issued|dismissed');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `responding_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responding Party Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `responding_party_type` SET TAGS ('dbx_business_glossary_term' = 'Responding Party Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `responding_party_type` SET TAGS ('dbx_value_regex' = 'talent|guild|production company|network|studio');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`partner_relationship` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`partner_relationship` SET TAGS ('dbx_subdomain' = 'talent_identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`partner_relationship` SET TAGS ('dbx_association_edges' = 'talent.talent_profile,partner.partner_partner');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`partner_relationship` ALTER COLUMN `partner_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Talent-Partner Relationship ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`partner_relationship` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Partner Relationship - Partner Partner Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`partner_relationship` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Partner Relationship - Talent Profile Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`partner_relationship` ALTER COLUMN `conflict_of_interest_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`partner_relationship` ALTER COLUMN `deal_count` SET TAGS ('dbx_business_glossary_term' = 'Deal Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`partner_relationship` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`partner_relationship` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`partner_relationship` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`partner_relationship` ALTER COLUMN `preferred_partner_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Partner Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`partner_relationship` ALTER COLUMN `relationship_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Relationship Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`partner_relationship` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`partner_relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`partner_relationship` ALTER COLUMN `relationship_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Relationship Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`partner_relationship` ALTER COLUMN `total_deal_value` SET TAGS ('dbx_business_glossary_term' = 'Total Deal Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` SET TAGS ('dbx_subdomain' = 'rights_clearance');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` SET TAGS ('dbx_association_edges' = 'talent.talent_profile,sales.sales_account');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `endorsement_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Deal Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Deal - Sales Account Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Deal - Talent Profile Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `deal_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deal Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `deal_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Deal Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `deal_last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deal Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_business_glossary_term' = 'Deal Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `deal_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Deal Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `deal_value_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `exclusivity_period_end` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period End');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `exclusivity_period_start` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period Start');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `morals_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Morals Clause Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `performance_deliverables` SET TAGS ('dbx_business_glossary_term' = 'Performance Deliverables');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `renewal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Deadline Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `usage_media_types` SET TAGS ('dbx_business_glossary_term' = 'Usage Media Types');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ALTER COLUMN `usage_territory` SET TAGS ('dbx_business_glossary_term' = 'Usage Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` SET TAGS ('dbx_subdomain' = 'production_scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` SET TAGS ('dbx_association_edges' = 'talent.talent_profile,technology.broadcast_facility');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ALTER COLUMN `facility_access_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Access ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized By Employee');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Access - Broadcast Facility Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Access - Talent Profile Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ALTER COLUMN `access_purpose` SET TAGS ('dbx_business_glossary_term' = 'Access Purpose');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ALTER COLUMN `access_status` SET TAGS ('dbx_business_glossary_term' = 'Access Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ALTER COLUMN `badge_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Badge Issue Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ALTER COLUMN `badge_number` SET TAGS ('dbx_business_glossary_term' = 'Badge Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ALTER COLUMN `clearance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ALTER COLUMN `escort_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escort Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ALTER COLUMN `insurance_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Verified Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ALTER COLUMN `last_access_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Access Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
