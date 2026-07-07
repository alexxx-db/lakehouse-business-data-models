-- Schema for Domain: regulatory | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 05:32:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`regulatory` COMMENT 'Owns product registration, regulatory submissions, labeling compliance, and safety documentation management. Manages regulatory dossiers, SDS/MSDS sheets, ingredient declarations, country-specific registrations (FDA, EPA, EU), CPSC filings, IFRA compliance records, post-market surveillance, and CFR compliance. Ensures multi-jurisdictional regulatory adherence.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` (
    `regulatory_registration_id` BIGINT COMMENT 'Unique identifier for the product registration record. Primary key for the registration entity.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Financial posting of registration fees requires a GL account; finance uses GL accounts for all fee postings.',
    `jurisdiction_id` BIGINT COMMENT 'The jurisdiction id of the regulatory registration record',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing facility or establishment where the registered product is manufactured. Links to facility master data.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Registration approval requires a designated regulatory affairs employee; linking enables audit trail of responsible employee.',
    `sku_id` BIGINT COMMENT 'Reference to the product being registered with regulatory authorities. Links to the product master record.',
    `product_registration_id` BIGINT COMMENT 'References authoritative SSOT record in product.product_registration.',
    `active_ingredients` STRING COMMENT 'List of active ingredients or substances covered by this registration, using INCI (International Nomenclature of Cosmetic Ingredients) or CAS (Chemical Abstracts Service) numbers where applicable. Critical for EPA pesticide and antimicrobial registrations.',
    `annual_report_due_date` DATE COMMENT 'Date by which annual registration reports or updates must be submitted to the regulatory authority. Used for compliance tracking and reporting calendar management.',
    `application_date` DATE COMMENT 'The application date of the regulatory registration record',
    `approval_date` DATE COMMENT 'Date when the regulatory authority officially approved the registration application.',
    `cfr_citation` STRING COMMENT 'Specific CFR (Code of Federal Regulations) citation or section under which the product is registered (e.g., 21 CFR 314 for NDAs, 40 CFR 152 for pesticides). Applicable primarily to US registrations.',
    `regulatory_registration_code` STRING COMMENT 'The regulatory registration code of the regulatory registration record',
    `country_code` STRING COMMENT 'The country code of the regulatory registration record',
    `cpsc_tracking_label_required` BOOLEAN COMMENT 'Indicates whether CPSC tracking label requirements apply to this registered product. True if tracking labels are required, False otherwise. Applicable to childrens products and certain consumer goods.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this registration record was first created in the system. Audit trail field for data lineage and compliance.',
    `regulatory_registration_description` STRING COMMENT 'The regulatory registration description of the regulatory registration record',
    `effective_date` DATE COMMENT 'Date when the registration becomes legally effective and the product may be marketed or distributed under this registration.',
    `effective_from` DATE COMMENT 'The effective from of the regulatory registration record',
    `effective_until` DATE COMMENT 'The effective until of the regulatory registration record',
    `expiry_date` DATE COMMENT 'Date when the registration expires and is no longer valid unless renewed. Null for registrations with indefinite validity.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total fee amount paid or payable for this registration in the registration holders reporting currency. Includes initial registration fees and any applicable renewal fees.',
    `fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the registration fee amount (e.g., USD, EUR, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether the product and manufacturing facility meet Good Manufacturing Practice requirements as verified during registration. True if GMP-compliant, False otherwise.',
    `holder_address` STRING COMMENT 'Full business address of the registration holder as registered with the regulatory authority. Organizational contact data classified as confidential.',
    `holder_name` STRING COMMENT 'Legal name of the company or entity that holds the registration. This is the registrant of record with the regulatory authority.',
    `ifra_compliance_flag` BOOLEAN COMMENT 'Indicates whether the product formulation complies with IFRA standards for fragrance ingredients. True if IFRA-compliant, False otherwise. Relevant for cosmetic and personal care products.',
    `jurisdiction_country_code` STRING COMMENT 'Three-letter ISO country code representing the jurisdiction where the registration is valid (e.g., USA, DEU, GBR, CAN, BRA, JPN, AUS, CHN).. Valid values are `^[A-Z]{3}$`',
    `jurisdiction_region` STRING COMMENT 'Specific region, state, or province within the country where the registration applies (e.g., California, Ontario, Bavaria). Used for sub-national regulatory requirements.',
    `label_approval_number` STRING COMMENT 'Approval number for the product label as reviewed and accepted by the regulatory authority. Critical for EPA pesticide registrations where label claims are strictly regulated.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this registration record. Audit trail field for accountability and compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this registration record was last modified or updated. Audit trail field for change tracking and compliance.',
    `regulatory_registration_name` STRING COMMENT 'The regulatory registration name of the regulatory registration record',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to the registration. May include restrictions, special handling requirements, or regulatory caveats.',
    `post_market_surveillance_required` BOOLEAN COMMENT 'Indicates whether post-market surveillance or pharmacovigilance reporting is required for this registration. True if surveillance is required, False otherwise.',
    `product_classification` STRING COMMENT 'The product classification of the regulatory registration record',
    `product_scope` STRING COMMENT 'Description of the product scope covered by this registration, including specific formulations, SKUs (Stock Keeping Units), or product variants included under this registration.',
    `reach_registration_number` STRING COMMENT 'EU REACH registration number for chemical substances. Applicable for products containing substances subject to REACH regulation in the European Union.',
    `registering_authority` STRING COMMENT 'Name of the regulatory authority or governing body with which the product is registered (e.g., FDA, EPA, EU Commission, Health Canada, ANVISA). [ENUM-REF-CANDIDATE: FDA|EPA|CPSC|EU_REACH|Health_Canada|ANVISA|PMDA|TGA|SFDA|MHRA|BfR — promote to reference product]',
    `registration_category` STRING COMMENT 'Regulatory category or class of the registration as defined by the authority (e.g., OTC drug, prescription drug, general use pesticide, restricted use pesticide, cosmetic product, biocidal product).',
    `registration_number` STRING COMMENT 'Official registration number or identifier issued by the regulatory authority. This is the externally-known unique identifier for the registration (e.g., FDA registration number, EPA registration number, EU REACH registration number).',
    `registration_status` STRING COMMENT 'Current lifecycle status of the registration. Tracks the registration through submission, review, approval, active use, and potential suspension or expiration. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|active|suspended|expired|cancelled|rejected — 9 candidates stripped; promote to reference product]',
    `registration_type` STRING COMMENT 'Type of registration action being recorded. Indicates whether this is a new registration, renewal of existing registration, amendment to existing registration, cancellation, variation, or transfer to another entity.. Valid values are `new|renewal|amendment|cancellation|variation|transfer`',
    `regulatory_authority` STRING COMMENT 'The regulatory authority of the regulatory registration record',
    `regulatory_contact_email` STRING COMMENT 'Email address of the primary regulatory affairs contact person for this registration. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `regulatory_contact_name` STRING COMMENT 'Name of the primary regulatory affairs contact person responsible for this registration. Used for correspondence and regulatory inquiries.',
    `regulatory_contact_phone` STRING COMMENT 'Phone number of the primary regulatory affairs contact person for this registration. Organizational contact data classified as confidential.',
    `regulatory_registration_status` STRING COMMENT 'The regulatory registration status of the regulatory registration record',
    `renewal_date` DATE COMMENT 'The renewal date of the regulatory registration record',
    `renewal_due_date` DATE COMMENT 'Date by which the registration renewal application must be submitted to maintain continuous registration status. Used for proactive renewal management.',
    `sds_document_reference` STRING COMMENT 'Reference identifier or document number for the Safety Data Sheet (SDS) or Material Safety Data Sheet (MSDS) associated with this registered product. Links to safety documentation repository.',
    `source_system_code` STRING COMMENT 'The source system code of the regulatory registration record',
    `submission_date` DATE COMMENT 'Date when the registration application or dossier was submitted to the regulatory authority.',
    `submission_reference_number` STRING COMMENT 'Internal or external reference number for the regulatory submission dossier associated with this registration. Links to detailed submission documentation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the regulatory registration record',
    `use_classification` STRING COMMENT 'Classification of the intended use or application of the product as defined by the regulatory authority (e.g., cosmetic, drug, pesticide, antimicrobial, food contact substance, medical device). [ENUM-REF-CANDIDATE: cosmetic|drug|pesticide|antimicrobial|food_contact|medical_device|biocide|industrial_chemical — promote to reference product]',
    CONSTRAINT pk_regulatory_registration PRIMARY KEY(`regulatory_registration_id`)
) COMMENT 'Master record for product registrations with regulatory authorities across all jurisdictions. Tracks registration number, status, effective/expiry dates, registering authority, product scope, registration type (new, renewal, amendment, cancellation), active ingredients, use classification, submission reference, and renewal due date. Covers FDA, EPA (FIFRA pesticide/antimicrobial), CPSC, EU REACH, and country-specific registrations. SSOT for all regulatory registration identities regardless of authority or jurisdiction. [SSOT] Superseded by authoritative table product.product_registration for concept registration. SSOT: canonical table is product.product_registration. [SSOT for concept registration.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` (
    `submission_id` BIGINT COMMENT 'Unique identifier for the regulatory submission record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory submission review is performed by a specific employee; FK supports reviewer assignment tracking.',
    `dossier_id` BIGINT COMMENT 'The dossier id of the submission record',
    `jurisdiction_id` BIGINT COMMENT 'The jurisdiction id of the submission record',
    `previous_submission_id` BIGINT COMMENT 'Foreign key reference to the prior submission record that this submission amends, supersedes, or follows up on.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Regulatory submissions are initiated by a specific R&D project; tracking rd_project_id enables the Submission Tracking Report linking project milestones to submission status.',
    `regulatory_registration_id` BIGINT COMMENT 'Foreign key reference to the product registration record that this submission supports or updates.',
    `sku_id` BIGINT COMMENT 'Foreign key reference to the product or SKU (Stock Keeping Unit) that is the subject of this regulatory submission.',
    `acknowledgement_date` DATE COMMENT 'The acknowledgement date of the submission record',
    `actual_decision_date` DATE COMMENT 'Actual date on which the regulatory authority issued a final decision (approval, rejection, or other outcome) on the submission.',
    `authority_jurisdiction` STRING COMMENT 'Three-letter ISO country code representing the jurisdiction of the regulatory authority (e.g., USA, DEU, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `channel` STRING COMMENT 'Channel or method through which the submission was filed (electronic, paper, regulatory portal, EDI electronic data interchange).. Valid values are `electronic|paper|portal|edi`',
    `submission_code` STRING COMMENT 'The submission code of the submission record',
    `contact_person_email` STRING COMMENT 'Email address of the internal regulatory affairs contact person for correspondence related to this submission.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person_name` STRING COMMENT 'Name of the internal regulatory affairs contact person or responsible party for this submission.',
    `contact_person_phone` STRING COMMENT 'Phone number of the internal regulatory affairs contact person for inquiries related to this submission.',
    `corrective_action_description` STRING COMMENT 'Description of the corrective action required or implemented in response to the submission (e.g., voluntary recall, labeling update, product reformulation).',
    `corrective_action_required` BOOLEAN COMMENT 'Boolean flag indicating whether the regulatory authority has mandated corrective action (recall, labeling change, product modification) as a result of this submission.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was first created in the regulatory management system.',
    `decision_date` DATE COMMENT 'The decision date of the submission record',
    `decision_outcome` STRING COMMENT 'Final outcome or decision rendered by the regulatory authority (approved, approved with conditions, rejected, withdrawn, pending).. Valid values are `approved|approved_with_conditions|rejected|withdrawn|pending`',
    `submission_description` STRING COMMENT 'The submission description of the submission record',
    `effective_from` DATE COMMENT 'The effective from of the submission record',
    `effective_until` DATE COMMENT 'The effective until of the submission record',
    `fee_amount` DECIMAL(18,2) COMMENT 'Regulatory filing fee amount charged by the authority for processing the submission.',
    `fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the regulatory filing fee (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `fee_payment_status` STRING COMMENT 'Payment status of the regulatory filing fee (paid, pending, waived, refunded).. Valid values are `paid|pending|waived|refunded`',
    `hazard_description` STRING COMMENT 'Detailed description of the hazard, incident, or safety concern that prompted the submission (applicable for CPSC Section 15(b) reports, SaferProducts.gov filings, and post-market surveillance submissions).',
    `incident_date` DATE COMMENT 'Date on which the reported incident, adverse event, or safety issue occurred (applicable for safety-related submissions).',
    `language` STRING COMMENT 'Two-letter ISO 639-1 language code representing the primary language in which the submission was prepared and filed (e.g., en for English, de for German, fr for French).. Valid values are `^[a-z]{2}$`',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified the submission record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was last updated or modified.',
    `submission_name` STRING COMMENT 'The submission name of the submission record',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the submission, including internal observations, authority feedback, or follow-up actions required.',
    `population_at_risk` STRING COMMENT 'Estimated number of consumers or units in the market that may be affected by the reported hazard or safety issue (applicable for safety-related submissions).',
    `priority` STRING COMMENT 'Priority level assigned to the submission by the regulatory authority or internal regulatory affairs team (expedited, standard, routine).. Valid values are `expedited|standard|routine`',
    `regulatory_authority` STRING COMMENT 'Name of the governing body or regulatory authority to which the submission was filed (e.g., FDA, EPA, CPSC, European Chemicals Agency, Health Canada).',
    `severity_level` STRING COMMENT 'Assessed severity level of the hazard or incident reported in the submission (critical, high, medium, low).. Valid values are `critical|high|medium|low`',
    `source_system_code` STRING COMMENT 'The source system code of the submission record',
    `submission_date` DATE COMMENT 'Date the submission was officially filed with the regulatory authority.',
    `submission_number` STRING COMMENT 'Externally-known unique submission number or dossier reference assigned by the regulatory authority or internal tracking system (e.g., 510(k) number, PMA number, REACH registration number).',
    `submission_status` STRING COMMENT 'Current lifecycle status of the regulatory submission (draft, submitted, under review, additional information requested, approved, rejected, withdrawn). [ENUM-REF-CANDIDATE: draft|submitted|under_review|additional_info_requested|approved|rejected|withdrawn — 7 candidates stripped; promote to reference product]',
    `submission_type` STRING COMMENT 'Type of regulatory submission filed (510(k) premarket notification, PMA premarket approval, GRAS generally recognized as safe, TSCA toxic substances control act, cosmetic notification, CPSC Section 15(b) report, SaferProducts.gov incident report, REACH registration). [ENUM-REF-CANDIDATE: 510k|pma|gras|tsca|cosmetic_notification|cpsc_section_15b|saferproducts_gov|reach_registration — 8 candidates stripped; promote to reference product]',
    `supporting_document_count` STRING COMMENT 'Number of supporting documents, attachments, or exhibits included with the submission (e.g., safety data sheets, clinical studies, ingredient declarations).',
    `target_decision_date` DATE COMMENT 'Expected or target date by which the regulatory authority is anticipated to issue a decision on the submission.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the submission record',
    `version` STRING COMMENT 'Version number of the submission, incremented when amendments or resubmissions are filed.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created the submission record in the regulatory management system.',
    CONSTRAINT pk_submission PRIMARY KEY(`submission_id`)
) COMMENT 'Regulatory submission records filed with any governing body worldwide. Captures submission type (510k, PMA, GRAS, TSCA, cosmetic notification, CPSC Section 15(b) report, SaferProducts.gov, REACH registration), submission date, dossier reference, submission channel, assigned reviewer, status, target decision date, hazard/incident details (for safety filings), population at risk, and linked registration. SSOT for all regulatory filings regardless of authority. Sourced from Veeva Vault regulatory submissions module.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` (
    `dossier_id` BIGINT COMMENT 'Unique identifier for the regulatory dossier record. Primary key.',
    `jurisdiction_id` BIGINT COMMENT 'The jurisdiction id of the dossier record',
    `employee_id` BIGINT COMMENT 'The owner employee id of the dossier record',
    `primary_contact_employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Dossier primary contact is an employee responsible for dossier management; needed for responsibility reporting.',
    `product_lca_id` BIGINT COMMENT 'Foreign key linking to sustainability.product_lca. Business justification: Regulatory dossiers often require Life‑Cycle Assessment data; FK attaches the LCA record to the dossier.',
    `regulatory_registration_id` BIGINT COMMENT 'The regulatory registration id of the dossier record',
    `sku_id` BIGINT COMMENT 'Reference to the product for which this regulatory dossier was compiled. Links to the product master record.',
    `submission_id` BIGINT COMMENT 'Reference to the regulatory submission that this dossier supports. One dossier may support multiple submissions across jurisdictions.',
    `approval_date` DATE COMMENT 'Date when the dossier was formally approved by the regulatory affairs leadership or quality assurance team for submission or archival.',
    `approved_by` STRING COMMENT 'Name or identifier of the regulatory affairs manager or quality assurance officer who approved the dossier for submission.',
    `cfr_reference` STRING COMMENT 'Specific CFR title and part number(s) that govern the regulatory requirements addressed by this dossier, applicable for U.S. FDA and EPA submissions.',
    `dossier_code` STRING COMMENT 'The dossier code of the dossier record',
    `comments` STRING COMMENT 'Free-text field for additional notes, special instructions, or contextual information related to the dossier compilation, review, or submission.',
    `compilation_date` DATE COMMENT 'Date when the dossier compilation was completed and finalized for submission or review.',
    `completeness_percentage` DECIMAL(18,2) COMMENT 'Numeric representation of dossier completeness, calculated as the percentage of required sections and documents that have been compiled and approved.',
    `completeness_status` STRING COMMENT 'Assessment of whether all required documentation sections and supporting materials have been compiled and verified for regulatory submission readiness.. Valid values are `incomplete|substantially_complete|complete|verified`',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for the dossier content.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dossier record was first created in the regulatory data management system.',
    `dossier_description` STRING COMMENT 'The dossier description of the dossier record',
    `document_count` STRING COMMENT 'Total number of individual documents included in this regulatory dossier package.',
    `document_reference` STRING COMMENT 'The document reference of the dossier record',
    `dossier_number` STRING COMMENT 'Business identifier for the regulatory dossier, used for external reference and tracking across regulatory affairs teams and submissions.. Valid values are `^[A-Z0-9]{6,20}$`',
    `dossier_status` STRING COMMENT 'Current lifecycle status of the regulatory dossier indicating its stage in the compilation and submission process.. Valid values are `draft|in_compilation|under_review|complete|submitted|archived`',
    `dossier_type` STRING COMMENT 'Classification of the regulatory dossier format and submission standard. CTD (Common Technical Document), eCTD (Electronic Common Technical Document), IECIC (International Cooperation on Cosmetics Regulation), CPNP (Cosmetic Products Notification Portal), FDA 510K (Medical Device Premarket Notification), EPA FIFRA (Federal Insecticide Fungicide and Rodenticide Act).. Valid values are `CTD|eCTD|IECIC|CPNP|FDA_510K|EPA_FIFRA`',
    `effective_date` DATE COMMENT 'Date from which the dossier becomes the active regulatory documentation package for the associated product or submission.',
    `effective_from` DATE COMMENT 'The effective from of the dossier record',
    `effective_until` DATE COMMENT 'The effective until of the dossier record',
    `expiration_date` DATE COMMENT 'Date when the dossier is no longer valid or requires renewal, typically driven by regulatory authority requirements or internal policy.',
    `format_standard` STRING COMMENT 'The format standard of the dossier record',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicator of whether the dossier includes documentation demonstrating compliance with Good Manufacturing Practice standards as required by regulatory authorities.',
    `ifra_compliance_flag` BOOLEAN COMMENT 'Indicator of whether the dossier includes documentation demonstrating compliance with IFRA standards for fragrance ingredients.',
    `ingredient_declaration_included` BOOLEAN COMMENT 'Indicator of whether a complete ingredient declaration (INCI list or equivalent) is included in the dossier.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (with optional ISO 3166-1 country code) indicating the primary language in which the dossier documentation is compiled.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update or modification to the dossier record, supporting audit trail and version control.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review or audit of the dossier content for accuracy, completeness, and regulatory compliance.',
    `dossier_name` STRING COMMENT 'The dossier name of the dossier record',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or update of the dossier, ensuring ongoing compliance with evolving regulatory requirements.',
    `notes` STRING COMMENT 'The notes of the dossier record',
    `owning_team` STRING COMMENT 'Name or identifier of the regulatory affairs team responsible for compiling, maintaining, and submitting this dossier.',
    `post_market_surveillance_included` BOOLEAN COMMENT 'Indicator of whether post-market surveillance data, adverse event reports, or vigilance documentation is included in the dossier.',
    `reach_registration_number` STRING COMMENT 'REACH registration number for chemical substances included in the dossier, required for EU market compliance.. Valid values are `^[0-9]{2}-[0-9]{10}-[0-9]{2}-[0-9]{4}$`',
    `regulatory_authority` STRING COMMENT 'Primary regulatory body or agency for which this dossier is intended. FDA (U.S. Food and Drug Administration), EPA (Environmental Protection Agency), CPSC (Consumer Product Safety Commission), EMA (European Medicines Agency), MHRA (Medicines and Healthcare products Regulatory Agency), ANVISA (Brazilian Health Regulatory Agency), PMDA (Pharmaceuticals and Medical Devices Agency Japan). [ENUM-REF-CANDIDATE: FDA|EPA|CPSC|EMA|MHRA|ANVISA|PMDA — 7 candidates stripped; promote to reference product]',
    `regulatory_category` STRING COMMENT 'Broad regulatory classification of the dossier content, such as cosmetics, personal care, household products, food contact materials, or pesticides, aligning with applicable regulatory frameworks. [ENUM-REF-CANDIDATE: cosmetics|personal_care|household_cleaning|food_contact|pesticides|biocides|medical_devices — promote to reference product]',
    `safety_assessment_included` BOOLEAN COMMENT 'Indicator of whether a formal safety assessment report is included in the dossier, as required for cosmetic and personal care product registrations.',
    `sds_included` BOOLEAN COMMENT 'Indicator of whether Safety Data Sheets (SDS) or Material Safety Data Sheets (MSDS) are included in the dossier for hazardous substances or mixtures.',
    `source_system_code` STRING COMMENT 'The source system code of the dossier record',
    `submission_date` DATE COMMENT 'The submission date of the dossier record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the dossier record',
    `vault_folder_path` STRING COMMENT 'Hierarchical folder path within Veeva Vault where the dossier documents are stored, enabling navigation and retrieval.',
    `vault_reference_code` STRING COMMENT 'External reference identifier linking this dossier record to the corresponding document repository location in Veeva Vault for full document access and version control.. Valid values are `^VV[A-Z0-9]{10,30}$`',
    `version_number` STRING COMMENT 'Version identifier for the dossier, tracking revisions and updates to the compiled documentation package.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$`',
    CONSTRAINT pk_dossier PRIMARY KEY(`dossier_id`)
) COMMENT 'Regulatory dossier master record representing the compiled technical and scientific documentation package supporting a product registration or submission. Tracks dossier type (CTD, eCTD, IECIC, CPNP), version, compilation date, owning regulatory affairs team, completeness status, linked submission, and document repository reference in Veeva Vault. One dossier may support multiple submissions across jurisdictions.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` (
    `sds_id` BIGINT COMMENT 'Unique identifier for the Safety Data Sheet record. Primary key.',
    `employee_id` BIGINT COMMENT 'The author employee id of the sds record',
    `jurisdiction_id` BIGINT COMMENT 'The jurisdiction id of the sds record',
    `sku_id` BIGINT COMMENT 'Reference to the raw material, finished good, or intermediate product that this SDS describes.',
    `accidental_release_measures` STRING COMMENT 'Personal precautions, protective equipment, emergency procedures, and methods for containment and cleanup of spills or releases.',
    `appearance` STRING COMMENT 'Visual description of the substance including color and form.',
    `authoring_chemist` STRING COMMENT 'Name of the qualified chemist or toxicologist who authored or reviewed this SDS for technical accuracy.',
    `autoignition_temperature` STRING COMMENT 'Temperature at which the substance will spontaneously ignite without an external ignition source.',
    `cas_number` STRING COMMENT 'CAS Registry Number uniquely identifying the chemical substance or mixture, if applicable.',
    `sds_code` STRING COMMENT 'The sds code of the sds record',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the jurisdiction for which this SDS is prepared (e.g., USA, GBR, DEU).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SDS record was first created in the system.',
    `sds_description` STRING COMMENT 'The sds description of the sds record',
    `disposal_considerations` STRING COMMENT 'Guidance on proper disposal methods, waste treatment, and applicable regulations for the substance and contaminated packaging.',
    `document_reference` STRING COMMENT 'The document reference of the sds record',
    `document_type` STRING COMMENT 'Classification of the safety document type: SDS (Safety Data Sheet per GHS), MSDS (Material Safety Data Sheet legacy format), or Extended SDS (with additional exposure scenarios).. Valid values are `sds|msds|extended_sds`',
    `document_url` STRING COMMENT 'Uniform Resource Locator (URL) or file path to the published SDS document in the document management system.',
    `ecological_information` STRING COMMENT 'Environmental impact data including aquatic toxicity, persistence and degradability, bioaccumulative potential, and mobility in soil.',
    `effective_date` DATE COMMENT 'Date from which this SDS version becomes the official document for regulatory and operational use.',
    `effective_from` DATE COMMENT 'The effective from of the sds record',
    `effective_until` DATE COMMENT 'The effective until of the sds record',
    `emergency_phone_number` STRING COMMENT '24-hour emergency contact telephone number for chemical emergency response (e.g., CHEMTREC, poison control).',
    `expiration_date` DATE COMMENT 'Date when this SDS version is superseded or no longer valid, requiring update or renewal.',
    `exposure_limits` STRING COMMENT 'Occupational exposure limits (OELs), permissible exposure limits (PELs), threshold limit values (TLVs), and biological exposure indices.',
    `firefighting_measures` STRING COMMENT 'Suitable extinguishing media, unsuitable extinguishing media, and special hazards arising from the substance or mixture during fire.',
    `first_aid_measures` STRING COMMENT 'Detailed first aid instructions for different exposure routes (inhalation, skin contact, eye contact, ingestion) as required by GHS Section 4.',
    `flash_point` STRING COMMENT 'Lowest temperature at which vapors of the substance will ignite when given an ignition source, typically in degrees Celsius.',
    `ghs_classification` STRING COMMENT 'GHS hazard classification codes assigned to this substance or mixture (e.g., Flam. Liq. 2, Acute Tox. 3, Skin Corr. 1B).',
    `handling_precautions` STRING COMMENT 'Safe handling practices and precautions for use to prevent exposure and ensure worker safety.',
    `hazard_statements` STRING COMMENT 'Standardized GHS hazard statements (H-codes) describing the nature and degree of hazards (e.g., H225: Highly flammable liquid and vapor).',
    `hazardous_decomposition_products` STRING COMMENT 'Hazardous substances that may be formed under fire conditions or other decomposition scenarios.',
    `incompatible_materials` STRING COMMENT 'Materials or substances that should not be stored or used with this product due to potential hazardous reactions.',
    `is_hazardous` BOOLEAN COMMENT 'The is hazardous of the sds record',
    `issue_date` DATE COMMENT 'Date when this SDS was originally issued or first published.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language in which this SDS is written (e.g., EN for English, ES for Spanish).',
    `manufacturer_address` STRING COMMENT 'Complete physical address of the manufacturer or supplier for regulatory contact purposes.',
    `manufacturer_name` STRING COMMENT 'Legal name of the company that manufactures or supplies the product covered by this SDS.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SDS record was last modified or updated in the system.',
    `sds_name` STRING COMMENT 'The sds name of the sds record',
    `notes` STRING COMMENT 'The notes of the sds record',
    `odor` STRING COMMENT 'Characteristic odor of the substance or mixture, if detectable.',
    `packing_group` STRING COMMENT 'UN packing group indicating degree of danger for transport: I (high danger), II (medium danger), III (low danger).. Valid values are `I|II|III`',
    `personal_protective_equipment` STRING COMMENT 'Required personal protective equipment for safe handling: respiratory protection, hand protection, eye protection, skin protection.',
    `ph_value` DECIMAL(18,2) COMMENT 'pH measurement of the substance or mixture, indicating acidity or alkalinity.',
    `physical_state` STRING COMMENT 'Physical form of the substance or mixture at ambient conditions.. Valid values are `solid|liquid|gas|aerosol|paste|gel`',
    `pictograms` STRING COMMENT 'List of GHS pictogram codes required on the label (e.g., GHS02 Flame, GHS07 Exclamation Mark, GHS08 Health Hazard).',
    `precautionary_statements` STRING COMMENT 'Standardized GHS precautionary statements (P-codes) describing recommended measures to minimize or prevent adverse effects (e.g., P210: Keep away from heat/sparks/open flames).',
    `product_code` STRING COMMENT 'Internal product code or SKU (Stock Keeping Unit) for the material covered by this SDS.',
    `product_name` STRING COMMENT 'The commercial or chemical name of the product or substance covered by this SDS.',
    `proper_shipping_name` STRING COMMENT 'Official shipping name for transport documentation as specified by UN/DOT regulations.',
    `regulatory_format` STRING COMMENT 'The regulatory format of the sds record',
    `regulatory_information` STRING COMMENT 'Applicable regulatory requirements including TSCA status, REACH registration, California Prop 65, SARA Title III, and other jurisdiction-specific regulations.',
    `revision_date` DATE COMMENT 'Date when this version of the SDS was last revised or updated.',
    `sds_number` STRING COMMENT 'The externally-known unique document number assigned to this SDS, used for regulatory submissions and cross-referencing.',
    `sds_status` STRING COMMENT 'Current lifecycle status of the SDS document within the regulatory document management system.. Valid values are `draft|under_review|approved|active|superseded|archived`',
    `signal_word` STRING COMMENT 'GHS signal word indicating the severity level of the hazard: Danger (more severe) or Warning (less severe).. Valid values are `danger|warning|none`',
    `source_system_code` STRING COMMENT 'The source system code of the sds record',
    `stability` STRING COMMENT 'Chemical stability information and conditions to avoid that may cause instability or hazardous reactions.',
    `storage_conditions` STRING COMMENT 'Conditions for safe storage including temperature, humidity, ventilation requirements, and incompatible materials.',
    `toxicological_information` STRING COMMENT 'Comprehensive toxicology data including acute toxicity, skin corrosion/irritation, eye damage/irritation, sensitization, mutagenicity, carcinogenicity, reproductive toxicity, and target organ effects.',
    `transport_hazard_class` STRING COMMENT 'UN/DOT hazard class for transportation (e.g., Class 3 Flammable Liquids, Class 8 Corrosives).',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials transport classification.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the sds record',
    `version_number` STRING COMMENT 'Version identifier for this SDS revision, tracking document evolution over time.',
    CONSTRAINT pk_sds PRIMARY KEY(`sds_id`)
) COMMENT 'Safety Data Sheet (SDS/MSDS) master records for raw materials, finished goods, and intermediates as required by OSHA HazCom, EU CLP, and GHS standards. Captures SDS version, revision date, GHS hazard classifications, signal word, precautionary statements, first aid measures, handling/storage requirements, disposal guidance, transport classification (UN number, packing group), and authoring chemist. Managed in Veeva Vault.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` (
    `ingredient_list_id` BIGINT COMMENT 'Primary key for ingredient_list',
    `jurisdiction_id` BIGINT COMMENT 'The jurisdiction id of the ingredient list record',
    `product_formulation_id` BIGINT COMMENT 'Reference to the formulation record that defines the recipe and composition for this product. Links to formulation master data.',
    `regulatory_registration_id` BIGINT COMMENT 'The regulatory registration id of the ingredient list record',
    `sku_id` BIGINT COMMENT 'Reference to the finished product SKU (Stock Keeping Unit) for which this ingredient declaration applies. Links to product master data.',
    `allergen_declaration` STRING COMMENT 'The allergen declaration of the ingredient list record',
    `allergen_flag` BOOLEAN COMMENT 'Indicates whether this ingredient is a known allergen requiring special labeling or disclosure per regulatory requirements (e.g., EU Cosmetics Regulation Annex III).',
    `allergen_type` STRING COMMENT 'Classification of the allergen type if allergen_flag is true. Used for consumer safety labeling and regulatory compliance.. Valid values are `fragrance_allergen|preservative_allergen|colorant_allergen|botanical_allergen|protein_allergen|other`',
    `approval_status` STRING COMMENT 'The approval status of the ingredient list record',
    `approved_by` STRING COMMENT 'Name or identifier of the regulatory affairs professional who approved this ingredient declaration for use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this ingredient declaration was approved by regulatory affairs.',
    `cas_number` STRING COMMENT 'Unique CAS (Chemical Abstracts Service) registry number identifying the chemical substance. Used for regulatory submissions and safety documentation.. Valid values are `^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$`',
    `ingredient_list_code` STRING COMMENT 'The ingredient list code of the ingredient list record',
    `common_name` STRING COMMENT 'Common or trade name of the ingredient used for internal reference and non-regulated communications.',
    `concentration_max_percent` DECIMAL(18,2) COMMENT 'Maximum concentration of the ingredient in the finished product, expressed as a percentage by weight. Used for regulatory submissions and formulation specifications.',
    `concentration_min_percent` DECIMAL(18,2) COMMENT 'Minimum concentration of the ingredient in the finished product, expressed as a percentage by weight. Used for regulatory submissions and formulation specifications.',
    `concentration_typical_percent` DECIMAL(18,2) COMMENT 'Typical or target concentration of the ingredient in the finished product, expressed as a percentage by weight. Used for quality control and manufacturing guidance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ingredient declaration record was first created in the data platform.',
    `declaration_name_override` STRING COMMENT 'Alternative name to be used on the product label if different from INCI name, as permitted by jurisdiction-specific regulations (e.g., trade name, common name).',
    `declaration_required_flag` BOOLEAN COMMENT 'Indicates whether this ingredient must be declared on the product label per regulatory requirements. Some processing aids or trace contaminants may be exempt.',
    `declaration_status` STRING COMMENT 'Current lifecycle status of the ingredient declaration record in the regulatory documentation workflow.. Valid values are `draft|pending_review|approved|active|superseded|retired`',
    `ingredient_list_description` STRING COMMENT 'The ingredient list description of the ingredient list record',
    `effective_date` DATE COMMENT 'Date from which this ingredient declaration becomes effective for regulatory compliance and labeling purposes.',
    `effective_from` DATE COMMENT 'The effective from of the ingredient list record',
    `effective_until` DATE COMMENT 'The effective until of the ingredient list record',
    `einecs_number` STRING COMMENT 'EINECS (European Inventory of Existing Commercial Chemical Substances) number for substances marketed in the EU before September 1981. Required for EU REACH compliance.. Valid values are `^[0-9]{3}-[0-9]{3}-[0-9]$`',
    `expiration_date` DATE COMMENT 'Date after which this ingredient declaration is no longer valid, typically due to formulation changes or regulatory updates. Null indicates no expiration.',
    `fda_status` STRING COMMENT 'FDA (Food and Drug Administration) regulatory status of the ingredient for use in consumer goods (e.g., GRAS - Generally Recognized As Safe, approved food additive, approved color additive).. Valid values are `gras|food_additive|color_additive|otc_monograph|new_dietary_ingredient|not_approved`',
    `ifra_amendment_number` STRING COMMENT 'IFRA (International Fragrance Association) amendment number that governs the use restrictions for this ingredient if IFRA restricted.',
    `ifra_restricted_flag` BOOLEAN COMMENT 'Indicates whether this ingredient is subject to IFRA (International Fragrance Association) restrictions or standards for use in fragrance compounds.',
    `inci_declaration` STRING COMMENT 'The inci declaration of the ingredient list record',
    `inci_name` STRING COMMENT 'Standardized INCI (International Nomenclature of Cosmetic Ingredients) name for the ingredient as required for cosmetic product labeling. Mandatory for cosmetics and personal care products.',
    `ingredient_function` STRING COMMENT 'Primary functional role of the ingredient in the formulation (e.g., preservative, surfactant, fragrance, colorant, active ingredient). Used for regulatory classification and formulation analysis. [ENUM-REF-CANDIDATE: preservative|surfactant|emollient|humectant|emulsifier|thickener|fragrance|colorant|active_ingredient|solvent|ph_adjuster|antioxidant|chelating_agent|opacifier|film_former — 15 candidates stripped; promote to reference product]',
    `ingredient_list_status` STRING COMMENT 'The ingredient list status of the ingredient list record',
    `ingredient_order` STRING COMMENT 'The ingredient order of the ingredient list record',
    `ingredient_order_text` STRING COMMENT 'The ingredient order text of the ingredient list record',
    `ingredient_sequence` STRING COMMENT 'Order in which this ingredient appears on the product label declaration. Typically sorted by descending concentration per regulatory requirements (FDA 21 CFR, EU Cosmetics Regulation).',
    `language_code` STRING COMMENT 'The language code of the ingredient list record',
    `list_type` STRING COMMENT 'The list type of the ingredient list record',
    `market_country_code` STRING COMMENT 'The market country code of the ingredient list record',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ingredient declaration record was last modified in the data platform.',
    `ingredient_list_name` STRING COMMENT 'The ingredient list name of the ingredient list record',
    `nanomaterial_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is in nanomaterial form, requiring special labeling per EU Cosmetics Regulation (nano) designation.',
    `natural_origin_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is derived from natural sources (plant, mineral, animal) as opposed to synthetic or petrochemical sources. Used for natural product claims and marketing.',
    `notes` STRING COMMENT 'The notes of the ingredient list record',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is certified organic by a recognized certification body (e.g., USDA Organic, COSMOS, ECOCERT). Used for organic product claims.',
    `palm_oil_derivative_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is derived from palm oil. Used for sustainable sourcing tracking and RSPO (Roundtable on Sustainable Palm Oil) compliance.',
    `reach_registration_number` STRING COMMENT 'REACH (Registration Evaluation Authorization and Restriction of Chemicals) registration number for substances manufactured or imported in the EU in quantities of 1 tonne or more per year.',
    `restricted_substance_flag` BOOLEAN COMMENT 'Indicates whether this ingredient is subject to regulatory restrictions, concentration limits, or prohibited use conditions in certain jurisdictions.',
    `restriction_jurisdiction` STRING COMMENT 'Comma-separated list of jurisdictions or regulatory bodies where restrictions apply (e.g., EU, USA, CAN, JPN). Used for multi-jurisdictional compliance management.',
    `restriction_type` STRING COMMENT 'Type of regulatory restriction applied to this ingredient if restricted_substance_flag is true. Defines the nature of the regulatory control.. Valid values are `prohibited|concentration_limited|use_restricted|authorization_required|sunset_substance`',
    `rspo_certified_flag` BOOLEAN COMMENT 'Indicates whether palm-derived ingredients are RSPO (Roundtable on Sustainable Palm Oil) certified for sustainable sourcing.',
    `sds_reference_number` STRING COMMENT 'Reference number linking this ingredient to its Safety Data Sheet (SDS) or Material Safety Data Sheet (MSDS) document for hazard communication and workplace safety.',
    `source_record_reference` STRING COMMENT 'Unique identifier of this record in the source system, used for data lineage and reconciliation.',
    `source_system_code` STRING COMMENT 'The source system code of the ingredient list record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the ingredient list record',
    `vegan_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is free from animal-derived substances and suitable for vegan product claims.',
    `version_number` STRING COMMENT 'The version number of the ingredient list record',
    CONSTRAINT pk_ingredient_list PRIMARY KEY(`ingredient_list_id`)
) COMMENT 'Ingredient declaration records capturing the full ingredient list for a finished product SKU as required for labeling compliance. Tracks INCI names, CAS numbers, concentration ranges, function (preservative, surfactant, fragrance, colorant), declaration order, jurisdiction-specific requirements (FDA 21 CFR, EU Cosmetics Regulation, REACH), allergen flags, and restricted substance flags. Links to product master and formulation records.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` (
    `label_version_id` BIGINT COMMENT 'Unique identifier for the label version record. Primary key.',
    `jurisdiction_id` BIGINT COMMENT 'The jurisdiction id of the label version record',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Label approvals are signed off by a regulatory employee; FK records who approved each label version.',
    `label_approved_by_employee_id` BIGINT COMMENT 'The label approved by employee id of the label version record',
    `previous_version_label_version_id` BIGINT COMMENT 'Reference to the immediately preceding label version that this version supersedes, enabling version lineage tracking.',
    `regulatory_registration_id` BIGINT COMMENT 'The regulatory registration id of the label version record',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU this label version applies to.',
    `allergen_declarations` STRING COMMENT 'Allergen declarations required on the label (e.g., Contains: milk, soy, tree nuts). Applicable for food and cosmetic products.',
    `approval_date` DATE COMMENT 'Date when the label version received regulatory approval from the governing authority.',
    `approval_expiry_date` DATE COMMENT 'Date when the regulatory approval expires and the label version can no longer be used, if applicable.',
    `approval_reference_number` STRING COMMENT 'Official reference or registration number assigned by the regulatory authority for this label approval.',
    `approval_status` STRING COMMENT 'The approval status of the label version record',
    `approving_authority` STRING COMMENT 'Name of the regulatory body or authority that approved this label version (e.g., FDA, EPA, EU Commission, Health Canada).',
    `artwork_checksum` STRING COMMENT 'SHA-256 checksum hash of the artwork file to ensure file integrity and detect unauthorized modifications.. Valid values are `^[a-fA-F0-9]{64}$`',
    `artwork_file_name` STRING COMMENT 'File name of the approved label artwork file (e.g., PDF, AI, or other format) stored in the document management system.',
    `artwork_reference` STRING COMMENT 'The artwork reference of the label version record',
    `barcode_type` STRING COMMENT 'Type of barcode symbology printed on the label (e.g., UPC, EAN-13, GTIN-14, QR Code, DataMatrix).. Valid values are `UPC|EAN|GTIN|QR|DataMatrix|Code128`',
    `barcode_value` DECIMAL(18,2) COMMENT 'The encoded value of the barcode printed on this label version (e.g., UPC number, GTIN, serialized data).',
    `brand_name` STRING COMMENT 'Brand name displayed on the label.',
    `certification_marks` STRING COMMENT 'Third-party certification marks and compliance logos displayed on the label (e.g., USDA Organic, Leaping Bunny, Non-GMO Project, Kosher, Halal).',
    `change_reason` STRING COMMENT 'Business reason for creating this new label version (e.g., Regulatory requirement change, Ingredient reformulation, Packaging redesign, Correction of error).',
    `label_version_code` STRING COMMENT 'The label version code of the label version record',
    `contact_information` STRING COMMENT 'Consumer contact information displayed on the label (phone number, website, email) for inquiries and customer service.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the product was manufactured or produced, as declared on the label.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this label version record was first created in the system.',
    `label_version_description` STRING COMMENT 'The label version description of the label version record',
    `distributor_name` STRING COMMENT 'Name of the distributor or importer as declared on the label, if different from manufacturer.',
    `effective_date` DATE COMMENT 'The effective date of the label version record',
    `effective_end_date` DATE COMMENT 'Date when this label version is no longer valid for new production. Nullable for currently active versions.',
    `effective_from` DATE COMMENT 'The effective from of the label version record',
    `effective_start_date` DATE COMMENT 'Date from which this label version becomes effective and can be used in production and distribution.',
    `effective_until` DATE COMMENT 'The effective until of the label version record',
    `expiry_date` DATE COMMENT 'The expiry date of the label version record',
    `expiry_date_format` STRING COMMENT 'Format specification for how the expiry or best-before date will be printed on the label (e.g., MM/YYYY, DD-MMM-YYYY, EXP: YYYY-MM-DD).',
    `ingredient_list` STRING COMMENT 'Full ingredient list as declared on the label in descending order of predominance, following regulatory naming conventions (INCI for cosmetics, common names for food).',
    `is_current_version` BOOLEAN COMMENT 'Boolean flag indicating whether this is the currently active label version for the SKU in the specified market. True if current, False if historical.',
    `label_claims` STRING COMMENT 'Marketing claims and statements appearing on the label (e.g., organic, hypoallergenic, dermatologist tested, cruelty-free). Pipe-separated list if multiple.',
    `label_status` STRING COMMENT 'The label status of the label version record',
    `label_type` STRING COMMENT 'Classification of the label type: primary (consumer-facing package), secondary (outer carton), shipper (distribution box), pallet (logistics unit), promotional (limited edition), or sample (trial size).. Valid values are `primary|secondary|shipper|pallet|promotional|sample`',
    `label_version_status` STRING COMMENT 'The label version status of the label version record',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code, optionally with ISO 3166-1 country code (e.g., en, en-US, fr-CA) indicating the label language.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified this label version record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this label version record was last modified.',
    `lot_code_format` STRING COMMENT 'Format specification for the lot or batch code that will be printed on labels during production (e.g., YYMMDD-LLLL where LLLL is line code).',
    `manufacturer_address` STRING COMMENT 'Full address of the manufacturer as declared on the label for regulatory compliance and consumer contact.',
    `manufacturer_name` STRING COMMENT 'Name of the manufacturer as declared on the label for regulatory compliance.',
    `market_country_code` STRING COMMENT 'Three-letter ISO country code identifying the market jurisdiction for this label version (e.g., USA, DEU, JPN).. Valid values are `^[A-Z]{3}$`',
    `label_version_name` STRING COMMENT 'The label version name of the label version record',
    `net_content_declaration` STRING COMMENT 'Full net content declaration statement as it appears on the label, including quantity and unit (e.g., 500 ml, 16 fl oz (473 ml)).',
    `net_content_quantity` DECIMAL(18,2) COMMENT 'Numeric value of the net content quantity declared on the label.',
    `net_content_unit` STRING COMMENT 'Unit of measure for the net content quantity (e.g., ml, g, oz, fl_oz, count). [ENUM-REF-CANDIDATE: ml|l|g|kg|oz|lb|fl_oz|gal|count|each — 10 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'The notes of the label version record',
    `product_name_on_label` STRING COMMENT 'The exact product name as it appears on the label artwork, which may differ from internal product names due to marketing or regulatory requirements.',
    `recycling_symbols` STRING COMMENT 'Recycling symbols and sustainability marks displayed on the label (e.g., Recyclable, FSC Certified, Green Dot, resin identification codes).',
    `regulatory_approval_status` STRING COMMENT 'Current regulatory approval status of the label version in the target market jurisdiction. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|withdrawn|expired — 7 candidates stripped; promote to reference product]',
    `regulatory_framework` STRING COMMENT 'The regulatory framework of the label version record',
    `source_system_code` STRING COMMENT 'The source system code of the label version record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the label version record',
    `veeva_vault_document_code` STRING COMMENT 'Reference identifier to the label artwork document stored in Veeva Vault regulatory document management system.',
    `version_label` STRING COMMENT 'The version label of the label version record',
    `version_number` STRING COMMENT 'Semantic version number of the label artwork (e.g., 1.0, 2.1, 3.0.1). Follows semantic versioning convention.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `warning_statements` STRING COMMENT 'Mandatory warning and precautionary statements required by regulatory authorities (e.g., Keep out of reach of children, For external use only).',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this label version record.',
    CONSTRAINT pk_label_version PRIMARY KEY(`label_version_id`)
) COMMENT 'Product label version master tracking all approved and historical label artwork versions for each SKU across markets. Captures label version number, market/country, language, label type (primary, secondary, shipper), regulatory approval status, approval date, approving authority, label claims, warning statements, net content declaration, country-of-origin, and Veeva Vault document reference. Supports multi-jurisdictional labeling compliance.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` (
    `compliance_obligation_id` BIGINT COMMENT 'Unique identifier for the compliance obligation record. Primary key.',
    `employee_id` BIGINT COMMENT 'The compliance responsible employee id of the compliance obligation record',
    `compliance_responsible_owner_employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each compliance obligation is owned by a specific employee; linking enables ownership tracking and audit.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Compliance budgeting assigns each obligation to a cost center for internal charge‑back and reporting.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Compliance obligations are defined per regulatory jurisdiction; linking provides a normalized reference and removes duplicated jurisdiction fields.',
    `advance_notice_period_days` STRING COMMENT 'The number of days in advance that the business must be notified or begin preparation to meet this compliance obligation.',
    `applicable_product_category` STRING COMMENT 'The product category or categories to which this compliance obligation applies (e.g., cosmetics, household cleaners, personal care, food contact materials).',
    `compliance_obligation_code` STRING COMMENT 'The compliance obligation code of the compliance obligation record',
    `compliance_deadline` DATE COMMENT 'The date by which the compliance obligation must be fulfilled to avoid regulatory penalties or non-compliance.',
    `compliance_notes` STRING COMMENT 'Free-text field for additional notes, comments, or context regarding this compliance obligation, including special instructions, historical context, or exceptions.',
    `compliance_obligation_status` STRING COMMENT 'The compliance obligation status of the compliance obligation record',
    `compliance_status` STRING COMMENT 'Current status of compliance with this obligation.. Valid values are `compliant|pending|overdue|not_applicable|in_progress|expired`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this compliance obligation record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the estimated compliance cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `compliance_obligation_description` STRING COMMENT 'The compliance obligation description of the compliance obligation record',
    `due_date` DATE COMMENT 'The due date of the compliance obligation record',
    `effective_date` DATE COMMENT 'The date when this compliance obligation becomes effective and enforceable.',
    `effective_from` DATE COMMENT 'The effective from of the compliance obligation record',
    `effective_until` DATE COMMENT 'The effective until of the compliance obligation record',
    `estimated_compliance_cost` DECIMAL(18,2) COMMENT 'The estimated financial cost to fulfill this compliance obligation, including registration fees, testing costs, documentation, and labor.',
    `expiration_date` DATE COMMENT 'The date when this compliance obligation expires or is no longer applicable, if applicable.',
    `frequency` STRING COMMENT 'The frequency of the compliance obligation record',
    `governing_body` STRING COMMENT 'The regulatory authority or governing body that enforces this obligation (e.g., FDA, EPA, CPSC, EU Commission).',
    `governing_regulation` STRING COMMENT 'The specific regulation, directive, or legal framework that mandates this obligation (e.g., CFR 21 Part 701, EU Directive 2009/48/EC, REACH Article 33).',
    `is_active` BOOLEAN COMMENT 'Indicates whether this compliance obligation is currently active and applicable to the business.',
    `last_compliance_verification_date` DATE COMMENT 'The date when compliance with this obligation was last verified or audited.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this compliance obligation record was last updated or modified.',
    `compliance_obligation_name` STRING COMMENT 'The compliance obligation name of the compliance obligation record',
    `next_audit_date` DATE COMMENT 'The scheduled date for the next internal or external audit of compliance with this obligation.',
    `next_renewal_date` DATE COMMENT 'The date when the next renewal or re-certification of this obligation is due.',
    `notes` STRING COMMENT 'The notes of the compliance obligation record',
    `notification_sent_date` DATE COMMENT 'The date when the compliance deadline notification was sent to the responsible owner.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether advance notification has been sent to the responsible owner regarding the upcoming compliance deadline.',
    `obligation_code` STRING COMMENT 'Business identifier code for the compliance obligation, used for external reference and reporting.. Valid values are `^[A-Z0-9]{6,20}$`',
    `obligation_name` STRING COMMENT 'Full descriptive name of the compliance obligation.',
    `obligation_reference` STRING COMMENT 'The obligation reference of the compliance obligation record',
    `obligation_status` STRING COMMENT 'The obligation status of the compliance obligation record',
    `obligation_type` STRING COMMENT 'Classification of the compliance obligation by regulatory action required.. Valid values are `registration|labeling|reporting|testing|notification|renewal`',
    `penalty_description` STRING COMMENT 'The penalty description of the compliance obligation record',
    `penalty_for_non_compliance` STRING COMMENT 'Description of the penalties, fines, or consequences for failing to meet this compliance obligation (e.g., product recall, market withdrawal, monetary fines, legal action).',
    `priority` STRING COMMENT 'The business priority assigned to fulfilling this compliance obligation, used for resource allocation and scheduling.. Valid values are `urgent|high|medium|low`',
    `regulation_name` STRING COMMENT 'The regulation name of the compliance obligation record',
    `regulatory_framework` STRING COMMENT 'The regulatory framework of the compliance obligation record',
    `renewal_frequency` STRING COMMENT 'The frequency at which this compliance obligation must be renewed or re-certified.. Valid values are `annual|biennial|triennial|quinquennial|one_time|as_needed`',
    `required_documentation` STRING COMMENT 'List or description of the documentation required to fulfill this compliance obligation (e.g., Safety Data Sheet (SDS), ingredient declaration, test reports, certificates of analysis).',
    `responsible_department` STRING COMMENT 'The department or business unit responsible for managing this compliance obligation (e.g., Regulatory Affairs, Quality Assurance, Legal).',
    `risk_level` STRING COMMENT 'The assessed risk level associated with non-compliance with this obligation, based on potential business impact, regulatory scrutiny, and penalty severity.. Valid values are `critical|high|medium|low`',
    `source_system_code` STRING COMMENT 'The unique identifier for this compliance obligation in the source system of record.',
    `submission_method` STRING COMMENT 'The method by which compliance documentation or filings must be submitted to the governing body.. Valid values are `electronic|paper|portal|email|in_person`',
    `submission_portal_url` STRING COMMENT 'The web address of the electronic portal or system where compliance submissions must be filed, if applicable.',
    `testing_requirement` STRING COMMENT 'Description of any laboratory testing or analytical work required to demonstrate compliance (e.g., stability testing, microbial testing, heavy metals analysis, allergen testing).',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the compliance obligation record',
    CONSTRAINT pk_compliance_obligation PRIMARY KEY(`compliance_obligation_id`)
) COMMENT 'Master record of regulatory compliance obligations applicable to the business by jurisdiction, product category, and governing body. Tracks obligation type (registration, labeling, reporting, testing, notification, renewal), governing regulation (CFR part, EU directive, REACH article, state law), applicable product categories, compliance deadline, renewal frequency, advance notice period, responsible regulatory affairs owner, estimated compliance cost, and current compliance status. Drives the regulatory compliance calendar and proactive renewal management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` (
    `compliance_assessment_id` BIGINT COMMENT 'Primary key for compliance_assessment',
    `employee_id` BIGINT COMMENT 'The compliance assessor employee id of the compliance assessment record',
    `compliance_obligation_id` BIGINT COMMENT 'The compliance obligation id of the compliance assessment record',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing or distribution facility being assessed for regulatory compliance.',
    `primary_compliance_assessor_employee_id` BIGINT COMMENT 'Employee identifier for the individual who conducted the compliance assessment.',
    `product_formulation_id` BIGINT COMMENT 'Reference to the specific product formulation undergoing compliance assessment.',
    `reviewer_employee_id` BIGINT COMMENT 'Employee identifier for the individual who reviewed and approved the compliance assessment.',
    `sku_id` BIGINT COMMENT 'Reference to the product being assessed for regulatory compliance.',
    `assessment_date` DATE COMMENT 'The date on which the compliance assessment was performed.',
    `assessment_method` STRING COMMENT 'Method or approach used to conduct the compliance assessment (e.g., document review, laboratory test, site inspection, supplier audit, self-assessment, third-party certification).. Valid values are `document_review|laboratory_test|site_inspection|supplier_audit|self_assessment|third_party_certification`',
    `assessment_number` STRING COMMENT 'Externally-known unique identifier for the compliance assessment record, typically formatted as CA-YYYYNNNN.. Valid values are `^CA-[0-9]{8}$`',
    `assessment_result` STRING COMMENT 'The assessment result of the compliance assessment record',
    `assessment_type` STRING COMMENT 'Classification of the compliance assessment type (e.g., initial, periodic, pre-market, post-market, audit-triggered, change control).. Valid values are `initial|periodic|pre_market|post_market|audit_triggered|change_control`',
    `assessor_name` STRING COMMENT 'Full name of the individual or team who conducted the compliance assessment.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this compliance assessment to the audit trail or change history log for traceability and regulatory audit readiness.',
    `certification_number` STRING COMMENT 'Unique identifier for the third-party certification or approval certificate obtained as evidence of compliance, if applicable.',
    `closure_date` DATE COMMENT 'Date on which the compliance assessment was formally closed after verification of corrective actions or confirmation of compliance.',
    `compliance_assessment_code` STRING COMMENT 'The compliance assessment code of the compliance assessment record',
    `comments` STRING COMMENT 'Additional comments, notes, or observations related to the compliance assessment that provide context or clarification.',
    `compliance_assessment_status` STRING COMMENT 'The compliance assessment status of the compliance assessment record',
    `compliance_finding` STRING COMMENT 'Detailed narrative of the compliance assessment finding, including observations, test results, and rationale for the compliance determination.',
    `compliance_score` DECIMAL(18,2) COMMENT 'The compliance score of the compliance assessment record',
    `compliance_status` STRING COMMENT 'Current compliance finding status indicating whether the product, formulation, or facility meets the regulatory requirement (compliant, non-compliant, conditional, pending review, not applicable).. Valid values are `compliant|non_compliant|conditional|pending_review|not_applicable`',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective action plan required to remediate the non-compliance or conditional finding.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which the corrective action must be completed to achieve compliance.',
    `corrective_action_owner` STRING COMMENT 'Name of the individual or department responsible for implementing the corrective action.',
    `corrective_action_required` BOOLEAN COMMENT 'Boolean flag indicating whether corrective action is required to address the compliance finding (True if corrective action is required, False otherwise).',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action implementation (not started, in progress, completed, verified, overdue).. Valid values are `not_started|in_progress|completed|verified|overdue`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when the compliance assessment record was first created in the system.',
    `compliance_assessment_description` STRING COMMENT 'The compliance assessment description of the compliance assessment record',
    `effective_from` DATE COMMENT 'The effective from of the compliance assessment record',
    `effective_until` DATE COMMENT 'The effective until of the compliance assessment record',
    `evidence_document_reference` STRING COMMENT 'Reference identifier or URI to the supporting documentation, test reports, certificates, or dossiers that substantiate the compliance assessment finding.',
    `finding_summary` STRING COMMENT 'The finding summary of the compliance assessment record',
    `gap_description` STRING COMMENT 'The gap description of the compliance assessment record',
    `jurisdiction` STRING COMMENT 'Three-letter ISO country code representing the regulatory jurisdiction under which the compliance assessment applies (e.g., USA, DEU, GBR, CHN).. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when the compliance assessment record was last modified or updated.',
    `compliance_assessment_name` STRING COMMENT 'The compliance assessment name of the compliance assessment record',
    `next_assessment_date` DATE COMMENT 'The next assessment date of the compliance assessment record',
    `next_assessment_due_date` DATE COMMENT 'Scheduled date for the next periodic compliance assessment or re-assessment.',
    `notes` STRING COMMENT 'The notes of the compliance assessment record',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory authority or governing body responsible for the regulatory framework (e.g., FDA, EPA, ECHA, CPSC).',
    `regulatory_framework` STRING COMMENT 'The governing regulatory framework under which the compliance assessment is conducted (e.g., CFR, IFRA, EU CLP, REACH, EPA, FDA, CPSC). [ENUM-REF-CANDIDATE: CFR|IFRA|EU_CLP|REACH|EPA|FDA|CPSC — 7 candidates stripped; promote to reference product]',
    `remediation_plan` STRING COMMENT 'The remediation plan of the compliance assessment record',
    `requirement_description` STRING COMMENT 'Detailed description of the specific regulatory requirement being assessed for compliance.',
    `requirement_reference` STRING COMMENT 'Specific citation or reference to the regulatory requirement being assessed (e.g., 21 CFR 701.3, IFRA Standard 49, REACH Annex XVII Entry 23).',
    `review_date` DATE COMMENT 'Date on which the compliance assessment was formally reviewed and approved.',
    `reviewer_name` STRING COMMENT 'Full name of the individual who reviewed and approved the compliance assessment findings.',
    `risk_level` STRING COMMENT 'Risk severity level associated with the compliance finding (critical, high, medium, low, negligible).. Valid values are `critical|high|medium|low|negligible`',
    `risk_rating` STRING COMMENT 'The risk rating of the compliance assessment record',
    `source_system_code` STRING COMMENT 'The source system code of the compliance assessment record',
    `test_report_number` STRING COMMENT 'Unique identifier for the laboratory test report or analytical certificate supporting the compliance assessment, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the compliance assessment record',
    CONSTRAINT pk_compliance_assessment PRIMARY KEY(`compliance_assessment_id`)
) COMMENT 'Transactional records documenting compliance assessments against specific regulatory requirements (CFR, IFRA, EU CLP, REACH, state regulations) for each product, formulation, or facility. Captures regulatory framework, specific requirement reference, compliance assessment date, assessor, compliance finding (compliant, non-compliant, conditional), corrective action required, corrective action due date, closure date, and evidence document reference. Supports multi-framework compliance verification including FDA/EPA audit readiness and IFRA fragrance safety substantiation. SSOT for all regulatory compliance assessments regardless of governing body.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` (
    `reach_substance_id` BIGINT COMMENT 'Unique identifier for the REACH substance record. Primary key.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Reach substances are regulated per jurisdiction; linking normalizes jurisdiction data and eliminates the duplicated code column.',
    `supplier_id` BIGINT COMMENT 'The supplier id of the reach substance record',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this substance record is currently active and in use within the organizations product portfolio.',
    `authorisation_required` BOOLEAN COMMENT 'The authorisation required of the reach substance record',
    `authorization_expiry_date` DATE COMMENT 'Date when the granted authorization expires and the substance can no longer be used unless renewed.',
    `authorization_number` STRING COMMENT 'Unique authorization number granted by the European Commission for use of an Annex XIV substance.',
    `authorization_required_flag` BOOLEAN COMMENT 'Indicates whether the substance is subject to authorization requirements under REACH Annex XIV before it can be placed on the market or used.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to every chemical substance described in the open scientific literature.. Valid values are `^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$`',
    `cmr_classification` STRING COMMENT 'Classification indicating whether the substance is carcinogenic, mutagenic, or toxic for reproduction, and its category level. [ENUM-REF-CANDIDATE: carcinogenic|mutagenic|reprotoxic|cmr_category_1a|cmr_category_1b|cmr_category_2|not_cmr — 7 candidates stripped; promote to reference product]',
    `reach_substance_code` STRING COMMENT 'The reach substance code of the reach substance record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this REACH substance record was first created in the system.',
    `reach_substance_description` STRING COMMENT 'The reach substance description of the reach substance record',
    `dnel_unit` STRING COMMENT 'Unit of measure for the DNEL value.. Valid values are `mg_per_kg_bw_per_day|mg_per_m3|ppm`',
    `dnel_value` DECIMAL(18,2) COMMENT 'The level of exposure to the substance above which humans should not be exposed, expressed in mg/kg body weight/day or mg/m³.',
    `downstream_user_notification_required_flag` BOOLEAN COMMENT 'Indicates whether downstream users must be notified of specific obligations or restrictions related to this substance.',
    `ec_number` STRING COMMENT 'Seven-digit identifier assigned to chemical substances commercially available in the European Union between 1971 and 1981 (EINECS) or notified under Directive 67/548/EEC (ELINCS).. Valid values are `^[0-9]{3}-[0-9]{3}-[0-9]$`',
    `effective_from` DATE COMMENT 'The effective from of the reach substance record',
    `effective_until` DATE COMMENT 'The effective until of the reach substance record',
    `endocrine_disruptor_flag` BOOLEAN COMMENT 'Indicates whether the substance is identified as an endocrine disruptor under EU criteria.',
    `exposure_scenario_required_flag` BOOLEAN COMMENT 'Indicates whether exposure scenarios must be developed and communicated in the extended Safety Data Sheet for this substance.',
    `ghs_pictogram_codes` STRING COMMENT 'Comma-separated list of GHS pictogram codes required on labels (e.g., GHS02, GHS05, GHS07, GHS09).',
    `h_statements` STRING COMMENT 'Comma-separated list of standardized hazard statement codes describing the nature of hazards (e.g., H302, H315, H400).',
    `hazard_classification` STRING COMMENT 'Classification and Labelling (CLP) hazard class and category codes assigned to the substance (e.g., Acute Tox. 3, Skin Corr. 1B, Aquatic Chronic 2).',
    `last_evaluation_date` DATE COMMENT 'Date when the substance was last evaluated by ECHA or competent authorities for compliance or risk assessment purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this REACH substance record was last updated or modified.',
    `market_access_status_eu` STRING COMMENT 'Current market access status for placing the substance on the EU market.. Valid values are `approved|restricted|banned|pending`',
    `reach_substance_name` STRING COMMENT 'The reach substance name of the reach substance record',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or re-evaluation of the substance registration or authorization.',
    `notes` STRING COMMENT 'The notes of the reach substance record',
    `p_statements` STRING COMMENT 'Comma-separated list of standardized precautionary statement codes describing recommended measures to minimize or prevent adverse effects (e.g., P264, P280, P301+P312).',
    `pbt_assessment` STRING COMMENT 'Assessment result indicating whether the substance meets the criteria for being Persistent, Bioaccumulative and Toxic (PBT) or very Persistent and very Bioaccumulative (vPvB).. Valid values are `pbt|vpvb|not_pbt|under_assessment`',
    `pnec_unit` STRING COMMENT 'Unit of measure for the PNEC value.. Valid values are `mg_per_l|mg_per_kg|ug_per_l`',
    `pnec_value` DECIMAL(18,2) COMMENT 'The concentration of the substance below which adverse effects in the environmental sphere of concern are not expected to occur.',
    `reach_registration_number` STRING COMMENT 'Unique registration number issued by ECHA upon successful REACH registration. Format: YY-XXXXXXXXXX-XX-XXXX where YY is submission year.. Valid values are `^[0-9]{2}-[0-9]{10}-[0-9]{2}-[0-9]{4}$`',
    `reach_substance_status` STRING COMMENT 'The reach substance status of the reach substance record',
    `registration_date` DATE COMMENT 'Date when the substance was successfully registered with ECHA under REACH.',
    `registration_deadline` DATE COMMENT 'The registration deadline of the reach substance record',
    `registration_expiry_date` DATE COMMENT 'Date when the current REACH registration expires and renewal is required.',
    `registration_status` STRING COMMENT 'Current status of the substance registration under REACH regulation. [ENUM-REF-CANDIDATE: registered|pre-registered|inquiry|exempted|not_required|pending|withdrawn — 7 candidates stripped; promote to reference product]',
    `restricted_substance_id` BIGINT COMMENT 'The restricted substance id of the reach substance record',
    `restriction_conditions` STRING COMMENT 'Detailed description of the specific conditions, limitations, or prohibitions applied to the substance under REACH Annex XVII restrictions.',
    `restriction_entry_number` STRING COMMENT 'The entry number in REACH Annex XVII that specifies the restriction applicable to this substance.',
    `restriction_status` STRING COMMENT 'Indicates whether the substance is subject to restrictions under REACH Annex XVII limiting or prohibiting its manufacture, use, or placing on the market.. Valid values are `restricted|banned|conditional|not_restricted`',
    `sds_required_flag` BOOLEAN COMMENT 'Indicates whether a Safety Data Sheet must be provided for this substance under REACH Article 31.',
    `sds_revision_date` DATE COMMENT 'Date of the most recent revision of the Safety Data Sheet.',
    `sds_version` STRING COMMENT 'Current version number of the Safety Data Sheet for this substance.',
    `signal_word` STRING COMMENT 'GHS signal word indicating the relative level of severity of hazard: Danger (more severe) or Warning (less severe).. Valid values are `danger|warning|none`',
    `source_system_code` STRING COMMENT 'The source system code of the reach substance record',
    `substance_name` STRING COMMENT 'The common or chemical name of the substance as registered under REACH.',
    `substance_origin_country_code` STRING COMMENT 'Three-letter ISO country code indicating the primary country of origin or manufacture for this substance.. Valid values are `^[A-Z]{3}$`',
    `supplier_reference_number` STRING COMMENT 'Internal reference number or code used by the supplier to identify this substance in their catalog or system.',
    `svhc_flag` BOOLEAN COMMENT 'The svhc flag of the reach substance record',
    `svhc_inclusion_date` DATE COMMENT 'Date when the substance was added to the SVHC Candidate List by ECHA.',
    `svhc_status` STRING COMMENT 'Classification status indicating whether the substance is identified as a Substance of Very High Concern under REACH Article 57, requiring special authorization or restriction.. Valid values are `candidate_list|authorization_list|not_svhc|under_evaluation`',
    `tonnage_band` STRING COMMENT 'Annual quantity band (in metric tonnes per year) of the substance manufactured or imported into the EU, determining registration requirements and data submission obligations.. Valid values are `1_to_10|10_to_100|100_to_1000|above_1000`',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the reach substance record',
    `use_descriptor_codes` STRING COMMENT 'Comma-separated list of standardized use descriptor codes (SU, PC, PROC, ERC, AC) describing identified uses of the substance.',
    CONSTRAINT pk_reach_substance PRIMARY KEY(`reach_substance_id`)
) COMMENT 'EU REACH regulation substance master tracking all chemical substances used in products or processes that are subject to REACH registration, evaluation, authorization, or restriction. Captures SVHC (Substance of Very High Concern) status, REACH registration number, EC number, CAS number, tonnage band, authorization status, restriction conditions, SDS requirement flag, and downstream user notification obligations. Critical for EU market access.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` (
    `ifra_compliance_record_id` BIGINT COMMENT 'Unique identifier for the IFRA compliance record. Primary key for tracking fragrance ingredient compliance assessments against IFRA standards.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the assessor who performed the IFRA compliance evaluation. Links to HR system for audit trail.',
    `product_formulation_id` BIGINT COMMENT 'The product formulation id of the ifra compliance record record',
    `sku_id` BIGINT COMMENT 'Reference to the product containing the fragrance ingredient. Links to the product master data for which this IFRA compliance assessment applies.',
    `actual_concentration_pct` DECIMAL(18,2) COMMENT 'The actual concentration pct of the ifra compliance record record',
    `actual_formulated_usage_level` DECIMAL(18,2) COMMENT 'Actual concentration of the fragrance ingredient in the finished product formulation. Expressed in the same unit as maximum_permitted_usage_level. Used to determine compliance status.',
    `allergen_declaration_required` BOOLEAN COMMENT 'Indicates whether the fragrance ingredient is a recognized allergen requiring declaration on product labeling per EU Cosmetics Regulation or other jurisdictional requirements.',
    `allergen_threshold_exceeded` BOOLEAN COMMENT 'Indicates whether the fragrance ingredient concentration exceeds the allergen labeling threshold (0.001% for leave-on, 0.01% for rinse-off products per EU regulation).',
    `amendment_number` STRING COMMENT 'The amendment number of the ifra compliance record record',
    `approval_date` DATE COMMENT 'Date when the IFRA compliance record was formally approved by regulatory affairs. Format: yyyy-MM-dd.',
    `approval_status` STRING COMMENT 'Workflow approval status of the IFRA compliance record. Approved records are used for regulatory submissions and product release decisions.. Valid values are `draft|pending approval|approved|rejected|obsolete`',
    `approved_by` STRING COMMENT 'Name of the regulatory affairs manager or quality director who approved this IFRA compliance record for use in regulatory submissions.',
    `assessment_date` DATE COMMENT 'Date when the IFRA compliance assessment was performed for this fragrance ingredient and product combination. Format: yyyy-MM-dd.',
    `assessment_due_date` DATE COMMENT 'Date by which the next IFRA compliance reassessment is required. Triggered by IFRA standard updates or product reformulation. Format: yyyy-MM-dd.',
    `assessor_name` STRING COMMENT 'Name of the regulatory affairs or quality assurance professional who performed the IFRA compliance assessment.',
    `cas_number` STRING COMMENT 'Chemical Abstracts Service registry number uniquely identifying the fragrance ingredient chemical substance. Standard format: XXXXXX-XX-X.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `certificate_reference` STRING COMMENT 'The certificate reference of the ifra compliance record record',
    `ifra_compliance_record_code` STRING COMMENT 'The ifra compliance record code of the ifra compliance record record',
    `comments` STRING COMMENT 'Free-text comments or notes from the assessor regarding special considerations, assumptions, or clarifications related to this IFRA compliance assessment.',
    `compliance_status` STRING COMMENT 'Current compliance status of the fragrance ingredient usage against IFRA standards. Compliant indicates actual usage is within permitted limits; non-compliant requires reformulation; pending review indicates assessment in progress.. Valid values are `compliant|non-compliant|pending review|not applicable|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this IFRA compliance record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Audit trail field.',
    `ifra_compliance_record_description` STRING COMMENT 'The ifra compliance record description of the ifra compliance record record',
    `effective_from` DATE COMMENT 'The effective from of the ifra compliance record record',
    `effective_until` DATE COMMENT 'The effective until of the ifra compliance record record',
    `exemption_justification` STRING COMMENT 'Detailed justification text if an exemption or deviation from IFRA standard is claimed. Must include scientific rationale and risk assessment summary.',
    `formulation_version` STRING COMMENT 'Version identifier of the product formulation for which this IFRA compliance assessment applies. Links to PLM system for formulation change tracking.',
    `fragrance_ingredient_name` STRING COMMENT 'Name of the specific fragrance ingredient being assessed for IFRA compliance. May be a chemical name, INCI name, or proprietary fragrance component identifier.',
    `fragrance_material_name` STRING COMMENT 'The fragrance material name of the ifra compliance record record',
    `geographic_scope` STRING COMMENT 'Geographic markets or jurisdictions for which this IFRA compliance assessment applies. Pipe-separated list of ISO 3-letter country codes or regional identifiers (e.g., USA|CAN|GBR|DEU|FRA).',
    `ifra_amendment_number` STRING COMMENT 'The ifra amendment number of the ifra compliance record record',
    `ifra_category` STRING COMMENT 'The ifra category of the ifra compliance record record',
    `ifra_certificate_number` STRING COMMENT 'Certificate number issued by fragrance supplier confirming IFRA compliance of the fragrance compound. Required for audit and regulatory submissions.',
    `ifra_compliance_record_status` STRING COMMENT 'The ifra compliance record status of the ifra compliance record record',
    `ifra_product_category` STRING COMMENT 'IFRA product category classification determining usage restrictions. Categories range from 1 (toys) to 12 (air fresheners), with subcategories for leave-on vs rinse-off products. Each category has specific maximum permitted usage levels. [ENUM-REF-CANDIDATE: Category 1|Category 2|Category 3|Category 4|Category 5A|Category 5B|Category 5C|Category 5D|Category 6|Category 7A|Category 7B|Category 8|Category 9|Category 10A|Category 10B|Category 11A|Category 11B|Category 12 — 18 candidates stripped; promote to reference product]',
    `ifra_standard_reference` STRING COMMENT 'The ifra standard reference of the ifra compliance record record',
    `ifra_standard_version` STRING COMMENT 'Version of the IFRA standard applied for this compliance assessment (e.g., 49th Amendment, 50th Amendment). IFRA publishes amendments periodically with updated usage restrictions.. Valid values are `^[0-9]{1,2}(th)?sAmendment$`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this IFRA compliance record is currently active and valid. Inactive records represent historical assessments superseded by newer evaluations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this IFRA compliance record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Audit trail field for change tracking.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of this IFRA compliance record. Ensures ongoing compliance monitoring as IFRA standards evolve. Format: yyyy-MM-dd.',
    `max_concentration_pct` DECIMAL(18,2) COMMENT 'The max concentration pct of the ifra compliance record record',
    `maximum_permitted_usage_level` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of the fragrance ingredient as defined by IFRA standard for the specified product category. Expressed as percentage (e.g., 0.5 = 0.5%). Null if no restriction applies.',
    `ifra_compliance_record_name` STRING COMMENT 'The ifra compliance record name of the ifra compliance record record',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this IFRA compliance record. Typically triggered annually or upon IFRA standard amendment. Format: yyyy-MM-dd.',
    `notes` STRING COMMENT 'The notes of the ifra compliance record record',
    `product_category` STRING COMMENT 'The product category of the ifra compliance record record',
    `product_type` STRING COMMENT 'High-level product type classification determining IFRA category assignment and usage restrictions. Leave-on products have stricter limits than rinse-off products.. Valid values are `leave-on|rinse-off|fine fragrance|household|air care|candle`',
    `qra_reference_number` STRING COMMENT 'Reference number to the Quantitative Risk Assessment document supporting the safety substantiation of this fragrance ingredient usage. Required for regulatory defense.',
    `record_source_system` STRING COMMENT 'Name of the source system from which this IFRA compliance record originated (e.g., Veeva Vault, SAP QM, PLM system). Used for data lineage and reconciliation.',
    `restriction_type` STRING COMMENT 'Type of IFRA restriction applied to the ingredient. Prohibited means banned entirely; specification means allowed with purity/quality requirements; restricted means usage level limits apply.. Valid values are `prohibited|specification|restricted`',
    `risk_assessment_reference` STRING COMMENT 'Reference number to the detailed risk assessment document or safety dossier supporting this IFRA compliance determination. Links to document management system.',
    `safety_margin_percentage` DECIMAL(18,2) COMMENT 'Calculated safety margin between actual usage level and maximum permitted level, expressed as percentage. Positive values indicate compliance buffer; negative values indicate non-compliance.',
    `source_system_code` STRING COMMENT 'The source system code of the ifra compliance record record',
    `supplier_name` STRING COMMENT 'Name of the supplier providing the fragrance ingredient or compound. Critical for traceability and IFRA certificate validation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the ifra compliance record record',
    `usage_level_unit` STRING COMMENT 'Unit of measure for usage levels. Typically percentage (%) for most fragrance ingredients, or ppm/mg/kg for trace components.. Valid values are `percentage|ppm|mg/kg`',
    CONSTRAINT pk_ifra_compliance_record PRIMARY KEY(`ifra_compliance_record_id`)
) COMMENT 'IFRA (International Fragrance Association) compliance records for fragrance-containing products. Tracks IFRA standard version, fragrance ingredient, product category (leave-on, rinse-off, fine fragrance), maximum permitted usage level per IFRA standard, actual formulated usage level, compliance status (compliant/non-compliant), assessment date, and assessor. Required for fragrance safety substantiation in personal care and household products.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` (
    `surveillance_event_id` BIGINT COMMENT 'Primary key for surveillance_event',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Investigation costs from post‑market surveillance are charged to a cost center for cost tracking.',
    `jurisdiction_id` BIGINT COMMENT 'The jurisdiction id of the surveillance event record',
    `lot_batch_id` BIGINT COMMENT 'Reference to the specific production lot or batch implicated in the surveillance event for traceability and potential recall scope determination.',
    `regulatory_registration_id` BIGINT COMMENT 'The regulatory registration id of the surveillance event record',
    `sku_id` BIGINT COMMENT 'Reference to the specific product (SKU) implicated in the surveillance event.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Post‑market surveillance investigations are assigned to an employee; FK enables investigation tracking.',
    `surveillance_reported_by_employee_id` BIGINT COMMENT 'The surveillance reported by employee id of the surveillance event record',
    `action_taken` STRING COMMENT 'The action taken of the surveillance event record',
    `batch_number` STRING COMMENT 'Manufacturing batch or lot number of the affected product for traceability and scope analysis.. Valid values are `^[A-Z0-9]{6,20}$`',
    `surveillance_event_code` STRING COMMENT 'The surveillance event code of the surveillance event record',
    `consumer_complaint_description` STRING COMMENT 'Detailed narrative description of the consumer complaint or adverse event as reported, capturing symptoms, circumstances, and product usage context.',
    `corrective_action_completion_date` DATE COMMENT 'Date when the corrective action was fully implemented and verified for effectiveness.',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective action plan implemented or planned to address the root cause and prevent recurrence.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action is required based on the investigation findings and risk assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the surveillance event record was first created in the system for audit trail purposes.',
    `surveillance_event_description` STRING COMMENT 'The surveillance event description of the surveillance event record',
    `effective_from` DATE COMMENT 'The effective from of the surveillance event record',
    `effective_until` DATE COMMENT 'The effective until of the surveillance event record',
    `event_date` DATE COMMENT 'The event date of the surveillance event record',
    `event_description` STRING COMMENT 'The event description of the surveillance event record',
    `event_occurrence_date` DATE COMMENT 'Date when the adverse event or product issue actually occurred or was first observed by the consumer or reporter.',
    `event_received_timestamp` TIMESTAMP COMMENT 'Date and time when the surveillance signal was first received by the organization, marking the start of the regulatory clock for reporting obligations.',
    `event_reference` STRING COMMENT 'The event reference of the surveillance event record',
    `event_status` STRING COMMENT 'Current lifecycle status of the post-market surveillance event investigation and resolution workflow. [ENUM-REF-CANDIDATE: reported|under_investigation|root_cause_identified|corrective_action_pending|corrective_action_completed|closed|escalated_to_recall — 7 candidates stripped; promote to reference product]',
    `event_type` STRING COMMENT 'Classification of the post-market surveillance signal indicating the nature of the safety or quality concern.. Valid values are `adverse_event|consumer_complaint|retailer_report|regulatory_inquiry|social_media_signal|quality_defect`',
    `expiration_date` DATE COMMENT 'Expiration or best-before date of the affected product, relevant for stability-related events.',
    `financial_impact_estimate` DECIMAL(18,2) COMMENT 'Estimated financial impact of the surveillance event including investigation costs, corrective actions, potential recall costs, and liability exposure in USD.',
    `geographic_market` STRING COMMENT 'Three-letter ISO country codes indicating the geographic markets where the affected product was distributed, pipe-separated for multiple countries.. Valid values are `^[A-Z]{3}(|[A-Z]{3})*$`',
    `gtin` STRING COMMENT 'Global Trade Item Number identifying the product involved in the surveillance event for international traceability.. Valid values are `^[0-9]{8,14}$`',
    `injury_description` STRING COMMENT 'Detailed description of the injury or adverse health effect reported by the consumer or healthcare provider.',
    `injury_reported_flag` BOOLEAN COMMENT 'Indicates whether the surveillance event involved a reported consumer injury or adverse health effect.',
    `investigation_completion_date` DATE COMMENT 'Date when the investigation was completed and root cause determination was finalized.',
    `investigation_start_date` DATE COMMENT 'Date when the formal investigation of the surveillance event was initiated.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the surveillance event record was last updated, supporting audit trail and data lineage requirements.',
    `manufacturing_date` DATE COMMENT 'Date when the affected product batch was manufactured, used for shelf-life and stability analysis.',
    `medical_treatment_required_flag` BOOLEAN COMMENT 'Indicates whether the reported injury required medical treatment or healthcare intervention.',
    `modified_by_user` STRING COMMENT 'Identifier of the user who last modified the surveillance event record for accountability and audit purposes.',
    `surveillance_event_name` STRING COMMENT 'The surveillance event name of the surveillance event record',
    `notes` STRING COMMENT 'The notes of the surveillance event record',
    `recall_classification` STRING COMMENT 'FDA recall classification (Class I, II, III) or equivalent regulatory classification indicating the level of health hazard.. Valid values are `class_I|class_II|class_III|market_withdrawal|not_applicable`',
    `recall_initiated_flag` BOOLEAN COMMENT 'Indicates whether the surveillance event resulted in a product recall or market withdrawal action.',
    `regulatory_authority` STRING COMMENT 'Regulatory authority to which the surveillance event must be reported based on jurisdiction and product category. [ENUM-REF-CANDIDATE: FDA|CPSC|EPA|EU_RAPEX|Health_Canada|TGA_Australia|ANVISA_Brazil|CFDA_China|MHRA_UK|none — 10 candidates stripped; promote to reference product]',
    `regulatory_report_reference_number` STRING COMMENT 'Official reference or tracking number assigned by the regulatory authority upon submission of the surveillance report.. Valid values are `^[A-Z0-9-]{8,30}$`',
    `regulatory_report_submission_date` DATE COMMENT 'Date when the mandatory regulatory report was submitted to the applicable authority.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the surveillance event triggers a mandatory regulatory reporting obligation to FDA, CPSC, EPA, or other authorities.',
    `report_due_date` DATE COMMENT 'The report due date of the surveillance event record',
    `reportable_flag` BOOLEAN COMMENT 'The reportable flag of the surveillance event record',
    `reporter_contact_email` STRING COMMENT 'Email address of the reporter for written communication and documentation exchange.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `reporter_contact_phone` STRING COMMENT 'Primary phone number of the reporter for follow-up investigation and clarification.',
    `reporter_name` STRING COMMENT 'Full name of the individual who reported the surveillance event, required for follow-up and regulatory submissions.',
    `root_cause_category` STRING COMMENT 'Standardized classification of the root cause for trending and analytics purposes. [ENUM-REF-CANDIDATE: manufacturing_defect|formulation_issue|packaging_failure|labeling_error|contamination|stability_failure|consumer_misuse|no_defect_found|under_investigation — 9 candidates stripped; promote to reference product]',
    `root_cause_identified` STRING COMMENT 'Documented root cause of the surveillance event as determined through investigation, including manufacturing defect, formulation issue, packaging failure, or misuse.',
    `severity` STRING COMMENT 'The severity of the surveillance event record',
    `severity_classification` STRING COMMENT 'Risk-based severity rating of the surveillance event based on potential harm to consumers and regulatory impact.. Valid values are `critical|major|moderate|minor|informational`',
    `signal_source` STRING COMMENT 'Origin channel through which the post-market surveillance signal was received. [ENUM-REF-CANDIDATE: consumer_direct|call_center|retailer|distributor|regulatory_authority|social_media|healthcare_provider|internal_audit — 8 candidates stripped; promote to reference product]',
    `source` STRING COMMENT 'The source of the surveillance event record',
    `source_system_code` STRING COMMENT 'The source system code of the surveillance event record',
    `surveillance_event_status` STRING COMMENT 'The surveillance event status of the surveillance event record',
    `surveillance_number` STRING COMMENT 'Business identifier for the surveillance event, externally referenced in regulatory submissions and internal tracking systems.. Valid values are `^PMS-[0-9]{8}$`',
    `units_affected_estimate` STRING COMMENT 'Estimated number of product units potentially affected by the surveillance event, used for recall scope and risk assessment.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the surveillance event record',
    CONSTRAINT pk_surveillance_event PRIMARY KEY(`surveillance_event_id`)
) COMMENT 'Post-market surveillance records tracking product safety signals, adverse event reports, consumer complaints with safety implications, and regulatory authority inquiries after product launch. Captures signal type, source (consumer complaint, retailer report, regulatory authority, social media), severity classification, affected SKU/batch, investigation status, root cause, corrective action, and regulatory reporting obligation triggered. Supports CPSC and FDA post-market requirements.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` (
    `product_recall_id` BIGINT COMMENT 'Unique identifier for the product recall event. Primary key for the product recall record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Recall expenses (logistics, disposal) are allocated to a cost center for budgeting and reporting.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Product recalls are managed per jurisdiction; linking provides a normalized jurisdiction reference.',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Recall execution must pinpoint shipments containing recalled items; linking product_recall to logistics_shipment supports targeted recall logistics and reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Recall coordination is managed by a specific employee; FK supports recall project management.',
    `product_responsible_employee_id` BIGINT COMMENT 'The product responsible employee id of the product recall record',
    `sku_id` BIGINT COMMENT 'The sku id of the product recall record',
    `affected_channels` STRING COMMENT 'Comma-separated list of distribution channels impacted by recall (e.g., Retail, E-commerce, Wholesale, DSD, DTC). Defines which go-to-market channels received affected product.',
    `affected_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where recalled products were distributed (e.g., USA, CAN, MEX, GBR, DEU).',
    `affected_gtin_list` STRING COMMENT 'Comma-separated list of GTIN/UPC/EAN codes for recalled products. Enables point-of-sale and supply chain identification of affected items.',
    `affected_lot_batch_numbers` STRING COMMENT 'Comma-separated list of manufacturing lot or batch numbers included in the recall. Enables traceability to specific production runs.',
    `affected_lot_codes` STRING COMMENT 'The affected lot codes of the product recall record',
    `affected_production_date_range_end` DATE COMMENT 'End date of the production date range for affected products. Used when recall spans multiple production dates.',
    `affected_production_date_range_start` DATE COMMENT 'Start date of the production date range for affected products. Used when recall spans multiple production dates.',
    `affected_sku_list` STRING COMMENT 'Comma-separated list of SKU codes for all product variants included in the recall. Links recall to specific product master records.',
    `affected_states_provinces` STRING COMMENT 'Comma-separated list of state or province codes where recalled products were distributed within countries. Used for regional recalls.',
    `authority_notification_date` DATE COMMENT 'Date when the company notified the relevant regulatory authority of the recall. FDA requires notification within 24 hours of recall initiation.',
    `product_recall_code` STRING COMMENT 'The product recall code of the product recall record',
    `completion_date` DATE COMMENT 'The completion date of the product recall record',
    `consumer_hotline_number` STRING COMMENT 'Toll-free or dedicated phone number for consumers to call with questions about the recall or to request remedies.',
    `consumer_remedy_instructions` STRING COMMENT 'Detailed instructions for consumers on how to return, dispose of, or obtain remedy for recalled products. Includes contact information and process steps.',
    `consumer_remedy_type` STRING COMMENT 'Type of corrective action or compensation offered to consumers who purchased recalled products. Defines how consumers are made whole.. Valid values are `Full Refund|Replacement|Repair|Credit|Disposal Instructions|No Remedy`',
    `corrective_action_plan_reference` STRING COMMENT 'Reference to the Corrective and Preventive Action (CAPA) plan implemented to prevent recurrence of the issue that caused the recall.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the product recall record',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for financial amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `product_recall_description` STRING COMMENT 'The product recall description of the product recall record',
    `effective_from` DATE COMMENT 'The effective from of the product recall record',
    `effective_until` DATE COMMENT 'The effective until of the product recall record',
    `effectiveness_check_date` DATE COMMENT 'Date when the recall effectiveness check was conducted to verify that all consignees were notified and appropriate action taken. FDA requires effectiveness checks at specified intervals.',
    `effectiveness_check_result` STRING COMMENT 'Result of the recall effectiveness check. Effective: recall objectives met. Partially Effective: some objectives met. Ineffective: recall objectives not met. Pending: check in progress.. Valid values are `Effective|Partially Effective|Ineffective|Pending`',
    `estimated_financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated total financial cost of the recall including product value, logistics, disposal, consumer remedies, and administrative costs. Reported in company reporting currency.',
    `health_hazard_evaluation` STRING COMMENT 'Assessment of the health risk posed by the recalled product. Describes potential adverse health consequences and likelihood of occurrence. Used to determine recall classification.',
    `initiation_date` DATE COMMENT 'The initiation date of the product recall record',
    `product_recall_name` STRING COMMENT 'The product recall name of the product recall record',
    `notes` STRING COMMENT 'The notes of the product recall record',
    `notification_date` DATE COMMENT 'The notification date of the product recall record',
    `press_release_reference` STRING COMMENT 'Reference number, URL, or document identifier for the official press release or public announcement of the recall.',
    `product_recall_status` STRING COMMENT 'The product recall status of the product recall record',
    `public_notification_date` DATE COMMENT 'Date when the recall was publicly announced through press release, media, or regulatory agency posting.',
    `quantity_recalled_units` DECIMAL(18,2) COMMENT 'Total number of product units subject to recall. Represents the volume of affected inventory across all distribution levels.',
    `quantity_recovered_units` DECIMAL(18,2) COMMENT 'Number of recalled product units successfully recovered and removed from distribution. Used to calculate recall effectiveness.',
    `recall_class` STRING COMMENT 'The recall class of the product recall record',
    `recall_classification` STRING COMMENT 'FDA/CPSC classification of recall severity. Class I: dangerous or defective products that could cause serious health problems or death. Class II: products that might cause temporary health problem or slight threat of serious nature. Class III: products unlikely to cause adverse health reaction but violate FDA labeling or manufacturing regulations. Voluntary: company-initiated without regulatory mandate. Market Withdrawal: minor violation not subject to FDA legal action.. Valid values are `Class I|Class II|Class III|Voluntary|Market Withdrawal`',
    `recall_completion_date` DATE COMMENT 'Date when the recall was officially closed after all corrective actions were completed and effectiveness verified. Nullable for ongoing recalls.',
    `recall_coordinator_email` STRING COMMENT 'Email address of the recall coordinator for internal and external communications regarding the recall event.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recall_coordinator_phone` STRING COMMENT 'Phone number of the recall coordinator for urgent communications regarding the recall event.',
    `recall_effectiveness_percentage` DECIMAL(18,2) COMMENT 'Percentage of recalled units successfully recovered (quantity_recovered_units / quantity_recalled_units * 100). FDA requires effectiveness checks to verify recall completion.',
    `recall_initiation_date` DATE COMMENT 'Date when the company officially initiated the recall action. Marks the beginning of the recall event lifecycle.',
    `recall_number` STRING COMMENT 'Official recall identification number assigned by the company or regulatory authority. External business identifier for the recall event.',
    `recall_reason` STRING COMMENT 'The recall reason of the product recall record',
    `recall_reason_code` STRING COMMENT 'Standardized code categorizing the root cause of the recall (e.g., contamination, mislabeling, undeclared allergen, packaging defect, microbial contamination, foreign material).',
    `recall_reason_description` STRING COMMENT 'Detailed narrative explanation of the defect, hazard, or violation that triggered the recall. Includes specific product issue, potential health risk, and circumstances of discovery.',
    `recall_scope` STRING COMMENT 'Geographic scope of the recall action. Defines the market territories affected by the recall.. Valid values are `National|Regional|State|International|Global`',
    `recall_status` STRING COMMENT 'Current lifecycle status of the recall event. Tracks progression from initiation through completion or termination.. Valid values are `Initiated|Ongoing|Completed|Terminated|Pending`',
    `recall_type` STRING COMMENT 'Distribution level at which the recall is executed. Consumer Level: product reached end consumers. Retail Level: product at retail stores. Wholesale Level: product at distribution centers. Manufacturing Level: product not yet distributed.. Valid values are `Consumer Level|Retail Level|Wholesale Level|Manufacturing Level`',
    `recall_website_url` STRING COMMENT 'URL of the dedicated webpage providing detailed recall information, consumer instructions, and remedy request forms.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this recall record was first created in the system. Audit trail for data governance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this recall record was last modified. Audit trail for data governance and change tracking.',
    `regulatory_authority` STRING COMMENT 'Name of the government agency or regulatory body overseeing the recall (e.g., FDA, CPSC, EPA, Health Canada, EU Commission). May be multiple authorities for international recalls.',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Indicates whether the recall was mandated by a regulatory authority (True) or initiated voluntarily by the company (False).',
    `root_cause_analysis_reference` STRING COMMENT 'Reference to the formal root cause analysis document or investigation report that identified the underlying cause of the product defect or contamination.',
    `source_system_code` STRING COMMENT 'The source system code of the product recall record',
    `units_affected` STRING COMMENT 'The units affected of the product recall record',
    `units_recovered` STRING COMMENT 'The units recovered of the product recall record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the product recall record',
    CONSTRAINT pk_product_recall PRIMARY KEY(`product_recall_id`)
) COMMENT 'Product recall and market withdrawal master records initiated voluntarily or mandated by regulatory authorities. Captures recall class (Class I/II/III per FDA/CPSC), recall reason, affected SKUs, affected lot/batch numbers, recall scope (geographic, channel), initiation date, authority notification date, press release reference, quantity recalled, completion date, effectiveness check results, and consumer remedy type. SSOT for recall event management across all jurisdictions and authorities.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` (
    `jurisdiction_id` BIGINT COMMENT 'Unique identifier for the regulatory jurisdiction. Primary key.',
    `parent_jurisdiction_id` BIGINT COMMENT 'Foreign key reference to a parent jurisdiction if this jurisdiction is a sub-jurisdiction (e.g., a state within a country, or a country within a regional bloc). Null for top-level jurisdictions.',
    `region_id` BIGINT COMMENT 'add column region_id (BIGINT) with FK to shared.region.region_id - jurisdictions roll up to regions for reporting',
    `animal_testing_ban_flag` BOOLEAN COMMENT 'Indicates whether the jurisdiction prohibits the sale of products tested on animals (True) or allows it (False).',
    `cfr_reference` STRING COMMENT 'The specific CFR title and part number applicable to this jurisdiction (e.g., 21 CFR Part 700 for cosmetics). Primarily used for US FDA jurisdictions.',
    `jurisdiction_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the jurisdiction (e.g., US-FDA, EU-REACH, ASEAN-CCD).. Valid values are `^[A-Z0-9]{2,10}$`',
    `comments` STRING COMMENT 'Free-text field for additional notes, clarifications, or special instructions related to this jurisdiction.',
    `contact_email` STRING COMMENT 'Official email address for contacting the regulatory authority for this jurisdiction.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Official phone number for contacting the regulatory authority for this jurisdiction.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the primary country of the jurisdiction (e.g., USA, DEU, CHN). For regional jurisdictions, this may represent the lead country or be null.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this jurisdiction record was first created in the system.',
    `currency_code` STRING COMMENT 'The currency code of the jurisdiction record',
    `jurisdiction_description` STRING COMMENT 'The jurisdiction description of the jurisdiction record',
    `effective_date` DATE COMMENT 'The date from which this jurisdiction definition and its requirements became effective.',
    `effective_from` DATE COMMENT 'The effective from of the jurisdiction record',
    `effective_until` DATE COMMENT 'The effective until of the jurisdiction record',
    `expiration_date` DATE COMMENT 'The date on which this jurisdiction definition expires or is superseded. Null if currently active with no planned expiration.',
    `gmp_compliance_required_flag` BOOLEAN COMMENT 'Indicates whether Good Manufacturing Practice (GMP) certification or compliance is mandatory for products sold in this jurisdiction (True) or not (False).',
    `ifra_compliance_required_flag` BOOLEAN COMMENT 'Indicates whether compliance with IFRA standards for fragrance ingredients is required (True) or not (False).',
    `ingredient_declaration_format` STRING COMMENT 'The required format for ingredient listing on labels: INCI (International Nomenclature of Cosmetic Ingredients), CAS (Chemical Abstracts Service number), common name, or proprietary (brand-specific naming).. Valid values are `inci|cas|common_name|proprietary`',
    `jurisdiction_status` STRING COMMENT 'Current lifecycle status of the jurisdiction record: active (in use), inactive (no longer applicable), pending (awaiting activation), superseded (replaced by newer version).. Valid values are `active|inactive|pending|superseded`',
    `jurisdiction_type` STRING COMMENT 'Classification of the jurisdiction scope: national (country-level), regional (multi-country bloc), supranational (international treaty), state/provincial (sub-national), or municipal (city-level).. Valid values are `national|regional|supranational|state|provincial|municipal`',
    `labeling_language_primary` STRING COMMENT 'ISO 639 two- or three-letter code for the primary language required on product labels in this jurisdiction (e.g., en, fr, de, zh).. Valid values are `^[a-z]{2,3}$`',
    `labeling_language_secondary` STRING COMMENT 'Comma-separated list of ISO 639 language codes for additional languages required or recommended on labels (e.g., fr,nl for Belgium).',
    `language_code` STRING COMMENT 'The language code of the jurisdiction record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this jurisdiction record was last updated or modified.',
    `jurisdiction_level` STRING COMMENT 'The jurisdiction level of the jurisdiction record',
    `market_entry_requirement_type` STRING COMMENT 'The type of regulatory requirement for market entry: notification (simple filing), registration (formal registration), pre-market approval (full dossier review before sale), post-market surveillance (monitoring after launch), or voluntary (no mandatory requirement).. Valid values are `notification|registration|pre-market_approval|post-market_surveillance|voluntary`',
    `jurisdiction_name` STRING COMMENT 'Full official name of the regulatory jurisdiction (e.g., United States Food and Drug Administration, European Union REACH).',
    `notes` STRING COMMENT 'The notes of the jurisdiction record',
    `notification_required_flag` BOOLEAN COMMENT 'Indicates whether a formal notification to the regulatory authority is required before product launch (True) or not (False).',
    `post_market_surveillance_required_flag` BOOLEAN COMMENT 'Indicates whether ongoing post-market surveillance (adverse event reporting, product monitoring) is mandatory (True) or not (False).',
    `pre_market_approval_required_flag` BOOLEAN COMMENT 'Indicates whether pre-market approval (full dossier review and authorization before sale) is required (True) or not (False).',
    `product_information_file_required_flag` BOOLEAN COMMENT 'Indicates whether a Product Information File (PIF) or dossier must be maintained and made available to authorities (True) or not (False).',
    `reach_registration_required_flag` BOOLEAN COMMENT 'Indicates whether REACH registration for chemical substances is required for this jurisdiction (True) or not (False). Primarily applicable to EU and EEA jurisdictions.',
    `registration_required_flag` BOOLEAN COMMENT 'Indicates whether formal product registration with the regulatory authority is mandatory (True) or not (False).',
    `regulatory_authority` STRING COMMENT 'Name of the governing regulatory body or agency responsible for enforcement within this jurisdiction (e.g., FDA, EPA, CPSC, European Commission).',
    `regulatory_framework` STRING COMMENT 'The primary legal or regulatory framework governing this jurisdiction (e.g., FDA 21 CFR, EU Cosmetics Regulation 1223/2009, ASEAN Cosmetic Directive, GCC Standardization Organization).',
    `responsible_person_required_flag` BOOLEAN COMMENT 'Indicates whether a designated Responsible Person (RP) within the jurisdiction is required for regulatory compliance (True) or not (False). Common in EU jurisdictions.',
    `sds_required_flag` BOOLEAN COMMENT 'Indicates whether a Safety Data Sheet (SDS) or Material Safety Data Sheet (MSDS) must be provided for products in this jurisdiction (True) or not (False).',
    `source_system_code` STRING COMMENT 'The source system code of the jurisdiction record',
    `submission_portal_url` STRING COMMENT 'URL of the online portal or system used for submitting regulatory notifications, registrations, or dossiers to this jurisdiction.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the jurisdiction record',
    `website_url` STRING COMMENT 'Official website URL of the regulatory authority for this jurisdiction, providing access to regulations, guidance documents, and submission portals.',
    CONSTRAINT pk_jurisdiction PRIMARY KEY(`jurisdiction_id`)
) COMMENT 'Reference master for regulatory jurisdictions defining the geographic and legal scope of regulatory requirements. Captures jurisdiction code, jurisdiction name, country/region, applicable regulatory framework (FDA, EU, ASEAN, GCC), market entry requirement type, language requirements for labeling, and notification vs. registration requirement flag. Used to drive multi-jurisdictional compliance workflows across registrations, labels, and submissions.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` (
    `restricted_substance_id` BIGINT COMMENT 'Unique identifier for the restricted substance record. Primary key.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Restricted substances are subject to jurisdiction‑specific regulations; linking provides a proper reference and removes the duplicated code.',
    `reach_substance_id` BIGINT COMMENT 'add column reach_substance_id (BIGINT) with FK to regulatory.reach_substance.reach_substance_id - restricted substances overlap REACH-listed substances',
    `affected_product_categories` STRING COMMENT 'Comma-separated list of product categories or SKU families in which this substance is restricted or prohibited (e.g., cosmetics, household cleaners, food contact materials, childrens products).',
    `alternative_substance_recommendations` STRING COMMENT 'Comma-separated list of CAS numbers or substance names recommended as safer alternatives for formulation substitution.',
    `applicable_regulations` STRING COMMENT 'Comma-separated list of all regulations, directives, or legal frameworks under which this substance is restricted (e.g., EU REACH, California Prop 65, FDA 21 CFR 700, EPA FIFRA, CPSC regulations).',
    `authorization_status` STRING COMMENT 'Current status of regulatory authorization for use of the substance in specific applications or markets.. Valid values are `not_required|pending|granted|denied|expired|withdrawn`',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to every chemical substance described in the open scientific literature.. Valid values are `^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$`',
    `cfr_reference` STRING COMMENT 'Specific CFR title, part, and section citation(s) that govern the use, labeling, or prohibition of this substance in the United States.',
    `restricted_substance_code` STRING COMMENT 'The restricted substance code of the restricted substance record',
    `comments` STRING COMMENT 'Free-text field for additional context, special handling instructions, or notes regarding the restricted substance and its regulatory status.',
    `concentration_unit` STRING COMMENT 'Unit of measure for the maximum permitted concentration: percent by weight, percent by volume, parts per million (ppm), parts per billion (ppb), or milligrams per kilogram.. Valid values are `percent_weight|percent_volume|ppm|ppb|mg_per_kg`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this restricted substance record was first created in the system.',
    `restricted_substance_description` STRING COMMENT 'The restricted substance description of the restricted substance record',
    `downstream_notification_required` BOOLEAN COMMENT 'Indicates whether manufacturers and importers must notify downstream users (formulators, distributors, retailers) of the presence of this substance in articles or mixtures.',
    `ec_number` STRING COMMENT 'Seven-digit identifier assigned to chemical substances for regulatory purposes within the European Union.. Valid values are `^[0-9]{3}-[0-9]{3}-[0-9]$`',
    `effective_date` DATE COMMENT 'Date on which the restriction or regulatory requirement becomes legally enforceable.',
    `effective_from` DATE COMMENT 'The effective from of the restricted substance record',
    `effective_until` DATE COMMENT 'The effective until of the restricted substance record',
    `epa_restricted_flag` BOOLEAN COMMENT 'Indicates whether the substance is subject to EPA restrictions under TSCA, FIFRA, or other environmental regulations.',
    `fda_prohibited_flag` BOOLEAN COMMENT 'Indicates whether the substance is explicitly prohibited by the FDA for use in cosmetics, drugs, or food contact materials under CFR Title 21.',
    `hazard_classification` STRING COMMENT 'GHS hazard class and category codes assigned to the substance (e.g., Acute Tox. 3, Skin Corr. 1B, Carc. 1A) for safety data sheet and labeling purposes.',
    `ifra_prohibition_category` STRING COMMENT 'IFRA product category (1-11) in which the substance is prohibited or restricted, ranging from Category 1 (lip products) to Category 11 (non-skin contact products).',
    `ifra_standard_reference` STRING COMMENT 'Reference to the applicable IFRA Standard number and amendment that governs the use of this substance in fragrance compounds.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this restricted substance record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date on which the restricted substance record was last reviewed for regulatory updates, new restrictions, or changes in applicable law.',
    `max_allowed_concentration_pct` DECIMAL(18,2) COMMENT 'The max allowed concentration pct of the restricted substance record',
    `maximum_permitted_concentration` DECIMAL(18,2) COMMENT 'Maximum allowable concentration of the substance in finished products, expressed as a percentage by weight or volume, as defined by applicable regulations.',
    `restricted_substance_name` STRING COMMENT 'The restricted substance name of the restricted substance record',
    `next_review_date` DATE COMMENT 'Date on which the next periodic review of this restricted substance record is scheduled to ensure ongoing compliance with evolving regulations.',
    `notes` STRING COMMENT 'The notes of the restricted substance record',
    `owning_team` STRING COMMENT 'Name of the internal team or department responsible for maintaining this restricted substance record (e.g., Regulatory Affairs, Product Safety, Quality Assurance).',
    `post_market_surveillance_required` BOOLEAN COMMENT 'Indicates whether ongoing post-market surveillance, adverse event reporting, or periodic safety updates are required for products containing this substance.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact for regulatory inquiries and substance compliance questions.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the individual responsible for regulatory compliance and updates related to this restricted substance.',
    `product_category_scope` STRING COMMENT 'The product category scope of the restricted substance record',
    `prohibition_flag` BOOLEAN COMMENT 'The prohibition flag of the restricted substance record',
    `prop_65_listing` BOOLEAN COMMENT 'Indicates whether the substance is listed under California Proposition 65 as known to cause cancer, birth defects, or reproductive harm, requiring warning labels for California sales.',
    `reach_registration_number` STRING COMMENT 'Unique registration number assigned under EU REACH for substances manufactured or imported in quantities of one tonne or more per year.',
    `regulation_reference` STRING COMMENT 'The regulation reference of the restricted substance record',
    `regulatory_authority` STRING COMMENT 'Name of the primary regulatory body or agency that issued the restriction (e.g., ECHA, FDA, EPA, CPSC, Health Canada).',
    `regulatory_framework` STRING COMMENT 'The regulatory framework of the restricted substance record',
    `restricted_substance_status` STRING COMMENT 'The restricted substance status of the restricted substance record',
    `restriction_basis` STRING COMMENT 'The restriction basis of the restricted substance record',
    `restriction_scope` STRING COMMENT 'The restriction scope of the restricted substance record',
    `restriction_type` STRING COMMENT 'Classification of the regulatory restriction imposed on the substance: banned (prohibited entirely), concentration_limit (allowed below threshold), disclosure_required (must be declared on label), authorization_required (needs pre-approval), restricted_use (limited applications), conditional_approval (allowed under specific conditions).. Valid values are `banned|concentration_limit|disclosure_required|authorization_required|restricted_use|conditional_approval`',
    `rspo_compliance_flag` BOOLEAN COMMENT 'Indicates whether the substance (if palm-derived) meets RSPO certification requirements for sustainable sourcing.',
    `sds_required` BOOLEAN COMMENT 'Indicates whether a Safety Data Sheet (formerly MSDS) must be maintained and provided to downstream users for this substance.',
    `source_system_code` STRING COMMENT 'The source system code of the restricted substance record',
    `substance_name` STRING COMMENT 'Common or chemical name of the restricted substance as recognized in regulatory filings and industry practice.',
    `sunset_date` DATE COMMENT 'Date after which the use of the substance is prohibited unless a specific authorization has been granted, applicable primarily under REACH authorization provisions.',
    `svhc_status` BOOLEAN COMMENT 'Indicates whether the substance is identified as a Substance of Very High Concern under REACH, triggering additional authorization and notification obligations.',
    `tonnage_band` STRING COMMENT 'Annual production or import volume range in metric tonnes per year, used for REACH registration tier determination.. Valid values are `1_to_10|10_to_100|100_to_1000|above_1000|not_applicable`',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the restricted substance record',
    CONSTRAINT pk_restricted_substance PRIMARY KEY(`restricted_substance_id`)
) COMMENT 'Master record for all chemicals, ingredients, and materials subject to prohibition, restriction, authorization, or disclosure under any applicable regulation worldwide. Captures substance name, CAS number, EC number, restriction type (banned, concentration limit, disclosure required, authorization required), applicable regulation(s), REACH registration number, tonnage band, SVHC status, authorization status, maximum permitted concentration, effective date, downstream user notification obligations, and affected product categories. SSOT for all regulated substance data including EU REACH, California Prop 65, FDA prohibited ingredients, EPA restricted chemicals, and FIFRA substances.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` (
    `regulatory_claim_id` BIGINT COMMENT 'Unique identifier for the regulatory claim record. Primary key.',
    `jurisdiction_id` BIGINT COMMENT 'The jurisdiction id of the regulatory claim record',
    `product_brand_id` BIGINT COMMENT 'FK to product.product_brand',
    `employee_id` BIGINT COMMENT 'The regulatory approved by employee id of the regulatory claim record',
    `regulatory_compliance_reviewer_employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Claims are reviewed by a designated employee; FK supports claim review audit and reporting.',
    `sku_id` BIGINT COMMENT 'Identifier of the product to which this claim applies. Links to the product master record.',
    `product_claim_id` BIGINT COMMENT 'References authoritative SSOT record in product.product_claim.',
    `adverse_event_reporting_required` BOOLEAN COMMENT 'Indicates whether adverse events related to the claim must be reported to regulatory authorities. True if reporting is required, False otherwise.',
    `approval_date` DATE COMMENT 'Date when the regulatory authority approved the claim for use. Null if not yet approved. Format: yyyy-MM-dd.',
    `approval_status` STRING COMMENT 'Regulatory authority approval status: not submitted (claim not yet filed), submitted (application filed), under review (being evaluated), approved (authorized for use), conditionally approved (approved with restrictions), denied (rejected), or appeal pending (denial being contested). [ENUM-REF-CANDIDATE: not_submitted|submitted|under_review|approved|conditionally_approved|denied|appeal_pending — 7 candidates stripped; promote to reference product]',
    `approved_markets` STRING COMMENT 'Comma-separated list of market codes or regions where the claim is approved for use (e.g., USA, EU, LATAM, APAC). Enables market-specific claim deployment.',
    `certification_number` STRING COMMENT 'Unique certification or registration number issued by the third-party certifying body. Null if no certification applies.',
    `cfr_reference` STRING COMMENT 'Specific CFR citation that governs the claim (e.g., 21 CFR 101.54 for health claims, 16 CFR Part 260 for environmental claims). Provides regulatory traceability.',
    `claim_code` STRING COMMENT 'The claim code of the regulatory claim record',
    `claim_number` STRING COMMENT 'Business identifier for the regulatory claim, formatted as RC- followed by 8 digits. Used for external reference and tracking.. Valid values are `^RC-[0-9]{8}$`',
    `claim_scope` STRING COMMENT 'Scope of the claim application: product-specific (applies to one SKU), brand-level (applies to all products under a brand), category-level (applies to a product category), or ingredient-specific (applies to products containing a specific ingredient).. Valid values are `product_specific|brand_level|category_level|ingredient_specific`',
    `claim_status` STRING COMMENT 'Current lifecycle status of the regulatory claim: draft (being prepared), pending review (submitted for approval), approved (authorized for use), rejected (denied by authority), expired (approval period ended), or withdrawn (voluntarily removed).. Valid values are `draft|pending_review|approved|rejected|expired|withdrawn`',
    `claim_text` STRING COMMENT 'Full text of the regulatory claim as it appears or will appear on product labels, packaging, or marketing materials. Must match approved wording exactly.',
    `claim_type` STRING COMMENT 'Category of regulatory claim: structure/function claims (e.g., strengthens hair), environmental claims (biodegradable, recyclable), organic/natural certifications, efficacy claims (clinically proven), safety claims, nutritional claims, or hypoallergenic claims. [ENUM-REF-CANDIDATE: structure_function|environmental|organic_natural|efficacy|safety|nutritional|hypoallergenic — 7 candidates stripped; promote to reference product]',
    `regulatory_claim_code` STRING COMMENT 'The regulatory claim code of the regulatory claim record',
    `comments` STRING COMMENT 'Free-text field for additional notes, context, or special instructions related to the claim. May include reviewer comments, historical context, or implementation guidance.',
    `compliance_review_date` DATE COMMENT 'Date when the internal compliance review was completed. Format: yyyy-MM-dd.',
    `compliance_review_outcome` STRING COMMENT 'Result of internal FTC/FDA compliance review: compliant (meets all requirements), non-compliant (violates regulations), requires modification (needs changes before use), pending review (under evaluation), or not reviewed (not yet assessed).. Valid values are `compliant|non_compliant|requires_modification|pending_review|not_reviewed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory claim record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Supports audit trail and data lineage.',
    `regulatory_claim_description` STRING COMMENT 'The regulatory claim description of the regulatory claim record',
    `disclaimer_required_flag` BOOLEAN COMMENT 'Indicates whether a disclaimer statement must accompany the claim on labels or marketing materials. True if disclaimer is required, False otherwise.',
    `disclaimer_text` STRING COMMENT 'Full text of the required disclaimer that must accompany the claim. Null if no disclaimer is required. Must be displayed in accordance with regulatory guidelines.',
    `effective_date` DATE COMMENT 'Date when the approved claim becomes valid for use on products and marketing materials. May differ from approval date due to implementation lead time. Format: yyyy-MM-dd.',
    `effective_from` DATE COMMENT 'The effective from of the regulatory claim record',
    `effective_until` DATE COMMENT 'The effective until of the regulatory claim record',
    `eu_regulation_reference` STRING COMMENT 'Specific EU regulation or directive that governs the claim (e.g., Regulation 1223/2009 for cosmetics, Regulation 1924/2006 for nutrition and health claims). Null if not applicable to EU markets.',
    `expiry_date` DATE COMMENT 'Date when the claim approval expires and can no longer be used unless renewed. Null for claims with indefinite approval. Format: yyyy-MM-dd.',
    `ifra_compliance_flag` BOOLEAN COMMENT 'Indicates whether the claim complies with IFRA standards for fragrance ingredients. True if compliant, False if not applicable or non-compliant. Relevant for cosmetics and personal care products.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code for the claim text (e.g., en for English, es for Spanish, fr for French). Supports multi-language claim management.. Valid values are `^[a-z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory claim record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Supports change tracking and audit compliance.',
    `regulatory_claim_name` STRING COMMENT 'The regulatory claim name of the regulatory claim record',
    `notes` STRING COMMENT 'The notes of the regulatory claim record',
    `owning_team` STRING COMMENT 'Name of the internal team or department responsible for managing the claim (e.g., Regulatory Affairs, Product Development, Marketing). Supports accountability and workflow routing.',
    `post_market_surveillance_required` BOOLEAN COMMENT 'Indicates whether post-market surveillance or ongoing monitoring is required for the claim. True if surveillance is mandated, False otherwise.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact person for the claim. Used for notifications and inquiries.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact person responsible for the claim. Typically a regulatory affairs specialist or product manager.',
    `product_category` STRING COMMENT 'High-level category of the product associated with the claim: cosmetics, personal care, household products, food, dietary supplements, over-the-counter (OTC) drugs, or medical devices. Determines applicable regulatory framework. [ENUM-REF-CANDIDATE: cosmetics|personal_care|household|food|dietary_supplement|otc_drug|medical_device — 7 candidates stripped; promote to reference product]',
    `regulatory_authority` STRING COMMENT 'Primary regulatory authority that reviewed or approved the claim: FDA (U.S. Food and Drug Administration), EPA (Environmental Protection Agency), CPSC (Consumer Product Safety Commission), EU Commission, EFSA (European Food Safety Authority), USDA (U.S. Department of Agriculture), FTC (Federal Trade Commission), Health Canada, TGA (Therapeutic Goods Administration - Australia), ANVISA (Brazil), or CFDA (China Food and Drug Administration). [ENUM-REF-CANDIDATE: FDA|EPA|CPSC|EU_COMMISSION|EFSA|USDA|FTC|HEALTH_CANADA|TGA|ANVISA|CFDA — 11 candidates stripped; promote to reference product]',
    `regulatory_body` STRING COMMENT 'The regulatory body of the regulatory claim record',
    `regulatory_claim_status` STRING COMMENT 'The regulatory claim status of the regulatory claim record',
    `renewal_frequency_months` STRING COMMENT 'Number of months between required renewals for the claim. Null if no renewal is required. Common values: 12, 24, 36, 60.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether the claim requires periodic renewal with the regulatory authority. True if renewal is required, False if approval is indefinite.',
    `source_system_code` STRING COMMENT 'The source system code of the regulatory claim record',
    `submission_date` DATE COMMENT 'Date when the claim was submitted to the regulatory authority for review. Format: yyyy-MM-dd.',
    `substantiation_method` STRING COMMENT 'Method used to substantiate the claim: clinical study (human trials), laboratory test (in vitro), consumer perception study, literature review, expert opinion, historical use documentation, or third-party certification. [ENUM-REF-CANDIDATE: clinical_study|laboratory_test|consumer_perception|literature_review|expert_opinion|historical_use|third_party_certification — 7 candidates stripped; promote to reference product]',
    `supporting_study_reference` STRING COMMENT 'Reference identifier or citation for the study, test report, or documentation that substantiates the claim. May include internal study IDs, published journal citations, or third-party certification numbers.',
    `third_party_certification` STRING COMMENT 'Name of third-party certification body or seal that validates the claim (e.g., USDA Organic, Leaping Bunny, EcoCert, NSF, Rainforest Alliance). Null if no third-party certification applies.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the regulatory claim record',
    `usage_restriction` STRING COMMENT 'Any restrictions or conditions on the use of the claim, such as required disclaimers, context limitations, or co-claim requirements. Free text field for detailed restriction documentation.',
    `version_number` STRING COMMENT 'The version number of the regulatory claim record',
    CONSTRAINT pk_regulatory_claim PRIMARY KEY(`regulatory_claim_id`)
) COMMENT 'Master record of approved and pending regulatory claims for products including structure/function claims, environmental claims (biodegradable, recyclable), organic/natural certifications, and efficacy claims. Captures claim text, claim type, substantiation method, supporting study references, regulatory authority approval status, approved markets, claim expiry date, and FTC/FDA compliance review outcome. Prevents unapproved claims from appearing on labels or marketing materials. [SSOT] Superseded by authoritative table product.product_claim for concept claim. SSOT: canonical table is product.product_claim. [SSOT for concept claim.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` (
    `action_id` BIGINT COMMENT 'Unique identifier for the regulatory action record. Primary key.',
    `employee_id` BIGINT COMMENT 'The action assigned employee id of the action record',
    `compliance_assessment_id` BIGINT COMMENT 'The compliance assessment id of the action record',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Costs of corrective actions are charged to a cost center for internal cost control.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Penalties or fees from regulatory actions are posted to a GL account for financial compliance.',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing facility, warehouse, or distribution center that is the subject of this regulatory action. Links to facility master data. Nullable when action is product-specific rather than facility-specific.',
    `owner_employee_id` BIGINT COMMENT 'The owner employee id of the action record',
    `primary_regulatory_action_responsible_party_employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory actions assign a responsible employee for follow‑up; FK enables tracking of accountability.',
    `sku_id` BIGINT COMMENT 'Reference to the specific product affected by this regulatory action. Links to the product master data. Nullable when action applies to facility or process rather than specific product.',
    `surveillance_event_id` BIGINT COMMENT 'The surveillance event id of the action record',
    `action_date` DATE COMMENT 'Official date the regulatory authority issued or published the enforcement action. This is the business event timestamp representing when the action became effective.',
    `action_number` STRING COMMENT 'Official reference number assigned by the regulatory authority to this enforcement action (e.g., warning letter number, import alert number, consent decree docket number).. Valid values are `^[A-Z0-9-]{6,30}$`',
    `action_status` STRING COMMENT 'Current lifecycle status of the regulatory action. Tracks progression from initial receipt through company response, corrective action implementation, and final resolution or closure by the authority. [ENUM-REF-CANDIDATE: received|under_review|response_submitted|corrective_action_in_progress|resolved|closed|appealed — 7 candidates stripped; promote to reference product]',
    `action_type` STRING COMMENT 'Classification of the regulatory enforcement action received. Warning letters address violations; import alerts restrict product entry; consent decrees are legal settlements; Form 483 observations document inspection findings; recalls remove products from market; injunctions halt operations; seizures confiscate products; penalties impose fines; prosecutions pursue criminal charges. [ENUM-REF-CANDIDATE: warning_letter|import_alert|consent_decree|form_483|mandatory_recall|voluntary_recall|injunction|seizure|civil_penalty|criminal_prosecution — 10 candidates stripped; promote to reference product]',
    `affected_facility_list` STRING COMMENT 'Comma-separated list of facility names or codes affected by this regulatory action when multiple sites are involved. Used for multi-site enforcement actions or consent decrees covering multiple locations.',
    `affected_product_list` STRING COMMENT 'Comma-separated list of product names, SKUs (Stock Keeping Units), or GTINs (Global Trade Item Numbers) affected by this regulatory action when multiple products are involved. Used when action spans multiple products or product families.',
    `audit_completion_date` DATE COMMENT 'Date the mandated external audit was completed and final audit report submitted to the regulatory authority. Null if no external audit is required or if audit is still in progress.',
    `board_notification_date` DATE COMMENT 'Date the Board of Directors was formally notified of this regulatory action. Required for material enforcement actions that could impact financial statements, stock price, or corporate reputation. Null if board notification was not required.',
    `citation_reference` STRING COMMENT 'Specific legal or regulatory code sections cited in the enforcement action (e.g., 21 CFR 211.110 for GMP violations, 40 CFR 261 for hazardous waste, 16 CFR Part 1500 for CPSC). Provides the legal basis for the action.',
    `action_code` STRING COMMENT 'The action code of the action record',
    `comments` STRING COMMENT 'Free-text field for internal notes, strategic considerations, lessons learned, or additional context about this regulatory action. May include legal strategy notes, root cause analysis summary, or cross-functional coordination details. Confidential internal use only.',
    `completion_date` DATE COMMENT 'The completion date of the action record',
    `corrective_action_plan_reference` STRING COMMENT 'Reference identifier to the formal Corrective and Preventive Action (CAPA) plan submitted to the regulatory authority in response to this action. Links to the CAPA management system where detailed remediation steps, timelines, and verification evidence are documented.. Valid values are `^CAP-[A-Z0-9-]{6,30}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory action record was first created in the system. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX. Audit trail for data lineage.',
    `action_description` STRING COMMENT 'The action description of the action record',
    `due_date` DATE COMMENT 'The due date of the action record',
    `effective_from` DATE COMMENT 'The effective from of the action record',
    `effective_until` DATE COMMENT 'The effective until of the action record',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this regulatory action has been escalated to executive leadership (CEO, COO, General Counsel) due to severity, financial impact, or reputational risk. True for actions requiring board-level visibility; False for routine enforcement handled at operational level.',
    `external_audit_required_flag` BOOLEAN COMMENT 'Indicates whether the regulatory action mandates an independent third-party audit or inspection to verify corrective actions. True when authority requires external verification; False when internal verification is sufficient.',
    `external_auditor_name` STRING COMMENT 'Name of the independent third-party auditing firm or consultant engaged to verify corrective actions as required by the regulatory authority. Null if no external audit is required.',
    `financial_penalty_amount` DECIMAL(18,2) COMMENT 'Monetary fine or civil penalty assessed by the regulatory authority as part of the enforcement action. Expressed in the currency specified in penalty_currency_code. Null if no financial penalty was imposed.',
    `insurance_claim_reference` STRING COMMENT 'Reference number for any insurance claim filed to recover costs associated with this regulatory action (e.g., recall expenses, legal fees, penalties). Links to the insurance claims management system. Null if no claim was filed.. Valid values are `^INS-[A-Z0-9-]{6,30}$`',
    `issuing_authority` STRING COMMENT 'The regulatory body or government agency that issued the enforcement action. FDA (Food and Drug Administration) for food/drug/cosmetics; EPA (Environmental Protection Agency) for environmental violations; CPSC (Consumer Product Safety Commission) for product safety; EU REACH for chemical compliance; FTC (Federal Trade Commission) for advertising; OSHA for workplace safety; state agencies for local enforcement; international authorities for foreign jurisdictions. [ENUM-REF-CANDIDATE: FDA|EPA|CPSC|EU_REACH|FTC|OSHA|STATE_AGENCY|INTERNATIONAL_AUTHORITY — 8 candidates stripped; promote to reference product]',
    `jurisdiction_code` STRING COMMENT 'Geographic or regulatory jurisdiction where the action was issued. Uses ISO 3166-1 alpha-3 country codes (e.g., USA, DEU, GBR) with optional subdivision codes for state/province level enforcement (e.g., USA-CA for California, USA-NY for New York).. Valid values are `^[A-Z]{2,3}(-[A-Z0-9]{2,4})?$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory action record was last updated in the system. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX. Audit trail for change tracking.',
    `legal_counsel_assigned` STRING COMMENT 'Name of the internal or external legal counsel assigned to advise on this regulatory action. Critical for consent decrees, injunctions, civil penalties, and criminal prosecutions where legal strategy is required.',
    `action_name` STRING COMMENT 'The action name of the action record',
    `notes` STRING COMMENT 'The notes of the action record',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial penalty amount (e.g., USD, EUR, GBP). Null if no financial penalty was imposed.. Valid values are `^[A-Z]{3}$`',
    `previous_action_reference` STRING COMMENT 'Reference to the earlier regulatory action that cited the same or related violations. Used to track repeat violations and enforcement escalation patterns. Null if this is a first-time violation.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `priority` STRING COMMENT 'The priority of the action record',
    `public_disclosure_flag` BOOLEAN COMMENT 'Indicates whether the regulatory action has been publicly disclosed by the authority (e.g., published on FDA warning letters database, EPA enforcement actions website). True if publicly available; False if confidential or under seal.',
    `public_disclosure_url` STRING COMMENT 'Web address where the regulatory action is publicly published by the issuing authority. Typically links to FDA warning letters database, EPA enforcement actions, CPSC recall notices, or equivalent public registries. Null if not publicly disclosed.. Valid values are `^https?://.*`',
    `recall_class` STRING COMMENT 'FDA recall classification indicating the health hazard level. Class I: dangerous or defective products that could cause serious health problems or death; Class II: products that might cause temporary health problem or slight threat of serious nature; Class III: products unlikely to cause adverse health reaction but violate FDA regulations. Null if no recall is involved.. Valid values are `class_i|class_ii|class_iii`',
    `recall_required_flag` BOOLEAN COMMENT 'Indicates whether the regulatory action mandates a product recall. True for mandatory recalls ordered by the authority; False for actions that do not require recall or for voluntary recalls initiated by the company.',
    `received_date` DATE COMMENT 'Date the company officially received notification of the regulatory action. May differ from action_date due to transmission delays or publication lag.',
    `reference` STRING COMMENT 'The reference of the action record',
    `repeat_violation_flag` BOOLEAN COMMENT 'Indicates whether this regulatory action cites violations that were previously identified in earlier inspections or enforcement actions. True for repeat violations, which typically result in escalated enforcement and higher penalties; False for first-time violations.',
    `resolution_date` DATE COMMENT 'Date the regulatory authority officially closed or resolved the enforcement action, indicating the company has satisfactorily addressed all cited violations and corrective actions have been verified.',
    `response_due_date` DATE COMMENT 'Deadline by which the company must submit a formal response to the regulatory authority. Typically 15-30 days from receipt depending on action type and jurisdiction. Missing this deadline can escalate enforcement.',
    `response_submitted_date` DATE COMMENT 'Date the company submitted its formal response to the regulatory authority addressing the violations or observations cited in the action.',
    `responsible_party_email` STRING COMMENT 'Corporate email address of the internal executive or department head accountable for this regulatory action. Used for escalation and executive reporting.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `risk_score` STRING COMMENT 'Internal risk assessment score (0-100 scale) evaluating the potential business impact of this regulatory action. Considers factors such as financial exposure, reputational damage, operational disruption, and likelihood of escalation. Higher scores indicate greater risk requiring executive attention.',
    `severity_level` STRING COMMENT 'Regulatory assessment of the seriousness of the violation. Critical: immediate health/safety risk requiring urgent action; Major: significant compliance failure with potential harm; Minor: procedural non-compliance with low risk; Observation: noted deficiency not yet a violation but requiring attention.. Valid values are `critical|major|minor|observation`',
    `source_system_code` STRING COMMENT 'The source system code of the action record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the action record',
    `violation_category` STRING COMMENT 'Primary classification of the regulatory violation cited in the action. GMP (Good Manufacturing Practice) violations relate to production standards; labeling violations involve packaging claims or ingredient declarations; safety violations concern product hazards; environmental violations address EPA compliance; advertising violations involve FTC rules; ingredient violations relate to prohibited or undeclared substances; quality system violations concern QMS (Quality Management System) deficiencies; record-keeping violations involve documentation failures; reporting violations concern mandatory disclosure failures. [ENUM-REF-CANDIDATE: gmp_violation|labeling_violation|safety_violation|environmental_violation|advertising_violation|ingredient_violation|quality_system_violation|record_keeping_violation|reporting_violation — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_action PRIMARY KEY(`action_id`)
) COMMENT 'Records of regulatory authority actions received by the company including warning letters, import alerts, consent decrees, enforcement actions, Form 483 observations, and mandatory recall orders. Captures action type, issuing authority, action date, affected products/facilities, required response deadline, company response submitted date, corrective action plan reference, and resolution status. Critical for executive and legal visibility into regulatory risk.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` (
    `cpsc_filing_id` BIGINT COMMENT 'Unique identifier for the CPSC filing record. Primary key.',
    `employee_id` BIGINT COMMENT 'The cpsc filed by employee id of the cpsc filing record',
    `cpsc_submitted_by_employee_id` BIGINT COMMENT 'Employee identifier of the person who submitted the filing. Links to HR system for accountability.',
    `product_recall_id` BIGINT COMMENT 'The product recall id of the cpsc filing record',
    `regulatory_registration_id` BIGINT COMMENT 'The regulatory registration id of the cpsc filing record',
    `sku_id` BIGINT COMMENT 'Reference to the product involved in the incident or subject of the filing. Links to product master data.',
    `certificate_reference` STRING COMMENT 'The certificate reference of the cpsc filing record',
    `cpsc_filing_code` STRING COMMENT 'The cpsc filing code of the cpsc filing record',
    `comments` STRING COMMENT 'Additional notes, internal comments, or context regarding the filing, CPSC interactions, or corrective actions.',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective action plan, including consumer notification strategy, remedy process, and timeline.',
    `corrective_action_type` STRING COMMENT 'Type of corrective action proposed or implemented to address the product hazard. May include multiple remedies. [ENUM-REF-CANDIDATE: recall|repair|replacement|refund|warning|product_modification|none_proposed — 7 candidates stripped; promote to reference product]',
    `cpsc_case_number` STRING COMMENT 'Official case number assigned by CPSC upon receipt and acceptance of the filing. Used for all subsequent correspondence and tracking.. Valid values are `^[0-9]{2}-[A-Z0-9]{4,8}$`',
    `cpsc_filing_status` STRING COMMENT 'The cpsc filing status of the cpsc filing record',
    `cpsc_response_description` STRING COMMENT 'Detailed description of CPSC response, including any requirements, recommendations, or determinations made by the agency.',
    `cpsc_response_received_date` DATE COMMENT 'Date CPSC provided official response to the filing, including acceptance, request for additional information, or determination.',
    `cpsc_response_type` STRING COMMENT 'Type of response received from CPSC regarding the filing. Indicates regulatory action required or determination made.. Valid values are `accepted|additional_info_requested|recall_required|no_action_required|under_investigation|closed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CPSC filing record was first created in the system. Audit trail for record creation.',
    `defect_description` STRING COMMENT 'Technical description of the product defect or failure mode that creates the hazard. Includes root cause analysis when known.',
    `cpsc_filing_description` STRING COMMENT 'The cpsc filing description of the cpsc filing record',
    `effective_date` DATE COMMENT 'The effective date of the cpsc filing record',
    `effective_from` DATE COMMENT 'The effective from of the cpsc filing record',
    `effective_until` DATE COMMENT 'The effective until of the cpsc filing record',
    `fatality_count` STRING COMMENT 'Number of deaths associated with the product hazard. Triggers immediate CPSC notification and investigation.',
    `filing_date` DATE COMMENT 'Date the filing was officially submitted to CPSC. Must be within 24 hours of knowledge of substantial product hazard per Section 15(b) requirements.',
    `filing_number` STRING COMMENT 'Externally-known unique filing number assigned by CPSC or internally generated for tracking. Format: CPSC-YYYY-NNNNNN.. Valid values are `^CPSC-[0-9]{4}-[0-9]{6}$`',
    `filing_status` STRING COMMENT 'Current lifecycle status of the CPSC filing. Tracks progression from draft through submission, CPSC review, and final disposition. [ENUM-REF-CANDIDATE: draft|submitted|under_review|accepted|rejected|closed|withdrawn — 7 candidates stripped; promote to reference product]',
    `filing_type` STRING COMMENT 'Type of CPSC filing. Section 15(b) reports are mandatory substantial product hazard reports; incident reports capture consumer complaints; SaferProducts.gov submissions are public database entries; voluntary corrective actions and recall notifications document remediation efforts.. Valid values are `section_15b_report|incident_report|saferproducts_submission|voluntary_corrective_action|recall_notification|follow_up_report`',
    `gtin` STRING COMMENT '14-digit GTIN of the product involved. Global standard for product identification across supply chain.. Valid values are `^[0-9]{14}$`',
    `hazard_category` STRING COMMENT 'The hazard category of the cpsc filing record',
    `hazard_description` STRING COMMENT 'Detailed narrative description of the product hazard, defect, or safety issue. Explains how the product can cause harm to consumers.',
    `hazard_type` STRING COMMENT 'Primary type of hazard posed by the product defect. Categorizes the nature of risk to consumers. [ENUM-REF-CANDIDATE: fire|burn|laceration|choking|chemical_exposure|electrical_shock|fall|entrapment|suffocation|poisoning|other — 11 candidates stripped; promote to reference product]',
    `incident_count` STRING COMMENT 'Total number of reported incidents involving the product hazard, including those without injury.',
    `incident_date` DATE COMMENT 'Date the product incident, injury, or hazard event occurred or was first reported by consumer.',
    `incident_report_count` STRING COMMENT 'The incident report count of the cpsc filing record',
    `injury_count` STRING COMMENT 'Number of reported injuries associated with the product hazard. Includes both confirmed and alleged injuries.',
    `injury_description` STRING COMMENT 'Narrative description of injuries sustained by consumers, including medical treatment required. May include multiple incident summaries.',
    `injury_severity` STRING COMMENT 'Highest severity level of injuries reported. Used to assess risk level and prioritize regulatory response.. Valid values are `none|minor|moderate|serious|life_threatening|fatal`',
    `knowledge_date` DATE COMMENT 'Date the company first obtained information reasonably supporting the conclusion that a product contains a defect which could create a substantial product hazard. Triggers 24-hour reporting obligation under Section 15(b).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the CPSC filing record was last updated. Audit trail for tracking changes throughout the filing lifecycle.',
    `legal_review_completed_flag` BOOLEAN COMMENT 'Indicates whether legal counsel has reviewed and approved the filing before submission. Required for Section 15(b) reports.',
    `legal_reviewer_name` STRING COMMENT 'Name of the legal counsel who reviewed the filing.',
    `lot_batch_number` STRING COMMENT 'Manufacturing lot or batch number of the affected product units. Essential for determining scope of hazard and recall.',
    `manufacturing_date_range_end` DATE COMMENT 'End date of the manufacturing period for affected product units.',
    `manufacturing_date_range_start` DATE COMMENT 'Start date of the manufacturing period for affected product units.',
    `cpsc_filing_name` STRING COMMENT 'The cpsc filing name of the cpsc filing record',
    `notes` STRING COMMENT 'The notes of the cpsc filing record',
    `population_at_risk` STRING COMMENT 'Description of consumer population particularly vulnerable to the hazard (e.g., children under 3, elderly, pregnant women). Used for targeted warnings and recalls.',
    `product_model_number` STRING COMMENT 'Specific model or SKU number of the product involved in the incident. Critical for identifying affected units.',
    `product_name` STRING COMMENT 'Commercial name of the product involved in the CPSC filing as known to consumers.',
    `recall_announced_flag` BOOLEAN COMMENT 'Indicates whether a public recall has been announced in conjunction with this filing. True if recall press release issued.',
    `recall_announcement_date` DATE COMMENT 'Date the product recall was publicly announced via CPSC press release and website posting.',
    `regulatory_contact_email` STRING COMMENT 'Email address of the regulatory contact for official CPSC correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `regulatory_contact_name` STRING COMMENT 'Name of the primary regulatory affairs contact responsible for managing this filing and CPSC communications.',
    `saferproducts_report_number` STRING COMMENT 'Unique identifier assigned to the report in the SaferProducts.gov public database if the filing resulted in a public posting.',
    `source_system_code` STRING COMMENT 'The source system code of the cpsc filing record',
    `submitted_by_email` STRING COMMENT 'Email address of the submitter for CPSC correspondence and follow-up communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `submitted_by_name` STRING COMMENT 'Name of the individual who submitted the filing to CPSC on behalf of the company.',
    `supporting_document_count` STRING COMMENT 'Number of supporting documents attached to the filing (test reports, photos, consumer complaints, medical records, etc.).',
    `tracking_label_text` STRING COMMENT 'The tracking label text of the cpsc filing record',
    `units_affected` STRING COMMENT 'Estimated number of product units in commerce that are subject to the reported hazard. Used to assess population at risk.',
    `units_sold` STRING COMMENT 'Total number of units of the affected product sold to consumers. Helps determine recall scope and consumer notification requirements.',
    `upc` STRING COMMENT '12-digit UPC barcode of the product involved in the filing. Used for retail identification and tracking.. Valid values are `^[0-9]{12}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the cpsc filing record',
    `vault_reference_code` STRING COMMENT 'Reference identifier to the document management system (Veeva Vault) where all filing documentation is stored.',
    CONSTRAINT pk_cpsc_filing PRIMARY KEY(`cpsc_filing_id`)
) COMMENT 'CPSC (Consumer Product Safety Commission) filing records for mandatory incident reports, Section 15(b) substantial product hazard reports, and SaferProducts.gov submissions. Captures filing type, filing date, CPSC case number, product involved, hazard description, injury/incident details, population at risk, corrective action proposed, and CPSC response received. Tracks compliance with CPSA reporting obligations.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` (
    `epa_registration_id` BIGINT COMMENT 'Unique identifier for the EPA registration record. Primary key for this product.',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the internal facility master record for the manufacturing site producing this registered product. Links EPA registration to internal facility management.',
    `regulatory_registration_id` BIGINT COMMENT 'The regulatory registration id of the epa registration record',
    `sku_id` BIGINT COMMENT 'Reference to the internal product master record for the registered product. Links this EPA registration to the companys product catalog.',
    `submission_id` BIGINT COMMENT 'Reference to the regulatory submission record that resulted in this EPA registration. Links to the submission dossier and supporting documentation.',
    `active_ingredient` STRING COMMENT 'The active ingredient of the epa registration record',
    `active_ingredient_list` STRING COMMENT 'Comma-separated list of active ingredient(s) in the registered product. Each active ingredient is the chemical substance responsible for the pesticidal or antimicrobial effect. Format: Chemical Name (CAS Number); Chemical Name (CAS Number).',
    `active_ingredient_percentage` STRING COMMENT 'Percentage concentration of each active ingredient in the formulation. Corresponds to the active_ingredient_list. Format: percentage values separated by semicolons matching the ingredient list order.',
    `approval_date` DATE COMMENT 'The approval date of the epa registration record',
    `cancellation_date` DATE COMMENT 'Date when the EPA registration was cancelled, either voluntarily by the registrant or involuntarily by EPA. Nullable for active registrations.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the EPA registration was cancelled. Includes voluntary cancellation reasons (e.g., product discontinuation, business decision) or involuntary reasons (e.g., safety concerns, data deficiencies, regulatory non-compliance).',
    `epa_registration_code` STRING COMMENT 'The epa registration code of the epa registration record',
    `comments` STRING COMMENT 'Additional notes, comments, or special conditions related to this EPA registration. May include internal notes on registration strategy, EPA correspondence summaries, or special handling instructions.',
    `company_number` STRING COMMENT 'Five-digit EPA company number assigned to the registrant. This is the first component of the EPA registration number and identifies the company holding the registration.. Valid values are `^[0-9]{5}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this EPA registration record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_call_in_due_date` DATE COMMENT 'Date by which the registrant must submit data or studies in response to an EPA data call-in. Failure to meet this deadline may result in registration cancellation.',
    `data_call_in_requirement` STRING COMMENT 'Description of any outstanding data call-in requirements issued by EPA. Data call-ins require registrants to submit additional studies or data to support continued registration. Includes requirement reference number and due date.',
    `epa_registration_description` STRING COMMENT 'The epa registration description of the epa registration record',
    `effective_date` DATE COMMENT 'Date when the EPA registration becomes legally effective and the product may be manufactured, distributed, and sold under this registration.',
    `effective_from` DATE COMMENT 'The effective from of the epa registration record',
    `effective_until` DATE COMMENT 'The effective until of the epa registration record',
    `epa_establishment_number` STRING COMMENT 'EPA establishment number identifying the facility where the product is manufactured. Format: Company Number-State Code-Facility Number (e.g., 12345-CA-001). Required on product labels.. Valid values are `^[0-9]{5}-[A-Z]{2}-[0-9]{3}$`',
    `epa_registration_number` STRING COMMENT 'Official EPA registration number assigned under FIFRA. Format: Company Number-Product Number-Supplemental Number (e.g., 12345-67 or 12345-67-890). This is the externally-known unique identifier for the registered pesticide or antimicrobial product.. Valid values are `^[0-9]{5}-[0-9]{1,5}(-[0-9]{1,5})?$`',
    `epa_registration_status` STRING COMMENT 'The epa registration status of the epa registration record',
    `establishment_number` STRING COMMENT 'The establishment number of the epa registration record',
    `expiration_date` DATE COMMENT 'Date when the EPA registration expires and is no longer valid unless renewed. Nullable for registrations without a fixed expiration (subject to periodic review).',
    `expiry_date` DATE COMMENT 'The expiry date of the epa registration record',
    `formulation_type` STRING COMMENT 'Physical form and delivery method of the registered product. Determines packaging, application method, and handling requirements. [ENUM-REF-CANDIDATE: liquid|aerosol|wipe|powder|granular|tablet|gel|paste|ready_to_use|concentrate — 10 candidates stripped; promote to reference product]',
    `label_approval_date` DATE COMMENT 'Date when the current label version was approved by EPA. Critical for compliance tracking and ensuring only approved labels are used.',
    `label_approval_status` STRING COMMENT 'Current status of the EPA-approved product label. The label must be approved before the product can be marketed. Approved = label accepted by EPA, Pending Review = submitted awaiting EPA review, Conditionally Approved = approved with minor changes required, Rejected = label not acceptable, Revision Required = EPA requested changes.. Valid values are `approved|pending_review|conditionally_approved|rejected|revision_required`',
    `label_version` STRING COMMENT 'Version identifier for the currently approved EPA label. Used to track label revisions and ensure correct label is in use for manufacturing and distribution.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this EPA registration record was last updated in the system. Used for audit trail and change tracking.',
    `last_renewal_date` DATE COMMENT 'Date of the most recent renewal action for this EPA registration. Used to track renewal history and calculate next renewal due date.',
    `epa_registration_name` STRING COMMENT 'The epa registration name of the epa registration record',
    `next_renewal_due_date` DATE COMMENT 'Date by which the next renewal application must be submitted to EPA to maintain continuous registration status. Critical for compliance planning.',
    `notes` STRING COMMENT 'The notes of the epa registration record',
    `product_brand_name` STRING COMMENT 'Commercial brand name under which the product is marketed to consumers. May differ from the registered product name.',
    `product_category` STRING COMMENT 'EPA product classification category based on intended use and target pest. Antimicrobial = broad-spectrum microbial control, Disinfectant = kills bacteria/viruses on surfaces, Sanitizer = reduces microbial load, Insecticide = controls insects, Rodenticide = controls rodents, Fungicide = controls fungi, Herbicide = controls weeds. [ENUM-REF-CANDIDATE: antimicrobial|disinfectant|sanitizer|insecticide|rodenticide|fungicide|herbicide — 7 candidates stripped; promote to reference product]',
    `product_name` STRING COMMENT 'Official product name as registered with EPA. This is the name that appears on the approved label and in EPA databases.',
    `registrant_name` STRING COMMENT 'Legal name of the company or entity holding the EPA registration. This is the party legally responsible for the registered product.',
    `registration_date` DATE COMMENT 'Date when the EPA registration was officially granted or approved by the Environmental Protection Agency. This is the principal business event timestamp for this registration record.',
    `registration_review_case_number` STRING COMMENT 'EPA case number for the periodic registration review process. EPA reviews all pesticide registrations on a 15-year cycle to ensure they continue to meet safety standards.',
    `registration_review_decision_date` DATE COMMENT 'Date when EPA issued the most recent registration review decision for this product. Used to track compliance with periodic review requirements.',
    `registration_status` STRING COMMENT 'Current lifecycle status of the EPA registration. Active = currently valid and marketable, Pending = application submitted awaiting EPA decision, Approved = EPA approved but not yet effective, Suspended = temporarily not valid, Cancelled = permanently terminated, Expired = validity period ended, Withdrawn = applicant withdrew before approval. [ENUM-REF-CANDIDATE: active|pending|approved|suspended|cancelled|expired|withdrawn — 7 candidates stripped; promote to reference product]',
    `registration_type` STRING COMMENT 'Type of EPA registration action. New = initial registration, Amendment = modification to existing registration, Renewal = periodic renewal, Reregistration = compliance with updated data requirements, Cancellation = voluntary or involuntary termination, Conditional = approved pending additional data, Emergency Exemption = Section 18 emergency use. [ENUM-REF-CANDIDATE: new|amendment|renewal|reregistration|cancellation|conditional|emergency_exemption — 7 candidates stripped; promote to reference product]',
    `regulatory_contact_email` STRING COMMENT 'Email address of the primary regulatory affairs contact for this EPA registration. Used for internal coordination and EPA correspondence tracking.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `regulatory_contact_name` STRING COMMENT 'Name of the primary regulatory affairs contact responsible for managing this EPA registration. Internal point of contact for registration maintenance and EPA correspondence.',
    `reregistration_eligibility_decision` STRING COMMENT 'EPA determination of whether the product is eligible for reregistration under updated safety and environmental standards. Eligible = meets current standards, Ineligible = does not meet standards and requires reformulation or cancellation, Pending = under EPA review, Not Applicable = not subject to reregistration.. Valid values are `eligible|ineligible|pending|not_applicable`',
    `signal_word` STRING COMMENT 'Required signal word on the product label indicating relative acute toxicity. Danger = highest toxicity (Category I), Warning = moderate toxicity (Category II), Caution = lower toxicity (Category III), None = minimal toxicity (Category IV).. Valid values are `danger|warning|caution|none`',
    `source_system_code` STRING COMMENT 'The source system code of the epa registration record',
    `target_pest_list` STRING COMMENT 'List of target pests, pathogens, or organisms that the product is registered to control (e.g., bacteria, viruses, mold, ants, cockroaches). Defines the approved efficacy claims.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the epa registration record',
    `use_classification` STRING COMMENT 'EPA classification determining who may purchase and apply the product. General Use = available to general public, Restricted Use = requires certified applicator due to potential hazards to environment or applicator.. Valid values are `general|restricted`',
    `use_site_description` STRING COMMENT 'Description of approved use sites and application locations for the registered product (e.g., household surfaces, food contact surfaces, hospitals, schools, outdoor residential). Defines where the product may legally be applied.',
    `vault_document_reference` STRING COMMENT 'Reference identifier to the EPA registration documents stored in the regulatory document vault system (e.g., Veeva Vault). Links to approved labels, safety data sheets, and registration correspondence.',
    CONSTRAINT pk_epa_registration PRIMARY KEY(`epa_registration_id`)
) COMMENT 'EPA pesticide and antimicrobial product registration records under FIFRA (Federal Insecticide, Fungicide, and Rodenticide Act). Captures EPA registration number, product name, active ingredient(s), registration type (new, amendment, renewal, cancellation), registration date, expiry date, use classification (general/restricted), label approval status, and data call-in requirements. Applicable to household disinfectants, insecticides, and antimicrobial cleaning products.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` (
    `change_id` BIGINT COMMENT 'System-generated unique identifier for the regulatory change record.',
    `employee_id` BIGINT COMMENT 'The change initiated by employee id of the change record',
    `change_requested_by_employee_id` BIGINT COMMENT 'The change requested by employee id of the change record',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Regulatory changes are tied to a specific jurisdiction; linking enables consistent jurisdiction lookup and removes the duplicated code column.',
    `primary_regulatory_change_responsible_owner_employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory change implementation is owned by a specific employee; linking records ownership for change management.',
    `regulatory_registration_id` BIGINT COMMENT 'The regulatory registration id of the change record',
    `sku_id` BIGINT COMMENT 'The sku id of the change record',
    `submission_id` BIGINT COMMENT 'The submission id of the change record',
    `superseded_change_id` BIGINT COMMENT 'Self-referencing FK on change (superseded_change_id)',
    `affected_product_category` STRING COMMENT 'Product category or categories impacted by the regulatory change.',
    `affected_product_scope` STRING COMMENT 'Scope description of the products impacted (e.g., all SKUs in a brand, specific formulations).',
    `change_category` STRING COMMENT 'High‑level category of the regulatory change.. Valid values are `safety|labeling|environment|composition|marketing|manufacturing`',
    `change_number` STRING COMMENT 'External reference number assigned by the regulatory authority or internal tracking system.',
    `change_status` STRING COMMENT 'Current lifecycle status of the regulatory change record.. Valid values are `active|closed|archived`',
    `change_type` STRING COMMENT 'Classification of the change (new regulation, amendment, repeal, guidance update).. Valid values are `new|amendment|repeal|guidance`',
    `change_code` STRING COMMENT 'The change code of the change record',
    `compliance_risk_level` STRING COMMENT 'Risk rating associated with non‑compliance to the change.. Valid values are `low|medium|high`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory change record was first created.',
    `change_description` STRING COMMENT 'Detailed description of the regulatory change, including scope and rationale.',
    `effective_date` DATE COMMENT 'Date when the regulatory change becomes effective for the business.',
    `effective_from` DATE COMMENT 'The effective from of the change record',
    `effective_until` DATE COMMENT 'The effective until of the change record',
    `expiration_date` DATE COMMENT 'Date when the regulatory change ceases to be applicable, if applicable.',
    `impact_assessment_date` DATE COMMENT 'Date the impact assessment was completed or recorded.',
    `impact_assessment_status` STRING COMMENT 'Current status of the impact assessment process.. Valid values are `pending|in_progress|completed`',
    `impact_severity` STRING COMMENT 'Severity level of the regulatory impact on the business.. Valid values are `low|medium|high|critical`',
    `implementation_date` DATE COMMENT 'The implementation date of the change record',
    `implementation_end_date` DATE COMMENT 'Date when implementation activities were completed.',
    `implementation_start_date` DATE COMMENT 'Date when implementation activities began.',
    `implementation_status` STRING COMMENT 'Current status of the implementation of required actions.. Valid values are `not_started|in_progress|completed|deferred`',
    `initiated_date` DATE COMMENT 'The initiated date of the change record',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether compliance with the change is mandatory (true) or optional (false).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the regulatory change record.',
    `change_name` STRING COMMENT 'The change name of the change record',
    `notes` STRING COMMENT 'Free‑form notes or comments regarding the change.',
    `priority` STRING COMMENT 'Business priority assigned to the change for planning and resource allocation.. Valid values are `low|medium|high`',
    `reason` STRING COMMENT 'The reason of the change record',
    `reference` STRING COMMENT 'The reference of the change record',
    `regulatory_impact` STRING COMMENT 'The regulatory impact of the change record',
    `regulatory_reference` STRING COMMENT 'Citation or reference number of the regulation (e.g., CFR section, EU directive).',
    `requested_date` DATE COMMENT 'The requested date of the change record',
    `required_action_deadline` DATE COMMENT 'Latest date by which required compliance actions must be taken.',
    `source` STRING COMMENT 'Origin of the change (regulatory authority, industry body, court decision).',
    `source_authority` STRING COMMENT 'Name of the regulatory authority issuing the change (e.g., FDA, EPA).',
    `source_body` STRING COMMENT 'Governing body or standard organization responsible for the change.',
    `source_system_code` STRING COMMENT 'The source system code of the change record',
    `submission_required` BOOLEAN COMMENT 'The submission required of the change record',
    `title` STRING COMMENT 'Brief title summarizing the regulatory change.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the change record',
    `url` STRING COMMENT 'Link to the official document or announcement describing the change.',
    CONSTRAINT pk_change PRIMARY KEY(`change_id`)
) COMMENT 'Tracks new, amended, or repealed regulations and standards that may impact the companys products or operations. Captures change source (regulatory authority, industry body), change type (new regulation, amendment, repeal, guidance update), affected product categories, affected jurisdictions, impact assessment status, required action deadline, responsible regulatory affairs owner, and implementation status. Drives proactive regulatory intelligence and ensures timely compliance adaptation.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ADD CONSTRAINT `fk_regulatory_regulatory_registration_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_dossier_id` FOREIGN KEY (`dossier_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`dossier`(`dossier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_previous_submission_id` FOREIGN KEY (`previous_submission_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_regulatory_registration_id` FOREIGN KEY (`regulatory_registration_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`(`regulatory_registration_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ADD CONSTRAINT `fk_regulatory_dossier_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ADD CONSTRAINT `fk_regulatory_dossier_regulatory_registration_id` FOREIGN KEY (`regulatory_registration_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`(`regulatory_registration_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ADD CONSTRAINT `fk_regulatory_dossier_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ADD CONSTRAINT `fk_regulatory_sds_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ADD CONSTRAINT `fk_regulatory_ingredient_list_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ADD CONSTRAINT `fk_regulatory_ingredient_list_regulatory_registration_id` FOREIGN KEY (`regulatory_registration_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`(`regulatory_registration_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ADD CONSTRAINT `fk_regulatory_label_version_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ADD CONSTRAINT `fk_regulatory_label_version_previous_version_label_version_id` FOREIGN KEY (`previous_version_label_version_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`label_version`(`label_version_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ADD CONSTRAINT `fk_regulatory_label_version_regulatory_registration_id` FOREIGN KEY (`regulatory_registration_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`(`regulatory_registration_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ADD CONSTRAINT `fk_regulatory_reach_substance_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ADD CONSTRAINT `fk_regulatory_surveillance_event_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ADD CONSTRAINT `fk_regulatory_surveillance_event_regulatory_registration_id` FOREIGN KEY (`regulatory_registration_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`(`regulatory_registration_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ADD CONSTRAINT `fk_regulatory_product_recall_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ADD CONSTRAINT `fk_regulatory_jurisdiction_parent_jurisdiction_id` FOREIGN KEY (`parent_jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ADD CONSTRAINT `fk_regulatory_restricted_substance_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ADD CONSTRAINT `fk_regulatory_restricted_substance_reach_substance_id` FOREIGN KEY (`reach_substance_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`reach_substance`(`reach_substance_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ADD CONSTRAINT `fk_regulatory_regulatory_claim_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ADD CONSTRAINT `fk_regulatory_action_compliance_assessment_id` FOREIGN KEY (`compliance_assessment_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment`(`compliance_assessment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ADD CONSTRAINT `fk_regulatory_action_surveillance_event_id` FOREIGN KEY (`surveillance_event_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event`(`surveillance_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ADD CONSTRAINT `fk_regulatory_cpsc_filing_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`product_recall`(`product_recall_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ADD CONSTRAINT `fk_regulatory_cpsc_filing_regulatory_registration_id` FOREIGN KEY (`regulatory_registration_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`(`regulatory_registration_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ADD CONSTRAINT `fk_regulatory_epa_registration_regulatory_registration_id` FOREIGN KEY (`regulatory_registration_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`(`regulatory_registration_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ADD CONSTRAINT `fk_regulatory_epa_registration_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ADD CONSTRAINT `fk_regulatory_change_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ADD CONSTRAINT `fk_regulatory_change_regulatory_registration_id` FOREIGN KEY (`regulatory_registration_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`(`regulatory_registration_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ADD CONSTRAINT `fk_regulatory_change_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ADD CONSTRAINT `fk_regulatory_change_superseded_change_id` FOREIGN KEY (`superseded_change_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`change`(`change_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`regulatory` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_consumer_goods_v1`.`regulatory` SET TAGS ('dbx_domain' = 'regulatory');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` SET TAGS ('dbx_subdomain' = 'registration_compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` SET TAGS ('dbx_ssot_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` SET TAGS ('dbx_ssot_concept' = 'registration');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` SET TAGS ('dbx_ssot' = 'secondary');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` SET TAGS ('dbx_ssot_canonical' = 'product.product_registration');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` SET TAGS ('dbx_ssot_role' = 'primary');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` SET TAGS ('dbx_ssot_status' = 'authoritative');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `active_ingredients` SET TAGS ('dbx_business_glossary_term' = 'Active Ingredients');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `annual_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Annual Report Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `cfr_citation` SET TAGS ('dbx_business_glossary_term' = 'Code of Federal Regulations (CFR) Citation');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_registration_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_registration_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_registration_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `cpsc_tracking_label_required` SET TAGS ('dbx_business_glossary_term' = 'Consumer Product Safety Commission (CPSC) Tracking Label Required');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_registration_description` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_registration_description` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_registration_description` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Registration Fee Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Registration Fee Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `holder_address` SET TAGS ('dbx_business_glossary_term' = 'Registration Holder Address');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `holder_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `holder_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `holder_name` SET TAGS ('dbx_business_glossary_term' = 'Registration Holder Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `holder_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `ifra_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'International Fragrance Association (IFRA) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `jurisdiction_region` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Region');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `label_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Label Approval Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_registration_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_registration_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_registration_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Registration Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `post_market_surveillance_required` SET TAGS ('dbx_business_glossary_term' = 'Post-Market Surveillance Required');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `product_classification` SET TAGS ('dbx_business_glossary_term' = 'Product Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `product_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Registration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `registering_authority` SET TAGS ('dbx_business_glossary_term' = 'Registering Authority');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `registration_category` SET TAGS ('dbx_business_glossary_term' = 'Registration Category');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_value_regex' = 'new|renewal|amendment|cancellation|variation|transfer');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_registration_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_registration_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `regulatory_registration_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `sds_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Document Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `submission_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ALTER COLUMN `use_classification` SET TAGS ('dbx_business_glossary_term' = 'Use Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` SET TAGS ('dbx_subdomain' = 'registration_compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Assigned Reviewer Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `dossier_id` SET TAGS ('dbx_business_glossary_term' = 'Dossier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `previous_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Submission Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `actual_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Decision Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `authority_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Authority Jurisdiction');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `authority_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'electronic|paper|portal|edi');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `submission_code` SET TAGS ('dbx_business_glossary_term' = 'Submission Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_business_glossary_term' = 'Decision Outcome');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_value_regex' = 'approved|approved_with_conditions|rejected|withdrawn|pending');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `submission_description` SET TAGS ('dbx_business_glossary_term' = 'Submission Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `fee_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `fee_payment_status` SET TAGS ('dbx_value_regex' = 'paid|pending|waived|refunded');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `hazard_description` SET TAGS ('dbx_business_glossary_term' = 'Hazard Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `hazard_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Submission Language');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `submission_name` SET TAGS ('dbx_business_glossary_term' = 'Submission Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Submission Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `population_at_risk` SET TAGS ('dbx_business_glossary_term' = 'Population at Risk');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `population_at_risk` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `population_at_risk` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Submission Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'expedited|standard|routine');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `supporting_document_count` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Count');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `target_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Target Decision Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Submission Version');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` SET TAGS ('dbx_subdomain' = 'registration_compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `dossier_id` SET TAGS ('dbx_business_glossary_term' = 'Dossier Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `primary_contact_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Dossier Primary Contact Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `primary_contact_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `primary_contact_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `product_lca_id` SET TAGS ('dbx_business_glossary_term' = 'Product Lca Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `cfr_reference` SET TAGS ('dbx_business_glossary_term' = 'Code of Federal Regulations (CFR) Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `dossier_code` SET TAGS ('dbx_business_glossary_term' = 'Dossier Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `compilation_date` SET TAGS ('dbx_business_glossary_term' = 'Compilation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `compilation_date` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `compilation_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `completeness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completeness Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `completeness_status` SET TAGS ('dbx_business_glossary_term' = 'Completeness Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `completeness_status` SET TAGS ('dbx_value_regex' = 'incomplete|substantially_complete|complete|verified');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `dossier_description` SET TAGS ('dbx_business_glossary_term' = 'Dossier Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Document Count');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `dossier_number` SET TAGS ('dbx_business_glossary_term' = 'Dossier Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `dossier_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `dossier_status` SET TAGS ('dbx_business_glossary_term' = 'Dossier Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `dossier_status` SET TAGS ('dbx_value_regex' = 'draft|in_compilation|under_review|complete|submitted|archived');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `dossier_type` SET TAGS ('dbx_business_glossary_term' = 'Dossier Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `dossier_type` SET TAGS ('dbx_value_regex' = 'CTD|eCTD|IECIC|CPNP|FDA_510K|EPA_FIFRA');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `format_standard` SET TAGS ('dbx_business_glossary_term' = 'Format Standard');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `ifra_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'International Fragrance Association (IFRA) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `ingredient_declaration_included` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Declaration Included Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `dossier_name` SET TAGS ('dbx_business_glossary_term' = 'Dossier Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Regulatory Affairs Team');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `post_market_surveillance_included` SET TAGS ('dbx_business_glossary_term' = 'Post-Market Surveillance Included Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Registration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{10}-[0-9]{2}-[0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `regulatory_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Category');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `regulatory_category` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `regulatory_category` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `safety_assessment_included` SET TAGS ('dbx_business_glossary_term' = 'Safety Assessment Included Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `sds_included` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Included Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `vault_folder_path` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Folder Path');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `vault_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Reference Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `vault_reference_code` SET TAGS ('dbx_value_regex' = '^VV[A-Z0-9]{10,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` SET TAGS ('dbx_subdomain' = 'substance_control');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Author Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `accidental_release_measures` SET TAGS ('dbx_business_glossary_term' = 'Accidental Release Measures');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `appearance` SET TAGS ('dbx_business_glossary_term' = 'Appearance');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `authoring_chemist` SET TAGS ('dbx_business_glossary_term' = 'Authoring Chemist');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `authoring_chemist` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `autoignition_temperature` SET TAGS ('dbx_business_glossary_term' = 'Autoignition Temperature');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `sds_code` SET TAGS ('dbx_business_glossary_term' = 'Sds Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `sds_description` SET TAGS ('dbx_business_glossary_term' = 'Sds Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `disposal_considerations` SET TAGS ('dbx_business_glossary_term' = 'Disposal Considerations');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'sds|msds|extended_sds');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `ecological_information` SET TAGS ('dbx_business_glossary_term' = 'Ecological Information');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `emergency_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Emergency Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `emergency_phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `emergency_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `exposure_limits` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limits');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `firefighting_measures` SET TAGS ('dbx_business_glossary_term' = 'Firefighting Measures');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `first_aid_measures` SET TAGS ('dbx_business_glossary_term' = 'First Aid Measures');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `flash_point` SET TAGS ('dbx_business_glossary_term' = 'Flash Point');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `handling_precautions` SET TAGS ('dbx_business_glossary_term' = 'Handling Precautions');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `hazard_statements` SET TAGS ('dbx_business_glossary_term' = 'Hazard Statements');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `hazardous_decomposition_products` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Decomposition Products');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `incompatible_materials` SET TAGS ('dbx_business_glossary_term' = 'Incompatible Materials');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Address');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `sds_name` SET TAGS ('dbx_business_glossary_term' = 'Sds Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `odor` SET TAGS ('dbx_business_glossary_term' = 'Odor');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `packing_group` SET TAGS ('dbx_business_glossary_term' = 'Packing Group');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `personal_protective_equipment` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `ph_value` SET TAGS ('dbx_business_glossary_term' = 'pH Value');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `physical_state` SET TAGS ('dbx_business_glossary_term' = 'Physical State');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `physical_state` SET TAGS ('dbx_value_regex' = 'solid|liquid|gas|aerosol|paste|gel');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `pictograms` SET TAGS ('dbx_business_glossary_term' = 'GHS Pictograms');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `precautionary_statements` SET TAGS ('dbx_business_glossary_term' = 'Precautionary Statements');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `proper_shipping_name` SET TAGS ('dbx_business_glossary_term' = 'Proper Shipping Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `regulatory_format` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Format');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `regulatory_format` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `regulatory_format` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `regulatory_information` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Information');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `regulatory_information` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `regulatory_information` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `sds_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `sds_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `sds_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|archived');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `signal_word` SET TAGS ('dbx_business_glossary_term' = 'GHS Signal Word');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `signal_word` SET TAGS ('dbx_value_regex' = 'danger|warning|none');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `stability` SET TAGS ('dbx_business_glossary_term' = 'Stability');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `toxicological_information` SET TAGS ('dbx_business_glossary_term' = 'Toxicological Information');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `transport_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Transport Hazard Class');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` SET TAGS ('dbx_subdomain' = 'substance_control');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `ingredient_list_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient List Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `allergen_declaration` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `allergen_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `allergen_type` SET TAGS ('dbx_business_glossary_term' = 'Allergen Type Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `allergen_type` SET TAGS ('dbx_value_regex' = 'fragrance_allergen|preservative_allergen|colorant_allergen|botanical_allergen|protein_allergen|other');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `ingredient_list_code` SET TAGS ('dbx_business_glossary_term' = 'Ingredient List Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `common_name` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Common Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `concentration_max_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concentration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `concentration_max_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `concentration_min_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum Concentration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `concentration_min_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `concentration_typical_percent` SET TAGS ('dbx_business_glossary_term' = 'Typical Concentration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `concentration_typical_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `declaration_name_override` SET TAGS ('dbx_business_glossary_term' = 'Declaration Name Override');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `declaration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Label Declaration Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `declaration_status` SET TAGS ('dbx_business_glossary_term' = 'Declaration Record Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `declaration_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|active|superseded|retired');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `ingredient_list_description` SET TAGS ('dbx_business_glossary_term' = 'Ingredient List Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Declaration Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `einecs_number` SET TAGS ('dbx_business_glossary_term' = 'European Inventory of Existing Commercial Chemical Substances (EINECS) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `einecs_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{3}-[0-9]$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Declaration Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `fda_status` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Regulatory Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `fda_status` SET TAGS ('dbx_value_regex' = 'gras|food_additive|color_additive|otc_monograph|new_dietary_ingredient|not_approved');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `ifra_amendment_number` SET TAGS ('dbx_business_glossary_term' = 'International Fragrance Association (IFRA) Amendment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `ifra_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'International Fragrance Association (IFRA) Restricted Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `inci_declaration` SET TAGS ('dbx_business_glossary_term' = 'Inci Declaration');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `inci_name` SET TAGS ('dbx_business_glossary_term' = 'International Nomenclature of Cosmetic Ingredients (INCI) Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `ingredient_function` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Functional Category');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `ingredient_list_status` SET TAGS ('dbx_business_glossary_term' = 'Ingredient List Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `ingredient_order` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Order');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `ingredient_order_text` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Order Text');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `ingredient_sequence` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Declaration Sequence');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `list_type` SET TAGS ('dbx_business_glossary_term' = 'List Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `market_country_code` SET TAGS ('dbx_business_glossary_term' = 'Market Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `ingredient_list_name` SET TAGS ('dbx_business_glossary_term' = 'Ingredient List Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `nanomaterial_flag` SET TAGS ('dbx_business_glossary_term' = 'Nanomaterial Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `natural_origin_flag` SET TAGS ('dbx_business_glossary_term' = 'Natural Origin Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `palm_oil_derivative_flag` SET TAGS ('dbx_business_glossary_term' = 'Palm Oil Derivative Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Registration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `restricted_substance_flag` SET TAGS ('dbx_business_glossary_term' = 'Restricted Substance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `restriction_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Restriction Jurisdiction');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'prohibited|concentration_limited|use_restricted|authorization_required|sunset_substance');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `rspo_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Roundtable on Sustainable Palm Oil (RSPO) Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `sds_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `vegan_flag` SET TAGS ('dbx_business_glossary_term' = 'Vegan Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` SET TAGS ('dbx_subdomain' = 'label_integrity');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `label_version_id` SET TAGS ('dbx_business_glossary_term' = 'Label Version Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Label Version Approval Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `label_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `label_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `label_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `previous_version_label_version_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Label Version Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `allergen_declarations` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration Statements');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `approval_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `approval_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Regulatory Authority');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `artwork_checksum` SET TAGS ('dbx_business_glossary_term' = 'Artwork File Checksum');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `artwork_checksum` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{64}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `artwork_file_name` SET TAGS ('dbx_business_glossary_term' = 'Label Artwork File Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `artwork_reference` SET TAGS ('dbx_business_glossary_term' = 'Artwork Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `barcode_type` SET TAGS ('dbx_business_glossary_term' = 'Barcode Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `barcode_type` SET TAGS ('dbx_value_regex' = 'UPC|EAN|GTIN|QR|DataMatrix|Code128');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `barcode_value` SET TAGS ('dbx_business_glossary_term' = 'Barcode Value');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `certification_marks` SET TAGS ('dbx_business_glossary_term' = 'Certification and Compliance Marks');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Version Change Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `label_version_code` SET TAGS ('dbx_business_glossary_term' = 'Label Version Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `contact_information` SET TAGS ('dbx_business_glossary_term' = 'Consumer Contact Information');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `contact_information` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `contact_information` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `label_version_description` SET TAGS ('dbx_business_glossary_term' = 'Label Version Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `distributor_name` SET TAGS ('dbx_business_glossary_term' = 'Distributor Name on Label');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Label Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Label Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `expiry_date_format` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date Format Specification');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `ingredient_list` SET TAGS ('dbx_business_glossary_term' = 'Ingredient List Declaration');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `is_current_version` SET TAGS ('dbx_business_glossary_term' = 'Is Current Version Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `label_claims` SET TAGS ('dbx_business_glossary_term' = 'Label Claims and Marketing Statements');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `label_status` SET TAGS ('dbx_business_glossary_term' = 'Label Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `label_type` SET TAGS ('dbx_business_glossary_term' = 'Label Type Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `label_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|shipper|pallet|promotional|sample');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `label_version_status` SET TAGS ('dbx_business_glossary_term' = 'Label Version Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Label Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `lot_code_format` SET TAGS ('dbx_business_glossary_term' = 'Lot Code Format Specification');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Address on Label');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name on Label');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `market_country_code` SET TAGS ('dbx_business_glossary_term' = 'Market Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `market_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `label_version_name` SET TAGS ('dbx_business_glossary_term' = 'Label Version Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `net_content_declaration` SET TAGS ('dbx_business_glossary_term' = 'Net Content Declaration Statement');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `net_content_quantity` SET TAGS ('dbx_business_glossary_term' = 'Net Content Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `net_content_unit` SET TAGS ('dbx_business_glossary_term' = 'Net Content Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `product_name_on_label` SET TAGS ('dbx_business_glossary_term' = 'Product Name on Label');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `recycling_symbols` SET TAGS ('dbx_business_glossary_term' = 'Recycling and Sustainability Symbols');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `veeva_vault_document_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `version_label` SET TAGS ('dbx_business_glossary_term' = 'Version Label');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Label Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `warning_statements` SET TAGS ('dbx_business_glossary_term' = 'Warning and Precautionary Statements');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` SET TAGS ('dbx_subdomain' = 'obligation_management');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_responsible_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Responsible Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_responsible_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_responsible_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `advance_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Notice Period (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `applicable_product_category` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|pending|overdue|not_applicable|in_progress|expired');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `estimated_compliance_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Compliance Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `estimated_compliance_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `governing_regulation` SET TAGS ('dbx_business_glossary_term' = 'Governing Regulation');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `governing_regulation` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `governing_regulation` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `last_compliance_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Verification Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Obligation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `obligation_reference` SET TAGS ('dbx_business_glossary_term' = 'Obligation Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'registration|labeling|reporting|testing|notification|renewal');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `penalty_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `penalty_for_non_compliance` SET TAGS ('dbx_business_glossary_term' = 'Penalty for Non-Compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `penalty_for_non_compliance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'urgent|high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `regulation_name` SET TAGS ('dbx_business_glossary_term' = 'Regulation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `regulation_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `regulation_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `renewal_frequency` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `renewal_frequency` SET TAGS ('dbx_value_regex' = 'annual|biennial|triennial|quinquennial|one_time|as_needed');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `required_documentation` SET TAGS ('dbx_business_glossary_term' = 'Required Documentation');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|portal|email|in_person');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `submission_portal_url` SET TAGS ('dbx_business_glossary_term' = 'Submission Portal Uniform Resource Locator (URL)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `testing_requirement` SET TAGS ('dbx_business_glossary_term' = 'Testing Requirement');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` SET TAGS ('dbx_subdomain' = 'obligation_management');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `compliance_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `primary_compliance_assessor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `primary_compliance_assessor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `primary_compliance_assessor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'document_review|laboratory_test|site_inspection|supplier_audit|self_assessment|third_party_certification');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_value_regex' = '^CA-[0-9]{8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Assessment Result');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'initial|periodic|pre_market|post_market|audit_triggered|change_control');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Closure Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `compliance_assessment_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Assessment Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `compliance_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `compliance_finding` SET TAGS ('dbx_business_glossary_term' = 'Compliance Finding');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional|pending_review|not_applicable');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `corrective_action_owner` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Owner');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified|overdue');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `compliance_assessment_description` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `evidence_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `finding_summary` SET TAGS ('dbx_business_glossary_term' = 'Finding Summary');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `gap_description` SET TAGS ('dbx_business_glossary_term' = 'Gap Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `compliance_assessment_name` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `next_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `requirement_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `test_report_number` SET TAGS ('dbx_business_glossary_term' = 'Test Report Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` SET TAGS ('dbx_subdomain' = 'substance_control');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `reach_substance_id` SET TAGS ('dbx_business_glossary_term' = 'REACH Substance ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `authorisation_required` SET TAGS ('dbx_business_glossary_term' = 'Authorisation Required');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `authorization_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'REACH Authorization Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Authorization Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `cmr_classification` SET TAGS ('dbx_business_glossary_term' = 'Carcinogenic Mutagenic or Reprotoxic (CMR) Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `reach_substance_code` SET TAGS ('dbx_business_glossary_term' = 'Reach Substance Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `reach_substance_description` SET TAGS ('dbx_business_glossary_term' = 'Reach Substance Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `dnel_unit` SET TAGS ('dbx_business_glossary_term' = 'Derived No-Effect Level (DNEL) Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `dnel_unit` SET TAGS ('dbx_value_regex' = 'mg_per_kg_bw_per_day|mg_per_m3|ppm');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `dnel_value` SET TAGS ('dbx_business_glossary_term' = 'Derived No-Effect Level (DNEL) Value');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `downstream_user_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Downstream User Notification Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `ec_number` SET TAGS ('dbx_business_glossary_term' = 'European Community (EC) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `ec_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{3}-[0-9]$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `endocrine_disruptor_flag` SET TAGS ('dbx_business_glossary_term' = 'Endocrine Disruptor Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `exposure_scenario_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Exposure Scenario Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `ghs_pictogram_codes` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Pictogram Codes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `h_statements` SET TAGS ('dbx_business_glossary_term' = 'Hazard (H) Statements');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `last_evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Last REACH Evaluation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `market_access_status_eu` SET TAGS ('dbx_business_glossary_term' = 'European Union (EU) Market Access Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `market_access_status_eu` SET TAGS ('dbx_value_regex' = 'approved|restricted|banned|pending');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `reach_substance_name` SET TAGS ('dbx_business_glossary_term' = 'Reach Substance Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `p_statements` SET TAGS ('dbx_business_glossary_term' = 'Precautionary (P) Statements');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `pbt_assessment` SET TAGS ('dbx_business_glossary_term' = 'Persistent Bioaccumulative and Toxic (PBT) Assessment');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `pbt_assessment` SET TAGS ('dbx_value_regex' = 'pbt|vpvb|not_pbt|under_assessment');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `pnec_unit` SET TAGS ('dbx_business_glossary_term' = 'Predicted No-Effect Concentration (PNEC) Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `pnec_unit` SET TAGS ('dbx_value_regex' = 'mg_per_l|mg_per_kg|ug_per_l');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `pnec_value` SET TAGS ('dbx_business_glossary_term' = 'Predicted No-Effect Concentration (PNEC) Value');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'REACH Registration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{10}-[0-9]{2}-[0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `reach_substance_status` SET TAGS ('dbx_business_glossary_term' = 'Reach Substance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'REACH Registration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `registration_deadline` SET TAGS ('dbx_business_glossary_term' = 'Registration Deadline');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `registration_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'REACH Registration Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'REACH Registration Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `restricted_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Restricted Substance Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `restriction_conditions` SET TAGS ('dbx_business_glossary_term' = 'Restriction Conditions');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `restriction_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Annex XVII Restriction Entry Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `restriction_status` SET TAGS ('dbx_business_glossary_term' = 'REACH Restriction Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `restriction_status` SET TAGS ('dbx_value_regex' = 'restricted|banned|conditional|not_restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `sds_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `sds_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Revision Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `sds_version` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Version');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `signal_word` SET TAGS ('dbx_business_glossary_term' = 'Signal Word');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `signal_word` SET TAGS ('dbx_value_regex' = 'danger|warning|none');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `substance_name` SET TAGS ('dbx_business_glossary_term' = 'Substance Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `substance_origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Substance Origin Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `substance_origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `supplier_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `svhc_flag` SET TAGS ('dbx_business_glossary_term' = 'Svhc Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `svhc_inclusion_date` SET TAGS ('dbx_business_glossary_term' = 'SVHC Candidate List Inclusion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `svhc_status` SET TAGS ('dbx_business_glossary_term' = 'Substance of Very High Concern (SVHC) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `svhc_status` SET TAGS ('dbx_value_regex' = 'candidate_list|authorization_list|not_svhc|under_evaluation');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `tonnage_band` SET TAGS ('dbx_business_glossary_term' = 'Annual Tonnage Band');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `tonnage_band` SET TAGS ('dbx_value_regex' = '1_to_10|10_to_100|100_to_1000|above_1000');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ALTER COLUMN `use_descriptor_codes` SET TAGS ('dbx_business_glossary_term' = 'Use Descriptor Codes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` SET TAGS ('dbx_subdomain' = 'substance_control');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `ifra_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'IFRA (International Fragrance Association) Compliance Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Product Formulation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `actual_concentration_pct` SET TAGS ('dbx_business_glossary_term' = 'Actual Concentration Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `actual_formulated_usage_level` SET TAGS ('dbx_business_glossary_term' = 'Actual Formulated Usage Level');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `actual_formulated_usage_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `actual_formulated_usage_level` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `actual_formulated_usage_level` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `allergen_declaration_required` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `allergen_threshold_exceeded` SET TAGS ('dbx_business_glossary_term' = 'Allergen Threshold Exceeded Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'IFRA Record Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'IFRA Record Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending approval|approved|rejected|obsolete');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'IFRA Record Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'IFRA Compliance Assessment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'IFRA Compliance Assessment Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'IFRA Compliance Assessor Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'CAS (Chemical Abstracts Service) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `cas_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Certificate Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `ifra_compliance_record_code` SET TAGS ('dbx_business_glossary_term' = 'Ifra Compliance Record Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'IFRA Compliance Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'IFRA Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|pending review|not applicable|restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `ifra_compliance_record_description` SET TAGS ('dbx_business_glossary_term' = 'Ifra Compliance Record Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `exemption_justification` SET TAGS ('dbx_business_glossary_term' = 'IFRA Exemption Justification');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `formulation_version` SET TAGS ('dbx_business_glossary_term' = 'Product Formulation Version');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `formulation_version` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `formulation_version` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `fragrance_ingredient_name` SET TAGS ('dbx_business_glossary_term' = 'Fragrance Ingredient Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `fragrance_ingredient_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `fragrance_material_name` SET TAGS ('dbx_business_glossary_term' = 'Fragrance Material Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `ifra_amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Ifra Amendment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `ifra_category` SET TAGS ('dbx_business_glossary_term' = 'Ifra Category');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `ifra_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'IFRA Certificate Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `ifra_compliance_record_status` SET TAGS ('dbx_business_glossary_term' = 'Ifra Compliance Record Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `ifra_product_category` SET TAGS ('dbx_business_glossary_term' = 'IFRA (International Fragrance Association) Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `ifra_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Ifra Standard Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `ifra_standard_version` SET TAGS ('dbx_business_glossary_term' = 'IFRA (International Fragrance Association) Standard Version');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `ifra_standard_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,2}(th)?sAmendment$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last IFRA Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `max_concentration_pct` SET TAGS ('dbx_business_glossary_term' = 'Max Concentration Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `maximum_permitted_usage_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Permitted Usage Level');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `ifra_compliance_record_name` SET TAGS ('dbx_business_glossary_term' = 'Ifra Compliance Record Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next IFRA Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'leave-on|rinse-off|fine fragrance|household|air care|candle');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `qra_reference_number` SET TAGS ('dbx_business_glossary_term' = 'QRA (Quantitative Risk Assessment) Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'IFRA Restriction Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'prohibited|specification|restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `risk_assessment_reference` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `safety_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Safety Margin Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Fragrance Supplier Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `usage_level_unit` SET TAGS ('dbx_business_glossary_term' = 'Usage Level Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ALTER COLUMN `usage_level_unit` SET TAGS ('dbx_value_regex' = 'percentage|ppm|mg/kg');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` SET TAGS ('dbx_subdomain' = 'submission_tracking');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `surveillance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Surveillance Event Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Surveillance Event Investigation Assigned To Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `surveillance_reported_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `surveillance_reported_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `surveillance_reported_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `action_taken` SET TAGS ('dbx_business_glossary_term' = 'Action Taken');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `surveillance_event_code` SET TAGS ('dbx_business_glossary_term' = 'Surveillance Event Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `consumer_complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Consumer Complaint Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `surveillance_event_description` SET TAGS ('dbx_business_glossary_term' = 'Surveillance Event Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `event_occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Event Occurrence Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `event_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Received Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `event_reference` SET TAGS ('dbx_business_glossary_term' = 'Event Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Surveillance Event Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Surveillance Event Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'adverse_event|consumer_complaint|retailer_report|regulatory_inquiry|social_media_signal|quality_defect');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Product Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `financial_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Estimate');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `financial_impact_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `geographic_market` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}(|[A-Z]{3})*$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `geographic_market` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `geographic_market` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `injury_description` SET TAGS ('dbx_business_glossary_term' = 'Injury Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `injury_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `injury_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Injury Reported Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `medical_treatment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Treatment Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `medical_treatment_required_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `medical_treatment_required_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `surveillance_event_name` SET TAGS ('dbx_business_glossary_term' = 'Surveillance Event Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `recall_classification` SET TAGS ('dbx_business_glossary_term' = 'Recall Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `recall_classification` SET TAGS ('dbx_value_regex' = 'class_I|class_II|class_III|market_withdrawal|not_applicable');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `recall_initiated_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Initiated Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `regulatory_report_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `regulatory_report_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `regulatory_report_reference_number` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `regulatory_report_reference_number` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `regulatory_report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submission Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `regulatory_report_submission_date` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `regulatory_report_submission_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Report Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Reportable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `reporter_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Reporter Contact Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `reporter_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `reporter_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `reporter_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `reporter_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Reporter Contact Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `reporter_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `reporter_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `reporter_name` SET TAGS ('dbx_business_glossary_term' = 'Reporter Full Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `reporter_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `reporter_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `root_cause_identified` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Identified');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `severity_classification` SET TAGS ('dbx_business_glossary_term' = 'Event Severity Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `severity_classification` SET TAGS ('dbx_value_regex' = 'critical|major|moderate|minor|informational');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `signal_source` SET TAGS ('dbx_business_glossary_term' = 'Signal Source Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Source');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `surveillance_event_status` SET TAGS ('dbx_business_glossary_term' = 'Surveillance Event Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `surveillance_number` SET TAGS ('dbx_business_glossary_term' = 'Surveillance Event Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `surveillance_number` SET TAGS ('dbx_value_regex' = '^PMS-[0-9]{8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `units_affected_estimate` SET TAGS ('dbx_business_glossary_term' = 'Units Affected Estimate');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` SET TAGS ('dbx_subdomain' = 'submission_tracking');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `product_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Coordinator Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `product_responsible_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `product_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `product_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `affected_channels` SET TAGS ('dbx_business_glossary_term' = 'Affected Distribution Channels');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `affected_countries` SET TAGS ('dbx_business_glossary_term' = 'Affected Countries');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `affected_gtin_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Global Trade Item Number (GTIN) List');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `affected_lot_batch_numbers` SET TAGS ('dbx_business_glossary_term' = 'Affected Lot or Batch Numbers');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `affected_lot_codes` SET TAGS ('dbx_business_glossary_term' = 'Affected Lot Codes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `affected_production_date_range_end` SET TAGS ('dbx_business_glossary_term' = 'Affected Production Date Range End');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `affected_production_date_range_start` SET TAGS ('dbx_business_glossary_term' = 'Affected Production Date Range Start');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `affected_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Stock Keeping Unit (SKU) List');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `affected_states_provinces` SET TAGS ('dbx_business_glossary_term' = 'Affected States or Provinces');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `authority_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Authority Notification Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `product_recall_code` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `consumer_hotline_number` SET TAGS ('dbx_business_glossary_term' = 'Consumer Hotline Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `consumer_remedy_instructions` SET TAGS ('dbx_business_glossary_term' = 'Consumer Remedy Instructions');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `consumer_remedy_type` SET TAGS ('dbx_business_glossary_term' = 'Consumer Remedy Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `consumer_remedy_type` SET TAGS ('dbx_value_regex' = 'Full Refund|Replacement|Repair|Credit|Disposal Instructions|No Remedy');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `corrective_action_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `product_recall_description` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `effectiveness_check_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `effectiveness_check_result` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Result');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `effectiveness_check_result` SET TAGS ('dbx_value_regex' = 'Effective|Partially Effective|Ineffective|Pending');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `estimated_financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `estimated_financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `health_hazard_evaluation` SET TAGS ('dbx_business_glossary_term' = 'Health Hazard Evaluation');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `health_hazard_evaluation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `health_hazard_evaluation` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Initiation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `product_recall_name` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `press_release_reference` SET TAGS ('dbx_business_glossary_term' = 'Press Release Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `product_recall_status` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `public_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `quantity_recalled_units` SET TAGS ('dbx_business_glossary_term' = 'Quantity Recalled Units');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `quantity_recovered_units` SET TAGS ('dbx_business_glossary_term' = 'Quantity Recovered Units');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_class` SET TAGS ('dbx_business_glossary_term' = 'Recall Class');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_classification` SET TAGS ('dbx_business_glossary_term' = 'Recall Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_classification` SET TAGS ('dbx_value_regex' = 'Class I|Class II|Class III|Voluntary|Market Withdrawal');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_coordinator_email` SET TAGS ('dbx_business_glossary_term' = 'Recall Coordinator Email');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_coordinator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_coordinator_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_coordinator_email` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_coordinator_email` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_coordinator_phone` SET TAGS ('dbx_business_glossary_term' = 'Recall Coordinator Phone');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_coordinator_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_coordinator_phone` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_coordinator_phone` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_effectiveness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Recall Effectiveness Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Initiation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_reason` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_scope` SET TAGS ('dbx_business_glossary_term' = 'Recall Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_scope` SET TAGS ('dbx_value_regex' = 'National|Regional|State|International|Global');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_status` SET TAGS ('dbx_value_regex' = 'Initiated|Ongoing|Completed|Terminated|Pending');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_type` SET TAGS ('dbx_business_glossary_term' = 'Recall Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_type` SET TAGS ('dbx_value_regex' = 'Consumer Level|Retail Level|Wholesale Level|Manufacturing Level');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `recall_website_url` SET TAGS ('dbx_business_glossary_term' = 'Recall Website Uniform Resource Locator (URL)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `root_cause_analysis_reference` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `units_affected` SET TAGS ('dbx_business_glossary_term' = 'Units Affected');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `units_recovered` SET TAGS ('dbx_business_glossary_term' = 'Units Recovered');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` SET TAGS ('dbx_subdomain' = 'obligation_management');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `parent_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Jurisdiction Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `animal_testing_ban_flag` SET TAGS ('dbx_business_glossary_term' = 'Animal Testing Ban Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `cfr_reference` SET TAGS ('dbx_business_glossary_term' = 'Code of Federal Regulations (CFR) Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Contact Email');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `contact_email` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Contact Phone');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `contact_phone` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `jurisdiction_description` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `gmp_compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `ifra_compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'International Fragrance Association (IFRA) Compliance Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `ingredient_declaration_format` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Declaration Format');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `ingredient_declaration_format` SET TAGS ('dbx_value_regex' = 'inci|cas|common_name|proprietary');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `jurisdiction_status` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `jurisdiction_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `jurisdiction_type` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `jurisdiction_type` SET TAGS ('dbx_value_regex' = 'national|regional|supranational|state|provincial|municipal');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `labeling_language_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Labeling Language');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `labeling_language_primary` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `labeling_language_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Labeling Language(s)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `jurisdiction_level` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Level');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `market_entry_requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Market Entry Requirement Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `market_entry_requirement_type` SET TAGS ('dbx_value_regex' = 'notification|registration|pre-market_approval|post-market_surveillance|voluntary');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `jurisdiction_name` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `post_market_surveillance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Market Surveillance Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `pre_market_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Market Approval Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `product_information_file_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Product Information File (PIF) Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `reach_registration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Registration Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `registration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `responsible_person_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `sds_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `submission_portal_url` SET TAGS ('dbx_business_glossary_term' = 'Submission Portal Uniform Resource Locator (URL)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Website Uniform Resource Locator (URL)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` SET TAGS ('dbx_subdomain' = 'substance_control');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `restricted_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Restricted Substance ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `affected_product_categories` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Categories');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `alternative_substance_recommendations` SET TAGS ('dbx_business_glossary_term' = 'Alternative Substance Recommendations');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `applicable_regulations` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulations');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `applicable_regulations` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `applicable_regulations` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `authorization_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|granted|denied|expired|withdrawn');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `cfr_reference` SET TAGS ('dbx_business_glossary_term' = 'Code of Federal Regulations (CFR) Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `restricted_substance_code` SET TAGS ('dbx_business_glossary_term' = 'Restricted Substance Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments or Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_business_glossary_term' = 'Concentration Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_value_regex' = 'percent_weight|percent_volume|ppm|ppb|mg_per_kg');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `restricted_substance_description` SET TAGS ('dbx_business_glossary_term' = 'Restricted Substance Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `downstream_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Downstream User Notification Required');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `ec_number` SET TAGS ('dbx_business_glossary_term' = 'European Community (EC) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `ec_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{3}-[0-9]$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Restriction Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `epa_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Restricted Chemical Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `fda_prohibited_flag` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Prohibited Ingredient Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Hazard Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `ifra_prohibition_category` SET TAGS ('dbx_business_glossary_term' = 'IFRA Prohibition or Restriction Category');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `ifra_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'International Fragrance Association (IFRA) Standard Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Regulatory Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `max_allowed_concentration_pct` SET TAGS ('dbx_business_glossary_term' = 'Max Allowed Concentration Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `maximum_permitted_concentration` SET TAGS ('dbx_business_glossary_term' = 'Maximum Permitted Concentration');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `restricted_substance_name` SET TAGS ('dbx_business_glossary_term' = 'Restricted Substance Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team or Department');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `post_market_surveillance_required` SET TAGS ('dbx_business_glossary_term' = 'Post-Market Surveillance Required');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `product_category_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Category Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `prohibition_flag` SET TAGS ('dbx_business_glossary_term' = 'Prohibition Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `prop_65_listing` SET TAGS ('dbx_business_glossary_term' = 'California Proposition 65 Listing');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Registration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `regulation_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulation Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `regulation_reference` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `regulation_reference` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Primary Regulatory Authority');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `restricted_substance_status` SET TAGS ('dbx_business_glossary_term' = 'Restricted Substance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `restriction_basis` SET TAGS ('dbx_business_glossary_term' = 'Restriction Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `restriction_scope` SET TAGS ('dbx_business_glossary_term' = 'Restriction Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'banned|concentration_limit|disclosure_required|authorization_required|restricted_use|conditional_approval');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `rspo_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Roundtable on Sustainable Palm Oil (RSPO) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `sds_required` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Required');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `substance_name` SET TAGS ('dbx_business_glossary_term' = 'Substance Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `sunset_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Sunset Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `svhc_status` SET TAGS ('dbx_business_glossary_term' = 'Substance of Very High Concern (SVHC) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `tonnage_band` SET TAGS ('dbx_business_glossary_term' = 'Tonnage Band');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `tonnage_band` SET TAGS ('dbx_value_regex' = '1_to_10|10_to_100|100_to_1000|above_1000|not_applicable');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`restricted_substance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` SET TAGS ('dbx_subdomain' = 'label_integrity');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` SET TAGS ('dbx_ssot_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` SET TAGS ('dbx_ssot_concept' = 'claim');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` SET TAGS ('dbx_ssot' = 'secondary');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` SET TAGS ('dbx_ssot_canonical' = 'product.product_claim');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` SET TAGS ('dbx_ssot_role' = 'primary');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` SET TAGS ('dbx_ssot_status' = 'authoritative');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Claim ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_claim_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_claim_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `product_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `product_brand_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_compliance_reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Claim Compliance Reviewer Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_compliance_reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_compliance_reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `product_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Product Claim Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `product_claim_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `adverse_event_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Reporting Required');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `approved_markets` SET TAGS ('dbx_business_glossary_term' = 'Approved Markets');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `cfr_reference` SET TAGS ('dbx_business_glossary_term' = 'Code of Federal Regulations (CFR) Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `claim_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_value_regex' = '^RC-[0-9]{8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `claim_scope` SET TAGS ('dbx_business_glossary_term' = 'Claim Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `claim_scope` SET TAGS ('dbx_value_regex' = 'product_specific|brand_level|category_level|ingredient_specific');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|expired|withdrawn');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `claim_text` SET TAGS ('dbx_business_glossary_term' = 'Claim Text');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_claim_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Claim Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_claim_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_claim_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `compliance_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Outcome');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `compliance_review_outcome` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|requires_modification|pending_review|not_reviewed');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_claim_description` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Claim Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_claim_description` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_claim_description` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `disclaimer_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Disclaimer Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `disclaimer_text` SET TAGS ('dbx_business_glossary_term' = 'Disclaimer Text');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `eu_regulation_reference` SET TAGS ('dbx_business_glossary_term' = 'European Union (EU) Regulation Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `eu_regulation_reference` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `eu_regulation_reference` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `ifra_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'International Fragrance Association (IFRA) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_claim_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Claim Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_claim_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_claim_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `post_market_surveillance_required` SET TAGS ('dbx_business_glossary_term' = 'Post-Market Surveillance Required');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_claim_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Claim Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_claim_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_claim_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency Months');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `substantiation_method` SET TAGS ('dbx_business_glossary_term' = 'Substantiation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `supporting_study_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Study Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `third_party_certification` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `usage_restriction` SET TAGS ('dbx_business_glossary_term' = 'Usage Restriction');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` SET TAGS ('dbx_subdomain' = 'submission_tracking');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `action_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Action Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `compliance_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `primary_regulatory_action_responsible_party_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Action Responsible Party Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `primary_regulatory_action_responsible_party_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `primary_regulatory_action_responsible_party_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `primary_regulatory_action_responsible_party_employee_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `primary_regulatory_action_responsible_party_employee_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `surveillance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Surveillance Event Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `action_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Action Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Action Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `action_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Action Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Action Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `affected_facility_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Facility List');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `affected_product_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Product List');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `audit_completion_date` SET TAGS ('dbx_business_glossary_term' = 'External Audit Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `board_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Board of Directors Notification Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `board_notification_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `citation_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Citation Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `action_code` SET TAGS ('dbx_business_glossary_term' = 'Action Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Internal Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `corrective_action_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `corrective_action_plan_reference` SET TAGS ('dbx_value_regex' = '^CAP-[A-Z0-9-]{6,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `action_description` SET TAGS ('dbx_business_glossary_term' = 'Action Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Executive Escalation Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `external_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'External Audit Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `external_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `external_auditor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `financial_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Penalty Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `financial_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `insurance_claim_reference` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `insurance_claim_reference` SET TAGS ('dbx_value_regex' = '^INS-[A-Z0-9-]{6,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `insurance_claim_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Regulatory Authority');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}(-[A-Z0-9]{2,4})?$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `legal_counsel_assigned` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Assigned');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `legal_counsel_assigned` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `action_name` SET TAGS ('dbx_business_glossary_term' = 'Action Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `previous_action_reference` SET TAGS ('dbx_business_glossary_term' = 'Previous Action Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `previous_action_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `public_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `public_disclosure_url` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Uniform Resource Locator (URL)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `public_disclosure_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `recall_class` SET TAGS ('dbx_business_glossary_term' = 'Recall Classification Class');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `recall_class` SET TAGS ('dbx_value_regex' = 'class_i|class_ii|class_iii');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `recall_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Action Received Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `repeat_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Violation Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `repeat_violation_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `repeat_violation_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Action Resolution Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Risk Score');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Violation Severity Level');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor|observation');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `violation_category` SET TAGS ('dbx_business_glossary_term' = 'Violation Category');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `violation_category` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ALTER COLUMN `violation_category` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` SET TAGS ('dbx_subdomain' = 'submission_tracking');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `cpsc_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Product Safety Commission (CPSC) Filing ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Filed By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `cpsc_submitted_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `cpsc_submitted_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `cpsc_submitted_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `product_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Certificate Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `cpsc_filing_code` SET TAGS ('dbx_business_glossary_term' = 'Cpsc Filing Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `corrective_action_type` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `cpsc_case_number` SET TAGS ('dbx_business_glossary_term' = 'CPSC Case Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `cpsc_case_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[A-Z0-9]{4,8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `cpsc_filing_status` SET TAGS ('dbx_business_glossary_term' = 'Cpsc Filing Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `cpsc_response_description` SET TAGS ('dbx_business_glossary_term' = 'CPSC Response Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `cpsc_response_received_date` SET TAGS ('dbx_business_glossary_term' = 'CPSC Response Received Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `cpsc_response_type` SET TAGS ('dbx_business_glossary_term' = 'CPSC Response Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `cpsc_response_type` SET TAGS ('dbx_value_regex' = 'accepted|additional_info_requested|recall_required|no_action_required|under_investigation|closed');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `cpsc_filing_description` SET TAGS ('dbx_business_glossary_term' = 'Cpsc Filing Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `fatality_count` SET TAGS ('dbx_business_glossary_term' = 'Fatality Count');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'CPSC Filing Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_value_regex' = '^CPSC-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_value_regex' = 'section_15b_report|incident_report|saferproducts_submission|voluntary_corrective_action|recall_notification|follow_up_report');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `hazard_category` SET TAGS ('dbx_business_glossary_term' = 'Hazard Category');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `hazard_description` SET TAGS ('dbx_business_glossary_term' = 'Hazard Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `hazard_type` SET TAGS ('dbx_business_glossary_term' = 'Hazard Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `incident_count` SET TAGS ('dbx_business_glossary_term' = 'Incident Count');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `incident_report_count` SET TAGS ('dbx_business_glossary_term' = 'Incident Report Count');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `injury_count` SET TAGS ('dbx_business_glossary_term' = 'Injury Count');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `injury_description` SET TAGS ('dbx_business_glossary_term' = 'Injury Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `injury_severity` SET TAGS ('dbx_business_glossary_term' = 'Injury Severity');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `injury_severity` SET TAGS ('dbx_value_regex' = 'none|minor|moderate|serious|life_threatening|fatal');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `knowledge_date` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `legal_review_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `legal_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `lot_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Lot or Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `manufacturing_date_range_end` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date Range End');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `manufacturing_date_range_start` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date Range Start');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `cpsc_filing_name` SET TAGS ('dbx_business_glossary_term' = 'Cpsc Filing Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `population_at_risk` SET TAGS ('dbx_business_glossary_term' = 'Population at Risk');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `population_at_risk` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `population_at_risk` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `product_model_number` SET TAGS ('dbx_business_glossary_term' = 'Product Model Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `recall_announced_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Announced Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `recall_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Announcement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Email');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `saferproducts_report_number` SET TAGS ('dbx_business_glossary_term' = 'SaferProducts.gov Report ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `submitted_by_email` SET TAGS ('dbx_business_glossary_term' = 'Submitted By Email');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `submitted_by_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `submitted_by_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `submitted_by_email` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `submitted_by_email` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `submitted_by_name` SET TAGS ('dbx_business_glossary_term' = 'Submitted By Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `supporting_document_count` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Count');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `tracking_label_text` SET TAGS ('dbx_business_glossary_term' = 'Tracking Label Text');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `units_affected` SET TAGS ('dbx_business_glossary_term' = 'Units Affected');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `units_sold` SET TAGS ('dbx_business_glossary_term' = 'Units Sold');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ALTER COLUMN `vault_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Vault Reference ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` SET TAGS ('dbx_subdomain' = 'registration_compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `epa_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Registration ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `active_ingredient` SET TAGS ('dbx_business_glossary_term' = 'Active Ingredient');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `active_ingredient_list` SET TAGS ('dbx_business_glossary_term' = 'Active Ingredient List');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `active_ingredient_percentage` SET TAGS ('dbx_business_glossary_term' = 'Active Ingredient Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'EPA Registration Cancellation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'EPA Registration Cancellation Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `epa_registration_code` SET TAGS ('dbx_business_glossary_term' = 'Epa Registration Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Registration Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `company_number` SET TAGS ('dbx_business_glossary_term' = 'EPA Company Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `company_number` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `data_call_in_due_date` SET TAGS ('dbx_business_glossary_term' = 'Data Call-In Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `data_call_in_requirement` SET TAGS ('dbx_business_glossary_term' = 'EPA Data Call-In Requirement');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `epa_registration_description` SET TAGS ('dbx_business_glossary_term' = 'Epa Registration Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `epa_establishment_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Establishment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `epa_establishment_number` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[A-Z]{2}-[0-9]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `epa_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Registration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `epa_registration_number` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{1,5}(-[0-9]{1,5})?$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `epa_registration_status` SET TAGS ('dbx_business_glossary_term' = 'Epa Registration Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `establishment_number` SET TAGS ('dbx_business_glossary_term' = 'Establishment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `formulation_type` SET TAGS ('dbx_business_glossary_term' = 'Product Formulation Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `formulation_type` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `formulation_type` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `label_approval_date` SET TAGS ('dbx_business_glossary_term' = 'EPA Label Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `label_approval_status` SET TAGS ('dbx_business_glossary_term' = 'EPA Label Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `label_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending_review|conditionally_approved|rejected|revision_required');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `label_version` SET TAGS ('dbx_business_glossary_term' = 'EPA Label Version');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `epa_registration_name` SET TAGS ('dbx_business_glossary_term' = 'Epa Registration Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `next_renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `product_brand_name` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'EPA Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Registered Product Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `registrant_name` SET TAGS ('dbx_business_glossary_term' = 'EPA Registrant Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'EPA Registration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `registration_review_case_number` SET TAGS ('dbx_business_glossary_term' = 'EPA Registration Review Case Number');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `registration_review_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Review Decision Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'EPA Registration Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'EPA Registration Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `reregistration_eligibility_decision` SET TAGS ('dbx_business_glossary_term' = 'Reregistration Eligibility Decision (RED)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `reregistration_eligibility_decision` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending|not_applicable');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `signal_word` SET TAGS ('dbx_business_glossary_term' = 'EPA Signal Word');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `signal_word` SET TAGS ('dbx_value_regex' = 'danger|warning|caution|none');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `target_pest_list` SET TAGS ('dbx_business_glossary_term' = 'Target Pest List');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `use_classification` SET TAGS ('dbx_business_glossary_term' = 'EPA Use Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `use_classification` SET TAGS ('dbx_value_regex' = 'general|restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `use_site_description` SET TAGS ('dbx_business_glossary_term' = 'Use Site Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ALTER COLUMN `vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Vault Document Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` SET TAGS ('dbx_subdomain' = 'obligation_management');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change ID');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `change_requested_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `change_requested_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `change_requested_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `primary_regulatory_change_responsible_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Responsible Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `primary_regulatory_change_responsible_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `primary_regulatory_change_responsible_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `primary_regulatory_change_responsible_owner_employee_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `primary_regulatory_change_responsible_owner_employee_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `superseded_change_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Change Id');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `superseded_change_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `affected_product_category` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `affected_product_scope` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `change_category` SET TAGS ('dbx_value_regex' = 'safety|labeling|environment|composition|marketing|manufacturing');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `change_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Number (RCN)');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `change_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `change_status` SET TAGS ('dbx_value_regex' = 'active|closed|archived');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Type');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'new|amendment|repeal|guidance');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `change_code` SET TAGS ('dbx_business_glossary_term' = 'Change Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `compliance_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Compliance Risk Level');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `compliance_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Description');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `impact_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `impact_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `impact_assessment_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `impact_severity` SET TAGS ('dbx_business_glossary_term' = 'Impact Severity');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `impact_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `implementation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `implementation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `implementation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|deferred');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Initiated Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `change_name` SET TAGS ('dbx_business_glossary_term' = 'Change Name');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Change Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `regulatory_impact` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `regulatory_impact` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `regulatory_impact` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Date');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `required_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Required Action Deadline');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Change Source');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `source_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Source Authority');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `source_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Source Body');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `submission_required` SET TAGS ('dbx_business_glossary_term' = 'Submission Required');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Title');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Change URL');
