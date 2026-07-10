-- Schema for Domain: compliance | Business: Media_Broadcasting | Version: v3_mvm
-- Generated on: 2026-07-10 21:14:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`compliance` COMMENT 'Governs regulatory compliance obligations across broadcast licensing (FCC, Ofcom), content standards (MPA ratings, COPPA childrens content), data privacy (GDPR, CCPA), financial reporting (SOX), accessibility mandates, and technical standards (ATSC, DVB). Manages regulatory filings, license renewals, public inspection files, content clearance records, closed captioning compliance, consent management, and audit trails required by governing bodies.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` (
    `broadcast_license_id` BIGINT COMMENT 'Unique identifier for the broadcast license record. Primary key for the broadcast license entity.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: FCC licenses authorize specific transmission equipment operation. Compliance audits require equipment-level tracking for power output, frequency, and technical parameter verification. Real-world Form ',
    `annual_fee_amount` DECIMAL(18,2) COMMENT 'Annual regulatory fee assessed by the governing authority for maintaining this broadcast license.',
    `antenna_height_meters` DECIMAL(18,2) COMMENT 'Height of the transmitting antenna above average terrain, measured in meters. Critical factor in determining coverage area.',
    `broadcast_license_status` STRING COMMENT 'Current lifecycle status of the broadcast license indicating its operational validity and regulatory standing. [ENUM-REF-CANDIDATE: Active|Pending|Suspended|Expired|Revoked|Cancelled|Under Renewal — 7 candidates stripped; promote to reference product]',
    `call_sign` STRING COMMENT 'Unique station identifier assigned by the regulatory authority (e.g., WABC, KPIX-TV). Used for station identification during broadcasts.. Valid values are `^[A-Z]{3,4}(-[A-Z]{2})?$`',
    `channel_number` STRING COMMENT 'Assigned broadcast channel number for television licenses (e.g., Channel 2, Channel 7). May include virtual channel numbers for digital broadcasts.',
    `closed_captioning_required` BOOLEAN COMMENT 'Indicates whether this license requires closed captioning for accessibility compliance.',
    `community_of_license` STRING COMMENT 'City or community that the broadcast station is licensed to serve. Determines local content and public interest obligations.',
    `compliance_obligations` STRING COMMENT 'Summary of specific regulatory compliance requirements attached to this license (e.g., closed captioning, EAS participation, local content quotas, childrens programming).',
    `coverage_area_contour` STRING COMMENT 'Geographic boundary of the licensed coverage area, typically defined by signal strength contours (e.g., 60 dBu for FM, Grade A/B for TV). May be expressed as coordinates or geographic description.',
    `eas_participation_required` BOOLEAN COMMENT 'Indicates whether this license requires participation in the Emergency Alert System for public safety broadcasts.',
    `effective_date` DATE COMMENT 'Date when the broadcast license becomes legally effective and operational broadcasting is authorized.',
    `expiration_date` DATE COMMENT 'Date when the current license term expires and renewal is required to continue operations.',
    `frequency_band` STRING COMMENT 'Spectrum frequency band allocated to this license (e.g., 88.1 MHz for FM, 470-608 MHz for UHF TV). Expressed in MHz or GHz.',
    `grant_date` DATE COMMENT 'Date when the broadcast license was originally granted or issued by the regulatory authority.',
    `jurisdiction_country_code` STRING COMMENT 'Three-letter ISO country code of the jurisdiction where this license is valid (e.g., USA, GBR, AUS).. Valid values are `^[A-Z]{3}$`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection or audit of the licensed facility and operations.',
    `last_modification_date` DATE COMMENT 'Date of the most recent modification or amendment to the license terms, technical parameters, or ownership.',
    `license_class` STRING COMMENT 'Regulatory classification of the license indicating power level, coverage area, and operational constraints (e.g., Class A, Class B, Class C for FM; Full-Power, Low-Power for TV).',
    `license_number` STRING COMMENT 'Official license number or authorization code issued by the regulatory authority. This is the externally-known unique identifier for the broadcast license.',
    `license_type` STRING COMMENT 'Classification of the broadcast license by service type and transmission technology. [ENUM-REF-CANDIDATE: AM Radio|FM Radio|TV Full-Power|TV Low-Power|TV Translator|Satellite|Cable Franchise|IPTV — 8 candidates stripped; promote to reference product]',
    `licensee_type` STRING COMMENT 'Legal structure of the licensee organization.. Valid values are `Corporation|Partnership|Individual|Non-Profit|Government|Trust`',
    `modification_type` STRING COMMENT 'Nature of the most recent license modification (e.g., Technical Change, Ownership Transfer, Power Increase, Frequency Change).',
    `notes` STRING COMMENT 'Additional notes, conditions, or special provisions attached to this broadcast license by the regulatory authority.',
    `ownership_attribution` STRING COMMENT 'Details of attributable ownership interests in the licensee entity, required for regulatory ownership reporting and concentration limits.',
    `power_output_erp_watts` DECIMAL(18,2) COMMENT 'Maximum authorized effective radiated power output for the transmitter, measured in watts. Determines the coverage area and signal strength.',
    `public_inspection_file_location` STRING COMMENT 'Physical or online location where the stations public inspection file is maintained, as required by regulatory authorities.',
    `regulatory_authority` STRING COMMENT 'Governing body that issued and oversees this broadcast license (e.g., FCC for United States, Ofcom for United Kingdom). [ENUM-REF-CANDIDATE: FCC|Ofcom|ACMA|CRTC|ANATEL|IFT|Other — 7 candidates stripped; promote to reference product]',
    `renewal_application_date` DATE COMMENT 'Date when the license renewal application was filed with the regulatory authority.',
    `renewal_status` STRING COMMENT 'Current status of the license renewal process, tracking whether renewal application has been filed and its disposition.. Valid values are `Not Due|Renewal Filed|Renewal Pending|Renewal Granted|Renewal Denied`',
    `service_type` STRING COMMENT 'Nature of the broadcast service provided under this license, indicating the operational and content obligations.. Valid values are `Commercial|Non-Commercial Educational|Public|Community|Religious|Government`',
    `transmitter_address` STRING COMMENT 'Physical street address of the licensed transmitter facility. Organizational contact data classified as confidential.',
    `transmitter_location_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the licensed transmitter site in decimal degrees.',
    `transmitter_location_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the licensed transmitter site in decimal degrees.',
    CONSTRAINT pk_broadcast_license PRIMARY KEY(`broadcast_license_id`)
) COMMENT 'Master record for all broadcast licenses and spectrum authorizations issued by regulatory bodies (FCC, Ofcom, ACMA, CRTC) held by the organization. Tracks license type (AM, FM, TV full-power, TV low-power, satellite, cable franchise, IPTV), call sign, facility ID, frequency band, channel number, power output (ERP), coverage area (contour), community of license, license class, grant date, expiration date, renewal status, modification history, and the governing regulatory authority. Serves as the authoritative registry of all spectrum and broadcast operating authorities and the anchor entity for per-station compliance obligations.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` (
    `license_renewal_id` BIGINT COMMENT 'Unique identifier for the broadcast license renewal application record.',
    `broadcast_license_id` BIGINT COMMENT 'Reference to the underlying broadcast license being renewed.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: License renewals ARE regulatory filings - the renewal application is submitted as a formal filing to the FCC/Ofcom. This FK links the renewal record to its regulatory filing record. Removes duplicate ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: license_renewal tracks the lifecycle of broadcast license renewal applications governed by specific FCC/Ofcom regulatory obligations (e.g., FCC 47 CFR §73.3539 for TV license renewals). Adding a FK to',
    `approval_date` DATE COMMENT 'The date the regulatory authority officially granted the license renewal.',
    `compliance_certification_submitted` BOOLEAN COMMENT 'Indicates whether the required compliance certifications (EEO, childrens programming, political file, etc.) were submitted as part of the renewal application.',
    `conditions_imposed` STRING COMMENT 'Any special conditions, restrictions, or requirements imposed by the regulatory authority as part of the renewal grant (e.g., compliance reporting, technical upgrades, programming commitments).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this license renewal record was first created in the system.',
    `denial_date` DATE COMMENT 'The date the regulatory authority officially denied the license renewal application.',
    `denial_reason` STRING COMMENT 'The regulatory authoritys stated reason for denying the license renewal (e.g., failure to meet public interest standard, character qualifications, technical violations).',
    `fee_payment_date` DATE COMMENT 'The date the renewal filing fee was paid to the regulatory authority.',
    `fee_payment_status` STRING COMMENT 'The current status of the renewal fee payment obligation.. Valid values are `Pending|Paid|Waived|Refunded`',
    `filing_deadline` DATE COMMENT 'The regulatory deadline by which the renewal application must be submitted to avoid license lapse (typically 4 months prior to expiration for FCC).',
    `final_disposition` STRING COMMENT 'The ultimate outcome of the license renewal application process.. Valid values are `Granted|Granted with Conditions|Denied|Withdrawn|Dismissed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this license renewal record was most recently updated.',
    `license_type` STRING COMMENT 'The category of broadcast license being renewed (television station, radio station, cable system, satellite carrier, Multichannel Video Programming Distributor).. Valid values are `Television|Radio|Cable|Satellite|MVPD|Other`',
    `new_license_term_end_date` DATE COMMENT 'The expiration date of the renewed license term, establishing the next renewal cycle.',
    `new_license_term_start_date` DATE COMMENT 'The effective start date of the renewed license term following approval.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, issues, or observations related to the renewal application process.',
    `petition_count` STRING COMMENT 'The total number of petitions to deny filed against this renewal application.',
    `petition_to_deny_filed` BOOLEAN COMMENT 'Indicates whether any party filed a formal petition to deny the license renewal during the public comment period.',
    `public_comment_deadline` DATE COMMENT 'The deadline by which the public may file comments or petitions to deny the renewal application.',
    `public_inspection_file_updated` BOOLEAN COMMENT 'Indicates whether the stations public inspection file has been updated with the renewal application and related documents as required by regulation.',
    `public_notice_date` DATE COMMENT 'The date the regulatory body published public notice of the renewal application, opening the period for public comment and petitions to deny.',
    `regulatory_body` STRING COMMENT 'The governing regulatory authority to which the renewal application is submitted (Federal Communications Commission, Office of Communications, etc.).. Valid values are `FCC|Ofcom|CRTC|ACMA|Other`',
    `renewal_cycle_end_date` DATE COMMENT 'The date marking the expiration of the current license term, triggering the renewal requirement.',
    `renewal_cycle_start_date` DATE COMMENT 'The date marking the beginning of the current license term that is subject to renewal.',
    `renewal_fee_amount` DECIMAL(18,2) COMMENT 'The regulatory filing fee amount required for processing the license renewal application.',
    `renewal_fee_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the renewal fee (e.g., USD, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    `renewal_status` STRING COMMENT 'Current lifecycle status of the license renewal application in the regulatory review process. [ENUM-REF-CANDIDATE: Draft|Submitted|Under Review|Public Notice Issued|Petition Filed|Approved|Denied|Withdrawn — 8 candidates stripped; promote to reference product]',
    `review_completion_date` DATE COMMENT 'The date the regulatory authority completed its review and issued a final decision on the renewal application.',
    `review_start_date` DATE COMMENT 'The date the regulatory authority formally commenced substantive review of the renewal application.',
    CONSTRAINT pk_license_renewal PRIMARY KEY(`license_renewal_id`)
) COMMENT 'Tracks the lifecycle of broadcast license renewal applications submitted to the FCC, Ofcom, or other regulatory bodies. Captures renewal cycle, filing deadline, submission date, application status, renewal fee, public notice period, petitions to deny, and final disposition. Ensures no license lapses due to missed renewal windows.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` (
    `regulatory_filing_id` BIGINT COMMENT 'Unique identifier for the regulatory filing record. Primary key.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Regulatory filings are often associated with specific broadcast licenses. The filing has license_number (STRING) which should be replaced by FK to broadcast_license. This allows joining to get call_si',
    `original_filing_regulatory_filing_id` BIGINT COMMENT 'Reference to the original regulatory filing identifier if this submission is an amendment or correction, establishing the lineage of filing revisions.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: FCC Form 301/302 filings reference specific transmission equipment for power changes, frequency modifications, and technical upgrades. Real regulatory filing workflow requires equipment-level granular',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: regulatory_filing is the authoritative record of all filings submitted to governing bodies. Each filing fulfills a specific regulatory_obligation from the master catalog (e.g., annual EEO report, lice',
    `amendment_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this filing is an amendment or correction to a previously submitted filing.',
    `approval_date` DATE COMMENT 'The date on which the regulatory body officially approved or accepted the filing, marking successful completion of the compliance obligation.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this filing to detailed audit trail records capturing all preparation, review, approval, and submission activities for compliance verification.',
    `ccpa_applicable` BOOLEAN COMMENT 'Boolean indicator specifying whether this filing is subject to California Consumer Privacy Act (CCPA) viewer data privacy requirements for California residents.',
    `compliance_category` STRING COMMENT 'The primary regulatory compliance domain or category that this filing addresses, such as broadcast licensing, content standards, data privacy, financial reporting, accessibility mandates, or technical standards.. Valid values are `broadcast_licensing|content_standards|data_privacy|financial_reporting|accessibility|technical_standards`',
    `confirmation_number` STRING COMMENT 'The unique confirmation or receipt number issued by the regulatory body upon successful submission of the filing, serving as proof of receipt.',
    `coppa_applicable` BOOLEAN COMMENT 'Boolean indicator specifying whether this filing is subject to Childrens Online Privacy Protection Act (COPPA) requirements for childrens content and data collection practices.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory filing record was first created in the system, supporting audit trail and data lineage requirements.',
    `document_url` STRING COMMENT 'The Uniform Resource Locator (URL) or file path to the digital copy of the filed document stored in the Media Asset Management (MAM) system or document repository.',
    `due_date` DATE COMMENT 'The regulatory deadline by which the filing must be submitted to remain in compliance with governing body requirements.',
    `filing_date` DATE COMMENT 'The date on which the regulatory filing was officially submitted to the governing body. This is the principal business event timestamp for the filing.',
    `filing_description` STRING COMMENT 'A detailed textual description of the filing content, purpose, and scope, providing context for the regulatory submission.',
    `filing_fee_amount` DECIMAL(18,2) COMMENT 'The monetary fee charged by the regulatory body for processing this filing, expressed in the broadcasters reporting currency.',
    `filing_fee_currency` STRING COMMENT 'The three-letter International Organization for Standardization (ISO) 4217 currency code for the filing fee amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `filing_number` STRING COMMENT 'The externally-known unique filing number or reference code assigned by the broadcaster or regulatory body for tracking and identification purposes.',
    `filing_status` STRING COMMENT 'Current lifecycle status of the regulatory filing indicating its progress through the submission and approval workflow. [ENUM-REF-CANDIDATE: draft|submitted|accepted|rejected|under_review|pending_correction|completed — 7 candidates stripped; promote to reference product]',
    `filing_type` STRING COMMENT 'The category or type of regulatory filing being submitted, such as Equal Employment Opportunity (EEO) report, ownership report, political file, childrens programming report, annual report, license renewal application, or public inspection file entry. [ENUM-REF-CANDIDATE: eeo_report|ownership_report|political_file|childrens_programming_report|annual_report|license_renewal|public_inspection_file — 7 candidates stripped; promote to reference product]',
    `form_number` STRING COMMENT 'The official form number or identifier designated by the regulatory body for this filing type (e.g., FCC Form 323, FCC Form 396, Ofcom Form 1).',
    `gdpr_applicable` BOOLEAN COMMENT 'Boolean indicator specifying whether this filing is subject to General Data Protection Regulation (GDPR) data privacy and protection requirements for European Union (EU) audience data.',
    `market_designation` STRING COMMENT 'The designated market area or geographic market served by the broadcast facility, as defined by Nielsen or equivalent measurement authority.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory filing record was last modified or updated, supporting change tracking and audit requirements.',
    `next_filing_due_date` DATE COMMENT 'The anticipated due date for the next recurring filing of this type, supporting proactive compliance planning and calendar management.',
    `payment_confirmation_number` STRING COMMENT 'The confirmation or transaction number for the filing fee payment, linking the financial transaction to the regulatory submission.',
    `public_inspection_required` BOOLEAN COMMENT 'Boolean indicator specifying whether this filing must be made available for public inspection as required by regulatory transparency mandates.',
    `regulatory_body` STRING COMMENT 'The governing body or regulatory authority to which this filing was submitted, such as Federal Communications Commission (FCC), Office of Communications (Ofcom), Motion Picture Association (MPA), Interactive Advertising Bureau (IAB), Advanced Television Systems Committee (ATSC), Digital Video Broadcasting (DVB), Nielsen Media Research, Society of Cable Telecommunications Engineers (SCTE), International Organization for Standardization (ISO), General Data Protection Regulation (GDPR) authority, California Consumer Privacy Act (CCPA) authority, Sarbanes-Oxley Act (SOX) auditor, Payment Card Industry (PCI) council, or Childrens Online Privacy Protection Act (COPPA) Federal Trade Commission (FTC). [ENUM-REF-CANDIDATE: fcc|ofcom|mpa|iab|atsc|dvb|nielsen|scte|iso|gdpr_authority|ccpa_authority|sox_auditor|pci_council|coppa_ftc — 14 candidates stripped; promote to reference product]',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the regulatory body for rejecting or requesting corrections to the filing, guiding remediation efforts.',
    `reporting_period_end` DATE COMMENT 'The end date of the time period covered by this regulatory filing, defining the conclusion of the reporting window for compliance data.',
    `reporting_period_start` DATE COMMENT 'The start date of the time period covered by this regulatory filing, defining the beginning of the reporting window for compliance data.',
    `sox_applicable` BOOLEAN COMMENT 'Boolean indicator specifying whether this filing is subject to Sarbanes-Oxley Act (SOX) financial reporting and internal control requirements.',
    `submission_method` STRING COMMENT 'The channel or mechanism through which the filing was submitted to the regulatory body, such as online portal, email, postal mail, fax, electronic filing system, or Application Programming Interface (API).. Valid values are `online_portal|email|postal_mail|fax|electronic_filing_system|api`',
    CONSTRAINT pk_regulatory_filing PRIMARY KEY(`regulatory_filing_id`)
) COMMENT 'Authoritative record of all regulatory filings submitted to governing bodies including FCC, Ofcom, MPA, IAB, and others. Captures filing type (EEO report, ownership report, political file, childrens programming report, annual report), form number, filing date, due date, submission method, filing status, confirmation number, and the responsible regulatory body. Supports SOX, FCC, and Ofcom compliance obligations.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` (
    `public_inspection_file_id` BIGINT COMMENT 'Unique identifier for the public inspection file record. Primary key for the entity. Role: MASTER_RESOURCE (regulatory document repository).',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Public inspection files are maintained per broadcast license per FCC requirements. Each document in the OPIF relates to a specific licensed station. This FK enables tracking which license each documen',
    `channel_id` BIGINT COMMENT 'Reference to the FCC-licensed broadcast station that owns this public inspection file.',
    `original_document_public_inspection_file_id` BIGINT COMMENT 'If this is an amendment, reference to the original public inspection file document being amended or corrected.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Many regulatory filings must be included in the stations public inspection file. This FK links public file documents to their corresponding regulatory filing records, ensuring disclosure compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this public inspection file record was first created in the system.',
    `document_category` STRING COMMENT 'The FCC-mandated category of the public inspection file document. Categories include political file (advertising records), EEO reports (equal employment opportunity), ownership reports, issues/programs lists, childrens programming reports, and contour maps.. Valid values are `political_file|eeo_reports|ownership_reports|issues_programs_lists|childrens_programming_reports|contour_maps`',
    `document_description` STRING COMMENT 'Detailed description of the document content, purpose, and any relevant context for public inspection.',
    `document_file_format` STRING COMMENT 'The file format of the stored document (e.g., PDF, DOCX, XLSX). FCC typically requires PDF format for OPIF submissions.. Valid values are `pdf|docx|xlsx|txt|html|xml`',
    `document_file_path` STRING COMMENT 'The storage location or URI of the document file in the media asset management system or document repository.',
    `document_file_size_bytes` BIGINT COMMENT 'The size of the document file in bytes.',
    `document_period_end_date` DATE COMMENT 'The end date of the reporting period covered by this document.',
    `document_period_start_date` DATE COMMENT 'The start date of the reporting period covered by this document (e.g., for quarterly EEO reports or issues/programs lists).',
    `document_title` STRING COMMENT 'The descriptive title or name of the public inspection file document.',
    `fcc_opif_sync_status` STRING COMMENT 'Synchronization status with the FCCs Online Public Inspection File portal. Indicates whether the document has been successfully transmitted to and accepted by the FCC system.. Valid values are `not_synced|synced|sync_failed|sync_pending`',
    `fcc_opif_sync_timestamp` TIMESTAMP COMMENT 'The date and time of the last successful synchronization with the FCC OPIF portal.',
    `fcc_reference_number` STRING COMMENT 'The unique reference or confirmation number assigned by the FCC OPIF system upon successful document submission.',
    `filing_date` DATE COMMENT 'The date the document was filed or added to the public inspection file. This is the official date of record for compliance purposes.',
    `is_amendment` BOOLEAN COMMENT 'Indicates whether this document is an amendment or correction to a previously filed public inspection file document.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this public inspection file record was last updated or modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or context about the document, its filing, or any special circumstances related to compliance.',
    `political_advertiser_name` STRING COMMENT 'For political file documents, the name of the candidate, campaign, or political organization that purchased advertising time. Required for political file category documents.',
    `political_office_sought` STRING COMMENT 'For political file documents, the elected office being sought by the candidate (e.g., President, Senator, Governor, Mayor).',
    `public_access_status` STRING COMMENT 'Indicates whether the document is currently available for public inspection. Documents may be restricted during review or removed after retention period expiration.. Valid values are `available|restricted|pending_review|removed`',
    `retention_expiration_date` DATE COMMENT 'The date when the regulatory retention period expires and the document may be removed from the public inspection file.',
    `retention_period_years` STRING COMMENT 'The number of years this document must be retained in the public inspection file as mandated by FCC regulations. Varies by document category (e.g., 2 years for political files, 8 years for ownership reports).',
    `upload_status` STRING COMMENT 'Current status of the document upload to the FCC OPIF (Online Public Inspection File) portal. Tracks the lifecycle from pending submission through verification and archival.. Valid values are `pending|uploaded|verified|rejected|archived`',
    `upload_timestamp` TIMESTAMP COMMENT 'The date and time when the document was successfully uploaded to the FCC OPIF portal or internal public inspection file system.',
    `verification_status` STRING COMMENT 'Internal verification status indicating whether the document has been reviewed for accuracy and compliance before public posting.. Valid values are `unverified|verified|requires_correction|corrected`',
    `verification_timestamp` TIMESTAMP COMMENT 'The date and time when the document was verified for compliance and accuracy by station staff.',
    CONSTRAINT pk_public_inspection_file PRIMARY KEY(`public_inspection_file_id`)
) COMMENT 'Manages the FCC-mandated public inspection file (OPIF) for each licensed broadcast station. Tracks document categories (political file, EEO reports, ownership disclosures, childrens programming reports, issues/programs lists, contour maps), document upload status, retention period, public access status, and FCC OPIF portal sync status. Required for all FCC-licensed stations under 47 CFR §73.3526 and §73.3527.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` (
    `content_rating_id` BIGINT COMMENT 'Primary key for content_rating',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: content_rating tracks ratings issued under specific regulatory frameworks (MPA, TV Parental Guidelines, COPPA). Each rating system is governed by a specific regulatory_obligation in the master catalog',
    `accessibility_rating_notes` STRING COMMENT 'Notes regarding accessibility features relevant to the rating, such as closed captioning compliance, audio description availability, or photosensitive epilepsy warnings.',
    `appeal_status` STRING COMMENT 'Status of any appeal filed by the content producer to challenge the assigned rating. Not Appealed: no appeal has been filed; Appeal Pending: appeal is under review; Appeal Approved: rating was changed following appeal; Appeal Denied: original rating upheld.. Valid values are `not_appealed|appeal_pending|appeal_approved|appeal_denied`',
    `content_descriptors` STRING COMMENT 'Comma-separated list of content advisory descriptors that explain the reasons for the rating. Examples: violence, strong language, sexual content, drug use, nudity, adult themes, frightening scenes.',
    `coppa_compliant` BOOLEAN COMMENT 'Indicates whether the content and its associated data collection practices comply with COPPA requirements for childrens content.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this content rating record was first created in the system.',
    `drug_use_descriptor` BOOLEAN COMMENT 'Indicates whether the content contains drug use or substance abuse that contributed to the rating.',
    `eidr_code` STRING COMMENT 'The EIDR identifier for the content asset, providing a globally unique reference for the audiovisual work.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `language_descriptor` BOOLEAN COMMENT 'Indicates whether the content contains strong or offensive language that contributed to the rating.',
    `minimum_age` STRING COMMENT 'The minimum recommended or required age for viewers of this content, as specified by the rating authority. Null if no specific age restriction applies.',
    `parental_guidance_required` BOOLEAN COMMENT 'Indicates whether parental guidance is recommended or required for viewers under a certain age.',
    `previous_rating_value` DECIMAL(18,2) COMMENT 'The rating value that was assigned before the current rating, if the content was re-rated. Null for initial ratings.',
    `rating_authority` STRING COMMENT 'The official organization or regulatory body that issued the rating. Examples: Motion Picture Association, TV Parental Guidelines Monitoring Board, British Board of Film Classification, Freiwillige Selbstkontrolle der Filmwirtschaft.',
    `rating_certificate_number` STRING COMMENT 'The official certificate or registration number issued by the rating authority for this content rating.',
    `rating_date` DATE COMMENT 'The date on which the rating was officially assigned to the content by the rating authority.',
    `rating_expiration_date` DATE COMMENT 'The date on which the rating expires or requires renewal, if applicable. Null for ratings with no expiration.',
    `rating_fee_amount` DECIMAL(18,2) COMMENT 'The fee charged by the rating authority for evaluating and assigning the rating to the content.',
    `rating_fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the rating fee. Examples: USD, GBP, EUR, AUD, JPY.. Valid values are `^[A-Z]{3}$`',
    `rating_notes` STRING COMMENT 'Additional notes or comments regarding the rating, including any special conditions, context, or clarifications provided by the rating authority or compliance team.',
    `rating_reason` STRING COMMENT 'Detailed explanation provided by the rating authority describing the specific content elements that led to the assigned rating.',
    `rating_review_date` DATE COMMENT 'The date on which the rating was last reviewed or re-evaluated by the rating authority.',
    `rating_status` STRING COMMENT 'Current lifecycle status of the rating. Active: rating is valid and in effect; Expired: rating has passed its expiration date; Revoked: rating has been withdrawn by the authority; Pending: rating application submitted but not yet approved; Under Review: rating is being re-evaluated.. Valid values are `active|expired|revoked|pending|under_review`',
    `rating_submission_date` DATE COMMENT 'The date on which the content was submitted to the rating authority for evaluation.',
    `rating_system` STRING COMMENT 'The rating authority or system that issued this rating. Examples: MPA (Motion Picture Association), TV Parental Guidelines, BBFC (British Board of Film Classification), FSK (Germany), ACB (Australia), EIRIN (Japan), KFCB (Kenya). [ENUM-REF-CANDIDATE: MPA|TV_PARENTAL_GUIDELINES|BBFC|FSK|ACB|EIRIN|KFCB — 7 candidates stripped; promote to reference product]',
    `rating_type` STRING COMMENT 'The distribution context for which this rating was assigned. Different ratings may apply to theatrical release, television broadcast, home video, or streaming platforms.. Valid values are `theatrical|television|home_video|streaming|broadcast`',
    `rating_value` DECIMAL(18,2) COMMENT 'The specific rating classification assigned to the content. Examples: G, PG, PG-13, R, NC-17 (MPA); TV-Y, TV-Y7, TV-G, TV-PG, TV-14, TV-MA (TV Parental Guidelines); U, PG, 12A, 15, 18 (BBFC). [ENUM-REF-CANDIDATE: G|PG|PG-13|R|NC-17|TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA|U|12A|15|18|FSK0|FSK6|FSK12|FSK16|FSK18 — promote to reference product]',
    `rating_version` STRING COMMENT 'Version number of this rating record. Increments when the rating is re-evaluated or updated due to content changes or appeals.',
    `sexual_content_descriptor` BOOLEAN COMMENT 'Indicates whether the content contains sexual content or nudity that contributed to the rating.',
    `territory_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the geographic territory where this rating is applicable. Examples: USA, GBR, DEU, AUS, JPN.. Valid values are `^[A-Z]{3}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this content rating record was last modified in the system.',
    `violence_descriptor` BOOLEAN COMMENT 'Indicates whether the content contains violence that contributed to the rating.',
    CONSTRAINT pk_content_rating PRIMARY KEY(`content_rating_id`)
) COMMENT 'Master registry of content ratings assigned to programming assets per MPA, TV Parental Guidelines, and international rating systems (BBFC, FSK, etc.). Captures rating system, rating value (G, PG, PG-13, R, NC-17; TV-Y, TV-Y7, TV-G, TV-PG, TV-14, TV-MA), content descriptors (violence, language, sexual content, drug use), rating authority, rating date, and applicability by territory. Links to content assets in the content domain.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` (
    `closed_caption_record_id` BIGINT COMMENT 'Unique identifier for the closed caption compliance record.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Closed captioning is a specific type of accessibility obligation under FCC/Ofcom rules. This FK links each captioning record to the accessibility obligation it fulfills, enabling compliance reporting ',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: Closed captioning violations (low accuracy, missing captions, complaints) may be recorded as compliance incidents. This FK links the captioning record to any incident it triggered, supporting FCC comp',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Captioning vendor performance and FCC compliance is tracked by partner. Captioning accuracy failures, latency violations, and format errors may trigger vendor SLA breaches, disputes, or vendor substit',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Caption compliance audits require tracking which encoder processed each stream. Real NOC/compliance workflow for troubleshooting caption failures and demonstrating CVAA compliance to FCC.',
    `delivery_channel_id` BIGINT COMMENT 'Reference to the channel or platform where the captioned content was broadcast or streamed.',
    `public_inspection_file_id` BIGINT COMMENT 'Foreign key linking to compliance.public_inspection_file. Business justification: closed_caption_record has a public_inspection_file_included (BOOLEAN) flag indicating whether the caption record is included in the FCC public inspection file. Adding a direct FK to public_inspection_',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: closed_caption_record has regulatory_filing_required (BOOLEAN) and regulatory_filing_date (DATE) indicating that caption compliance events can trigger formal regulatory filings with the FCC. Adding a ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: closed_caption_record tracks compliance under FCC rules (47 CFR §79.1) and Ofcom requirements. These are specific entries in the regulatory_obligation master catalog. Adding this FK links each caption',
    `air_date` DATE COMMENT 'The date the captioned content was broadcast or made available to viewers.',
    `air_time` TIMESTAMP COMMENT 'The precise timestamp when the captioned content began airing or streaming.',
    `caption_accuracy_score` DECIMAL(18,2) COMMENT 'Percentage score representing the accuracy of the captions compared to the spoken audio, measured as a percentage from 0.00 to 100.00.',
    `caption_completeness_percentage` DECIMAL(18,2) COMMENT 'Percentage of the program duration that was captioned, measured from 0.00 to 100.00.',
    `caption_file_format` STRING COMMENT 'The technical format of the closed caption file used for this broadcast. [ENUM-REF-CANDIDATE: SRT|SCC|TTML|WebVTT|CEA-608|CEA-708|DFXP|STL — 8 candidates stripped; promote to reference product]',
    `caption_latency_seconds` DECIMAL(18,2) COMMENT 'The average delay in seconds between spoken audio and caption display, critical for live programming compliance.',
    `caption_placement_compliance` BOOLEAN COMMENT 'Indicates whether caption placement on screen met regulatory standards for visibility and non-obstruction of critical content.',
    `caption_quality_review_date` DATE COMMENT 'Date when the caption quality was formally reviewed for compliance assessment.',
    `caption_synchronization_compliance` BOOLEAN COMMENT 'Indicates whether captions were properly synchronized with the audio and video content per regulatory requirements.',
    `caption_type` STRING COMMENT 'Indicates whether the captions were generated live during broadcast or pre-recorded offline.. Valid values are `live|pre_recorded|real_time|offline`',
    `captioned_duration_minutes` STRING COMMENT 'Total duration in minutes that was actually captioned within the program.',
    `complaint_received_date` DATE COMMENT 'Date when a viewer complaint regarding captioning was received by the broadcaster.',
    `complaint_reference_number` STRING COMMENT 'Reference number of any viewer complaint filed regarding caption quality or availability for this broadcast.',
    `complaint_type` STRING COMMENT 'Category of the captioning complaint filed by viewers or regulatory bodies.. Valid values are `accuracy|completeness|placement|synchronization|availability|latency`',
    `compliance_status` STRING COMMENT 'Current compliance status of the closed captioning for this broadcast record.. Valid values are `compliant|non_compliant|under_review|remediated|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this closed caption compliance record was first created in the system.',
    `daypart` STRING COMMENT 'The broadcast daypart time segment during which the captioned content aired. [ENUM-REF-CANDIDATE: early_morning|morning|daytime|early_fringe|prime_access|prime_time|late_fringe|overnight — 8 candidates stripped; promote to reference product]',
    `exemption_basis` STRING COMMENT 'Legal or regulatory basis for exemption from closed captioning requirements, if applicable.',
    `exemption_category` STRING COMMENT 'Category of exemption from captioning requirements as defined by regulatory frameworks. [ENUM-REF-CANDIDATE: primarily_textual|late_night|promotional|public_service_announcement|locally_produced|economic_burden|interstitial_material|secondary_audio — promote to reference product]. Valid values are `primarily_textual|late_night|promotional|public_service_announcement|locally_produced|economic_burden`',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the language of the closed captions.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this closed caption compliance record was last updated or modified.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the closed caption compliance record, quality issues, or special circumstances.',
    `program_duration_minutes` STRING COMMENT 'Total duration of the program in minutes for which captioning compliance is being tracked.',
    `program_title` STRING COMMENT 'The title of the program that was captioned as it appeared in the broadcast schedule.',
    `regulatory_filing_date` DATE COMMENT 'Date when the caption compliance record was filed with the regulatory authority.',
    `regulatory_filing_required` BOOLEAN COMMENT 'Indicates whether this caption record requires formal filing with regulatory authorities such as FCC or Ofcom.',
    `remediation_completed_date` DATE COMMENT 'Date when remediation actions to correct captioning issues were completed.',
    `remediation_description` STRING COMMENT 'Detailed description of the remediation actions taken to address captioning compliance issues.',
    `remediation_status` STRING COMMENT 'Current status of remediation efforts to address captioning deficiencies or complaints.. Valid values are `not_required|pending|in_progress|completed|failed`',
    CONSTRAINT pk_closed_caption_record PRIMARY KEY(`closed_caption_record_id`)
) COMMENT 'Compliance record for closed captioning obligations under FCC rules (47 CFR §79.1) and Ofcom requirements. Tracks program title, air date, channel, caption file format (SRT, SCC, TTML, WebVTT), caption accuracy score, caption latency (for live programming), caption completeness percentage, complaint reference, remediation status, and exemption basis if applicable. Supports FCC caption quality standards and complaint response workflows.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` (
    `accessibility_obligation_id` BIGINT COMMENT 'Unique identifier for the accessibility compliance obligation record.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Accessibility obligations may be license-specific (e.g., closed captioning requirements vary by license type and market). This FK enables tracking which obligations apply to which licenses.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: accessibility_obligation is a domain-specific instantiation of a broader regulatory_obligation (e.g., ADA, CVAA, FCC accessibility rules). The regulatory_obligation master catalog contains regulation_',
    `compliance_deadline` DATE COMMENT 'Date by which the organization must achieve full compliance with this accessibility obligation.',
    `compliance_percentage` DECIMAL(18,2) COMMENT 'Percentage of content or platform features currently meeting this accessibility obligation (0.00 to 100.00), used for tracking progress toward full compliance.',
    `compliance_status` STRING COMMENT 'Current state of the organizations compliance with this obligation: compliant (fully meeting requirements), non-compliant (failing to meet requirements), in progress (actively working toward compliance), not started (no action taken), exempt (obligation does not apply), or waiver granted (temporary or permanent exemption approved by regulator).. Valid values are `compliant|non_compliant|in_progress|not_started|exempt|waiver_granted`',
    `content_type_applicability` STRING COMMENT 'Types of content to which this obligation applies (e.g., all programming, news and emergency information, pre-recorded entertainment, live events, user-generated content exclusions).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this accessibility obligation record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when this accessibility obligation became or will become legally binding on the organization.',
    `estimated_compliance_cost` DECIMAL(18,2) COMMENT 'Estimated total cost in USD to achieve full compliance with this obligation, including technology implementation, content remediation, training, and ongoing operational costs.',
    `exemption_reason` STRING COMMENT 'Explanation of why this obligation does not apply to the organization or why a waiver was granted (e.g., content category exemption, undue burden waiver, technical infeasibility).',
    `expiration_date` DATE COMMENT 'Date when this obligation ceases to apply, if applicable (null for ongoing obligations).',
    `geographic_jurisdiction` STRING COMMENT 'Three-letter ISO country code representing the jurisdiction where this obligation is enforceable (e.g., USA for FCC/CVAA, GBR for Ofcom, DEU for German regulations).. Valid values are `^[A-Z]{3}$`',
    `last_compliance_review_date` DATE COMMENT 'Date when the organization last conducted an internal review or audit of compliance with this accessibility obligation.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this accessibility obligation record was most recently modified.',
    `measurement_methodology` STRING COMMENT 'Method used to measure and verify compliance with this obligation (e.g., automated caption quality analysis, manual content audits, user testing, third-party accessibility audits).',
    `next_compliance_review_date` DATE COMMENT 'Scheduled date for the next internal review or audit of compliance with this accessibility obligation.',
    `notes` STRING COMMENT 'Additional notes, context, or special considerations related to this accessibility obligation (e.g., pending regulatory changes, coordination with other obligations, vendor dependencies).',
    `obligation_code` STRING COMMENT 'Business identifier code for the accessibility obligation, used for external reference and reporting.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `obligation_name` STRING COMMENT 'Human-readable name of the accessibility obligation (e.g., Closed Captioning for Linear Broadcast, Audio Description for VOD Content).',
    `obligation_type` STRING COMMENT 'Category of accessibility requirement: closed captioning (CC), audio description (AD), video description, emergency alert accessibility, online video player accessibility, or keyboard navigation compliance.. Valid values are `closed_captioning|audio_description|video_description|emergency_alert_accessibility|player_accessibility|keyboard_navigation`',
    `penalty_for_non_compliance` STRING COMMENT 'Description of regulatory penalties, fines, or sanctions that may be imposed for failure to meet this obligation (e.g., FCC forfeiture up to $100,000 per violation, Ofcom statutory sanctions, license suspension risk).',
    `priority_level` STRING COMMENT 'Business priority assigned to achieving compliance with this obligation: critical (regulatory deadline imminent or high penalty risk), high (significant regulatory or reputational risk), medium (standard compliance requirement), or low (minimal risk or long timeline).. Valid values are `critical|high|medium|low`',
    `regulation_section` STRING COMMENT 'Specific section, article, or clause of the regulation that mandates this obligation (e.g., 47 CFR 79.1, WCAG 2.1 Success Criterion 1.2.2).',
    `reporting_frequency` STRING COMMENT 'Frequency at which compliance status for this obligation must be reported to the regulator: annual, quarterly, monthly, on-demand (upon request), or not required.. Valid values are `annual|quarterly|monthly|on_demand|not_required`',
    `responsible_team` STRING COMMENT 'Name of the internal team, department, or business unit responsible for ensuring compliance with this obligation (e.g., Broadcast Operations, Digital Product, Legal Compliance, Content Production).',
    `scope` STRING COMMENT 'Distribution platform scope to which this obligation applies: linear broadcast, VOD (Video On Demand), SVOD (Subscription Video On Demand), AVOD (Advertising-Supported Video On Demand), TVOD (Transactional Video On Demand), OTT (Over-The-Top), FAST (Free Ad-Supported Streaming Television), MVPD (Multichannel Video Programming Distributor), vMVPD (Virtual Multichannel Video Programming Distributor), or all platforms. [ENUM-REF-CANDIDATE: linear|vod|svod|avod|tvod|ott|fast|mvpd|vmvpd|all_platforms — 10 candidates stripped; promote to reference product]',
    `target_compliance_percentage` DECIMAL(18,2) COMMENT 'Required percentage of content or platform features that must meet this accessibility obligation to achieve regulatory compliance (typically 100.00, but may be lower for phased implementation schedules).',
    `technical_standard` STRING COMMENT 'Technical standard or specification that defines how this accessibility feature must be implemented (e.g., CEA-608 for closed captioning, TTML for web captions, WCAG 2.1 AA for player accessibility).',
    `waiver_expiration_date` DATE COMMENT 'Date when a granted waiver or exemption expires and the obligation becomes enforceable again (null for permanent exemptions).',
    CONSTRAINT pk_accessibility_obligation PRIMARY KEY(`accessibility_obligation_id`)
) COMMENT 'Master record of accessibility compliance obligations applicable to the organizations content and platforms, including closed captioning, audio description (AD), video description, emergency alert accessibility, and online video player accessibility under CVAA, ADA, and Ofcom accessibility codes. Captures obligation type, applicable regulation, scope (linear, VOD, OTT), compliance deadline, responsible team, and current compliance status.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` (
    `eas_log_id` BIGINT COMMENT 'Unique identifier for the EAS log entry. Primary key for the EAS log record.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: EAS logs track Emergency Alert System activations for FCC-licensed broadcast stations. Each log entry relates to a specific broadcast license. This FK links the operational log to the license record.',
    `channel_id` BIGINT COMMENT 'Identifier of the broadcast station that received or transmitted the EAS alert.',
    `public_inspection_file_id` BIGINT COMMENT 'Foreign key linking to compliance.public_inspection_file. Business justification: eas_log has a public_inspection_file_entry (BOOLEAN) flag indicating whether the EAS log entry is included in the FCC public inspection file. Adding a direct FK to public_inspection_file normalizes th',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: eas_log records FCC-mandated Emergency Alert System activations and tests. EAS compliance events can generate formal regulatory filings (e.g., EAS test reports submitted to the FCC). Adding a FK to re',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_calendar. Business justification: Scheduled EAS tests are tracked in the compliance calendar. This FK links each EAS log entry to the calendar entry for the scheduled test, enabling verification that required tests were performed on t',
    `alert_duration_seconds` STRING COMMENT 'Duration of the EAS alert transmission in seconds, from start to end of the alert message.',
    `alert_text` STRING COMMENT 'Full text content of the EAS alert message that was transmitted or received, including any instructions to the public.',
    `alert_timestamp` TIMESTAMP COMMENT 'Date and time when the EAS alert was activated or received by the station. This is the principal business event timestamp for the alert.',
    `alert_type` STRING COMMENT 'Classification of the EAS alert by geographic scope: national emergency, state emergency, local emergency, or test alert.. Valid values are `national|state|local|test`',
    `attention_signal_transmitted` BOOLEAN COMMENT 'Indicates whether the two-tone attention signal was transmitted as part of the EAS alert.',
    `audio_message_transmitted` BOOLEAN COMMENT 'Indicates whether the audio message portion of the EAS alert was transmitted.',
    `cap_message_received` BOOLEAN COMMENT 'Indicates whether the alert was received in Common Alerting Protocol (CAP) format via IPAWS or other digital alert system.',
    `compliance_status` STRING COMMENT 'Compliance status of the EAS alert or test: compliant (met all requirements), missed (alert not transmitted), late (transmitted after required time), or failed (technical failure).. Valid values are `compliant|missed|late|failed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this EAS log record was first created in the system for audit and compliance tracking.',
    `end_of_message_transmitted` BOOLEAN COMMENT 'Indicates whether the End of Message (EOM) code was transmitted to signal completion of the EAS alert.',
    `equipment_used` STRING COMMENT 'Description or model identifier of the EAS equipment (encoder/decoder) used to process and transmit the alert.',
    `event_code` STRING COMMENT 'Three-letter EAS event code identifying the nature of the emergency (e.g., EAN for Emergency Action Notification, RWT for Required Weekly Test, RMT for Required Monthly Test, TOR for Tornado Warning).. Valid values are `^[A-Z]{3}$`',
    `failure_reason` STRING COMMENT 'Detailed explanation of why an EAS alert transmission failed or was missed, including technical or operational reasons.',
    `ipaws_message_code` STRING COMMENT 'Unique message identifier from FEMA IPAWS system for alerts originated through the national alert infrastructure.',
    `location_code` STRING COMMENT 'Six-digit FIPS code identifying the geographic area affected by the alert (county or equivalent subdivision).. Valid values are `^[0-9]{6}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this EAS log record was last modified, supporting audit trail requirements.',
    `notes` STRING COMMENT 'Free-form notes entered by station personnel regarding the EAS alert, including any special circumstances, corrective actions taken, or follow-up required.',
    `originator_code` STRING COMMENT 'Three-letter code identifying the entity that originated the alert (e.g., PEP for Primary Entry Point, CIV for Civil Authority, WXR for National Weather Service, EAS for EAS Participant).. Valid values are `^[A-Z]{3}$`',
    `originator_name` STRING COMMENT 'Full name of the authority or organization that originated the EAS alert (e.g., FEMA IPAWS, National Weather Service, State Emergency Management Agency).',
    `relay_chain_position` STRING COMMENT 'Position of this station in the EAS relay chain, indicating how many hops the alert has traveled from the originator (1 for direct receipt, 2+ for relayed).',
    `retention_expiry_date` DATE COMMENT 'Date when this EAS log record is eligible for deletion based on FCC retention requirements (minimum 2 years for EAS logs).',
    `test_compliance_type` STRING COMMENT 'Type of EAS test compliance this log entry satisfies: Required Weekly Test (RWT), Required Monthly Test (RMT), National Periodic Test, or none if not a test.. Valid values are `required_weekly_test|required_monthly_test|national_periodic_test|none`',
    `test_scheduled_date` DATE COMMENT 'Date when the EAS test was scheduled to occur, used for tracking compliance with required weekly and monthly test schedules.',
    `transmission_status` STRING COMMENT 'Status of the EAS alert transmission indicating whether the station successfully transmitted, received, relayed, failed to transmit, or missed the alert.. Valid values are `transmitted|received|relayed|failed|missed`',
    `upstream_source_callsign` STRING COMMENT 'Call sign of the upstream station or source from which this station received the EAS alert for relay.',
    `valid_time_period` STRING COMMENT 'Four-digit code indicating the valid time period for the alert in 15-minute increments (e.g., 0030 for 30 minutes, 0100 for 1 hour).. Valid values are `^[0-9]{4}$`',
    CONSTRAINT pk_eas_log PRIMARY KEY(`eas_log_id`)
) COMMENT 'Operational log of Emergency Alert System (EAS) activations and tests for FCC-licensed broadcast stations. Captures alert type (national, state, local), alert originator (FEMA IPAWS, NWS, state/local authority), activation timestamp, relay chain, transmission status, duration, required monthly/weekly test compliance, and any missed alert incidents. Required under FCC 47 CFR Part 11 for all EAS participants.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` (
    `political_ad_record_id` BIGINT COMMENT 'Unique identifier for the political advertising compliance record. Primary key for tracking FCC political broadcasting obligations under 47 CFR §73.1940-73.1942.',
    `ad_order_id` BIGINT COMMENT 'Reference to the advertising sales order in the traffic system that originated this political ad placement.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Political ad records are tied to specific broadcast licenses under FCC political broadcasting rules. The record has broadcast_station_call_sign which should be replaced by FK to broadcast_license to g',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: FCC political file compliance requires tracking the exact content version (creative) of each political ad aired. Linking political_ad_record to the specific content version enables compliance teams to',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Political ad records must identify the buying partner/agency for FCC public inspection file disclosure and reasonable access/equal time administration. The advertiser entity (campaign, PAC, party comm',
    `public_inspection_file_id` BIGINT COMMENT 'Foreign key linking to compliance.public_inspection_file. Business justification: Political ad records must be included in the stations public inspection file per FCC rules. This FK links each political ad record to its corresponding public file document, ensuring disclosure compl',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: political_ad_record tracks compliance under FCC political broadcasting rules (47 CFR §73.1940, §73.1941, §73.1943). These rules are entries in the regulatory_obligation master catalog. Adding this FK ',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Political ads featuring talent require disclosure of talent identity, compensation, and sponsorship identification in public inspection files. Ad clearance teams document talent appearing in political',
    `advertiser_type` STRING COMMENT 'Classification of the political advertiser entity type for regulatory reporting and rate determination purposes.. Valid values are `candidate|political_party|pac|super_pac|issue_advocacy|ballot_measure`',
    `affidavit_issued_flag` BOOLEAN COMMENT 'Indicates whether a broadcast affidavit (proof of performance) has been issued to the advertiser confirming that this political ad aired as scheduled.',
    `air_date` DATE COMMENT 'Calendar date on which the political advertisement was broadcast or is scheduled to broadcast.',
    `air_time` TIMESTAMP COMMENT 'Precise timestamp when the political advertisement aired or is scheduled to air, including time zone. Required for public inspection file and affidavit of performance.',
    `candidate_name` STRING COMMENT 'Name of the political candidate featured or referenced in the advertisement, if applicable. Null for issue advocacy ads without candidate reference.',
    `compliance_notes` STRING COMMENT 'Free-text field for documenting compliance issues, remediation actions, equal opportunities requests, reasonable access determinations, or other regulatory notes related to this political ad placement.',
    `compliance_status` STRING COMMENT 'Current regulatory compliance status of this political ad record indicating whether all FCC political broadcasting requirements have been met.. Valid values are `compliant|pending_review|non_compliant|remediated`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this political ad compliance record was first created in the system. Part of audit trail for regulatory record-keeping.',
    `daypart` STRING COMMENT 'Broadcast daypart segment during which the ad aired (e.g., Prime Time, Early Morning, Late Fringe). Used for rate class determination and Lowest Unit Charge (LUC) comparison.',
    `election_date` DATE COMMENT 'Scheduled date of the election to which this political advertisement relates. Critical for determining Lowest Unit Charge (LUC) period applicability (45 days before primary, 60 days before general election).',
    `election_type` STRING COMMENT 'Type of election for which the political advertisement is being aired.. Valid values are `primary|general|special|runoff|recall`',
    `equal_opportunities_request_flag` BOOLEAN COMMENT 'Indicates whether this ad placement was triggered by an equal opportunities request under Section 315 of the Communications Act, requiring equal treatment of opposing candidates.',
    `isci_code` STRING COMMENT 'Industry Standard Commercial Identification code uniquely identifying the creative asset aired. Standard 12-character alphanumeric code used for ad tracking and affidavit verification.. Valid values are `^[A-Z]{4}[0-9]{4}[A-Z0-9]{4}$`',
    `jurisdiction_level` STRING COMMENT 'Governmental jurisdiction level of the race or ballot measure (federal, state, or local) for compliance categorization and public file organization.. Valid values are `federal|state|local`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this political ad compliance record. Tracks changes for audit and compliance verification purposes.',
    `luc_period_flag` BOOLEAN COMMENT 'Indicates whether this ad aired during the Lowest Unit Charge (LUC) period (45 days before primary or 60 days before general election) when special rate protections apply to candidate ads.',
    `luc_rate` DECIMAL(18,2) COMMENT 'The lowest unit charge rate applicable to this spot based on the rate class and daypart during the pre-election window (45 days before primary, 60 days before general election). Null if outside LUC period.',
    `makegood_flag` BOOLEAN COMMENT 'Indicates whether this ad spot is a compensatory makegood placement provided due to a previous preemption or technical failure.',
    `market_name` STRING COMMENT 'Designated Market Area (DMA) or Nielsen market name where the political advertisement aired. Used for geographic compliance tracking.',
    `office_sought` STRING COMMENT 'The elected office or ballot measure that the political advertisement relates to (e.g., President, U.S. Senate, Governor, State Representative, Proposition 22).',
    `preemption_flag` BOOLEAN COMMENT 'Indicates whether this scheduled political ad spot was preempted and did not air as originally scheduled. Triggers makegood obligations.',
    `program_name` STRING COMMENT 'Name of the television or radio program during which the political advertisement aired. Required for public file disclosure.',
    `public_file_disclosure_date` DATE COMMENT 'Date when this political ad record was uploaded to the stations online public inspection file as required by FCC rules. Must occur immediately upon ad placement.',
    `rate_charged` DECIMAL(18,2) COMMENT 'Actual dollar amount charged to the political advertiser for this spot placement. Must comply with Lowest Unit Charge (LUC) requirements during pre-election windows.',
    `rate_class` STRING COMMENT 'Commercial rate classification applied to this spot (e.g., Fixed, Preemptible-1, Preemptible-2, Run-of-Schedule). Determines Lowest Unit Charge (LUC) eligibility and comparison group.',
    `reasonable_access_request_flag` BOOLEAN COMMENT 'Indicates whether this ad placement was the result of a federal candidate reasonable access request under Section 312(a)(7) of the Communications Act, requiring broadcasters to provide reasonable access to federal candidates.',
    `sponsor_address` STRING COMMENT 'Mailing address of the political advertiser or sponsor. Required for public inspection file disclosure.',
    `sponsor_contact_name` STRING COMMENT 'Name of the individual or organization contact person responsible for the political advertisement purchase. Required for public file records.',
    `sponsor_email` STRING COMMENT 'Email address of the political advertiser or sponsor contact for correspondence and compliance communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sponsor_phone` STRING COMMENT 'Contact telephone number for the political advertiser or sponsor. Required for public file records.',
    `sponsorship_identification` STRING COMMENT 'The on-air sponsorship disclosure statement identifying who paid for the advertisement (e.g., Paid for by Committee to Elect Jane Smith). Required by FCC sponsorship identification rules.',
    `spot_length_seconds` STRING COMMENT 'Duration of the political advertisement spot in seconds (e.g., 15, 30, 60, 120). Used for rate calculation and inventory management.',
    CONSTRAINT pk_political_ad_record PRIMARY KEY(`political_ad_record_id`)
) COMMENT 'Compliance record for political advertising under FCC political broadcasting rules (47 CFR §73.1940, §73.1941, §73.1942). Tracks candidate or issue advertiser, federal/state/local race, lowest unit charge (LUC) rate applied, equal opportunities requests, reasonable access requests, sponsorship identification, air date and time, and public file disclosure. Mandatory for all FCC-licensed stations during election periods.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` (
    `regulatory_obligation_id` BIGINT COMMENT 'Unique identifier for the regulatory obligation record. Primary key.',
    `superseded_by_obligation_regulatory_obligation_id` BIGINT COMMENT 'Reference to the regulatory obligation that supersedes this one, if applicable. Null if not superseded.',
    `applicability_scope` STRING COMMENT 'Business units, platforms, or services to which this obligation applies (e.g., linear TV, OTT platforms, radio, digital publishers, SVOD services, AVOD platforms, FAST channels).',
    `audit_trail_required` BOOLEAN COMMENT 'Indicates whether an audit trail of compliance activities and decisions must be maintained for this obligation.',
    `automation_status` STRING COMMENT 'Degree to which compliance monitoring and reporting for this obligation is automated: manual, partially automated, fully automated, or not applicable.. Valid values are `manual|partially_automated|fully_automated|not_applicable`',
    `compliance_frequency` STRING COMMENT 'How often compliance with this obligation must be demonstrated or reported: ongoing (continuous), annual, quarterly, monthly, event-driven (triggered by specific events), or biennial.. Valid values are `ongoing|annual|quarterly|monthly|event_driven|biennial`',
    `compliance_status` STRING COMMENT 'Current compliance status of the organization with respect to this obligation: compliant, non-compliant, in progress, not applicable, under review, or remediation required.. Valid values are `compliant|non_compliant|in_progress|not_applicable|under_review|remediation_required`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory obligation record was first created in the system.',
    `documentation_required` BOOLEAN COMMENT 'Indicates whether formal documentation, records, or evidence must be maintained to demonstrate compliance with this obligation.',
    `documentation_retention_years` STRING COMMENT 'Number of years that compliance documentation must be retained, as mandated by the regulation or internal policy.',
    `effective_date` DATE COMMENT 'Date when this regulatory obligation became or becomes effective and enforceable.',
    `expiration_date` DATE COMMENT 'Date when this obligation expires or is superseded, if applicable. Null for ongoing obligations.',
    `external_reporting_required` BOOLEAN COMMENT 'Indicates whether compliance with this obligation requires formal reporting or filing to an external regulatory body.',
    `filing_deadline_description` STRING COMMENT 'Human-readable description of the filing deadline (e.g., April 1 annually, 10 days after broadcast, within 30 days of license expiration).',
    `filing_deadline_type` STRING COMMENT 'Type of deadline for compliance filing or reporting: fixed date (specific calendar date), rolling (X days from event), event-based (triggered by business event), or not applicable.. Valid values are `fixed_date|rolling|event_based|not_applicable`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this regulatory obligation is currently active and enforceable. False if the obligation has been superseded, repealed, or is no longer applicable.',
    `jurisdiction` STRING COMMENT 'Geographic jurisdiction where this obligation applies, using 3-letter ISO country code (e.g., USA, GBR, DEU) or regional code (e.g., EUR for EU-wide regulations).. Valid values are `^[A-Z]{3}$`',
    `last_compliance_review_date` DATE COMMENT 'Date when compliance with this obligation was last reviewed or assessed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory obligation record was last updated or modified.',
    `maximum_penalty_amount` DECIMAL(18,2) COMMENT 'Maximum monetary penalty or fine amount that can be imposed for non-compliance, in the currency specified.',
    `monitoring_system` STRING COMMENT 'Name of the system or tool used to monitor compliance with this obligation (e.g., GRC platform, compliance management system, manual tracking).',
    `next_compliance_review_date` DATE COMMENT 'Scheduled date for the next compliance review or assessment of this obligation.',
    `notes` STRING COMMENT 'Additional notes, comments, or context about this regulatory obligation, including implementation guidance or special considerations.',
    `obligation_code` STRING COMMENT 'Unique business identifier code for the regulatory obligation, used for external reference and reporting.. Valid values are `^[A-Z0-9]{4,20}$`',
    `obligation_description` STRING COMMENT 'Detailed description of the regulatory obligation, including what must be done, reported, or maintained to achieve compliance.',
    `obligation_name` STRING COMMENT 'Short descriptive name of the regulatory obligation.',
    `obligation_type` STRING COMMENT 'Category of regulatory obligation: licensing (broadcast licenses, spectrum), content standards (ratings, COPPA), data privacy (GDPR, CCPA), financial reporting (SOX), accessibility (closed captioning), or technical standards (ATSC, DVB).. Valid values are `licensing|content_standards|data_privacy|financial_reporting|accessibility|technical_standards`',
    `penalty_currency` STRING COMMENT 'Currency code for the penalty amount, using ISO 4217 3-letter code (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `penalty_description` STRING COMMENT 'Description of penalties, fines, or sanctions that may be imposed for non-compliance with this obligation.',
    `public_disclosure_required` BOOLEAN COMMENT 'Indicates whether compliance information or related documents must be made publicly available (e.g., in FCC Online Public Inspection File).',
    `regulation_name` STRING COMMENT 'Full name of the regulation, law, or standard that mandates this obligation (e.g., Communications Act Section 73, GDPR Article 30, SOX Section 404).',
    `regulation_reference_number` STRING COMMENT 'Official citation or reference number of the regulation (e.g., 47 CFR 73.3526, GDPR Art. 30, SOX §404).',
    `regulatory_body` STRING COMMENT 'Name of the governing body or agency that enforces this obligation (e.g., FCC, Ofcom, European Audiovisual Observatory, MPA, Nielsen, IAB, SCTE, ISO).',
    `responsible_department` STRING COMMENT 'Department or business unit accountable for this obligation (e.g., Legal, Compliance, Broadcast Operations, Finance, IT Security).',
    `risk_level` STRING COMMENT 'Assessed risk level of non-compliance with this obligation, based on potential business impact, regulatory scrutiny, and penalty severity.. Valid values are `critical|high|medium|low`',
    CONSTRAINT pk_regulatory_obligation PRIMARY KEY(`regulatory_obligation_id`)
) COMMENT 'Master catalog of all regulatory obligations applicable to the organization, mapped to specific regulations, governing bodies, and business units. Captures obligation type, regulation name, regulatory body, jurisdiction, obligation description, applicability scope (linear TV, OTT, radio, digital), compliance frequency (ongoing, annual, quarterly, event-driven), responsible owner, and current compliance status. Serves as the compliance obligation register.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ADD CONSTRAINT `fk_compliance_license_renewal_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ADD CONSTRAINT `fk_compliance_license_renewal_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ADD CONSTRAINT `fk_compliance_license_renewal_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_original_filing_regulatory_filing_id` FOREIGN KEY (`original_filing_regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ADD CONSTRAINT `fk_compliance_public_inspection_file_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ADD CONSTRAINT `fk_compliance_public_inspection_file_original_document_public_inspection_file_id` FOREIGN KEY (`original_document_public_inspection_file_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file`(`public_inspection_file_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ADD CONSTRAINT `fk_compliance_public_inspection_file_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ADD CONSTRAINT `fk_compliance_content_rating_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_public_inspection_file_id` FOREIGN KEY (`public_inspection_file_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file`(`public_inspection_file_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ADD CONSTRAINT `fk_compliance_accessibility_obligation_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ADD CONSTRAINT `fk_compliance_accessibility_obligation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ADD CONSTRAINT `fk_compliance_eas_log_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ADD CONSTRAINT `fk_compliance_eas_log_public_inspection_file_id` FOREIGN KEY (`public_inspection_file_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file`(`public_inspection_file_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ADD CONSTRAINT `fk_compliance_eas_log_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ADD CONSTRAINT `fk_compliance_eas_log_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_public_inspection_file_id` FOREIGN KEY (`public_inspection_file_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file`(`public_inspection_file_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_superseded_by_obligation_regulatory_obligation_id` FOREIGN KEY (`superseded_by_obligation_regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` SET TAGS ('dbx_subdomain' = 'license_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Equipment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `annual_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Regulatory Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `antenna_height_meters` SET TAGS ('dbx_business_glossary_term' = 'Antenna Height Above Average Terrain (HAAT) in Meters');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `broadcast_license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `call_sign` SET TAGS ('dbx_business_glossary_term' = 'Call Sign');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `call_sign` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,4}(-[A-Z]{2})?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `channel_number` SET TAGS ('dbx_business_glossary_term' = 'Channel Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `closed_captioning_required` SET TAGS ('dbx_business_glossary_term' = 'Closed Captioning Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `community_of_license` SET TAGS ('dbx_business_glossary_term' = 'Community of License');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `compliance_obligations` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligations');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `coverage_area_contour` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area Contour');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `eas_participation_required` SET TAGS ('dbx_business_glossary_term' = 'Emergency Alert System (EAS) Participation Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'License Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `frequency_band` SET TAGS ('dbx_business_glossary_term' = 'Frequency Band');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `grant_date` SET TAGS ('dbx_business_glossary_term' = 'License Grant Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Regulatory Inspection Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `last_modification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `license_class` SET TAGS ('dbx_business_glossary_term' = 'License Class');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `licensee_type` SET TAGS ('dbx_business_glossary_term' = 'Licensee Entity Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `licensee_type` SET TAGS ('dbx_value_regex' = 'Corporation|Partnership|Individual|Non-Profit|Government|Trust');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `modification_type` SET TAGS ('dbx_business_glossary_term' = 'Modification Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'License Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `ownership_attribution` SET TAGS ('dbx_business_glossary_term' = 'Ownership Attribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `power_output_erp_watts` SET TAGS ('dbx_business_glossary_term' = 'Effective Radiated Power (ERP) in Watts');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `public_inspection_file_location` SET TAGS ('dbx_business_glossary_term' = 'Public Inspection File Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `renewal_application_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Application Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'License Renewal Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'Not Due|Renewal Filed|Renewal Pending|Renewal Granted|Renewal Denied');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'Commercial|Non-Commercial Educational|Public|Community|Religious|Government');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `transmitter_address` SET TAGS ('dbx_business_glossary_term' = 'Transmitter Physical Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `transmitter_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `transmitter_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `transmitter_location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Transmitter Location Latitude');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `transmitter_location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `transmitter_location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `transmitter_location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Transmitter Location Longitude');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `transmitter_location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `transmitter_location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` SET TAGS ('dbx_subdomain' = 'license_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `license_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'License Renewal Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `compliance_certification_submitted` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Submitted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `conditions_imposed` SET TAGS ('dbx_business_glossary_term' = 'Renewal Conditions Imposed');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `denial_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Denial Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `fee_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `fee_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `fee_payment_status` SET TAGS ('dbx_value_regex' = 'Pending|Paid|Waived|Refunded');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `filing_deadline` SET TAGS ('dbx_business_glossary_term' = 'Renewal Filing Deadline');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `final_disposition` SET TAGS ('dbx_business_glossary_term' = 'Final Disposition');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `final_disposition` SET TAGS ('dbx_value_regex' = 'Granted|Granted with Conditions|Denied|Withdrawn|Dismissed');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'Television|Radio|Cable|Satellite|MVPD|Other');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `new_license_term_end_date` SET TAGS ('dbx_business_glossary_term' = 'New License Term End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `new_license_term_start_date` SET TAGS ('dbx_business_glossary_term' = 'New License Term Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Renewal Application Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `petition_count` SET TAGS ('dbx_business_glossary_term' = 'Petition Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `petition_to_deny_filed` SET TAGS ('dbx_business_glossary_term' = 'Petition to Deny Filed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `public_comment_deadline` SET TAGS ('dbx_business_glossary_term' = 'Public Comment Deadline');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `public_inspection_file_updated` SET TAGS ('dbx_business_glossary_term' = 'Public Inspection File Updated Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `public_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Publication Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FCC|Ofcom|CRTC|ACMA|Other');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `renewal_cycle_end_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Cycle End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `renewal_cycle_start_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Cycle Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `renewal_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `renewal_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `renewal_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Application Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Completion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `original_filing_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Original Filing Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Equipment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `amendment_flag` SET TAGS ('dbx_business_glossary_term' = 'Amendment Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `ccpa_applicable` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'broadcast_licensing|content_standards|data_privacy|financial_reporting|accessibility|technical_standards');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `coppa_applicable` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_description` SET TAGS ('dbx_business_glossary_term' = 'Filing Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `form_number` SET TAGS ('dbx_business_glossary_term' = 'Form Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `market_designation` SET TAGS ('dbx_business_glossary_term' = 'Market Designation');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `next_filing_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Filing Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `payment_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Confirmation Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `public_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Public Inspection Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `sox_applicable` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'online_portal|email|postal_mail|fax|electronic_filing_system|api');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `public_inspection_file_id` SET TAGS ('dbx_business_glossary_term' = 'Public Inspection File ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Station ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `original_document_public_inspection_file_id` SET TAGS ('dbx_business_glossary_term' = 'Original Document ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `document_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `document_category` SET TAGS ('dbx_value_regex' = 'political_file|eeo_reports|ownership_reports|issues_programs_lists|childrens_programming_reports|contour_maps');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `document_file_format` SET TAGS ('dbx_business_glossary_term' = 'Document File Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `document_file_format` SET TAGS ('dbx_value_regex' = 'pdf|docx|xlsx|txt|html|xml');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `document_file_path` SET TAGS ('dbx_business_glossary_term' = 'Document File Path');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `document_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `document_file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Document File Size Bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `document_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Document Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `document_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Document Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `fcc_opif_sync_status` SET TAGS ('dbx_business_glossary_term' = 'Federal Communications Commission (FCC) Online Public Inspection File (OPIF) Sync Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `fcc_opif_sync_status` SET TAGS ('dbx_value_regex' = 'not_synced|synced|sync_failed|sync_pending');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `fcc_opif_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Federal Communications Commission (FCC) Online Public Inspection File (OPIF) Sync Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `fcc_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Communications Commission (FCC) Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `is_amendment` SET TAGS ('dbx_business_glossary_term' = 'Is Amendment');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `political_advertiser_name` SET TAGS ('dbx_business_glossary_term' = 'Political Advertiser Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `political_office_sought` SET TAGS ('dbx_business_glossary_term' = 'Political Office Sought');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `public_access_status` SET TAGS ('dbx_business_glossary_term' = 'Public Access Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `public_access_status` SET TAGS ('dbx_value_regex' = 'available|restricted|pending_review|removed');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `retention_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `upload_status` SET TAGS ('dbx_business_glossary_term' = 'Upload Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `upload_status` SET TAGS ('dbx_value_regex' = 'pending|uploaded|verified|rejected|archived');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `upload_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Upload Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|verified|requires_correction|corrected');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` SET TAGS ('dbx_subdomain' = 'content_standards');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `accessibility_rating_notes` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Rating Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_appealed|appeal_pending|appeal_approved|appeal_denied');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `content_descriptors` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptors');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `coppa_compliant` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Compliant');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `drug_use_descriptor` SET TAGS ('dbx_business_glossary_term' = 'Drug Use Descriptor');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `eidr_code` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `eidr_code` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `language_descriptor` SET TAGS ('dbx_business_glossary_term' = 'Language Descriptor');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `minimum_age` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `parental_guidance_required` SET TAGS ('dbx_business_glossary_term' = 'Parental Guidance Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `previous_rating_value` SET TAGS ('dbx_business_glossary_term' = 'Previous Rating Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `rating_authority` SET TAGS ('dbx_business_glossary_term' = 'Rating Authority');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `rating_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Rating Certificate Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `rating_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `rating_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `rating_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Rating Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `rating_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Rating Fee Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `rating_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `rating_notes` SET TAGS ('dbx_business_glossary_term' = 'Rating Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `rating_reason` SET TAGS ('dbx_business_glossary_term' = 'Rating Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `rating_review_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `rating_status` SET TAGS ('dbx_business_glossary_term' = 'Rating Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `rating_status` SET TAGS ('dbx_value_regex' = 'active|expired|revoked|pending|under_review');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `rating_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Submission Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `rating_system` SET TAGS ('dbx_business_glossary_term' = 'Rating System');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `rating_type` SET TAGS ('dbx_business_glossary_term' = 'Rating Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `rating_type` SET TAGS ('dbx_value_regex' = 'theatrical|television|home_video|streaming|broadcast');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `rating_value` SET TAGS ('dbx_business_glossary_term' = 'Rating Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `rating_version` SET TAGS ('dbx_business_glossary_term' = 'Rating Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `sexual_content_descriptor` SET TAGS ('dbx_business_glossary_term' = 'Sexual Content Descriptor');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `violence_descriptor` SET TAGS ('dbx_business_glossary_term' = 'Violence Descriptor');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` SET TAGS ('dbx_subdomain' = 'content_standards');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `closed_caption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Record ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Caption Vendor Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Encoder Config Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `public_inspection_file_id` SET TAGS ('dbx_business_glossary_term' = 'Public Inspection File Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `air_date` SET TAGS ('dbx_business_glossary_term' = 'Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `air_time` SET TAGS ('dbx_business_glossary_term' = 'Air Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `caption_accuracy_score` SET TAGS ('dbx_business_glossary_term' = 'Caption Accuracy Score');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `caption_completeness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Caption Completeness Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `caption_file_format` SET TAGS ('dbx_business_glossary_term' = 'Caption File Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `caption_latency_seconds` SET TAGS ('dbx_business_glossary_term' = 'Caption Latency Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `caption_placement_compliance` SET TAGS ('dbx_business_glossary_term' = 'Caption Placement Compliance');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `caption_quality_review_date` SET TAGS ('dbx_business_glossary_term' = 'Caption Quality Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `caption_synchronization_compliance` SET TAGS ('dbx_business_glossary_term' = 'Caption Synchronization Compliance');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `caption_type` SET TAGS ('dbx_business_glossary_term' = 'Caption Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `caption_type` SET TAGS ('dbx_value_regex' = 'live|pre_recorded|real_time|offline');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `captioned_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Captioned Duration Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `complaint_received_date` SET TAGS ('dbx_business_glossary_term' = 'Complaint Received Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `complaint_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Complaint Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `complaint_type` SET TAGS ('dbx_business_glossary_term' = 'Complaint Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `complaint_type` SET TAGS ('dbx_value_regex' = 'accuracy|completeness|placement|synchronization|availability|latency');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|remediated|exempt');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `exemption_basis` SET TAGS ('dbx_business_glossary_term' = 'Exemption Basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `exemption_category` SET TAGS ('dbx_business_glossary_term' = 'Exemption Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `exemption_category` SET TAGS ('dbx_value_regex' = 'primarily_textual|late_night|promotional|public_service_announcement|locally_produced|economic_burden');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `program_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Program Duration Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `program_title` SET TAGS ('dbx_business_glossary_term' = 'Program Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `remediation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `remediation_description` SET TAGS ('dbx_business_glossary_term' = 'Remediation Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|failed');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` SET TAGS ('dbx_subdomain' = 'content_standards');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `compliance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Compliance Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|in_progress|not_started|exempt|waiver_granted');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `content_type_applicability` SET TAGS ('dbx_business_glossary_term' = 'Content Type Applicability');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Obligation Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `estimated_compliance_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Compliance Cost');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `estimated_compliance_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Exemption Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Obligation Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `geographic_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `geographic_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `last_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `next_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Obligation Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Obligation Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'closed_captioning|audio_description|video_description|emergency_alert_accessibility|player_accessibility|keyboard_navigation');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `penalty_for_non_compliance` SET TAGS ('dbx_business_glossary_term' = 'Penalty for Non-Compliance');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `penalty_for_non_compliance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `regulation_section` SET TAGS ('dbx_business_glossary_term' = 'Regulation Section Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|on_demand|not_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `responsible_team` SET TAGS ('dbx_business_glossary_term' = 'Responsible Team');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Obligation Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `target_compliance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Compliance Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `technical_standard` SET TAGS ('dbx_business_glossary_term' = 'Technical Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `waiver_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` SET TAGS ('dbx_subdomain' = 'emergency_broadcasting');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `eas_log_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Alert System (EAS) Log ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Station ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `public_inspection_file_id` SET TAGS ('dbx_business_glossary_term' = 'Public Inspection File Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Calendar Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `alert_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Alert Duration in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `alert_text` SET TAGS ('dbx_business_glossary_term' = 'Alert Text Message');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `alert_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Activation Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `alert_type` SET TAGS ('dbx_business_glossary_term' = 'Alert Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `alert_type` SET TAGS ('dbx_value_regex' = 'national|state|local|test');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `attention_signal_transmitted` SET TAGS ('dbx_business_glossary_term' = 'Attention Signal Transmitted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `audio_message_transmitted` SET TAGS ('dbx_business_glossary_term' = 'Audio Message Transmitted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `cap_message_received` SET TAGS ('dbx_business_glossary_term' = 'Common Alerting Protocol (CAP) Message Received Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|missed|late|failed');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `end_of_message_transmitted` SET TAGS ('dbx_business_glossary_term' = 'End of Message (EOM) Transmitted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `equipment_used` SET TAGS ('dbx_business_glossary_term' = 'Equipment Used');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `event_code` SET TAGS ('dbx_business_glossary_term' = 'Event Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `event_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `ipaws_message_code` SET TAGS ('dbx_business_glossary_term' = 'Integrated Public Alert and Warning System (IPAWS) Message ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `originator_code` SET TAGS ('dbx_business_glossary_term' = 'Originator Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `originator_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `originator_name` SET TAGS ('dbx_business_glossary_term' = 'Originator Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `relay_chain_position` SET TAGS ('dbx_business_glossary_term' = 'Relay Chain Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `test_compliance_type` SET TAGS ('dbx_business_glossary_term' = 'Test Compliance Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `test_compliance_type` SET TAGS ('dbx_value_regex' = 'required_weekly_test|required_monthly_test|national_periodic_test|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `test_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Test Scheduled Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `transmission_status` SET TAGS ('dbx_business_glossary_term' = 'Transmission Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `transmission_status` SET TAGS ('dbx_value_regex' = 'transmitted|received|relayed|failed|missed');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `upstream_source_callsign` SET TAGS ('dbx_business_glossary_term' = 'Upstream Source Call Sign');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `valid_time_period` SET TAGS ('dbx_business_glossary_term' = 'Valid Time Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `valid_time_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` SET TAGS ('dbx_subdomain' = 'emergency_broadcasting');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `political_ad_record_id` SET TAGS ('dbx_business_glossary_term' = 'Political Ad Record ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `public_inspection_file_id` SET TAGS ('dbx_business_glossary_term' = 'Public Inspection File Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `advertiser_type` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `advertiser_type` SET TAGS ('dbx_value_regex' = 'candidate|political_party|pac|super_pac|issue_advocacy|ballot_measure');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `affidavit_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Issued Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `air_date` SET TAGS ('dbx_business_glossary_term' = 'Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `air_time` SET TAGS ('dbx_business_glossary_term' = 'Air Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `candidate_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `candidate_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `candidate_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|pending_review|non_compliant|remediated');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `election_date` SET TAGS ('dbx_business_glossary_term' = 'Election Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `election_type` SET TAGS ('dbx_business_glossary_term' = 'Election Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `election_type` SET TAGS ('dbx_value_regex' = 'primary|general|special|runoff|recall');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `equal_opportunities_request_flag` SET TAGS ('dbx_business_glossary_term' = 'Equal Opportunities Request Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `isci_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Standard Commercial Identification (ISCI) Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `isci_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[0-9]{4}[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `jurisdiction_level` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `jurisdiction_level` SET TAGS ('dbx_value_regex' = 'federal|state|local');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `luc_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Lowest Unit Charge (LUC) Period Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `luc_rate` SET TAGS ('dbx_business_glossary_term' = 'Lowest Unit Charge (LUC) Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `luc_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `makegood_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `market_name` SET TAGS ('dbx_business_glossary_term' = 'Market Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `office_sought` SET TAGS ('dbx_business_glossary_term' = 'Office Sought');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `preemption_flag` SET TAGS ('dbx_business_glossary_term' = 'Preemption Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `public_file_disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Public File Disclosure Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `rate_charged` SET TAGS ('dbx_business_glossary_term' = 'Rate Charged');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `rate_charged` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `rate_class` SET TAGS ('dbx_business_glossary_term' = 'Rate Class');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `reasonable_access_request_flag` SET TAGS ('dbx_business_glossary_term' = 'Reasonable Access Request Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `sponsor_address` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `sponsor_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `sponsor_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `sponsor_email` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `sponsor_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `sponsor_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `sponsor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `sponsor_phone` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `sponsor_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `sponsor_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `sponsorship_identification` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Identification');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Spot Length Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `superseded_by_obligation_regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Obligation ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicability Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `automation_status` SET TAGS ('dbx_business_glossary_term' = 'Automation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `automation_status` SET TAGS ('dbx_value_regex' = 'manual|partially_automated|fully_automated|not_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compliance Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_frequency` SET TAGS ('dbx_value_regex' = 'ongoing|annual|quarterly|monthly|event_driven|biennial');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|in_progress|not_applicable|under_review|remediation_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `documentation_required` SET TAGS ('dbx_business_glossary_term' = 'Documentation Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `documentation_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Documentation Retention Years');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `external_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `filing_deadline_description` SET TAGS ('dbx_business_glossary_term' = 'Filing Deadline Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `filing_deadline_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Deadline Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `filing_deadline_type` SET TAGS ('dbx_value_regex' = 'fixed_date|rolling|event_based|not_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `last_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `maximum_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Penalty Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `monitoring_system` SET TAGS ('dbx_business_glossary_term' = 'Monitoring System');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `next_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Obligation Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'licensing|content_standards|data_privacy|financial_reporting|accessibility|technical_standards');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `public_disclosure_required` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulation_name` SET TAGS ('dbx_business_glossary_term' = 'Regulation Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulation_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulation Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
