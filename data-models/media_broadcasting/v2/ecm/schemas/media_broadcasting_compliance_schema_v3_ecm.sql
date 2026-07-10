-- Schema for Domain: compliance | Business:  | Version: v3_ecm
-- Generated on: 2026-07-10 19:30:35

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`compliance` COMMENT 'Governs regulatory compliance obligations across broadcast licensing (FCC, Ofcom), content standards (MPA ratings, COPPA childrens content), data privacy (GDPR, CCPA), financial reporting (SOX), accessibility mandates, and technical standards (ATSC, DVB). Manages regulatory filings, license renewals, public inspection files, content clearance records, closed captioning compliance, consent management, and audit trails required by governing bodies.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` (
    `broadcast_license_id` BIGINT COMMENT 'Unique identifier for the broadcast license record. Primary key for the broadcast license entity.',
    `broadcast_facility_id` BIGINT COMMENT 'Unique facility identifier assigned by the regulatory authority to distinguish between multiple licenses held by the same licensee or at the same location.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: FCC broadcast licenses require a designated responsible party employee for regulatory accountability and correspondence. Licensee contact information should reference employee record rather than dupli',
    `transmission_equipment_id` BIGINT COMMENT 'Foreign key linking to technology.transmission_equipment. Business justification: FCC licenses authorize specific transmission equipment operation. Compliance audits require equipment-level tracking for power output, frequency, and technical parameter verification. Real-world Form ',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: FCC license renewals require named responsible employee for filing preparation and regulatory correspondence. Responsible party contact data should reference employee record.',
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
    `broadcast_facility_id` BIGINT COMMENT 'The unique facility identifier assigned by the regulatory body to the broadcast station or transmission facility covered by this filing.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Regulatory filings are often associated with specific broadcast licenses. The filing has license_number (STRING) which should be replaced by FK to broadcast_license. This allows joining to get call_si',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory filings (FCC Form 323, 396, etc.) require audit trail of which employee submitted the filing for compliance verification and accountability. Responsible party data should reference employee',
    `original_filing_regulatory_filing_id` BIGINT COMMENT 'Reference to the original regulatory filing identifier if this submission is an amendment or correction, establishing the lineage of filing revisions.',
    `transmission_equipment_id` BIGINT COMMENT 'Foreign key linking to technology.transmission_equipment. Business justification: FCC Form 301/302 filings reference specific transmission equipment for power changes, frequency modifications, and technical upgrades. Real regulatory filing workflow requires equipment-level granular',
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
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: FCC public inspection files may reference specific program assets for political advertising records, childrens programming reports (issues/programs lists), or sponsorship identification documentation',
    `original_document_public_inspection_file_id` BIGINT COMMENT 'If this is an amendment, reference to the original public inspection file document being amended or corrected.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Many regulatory filings must be included in the stations public inspection file. This FK links public file documents to their corresponding regulatory filing records, ensuring disclosure compliance.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: FCC public inspection file documents require audit trail of which employee uploaded each document for compliance verification and accountability. Compliance officer name should reference employee reco',
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
    `title_id` BIGINT COMMENT 'Reference to the content title asset that this rating applies to.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Broadcasters must track content ratings (TV-MA, TV-14, etc.) for every media asset to ensure FCC compliance, parental guidance requirements, and proper scheduling. Content rating is a regulatory attri',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Content rating submissions to MPAA, TV Parental Guidelines, or other rating authorities require tracking which employee submitted for accountability and audit trail purposes.',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` (
    `coppa_declaration_id` BIGINT COMMENT 'Unique identifier for the COPPA compliance declaration record.',
    `compliance_consent_record_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_record. Business justification: COPPA requires verifiable parental consent for childrens data collection. This FK links the COPPA declaration to the specific consent record that documents parental consent, supporting FTC compliance',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: COPPA declarations require named responsible party employee for legal accountability to FTC. Reviewer name should reference employee record rather than store as text.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: COPPA compliance requires broadcasters to declare whether specific media assets are directed at children under 13. This is a direct regulatory requirement for content classification, data collection p',
    `ott_platform_id` BIGINT COMMENT 'Identifier of the OTT platform or digital service on which the content is distributed. Relevant for streaming platforms carrying childrens programming.',
    `title_id` BIGINT COMMENT 'Identifier of the digital content, service, or platform subject to this COPPA declaration. Links to the content asset being evaluated for children-directed status.',
    `actual_knowledge_flag` BOOLEAN COMMENT 'Indicates whether the operator has actual knowledge that it is collecting personal information from children under 13, triggering COPPA compliance obligations regardless of directed-to-children status.',
    `advertising_assessment` STRING COMMENT 'Assessment of whether advertising or promotional materials are directed to children, including ad placement, messaging, and products advertised.',
    `audio_content_assessment` STRING COMMENT 'Assessment of audio elements (music, voice talent, sound effects) that may appeal to children, per FTC child-directed determination factors.',
    `audit_trail_reference` STRING COMMENT 'Reference to detailed audit trail or supporting documentation for the COPPA declaration, including assessment worksheets and evidence.',
    `child_celebrity_presence_flag` BOOLEAN COMMENT 'Indicates whether the content features child celebrities or characters that appeal to children, a factor in FTC child-directed determination.',
    `compliance_notes` STRING COMMENT 'Additional notes, observations, or context regarding the COPPA compliance assessment, including any mitigating factors or special considerations.',
    `consent_date` DATE COMMENT 'Date on which verifiable parental consent was obtained, if applicable. Must be maintained for audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the COPPA declaration record was first created in the system.',
    `data_collection_scope` STRING COMMENT 'Description of personal information collected from users, including identifiers, location data, photos, videos, audio recordings, and persistent identifiers for behavioral advertising.',
    `declaration_date` DATE COMMENT 'Date on which the COPPA declaration was formally made or submitted for review.',
    `declaration_number` STRING COMMENT 'Business identifier for the COPPA declaration, formatted as COPPA-YYYY-XXXXXXXX for external reference and audit tracking.. Valid values are `^COPPA-[0-9]{4}-[A-Z0-9]{8}$`',
    `declaration_status` STRING COMMENT 'Current lifecycle status of the COPPA declaration: draft (being prepared), active (in effect), under_review (legal/compliance review), approved (validated), rejected (non-compliant), expired (needs renewal), withdrawn (no longer applicable). [ENUM-REF-CANDIDATE: draft|active|under_review|approved|rejected|expired|withdrawn — 7 candidates stripped; promote to reference product]',
    `declaration_type` STRING COMMENT 'Type of digital asset being declared: content (video/audio program), service (subscription offering), platform (streaming service), website, mobile app, or interactive feature (games, social features).. Valid values are `content|service|platform|website|mobile_app|interactive_feature`',
    `directed_to_children_status` STRING COMMENT 'Determination of whether the content or service is directed to children under 13: directed (primary audience is children), mixed_audience (general audience including children), not_directed (not intended for children), under_review (assessment in progress).. Valid values are `directed|mixed_audience|not_directed|under_review`',
    `effective_date` DATE COMMENT 'Date from which the COPPA declaration and associated compliance measures become effective.',
    `expiration_date` DATE COMMENT 'Date on which the COPPA declaration expires and requires renewal or reassessment. Nullable for indefinite declarations.',
    `ftc_filing_reference` STRING COMMENT 'Reference number or identifier for any filings, notifications, or correspondence with the FTC regarding this COPPA declaration or compliance matter.',
    `legal_opinion_reference` STRING COMMENT 'Reference to any legal opinion, memo, or external counsel advice supporting the COPPA determination.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next compliance review or reassessment of the COPPA declaration.',
    `parental_consent_mechanism` STRING COMMENT 'Method used to obtain verifiable parental consent: email_plus (email plus additional verification), credit_card, toll_free (phone verification), video_conference, government_id, digital_certificate, not_required (content not directed to children), under_review. [ENUM-REF-CANDIDATE: email_plus|credit_card|toll_free|video_conference|government_id|digital_certificate|not_required|under_review — 8 candidates stripped; promote to reference product]',
    `persistent_identifier_collection_flag` BOOLEAN COMMENT 'Indicates whether persistent identifiers (cookies, device IDs, IP addresses) are collected for purposes other than internal operations, requiring parental consent under COPPA.',
    `privacy_policy_url` STRING COMMENT 'URL of the privacy policy that discloses data collection practices, parental rights, and COPPA compliance measures. Must be prominently displayed per COPPA requirements.',
    `review_date` DATE COMMENT 'Date of the most recent compliance review or reassessment of the COPPA declaration. Critical for demonstrating ongoing compliance diligence.',
    `reviewer_title` STRING COMMENT 'Job title or role of the reviewer (e.g., Chief Privacy Officer, Legal Counsel, Compliance Manager).',
    `safe_harbor_certification_number` STRING COMMENT 'Certification number or identifier issued by the safe harbor program, if applicable.',
    `safe_harbor_program` STRING COMMENT 'Name of the FTC-approved safe harbor program the operator participates in, if any (e.g., CARU, TRUSTe, iKeepSafe). Provides streamlined compliance pathway.',
    `subject_matter_description` STRING COMMENT 'Description of the contents subject matter, themes, and topics used to assess child-directed nature per FTC (Federal Trade Commission) guidelines.',
    `target_age_range_max` STRING COMMENT 'Maximum age of the intended audience for the content or service. Used to assess mixed-audience scenarios.',
    `target_age_range_min` STRING COMMENT 'Minimum age of the intended audience for the content or service. Critical for determining COPPA applicability (under 13 threshold).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the COPPA declaration record was last modified, supporting audit trail and change tracking requirements.',
    `verifiable_consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether verifiable parental consent has been obtained for data collection from children under 13, as required by COPPA.',
    `visual_content_assessment` STRING COMMENT 'Assessment of visual content elements (characters, animation style, color schemes) that may appeal to children, per FTC child-directed determination factors.',
    CONSTRAINT pk_coppa_declaration PRIMARY KEY(`coppa_declaration_id`)
) COMMENT 'Records COPPA (Childrens Online Privacy Protection Act) compliance declarations for digital content, platforms, and services directed at children under 13. Captures content or service identifier, directed-to-children determination, parental consent mechanism, data collection scope, verifiable parental consent status, FTC filing reference, and review date. Critical for OTT and streaming platforms carrying childrens programming.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` (
    `compliance_consent_record_id` BIGINT COMMENT 'Unique identifier for the consent record. Primary key.',
    `device_type_id` BIGINT COMMENT 'Unique identifier of the device used to provide consent. May be a mobile advertising ID (IDFA, AAID), smart TV device ID, or browser fingerprint.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: GDPR/CCPA consent records require audit trail of which employee processed the consent for data protection compliance verification and accountability to regulatory authorities.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the data subject (subscriber, registered user, or anonymous viewer) who provided or withdrew consent. May be a subscriber ID, user ID, device ID, or pseudonymized identifier depending on the subject type.',
    `superseded_by_consent_record_compliance_consent_record_id` BIGINT COMMENT 'Reference to the consent record ID that supersedes this record. Used to maintain consent history and audit trail when consent is updated or renewed. Null if this is the current active record.',
    `audit_notes` STRING COMMENT 'Free-text field for additional audit notes, compliance annotations, or special circumstances related to this consent record. Used for regulatory audit preparation and internal compliance reviews.',
    `consent_channel` STRING COMMENT 'Platform or channel through which the consent was collected. Distinguishes between web, mobile app, smart TV, email, phone, in-person, or API-driven consent capture. [ENUM-REF-CANDIDATE: web|mobile_app|smart_tv|email|phone|in_person|api — 7 candidates stripped; promote to reference product]',
    `consent_expiry_date` DATE COMMENT 'Date on which the consent expires and must be renewed. Null for consents without expiration. Used to enforce periodic re-consent requirements under certain regulations.',
    `consent_language` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language in which the consent notice was presented to the subject (e.g., en for English, es for Spanish, fr for French).. Valid values are `^[a-z]{2}$`',
    `consent_mechanism` STRING COMMENT 'Method or interface through which consent was captured. Examples include Consent Management Platform (CMP) banner, registration form, opt-in email, in-app toggle, customer service call, or written form.',
    `consent_proof_url` STRING COMMENT 'URL or storage path to the archived proof of consent (e.g., screenshot, form submission, audit log entry). Used as evidence in regulatory audits.',
    `consent_scope` STRING COMMENT 'Detailed description of the specific data processing activities or purposes covered by this consent. May include specific data categories, processing purposes, or third-party sharing arrangements.',
    `consent_source_system` STRING COMMENT 'Name of the source system or application that captured the consent event. Examples include Adobe Experience Platform, Salesforce, Zuora, or custom Consent Management Platform (CMP).',
    `consent_status` STRING COMMENT 'Current state of the consent. Indicates whether consent has been granted, withdrawn, expired, not yet provided, or is pending review.. Valid values are `granted|withdrawn|expired|not_yet_given|pending`',
    `consent_timestamp` TIMESTAMP COMMENT 'Date and time when the consent event occurred (granted, withdrawn, or modified). Recorded in ISO 8601 format with timezone.',
    `consent_transaction_code` STRING COMMENT 'Unique transaction or session identifier from the source system that captured the consent. Used for cross-system audit trail and reconciliation.',
    `consent_type` STRING COMMENT 'Category of consent being granted or withdrawn. Includes data processing, marketing communications, profiling, cookie usage, targeted advertising, and cross-device tracking.. Valid values are `data_processing|marketing|profiling|cookies|targeted_advertising|cross_device_tracking`',
    `cookie_consent_categories` STRING COMMENT 'Comma-separated list of cookie categories for which consent was granted (e.g., strictly_necessary, functional, analytics, advertising, social_media). Aligns with IAB Transparency and Consent Framework categories.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this consent record was first created in the system. Recorded in ISO 8601 format with timezone. Used for audit trail and data lineage.',
    `ip_address` STRING COMMENT 'IP address from which the consent was provided. Used for audit trail and fraud detection. May be IPv4 or IPv6 format.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this consent record is currently active and enforceable. False if consent has been withdrawn, expired, or superseded by a newer record.',
    `jurisdiction` STRING COMMENT 'Geographic jurisdiction or regulatory region governing this consent record. Uses ISO 3166-1 alpha-3 country codes (e.g., USA, GBR, DEU) or regional codes (e.g., EEA for European Economic Area).. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this consent record was last modified or updated. Recorded in ISO 8601 format with timezone. Used for audit trail and change tracking.',
    `marketing_email_consent` BOOLEAN COMMENT 'Boolean flag indicating whether the subject has consented to receive marketing communications via email.',
    `marketing_push_consent` BOOLEAN COMMENT 'Boolean flag indicating whether the subject has consented to receive marketing push notifications on mobile or web applications.',
    `marketing_sms_consent` BOOLEAN COMMENT 'Boolean flag indicating whether the subject has consented to receive marketing communications via SMS or text message.',
    `parental_consent_verified` BOOLEAN COMMENT 'Boolean flag indicating whether parental or guardian consent has been verified for subjects under the age of consent (required under Childrens Online Privacy Protection Act (COPPA) and similar regulations).',
    `parental_verification_method` STRING COMMENT 'Method used to verify parental consent for minors. Examples include credit card verification, government ID check, video conference, or signed consent form. Null if parental consent is not applicable.',
    `privacy_policy_version` STRING COMMENT 'Version identifier of the privacy policy or terms of service that the subject accepted when providing consent. Critical for demonstrating which terms were in effect at the time of consent.',
    `regulatory_framework` STRING COMMENT 'Primary privacy regulation or framework under which this consent was collected. Includes General Data Protection Regulation (GDPR), California Consumer Privacy Act (CCPA), Childrens Online Privacy Protection Act (COPPA), California Privacy Rights Act (CPRA), Lei Geral de Proteção de Dados (LGPD), Personal Information Protection and Electronic Documents Act (PIPEDA), or other applicable laws. [ENUM-REF-CANDIDATE: GDPR|CCPA|COPPA|CPRA|LGPD|PIPEDA|other — 7 candidates stripped; promote to reference product]',
    `subject_type` STRING COMMENT 'Classification of the data subject providing consent. Distinguishes between authenticated subscribers, registered users, anonymous viewers, guests, or device-level consent.. Valid values are `subscriber|registered_user|anonymous_viewer|guest|device`',
    `tcf_consent_string` STRING COMMENT 'IAB Transparency and Consent Framework encoded consent string capturing granular vendor and purpose consents. Used for programmatic advertising consent management.',
    `third_party_sharing_consent` BOOLEAN COMMENT 'Boolean flag indicating whether the subject has consented to sharing their data with third parties (e.g., advertising partners, analytics providers, content partners).',
    `user_agent` STRING COMMENT 'Browser or application user agent string captured at the time of consent. Provides context about the device and software used for consent capture.',
    `withdrawal_mechanism` STRING COMMENT 'Method or interface through which consent was withdrawn. Examples include preference center, unsubscribe link, customer service request, or in-app toggle. Null if consent has not been withdrawn.',
    `withdrawal_timestamp` TIMESTAMP COMMENT 'Date and time when consent was withdrawn by the subject. Null if consent has not been withdrawn. Critical for demonstrating compliance with right to withdraw consent.',
    CONSTRAINT pk_compliance_consent_record PRIMARY KEY(`compliance_consent_record_id`)
) COMMENT 'Authoritative log of audience and subscriber consent events for data collection, processing, and marketing under GDPR, CCPA, COPPA, and emerging state privacy laws. Captures consent subject (subscriber, registered user, or anonymous viewer), consent type (data processing, marketing, profiling, cookies, targeted advertising, cross-device tracking), consent status (granted, withdrawn, expired, not-yet-given), consent mechanism (CMP banner, registration form, opt-in email, in-app toggle), jurisdiction, consent timestamp, expiry date, version of privacy policy accepted, and withdrawal mechanism used. Serves as the legal basis record for all personal data processing and the primary evidence artifact for regulatory audits.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` (
    `privacy_request_id` BIGINT COMMENT 'Unique identifier for the privacy request. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: GDPR/CCPA privacy requests (access, deletion, portability) must be assigned to specific employees for fulfillment tracking and regulatory deadline compliance. Assigned handler text should be FK.',
    `compliance_consent_record_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_record. Business justification: Privacy requests (GDPR right to erasure, consent withdrawal) may involve modifying or revoking consent records. This FK links the privacy request to the consent record it affects. Using related_conse',
    `subscriber_id` BIGINT COMMENT 'Internal subscriber identifier linked to the requestor, if the data subject is a known subscriber in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this privacy request record was first created in the system. Used for audit trail and data lineage.',
    `data_categories_involved` STRING COMMENT 'Comma-separated list of data categories involved in the request (e.g., subscriber profile, viewing history, payment data, device identifiers). Used for scope tracking and audit.',
    `data_volume_processed` DECIMAL(18,2) COMMENT 'Total volume of data processed for this request in megabytes, used for operational metrics and resource planning.',
    `extended_deadline` DATE COMMENT 'New deadline date if an extension was granted. GDPR allows up to 3 months total; CCPA allows up to 90 days total.',
    `extension_granted` BOOLEAN COMMENT 'Indicates whether a deadline extension was granted due to request complexity or volume. GDPR allows 2-month extension; CCPA allows 45-day extension.',
    `extension_reason` STRING COMMENT 'Business justification for granting a deadline extension, such as request complexity, high volume of requests, or technical challenges.',
    `fulfillment_status` STRING COMMENT 'Detailed status of request fulfillment workflow: not_started, data_collection (gathering data), data_review (validating), response_preparation (packaging), response_sent (delivered), closed (finalized).. Valid values are `not_started|data_collection|data_review|response_preparation|response_sent|closed`',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special handling instructions, or communications log for the request.',
    `processing_time_hours` DECIMAL(18,2) COMMENT 'Total staff hours spent processing this request, used for cost tracking and efficiency analysis.',
    `regulatory_deadline` DATE COMMENT 'Calculated deadline for responding to the request based on regulatory requirements: 30 calendar days for GDPR, 45 calendar days for CCPA, from submission date.',
    `regulatory_framework` STRING COMMENT 'Primary data privacy regulation governing this request: GDPR (EU/EEA), CCPA (California), both (dual jurisdiction), or other (state-specific or international).. Valid values are `gdpr|ccpa|both|other`',
    `rejection_reason` STRING COMMENT 'Detailed explanation if the request was rejected, including legal basis (e.g., identity not verified, request manifestly unfounded or excessive, legal obligation to retain data).',
    `request_number` STRING COMMENT 'Externally-visible unique identifier for the privacy request, used in communications with data subjects and regulators.. Valid values are `^PR-[0-9]{8}$`',
    `request_status` STRING COMMENT 'Current lifecycle status of the privacy request: submitted (received), under_review (initial assessment), identity_verification (verifying requestor), in_progress (fulfilling), completed (closed successfully), rejected (denied with justification), withdrawn (cancelled by requestor). [ENUM-REF-CANDIDATE: submitted|under_review|identity_verification|in_progress|completed|rejected|withdrawn — 7 candidates stripped; promote to reference product]',
    `request_type` STRING COMMENT 'Type of data subject rights request: access (right to know), erasure (right to delete), portability (data export), rectification (correction), restriction (processing limitation), or opt_out_sale (CCPA opt-out).. Valid values are `access|erasure|portability|rectification|restriction|opt_out_sale`',
    `requestor_email` STRING COMMENT 'Primary email address of the data subject for request correspondence and response delivery.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requestor_jurisdiction` STRING COMMENT 'Three-letter ISO country code representing the data subjects jurisdiction, used to determine applicable privacy law (e.g., DEU for Germany/GDPR, USA for US/CCPA).. Valid values are `^[A-Z]{3}$`',
    `requestor_name` STRING COMMENT 'Full legal name of the data subject submitting the privacy request.',
    `requestor_phone` STRING COMMENT 'Contact phone number of the data subject for identity verification and request follow-up.',
    `response_date` DATE COMMENT 'Date when the response was delivered to the data subject, marking completion of the request.',
    `response_method` STRING COMMENT 'Method used to deliver the response to the data subject: email (encrypted), secure_portal (download link), mail (postal), phone (verbal), or in_person.. Valid values are `email|secure_portal|mail|phone|in_person`',
    `submission_channel` STRING COMMENT 'Channel through which the privacy request was submitted: web_form (online portal), email, phone (call center), mail (postal), mobile_app, or chat (live support).. Valid values are `web_form|email|phone|mail|mobile_app|chat`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the privacy request was submitted by the data subject. Used to calculate regulatory deadline (30 days GDPR, 45 days CCPA).',
    `systems_accessed` STRING COMMENT 'Comma-separated list of internal systems queried to fulfill the request (e.g., Zuora, Adobe Experience Platform, Akamai CDN logs). Used for audit trail and completeness verification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this privacy request record was last modified. Used for audit trail and change tracking.',
    `verification_method` STRING COMMENT 'Method used to verify the requestors identity: email_confirmation, account_login, document_upload (ID scan), phone_verification, two_factor_auth, or manual_review.. Valid values are `email_confirmation|account_login|document_upload|phone_verification|two_factor_auth|manual_review`',
    `verification_status` STRING COMMENT 'Status of requestor identity verification process: pending (awaiting verification), verified (identity confirmed), failed (unable to verify), not_required (low-risk request).. Valid values are `pending|verified|failed|not_required`',
    `verification_timestamp` TIMESTAMP COMMENT 'Date and time when the requestors identity was successfully verified.',
    CONSTRAINT pk_privacy_request PRIMARY KEY(`privacy_request_id`)
) COMMENT 'Tracks data subject rights requests submitted under GDPR (right to access, erasure, portability, rectification, restriction) and CCPA (right to know, delete, opt-out of sale). Captures request type, requestor identity, submission channel, verification status, assigned handler, regulatory deadline (30-day GDPR / 45-day CCPA), fulfillment status, and response date. Ensures timely compliance with data subject rights obligations.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` (
    `closed_caption_record_id` BIGINT COMMENT 'Unique identifier for the closed caption compliance record.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Closed captioning is a specific type of accessibility obligation under FCC/Ofcom rules. This FK links each captioning record to the accessibility obligation it fulfills, enabling compliance reporting ',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Closed captioning applies to specific versions/renditions of assets (broadcast master vs. streaming proxy vs. archived version). Different versions may have different caption formats (CEA-608, CEA-708',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Captioning vendor performance and FCC compliance is tracked by partner. Captioning accuracy failures, latency violations, and format errors may trigger vendor SLA breaches, disputes, or vendor substit',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: Closed captioning violations (low accuracy, missing captions, complaints) may be recorded as compliance incidents. This FK links the captioning record to any incident it triggered, supporting FCC comp',
    `content_episode_id` BIGINT COMMENT 'Reference to the specific episode that was captioned, if applicable.',
    `title_id` BIGINT COMMENT 'Reference to the content title that was captioned.',
    `delivery_channel_id` BIGINT COMMENT 'Reference to the channel or platform where the captioned content was broadcast or streamed.',
    `encoder_config_id` BIGINT COMMENT 'Foreign key linking to technology.encoder_config. Business justification: Caption compliance audits require tracking which encoder processed each stream. Real NOC/compliance workflow for troubleshooting caption failures and demonstrating CVAA compliance to FCC.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: FCC closed captioning compliance requires tracking which media assets have caption files, caption quality scores, and compliance status. This is mandatory for accessibility reporting, public inspectio',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Closed caption records may reference talent for audio description, voice identification, or accessibility compliance when talent narrates or appears in content. Accessibility teams identify talent voi',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: FCC closed captioning quality reviews require tracking which employee performed the review for compliance verification and audit trail. Reviewer name should reference employee record.',
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
    `public_inspection_file_included` BOOLEAN COMMENT 'Indicates whether this caption record has been included in the broadcasters public inspection file as required by FCC regulations.',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: FCC accessibility obligations (CVAA, closed captioning, video description) require named employee owner for compliance tracking and regulatory correspondence. Contact email should reference employee r',
    `applicable_regulation` STRING COMMENT 'Primary regulatory framework governing this obligation: CVAA (Twenty-First Century Communications and Video Accessibility Act), ADA (Americans with Disabilities Act), Ofcom Access Code, EU Audiovisual Media Services Directive, WCAG 2.1 (Web Content Accessibility Guidelines), or ATSC A/53 (Advanced Television Systems Committee standard for closed captioning).. Valid values are `cvaa|ada|ofcom_access_code|eu_audiovisual_directive|wcag_2_1|atsc_a_53`',
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
    `calendar_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_calendar. Business justification: Scheduled EAS tests are tracked in the compliance calendar. This FK links each EAS log entry to the calendar entry for the scheduled test, enabling verification that required tests were performed on t',
    `channel_id` BIGINT COMMENT 'Identifier of the broadcast station that received or transmitted the EAS alert.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: EAS failures or non-compliance (missed tests, equipment failures) may be recorded as compliance incidents. This FK links the EAS log entry to any incident it triggered, supporting FCC compliance track',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: EAS (Emergency Alert System) tests and alerts are often recorded as media assets for compliance retention, quality verification, and FCC audit purposes. Broadcasters must retain EAS logs and associate',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: FCC EAS logs must record which licensed operator was on duty during alert transmission for regulatory compliance verification. Operator on duty text should be FK.',
    `transmission_equipment_id` BIGINT COMMENT 'Foreign key linking to technology.transmission_equipment. Business justification: FCC EAS compliance requires equipment-level logs showing which transmitter relayed each alert. Real public inspection file requirement and FCC audit trail for EAS participation verification.',
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
    `public_inspection_file_entry` BOOLEAN COMMENT 'Indicates whether this EAS log entry has been included in the stations public inspection file as required by FCC regulations.',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: FCC political advertising records require compliance officer review for equal time and reasonable access rules. Tracking reviewer employee is essential for audit trail and accountability.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: FCC political advertising rules require broadcasters to maintain public inspection files linking political ad orders to the specific creative assets (spots) that aired. This enables verification of sp',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Political ad records must identify the buying partner/agency for FCC public inspection file disclosure and reasonable access/equal time administration. The advertiser entity (campaign, PAC, party comm',
    `public_inspection_file_id` BIGINT COMMENT 'Foreign key linking to compliance.public_inspection_file. Business justification: Political ad records must be included in the stations public inspection file per FCC rules. This FK links each political ad record to its corresponding public file document, ensuring disclosure compl',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Political ads featuring talent require disclosure of talent identity, compensation, and sponsorship identification in public inspection files. Ad clearance teams document talent appearing in political',
    `advertiser_type` STRING COMMENT 'Classification of the political advertiser entity type for regulatory reporting and rate determination purposes.. Valid values are `candidate|political_party|pac|super_pac|issue_advocacy|ballot_measure`',
    `affidavit_issued_flag` BOOLEAN COMMENT 'Indicates whether a broadcast affidavit (proof of performance) has been issued to the advertiser confirming that this political ad aired as scheduled.',
    `air_date` DATE COMMENT 'Calendar date on which the political advertisement was broadcast or is scheduled to broadcast.',
    `air_time` TIMESTAMP COMMENT 'Precise timestamp when the political advertisement aired or is scheduled to air, including time zone. Required for public inspection file and affidavit of performance.',
    `candidate_name` STRING COMMENT 'Name of the political candidate featured or referenced in the advertisement, if applicable. Null for issue advocacy ads without candidate reference.',
    `compliance_notes` STRING COMMENT 'Free-text field for documenting compliance issues, remediation actions, equal opportunities requests, reasonable access determinations, or other regulatory notes related to this political ad placement.',
    `compliance_status` STRING COMMENT 'Current regulatory compliance status of this political ad record indicating whether all FCC political broadcasting requirements have been met.. Valid values are `compliant|pending_review|non_compliant|remediated`',
    `contract_number` STRING COMMENT 'Sales contract or agreement number under which this political advertisement was purchased. Links to the traffic system sales order.',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` (
    `sox_control_id` BIGINT COMMENT 'Unique identifier for the SOX control record. Primary key for the sox_control product.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: SOX control deficiencies are documented as audit findings. This FK links a SOX control to any audit finding that identified a deficiency in that control. Note: Using related_audit_finding_id as the ',
    `compensating_control_id` BIGINT COMMENT 'Reference to another SOX control that serves as a compensating control if this control fails or is temporarily inactive. Compensating controls provide alternative assurance over the same financial reporting risk.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: SOX controls require named employee owners for accountability in financial reporting compliance. Control owner text should reference employee record for audit trail and performance tracking.',
    `assertion_category` STRING COMMENT 'The financial statement assertion that this control addresses. Existence ensures recorded transactions occurred; completeness ensures all transactions are recorded; accuracy ensures amounts are correct; valuation ensures proper measurement; rights and obligations ensure the entity has legal claim; presentation and disclosure ensure proper classification and disclosure; cutoff ensures transactions are recorded in the correct period. [ENUM-REF-CANDIDATE: existence|completeness|accuracy|valuation|rights and obligations|presentation and disclosure|cutoff — 7 candidates stripped; promote to reference product]',
    `auditor_notes` STRING COMMENT 'Comments and observations from internal or external auditors regarding control design, operating effectiveness, or areas for improvement. Supports audit trail and continuous improvement.',
    `automated_flag` BOOLEAN COMMENT 'Indicates whether the control is fully automated (True) or requires manual execution (False). Automated controls are typically embedded in financial systems and execute without human intervention.',
    `control_description` STRING COMMENT 'Comprehensive description of the control activity, including specific procedures, data sources, systems involved, thresholds, and documentation requirements. For media companies, may reference systems such as Wide Orbit (traffic and billing), Rightsline (rights management), or Zuora (subscription billing).',
    `control_documentation_path` STRING COMMENT 'File path or document management system reference to the detailed control documentation, including procedures, flowcharts, and testing workpapers. Used for audit evidence and compliance verification.',
    `control_frequency` STRING COMMENT 'How often the control is performed or operates. Continuous controls run automatically in real-time (e.g., system validations); periodic controls are executed at defined intervals; event-driven controls are triggered by specific business events (e.g., contract execution, content release). [ENUM-REF-CANDIDATE: continuous|daily|weekly|monthly|quarterly|annual|event-driven — 7 candidates stripped; promote to reference product]',
    `control_name` STRING COMMENT 'Short descriptive name of the control that summarizes its purpose (e.g., Advertising Revenue Recognition Review, Subscriber Billing Reconciliation).',
    `control_number` STRING COMMENT 'Business identifier for the control, typically formatted as a prefix code followed by a numeric sequence (e.g., FIN-001, REV-1234). Used for external reference and audit documentation.. Valid values are `^[A-Z]{2,4}-[0-9]{3,5}$`',
    `control_objective` STRING COMMENT 'Detailed statement of what the control is designed to achieve, including the specific financial reporting assertion it addresses (existence, completeness, accuracy, valuation, rights and obligations, presentation and disclosure).',
    `control_status` STRING COMMENT 'Current operational status of the control. Active controls are in effect; inactive controls are temporarily suspended; under remediation indicates deficiencies are being addressed; pending implementation means the control is designed but not yet operational; retired controls are no longer applicable.. Valid values are `active|inactive|under remediation|pending implementation|retired`',
    `control_type` STRING COMMENT 'Classification of the control based on its nature and timing. Preventive controls stop errors before they occur; detective controls identify errors after occurrence; IT general controls (ITGC) govern system access and change management; IT application controls are embedded in financial systems; entity-level controls address governance and culture; management review controls involve oversight and analysis.. Valid values are `preventive|detective|it general control|it application control|entity level control|management review control`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this control record was first created in the system. Part of audit trail for control lifecycle management.',
    `deficiency_classification` STRING COMMENT 'Severity classification of any identified control deficiency. No deficiency means the control is effective; control deficiency is a minor issue unlikely to result in misstatement; significant deficiency is important enough to merit attention by those charged with governance; material weakness is a deficiency or combination of deficiencies that creates a reasonable possibility of material misstatement not being prevented or detected.. Valid values are `no deficiency|control deficiency|significant deficiency|material weakness`',
    `deficiency_description` STRING COMMENT 'Detailed explanation of any identified control deficiency, including the nature of the failure, root cause analysis, and potential impact on financial reporting. Null if no deficiency exists.',
    `effective_date` DATE COMMENT 'Date on which the control became operational and began addressing the identified financial reporting risk. Used to track control lifecycle and determine testing periods.',
    `financial_statement_line_item` STRING COMMENT 'The specific financial statement account or line item that this control impacts (e.g., Advertising Revenue, Subscription Revenue, Content Amortization Expense, Accounts Receivable, Deferred Revenue). Maps control to financial reporting impact.',
    `key_control_flag` BOOLEAN COMMENT 'Indicates whether this is a key control (True) that directly addresses a significant risk to financial reporting, or a supporting control (False). Key controls receive more rigorous testing and documentation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this control record. Tracks changes to control design, ownership, status, or test results.',
    `last_test_date` DATE COMMENT 'The most recent date on which the control was formally tested for design and operating effectiveness by internal audit, external auditors, or control owners.',
    `management_assertion_mapping` STRING COMMENT 'Mapping of this control to managements assertions under SOX Section 302 (CEO/CFO certification) and Section 404 (internal control over financial reporting). Documents how this control supports managements ability to assert the effectiveness of internal controls.',
    `process_area` STRING COMMENT 'The business process or financial cycle to which this control applies. Media-specific areas include advertising revenue recognition (CPM, GRP-based billing), carriage fee billing (MVPD/vMVPD distribution payments), subscriber billing (SVOD, TVOD), content licensing revenue (syndication, windowing), rights royalty accruals (talent residuals, music licensing), and barter transactions (ad inventory exchanges). [ENUM-REF-CANDIDATE: advertising revenue recognition|carriage fee billing|subscriber billing|content licensing revenue|rights royalty accruals|barter transactions|production cost capitalization|content amortization|deferred revenue|accounts receivable|accounts payable|payroll|treasury|tax compliance|financial close|general ledger|fixed assets|inventory|intercompany transactions — 19 candidates stripped; promote to reference product]',
    `remediation_plan` STRING COMMENT 'Action plan to address identified deficiencies, including specific corrective actions, responsible parties, and target completion dates. Null if no remediation is required.',
    `remediation_status` STRING COMMENT 'Current status of remediation efforts for identified deficiencies. Not applicable if no deficiency exists; planned means remediation is designed but not started; in progress indicates active remediation; completed means actions are finished but not yet validated; validated means remediation has been tested and confirmed effective.. Valid values are `not applicable|planned|in progress|completed|validated`',
    `remediation_target_date` DATE COMMENT 'Target date by which remediation activities are expected to be completed and validated. Null if no remediation is required.',
    `retirement_date` DATE COMMENT 'Date on which the control was retired or superseded by another control. Null for active controls. Used for historical tracking and audit trail.',
    `risk_rating` STRING COMMENT 'Assessment of the inherent risk level associated with the process area this control addresses. Critical and high ratings indicate areas with significant potential for material misstatement if controls fail.. Valid values are `critical|high|medium|low`',
    `system_name` STRING COMMENT 'Name of the primary financial or operational system in which the control is executed or from which control evidence is derived (e.g., SAP S/4HANA FI, Wide Orbit Traffic, Zuora Billing, Rightsline Rights Management).',
    `test_frequency` STRING COMMENT 'How often the control is formally tested for effectiveness. Quarterly testing is typical for key controls; annual testing may suffice for lower-risk controls; event-driven testing occurs when significant changes are made to the control or underlying process.. Valid values are `quarterly|semi-annual|annual|event-driven`',
    `test_result` STRING COMMENT 'Outcome of the most recent control test. Effective means the control operated as designed with no exceptions; ineffective with exception indicates isolated failures that do not rise to a deficiency; ineffective means the control did not operate as designed; not tested means no evaluation has been performed.. Valid values are `effective|ineffective with exception|ineffective|not tested`',
    CONSTRAINT pk_sox_control PRIMARY KEY(`sox_control_id`)
) COMMENT 'Master registry of Sarbanes-Oxley (SOX) internal controls applicable to the organizations financial reporting processes, with emphasis on media-specific revenue streams. Captures control ID, control name, control objective, process area (advertising revenue recognition, carriage fee billing, subscriber billing, content licensing revenue, rights royalty accruals, barter transactions), control type (preventive, detective, IT general, IT application), frequency (continuous, daily, monthly, quarterly, annual), control owner, last test date, test result (effective, ineffective with exception, ineffective), deficiency classification (control deficiency, significant deficiency, material weakness), remediation plan, and management assertion mapping. Supports SOX Section 302 and 404 compliance for publicly traded media companies.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'Unique identifier for the audit finding record. Primary key.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Audit findings may relate to accessibility compliance (e.g., closed captioning deficiencies, audio description gaps). This FK links the finding to the specific accessibility obligation that was violat',
    `audit_id` BIGINT COMMENT 'Reference to the parent audit engagement or audit project during which this finding was identified.',
    `channel_id` BIGINT COMMENT 'Reference to the broadcast station or channel to which this finding applies, if the finding is station-specific (e.g., FCC license compliance, public inspection file deficiency).',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Compliance audits (FCC, internal, SOX) often identify issues with specific media assets: rights clearance violations, indecency complaints, technical non-compliance (loudness, captioning), or content ',
    `previous_finding_audit_finding_id` BIGINT COMMENT 'Reference to the prior audit finding record if this is a recurrence, enabling tracking of repeat issues and corrective action effectiveness.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Audit findings may result in regulatory filings (e.g., corrective action reports, compliance certifications). This FK links findings to any regulatory filings they triggered, supporting audit trail re',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Audit findings often relate to specific regulatory obligations (e.g., finding that FCC public file requirements were not met). This FK links the finding to the obligation it evaluates, supporting comp',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Audit findings require assigned employee for remediation tracking and accountability. Remediation owner text should reference employee record for workload management and performance evaluation.',
    `title_id` BIGINT COMMENT 'Reference to the specific content asset, program, or title associated with this finding, if the finding pertains to content standards, ratings, clearance, or captioning compliance.',
    `transmission_equipment_id` BIGINT COMMENT 'Foreign key linking to technology.transmission_equipment. Business justification: FCC/regulatory audit findings often cite specific equipment non-compliance (power output variance, frequency deviation). Real audit workflow requires equipment-level tracking for remediation and verif',
    `actual_resolution_date` DATE COMMENT 'The actual date on which the remediation action was completed and verified, resulting in closure of the finding.',
    `affected_process` STRING COMMENT 'The business process, operational area, or functional domain impacted by this finding (e.g., Content Acquisition and Licensing, Program Scheduling and Playout, Advertising Sales and Campaign Management, Rights and Royalties Management, Subscriber and Membership Management).',
    `affected_system` STRING COMMENT 'The operational system, application, or platform where the non-compliance or control deficiency was identified (e.g., Dalet Galaxy, Wide Orbit, SAP S/4HANA, Salesforce Media Cloud, Nielsen Media Research Platform, Ericsson MediaFirst, Adobe Experience Platform, Rightsline, Akamai CDN, Zuora).',
    `audit_period_end_date` DATE COMMENT 'The end date of the audit period or scope during which the condition leading to this finding occurred.',
    `audit_period_start_date` DATE COMMENT 'The start date of the audit period or scope during which the condition leading to this finding occurred.',
    `audit_type` STRING COMMENT 'Classification of the audit engagement: internal (conducted by internal audit team), external (third-party auditor), regulatory (government agency inspection), certification (ISO/standards body), or surveillance (ongoing compliance monitoring).. Valid values are `internal|external|regulatory|certification|surveillance`',
    `auditor_name` STRING COMMENT 'Name of the lead auditor or audit firm responsible for identifying and documenting this finding.',
    `auditor_type` STRING COMMENT 'Classification of the auditor: internal (company internal audit team), external (third-party audit firm), regulatory (government agency inspector or regulator).. Valid values are `internal|external|regulatory`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit finding record was first created in the system.',
    `finding_category` STRING COMMENT 'High-level categorization of the finding type. [ENUM-REF-CANDIDATE: License Compliance|Content Standards Violation|Data Privacy Breach|Financial Reporting Error|Technical Standards Non-Conformance|Accessibility Non-Compliance|Rights Clearance Issue|Consent Management Deficiency|Public File Deficiency|Affidavit Discrepancy|Process Control Weakness|Documentation Gap — promote to reference product]',
    `finding_description` STRING COMMENT 'Detailed narrative description of the audit finding, including the specific condition observed, the standard or requirement violated, and the evidence supporting the finding.',
    `finding_number` STRING COMMENT 'Business identifier or reference number assigned to this finding for tracking and reporting purposes (e.g., FCC-2024-001, SOX-Q1-042).',
    `finding_status` STRING COMMENT 'Current lifecycle status of the finding: open (newly identified, not yet addressed), in_remediation (corrective action underway), pending_verification (remediation complete, awaiting validation), closed (verified and resolved), deferred (accepted risk or postponed remediation).. Valid values are `open|in_remediation|pending_verification|closed|deferred`',
    `identified_date` DATE COMMENT 'The date on which the audit finding was first identified or documented during the audit engagement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit finding record was last updated or modified, supporting audit trail and change tracking.',
    `management_response` STRING COMMENT 'Formal response or action plan provided by management in reply to the audit finding, including agreement or disagreement with the finding, proposed corrective actions, and committed timelines.',
    `notes` STRING COMMENT 'Additional notes, comments, or supplementary information related to the finding, remediation progress, or verification activities.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the potential penalty amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `potential_penalty_amount` DECIMAL(18,2) COMMENT 'Estimated or assessed monetary penalty, fine, or forfeiture amount that could be imposed by the regulatory authority if the finding is not remediated or if enforcement action is taken.',
    `recommended_remediation` STRING COMMENT 'The corrective action or remediation plan recommended by the auditor to address the finding and prevent recurrence.',
    `recurrence_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this finding is a repeat or recurrence of a previously identified and closed finding, suggesting ineffective corrective action or systemic control weakness.',
    `regulatory_citation` STRING COMMENT 'Specific regulatory rule, statute, standard, or policy section that was violated or not met (e.g., 47 CFR 73.3526 for FCC public file requirements, GDPR Article 32 for security measures, SOX Section 404 for internal controls).',
    `regulatory_domain` STRING COMMENT 'The regulatory or compliance domain to which this finding pertains. [ENUM-REF-CANDIDATE: FCC Broadcast Licensing|Ofcom Broadcasting Standards|MPA Content Ratings|COPPA Childrens Content|GDPR Data Privacy|CCPA Consumer Privacy|SOX Financial Reporting|PCI DSS Payment Security|ATSC Technical Standards|DVB Technical Standards|Accessibility Mandates|Content Clearance|Closed Captioning|Consent Management — promote to reference product]',
    `regulatory_reference_number` STRING COMMENT 'External reference number or citation assigned by the regulatory body or governing authority (e.g., FCC Notice of Violation number, Ofcom enforcement case reference, SOX deficiency ID).',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to this finding based on likelihood of regulatory enforcement, potential financial impact, reputational damage, and operational disruption.. Valid values are `critical|high|medium|low`',
    `root_cause` STRING COMMENT 'Analysis of the underlying root cause or contributing factors that led to the non-compliance or control deficiency (e.g., inadequate training, process gap, system limitation, human error, policy ambiguity).',
    `severity` STRING COMMENT 'Severity level of the finding based on risk impact and regulatory consequence: critical (immediate regulatory action or material breach), high (significant risk or non-compliance), medium (moderate risk requiring timely remediation), low (minor issue or observation).. Valid values are `critical|high|medium|low`',
    `target_resolution_date` DATE COMMENT 'The target or committed date by which the remediation action is expected to be completed and the finding closed.',
    `verification_date` DATE COMMENT 'The date on which the remediation action was verified or validated by the auditor or compliance officer.',
    `verification_status` STRING COMMENT 'Status of the verification or validation process to confirm that the remediation action effectively addressed the finding: not_started (remediation not yet verified), in_progress (verification underway), completed (remediation verified and effective), failed (remediation inadequate, finding remains open).. Valid values are `not_started|in_progress|completed|failed`',
    `verified_by` STRING COMMENT 'Name or identifier of the auditor, compliance officer, or quality assurance personnel who verified the effectiveness of the remediation action.',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Records findings from internal and external compliance audits across all regulatory domains (FCC, Ofcom, SOX, GDPR, CCPA, PCI DSS, COPPA). Captures audit type, audit period, auditor (internal/external), finding category, severity (critical, high, medium, low), affected process or system, root cause, recommended remediation, remediation owner, target resolution date, and closure status. Drives the compliance remediation workflow.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` (
    `regulatory_obligation_id` BIGINT COMMENT 'Unique identifier for the regulatory obligation record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory obligations require named employee owner for compliance tracking and deadline management. Responsible owner text should reference employee record for accountability and workload visibility.',
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
    `related_policy_document` STRING COMMENT 'Reference to internal policy, procedure, or guideline document that governs how this obligation is implemented and monitored.',
    `responsible_department` STRING COMMENT 'Department or business unit accountable for this obligation (e.g., Legal, Compliance, Broadcast Operations, Finance, IT Security).',
    `risk_level` STRING COMMENT 'Assessed risk level of non-compliance with this obligation, based on potential business impact, regulatory scrutiny, and penalty severity.. Valid values are `critical|high|medium|low`',
    CONSTRAINT pk_regulatory_obligation PRIMARY KEY(`regulatory_obligation_id`)
) COMMENT 'Master catalog of all regulatory obligations applicable to the organization, mapped to specific regulations, governing bodies, and business units. Captures obligation type, regulation name, regulatory body, jurisdiction, obligation description, applicability scope (linear TV, OTT, radio, digital), compliance frequency (ongoing, annual, quarterly, event-driven), responsible owner, and current compliance status. Serves as the compliance obligation register.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` (
    `incident_id` BIGINT COMMENT 'Primary key for incident',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Accessibility violations (missing captions, non-compliant video player) may be recorded as compliance incidents. This FK links the incident to the specific accessibility obligation that was violated.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Compliance incidents may be discovered through audit findings. This FK links incidents to the audit finding that identified them, supporting root cause analysis and audit trail requirements.',
    `broadcast_facility_id` BIGINT COMMENT 'Identifier of the broadcast station or facility involved in the compliance incident, if applicable.',
    `broadcast_license_id` BIGINT COMMENT 'Identifier of the broadcast license associated with the compliance incident, if applicable.',
    `coppa_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.coppa_declaration. Business justification: COPPA compliance incidents (e.g., collecting childrens data without parental consent) relate to specific COPPA declarations. This FK links the incident to the COPPA declaration that was violated, sup',
    `encoder_config_id` BIGINT COMMENT 'Foreign key linking to technology.encoder_config. Business justification: Encoding failures causing compliance violations (caption loss, rating display failure, audio description dropout) require encoder tracking for FCC incident reporting and remediation.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Compliance incidents (indecency complaints, technical violations, content violations, rights disputes) must reference the specific media asset involved for investigation, root cause analysis, regulato',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_change. Business justification: Compliance incidents may be triggered by new regulatory requirements that the organization has not yet implemented. This FK links incidents to the regulatory change that introduced the requirement, su',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Compliance incidents may trigger or be documented in regulatory filings (e.g., incident reports to FCC). This FK links the incident to any resulting regulatory filing, enabling tracking of incident re',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Compliance incidents represent violations of specific regulatory obligations. This FK links the incident to the primary obligation that was violated, enabling compliance reporting and risk analysis by',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Compliance incidents require assigned employee for resolution tracking and accountability. Responsible party contact data should reference employee record rather than duplicate information.',
    `sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: SOX control failures may be recorded as compliance incidents (e.g., control breakdown leading to financial misstatement risk). This FK links the incident to the SOX control that failed, supporting roo',
    `title_id` BIGINT COMMENT 'Identifier of the content asset (title, episode, program) affected by the compliance incident, if applicable.',
    `transmission_equipment_id` BIGINT COMMENT 'Foreign key linking to technology.transmission_equipment. Business justification: Compliance incidents often involve specific equipment failures (transmitter power drop, frequency drift). Equipment-level tracking required for root cause analysis and regulatory reporting beyond faci',
    `affected_regulation` STRING COMMENT 'The specific regulation, statute, or standard that was violated or at risk (e.g., FCC Part 73, GDPR Article 5, SOX Section 404, ATSC A/53).',
    `closure_date` DATE COMMENT 'The date on which the compliance incident was formally closed after all remediation actions were completed and verified.',
    `closure_notes` STRING COMMENT 'Final notes and summary documenting the resolution of the compliance incident, lessons learned, and any outstanding follow-up items.',
    `corrective_action_completion_date` DATE COMMENT 'Actual date on which the corrective action plan was completed and verified.',
    `corrective_action_due_date` DATE COMMENT 'Target completion date for the corrective action plan.',
    `corrective_action_plan` STRING COMMENT 'Documented plan outlining the corrective actions to be taken to remediate the incident and prevent recurrence.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action plan implementation.. Valid values are `not_started|in_progress|completed|verified|overdue`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance incident record was first created in the system.',
    `incident_description` STRING COMMENT 'Detailed narrative description of the compliance incident, including what occurred, how it was identified, and the immediate circumstances.',
    `discovery_date` DATE COMMENT 'The date on which the compliance incident was discovered or identified by the organization or external party.',
    `discovery_source` STRING COMMENT 'The source or method by which the compliance incident was discovered (e.g., internal audit, regulator inspection, viewer complaint, self-disclosure, automated monitoring). [ENUM-REF-CANDIDATE: internal_audit|external_audit|regulator_inspection|viewer_complaint|self_disclosure|automated_monitoring|third_party_report — 7 candidates stripped; promote to reference product]',
    `escalation_date` DATE COMMENT 'The date on which the compliance incident was escalated to a higher authority or external party.',
    `escalation_status` STRING COMMENT 'Indicates whether and to whom the compliance incident has been escalated within the organization or externally.. Valid values are `not_escalated|escalated_to_management|escalated_to_legal|escalated_to_board|escalated_to_regulator`',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact of the compliance incident, including fines, penalties, remediation costs, and lost revenue.',
    `financial_impact_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount.. Valid values are `^[A-Z]{3}$`',
    `impacted_service` STRING COMMENT 'The broadcast service, streaming platform, or distribution channel affected by the compliance incident (e.g., linear broadcast, OTT platform, MVPD service).',
    `incident_date` DATE COMMENT 'The date on which the compliance incident occurred or was first observed.',
    `incident_number` STRING COMMENT 'Business-facing unique identifier or case number assigned to the compliance incident for tracking and reference purposes.',
    `incident_status` STRING COMMENT 'Current lifecycle status of the compliance incident in the response and remediation workflow.. Valid values are `open|under_investigation|remediation_in_progress|closed|escalated|pending_regulatory_response`',
    `incident_type` STRING COMMENT 'Classification of the compliance incident by regulatory domain (e.g., broadcast licensing, content standards, data privacy, financial reporting, accessibility, technical standards). [ENUM-REF-CANDIDATE: broadcast_licensing|content_standards|data_privacy|financial_reporting|accessibility|technical_standards|advertising_compliance|rights_clearance|closed_captioning|other — 10 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance incident record was last updated or modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or context related to the compliance incident that do not fit into other structured fields.',
    `recurrence_risk_level` STRING COMMENT 'Assessed risk level of the compliance incident recurring after corrective actions have been implemented.. Valid values are `high|medium|low|negligible`',
    `regulatory_body` STRING COMMENT 'The governing body or regulatory authority with jurisdiction over the affected regulation (e.g., FCC, Ofcom, MPA, ISO).',
    `regulatory_notification_date` DATE COMMENT 'The date on which the regulatory body was formally notified of the compliance incident.',
    `regulatory_notification_method` STRING COMMENT 'The method used to notify the regulatory body of the compliance incident.. Valid values are `electronic_filing|written_notice|phone|in_person|not_applicable`',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether the compliance incident requires formal notification to the regulatory body under applicable reporting obligations.',
    `regulatory_reference_number` STRING COMMENT 'Reference or case number assigned by the regulatory body for tracking the incident and any subsequent investigation or enforcement action.',
    `root_cause_analysis` STRING COMMENT 'Analysis of the underlying root cause(s) of the compliance incident, including process failures, system defects, human error, or policy gaps.',
    `severity_level` STRING COMMENT 'Assessed severity of the compliance incident based on potential regulatory impact, financial exposure, and reputational risk.. Valid values are `critical|high|medium|low`',
    CONSTRAINT pk_incident PRIMARY KEY(`incident_id`)
) COMMENT 'Operational record of compliance incidents, violations, and near-misses identified across all regulatory domains. Captures incident type, affected regulation, discovery source (internal audit, regulator, viewer complaint, self-disclosure), incident date, severity, impacted content or service, root cause analysis, corrective action plan, escalation status, and regulatory notification requirement. Drives the compliance incident response and remediation lifecycle.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` (
    `ad_standards_clearance_id` BIGINT COMMENT 'Unique identifier for the advertising standards clearance record.',
    `advertiser_id` BIGINT COMMENT 'Identifier of the advertiser or brand submitting the ad creative for clearance.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: Rejected ads or clearance violations may trigger compliance incidents (e.g., airing an ad that failed clearance). This FK links the clearance record to any incident it caused, supporting compliance tr',
    `isci_creative_id` BIGINT COMMENT 'Identifier of the advertising creative asset submitted for clearance review.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Ad standards clearance decisions (NAB, network standards, legal review) apply to specific creative assets (commercial spots). Broadcasters must track which assets have been cleared for broadcast, reje',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Advertising standards clearance reviews require tracking which employee performed the review for accountability and audit trail. Reviewer contact data should reference employee record.',
    `ad_duration_seconds` STRING COMMENT 'Duration of the advertising creative in seconds, used to verify compliance with time-based advertising standards.',
    `alcohol_tobacco_flag` BOOLEAN COMMENT 'Indicates whether the ad creative promotes alcohol or tobacco products, subject to strict regulatory restrictions and daypart limitations.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the advertiser filed an appeal against a rejection or required-edits decision.',
    `appeal_outcome` STRING COMMENT 'Result of the appeal process if an appeal was filed against the original clearance decision.. Valid values are `upheld|overturned|pending|not applicable`',
    `children_directed_flag` BOOLEAN COMMENT 'Indicates whether the ad creative is directed at children under 13, triggering stricter COPPA and CARU compliance requirements.',
    `clearance_certificate_number` STRING COMMENT 'Unique certificate or reference number issued upon successful clearance, used for audit trail and affidavit verification.',
    `clearance_date` DATE COMMENT 'Date on which the standards clearance decision was finalized and communicated to the advertiser.',
    `clearance_expiration_date` DATE COMMENT 'Date on which the clearance approval expires, requiring re-submission if the ad is to air beyond this date.',
    `clearance_type` STRING COMMENT 'Type of clearance review process applied to the ad creative, indicating timing and depth of review.. Valid values are `pre-clearance|post-air review|expedited review|routine review|special review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ad standards clearance record was first created in the system.',
    `financial_services_flag` BOOLEAN COMMENT 'Indicates whether the ad creative promotes financial services or products, requiring compliance with truth-in-lending and consumer protection regulations.',
    `isci_code` STRING COMMENT 'Industry Standard Commercial Identification code uniquely identifying the commercial spot for broadcast tracking and clearance.. Valid values are `^[A-Z]{4}[0-9]{4}[A-Z0-9]{4}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the ad standards clearance record was last updated, capturing any changes to review status or outcome.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the clearance review, including specific edits requested or special conditions imposed.',
    `political_ad_flag` BOOLEAN COMMENT 'Indicates whether the ad creative is a political advertisement requiring special disclosure and public inspection file requirements under FCC rules.',
    `political_candidate_name` STRING COMMENT 'Name of the political candidate featured in or sponsoring the ad, required for FCC political advertising disclosure.',
    `political_office_sought` STRING COMMENT 'Political office being sought by the candidate in the political ad, required for FCC disclosure and public inspection file.',
    `prescription_drug_flag` BOOLEAN COMMENT 'Indicates whether the ad creative promotes prescription pharmaceutical products, requiring FDA compliance and specific disclosure language.',
    `product_category` STRING COMMENT 'Product or service category being advertised, used to apply category-specific advertising standards and restrictions (e.g., alcohol, pharmaceuticals, financial services, childrens products).',
    `rejection_category` STRING COMMENT 'High-level category of the standards violation leading to rejection or required edits (e.g., misleading claims, inappropriate content, regulatory non-compliance, childrens advertising violation).',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the ad creative was rejected or required edits, citing specific standards violations or regulatory concerns.',
    `review_outcome` STRING COMMENT 'Final decision of the standards clearance review indicating whether the ad creative is approved for broadcast, requires modifications, or is rejected.. Valid values are `approved|approved with edits|rejected|pending|withdrawn`',
    `review_start_date` DATE COMMENT 'Date on which the standards review process officially began for the submitted ad creative.',
    `standards_body` STRING COMMENT 'Regulatory or self-regulatory organization conducting the clearance review (e.g., NAB, CARU, IAB, internal broadcast standards department).',
    `submission_date` DATE COMMENT 'Date on which the ad creative was submitted for standards clearance review.',
    `substantiation_provided_flag` BOOLEAN COMMENT 'Indicates whether the advertiser provided required substantiation documentation to support claims made in the ad creative.',
    `substantiation_required_flag` BOOLEAN COMMENT 'Indicates whether the ad creative makes claims requiring documented substantiation (e.g., scientific evidence, test results, endorsements).',
    `target_audience` STRING COMMENT 'Intended demographic audience for the ad creative, critical for applying age-appropriate content standards and childrens advertising rules.',
    CONSTRAINT pk_ad_standards_clearance PRIMARY KEY(`ad_standards_clearance_id`)
) COMMENT 'Compliance clearance record for advertising content reviewed against broadcast standards, FCC rules, and industry codes (NAB Code, IAB standards, CARU guidelines for childrens advertising). Captures ad creative identifier, advertiser, product category, clearance type (pre-clearance, post-air review), standards body, review outcome (approved, approved with edits, rejected), rejection reason, and clearance date. Ensures all aired advertising meets regulatory and self-regulatory standards.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` (
    `technical_standard_cert_id` BIGINT COMMENT 'Unique identifier for the technical standard certification record.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Technical standard certifications (ATSC, DVB, etc.) are required for licensed broadcast operations. Each certification relates to equipment/systems operating under a specific broadcast license. This F',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Technical standard certifications (ATSC 3.0, DVB, etc.) require compliance officer sign-off for regulatory accountability. Officer contact data should reference employee record.',
    `encoder_config_id` BIGINT COMMENT 'Foreign key linking to technology.encoder_config. Business justification: Encoders must be certified for broadcast standards (HEVC, AVC, HDR). Real compliance requirement for demonstrating codec/format compliance to regulatory authorities and industry bodies.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Technical standard certifications (ATSC 3.0, DVB-T2) fulfill specific regulatory obligations. This FK links the certification to the obligation it satisfies, enabling compliance tracking and audit sup',
    `transmission_equipment_id` BIGINT COMMENT 'Foreign key linking to technology.transmission_equipment. Business justification: Broadcast standard certifications (ATSC 3.0, DVB-T2) are tied to specific transmission equipment. Real certification workflow for demonstrating technical compliance to FCC/regulatory bodies.',
    `applicable_platform` STRING COMMENT 'Platform or transmission system to which this certification applies (e.g., OTT streaming, linear broadcast, cable, satellite, IPTV).',
    `certificate_file_path` STRING COMMENT 'File path or storage location of the digital certificate document.',
    `certificate_number` STRING COMMENT 'Unique certificate number or identifier issued by the certification body.',
    `certification_body` STRING COMMENT 'Name of the organization or authority that issued the certification (e.g., ATSC, DVB Project, SCTE, ISO, independent testing lab).',
    `certification_date` DATE COMMENT 'Date when the certification was officially granted by the certification body.',
    `certification_expiry_date` DATE COMMENT 'Date when the certification expires and recertification is required.',
    `certification_status` STRING COMMENT 'Current status of the certification (certified, non-compliant, pending, expired, under review, waived).. Valid values are `certified|non_compliant|pending|expired|under_review|waived`',
    `corrective_action_completion_date` DATE COMMENT 'Date when corrective actions were completed and verified.',
    `corrective_action_description` STRING COMMENT 'Description of corrective actions taken or planned to address non-conformance issues.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective action is required to address non-conformance issues (true/false).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the system.',
    `equipment_identifier` STRING COMMENT 'Serial number, asset tag, or unique identifier of the equipment or system component being certified.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was last modified or updated.',
    `non_conformance_count` STRING COMMENT 'Number of non-conformance issues identified during the certification test.',
    `non_conformance_details` STRING COMMENT 'Detailed description of any non-conformance issues, deviations, or exceptions identified during testing.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the certification or test results.',
    `recertification_due_date` DATE COMMENT 'Date by which recertification must be completed to maintain compliance.',
    `recertification_required` BOOLEAN COMMENT 'Indicates whether recertification is required before the expiry date (true/false).',
    `regulatory_requirement` STRING COMMENT 'Specific regulatory requirement or mandate that this certification fulfills (e.g., FCC Part 73, Ofcom Code).',
    `standard_category` STRING COMMENT 'Category of the technical standard (transmission, encoding, streaming, ad insertion, loudness normalization, accessibility, metadata, security). [ENUM-REF-CANDIDATE: transmission|encoding|streaming|ad_insertion|loudness|accessibility|metadata|security — 8 candidates stripped; promote to reference product]',
    `standard_name` STRING COMMENT 'Name of the broadcast technical standard being certified (e.g., ATSC 3.0, DVB-T2, MPEG-4, HEVC, HLS, MPEG-DASH, SCTE-35).',
    `standard_version` STRING COMMENT 'Version or release number of the technical standard (e.g., 3.0, T2, Part 10, 1.0).',
    `test_date` DATE COMMENT 'Date when the technical standard compliance test was conducted.',
    `test_report_reference` STRING COMMENT 'Reference number or identifier of the official test report document.',
    `test_result` STRING COMMENT 'Outcome of the compliance test (pass, fail, conditional pass, not tested).. Valid values are `pass|fail|conditional_pass|not_tested`',
    `test_score` DECIMAL(18,2) COMMENT 'Numeric score or percentage achieved in the compliance test, if applicable.',
    `testing_lab_name` STRING COMMENT 'Name of the independent testing laboratory or facility that conducted the compliance test.',
    `transmission_system` STRING COMMENT 'Specific transmission system or infrastructure component being certified (e.g., encoder model, playout server, CDN node, IRD).',
    CONSTRAINT pk_technical_standard_cert PRIMARY KEY(`technical_standard_cert_id`)
) COMMENT 'Certification and compliance records for broadcast technical standards including ATSC 3.0, DVB-T2, MPEG-4/HEVC encoding, HLS/MPEG-DASH streaming, SCTE-35 ad insertion markers, and loudness normalization (ATSC A/85, EBU R128). Captures standard name, version, certification body, applicable platform or transmission system, test date, test result, certification expiry, and non-conformance details. Ensures all transmission and streaming infrastructure meets mandated technical standards.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` (
    `calendar_id` BIGINT COMMENT 'Unique identifier for the compliance calendar entry. Primary key.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Accessibility compliance deadlines (e.g., CVAA implementation milestones) are tracked in the compliance calendar. This FK links calendar entries to specific accessibility obligations, enabling proacti',
    `broadcast_license_id` BIGINT COMMENT 'Reference to the specific broadcast license associated with this compliance deadline, if applicable (e.g., for FCC license renewals or station-specific filings).',
    `channel_id` BIGINT COMMENT 'Reference to the broadcast station or facility associated with this compliance deadline, if applicable.',
    `license_renewal_id` BIGINT COMMENT 'Foreign key linking to compliance.license_renewal. Business justification: License renewal deadlines are critical compliance milestones tracked in the compliance calendar. This FK links calendar entries to specific license renewal records, enabling proactive deadline managem',
    `parent_calendar_id` BIGINT COMMENT 'Self-referencing FK on calendar (parent_calendar_id)',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Compliance calendar entries track specific filing deadlines. This FK links calendar deadlines to the actual regulatory filing records, enabling tracking of whether filings were submitted on time.',
    `regulatory_obligation_id` BIGINT COMMENT 'Reference to the underlying regulatory obligation that this calendar entry tracks. Links to the master obligation registry.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Compliance calendar deadlines must be assigned to specific employees for accountability and workload management. Responsible owner contact data should reference employee record.',
    `transmission_equipment_id` BIGINT COMMENT 'Foreign key linking to technology.transmission_equipment. Business justification: Scheduled equipment testing and certification deadlines (annual transmitter testing, EAS equipment verification) tracked in compliance calendar. Real broadcast operations workflow for regulatory deadl',
    `automation_status` STRING COMMENT 'Indicates the level of automation applied to this compliance obligation (manual process, semi-automated with human review, or fully automated).. Valid values are `manual|semi_automated|fully_automated`',
    `completion_date` DATE COMMENT 'Actual date when the compliance obligation was fulfilled and submitted or completed. Null if not yet completed.',
    `completion_status` STRING COMMENT 'Current status of the compliance obligation in its lifecycle (not started, in progress, under review, completed, submitted to regulatory body, overdue, or deferred). [ENUM-REF-CANDIDATE: not_started|in_progress|under_review|completed|submitted|overdue|deferred — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance calendar entry was first created in the system.',
    `deadline_date` DATE COMMENT 'The final date by which the compliance obligation must be fulfilled. This is the hard deadline for regulatory submission, renewal, or completion.',
    `deadline_description` STRING COMMENT 'Detailed description of the compliance deadline, including specific requirements, deliverables, and any special conditions or instructions.',
    `deadline_type` STRING COMMENT 'Category of compliance deadline being tracked (filing, license renewal, audit schedule, certification expiry, reporting period, or inspection).. Valid values are `filing|renewal|audit|certification|reporting|inspection`',
    `documentation_path` STRING COMMENT 'File system path or document management system location where supporting documentation for this compliance deadline is stored.',
    `documentation_required` BOOLEAN COMMENT 'Indicates whether supporting documentation, evidence, or attachments must be prepared and submitted with this compliance obligation.',
    `escalation_date` DATE COMMENT 'Date when this compliance deadline was escalated to senior management or executive leadership due to risk of non-compliance.',
    `escalation_path` STRING COMMENT 'Defined escalation hierarchy or contact chain for at-risk deadlines (e.g., Manager → Director → VP → Chief Compliance Officer).',
    `escalation_status` STRING COMMENT 'Indicates whether this deadline is at risk of being missed and requires management escalation (none, at risk, escalated to management, or critical).. Valid values are `none|at_risk|escalated|critical`',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction where this compliance obligation applies (e.g., USA, GBR, EUR, state-level, or specific market designation).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance calendar entry was last updated or modified.',
    `maximum_penalty_amount` DECIMAL(18,2) COMMENT 'Maximum financial penalty or fine amount that could be imposed for non-compliance with this obligation.',
    `monitoring_system` STRING COMMENT 'Name of the system or tool used to monitor and track progress toward this compliance deadline (e.g., GRC platform, workflow system, calendar application).',
    `next_occurrence_date` DATE COMMENT 'Date of the next scheduled occurrence of this recurring compliance obligation. Null for one-time obligations.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding this compliance deadline, including special instructions, dependencies, or historical issues.',
    `obligation_reference_number` STRING COMMENT 'External reference number or code assigned by the regulatory body to this specific obligation or filing requirement.',
    `penalty_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `penalty_description` STRING COMMENT 'Description of potential penalties, fines, sanctions, or consequences if this compliance deadline is missed or the obligation is not fulfilled.',
    `preparation_lead_time_days` STRING COMMENT 'Number of days required in advance of the deadline to prepare, review, and submit the compliance deliverable. Used to calculate reminder triggers.',
    `public_disclosure_required` BOOLEAN COMMENT 'Indicates whether this compliance obligation requires public disclosure or inclusion in the public inspection file (e.g., FCC OPIF requirements).',
    `recurrence_frequency` STRING COMMENT 'How often this compliance obligation recurs (one-time, daily, weekly, monthly, quarterly, semi-annually, annually, biennially, or triennially). [ENUM-REF-CANDIDATE: one_time|daily|weekly|monthly|quarterly|semi_annual|annual|biennial|triennial — 9 candidates stripped; promote to reference product]',
    `regulatory_body` STRING COMMENT 'The governing body or regulatory authority that mandates this compliance deadline (e.g., FCC for broadcast licensing, GDPR for data privacy, SOX for financial reporting). [ENUM-REF-CANDIDATE: FCC|Ofcom|MPA|ATSC|DVB|Nielsen|IAB|SCTE|ISO|GDPR|CCPA|SOX|PCI DSS|COPPA — 14 candidates stripped; promote to reference product]',
    `reminder_trigger_date` DATE COMMENT 'Date when automated reminders or alerts should be sent to the responsible owner to begin preparation. Calculated as deadline_date minus preparation_lead_time_days.',
    `reporting_period_end_date` DATE COMMENT 'End date of the reporting or compliance period covered by this deadline (e.g., fiscal quarter end, license term end).',
    `reporting_period_start_date` DATE COMMENT 'Start date of the reporting or compliance period covered by this deadline (e.g., fiscal quarter start, license term start).',
    `responsible_department` STRING COMMENT 'Business unit or department accountable for managing and completing this compliance obligation (e.g., Legal, Compliance, Engineering, Finance).',
    `risk_level` STRING COMMENT 'Assessed risk level associated with missing this compliance deadline, considering potential penalties, reputational impact, and operational consequences.. Valid values are `low|medium|high|critical`',
    `submission_confirmation_number` STRING COMMENT 'Confirmation or tracking number provided by the regulatory body upon successful submission of the compliance deliverable.',
    CONSTRAINT pk_calendar PRIMARY KEY(`calendar_id`)
) COMMENT 'Proactive compliance deadline and milestone tracker consolidating all regulatory filing deadlines, license renewal dates, audit schedules, certification expiries, and reporting periods into a single operational calendar. Captures deadline type, regulatory body, associated obligation, responsible owner, lead time for preparation, reminder triggers, completion status, and escalation path for at-risk deadlines. Serves as the operational heartbeat for compliance teams managing dozens of concurrent regulatory timelines across FCC, Ofcom, GDPR, SOX, and PCI obligations.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` (
    `regulatory_change_id` BIGINT COMMENT 'Unique identifier for the regulatory change record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory changes require compliance officer ownership for impact assessment and implementation tracking. Officer contact data should reference employee record for accountability.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Regulatory changes create, modify, or supersede regulatory obligations. This FK links a regulatory change to the primary obligation it affects, enabling impact tracking and compliance planning.',
    `superseded_regulatory_change_id` BIGINT COMMENT 'Self-referencing FK on regulatory_change (superseded_regulatory_change_id)',
    `affected_business_units` STRING COMMENT 'Comma-separated list of business units, departments, or divisions impacted by the regulatory change (e.g., Broadcasting Operations, Digital Platforms, Legal, Finance).',
    `affected_obligations_count` STRING COMMENT 'Number of existing regulatory obligations that are modified, superseded, or created by this change.',
    `change_number` STRING COMMENT 'Business identifier or reference number assigned to this regulatory change by the compliance team or regulatory body.',
    `change_status` STRING COMMENT 'Current lifecycle status of the regulatory change: proposed, under review, approved, effective (in force), deferred, or withdrawn.. Valid values are `proposed|under_review|approved|effective|deferred|withdrawn`',
    `change_type` STRING COMMENT 'The nature of the regulatory change: new rule, amendment to existing rule, repeal, guidance update, interpretation clarification, or technical standard update.. Valid values are `new_rule|amendment|repeal|guidance_update|interpretation|technical_standard_update`',
    `compliance_deadline` DATE COMMENT 'The date by which the organization must achieve full compliance with the regulatory change.',
    `cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated cost (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory change record was first created in the system.',
    `documentation_url` STRING COMMENT 'URL link to the official regulatory documentation, Federal Register notice, or issuing bodys publication page.',
    `effective_date` DATE COMMENT 'The date when the regulatory change becomes legally binding and enforceable.',
    `estimated_cost_amount` DECIMAL(18,2) COMMENT 'Estimated financial cost to implement the regulatory change, including system modifications, training, and process updates.',
    `expiration_date` DATE COMMENT 'The date when the regulatory change expires or sunsets, if applicable. Null for permanent changes.',
    `impact_assessment` STRING COMMENT 'Assessment of the regulatory changes impact on the organizations operations, systems, and compliance posture: critical, high, medium, low, or minimal.. Valid values are `critical|high|medium|low|minimal`',
    `impact_description` STRING COMMENT 'Detailed narrative describing how the regulatory change affects the organization, including operational, technical, and financial implications.',
    `implementation_completion_date` DATE COMMENT 'The date when implementation was completed and the organization achieved full compliance.',
    `implementation_plan` STRING COMMENT 'Summary of the plan to implement the regulatory change, including key milestones, resource requirements, and system modifications.',
    `implementation_start_date` DATE COMMENT 'The date when implementation activities for this regulatory change began.',
    `implementation_status` STRING COMMENT 'Current status of the organizations implementation efforts: not started, planning, in progress, testing, completed, or deferred.. Valid values are `not_started|planning|in_progress|testing|completed|deferred`',
    `issuing_body` STRING COMMENT 'The regulatory authority or governing body that issued the change (e.g., FCC, Ofcom, European Commission, MPA, ATSC).',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction where the regulatory change applies (e.g., USA, GBR, EUR, California).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory change record was last updated or modified.',
    `maximum_penalty_amount` DECIMAL(18,2) COMMENT 'Maximum financial penalty or fine that could be imposed for non-compliance with this regulatory change.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the regulatory change, implementation challenges, or special considerations.',
    `organization_comment_submitted` BOOLEAN COMMENT 'Indicates whether the organization submitted formal comments during the public comment period (True/False).',
    `penalty_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the maximum penalty amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `penalty_description` STRING COMMENT 'Description of potential penalties, fines, or sanctions for non-compliance with this regulatory change.',
    `public_comment_period_end` DATE COMMENT 'End date of the public comment period for proposed regulatory changes, if applicable.',
    `public_comment_period_start` DATE COMMENT 'Start date of the public comment period for proposed regulatory changes, if applicable.',
    `publication_date` DATE COMMENT 'The date when the regulatory change was officially published or announced by the issuing body.',
    `regulation_name` STRING COMMENT 'The name or title of the regulation being changed (e.g., FCC Part 73, GDPR Article 5, ATSC 3.0 Standard).',
    `regulation_reference_number` STRING COMMENT 'Official reference number or citation of the regulation (e.g., 47 CFR 73.1201, ISO 14496-10).',
    `regulatory_domain` STRING COMMENT 'The compliance domain affected by this change: broadcast licensing, content standards, data privacy, financial reporting, accessibility, technical standards, advertising, or rights management. [ENUM-REF-CANDIDATE: broadcast_licensing|content_standards|data_privacy|financial_reporting|accessibility|technical_standards|advertising|rights_management — 8 candidates stripped; promote to reference product]',
    `related_changes` STRING COMMENT 'Comma-separated list of related regulatory change identifiers or reference numbers that are connected to this change.',
    `risk_level` STRING COMMENT 'Risk level associated with non-compliance or delayed implementation of this regulatory change: critical, high, medium, or low.. Valid values are `critical|high|medium|low`',
    `sign_off_date` DATE COMMENT 'The date when the compliance officer formally signed off on the implementation of this regulatory change.',
    `sign_off_status` STRING COMMENT 'Status of formal sign-off by the compliance officer: pending, approved, rejected, or conditional approval.. Valid values are `pending|approved|rejected|conditional`',
    `supersedes_regulation_reference` STRING COMMENT 'Reference number or identifier of the previous regulation that this change supersedes or replaces, if applicable.',
    CONSTRAINT pk_regulatory_change PRIMARY KEY(`regulatory_change_id`)
) COMMENT 'Tracks new, amended, or repealed regulations and their impact on the organizations compliance posture. Captures regulation identifier, issuing body, change type (new rule, amendment, repeal, guidance update), effective date, impact assessment, affected business units, affected existing obligations, implementation plan, implementation status, and sign-off by compliance officer. Essential for media companies navigating rapidly evolving digital privacy laws, streaming regulations, and broadcast rule modernization (e.g., FCC ATSC 3.0 mandates, EU Digital Services Act).';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance_obligation` (
    `facility_compliance_obligation_id` BIGINT COMMENT 'Unique identifier for this facility-obligation compliance tracking record. Primary key.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to the accessibility obligation being tracked for this facility',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to the broadcast facility where this obligation applies',
    `compliance_percentage` DECIMAL(18,2) COMMENT 'Percentage of content or platform features at this facility currently meeting this accessibility requirement. Moved from accessibility_obligation because compliance percentage is facility-specific.',
    `compliance_status` STRING COMMENT 'Current state of this specific facilitys compliance with this specific obligation: compliant, non_compliant, in_progress, exempt, waived, not_applicable. Moved from accessibility_obligation because compliance status varies by facility.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility-obligation compliance tracking record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when this obligation became applicable to this specific facility (may differ from the obligations general effective_date if facilities were added later or have phased rollout).',
    `exemption_reason` STRING COMMENT 'Explanation of why this obligation does not apply to this specific facility or why a waiver was granted for this facility-obligation combination. Moved from accessibility_obligation because exemptions are granted per facility.',
    `facility_responsible_person` STRING COMMENT 'Name or identifier of the person at this facility responsible for ensuring compliance with this specific obligation (may differ from the corporate responsible_team).',
    `last_compliance_review_date` DATE COMMENT 'Date when this facility last conducted an internal review or audit of compliance with this specific obligation. Moved from accessibility_obligation because review schedules are managed per facility.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility-obligation compliance tracking record was most recently modified.',
    `next_compliance_review_date` DATE COMMENT 'Scheduled date for the next internal review or audit of this facilitys compliance with this obligation. Moved from accessibility_obligation because review schedules are facility-specific.',
    `waiver_expiration_date` DATE COMMENT 'Date when a granted waiver or exemption expires for this facility and the obligation becomes enforceable. Moved from accessibility_obligation because waivers are facility-specific.',
    CONSTRAINT pk_facility_compliance_obligation PRIMARY KEY(`facility_compliance_obligation_id`)
) COMMENT 'This association product represents the compliance tracking relationship between accessibility obligations and broadcast facilities. It captures facility-specific compliance status, review schedules, exemptions, and waivers for each accessibility requirement at each physical location. Each record links one accessibility obligation to one broadcast facility with compliance metrics and dates that exist only in the context of this specific facility-obligation pairing.. Existence Justification: In media broadcasting operations, each accessibility obligation (closed captioning, audio description, emergency alert accessibility, etc.) applies to multiple physical facilities (studios, NOCs, transmission sites), and each facility must comply with multiple accessibility obligations. Compliance is tracked and managed at the facility level because different facilities have different compliance statuses, review schedules, exemptions, and waiver expiration dates for the same obligation. The compliance team actively manages these facility-obligation pairings as part of regulatory reporting and audit preparation.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance` (
    `facility_compliance_id` BIGINT COMMENT 'Unique identifier for this facility-obligation compliance record. Primary key.',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to the broadcast facility subject to this regulatory obligation',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to the regulatory obligation being tracked for this facility',
    `compliance_status` STRING COMMENT 'Current compliance status of this specific facility with respect to this specific obligation. Status is facility-specific because different facilities may have different compliance states for the same obligation (e.g., Studio A compliant, Transmission Site B under review).',
    `exemption_reason` STRING COMMENT 'Explanation of why this facility is exempt from this regulatory obligation, if applicable. Exemptions are facility-specific based on facility type, jurisdiction, operational scope, or regulatory waivers (e.g., transmission sites exempt from studio-specific obligations).',
    `first_compliance_date` DATE COMMENT 'Date when this facility first achieved compliance with this obligation. Captures the historical start of the compliance relationship for audit trail and reporting purposes.',
    `last_compliance_review_date` DATE COMMENT 'Date when compliance with this obligation was last reviewed or assessed at this specific facility. Review dates vary by facility based on local audits, inspections, and facility-specific compliance activities.',
    `next_compliance_review_date` DATE COMMENT 'Scheduled date for the next compliance review or assessment of this obligation at this specific facility. Review schedules may differ by facility based on risk level, past compliance history, and facility type.',
    `notes` STRING COMMENT 'Free-text notes about facility-specific compliance considerations, remediation actions, inspection findings, or other contextual information relevant to this facility-obligation relationship.',
    `responsible_party_name` STRING COMMENT 'Name of the individual or role responsible for ensuring compliance with this obligation at this specific facility. Responsibility is facility-specific - different facility managers or compliance officers may own the same obligation at different locations.',
    `waiver_expiration_date` DATE COMMENT 'Date when a regulatory waiver or exemption expires for this facility-obligation combination. Waivers are granted per-facility and have facility-specific expiration dates requiring renewal or compliance action.',
    CONSTRAINT pk_facility_compliance PRIMARY KEY(`facility_compliance_id`)
) COMMENT 'This association product represents the compliance relationship between regulatory obligations and broadcast facilities. It captures facility-specific compliance status, review schedules, exemptions, and responsible parties for each obligation at each facility. Each record links one regulatory obligation to one broadcast facility with attributes that exist only in the context of this specific facility-obligation compliance relationship.. Existence Justification: In media broadcasting operations, regulatory obligations apply to multiple facilities based on facility type and jurisdiction (e.g., EAS participation applies to all transmission sites, public inspection file requirements apply to all studios, tower lighting standards apply to all transmission towers), and each facility must comply with multiple obligations simultaneously (e.g., a studio must comply with EAS, public file, accessibility, content standards). Compliance officers actively manage facility-specific compliance status, review schedules, exemptions, and responsible parties for each obligation at each facility - this is an operational compliance tracking process, not an analytical correlation.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` (
    `audit_id` BIGINT COMMENT 'Primary key for audit',
    `follow_up_audit_id` BIGINT COMMENT 'Self-referencing FK on audit (follow_up_audit_id)',
    `accessibility_standard` STRING COMMENT 'Accessibility standard or guideline under audit (e.g., WCAG 2.1, Section 508, CVAA closed captioning).',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the audit fieldwork or review was completed.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the audit fieldwork or review commenced.',
    `audit_number` STRING COMMENT 'Externally-known unique business identifier for the audit, used in regulatory filings and correspondence.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit process.',
    `audit_type` STRING COMMENT 'Classification of the audit based on its regulatory or compliance domain (e.g., FCC licensing, content standards, GDPR privacy, SOX financial).',
    `auditor_organization` STRING COMMENT 'Classification of the auditing organization (internal audit team, external audit firm, or regulatory body inspection).',
    `compliance_rating` STRING COMMENT 'Overall compliance assessment or rating assigned by the auditor based on findings.',
    `content_rating_system` STRING COMMENT 'Content rating or classification system under audit (e.g., MPA film ratings, TV Parental Guidelines).',
    `cost` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting the audit, including auditor fees and internal resource costs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was first created in the system.',
    `critical_finding_count` STRING COMMENT 'Number of critical or high-severity findings that require immediate remediation.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for audit cost and financial amounts.',
    `data_privacy_framework` STRING COMMENT 'Data privacy regulation or framework under audit (e.g., GDPR, CCPA, COPPA for childrens content).',
    `finding_count` STRING COMMENT 'Total number of audit findings, observations, or non-conformances identified during the audit.',
    `firm_name` STRING COMMENT 'Name of the external audit firm or regulatory body conducting the audit, if applicable.',
    `follow_up_audit_required` BOOLEAN COMMENT 'Indicates whether a follow-up audit is required to verify remediation of findings.',
    `frequency` STRING COMMENT 'Scheduled recurrence pattern for this audit type.',
    `governing_body` STRING COMMENT 'Name of the regulatory or standards body that mandates or oversees this audit (e.g., Federal Communications Commission, Office of Communications).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was last updated or modified.',
    `lead_auditor_name` STRING COMMENT 'Full name of the lead auditor responsible for conducting and signing off on the audit.',
    `license_number` STRING COMMENT 'Broadcast license number or regulatory authorization identifier associated with this audit, if applicable.',
    `methodology` STRING COMMENT 'Primary methodology or approach used to conduct the audit.',
    `notes` STRING COMMENT 'Free-text notes, observations, or additional context recorded by auditors during the audit process.',
    `opinion` STRING COMMENT 'Formal auditor opinion or conclusion issued for financial or SOX audits.',
    `regulatory_framework` STRING COMMENT 'Primary regulatory framework or governing body standard under which this audit is conducted.',
    `remediation_due_date` DATE COMMENT 'Deadline by which identified findings must be remediated or corrective actions completed.',
    `remediation_status` STRING COMMENT 'Current status of remediation efforts for audit findings.',
    `report_file_path` STRING COMMENT 'Storage location or file path reference for the audit report document in the document management system.',
    `report_issued_date` DATE COMMENT 'Date on which the formal audit report was issued to management or regulatory body.',
    `sample_size` STRING COMMENT 'Number of records, transactions, or items sampled during the audit, if sampling methodology was used.',
    `scheduled_end_date` DATE COMMENT 'Planned date for the audit to conclude.',
    `scheduled_start_date` DATE COMMENT 'Planned date for the audit to commence.',
    `scope` STRING COMMENT 'Detailed description of the audit scope, including systems, processes, and compliance areas covered.',
    `station_call_sign` STRING COMMENT 'FCC-assigned call sign of the broadcast station subject to this audit, if applicable.',
    `technical_standard` STRING COMMENT 'Broadcast technical standard or specification under audit (e.g., ATSC 3.0, DVB-T, MPEG-4).',
    `title` STRING COMMENT 'Human-readable title or name of the audit engagement.',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Master reference table for audit. Referenced by audit_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ADD CONSTRAINT `fk_compliance_license_renewal_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ADD CONSTRAINT `fk_compliance_license_renewal_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_original_filing_regulatory_filing_id` FOREIGN KEY (`original_filing_regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ADD CONSTRAINT `fk_compliance_public_inspection_file_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ADD CONSTRAINT `fk_compliance_public_inspection_file_original_document_public_inspection_file_id` FOREIGN KEY (`original_document_public_inspection_file_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file`(`public_inspection_file_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ADD CONSTRAINT `fk_compliance_public_inspection_file_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ADD CONSTRAINT `fk_compliance_coppa_declaration_compliance_consent_record_id` FOREIGN KEY (`compliance_consent_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record`(`compliance_consent_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ADD CONSTRAINT `fk_compliance_compliance_consent_record_superseded_by_consent_record_compliance_consent_record_id` FOREIGN KEY (`superseded_by_consent_record_compliance_consent_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record`(`compliance_consent_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_compliance_consent_record_id` FOREIGN KEY (`compliance_consent_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record`(`compliance_consent_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ADD CONSTRAINT `fk_compliance_accessibility_obligation_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ADD CONSTRAINT `fk_compliance_eas_log_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ADD CONSTRAINT `fk_compliance_eas_log_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`calendar`(`calendar_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ADD CONSTRAINT `fk_compliance_eas_log_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_public_inspection_file_id` FOREIGN KEY (`public_inspection_file_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file`(`public_inspection_file_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ADD CONSTRAINT `fk_compliance_sox_control_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ADD CONSTRAINT `fk_compliance_sox_control_compensating_control_id` FOREIGN KEY (`compensating_control_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_previous_finding_audit_finding_id` FOREIGN KEY (`previous_finding_audit_finding_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_superseded_by_obligation_regulatory_obligation_id` FOREIGN KEY (`superseded_by_obligation_regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ADD CONSTRAINT `fk_compliance_ad_standards_clearance_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ADD CONSTRAINT `fk_compliance_technical_standard_cert_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ADD CONSTRAINT `fk_compliance_technical_standard_cert_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_license_renewal_id` FOREIGN KEY (`license_renewal_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`license_renewal`(`license_renewal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_parent_calendar_id` FOREIGN KEY (`parent_calendar_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`calendar`(`calendar_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_superseded_regulatory_change_id` FOREIGN KEY (`superseded_regulatory_change_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance_obligation` ADD CONSTRAINT `fk_compliance_facility_compliance_obligation_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance` ADD CONSTRAINT `fk_compliance_facility_compliance_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_follow_up_audit_id` FOREIGN KEY (`follow_up_audit_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`audit`(`audit_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` SET TAGS ('dbx_subdomain' = 'broadcast_licensing');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Equipment Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` SET TAGS ('dbx_subdomain' = 'broadcast_licensing');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `license_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'License Renewal Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` SET TAGS ('dbx_subdomain' = 'broadcast_licensing');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Filed By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `original_filing_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Original Filing Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Equipment Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` SET TAGS ('dbx_subdomain' = 'broadcast_licensing');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `public_inspection_file_id` SET TAGS ('dbx_business_glossary_term' = 'Public Inspection File ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Station ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `original_document_public_inspection_file_id` SET TAGS ('dbx_business_glossary_term' = 'Original Document ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Uploaded By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Title ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` SET TAGS ('dbx_subdomain' = 'privacy_governance');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `coppa_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'COPPA (Childrens Online Privacy Protection Act) Declaration ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `compliance_consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Declared By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'OTT (Over-The-Top) Platform ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `actual_knowledge_flag` SET TAGS ('dbx_business_glossary_term' = 'Actual Knowledge Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `advertising_assessment` SET TAGS ('dbx_business_glossary_term' = 'Advertising Assessment');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `audio_content_assessment` SET TAGS ('dbx_business_glossary_term' = 'Audio Content Assessment');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `child_celebrity_presence_flag` SET TAGS ('dbx_business_glossary_term' = 'Child Celebrity Presence Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `data_collection_scope` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `declaration_date` SET TAGS ('dbx_business_glossary_term' = 'Declaration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `declaration_number` SET TAGS ('dbx_business_glossary_term' = 'COPPA Declaration Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `declaration_number` SET TAGS ('dbx_value_regex' = '^COPPA-[0-9]{4}-[A-Z0-9]{8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `declaration_status` SET TAGS ('dbx_business_glossary_term' = 'Declaration Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `declaration_type` SET TAGS ('dbx_business_glossary_term' = 'Declaration Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `declaration_type` SET TAGS ('dbx_value_regex' = 'content|service|platform|website|mobile_app|interactive_feature');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `directed_to_children_status` SET TAGS ('dbx_business_glossary_term' = 'Directed-to-Children Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `directed_to_children_status` SET TAGS ('dbx_value_regex' = 'directed|mixed_audience|not_directed|under_review');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `ftc_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'FTC (Federal Trade Commission) Filing Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `legal_opinion_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Opinion Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `parental_consent_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Mechanism');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `persistent_identifier_collection_flag` SET TAGS ('dbx_business_glossary_term' = 'Persistent Identifier Collection Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `privacy_policy_url` SET TAGS ('dbx_business_glossary_term' = 'Privacy Policy URL (Uniform Resource Locator)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `reviewer_title` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `safe_harbor_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Safe Harbor Certification Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `safe_harbor_program` SET TAGS ('dbx_business_glossary_term' = 'FTC (Federal Trade Commission) Safe Harbor Program');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `subject_matter_description` SET TAGS ('dbx_business_glossary_term' = 'Subject Matter Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `target_age_range_max` SET TAGS ('dbx_business_glossary_term' = 'Target Age Range Maximum');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `target_age_range_min` SET TAGS ('dbx_business_glossary_term' = 'Target Age Range Minimum');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `verifiable_consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Verifiable Parental Consent Obtained Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ALTER COLUMN `visual_content_assessment` SET TAGS ('dbx_business_glossary_term' = 'Visual Content Assessment');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` SET TAGS ('dbx_subdomain' = 'privacy_governance');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `compliance_consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `device_type_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `device_type_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `device_type_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processed By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Subject Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `superseded_by_consent_record_compliance_consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Consent Record Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `consent_channel` SET TAGS ('dbx_business_glossary_term' = 'Consent Collection Channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `consent_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `consent_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Consent Mechanism');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `consent_proof_url` SET TAGS ('dbx_business_glossary_term' = 'Consent Proof Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `consent_proof_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `consent_source_system` SET TAGS ('dbx_business_glossary_term' = 'Consent Source System');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|expired|not_yet_given|pending');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Event Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `consent_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Consent Transaction Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'data_processing|marketing|profiling|cookies|targeted_advertising|cross_device_tracking');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `cookie_consent_categories` SET TAGS ('dbx_business_glossary_term' = 'Cookie Consent Categories');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Consent Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Consent Jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `marketing_email_consent` SET TAGS ('dbx_business_glossary_term' = 'Marketing Email Consent Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `marketing_email_consent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `marketing_email_consent` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `marketing_push_consent` SET TAGS ('dbx_business_glossary_term' = 'Marketing Push Notification Consent Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `marketing_sms_consent` SET TAGS ('dbx_business_glossary_term' = 'Marketing Short Message Service (SMS) Consent Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `parental_consent_verified` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Verified Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `parental_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Parental Verification Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `privacy_policy_version` SET TAGS ('dbx_business_glossary_term' = 'Privacy Policy Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `subject_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Subject Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `subject_type` SET TAGS ('dbx_value_regex' = 'subscriber|registered_user|anonymous_viewer|guest|device');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `tcf_consent_string` SET TAGS ('dbx_business_glossary_term' = 'Transparency and Consent Framework (TCF) Consent String');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `third_party_sharing_consent` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Sharing Consent Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `withdrawal_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Mechanism');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ALTER COLUMN `withdrawal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` SET TAGS ('dbx_subdomain' = 'privacy_governance');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `privacy_request_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Request ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Handler Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `compliance_consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Related Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `data_categories_involved` SET TAGS ('dbx_business_glossary_term' = 'Data Categories Involved');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `data_volume_processed` SET TAGS ('dbx_business_glossary_term' = 'Data Volume Processed (MB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `extended_deadline` SET TAGS ('dbx_business_glossary_term' = 'Extended Deadline Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `extension_granted` SET TAGS ('dbx_business_glossary_term' = 'Extension Granted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `extension_reason` SET TAGS ('dbx_business_glossary_term' = 'Extension Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'not_started|data_collection|data_review|response_preparation|response_sent|closed');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Request Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `processing_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Processing Time (Hours)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `regulatory_deadline` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Deadline Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'gdpr|ccpa|both|other');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Privacy Request Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^PR-[0-9]{8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Privacy Request Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Privacy Request Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'access|erasure|portability|rectification|restriction|opt_out_sale');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_business_glossary_term' = 'Requestor Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `requestor_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Requestor Jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `requestor_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Full Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `requestor_phone` SET TAGS ('dbx_business_glossary_term' = 'Requestor Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `requestor_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `requestor_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `response_method` SET TAGS ('dbx_business_glossary_term' = 'Response Delivery Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `response_method` SET TAGS ('dbx_value_regex' = 'email|secure_portal|mail|phone|in_person');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `submission_channel` SET TAGS ('dbx_value_regex' = 'web_form|email|phone|mail|mobile_app|chat');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `systems_accessed` SET TAGS ('dbx_business_glossary_term' = 'Systems Accessed');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'email_confirmation|account_login|document_upload|phone_verification|two_factor_auth|manual_review');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|failed|not_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` SET TAGS ('dbx_subdomain' = 'content_standards');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `closed_caption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Record ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Caption Vendor Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Title ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `encoder_config_id` SET TAGS ('dbx_business_glossary_term' = 'Encoder Config Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Narrator Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ALTER COLUMN `public_inspection_file_included` SET TAGS ('dbx_business_glossary_term' = 'Public Inspection File Included');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Contact Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `applicable_regulation` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulation');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ALTER COLUMN `applicable_regulation` SET TAGS ('dbx_value_regex' = 'cvaa|ada|ofcom_access_code|eu_audiovisual_directive|wcag_2_1|atsc_a_53');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` SET TAGS ('dbx_subdomain' = 'content_standards');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `eas_log_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Alert System (EAS) Log ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Calendar Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Station ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Equipment Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ALTER COLUMN `public_inspection_file_entry` SET TAGS ('dbx_business_glossary_term' = 'Public Inspection File Entry Flag');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` SET TAGS ('dbx_subdomain' = 'content_standards');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `political_ad_record_id` SET TAGS ('dbx_business_glossary_term' = 'Political Ad Record ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `public_inspection_file_id` SET TAGS ('dbx_business_glossary_term' = 'Public Inspection File Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` SET TAGS ('dbx_subdomain' = 'audit_controls');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Related Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `compensating_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compensating Control Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `compensating_control_id` SET TAGS ('dbx_self_ref_fk_reviewed' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `assertion_category` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Assertion Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `auditor_notes` SET TAGS ('dbx_business_glossary_term' = 'Auditor Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `automated_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Control Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `control_description` SET TAGS ('dbx_business_glossary_term' = 'Control Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `control_documentation_path` SET TAGS ('dbx_business_glossary_term' = 'Control Documentation Path');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `control_frequency` SET TAGS ('dbx_business_glossary_term' = 'Control Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `control_name` SET TAGS ('dbx_business_glossary_term' = 'Control Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `control_number` SET TAGS ('dbx_business_glossary_term' = 'Control Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `control_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{3,5}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `control_objective` SET TAGS ('dbx_business_glossary_term' = 'Control Objective');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `control_status` SET TAGS ('dbx_business_glossary_term' = 'Control Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `control_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under remediation|pending implementation|retired');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'preventive|detective|it general control|it application control|entity level control|management review control');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `deficiency_classification` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `deficiency_classification` SET TAGS ('dbx_value_regex' = 'no deficiency|control deficiency|significant deficiency|material weakness');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `deficiency_description` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `financial_statement_line_item` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Line Item');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `key_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Key Control Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Test Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `management_assertion_mapping` SET TAGS ('dbx_business_glossary_term' = 'Management Assertion Mapping');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `process_area` SET TAGS ('dbx_business_glossary_term' = 'Process Area');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not applicable|planned|in progress|completed|validated');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `remediation_target_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Target Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `system_name` SET TAGS ('dbx_business_glossary_term' = 'System Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `test_frequency` SET TAGS ('dbx_business_glossary_term' = 'Test Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `test_frequency` SET TAGS ('dbx_value_regex' = 'quarterly|semi-annual|annual|event-driven');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'effective|ineffective with exception|ineffective|not tested');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` SET TAGS ('dbx_subdomain' = 'audit_controls');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Station Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `previous_finding_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Remediation Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Equipment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `affected_process` SET TAGS ('dbx_business_glossary_term' = 'Affected Business Process');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `affected_system` SET TAGS ('dbx_business_glossary_term' = 'Affected System or Application');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal|external|regulatory|certification|surveillance');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_type` SET TAGS ('dbx_business_glossary_term' = 'Auditor Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `auditor_type` SET TAGS ('dbx_value_regex' = 'internal|external|regulatory');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_business_glossary_term' = 'Finding Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_value_regex' = 'open|in_remediation|pending_verification|closed|deferred');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Identified Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `management_response` SET TAGS ('dbx_business_glossary_term' = 'Management Response');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Finding Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `potential_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Potential Penalty Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `potential_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `recommended_remediation` SET TAGS ('dbx_business_glossary_term' = 'Recommended Remediation Action');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `recurrence_indicator` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_domain` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Domain');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Finding Severity');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_subdomain' = 'regulatory_tracking');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `related_policy_document` SET TAGS ('dbx_business_glossary_term' = 'Related Policy Document');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` SET TAGS ('dbx_subdomain' = 'audit_controls');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Station ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `coppa_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Coppa Declaration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `encoder_config_id` SET TAGS ('dbx_business_glossary_term' = 'Encoder Config Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Impacted Content ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Equipment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `affected_regulation` SET TAGS ('dbx_business_glossary_term' = 'Affected Regulation');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified|overdue');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `discovery_source` SET TAGS ('dbx_business_glossary_term' = 'Discovery Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `escalation_status` SET TAGS ('dbx_business_glossary_term' = 'Escalation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `escalation_status` SET TAGS ('dbx_value_regex' = 'not_escalated|escalated_to_management|escalated_to_legal|escalated_to_board|escalated_to_regulator');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `impacted_service` SET TAGS ('dbx_business_glossary_term' = 'Impacted Service');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|remediation_in_progress|closed|escalated|pending_regulatory_response');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `recurrence_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Risk Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `recurrence_risk_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|negligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `regulatory_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `regulatory_notification_method` SET TAGS ('dbx_value_regex' = 'electronic_filing|written_notice|phone|in_person|not_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` SET TAGS ('dbx_subdomain' = 'content_standards');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `ad_standards_clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Standards Clearance ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `isci_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Creative ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `ad_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Ad Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `alcohol_tobacco_flag` SET TAGS ('dbx_business_glossary_term' = 'Alcohol or Tobacco Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|overturned|pending|not applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `children_directed_flag` SET TAGS ('dbx_business_glossary_term' = 'Children Directed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `clearance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Clearance Certificate Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `clearance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `clearance_type` SET TAGS ('dbx_business_glossary_term' = 'Clearance Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `clearance_type` SET TAGS ('dbx_value_regex' = 'pre-clearance|post-air review|expedited review|routine review|special review');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `financial_services_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Services Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `isci_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Standard Commercial Identification (ISCI) Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `isci_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[0-9]{4}[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Clearance Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `political_ad_flag` SET TAGS ('dbx_business_glossary_term' = 'Political Ad Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `political_candidate_name` SET TAGS ('dbx_business_glossary_term' = 'Political Candidate Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `political_candidate_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `political_candidate_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `political_office_sought` SET TAGS ('dbx_business_glossary_term' = 'Political Office Sought');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `prescription_drug_flag` SET TAGS ('dbx_business_glossary_term' = 'Prescription Drug Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `prescription_drug_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `prescription_drug_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `rejection_category` SET TAGS ('dbx_business_glossary_term' = 'Rejection Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Review Outcome');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `review_outcome` SET TAGS ('dbx_value_regex' = 'approved|approved with edits|rejected|pending|withdrawn');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `standards_body` SET TAGS ('dbx_business_glossary_term' = 'Standards Body');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `substantiation_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Substantiation Provided Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `substantiation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Substantiation Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` SET TAGS ('dbx_subdomain' = 'broadcast_licensing');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `technical_standard_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Standard Certification ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `encoder_config_id` SET TAGS ('dbx_business_glossary_term' = 'Encoder Config Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Equipment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `applicable_platform` SET TAGS ('dbx_business_glossary_term' = 'Applicable Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `certificate_file_path` SET TAGS ('dbx_business_glossary_term' = 'Certificate File Path');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|non_compliant|pending|expired|under_review|waived');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `equipment_identifier` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `non_conformance_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `non_conformance_details` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Details');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `recertification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recertification Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `recertification_required` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `standard_category` SET TAGS ('dbx_business_glossary_term' = 'Technical Standard Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `standard_name` SET TAGS ('dbx_business_glossary_term' = 'Technical Standard Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `standard_version` SET TAGS ('dbx_business_glossary_term' = 'Technical Standard Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `test_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Report Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|not_tested');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `test_score` SET TAGS ('dbx_business_glossary_term' = 'Test Score');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `testing_lab_name` SET TAGS ('dbx_business_glossary_term' = 'Testing Laboratory Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ALTER COLUMN `transmission_system` SET TAGS ('dbx_business_glossary_term' = 'Transmission System');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` SET TAGS ('dbx_subdomain' = 'regulatory_tracking');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Calendar ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Station ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `license_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'License Renewal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `parent_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Calendar Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `parent_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Equipment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `automation_status` SET TAGS ('dbx_business_glossary_term' = 'Automation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `automation_status` SET TAGS ('dbx_value_regex' = 'manual|semi_automated|fully_automated');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Deadline Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `deadline_description` SET TAGS ('dbx_business_glossary_term' = 'Deadline Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `deadline_type` SET TAGS ('dbx_business_glossary_term' = 'Deadline Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `deadline_type` SET TAGS ('dbx_value_regex' = 'filing|renewal|audit|certification|reporting|inspection');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `documentation_path` SET TAGS ('dbx_business_glossary_term' = 'Documentation Path');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `documentation_required` SET TAGS ('dbx_business_glossary_term' = 'Documentation Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `escalation_path` SET TAGS ('dbx_business_glossary_term' = 'Escalation Path');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `escalation_status` SET TAGS ('dbx_business_glossary_term' = 'Escalation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `escalation_status` SET TAGS ('dbx_value_regex' = 'none|at_risk|escalated|critical');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `maximum_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Penalty Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `monitoring_system` SET TAGS ('dbx_business_glossary_term' = 'Monitoring System');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `next_occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Next Occurrence Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `obligation_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Obligation Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `penalty_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `preparation_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Preparation Lead Time Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `public_disclosure_required` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `reminder_trigger_date` SET TAGS ('dbx_business_glossary_term' = 'Reminder Trigger Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ALTER COLUMN `submission_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Confirmation Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` SET TAGS ('dbx_subdomain' = 'regulatory_tracking');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `superseded_regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Regulatory Change Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `superseded_regulatory_change_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `affected_business_units` SET TAGS ('dbx_business_glossary_term' = 'Affected Business Units');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `affected_obligations_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Obligations Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_status` SET TAGS ('dbx_value_regex' = 'proposed|under_review|approved|effective|deferred|withdrawn');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'new_rule|amendment|repeal|guidance_update|interpretation|technical_standard_update');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL (Uniform Resource Locator)');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Implementation Cost Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|minimal');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `impact_description` SET TAGS ('dbx_business_glossary_term' = 'Impact Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Completion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_plan` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_status` SET TAGS ('dbx_value_regex' = 'not_started|planning|in_progress|testing|completed|deferred');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Regulatory Body');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `maximum_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Penalty Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `maximum_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `organization_comment_submitted` SET TAGS ('dbx_business_glossary_term' = 'Organization Comment Submitted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `penalty_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `public_comment_period_end` SET TAGS ('dbx_business_glossary_term' = 'Public Comment Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `public_comment_period_start` SET TAGS ('dbx_business_glossary_term' = 'Public Comment Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulation_name` SET TAGS ('dbx_business_glossary_term' = 'Regulation Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulation_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulation Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_domain` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Domain');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `related_changes` SET TAGS ('dbx_business_glossary_term' = 'Related Regulatory Changes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `sign_off_status` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `sign_off_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ALTER COLUMN `supersedes_regulation_reference` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Regulation Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance_obligation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance_obligation` SET TAGS ('dbx_subdomain' = 'broadcast_licensing');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance_obligation` SET TAGS ('dbx_association_edges' = 'compliance.accessibility_obligation,technology.broadcast_facility');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance_obligation` ALTER COLUMN `facility_compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Compliance Obligation ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance_obligation` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Compliance Obligation - Accessibility Obligation Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance_obligation` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Compliance Obligation - Broadcast Facility Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance_obligation` ALTER COLUMN `compliance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Compliance Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance_obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance_obligation` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Exemption Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance_obligation` ALTER COLUMN `facility_responsible_person` SET TAGS ('dbx_business_glossary_term' = 'Facility Responsible Person');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance_obligation` ALTER COLUMN `last_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance_obligation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance_obligation` ALTER COLUMN `next_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance_obligation` ALTER COLUMN `waiver_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance` SET TAGS ('dbx_subdomain' = 'broadcast_licensing');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance` SET TAGS ('dbx_association_edges' = 'compliance.regulatory_obligation,technology.broadcast_facility');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance` ALTER COLUMN `facility_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Compliance Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Compliance - Broadcast Facility Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Compliance - Regulatory Obligation Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Facility-Specific Compliance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Facility-Specific Exemption Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance` ALTER COLUMN `first_compliance_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Facility Compliance Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance` ALTER COLUMN `last_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Facility Compliance Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance` ALTER COLUMN `next_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Facility Compliance Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Facility Compliance Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Compliance Responsible Party');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance` ALTER COLUMN `waiver_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Facility Waiver Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` SET TAGS ('dbx_subdomain' = 'audit_controls');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `follow_up_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Audit Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `follow_up_audit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `accessibility_standard` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `auditor_organization` SET TAGS ('dbx_business_glossary_term' = 'Auditor Organization');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `compliance_rating` SET TAGS ('dbx_business_glossary_term' = 'Compliance Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_business_glossary_term' = 'Content Rating System');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `critical_finding_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Finding Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `data_privacy_framework` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Framework');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `finding_count` SET TAGS ('dbx_business_glossary_term' = 'Finding Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `firm_name` SET TAGS ('dbx_business_glossary_term' = 'Audit Firm Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `follow_up_audit_required` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Audit Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Audit Methodology');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `opinion` SET TAGS ('dbx_business_glossary_term' = 'Audit Opinion');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `report_file_path` SET TAGS ('dbx_business_glossary_term' = 'Report File Path');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `report_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `report_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Report Issued Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `station_call_sign` SET TAGS ('dbx_business_glossary_term' = 'Station Call Sign');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `technical_standard` SET TAGS ('dbx_business_glossary_term' = 'Technical Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Audit Title');
