-- Schema for Domain: client | Business: Construction | Version: v2_mvm
-- Generated on: 2026-06-27 01:56:02

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`client` COMMENT 'Master client/owner data managing relationships with project owners, developers, and sponsors who commission construction work. Owns client profiles, account hierarchies, JV structures, stakeholder contacts, communication preferences, and relationship history. Supports CRM (Customer Relationship Management), opportunity pipeline management, and client segmentation across public-sector, private-sector, and PPP/BOT arrangements.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`client`.`account` (
    `account_id` BIGINT COMMENT 'Unique surrogate identifier for the client/owner account record in the Silver Layer lakehouse. Primary key for the account master entity.',
    `parent_account_id` BIGINT COMMENT 'Reference to the parent account record for clients that are subsidiaries or divisions within a larger corporate hierarchy. Enables account hierarchy traversal for consolidated reporting and group-level relationship management.',
    `primary_ultimate_parent_account_id` BIGINT COMMENT 'Reference to the top-level account in the corporate hierarchy (ultimate holding entity). Used for group-level exposure analysis, consolidated pipeline reporting, and enterprise relationship management.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to client.segment. Business justification: An account belongs to a single segment classification; using a foreign key to segment normalizes the model and removes the redundant string column.',
    `account_status` STRING COMMENT 'Current lifecycle status of the client account. Controls whether the account is eligible for new project bids, contract awards, and CRM pipeline activities.. Valid values are `active|inactive|prospect|suspended|blacklisted|archived`',
    `account_type` STRING COMMENT 'Classification of the client account by ownership and sector type. Drives contract template selection, compliance requirements, and reporting segmentation. [ENUM-REF-CANDIDATE: public_sector|private_sector|government_body|corporate_sponsor|jv_entity|ppp_authority — promote to reference product]. Valid values are `public_sector|private_sector|government_body|corporate_sponsor|jv_entity|ppp_authority`',
    `annual_revenue` DECIMAL(18,2) COMMENT 'Reported or estimated annual revenue of the client organisation in the accounts billing currency. Used for client segmentation, credit assessment, and strategic account prioritisation.',
    `billing_address` STRING COMMENT 'Address to which invoices and financial correspondence are directed for this client account. May differ from the registered address. Used in SAP S/4HANA accounts receivable and Viewpoint Vista job costing.',
    `bim_requirement_level` STRING COMMENT 'Level of Building Information Modeling (BIM) mandated by the client for construction projects. Drives design collaboration tooling requirements (e.g., Autodesk BIM 360), data exchange standards, and project delivery methodology.. Valid values are `none|bim_level_1|bim_level_2|bim_level_3`',
    `client_tier` STRING COMMENT 'Strategic segmentation tier assigned to the client based on revenue potential, relationship depth, and strategic importance. Tier 1 represents the highest-value clients. Drives account management resource allocation and executive engagement levels.. Valid values are `tier_1|tier_2|tier_3|strategic`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country of incorporation or primary operations for the client organisation. Used for jurisdictional compliance, tax treatment, and geographic segmentation.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the account record was first created in the source Salesforce CRM system. Represents the audit trail creation event for the master client record.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding receivable balance approved for this client account. Used by the finance team to manage exposure and payment risk on construction contracts. Expressed in the accounts billing currency.',
    `credit_rating` STRING COMMENT 'External credit rating assigned to the client organisation by a recognised credit rating agency (e.g., S&P, Moodys, Fitch) or internal credit assessment score. Used for financial risk evaluation, payment terms negotiation, and bonding/surety decisions.',
    `crm_account_code` STRING COMMENT 'Source system identifier for the account as recorded in Salesforce CRM. Used for cross-system reconciliation and lineage tracing back to the operational system of record.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code representing the primary billing currency for this client account (e.g., USD, GBP, EUR, AED). Used for contract valuation, invoicing, and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `do_not_contact` BOOLEAN COMMENT 'Indicates whether outbound marketing and unsolicited commercial communications to this client account are restricted. Set to True when the client has opted out of communications or is subject to legal/regulatory restrictions. Supports GDPR compliance.',
    `duns_number` STRING COMMENT 'Nine-digit Dun & Bradstreet Data Universal Numbering System identifier for the client organisation. Used for credit assessment, supplier/client qualification, and global entity resolution.. Valid values are `^[0-9]{9}$`',
    `employee_count` STRING COMMENT 'Approximate number of employees in the client organisation. Used as a proxy for organisational scale, procurement capacity, and client segmentation in CRM analytics.',
    `eot_policy` STRING COMMENT 'Clients standard policy for granting Extension of Time (EOT) on construction contracts. Indicates whether the client follows standard FIDIC provisions, applies strict timelines, or allows flexible negotiation. Used in bid risk evaluation.. Valid values are `standard|strict|flexible`',
    `hse_compliance_required` BOOLEAN COMMENT 'Indicates whether this client mandates specific Health, Safety and Environment (HSE) compliance standards (e.g., ISO 45001, OSHA requirements, client-specific HSE plans) as a condition of contract. Drives HSE planning and prequalification requirements.',
    `industry_sector` STRING COMMENT 'Primary industry sector of the client organisation (e.g., Infrastructure, Energy, Real Estate, Transportation, Healthcare, Government). Used for market segmentation and opportunity pipeline analytics in Salesforce CRM.',
    `is_jv_entity` BOOLEAN COMMENT 'Indicates whether this client account represents a Joint Venture (JV) entity formed specifically for a construction project or programme. JV entities require special contract administration, profit-sharing arrangements, and consolidated reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the account record in the source Salesforce CRM system. Used for change data capture, incremental ETL processing, and audit trail maintenance.',
    `last_project_award_date` DATE COMMENT 'Date of the most recent contract or project award from this client. Used to identify dormant accounts, measure relationship recency, and prioritise re-engagement activities in the CRM pipeline.',
    `ld_clause_standard` STRING COMMENT 'Indicates whether this client typically enforces Liquidated Damages (LD) clauses in construction contracts, and whether the LD terms are standard or negotiable. Informs bid risk assessment and contract strategy.. Valid values are `yes|no|negotiable`',
    `leed_certification_required` BOOLEAN COMMENT 'Indicates whether this client requires LEED (Leadership in Energy and Environmental Design) certification for construction projects. Drives design, procurement, and construction methodology decisions to meet green building standards.',
    `legal_name` STRING COMMENT 'Full registered legal name of the client/owner organisation as it appears on contracts, invoices, and regulatory filings. This is the authoritative identity label for the account.',
    `ntp_authority_level` STRING COMMENT 'Describes the clients internal authority level or approval threshold required to issue a Notice to Proceed (NTP) on construction contracts. Used in contract administration to understand client governance and approval workflows.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the client for construction contracts (e.g., Net 30, Net 60, milestone-based, progress payment). Drives accounts receivable management and cash flow forecasting in SAP S/4HANA.',
    `preferred_contract_type` STRING COMMENT 'Clients preferred contract delivery model for construction engagements. Options include Engineering Procurement and Construction (EPC), Guaranteed Maximum Price (GMP), Design-Bid-Build (DBB), Design-Build (DB), Public-Private Partnership (PPP), and Build-Operate-Transfer (BOT). Informs bid strategy and contract template selection. [ENUM-REF-CANDIDATE: EPC|GMP|DBB|DB|PPP|BOT|FIDIC — 7 candidates stripped; promote to reference product]',
    `prequalification_expiry_date` DATE COMMENT 'Date on which the clients prequalification approval expires and requires renewal. Used to trigger re-assessment workflows and ensure compliance before new contract awards.',
    `prequalification_status` STRING COMMENT 'Current prequalification status of the client as a commissioning entity. Indicates whether the client has been assessed and approved for contract award eligibility, is pending review, or has an expired/rejected qualification.. Valid values are `approved|pending|expired|rejected`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact at the client organisation. Used for RFI responses, RFP submissions, contract correspondence, and CRM communication tracking.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary point of contact at the client organisation for commercial and contractual matters. Typically the clients project director, procurement manager, or authorised representative.',
    `primary_contact_phone` STRING COMMENT 'Direct telephone number for the primary contact at the client organisation. Used for urgent project communications, bid clarifications, and relationship management activities.',
    `registered_address` STRING COMMENT 'Full registered office address of the client organisation as recorded with the relevant business registry. Used for legal correspondence, contract execution, and regulatory filings.',
    `registration_number` STRING COMMENT 'Official company or entity registration number issued by the relevant national or state business registry authority. Used for legal entity verification and compliance due diligence.',
    `relationship_start_date` DATE COMMENT 'Date on which the business relationship with this client was formally established (e.g., first contract award, first NTP issued, or CRM account creation date). Used for relationship tenure analysis and loyalty segmentation.',
    `tax_number` STRING COMMENT 'Government-issued tax identification number (e.g., EIN, VAT number, GST number) for the client entity. Required for invoicing, contract administration, and financial reporting under IFRS/GAAP.',
    `trading_name` STRING COMMENT 'Operating or brand name used by the client organisation in day-to-day business, which may differ from the registered legal name. Used in CRM displays and correspondence.',
    `website_url` STRING COMMENT 'Official website address of the client organisation. Used for due diligence, background research, and CRM account enrichment.. Valid values are `^https?://[^s/$.?#].[^s]*$`',
    CONSTRAINT pk_account PRIMARY KEY(`account_id`)
) COMMENT 'Master record for each client/owner organization that commissions construction work. SSOT for client identity across public-sector agencies, private developers, government bodies, and corporate sponsors. Captures legal entity name, registration number, tax ID, industry sector, client tier, credit rating, preferred contract type (EPC, GMP, DBB, PPP, BOT), account status, CRM account owner, and segment assignments. Sourced from Salesforce CRM Account object. All other client domain products reference this entity.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`client`.`contact` (
    `contact_id` BIGINT COMMENT 'Unique surrogate identifier for the individual stakeholder contact record in the Databricks Silver Layer. Primary key for the contact data product.',
    `account_id` BIGINT COMMENT 'Reference to the parent client account (project owner, developer, or sponsor) to which this contact belongs. Sourced from Salesforce CRM Account object.',
    `address_id` BIGINT COMMENT 'Foreign key linking to client.address. Business justification: contact carries five inline mailing address fields (mailing_street, mailing_city, mailing_state, mailing_postal_code, mailing_country) that duplicate the address tables purpose. The address table is ',
    `reports_to_contact_id` BIGINT COMMENT 'Self-referencing identifier pointing to the contacts direct manager or superior within the client organisation. Enables hierarchical stakeholder mapping and organisational chart modelling for large client accounts.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to client.segment. Business justification: contact.client_segment is a STRING denormalization of the segment classification. The segment table is the authoritative SSOT for client segmentation in this domain. Adding segment_id FK to contact no',
    `account_manager` STRING COMMENT 'Full name of the internal account manager or business development representative responsible for managing the relationship with this contact. Used for ownership assignment and pipeline accountability in Salesforce CRM.',
    `birthdate` DATE COMMENT 'Date of birth of the contact. Stored for relationship personalisation purposes (e.g., milestone acknowledgements) and identity verification in regulated markets. Handled under strict GDPR data minimisation principles.',
    `contact_status` STRING COMMENT 'Current lifecycle status of the contact record within the CRM system. active indicates an engaged stakeholder; inactive indicates no recent engagement; archived indicates the contact has left the organisation; do_not_contact indicates a communication opt-out or legal restriction.. Valid values are `active|inactive|archived|do_not_contact`',
    `contact_type` STRING COMMENT 'Classification of the contacts functional role in the client relationship (e.g., owner representative, technical representative, procurement officer, legal counsel, executive sponsor, financial approver). Drives stakeholder engagement strategy and communication routing. [ENUM-REF-CANDIDATE: owner|technical|procurement|legal|executive|financial|hse|commercial — promote to reference product]. Valid values are `owner|technical|procurement|legal|executive|financial`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contact record was first created in the source Salesforce CRM system. Used for data lineage, audit trail, and CRM record age analytics in the Databricks Silver Layer.',
    `crm_contact_code` STRING COMMENT 'External identifier for this contact as recorded in Salesforce CRM Contact object. Used for cross-system reconciliation and data lineage tracing back to the operational system of record.',
    `data_consent_date` DATE COMMENT 'Date on which the contacts data processing consent was last recorded or updated. Required for GDPR compliance audit trails to demonstrate lawful basis for processing personal data.',
    `data_consent_status` STRING COMMENT 'Current status of the contacts consent for personal data processing under applicable privacy regulations (GDPR, CCPA). Tracks whether consent has been granted, withdrawn, is pending confirmation, or is not required (e.g., legitimate interest basis).. Valid values are `granted|withdrawn|pending|not_required`',
    `decision_authority_level` STRING COMMENT 'Indicates the contacts level of decision-making authority within the client organisation for construction project approvals, contract awards, and change order authorisations. Supports bid strategy and stakeholder influence mapping.. Valid values are `strategic|operational|advisory|none`',
    `department` STRING COMMENT 'Organisational department or business unit within the client organisation to which the contact belongs (e.g., Engineering, Procurement, Legal, Finance). Supports targeted stakeholder engagement and communication routing.',
    `do_not_contact` BOOLEAN COMMENT 'Indicates that this contact has opted out of all marketing and non-essential communications, or that a legal restriction prevents outreach. Enforces GDPR Article 21 right to object and CAN-SPAM compliance in Salesforce CRM campaign management.',
    `email` STRING COMMENT 'Primary business email address of the contact used for official project correspondence, RFI responses, bid submissions, and CRM communication tracking. Sourced from Salesforce CRM.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `email_opt_out` BOOLEAN COMMENT 'Indicates whether the contact has opted out of email marketing communications specifically. Distinct from do_not_contact which covers all channels. Enforces GDPR consent management and CAN-SPAM compliance.',
    `first_name` STRING COMMENT 'Given name of the individual stakeholder contact as recorded in Salesforce CRM. Used for personalised correspondence and formal communication in client relationship management.',
    `full_name` STRING COMMENT 'Complete display name of the contact (e.g., salutation + first + last name) as stored in Salesforce CRM. Used in formal correspondence, bid submissions, and contract administration documents.',
    `influence_score` STRING COMMENT 'Numeric score (typically 1–10) representing the contacts level of influence over project award decisions, contract negotiations, and change order approvals. Used in bid strategy and stakeholder mapping for major infrastructure pursuits.',
    `is_decision_maker` BOOLEAN COMMENT 'Indicates whether this contact has final decision-making authority for contract awards, change orders (CO), or project approvals. Critical for bid management and opportunity pipeline qualification in Salesforce CRM.',
    `is_executive_sponsor` BOOLEAN COMMENT 'Indicates whether this contact holds the role of executive sponsor for the client relationship. Executive sponsors are senior client representatives who champion the construction partnership at the strategic level.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this contact is the designated primary point of contact for the client account. Only one contact per account should be flagged as primary. Used to route official correspondence and contract notifications.',
    `job_title` STRING COMMENT 'Official job title or position of the contact within their organisation (e.g., Project Director, Procurement Manager, Chief Engineer). Used to identify the contacts functional role in client engagement and bid management.',
    `last_activity_date` DATE COMMENT 'Date of the most recent logged activity (call, email, meeting, site visit) with this contact in Salesforce CRM. Used to measure engagement recency and identify at-risk relationships in client retention analytics.',
    `last_meeting_date` DATE COMMENT 'Date of the most recent in-person or virtual meeting held with this contact. Used by account managers to track face-to-face engagement frequency and support relationship health assessments.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contact record in the source Salesforce CRM system. Used for incremental data loading, change data capture (CDC), and audit trail maintenance in the Silver Layer.',
    `last_name` STRING COMMENT 'Family name or surname of the individual stakeholder contact. Combined with first_name to form the full display name used in client-facing communications and CRM reporting.',
    `linkedin_url` STRING COMMENT 'LinkedIn professional profile URL for the contact. Used by business development and account management teams for relationship intelligence, stakeholder research, and pre-bid engagement in Salesforce CRM.. Valid values are `^https://(www.)?linkedin.com/in/[a-zA-Z0-9-_%]+/?$`',
    `mobile_phone` STRING COMMENT 'Mobile or cell phone number for the contact. Used for urgent site communications, HSE notifications, and out-of-hours contact during critical project milestones.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `notes` STRING COMMENT 'Free-text field for account managers to record qualitative observations, relationship context, stakeholder preferences, and strategic notes about the contact. Supports informed client engagement and bid strategy preparation.',
    `phone` STRING COMMENT 'Primary business phone number for the contact, including country and area code. Used for direct communication during project execution, bid clarifications, and contract administration.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `preferred_communication_channel` STRING COMMENT 'The contacts preferred method of communication for project correspondence, meeting invitations, and bid-related notifications. Sourced from Salesforce CRM and used to personalise outreach in opportunity pipeline management.. Valid values are `email|phone|video_call|in_person|portal`',
    `preferred_language` STRING COMMENT 'ISO 639-1 language code representing the contacts preferred language for written and verbal communication (e.g., en, fr, ar, zh). Supports multilingual project environments common in global EPC and infrastructure projects.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `relationship_health` STRING COMMENT 'Qualitative assessment of the current health of the business relationship with this contact, as evaluated by the account manager or business development team. Used in CRM pipeline forecasting and client retention strategies.. Valid values are `strong|good|neutral|at_risk|poor`',
    `salutation` STRING COMMENT 'Formal honorific or title prefix for the contact (e.g., Mr., Ms., Dr.) used in official correspondence, contract documents, and client communications.. Valid values are `Mr.|Ms.|Mrs.|Dr.|Prof.`',
    `source` STRING COMMENT 'Origin channel through which this contact was acquired or first identified (e.g., CRM import, referral, industry conference, Request for Proposal (RFP) response, website enquiry, partner introduction). Supports lead source analytics in Salesforce CRM.. Valid values are `crm|referral|conference|rfp|website|partner`',
    CONSTRAINT pk_contact PRIMARY KEY(`contact_id`)
) COMMENT 'Individual stakeholder contact associated with a client account, including project owners, technical representatives, procurement officers, legal counsel, and executive sponsors. Captures full name, job title, department, email, phone, preferred communication channel, decision-making authority level, and relationship health indicator. Sourced from Salesforce CRM Contact object.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`client`.`address` (
    `address_id` BIGINT COMMENT 'Unique surrogate identifier for each client address record in the Construction data platform. Serves as the primary key for the client_address entity.',
    `account_id` BIGINT COMMENT 'Reference to the parent client account to which this address belongs. Links the address record to the client master in the CRM (Customer Relationship Management) system (Salesforce CRM).',
    `address_status` STRING COMMENT 'Current lifecycle status of the address record. Active indicates the address is in current use; inactive means it is no longer used; pending_validation awaits address verification; superseded means it has been replaced by a newer address; undeliverable indicates mail or correspondence has been returned.. Valid values are `active|inactive|pending_validation|superseded|undeliverable`',
    `address_type` STRING COMMENT 'Classifies the functional purpose of the address. Registered office is the legal domicile; billing is used for invoice delivery; correspondence is the preferred mailing address; project_site_liaison is the on-site contact office for a specific project; head_office and branch_office denote organisational hierarchy locations. [ENUM-REF-CANDIDATE: registered_office|billing|correspondence|project_site_liaison|head_office|branch_office — promote to reference product]. Valid values are `registered_office|billing|correspondence|project_site_liaison|head_office|branch_office`',
    `attention_to` STRING COMMENT 'Name of the specific individual or department to whom correspondence should be directed at this address (e.g., Attn: Contracts Manager or Attn: Finance Department). Used in formal contract correspondence and RFI (Request for Information) transmittals.',
    `building_name` STRING COMMENT 'Name of the building or complex at this address (e.g., Empire State Building, One Canada Square, Dubai World Trade Centre). Used for precise address identification in dense urban environments and for formal correspondence headers.',
    `city` STRING COMMENT 'Name of the city, town, or municipality in which the address is located. Used for regional client segmentation, jurisdiction determination, and multi-city project coordination.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the address (e.g., USA, GBR, AUS, ARE). Supports multi-jurisdiction client management across global construction operations including EPC (Engineering, Procurement and Construction) and PPP (Public-Private Partnership) projects.. Valid values are `^[A-Z]{3}$`',
    `country_name` STRING COMMENT 'Full English name of the country corresponding to the country_code. Stored for display and reporting purposes to avoid repeated lookups against the ISO country reference table. Denormalized natural-key value derivable from country_code; resolved warning.',
    `country_natural_key_source` STRING COMMENT 'SSOT pointer for the denormalized country_code/country_name natural key, governing the denormalized natural key warning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was first created in the data platform. Provides the audit trail creation marker for data governance and GDPR compliance tracking.',
    `effective_from_date` DATE COMMENT 'Date from which this address became or becomes effective for the client. Supports temporal address management, enabling historical address tracking for contract administration and legal notice purposes.',
    `effective_to_date` DATE COMMENT 'Date on which this address ceases to be effective for the client. Null indicates the address is currently active with no planned end date. Used for temporal address history management and superseded address tracking.',
    `email_address` STRING COMMENT 'General email address associated with this address location (e.g., a departmental or office inbox). Used for electronic correspondence, transmittal delivery via Aconex, and formal notice under contract. Distinct from individual contact email addresses.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number associated with this address location. Retained for clients and jurisdictions where fax remains a legally recognised method of formal notice delivery under FIDIC contract conditions.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `floor_level` STRING COMMENT 'Floor or level number within a building at this address (e.g., Level 12, Ground Floor, Basement 2). Used for precise delivery instructions and visitor access coordination for client site visits.',
    `format_type` STRING COMMENT 'Indicates the structural format of the address to support correct rendering and printing. Western follows street-city-state-postal conventions; eastern follows country-specific formats (e.g., Japan, China); po_box is a post office box address; free_form is an unstructured address entry.. Valid values are `western|eastern|po_box|free_form`',
    `is_billing_address` BOOLEAN COMMENT 'Indicates whether this address is designated as the billing address for invoice delivery and accounts receivable correspondence. Used by SAP S/4HANA AR (Accounts Receivable) module for invoice routing.',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this address is the primary address for the client account. Only one address per client should be flagged as primary at any given time. Used to determine the default address for correspondence and contract documentation.',
    `is_registered_office` BOOLEAN COMMENT 'Indicates whether this address is the legally registered office address of the client entity. Required for contract execution, legal notices under FIDIC conditions, and regulatory compliance filings.',
    `jurisdiction_code` STRING COMMENT 'Legal and regulatory jurisdiction code applicable to this address, combining ISO 3166-1 country code and subdivision code (e.g., US-CA for California, AU-NSW for New South Wales). Used for tax jurisdiction mapping, OSHA/EPA regulatory compliance, and contract law determination.. Valid values are `^[A-Z]{2,3}-[A-Z0-9]{1,6}$`',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the address in decimal degrees (WGS 84 datum). Supports GIS (Geographic Information System) mapping, proximity analysis to active construction sites, and spatial analytics for project planning.',
    `line_1` STRING COMMENT 'Primary street address line including building number, street name, and suite or unit number. Represents the first line of the postal address as used in official correspondence and contract documentation.',
    `line_2` STRING COMMENT 'Secondary address line for additional location details such as floor number, building name, industrial estate, or campus identifier. Optional field used when the primary line is insufficient.',
    `line_3` STRING COMMENT 'Tertiary address line used for additional locality or district information, particularly relevant for international clients in regions where addresses require more than two street lines.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the address in decimal degrees (WGS 84 datum). Used in conjunction with latitude for GIS (Geographic Information System) spatial analysis, site proximity calculations, and mapping of client office locations.',
    `notes` STRING COMMENT 'Free-text field for additional address-related notes or delivery instructions (e.g., Security clearance required for entry, Use rear entrance, Deliveries accepted Monday-Friday only). Supports operational coordination for site visits and document deliveries.',
    `phone_number` STRING COMMENT 'Primary telephone number associated with this address location. Used for direct contact with the client office at this address for project coordination, site liaison, and contract administration purposes.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `po_box_number` STRING COMMENT 'Post Office (PO) Box number for clients who receive correspondence via a PO Box rather than a street address. Common for government agencies, public-sector clients, and clients in regions where PO Box delivery is standard.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the address. Used for mail routing, geographic clustering of clients, and regional analytics. Format varies by country (e.g., 5-digit US ZIP, alphanumeric UK postcode).',
    `preferred_correspondence_language` STRING COMMENT 'ISO 639-1 or ISO 639-2 language code indicating the preferred language for correspondence sent to this address (e.g., en for English, fr for French, ar for Arabic). Supports multilingual client communication in international construction markets.. Valid values are `^[a-z]{2,3}$`',
    `region` STRING COMMENT 'Broad geographic region grouping for the address (e.g., North America, Middle East, Asia Pacific, Europe). Used for regional portfolio reporting, business development segmentation, and PMO (Project Management Office) territory alignment. Denormalized natural-key value derivable from country_code; resolved warning.',
    `source_system_address_code` STRING COMMENT 'The native identifier of this address record in the originating operational system (e.g., Salesforce CRM Address ID, SAP S/4HANA partner address number). Used for data lineage, reconciliation, and cross-system deduplication.',
    `state_province` STRING COMMENT 'State, province, territory, or region within the country. Used for regulatory jurisdiction mapping, tax compliance, and regional reporting across multi-jurisdiction construction clients.',
    `suite_unit_number` STRING COMMENT 'Suite, unit, or office number within a building at this address. Provides the final level of address precision for multi-tenant buildings where multiple client offices may occupy the same floor.',
    `tax_jurisdiction_code` STRING COMMENT 'Specific tax jurisdiction code for the address as used in SAP S/4HANA tax determination. May differ from the general jurisdiction code in federal/state/local tax overlay scenarios. Used for sales tax, VAT, and withholding tax calculations on client invoices.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the address location (e.g., America/New_York, Asia/Dubai, Australia/Sydney). Used for scheduling client communications, meeting coordination, and project milestone notifications across global construction operations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was last modified in the data platform. Used for change detection, incremental data loading in the Databricks Lakehouse Silver Layer, and audit trail maintenance.',
    `validation_date` DATE COMMENT 'Date on which the address was last validated against a postal authority or address verification service. Used to schedule re-validation cycles and assess data quality freshness.',
    `validation_source` STRING COMMENT 'Name of the service or system used to validate the address (e.g., USPS, Google Maps API, Loqate, SmartyStreets). Provides traceability for data quality audits and vendor management.',
    `validation_status` STRING COMMENT 'Result of the address validation process against a postal authority or third-party address verification service. Validated means the address has been confirmed as deliverable; not_validated means validation has not been attempted; failed means the address could not be verified; partial means only some components were verified.. Valid values are `validated|not_validated|failed|partial`',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Physical and mailing addresses associated with client accounts, including registered office, billing address, project site liaison office, and correspondence address. Captures address type, street, city, state/province, postal code, country, GIS coordinates, and address validation status. Supports multi-jurisdiction clients operating across regions.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`client`.`segment` (
    `segment_id` BIGINT COMMENT 'Unique surrogate identifier for the client segment record in the Databricks Silver Layer. Primary key for the segment data product within the client domain.',
    `parent_segment_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent segment in a segment hierarchy (e.g., a regional sub-segment referencing a global segment). Enables hierarchical segment structures for multi-level BD reporting and account planning roll-ups.',
    `account_count_target` STRING COMMENT 'Planned number of client accounts to be assigned to this segment as part of the annual BD account planning cycle. Used to measure segment coverage and BD capacity planning in Salesforce CRM.',
    `bd_owner` STRING COMMENT 'Name or identifier of the Business Development (BD) lead or team responsible for managing accounts and opportunities within this segment. Used for accountability tracking in Salesforce CRM and BD performance reporting.',
    `bim_requirement` STRING COMMENT 'Level of Building Information Modeling (BIM) requirement typically mandated by clients in this segment. mandatory = BIM required on all projects; preferred = BIM expected but not contractually required; optional = BIM accepted if offered; not_required = no BIM expectation. Drives Autodesk BIM 360 capability positioning in bids.. Valid values are `mandatory|preferred|optional|not_required`',
    `segment_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the segment, used in Salesforce CRM pipeline filtering, account planning, and BD reporting. Serves as the business-facing identifier across systems (e.g., PUB-INFRA-APAC-T1).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports data lineage, audit trail, and segmentation history tracking.',
    `criteria_description` STRING COMMENT 'Narrative description of the specific qualification criteria used to assign accounts to this segment, including revenue thresholds, project type filters, geographic scope, and strategic fit indicators. Supports BD team alignment and CRM configuration.',
    `criteria_version` STRING COMMENT 'Version identifier of the segmentation criteria framework used to define and classify this segment (e.g., v1.0, v2.3). Enables tracking of changes to segmentation methodology over time and supports historical win-rate analysis by criteria version.. Valid values are `^vd+.d+$`',
    `crm_segment_code` STRING COMMENT 'External identifier for this segment as recorded in Salesforce CRM. Enables cross-system reconciliation between the Databricks Silver Layer and the CRM source of record for pipeline filtering and account assignment.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code representing the primary transaction currency for contracts in this segment (e.g., USD, EUR, GBP). Used for financial reporting, pipeline valuation, and cross-segment revenue comparisons.. Valid values are `^[A-Z]{3}$`',
    `delivery_model` STRING COMMENT 'Preferred project delivery model for clients in this segment, indicating how design, construction, and risk are allocated. EPC = Engineering Procurement and Construction; DB = Design-Build; DBB = Design-Bid-Build; PPP = Public-Private Partnership; BOT = Build-Operate-Transfer; JV = Joint Venture. Informs bid strategy and partner selection.. Valid values are `epc|db|dbb|ppp|bot|jv`',
    `segment_description` STRING COMMENT 'Detailed narrative describing the strategic rationale, target client profile, and BD focus for this segment. Used in account planning and BD resource allocation documentation.',
    `effective_from` DATE COMMENT 'Date from which this segment definition became active and applicable for BD targeting and CRM account assignment. Supports historical segmentation analysis and criteria version tracking.',
    `effective_until` DATE COMMENT 'Date on which this segment definition expires or is superseded by a new version. Null indicates the segment is currently open-ended and active. Supports segmentation versioning and historical win-rate analysis.',
    `esg_focus` BOOLEAN COMMENT 'Indicates whether clients in this segment place significant emphasis on Environmental, Social, and Governance (ESG) criteria in their procurement and project evaluation processes. Informs BD messaging, capability statements, and sustainability reporting alignment.',
    `geographic_region` STRING COMMENT 'Geographic market region associated with this segment (e.g., Asia Pacific, North America, Middle East & Africa). Used for regional BD pipeline filtering and account planning. Complements country-level targeting.',
    `hse_standard` STRING COMMENT 'Primary Health, Safety, and Environment (HSE) standard required by clients in this segment. Drives HSE prequalification requirements and Intelex configuration for incident reporting and audit compliance. Values: iso_45001, osha, client_specific, none.. Valid values are `iso_45001|osha|client_specific|none`',
    `is_global_segment` BOOLEAN COMMENT 'Indicates whether this segment is defined at a global level (applicable across all geographic regions) or is region-specific. Global segments are used for enterprise-wide BD strategy reporting; regional segments support local account planning.',
    `jv_partnership_typical` BOOLEAN COMMENT 'Indicates whether projects in this segment are typically pursued through Joint Venture (JV) arrangements rather than as a sole contractor. Informs BD partner strategy, JV structure planning, and bid resource allocation.',
    `last_reviewed_date` DATE COMMENT 'Date on which this segment definition was last formally reviewed and validated by the BD or PMO team. Used to enforce review frequency governance and identify stale segment definitions.',
    `leed_certification_required` BOOLEAN COMMENT 'Indicates whether clients in this segment typically require LEED (Leadership in Energy and Environmental Design) certification on their projects. Drives capability positioning, bid qualification, and sustainability resource planning for BD targeting.',
    `segment_name` STRING COMMENT 'Human-readable name of the client segment used in CRM dashboards, BD strategy documents, and account planning reports (e.g., Public Infrastructure – Asia Pacific – Key Account).',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this segment definition. Derived from last_reviewed_date and review_frequency but stored explicitly to support CRM workflow triggers and governance reporting.',
    `prequalification_required` BOOLEAN COMMENT 'Indicates whether clients in this segment require formal contractor prequalification before issuing a Request for Proposal (RFP) or Request for Quotation (RFQ). Drives BD qualification workflow and Salesforce CRM opportunity stage configuration.',
    `primary_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code representing the primary target country for this segment (e.g., USA, GBR, AUS). Used for regulatory alignment and geographic BD targeting.. Valid values are `^[A-Z]{3}$`',
    `procurement_category` STRING COMMENT 'Dominant procurement and contract delivery model used by clients in this segment. Values: EPC (Engineering, Procurement and Construction), DB (Design-Build), DBB (Design-Bid-Build), GMP (Guaranteed Maximum Price), PPP/BOT (Public-Private Partnership/Build-Operate-Transfer), NEC4, JCT, FIDIC. Drives contract strategy and BD approach. [ENUM-REF-CANDIDATE: epc|db|dbb|gmp|ppp_bot|nec4|jct|fidic — promote to reference product]',
    `quality_standard` STRING COMMENT 'Primary quality management standard required by clients in this segment for project delivery and QA/QC compliance. Drives Inspection and Test Plan (ITP) and Non-Conformance Report (NCR) requirements. Values: iso_9001, client_specific, none.. Valid values are `iso_9001|client_specific|none`',
    `regulatory_framework` STRING COMMENT 'Primary regulatory or standards framework governing procurement and project delivery for clients in this segment (e.g., FIDIC Red Book, NEC4 ECC, JCT Design and Build, FAR/DFARS for US federal). Informs contract administration approach and compliance requirements.',
    `revenue_band_max_usd` DECIMAL(18,2) COMMENT 'Maximum annual revenue threshold (in USD) defining the upper bound of the target client revenue band for this segment. A null value indicates an open-ended upper bound (e.g., mega-clients). Used alongside revenue_band_min_usd for client qualification.',
    `revenue_band_min_usd` DECIMAL(18,2) COMMENT 'Minimum annual revenue threshold (in USD) defining the lower bound of the target client revenue band for this segment. Used for client qualification and BD targeting criteria. Expressed in USD for cross-regional comparability.',
    `review_frequency` STRING COMMENT 'Frequency at which this segment definition and its assigned accounts are reviewed and updated by the BD and PMO teams. Drives CRM workflow scheduling and segmentation governance cadence.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `sector` STRING COMMENT 'High-level ownership and funding sector of the client segment. public covers government and state-owned entities; private covers privately-funded developers and corporations; ppp_bot covers Public-Private Partnership (PPP) and Build-Operate-Transfer (BOT) arrangements. Aligned with FIDIC and NEC4 procurement categories.. Valid values are `public|private|ppp_bot`',
    `segment_status` STRING COMMENT 'Current lifecycle status of the segment definition. active = currently used for BD targeting and CRM filtering; inactive = no longer targeted; under_review = pending re-classification; archived = retired segment retained for historical reporting.. Valid values are `active|inactive|under_review|archived`',
    `strategic_tier` STRING COMMENT 'BD prioritization tier assigned to this segment indicating the level of strategic investment and relationship management effort. key_account = highest-priority clients with dedicated BD resources; growth = high-potential targets; standard = routine pipeline; dormant = inactive or deprioritized. Drives CRM pipeline weighting and BD resource allocation.. Valid values are `key_account|growth|standard|dormant`',
    `sub_sector` STRING COMMENT 'Detailed market sub-sector classification within the parent sector. Drives BD resource allocation and win-rate analysis by market vertical. Values: infrastructure (highways, airports, bridges), energy (power plants, renewables), commercial (offices, retail), residential (housing developments), industrial (factories, warehouses).. Valid values are `infrastructure|energy|commercial|residential|industrial`',
    `target_pipeline_value_usd` DECIMAL(18,2) COMMENT 'Annual BD pipeline value target (in USD) for this segment, set during strategic planning cycles. Used to measure pipeline coverage ratio and BD resource adequacy. Supports Salesforce CRM pipeline forecasting and PMO reporting.',
    `target_win_rate_pct` DECIMAL(18,2) COMMENT 'Strategically defined target bid win rate (as a percentage, 0.00–100.00) for this segment, set during annual BD planning. Used as a benchmark for measuring BD performance and CRM pipeline health against actual win rates by segment.',
    `typical_contract_duration_months` STRING COMMENT 'Average or typical project/contract duration in months for engagements within this segment. Used in resource planning, scheduling baseline development in Oracle Primavera P6, and BD pipeline timing analysis.',
    `typical_project_value_max_usd` DECIMAL(18,2) COMMENT 'Maximum typical contract or project value (in USD) expected from clients in this segment. A null value indicates no upper cap (e.g., mega-infrastructure programs). Used in BD resource sizing and pipeline forecasting.',
    `typical_project_value_min_usd` DECIMAL(18,2) COMMENT 'Minimum typical contract or project value (in USD) expected from clients in this segment. Used in bid/no-bid decision frameworks and BD pipeline prioritization. Reflects the lower bound of the Bill of Quantities (BOQ) range for this market.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment record was last modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change detection, incremental data loads in the Databricks Silver Layer, and audit compliance.',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Client segmentation classification defining market categories for strategic targeting, pipeline prioritization, and BD resource allocation. Captures segment name, sector (public, private, PPP/BOT), sub-sector (infrastructure, energy, commercial, residential, industrial), geographic region, revenue band, strategic tier (key account, growth, standard, dormant), and segmentation criteria version. Accounts are assigned to segments via a direct FK on the account record. Enables targeted BD strategies, CRM pipeline filtering, account planning by sector and tier, and win-rate analysis by market segment. Aligned with FIDIC, NEC4, and JCT procurement categories.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`client`.`opportunity` (
    `opportunity_id` BIGINT COMMENT 'Unique surrogate identifier for the client opportunity record in the Databricks Silver Layer. Primary key for the client_opportunity data product.',
    `account_id` BIGINT COMMENT 'Reference to the client account (project owner, developer, or sponsor) associated with this opportunity. Maps to the Salesforce CRM Account object.',
    `actual_award_date` DATE COMMENT 'Date on which the contract was formally awarded. Populated upon win outcome. Used for win/loss analysis and BD cycle time measurement.',
    `bid_cost_estimate` DECIMAL(18,2) COMMENT 'Internal estimate of the cost to prepare and submit the bid (tendering cost), including estimating, engineering, and proposal resources. Used for bid cost tracking and ROI analysis on BD spend.',
    `bid_no_bid_decision` STRING COMMENT 'Formal decision outcome from the bid/no-bid review process indicating whether the company will pursue this opportunity. Pending_review indicates the decision gate has not yet been completed.. Valid values are `bid|no_bid|pending_review`',
    `bid_no_bid_decision_date` DATE COMMENT 'Date on which the formal bid/no-bid decision was made and recorded. Used for governance audit trails and BD cycle time analysis.',
    `bid_submission_date` DATE COMMENT 'Actual or planned date on which the bid/tender/proposal was or is to be submitted to the client. Critical scheduling milestone for BD and estimating teams.',
    `bim_required` BOOLEAN COMMENT 'Indicates whether the client mandates Building Information Modeling (BIM) as a project delivery requirement. True = BIM is contractually required. Drives technology and resource planning for the bid.',
    `boq_available` BOOLEAN COMMENT 'Indicates whether a Bill of Quantities (BOQ) has been issued by the client as part of the tender package. True = BOQ provided; False = lump-sum or design-build without BOQ. Affects estimating approach and bid strategy.',
    `client_opportunity_description` STRING COMMENT 'Free-text narrative describing the scope, nature, and key characteristics of the construction opportunity. Provides context for BD team members reviewing the pipeline and supports AI/ML-based opportunity classification.',
    `competitor_names` STRING COMMENT 'Names of known competing firms bidding on the same opportunity. Free-text or comma-separated list. Confidential competitive intelligence used for bid strategy and market positioning analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the opportunity record was first created in the source CRM system. Represents the business event of opportunity identification and entry into the BD pipeline. Used for pipeline age and BD cycle time analytics.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the estimated contract value and weighted pipeline value (e.g., USD, EUR, AED, GBP). Required for multi-currency pipeline consolidation.. Valid values are `^[A-Z]{3}$`',
    `delivery_model` STRING COMMENT 'Contract delivery model under which the construction project will be executed. EPC = Engineering Procurement and Construction; GMP = Guaranteed Maximum Price; DBB = Design-Bid-Build; DB = Design-Build; PPP = Public-Private Partnership; BOT = Build-Operate-Transfer; FIDIC = FIDIC-based contract. Drives risk allocation and commercial strategy. [ENUM-REF-CANDIDATE: EPC|GMP|DBB|DB|PPP|BOT|FIDIC — 7 candidates stripped; promote to reference product]',
    `esg_requirements` STRING COMMENT 'Description of any Environmental, Social, and Governance (ESG) requirements specified by the client for this opportunity (e.g., carbon targets, local content requirements, diversity commitments). Free-text field for BD qualification notes.',
    `estimated_contract_value` DECIMAL(18,2) COMMENT 'Estimated total contract value of the opportunity in the reporting currency. Used for pipeline forecasting, revenue planning, and bid/no-bid decision thresholds. Raw commercial estimate; not a committed figure.',
    `expected_award_date` DATE COMMENT 'Anticipated date on which the contract is expected to be formally awarded to the company. Used for pipeline close-date forecasting and resource mobilization planning.',
    `expected_ntp_date` DATE COMMENT 'Anticipated date on which the client will issue the Notice to Proceed (NTP), authorizing the start of construction work. Used for resource planning and revenue recognition scheduling.',
    `is_jv_bid` BOOLEAN COMMENT 'Indicates whether this opportunity is being pursued as a Joint Venture (JV) arrangement. True = JV bid; False = sole-entity bid. Drives JV governance and risk review processes.',
    `jv_partner_names` STRING COMMENT 'Names of Joint Venture (JV) partners with whom the company intends to bid on this opportunity. Relevant for JV-structured bids common in large infrastructure and EPC projects. Confidential commercial information.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the opportunity record in the source CRM system. Used for change tracking, data freshness monitoring, and incremental pipeline loads.',
    `leed_certification_required` BOOLEAN COMMENT 'Indicates whether the client requires LEED (Leadership in Energy and Environmental Design) certification for the project. True = LEED certification is a contract requirement. Drives sustainability planning and cost estimation.',
    `loss_reason` STRING COMMENT 'Reason code or description explaining why the opportunity was lost or withdrawn (e.g., price, technical score, client relationship, competitor strength, scope mismatch). Populated when win_loss_outcome is lost or withdrawn. Used for BD lessons-learned and competitive intelligence. [ENUM-REF-CANDIDATE: price|technical_score|client_relationship|competitor_strength|scope_mismatch|capacity|no_bid_decision|other — promote to reference product]',
    `opportunity_name` STRING COMMENT 'Descriptive name of the construction opportunity, typically including the project name and client name (e.g., Greenfield Highway Extension – ADOT). Used for identification in pipeline reports and BD dashboards.',
    `next_action` STRING COMMENT 'Description of the next planned business development action required to advance this opportunity (e.g., Submit EOI by 15-Mar, Attend client briefing, Complete bid/no-bid review). Operational field used by BD team for pipeline management.',
    `next_action_due_date` DATE COMMENT 'Target date by which the next business development action must be completed. Used for BD pipeline hygiene, follow-up scheduling, and opportunity stagnation alerts.',
    `opportunity_number` STRING COMMENT 'Externally-known unique alphanumeric identifier for the opportunity as assigned in Salesforce CRM. Used for cross-system reference and client-facing communications.. Valid values are `^OPP-[0-9]{4}-[0-9]{6}$`',
    `opportunity_status` STRING COMMENT 'Lifecycle status of the opportunity record indicating whether it is actively pursued, won, lost, on hold, or cancelled. Distinct from pipeline_stage which tracks the BD workflow step.. Valid values are `open|closed_won|closed_lost|on_hold|cancelled`',
    `pipeline_stage` STRING COMMENT 'Current stage of the opportunity in the business development pipeline. Drives pipeline forecasting and BD reporting. [ENUM-REF-CANDIDATE: prospect|qualification|bid_preparation|submitted|negotiation|awarded|lost|no_bid — promote to reference product]',
    `prequalification_status` STRING COMMENT 'Status of the companys prequalification with the client for this opportunity. Many public-sector and large private clients require formal prequalification before bid submission. Drives eligibility gating in the BD pipeline.. Valid values are `not_required|pending|approved|rejected`',
    `probability_of_win_pct` DECIMAL(18,2) COMMENT 'Estimated probability (0–100%) that the company will be awarded this contract. Used to calculate weighted pipeline value for revenue forecasting. Assigned by the BD owner and reviewed at stage gates.',
    `project_duration_months` STRING COMMENT 'Estimated duration of the construction project in months from NTP to practical completion. Used for resource planning, revenue phasing, and schedule risk assessment.',
    `project_location_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the construction project will be executed (e.g., USA, ARE, GBR). Used for geographic pipeline analysis and regulatory compliance scoping.. Valid values are `^[A-Z]{3}$`',
    `project_location_region` STRING COMMENT 'State, province, or region where the construction project will be executed. Used for regional pipeline reporting, resource planning, and jurisdictional compliance (e.g., OSHA state plans, local building codes).',
    `project_type` STRING COMMENT 'Classification of the construction project type (e.g., highway, airport, bridge, power plant, residential, commercial, industrial). Used for market segmentation and capability matching. [ENUM-REF-CANDIDATE: highway|airport|bridge|power_plant|residential|commercial|industrial|water_treatment|rail|data_center — promote to reference product]',
    `rfp_issue_date` DATE COMMENT 'Date on which the client issued the Request for Proposal (RFP) or Invitation to Tender (ITT). Marks the formal start of the bid preparation phase.',
    `rfq_number` STRING COMMENT 'Client-issued Request for Quotation (RFQ) or Request for Proposal (RFP) reference number. Used for cross-referencing with client procurement documents and Aconex correspondence.',
    `sector` STRING COMMENT 'Sector classification of the client commissioning the work: public-sector (government/municipal), private-sector (developer/corporate), or PPP/BOT (public-private partnership or build-operate-transfer arrangement). Used for client segmentation and reporting.. Valid values are `public|private|ppp_bot`',
    `source_crm_opportunity_code` STRING COMMENT 'Original opportunity identifier from the Salesforce CRM system of record. Used for data lineage, cross-system reconciliation, and traceability back to the operational source.',
    `strategic_priority` STRING COMMENT 'Internal strategic priority classification assigned to this opportunity by BD leadership. Tier 1 = highest strategic importance (must-win); Tier 2 = important but not critical; Tier 3 = opportunistic. Drives resource allocation for bid preparation.. Valid values are `tier_1|tier_2|tier_3`',
    `weighted_pipeline_value` DECIMAL(18,2) COMMENT 'Estimated contract value multiplied by the probability of win percentage, representing the risk-adjusted contribution of this opportunity to the revenue forecast. Key metric for executive pipeline reporting.',
    `win_loss_outcome` STRING COMMENT 'Final outcome of the opportunity after the bid process concludes. Won = contract awarded to company; Lost = awarded to competitor; Withdrawn = company withdrew bid; No_award = client cancelled procurement. Drives win rate analytics and BD performance reporting.. Valid values are `won|lost|withdrawn|no_award`',
    CONSTRAINT pk_opportunity PRIMARY KEY(`opportunity_id`)
) COMMENT 'Pre-award commercial opportunity record tracking potential construction projects in the BD pipeline. Captures opportunity name, client account, project type, estimated contract value, delivery model (EPC, GMP, DBB, PPP), bid/no-bid decision, probability of win, expected NTP date, pipeline stage, BD owner, and win/loss outcome. Sourced from Salesforce CRM Opportunity object. SSOT for pipeline forecasting.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`client`.`prequalification` (
    `prequalification_id` BIGINT COMMENT 'Unique surrogate identifier for each client prequalification record in the Databricks Silver Layer. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Reference to the client/owner organization that issued this prequalification assessment. Links to the master client account record.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: client_prequalification carries client_contact_name (STRING) and client_contact_email (STRING) as denormalized contact data. The contact table is the SSOT for individual stakeholder contacts. Adding c',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to client.client_opportunity. Business justification: A prequalification assessment is typically initiated in the context of a specific commercial opportunity in the BD pipeline. Linking client_prequalification to the originating client_opportunity enabl',
    `approval_date` DATE COMMENT 'The date on which the client organization formally approved or conditionally approved the prequalification. Null if not yet approved or if rejected.',
    `approving_authority` STRING COMMENT 'Name or designation of the client-side authority (individual, committee, or department) that reviewed and approved or rejected the prequalification submission.',
    `condition_resolution_date` DATE COMMENT 'The date by which all imposed conditions must be resolved or evidenced to the client to convert a conditional approval to full approval.',
    `conditions_imposed` STRING COMMENT 'Free-text description of any conditions, restrictions, or requirements imposed by the client as part of a conditional prequalification approval. Null if unconditionally approved.',
    `contract_delivery_method` STRING COMMENT 'The project delivery method for which this prequalification applies: Engineering Procurement and Construction (EPC), Design-Build (DB), Design-Bid-Build (DBB), Guaranteed Maximum Price (GMP), Build-Operate-Transfer (BOT), or Public-Private Partnership (PPP).. Valid values are `epc|db|dbb|gmp|bot|ppp`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the primary jurisdiction in which this prequalification is applicable.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this prequalification record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the maximum project value and any financial thresholds in this prequalification record (e.g., USD, EUR, GBP, AED).. Valid values are `^[A-Z]{3}$`',
    `document_reference` STRING COMMENT 'Reference number or identifier for the prequalification submission document package as stored in the document management system (e.g., Aconex transmittal number or document register ID).',
    `effective_from_date` DATE COMMENT 'The date from which the prequalification becomes valid and the firm is eligible to bid on work from this client in the specified category.',
    `environmental_certification_required` BOOLEAN COMMENT 'Indicates whether the client requires ISO 14001 or equivalent environmental management certification as part of the prequalification criteria.',
    `expiry_date` DATE COMMENT 'The date on which the prequalification ceases to be valid. After this date, the firm is no longer eligible to bid unless renewed. Critical for bid eligibility tracking.',
    `financial_audit_required` BOOLEAN COMMENT 'Indicates whether the client requires submission of audited financial statements as part of the prequalification documentation package.',
    `geographic_scope` STRING COMMENT 'The geographic region, country, or territory for which this prequalification is valid. Prequalification may be limited to specific jurisdictions or project locations.',
    `hse_certification_required` BOOLEAN COMMENT 'Indicates whether the client requires valid HSE certifications (e.g., ISO 45001, OSHA compliance) as a mandatory condition of prequalification in this category.',
    `insurance_verification_required` BOOLEAN COMMENT 'Indicates whether the client requires proof of adequate insurance coverage (professional indemnity, public liability, workers compensation) as a prequalification condition.',
    `leed_certification_required` BOOLEAN COMMENT 'Indicates whether the client requires LEED certification or demonstrated LEED project experience as a prequalification criterion for sustainable construction projects.',
    `max_project_value` DECIMAL(18,2) COMMENT 'The maximum single-project contract value (in the specified currency) for which the firm is prequalified by this client. Bids exceeding this threshold require separate approval or re-prequalification.',
    `minimum_passing_score` DECIMAL(18,2) COMMENT 'The minimum score threshold set by the client that the construction firm must achieve to receive an approved prequalification status in this category.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, internal observations, or strategic notes related to this prequalification record. Confidential as it may contain competitive intelligence.',
    `prequalification_number` STRING COMMENT 'Externally-known unique reference number assigned by the client organization to this prequalification submission. Used in all correspondence and bid eligibility checks.. Valid values are `^PREQ-[A-Z0-9]{4,20}$`',
    `prequalification_status` STRING COMMENT 'Current lifecycle state of the prequalification record. Determines bid eligibility — only approved or conditional statuses permit the firm to submit bids for the client in the relevant category. [ENUM-REF-CANDIDATE: approved|conditional|rejected|expired|pending|withdrawn — promote to reference product]. Valid values are `approved|conditional|rejected|expired|pending|withdrawn`',
    `procurement_category` STRING COMMENT 'Classification of the client procurement arrangement type: public sector, private sector, Public-Private Partnership (PPP), Build-Operate-Transfer (BOT), or Joint Venture (JV). Drives compliance and reporting requirements.. Valid values are `public_sector|private_sector|ppp|bot|jv`',
    `quality_certification_required` BOOLEAN COMMENT 'Indicates whether the client mandates a valid ISO 9001 or equivalent quality management system certification as a prequalification requirement.',
    `reference_projects_required` STRING COMMENT 'Minimum number of comparable completed projects the client requires the firm to demonstrate as part of the prequalification submission.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the client for rejecting the prequalification submission. Populated only when prequalification_status is rejected. Used for gap analysis and resubmission planning.',
    `renewal_actions_required` STRING COMMENT 'Free-text description of specific actions, documentation updates, or re-submissions required by the client to successfully renew this prequalification.',
    `renewal_due_date` DATE COMMENT 'The date by which the firm must initiate the renewal process to maintain uninterrupted prequalification status. Typically set before the expiry date to allow processing time.',
    `renewal_period_months` STRING COMMENT 'The duration in months of each prequalification validity period before renewal is required. Typically 12, 24, or 36 months depending on client policy.',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether this prequalification requires periodic renewal to remain valid, as opposed to a one-time permanent approval.',
    `rfp_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the firm is currently eligible to receive and respond to RFPs from this client in the specified work category, based on active prequalification status.',
    `rfq_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the firm is currently eligible to receive and respond to RFQs from this client in the specified work category, based on active prequalification status.',
    `score` DECIMAL(18,2) COMMENT 'Numeric score assigned by the client during the prequalification evaluation, typically on a 0–100 scale. Used to rank and compare contractors. Confidential as it reflects competitive assessment.',
    `submission_date` DATE COMMENT 'The date on which the construction firm formally submitted its prequalification documentation package to the client organization.',
    `submitted_trir` DECIMAL(18,2) COMMENT 'The firms actual TRIR value submitted as part of the prequalification documentation, typically based on the most recent 12-month or 3-year rolling average.',
    `trir_threshold` DECIMAL(18,2) COMMENT 'The maximum Total Recordable Incident Rate (TRIR) the client permits for prequalification. If the firms TRIR exceeds this value, prequalification may be denied or revoked.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this prequalification record was last modified. Used for change tracking, audit trail, and Silver Layer incremental processing.',
    `work_category` STRING COMMENT 'The construction discipline or scope category for which prequalification has been assessed (e.g., civil, MEP, EPC, marine, tunneling, structural, roads, bridges). Determines which types of RFPs/RFQs the firm is eligible to bid on. [ENUM-REF-CANDIDATE: civil|mep|epc|marine|tunneling|structural|roads|bridges|power|rail — promote to reference product]',
    `years_experience_required` STRING COMMENT 'Minimum number of years of relevant construction experience in the specified work category that the client requires for prequalification.',
    CONSTRAINT pk_prequalification PRIMARY KEY(`prequalification_id`)
) COMMENT 'Records prequalification and due diligence assessments that client organizations apply to the construction firm before issuing RFPs or RFQs. Captures prequalification reference number, client account, category (civil, MEP, EPC, marine, tunneling), submission date, expiry date, status (approved, conditional, rejected, expired), conditions imposed, approving authority, and required renewal actions. Critical for bid eligibility tracking — the firm cannot bid on work from a client without active prequalification in the relevant category. [SSOT: distinct source of truth for client domain]';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`client`.`rfp_issuance` (
    `rfp_issuance_id` BIGINT COMMENT 'Unique surrogate identifier for each RFP/RFQ/ITT issuance record in the system. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Reference to the client/owner account that issued this solicitation. Links to the master client account record in the CRM. Sourced from Salesforce CRM Account Management.',
    `opportunity_id` BIGINT COMMENT 'Reference to the linked sales opportunity in the CRM pipeline that this RFP issuance is associated with. Enables traceability from solicitation to bid pursuit. Sourced from Salesforce CRM Opportunity Tracking.',
    `prequalification_id` BIGINT COMMENT 'Foreign key linking to client.client_prequalification. Business justification: In construction procurement, an RFP/ITT is only issued to contractors who have passed a prequalification assessment. Linking rfp_issuance to the specific client_prequalification record that governs el',
    `addendum_count` STRING COMMENT 'The total number of addenda (amendments) issued by the client against this RFP since original issuance. Each addendum modifies the original RFP terms, scope, or schedule. Used to track document version history.',
    `anticipated_award_date` DATE COMMENT 'The clients indicative target date for issuing the Notice to Proceed (NTP) or contract award, as stated in the RFP. Used for resource planning, bid team scheduling, and pipeline forecasting in Salesforce CRM.',
    `anticipated_completion_date` DATE COMMENT 'The clients required or indicative project completion date as stated in the RFP. Defines the overall programme duration and is a key input to CPM (Critical Path Method) scheduling and resource planning.',
    `anticipated_start_date` DATE COMMENT 'The clients indicative target date for project commencement (Notice to Proceed / NTP) as stated in the RFP. Used for resource mobilisation planning and schedule baseline development in Oracle Primavera P6.',
    `bid_bond_percentage` DECIMAL(18,2) COMMENT 'The bid bond (tender guarantee) value expressed as a percentage of the estimated contract value, as required by the client in the RFP. Typically ranges from 1% to 5% of contract value. Null if bid bond is not required.',
    `bid_bond_required` BOOLEAN COMMENT 'Indicates whether the client requires a bid bond (tender guarantee) to be submitted with the proposal (True) or not (False). Bid bonds protect the client against bidder withdrawal after award.',
    `bid_validity_days` STRING COMMENT 'The number of calendar days from the submission deadline during which the bidders proposal must remain valid and binding, as specified in the RFP. Typically 60 to 180 days. Impacts financial exposure and resource commitment.',
    `bim_level` STRING COMMENT 'The BIM maturity level required by the client in the RFP: level_1 (CAD-based), level_2 (collaborative BIM with federated models), or level_3 (fully integrated open BIM). Null if BIM is not required.. Valid values are `level_1|level_2|level_3`',
    `bim_required` BOOLEAN COMMENT 'Indicates whether the client mandates the use of BIM (Building Information Modeling) for design and construction delivery as specified in the RFP (True) or not (False). Impacts technology requirements and Autodesk BIM 360 platform usage.',
    `client_sector` STRING COMMENT 'Classification of the client/owner by sector: public (government/public authority), private (private developer/corporation), ppp (Public-Private Partnership arrangement), or jv (Joint Venture client entity). Drives compliance, reporting, and bid strategy.. Valid values are `public|private|ppp|jv`',
    `commercial_score_weight` DECIMAL(18,2) COMMENT 'The percentage weighting assigned to the commercial/price component of the bid evaluation, as specified in the RFP (e.g., 40.00 for 40%). Combined with technical_score_weight to total 100%. Null for quality-only evaluations.',
    `contract_type` STRING COMMENT 'The pricing and risk-sharing mechanism for the contract as specified in the RFP: lump_sum (fixed price), unit_rate (BOQ-based), cost_plus (reimbursable), target_cost (incentivised), or framework (call-off arrangement). Directly influences bid strategy and cost estimation.. Valid values are `lump_sum|unit_rate|cost_plus|target_cost|framework`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the country where the project is located (e.g., USA, GBR, AUS). Used for regulatory compliance, currency, and jurisdictional reporting.. Valid values are `^[A-Z]{3}$`',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the contract value and financial terms stated in the RFP (e.g., USD, GBP, EUR, AUD). Required for multi-currency financial reporting and IFRS/GAAP compliance.. Valid values are `^[A-Z]{3}$`',
    `defects_liability_period_days` STRING COMMENT 'The duration of the Defects Liability Period (DLP) in calendar days as specified in the RFP, commencing from the date of practical completion. Typically 365 or 730 days. Impacts warranty provisioning and post-completion resource planning.',
    `delivery_model` STRING COMMENT 'The contractual delivery model specified in the RFP: DBB (Design-Bid-Build), DB (Design-Build), EPC (Engineering Procurement and Construction), GMP (Guaranteed Maximum Price), PPP (Public-Private Partnership), BOT (Build-Operate-Transfer), EPCM (Engineering Procurement Construction Management), or CM (Construction Management). Determines risk allocation and bid structure. [ENUM-REF-CANDIDATE: DBB|DB|EPC|GMP|PPP|BOT|EPCM|CM — promote to reference product]',
    `estimated_contract_value` DECIMAL(18,2) COMMENT 'Clients published or internally estimated value of the contract in the nominated currency. Used for bid/no-bid decision-making, bonding requirements, and pipeline forecasting. May be client-disclosed or internally estimated.',
    `evaluation_criteria` STRING COMMENT 'The overall evaluation methodology specified in the RFP for assessing and ranking bids: price_only (lowest price wins), price_quality (weighted price and technical), quality_only (technical merit), best_value (whole-life cost), or pass_fail (compliance-based). Drives bid strategy.. Valid values are `price_only|price_quality|quality_only|best_value|pass_fail`',
    `issue_date` DATE COMMENT 'The date on which the RFP/RFQ/ITT was formally issued and released to prospective bidders by the client. Represents the principal business event date for this solicitation record.',
    `issued_timestamp` TIMESTAMP COMMENT 'The system timestamp when this RFP issuance record was first created in the data platform. Represents the audit creation time, distinct from the business issue_date. Used for data lineage and audit trail.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The system timestamp of the most recent modification to this RFP issuance record. Used for change tracking, data synchronisation, and audit trail compliance.',
    `latest_addendum_date` DATE COMMENT 'The date of the most recent addendum issued by the client against this RFP. Null if no addenda have been issued. Used to ensure bidders are working from the latest version of the solicitation document.',
    `leed_certification_level` STRING COMMENT 'The minimum LEED certification level required by the client as stated in the RFP: certified, silver, gold, or platinum. Null if LEED certification is not required.. Valid values are `certified|silver|gold|platinum`',
    `leed_certification_required` BOOLEAN COMMENT 'Indicates whether the client has specified a LEED (Leadership in Energy and Environmental Design) certification requirement for the project in the RFP (True) or not (False). Impacts design, materials, and cost estimation.',
    `liquidated_damages_applicable` BOOLEAN COMMENT 'Indicates whether the RFP specifies that Liquidated Damages (LD) will apply for delays or non-performance (True) or not (False). LD clauses are a key risk factor in bid pricing and schedule planning.',
    `liquidated_damages_rate` DECIMAL(18,2) COMMENT 'The daily Liquidated Damages (LD) rate specified in the RFP, expressed in the contract currency. Applied for each calendar day of delay beyond the contractual completion date. Null if LD is not applicable.',
    `local_content_requirement_pct` DECIMAL(18,2) COMMENT 'Minimum percentage of local workforce, materials, or subcontractors required by the client as specified in the RFP. Common in public-sector and government-funded projects. Impacts procurement and subcontractor strategy.',
    `performance_bond_percentage` DECIMAL(18,2) COMMENT 'The performance bond value expressed as a percentage of the contract value, as specified in the RFP. Typically ranges from 5% to 10% of contract value. Null if performance bond is not required.',
    `performance_bond_required` BOOLEAN COMMENT 'Indicates whether the client requires a performance bond to be provided upon contract award (True) or not (False). Performance bonds guarantee the contractor will fulfil contractual obligations.',
    `pre_bid_meeting_date` TIMESTAMP COMMENT 'Scheduled date and time of the mandatory or optional pre-bid conference/site visit where the client clarifies scope and answers bidder questions. Attendance may be a prerequisite for bid eligibility.',
    `pre_bid_meeting_mandatory` BOOLEAN COMMENT 'Indicates whether attendance at the pre-bid meeting is mandatory for bid eligibility (True) or optional (False). Mandatory attendance is a common client requirement for complex infrastructure projects.',
    `project_description` STRING COMMENT 'Detailed narrative description of the project scope, works, and deliverables as outlined in the RFP. Includes key scope elements such as civil works, MEP systems, infrastructure type, and geographic extent.',
    `project_sector` STRING COMMENT 'The industry sector classification of the project as described in the RFP. Used for market segmentation, capability matching, and portfolio analytics. [ENUM-REF-CANDIDATE: infrastructure|energy|commercial|residential|industrial|transport|water|healthcare|education|defence — promote to reference product]',
    `project_title` STRING COMMENT 'The official name or title of the project as stated in the RFP document. Provides the primary human-readable description of the work being solicited (e.g., Highway 45 Expansion Phase 2, Airport Terminal C Construction).',
    `rfp_document_reference` STRING COMMENT 'The document control reference number or URL/path to the official RFP package in the document management system (Aconex or Autodesk BIM 360). Enables direct retrieval of the source solicitation document.',
    `rfp_number` STRING COMMENT 'Externally-known reference number assigned by the client to uniquely identify this solicitation document (RFP, RFQ, or ITT). Used in all correspondence and bid submissions. Sourced from Salesforce CRM Bid Management or Aconex Document Management.. Valid values are `^[A-Z0-9-/]{3,50}$`',
    `rfp_status` STRING COMMENT 'Current lifecycle status of the RFP issuance: draft (being prepared), issued (released to market), amended (addendum issued), closed (submission deadline passed), cancelled (withdrawn by client), or awarded (contract awarded). Drives workflow and reporting.. Valid values are `draft|issued|amended|closed|cancelled|awarded`',
    `solicitation_type` STRING COMMENT 'Classification of the solicitation document type: RFP (Request for Proposal), RFQ (Request for Quotation), ITT (Invitation to Tender), EOI (Expression of Interest), or RFI (Request for Information). Determines the formality and evaluation process applied.. Valid values are `RFP|RFQ|ITT|EOI|RFI`',
    `submission_deadline` TIMESTAMP COMMENT 'The exact date and time by which all bid/proposal submissions must be received by the client. Late submissions are typically disqualified. Critical for bid planning and scheduling in Oracle Primavera P6.',
    `technical_score_weight` DECIMAL(18,2) COMMENT 'The percentage weighting assigned to the technical/quality component of the bid evaluation, as specified in the RFP (e.g., 60.00 for 60%). Combined with commercial_score_weight to total 100%. Null for price-only evaluations.',
    CONSTRAINT pk_rfp_issuance PRIMARY KEY(`rfp_issuance_id`)
) COMMENT 'Records RFP (Request for Proposal), RFQ (Request for Quotation), and ITT (Invitation to Tender) documents issued by clients, initiating the formal bid process. Captures RFP reference number, client account, project description, issue date, submission deadline, bond requirements (bid bond, performance bond), evaluation criteria weights, delivery model, pre-bid meeting dates, and linked opportunity. This is the client-side solicitation record; the firms response is managed in the bid domain.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`client`.`master_services_agreement` (
    `master_services_agreement_id` BIGINT COMMENT 'Unique surrogate identifier for the framework agreement record in the lakehouse silver layer. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the client account (project owner, developer, or public-sector body) that is party to this framework agreement. Links to the client master product.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: master_services_agreement.client_contact_name is a STRING denormalization of the client-side contact responsible for the MSA. The contact table is the SSOT for individual stakeholder contacts. Adding ',
    `opportunity_id` BIGINT COMMENT 'Reference to the originating opportunity record in Salesforce CRM from which this framework agreement was won. Enables traceability from bid pipeline to executed agreement for win-rate and revenue analytics.',
    `parent_agreement_client_framework_agreement_master_services_agreement_id` BIGINT COMMENT 'Self-referencing identifier linking a call-off contract or lot-level agreement to its parent framework agreement. Supports hierarchical agreement structures where individual call-offs are children of a master framework.',
    `site_id` BIGINT COMMENT 'Foreign key linking to site.site. Business justification: MSAs in construction are frequently scoped to specific project sites or geographic locations. Linking MSA to site enables site-level contract coverage reporting, ensuring the correct framework agreeme',
    `agreement_number` STRING COMMENT 'Externally-known unique reference number assigned to the framework agreement, used in correspondence, call-off orders, and contract administration. Typically issued by the client or procurement authority (e.g., FA-2024-HWY-001).. Valid values are `^[A-Z0-9-]{3,30}$`',
    `agreement_type` STRING COMMENT 'Classification of the long-term agreement structure. framework = competitive framework with multiple call-offs; master_service_agreement (MSA) = pre-agreed terms for repeat services; term_contract = fixed-duration works contract; blanket_order = open purchase order for repeat supply; call_off_contract = individual release under a parent framework.. Valid values are `framework|master_service_agreement|term_contract|blanket_order|call_off_contract`',
    `ceiling_value` DECIMAL(18,2) COMMENT 'Maximum total monetary value of all call-off orders that may be placed under this framework agreement over its full term. Acts as the Guaranteed Maximum Price (GMP) envelope for the framework. Expressed in the agreement currency.',
    `client_framework_agreement_status` STRING COMMENT 'Current lifecycle state of the framework agreement. draft = being negotiated; active = in force and accepting call-offs; suspended = temporarily halted; expired = past expiry date with no renewal; terminated = ended early; under_renewal = renewal process initiated.. Valid values are `draft|active|suspended|expired|terminated|under_renewal`',
    `committed_value` DECIMAL(18,2) COMMENT 'Total value of all call-off orders formally issued against this framework agreement to date. Used to track utilisation against the ceiling value and support financial forecasting.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the primary jurisdiction in which the framework agreement is executed and governed (e.g., GBR, USA, ARE).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the framework agreement record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the ceiling value, call-off values, and rates are denominated (e.g., USD, GBP, EUR, AED).. Valid values are `^[A-Z]{3}$`',
    `delivery_model` STRING COMMENT 'Contractual delivery model governing how works are executed under the framework. EPC = Engineering Procurement and Construction; DB = Design-Build; DBB = Design-Bid-Build; PPP = Public-Private Partnership; BOT = Build-Operate-Transfer; MSA = Master Service Agreement; term_maintenance = ongoing maintenance term. [ENUM-REF-CANDIDATE: EPC|DB|DBB|PPP|BOT|MSA|term_maintenance — 7 candidates stripped; promote to reference product]',
    `dispute_resolution_mechanism` STRING COMMENT 'Contractual mechanism for resolving disputes arising under the framework. dab = Dispute Adjudication Board (FIDIC); arbitration = binding arbitration; adjudication = statutory adjudication; litigation = court proceedings; mediation = non-binding mediation.. Valid values are `arbitration|adjudication|litigation|dab|mediation`',
    `duration_months` STRING COMMENT 'Total planned duration of the framework agreement in calendar months from effective date to expiry date. Used for scheduling, resource planning, and renewal forecasting.',
    `effective_date` DATE COMMENT 'Date on which the framework agreement becomes legally binding and call-offs may commence. Equivalent to the Notice to Proceed (NTP) date for the framework.',
    `expiry_date` DATE COMMENT 'Date on which the framework agreement is scheduled to expire and no further call-offs may be issued, unless an extension option is exercised.',
    `extension_duration_months` STRING COMMENT 'Duration in calendar months of each individual extension option. Combined with extension_options to determine the maximum possible agreement term.',
    `extension_options` STRING COMMENT 'Number of contractual extension options available to the client to extend the framework agreement beyond the original expiry date (e.g., 2 options of 12 months each).',
    `framework_lot` STRING COMMENT 'Lot or package designation within a multi-lot framework agreement (e.g., Lot 1 – Civils, Lot 2 – MEP, Lot 3 – Highways). Applicable where the client has structured the framework into distinct work categories.',
    `geographic_region` STRING COMMENT 'Geographic region or territory within which works under this framework agreement are to be executed (e.g., Northern England, Gulf Region, Southeast Asia). Used for resource planning and regional P&L reporting.',
    `governing_law` STRING COMMENT 'Legal jurisdiction and governing law under which the framework agreement is interpreted and enforced (e.g., English Law, New York State Law, UAE Federal Law). Critical for dispute resolution and contract administration.',
    `hse_requirements` STRING COMMENT 'Summary of Health, Safety and Environment (HSE) obligations and standards mandated under the framework agreement, such as OSHA compliance, ISO 45001 certification, SWMS submission, and minimum PPE standards.',
    `incentive_mechanism` STRING COMMENT 'Description of any pain/gain share, bonus, or incentive fee mechanism embedded in the framework agreement to reward performance above KPI thresholds or penalise underperformance.',
    `insurance_required` BOOLEAN COMMENT 'Indicates whether specific insurance requirements (e.g., professional indemnity, public liability, contractors all-risk) are mandated under the framework agreement terms.',
    `kpi_description` STRING COMMENT 'Narrative description of the performance KPIs defined in the framework agreement against which the contractors performance will be measured across call-off orders (e.g., on-time delivery rate, defect rate, TRIR, CPI thresholds).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the framework agreement record was most recently modified. Supports incremental data loading in the Databricks lakehouse silver layer and change data capture.',
    `liquidated_damages_rate` DECIMAL(18,2) COMMENT 'Pre-agreed daily or weekly Liquidated Damages (LD) rate applicable per call-off order for delay beyond the agreed completion date. Expressed in the agreement currency per day.',
    `max_calloff_value` DECIMAL(18,2) COMMENT 'Maximum monetary value of a single call-off order permitted under this framework agreement without triggering a mini-competition or additional approval. Supports procurement governance.',
    `min_calloff_value` DECIMAL(18,2) COMMENT 'Minimum monetary value of an individual call-off order that may be placed under this framework agreement. Ensures commercial viability of individual work packages.',
    `payment_terms` STRING COMMENT 'Pre-agreed payment terms applicable to all call-off orders under this framework (e.g., Net 30 days from certified invoice, Monthly progress payment, Milestone-based). Governs accounts receivable and cash flow forecasting.',
    `performance_bond_required` BOOLEAN COMMENT 'Indicates whether a performance bond or parent company guarantee is required from the contractor for call-off orders placed under this framework agreement.',
    `procurement_route` STRING COMMENT 'Mechanism by which individual call-off orders are awarded under the framework. direct_award = awarded without further competition; mini_competition = secondary competition among framework members; competitive_tender = full re-tender; negotiated = negotiated with incumbent.. Valid values are `direct_award|mini_competition|competitive_tender|negotiated`',
    `quality_standard` STRING COMMENT 'Quality management standard or certification required of the contractor under the framework agreement (e.g., ISO 9001:2015, LEED Gold, ITP compliance). Supports QA/QC governance.',
    `renewal_notice_days` STRING COMMENT 'Number of calendar days prior to expiry by which either party must serve notice of intent to renew or extend the framework agreement. Triggers CRM pipeline renewal workflow.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of each certified payment withheld as retention money under call-off orders, to be released upon satisfactory completion and expiry of the Defects Liability Period (DLP). Standard construction contract retention mechanism.',
    `scope_description` STRING COMMENT 'Narrative description of the categories of works, services, or supply covered by the framework agreement (e.g., Highway maintenance, resurfacing, and drainage works across the Northern Region).',
    `sector` STRING COMMENT 'Industry sector of the client commissioning the framework, used for client segmentation and pipeline analytics. Distinguishes public-sector (government agencies, highways authorities), private-sector developers, PPP/BOT sponsors, and utilities clients. [ENUM-REF-CANDIDATE: public|private|ppp|utilities|defence|transport|energy|residential|commercial — promote to reference product]',
    `signed_date` DATE COMMENT 'Date on which the framework agreement was formally executed (signed by all parties). May precede the effective date if there is a mobilisation period.',
    `termination_date` DATE COMMENT 'Actual date on which the framework agreement was terminated early, if applicable. Null if the agreement expired naturally or is still active.',
    `termination_reason` STRING COMMENT 'Reason for early termination of the framework agreement. client_default = client failed to meet obligations; contractor_default = contractor breach; mutual_agreement = both parties agreed; force_majeure = unforeseeable event; regulatory = regulatory or legal requirement; convenience = termination for convenience by client.. Valid values are `client_default|contractor_default|mutual_agreement|force_majeure|regulatory|convenience`',
    `title` STRING COMMENT 'Full descriptive title of the framework agreement as stated in the executed contract document (e.g., National Highways Maintenance Framework 2024–2028).',
    CONSTRAINT pk_master_services_agreement PRIMARY KEY(`master_services_agreement_id`)
) COMMENT 'Long-term framework agreements, master service agreements (MSA), or term contracts established with repeat clients, defining pre-agreed rates, scope categories, KPIs, and call-off procedures for multiple projects over a defined period. Captures agreement title, client account, agreement type (framework, MSA, term contract, blanket order), effective date, expiry date, total ceiling value, call-off mechanism, performance KPIs, renewal terms, and extension options. Common with public-sector clients (e.g., highways agencies, utilities) who procure repeat works under a single competitive framework. [SSOT: distinct source of truth for client domain]';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`client`.`opportunity_contact_engagement` (
    `opportunity_contact_engagement_id` BIGINT COMMENT 'Primary key for the opportunity_contact_engagement association',
    `contact_id` BIGINT COMMENT 'Foreign key linking to the client stakeholder contact engaged on the opportunity',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to the BD pipeline opportunity on which the contact is engaged',
    `contact_role` STRING COMMENT 'The functional role this contact plays in evaluating or influencing the opportunity. Determines how BD engages with this contact and what information is shared. Cannot reside on contact (role varies per opportunity) or on client_opportunity (role is per-contact).',
    `engagement_date` DATE COMMENT 'Date on which this contact was formally identified and engaged as a stakeholder on this opportunity. Used to track BD relationship timeline per contact per opportunity.',
    `evaluation_score_contribution` DECIMAL(18,2) COMMENT 'Numeric score or weighting representing this contacts contribution to the clients evaluation of the opportunity. Used by BD to assess influence and prioritise relationship investment. Belongs to the contact-opportunity pairing, not to either entity alone.',
    `is_primary_evaluator` BOOLEAN COMMENT 'Indicates whether this contact is the designated primary evaluator or decision-maker for this opportunity. Only one contact per opportunity should hold this flag. Drives BD prioritisation of engagement effort.',
    CONSTRAINT pk_opportunity_contact_engagement PRIMARY KEY(`opportunity_contact_engagement_id`)
) COMMENT 'This association product represents the Role-based engagement between a client contact and a client opportunity in the BD pipeline. It captures which stakeholder contacts are formally engaged on a given opportunity, in what capacity, and with what level of evaluative influence. Each record links one contact to one client_opportunity with attributes — role, engagement date, primary evaluator flag, and evaluation score contribution — that exist only in the context of this specific contact-opportunity relationship. Sourced from Salesforce CRM OpportunityContactRole object.. Existence Justification: In construction BD operations, client contacts are actively engaged across multiple opportunities — a procurement officer may evaluate bids on three concurrent projects, while a single opportunity involves a panel of client contacts (owner, technical lead, legal counsel, executive sponsor). This is not an analytical correlation; BD teams actively manage who is engaged on which opportunity, in what role, and at what stage. The relationship is a recognized CRM concept called Opportunity Contact Role (Salesforce standard object) and carries its own operational data.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`client`.`account` ADD CONSTRAINT `fk_client_account_parent_account_id` FOREIGN KEY (`parent_account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`account` ADD CONSTRAINT `fk_client_account_primary_ultimate_parent_account_id` FOREIGN KEY (`primary_ultimate_parent_account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`account` ADD CONSTRAINT `fk_client_account_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_construction_v1`.`client`.`segment`(`segment_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ADD CONSTRAINT `fk_client_contact_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ADD CONSTRAINT `fk_client_contact_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_construction_v1`.`client`.`address`(`address_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ADD CONSTRAINT `fk_client_contact_reports_to_contact_id` FOREIGN KEY (`reports_to_contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ADD CONSTRAINT `fk_client_contact_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_construction_v1`.`client`.`segment`(`segment_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`address` ADD CONSTRAINT `fk_client_address_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ADD CONSTRAINT `fk_client_segment_parent_segment_id` FOREIGN KEY (`parent_segment_id`) REFERENCES `vibe_construction_v1`.`client`.`segment`(`segment_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ADD CONSTRAINT `fk_client_opportunity_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ADD CONSTRAINT `fk_client_prequalification_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ADD CONSTRAINT `fk_client_prequalification_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ADD CONSTRAINT `fk_client_prequalification_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_construction_v1`.`client`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ADD CONSTRAINT `fk_client_rfp_issuance_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ADD CONSTRAINT `fk_client_rfp_issuance_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_construction_v1`.`client`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ADD CONSTRAINT `fk_client_rfp_issuance_prequalification_id` FOREIGN KEY (`prequalification_id`) REFERENCES `vibe_construction_v1`.`client`.`prequalification`(`prequalification_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ADD CONSTRAINT `fk_client_master_services_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ADD CONSTRAINT `fk_client_master_services_agreement_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ADD CONSTRAINT `fk_client_master_services_agreement_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_construction_v1`.`client`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ADD CONSTRAINT `fk_client_master_services_agreement_parent_agreement_client_framework_agreement_master_services_agreement_id` FOREIGN KEY (`parent_agreement_client_framework_agreement_master_services_agreement_id`) REFERENCES `vibe_construction_v1`.`client`.`master_services_agreement`(`master_services_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity_contact_engagement` ADD CONSTRAINT `fk_client_opportunity_contact_engagement_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity_contact_engagement` ADD CONSTRAINT `fk_client_opportunity_contact_engagement_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_construction_v1`.`client`.`opportunity`(`opportunity_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`client` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_construction_v1`.`client` SET TAGS ('dbx_domain' = 'client');
ALTER TABLE `vibe_construction_v1`.`client`.`account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`client`.`account` SET TAGS ('dbx_subdomain' = 'client_identity');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `parent_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account ID');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `primary_ultimate_parent_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Parent Account ID');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|prospect|suspended|blacklisted|archived');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'public_sector|private_sector|government_body|corporate_sponsor|jv_entity|ppp_authority');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `billing_address` SET TAGS ('dbx_business_glossary_term' = 'Billing Address');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `billing_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `billing_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `bim_requirement_level` SET TAGS ('dbx_business_glossary_term' = 'Building Information Modeling (BIM) Requirement Level');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `bim_requirement_level` SET TAGS ('dbx_value_regex' = 'none|bim_level_1|bim_level_2|bim_level_3');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `client_tier` SET TAGS ('dbx_business_glossary_term' = 'Client Tier');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `client_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|strategic');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `crm_account_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Account ID');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency Code');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `do_not_contact` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Count');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `eot_policy` SET TAGS ('dbx_business_glossary_term' = 'Extension of Time (EOT) Policy');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `eot_policy` SET TAGS ('dbx_value_regex' = 'standard|strict|flexible');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `hse_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Compliance Required Flag');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `is_jv_entity` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Entity Flag');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `last_project_award_date` SET TAGS ('dbx_business_glossary_term' = 'Last Project Award Date');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `ld_clause_standard` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages (LD) Clause Standard');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `ld_clause_standard` SET TAGS ('dbx_value_regex' = 'yes|no|negotiable');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `leed_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Certification Required Flag');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `ntp_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Notice to Proceed (NTP) Authority Level');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `preferred_contract_type` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contract Type');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `prequalification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Expiry Date');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `prequalification_status` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Status');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `prequalification_status` SET TAGS ('dbx_value_regex' = 'approved|pending|expired|rejected');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `registered_address` SET TAGS ('dbx_business_glossary_term' = 'Registered Address');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `registered_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `registered_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Company Registration Number');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `trading_name` SET TAGS ('dbx_business_glossary_term' = 'Trading Name');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `vibe_construction_v1`.`client`.`account` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://[^s/$.?#].[^s]*$');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` SET TAGS ('dbx_subdomain' = 'client_identity');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `reports_to_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Contact ID');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `account_manager` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Name');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `birthdate` SET TAGS ('dbx_business_glossary_term' = 'Contact Date of Birth');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `birthdate` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `birthdate` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|do_not_contact');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'owner|technical|procurement|legal|executive|financial');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `crm_contact_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Contact ID');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `data_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Consent Date');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `data_consent_status` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Consent Status');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `data_consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|pending|not_required');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `decision_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Decision-Making Authority Level');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `decision_authority_level` SET TAGS ('dbx_value_regex' = 'strategic|operational|advisory|none');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Contact Department');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `do_not_contact` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Contact Primary Email Address');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `email_opt_out` SET TAGS ('dbx_business_glossary_term' = 'Email Opt-Out Flag');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `email_opt_out` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `email_opt_out` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `influence_score` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Influence Score');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `is_decision_maker` SET TAGS ('dbx_business_glossary_term' = 'Decision Maker Flag');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `is_executive_sponsor` SET TAGS ('dbx_business_glossary_term' = 'Executive Sponsor Flag');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `last_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Last Meeting Date');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_business_glossary_term' = 'Contact LinkedIn Profile URL');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_value_regex' = '^https://(www.)?linkedin.com/in/[a-zA-Z0-9-_%]+/?$');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Mobile Phone Number');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Primary Phone Number');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|video_call|in_person|portal');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `relationship_health` SET TAGS ('dbx_business_glossary_term' = 'Relationship Health Indicator');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `relationship_health` SET TAGS ('dbx_value_regex' = 'strong|good|neutral|at_risk|poor');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `relationship_health` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `relationship_health` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `salutation` SET TAGS ('dbx_business_glossary_term' = 'Contact Salutation');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `salutation` SET TAGS ('dbx_value_regex' = 'Mr.|Ms.|Mrs.|Dr.|Prof.');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Contact Source');
ALTER TABLE `vibe_construction_v1`.`client`.`contact` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'crm|referral|conference|rfp|website|partner');
ALTER TABLE `vibe_construction_v1`.`client`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`client`.`address` SET TAGS ('dbx_subdomain' = 'client_identity');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Client Address ID');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_ssot' = 'client.address');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_validation|superseded|undeliverable');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'registered_office|billing|correspondence|project_site_liaison|head_office|branch_office');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `attention_to` SET TAGS ('dbx_business_glossary_term' = 'Attention To (Addressee)');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `attention_to` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `attention_to` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_business_glossary_term' = 'Building Name');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `city` SET TAGS ('dbx_natural_key' = 'normalized');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_natural_key' = 'normalized');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_natural_key_source' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_ssot' = 'reference.country.country_code');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_denormalized_natural_key_governed' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `country_name` SET TAGS ('dbx_business_glossary_term' = 'Country Name');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `country_name` SET TAGS ('dbx_denormalized' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `country_name` SET TAGS ('dbx_source_natural_key' = 'country_code');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `country_name` SET TAGS ('dbx_natural_key_source' = 'country_code');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `country_natural_key_source` SET TAGS ('dbx_business_glossary_term' = 'Country Reference Source');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `country_natural_key_source` SET TAGS ('dbx_denormalized_natural_key_governed;ssot' = 'reference.country');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `country_natural_key_source` SET TAGS ('dbx_denormalized' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `country_natural_key_source` SET TAGS ('dbx_natural_key_warning' = 'resolved');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `country_natural_key_source` SET TAGS ('dbx_nk_for' = 'country_code');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Address Effective From Date');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Address Effective To Date');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Address Email Address');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Address Fax Number');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `fax_number` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `floor_level` SET TAGS ('dbx_business_glossary_term' = 'Floor Level');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `format_type` SET TAGS ('dbx_business_glossary_term' = 'Address Format Type');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `format_type` SET TAGS ('dbx_value_regex' = 'western|eastern|po_box|free_form');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `is_billing_address` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Indicator');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `is_billing_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `is_billing_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Indicator');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `is_registered_office` SET TAGS ('dbx_business_glossary_term' = 'Registered Office Indicator');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}-[A-Z0-9]{1,6}$');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (GIS Coordinate)');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_business_glossary_term' = 'Address Line 3');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (GIS Coordinate)');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Address Notes');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Address Phone Number');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `po_box_number` SET TAGS ('dbx_business_glossary_term' = 'Post Office (PO) Box Number');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `po_box_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `po_box_number` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `preferred_correspondence_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Correspondence Language');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `preferred_correspondence_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `region` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `region` SET TAGS ('dbx_derived_from' = 'country_code');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Address ID');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State / Province');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_natural_key' = 'normalized');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_denormalized_natural_key' = 'region');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `suite_unit_number` SET TAGS ('dbx_business_glossary_term' = 'Suite / Unit Number');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `suite_unit_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `suite_unit_number` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_denormalized' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_source_natural_key' = 'jurisdiction_code');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Date');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `validation_source` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Source');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `vibe_construction_v1`.`client`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|not_validated|failed|partial');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` SET TAGS ('dbx_subdomain' = 'client_identity');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Client Segment ID');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `parent_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Segment ID');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `account_count_target` SET TAGS ('dbx_business_glossary_term' = 'Target Account Count');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `bd_owner` SET TAGS ('dbx_business_glossary_term' = 'Business Development Owner');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `bim_requirement` SET TAGS ('dbx_business_glossary_term' = 'Building Information Modeling (BIM) Requirement');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `bim_requirement` SET TAGS ('dbx_value_regex' = 'mandatory|preferred|optional|not_required');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Client Segment Code');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `criteria_description` SET TAGS ('dbx_business_glossary_term' = 'Segmentation Criteria Description');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Segmentation Criteria Version');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `criteria_version` SET TAGS ('dbx_value_regex' = '^vd+.d+$');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `crm_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Segment ID');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `delivery_model` SET TAGS ('dbx_business_glossary_term' = 'Project Delivery Model');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `delivery_model` SET TAGS ('dbx_value_regex' = 'epc|db|dbb|ppp|bot|jv');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Client Segment Description');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective From Date');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective Until Date');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `esg_focus` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Focus');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `hse_standard` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Standard');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `hse_standard` SET TAGS ('dbx_value_regex' = 'iso_45001|osha|client_specific|none');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `is_global_segment` SET TAGS ('dbx_business_glossary_term' = 'Global Segment Indicator');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `jv_partnership_typical` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Partnership Typical');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `leed_certification_required` SET TAGS ('dbx_business_glossary_term' = 'LEED Certification Required');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Client Segment Name');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `prequalification_required` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Required');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `primary_country_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Country Code');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `primary_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `quality_standard` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `quality_standard` SET TAGS ('dbx_value_regex' = 'iso_9001|client_specific|none');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `revenue_band_max_usd` SET TAGS ('dbx_business_glossary_term' = 'Revenue Band Maximum (USD)');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `revenue_band_max_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `revenue_band_min_usd` SET TAGS ('dbx_business_glossary_term' = 'Revenue Band Minimum (USD)');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `revenue_band_min_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Segment Review Frequency');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `sector` SET TAGS ('dbx_business_glossary_term' = 'Client Sector');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `sector` SET TAGS ('dbx_value_regex' = 'public|private|ppp_bot');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|archived');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `strategic_tier` SET TAGS ('dbx_business_glossary_term' = 'Strategic Tier');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `strategic_tier` SET TAGS ('dbx_value_regex' = 'key_account|growth|standard|dormant');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `sub_sector` SET TAGS ('dbx_business_glossary_term' = 'Client Sub-Sector');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `sub_sector` SET TAGS ('dbx_value_regex' = 'infrastructure|energy|commercial|residential|industrial');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `target_pipeline_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Target Pipeline Value (USD)');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `target_pipeline_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `target_win_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Win Rate Percentage');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `target_win_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `typical_contract_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Typical Contract Duration (Months)');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `typical_project_value_max_usd` SET TAGS ('dbx_business_glossary_term' = 'Typical Project Value Maximum (USD)');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `typical_project_value_max_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `typical_project_value_min_usd` SET TAGS ('dbx_business_glossary_term' = 'Typical Project Value Minimum (USD)');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `typical_project_value_min_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` SET TAGS ('dbx_subdomain' = 'business_development');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Client Opportunity ID');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `actual_award_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Award Date');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `bid_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Bid Cost Estimate');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `bid_cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `bid_no_bid_decision` SET TAGS ('dbx_business_glossary_term' = 'Bid / No-Bid Decision');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `bid_no_bid_decision` SET TAGS ('dbx_value_regex' = 'bid|no_bid|pending_review');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `bid_no_bid_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Bid / No-Bid Decision Date');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `bid_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Bid Submission Date');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `bim_required` SET TAGS ('dbx_business_glossary_term' = 'Building Information Modeling (BIM) Required Flag');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `boq_available` SET TAGS ('dbx_business_glossary_term' = 'Bill of Quantities (BOQ) Available Flag');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `client_opportunity_description` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Description');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `competitor_names` SET TAGS ('dbx_business_glossary_term' = 'Competitor Names');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `competitor_names` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `delivery_model` SET TAGS ('dbx_business_glossary_term' = 'Delivery Model');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `esg_requirements` SET TAGS ('dbx_business_glossary_term' = 'Environmental, Social, and Governance (ESG) Requirements');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `estimated_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Contract Value');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `estimated_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `expected_award_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Award Date');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `expected_ntp_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Notice to Proceed (NTP) Date');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `is_jv_bid` SET TAGS ('dbx_business_glossary_term' = 'Is Joint Venture (JV) Bid Flag');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `jv_partner_names` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Partner Names');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `jv_partner_names` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `leed_certification_required` SET TAGS ('dbx_business_glossary_term' = 'LEED Certification Required Flag');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `loss_reason` SET TAGS ('dbx_business_glossary_term' = 'Loss Reason');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Name');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `next_action` SET TAGS ('dbx_business_glossary_term' = 'Next BD Action');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `next_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next BD Action Due Date');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Number');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_value_regex' = '^OPP-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `opportunity_status` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Status');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `opportunity_status` SET TAGS ('dbx_value_regex' = 'open|closed_won|closed_lost|on_hold|cancelled');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `pipeline_stage` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Stage');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `prequalification_status` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Status');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `prequalification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `probability_of_win_pct` SET TAGS ('dbx_business_glossary_term' = 'Probability of Win Percentage');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `project_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Estimated Project Duration (Months)');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `project_location_country` SET TAGS ('dbx_business_glossary_term' = 'Project Location Country');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `project_location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `project_location_region` SET TAGS ('dbx_business_glossary_term' = 'Project Location Region / State');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `rfp_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Issue Date');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `rfq_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) / RFP Number');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `sector` SET TAGS ('dbx_business_glossary_term' = 'Client Sector');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `sector` SET TAGS ('dbx_value_regex' = 'public|private|ppp_bot');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `source_crm_opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'Source CRM Opportunity ID');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority Tier');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `weighted_pipeline_value` SET TAGS ('dbx_business_glossary_term' = 'Weighted Pipeline Value');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `weighted_pipeline_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `win_loss_outcome` SET TAGS ('dbx_business_glossary_term' = 'Win / Loss Outcome');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity` ALTER COLUMN `win_loss_outcome` SET TAGS ('dbx_value_regex' = 'won|lost|withdrawn|no_award');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` SET TAGS ('dbx_subdomain' = 'business_development');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `prequalification_id` SET TAGS ('dbx_business_glossary_term' = 'Client Prequalification ID');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Client Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Approval Date');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `condition_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Condition Resolution Date');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `conditions_imposed` SET TAGS ('dbx_business_glossary_term' = 'Conditions Imposed');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `conditions_imposed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `contract_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Contract Delivery Method');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `contract_delivery_method` SET TAGS ('dbx_value_regex' = 'epc|db|dbb|gmp|bot|ppp');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Document Reference');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Effective From Date');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `environmental_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Environmental Certification Required');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Expiry Date');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `financial_audit_required` SET TAGS ('dbx_business_glossary_term' = 'Financial Audit Required');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `hse_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Certification Required');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `insurance_verification_required` SET TAGS ('dbx_business_glossary_term' = 'Insurance Verification Required');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `leed_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Certification Required');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `max_project_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Approved Project Value');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `max_project_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `minimum_passing_score` SET TAGS ('dbx_business_glossary_term' = 'Minimum Passing Score');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Notes');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `prequalification_number` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Reference Number');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `prequalification_number` SET TAGS ('dbx_value_regex' = '^PREQ-[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `prequalification_status` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Status');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `prequalification_status` SET TAGS ('dbx_value_regex' = 'approved|conditional|rejected|expired|pending|withdrawn');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `procurement_category` SET TAGS ('dbx_value_regex' = 'public_sector|private_sector|ppp|bot|jv');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `quality_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Required');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `reference_projects_required` SET TAGS ('dbx_business_glossary_term' = 'Reference Projects Required');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `renewal_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Actions Required');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Renewal Due Date');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `renewal_period_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Period (Months)');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `rfp_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Eligibility Flag');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `rfq_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Eligibility Flag');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Score');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Submission Date');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `submitted_trir` SET TAGS ('dbx_business_glossary_term' = 'Submitted Total Recordable Incident Rate (TRIR)');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `trir_threshold` SET TAGS ('dbx_business_glossary_term' = 'Total Recordable Incident Rate (TRIR) Threshold');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `work_category` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Work Category');
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ALTER COLUMN `years_experience_required` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience Required');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` SET TAGS ('dbx_subdomain' = 'business_development');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `rfp_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Issuance ID');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `prequalification_id` SET TAGS ('dbx_business_glossary_term' = 'Client Prequalification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `addendum_count` SET TAGS ('dbx_business_glossary_term' = 'RFP Addendum Count');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `anticipated_award_date` SET TAGS ('dbx_business_glossary_term' = 'Anticipated Contract Award Date');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `anticipated_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Anticipated Project Completion Date');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `anticipated_start_date` SET TAGS ('dbx_business_glossary_term' = 'Anticipated Project Start Date');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `bid_bond_percentage` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Percentage');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `bid_bond_required` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Required Flag');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `bid_validity_days` SET TAGS ('dbx_business_glossary_term' = 'Bid Validity Period in Days');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `bim_level` SET TAGS ('dbx_business_glossary_term' = 'Building Information Modeling (BIM) Level');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `bim_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `bim_required` SET TAGS ('dbx_business_glossary_term' = 'Building Information Modeling (BIM) Required Flag');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `client_sector` SET TAGS ('dbx_business_glossary_term' = 'Client Sector Classification');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `client_sector` SET TAGS ('dbx_value_regex' = 'public|private|ppp|jv');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `commercial_score_weight` SET TAGS ('dbx_business_glossary_term' = 'Commercial Score Weight Percentage');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'lump_sum|unit_rate|cost_plus|target_cost|framework');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Project Country Code');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `defects_liability_period_days` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period (DLP) in Days');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `delivery_model` SET TAGS ('dbx_business_glossary_term' = 'Project Delivery Model');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `estimated_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Contract Value');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `estimated_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `evaluation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Bid Evaluation Criteria Method');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `evaluation_criteria` SET TAGS ('dbx_value_regex' = 'price_only|price_quality|quality_only|best_value|pass_fail');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'RFP Issue Date');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'RFP Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'RFP Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `latest_addendum_date` SET TAGS ('dbx_business_glossary_term' = 'Latest RFP Addendum Date');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `leed_certification_level` SET TAGS ('dbx_business_glossary_term' = 'LEED Certification Level');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `leed_certification_level` SET TAGS ('dbx_value_regex' = 'certified|silver|gold|platinum');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `leed_certification_required` SET TAGS ('dbx_business_glossary_term' = 'LEED Certification Required Flag');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `liquidated_damages_applicable` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages (LD) Applicable Flag');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `liquidated_damages_rate` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages (LD) Daily Rate');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `liquidated_damages_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `local_content_requirement_pct` SET TAGS ('dbx_business_glossary_term' = 'Local Content Requirement Percentage');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `performance_bond_percentage` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Percentage');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `performance_bond_required` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Required Flag');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `pre_bid_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Bid Meeting Date');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `pre_bid_meeting_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Pre-Bid Meeting Mandatory Flag');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Scope Description');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `project_sector` SET TAGS ('dbx_business_glossary_term' = 'Project Sector');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `project_title` SET TAGS ('dbx_business_glossary_term' = 'Project Title');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `rfp_document_reference` SET TAGS ('dbx_business_glossary_term' = 'RFP Document Reference');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `rfp_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Reference Number');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `rfp_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-/]{3,50}$');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `rfp_status` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Status');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `rfp_status` SET TAGS ('dbx_value_regex' = 'draft|issued|amended|closed|cancelled|awarded');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `solicitation_type` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Type');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `solicitation_type` SET TAGS ('dbx_value_regex' = 'RFP|RFQ|ITT|EOI|RFI');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Bid Submission Deadline');
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ALTER COLUMN `technical_score_weight` SET TAGS ('dbx_business_glossary_term' = 'Technical Score Weight Percentage');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` SET TAGS ('dbx_subdomain' = 'business_development');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `master_services_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Framework Agreement ID');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'CRM Opportunity ID');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `parent_agreement_client_framework_agreement_master_services_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Agreement ID');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Framework Agreement Number');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,30}$');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_ssot_source' = 'procurement.procurement_framework_agreement');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Framework Agreement Type');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'framework|master_service_agreement|term_contract|blanket_order|call_off_contract');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_ssot_source' = 'procurement.procurement_framework_agreement');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `ceiling_value` SET TAGS ('dbx_business_glossary_term' = 'Ceiling Value');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `ceiling_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `client_framework_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Framework Agreement Status');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `client_framework_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|under_renewal');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `committed_value` SET TAGS ('dbx_business_glossary_term' = 'Committed Value');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `committed_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ssot_source' = 'procurement.procurement_framework_agreement');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_ssot_source' = 'procurement.procurement_framework_agreement');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `delivery_model` SET TAGS ('dbx_business_glossary_term' = 'Delivery Model');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_value_regex' = 'arbitration|adjudication|litigation|dab|mediation');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_ssot_source' = 'procurement.procurement_framework_agreement');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `duration_months` SET TAGS ('dbx_business_glossary_term' = 'Agreement Duration (Months)');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `extension_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Extension Duration Per Option (Months)');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `extension_options` SET TAGS ('dbx_business_glossary_term' = 'Extension Options (Count)');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `framework_lot` SET TAGS ('dbx_business_glossary_term' = 'Framework Lot');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_ssot_source' = 'procurement.procurement_framework_agreement');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `hse_requirements` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Requirements');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `incentive_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Incentive Mechanism');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `insurance_required` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `kpi_description` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Description');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `liquidated_damages_rate` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages (LD) Rate');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `liquidated_damages_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `max_calloff_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Call-Off Value');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `max_calloff_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `min_calloff_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Call-Off Value');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `min_calloff_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_ssot_source' = 'procurement.procurement_framework_agreement');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `performance_bond_required` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Required');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `performance_bond_required` SET TAGS ('dbx_ssot_source' = 'procurement.procurement_framework_agreement');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `procurement_route` SET TAGS ('dbx_business_glossary_term' = 'Procurement Route');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `procurement_route` SET TAGS ('dbx_value_regex' = 'direct_award|mini_competition|competitive_tender|negotiated');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `quality_standard` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `sector` SET TAGS ('dbx_business_glossary_term' = 'Client Sector');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_ssot_source' = 'procurement.procurement_framework_agreement');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'client_default|contractor_default|mutual_agreement|force_majeure|regulatory|convenience');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_ssot_source' = 'procurement.procurement_framework_agreement');
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Framework Agreement Title');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity_contact_engagement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity_contact_engagement` SET TAGS ('dbx_subdomain' = 'business_development');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity_contact_engagement` SET TAGS ('dbx_association_edges' = 'client.contact,client.client_opportunity');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity_contact_engagement` ALTER COLUMN `opportunity_contact_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Contact Engagement - Opportunity Contact Engagement Id');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity_contact_engagement` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Contact Engagement - Contact Id');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity_contact_engagement` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Contact Engagement - Client Opportunity Id');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity_contact_engagement` ALTER COLUMN `contact_role` SET TAGS ('dbx_business_glossary_term' = 'Contact Role on Opportunity');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity_contact_engagement` ALTER COLUMN `contact_role` SET TAGS ('dbx_classification' = 'true');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity_contact_engagement` ALTER COLUMN `engagement_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Date');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity_contact_engagement` ALTER COLUMN `evaluation_score_contribution` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Score Contribution');
ALTER TABLE `vibe_construction_v1`.`client`.`opportunity_contact_engagement` ALTER COLUMN `is_primary_evaluator` SET TAGS ('dbx_business_glossary_term' = 'Primary Evaluator Flag');
