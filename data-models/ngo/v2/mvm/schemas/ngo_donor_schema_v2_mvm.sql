-- Schema for Domain: donor | Business: Ngo | Version: v2_mvm
-- Generated on: 2026-07-10 20:23:30

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`donor` COMMENT 'SSOT for all donor and funder relationships including institutional donors (USAID, DFID, UN agencies, DAC members), foundations, corporate sponsors, and individual major gift contributors. Manages donor cultivation, prospect research, stewardship, gift processing, pledge management, and CRM constituent engagement in Salesforce Nonprofit Cloud and Raisers Edge NXT.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`donor`.`constituent` (
    `constituent_id` BIGINT COMMENT 'Unique identifier for the constituent record. Primary key for the constituent entity representing every donor, funder, and supporter in the CRM (Constituent Relationship Management) system.',
    `country_id` BIGINT COMMENT 'add column country_id (BIGINT) with FK to field.country.country_id - donor constituents have a country of residence/registration that is essential for compliance and stewardship',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Constituents (donors) are managed by specific country offices — local major donors are assigned to the country office relationship management team. Portfolio assignment by country office is standard N',
    `communication_preference` STRING COMMENT 'The constituents preferred method of communication for stewardship, acknowledgment, and cultivation activities.. Valid values are `email|phone|mail|sms|no_contact`',
    `constituent_type` STRING COMMENT 'The classification of the constituent entity. Individual = private person major gift donor; Institutional = government agency or public sector donor (USAID, DFID/FCDO); Foundation = private or family foundation; Corporate = business or corporate sponsor; Bilateral = government-to-government donor (DAC member); Multilateral = international organization (UN agencies, World Bank); Household = family unit for joint giving. [ENUM-REF-CANDIDATE: individual|institutional|foundation|corporate|bilateral|multilateral|household — 7 candidates stripped; promote to reference product]',
    `country_of_origin` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code representing the constituents country of origin or headquarters. For bilateral and multilateral donors, this is the donor country. For foundations and corporates, this is the country of incorporation.. Valid values are `^[A-Z]{3}$`',
    `crm_source_record_code` STRING COMMENT 'The unique identifier of this constituent record in the source CRM system. Used for data lineage, reconciliation, and bi-directional sync.',
    `crm_source_system` STRING COMMENT 'The source CRM system from which this constituent record originated. Salesforce Nonprofit Cloud = Salesforce NPSP or Nonprofit Cloud; Raisers Edge NXT = Blackbaud Raisers Edge NXT; Other = other donor management system.. Valid values are `salesforce_nonprofit_cloud|raisers_edge_nxt|other`',
    `dac_member_flag` BOOLEAN COMMENT 'Indicates whether this constituent is a member of the OECD Development Assistance Committee. True = DAC member; False = not a DAC member. Used for ODA reporting and donor classification.',
    `deceased_date` DATE COMMENT 'The date on which the constituent passed away. Used for planned giving, estate gift tracking, and memorial acknowledgment.',
    `deceased_flag` BOOLEAN COMMENT 'Indicates whether the constituent is deceased. True = deceased; False = living. Used to prevent inappropriate communications and for planned giving tracking.',
    `email_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the constituent has explicitly consented to receive email communications. True = opted in; False = opted out or consent not given.',
    `estimated_giving_capacity` DECIMAL(18,2) COMMENT 'The estimated total giving capacity of the constituent based on wealth screening, prospect research, and capacity analysis. Expressed in USD. Used for major gift solicitation strategy and campaign goal setting.',
    `first_gift_date` DATE COMMENT 'The date of the first gift or grant received from this constituent. Used for donor tenure analysis, anniversary recognition, and retention metrics.',
    `funder_classification` STRING COMMENT 'The classification of the funder based on international development and humanitarian standards. Bilateral = government-to-government donor; Multilateral = international organization (UN, World Bank); DAC Member = OECD Development Assistance Committee member country; Foundation = private or family foundation; Corporate = business or corporate sponsor; Individual = private individual donor; Other = other funder type. [ENUM-REF-CANDIDATE: bilateral|multilateral|dac_member|foundation|corporate|individual|other — 7 candidates stripped; promote to reference product]',
    `gdpr_consent_date` DATE COMMENT 'The date on which the constituent provided GDPR consent for data processing. Used for audit and compliance tracking.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether the constituent has provided explicit consent for data processing under GDPR requirements. True = consent given; False = consent not given or withdrawn.',
    `iati_organization_identifier` STRING COMMENT 'The globally unique identifier for the organization as registered in the IATI registry. Used for transparency reporting and tracking ODA (Official Development Assistance) flows. Format: country-code-registration-agency-identifier (e.g., US-EIN-123456789, GB-COH-12345678).. Valid values are `^[A-Z]{2}-[A-Z]+-[0-9A-Z]+$`',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'The negotiated indirect cost rate (also known as NICRA - Negotiated Indirect Cost Rate Agreement) that this donor allows for F&A (Facilities and Administration) costs. Expressed as a decimal (e.g., 0.1500 for 15%). Used for grant budgeting and financial planning.',
    `largest_gift_amount` DECIMAL(18,2) COMMENT 'The amount of the largest single gift or grant received from this constituent. Expressed in USD. Used for major gift benchmarking and solicitation strategy.',
    `last_gift_date` DATE COMMENT 'The date of the most recent gift or grant received from this constituent. Used for lapsed donor identification, recency-frequency-monetary (RFM) analysis, and re-engagement campaigns.',
    `legal_name` STRING COMMENT 'The full legal name of the constituent as registered with government authorities or as appears on official documents. For individuals, this is the full legal name; for organizations, this is the registered entity name.',
    `lifetime_giving_total` DECIMAL(18,2) COMMENT 'The cumulative total of all gifts and grants received from this constituent since the first gift date. Expressed in USD. Used for donor recognition, stewardship segmentation, and major gift qualification.',
    `mailing_address_line1` STRING COMMENT 'The first line of the constituents mailing address, typically containing street number and street name or PO Box.',
    `mailing_address_line2` STRING COMMENT 'The second line of the constituents mailing address, typically containing apartment, suite, or building information.',
    `mailing_city` STRING COMMENT 'The city or municipality of the constituents mailing address.',
    `mailing_country_code` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code of the constituents mailing address (e.g., USA, GBR, CHE).. Valid values are `^[A-Z]{3}$`',
    `mailing_postal_code` STRING COMMENT 'The postal code or ZIP code of the constituents mailing address.',
    `mailing_state_province` STRING COMMENT 'The state, province, or administrative region of the constituents mailing address.',
    `oda_eligibility_flag` BOOLEAN COMMENT 'Indicates whether gifts from this constituent qualify as ODA under DAC (Development Assistance Committee) criteria. True = ODA-eligible; False = not ODA-eligible. Used for IATI reporting and donor transparency.',
    `preferred_grant_modality` STRING COMMENT 'The type of grant funding this donor typically provides. Restricted = tied to specific projects or activities; Unrestricted = general operating support; Project = specific project funding; Program = program-level funding; Core = institutional core support; Capital = infrastructure or capital expenditure; Endowment = long-term endowment funding. [ENUM-REF-CANDIDATE: restricted|unrestricted|project|program|core|capital|endowment — 7 candidates stripped; promote to reference product]',
    `preferred_name` STRING COMMENT 'The name the constituent prefers to be addressed by in communications and correspondence. May differ from legal name for individuals (e.g., nickname, shortened name) or organizations (e.g., brand name, acronym).',
    `primary_email` STRING COMMENT 'The primary email address for constituent communication, gift acknowledgment, and stewardship correspondence. This is the operational source of truth for digital outreach.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'The primary telephone number for constituent contact. May include country code, area code, and extension for institutional donors.',
    `prospect_research_rating` STRING COMMENT 'The wealth screening and prospect research rating assigned to this constituent. A = highest capacity and propensity; B = high capacity; C = moderate capacity; D = lower capacity; Unrated = not yet screened. Used for major gift cultivation and campaign planning.. Valid values are `A|B|C|D|unrated`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this constituent record was first created in the system. Used for audit trail and data lineage.',
    `record_status` STRING COMMENT 'The current lifecycle status of this constituent record. Active = current and valid; Inactive = no longer active but retained for history; Merged = merged into another record; Duplicate = identified as duplicate; Archived = archived for compliance retention.. Valid values are `active|inactive|merged|duplicate|archived`',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this constituent record was last updated. Used for change tracking, data freshness monitoring, and incremental load processing.',
    `relationship_tier` STRING COMMENT 'The donor cultivation and stewardship tier assigned to this constituent based on giving history, capacity, and engagement. Major = major gift donor; Principal = top-tier institutional funder; Leadership = leadership circle member; Sustaining = recurring donor; Annual = annual fund donor; Lapsed = former donor; Prospect = prospective donor under cultivation. [ENUM-REF-CANDIDATE: major|principal|leadership|sustaining|annual|lapsed|prospect — 7 candidates stripped; promote to reference product]',
    `salutation` STRING COMMENT 'The formal greeting or title used when addressing the constituent in written or verbal communication (e.g., Mr., Ms., Dr., His Excellency, The Honorable).',
    CONSTRAINT pk_constituent PRIMARY KEY(`constituent_id`)
) COMMENT 'Master identity record and single source of truth for all donor and funder constituents across Salesforce Nonprofit Cloud and Raisers Edge NXT. Represents every entity that gives to or funds the NGO — individual major gift contributors, institutional donors (USAID, DFID/FCDO, UN agencies, DAC members), bilateral and multilateral agencies, private foundations, corporate sponsors, and households. Captures full constituent profile including legal name, preferred name/salutation, constituent type (individual, institutional, foundation, corporate, bilateral, multilateral, household), organization affiliation, IATI organization identifier, communication preferences, GDPR/data consent flags, deceased indicator, ODA eligibility flag, indirect cost rate (ICR/NICRA) terms, preferred grant modality, relationship tier, funder classification (bilateral, multilateral, DAC), country of origin, and CRM source system reference. All gift, pledge, grant, soft credit, and cultivation records reference this entity as the authoritative donor identity.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`donor`.`prospect` (
    `prospect_id` BIGINT COMMENT 'Unique identifier for the prospect record. Primary key for the prospect entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to donor.campaign. Business justification: Prospects are often identified through specific campaigns (e.g., acquisition campaign identifies new prospects). Campaign attribution for prospect identification enables source tracking and campaign e',
    `constituent_id` BIGINT COMMENT 'Reference to the constituent record in the CRM (Constituent Relationship Management) system. Links prospect to their constituent profile in Salesforce Nonprofit Cloud or Raisers Edge NXT.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Prospects are assigned to country offices for cultivation and solicitation. Country office fundraising teams manage their own prospect pipelines. Country office prospect pipeline reporting and solicit',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: A prospect in the cultivation pipeline is typically being cultivated toward a specific donor-designated fund (e.g., an endowment, a restricted program fund). Linking prospect.donor_fund_id → donor_fun',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Co-financing prospect pipeline management: NGOs actively prospect partner orgs for major co-funding commitments. A direct prospect→partner_org link enables partner-specific prospect pipeline reports a',
    `proposal_id` BIGINT COMMENT 'Foreign key linking to grant.proposal. Business justification: NGO business development teams cultivate prospects in the context of specific proposals being developed. Tracking prospect-to-proposal pipeline is a named BD process enabling win/loss analysis and pro',
    `ability_score` STRING COMMENT 'Ability score component of the LAI (Linkage-Ability-Interest) assessment. Measures financial capacity to make a significant gift. Typically scored 1-5.',
    `board_affiliation` STRING COMMENT 'Known board memberships or trustee positions held by the prospect at other nonprofit organizations, foundations, or corporate boards. Indicates philanthropic engagement and network connections.',
    `communication_preference` STRING COMMENT 'Prospects preferred method of communication for cultivation and stewardship activities.. Valid values are `email|phone|mail|in_person|no_preference`',
    `conversion_date` DATE COMMENT 'Date when the prospect converted to an active donor by making their first gift or grant commitment. Null if not yet converted.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this prospect record was first created in the system. Audit trail field for data governance.',
    `cultivation_strategy` STRING COMMENT 'Detailed narrative describing the cultivation strategy, engagement plan, and relationship-building approach for this prospect. Includes key talking points, areas of interest, preferred communication channels, and strategic next steps.',
    `disqualification_reason` STRING COMMENT 'Explanation for why the prospect was disqualified from active cultivation. Null if prospect is not disqualified. Examples: Insufficient capacity, No mission alignment, Unresponsive to outreach, Ethical concerns.',
    `donor_recognition_preference` STRING COMMENT 'Prospects stated preference for public recognition of their giving. Public (full recognition in donor lists and materials), Anonymous (no public attribution), Limited (recognition in select contexts only), No Preference (not yet specified).. Valid values are `public|anonymous|limited|no_preference`',
    `email_address` STRING COMMENT 'Primary email address for prospect communication and correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `estimated_capacity` DECIMAL(18,2) COMMENT 'Estimated total giving capacity of the prospect in USD. Based on wealth screening, research, and capacity assessment. For institutional donors, represents estimated annual grant-making budget available for alignment with organizational mission.',
    `estimated_gift_range_max` DECIMAL(18,2) COMMENT 'Maximum estimated gift amount expected from this prospect in USD. Upper bound of the anticipated solicitation range.',
    `estimated_gift_range_min` DECIMAL(18,2) COMMENT 'Minimum estimated gift amount expected from this prospect in USD. Lower bound of the anticipated solicitation range.',
    `expected_close_date` DATE COMMENT 'Anticipated date when the prospect is expected to make a commitment decision or when grant award notification is expected.',
    `geographic_interest` STRING COMMENT 'Geographic regions or countries where the prospect has expressed interest in supporting programs. Comma-separated list of ISO 3166-1 alpha-3 country codes or regional descriptors.',
    `identification_date` DATE COMMENT 'Date when the prospect was first identified and entered into the cultivation pipeline. Marks the beginning of the prospect lifecycle.',
    `interest_score` STRING COMMENT 'Interest score component of the LAI (Linkage-Ability-Interest) assessment. Measures alignment of prospects philanthropic interests with organizational mission and programs. Typically scored 1-5.',
    `last_contact_date` DATE COMMENT 'Date of the most recent meaningful contact or engagement with the prospect. Includes meetings, calls, events, correspondence.',
    `last_contact_type` STRING COMMENT 'Type of the most recent contact or engagement activity with the prospect. [ENUM-REF-CANDIDATE: meeting|phone_call|email|event|site_visit|proposal_submission|other — 7 candidates stripped; promote to reference product]',
    `linkage_score` STRING COMMENT 'Linkage score component of the LAI (Linkage-Ability-Interest) assessment. Measures strength of existing connections to the organization (board members, staff, volunteers, beneficiaries). Typically scored 1-5.',
    `mailing_address` STRING COMMENT 'Full mailing address for prospect correspondence. Includes street address, city, state/province, postal code, and country.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this prospect record was last modified. Audit trail field for data governance and change tracking.',
    `prospect_name` STRING COMMENT 'Full legal or preferred name of the prospective donor or funder. For institutional donors, this is the organization name.',
    `next_action_date` DATE COMMENT 'Scheduled date for the next cultivation activity or touchpoint with this prospect. Used for pipeline management and follow-up tracking.',
    `next_action_description` STRING COMMENT 'Description of the planned next cultivation action or engagement activity (e.g., Schedule site visit, Send program impact report, Invite to annual gala, Submit grant proposal).',
    `phone_number` STRING COMMENT 'Primary phone number for prospect contact. Includes country code for international prospects.',
    `previous_giving_history` STRING COMMENT 'Summary of the prospects known philanthropic giving history to other organizations or prior gifts to this organization. Includes gift amounts, recipient organizations, and giving patterns.',
    `probability_percentage` DECIMAL(18,2) COMMENT 'Estimated probability (0-100%) that this prospect will convert to an active donor and make a gift. Used for pipeline forecasting and weighted revenue projections.',
    `program_interest_area` STRING COMMENT 'Primary program area or thematic focus that aligns with the prospects philanthropic interests (e.g., WASH, Education, Health, Emergency Response, Gender Equality). May reference SDG (Sustainable Development Goal) alignment.',
    `prospect_status` STRING COMMENT 'Current operational status of the prospect record. Active (currently being cultivated), Inactive (no current engagement), Disqualified (determined not viable), Converted (became active donor), On Hold (temporarily paused cultivation).. Valid values are `active|inactive|disqualified|converted|on_hold`',
    `prospect_type` STRING COMMENT 'Classification of the prospect by donor category. Individual (major gift prospects), Foundation (private/family/community foundations), Corporate (corporate sponsors), Institutional (USAID, DFID, DAC members), Government (bilateral government donors), Multilateral (UN agencies, World Bank, regional development banks).. Valid values are `individual|foundation|corporate|institutional|government|multilateral`',
    `qualification_date` DATE COMMENT 'Date when the prospect was qualified as a viable cultivation target after initial research and assessment. Null if not yet qualified.',
    `rating` STRING COMMENT 'Qualitative rating assigned by prospect research or major gift officer indicating overall prospect quality and likelihood of conversion. A+ (highest priority, strongest capacity and affinity), D (lowest priority).. Valid values are `A+|A|B+|B|C+|C|D`',
    `research_stage` STRING COMMENT 'Current stage of prospect research activities. Not Started (no research conducted), Preliminary (initial screening and public records review), In Depth (comprehensive research including wealth screening and relationship mapping), Completed (research finalized and briefing prepared), Ongoing Monitoring (periodic updates and news monitoring).. Valid values are `not_started|preliminary|in_depth|completed|ongoing_monitoring`',
    `solicitation_amount` DECIMAL(18,2) COMMENT 'Specific dollar amount being requested or proposed in the current solicitation. Null if not yet at solicitation stage.',
    `solicitation_date` DATE COMMENT 'Date when the formal ask or grant proposal was submitted to the prospect. Null if not yet solicited.',
    `source_of_wealth` STRING COMMENT 'Primary source of the prospects wealth or funding capacity (e.g., Technology entrepreneur, Inherited wealth, Real estate, Government appropriation, Endowment income). For institutional donors, describes funding source.',
    `stage` STRING COMMENT 'Current stage in the donor cultivation pipeline lifecycle. Identification (newly identified prospect), Qualification (research and capacity assessment underway), Cultivation (relationship building and engagement), Solicitation (active proposal or ask), Negotiation (terms and agreement discussion), Stewardship (post-gift relationship management).. Valid values are `identification|qualification|cultivation|solicitation|negotiation|stewardship`',
    `wealth_screening_score` DECIMAL(18,2) COMMENT 'Quantitative wealth screening score from third-party wealth screening service (e.g., WealthEngine, iWave). Typically scaled 0-100 indicating relative wealth capacity.',
    CONSTRAINT pk_prospect PRIMARY KEY(`prospect_id`)
) COMMENT 'Prospect research and donor cultivation pipeline record managed in Raisers Edge NXT and Salesforce Nonprofit Cloud. Tracks prospective donors and funders through the cultivation lifecycle from identification through qualification, cultivation, solicitation, and stewardship. Captures prospect rating, estimated giving capacity, wealth screening score, research stage, assigned major gift officer, next action date, cultivation strategy notes, and linkage-ability-interest (LAI) assessment. Supports the Donor Cultivation and Fundraising core business process.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`donor`.`gift` (
    `gift_id` BIGINT COMMENT 'Unique identifier for the gift transaction. Primary key for the gift data product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.agreement. Business justification: Gifts may be restricted, returned, or refused due to safeguarding incidents involving the donor. Tracks financial impact of safeguarding cases, supports gift acceptance policy enforcement, and documen',
    `appeal_id` BIGINT COMMENT 'Reference to the specific appeal or solicitation within a campaign that generated this gift.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Gifts are recorded as grant income against specific awards for grant income reconciliation and financial reporting. NGO finance teams must match gift receipts to award obligations. This is a named pro',
    `campaign_id` BIGINT COMMENT 'Reference to the fundraising campaign that solicited or attributed this gift.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to supply.commodity. Business justification: In-kind gift recording: NGOs receive in-kind donations of specific commodities (food, medicines, NFIs). Linking gift to commodity enables in-kind valuation, inventory entry, and IATI in-kind contribut',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Gifts are allocated to specific country offices for fund disbursement and financial reconciliation. Country office finance teams require gift-to-office traceability for budget management, donor restri',
    `event_registration_id` BIGINT COMMENT 'Foreign key linking to donor.event_registration. Business justification: A gift made at or in response to a fundraising event can be traced to a specific attendee registration record. gift already has fundraising_event_id for event-level attribution, but event_registration',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: Every gift in an NGO fundraising model must be designated to a specific donor fund — this is the core mechanism by which restricted and unrestricted gifts are allocated to programmatic purposes. gift.',
    `funding_source_id` BIGINT COMMENT 'Foreign key linking to grant.funding_source. Business justification: Gifts are deposited into specific finance funds for GL posting, restriction tracking, and fund balance management. Core nonprofit financial operation linking fundraising revenue to accounting records.',
    `fundraising_event_id` BIGINT COMMENT 'Foreign key linking to donor.fundraising_event. Business justification: Gifts can be made at or through fundraising events (ticket purchase, auction bid, event donation). Event attribution enables event ROI calculation, revenue tracking, and event effectiveness analysis. ',
    `original_gift_id` BIGINT COMMENT 'Reference to the original employee gift that this matching gift is matching. Populated only for matching gifts.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Federal grants received as gifts (pass-through awards) are included in single audit federal expenditure calculations. Grants accounting identifies which gifts are federal pass-throughs for audit scope',
    `pledge_id` BIGINT COMMENT 'Foreign key linking to donor.pledge. Business justification: Gifts can be payments against pledges. This FK is CRITICAL for pledge fulfillment tracking, balance calculation, and installment schedule management. Nullable (not all gifts are pledge payments; some ',
    `constituent_id` BIGINT COMMENT 'Reference to the donor who made this gift. Links to the donor master record in the donor domain.',
    `acknowledgement_date` DATE COMMENT 'Date the donor acknowledgement or thank-you letter was sent for this gift.',
    `acknowledgement_type` STRING COMMENT 'Classification of the donor acknowledgement or thank-you communication sent for this gift. [ENUM-REF-CANDIDATE: standard|personalized|major-gift|planned-giving|corporate|foundation|none — 7 candidates stripped; promote to reference product]',
    `amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the gift in the transaction currency before any adjustments or fees.',
    `anonymous_flag` BOOLEAN COMMENT 'Indicates whether the donor requested anonymity for this gift in public recognition and donor lists.',
    `batch_number` STRING COMMENT 'Gift processing batch identifier for grouping gifts deposited or processed together for reconciliation and audit purposes.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the gift amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `fee_amount` DECIMAL(18,2) COMMENT 'Transaction processing fees or costs deducted from the gross gift amount (e.g., credit card fees, wire transfer fees).',
    `gift_date` DATE COMMENT 'The date the gift was received or pledged. This is the principal business event timestamp for revenue recognition per FASB ASC 958.',
    `gift_status` STRING COMMENT 'Current lifecycle status of the gift transaction in the processing workflow.. Valid values are `pending|received|processed|acknowledged|refunded|cancelled`',
    `gift_type` STRING COMMENT 'Discriminator indicating the nature and form of the gift. Determines processing rules, revenue recognition treatment, and IRS substantiation requirements. [ENUM-REF-CANDIDATE: cash|check|wire|in-kind|stock|cryptocurrency|matching|tribute|pledge|recurring|refund|adjustment — 12 candidates stripped; promote to reference product]',
    `gl_account_code` STRING COMMENT 'General ledger account code where this gift revenue is posted in the financial system per the Chart of Accounts (CoA).',
    `gl_posting_date` DATE COMMENT 'Date this gift transaction was posted to the general ledger for financial reporting.',
    `goods_services_value` DECIMAL(18,2) COMMENT 'Fair market value of any goods or services provided to the donor in exchange for the gift, required for IRS substantiation and deductibility calculation.',
    `honoree_name` STRING COMMENT 'Full name of the person being honored or memorialized by this tribute gift. Populated only when tribute_flag is true.',
    `irs_compliant_flag` BOOLEAN COMMENT 'Indicates whether the gift acknowledgement includes IRS-required substantiation language for charitable contribution deductions per IRS Publication 1771.',
    `match_approval_status` STRING COMMENT 'Current status of the matching gift request with the employer. Populated only for matching gifts.. Valid values are `pending|approved|denied|paid`',
    `match_ratio` DECIMAL(18,2) COMMENT 'The employer matching ratio (e.g., 1.00 for 1:1, 2.00 for 2:1, 0.50 for 1:2). Populated only for matching gifts.',
    `match_request_date` DATE COMMENT 'Date the matching gift request was submitted to the employer. Populated only for matching gifts.',
    `matching_gift_flag` BOOLEAN COMMENT 'Indicates whether this gift is a corporate matching gift from an employer matching an employees donation.',
    `net_amount` DECIMAL(18,2) COMMENT 'The net amount received after deducting processing fees, transaction costs, or goods-and-services fair market value per IRS requirements.',
    `notification_recipient_address` STRING COMMENT 'Mailing address for sending tribute gift notification to the honorees family or designated recipient.',
    `notification_recipient_name` STRING COMMENT 'Name of the person who should be notified about this tribute gift (typically a family member of the honoree).',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether the tribute gift notification has been sent to the designated recipient.',
    `number` STRING COMMENT 'Externally-known unique business identifier for this gift transaction, used for donor communication and receipt references.',
    `payment_channel` STRING COMMENT 'The interface or touchpoint through which the donor made the gift, used for campaign attribution and channel effectiveness analysis. [ENUM-REF-CANDIDATE: online|mobile-app|direct-mail|phone|in-person|event|major-gift-officer|peer-to-peer|text-to-give|other — 10 candidates stripped; promote to reference product]',
    `payment_method` STRING COMMENT 'The financial instrument or mechanism used to make the gift payment. [ENUM-REF-CANDIDATE: credit-card|debit-card|ach|wire-transfer|check|cash|paypal|stock-transfer|cryptocurrency|mobile-payment|other — 11 candidates stripped; promote to reference product]',
    `receipt_number` STRING COMMENT 'Unique receipt number issued for this gift for IRS substantiation and donor tax deduction purposes.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this gift record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this gift record was last modified in the system.',
    `refund_flag` BOOLEAN COMMENT 'Indicates whether this record represents a gift refund or reversal transaction.',
    `refund_reason` STRING COMMENT 'Explanation or business reason for refunding or reversing this gift. Populated only when refund_flag is true.',
    `restriction_description` STRING COMMENT 'Detailed narrative of any donor-imposed restrictions, purpose designations, or conditions on the use of the gift funds.',
    `restriction_type` STRING COMMENT 'Classification of donor-imposed restrictions on the use of the gift per FASB ASC 958 net asset classification requirements.. Valid values are `unrestricted|temporarily-restricted|permanently-restricted`',
    `tribute_flag` BOOLEAN COMMENT 'Indicates whether this gift is made in honor or memory of another person (tribute gift).',
    `tribute_type` STRING COMMENT 'Classification of the tribute gift as either in honor of a living person or in memory of a deceased person. Populated only when tribute_flag is true.. Valid values are `in-honor-of|in-memory-of`',
    CONSTRAINT pk_gift PRIMARY KEY(`gift_id`)
) COMMENT 'Authoritative transactional ledger and single source of truth for every financial transaction in the donor domain — gifts, donations, matching gifts, tribute gifts, refunds, adjustments, and acknowledgements — processed through Salesforce Nonprofit Cloud and Raisers Edge NXT. This is the ONE table that answers what is this donors total giving? Captures gift date, amount, currency, gift type discriminator (cash, check, wire, in-kind, stock, crypto, matching, tribute, refund/adjustment, recurring), fund designation, campaign and appeal attribution, gift source (online, direct mail, event, major gift officer), payment method, batch reference, anonymous flag, restricted vs. unrestricted designation, and GL posting reference. For matching gifts: match ratio, matching employer/corporation, match request date, match approval status, match payment received date, maximum match amount. For tribute gifts: tribute type (in-memoriam, in-honor-of), honoree name, honoree relationship, notification recipient, notification sent flag. For refunds/adjustments: original gift reference, refund date, refund amount, refund reason, refund method, GL reversal reference. For acknowledgements: acknowledgement type, acknowledgement date, receipt number, delivery method, acknowledgement status, IRS-compliant language flag, goods-or-services disclosure. Core financial transaction for donor revenue recognition per FASB ASC 958 and IRS 501(c)(3) substantiation requirements.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`donor`.`pledge` (
    `pledge_id` BIGINT COMMENT 'Unique identifier for the pledge commitment record. Primary key.',
    `appeal_id` BIGINT COMMENT 'Reference to the specific appeal or solicitation that generated this pledge.',
    `campaign_id` BIGINT COMMENT 'Reference to the fundraising campaign associated with this pledge.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to supply.commodity. Business justification: In-kind pledge pipeline planning: companies pledge specific commodities (e.g., 5,000 blankets) before delivery. Linking pledge to commodity enables supply pipeline forecasting, procurement gap analysi',
    `constituent_id` BIGINT COMMENT 'Reference to the donor who made this pledge commitment.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Pledges are committed to specific country programs managed by country offices. Country office budget planning and cash flow forecasting depends on knowing which pledges are allocated to their operatio',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: A pledge commitment in NGO fundraising is almost always designated to a specific donor fund — the donor commits to funding a particular program or endowment. Without pledge.donor_fund_id, it is imposs',
    `funding_source_id` BIGINT COMMENT 'Foreign key linking to grant.funding_source. Business justification: Pledges commit future revenue to specific finance funds. Finance uses this for cash flow forecasting, fund balance projections, and accounts receivable management. Essential for nonprofit liquidity pl',
    `fundraising_event_id` BIGINT COMMENT 'Foreign key linking to donor.fundraising_event. Business justification: Pledges are frequently made at fundraising events — gala pledge cards, benefit dinner commitments, and capital campaign kickoff events are common NGO scenarios where a pledge originates from a specifi',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: NGO pledge pipeline management tracks which intervention each pledge supports for intervention-level fundraising forecasts and restricted fund allocation. Pledges are solicited for specific interventi',
    `acknowledgment_date` DATE COMMENT 'The date on which the pledge acknowledgment was sent to the donor.',
    `acknowledgment_sent` BOOLEAN COMMENT 'Indicates whether a pledge acknowledgment letter or receipt has been sent to the donor.',
    `amount_paid` DECIMAL(18,2) COMMENT 'The cumulative amount paid to date across all installments. Updated as installment payments are received.',
    `balance_outstanding` DECIMAL(18,2) COMMENT 'The remaining unpaid balance on the pledge. Calculated as total_pledge_amount minus amount_paid.',
    `cancellation_date` DATE COMMENT 'The date on which the donor or organization cancelled the pledge commitment. Populated only when pledge_status is cancelled.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the pledge was cancelled (e.g., donor request, duplicate entry, data entry error).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this pledge record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the pledge amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `first_installment_date` DATE COMMENT 'The scheduled due date for the first installment payment.',
    `fulfillment_date` DATE COMMENT 'The date on which the pledge was fully paid and marked as fulfilled. Populated only when pledge_status is fulfilled.',
    `installment_frequency` STRING COMMENT 'The recurring schedule for installment payments. One-time for single-payment pledges; monthly, quarterly, semi-annual, annual for standard recurring schedules; custom for irregular or donor-specified schedules.. Valid values are `one_time|monthly|quarterly|semi_annual|annual|custom`',
    `installments_paid` STRING COMMENT 'The count of installments that have been fully paid to date. Updated as installment payments are received.',
    `installments_remaining` STRING COMMENT 'The count of installments that are still unpaid. Calculated as number_of_installments minus installments_paid.',
    `is_anonymous` BOOLEAN COMMENT 'Indicates whether the donor has requested that this pledge be kept anonymous in public recognition and reporting.',
    `is_matching_gift_eligible` BOOLEAN COMMENT 'Indicates whether this pledge is eligible for corporate matching gift programs.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this pledge is a recurring sustainer commitment with ongoing installments beyond the initial schedule.',
    `last_installment_date` DATE COMMENT 'The scheduled due date for the final installment payment.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'The amount of the most recent installment payment received.',
    `last_payment_date` DATE COMMENT 'The date on which the most recent installment payment was received.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this pledge record was last modified in the system.',
    `next_installment_amount` DECIMAL(18,2) COMMENT 'The scheduled amount for the next unpaid installment.',
    `next_installment_due_date` DATE COMMENT 'The due date for the next unpaid installment. Used for reminder generation and overdue tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments about the pledge, including special donor instructions, stewardship considerations, or internal processing notes.',
    `number` STRING COMMENT 'Human-readable business identifier for the pledge commitment, often displayed on donor communications and receipts.',
    `number_of_installments` STRING COMMENT 'The total number of scheduled installment payments for this pledge. For one-time pledges, this is 1.',
    `payment_method` STRING COMMENT 'The primary payment instrument or method the donor intends to use for installment payments.. Valid values are `credit_card|bank_transfer|check|cash|stock|wire_transfer`',
    `pledge_date` DATE COMMENT 'The date on which the donor made the pledge commitment. This is the principal business event timestamp for the pledge.',
    `pledge_status` STRING COMMENT 'Current lifecycle status of the pledge commitment. Active indicates ongoing installment schedule; fulfilled indicates all installments paid; lapsed indicates overdue with no recent payment; written-off indicates uncollectible; cancelled indicates donor withdrew commitment; pending indicates awaiting approval or activation.. Valid values are `active|fulfilled|lapsed|written_off|cancelled|pending`',
    `pledge_type` STRING COMMENT 'Classification of the pledge based on its purpose and structure. Standard for general multi-installment pledges; sustainer for recurring monthly giving; major gift for high-value commitments; planned giving for estate or deferred gifts; capital campaign for infrastructure projects; endowment for permanent fund contributions.. Valid values are `standard|sustainer|major_gift|planned_giving|capital_campaign|endowment`',
    `reminder_schedule` STRING COMMENT 'The timing for automated payment reminders sent to the donor before each installment due date.. Valid values are `none|7_days_before|14_days_before|30_days_before|custom`',
    `total_pledge_amount` DECIMAL(18,2) COMMENT 'The total monetary value committed by the donor across all installments. This is the gross pledge amount before any payments.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'The outstanding balance amount that was written off. Populated only when pledge_status is written_off.',
    `write_off_date` DATE COMMENT 'The date on which the pledge was written off as uncollectible. Populated only when pledge_status is written_off.',
    `write_off_reason` STRING COMMENT 'Free-text explanation for why the pledge was written off (e.g., donor deceased, donor financial hardship, unable to contact, donor dispute).',
    CONSTRAINT pk_pledge PRIMARY KEY(`pledge_id`)
) COMMENT 'Tracks multi-installment giving commitments, pledge agreements, and their individual installment schedules from donors, managed in Raisers Edge NXT and Salesforce Nonprofit Cloud. Captures pledge date, total pledge amount, installment schedule (monthly, quarterly, annual), number of installments, pledge balance outstanding, pledge status (active, fulfilled, lapsed, written-off), fund designation, campaign, appeal, reminder schedule, and write-off reason. Includes installment-level detail: individual due dates, scheduled amounts, actual payment dates, amounts paid, installment status (scheduled, paid, overdue, skipped, waived), payment method, and linked gift reference upon payment. Enables granular pledge fulfillment tracking, overdue installment identification, automated reminder generation, and BvA (Budget vs. Actual) reconciliation for pledged revenue. Distinct from gift — a pledge is a commitment to give, not a completed transaction.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`donor`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Unique identifier for the fundraising campaign. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Joint campaign management: NGOs run co-funded campaigns governed by specific partnership agreements. Linking campaign to partnership_agreement enables compliance reporting on which formal agreement go',
    `award_id` BIGINT COMMENT 'Reference to an institutional grant or award if this campaign is tied to a specific funders matching or challenge grant.',
    `constituent_id` BIGINT COMMENT 'Foreign key linking to donor.constituent. Business justification: Donor-funded campaigns have specific compliance requirements from funding sources (reporting schedules, branding guidelines, impact metrics). Campaign managers track donor-imposed requirements to ensu',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Campaigns are often country-specific (e.g., Yemen Crisis Appeal, Bangladesh Rohingya Response) for donor targeting, regulatory compliance, and financial reporting. Links campaign fundraising to operat',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Emergency fundraising campaigns are directly tied to declared emergencies (e.g., Haiti Earthquake Appeal 2024). Campaign performance reporting against emergency funding requirements and flash appeal',
    `funding_source_id` BIGINT COMMENT 'Foreign key linking to grant.funding_source. Business justification: Campaigns often have dedicated finance funds for revenue tracking, expense allocation, and donor reporting. Standard nonprofit practice for capital campaigns, annual funds, and restricted initiatives.',
    `indicator_id` BIGINT COMMENT 'Foreign key linking to mel.indicator. Business justification: NGO fundraising campaigns are designed around specific impact indicators (e.g., # children vaccinated). Campaign goal-setting, impact messaging, and post-campaign reporting all reference the primary',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project that this campaign is raising funds for, enabling fund accounting and impact tracking.',
    `mel_logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: NGO fundraising campaigns are structured around a program logframe to align donor messaging with the results chain. Campaign managers reference the logframe when crafting impact narratives and setting',
    `parent_campaign_id` BIGINT COMMENT 'Reference to a parent campaign if this campaign is part of a larger multi-phase or hierarchical campaign structure.',
    `acknowledgment_template` STRING COMMENT 'Name or identifier of the donor acknowledgment letter or email template used for gifts to this campaign.',
    `appeal_channel` STRING COMMENT 'Primary communication channel used to solicit donations for this campaign. [ENUM-REF-CANDIDATE: direct_mail|email|social_media|website|event|phone|peer_to_peer — 7 candidates stripped; promote to reference product]',
    `appeal_description` STRING COMMENT 'Detailed narrative describing the campaigns mission, beneficiaries, and impact story used in donor communications.',
    `campaign_status` STRING COMMENT 'Current lifecycle status of the campaign indicating its operational state.. Valid values are `planned|active|completed|cancelled|on_hold`',
    `campaign_type` STRING COMMENT 'Classification of the fundraising campaign by its strategic purpose and donor engagement model.. Valid values are `annual_fund|capital_campaign|emergency_appeal|planned_giving|corporate_partnership|digital_online`',
    `campaign_code` STRING COMMENT 'Short alphanumeric code used for internal tracking and gift attribution. Often used in appeal codes and donation forms.',
    `cost_of_fundraising` DECIMAL(18,2) COMMENT 'Total expenses incurred to execute the campaign, including marketing, events, staff time, and materials.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the campaign goal and raised amounts.. Valid values are `^[A-Z]{3}$`',
    `donor_count` STRING COMMENT 'Total number of unique donors who have contributed to this campaign.',
    `end_date` DATE COMMENT 'The date when the campaign officially closes. Null for ongoing campaigns without a defined end.',
    `gift_count` STRING COMMENT 'Total number of individual gift transactions attributed to this campaign.',
    `goal_amount` DECIMAL(18,2) COMMENT 'The target fundraising amount the campaign aims to raise, expressed in the organizations base currency.',
    `impact_report_url` STRING COMMENT 'Web address of the campaign impact report or results summary shared with donors.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the campaign is currently active and accepting donations.',
    `is_public` BOOLEAN COMMENT 'Boolean flag indicating whether the campaign is publicly visible on the organizations website and donation pages.',
    `matching_gift_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether donations to this campaign are eligible for corporate matching gift programs.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign record was last updated.',
    `campaign_name` STRING COMMENT 'The full name of the fundraising campaign as displayed to donors and staff.',
    `roi_percentage` DECIMAL(18,2) COMMENT 'Calculated return on investment for the campaign, expressed as a percentage of net revenue over cost.',
    `sdg_alignment` STRING COMMENT 'Comma-separated list of UN Sustainable Development Goal numbers (1-17) that this campaign contributes to, supporting impact reporting.',
    `start_date` DATE COMMENT 'The date when the campaign officially begins accepting donations and engaging donors.',
    `stewardship_plan` STRING COMMENT 'Description of the donor stewardship and engagement activities planned for campaign contributors.',
    `target_audience_segment` STRING COMMENT 'Description of the donor segment or constituency this campaign is designed to engage (e.g., major donors, monthly sustainers, corporate partners, lapsed donors).',
    `tax_deductible` BOOLEAN COMMENT 'Boolean flag indicating whether donations to this campaign are tax-deductible under IRS 501(c)(3) regulations or equivalent.',
    `total_raised_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of gifts and pledges received to date for this campaign.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Fundraising campaign master record managing all donor-facing fundraising initiatives in Salesforce Nonprofit Cloud. Captures campaign name, campaign type (annual fund, capital campaign, emergency appeal, planned giving, corporate partnership, digital/online), campaign goal amount, start and end dates, campaign status, target audience segment, appeal codes associated, total gifts raised to date, number of donors, cost of fundraising, and ROI. Supports campaign performance tracking and donor attribution across all gift transactions.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`donor`.`appeal` (
    `appeal_id` BIGINT COMMENT 'Unique identifier for the fundraising appeal. Primary key.',
    `campaign_id` BIGINT COMMENT 'Reference to the parent fundraising campaign under which this appeal is organized.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.fund. Business justification: Appeals direct donors to specific funds. Currently fund_designation is a STRING (likely fund name/code); replacing with FK to fund.fund_id provides referential integrity and enables JOIN to retrieve f',
    `acknowledgment_template` STRING COMMENT 'Name or identifier of the gift acknowledgment letter template used for donors responding to this appeal.',
    `appeal_status` STRING COMMENT 'Current lifecycle status of the appeal.. Valid values are `draft|scheduled|active|completed|cancelled|on_hold`',
    `appeal_type` STRING COMMENT 'Classification of the appeal based on donor lifecycle stage and solicitation strategy.. Valid values are `acquisition|renewal|upgrade|lapsed_reactivation|major_gift|planned_giving`',
    `ask_amount` DECIMAL(18,2) COMMENT 'Suggested or recommended gift amount presented to constituents in the appeal solicitation.',
    `ask_string` STRING COMMENT 'Formatted ask string presented to constituents showing multiple giving levels (e.g., $50, $100, $250, $500, Other).',
    `average_gift_amount` DECIMAL(18,2) COMMENT 'Average gift size for responses to this appeal calculated as total_revenue_amount / response_count.',
    `channel` STRING COMMENT 'Primary communication channel through which the appeal is delivered to constituents. [ENUM-REF-CANDIDATE: direct_mail|email|phone|digital|event|face_to_face|social_media — 7 candidates stripped; promote to reference product]',
    `appeal_code` STRING COMMENT 'Externally-known unique code for the appeal used in gift attribution and tracking (e.g., DM2024Q1, EMAIL-SPRING, PHONE-EOY).. Valid values are `^[A-Z0-9]{3,20}$`',
    `control_group_flag` BOOLEAN COMMENT 'Indicates whether this appeal represents the control group in an A/B test (true) or a test variant (false).',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred to execute the appeal including production, postage, vendor fees, and staff time.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the appeal cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the appeal record was first created in the system.',
    `end_date` DATE COMMENT 'Date the appeal closes and stops accepting new responses. Nullable for ongoing appeals.',
    `mailing_date` DATE COMMENT 'Date the appeal solicitation was sent or deployed to the target segment.',
    `manager_name` STRING COMMENT 'Name of the staff member responsible for managing and executing this appeal.',
    `modified_by` STRING COMMENT 'Username or identifier of the system user who last modified the appeal record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the appeal record was last modified in the system.',
    `appeal_name` STRING COMMENT 'Human-readable name of the appeal (e.g., Spring Direct Mail Appeal, Year-End Email Solicitation).',
    `notes` STRING COMMENT 'Free-text notes and comments about the appeal including lessons learned, special circumstances, and post-campaign observations.',
    `package_description` STRING COMMENT 'Detailed description of the solicitation package contents including letter, brochure, reply device, premium, and other components.',
    `pieces_sent` STRING COMMENT 'Total count of solicitation pieces (letters, emails, calls) sent to constituents for this appeal.',
    `premium_offered` STRING COMMENT 'Description of any premium or thank-you gift offered to donors responding to this appeal (e.g., tote bag, calendar, recognition pin).',
    `response_count` STRING COMMENT 'Total number of constituents who responded to the appeal with a gift or pledge.',
    `response_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of constituents who responded to the appeal calculated as (response_count / pieces_sent) * 100.',
    `revenue_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the total revenue amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `roi_ratio` DECIMAL(18,2) COMMENT 'Return on investment ratio for the appeal calculated as total_revenue_amount / cost_amount. Values greater than 1.0 indicate positive ROI.',
    `solicitor_name` STRING COMMENT 'Name of the primary solicitor or fundraiser credited with this appeal (may be staff, volunteer, or board member).',
    `start_date` DATE COMMENT 'Date the appeal becomes active and begins accepting responses.',
    `test_segment_flag` BOOLEAN COMMENT 'Indicates whether this appeal is part of an A/B test or experimental segment for testing messaging, package, or channel effectiveness.',
    `total_revenue_amount` DECIMAL(18,2) COMMENT 'Total gross revenue generated by gifts and pledges attributed to this appeal.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created the appeal record.',
    CONSTRAINT pk_appeal PRIMARY KEY(`appeal_id`)
) COMMENT 'Specific fundraising appeal or solicitation package within a campaign, managed in Raisers Edge NXT. An appeal is a targeted ask sent to a defined segment of constituents via a specific channel (direct mail, email, phone, event). Captures appeal code, appeal name, parent campaign, appeal type (acquisition, renewal, upgrade, lapsed reactivation), mailing date, channel (mail, email, phone, digital), cost, number of pieces sent, response rate, and total revenue generated. Enables granular attribution of gifts to specific solicitation efforts.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`donor`.`fund` (
    `fund_id` BIGINT COMMENT 'Unique identifier for the donor-designated fund record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Restricted fund compliance reporting: Donor funds are often governed by specific partnership agreements defining restrictions, reporting obligations, and co-financing terms. This link is required for ',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.donor_requirement. Business justification: Restricted funds have donor-imposed compliance requirements (spending timelines, allowable expenses, reporting schedules). Fund managers track requirements for each restricted fund to ensure donor res',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to donor.campaign. Business justification: A donor-designated fund is often established or activated through a specific fundraising campaign — for example, a capital campaign creates a building fund, or an annual campaign drives contributions ',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Restricted funds often have country-specific designations per donor agreements. Essential for compliance with donor restrictions, country-level financial reporting, registration requirements, and ensu',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Emergency response funds are directly tied to declared emergencies (e.g., Ukraine Emergency Fund 2022). Linking donor_fund to emergency enables emergency-specific financial tracking, OCHA financial ',
    `funding_source_id` BIGINT COMMENT 'Foreign key linking to grant.funding_source. Business justification: Donor.fund (fundraising view) and finance.finance_fund (accounting view) represent the same entity from different departmental perspectives. This link enables reconciliation between development and fi',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project to which this fund is designated. Links donor intent to operational program delivery.',
    `mel_logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: Restricted donor funds are governed by a specific logframe — the funds restriction terms map to a results chain level. Grants compliance and donor reporting require knowing which logframe governs a f',
    `constituent_id` BIGINT COMMENT 'Reference to the primary donor or institutional funder who established or designated this fund. Links fund to donor cultivation and stewardship records in Salesforce Nonprofit Cloud or Raisers Edge NXT.',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Donor funds have specific reporting cycles that must align with MEL reporting periods for donor compliance. Linking donor_fund to reporting_period enables automated reporting calendar management and e',
    `audit_required` BOOLEAN COMMENT 'Indicates whether the fund is subject to separate audit requirements beyond organizational annual audit, such as single audit or donor-specific financial audit per OMB Uniform Guidance or grant terms.',
    `balance` DECIMAL(18,2) COMMENT 'Current available balance in the fund representing cumulative gifts received minus disbursements and allocations. Updated through integration with SAP S/4HANA or Unit4 ERP fund accounting modules.',
    `beneficiary_population` STRING COMMENT 'Description of the target beneficiary population or vulnerable group that this fund is designated to serve (e.g., IDPs, refugees, children under 5, women survivors of GBV).',
    `closure_date` DATE COMMENT 'Date when the fund was formally closed and ceased accepting new gifts. Nullable for active funds. Used for endowment spend-down tracking and restricted fund completion.',
    `compliance_notes` STRING COMMENT 'Free-text field capturing special compliance requirements, donor-specific terms and conditions, procurement restrictions, or regulatory obligations unique to this fund.',
    `cost_share_percentage` DECIMAL(18,2) COMMENT 'Required percentage of organizational cost-sharing or matching funds relative to total project budget. Nullable if cost share is not required.',
    `cost_share_required` BOOLEAN COMMENT 'Indicates whether the fund requires organizational cost-sharing or matching contributions per donor agreement terms. True if cost share is mandatory.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fund record was first created in the system. Audit trail for data lineage and record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the funds financial transactions and reporting. Supports multi-currency fund accounting for international NGO operations.. Valid values are `^[A-Z]{3}$`',
    `dac_sector_code` STRING COMMENT 'Five-digit OECD DAC sector classification code indicating the primary sector focus of the fund (e.g., health, education, WASH, humanitarian aid). Required for DAC reporting by institutional donors.. Valid values are `^[0-9]{5}$`',
    `donor_fund_category` STRING COMMENT 'High-level classification of the funds purpose for portfolio management and strategic planning. Distinguishes operating funds from capital campaigns, emergency response funds, and endowments. [ENUM-REF-CANDIDATE: operating|capital|program|emergency_response|endowment|scholarship|research — 7 candidates stripped; promote to reference product]',
    `donor_fund_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the fund in donor communications, grant agreements, and financial reports. Used as the business identifier for fund accounting and stewardship.. Valid values are `^[A-Z0-9]{3,15}$`',
    `donor_fund_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and intended use of the fund. Captures donor intent and programmatic objectives for stewardship and compliance reporting.',
    `donor_fund_name` STRING COMMENT 'Full descriptive name of the fund as presented to donors and in financial statements. Human-readable identity label for the fund.',
    `donor_fund_status` STRING COMMENT 'Current lifecycle state of the fund indicating whether it is actively accepting gifts and disbursing funds, or has been closed or temporarily suspended.. Valid values are `open|closed|suspended|pending_approval`',
    `donor_fund_type` STRING COMMENT 'Classification of the fund based on donor restrictions and organizational policy. Determines accounting treatment per ASC 958 net asset classification requirements.. Valid values are `restricted|temporarily_restricted|unrestricted|endowment|quasi_endowment|board_designated`',
    `endowment_spending_policy` STRING COMMENT 'Description of the board-approved spending policy for endowment funds, including annual distribution rate, calculation methodology, and underwater endowment provisions per ASC 958.',
    `geographic_scope` STRING COMMENT 'Geographic reach of the funds programmatic activities. Indicates whether the fund supports global operations, regional initiatives, or country-specific programs.. Valid values are `global|regional|country_specific|multi_country`',
    `gl_account_code` STRING COMMENT 'Chart of Accounts (CoA) code in SAP S/4HANA or Unit4 ERP to which this fund maps for financial accounting and fund accounting purposes. Enables reconciliation between donor-facing fund designations and GL postings.. Valid values are `^[0-9]{4,10}$`',
    `iati_identifier` STRING COMMENT 'Unique IATI activity identifier for this fund if reported under IATI transparency standards. Enables public disclosure and donor coordination.',
    `inception_date` DATE COMMENT 'Date when the fund was established and opened for gift acceptance. Marks the beginning of the funds lifecycle.',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'Percentage rate for Facilities and Administration (F&A) indirect costs allowed under this fund per donor agreement or NICRA. Expressed as a percentage (e.g., 15.00 for 15%).',
    `investment_policy` STRING COMMENT 'Summary of investment strategy and asset allocation policy for endowment or quasi-endowment funds. References board-approved investment policy statement.',
    `minimum_gift_amount` DECIMAL(18,2) COMMENT 'Minimum contribution threshold required to designate a gift to this fund. Used for major gift funds, endowments, and named funds with donor-established minimums.',
    `modified_by` STRING COMMENT 'Username or identifier of the system user who last modified this fund record. Supports change management and audit compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fund record was last updated. Supports change tracking and audit compliance.',
    `reporting_frequency` STRING COMMENT 'Required frequency of stewardship and financial reporting to the donor or funding agency for this fund per grant agreement or donor stewardship plan.. Valid values are `monthly|quarterly|semi_annual|annual|upon_request`',
    `restriction_description` STRING COMMENT 'Detailed explanation of donor-imposed restrictions, including specific programmatic purposes, geographic limitations, beneficiary populations, or time-bound conditions that govern fund usage.',
    `restriction_expiration_date` DATE COMMENT 'Date when time-based donor restrictions expire and temporarily restricted funds are released to unrestricted net assets. Nullable for perpetual or purpose-only restrictions.',
    `restriction_type` STRING COMMENT 'Nature of donor-imposed restrictions on the fund. Purpose-restricted funds must be used for specific programs or activities; time-restricted funds have temporal constraints; perpetual restrictions apply to endowments.. Valid values are `purpose_restricted|time_restricted|perpetual|unrestricted`',
    `sdg_alignment` STRING COMMENT 'Comma-separated list of United Nations Sustainable Development Goal (SDG) numbers (1-17) to which this funds programmatic purpose aligns. Used for impact reporting and IATI transparency.',
    `target_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where the funds resources are designated to be used. Supports geographic restriction tracking and field operations planning.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this fund record. Audit trail for accountability and data stewardship.',
    CONSTRAINT pk_fund PRIMARY KEY(`fund_id`)
) COMMENT 'Donor-designated fund master record representing the specific programmatic or operational purpose to which a gift is directed. Captures fund code, fund name, fund type (restricted, temporarily restricted, unrestricted, endowment, quasi-endowment), fund description, associated program or project, GL account mapping, fund status (open, closed, suspended), minimum gift threshold, and fund stewardship contact. Serves as the bridge between donor intent (gift designation) and financial stewardship (fund accounting in SAP/Unit4). Distinct from GL account — fund is the donor-facing designation.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` (
    `stewardship_activity_id` BIGINT COMMENT 'Unique identifier for the stewardship activity record. Primary key.',
    `appeal_id` BIGINT COMMENT 'Foreign key linking to donor.appeal. Business justification: Stewardship activities can be triggered by specific appeals (e.g., thank-you call after appeal response, acknowledgment letter for appeal gift). Appeal attribution enables integrated donor journey tra',
    `award_id` BIGINT COMMENT 'Foreign key linking to the safeguarding incident record associated with this stewardship activity',
    `campaign_id` BIGINT COMMENT 'Reference to the fundraising campaign context for this stewardship activity. Nullable if not campaign-specific.',
    `constituent_id` BIGINT COMMENT 'Reference to the donor or constituent involved in this stewardship activity. Links to the constituent master record in Salesforce Nonprofit Cloud or Raisers Edge NXT.',
    `evaluation_finding_id` BIGINT COMMENT 'Foreign key linking to mel.evaluation_finding. Business justification: Stewardship activities frequently share specific evaluation findings with donors (key lessons, recommendations, impact ratings). stewardship_activity has evaluation_id but not the specific finding. Sh',
    `evaluation_id` BIGINT COMMENT 'Foreign key linking to mel.evaluation. Business justification: Stewardship meetings often discuss evaluation findings with donors to demonstrate accountability and learning. Linking stewardship activity to evaluation enables tracking which evaluations were shared',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.fund. Business justification: Stewardship activities can be fund-specific (e.g., endowment impact report, scholarship recipient introduction, program site visit). Fund attribution enables fund-specific stewardship planning and imp',
    `fundraising_event_id` BIGINT COMMENT 'Foreign key linking to donor.fundraising_event. Business justification: Stewardship activities are frequently conducted in the context of fundraising events — post-event follow-up calls, thank-you notes after galas, impact briefings at donor receptions. Linking stewardshi',
    `gift_id` BIGINT COMMENT 'Reference to the specific gift or donation that triggered or is associated with this stewardship activity. Nullable for activities not tied to a specific gift.',
    `indicator_id` BIGINT COMMENT 'Foreign key linking to mel.indicator. Business justification: Stewardship communications share impact stories tied to specific indicators the donor funded. This link enables personalized donor reporting, tracking which indicators were discussed in stewardship me',
    `indicator_result_id` BIGINT COMMENT 'Foreign key linking to mel.indicator_result. Business justification: Stewardship activities share specific indicator results with donors (e.g., Q3 results: 5,000 beneficiaries reached). This is a core donor stewardship process — linking a specific verified result to ',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: NGO donor stewardship activities (site visits, impact reports, field trips) are directly tied to specific interventions to demonstrate results. The Donor Stewardship Reporting process requires linki',
    `mel_logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: Stewardship activities share the full results chain context with donors, not just individual indicators. Linking to the logframe enables relationship managers to present the complete theory of change ',
    `partner_contact_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_contact. Business justification: Partner relationship management: Stewardship activities (meetings, calls, site visits) are conducted with specific named partner contacts. Tracking which contact was engaged is required for relationsh',
    `pledge_id` BIGINT COMMENT 'Reference to the pledge commitment associated with this stewardship activity. Nullable for activities not related to a pledge.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Stewardship activities include donor field visits to project sites for relationship cultivation and impact demonstration. Critical for visit logistics, security coordination, beneficiary consent manag',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to donor.prospect. Business justification: Stewardship activities are conducted as part of donor cultivation and prospect management. Linking stewardship_activity.prospect_id → prospect.prospect_id enables tracking of which cultivation pipelin',
    `volunteer_deployment_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer_deployment. Business justification: NGO stewardship activities conducted during field deployments (e.g., deployed volunteer hosts donor site visit) must be traceable to the specific deployment for grant reporting and donor impact docume',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Stewardship activities in NGOs are frequently executed by volunteers (donor calls, impact report delivery, cultivation events). Stewardship managers need to report which volunteer conducted each donor',
    `acknowledgement_sent_date` DATE COMMENT 'The date on which the acknowledgement communication was sent to the donor. Nullable if no acknowledgement was sent.',
    `acknowledgement_sent_flag` BOOLEAN COMMENT 'Boolean indicator of whether a formal acknowledgement or thank-you communication was sent following this stewardship activity.',
    `attendee_count` STRING COMMENT 'Number of individuals who participated in the stewardship activity, including staff and constituents. Applicable for meetings, site visits, and events.',
    `communication_channel` STRING COMMENT 'The medium or channel through which the stewardship activity was conducted (in-person meeting, phone call, email, video conference, postal mail, or event).. Valid values are `in_person|phone|email|video_call|mail|event`',
    `completed_date` DATE COMMENT 'The actual date on which the stewardship activity was marked as completed. Nullable for activities that are planned or cancelled.',
    `cost_amount` DECIMAL(18,2) COMMENT 'The direct cost incurred for conducting this stewardship activity, including event costs, travel expenses, materials, or gifts. Nullable if no cost was tracked.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this stewardship activity record was first created in the system. Record audit trail.',
    `stewardship_activity_description` STRING COMMENT 'Detailed narrative description of the stewardship activity, including context, discussion points, and any relevant details captured by the staff member.',
    `donor_response` STRING COMMENT 'The donors response to any solicitation or engagement request made during the stewardship activity.. Valid values are `committed|interested|considering|declined|no_response`',
    `donor_sentiment` STRING COMMENT 'Qualitative assessment of the donors sentiment or engagement level observed during the stewardship activity, used for relationship health tracking.. Valid values are `very_positive|positive|neutral|negative|very_negative`',
    `duration_minutes` STRING COMMENT 'The length of the stewardship activity in minutes, applicable for meetings, calls, and site visits. Nullable for activities without a defined duration.',
    `engagement_score` STRING COMMENT 'Quantitative engagement score assigned to the activity based on donor responsiveness, interest level, and interaction quality. Scale typically 1-10.',
    `follow_up_due_date` DATE COMMENT 'The target date by which follow-up action should be completed. Nullable if no follow-up is required.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether follow-up action is required based on the outcome of this stewardship activity.',
    `impact_story_shared_flag` BOOLEAN COMMENT 'Boolean indicator of whether a beneficiary impact story or program outcome was shared with the donor during this activity.',
    `location` STRING COMMENT 'Physical or virtual location where the stewardship activity took place (office address, donor site, event venue, or virtual meeting platform).',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this stewardship activity record was last modified. Record audit trail.',
    `next_steps` STRING COMMENT 'Documented follow-up actions or next steps identified during or after the stewardship activity to continue donor cultivation.',
    `notes` STRING COMMENT 'Internal staff notes and observations about the stewardship activity, donor preferences, or relationship insights. Confidential business information.',
    `outcome` STRING COMMENT 'Summary of the outcome or result of the stewardship activity, including donor response, feedback received, and any commitments made.',
    `priority_level` STRING COMMENT 'Priority classification of the stewardship activity indicating its importance in the overall donor cultivation strategy.. Valid values are `high|medium|low`',
    `scheduled_date` DATE COMMENT 'The originally scheduled date for the stewardship activity. May differ from activity_date if the activity was rescheduled or completed on a different date.',
    `solicitation_amount` DECIMAL(18,2) COMMENT 'The specific funding amount requested from the donor during the solicitation. Nullable if no solicitation was made.',
    `solicitation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the solicitation amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `solicitation_made_flag` BOOLEAN COMMENT 'Boolean indicator of whether a funding solicitation or ask was made to the donor during this stewardship activity.',
    `stewardship_activity_date` DATE COMMENT 'The date on which the stewardship activity was conducted or scheduled. Principal business event timestamp for this transaction.',
    `stewardship_activity_status` STRING COMMENT 'Current lifecycle status of the stewardship activity indicating whether it is planned, completed, cancelled, rescheduled, or pending.. Valid values are `planned|completed|cancelled|rescheduled|pending`',
    `stewardship_activity_type` STRING COMMENT 'Classification of the stewardship activity. [ENUM-REF-CANDIDATE: acknowledgement_letter|impact_report|site_visit|phone_call|event_invitation|personal_meeting|grant_report_delivery|thank_you_call|donor_briefing|recognition_event — promote to reference product]. Valid values are `acknowledgement_letter|impact_report|site_visit|phone_call|event_invitation|personal_meeting`',
    `stewardship_plan_stage` STRING COMMENT 'The stage in the donor cultivation and stewardship lifecycle that this activity supports, aligned with the organizations donor relationship management framework.. Valid values are `identification|cultivation|solicitation|stewardship|renewal`',
    `subject` STRING COMMENT 'Brief subject line or title summarizing the purpose of the stewardship activity.',
    CONSTRAINT pk_stewardship_activity PRIMARY KEY(`stewardship_activity_id`)
) COMMENT 'Records all donor stewardship touchpoints and relationship management activities conducted by major gift officers and stewardship staff. Captures activity type (acknowledgement letter, impact report, site visit, phone call, event invitation, personal meeting, grant report delivery), activity date, staff member responsible, constituent involved, related gift or pledge, activity outcome, next steps, and stewardship plan stage. Supports the donor cultivation and stewardship lifecycle and enables relationship health tracking in Salesforce Nonprofit Cloud.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` (
    `fundraising_event_id` BIGINT COMMENT 'Unique identifier for the fundraising event record. Primary key.',
    `appeal_id` BIGINT COMMENT 'Foreign key linking to donor.appeal. Business justification: Fundraising events are often promoted through specific appeals (direct mail invitation, email invitation). Linking event to appeal enables integrated campaign tracking and multi-channel attribution an',
    `campaign_id` BIGINT COMMENT 'Identifier linking this fundraising event to a broader fundraising campaign or appeal in the donor management system.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.fund. Business justification: Event proceeds typically go to ONE designated fund (e.g., gala for scholarship fund, benefit for disaster relief fund). This FK is essential for accounting, fund balance tracking, and donor stewardshi',
    `intervention_id` BIGINT COMMENT 'Identifier linking this fundraising event to a specific program or initiative that will benefit from the funds raised.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Fundraising events (donor site visits, impact tours) are frequently held at project sites to demonstrate impact and cultivate major donors. Essential for event logistics planning, security clearance, ',
    `acknowledgment_sent_date` DATE COMMENT 'The date when thank-you acknowledgments or tax receipts were sent to event participants and donors.',
    `capacity_total` STRING COMMENT 'The maximum number of attendees the event can accommodate based on venue or platform constraints.',
    `fundraising_event_code` STRING COMMENT 'Short alphanumeric code or identifier used for internal tracking and reporting of the event.',
    `created_by_user` STRING COMMENT 'The username or identifier of the system user who created this fundraising event record.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this fundraising event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts associated with this event.. Valid values are `^[A-Z]{3}$`',
    `fundraising_event_description` STRING COMMENT 'Detailed narrative description of the fundraising event, including purpose, activities, and beneficiary impact.',
    `end_time` TIMESTAMP COMMENT 'The precise date and time when the fundraising event is scheduled to conclude.',
    `fundraising_event_date` DATE COMMENT 'The scheduled date on which the fundraising event takes place.',
    `fundraising_event_status` STRING COMMENT 'Current lifecycle status of the fundraising event (planned, active, completed, cancelled, postponed).. Valid values are `planned|active|completed|cancelled|postponed`',
    `fundraising_event_type` STRING COMMENT 'Classification of the fundraising event by format and purpose (e.g., gala, benefit dinner, golf tournament, auction, virtual fundraiser, cultivation event).. Valid values are `gala|benefit_dinner|golf_tournament|auction|virtual_fundraiser|cultivation_event`',
    `fundraising_goal_amount` DECIMAL(18,2) COMMENT 'The target revenue amount the organization aims to raise from this event.',
    `is_tax_deductible` BOOLEAN COMMENT 'Indicates whether contributions made to this event qualify for tax deduction under IRS 501(c)(3) regulations or equivalent.',
    `is_virtual_event` BOOLEAN COMMENT 'Indicates whether the fundraising event is conducted virtually (online) rather than at a physical venue.',
    `last_modified_by_user` STRING COMMENT 'The username or identifier of the system user who last modified this fundraising event record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this fundraising event record was last updated or modified.',
    `manager_email` STRING COMMENT 'The email address of the event manager for coordination and communication purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `manager_name` STRING COMMENT 'The name of the staff member or volunteer responsible for managing and coordinating the fundraising event.',
    `manager_phone` STRING COMMENT 'The phone number of the event manager for coordination and communication purposes.',
    `fundraising_event_name` STRING COMMENT 'The official name or title of the fundraising event (e.g., Annual Gala, Spring Golf Tournament, Virtual Benefit Concert).',
    `net_revenue` DECIMAL(18,2) COMMENT 'The net proceeds from the event, calculated as total revenue raised minus total event cost.',
    `registration_close_date` DATE COMMENT 'The date when registration for the event closes and no further registrations are accepted.',
    `registration_open_date` DATE COMMENT 'The date when registration for the event opens to constituents.',
    `sponsorship_levels_available` STRING COMMENT 'Comma-separated list or description of sponsorship tiers offered for the event (e.g., Platinum, Gold, Silver, Bronze).',
    `start_time` TIMESTAMP COMMENT 'The precise date and time when the fundraising event is scheduled to begin.',
    `tax_deductible_percentage` DECIMAL(18,2) COMMENT 'The percentage of ticket price or contribution that qualifies as a tax-deductible charitable donation (e.g., 70% if 30% represents fair market value of goods/services received).',
    `ticket_price_tiers` STRING COMMENT 'Description or list of ticket pricing options available for attendees (e.g., General Admission, VIP, Student, Early Bird).',
    `total_attendance` STRING COMMENT 'The actual number of individuals who attended the fundraising event, confirmed via check-in or participation tracking.',
    `total_event_cost` DECIMAL(18,2) COMMENT 'The total expenses incurred to plan, organize, and execute the fundraising event (venue, catering, marketing, staff, etc.).',
    `total_registrations` STRING COMMENT 'The total number of individuals who registered for the fundraising event.',
    `total_revenue_raised` DECIMAL(18,2) COMMENT 'The actual total revenue generated from the fundraising event, including ticket sales, sponsorships, donations, and auction proceeds.',
    `venue_address_line1` STRING COMMENT 'First line of the street address for the event venue.',
    `venue_address_line2` STRING COMMENT 'Second line of the street address for the event venue (suite, floor, building).',
    `venue_city` STRING COMMENT 'City where the event venue is located.',
    `venue_country_code` STRING COMMENT 'Three-letter ISO country code for the event venue location.. Valid values are `^[A-Z]{3}$`',
    `venue_name` STRING COMMENT 'The name of the physical or virtual venue where the fundraising event is hosted.',
    `venue_postal_code` STRING COMMENT 'Postal or ZIP code for the event venue location.',
    `venue_state_province` STRING COMMENT 'State or province where the event venue is located.',
    `virtual_platform` STRING COMMENT 'Name of the online platform or service used to host the virtual fundraising event (e.g., Zoom, Microsoft Teams, custom web portal).',
    CONSTRAINT pk_fundraising_event PRIMARY KEY(`fundraising_event_id`)
) COMMENT 'Master record for donor-facing fundraising events and attendee registrations including galas, benefit dinners, golf tournaments, virtual fundraisers, and cultivation events managed in Salesforce Nonprofit Cloud. Captures event name, event type, event date and venue, fundraising goal, ticket price tiers, sponsorship levels, total revenue raised, total attendance, event cost, net revenue, and event manager. Includes individual constituent registration records with registration date, registration type (attendee, table sponsor, individual sponsor, volunteer), ticket type and price paid, table assignment, meal preference, attendance confirmation status, check-in timestamp, and post-event follow-up status. Enables event capacity management, seating logistics, and post-event stewardship workflows. Distinct from field operations events — fundraising events are donor cultivation and revenue generation activities.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`donor`.`event_registration` (
    `event_registration_id` BIGINT COMMENT 'Unique identifier for this event registration record. Primary key.',
    `constituent_id` BIGINT COMMENT 'Foreign key linking to the constituent who registered for or attended the fundraising event',
    `fundraising_event_id` BIGINT COMMENT 'Foreign key linking to the fundraising event for which the constituent registered',
    `attendance_status` STRING COMMENT 'The current status of the constituents attendance (registered, confirmed, checked_in, no_show, cancelled). Tracks the registration lifecycle from initial signup through event day check-in. Explicitly identified in detection phase relationship data.',
    `auction_paddle_number` STRING COMMENT 'The paddle or bidder number assigned to the constituent for auction participation at the event. Links to auction transaction tracking. Explicitly identified in detection phase relationship data.',
    `check_in_timestamp` TIMESTAMP COMMENT 'The precise date and time when the constituent checked in at the event. Used to confirm actual attendance and trigger post-event stewardship workflows.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this registration record was created in the system.',
    `dietary_restrictions` STRING COMMENT 'Any dietary restrictions or meal preferences specified by the constituent during registration (vegetarian, vegan, gluten-free, allergies). Used for catering planning. Explicitly identified in detection phase relationship data.',
    `event_registration_date` DATE COMMENT 'The date on which the constituent registered for the fundraising event. Explicitly identified in detection phase relationship data.',
    `event_registration_type` STRING COMMENT 'The type of registration or participation role for this constituent at the event (attendee, table sponsor, individual sponsor, volunteer). Determines engagement level and stewardship approach.',
    `guest_count` STRING COMMENT 'The number of guests included in this registration (e.g., table sponsorships may include multiple seats). Explicitly identified in detection phase relationship data.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this registration record was last updated.',
    `payment_method` STRING COMMENT 'The method of payment used for the registration (credit card, check, cash, wire transfer, complimentary). Supports reconciliation and revenue tracking.',
    `payment_status` STRING COMMENT 'The current payment status for this registration (paid, pending, refunded, waived). Tracks financial completion of the registration.',
    `post_event_follow_up_status` STRING COMMENT 'The status of post-event stewardship and cultivation follow-up activities for this constituent (pending, thank_you_sent, survey_sent, completed). Tracks donor engagement workflow completion.',
    `source` STRING COMMENT 'The channel through which the constituent registered for the event (online, phone, mail, in-person, staff entry). Used for marketing effectiveness analysis.',
    `special_requests` STRING COMMENT 'Any special requests or accommodations requested by the constituent (accessibility needs, seating preferences, VIP treatment). Used for event logistics and donor stewardship.',
    `table_number` STRING COMMENT 'The table number or seating assignment for the constituent at the event. Used for seating logistics and VIP placement. Explicitly identified in detection phase relationship data (table_assignment/table_number).',
    `ticket_price_paid` DECIMAL(18,2) COMMENT 'The actual amount paid by the constituent for their ticket or registration. May differ from standard ticket price due to discounts, early bird pricing, or sponsorship levels. Corresponds to amount_paid in detection phase data.',
    `ticket_type` STRING COMMENT 'The specific ticket tier or type purchased by the constituent (e.g., general admission, VIP, early bird). Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_event_registration PRIMARY KEY(`event_registration_id`)
) COMMENT 'This association product represents the registration and attendance relationship between constituents and fundraising events. It captures the complete lifecycle of constituent participation in donor cultivation and fundraising activities, from initial registration through post-event follow-up. Each record links one constituent to one fundraising event with transactional attributes including registration details, ticketing information, seating assignments, payment tracking, attendance confirmation, and stewardship workflow status. This is a core operational entity managed actively by development and events staff for capacity planning, revenue tracking, donor engagement measurement, and post-event cultivation workflows.. Existence Justification: In nonprofit fundraising operations, constituents register for and attend multiple fundraising events over their donor lifecycle (galas, golf tournaments, cultivation dinners), and each event hosts multiple constituent attendees. Event registration is an actively managed operational process with its own lifecycle: registration → payment → seating assignment → check-in → post-event follow-up. This is distinct from gift processing—not all attendees make gifts, and registration data (ticket type, table assignment, dietary restrictions, attendance confirmation) is managed separately from donation transactions.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ADD CONSTRAINT `fk_donor_prospect_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ADD CONSTRAINT `fk_donor_prospect_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ADD CONSTRAINT `fk_donor_prospect_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_appeal_id` FOREIGN KEY (`appeal_id`) REFERENCES `vibe_ngo_v1`.`donor`.`appeal`(`appeal_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_event_registration_id` FOREIGN KEY (`event_registration_id`) REFERENCES `vibe_ngo_v1`.`donor`.`event_registration`(`event_registration_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_fundraising_event_id` FOREIGN KEY (`fundraising_event_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fundraising_event`(`fundraising_event_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_original_gift_id` FOREIGN KEY (`original_gift_id`) REFERENCES `vibe_ngo_v1`.`donor`.`gift`(`gift_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `vibe_ngo_v1`.`donor`.`pledge`(`pledge_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_appeal_id` FOREIGN KEY (`appeal_id`) REFERENCES `vibe_ngo_v1`.`donor`.`appeal`(`appeal_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_fundraising_event_id` FOREIGN KEY (`fundraising_event_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fundraising_event`(`fundraising_event_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_parent_campaign_id` FOREIGN KEY (`parent_campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ADD CONSTRAINT `fk_donor_appeal_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ADD CONSTRAINT `fk_donor_appeal_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ADD CONSTRAINT `fk_donor_fund_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ADD CONSTRAINT `fk_donor_fund_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_appeal_id` FOREIGN KEY (`appeal_id`) REFERENCES `vibe_ngo_v1`.`donor`.`appeal`(`appeal_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_fundraising_event_id` FOREIGN KEY (`fundraising_event_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fundraising_event`(`fundraising_event_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_gift_id` FOREIGN KEY (`gift_id`) REFERENCES `vibe_ngo_v1`.`donor`.`gift`(`gift_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `vibe_ngo_v1`.`donor`.`pledge`(`pledge_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `vibe_ngo_v1`.`donor`.`prospect`(`prospect_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_appeal_id` FOREIGN KEY (`appeal_id`) REFERENCES `vibe_ngo_v1`.`donor`.`appeal`(`appeal_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` ADD CONSTRAINT `fk_donor_event_registration_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` ADD CONSTRAINT `fk_donor_event_registration_fundraising_event_id` FOREIGN KEY (`fundraising_event_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fundraising_event`(`fundraising_event_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`donor` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_ngo_v1`.`donor` SET TAGS ('dbx_domain' = 'donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` SET TAGS ('dbx_subdomain' = 'constituent_management');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent Identifier');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `communication_preference` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `communication_preference` SET TAGS ('dbx_value_regex' = 'email|phone|mail|sms|no_contact');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `constituent_type` SET TAGS ('dbx_business_glossary_term' = 'Constituent Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `crm_source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Constituent Relationship Management (CRM) Source Record Identifier');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `crm_source_system` SET TAGS ('dbx_business_glossary_term' = 'Constituent Relationship Management (CRM) Source System');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `crm_source_system` SET TAGS ('dbx_value_regex' = 'salesforce_nonprofit_cloud|raisers_edge_nxt|other');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `dac_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Member Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `deceased_date` SET TAGS ('dbx_business_glossary_term' = 'Deceased Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `deceased_flag` SET TAGS ('dbx_business_glossary_term' = 'Deceased Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Email Opt-In Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `estimated_giving_capacity` SET TAGS ('dbx_business_glossary_term' = 'Estimated Giving Capacity');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `estimated_giving_capacity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `first_gift_date` SET TAGS ('dbx_business_glossary_term' = 'First Gift Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `funder_classification` SET TAGS ('dbx_business_glossary_term' = 'Funder Classification');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `gdpr_consent_date` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `iati_organization_identifier` SET TAGS ('dbx_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Organization Identifier');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `iati_organization_identifier` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}-[A-Z]+-[0-9A-Z]+$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `largest_gift_amount` SET TAGS ('dbx_business_glossary_term' = 'Largest Gift Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `last_gift_date` SET TAGS ('dbx_business_glossary_term' = 'Last Gift Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `lifetime_giving_total` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Giving Total');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 1');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 2');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_city` SET TAGS ('dbx_business_glossary_term' = 'Mailing City');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Country Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Postal Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Mailing State or Province');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `oda_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Official Development Assistance (ODA) Eligibility Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `preferred_grant_modality` SET TAGS ('dbx_business_glossary_term' = 'Preferred Grant Modality');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `prospect_research_rating` SET TAGS ('dbx_business_glossary_term' = 'Prospect Research Rating');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `prospect_research_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|unrated');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|merged|duplicate|archived');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `relationship_tier` SET TAGS ('dbx_business_glossary_term' = 'Relationship Tier');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `salutation` SET TAGS ('dbx_business_glossary_term' = 'Salutation');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` SET TAGS ('dbx_subdomain' = 'constituent_management');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Identifier');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent Identifier');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `ability_score` SET TAGS ('dbx_business_glossary_term' = 'Ability Score (LAI Assessment)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `board_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Board Affiliation');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `communication_preference` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `communication_preference` SET TAGS ('dbx_value_regex' = 'email|phone|mail|in_person|no_preference');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `cultivation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Cultivation Strategy Notes');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `cultivation_strategy` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Reason');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `donor_recognition_preference` SET TAGS ('dbx_business_glossary_term' = 'Donor Recognition Preference');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `donor_recognition_preference` SET TAGS ('dbx_value_regex' = 'public|anonymous|limited|no_preference');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `estimated_capacity` SET TAGS ('dbx_business_glossary_term' = 'Estimated Giving Capacity');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `estimated_capacity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `estimated_gift_range_max` SET TAGS ('dbx_business_glossary_term' = 'Estimated Gift Range Maximum');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `estimated_gift_range_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `estimated_gift_range_min` SET TAGS ('dbx_business_glossary_term' = 'Estimated Gift Range Minimum');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `estimated_gift_range_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `expected_close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Close Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `geographic_interest` SET TAGS ('dbx_business_glossary_term' = 'Geographic Interest');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `identification_date` SET TAGS ('dbx_business_glossary_term' = 'Identification Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `interest_score` SET TAGS ('dbx_business_glossary_term' = 'Interest Score (LAI Assessment)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `last_contact_type` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `linkage_score` SET TAGS ('dbx_business_glossary_term' = 'Linkage Score (LAI Assessment)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `linkage_score` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `mailing_address` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `mailing_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `mailing_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_business_glossary_term' = 'Prospect Full Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `next_action_date` SET TAGS ('dbx_business_glossary_term' = 'Next Action Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `next_action_description` SET TAGS ('dbx_business_glossary_term' = 'Next Action Description');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `previous_giving_history` SET TAGS ('dbx_business_glossary_term' = 'Previous Giving History');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `previous_giving_history` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `probability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Probability Percentage');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `probability_percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `program_interest_area` SET TAGS ('dbx_business_glossary_term' = 'Program Interest Area');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_status` SET TAGS ('dbx_business_glossary_term' = 'Prospect Status');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_status` SET TAGS ('dbx_value_regex' = 'active|inactive|disqualified|converted|on_hold');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_type` SET TAGS ('dbx_business_glossary_term' = 'Prospect Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_type` SET TAGS ('dbx_value_regex' = 'individual|foundation|corporate|institutional|government|multilateral');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `rating` SET TAGS ('dbx_business_glossary_term' = 'Prospect Rating');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `rating` SET TAGS ('dbx_value_regex' = 'A+|A|B+|B|C+|C|D');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `research_stage` SET TAGS ('dbx_business_glossary_term' = 'Research Stage');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `research_stage` SET TAGS ('dbx_value_regex' = 'not_started|preliminary|in_depth|completed|ongoing_monitoring');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `research_stage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `solicitation_amount` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `solicitation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `solicitation_date` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `source_of_wealth` SET TAGS ('dbx_business_glossary_term' = 'Source of Wealth');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `source_of_wealth` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Prospect Stage');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `stage` SET TAGS ('dbx_value_regex' = 'identification|qualification|cultivation|solicitation|negotiation|stewardship');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `stage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `wealth_screening_score` SET TAGS ('dbx_business_glossary_term' = 'Wealth Screening Score');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `wealth_screening_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` SET TAGS ('dbx_subdomain' = 'fundraising_giving');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `gift_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Safeguarding Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `event_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Event Registration Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `fundraising_event_id` SET TAGS ('dbx_business_glossary_term' = 'Fundraising Event Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `original_gift_id` SET TAGS ('dbx_business_glossary_term' = 'Original Gift Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Single Audit Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `acknowledgement_type` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Gift Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `anonymous_flag` SET TAGS ('dbx_business_glossary_term' = 'Anonymous Gift Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Processing Fee Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `gift_date` SET TAGS ('dbx_business_glossary_term' = 'Gift Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `gift_status` SET TAGS ('dbx_business_glossary_term' = 'Gift Status');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `gift_status` SET TAGS ('dbx_value_regex' = 'pending|received|processed|acknowledged|refunded|cancelled');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `gift_type` SET TAGS ('dbx_business_glossary_term' = 'Gift Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `goods_services_value` SET TAGS ('dbx_business_glossary_term' = 'Goods or Services Fair Market Value');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `honoree_name` SET TAGS ('dbx_business_glossary_term' = 'Honoree Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `honoree_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `honoree_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `irs_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Service (IRS) Compliant Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `match_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Match Approval Status');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `match_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|paid');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `match_ratio` SET TAGS ('dbx_business_glossary_term' = 'Match Ratio');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `match_request_date` SET TAGS ('dbx_business_glossary_term' = 'Match Request Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `matching_gift_flag` SET TAGS ('dbx_business_glossary_term' = 'Matching Gift Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Gift Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_address` SET TAGS ('dbx_business_glossary_term' = 'Notification Recipient Address');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Notification Recipient Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Gift Number');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `refund_flag` SET TAGS ('dbx_business_glossary_term' = 'Refund Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `refund_reason` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `restriction_description` SET TAGS ('dbx_business_glossary_term' = 'Restriction Description');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'unrestricted|temporarily-restricted|permanently-restricted');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `tribute_flag` SET TAGS ('dbx_business_glossary_term' = 'Tribute Gift Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `tribute_type` SET TAGS ('dbx_business_glossary_term' = 'Tribute Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `tribute_type` SET TAGS ('dbx_value_regex' = 'in-honor-of|in-memory-of');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` SET TAGS ('dbx_subdomain' = 'fundraising_giving');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Identifier');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Identifier');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `fundraising_event_id` SET TAGS ('dbx_business_glossary_term' = 'Fundraising Event Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `acknowledgment_sent` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Sent');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Amount Paid');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `balance_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Balance Outstanding');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `first_installment_date` SET TAGS ('dbx_business_glossary_term' = 'First Installment Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `fulfillment_date` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Installment Frequency');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_value_regex' = 'one_time|monthly|quarterly|semi_annual|annual|custom');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `installments_paid` SET TAGS ('dbx_business_glossary_term' = 'Installments Paid');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `installments_remaining` SET TAGS ('dbx_business_glossary_term' = 'Installments Remaining');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `is_anonymous` SET TAGS ('dbx_business_glossary_term' = 'Is Anonymous');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `is_matching_gift_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Matching Gift Eligible');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `last_installment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Installment Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `next_installment_amount` SET TAGS ('dbx_business_glossary_term' = 'Next Installment Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `next_installment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Installment Due Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Pledge Notes');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Pledge Number');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `number_of_installments` SET TAGS ('dbx_business_glossary_term' = 'Number of Installments');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|bank_transfer|check|cash|stock|wire_transfer');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `pledge_date` SET TAGS ('dbx_business_glossary_term' = 'Pledge Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `pledge_status` SET TAGS ('dbx_business_glossary_term' = 'Pledge Status');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `pledge_status` SET TAGS ('dbx_value_regex' = 'active|fulfilled|lapsed|written_off|cancelled|pending');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `pledge_type` SET TAGS ('dbx_business_glossary_term' = 'Pledge Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `pledge_type` SET TAGS ('dbx_value_regex' = 'standard|sustainer|major_gift|planned_giving|capital_campaign|endowment');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `reminder_schedule` SET TAGS ('dbx_business_glossary_term' = 'Reminder Schedule');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `reminder_schedule` SET TAGS ('dbx_value_regex' = 'none|7_days_before|14_days_before|30_days_before|custom');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `total_pledge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Pledge Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `write_off_reason` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` SET TAGS ('dbx_subdomain' = 'fundraising_giving');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Compliance Req Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `mel_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `parent_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Campaign ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `acknowledgment_template` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Template');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `appeal_channel` SET TAGS ('dbx_business_glossary_term' = 'Appeal Channel');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `appeal_description` SET TAGS ('dbx_business_glossary_term' = 'Appeal Description');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|cancelled|on_hold');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'annual_fund|capital_campaign|emergency_appeal|planned_giving|corporate_partnership|digital_online');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `cost_of_fundraising` SET TAGS ('dbx_business_glossary_term' = 'Cost of Fundraising');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `donor_count` SET TAGS ('dbx_business_glossary_term' = 'Donor Count');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `gift_count` SET TAGS ('dbx_business_glossary_term' = 'Gift Count');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `goal_amount` SET TAGS ('dbx_business_glossary_term' = 'Campaign Goal Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `impact_report_url` SET TAGS ('dbx_business_glossary_term' = 'Impact Report URL');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `is_public` SET TAGS ('dbx_business_glossary_term' = 'Is Public Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `matching_gift_eligible` SET TAGS ('dbx_business_glossary_term' = 'Matching Gift Eligible Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Percentage');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `roi_percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `stewardship_plan` SET TAGS ('dbx_business_glossary_term' = 'Stewardship Plan');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `target_audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `tax_deductible` SET TAGS ('dbx_business_glossary_term' = 'Tax Deductible Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `total_raised_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Raised Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` SET TAGS ('dbx_subdomain' = 'fundraising_giving');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `acknowledgment_template` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Template');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|completed|cancelled|on_hold');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_type` SET TAGS ('dbx_business_glossary_term' = 'Appeal Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_type` SET TAGS ('dbx_value_regex' = 'acquisition|renewal|upgrade|lapsed_reactivation|major_gift|planned_giving');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `ask_amount` SET TAGS ('dbx_business_glossary_term' = 'Suggested Ask Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `ask_string` SET TAGS ('dbx_business_glossary_term' = 'Ask String');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `average_gift_amount` SET TAGS ('dbx_business_glossary_term' = 'Average Gift Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `average_gift_amount` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Channel');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_code` SET TAGS ('dbx_business_glossary_term' = 'Appeal Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `control_group_flag` SET TAGS ('dbx_business_glossary_term' = 'Control Group Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Appeal Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal End Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `mailing_date` SET TAGS ('dbx_business_glossary_term' = 'Mailing Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Appeal Manager Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_name` SET TAGS ('dbx_business_glossary_term' = 'Appeal Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Appeal Notes');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `package_description` SET TAGS ('dbx_business_glossary_term' = 'Appeal Package Description');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `package_description` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `pieces_sent` SET TAGS ('dbx_business_glossary_term' = 'Number of Pieces Sent');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `premium_offered` SET TAGS ('dbx_business_glossary_term' = 'Premium Offered');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `response_count` SET TAGS ('dbx_business_glossary_term' = 'Response Count');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `response_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Response Rate Percentage');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `revenue_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Currency Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `revenue_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `roi_ratio` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Ratio');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `solicitor_name` SET TAGS ('dbx_business_glossary_term' = 'Solicitor Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `solicitor_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Start Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `test_segment_flag` SET TAGS ('dbx_business_glossary_term' = 'Test Segment Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `total_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` SET TAGS ('dbx_subdomain' = 'fundraising_giving');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Compliance Req Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `mel_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `audit_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Required Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `balance` SET TAGS ('dbx_business_glossary_term' = 'Fund Balance');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `beneficiary_population` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Population');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Fund Closure Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Required Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `donor_fund_category` SET TAGS ('dbx_business_glossary_term' = 'Fund Category');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `donor_fund_code` SET TAGS ('dbx_business_glossary_term' = 'Fund Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `donor_fund_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,15}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `donor_fund_description` SET TAGS ('dbx_business_glossary_term' = 'Fund Description');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `donor_fund_name` SET TAGS ('dbx_business_glossary_term' = 'Fund Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `donor_fund_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `donor_fund_status` SET TAGS ('dbx_business_glossary_term' = 'Fund Status');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `donor_fund_status` SET TAGS ('dbx_value_regex' = 'open|closed|suspended|pending_approval');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `donor_fund_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `donor_fund_type` SET TAGS ('dbx_value_regex' = 'restricted|temporarily_restricted|unrestricted|endowment|quasi_endowment|board_designated');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `endowment_spending_policy` SET TAGS ('dbx_business_glossary_term' = 'Endowment Spending Policy');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|country_specific|multi_country');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `iati_identifier` SET TAGS ('dbx_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Identifier');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `inception_date` SET TAGS ('dbx_business_glossary_term' = 'Fund Inception Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `investment_policy` SET TAGS ('dbx_business_glossary_term' = 'Investment Policy');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `minimum_gift_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Gift Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|upon_request');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `restriction_description` SET TAGS ('dbx_business_glossary_term' = 'Restriction Description');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `restriction_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Restriction Expiration Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'purpose_restricted|time_restricted|perpetual|unrestricted');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `target_countries` SET TAGS ('dbx_business_glossary_term' = 'Target Countries');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` SET TAGS ('dbx_subdomain' = 'constituent_management');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `stewardship_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Stewardship Activity ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `award_id` SET TAGS ('dbx_description_cleaned' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `evaluation_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Finding Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `fundraising_event_id` SET TAGS ('dbx_business_glossary_term' = 'Fundraising Event Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `gift_id` SET TAGS ('dbx_business_glossary_term' = 'Gift ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `indicator_result_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Result Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `mel_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `partner_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `volunteer_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Deployment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `acknowledgement_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Sent Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `acknowledgement_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Sent Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `attendee_count` SET TAGS ('dbx_business_glossary_term' = 'Attendee Count');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `communication_channel` SET TAGS ('dbx_value_regex' = 'in_person|phone|email|video_call|mail|event');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'Completed Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `stewardship_activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `donor_response` SET TAGS ('dbx_business_glossary_term' = 'Donor Response');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `donor_response` SET TAGS ('dbx_value_regex' = 'committed|interested|considering|declined|no_response');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `donor_sentiment` SET TAGS ('dbx_business_glossary_term' = 'Donor Sentiment');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `donor_sentiment` SET TAGS ('dbx_value_regex' = 'very_positive|positive|neutral|negative|very_negative');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `engagement_score` SET TAGS ('dbx_business_glossary_term' = 'Engagement Score');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `engagement_score` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `impact_story_shared_flag` SET TAGS ('dbx_business_glossary_term' = 'Impact Story Shared Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Activity Location');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `next_steps` SET TAGS ('dbx_business_glossary_term' = 'Next Steps');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Activity Outcome');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `solicitation_amount` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `solicitation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Currency Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `solicitation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `solicitation_made_flag` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Made Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `stewardship_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Activity Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `stewardship_activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `stewardship_activity_status` SET TAGS ('dbx_value_regex' = 'planned|completed|cancelled|rescheduled|pending');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `stewardship_activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `stewardship_activity_type` SET TAGS ('dbx_value_regex' = 'acknowledgement_letter|impact_report|site_visit|phone_call|event_invitation|personal_meeting');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `stewardship_plan_stage` SET TAGS ('dbx_business_glossary_term' = 'Stewardship Plan Stage');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `stewardship_plan_stage` SET TAGS ('dbx_value_regex' = 'identification|cultivation|solicitation|stewardship|renewal');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `stewardship_plan_stage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Activity Subject');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` SET TAGS ('dbx_subdomain' = 'event_engagement');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `fundraising_event_id` SET TAGS ('dbx_business_glossary_term' = 'Fundraising Event ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `acknowledgment_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Sent Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `capacity_total` SET TAGS ('dbx_business_glossary_term' = 'Total Capacity');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `fundraising_event_code` SET TAGS ('dbx_business_glossary_term' = 'Event Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `fundraising_event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Event End Time');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `fundraising_event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `fundraising_event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `fundraising_event_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|cancelled|postponed');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `fundraising_event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `fundraising_event_type` SET TAGS ('dbx_value_regex' = 'gala|benefit_dinner|golf_tournament|auction|virtual_fundraiser|cultivation_event');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `fundraising_goal_amount` SET TAGS ('dbx_business_glossary_term' = 'Fundraising Goal Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `is_tax_deductible` SET TAGS ('dbx_business_glossary_term' = 'Is Tax Deductible');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `is_virtual_event` SET TAGS ('dbx_business_glossary_term' = 'Is Virtual Event');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Event Manager Email');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Event Manager Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Event Manager Phone');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `fundraising_event_name` SET TAGS ('dbx_business_glossary_term' = 'Event Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `fundraising_event_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `net_revenue` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `registration_close_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Close Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `registration_open_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Open Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `sponsorship_levels_available` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Levels Available');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Event Start Time');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `tax_deductible_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Deductible Percentage');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `tax_deductible_percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `ticket_price_tiers` SET TAGS ('dbx_business_glossary_term' = 'Ticket Price Tiers');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `total_attendance` SET TAGS ('dbx_business_glossary_term' = 'Total Attendance');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `total_event_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Event Cost');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `total_registrations` SET TAGS ('dbx_business_glossary_term' = 'Total Registrations');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `total_revenue_raised` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue Raised');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `venue_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Venue Address Line 1');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `venue_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `venue_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `venue_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Venue Address Line 2');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `venue_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `venue_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `venue_city` SET TAGS ('dbx_business_glossary_term' = 'Venue City');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `venue_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `venue_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `venue_country_code` SET TAGS ('dbx_business_glossary_term' = 'Venue Country Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `venue_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `venue_name` SET TAGS ('dbx_business_glossary_term' = 'Venue Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `venue_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `venue_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Venue Postal Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `venue_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `venue_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `venue_state_province` SET TAGS ('dbx_business_glossary_term' = 'Venue State or Province');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `venue_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `venue_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ALTER COLUMN `virtual_platform` SET TAGS ('dbx_business_glossary_term' = 'Virtual Platform');
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` SET TAGS ('dbx_subdomain' = 'event_engagement');
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` ALTER COLUMN `event_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Event Registration ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Event Registration - Constituent Id');
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` ALTER COLUMN `fundraising_event_id` SET TAGS ('dbx_business_glossary_term' = 'Event Registration - Fundraising Event Id');
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` ALTER COLUMN `attendance_status` SET TAGS ('dbx_business_glossary_term' = 'Attendance Status');
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` ALTER COLUMN `auction_paddle_number` SET TAGS ('dbx_business_glossary_term' = 'Auction Paddle Number');
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` ALTER COLUMN `dietary_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Dietary Restrictions');
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` ALTER COLUMN `event_registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` ALTER COLUMN `event_registration_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` ALTER COLUMN `guest_count` SET TAGS ('dbx_business_glossary_term' = 'Guest Count');
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` ALTER COLUMN `post_event_follow_up_status` SET TAGS ('dbx_business_glossary_term' = 'Post-Event Follow-Up Status');
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Registration Source');
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Requests');
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` ALTER COLUMN `table_number` SET TAGS ('dbx_business_glossary_term' = 'Table Assignment');
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` ALTER COLUMN `ticket_price_paid` SET TAGS ('dbx_business_glossary_term' = 'Ticket Price Paid');
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_registration` ALTER COLUMN `ticket_type` SET TAGS ('dbx_business_glossary_term' = 'Ticket Type');
