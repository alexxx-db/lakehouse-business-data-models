-- Schema for Domain: design | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:09:56

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`design` COMMENT 'Engineering and design domain owning BIM models, CAD drawings, technical specifications, design packages, RFIs, submittals, clash detection, document control registers, transmittals, correspondence, workflow approvals, and handover documentation for construction projects';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`correspondence` (
    `correspondence_id` BIGINT COMMENT 'Unique identifier for the correspondence record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Needed for Contract Correspondence Register report linking each correspondence to its governing agreement for audit and legal compliance.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project this correspondence belongs to.',
    `parent_correspondence_id` BIGINT COMMENT 'Reference to the parent correspondence record if this item is part of a threaded response chain. Nullable for root correspondence items.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Required for client communication log linking each sent correspondence to the originating client account.',
    `attachment_count` STRING COMMENT 'Number of document attachments associated with this correspondence item (drawings, specifications, photos, reports).',
    `body_text` STRING COMMENT 'Full text content of the correspondence message or letter body.',
    `closure_date` DATE COMMENT 'The date the correspondence thread was formally closed. Nullable if still open.',
    `closure_status` STRING COMMENT 'Final closure status indicating whether the correspondence thread was accepted, rejected, or superseded by subsequent correspondence.. Valid values are `open|closed_accepted|closed_rejected|closed_superseded`',
    `confidential_flag` BOOLEAN COMMENT 'Boolean indicator whether this correspondence is marked as confidential and subject to restricted access controls.',
    `correspondence_date` DATE COMMENT 'The date the correspondence was officially issued or sent. This is the principal business event timestamp for the correspondence lifecycle.',
    `correspondence_number` STRING COMMENT 'Externally-known unique business identifier for the correspondence item as registered in the Aconex mail register. This is the official reference number used in contractual communications.. Valid values are `^[A-Z0-9-]+$`',
    `correspondence_status` STRING COMMENT 'Current lifecycle status of the correspondence item tracking its workflow state from draft through closure.. Valid values are `draft|issued|acknowledged|responded|closed|cancelled`',
    `correspondence_type` STRING COMMENT 'Classification of the correspondence item. RFI (Request for Information), instruction, notice, claim, letter, or memo.. Valid values are `rfi|instruction|notice|claim|letter|memo`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this correspondence record was first created in the document management system.',
    `discipline` STRING COMMENT 'Engineering or construction discipline to which this correspondence relates (civil, structural, MEP, architectural, etc.). [ENUM-REF-CANDIDATE: civil|structural|mechanical|electrical|architectural|plumbing|general — 7 candidates stripped; promote to reference product]',
    `distribution_list` STRING COMMENT 'Comma-separated list of additional parties or roles who were copied on this correspondence for information or action.',
    `modified_by` STRING COMMENT 'Username or identifier of the system user who last modified this correspondence record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this correspondence record was last modified or updated.',
    `priority` STRING COMMENT 'Priority level assigned to the correspondence indicating urgency of response or action required.. Valid values are `urgent|high|normal|low`',
    `received_date` DATE COMMENT 'The date the correspondence was received and registered in the document management system.',
    `recipient_email` STRING COMMENT 'Email address of the recipient for correspondence delivery and acknowledgment.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_name` STRING COMMENT 'Full name of the individual who is the intended recipient of the correspondence.',
    `recipient_organization` STRING COMMENT 'Name of the organization receiving the correspondence (contractor, client, consultant, subcontractor, or authority).',
    `response_date` DATE COMMENT 'The date a formal response was issued for this correspondence. Nullable if no response has been provided.',
    `response_due_date` DATE COMMENT 'The contractual or agreed date by which a response to this correspondence must be provided. Nullable if no response is required.',
    `response_method` STRING COMMENT 'The method or channel through which the response was delivered (email, formal letter, transmittal, meeting minutes, phone call).. Valid values are `email|letter|transmittal|meeting|phone`',
    `response_required_flag` BOOLEAN COMMENT 'Boolean indicator whether a formal response is required for this correspondence.',
    `response_text` STRING COMMENT 'Full text content of the response provided to this correspondence. Nullable if no response has been issued.',
    `sender_email` STRING COMMENT 'Email address of the sender for correspondence tracking and response routing.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sender_name` STRING COMMENT 'Full name of the individual who authored or sent the correspondence.',
    `subject` STRING COMMENT 'Subject line or title of the correspondence describing the topic or issue being communicated.',
    `transmittal_number` STRING COMMENT 'Reference number of the transmittal document if this correspondence was sent via formal transmittal. Nullable if sent directly.',
    `wbs_code` STRING COMMENT 'Work Breakdown Structure code linking the correspondence to a specific project work package or deliverable.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this correspondence record.',
    CONSTRAINT pk_correspondence PRIMARY KEY(`correspondence_id`)
) COMMENT 'Master register of all formal project correspondence including letters, emails, notices, and official communications managed through Aconex mail register. Tracks sender, recipient, subject, correspondence type (RFI, instruction, notice, claim), priority, response required flag, response due date, current status, response thread history with full response chain (response date, content, method, closure status), and parent-child threading. Serves as the authoritative SSOT for all project correspondence and response chains across contractors, clients, consultants, and authorities, providing the contractual audit trail required under FIDIC and NEC contract forms.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`transmittal` (
    `transmittal_id` BIGINT COMMENT 'Unique identifier for the transmittal record. Primary key for the transmittal entity.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract or agreement under which this transmittal is issued. Links document distribution to contractual obligations and scope.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this transmittal is issued. Links transmittal to the parent project context.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Transmittal creation is performed by an employee; required for traceability of document distribution.',
    `phase_id` BIGINT COMMENT 'Reference to the project phase or stage during which this transmittal is issued. Provides temporal context within the project lifecycle.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Transmittal origin must be linked to the client account for contract document tracking and regulatory filing.',
    `acknowledgement_by` STRING COMMENT 'Full name of the individual who provided formal acknowledgement on behalf of the recipient organization. Establishes personal accountability for receipt confirmation.',
    `acknowledgement_date` DATE COMMENT 'The date when the recipient formally acknowledged receipt of the transmittal. Null if not yet acknowledged. Provides legally defensible proof of document delivery.',
    `acknowledgement_required_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether the recipient is required to formally acknowledge receipt of the transmittal. True indicates acknowledgement is mandatory.',
    `acknowledgement_status` STRING COMMENT 'Current status of recipient acknowledgement tracking. Indicates whether the transmittal has been formally acknowledged by the recipient organization.. Valid values are `pending|acknowledged|overdue|not_required`',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions applicable to the transmittal and its enclosed documents.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transmittal record was first created in the system. Provides audit trail for record origination.',
    `delivery_method` STRING COMMENT 'The method or channel used to physically or electronically deliver the transmittal to the recipient. Tracks distribution logistics.. Valid values are `electronic|courier|hand_delivery|postal_mail|ftp|portal`',
    `transmittal_description` STRING COMMENT 'Detailed narrative description of the transmittal contents, context, and any special instructions or notes for the recipient. Provides comprehensive background information.',
    `discipline` STRING COMMENT 'The primary engineering or design discipline to which the transmittal documents belong. Categorizes transmittals by technical specialization for routing and review. [ENUM-REF-CANDIDATE: architectural|structural|mechanical|electrical|plumbing|civil|geotechnical|environmental — 8 candidates stripped; promote to reference product]',
    `document_count` STRING COMMENT 'Total number of individual documents or drawings included in this transmittal package. Used for completeness verification and audit trail.',
    `due_date` DATE COMMENT 'The date by which the recipient is expected to respond or take action on the transmittal, particularly relevant for approval or review purposes. Null if no response deadline applies.',
    `issue_date` DATE COMMENT 'The date when the transmittal was formally issued and dispatched to the recipient organization. Represents the principal business event timestamp for document distribution.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the transmittal record was last modified or updated. Tracks the most recent change to the record for audit and version control purposes.',
    `priority` STRING COMMENT 'Priority level assigned to the transmittal indicating the urgency of review or response required from the recipient. Guides workflow prioritization.. Valid values are `urgent|high|normal|low`',
    `purpose_of_issue` STRING COMMENT 'The intended purpose or action required from the recipient upon receiving the transmittal. Defines the business intent behind the document distribution and guides recipient response obligations.. Valid values are `for_approval|for_information|for_construction|for_record|for_review|for_comment`',
    `recipient_contact_name` STRING COMMENT 'Full name of the individual within the recipient organization designated to receive and acknowledge the transmittal.',
    `recipient_email` STRING COMMENT 'Email address of the recipient contact for delivery confirmation and acknowledgement of the transmittal.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_organization` STRING COMMENT 'Name of the organization or company receiving the transmittal. Identifies the party to whom the documents are being dispatched.',
    `reference_transmittal_number` STRING COMMENT 'Transmittal number of a previous or related transmittal that this transmittal references, supersedes, or responds to. Establishes document lineage and traceability.',
    `remarks` STRING COMMENT 'Additional notes, comments, or special instructions related to the transmittal that do not fit in other structured fields. Provides supplementary context.',
    `revision_number` STRING COMMENT 'Revision identifier for the transmittal itself if it has been reissued or updated. Tracks version history of the transmittal record.. Valid values are `^[A-Z0-9.]+$`',
    `sender_contact_name` STRING COMMENT 'Full name of the individual within the sender organization who prepared and issued the transmittal. Provides personal accountability for document distribution.',
    `sender_email` STRING COMMENT 'Email address of the sender contact for correspondence and queries related to the transmittal.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `subject` STRING COMMENT 'Brief descriptive title or subject line summarizing the content and purpose of the transmittal. Provides quick context for document package identification.',
    `transmittal_number` STRING COMMENT 'Unique business identifier for the transmittal as recognized by all project parties. Typically follows project-specific numbering conventions and serves as the externally-known reference for document distribution tracking.. Valid values are `^[A-Z0-9-]+$`',
    `transmittal_status` STRING COMMENT 'Current lifecycle status of the transmittal indicating its position in the document distribution workflow. Tracks progression from draft through issuance to acknowledgement or closure.. Valid values are `draft|issued|acknowledged|rejected|superseded|closed`',
    CONSTRAINT pk_transmittal PRIMARY KEY(`transmittal_id`)
) COMMENT 'Records the formal dispatch of documents, drawings, and submittals between project parties via Aconex transmittals. Captures transmittal number, issue date, sender organization, recipient organization, purpose of issue (for approval, for information, for construction, for record), document list, and acknowledgement status. Provides a legally defensible audit trail of document distribution throughout the project lifecycle.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`rfi` (
    `rfi_id` BIGINT COMMENT 'Primary key for rfi',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Supports RFI‑to‑Agreement traceability required in the RFI Management Process and impact assessment on contract scope.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this RFI belongs.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: RFI is raised by a craft worker on site to request clarification; linking captures who raised it (RFI Management Process).',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: RFIs may result in cost changes; linking each RFI to the relevant cost code enables cost impact analysis.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: RFI response workflow requires tracking which subcontractor firm the RFI is addressed to for accountability and response time metrics.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: RFI originator employee is required for accountability and response tracking.',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: RFIs often seek clarification of specific permit conditions; linking RFI to the condition it addresses enables compliance tracking.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element or work package to which this RFI is associated for cost and schedule tracking.',
    `actual_response_date` DATE COMMENT 'The actual date on which the RFI response was provided and recorded in the system.',
    `closure_date` DATE COMMENT 'The date on which the RFI was formally closed after response acceptance and any required follow-up actions were completed.',
    `closure_notes` STRING COMMENT 'Additional notes or comments recorded at the time of RFI closure, documenting final resolution or outstanding items.',
    `cost_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact (in project currency) resulting from the RFI clarification, if applicable.',
    `cost_impact_flag` BOOLEAN COMMENT 'Indicates whether the RFI response has identified a potential cost impact to the project, triggering change order evaluation.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this RFI record was first created in the data platform.',
    `date_raised` DATE COMMENT 'The date on which the RFI was formally submitted or raised in the project management system.',
    `rfi_description` STRING COMMENT 'Detailed description of the question, issue, or clarification being requested, including context and specific areas of concern.',
    `discipline` STRING COMMENT 'The engineering or design discipline to which this RFI pertains (e.g., architectural, structural, MEP). [ENUM-REF-CANDIDATE: architectural|structural|mechanical|electrical|plumbing|civil|geotechnical — 7 candidates stripped; promote to reference product]',
    `external_reference_code` STRING COMMENT 'The unique identifier of this RFI in the source system, used for traceability and reconciliation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this RFI record was last updated in the data platform, supporting audit trail and change tracking.',
    `linked_drawing_reference` STRING COMMENT 'Reference number or identifier of the CAD drawing or BIM model element to which this RFI relates.',
    `linked_specification_reference` STRING COMMENT 'Reference to the technical specification section or clause that is the subject of the RFI.',
    `priority` STRING COMMENT 'Priority level assigned to the RFI indicating urgency and impact on project schedule or critical path.. Valid values are `low|medium|high|critical`',
    `response_content` STRING COMMENT 'Detailed text of the response provided by the addressee, including clarifications, instructions, or references to supporting documentation.',
    `response_due_date` DATE COMMENT 'The contractual or agreed-upon date by which a response to the RFI is required, often tied to project schedule milestones.',
    `response_time_days` STRING COMMENT 'Calculated number of calendar days between date raised and actual response date, used for performance tracking and SLA compliance.',
    `rfi_number` STRING COMMENT 'Business identifier for the RFI, typically a sequential or structured code used for tracking and reference in project documentation and correspondence.',
    `rfi_status` STRING COMMENT 'Current lifecycle status of the RFI indicating its position in the review and response workflow.. Valid values are `draft|open|pending_response|responded|closed|cancelled`',
    `schedule_impact_days` STRING COMMENT 'Estimated number of calendar days of schedule delay resulting from the RFI clarification, if applicable.',
    `schedule_impact_flag` BOOLEAN COMMENT 'Indicates whether the RFI response has identified a potential schedule impact, potentially triggering an Extension of Time (EOT) request.',
    `subject` STRING COMMENT 'Brief title or subject line summarizing the nature of the clarification request.',
    CONSTRAINT pk_rfi PRIMARY KEY(`rfi_id`)
) COMMENT 'Request for Information records capturing formal queries raised by contractors seeking clarification on design intent, specifications, or contract documents. Tracks RFI number, subject, discipline, originator, addressee, date raised, response due date, actual response date, response content, cost/schedule impact assessment, linked drawing or specification reference, and closure status. High-volume transactional entity critical for design coordination and contractual record-keeping. Sourced from Procore RFI module and Aconex.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`document_register` (
    `document_register_id` BIGINT COMMENT 'Unique identifier for the document register entry. Primary key for the document register product.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract under which this document was produced or to which it is a deliverable.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Document author employee is required for document control and audit trails.',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Permit Application requires linking each design document to the specific permit it satisfies for regulatory approval.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project this document belongs to.',
    `bid_contract_agreement_id` BIGINT COMMENT 'Foreign key linking to bid.contract_agreement. Business justification: Documents often belong to a subcontractor contract; FK supports contract‑based document control, retention, and regulatory reporting.',
    `rfi_id` BIGINT COMMENT 'Foreign key linking to design.rfi. Business justification: RFI is currently siloed; adding a foreign key from document_register to rfi creates an inbound link and removes the redundant string reference column.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element or work package this document supports or relates to.',
    `approval_date` DATE COMMENT 'Date when the document received formal approval from the designated approver.',
    `approver_name` STRING COMMENT 'Name of the individual who provided final approval for the document to be issued.',
    `confidentiality_classification` STRING COMMENT 'Security classification level of the document content determining access rights and distribution restrictions.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this document register record was first created in the system.',
    `discipline` STRING COMMENT 'Engineering or construction discipline responsible for the document. [ENUM-REF-CANDIDATE: civil|structural|architectural|mechanical|electrical|plumbing|instrumentation|controls|process|geotechnical|environmental|HSE|quality|project_management — promote to reference product]',
    `distribution_list` STRING COMMENT 'Comma-separated list of parties, roles, or organizations to whom this document should be distributed.',
    `document_number` STRING COMMENT 'Unique business identifier for the document following project numbering convention. This is the externally-known document reference used across all project communications and systems.',
    `document_purpose` STRING COMMENT 'Brief statement describing the intended use and purpose of the document within the project context.',
    `document_register_status` STRING COMMENT 'Current lifecycle status of the document in the approval and distribution workflow. [ENUM-REF-CANDIDATE: draft|in_review|approved|issued_for_construction|issued_for_information|issued_for_tender|superseded|archived|void|cancelled — promote to reference product]',
    `document_title` STRING COMMENT 'Full descriptive title of the document as it appears on the document itself.',
    `document_type` STRING COMMENT 'Classification of the document by its primary purpose and content type. [ENUM-REF-CANDIDATE: specification|report|procedure|method_statement|manual|certificate|correspondence|transmittal|inspection_plan|quality_plan|test_report|safety_plan|environmental_plan|commissioning_plan|handover_document|as_built_record|warranty|permit — promote to reference product]',
    `file_format` STRING COMMENT 'Digital file format of the document (e.g., PDF for specifications, DWG for CAD drawings, RVT for Revit models). [ENUM-REF-CANDIDATE: PDF|DOCX|XLSX|DWG|RVT|IFC|XML — 7 candidates stripped; promote to reference product]',
    `file_size_mb` DECIMAL(18,2) COMMENT 'Size of the document file in megabytes for storage and transmission planning.',
    `is_client_deliverable` BOOLEAN COMMENT 'Flag indicating whether this document is a contractual deliverable to the client requiring formal acceptance.',
    `is_controlled_document` BOOLEAN COMMENT 'Flag indicating whether this document is subject to formal change control procedures and requires approval for any modifications.',
    `issue_date` DATE COMMENT 'Date when the current revision of the document was formally issued or published.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags for document search and categorization purposes.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 code representing the primary language of the document content. [ENUM-REF-CANDIDATE: ENG|SPA|FRA|DEU|ARA|CHI|POR — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this document register record was last updated or modified.',
    `originator` STRING COMMENT 'Organization or party responsible for creating and issuing the document (e.g., design consultant, contractor, subcontractor, client).',
    `page_count` STRING COMMENT 'Total number of pages in the document for printing and review planning purposes.',
    `related_submittal_number` STRING COMMENT 'Submittal number if this document is part of or related to a formal submittal package.',
    `retention_period_years` STRING COMMENT 'Number of years the document must be retained per regulatory, contractual, or organizational requirements before eligible for disposal.',
    `review_due_date` DATE COMMENT 'Target date by which the document review must be completed to maintain project schedule.',
    `reviewer_name` STRING COMMENT 'Name of the individual who reviewed the document for technical accuracy and completeness.',
    `revision_description` STRING COMMENT 'Brief description of the changes made in the current revision compared to the previous version.',
    `revision_number` STRING COMMENT 'Current revision identifier of the document following project revision convention (e.g., A, B, C or 01, 02, 03 or R0, R1, R2).',
    `storage_location` STRING COMMENT 'Physical or digital location where the document is stored (e.g., Aconex folder path, SharePoint site, physical archive location).',
    `superseded_by_document_number` STRING COMMENT 'Document number of the newer document that supersedes this document, if applicable. Used to maintain document lineage and version control.',
    `supersedes_document_number` STRING COMMENT 'Document number of the older document that this document supersedes or replaces.',
    `transmittal_number` STRING COMMENT 'Reference number of the transmittal through which this document was formally issued or exchanged between parties.',
    CONSTRAINT pk_document_register PRIMARY KEY(`document_register_id`)
) COMMENT 'Central master register of all project documents beyond drawings — including specifications, reports, procedures, method statements, O&M manuals, certificates, and correspondence — managed in Aconex CDE (Common Data Environment). Captures document number, title, document type, discipline, revision, status, originator, issue date, confidentiality classification, retention period, and numbering convention. Provides the authoritative catalog of all project documentation per ISO 19650 information container requirements.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`revision` (
    `revision_id` BIGINT COMMENT 'Primary key for revision',
    `hr_employee_id` BIGINT COMMENT 'System identifier for the approver. Links to the workforce or user management system.',
    `document_register_id` BIGINT COMMENT 'Reference to the parent document in the document register. Links this revision to its master document record.',
    `primary_revision_employee_id` BIGINT COMMENT 'System identifier for the author. Links to the workforce or user management system.',
    `reviewer_employee_id` BIGINT COMMENT 'System identifier for the reviewer. Links to the workforce or user management system.',
    `superseded_revision_id` BIGINT COMMENT 'Reference to the previous revision that this version replaces. Maintains the revision chain and version history.',
    `approval_date` DATE COMMENT 'Date when this revision was officially approved for issuance. Represents a distinct lifecycle event in the approval workflow.',
    `approver_name` STRING COMMENT 'Full name of the individual who approved this revision for release. Authorized signatory for document issuance.',
    `author_name` STRING COMMENT 'Full name of the individual who authored or prepared this revision. Responsible party for the content creation.',
    `change_reason` STRING COMMENT 'Primary reason or trigger for this revision. Categorizes the business driver behind the document update.. Valid values are `design_change|client_request|rfi_response|regulatory_update|error_correction|clarification`',
    `change_summary` STRING COMMENT 'Concise summary of the specific changes made in this revision compared to the previous version. Highlights key modifications, additions, or deletions.',
    `checksum_hash` STRING COMMENT 'Cryptographic hash (e.g., SHA-256) of the file content. Ensures file integrity and detects unauthorized modifications.',
    `comments` STRING COMMENT 'Additional notes, remarks, or instructions related to this revision. Captures supplementary information not covered by other fields.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this revision record was first created in the system. Audit trail for record creation.',
    `revision_description` STRING COMMENT 'Detailed narrative describing the purpose and scope of this revision. Explains what changed and why.',
    `distribution_list` STRING COMMENT 'Comma-separated list of recipients or distribution groups who should receive this revision. Tracks who needs to be notified of the update.',
    `file_format` STRING COMMENT 'File type or format of the document (e.g., PDF, DWG for CAD, RVT for BIM). Indicates the software required to open the file. [ENUM-REF-CANDIDATE: pdf|dwg|dxf|rvt|ifc|docx|xlsx|pptx — 8 candidates stripped; promote to reference product]',
    `file_name` STRING COMMENT 'Name of the physical file associated with this revision, including extension (e.g., Drawing_A101_RevB.pdf).',
    `file_size_bytes` BIGINT COMMENT 'Size of the document file in bytes. Used for storage management and download estimation.',
    `file_storage_path` STRING COMMENT 'Full path or URI to the physical file location in the document management system or cloud storage. Enables retrieval of the actual document file.',
    `is_controlled_copy` BOOLEAN COMMENT 'Indicates whether this revision is a controlled copy subject to formal change management. True for official project copies, false for reference or uncontrolled copies.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this revision record was last updated in the system. Audit trail for record modifications.',
    `page_count` STRING COMMENT 'Total number of pages in this revision. Used for printing, archiving, and completeness verification.',
    `review_date` DATE COMMENT 'Date when the review of this revision was completed. Represents a distinct lifecycle event in the approval workflow.',
    `reviewer_name` STRING COMMENT 'Full name of the individual who reviewed this revision for technical accuracy and completeness.',
    `revision_date` DATE COMMENT 'Date when this revision was officially issued or published. Represents the business event timestamp for the revision release.',
    `revision_number` STRING COMMENT 'Sequential or alphanumeric identifier for this revision (e.g., Rev A, Rev 01, R1.2). Represents the version sequence within the document lifecycle.',
    `revision_status` STRING COMMENT 'Current lifecycle status of this revision. Tracks the approval and publication workflow state.. Valid values are `draft|in_review|approved|issued|superseded|obsolete`',
    `revision_type` STRING COMMENT 'Classification of the revision based on the nature and impact of changes. Distinguishes between routine updates and significant modifications.. Valid values are `initial|minor|major|emergency|regulatory`',
    `sheet_count` STRING COMMENT 'Total number of sheets or drawings in this revision (applicable for CAD and BIM documents). Used for drawing set completeness checks.',
    `transmittal_number` STRING COMMENT 'Reference number of the transmittal document used to formally issue this revision to stakeholders. Links to the correspondence register.',
    CONSTRAINT pk_revision PRIMARY KEY(`revision_id`)
) COMMENT 'Version control record for each document in the document register, capturing revision identifier, revision date, revision description, author, reviewer, approver, change summary, superseded revision reference, and file storage path. Maintains a complete and auditable version history for all project documents to support regulatory compliance, handover, and DLP (Defects Liability Period) obligations.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`workflow_approval` (
    `workflow_approval_id` BIGINT COMMENT 'Unique identifier for the workflow approval instance. Primary key for the workflow approval entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Enables linking workflow approvals to the specific contract for regulatory compliance and audit trails.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this workflow approval belongs. Enables project-level reporting and audit trails.',
    `document_register_id` BIGINT COMMENT 'Reference to the document or deliverable under review in this workflow. Links to the document management system record.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the individual person currently assigned to review and approve this workflow step. Links to workforce or user management system.',
    `tertiary_workflow_escalated_to_employee_id` BIGINT COMMENT 'Reference to the individual or role to whom the workflow was escalated for expedited review or higher-level decision authority.',
    `workflow_template_id` BIGINT COMMENT 'Reference to the workflow template that defines the approval chain structure, step sequence, and routing rules for this approval process.',
    `action_date` TIMESTAMP COMMENT 'Date and time when the reviewer recorded their approval decision or action. Used for SLA compliance tracking and audit trail.',
    `action_taken` STRING COMMENT 'The decision or action recorded by the reviewer at the current workflow step. Determines routing to next step or workflow termination. [ENUM-REF-CANDIDATE: approved|approved_with_comments|rejected|no_objection|commented|delegated|returned_for_revision|acknowledged|pending — 9 candidates stripped; promote to reference product]',
    `approval_authority_level` STRING COMMENT 'The organizational or contractual authority level required to approve this workflow. Determines who has final sign-off rights per delegation of authority matrix. [ENUM-REF-CANDIDATE: project_team|discipline_lead|project_manager|design_manager|technical_director|client_representative|regulatory_authority — 7 candidates stripped; promote to reference product]',
    `assigned_reviewer_role` STRING COMMENT 'The functional role or position assigned to review the current step (e.g., Lead Engineer, Design Manager, QA/QC Manager, Project Director). Defines approval authority.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this workflow approval to the complete audit trail log in the document management system. Supports ISO 9001 and ISO 19650 compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this workflow approval record was first created in the data platform. Audit field for data lineage and record lifecycle tracking.',
    `current_step_sequence` STRING COMMENT 'The ordinal position of the current approval step in the workflow chain. Used to track progress and determine next routing action.',
    `delegation_reason` STRING COMMENT 'Explanation provided by the original reviewer for delegating the approval to another individual (e.g., absence, conflict of interest, technical expertise).',
    `due_date` DATE COMMENT 'Target completion date for the entire workflow approval process. Derived from project schedule, contractual milestones, or regulatory deadlines.',
    `escalation_date` TIMESTAMP COMMENT 'Date and time when the workflow was escalated to higher approval authority or management attention due to delay or complexity.',
    `escalation_flag` BOOLEAN COMMENT 'Indicator of whether this workflow step was escalated to higher authority due to SLA breach, complexity, or policy requirements. True if escalated.',
    `external_reference_code` STRING COMMENT 'The unique identifier of this workflow approval in the source system (Aconex workflow ID, BIM 360 review ID). Enables bi-directional traceability.',
    `initiated_date` TIMESTAMP COMMENT 'Date and time when the workflow approval was initiated and entered the approval chain. Marks the start of the approval lifecycle and SLA clock.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this workflow approval record was last updated in the data platform. Audit field for change tracking and data freshness monitoring.',
    `last_reminder_date` TIMESTAMP COMMENT 'Date and time when the most recent reminder notification was sent to the assigned reviewer. Used to schedule next reminder per escalation policy.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicator of whether automated notification was sent to the assigned reviewer when the workflow step was routed to them. True if notification sent.',
    `outcome_date` TIMESTAMP COMMENT 'Date and time when the final workflow outcome was determined and the approval process was closed. Marks the end of the approval lifecycle.',
    `overall_outcome` STRING COMMENT 'Final outcome of the complete workflow approval process after all steps are completed. Determines document status and next business actions.. Valid values are `approved|rejected|withdrawn|superseded|closed`',
    `priority` STRING COMMENT 'Business priority level assigned to the workflow approval. Influences SLA targets, routing urgency, and reviewer notification frequency.. Valid values are `critical|high|medium|low`',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicator of whether this workflow approval is required to satisfy regulatory, statutory, or building code compliance obligations. True if regulatory-driven.',
    `reminder_count` STRING COMMENT 'Number of automated reminder notifications sent to the assigned reviewer for pending action. Used to track follow-up frequency and SLA risk.',
    `reviewer_comments` STRING COMMENT 'Free-text comments, observations, or conditions recorded by the reviewer. Captures technical feedback, approval conditions, or reasons for rejection.',
    `revision_number` STRING COMMENT 'The document revision or version number under review in this workflow instance. Ensures traceability between approval decisions and document versions.',
    `sla_actual_hours` DECIMAL(18,2) COMMENT 'The actual elapsed time in hours from workflow step assignment to action completion. Used to calculate SLA compliance and identify bottlenecks.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicator of whether the workflow step was completed within the SLA target duration. True if compliant, False if breached.',
    `sla_target_hours` STRING COMMENT 'The contractual or policy-defined target duration in hours for completing this workflow step. Used to measure compliance with approval turnaround commitments.',
    `total_steps` STRING COMMENT 'Total number of approval steps defined in the workflow template. Used to calculate completion percentage and remaining steps.',
    `workflow_name` STRING COMMENT 'Descriptive name of the workflow approval instance, typically derived from the document title or approval purpose.',
    `workflow_number` STRING COMMENT 'Business identifier for the workflow approval instance. Externally visible reference number used in correspondence and audit trails.',
    `workflow_status` STRING COMMENT 'Current lifecycle state of the workflow approval. Tracks progression through the approval chain from initiation to final outcome. [ENUM-REF-CANDIDATE: initiated|in_progress|pending_review|approved|rejected|on_hold|cancelled|completed — 8 candidates stripped; promote to reference product]',
    `workflow_type` STRING COMMENT 'Classification of the workflow approval by business purpose. Determines routing rules, SLA targets, and approval authority requirements. [ENUM-REF-CANDIDATE: design_review|submittal_approval|rfi_response|change_order_approval|drawing_approval|specification_review|technical_query|document_transmittal|noncompliance_review|method_statement_approval — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_workflow_approval PRIMARY KEY(`workflow_approval_id`)
) COMMENT 'Formal document review and approval workflow instances tracking multi-step approval chains in Aconex and BIM 360 CDE. Captures workflow template, document under review, step sequence, assigned reviewer (role and individual), action taken (approved, rejected, commented, delegated, no objection), action date, reviewer comments, SLA target vs actual duration, and overall workflow outcome. Provides the legally required audit trail of all document approval decisions for ISO 9001 quality management, ISO 19650 information management, and contractual compliance under FIDIC/NEC.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`handover_package` (
    `handover_package_id` BIGINT COMMENT 'Unique identifier for the handover package record. Primary key. Role: MASTER_RESOURCE.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Required for Handover Package Acceptance report that ties each package to the governing agreement.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Handover packages require a sign‑off by a specific client contact; linking enables handover acceptance reports.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this handover package is compiled.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Handover packages are delivered by a specific subcontractor; linking clarifies responsibility and client acceptance tracking.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Handover Package preparation requires tracking the responsible employee for audit and liability.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element that this handover package is associated with, enabling alignment with project planning and cost control structures.',
    `aconex_document_reference` STRING COMMENT 'Unique document identifier in the Aconex document management system for this handover package, enabling traceability to source system.',
    `approved_by` STRING COMMENT 'Name of the individual or role who approved the handover package for submission to the client.',
    `bim_model_reference` STRING COMMENT 'Reference to the BIM model or federated model that this handover package is derived from or linked to, enabling digital twin integration.',
    `client_acceptance_date` DATE COMMENT 'Date on which the client formally accepted the handover package, triggering DLP commencement and warranty periods.',
    `client_acceptance_status` STRING COMMENT 'Status of client acceptance for this handover package: pending, accepted, conditionally accepted, rejected, or under review.. Valid values are `pending|accepted|conditionally_accepted|rejected|under_review`',
    `comments` STRING COMMENT 'Free-text comments or notes regarding the handover package, including client feedback, revision requests, or special instructions.',
    `completeness_percentage` DECIMAL(18,2) COMMENT 'Percentage of required documents and deliverables that have been compiled and included in the handover package (0.00 to 100.00).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this handover package record was first created in the system.',
    `dlp_duration_days` STRING COMMENT 'Duration of the Defects Liability Period in days as specified in the contract for this handover package scope (commonly 365 days).',
    `dlp_end_date` DATE COMMENT 'Date on which the Defects Liability Period expires for the scope covered by this handover package, after which final release of retention may occur.',
    `dlp_start_date` DATE COMMENT 'Date on which the Defects Liability Period commences for the scope covered by this handover package, typically aligned with client acceptance or practical completion.',
    `handover_milestone` STRING COMMENT 'The contractual milestone at which this package is required for handover: practical completion, substantial completion, final completion, sectional handover, or early access.. Valid values are `practical_completion|substantial_completion|final_completion|sectional_handover|early_access`',
    `iso_19650_compliance_flag` BOOLEAN COMMENT 'Indicates whether this handover package complies with ISO 19650-3 operational phase information requirements (True/False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this handover package record was last updated or modified.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether this handover package is subject to a legal hold for litigation support, dispute resolution, or regulatory investigation (True/False).',
    `legal_hold_reason` STRING COMMENT 'Description of the reason for the legal hold, including case reference or dispute identifier if applicable.',
    `legal_hold_start_date` DATE COMMENT 'Date on which the legal hold was placed on this handover package.',
    `package_number` STRING COMMENT 'Business identifier for the handover package, typically following project-specific numbering convention (e.g., PRJ-HP-001234). Externally-known unique code.. Valid values are `^[A-Z0-9]{2,4}-HP-[0-9]{4,6}$`',
    `package_status` STRING COMMENT 'Current lifecycle status of the handover package: draft, in preparation, under review, submitted to client, accepted, rejected, or revision required. [ENUM-REF-CANDIDATE: draft|in_preparation|under_review|submitted_to_client|accepted|rejected|revision_required — 7 candidates stripped; promote to reference product]',
    `package_title` STRING COMMENT 'Descriptive title of the handover package indicating the scope or system covered (e.g., HVAC System O&M Documentation, Structural As-Built Drawings).',
    `package_type` STRING COMMENT 'Classification of the handover package by document category: operations and maintenance manuals, as-built drawings, test and commissioning records, warranties and guarantees, certificates and approvals, or training materials.. Valid values are `operations_and_maintenance_manual|as_built_drawings|test_and_commissioning_records|warranties_and_guarantees|certificates_and_approvals|training_materials`',
    `planned_submission_date` DATE COMMENT 'Target date for submission of the handover package as per the project handover schedule and contract requirements.',
    `required_document_count` STRING COMMENT 'Total number of documents required to be included in this handover package per the contract and handover plan.',
    `retention_period_years` STRING COMMENT 'Number of years this handover package must be retained per contractual, regulatory, or organizational policy requirements.',
    `reviewed_by` STRING COMMENT 'Name of the individual or role who reviewed the handover package for completeness and compliance before submission.',
    `scope_of_works` STRING COMMENT 'Detailed description of the scope of works, systems, or areas covered by this handover package (e.g., Mechanical systems for Building A floors 1-5).',
    `storage_location` STRING COMMENT 'Physical or digital storage location where the handover package is archived (e.g., document management system path, archive facility).',
    `submission_date` DATE COMMENT 'Date on which the handover package was submitted to the client or owner for review and acceptance.',
    `submitted_document_count` STRING COMMENT 'Number of documents that have been submitted and included in the handover package to date.',
    CONSTRAINT pk_handover_package PRIMARY KEY(`handover_package_id`)
) COMMENT 'Master record for project handover and commissioning documentation packages compiled for client/owner delivery at practical completion per ISO 19650-3 operational phase requirements. Captures package number, title, scope of works covered, handover milestone, package type (O&M manuals, as-built drawings, certificates, warranties, test records), completeness percentage, client acceptance status, DLP (Defects Liability Period) start date, and legal hold flag for litigation support. Sourced from Aconex handover module.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`handover_item` (
    `handover_item_id` BIGINT COMMENT 'Unique identifier for the handover item within the handover package tracking system.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Provides item‑level contract linkage for punch‑list tracking and final acceptance verification.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Required for Handover Package Acceptance Checklist linking each handover item to the specific equipment asset being transferred to client.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this handover item is being delivered.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Handover items are assigned to a craft worker who ensures client review and acceptance (Handover Management Process).',
    `document_register_id` BIGINT COMMENT 'Foreign key linking to design.document_register. Business justification: Handover item references a master document; replace free‑text reference with FK to document_register for consistency.',
    `handover_package_id` BIGINT COMMENT 'Reference to the parent handover package that contains this item.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Handover items may be physical materials; linking ensures client receives correct material records.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Assigns each handover item to a client contact for issue tracking and responsibility matrix.',
    `actual_submission_date` DATE COMMENT 'Actual date on which the handover item was submitted to the client or project team, used to track schedule performance.',
    `approval_date` DATE COMMENT 'Date on which the handover item received final approval and was accepted as complete and compliant.',
    `certification_date` DATE COMMENT 'Date on which the handover item was certified or verified by the certifying authority.',
    `certification_required` BOOLEAN COMMENT 'Flag indicating whether this handover item requires professional certification, third-party verification, or authorized signoff.',
    `certifying_authority` STRING COMMENT 'Name of the professional engineer, inspector, or third-party organization that certified or verified this handover item.',
    `client_review_date` DATE COMMENT 'Date on which the client completed their review and provided feedback or approval decision for this handover item.',
    `client_review_status` STRING COMMENT 'Status of the client or owner review process indicating whether the handover item has been accepted, requires revision, or is pending review. [ENUM-REF-CANDIDATE: not_submitted|pending_review|under_review|approved|approved_with_comments|rejected|resubmit_required — 7 candidates stripped; promote to reference product]',
    `client_reviewer_name` STRING COMMENT 'Name of the client representative who reviewed and approved or rejected this handover item.',
    `comments` STRING COMMENT 'Additional notes, observations, or contextual information related to this handover item that do not fit other structured fields.',
    `completed_timestamp` TIMESTAMP COMMENT 'Date and time when this handover item was marked as completed and fully closed out with all requirements satisfied.',
    `contractual_requirement` BOOLEAN COMMENT 'Flag indicating whether this handover item is a mandatory contractual deliverable required by the project contract or client agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this handover item record was first created in the system.',
    `discipline` STRING COMMENT 'Engineering or construction discipline category to which this handover item belongs for organizational and filtering purposes. [ENUM-REF-CANDIDATE: civil|structural|architectural|mechanical|electrical|plumbing|hvac|instrumentation|process|general — 10 candidates stripped; promote to reference product]',
    `file_location` STRING COMMENT 'Network path, cloud storage location, or document management system reference where the electronic version of this handover item is stored.',
    `format_type` STRING COMMENT 'Delivery format required for this handover item indicating whether it must be provided as physical hard copy, electronic file, or both.. Valid values are `hard_copy|electronic|both`',
    `item_description` STRING COMMENT 'Detailed description of the handover item including scope, content, and any special requirements or conditions.',
    `item_number` STRING COMMENT 'Sequential or hierarchical numbering of the item within the handover package for tracking and reference purposes.',
    `item_status` STRING COMMENT 'Current lifecycle status of the handover item tracking its progress through preparation, submission, review, and approval stages. [ENUM-REF-CANDIDATE: not_started|in_preparation|submitted|under_review|approved|rejected|resubmitted|completed — 8 candidates stripped; promote to reference product]',
    `item_title` STRING COMMENT 'Descriptive title or name of the handover item that clearly identifies the deliverable.',
    `item_type` STRING COMMENT 'Classification of the handover deliverable item. [ENUM-REF-CANDIDATE: om_manual|as_built_drawing|fat_certificate|sat_record|warranty_certificate|commissioning_record|spare_parts_list|training_material|maintenance_schedule|test_certificate|inspection_report|compliance_certificate — promote to reference product]',
    `language` STRING COMMENT 'Primary language in which the handover item document is prepared, using ISO 639-1 two-letter language codes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this handover item record was last updated or modified in the system.',
    `outstanding_action_notes` STRING COMMENT 'Description of any outstanding actions, corrections, or additional information required to complete or close out this handover item.',
    `page_count` STRING COMMENT 'Total number of pages in the handover item document for tracking completeness and printing requirements.',
    `planned_submission_date` DATE COMMENT 'Target date by which the handover item is scheduled to be submitted to the client or project team for review.',
    `priority` STRING COMMENT 'Priority level assigned to this handover item indicating its importance and urgency for project completion and client acceptance.. Valid values are `critical|high|medium|low`',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the handover item was rejected by the client or reviewing authority, including specific deficiencies or non-conformances.',
    `responsible_party` STRING COMMENT 'Name of the organization, contractor, subcontractor, or vendor responsible for preparing and submitting this handover item.',
    `revision_number` STRING COMMENT 'Version or revision identifier of the handover item document to track updates and changes.',
    `system_reference` STRING COMMENT 'Reference to the specific building system, equipment system, or facility system that this handover item documents.',
    `warranty_period_months` STRING COMMENT 'Duration of the warranty or defects liability period in months applicable to the system or equipment documented in this handover item.',
    `wbs_code` STRING COMMENT 'Work Breakdown Structure code linking this handover item to the project WBS hierarchy for cost and schedule integration.',
    CONSTRAINT pk_handover_item PRIMARY KEY(`handover_item_id`)
) COMMENT 'Individual document or deliverable item within a handover package, tracking item type (O&M manual, as-built drawing, FAT certificate, SAT record, warranty certificate, commissioning record, spare parts list), item status, responsible party, planned submission date, actual submission date, client review status, and outstanding action notes. Enables granular tracking of handover completeness at item level.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`correspondence_response` (
    `correspondence_response_id` BIGINT COMMENT 'Unique identifier for the correspondence response record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Identifier of the specific contract under which this correspondence response is issued. Links to contract master data.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the individual who approved the response for issuance. Links to workforce or user management system.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which this correspondence response belongs. Links to the project master data.',
    `correspondence_id` BIGINT COMMENT 'Reference to the originating correspondence item that this response addresses. Links to the parent correspondence record.',
    `primary_correspondence_employee_id` BIGINT COMMENT 'Identifier of the individual who authored or prepared the response. Links to workforce or user management system.',
    `supersedes_response_correspondence_response_id` BIGINT COMMENT 'Reference to a previous response that this response supersedes or replaces. Maintains version control and response history.',
    `acknowledgment_received_date` DATE COMMENT 'The date on which acknowledgment of receipt was received from the recipient, if acknowledgment was required.',
    `acknowledgment_required` BOOLEAN COMMENT 'Indicates whether the recipient is required to formally acknowledge receipt of the response.',
    `action_required_by_date` DATE COMMENT 'The deadline or due date by which the recipient must take action or provide a counter-response. Used for tracking contractual obligations and timelines.',
    `approval_date` DATE COMMENT 'The date the response was formally approved for issuance. Part of the approval workflow audit trail.',
    `approver_name` STRING COMMENT 'Full name of the individual who approved the response. Captured for audit and accountability purposes.',
    `attachment_count` STRING COMMENT 'The number of files or documents attached to the response. Used for completeness verification and tracking.',
    `attachment_file_names` STRING COMMENT 'List of file names for all attachments included with the response. Comma-separated or structured list for reference and retrieval.',
    `author_name` STRING COMMENT 'Full name of the individual who authored the response. Captured for display and reporting purposes.',
    `author_role` STRING COMMENT 'The organizational role or position of the response author at the time of authoring. Important for authority and approval tracking.',
    `closes_correspondence` BOOLEAN COMMENT 'Indicates whether this response fully resolves and closes the originating correspondence item, or if further action or response is required.',
    `contractual_impact` STRING COMMENT 'Classification of the potential impact this response may have on the project contract in terms of time, cost, scope, quality, or risk.. Valid values are `none|time|cost|scope|quality|risk`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the response record was first created in the system. Part of the audit trail.',
    `discipline` STRING COMMENT 'The engineering or technical discipline to which the response relates, such as civil, structural, mechanical, electrical, or architectural.',
    `distribution_list` STRING COMMENT 'List of individuals, roles, or organizations to whom the response is distributed for information or action. Comma-separated or structured list.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the response record was last updated or modified. Part of the audit trail for change tracking.',
    `legal_review_required` BOOLEAN COMMENT 'Indicates whether the response required or underwent legal review before issuance due to contractual or liability implications.',
    `legal_reviewer_name` STRING COMMENT 'Name of the legal counsel or advisor who reviewed the response, if legal review was performed.',
    `notes` STRING COMMENT 'Internal notes or comments about the response for team reference. Not shared externally with the recipient.',
    `priority` STRING COMMENT 'The urgency or priority level assigned to the response. Determines handling and escalation procedures.. Valid values are `low|medium|high|urgent|critical`',
    `recipient_contact_name` STRING COMMENT 'The name of the specific individual or role to whom the response is addressed within the recipient organization.',
    `recipient_email` STRING COMMENT 'Email address of the recipient contact. Used for electronic delivery and confirmation tracking.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_organization` STRING COMMENT 'The name of the organization or company to which the response is addressed. May be client, subcontractor, consultant, or regulatory authority.',
    `reference_documents` STRING COMMENT 'List or identifiers of supporting documents, drawings, specifications, or other materials referenced in the response. Comma-separated or structured list.',
    `requires_further_action` BOOLEAN COMMENT 'Indicates whether the response triggers or requires additional follow-up actions, responses, or decisions from the recipient or other parties.',
    `response_content` STRING COMMENT 'The full text content of the response. Contains the detailed answer, information, or position being communicated.',
    `response_date` DATE COMMENT 'The date the response was formally issued or sent to the recipient. Used for contractual timeline tracking and compliance verification.',
    `response_language` STRING COMMENT 'The language in which the response is written, using ISO 639-2 three-letter language codes. Important for international projects.. Valid values are `^[A-Z]{3}$`',
    `response_method` STRING COMMENT 'The communication channel or medium used to deliver the response. Critical for contractual and legal documentation purposes.. Valid values are `letter|email|formal_notice|transmittal|system_notification|verbal_confirmed`',
    `response_number` STRING COMMENT 'Business identifier for the response, typically following project or organizational numbering conventions. Used for external reference and tracking.. Valid values are `^[A-Z0-9-]+$`',
    `response_status` STRING COMMENT 'Current lifecycle status of the correspondence response. Tracks progression from draft through submission to closure.. Valid values are `draft|submitted|acknowledged|superseded|withdrawn|closed`',
    `response_summary` STRING COMMENT 'A brief summary or abstract of the response content. Provides quick overview without reading the full response text.',
    `response_timestamp` TIMESTAMP COMMENT 'Precise date and time when the response was submitted or transmitted. Provides audit trail for time-sensitive contractual obligations.',
    `response_type` STRING COMMENT 'Classification of the response based on its purpose and nature. Determines the formality and contractual weight of the response. [ENUM-REF-CANDIDATE: formal_reply|information_provision|clarification|acknowledgment|rejection|approval|conditional_approval — 7 candidates stripped; promote to reference product]',
    `revision_number` STRING COMMENT 'The revision or version number of the response. Increments when the response is updated or reissued.',
    `subject` STRING COMMENT 'The subject line or title of the response. Provides a concise summary of the response topic for indexing and retrieval.',
    CONSTRAINT pk_correspondence_response PRIMARY KEY(`correspondence_response_id`)
) COMMENT 'Tracks formal responses to incoming correspondence items, capturing the originating correspondence reference, response author, response date, response content summary, response method (letter, email, formal notice), attachments, and whether the response closes the correspondence item or requires further action. Maintains the full correspondence thread for contractual and legal purposes.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`transmittal_item` (
    `transmittal_item_id` BIGINT COMMENT 'Unique identifier for the transmittal item line. Primary key for the transmittal item entity.',
    `document_register_id` BIGINT COMMENT 'Reference to the document master record being transmitted. Links to the document control register.',
    `transmittal_id` BIGINT COMMENT 'Reference to the parent transmittal header that contains this item. Links the line item to its transmittal package.',
    `bim_model_reference` STRING COMMENT 'Reference to the BIM model or model element associated with this document. Used for linking documents to 3D models and coordinating design information.',
    `confidentiality_level` STRING COMMENT 'The data classification or confidentiality level of the document being transmitted. Used for access control and handling instructions.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this transmittal item record was first created in the system. Used for audit trail and record lifecycle tracking.',
    `discipline` STRING COMMENT 'The engineering or design discipline responsible for the document. Used for routing to appropriate reviewers and organizing documents by technical domain. [ENUM-REF-CANDIDATE: architectural|structural|civil|mechanical|electrical|plumbing|hvac|instrumentation|process|geotechnical|environmental — 11 candidates stripped; promote to reference product]',
    `distribution_method` STRING COMMENT 'The method by which this document item is being distributed to the recipient. Used for logistics planning and receipt confirmation.. Valid values are `electronic|hard_copy|both|courier|registered_mail`',
    `document_number` STRING COMMENT 'The unique document control number or identifier assigned to the document being transmitted. Used for document tracking and reference.',
    `document_revision` STRING COMMENT 'The specific revision or version number of the document being transmitted. Critical for tracking which version was sent and ensuring recipients have the correct iteration.',
    `document_title` STRING COMMENT 'The full title or name of the document being transmitted. Provides human-readable identification of the document content.',
    `document_type` STRING COMMENT 'Classification of the document being transmitted by its functional type. Enables filtering and routing based on document category. [ENUM-REF-CANDIDATE: drawing|specification|report|calculation|schedule|procedure|manual|correspondence|submittal|rfi_response|method_statement — 11 candidates stripped; promote to reference product]',
    `file_format` STRING COMMENT 'The digital file format of the document being transmitted. Critical for ensuring recipients can open and use the files. [ENUM-REF-CANDIDATE: PDF|DWG|DXF|RVT|IFC|DOCX|XLSX|PPTX|native — 9 candidates stripped; promote to reference product]',
    `file_size_mb` DECIMAL(18,2) COMMENT 'The size of the digital file in megabytes. Used for transmission planning, storage management, and download time estimation.',
    `item_notes` STRING COMMENT 'Free-text notes or special instructions specific to this transmittal item. Used to communicate item-specific handling requirements, clarifications, or context.',
    `item_status` STRING COMMENT 'The current lifecycle status of this transmittal item. Tracks the item through transmission, receipt, and acknowledgment stages.. Valid values are `pending|transmitted|received|acknowledged|rejected|superseded`',
    `line_number` STRING COMMENT 'Sequential line number of this item within the transmittal. Used for ordering and referencing specific items in the transmittal package.',
    `modified_by` STRING COMMENT 'The user or system identifier of the person who last modified this transmittal item record. Used for accountability and audit trail.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this transmittal item record was last modified. Used for audit trail and change tracking.',
    `number_of_copies` STRING COMMENT 'The quantity of physical or digital copies of this document included in the transmittal. Used for distribution tracking and receipt confirmation.',
    `number_of_sheets` STRING COMMENT 'The total number of sheets or pages in the document being transmitted. Used for completeness verification and reproduction planning.',
    `purpose_of_issue` STRING COMMENT 'The intended purpose or action required for this document transmission. Defines what the recipient is expected to do with the document. [ENUM-REF-CANDIDATE: for_information|for_review|for_approval|for_construction|for_tender|as_built|for_record — 7 candidates stripped; promote to reference product]',
    `received_by` STRING COMMENT 'The name or identifier of the person who acknowledged receipt of this transmittal item. Used for accountability and audit trail.',
    `received_date` DATE COMMENT 'The date on which the recipient confirmed receipt of this transmittal item. Used for audit trail and to track transmission completion.',
    `rejection_reason` STRING COMMENT 'The reason provided if this transmittal item was rejected by the recipient. Used for issue resolution and quality improvement.',
    `response_due_date` DATE COMMENT 'The date by which a response or action is required from the recipient for this document. Used for tracking compliance with review and approval schedules.',
    `response_required` BOOLEAN COMMENT 'Indicates whether the recipient is required to provide a formal response or acknowledgment for this document. Used to track outstanding actions.',
    `sheet_size` STRING COMMENT 'The physical or digital sheet size of the document, particularly relevant for drawings and plans. Used for printing and reproduction planning. [ENUM-REF-CANDIDATE: A0|A1|A2|A3|A4|ANSI_A|ANSI_B|ANSI_C|ANSI_D|ANSI_E — 10 candidates stripped; promote to reference product]',
    `status_code` STRING COMMENT 'The suitability or approval status code of the document at the time of transmission. Follows industry-standard document status coding conventions. [ENUM-REF-CANDIDATE: S0|S1|S2|S3|S4|A|B|C|D — 9 candidates stripped; promote to reference product]',
    `supersedes_document_number` STRING COMMENT 'The document number of the previous version that this document replaces or supersedes. Used for version control and ensuring obsolete documents are withdrawn.',
    `supersedes_revision` STRING COMMENT 'The revision number of the previous version that this document replaces. Used in conjunction with supersedes_document_number for complete version tracking.',
    `work_package_code` STRING COMMENT 'The work breakdown structure code or work package identifier that this document relates to. Used for organizing documents by project scope and phase.',
    `created_by` STRING COMMENT 'The user or system identifier of the person who created this transmittal item record. Used for accountability and audit trail.',
    CONSTRAINT pk_transmittal_item PRIMARY KEY(`transmittal_item_id`)
) COMMENT 'Line-item detail of each document included within a transmittal, capturing document number, document title, revision, number of copies, file format, and any item-specific notes or instructions. Enables granular tracking of exactly which document revisions were dispatched in each transmittal, supporting audit trail and document receipt confirmation at the individual document level.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`distribution_matrix` (
    `distribution_matrix_id` BIGINT COMMENT 'Primary key for distribution_matrix',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Links document distribution rules to the contract that defines distribution obligations and confidentiality requirements.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project this distribution matrix applies to.',
    `superseded_by_matrix_distribution_matrix_id` BIGINT COMMENT 'Reference to the distribution matrix entry that replaces this rule when it is superseded or revised.',
    `workflow_template_id` BIGINT COMMENT 'add column workflow_template_id (BIGINT) with FK to design.workflow_template.workflow_template_id - distribution matrices configure workflow routing',
    `acknowledgement_deadline_days` STRING COMMENT 'Number of calendar days within which the recipient must acknowledge receipt of the document, measured from distribution date.',
    `acknowledgement_required_flag` BOOLEAN COMMENT 'Indicates whether the recipient must formally acknowledge receipt of documents distributed under this rule.',
    `approval_authority` STRING COMMENT 'Name or role of the individual or body authorized to approve and activate this distribution rule (e.g., Project Manager, Document Controller, Contract Administrator).',
    `approval_date` DATE COMMENT 'Date on which this distribution matrix entry was formally approved for implementation.',
    `copy_type` STRING COMMENT 'Classification of the document copy being distributed indicating the level of control and recipient obligations (controlled copies require return/destruction upon revision; uncontrolled copies are informational only).. Valid values are `controlled|uncontrolled|for_information|for_approval|for_review|for_comment`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this distribution matrix entry was first created in the system.',
    `discipline_code` STRING COMMENT 'Engineering or construction discipline code indicating the technical domain of documents covered by this rule (e.g., CIVIL, STRUCT, MECH, ELEC, INST, ARCH, HVAC).. Valid values are `^[A-Z]{2,5}$`',
    `distribution_format` STRING COMMENT 'File format or media type in which documents are distributed to this recipient (e.g., PDF for review, DWG for CAD files, IFC for BIM models, paper hard copy).. Valid values are `pdf|dwg|ifc|native|paper|both`',
    `distribution_frequency` STRING COMMENT 'Timing or trigger for document distribution to this recipient (e.g., immediately upon issue, at project milestones, on a scheduled basis, or as contractually required). [ENUM-REF-CANDIDATE: on_issue|daily|weekly|monthly|milestone|as_required|upon_approval — 7 candidates stripped; promote to reference product]',
    `distribution_method` STRING COMMENT 'Method or channel through which documents are transmitted to the recipient (e.g., Aconex document management system, email, physical hard copy, BIM 360 platform, Procore, courier service). [ENUM-REF-CANDIDATE: aconex|email|hard_copy|bim_360|procore|courier|registered_mail — 7 candidates stripped; promote to reference product]',
    `distribution_priority` STRING COMMENT 'Priority level assigned to this distribution rule indicating urgency and importance of timely delivery.. Valid values are `critical|high|normal|low`',
    `distribution_status` STRING COMMENT 'Current operational status of this distribution matrix entry indicating whether the rule is actively enforced.. Valid values are `active|suspended|superseded|cancelled|pending_approval`',
    `document_type_code` STRING COMMENT 'Standardized code identifying the type of document subject to distribution (e.g., DWG for drawings, SPEC for specifications, RFI for Request for Information, NCR for Non-Conformance Report, ITP for Inspection and Test Plan).. Valid values are `^[A-Z0-9]{2,10}$`',
    `document_type_description` STRING COMMENT 'Full descriptive name of the document type covered by this distribution rule.',
    `effective_from_date` DATE COMMENT 'Date from which this distribution rule becomes active and enforceable within the project.',
    `effective_to_date` DATE COMMENT 'Date on which this distribution rule expires or is superseded; null indicates an open-ended rule.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this distribution matrix entry was most recently updated or revised.',
    `notes` STRING COMMENT 'Additional instructions, clarifications, or special conditions applicable to this distribution rule.',
    `project_phase_applicability` STRING COMMENT 'Project lifecycle phase(s) during which this distribution rule is active (e.g., Design, Procurement, Construction, Commissioning, Handover, Operations and Maintenance).',
    `recipient_contact_name` STRING COMMENT 'Full name of the individual designated to receive documents under this distribution rule.',
    `recipient_email_address` STRING COMMENT 'Primary email address for electronic document distribution to the recipient.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_organization_name` STRING COMMENT 'Name of the organization or company designated to receive documents of this type (e.g., General Contractor, Subcontractor, Client, Consultant, Regulatory Authority).',
    `recipient_role` STRING COMMENT 'Functional role or position of the recipient within the project structure (e.g., Project Manager, Design Engineer, QA/QC Manager, HSE Officer, Contract Administrator).',
    `response_deadline_days` STRING COMMENT 'Number of calendar days within which the recipient must provide a substantive response or approval decision, measured from distribution date.',
    `response_required_flag` BOOLEAN COMMENT 'Indicates whether the recipient is required to provide a substantive response, review, or approval action (not just acknowledgement of receipt).',
    `revision_number` STRING COMMENT 'Version or revision identifier for this distribution matrix entry, tracking changes over the project lifecycle.. Valid values are `^[A-Z0-9]{1,10}$`',
    `security_classification` STRING COMMENT 'Security or confidentiality classification level of documents distributed under this rule, governing handling and access restrictions.. Valid values are `public|internal|confidential|restricted|proprietary`',
    `wbs_code` STRING COMMENT 'Work Breakdown Structure code identifying the project component or work package to which this distribution rule applies.. Valid values are `^[A-Z0-9.-]{1,30}$`',
    CONSTRAINT pk_distribution_matrix PRIMARY KEY(`distribution_matrix_id`)
) COMMENT 'Planned distribution rules defining which organizations, roles, or individuals receive specific document types during the project lifecycle. Specifies copy type (controlled, uncontrolled, for information), distribution method (Aconex, email, hard copy), acknowledgement requirements, and contractual basis for distribution. Governs systematic and auditable document distribution per FIDIC and NEC contract requirements, ensuring all parties receive required documentation at each project milestone.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`access_permission` (
    `access_permission_id` BIGINT COMMENT 'Primary key for access_permission',
    `account_id` BIGINT COMMENT 'Reference to the organization granted access. Applicable when grantee_type is organization. Links to contractor, subcontractor, client, or JV (Joint Venture) partner organization master data.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Needed for Permission Matrix report to enforce contract‑specific access rights and confidentiality clauses.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this access permission applies. Links to project master data in Primavera P6 or SAP Project Systems. Enables project-level access control reporting and audit.',
    `document_register_id` BIGINT COMMENT 'Reference to the document or folder in Aconex or BIM 360 CDE (Common Data Environment) to which this access permission applies. Links to the document management systems document register.',
    `parent_permission_access_permission_id` BIGINT COMMENT 'Reference to the parent access permission from which this permission is inherited. Applicable when inherit_from_parent_flag is true. Enables traceability of permission inheritance chains.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the individual user granted access when grantee_type is user. Links to workforce or contact master data in SAP SuccessFactors or project team member registry.',
    `quaternary_quinary_access_created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created this access permission record in the system. Links to workforce master data. Required for audit trail and accountability.',
    `team_member_id` BIGINT COMMENT 'Reference to the project team granted access when grantee_type is team. Links to project team structure in Procore or Primavera P6.',
    `tertiary_access_approved_by_user_employee_id` BIGINT COMMENT 'Reference to the user who approved this access permission request. Applicable when approval_required_flag is true. Links to workforce master data. Required for segregation of duties and audit trail.',
    `tertiary_quaternary_access_revoked_by_user_employee_id` BIGINT COMMENT 'Reference to the user who revoked this access permission. Applicable when permission_status is revoked. Links to workforce master data. Required for audit trail and accountability.',
    `access_count` STRING COMMENT 'Total number of times the grantee has exercised this access permission. Supports usage analytics, dormant access identification, and anomaly detection for security monitoring.',
    `access_log_retention_days` STRING COMMENT 'Number of days that access logs for this permission must be retained for audit and compliance purposes. Driven by contractual requirements, ISO 27001, GDPR (General Data Protection Regulation), and litigation hold obligations.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this access permission required formal approval workflow before activation. True for high-risk permissions (admin, delete, access to commercially sensitive or legally privileged documents). False for standard view/download permissions.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the access permission was approved. Applicable when approval_required_flag is true. Required for audit trail and compliance reporting.',
    `business_justification` STRING COMMENT 'Business reason for granting access. Examples: contract requirement, design review participation, QA/QC (Quality Assurance/Quality Control) inspection, HSE (Health Safety Environment) audit, client approval authority, subcontractor coordination. Required for ISO 27001 and contractual compliance.',
    `confidentiality_level` STRING COMMENT 'Classification level of the document or folder to which this permission applies. Enforces need-to-know access control for commercially sensitive pricing, legally privileged correspondence, security-classified designs, and proprietary technical specifications.. Valid values are `public|internal|confidential|restricted|commercially_sensitive|legally_privileged`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this access permission record was first created in the system. Required for audit trail and data lineage. Distinct from granted_timestamp which represents the business event.',
    `discipline` STRING COMMENT 'Engineering or design discipline to which the document or folder belongs. Used to enforce discipline-specific access control and segregation of duties in multidisciplinary EPC (Engineering Procurement Construction) projects. [ENUM-REF-CANDIDATE: civil|structural|architectural|mechanical|electrical|plumbing|geotechnical|environmental|surveying|bim|general — 11 candidates stripped; promote to reference product]',
    `effective_from_date` DATE COMMENT 'Date when the access permission becomes active. Supports time-bound access control for phase-based project delivery, contractor mobilization periods, and temporary access grants.',
    `effective_to_date` DATE COMMENT 'Date when the access permission expires. Nullable for indefinite permissions. Enforces automatic access revocation upon contract completion, DLP (Defects Liability Period) expiry, or project handover.',
    `granted_timestamp` TIMESTAMP COMMENT 'Date and time when the access permission was granted. Principal business event timestamp for this access control record. Required for audit trail and compliance reporting.',
    `grantee_role_code` STRING COMMENT 'Role code granted access when grantee_type is role. Examples: PM (Project Manager), DE (Design Engineer), QA (Quality Assurance), HSE (Health Safety Environment), CA (Contract Administrator).. Valid values are `^[A-Z]{2,10}$`',
    `grantee_type` STRING COMMENT 'Type of entity receiving the access permission: organization (contractor, subcontractor, client), role (project manager, design engineer), individual user, or team.. Valid values are `organization|role|user|team`',
    `inherit_from_parent_flag` BOOLEAN COMMENT 'Indicates whether this permission is inherited from a parent folder or workspace. True for inherited permissions, false for explicitly granted permissions. Supports hierarchical access control in nested folder structures.',
    `last_accessed_timestamp` TIMESTAMP COMMENT 'Date and time when the grantee last exercised this access permission (last viewed, downloaded, or edited the document). Supports dormant access review and least-privilege enforcement.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this access permission record was last modified. Required for audit trail and change tracking. Updated whenever permission level, status, effective dates, or other attributes are changed.',
    `notes` STRING COMMENT 'Free-text notes providing additional context for this access permission. Examples: special instructions, temporary access conditions, escalation contact, related RFI (Request for Information) or NCR (Non-Conformance Report) reference.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a notification was sent to the grantee informing them of this access permission. True when notification email or system alert was successfully delivered. Supports user awareness and audit trail.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when the access permission notification was sent to the grantee. Applicable when notification_sent_flag is true. Required for audit trail.',
    `offline_access_allowed_flag` BOOLEAN COMMENT 'Indicates whether the grantee is allowed to download documents for offline access. False for highly confidential documents that must remain within the CDE (Common Data Environment) with online-only access control.',
    `permission_level` STRING COMMENT 'Level of access granted: view (read-only), download (retrieve copy), upload (add new), edit (modify existing), approve (workflow authority), delete (remove), admin (full control including permission management). [ENUM-REF-CANDIDATE: view|download|upload|edit|approve|delete|admin — 7 candidates stripped; promote to reference product]',
    `permission_number` STRING COMMENT 'Business identifier for the access permission rule. Format: ACL-NNNNNNNN. Used for audit trails and permission tracking across document control systems.. Valid values are `^ACL-[0-9]{8}$`',
    `permission_status` STRING COMMENT 'Current lifecycle status of the access permission: active (in effect), suspended (temporarily disabled), revoked (permanently removed), expired (past effective period), pending (awaiting approval).. Valid values are `active|suspended|revoked|expired|pending`',
    `permission_type` STRING COMMENT 'Scope of the access permission: document-level, folder-level, workspace-level, or project-level. Determines the granularity of access control enforcement.. Valid values are `document|folder|workspace|project`',
    `print_allowed_flag` BOOLEAN COMMENT 'Indicates whether the grantee is allowed to print documents accessed under this permission. False for highly confidential or legally privileged documents where physical copy control is required.',
    `revocation_reason` STRING COMMENT 'Business reason for revoking access. Examples: contract termination, employee departure, project completion, security incident, access no longer required, role change, subcontractor demobilization. Required for audit trail and compliance.',
    `revoked_timestamp` TIMESTAMP COMMENT 'Date and time when the access permission was revoked. Applicable when permission_status is revoked. Required for audit trail and compliance reporting.',
    `watermark_required_flag` BOOLEAN COMMENT 'Indicates whether documents accessed under this permission must be watermarked with user identity and access timestamp. True for confidential, commercially sensitive, or legally privileged documents. Supports document leakage prevention and forensic audit.',
    `wbs_code` STRING COMMENT 'WBS (Work Breakdown Structure) code identifying the project phase, deliverable, or work package to which this access permission applies. Enables phase-based and deliverable-based access control in CPM (Critical Path Method) scheduled projects.. Valid values are `^[A-Z0-9.-]{1,30}$`',
    CONSTRAINT pk_access_permission PRIMARY KEY(`access_permission_id`)
) COMMENT 'Access control rules governing who can view, edit, upload, or approve documents within Aconex and BIM 360 CDE. Captures document or folder reference, organization or role granted access, permission level (view, download, upload, approve), effective dates, granting authority, and business justification. Enforces confidentiality requirements for commercially sensitive, legally privileged, and security-classified project documents per contractual, ISO 27001, and regulatory obligations.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`bim_model` (
    `bim_model_id` BIGINT COMMENT 'Unique identifier for the BIM model record. Primary key for the BIM model entity.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: BIM model author employee is required for model provenance and liability.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project this BIM model belongs to. Links the model to its parent project context.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: BIM model material library requires linking each model to its material master for quantity take‑off and clash detection.',
    `superseded_by_model_bim_model_id` BIGINT COMMENT 'Reference to the newer BIM model version that replaces this one. Null if this is the current version.',
    `author_organization` STRING COMMENT 'Organization or company responsible for authoring the BIM model (e.g., design consultant, contractor).',
    `authoring_software` STRING COMMENT 'Software application used to create and edit the BIM model (e.g., Autodesk Revit, Bentley MicroStation, ArchiCAD, Tekla Structures).',
    `building_zone` STRING COMMENT 'Specific building, zone, or facility area that this BIM model represents (e.g., Tower A, Basement Level 2, North Wing).',
    `clash_count` STRING COMMENT 'Number of unresolved clashes identified in the latest clash detection run. Zero indicates coordination clearance.',
    `clash_detection_status` STRING COMMENT 'Status of clash detection analysis for this model against other discipline models. Critical for coordination.. Valid values are `not_started|in_progress|completed|issues_identified|resolved`',
    `comments` STRING COMMENT 'Additional notes, remarks, or special instructions related to the BIM model version.',
    `confidentiality_classification` STRING COMMENT 'Data classification level for the BIM model determining access controls and distribution restrictions.. Valid values are `public|internal|confidential|restricted`',
    `coordinate_system` STRING COMMENT 'Coordinate reference system used for model positioning (e.g., WGS84, NAD83, local grid). Ensures spatial alignment across disciplines.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this BIM model record was first created in the system.',
    `discipline` STRING COMMENT 'Engineering or design discipline that owns this BIM model. Determines the technical domain and responsible team. [ENUM-REF-CANDIDATE: architectural|structural|mechanical|electrical|plumbing|civil|geotechnical|landscape|interior_design|fire_protection|telecommunications|environmental — 12 candidates stripped; promote to reference product]',
    `element_count` STRING COMMENT 'Total number of BIM elements (objects) contained in the model. Indicator of model complexity.',
    `external_reference_code` STRING COMMENT 'Identifier from the source system (Autodesk BIM 360, Bentley ProjectWise) for integration and synchronization.',
    `federation_role` STRING COMMENT 'Role of this model in federated model assembly. Determines how it integrates with other discipline models.. Valid values are `host|linked|standalone|reference`',
    `file_format` STRING COMMENT 'Native or exchange file format of the BIM model. Determines interoperability and viewing requirements. [ENUM-REF-CANDIDATE: RVT|NWD|NWC|IFC|DWG|DGN|SKP|RFA|DXF — 9 candidates stripped; promote to reference product]',
    `file_size_mb` DECIMAL(18,2) COMMENT 'Size of the BIM model file in megabytes. Used for storage planning and performance optimization.',
    `iso_19650_compliance_flag` BOOLEAN COMMENT 'Indicates whether the BIM model meets ISO 19650 information management requirements and standards.',
    `issue_date` DATE COMMENT 'Date when this version of the BIM model was formally issued or published to the project team.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this BIM model record was last updated in the system.',
    `lifecycle_stage` STRING COMMENT 'Stage of the project lifecycle this model version represents. Aligns with ISO 19650 delivery phases. [ENUM-REF-CANDIDATE: concept|design_development|construction_documentation|construction|commissioning|operations|decommissioning — 7 candidates stripped; promote to reference product]',
    `lod_classification` STRING COMMENT 'Level of Development per AIA E202 and BIMForum LOD Specification. Defines the degree of geometric detail and information richness in the model elements.. Valid values are `LOD_100|LOD_200|LOD_300|LOD_350|LOD_400|LOD_500`',
    `model_name` STRING COMMENT 'Human-readable name of the BIM model describing its content and scope (e.g., Terminal Building Level 1 Architecture, Bridge Deck Structural Model).',
    `model_number` STRING COMMENT 'Business identifier for the BIM model, typically following project naming conventions (e.g., ARC-L01-001, STR-F02-005). Used for external reference and communication.',
    `model_status` STRING COMMENT 'Current lifecycle status of the BIM model. Controls access, usage, and workflow progression.. Valid values are `wip|shared|published|archived|superseded`',
    `model_type` STRING COMMENT 'Classification of the model purpose and usage context within the project lifecycle.. Valid values are `design|coordination|construction|as_built|facility_management`',
    `model_version` STRING COMMENT 'Version identifier for this iteration of the BIM model. Tracks evolution and change history.',
    `origin_elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the model origin point in meters above sea level. Provides vertical datum reference.',
    `origin_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the model origin point in decimal degrees. Establishes geolocation reference.',
    `origin_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the model origin point in decimal degrees. Establishes geolocation reference.',
    `review_date` DATE COMMENT 'Date when the BIM model review was completed and approved for issue.',
    `reviewer_name` STRING COMMENT 'Name of the individual who performed technical review of the BIM model before publication.',
    `revision_number` STRING COMMENT 'Formal revision number following project document control conventions (e.g., P01, C02, A03).',
    `software_version` STRING COMMENT 'Version number of the authoring software used to create the model. Critical for compatibility and file exchange.',
    `storage_location` STRING COMMENT 'File path or cloud storage location where the BIM model file is stored (e.g., BIM 360 project folder, SharePoint path).',
    `wbs_code` STRING COMMENT 'Work Breakdown Structure code linking the BIM model to specific project scope and cost accounts.',
    CONSTRAINT pk_bim_model PRIMARY KEY(`bim_model_id`)
) COMMENT 'Master record for each Building Information Model (BIM) asset managed in Autodesk BIM 360, Bentley ProjectWise, or equivalent platform. Captures model identity, discipline (architectural, structural, MEP, civil), authoring software and version, file format (RVT, IFC, NWD), project coordinate system, geolocation reference point, LOD (Level of Development) classification per AIA E202/BIMForum LOD Specification, model status (WIP, shared, published, archived), lifecycle stage, federation role (host/linked), and file size. SSOT for all 3D model metadata across the project portfolio, enabling federated model assembly, clash detection workflows, 4D/5D BIM integration, and ISO 19650 information management compliance.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`drawing` (
    `drawing_id` BIGINT COMMENT 'Unique identifier for the engineering or construction drawing record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Critical for Drawing Register to associate each drawing with its contract for scope control and change management.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Drawing author is an employee; required for design accountability and traceability.',
    `bim_model_id` BIGINT COMMENT 'Foreign key linking to design.bim_model. Business justification: Drawing belongs to a BIM model; replace string reference with proper FK to BIM model for traceability.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this drawing belongs.',
    `approval_date` DATE COMMENT 'Date when the drawing was formally approved for issue.',
    `approver_name` STRING COMMENT 'Name of the individual who approved the drawing for issue.',
    `cad_file_name` STRING COMMENT 'Name of the CAD source file from which the drawing was generated.',
    `checker_name` STRING COMMENT 'Name of the individual who performed technical checking or peer review of the drawing.',
    `clash_detection_status` STRING COMMENT 'Status of BIM clash detection analysis for this drawing (e.g., not checked, passed, clashes detected, resolved).. Valid values are `not_checked|passed|clashes_detected|resolved`',
    `comments` STRING COMMENT 'Free-text field for additional notes, remarks, or context about the drawing.',
    `confidentiality_classification` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for the drawing.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the drawing record was first created in the system.',
    `discipline` STRING COMMENT 'Engineering discipline or trade responsible for the drawing (e.g., architectural, structural, MEP). [ENUM-REF-CANDIDATE: architectural|structural|mechanical|electrical|plumbing|civil|geotechnical|environmental — 8 candidates stripped; promote to reference product]',
    `distribution_list` STRING COMMENT 'Comma-separated list of roles, organizations, or individuals to whom the drawing was distributed.',
    `drawing_number` STRING COMMENT 'Unique alphanumeric identifier assigned to the drawing per project drawing numbering convention. Serves as the business key for the drawing register.',
    `drawing_status` STRING COMMENT 'Current lifecycle status of the drawing (e.g., draft, issued for review, issued for construction, approved, superseded, archived). [ENUM-REF-CANDIDATE: draft|issued_for_review|issued_for_approval|issued_for_construction|approved|superseded|archived — 7 candidates stripped; promote to reference product]',
    `drawing_type` STRING COMMENT 'Classification of the drawing by its representation type (e.g., plan, elevation, section, detail, schedule, isometric).. Valid values are `plan|elevation|section|detail|schedule|isometric`',
    `file_format` STRING COMMENT 'Digital file format of the drawing (e.g., PDF, DWG, DXF, RVT, IFC, DGN).. Valid values are `PDF|DWG|DXF|RVT|IFC|DGN`',
    `file_size_mb` DECIMAL(18,2) COMMENT 'Size of the drawing file in megabytes.',
    `is_client_deliverable` BOOLEAN COMMENT 'Boolean flag indicating whether the drawing is a contractual deliverable to the client.',
    `is_controlled_document` BOOLEAN COMMENT 'Boolean flag indicating whether the drawing is subject to formal document control procedures.',
    `issue_purpose` STRING COMMENT 'Purpose for which the drawing was issued (e.g., for information, for review, for approval, for construction, for tender, as-built).. Valid values are `information|review|approval|construction|tender|as_built`',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language in which the drawing annotations are written.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified the drawing record in the system.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the drawing record was last modified in the system.',
    `originator` STRING COMMENT 'Name of the organization or firm that created the drawing (e.g., design consultant, engineering firm).',
    `page_count` STRING COMMENT 'Number of pages or sheets in the drawing document.',
    `related_specification_reference` STRING COMMENT 'Reference to the technical specification document that corresponds to this drawing.',
    `retention_period_years` STRING COMMENT 'Number of years the drawing must be retained per contractual, regulatory, or organizational policy.',
    `revision_date` DATE COMMENT 'Date when the current revision of the drawing was issued.',
    `revision_number` STRING COMMENT 'Current revision identifier of the drawing (e.g., A, B, C, 01, 02). Tracks version history.',
    `scale` STRING COMMENT 'Scale ratio of the drawing (e.g., 1:100, 1:50, NTS for not to scale).',
    `sheet_size` STRING COMMENT 'Standard paper or sheet size of the drawing (e.g., A0, A1, ARCH D, ARCH E). [ENUM-REF-CANDIDATE: A0|A1|A2|A3|A4|ARCH_D|ARCH_E — 7 candidates stripped; promote to reference product]',
    `storage_location` STRING COMMENT 'File path or URI indicating where the drawing file is stored in the document management system.',
    `superseded_by_drawing_number` STRING COMMENT 'Drawing number of the newer version that supersedes this drawing.',
    `supersedes_drawing_number` STRING COMMENT 'Drawing number of the previous version that this drawing supersedes or replaces.',
    `title` STRING COMMENT 'Descriptive title of the drawing indicating the scope, location, or system depicted.',
    `wbs_code` STRING COMMENT 'Work Breakdown Structure code linking the drawing to a specific project work package or deliverable.',
    `zone_location` STRING COMMENT 'Physical zone, building, or location within the project site that the drawing depicts.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created the drawing record in the system.',
    CONSTRAINT pk_drawing PRIMARY KEY(`drawing_id`)
) COMMENT 'Master record for each engineering and construction drawing (CAD/BIM-derived) managed across the project. Tracks drawing number, title, discipline, sheet size, scale, revision number, current status (issued for construction, issued for review, superseded), originator, and approval state. Serves as the SSOT for the drawing register aligned with Autodesk BIM 360 document control.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`drawing_revision` (
    `drawing_revision_id` BIGINT COMMENT 'Unique identifier for each drawing revision event. Primary key for the drawing revision record.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the individual with authority who approved this revision for issuance. Final checkpoint in the quality control process.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project this drawing revision is associated with. Enables project-level filtering and reporting.',
    `drawing_id` BIGINT COMMENT 'Reference to the parent drawing document that this revision belongs to. Links to the master drawing record in the document management system.',
    `primary_drawing_employee_id` BIGINT COMMENT 'Reference to the engineer or designer who prepared and issued this revision. Establishes accountability for the technical content.',
    `reviewer_employee_id` BIGINT COMMENT 'Reference to the individual who performed technical review of this revision prior to approval. Part of the quality assurance workflow.',
    `rfi_id` BIGINT COMMENT 'Foreign key linking to design.rfi. Business justification: Provides a second inbound link to RFI from drawing_revision, consolidating the existing string reference into a proper FK.',
    `superseded_revision_drawing_revision_id` BIGINT COMMENT 'Reference to the previous revision that this revision replaces or supersedes. Maintains the version control chain and audit trail.',
    `acknowledgment_required_flag` BOOLEAN COMMENT 'Indicates whether recipients are required to formally acknowledge receipt and review of this revision. Used for critical or contractual revisions.',
    `acknowledgment_status` STRING COMMENT 'Current status of acknowledgment from recipients. Tracks whether required acknowledgments have been received.. Valid values are `not_required|pending|acknowledged|overdue`',
    `approval_date` DATE COMMENT 'Date when this revision received formal approval for issuance. Marks the transition from draft to approved status.',
    `approver_name` STRING COMMENT 'Full name of the individual who approved this revision. Provides human-readable identification for the approval authority.',
    `bim_model_reference` STRING COMMENT 'Reference identifier to the BIM model or IFC file that this 2D drawing revision is derived from or coordinated with. Maintains linkage between 3D models and 2D deliverables.',
    `change_summary` STRING COMMENT 'Brief summary of the key changes introduced in this revision. Provides quick reference for stakeholders reviewing revision history.',
    `clash_detection_status` STRING COMMENT 'Status of clash detection analysis for this revision. Indicates whether the design has been checked for spatial conflicts with other disciplines and the outcome.. Valid values are `not_required|pending|in_progress|passed|failed|resolved`',
    `comments` STRING COMMENT 'Additional notes, remarks, or contextual information about this revision. Provides space for supplementary details not captured in structured fields.',
    `confidentiality_level` STRING COMMENT 'Security classification level of this drawing revision. Controls access permissions and distribution restrictions.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this revision record was first created in the data management system. Audit trail for data lineage.',
    `discipline` STRING COMMENT 'The engineering or design discipline responsible for this drawing revision. Enables discipline-based filtering and workflow routing. [ENUM-REF-CANDIDATE: architectural|structural|mechanical|electrical|plumbing|civil|geotechnical|environmental|surveying|landscape — 10 candidates stripped; promote to reference product]',
    `distribution_date` DATE COMMENT 'Date when this revision was distributed to project stakeholders. Marks the formal communication of the revision to the project team.',
    `distribution_method` STRING COMMENT 'The method or channel used to distribute this revision to stakeholders. Tracks whether distribution was electronic, physical, or both.. Valid values are `electronic|hard_copy|both|portal|email`',
    `distribution_status` STRING COMMENT 'Current state of the distribution process for this revision. Tracks whether the revision has been sent to stakeholders and their acknowledgment status.. Valid values are `pending|distributed|acknowledged|rejected|superseded`',
    `file_format` STRING COMMENT 'The digital file format of this revision (e.g., PDF for distribution, DWG for CAD native, IFC for BIM exchange). Supports format-based filtering and compatibility checks. [ENUM-REF-CANDIDATE: PDF|DWG|DXF|IFC|RVT|DGN|TIFF — 7 candidates stripped; promote to reference product]',
    `file_size_mb` DECIMAL(18,2) COMMENT 'Size of the revision file in megabytes. Used for storage management and transmission planning.',
    `issuing_engineer_name` STRING COMMENT 'Full name of the engineer who prepared and issued this revision. Provides human-readable identification for audit and communication purposes.',
    `linked_change_order_number` STRING COMMENT 'Reference number of the change order that authorized or necessitated this revision. Establishes traceability between contract changes and design updates.',
    `linked_submittal_number` STRING COMMENT 'Reference number of the submittal package associated with this revision. Links design revisions to material or equipment submittals.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this revision record was last updated. Tracks the most recent change to the record for audit and synchronization purposes.',
    `review_date` DATE COMMENT 'Date when the technical review of this revision was completed. Tracks the review milestone in the approval workflow.',
    `reviewer_name` STRING COMMENT 'Full name of the individual who reviewed this revision. Provides human-readable identification for the review step in the approval workflow.',
    `revision_code` STRING COMMENT 'Alphanumeric code identifying the specific revision version (e.g., A, B, C, P01, P02 for preliminary, C01 for construction issue). Follows project-specific or organizational revision coding standards.. Valid values are `^[A-Z0-9]{1,10}$`',
    `revision_date` DATE COMMENT 'The date when this revision was officially issued or released. Represents the business event timestamp for the revision lifecycle.',
    `revision_description` STRING COMMENT 'Detailed narrative describing the specific changes, modifications, or updates made in this revision. Provides context for what was altered from the previous version.',
    `revision_number` STRING COMMENT 'Sequential numeric identifier for the revision within the drawing lifecycle. Increments with each new revision to maintain chronological order.',
    `revision_reason` STRING COMMENT 'Categorical classification of the business driver or trigger that necessitated this revision. Enables analysis of revision patterns and root causes. [ENUM-REF-CANDIDATE: rfi_response|design_change|client_instruction|coordination_issue|code_compliance|value_engineering|constructability_review|error_correction|scope_change|material_substitution|site_condition|regulatory_requirement — 12 candidates stripped; promote to reference product]',
    `revision_status` STRING COMMENT 'Current state of the revision in its approval and distribution workflow. Tracks progression from draft through review, approval, issuance, and eventual supersession. [ENUM-REF-CANDIDATE: draft|in_review|approved|issued|superseded|void|archived — 7 candidates stripped; promote to reference product]',
    `revision_type` STRING COMMENT 'Classification of the intended purpose or stage of the revision within the project lifecycle. Distinguishes between preliminary design, construction issue, as-built documentation, etc. [ENUM-REF-CANDIDATE: preliminary|for_approval|for_construction|for_tender|as_built|record|coordination — 7 candidates stripped; promote to reference product]',
    `sheet_count` STRING COMMENT 'Number of sheets or pages in this drawing revision. Relevant for multi-sheet drawings and printing logistics.',
    `transmittal_number` STRING COMMENT 'Reference number of the transmittal package through which this revision was formally issued. Links the revision to its distribution record.',
    `wbs_code` STRING COMMENT 'The WBS element or work package code that this drawing revision is associated with. Enables project structure-based reporting and cost allocation.',
    CONSTRAINT pk_drawing_revision PRIMARY KEY(`drawing_revision_id`)
) COMMENT 'Transactional record capturing each revision event for a drawing. Stores revision code, revision date, description of changes, reason for revision (RFI-driven, design change, client instruction), issuing engineer, reviewer, approver, and distribution status. Enables full version-control audit trail for IFC/CAD drawing lifecycle.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`technical_specification` (
    `technical_specification_id` BIGINT COMMENT 'Unique identifier for the technical specification document. Primary key for this entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Enables Specification‑to‑Contract mapping required for compliance verification and cost control.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project this technical specification belongs to. Links specification to project scope and WBS (Work Breakdown Structure).',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Technical specifications list required materials; FK to material_master supports compliance checks and sourcing.',
    `applicable_standards` STRING COMMENT 'Comma-separated list of industry standards, codes, and regulations that govern this specification (e.g., ACI 318, AISC 360, NFPA 70, ASTM C150, BS EN 1992).',
    `approval_date` DATE COMMENT 'Date when the specification received formal approval from the designated approval authority (client, design manager, or regulatory body).',
    `approval_status` STRING COMMENT 'Formal approval state indicating whether the specification has received necessary sign-offs from design authority, client, or regulatory bodies.. Valid values are `pending|approved|rejected|conditional|not_required`',
    `approver_name` STRING COMMENT 'Name of the individual with authority who formally approved this specification for issue and use in construction.',
    `approver_role` STRING COMMENT 'Role or position of the approver (e.g., Lead Structural Engineer, Design Manager, Client Representative, QA/QC Manager).',
    `author_name` STRING COMMENT 'Name of the engineer or technical specialist who authored or prepared this specification document.',
    `author_organization` STRING COMMENT 'Organization or company responsible for authoring the specification (e.g., design consultant, engineering firm, EPC contractor).',
    `boq_reference` STRING COMMENT 'Reference to BOQ line items or sections that are governed by this technical specification, linking design requirements to cost estimation and procurement.',
    `comments` STRING COMMENT 'Additional notes, clarifications, or context regarding this specification, including change reasons, special instructions, or coordination notes.',
    `confidentiality_classification` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for this specification document.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this specification record was first created in the system, supporting audit trail and data lineage.',
    `csi_division` STRING COMMENT 'CSI MasterFormat division number (e.g., Division 03 - Concrete, Division 23 - HVAC) organizing specifications by construction work results.',
    `discipline` STRING COMMENT 'Engineering discipline or trade category to which this specification applies. Used for organizing specifications by technical domain within MEP (Mechanical Electrical and Plumbing) and other construction disciplines. [ENUM-REF-CANDIDATE: civil|structural|architectural|mechanical|electrical|plumbing|hvac|instrumentation|process|geotechnical|environmental — 11 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date from which this specification becomes binding and applicable to construction activities, procurement, and quality control.',
    `environmental_requirements` STRING COMMENT 'Environmental compliance requirements including LEED (Leadership in Energy and Environmental Design) criteria, sustainability standards, emissions limits, and waste management provisions.',
    `file_format` STRING COMMENT 'Digital file format of the specification document (e.g., PDF, DOCX, native CAD format). [ENUM-REF-CANDIDATE: pdf|docx|doc|xlsx|dwg|ifc|native — 7 candidates stripped; promote to reference product]',
    `file_storage_path` STRING COMMENT 'Network path, document management system location, or cloud storage URI where the specification document file is stored (e.g., Aconex document ID, BIM 360 path).',
    `hse_requirements` STRING COMMENT 'Health, safety, and environmental requirements specific to this specification including PPE (Personal Protective Equipment), hazard controls, and OSHA compliance.',
    `is_client_deliverable` BOOLEAN COMMENT 'Flag indicating whether this specification is a contractual deliverable to the client or owner, requiring formal submission and acceptance.',
    `issue_date` DATE COMMENT 'Date when the current revision of the technical specification was formally issued or published to the project team.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language in which the specification is written (e.g., EN for English, FR for French, AR for Arabic).',
    `material_requirements` STRING COMMENT 'Detailed requirements for materials including grades, properties, certifications, and acceptance criteria (e.g., concrete strength class C30/37, steel grade S355, ASTM A615 Grade 60 rebar).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this specification record, tracking change history and currency of information.',
    `page_count` STRING COMMENT 'Total number of pages in the specification document, used for document management and completeness verification.',
    `related_drawing_references` STRING COMMENT 'Comma-separated list of CAD (Computer-Aided Design) drawing numbers or BIM (Building Information Modeling) model references that illustrate or complement this specification.',
    `reviewer_name` STRING COMMENT 'Name of the individual who performed technical review or quality check of the specification before approval.',
    `revision_number` STRING COMMENT 'Current revision identifier for the specification document, tracking version history and change control (e.g., Rev 0, Rev A, Rev 1.2).',
    `scope_of_work` STRING COMMENT 'Detailed description of the work, materials, equipment, or systems covered by this technical specification, defining boundaries and inclusions.',
    `section_number` STRING COMMENT 'Detailed section number within CSI MasterFormat or project specification structure (e.g., 03 30 00 for Cast-in-Place Concrete, 23 05 13 for Common Motor Requirements for HVAC Equipment).',
    `specification_number` STRING COMMENT 'Unique business identifier for the technical specification document, typically following organizational or project numbering conventions (e.g., SPEC-MEP-001, TS-2024-HVAC-05).',
    `specification_title` STRING COMMENT 'Full descriptive title of the technical specification document, clearly identifying the scope of work, materials, or systems covered.',
    `specification_type` STRING COMMENT 'Classification of specification approach: performance-based (outcome-focused), prescriptive (method-focused), proprietary (brand-specific), reference (standard-based), or master (template).. Valid values are `performance|prescriptive|proprietary|reference|master`',
    `submittal_requirements` STRING COMMENT 'List of required submittals including shop drawings, product data, samples, test reports, and certifications that must be provided for approval.',
    `superseded_date` DATE COMMENT 'Date when this specification was replaced by a newer revision or cancelled, marking the end of its active lifecycle.',
    `supersedes_specification_number` STRING COMMENT 'Specification number of the previous version that this revision replaces, maintaining document lineage and change history.',
    `technical_specification_status` STRING COMMENT 'Current lifecycle status of the technical specification document within the document control workflow. [ENUM-REF-CANDIDATE: draft|in_review|approved|issued_for_construction|superseded|archived|cancelled — 7 candidates stripped; promote to reference product]',
    `testing_requirements` STRING COMMENT 'Required tests, inspections, and acceptance criteria including FAT (Factory Acceptance Test), SAT (Site Acceptance Test), and ITP (Inspection and Test Plan) references.',
    `warranty_period_months` STRING COMMENT 'Duration in months for which materials, equipment, or workmanship covered by this specification must be warranted, typically aligned with DLP (Defects Liability Period).',
    `wbs_code` STRING COMMENT 'WBS element code linking this specification to specific project deliverables, work packages, or cost accounts for scope and budget management.',
    `workmanship_standards` STRING COMMENT 'Standards and requirements for execution, installation, fabrication, and construction methods to ensure quality workmanship.',
    CONSTRAINT pk_technical_specification PRIMARY KEY(`technical_specification_id`)
) COMMENT 'Master record for each technical specification document governing materials, workmanship, and construction methods. Captures spec number, title, discipline, applicable standards (ACI, AISC, NFPA), revision status, approval state, and scope of work section reference. Linked to WBS elements and BOQ line items for design-build scope management.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`package` (
    `package_id` BIGINT COMMENT 'Unique identifier for the design deliverable package. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract under which this deliverable package is required.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project this package belongs to.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Package creation is assigned to a specific employee; required for responsibility tracking in project reports.',
    `actual_submission_date` DATE COMMENT 'Actual date when the package was submitted to the client or reviewing authority.',
    `approval_date` DATE COMMENT 'Date when the package received final internal approval for issuance.',
    `approval_workflow_state` STRING COMMENT 'Current state of the internal approval workflow for this package before external submission. [ENUM-REF-CANDIDATE: not_started|in_progress|pending_review|pending_approval|approved|rejected|on_hold — 7 candidates stripped; promote to reference product]',
    `approved_by` STRING COMMENT 'Name of the individual with authority who approved the package for issuance.',
    `bim_model_reference` STRING COMMENT 'Reference identifier or file path to the BIM model associated with this package.',
    `client_acceptance_date` DATE COMMENT 'Date when the client formally accepted the package.',
    `client_acceptance_status` STRING COMMENT 'Client or authority acceptance decision status for the submitted package.. Valid values are `pending|accepted|accepted_with_comments|rejected|conditionally_accepted|superseded`',
    `comments` STRING COMMENT 'Additional notes, remarks, or instructions related to this package.',
    `completeness_percentage` DECIMAL(18,2) COMMENT 'Percentage of required deliverable items completed within this package (0.00 to 100.00).',
    `confidentiality_classification` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for this package.. Valid values are `public|internal|confidential|restricted`',
    `contractual_due_date` DATE COMMENT 'Contractually mandated deadline for package submission to client or authority.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this package record was first created in the system.',
    `discipline` STRING COMMENT 'Primary engineering or design discipline responsible for this package. [ENUM-REF-CANDIDATE: architectural|structural|mechanical|electrical|plumbing|civil|geotechnical|environmental|multidisciplinary — 9 candidates stripped; promote to reference product]',
    `document_count` STRING COMMENT 'Total number of documents (drawings, specifications, reports, models) included in this package.',
    `drawing_count` STRING COMMENT 'Number of CAD drawings included in this package.',
    `iso_19650_compliance_flag` BOOLEAN COMMENT 'Indicates whether this package complies with ISO 19650 information management standards.',
    `issue_date` DATE COMMENT 'Date when the package was formally issued to recipients or stakeholders.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this package record was last updated or modified.',
    `milestone_stage` STRING COMMENT 'Design milestone stage at which this package is issued. IFC = Issued for Construction, IFD = Issued for Design. [ENUM-REF-CANDIDATE: concept|preliminary|30_percent|60_percent|90_percent|ifc|ifd|as_built — 8 candidates stripped; promote to reference product]',
    `package_number` STRING COMMENT 'Business identifier for the design deliverable package, typically following project numbering conventions (e.g., PKG-001, DP-2023-045).',
    `package_status` STRING COMMENT 'Current lifecycle status of the design deliverable package in the approval and submission workflow. [ENUM-REF-CANDIDATE: draft|in_review|approved|issued|submitted|accepted|rejected|superseded|cancelled — 9 candidates stripped; promote to reference product]',
    `package_type` STRING COMMENT 'Classification of the package based on its purpose and content type within the project lifecycle.. Valid values are `design_package|deliverable_package|submittal_package|handover_package|as_built_package|coordination_package`',
    `planned_issue_date` DATE COMMENT 'Originally scheduled date for package issuance as per project baseline schedule.',
    `recipient_distribution_list` STRING COMMENT 'Comma-separated list of organizations or individuals to whom this package is distributed.',
    `rejection_reason` STRING COMMENT 'Explanation provided by client or reviewer for package rejection or conditional acceptance.',
    `responsible_organization` STRING COMMENT 'Name of the organization (contractor, consultant, JV partner) responsible for preparing this package.',
    `reviewed_by` STRING COMMENT 'Name of the individual or team who performed technical review of the package.',
    `revision_number` STRING COMMENT 'Revision identifier for this package version (e.g., Rev 0, Rev A, Rev 1).',
    `specification_count` STRING COMMENT 'Number of technical specifications included in this package.',
    `storage_location` STRING COMMENT 'File system path, document management system location, or cloud storage URI where the package files are stored.',
    `submission_status` STRING COMMENT 'Current status of the package submission to client or reviewing authority.. Valid values are `not_submitted|submitted|under_review|resubmission_required|accepted|rejected`',
    `supersedes_package_number` STRING COMMENT 'Package number of the previous version that this package replaces or supersedes.',
    `title` STRING COMMENT 'Descriptive title of the design deliverable package indicating its scope and content.',
    `transmittal_number` STRING COMMENT 'Reference number of the transmittal document used to formally issue this package.',
    `wbs_code` STRING COMMENT 'Work Breakdown Structure code linking this package to the project cost and schedule hierarchy.',
    CONSTRAINT pk_package PRIMARY KEY(`package_id`)
) COMMENT 'Master record representing a formal design deliverable package issued at a project milestone (30%, 60%, 90%, IFC, As-Built). Groups related drawings, specifications, calculations, and BIM models into a contractual issuance unit. Tracks package number, milestone stage, discipline, issue date, contractual due date, recipient distribution list, submission status, client acceptance status, and approval workflow state. Also serves as the contractual deliverable register (DDR), tracking each required deliverable item with its type (drawing, specification, report, model, calculation), responsible discipline, milestone linkage, planned vs. actual submission dates, and client acceptance status. SSOT for design deliverable scheduling, contractual compliance monitoring, and milestone gate readiness assessment.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`clash_detection_run` (
    `clash_detection_run_id` BIGINT COMMENT 'Unique identifier for the clash detection run. Primary key for the clash detection run entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Associates clash detection results with the contract to assess compliance with design coordination clauses.',
    `comparison_run_id` BIGINT COMMENT 'Reference to a previous clash detection run against which this run is being compared to track resolution progress.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this clash detection run was executed.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the BIM analyst or coordinator who executed the clash detection run.',
    `accepted_clashes_count` STRING COMMENT 'Number of clashes that have been reviewed and accepted as permissible by the project team.',
    `baseline_run_flag` BOOLEAN COMMENT 'Indicates whether this clash detection run serves as a baseline for future comparison and tracking of clash resolution progress.',
    `building_zone` STRING COMMENT 'Specific building zone, level, or area covered by this clash detection run (e.g., Level 3, Tower A, Basement).',
    `certification_date` DATE COMMENT 'Date when clash-free certification was granted for the analyzed model scope.',
    `clash_free_certification_flag` BOOLEAN COMMENT 'Indicates whether this clash detection run resulted in clash-free certification, confirming construction readiness for the analyzed scope.',
    `clash_tolerance_mm` DECIMAL(18,2) COMMENT 'Minimum clearance distance threshold in millimeters below which elements are flagged as clashing. Defines the sensitivity of clash detection.',
    `clearance_clashes_count` STRING COMMENT 'Number of clearance clashes where elements violate required maintenance or operational access zones.',
    `coordination_milestone` STRING COMMENT 'Project coordination milestone or phase associated with this clash detection run (e.g., Design Development, Construction Documents, Pre-Construction).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this clash detection run record was first created in the system.',
    `critical_clashes_count` STRING COMMENT 'Number of clashes classified as critical severity, requiring immediate resolution before construction.',
    `discipline_pair` STRING COMMENT 'Pair of disciplines being compared in the clash detection run (e.g., Structural vs MEP Piping, Architectural vs HVAC, Electrical vs Plumbing). Multiple pairs may be separated by semicolons.',
    `federated_model_name` STRING COMMENT 'Name of the federated BIM model set used for the clash detection analysis, combining multiple discipline models.',
    `hard_clashes_count` STRING COMMENT 'Number of hard clashes where physical elements directly overlap or intersect, representing actual geometric conflicts.',
    `major_clashes_count` STRING COMMENT 'Number of clashes classified as major severity, requiring resolution during coordination phase.',
    `minor_clashes_count` STRING COMMENT 'Number of clashes classified as minor severity, may be acceptable or require minimal adjustment.',
    `model_version` STRING COMMENT 'Version identifier of the federated BIM model used in the clash detection run.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this clash detection run record was last modified or updated.',
    `new_clashes_count` STRING COMMENT 'Number of new clashes identified in this run that were not present in the comparison baseline run.',
    `notes` STRING COMMENT 'Additional notes, observations, or special conditions documented by the analyst regarding this clash detection run.',
    `open_clashes_count` STRING COMMENT 'Number of clashes currently in open status awaiting review or resolution.',
    `primary_discipline` STRING COMMENT 'Primary discipline being analyzed in the clash detection run (e.g., Structural, Architectural, Mechanical, Electrical, Plumbing).',
    `report_file_path` STRING COMMENT 'File system path or document management system location where the detailed clash detection report is stored.',
    `report_format` STRING COMMENT 'File format of the generated clash detection report.. Valid values are `pdf|html|xml|excel|csv`',
    `resolved_clashes_count` STRING COMMENT 'Number of clashes that have been resolved through design coordination and model updates.',
    `run_date` DATE COMMENT 'Date when the clash detection analysis was executed.',
    `run_duration_minutes` STRING COMMENT 'Total time in minutes required to complete the clash detection analysis processing.',
    `run_name` STRING COMMENT 'Descriptive name for the clash detection run, typically indicating the scope or purpose (e.g., MEP vs Structural - Level 3, Full Model Coordination Check).',
    `run_number` STRING COMMENT 'Business identifier for the clash detection run, typically following project-specific numbering conventions (e.g., CD-001, CD-2024-01-15).',
    `run_status` STRING COMMENT 'Current execution status of the clash detection run in its processing lifecycle.. Valid values are `queued|in_progress|completed|failed|cancelled`',
    `run_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the clash detection analysis was initiated, capturing the exact moment of execution.',
    `secondary_discipline` STRING COMMENT 'Secondary discipline being compared against the primary discipline in the clash detection run.',
    `soft_clashes_count` STRING COMMENT 'Number of soft clashes where elements violate clearance requirements but do not physically intersect.',
    `software_platform` STRING COMMENT 'BIM coordination software platform used to execute the clash detection analysis.. Valid values are `navisworks|bim_360_coordination|solibri|tekla_bimsight|synchro|other`',
    `software_version` STRING COMMENT 'Version number of the BIM coordination software used for the clash detection run (e.g., Navisworks 2024.1, BIM 360 v3.2).',
    `total_clashes_found` STRING COMMENT 'Total number of clash instances identified in this detection run across all severity levels.',
    `wbs_code` STRING COMMENT 'Work Breakdown Structure code identifying the project phase or work package scope for this clash detection run.',
    `workflow_clashes_count` STRING COMMENT 'Number of workflow clashes representing time-based conflicts in 4D construction sequencing.',
    CONSTRAINT pk_clash_detection_run PRIMARY KEY(`clash_detection_run_id`)
) COMMENT 'Transactional record for each clash detection analysis run executed via Navisworks, BIM 360 Coordination, or Solibri. Captures run date, federated model set, discipline pairs compared (e.g., structural vs. MEP piping), clash tolerance settings, total clashes found by severity (critical/major/minor), software version, analyst identity, and run status. Contains individual clash items as child records with clash type (hard/soft/workflow/clearance), element GUIDs, spatial coordinates, severity classification, assigned resolution owner, resolution status (open, in-review, resolved, accepted), resolution description, and closure date. SSOT for all BIM coordination clash data, enabling MEP coordination tracking, interdisciplinary design conflict resolution, and clash-free construction readiness certification.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`review` (
    `review_id` BIGINT COMMENT 'Unique identifier for the design review event. Primary key for the review product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Needed for Review Minutes linking to the contract that defines review scope and client approval requirements.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which this design review belongs.',
    `hr_employee_id` BIGINT COMMENT 'add column hr_employee_id (BIGINT) with FK to hr.hr.employee_id - design reviews need a reviewer of record',
    `action_items_count` STRING COMMENT 'Number of action items or follow-up tasks assigned as a result of this design review.',
    `attendee_count` STRING COMMENT 'Total number of participants who attended the design review event.',
    `attendee_list` STRING COMMENT 'Comma-separated or structured list of names and roles of all participants in the design review event.',
    `bim_model_reference` STRING COMMENT 'Reference identifier to the BIM model or digital twin that was reviewed during this event.',
    `chairperson_name` STRING COMMENT 'Name of the individual who chaired or led the design review meeting.',
    `clash_detection_performed` BOOLEAN COMMENT 'Indicates whether automated clash detection analysis was performed as part of this design review.',
    `clashes_identified_count` STRING COMMENT 'Number of design clashes or conflicts identified during clash detection analysis.',
    `client_approval_date` DATE COMMENT 'Date on which the client formally approved the design following this review.',
    `client_approval_required` BOOLEAN COMMENT 'Indicates whether formal client approval is required as an outcome of this design review.',
    `client_representative_name` STRING COMMENT 'Name of the client representative who participated in or received the results of this design review.',
    `comments_closed_count` STRING COMMENT 'Number of review comments that have been resolved and closed.',
    `comments_open_count` STRING COMMENT 'Number of review comments that remain open and require action.',
    `confidentiality_level` STRING COMMENT 'Data classification level for the design review record and associated documentation.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this design review record was first created in the system.',
    `design_package_reference` STRING COMMENT 'Reference identifier of the design package or document set under review (e.g., package number, drawing set reference).',
    `discipline` STRING COMMENT 'Primary engineering or design discipline that is the focus of this review. [ENUM-REF-CANDIDATE: architectural|structural|mechanical|electrical|plumbing|civil|geotechnical|environmental|multidisciplinary — 9 candidates stripped; promote to reference product]',
    `disposition` STRING COMMENT 'Overall outcome or decision of the design review. Accepted means approved without changes; conditionally accepted requires minor revisions; rejected requires major rework; revise and resubmit requires resubmission after changes.. Valid values are `accepted|conditionally_accepted|rejected|revise_and_resubmit`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the design review meeting or event in hours.',
    `external_reference_code` STRING COMMENT 'Unique identifier for this design review in the source operational system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this design review record was last updated or modified.',
    `major_comments_count` STRING COMMENT 'Number of major or critical comments raised that require mandatory resolution before approval.',
    `meeting_location` STRING COMMENT 'Physical or virtual location where the design review meeting was held (e.g., site office, video conference platform).',
    `minor_comments_count` STRING COMMENT 'Number of minor comments raised that are recommended but not mandatory for approval.',
    `minutes_document_reference` STRING COMMENT 'Reference to the formal meeting minutes or record document for this design review event.',
    `next_review_scheduled_date` DATE COMMENT 'Planned date for the next design review or follow-up review event.',
    `recommendations` STRING COMMENT 'Key recommendations or improvement suggestions arising from the design review.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or authority conducting or overseeing this review (e.g., local building department, environmental agency).',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this design review includes assessment of regulatory or code compliance.',
    `review_date` DATE COMMENT 'The date on which the formal design review event took place.',
    `review_number` STRING COMMENT 'Business identifier for the design review event, typically following project numbering conventions (e.g., DR-001, IDC-2024-05).',
    `review_status` STRING COMMENT 'Current lifecycle status of the design review event.. Valid values are `scheduled|in_progress|completed|cancelled|deferred`',
    `review_type` STRING COMMENT 'Classification of the design review event. Internal peer review is conducted within the design team; Interdisciplinary Check (IDC) validates coordination across disciplines; client milestone review is a formal client gate review; third-party review involves external consultants; authority review is conducted by regulatory bodies; constructability review assesses buildability.. Valid values are `internal_peer_review|interdisciplinary_check|client_milestone_review|third_party_review|authority_review|constructability_review`',
    `scheduled_date` DATE COMMENT 'The originally planned date for the design review event.',
    `sign_off_authority` STRING COMMENT 'Name or role of the individual or body with authority to approve or reject the design at this review stage (e.g., Chief Engineer, Client Representative, Regulatory Authority).',
    `sign_off_date` DATE COMMENT 'Date on which the sign-off authority formally approved or rejected the design package.',
    `stage` STRING COMMENT 'Design completion stage at which the review is conducted. IFC = Issued for Construction; IFD = Issued for Design; stages represent percentage completion milestones. [ENUM-REF-CANDIDATE: concept|30_percent|60_percent|90_percent|ifc|ifd|as_built — 7 candidates stripped; promote to reference product]',
    `summary` STRING COMMENT 'Executive summary or key findings from the design review event.',
    `total_comments_raised` STRING COMMENT 'Total number of review comments or issues raised during this design review event.',
    `wbs_code` STRING COMMENT 'Work Breakdown Structure code identifying the project work package or deliverable associated with this design review.',
    CONSTRAINT pk_review PRIMARY KEY(`review_id`)
) COMMENT 'Transactional record for each formal design review event including internal peer reviews, interdisciplinary checks (IDC), client milestone reviews, and third-party/authority reviews. Captures review type, review date, attendees, design package under review, review stage (30%/60%/90%/IFC), disposition (accepted, conditionally accepted, rejected), and sign-off authority. Contains individual review comments as child records with sequential comment number, category (major/minor/informational), comment text, marked-up reference location, design team response, disposition (accepted, rejected, partially accepted), action owner, and closure status. SSOT for all design review and comment resolution data, supporting design approval workflows, client milestone gate management, and regulatory submission readiness.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`change_notice` (
    `change_notice_id` BIGINT COMMENT 'Unique identifier for the engineering change notice (ECN) or design change notice. Primary key for the change_notice product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Ensures each change notice is tied to the governing agreement for impact analysis and contractual approval workflow.',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Change notices may require amendment of a permit; linking ensures the impacted permit is identified for regulatory follow‑up.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this change notice applies.',
    `bid_contract_agreement_id` BIGINT COMMENT 'Foreign key linking to bid.contract_agreement. Business justification: Change notices often affect subcontractor contracts; FK enables impact analysis, cost tracking, and schedule adjustments per subcontractor.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Change Notice Cost Impact Report requires linking each notice to the specific cost code impacted for budgeting and variance analysis.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Change notices often affect material selections; linking to material_master records the impacted material.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Change notices are originated by a client contact; linking enables change log reporting and responsibility tracking.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Change Notice originator must be linked to an employee for responsibility and impact analysis.',
    `actual_cost_impact_amount` DECIMAL(18,2) COMMENT 'Actual realized financial impact of the change notice after implementation, expressed in the project base currency.',
    `actual_schedule_impact_days` STRING COMMENT 'Actual realized schedule impact in calendar days after implementation of the change notice.',
    `affected_disciplines` STRING COMMENT 'Comma-separated list of all engineering disciplines impacted by this change notice, enabling cross-functional coordination.',
    `affected_drawing_references` STRING COMMENT 'Comma-separated list of drawing numbers and revisions that are impacted or superseded by this change notice.',
    `affected_specification_references` STRING COMMENT 'Comma-separated list of technical specification sections or document references that are modified by this change notice.',
    `approval_authority` STRING COMMENT 'Name or role of the individual or committee with authority to approve or reject this change notice (e.g., Project Manager, Chief Engineer, Change Control Board).',
    `approval_date` DATE COMMENT 'Date on which the change notice was formally approved by the designated approval authority.',
    `bim_model_reference` STRING COMMENT 'Reference to the BIM model file or version that incorporates or is affected by this change notice.',
    `change_notice_number` STRING COMMENT 'The externally-known unique business identifier for this change notice, typically following a project-specific numbering convention (e.g., ECN-2024-001).',
    `change_notice_status` STRING COMMENT 'Current lifecycle status of the change notice in the approval and implementation workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|implemented|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `change_notice_type` STRING COMMENT 'Classification of the change notice by its nature (design change, engineering change, specification change, material substitution, scope change, regulatory change).. Valid values are `design_change|engineering_change|specification_change|material_substitution|scope_change|regulatory_change`',
    `change_order_reference` STRING COMMENT 'Reference number of the formal Change Order (CO) that was generated from this change notice for contractual and financial processing.',
    `clash_detection_impact` STRING COMMENT 'Description of any clash detection issues identified or resolved as a result of this change notice in the BIM coordination process.',
    `client_approval_date` DATE COMMENT 'Date on which the client formally approved this change notice, if client approval was required.',
    `client_approval_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether formal client approval is contractually required for this change notice before implementation.',
    `comments` STRING COMMENT 'Additional notes, remarks, or commentary related to the change notice, including review feedback and coordination notes.',
    `cost_impact_flag` BOOLEAN COMMENT 'Boolean indicator of whether this change notice has a financial cost impact on the project budget.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this change notice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost impact amounts (e.g., USD, EUR, GBP).',
    `date_raised` DATE COMMENT 'Date on which the change notice was formally raised or submitted into the change management system.',
    `change_notice_description` STRING COMMENT 'Detailed narrative describing the design change, including technical rationale, scope of work affected, and justification for the modification.',
    `discipline` STRING COMMENT 'Primary engineering discipline impacted by this change notice (e.g., civil, structural, mechanical, electrical, plumbing, architectural).',
    `estimated_cost_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact of the change notice on project cost, expressed in the project base currency. Positive values indicate cost increases; negative values indicate savings.',
    `estimated_schedule_impact_days` STRING COMMENT 'Estimated number of calendar days by which the project schedule will be extended or accelerated due to this change notice. Positive values indicate delays; negative values indicate acceleration.',
    `implementation_completion_date` DATE COMMENT 'Date on which implementation of the change notice was fully completed and verified.',
    `implementation_start_date` DATE COMMENT 'Date on which implementation of the approved change notice commenced on site or in design documentation.',
    `implementation_status` STRING COMMENT 'Current status of the physical implementation of the approved change notice in the field or design deliverables.. Valid values are `not_started|in_progress|completed|on_hold|cancelled`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this change notice record was last updated or modified in the system.',
    `originating_cause` STRING COMMENT 'Root cause or trigger that necessitated the change notice (client instruction, unforeseen site condition, design error, regulatory requirement, value engineering, constructability improvement).. Valid values are `client_instruction|site_condition|design_error|regulatory_requirement|value_engineering|constructability_improvement`',
    `originator_organization` STRING COMMENT 'Organization or company of the individual who initiated the change notice (e.g., client, contractor, subcontractor, consultant).',
    `priority` STRING COMMENT 'Business priority level indicating urgency and impact of the change notice on project schedule and operations.. Valid values are `critical|high|medium|low`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether this change notice is driven by or impacts regulatory compliance requirements (building codes, safety standards, environmental regulations).',
    `regulatory_reference` STRING COMMENT 'Citation of the specific regulatory code, standard, or requirement that necessitates or is impacted by this change notice.',
    `rejection_date` DATE COMMENT 'Date on which the change notice was formally rejected by the approval authority, if applicable.',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the change notice was rejected, including technical, commercial, or procedural justifications.',
    `schedule_impact_flag` BOOLEAN COMMENT 'Boolean indicator of whether this change notice has an impact on the project schedule or critical path.',
    `title` STRING COMMENT 'Brief descriptive title summarizing the nature of the design or engineering change.',
    `wbs_code` STRING COMMENT 'Work Breakdown Structure code identifying the project work package or deliverable affected by this change notice.',
    CONSTRAINT pk_change_notice PRIMARY KEY(`change_notice_id`)
) COMMENT 'Transactional record capturing each formal design change or engineering change notice (ECN) issued during the project. Tracks change number, originating cause (client instruction, site condition, regulatory requirement, value engineering), affected drawings and specifications, design disciplines impacted, cost and schedule impact assessment, approval authority, and implementation status. Feeds into the CO (Change Order) process.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` (
    `mep_coordination_zone_id` BIGINT COMMENT 'Unique identifier for the MEP coordination zone record. Primary key for spatial coordination zone management.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Links MEP coordination zones to the contract to enforce scope, schedule, and liability clauses.',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent construction project to which this MEP coordination zone belongs.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the MEP coordinator or engineer responsible for managing coordination activities in this zone.',
    `access_constraints` STRING COMMENT 'Description of physical access limitations or restrictions affecting MEP installation in this zone (e.g., occupied areas, limited crane access, working hours restrictions).',
    `actual_completion_date` DATE COMMENT 'Actual date when MEP installation work was completed in this coordination zone.',
    `actual_start_date` DATE COMMENT 'Actual date when MEP installation work commenced in this coordination zone.',
    `available_clearance_m` DECIMAL(18,2) COMMENT 'Calculated vertical clearance available for MEP routing between soffit and ceiling in meters.',
    `bim_model_reference` STRING COMMENT 'Reference identifier or file path to the BIM model containing the 3D coordination data for this zone.',
    `bim_model_version` STRING COMMENT 'Version number or revision identifier of the BIM model associated with this coordination zone.',
    `building_reference` STRING COMMENT 'Identifier of the building or structure within the project where this coordination zone is located.',
    `ceiling_height_m` DECIMAL(18,2) COMMENT 'Maximum ceiling height constraint for the coordination zone in meters, defining the upper vertical boundary for MEP routing.',
    `clash_detection_status` STRING COMMENT 'Status of automated clash detection analysis for this coordination zone, tracking identification and resolution of spatial conflicts.. Valid values are `not_started|in_progress|completed|clashes_detected|clashes_resolved`',
    `contractor_organization` STRING COMMENT 'Name of the contractor or subcontractor organization responsible for MEP installation in this zone.',
    `coordination_meeting_date` DATE COMMENT 'Date of the most recent coordination meeting held to review and resolve conflicts in this zone.',
    `coordination_notes` STRING COMMENT 'General notes and comments related to coordination activities, decisions, and issues for this zone.',
    `coordination_priority_rank` STRING COMMENT 'Numerical ranking indicating the priority order for resolving routing conflicts in this zone (1=highest priority).',
    `coordination_status` STRING COMMENT 'Current lifecycle status of the coordination process for this zone, tracking progress from initial planning through final sign-off.. Valid values are `pending|in_progress|under_review|signed_off|on_hold|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this coordination zone record was first created in the system.',
    `document_reference` STRING COMMENT 'Reference to coordination drawings, specifications, or other documentation associated with this zone.',
    `grid_reference_end` STRING COMMENT 'Ending grid line reference defining the spatial extent of the coordination zone (e.g., C/3 in a grid system).',
    `grid_reference_start` STRING COMMENT 'Starting grid line reference defining the spatial extent of the coordination zone (e.g., A/1 in a grid system).',
    `installation_sequence_number` STRING COMMENT 'Planned sequence order for MEP installation in this zone relative to other zones, enabling clash-free construction sequencing.',
    `level_reference` STRING COMMENT 'Floor or level designation where the coordination zone is located (e.g., L1, L2, B1 for basement, RF for roof).',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this coordination zone record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this coordination zone record was last modified or updated.',
    `open_clash_count` STRING COMMENT 'Number of unresolved spatial clashes remaining in this coordination zone requiring design or routing adjustments.',
    `planned_completion_date` DATE COMMENT 'Scheduled date for completion of MEP installation work in this coordination zone.',
    `planned_start_date` DATE COMMENT 'Scheduled date for commencement of MEP installation work in this coordination zone.',
    `primary_discipline` STRING COMMENT 'The primary MEP discipline that has routing priority or dominance in this coordination zone. [ENUM-REF-CANDIDATE: mechanical|electrical|plumbing|fire_protection|hvac|low_voltage|data_communications — 7 candidates stripped; promote to reference product]',
    `sign_off_authority` STRING COMMENT 'Name or role of the individual or organization with authority to approve and sign off the coordination for this zone.',
    `sign_off_date` DATE COMMENT 'Date when the coordination for this zone was formally approved and signed off by all stakeholders.',
    `soffit_height_m` DECIMAL(18,2) COMMENT 'Minimum soffit or structural underside height in meters, defining the lower vertical boundary constraint for MEP systems.',
    `special_requirements` STRING COMMENT 'Free-text description of any special coordination requirements, constraints, or considerations specific to this zone (e.g., seismic bracing, fire-rated penetrations, access limitations).',
    `total_clash_count` STRING COMMENT 'Total number of spatial clashes or conflicts detected in this coordination zone during BIM clash detection analysis.',
    `wbs_code` STRING COMMENT 'Work Breakdown Structure code linking this coordination zone to the project schedule and cost control hierarchy.',
    `zone_area_sqm` DECIMAL(18,2) COMMENT 'Total floor area covered by this coordination zone in square meters, used for resource planning and density analysis.',
    `zone_complexity_rating` STRING COMMENT 'Qualitative assessment of the coordination complexity in this zone based on system density, clash potential, and installation difficulty.. Valid values are `low|medium|high|critical`',
    `zone_name` STRING COMMENT 'Descriptive name of the coordination zone for human identification and reference in coordination meetings and documentation.',
    `zone_number` STRING COMMENT 'Business identifier for the coordination zone, typically following project-specific numbering conventions (e.g., Z-01, ZONE-A-L3).',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this coordination zone record.',
    CONSTRAINT pk_mep_coordination_zone PRIMARY KEY(`mep_coordination_zone_id`)
) COMMENT 'Master record defining spatial coordination zones used for MEP (Mechanical, Electrical, Plumbing) and fire protection systems coordination on large building and infrastructure projects. Captures zone identifier, building/structure reference, level, grid reference extents, ceiling/soffit height constraints, primary MEP discipline, coordination priority ranking, assigned MEP coordinator, coordination status (pending, in-progress, signed-off), and linked BIM model reference. Enables structured spatial allocation, routing priority resolution, and clash-free MEP installation sequencing.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` (
    `value_engineering_proposal_id` BIGINT COMMENT 'Unique identifier for the value engineering proposal record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Required for VEP evaluation against contract terms, cost‑saving approvals, and schedule impact tracking.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this value engineering proposal was raised.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: VE proposals are evaluated against particular cost codes to quantify savings; linking enables tracking savings per cost code.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: VE proposals evaluate alternative materials; FK captures the material being proposed for substitution.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: VE proposal originator employee is required for cost‑saving accountability.',
    `affected_design_elements` STRING COMMENT 'Comma-separated list or description of design elements, systems, or components impacted by the proposed change (e.g., foundation system, HVAC layout, structural framing).',
    `approval_authority` STRING COMMENT 'Name or role of the individual or committee with authority to approve the value engineering proposal on behalf of the project.',
    `change_order_reference` STRING COMMENT 'Reference to the formal change order document issued to implement the accepted value engineering proposal.',
    `client_decision` STRING COMMENT 'Final decision rendered by the client or project owner regarding the value engineering proposal.. Valid values are `accepted|rejected|deferred|conditional_acceptance|pending`',
    `client_decision_date` DATE COMMENT 'Date on which the client formally communicated their decision on the value engineering proposal.',
    `client_decision_notes` STRING COMMENT 'Notes, conditions, or rationale provided by the client regarding their decision on the value engineering proposal.',
    `client_review_due_date` DATE COMMENT 'Contractual or agreed-upon date by which the client is expected to provide a decision on the value engineering proposal.',
    `client_submission_date` DATE COMMENT 'Date on which the value engineering proposal was formally submitted to the client or project owner for review and decision.',
    `comments` STRING COMMENT 'Additional comments, notes, or observations related to the value engineering proposal from stakeholders or reviewers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the value engineering proposal record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated cost saving and implemented saving value.. Valid values are `^[A-Z]{3}$`',
    `environmental_impact_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the value engineering proposal has environmental implications requiring assessment or regulatory review.',
    `estimated_cost_saving` DECIMAL(18,2) COMMENT 'Estimated financial savings expected from implementing the value engineering proposal, expressed in the project currency.',
    `implementation_completion_date` DATE COMMENT 'Date on which implementation of the value engineering proposal was completed and verified.',
    `implementation_start_date` DATE COMMENT 'Date on which implementation of the accepted value engineering proposal commenced.',
    `implementation_status` STRING COMMENT 'Current status of the implementation of the accepted value engineering proposal in the field or design.. Valid values are `not_started|in_progress|completed|cancelled|on_hold`',
    `implemented_saving_value` DECIMAL(18,2) COMMENT 'Actual financial savings realized from the implemented value engineering proposal, as verified through cost tracking and reconciliation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the value engineering proposal record was last modified or updated.',
    `originator_discipline` STRING COMMENT 'Engineering or functional discipline of the proposal originator. [ENUM-REF-CANDIDATE: civil|structural|architectural|mechanical|electrical|plumbing|geotechnical|environmental|cost_engineering|project_management — 10 candidates stripped; promote to reference product]',
    `originator_organization` STRING COMMENT 'Organization or company to which the proposal originator belongs (e.g., General Contractor, Design Consultant, Subcontractor).',
    `priority` STRING COMMENT 'Priority level assigned to the value engineering proposal based on potential savings, schedule impact, and project phase.. Valid values are `low|medium|high|critical`',
    `proposal_description` STRING COMMENT 'Detailed description of the proposed change, including technical rationale, scope of modification, and expected benefits.',
    `proposal_number` STRING COMMENT 'Externally-known unique business identifier for the value engineering proposal, typically following a project-specific numbering convention.. Valid values are `^VE-[A-Z0-9]{4,12}$`',
    `proposal_status` STRING COMMENT 'Current lifecycle status of the value engineering proposal in the review and approval workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|accepted|rejected|deferred|implemented|withdrawn — 8 candidates stripped; promote to reference product]',
    `proposal_title` STRING COMMENT 'Short descriptive title summarizing the value engineering proposal.',
    `quality_impact_assessment` STRING COMMENT 'Assessment of the impact of the proposed change on project quality, performance, and compliance with specifications.. Valid values are `positive|neutral|negative|requires_further_study`',
    `quality_impact_notes` STRING COMMENT 'Detailed notes explaining the quality impact assessment, including any mitigation measures or testing requirements.',
    `related_drawing_references` STRING COMMENT 'Comma-separated list of drawing numbers or BIM model references affected by or supporting the value engineering proposal.',
    `related_specification_references` STRING COMMENT 'Comma-separated list of technical specification sections or documents affected by the value engineering proposal.',
    `review_date` DATE COMMENT 'Date on which the technical review of the value engineering proposal was completed.',
    `reviewed_by` STRING COMMENT 'Name of the technical reviewer or design authority who evaluated the value engineering proposal for technical feasibility and compliance.',
    `risk_assessment` STRING COMMENT 'Overall risk level associated with implementing the value engineering proposal, considering technical, schedule, cost, and safety factors.. Valid values are `low|medium|high|critical`',
    `risk_description` STRING COMMENT 'Detailed description of identified risks, potential failure modes, and mitigation strategies associated with the proposal.',
    `safety_impact_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the value engineering proposal has any impact on health, safety, and environment (HSE) considerations.',
    `safety_review_notes` STRING COMMENT 'Notes from the HSE review of the proposal, including any required safety measures, permits, or compliance considerations.',
    `schedule_impact_days` STRING COMMENT 'Estimated impact on project schedule in days. Positive values indicate schedule acceleration; negative values indicate delay.',
    `sustainability_rating` STRING COMMENT 'Assessment of the proposals impact on project sustainability goals and LEED or equivalent green building certification.. Valid values are `improved|neutral|reduced|not_applicable`',
    `wbs_code` STRING COMMENT 'Work Breakdown Structure code identifying the project phase, area, or work package to which this value engineering proposal applies.',
    `created_by` STRING COMMENT 'User ID or name of the individual who created the value engineering proposal record in the system.',
    CONSTRAINT pk_value_engineering_proposal PRIMARY KEY(`value_engineering_proposal_id`)
) COMMENT 'Transactional record for each Value Engineering (VE) proposal raised during design development. Captures proposal number, originator, description of proposed change, affected design elements, estimated cost saving, schedule impact, quality impact, risk assessment, client submission date, client decision (accepted, rejected, deferred), and implemented saving value. Supports commercial optimization and design-build scope management.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`design_scope` (
    `design_scope_id` BIGINT COMMENT 'Unique identifier for the design scope record. Primary key for the design scope entity.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract under which this design scope is executed. Links scope to contractual terms and conditions.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this design scope applies. Links scope definition to the parent project.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Scope owner employee is tracked for responsibility and change control.',
    `superseded_by_scope_design_scope_id` BIGINT COMMENT 'Reference to the design scope record that supersedes this one. Used to track scope evolution and replacement.',
    `applicable_codes_standards` STRING COMMENT 'List of engineering codes, standards, and regulations applicable to this design scope by jurisdiction. Includes building codes, safety standards, environmental regulations, and industry-specific technical standards.',
    `approval_authority` STRING COMMENT 'Name or role of the authority responsible for approving this design scope definition and any subsequent changes.',
    `approval_date` DATE COMMENT 'Date on which this design scope package was formally approved by the designated approval authority.',
    `bim_model_reference` STRING COMMENT 'Reference to the BIM model or models associated with this design scope package. Links scope definition to 3D design models.',
    `change_control_baseline` STRING COMMENT 'Reference to the approved baseline version of the scope against which all changes are measured. Used for change order impact assessment.',
    `comments` STRING COMMENT 'Additional notes, clarifications, or commentary regarding this design scope package. Free-text field for supplementary information.',
    `confidentiality_classification` STRING COMMENT 'Data classification level for this design scope package governing access control and distribution restrictions.. Valid values are `Public|Internal|Confidential|Restricted`',
    `contract_type` STRING COMMENT 'Type of contract delivery method governing this design scope. Determines responsibility allocation and workflow. DB=Design-Build, DBB=Design-Bid-Build, EPC=Engineering Procurement Construction, EPCM=Engineering Procurement Construction Management, CM=Construction Management, PPP=Public-Private Partnership, BOT=Build-Operate-Transfer. [ENUM-REF-CANDIDATE: DB|DBB|EPC|EPCM|CM|PPP|BOT|Design-Only — 8 candidates stripped; promote to reference product]',
    `corrosion_allowance_mm` DECIMAL(18,2) COMMENT 'Additional material thickness in millimeters added to account for corrosion over the design life. Critical parameter for piping, structural steel, and equipment design.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this design scope record was first created in the system. Audit trail for record creation.',
    `design_basis_memorandum_reference` STRING COMMENT 'Reference identifier to the Design Basis Memorandum document containing fundamental design parameters and assumptions for this scope.',
    `design_life_years` STRING COMMENT 'Intended operational lifespan of the designed asset in years. Fundamental design parameter governing material selection, durability requirements, and maintenance planning.',
    `design_responsibility_matrix` STRING COMMENT 'Detailed allocation of design responsibilities across owner, contractor, and third-party entities. Structured text or reference defining who designs what within the scope.',
    `discipline` STRING COMMENT 'Primary engineering discipline responsible for this design scope package. Categorizes scope by technical specialty. [ENUM-REF-CANDIDATE: Civil|Structural|Architectural|Mechanical|Electrical|Plumbing|Process|Instrumentation|Multi-Discipline — 9 candidates stripped; promote to reference product]',
    `environmental_design_conditions` STRING COMMENT 'Comprehensive statement of environmental parameters governing design including humidity, precipitation, soil conditions, groundwater, air quality, and other site-specific environmental factors.',
    `exclusions_limitations` STRING COMMENT 'Explicit statement of work, deliverables, or responsibilities excluded from this design scope package. Defines scope boundaries by stating what is NOT included.',
    `fire_rating_requirements` STRING COMMENT 'Fire resistance rating requirements for structural elements, walls, doors, and systems. Specifies duration and performance criteria for fire protection.',
    `freeze_date` DATE COMMENT 'Date on which the design scope was frozen and baselined. After this date, changes require formal change control process.',
    `interface_points` STRING COMMENT 'Identification of interface points with adjacent scope packages, disciplines, or contractors. Defines coordination boundaries and handoff requirements.',
    `iso_19650_compliance_flag` BOOLEAN COMMENT 'Indicates whether this design scope package complies with ISO 19650 information management standards for BIM and digital construction.',
    `jurisdiction` STRING COMMENT 'Geographic or regulatory jurisdiction governing this design scope. Determines which codes, standards, and regulatory requirements apply.',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified this design scope record. Audit trail for accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this design scope record was last updated. Audit trail for tracking changes.',
    `leed_certification_target` STRING COMMENT 'Target LEED certification level for sustainable design. Governs green building design requirements and material selection.. Valid values are `Not Applicable|Certified|Silver|Gold|Platinum`',
    `manager_name` STRING COMMENT 'Name of the individual responsible for managing this design scope package. Primary point of contact for scope-related decisions.',
    `narrative_description` STRING COMMENT 'Comprehensive textual description of the design scope boundaries, deliverables, and work included within this package. Defines what is in scope in narrative form.',
    `owner_organization` STRING COMMENT 'Name of the organization responsible for managing and delivering this design scope package.',
    `package_number` STRING COMMENT 'Business identifier for the design scope package. Externally-known unique code used in contracts, transmittals, and correspondence to reference this scope boundary.',
    `package_title` STRING COMMENT 'Descriptive title of the design scope package providing human-readable identification of the scope boundary.',
    `retention_period_years` STRING COMMENT 'Number of years this design scope record must be retained per regulatory and contractual requirements.',
    `revision_number` STRING COMMENT 'Current revision number of the design scope document. Tracks version history and change iterations.',
    `scope_of_work_id` BIGINT COMMENT 'SSOT reference to canonical contract.contract_scope (single source of truth).',
    `scope_status` STRING COMMENT 'Current lifecycle status of the design scope package. Tracks progression from initial definition through freeze and closure. [ENUM-REF-CANDIDATE: Draft|Under Review|Approved|Frozen|Active|Closed|Superseded — 7 candidates stripped; promote to reference product]',
    `seismic_zone_classification` STRING COMMENT 'Seismic design category or zone classification for the project location. Governs structural design requirements for earthquake resistance.',
    `snow_loading_criteria` STRING COMMENT 'Design snow load parameters and ground snow load values used for structural design in applicable climates.',
    `temperature_range_max_c` DECIMAL(18,2) COMMENT 'Maximum design temperature in degrees Celsius for environmental design conditions. Governs material selection and thermal design.',
    `temperature_range_min_c` DECIMAL(18,2) COMMENT 'Minimum design temperature in degrees Celsius for environmental design conditions. Governs material selection and thermal design.',
    `wbs_code` STRING COMMENT 'Work Breakdown Structure code linking this design scope to the project WBS hierarchy. Enables cost tracking and schedule integration.',
    `wind_loading_criteria` STRING COMMENT 'Design wind speed, exposure category, and wind loading parameters used for structural calculations. Fundamental environmental design condition.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this design scope record. Audit trail for accountability.',
    CONSTRAINT pk_design_scope PRIMARY KEY(`design_scope_id`)
) COMMENT 'Master record defining design scope boundaries and design basis parameters for each project or work package, particularly for Design-Build (DB), EPC, and EPCM contracts. Captures scope package identifier, scope narrative description, design responsibility matrix (owner vs. contractor vs. third-party), applicable codes and standards by jurisdiction, exclusions and limitations, interface points with adjacent scope packages, scope freeze date, and change control baseline. Includes Design Basis Memorandum (DBM) content: fundamental design parameters such as design life, seismic zone classification, wind/snow loading criteria, temperature ranges, corrosion allowances, fire rating requirements, and environmental design conditions that govern all downstream engineering calculations. SSOT for DB scope management, design basis definition, design responsibility allocation, and scope change impact assessment. [SSOT: distinct source of truth for design domain]';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`interface_point` (
    `interface_point_id` BIGINT COMMENT 'Unique identifier for the interface point record. Primary key for the interface point entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Provides contract linkage for interface point registers to manage handover responsibilities and liability.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Interface Point approval authority is an employee; required for interface management records.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this interface point belongs.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Each interface point is coordinated by a designated craft worker responsible for trade coordination (Interface Coordination Procedure).',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Interface points can generate cost impacts; mapping to cost code allows impact tracking in cost reports.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Interface points coordinate work between design and a subcontractor; linking records the responsible subcontractor for coordination meetings and clash resolution.',
    `actual_handover_date` DATE COMMENT 'Actual date when the interface was handed over from the originating party to the receiving party. Used for schedule performance tracking.',
    `bim_model_reference` STRING COMMENT 'Reference to the BIM model or federated model element that represents this interface point. Used for 3D coordination and clash detection.',
    `clash_detection_status` STRING COMMENT 'Status of BIM clash detection activities for this interface point. Indicates whether spatial conflicts have been identified and resolved.. Valid values are `not-applicable|pending|in-progress|resolved|unresolved`',
    `closure_date` DATE COMMENT 'Date when the interface point was formally closed, indicating all coordination activities are complete and both parties have accepted the interface.',
    `comments` STRING COMMENT 'Additional comments, notes, or observations regarding the interface point. Used for capturing context, lessons learned, or special instructions.',
    `coordination_meeting_frequency` STRING COMMENT 'Agreed frequency of coordination meetings between the originating and receiving parties to manage this interface point.. Valid values are `daily|weekly|bi-weekly|monthly|as-needed|none`',
    `cost_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual cost impact associated with this interface point in the project base currency. Includes additional costs, variations, or claims resulting from interface coordination issues.',
    `cost_impact_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this interface point has resulted in cost impacts, variations, or claims. True if cost impact exists, false otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interface point record was first created in the system. Used for audit trail and data lineage.',
    `discipline` STRING COMMENT 'Primary engineering discipline associated with this interface point (e.g., civil, structural, MEP). For cross-discipline interfaces, indicates the lead or primary discipline. [ENUM-REF-CANDIDATE: civil|structural|architectural|mechanical|electrical|plumbing|instrumentation|multi-discipline — 8 candidates stripped; promote to reference product]',
    `interface_agreement_date` DATE COMMENT 'Date on which the interface requirements and responsibilities were formally agreed between the originating and receiving parties.',
    `interface_category` STRING COMMENT 'Categorization of the interface by project phase or organizational boundary (e.g., design-to-design, design-to-construction, construction-to-commissioning, internal discipline, external contractor).. Valid values are `design-design|design-construction|construction-construction|construction-commissioning|internal|external`',
    `interface_description` STRING COMMENT 'Detailed description of the interface point including scope, technical requirements, coordination needs, and any special conditions or constraints.',
    `interface_freeze_date` DATE COMMENT 'Agreed date by which the interface definition must be frozen to allow downstream work to proceed without further changes. Critical for schedule management in multi-package projects.',
    `interface_number` STRING COMMENT 'Business identifier for the interface point, typically following project numbering conventions (e.g., IF-001, INT-MEP-001). Used for external communication and documentation.',
    `interface_status` STRING COMMENT 'Current lifecycle status of the interface point: open (identified but not yet coordinated), under-review (being negotiated), agreed (parties have agreed on interface requirements), frozen (locked for execution), closed (interface successfully handed over), or disputed (conflict requiring resolution).. Valid values are `open|under-review|agreed|frozen|closed|disputed`',
    `interface_title` STRING COMMENT 'Descriptive title or name of the interface point summarizing the interface scope (e.g., Structural-MEP Coordination at Level 3, Civil-Electrical Handover at Substation).',
    `interface_type` STRING COMMENT 'Classification of the interface point by nature: physical (spatial/geometric coordination), functional (operational dependencies), data (information exchange), contractual (scope boundaries), or organizational (responsibility handoffs).. Valid values are `physical|functional|data|contractual|organizational`',
    `location_description` STRING COMMENT 'Physical location description of the interface point within the project site or facility (e.g., Level 3 Grid E-F, Substation Building North Wall, Chainage 12+500).',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this interface point record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this interface point record was last modified. Used for audit trail and change tracking.',
    `originating_party_contact_email` STRING COMMENT 'Email address of the originating party contact for interface coordination communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `originating_party_contact_name` STRING COMMENT 'Name of the individual responsible for managing the interface from the originating party side.',
    `originating_party_organization` STRING COMMENT 'Name of the organization or contractor responsible for the originating side of the interface (e.g., ABC Engineering Ltd, XYZ Construction JV).',
    `originating_scope_package` STRING COMMENT 'Identifier of the work package, discipline, or contractor scope that originates or provides the interface (e.g., Civil Works Package, MEP-Electrical, Structural Steel Contractor).',
    `outstanding_actions` STRING COMMENT 'Summary of any outstanding actions, issues, or dependencies that must be resolved before the interface can be closed. Includes action owners and target dates.',
    `planned_handover_date` DATE COMMENT 'Planned date for the physical or informational handover of the interface from the originating party to the receiving party.',
    `priority` STRING COMMENT 'Business priority level of the interface point based on project criticality, schedule impact, and risk. Critical interfaces require immediate attention and executive oversight.. Valid values are `critical|high|medium|low`',
    `receiving_party_contact_email` STRING COMMENT 'Email address of the receiving party contact for interface coordination communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `receiving_party_contact_name` STRING COMMENT 'Name of the individual responsible for managing the interface from the receiving party side.',
    `receiving_party_organization` STRING COMMENT 'Name of the organization or contractor responsible for the receiving side of the interface (e.g., DEF Mechanical Ltd, GHI Commissioning Services).',
    `receiving_scope_package` STRING COMMENT 'Identifier of the work package, discipline, or contractor scope that receives or depends on the interface (e.g., Architectural Finishes, MEP-Mechanical, Commissioning Team).',
    `related_drawing_references` STRING COMMENT 'Comma-separated list of drawing numbers or document references that define or illustrate this interface point.',
    `related_rfi_numbers` STRING COMMENT 'Comma-separated list of RFI numbers related to this interface point. Links interface coordination to formal information requests.',
    `risk_level` STRING COMMENT 'Assessed risk level associated with this interface point based on technical complexity, schedule criticality, organizational dependencies, and potential for disputes.. Valid values are `very-high|high|medium|low|very-low`',
    `schedule_impact_days` STRING COMMENT 'Estimated or actual number of days of schedule impact caused by delays or issues with this interface point. Used for Extension of Time (EOT) claims and schedule performance analysis.',
    `wbs_code` STRING COMMENT 'Work Breakdown Structure code linking this interface point to the project WBS hierarchy for cost and schedule tracking.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this interface point record. Used for audit trail and accountability.',
    CONSTRAINT pk_interface_point PRIMARY KEY(`interface_point_id`)
) COMMENT 'Master record managing design interface points between different project scopes, disciplines, or contractor packages. Captures interface identifier, interface type (physical, functional, data), originating scope package, receiving scope package, interface description, responsible parties, agreed interface freeze date, interface status (open, agreed, frozen, closed), and outstanding actions. Critical for EPC and multi-package infrastructure projects.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`calculation_register` (
    `calculation_register_id` BIGINT COMMENT 'System generated unique identifier for each calculation register record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Associates engineering calculations with the contract for verification of design assumptions and compliance.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the engineer who approved the calculation.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which the calculation belongs.',
    `emission_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_factor. Business justification: Calculations for carbon impact require an emission factor; the calculation register records which factor is used for regulatory carbon reporting.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Calculations (e.g., load, thermal) depend on material properties; FK ties each calculation to its material master.',
    `primary_calculation_employee_id` BIGINT COMMENT 'Identifier of the engineer who authored the calculation.',
    `analysis_software` STRING COMMENT 'Software tool used to perform the calculation (e.g., ETABS, SAFE, Revit, ANSYS).',
    `approval_date` DATE COMMENT 'Date on which the calculation was formally approved.',
    `approver_name` STRING COMMENT 'Full name of the approving engineer.',
    `author_name` STRING COMMENT 'Full name of the calculation author.',
    `calculation_number` STRING COMMENT 'Business identifier assigned to the engineering calculation (e.g., CAL-2023-001).',
    `calculation_purpose` STRING COMMENT 'Primary purpose of the calculation (e.g., structural member sizing, hydraulic analysis).. Valid values are `member_sizing|hydraulic_analysis|load_study|heat_load|fire_hydraulics|other`',
    `checker_name` STRING COMMENT 'Full name of the independent checker.',
    `creation_timestamp` TIMESTAMP COMMENT 'Timestamp when the calculation register record was created.',
    `design_code` STRING COMMENT 'Applicable design code or standard referenced by the calculation (e.g., AISC, ASCE, Eurocode).',
    `discipline` STRING COMMENT 'Engineering discipline to which the calculation belongs.. Valid values are `structural|hydraulic|electrical|hvac|fire_protection|civil`',
    `document_reference` STRING COMMENT 'Reference identifier linking to the associated design document in the document register.',
    `effective_date` DATE COMMENT 'Date when the calculation results become effective for design decisions.',
    `expiration_date` DATE COMMENT 'Date after which the calculation is considered superseded or obsolete.',
    `input_assumptions` STRING COMMENT 'Key assumptions and input data used in the calculation.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the calculation contains confidential information.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the calculation.',
    `result_units` STRING COMMENT 'Units associated with the result value (e.g., kN, m³/s).',
    `result_value` DECIMAL(18,2) COMMENT 'Numeric outcome of the calculation (e.g., load magnitude, member capacity).',
    `revision_number` STRING COMMENT 'Sequential revision number of the calculation document.',
    `revision_status` STRING COMMENT 'Current status of the calculation revision.. Valid values are `draft|checked|approved|superseded`',
    `title` STRING COMMENT 'Descriptive title of the calculation document.',
    `wbs_code` STRING COMMENT 'Work Breakdown Structure element code associated with the calculation.',
    CONSTRAINT pk_calculation_register PRIMARY KEY(`calculation_register_id`)
) COMMENT 'Master record for each engineering calculation document produced during design phases. Captures calculation number, title, discipline, calculation purpose (structural member sizing, hydraulic analysis, electrical load study, HVAC heat load, fire protection hydraulics), applicable design codes and standards, analysis software used, input assumptions, author, independent checker (per four-eyes principle), approver, revision status, approval date, and calculation status (draft, checked, approved, superseded). Provides full traceability between design decisions and their supporting engineering calculations as required for professional engineer (PE/CEng) sign-off, regulatory submissions, and ISO 9001 design verification evidence.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`equipment_installation` (
    `equipment_installation_id` BIGINT COMMENT 'Primary key for the equipment_installation association',
    `asset_id` BIGINT COMMENT 'Reference to the equipment asset being installed',
    `construction_project_id` BIGINT COMMENT '',
    `drawing_id` BIGINT COMMENT 'Reference to the drawing containing the installation',
    `hr_employee_id` BIGINT COMMENT 'add column hr_employee_id (BIGINT) with FK to hr.hr.employee_id - installations require a responsible engineer',
    `technical_specification_id` BIGINT COMMENT 'add column technical_specification_id (BIGINT) with FK to design.technical_specification.technical_specification_id - installations are governed by technical specifications',
    `wbs_element_id` BIGINT COMMENT 'add column wbs_element_id (BIGINT) with FK to project.wbs_element.wbs_element_id - equipment installations roll up to WBS for cost/progress tracking',
    `actual_date` DATE COMMENT '',
    `actual_install_date` DATE COMMENT '',
    `actual_installation_date` DATE COMMENT 'Actual installation date.',
    `as_built_ref` STRING COMMENT '',
    `commissioning_date` DATE COMMENT '',
    `commissioning_required` BOOLEAN COMMENT 'Whether commissioning is required.',
    `commissioning_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `elevation` DECIMAL(18,2) COMMENT '',
    `elevation_level` STRING COMMENT '',
    `inspection_status` STRING COMMENT '',
    `installation_date` DATE COMMENT '',
    `installation_location` STRING COMMENT 'Coordinate or area on the drawing where the asset is placed',
    `installation_method` STRING COMMENT '',
    `installation_status` STRING COMMENT '',
    `installed_by` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `location_ref` STRING COMMENT '',
    `location_reference` STRING COMMENT '',
    `mounting_type` STRING COMMENT '',
    `notes` STRING COMMENT '',
    `orientation` STRING COMMENT '',
    `planned_date` DATE COMMENT '',
    `planned_install_date` DATE COMMENT '',
    `planned_installation_date` DATE COMMENT 'Planned installation date.',
    `quantity` STRING COMMENT 'Number of units of the asset installed as shown on the drawing',
    `remarks` STRING COMMENT '',
    `tag_number` STRING COMMENT '',
    `test_status` STRING COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `verification_date` DATE COMMENT '',
    `verification_status` STRING COMMENT '',
    `verified_by` STRING COMMENT '',
    CONSTRAINT pk_equipment_installation PRIMARY KEY(`equipment_installation_id`)
) COMMENT 'Associative entity capturing the installation of equipment assets as referenced in engineering drawings. Each record links one drawing to one asset and stores the location on the drawing and quantity installed.. Existence Justification: A drawing defines the layout of a construction site and can reference many equipment assets that need to be installed. Conversely, a single equipment asset (e.g., a crane) can appear on multiple drawings for different phases or locations. The installation relationship is actively managed by design and field teams and includes attributes such as installation location on the drawing and quantity installed.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` (
    `interface_equipment_assignment_id` BIGINT COMMENT 'Primary key for the interface_equipment_assignment association',
    `asset_id` BIGINT COMMENT 'Foreign key linking to the equipment asset',
    `construction_project_id` BIGINT COMMENT 'add column construction_project_id (BIGINT) with FK to project.construction_project.construction_project_id - interface assignments are project-scoped',
    `interface_point_id` BIGINT COMMENT 'Foreign key linking to the interface point',
    `assigned_date` DATE COMMENT '',
    `assignment_date` DATE COMMENT '',
    `assignment_role` STRING COMMENT '',
    `assignment_status` STRING COMMENT '',
    `assignment_type` STRING COMMENT '',
    `connection_type` STRING COMMENT '',
    `coordination_notes` STRING COMMENT '',
    `coordination_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `installation_date` DATE COMMENT 'Date the asset was installed or became operational at the interface point',
    `interface_equipment_assignment_status` STRING COMMENT '',
    `interface_notes` STRING COMMENT 'Notes on the interface assignment.',
    `interface_role` STRING COMMENT '',
    `interface_status` STRING COMMENT '',
    `interface_type` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `remarks` STRING COMMENT '',
    `resolution_date` DATE COMMENT '',
    `resolved_date` DATE COMMENT '',
    `responsibility_party` STRING COMMENT '',
    `responsible_discipline` STRING COMMENT '',
    `responsible_party` STRING COMMENT '',
    `role_in_interface` STRING COMMENT 'The functional role of the asset within the interface (e.g., installer, temporary support)',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `verified_flag` BOOLEAN COMMENT '',
    CONSTRAINT pk_interface_equipment_assignment PRIMARY KEY(`interface_equipment_assignment_id`)
) COMMENT 'Represents the assignment of equipment assets to design interface points. Each record captures which asset is linked to which interface point, the role the asset plays in the interface (e.g., installer, temporary support), and the date the asset was installed at the interface.. Existence Justification: An interface point can involve multiple pieces of equipment (e.g., cranes, pumps) and a single equipment item can be used at multiple interface points across projects. The business actively records which assets are assigned to each interface point, the role each asset plays, and the installation date, making the relationship a managed many‑to‑many entity.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`change_impact` (
    `change_impact_id` BIGINT COMMENT 'Primary key for the change_impact association',
    `asset_id` BIGINT COMMENT 'FK to the equipment asset impacted by the change',
    `change_notice_id` BIGINT COMMENT 'FK to the change notice that creates the impact',
    `construction_project_id` BIGINT COMMENT '',
    `affected_discipline` STRING COMMENT '',
    `assessed_by` STRING COMMENT '',
    `assessed_date` DATE COMMENT 'Date impact was assessed.',
    `assessment_date` DATE COMMENT '',
    `change_impact_status` STRING COMMENT '',
    `cost_impact` DECIMAL(18,2) COMMENT '',
    `cost_impact_amount` DECIMAL(18,2) COMMENT 'Monetary cost impact of the change on the specific asset',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `disposition` STRING COMMENT '',
    `impact_category` STRING COMMENT '',
    `impact_description` STRING COMMENT 'Narrative describing how the change affects the specific asset',
    `impact_severity` STRING COMMENT '',
    `impact_status` STRING COMMENT '',
    `impact_type` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `mitigation_action` STRING COMMENT '',
    `mutator_note` STRING COMMENT 'Added by mutator',
    `remarks` STRING COMMENT 'Additional remarks.',
    `schedule_impact_days` STRING COMMENT '',
    `scope_impact` STRING COMMENT '',
    `scope_impact_desc` STRING COMMENT '',
    `severity` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    CONSTRAINT pk_change_impact PRIMARY KEY(`change_impact_id`)
) COMMENT 'Represents the operational link between a design change notice and an equipment asset, capturing the specific impact description and cost associated with that asset for the given change.. Existence Justification: A design change notice can affect many pieces of equipment, and a single piece of equipment can be impacted by many change notices over its lifecycle. The business records the impact details (description, cost) for each notice‑asset pair, and users actively create, update, and delete these records as part of change management.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` (
    `zone_equipment_allocation_id` BIGINT COMMENT 'Primary key for the zone_equipment_allocation association',
    `asset_id` BIGINT COMMENT 'Foreign key linking to the equipment asset',
    `construction_project_id` BIGINT COMMENT 'add column construction_project_id (BIGINT) with FK to project.construction_project.construction_project_id - zone allocations are project-scoped',
    `mep_coordination_zone_id` BIGINT COMMENT 'Foreign key linking to the MEP coordination zone',
    `access_requirement` STRING COMMENT '',
    `allocated_by` STRING COMMENT '',
    `allocated_date` DATE COMMENT '',
    `allocated_quantity` DECIMAL(18,2) COMMENT '',
    `allocation_date` DATE COMMENT '',
    `allocation_status` STRING COMMENT '',
    `asset_position` STRING COMMENT 'Describes the spatial position or location of the asset within the coordination zone (e.g., grid reference, floor level)',
    `clash_count` STRING COMMENT 'Number of clashes detected.',
    `clash_status` STRING COMMENT '',
    `clearance_requirement` DECIMAL(18,2) COMMENT 'Minimum clearance height or space required for the asset to operate safely within the zone',
    `clearance_verified` BOOLEAN COMMENT '',
    `coordination_notes` STRING COMMENT 'Notes from MEP coordination.',
    `coordination_priority` STRING COMMENT '',
    `coordination_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `elevation` DECIMAL(18,2) COMMENT '',
    `is_clash_resolved` BOOLEAN COMMENT 'Whether clashes for this allocation are resolved.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `orientation` STRING COMMENT '',
    `quantity` DECIMAL(18,2) COMMENT '',
    `quantity_allocated` DECIMAL(18,2) COMMENT '',
    `remarks` STRING COMMENT 'Additional remarks.',
    `responsible_discipline` STRING COMMENT '',
    `responsible_party` STRING COMMENT '',
    `spatial_coordination_notes` STRING COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `zone_capacity_used` DECIMAL(18,2) COMMENT '',
    `zone_ref` STRING COMMENT '',
    `zone_reference` STRING COMMENT '',
    CONSTRAINT pk_zone_equipment_allocation PRIMARY KEY(`zone_equipment_allocation_id`)
) COMMENT 'Represents the assignment of construction equipment assets to MEP coordination zones. Each record captures the specific position of the asset within the zone and any clearance requirements, enabling planners to manage equipment usage across zones over time.. Existence Justification: A MEP coordination zone defines a spatial area where mechanical, electrical, and plumbing work is planned. Equipment assets such as cranes, lifts, and generators are scheduled to operate in multiple zones over the project timeline, and a single asset can be assigned to different zones at different times. The assignment, including asset position within the zone and clearance requirements, is actively managed by coordinators as a distinct business process.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`drawing_requirement` (
    `drawing_requirement_id` BIGINT COMMENT 'Primary key for the drawing_requirement association',
    `activity_id` BIGINT COMMENT 'Foreign key linking to the activity',
    `construction_project_id` BIGINT COMMENT 'add column construction_project_id (BIGINT) with FK to project.construction_project.construction_project_id - drawing requirements are project-scoped',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to the drawing',
    `technical_specification_id` BIGINT COMMENT 'add column technical_specification_id (BIGINT) with FK to design.technical_specification.technical_specification_id - requirements typically reference specifications',
    `created_timestamp` TIMESTAMP COMMENT '',
    `dependency_type` STRING COMMENT 'Type of schedule dependency between drawing and activity (FS, SS, FF, SF)',
    `drawing_requirement_description` STRING COMMENT '',
    `drawing_requirement_status` STRING COMMENT '',
    `due_date` DATE COMMENT '',
    `is_critical` BOOLEAN COMMENT '',
    `lag_days` STRING COMMENT 'Lag time in days associated with the dependency',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `mandatory_flag` BOOLEAN COMMENT '',
    `notes` STRING COMMENT '',
    `priority` STRING COMMENT '',
    `remarks` STRING COMMENT 'Additional remarks.',
    `required_by_date` DATE COMMENT '',
    `required_date` DATE COMMENT '',
    `requirement_description` STRING COMMENT '',
    `requirement_status` STRING COMMENT '',
    `requirement_type` STRING COMMENT '',
    `responsible_party` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `verification_date` DATE COMMENT '',
    `verification_status` STRING COMMENT '',
    `verified_by` STRING COMMENT '',
    CONSTRAINT pk_drawing_requirement PRIMARY KEY(`drawing_requirement_id`)
) COMMENT 'Represents the link between a design drawing and a schedule activity, capturing how the drawing supports the activity and the scheduling dependency details.. Existence Justification: In construction projects a single drawing (e.g., structural or architectural) is referenced by many schedule activities, and each activity may require multiple drawings. Planners actively create, update, and delete these links as part of schedule development, and the link carries attributes such as dependency type and lag days.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` (
    `drawing_incident_link_id` BIGINT COMMENT 'Primary key for the drawing_incident_link association',
    `construction_project_id` BIGINT COMMENT 'add column construction_project_id (BIGINT) with FK to project.construction_project.construction_project_id - drawing incident links are project-scoped',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to the drawing',
    `incident_id` BIGINT COMMENT 'Foreign key linking to the incident',
    `created_timestamp` TIMESTAMP COMMENT '',
    `drawing_incident_link_status` STRING COMMENT '',
    `impact_description` STRING COMMENT '',
    `is_root_cause` BOOLEAN COMMENT 'Whether the drawing is a root cause of the incident.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `link_date` DATE COMMENT '',
    `link_description` STRING COMMENT '',
    `link_reason` STRING COMMENT '',
    `link_status` STRING COMMENT 'Status of link.',
    `link_type` STRING COMMENT '',
    `linked_by` STRING COMMENT '',
    `linked_date` DATE COMMENT 'Date linked.',
    `notes` STRING COMMENT '',
    `reference_notes` STRING COMMENT 'Free‑form notes describing why the drawing was referenced for the incident',
    `relevance` STRING COMMENT '',
    `relevance_description` STRING COMMENT '',
    `relevance_note` STRING COMMENT '',
    `remarks` STRING COMMENT 'Additional remarks.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    CONSTRAINT pk_drawing_incident_link PRIMARY KEY(`drawing_incident_link_id`)
) COMMENT 'Represents the operational link between an engineering drawing and a safety incident. Each record captures which drawing was referenced for a given incident and includes notes specific to that reference.. Existence Justification: A safety incident can reference multiple engineering drawings to pinpoint hazard locations, and a single drawing can be cited by many incidents over the life of a project. The safety team creates and maintains explicit links between drawings and incidents, adding notes per link.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`workflow_template` (
    `workflow_template_id` BIGINT COMMENT 'Primary key for workflow_template',
    `construction_project_id` BIGINT COMMENT 'add column construction_project_id (BIGINT) with FK to project.construction_project.construction_project_id - workflow templates are typically project-scoped configurations',
    `parent_workflow_template_id` BIGINT COMMENT 'Self-referencing FK on workflow_template (parent_workflow_template_id)',
    `approval_required` BOOLEAN COMMENT 'True if the workflow must pass an approval step before execution.',
    `average_step_duration_minutes` STRING COMMENT 'Typical duration of a single step, used for planning and scheduling.',
    `workflow_template_code` STRING COMMENT 'External code or short identifier used to reference the template in project documentation.',
    `compliance_requirements` STRING COMMENT 'Comma‑separated list of regulatory or internal compliance standards the workflow must satisfy (e.g., ISO 9001, OSHA).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the template record was first created.',
    `default_assignee_role` STRING COMMENT 'Standard role assigned to handle the workflow when instantiated.',
    `workflow_template_description` STRING COMMENT 'Detailed textual description of the workflow purpose and scope.',
    `documentation_url` STRING COMMENT 'Link to the detailed procedural documentation or BIM model associated with the template.',
    `effective_from` DATE COMMENT 'Date when the template becomes valid for use.',
    `effective_until` DATE COMMENT 'Date when the template expires or is superseded (null if open‑ended).',
    `escalation_policy` STRING COMMENT 'Policy that defines how escalations are handled for overdue steps.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this template is the default choice for new projects.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Date and time when the template was last reviewed for relevance and compliance.',
    `max_concurrent_instances` STRING COMMENT 'Maximum number of projects that may run this workflow simultaneously.',
    `workflow_template_name` STRING COMMENT 'Human‑readable name of the workflow template.',
    `notification_enabled` BOOLEAN COMMENT 'Indicates whether automatic notifications are sent during workflow execution.',
    `retention_period_days` STRING COMMENT 'Number of days the workflow execution history is retained for audit purposes.',
    `reviewed_by` STRING COMMENT 'Name or identifier of the person who performed the most recent review.',
    `risk_level` STRING COMMENT 'Assessed risk associated with executing the workflow.',
    `step_count` STRING COMMENT 'Total number of discrete steps defined in the workflow.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the template record.',
    `version_number` STRING COMMENT 'Incremental version of the template for change management.',
    `workflow_template_status` STRING COMMENT 'Current lifecycle state of the template.',
    `workflow_template_type` STRING COMMENT 'Category of the workflow (e.g., design, approval, construction).',
    CONSTRAINT pk_workflow_template PRIMARY KEY(`workflow_template_id`)
) COMMENT 'Master reference table for workflow_template. Referenced by workflow_template_id.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`engineering_submittal` (
    `engineering_submittal_id` BIGINT COMMENT 'Unique identifier for the design submittal record. Primary key for the design submittal entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Links each submittal to its contract for tracking submission deadlines and contractual obligations.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Equipment Submittal Review requires associating each design submittal with the specific equipment asset it documents.',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Design submittals are submitted for permit approval; associating each submittal with its permit tracks compliance status.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this submittal belongs.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Design submittal is generated from a specific drawing, may be triggered by an RFI and sent via a transmittal; replace free‑text references with FKs.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Submittals are associated with cost items; linking to cost code supports cost allocation and audit of submitted items.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Material submittals reference specific material master records for approval and traceability.',
    `rfi_id` BIGINT COMMENT 'Foreign key linking to design.rfi. Business justification: Link submittal to the originating RFI for clear traceability of query‑response flow.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Submittal submitter employee is recorded for responsibility and traceability.',
    `trade_package_id` BIGINT COMMENT 'Foreign key linking to bid.trade_package. Business justification: Submittal process is tied to a specific trade package; linking enables verification of subcontractor responsibility and audit of submission compliance.',
    `transmittal_id` BIGINT COMMENT 'Foreign key linking to design.transmittal. Business justification: Link submittal to the transmittal that delivered it, enabling end‑to‑end document flow tracking.',
    `actual_review_date` DATE COMMENT 'Actual date on which the review was completed and the submittal disposition was communicated back to the submitting party.',
    `actual_submission_date` DATE COMMENT 'Actual date on which the submittal was formally submitted to the reviewing authority, used for schedule performance tracking and SLA compliance.',
    `approval_authority_level` STRING COMMENT 'Classification of the approval authority indicating the organizational level or role responsible for final disposition: contractor for internal review, design_consultant for technical design review, client for owner acceptance, regulatory_authority for statutory compliance, independent_verifier for third-party certification.. Valid values are `contractor|design_consultant|client|regulatory_authority|independent_verifier`',
    `approval_disposition` STRING COMMENT 'Final disposition code assigned by the reviewing authority indicating the outcome of the review: approved for full acceptance without changes, approved_as_noted for conditional acceptance with minor comments that do not require resubmission, revise_and_resubmit for rework and formal resubmission required, rejected for non-compliance requiring major revision, no_exception_taken for acknowledgment without formal approval, reviewed_for_information for informational submittals not requiring approval.. Valid values are `approved|approved_as_noted|revise_and_resubmit|rejected|no_exception_taken|reviewed_for_information`',
    `approver_name` STRING COMMENT 'Full name of the individual with approval authority who formally authorized the submittal disposition, may be the same as reviewer or a senior authority depending on approval matrix.',
    `attachment_count` STRING COMMENT 'Number of supporting documents, drawings, data sheets, or files attached to this submittal, used for completeness verification and document control.',
    `bim_model_reference` STRING COMMENT 'Reference to the BIM model element, object identifier, or model file that this submittal relates to, enabling integration between physical submittals and digital BIM coordination.',
    `closure_date` DATE COMMENT 'Date on which the submittal was formally closed, indicating that all review cycles are complete, all comments are addressed, and the item is approved for construction or procurement.',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for this submittal: public for unrestricted information, internal for company-internal use, confidential for business-sensitive information, restricted for highly sensitive or proprietary data.. Valid values are `public|internal|confidential|restricted`',
    `cost_impact_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this submittal has potential cost implications, such as value engineering proposals, material substitutions, or design changes affecting project budget.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this submittal record was first created in the document management system, used for audit trail and record lifecycle tracking.',
    `discipline` STRING COMMENT 'Engineering or design discipline responsible for this submittal, used for routing and review assignment. [ENUM-REF-CANDIDATE: architectural|structural|mechanical|electrical|plumbing|civil|geotechnical|environmental — 8 candidates stripped; promote to reference product]',
    `estimated_cost_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact (positive or negative) associated with this submittal, expressed in the project base currency. Positive values indicate cost increases, negative values indicate savings.',
    `file_format` STRING COMMENT 'Primary file format of the submittal package, indicating the digital format used for submission (PDF for documents, DWG/DXF for CAD drawings, RVT for Revit models, IFC for BIM exchange, XLSX for spreadsheets, DOCX for text documents, ZIP for compressed packages). [ENUM-REF-CANDIDATE: PDF|DWG|DXF|RVT|IFC|XLSX|DOCX|ZIP — 8 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp recording the most recent update to this submittal record, used for change tracking and audit trail purposes.',
    `priority` STRING COMMENT 'Priority classification indicating the urgency and schedule impact of this submittal: critical for items on the critical path requiring immediate review, high for near-term procurement or construction activities, medium for standard schedule items, low for long-lead or informational items.. Valid values are `critical|high|medium|low`',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or statutory authority whose approval or compliance verification is required for this submittal (e.g., local building department, fire marshal, environmental agency).',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this submittal requires verification of compliance with statutory regulations, building codes, or regulatory authority approvals (e.g., OSHA, EPA, local building department).',
    `required_submission_date` DATE COMMENT 'Contractually mandated or schedule-driven date by which the submittal must be submitted to the design team or client for review, typically derived from the project schedule and procurement lead times.',
    `response_notes` STRING COMMENT 'Response notes provided by the submitting party addressing reviewer comments, documenting how comments were incorporated or providing justification for alternative approaches.',
    `review_comments` STRING COMMENT 'Detailed technical comments, observations, and instructions provided by the reviewing authority during the review process, documenting required corrections, clarifications, or conditions of approval.',
    `review_due_date` DATE COMMENT 'Target date by which the reviewing authority (design consultant, client representative) is expected to complete their review and return the submittal with disposition, typically governed by contract SLA terms.',
    `reviewer_name` STRING COMMENT 'Full name of the individual who performed the technical review and assigned the disposition for this submittal.',
    `reviewing_organization` STRING COMMENT 'Name of the organization responsible for reviewing and approving this submittal, typically the design consultant, architect, or client representative.',
    `revision_number` STRING COMMENT 'Revision identifier for this submittal, incremented with each resubmission following review comments or rejection, typically using alphanumeric convention (e.g., A, B, C or 01, 02, 03).',
    `schedule_impact_days` STRING COMMENT 'Number of calendar days by which the project schedule would be delayed if this submittal is not approved by the review due date, used for schedule risk analysis.',
    `schedule_impact_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether delays in reviewing or approving this submittal will impact the project critical path or key milestone dates.',
    `specification_section` STRING COMMENT 'Reference to the technical specification section that governs this submittal, typically using CSI MasterFormat division and section numbering (e.g., 03 30 00 for Cast-in-Place Concrete, 23 05 00 for HVAC).',
    `submittal_number` STRING COMMENT 'Unique business identifier for the submittal within the project, typically following a project-specific numbering convention (e.g., S-001, SUB-MEP-001).',
    `submittal_status` STRING COMMENT 'Current lifecycle status of the submittal in the review and approval workflow. Draft indicates preparation phase, submitted indicates formal lodgment, under_review indicates active evaluation, approved indicates full acceptance, approved_as_noted indicates conditional acceptance with minor comments, revise_and_resubmit indicates rework required, rejected indicates non-compliance, withdrawn indicates contractor cancellation, superseded indicates replacement by newer revision. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|approved_as_noted|revise_and_resubmit|rejected|withdrawn|superseded — 9 candidates stripped; promote to reference product]',
    `submittal_type` STRING COMMENT 'Classification of the submittal item indicating the nature of the submission: shop drawings for fabrication details, product data sheets for material specifications, physical samples for approval, method statements for construction procedures, mix designs for concrete/asphalt, calculations for structural/MEP systems, or test reports for quality verification. [ENUM-REF-CANDIDATE: shop_drawing|product_data|sample|method_statement|mix_design|calculation|test_report — 7 candidates stripped; promote to reference product]',
    `submitting_organization` STRING COMMENT 'Name of the contractor, subcontractor, or supplier organization responsible for preparing and submitting this submittal.',
    `supersedes_submittal_number` STRING COMMENT 'Reference to the previous submittal number that this revision supersedes, establishing the revision chain and audit trail.',
    `title` STRING COMMENT 'Descriptive title of the submittal item identifying the material, product, or system being submitted for review.',
    `wbs_code` STRING COMMENT 'Work Breakdown Structure code linking this submittal to a specific work package or deliverable within the project hierarchy, enabling cost and schedule integration.',
    CONSTRAINT pk_engineering_submittal PRIMARY KEY(`engineering_submittal_id`)
) COMMENT 'Transactional record for each design-phase submittal item tracking contractor-submitted shop drawings, material data sheets, product samples, and method statements through the review and approval lifecycle. Includes register-level metadata (specification section, required submission date, contractual obligation) and item-level tracking (submission date, review status, approval authority, disposition). [SSOT: distinct source of truth for design domain]';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ADD CONSTRAINT `fk_design_correspondence_parent_correspondence_id` FOREIGN KEY (`parent_correspondence_id`) REFERENCES `vibe_construction_v1`.`design`.`correspondence`(`correspondence_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `vibe_construction_v1`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `vibe_construction_v1`.`design`.`document_register`(`document_register_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_superseded_revision_id` FOREIGN KEY (`superseded_revision_id`) REFERENCES `vibe_construction_v1`.`design`.`revision`(`revision_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `vibe_construction_v1`.`design`.`document_register`(`document_register_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_workflow_template_id` FOREIGN KEY (`workflow_template_id`) REFERENCES `vibe_construction_v1`.`design`.`workflow_template`(`workflow_template_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `vibe_construction_v1`.`design`.`document_register`(`document_register_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_handover_package_id` FOREIGN KEY (`handover_package_id`) REFERENCES `vibe_construction_v1`.`design`.`handover_package`(`handover_package_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ADD CONSTRAINT `fk_design_correspondence_response_correspondence_id` FOREIGN KEY (`correspondence_id`) REFERENCES `vibe_construction_v1`.`design`.`correspondence`(`correspondence_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ADD CONSTRAINT `fk_design_correspondence_response_supersedes_response_correspondence_response_id` FOREIGN KEY (`supersedes_response_correspondence_response_id`) REFERENCES `vibe_construction_v1`.`design`.`correspondence_response`(`correspondence_response_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ADD CONSTRAINT `fk_design_transmittal_item_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `vibe_construction_v1`.`design`.`document_register`(`document_register_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ADD CONSTRAINT `fk_design_transmittal_item_transmittal_id` FOREIGN KEY (`transmittal_id`) REFERENCES `vibe_construction_v1`.`design`.`transmittal`(`transmittal_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ADD CONSTRAINT `fk_design_distribution_matrix_superseded_by_matrix_distribution_matrix_id` FOREIGN KEY (`superseded_by_matrix_distribution_matrix_id`) REFERENCES `vibe_construction_v1`.`design`.`distribution_matrix`(`distribution_matrix_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ADD CONSTRAINT `fk_design_distribution_matrix_workflow_template_id` FOREIGN KEY (`workflow_template_id`) REFERENCES `vibe_construction_v1`.`design`.`workflow_template`(`workflow_template_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ADD CONSTRAINT `fk_design_access_permission_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `vibe_construction_v1`.`design`.`document_register`(`document_register_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ADD CONSTRAINT `fk_design_access_permission_parent_permission_access_permission_id` FOREIGN KEY (`parent_permission_access_permission_id`) REFERENCES `vibe_construction_v1`.`design`.`access_permission`(`access_permission_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ADD CONSTRAINT `fk_design_bim_model_superseded_by_model_bim_model_id` FOREIGN KEY (`superseded_by_model_bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `vibe_construction_v1`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_superseded_revision_drawing_revision_id` FOREIGN KEY (`superseded_revision_drawing_revision_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing_revision`(`drawing_revision_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ADD CONSTRAINT `fk_design_clash_detection_run_comparison_run_id` FOREIGN KEY (`comparison_run_id`) REFERENCES `vibe_construction_v1`.`design`.`clash_detection_run`(`clash_detection_run_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ADD CONSTRAINT `fk_design_design_scope_superseded_by_scope_design_scope_id` FOREIGN KEY (`superseded_by_scope_design_scope_id`) REFERENCES `vibe_construction_v1`.`design`.`design_scope`(`design_scope_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ADD CONSTRAINT `fk_design_equipment_installation_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ADD CONSTRAINT `fk_design_equipment_installation_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ADD CONSTRAINT `fk_design_interface_equipment_assignment_interface_point_id` FOREIGN KEY (`interface_point_id`) REFERENCES `vibe_construction_v1`.`design`.`interface_point`(`interface_point_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ADD CONSTRAINT `fk_design_change_impact_change_notice_id` FOREIGN KEY (`change_notice_id`) REFERENCES `vibe_construction_v1`.`design`.`change_notice`(`change_notice_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ADD CONSTRAINT `fk_design_zone_equipment_allocation_mep_coordination_zone_id` FOREIGN KEY (`mep_coordination_zone_id`) REFERENCES `vibe_construction_v1`.`design`.`mep_coordination_zone`(`mep_coordination_zone_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ADD CONSTRAINT `fk_design_drawing_requirement_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ADD CONSTRAINT `fk_design_drawing_requirement_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ADD CONSTRAINT `fk_design_drawing_incident_link_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ADD CONSTRAINT `fk_design_workflow_template_parent_workflow_template_id` FOREIGN KEY (`parent_workflow_template_id`) REFERENCES `vibe_construction_v1`.`design`.`workflow_template`(`workflow_template_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ADD CONSTRAINT `fk_design_engineering_submittal_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ADD CONSTRAINT `fk_design_engineering_submittal_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `vibe_construction_v1`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ADD CONSTRAINT `fk_design_engineering_submittal_transmittal_id` FOREIGN KEY (`transmittal_id`) REFERENCES `vibe_construction_v1`.`design`.`transmittal`(`transmittal_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`design` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_construction_v1`.`design` SET TAGS ('pii_domain' = 'design');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` SET TAGS ('pii_subdomain' = 'document_control');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `correspondence_id` SET TAGS ('pii_business_glossary_term' = 'Correspondence Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `parent_correspondence_id` SET TAGS ('pii_business_glossary_term' = 'Parent Correspondence Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Sender Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `attachment_count` SET TAGS ('pii_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `body_text` SET TAGS ('pii_business_glossary_term' = 'Correspondence Body Text');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `closure_date` SET TAGS ('pii_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `closure_status` SET TAGS ('pii_business_glossary_term' = 'Closure Status');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `closure_status` SET TAGS ('pii_value_regex' = 'open|closed_accepted|closed_rejected|closed_superseded');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `confidential_flag` SET TAGS ('pii_business_glossary_term' = 'Confidential Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `correspondence_date` SET TAGS ('pii_business_glossary_term' = 'Correspondence Date');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `correspondence_number` SET TAGS ('pii_business_glossary_term' = 'Correspondence Number');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `correspondence_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `correspondence_status` SET TAGS ('pii_business_glossary_term' = 'Correspondence Status');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `correspondence_status` SET TAGS ('pii_value_regex' = 'draft|issued|acknowledged|responded|closed|cancelled');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `correspondence_type` SET TAGS ('pii_business_glossary_term' = 'Correspondence Type');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `correspondence_type` SET TAGS ('pii_value_regex' = 'rfi|instruction|notice|claim|letter|memo');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `distribution_list` SET TAGS ('pii_business_glossary_term' = 'Distribution List');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Correspondence Priority');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `received_date` SET TAGS ('pii_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `recipient_email` SET TAGS ('pii_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `recipient_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `recipient_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `recipient_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `recipient_name` SET TAGS ('pii_business_glossary_term' = 'Recipient Name');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `recipient_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `recipient_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `recipient_organization` SET TAGS ('pii_business_glossary_term' = 'Recipient Organization');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `response_date` SET TAGS ('pii_business_glossary_term' = 'Response Date');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `response_due_date` SET TAGS ('pii_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `response_method` SET TAGS ('pii_business_glossary_term' = 'Response Method');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `response_method` SET TAGS ('pii_value_regex' = 'email|letter|transmittal|meeting|phone');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `response_required_flag` SET TAGS ('pii_business_glossary_term' = 'Response Required Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `response_text` SET TAGS ('pii_business_glossary_term' = 'Response Text');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `sender_email` SET TAGS ('pii_business_glossary_term' = 'Sender Email Address');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `sender_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `sender_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `sender_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `sender_name` SET TAGS ('pii_business_glossary_term' = 'Sender Name');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `sender_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `sender_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `subject` SET TAGS ('pii_business_glossary_term' = 'Correspondence Subject');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `transmittal_number` SET TAGS ('pii_business_glossary_term' = 'Transmittal Number');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` SET TAGS ('pii_subdomain' = 'document_control');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `transmittal_id` SET TAGS ('pii_business_glossary_term' = 'Transmittal Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `phase_id` SET TAGS ('pii_business_glossary_term' = 'Phase Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Sender Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `acknowledgement_by` SET TAGS ('pii_business_glossary_term' = 'Acknowledged By');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `acknowledgement_by` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `acknowledgement_by` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `acknowledgement_date` SET TAGS ('pii_business_glossary_term' = 'Acknowledgement Date');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `acknowledgement_required_flag` SET TAGS ('pii_business_glossary_term' = 'Acknowledgement Required Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `acknowledgement_status` SET TAGS ('pii_business_glossary_term' = 'Acknowledgement Status');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `acknowledgement_status` SET TAGS ('pii_value_regex' = 'pending|acknowledged|overdue|not_required');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `delivery_method` SET TAGS ('pii_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `delivery_method` SET TAGS ('pii_value_regex' = 'electronic|courier|hand_delivery|postal_mail|ftp|portal');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `transmittal_description` SET TAGS ('pii_business_glossary_term' = 'Transmittal Description');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `document_count` SET TAGS ('pii_business_glossary_term' = 'Document Count');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Transmittal Priority');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `purpose_of_issue` SET TAGS ('pii_business_glossary_term' = 'Purpose of Issue');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `purpose_of_issue` SET TAGS ('pii_value_regex' = 'for_approval|for_information|for_construction|for_record|for_review|for_comment');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `recipient_contact_name` SET TAGS ('pii_business_glossary_term' = 'Recipient Contact Name');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `recipient_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `recipient_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `recipient_email` SET TAGS ('pii_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `recipient_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `recipient_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `recipient_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `recipient_organization` SET TAGS ('pii_business_glossary_term' = 'Recipient Organization');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `reference_transmittal_number` SET TAGS ('pii_business_glossary_term' = 'Reference Transmittal Number');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Transmittal Remarks');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `revision_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9.]+$');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `sender_contact_name` SET TAGS ('pii_business_glossary_term' = 'Sender Contact Name');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `sender_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `sender_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `sender_email` SET TAGS ('pii_business_glossary_term' = 'Sender Email Address');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `sender_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `sender_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `sender_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `subject` SET TAGS ('pii_business_glossary_term' = 'Transmittal Subject');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `transmittal_number` SET TAGS ('pii_business_glossary_term' = 'Transmittal Number');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `transmittal_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `transmittal_status` SET TAGS ('pii_business_glossary_term' = 'Transmittal Status');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `transmittal_status` SET TAGS ('pii_value_regex' = 'draft|issued|acknowledged|rejected|superseded|closed');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` SET TAGS ('pii_subdomain' = 'document_control');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `rfi_id` SET TAGS ('pii_business_glossary_term' = 'Rfi Identifier');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Originator Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Originator Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `permit_condition_id` SET TAGS ('pii_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `actual_response_date` SET TAGS ('pii_business_glossary_term' = 'Actual Response Date');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `closure_date` SET TAGS ('pii_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `closure_notes` SET TAGS ('pii_business_glossary_term' = 'Closure Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `cost_impact_amount` SET TAGS ('pii_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `cost_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Cost Impact Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `date_raised` SET TAGS ('pii_business_glossary_term' = 'Date Raised');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `rfi_description` SET TAGS ('pii_business_glossary_term' = 'Request for Information (RFI) Description');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `external_reference_code` SET TAGS ('pii_business_glossary_term' = 'External Reference ID');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `linked_drawing_reference` SET TAGS ('pii_business_glossary_term' = 'Linked Drawing Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `linked_specification_reference` SET TAGS ('pii_business_glossary_term' = 'Linked Specification Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Request for Information (RFI) Priority');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `response_content` SET TAGS ('pii_business_glossary_term' = 'Response Content');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `response_due_date` SET TAGS ('pii_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `response_time_days` SET TAGS ('pii_business_glossary_term' = 'Response Time Days');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `rfi_number` SET TAGS ('pii_business_glossary_term' = 'Request for Information (RFI) Number');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `rfi_status` SET TAGS ('pii_business_glossary_term' = 'Request for Information (RFI) Status');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `rfi_status` SET TAGS ('pii_value_regex' = 'draft|open|pending_response|responded|closed|cancelled');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `schedule_impact_days` SET TAGS ('pii_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `schedule_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Schedule Impact Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `subject` SET TAGS ('pii_business_glossary_term' = 'Request for Information (RFI) Subject');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` SET TAGS ('pii_subdomain' = 'document_control');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `document_register_id` SET TAGS ('pii_business_glossary_term' = 'Document Register ID');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Author Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `bid_contract_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Sub Contract Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `rfi_id` SET TAGS ('pii_business_glossary_term' = 'Rfi Document Rfi Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `approver_name` SET TAGS ('pii_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `confidentiality_classification` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `confidentiality_classification` SET TAGS ('pii_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `distribution_list` SET TAGS ('pii_business_glossary_term' = 'Distribution List');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `document_number` SET TAGS ('pii_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `document_purpose` SET TAGS ('pii_business_glossary_term' = 'Document Purpose');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `document_register_status` SET TAGS ('pii_business_glossary_term' = 'Document Status');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `document_title` SET TAGS ('pii_business_glossary_term' = 'Document Title');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `document_type` SET TAGS ('pii_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `file_format` SET TAGS ('pii_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `file_size_mb` SET TAGS ('pii_business_glossary_term' = 'File Size (Megabytes)');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `is_client_deliverable` SET TAGS ('pii_business_glossary_term' = 'Is Client Deliverable');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `is_controlled_document` SET TAGS ('pii_business_glossary_term' = 'Is Controlled Document');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `keywords` SET TAGS ('pii_business_glossary_term' = 'Keywords');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `originator` SET TAGS ('pii_business_glossary_term' = 'Document Originator');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `page_count` SET TAGS ('pii_business_glossary_term' = 'Page Count');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `related_submittal_number` SET TAGS ('pii_business_glossary_term' = 'Related Submittal Number');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `retention_period_years` SET TAGS ('pii_business_glossary_term' = 'Retention Period (Years)');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `review_due_date` SET TAGS ('pii_business_glossary_term' = 'Review Due Date');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `reviewer_name` SET TAGS ('pii_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `revision_description` SET TAGS ('pii_business_glossary_term' = 'Revision Description');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `storage_location` SET TAGS ('pii_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `superseded_by_document_number` SET TAGS ('pii_business_glossary_term' = 'Superseded By Document Number');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `supersedes_document_number` SET TAGS ('pii_business_glossary_term' = 'Supersedes Document Number');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `transmittal_number` SET TAGS ('pii_business_glossary_term' = 'Transmittal Number');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` SET TAGS ('pii_subdomain' = 'document_control');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `revision_id` SET TAGS ('pii_business_glossary_term' = 'Revision Identifier');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `document_register_id` SET TAGS ('pii_business_glossary_term' = 'Document ID');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `primary_revision_employee_id` SET TAGS ('pii_business_glossary_term' = 'Author ID');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `primary_revision_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `primary_revision_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `superseded_revision_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Revision ID');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `approver_name` SET TAGS ('pii_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `approver_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `author_name` SET TAGS ('pii_business_glossary_term' = 'Author Name');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `author_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `change_reason` SET TAGS ('pii_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `change_reason` SET TAGS ('pii_value_regex' = 'design_change|client_request|rfi_response|regulatory_update|error_correction|clarification');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `change_summary` SET TAGS ('pii_business_glossary_term' = 'Change Summary');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `checksum_hash` SET TAGS ('pii_business_glossary_term' = 'Checksum Hash');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `revision_description` SET TAGS ('pii_business_glossary_term' = 'Revision Description');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `distribution_list` SET TAGS ('pii_business_glossary_term' = 'Distribution List');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `file_format` SET TAGS ('pii_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `file_name` SET TAGS ('pii_business_glossary_term' = 'File Name');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `file_size_bytes` SET TAGS ('pii_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `file_storage_path` SET TAGS ('pii_business_glossary_term' = 'File Storage Path');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `is_controlled_copy` SET TAGS ('pii_business_glossary_term' = 'Is Controlled Copy');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `page_count` SET TAGS ('pii_business_glossary_term' = 'Page Count');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `reviewer_name` SET TAGS ('pii_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `reviewer_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `revision_date` SET TAGS ('pii_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `revision_status` SET TAGS ('pii_business_glossary_term' = 'Revision Status');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `revision_status` SET TAGS ('pii_value_regex' = 'draft|in_review|approved|issued|superseded|obsolete');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `revision_type` SET TAGS ('pii_business_glossary_term' = 'Revision Type');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `revision_type` SET TAGS ('pii_value_regex' = 'initial|minor|major|emergency|regulatory');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `sheet_count` SET TAGS ('pii_business_glossary_term' = 'Sheet Count');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `transmittal_number` SET TAGS ('pii_business_glossary_term' = 'Transmittal Number');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` SET TAGS ('pii_subdomain' = 'document_control');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `workflow_approval_id` SET TAGS ('pii_business_glossary_term' = 'Workflow Approval ID');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `document_register_id` SET TAGS ('pii_business_glossary_term' = 'Document ID');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Reviewer ID');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `tertiary_workflow_escalated_to_employee_id` SET TAGS ('pii_business_glossary_term' = 'Escalated To ID');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `tertiary_workflow_escalated_to_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `tertiary_workflow_escalated_to_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `workflow_template_id` SET TAGS ('pii_business_glossary_term' = 'Workflow Template ID');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `action_date` SET TAGS ('pii_business_glossary_term' = 'Action Date');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `action_taken` SET TAGS ('pii_business_glossary_term' = 'Action Taken');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `approval_authority_level` SET TAGS ('pii_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `assigned_reviewer_role` SET TAGS ('pii_business_glossary_term' = 'Assigned Reviewer Role');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `audit_trail_reference` SET TAGS ('pii_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `current_step_sequence` SET TAGS ('pii_business_glossary_term' = 'Current Step Sequence');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `delegation_reason` SET TAGS ('pii_business_glossary_term' = 'Delegation Reason');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `escalation_date` SET TAGS ('pii_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `escalation_flag` SET TAGS ('pii_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `external_reference_code` SET TAGS ('pii_business_glossary_term' = 'External Reference ID');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `initiated_date` SET TAGS ('pii_business_glossary_term' = 'Initiated Date');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `last_reminder_date` SET TAGS ('pii_business_glossary_term' = 'Last Reminder Date');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `notification_sent_flag` SET TAGS ('pii_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `outcome_date` SET TAGS ('pii_business_glossary_term' = 'Outcome Date');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `overall_outcome` SET TAGS ('pii_business_glossary_term' = 'Overall Outcome');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `overall_outcome` SET TAGS ('pii_value_regex' = 'approved|rejected|withdrawn|superseded|closed');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `reminder_count` SET TAGS ('pii_business_glossary_term' = 'Reminder Count');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `reviewer_comments` SET TAGS ('pii_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `sla_actual_hours` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Actual Hours');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `sla_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `sla_target_hours` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `total_steps` SET TAGS ('pii_business_glossary_term' = 'Total Steps');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `workflow_name` SET TAGS ('pii_business_glossary_term' = 'Workflow Name');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `workflow_number` SET TAGS ('pii_business_glossary_term' = 'Workflow Number');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `workflow_status` SET TAGS ('pii_business_glossary_term' = 'Workflow Status');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `workflow_type` SET TAGS ('pii_business_glossary_term' = 'Workflow Type');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` SET TAGS ('pii_subdomain' = 'handover_commissioning');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `handover_package_id` SET TAGS ('pii_business_glossary_term' = 'Handover Package ID');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `contact_id` SET TAGS ('pii_business_glossary_term' = 'Client Representative Contact Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Prepared By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `aconex_document_reference` SET TAGS ('pii_business_glossary_term' = 'Aconex Document ID');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `bim_model_reference` SET TAGS ('pii_business_glossary_term' = 'Building Information Modeling (BIM) Model Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `client_acceptance_date` SET TAGS ('pii_business_glossary_term' = 'Client Acceptance Date');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `client_acceptance_status` SET TAGS ('pii_business_glossary_term' = 'Client Acceptance Status');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `client_acceptance_status` SET TAGS ('pii_value_regex' = 'pending|accepted|conditionally_accepted|rejected|under_review');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `completeness_percentage` SET TAGS ('pii_business_glossary_term' = 'Completeness Percentage');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `dlp_duration_days` SET TAGS ('pii_business_glossary_term' = 'Defects Liability Period (DLP) Duration Days');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `dlp_end_date` SET TAGS ('pii_business_glossary_term' = 'Defects Liability Period (DLP) End Date');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `dlp_start_date` SET TAGS ('pii_business_glossary_term' = 'Defects Liability Period (DLP) Start Date');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `handover_milestone` SET TAGS ('pii_business_glossary_term' = 'Handover Milestone');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `handover_milestone` SET TAGS ('pii_value_regex' = 'practical_completion|substantial_completion|final_completion|sectional_handover|early_access');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `iso_19650_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'ISO 19650 Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `legal_hold_flag` SET TAGS ('pii_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `legal_hold_reason` SET TAGS ('pii_business_glossary_term' = 'Legal Hold Reason');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `legal_hold_reason` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `legal_hold_start_date` SET TAGS ('pii_business_glossary_term' = 'Legal Hold Start Date');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `package_number` SET TAGS ('pii_business_glossary_term' = 'Handover Package Number');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `package_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,4}-HP-[0-9]{4,6}$');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `package_status` SET TAGS ('pii_business_glossary_term' = 'Package Status');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `package_title` SET TAGS ('pii_business_glossary_term' = 'Handover Package Title');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `package_type` SET TAGS ('pii_business_glossary_term' = 'Handover Package Type');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `package_type` SET TAGS ('pii_value_regex' = 'operations_and_maintenance_manual|as_built_drawings|test_and_commissioning_records|warranties_and_guarantees|certificates_and_approvals|training_materials');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `planned_submission_date` SET TAGS ('pii_business_glossary_term' = 'Planned Submission Date');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `required_document_count` SET TAGS ('pii_business_glossary_term' = 'Required Document Count');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `retention_period_years` SET TAGS ('pii_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `reviewed_by` SET TAGS ('pii_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `scope_of_works` SET TAGS ('pii_business_glossary_term' = 'Scope of Works');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `storage_location` SET TAGS ('pii_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ALTER COLUMN `submitted_document_count` SET TAGS ('pii_business_glossary_term' = 'Submitted Document Count');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` SET TAGS ('pii_subdomain' = 'handover_commissioning');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `handover_item_id` SET TAGS ('pii_business_glossary_term' = 'Handover Item ID');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `document_register_id` SET TAGS ('pii_business_glossary_term' = 'Document Register Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `handover_package_id` SET TAGS ('pii_business_glossary_term' = 'Handover Package ID');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `contact_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Contact Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `actual_submission_date` SET TAGS ('pii_business_glossary_term' = 'Actual Submission Date');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `certification_date` SET TAGS ('pii_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `certification_required` SET TAGS ('pii_business_glossary_term' = 'Certification Required');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `certifying_authority` SET TAGS ('pii_business_glossary_term' = 'Certifying Authority');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `client_review_date` SET TAGS ('pii_business_glossary_term' = 'Client Review Date');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `client_review_status` SET TAGS ('pii_business_glossary_term' = 'Client Review Status');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `client_reviewer_name` SET TAGS ('pii_business_glossary_term' = 'Client Reviewer Name');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `client_reviewer_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `client_reviewer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `completed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `contractual_requirement` SET TAGS ('pii_business_glossary_term' = 'Contractual Requirement');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `file_location` SET TAGS ('pii_business_glossary_term' = 'File Location');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `format_type` SET TAGS ('pii_business_glossary_term' = 'Format Type');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `format_type` SET TAGS ('pii_value_regex' = 'hard_copy|electronic|both');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `item_description` SET TAGS ('pii_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `item_number` SET TAGS ('pii_business_glossary_term' = 'Item Number');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `item_status` SET TAGS ('pii_business_glossary_term' = 'Item Status');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `item_title` SET TAGS ('pii_business_glossary_term' = 'Item Title');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `item_type` SET TAGS ('pii_business_glossary_term' = 'Item Type');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `language` SET TAGS ('pii_business_glossary_term' = 'Language');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `outstanding_action_notes` SET TAGS ('pii_business_glossary_term' = 'Outstanding Action Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `page_count` SET TAGS ('pii_business_glossary_term' = 'Page Count');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `planned_submission_date` SET TAGS ('pii_business_glossary_term' = 'Planned Submission Date');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `responsible_party` SET TAGS ('pii_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `system_reference` SET TAGS ('pii_business_glossary_term' = 'System Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `warranty_period_months` SET TAGS ('pii_business_glossary_term' = 'Warranty Period Months');
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` SET TAGS ('pii_subdomain' = 'document_control');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `correspondence_response_id` SET TAGS ('pii_business_glossary_term' = 'Correspondence Response ID');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `correspondence_id` SET TAGS ('pii_business_glossary_term' = 'Correspondence ID');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `primary_correspondence_employee_id` SET TAGS ('pii_business_glossary_term' = 'Author ID');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `primary_correspondence_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `primary_correspondence_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `supersedes_response_correspondence_response_id` SET TAGS ('pii_business_glossary_term' = 'Supersedes Response ID');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `acknowledgment_received_date` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Received Date');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `acknowledgment_required` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Required Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `action_required_by_date` SET TAGS ('pii_business_glossary_term' = 'Action Required By Date');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `approver_name` SET TAGS ('pii_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `attachment_count` SET TAGS ('pii_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `attachment_file_names` SET TAGS ('pii_business_glossary_term' = 'Attachment File Names');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `author_name` SET TAGS ('pii_business_glossary_term' = 'Author Name');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `author_role` SET TAGS ('pii_business_glossary_term' = 'Author Role');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `closes_correspondence` SET TAGS ('pii_business_glossary_term' = 'Closes Correspondence Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `contractual_impact` SET TAGS ('pii_business_glossary_term' = 'Contractual Impact');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `contractual_impact` SET TAGS ('pii_value_regex' = 'none|time|cost|scope|quality|risk');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `distribution_list` SET TAGS ('pii_business_glossary_term' = 'Distribution List');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `legal_review_required` SET TAGS ('pii_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `legal_reviewer_name` SET TAGS ('pii_business_glossary_term' = 'Legal Reviewer Name');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Response Priority');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'low|medium|high|urgent|critical');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `recipient_contact_name` SET TAGS ('pii_business_glossary_term' = 'Recipient Contact Name');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `recipient_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `recipient_contact_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `recipient_email` SET TAGS ('pii_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `recipient_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `recipient_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `recipient_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `recipient_organization` SET TAGS ('pii_business_glossary_term' = 'Recipient Organization');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `reference_documents` SET TAGS ('pii_business_glossary_term' = 'Reference Documents');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `requires_further_action` SET TAGS ('pii_business_glossary_term' = 'Requires Further Action Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `response_content` SET TAGS ('pii_business_glossary_term' = 'Response Content');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `response_date` SET TAGS ('pii_business_glossary_term' = 'Response Date');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `response_language` SET TAGS ('pii_business_glossary_term' = 'Response Language');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `response_language` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `response_method` SET TAGS ('pii_business_glossary_term' = 'Response Method');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `response_method` SET TAGS ('pii_value_regex' = 'letter|email|formal_notice|transmittal|system_notification|verbal_confirmed');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `response_number` SET TAGS ('pii_business_glossary_term' = 'Response Number');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `response_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `response_status` SET TAGS ('pii_business_glossary_term' = 'Response Status');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `response_status` SET TAGS ('pii_value_regex' = 'draft|submitted|acknowledged|superseded|withdrawn|closed');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `response_summary` SET TAGS ('pii_business_glossary_term' = 'Response Summary');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `response_timestamp` SET TAGS ('pii_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `response_type` SET TAGS ('pii_business_glossary_term' = 'Response Type');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ALTER COLUMN `subject` SET TAGS ('pii_business_glossary_term' = 'Response Subject');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` SET TAGS ('pii_subdomain' = 'document_control');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `transmittal_item_id` SET TAGS ('pii_business_glossary_term' = 'Transmittal Item Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `document_register_id` SET TAGS ('pii_business_glossary_term' = 'Document Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `transmittal_id` SET TAGS ('pii_business_glossary_term' = 'Transmittal Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `bim_model_reference` SET TAGS ('pii_business_glossary_term' = 'Building Information Modeling (BIM) Model Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `distribution_method` SET TAGS ('pii_business_glossary_term' = 'Distribution Method');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `distribution_method` SET TAGS ('pii_value_regex' = 'electronic|hard_copy|both|courier|registered_mail');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `document_number` SET TAGS ('pii_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `document_revision` SET TAGS ('pii_business_glossary_term' = 'Document Revision');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `document_title` SET TAGS ('pii_business_glossary_term' = 'Document Title');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `document_type` SET TAGS ('pii_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `file_format` SET TAGS ('pii_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `file_size_mb` SET TAGS ('pii_business_glossary_term' = 'File Size (Megabytes)');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `item_notes` SET TAGS ('pii_business_glossary_term' = 'Item Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `item_status` SET TAGS ('pii_business_glossary_term' = 'Item Status');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `item_status` SET TAGS ('pii_value_regex' = 'pending|transmitted|received|acknowledged|rejected|superseded');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `number_of_copies` SET TAGS ('pii_business_glossary_term' = 'Number of Copies');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `number_of_sheets` SET TAGS ('pii_business_glossary_term' = 'Number of Sheets');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `purpose_of_issue` SET TAGS ('pii_business_glossary_term' = 'Purpose of Issue');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `received_by` SET TAGS ('pii_business_glossary_term' = 'Received By');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `received_date` SET TAGS ('pii_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `response_due_date` SET TAGS ('pii_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `response_required` SET TAGS ('pii_business_glossary_term' = 'Response Required Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `sheet_size` SET TAGS ('pii_business_glossary_term' = 'Sheet Size');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `status_code` SET TAGS ('pii_business_glossary_term' = 'Document Status Code');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `supersedes_document_number` SET TAGS ('pii_business_glossary_term' = 'Supersedes Document Number');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `supersedes_revision` SET TAGS ('pii_business_glossary_term' = 'Supersedes Revision');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `work_package_code` SET TAGS ('pii_business_glossary_term' = 'Work Package Code');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal_item` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` SET TAGS ('pii_subdomain' = 'document_control');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `distribution_matrix_id` SET TAGS ('pii_business_glossary_term' = 'Distribution Matrix Identifier');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `superseded_by_matrix_distribution_matrix_id` SET TAGS ('pii_business_glossary_term' = 'Superseded By Matrix ID');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `acknowledgement_deadline_days` SET TAGS ('pii_business_glossary_term' = 'Acknowledgement Deadline Days');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `acknowledgement_required_flag` SET TAGS ('pii_business_glossary_term' = 'Acknowledgement Required Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `approval_authority` SET TAGS ('pii_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `copy_type` SET TAGS ('pii_business_glossary_term' = 'Copy Type');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `copy_type` SET TAGS ('pii_value_regex' = 'controlled|uncontrolled|for_information|for_approval|for_review|for_comment');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `discipline_code` SET TAGS ('pii_business_glossary_term' = 'Discipline Code');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `discipline_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `distribution_format` SET TAGS ('pii_business_glossary_term' = 'Distribution Format');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `distribution_format` SET TAGS ('pii_value_regex' = 'pdf|dwg|ifc|native|paper|both');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `distribution_frequency` SET TAGS ('pii_business_glossary_term' = 'Distribution Frequency');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `distribution_method` SET TAGS ('pii_business_glossary_term' = 'Distribution Method');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `distribution_priority` SET TAGS ('pii_business_glossary_term' = 'Distribution Priority');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `distribution_priority` SET TAGS ('pii_value_regex' = 'critical|high|normal|low');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `distribution_status` SET TAGS ('pii_business_glossary_term' = 'Distribution Status');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `distribution_status` SET TAGS ('pii_value_regex' = 'active|suspended|superseded|cancelled|pending_approval');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `document_type_code` SET TAGS ('pii_business_glossary_term' = 'Document Type Code');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `document_type_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `document_type_description` SET TAGS ('pii_business_glossary_term' = 'Document Type Description');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `effective_from_date` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `effective_to_date` SET TAGS ('pii_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `project_phase_applicability` SET TAGS ('pii_business_glossary_term' = 'Project Phase Applicability');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `recipient_contact_name` SET TAGS ('pii_business_glossary_term' = 'Recipient Contact Name');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `recipient_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `recipient_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `recipient_email_address` SET TAGS ('pii_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `recipient_email_address` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `recipient_email_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `recipient_email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `recipient_organization_name` SET TAGS ('pii_business_glossary_term' = 'Recipient Organization Name');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `recipient_role` SET TAGS ('pii_business_glossary_term' = 'Recipient Role');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `response_deadline_days` SET TAGS ('pii_business_glossary_term' = 'Response Deadline Days');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `response_required_flag` SET TAGS ('pii_business_glossary_term' = 'Response Required Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `revision_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `security_classification` SET TAGS ('pii_business_glossary_term' = 'Security Classification');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `security_classification` SET TAGS ('pii_value_regex' = 'public|internal|confidential|restricted|proprietary');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ALTER COLUMN `wbs_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9.-]{1,30}$');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` SET TAGS ('pii_subdomain' = 'document_control');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `access_permission_id` SET TAGS ('pii_business_glossary_term' = 'Access Permission Identifier');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Grantee Organization ID');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `document_register_id` SET TAGS ('pii_business_glossary_term' = 'Document ID');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `parent_permission_access_permission_id` SET TAGS ('pii_business_glossary_term' = 'Parent Permission ID');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Grantee User ID');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `quaternary_quinary_access_created_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `quaternary_quinary_access_created_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `quaternary_quinary_access_created_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `team_member_id` SET TAGS ('pii_business_glossary_term' = 'Grantee Team ID');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `team_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `team_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `tertiary_access_approved_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `tertiary_access_approved_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `tertiary_access_approved_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `tertiary_quaternary_access_revoked_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Revoked By User ID');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `tertiary_quaternary_access_revoked_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `tertiary_quaternary_access_revoked_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `access_count` SET TAGS ('pii_business_glossary_term' = 'Access Count');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `access_log_retention_days` SET TAGS ('pii_business_glossary_term' = 'Access Log Retention Days');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `approval_required_flag` SET TAGS ('pii_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `business_justification` SET TAGS ('pii_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_value_regex' = 'public|internal|confidential|restricted|commercially_sensitive|legally_privileged');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `effective_from_date` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `effective_to_date` SET TAGS ('pii_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `granted_timestamp` SET TAGS ('pii_business_glossary_term' = 'Granted Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `grantee_role_code` SET TAGS ('pii_business_glossary_term' = 'Grantee Role Code');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `grantee_role_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `grantee_type` SET TAGS ('pii_business_glossary_term' = 'Grantee Type');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `grantee_type` SET TAGS ('pii_value_regex' = 'organization|role|user|team');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `inherit_from_parent_flag` SET TAGS ('pii_business_glossary_term' = 'Inherit From Parent Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Accessed Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `notification_sent_flag` SET TAGS ('pii_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('pii_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `offline_access_allowed_flag` SET TAGS ('pii_business_glossary_term' = 'Offline Access Allowed Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `permission_level` SET TAGS ('pii_business_glossary_term' = 'Permission Level');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `permission_number` SET TAGS ('pii_business_glossary_term' = 'Permission Number');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `permission_number` SET TAGS ('pii_value_regex' = '^ACL-[0-9]{8}$');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `permission_status` SET TAGS ('pii_business_glossary_term' = 'Permission Status');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `permission_status` SET TAGS ('pii_value_regex' = 'active|suspended|revoked|expired|pending');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `permission_type` SET TAGS ('pii_business_glossary_term' = 'Permission Type');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `permission_type` SET TAGS ('pii_value_regex' = 'document|folder|workspace|project');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `print_allowed_flag` SET TAGS ('pii_business_glossary_term' = 'Print Allowed Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `revocation_reason` SET TAGS ('pii_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `revoked_timestamp` SET TAGS ('pii_business_glossary_term' = 'Revoked Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `watermark_required_flag` SET TAGS ('pii_business_glossary_term' = 'Watermark Required Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ALTER COLUMN `wbs_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9.-]{1,30}$');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` SET TAGS ('pii_subdomain' = 'engineering_drawings');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `bim_model_id` SET TAGS ('pii_business_glossary_term' = 'Building Information Model (BIM) Model ID');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Author Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `superseded_by_model_bim_model_id` SET TAGS ('pii_business_glossary_term' = 'Superseded By Model ID');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `author_organization` SET TAGS ('pii_business_glossary_term' = 'Author Organization');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `authoring_software` SET TAGS ('pii_business_glossary_term' = 'Authoring Software');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `building_zone` SET TAGS ('pii_business_glossary_term' = 'Building Zone');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `clash_count` SET TAGS ('pii_business_glossary_term' = 'Clash Count');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `clash_detection_status` SET TAGS ('pii_business_glossary_term' = 'Clash Detection Status');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `clash_detection_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|issues_identified|resolved');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `confidentiality_classification` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `confidentiality_classification` SET TAGS ('pii_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `coordinate_system` SET TAGS ('pii_business_glossary_term' = 'Project Coordinate System');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'BIM Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `element_count` SET TAGS ('pii_business_glossary_term' = 'Element Count');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `external_reference_code` SET TAGS ('pii_business_glossary_term' = 'External Reference ID');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `federation_role` SET TAGS ('pii_business_glossary_term' = 'Federation Role');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `federation_role` SET TAGS ('pii_value_regex' = 'host|linked|standalone|reference');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `file_format` SET TAGS ('pii_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `file_size_mb` SET TAGS ('pii_business_glossary_term' = 'File Size (MB)');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `iso_19650_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'ISO 19650 Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `lifecycle_stage` SET TAGS ('pii_business_glossary_term' = 'Project Lifecycle Stage');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `lod_classification` SET TAGS ('pii_business_glossary_term' = 'Level of Development (LOD) Classification');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `lod_classification` SET TAGS ('pii_value_regex' = 'LOD_100|LOD_200|LOD_300|LOD_350|LOD_400|LOD_500');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `model_name` SET TAGS ('pii_business_glossary_term' = 'BIM Model Name');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `model_number` SET TAGS ('pii_business_glossary_term' = 'BIM Model Number');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `model_status` SET TAGS ('pii_business_glossary_term' = 'BIM Model Status');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `model_status` SET TAGS ('pii_value_regex' = 'wip|shared|published|archived|superseded');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `model_type` SET TAGS ('pii_business_glossary_term' = 'BIM Model Type');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `model_type` SET TAGS ('pii_value_regex' = 'design|coordination|construction|as_built|facility_management');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `model_version` SET TAGS ('pii_business_glossary_term' = 'Model Version');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `origin_elevation_m` SET TAGS ('pii_business_glossary_term' = 'Origin Elevation (Meters)');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `origin_latitude` SET TAGS ('pii_business_glossary_term' = 'Origin Latitude');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `origin_latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `origin_latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `origin_longitude` SET TAGS ('pii_business_glossary_term' = 'Origin Longitude');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `origin_longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `origin_longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `reviewer_name` SET TAGS ('pii_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `software_version` SET TAGS ('pii_business_glossary_term' = 'Software Version');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `storage_location` SET TAGS ('pii_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` SET TAGS ('pii_subdomain' = 'engineering_drawings');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `drawing_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Identifier');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Author Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `bim_model_id` SET TAGS ('pii_business_glossary_term' = 'Bim Model Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Identifier');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `approver_name` SET TAGS ('pii_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `cad_file_name` SET TAGS ('pii_business_glossary_term' = 'Computer-Aided Design (CAD) File Name');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `checker_name` SET TAGS ('pii_business_glossary_term' = 'Checker Name');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `clash_detection_status` SET TAGS ('pii_business_glossary_term' = 'Clash Detection Status');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `clash_detection_status` SET TAGS ('pii_value_regex' = 'not_checked|passed|clashes_detected|resolved');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `confidentiality_classification` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `confidentiality_classification` SET TAGS ('pii_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `distribution_list` SET TAGS ('pii_business_glossary_term' = 'Distribution List');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `drawing_number` SET TAGS ('pii_business_glossary_term' = 'Drawing Number');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `drawing_status` SET TAGS ('pii_business_glossary_term' = 'Drawing Status');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `drawing_type` SET TAGS ('pii_business_glossary_term' = 'Drawing Type');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `drawing_type` SET TAGS ('pii_value_regex' = 'plan|elevation|section|detail|schedule|isometric');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `file_format` SET TAGS ('pii_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `file_format` SET TAGS ('pii_value_regex' = 'PDF|DWG|DXF|RVT|IFC|DGN');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `file_size_mb` SET TAGS ('pii_business_glossary_term' = 'File Size in Megabytes (MB)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `is_client_deliverable` SET TAGS ('pii_business_glossary_term' = 'Is Client Deliverable Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `is_controlled_document` SET TAGS ('pii_business_glossary_term' = 'Is Controlled Document Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `issue_purpose` SET TAGS ('pii_business_glossary_term' = 'Issue Purpose');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `issue_purpose` SET TAGS ('pii_value_regex' = 'information|review|approval|construction|tender|as_built');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `originator` SET TAGS ('pii_business_glossary_term' = 'Originator Organization');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `page_count` SET TAGS ('pii_business_glossary_term' = 'Page Count');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `related_specification_reference` SET TAGS ('pii_business_glossary_term' = 'Related Specification Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `retention_period_years` SET TAGS ('pii_business_glossary_term' = 'Retention Period in Years');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `revision_date` SET TAGS ('pii_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `scale` SET TAGS ('pii_business_glossary_term' = 'Drawing Scale');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `sheet_size` SET TAGS ('pii_business_glossary_term' = 'Sheet Size');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `storage_location` SET TAGS ('pii_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `superseded_by_drawing_number` SET TAGS ('pii_business_glossary_term' = 'Superseded By Drawing Number');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `supersedes_drawing_number` SET TAGS ('pii_business_glossary_term' = 'Supersedes Drawing Number');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Drawing Title');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `zone_location` SET TAGS ('pii_business_glossary_term' = 'Zone or Location');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` SET TAGS ('pii_subdomain' = 'engineering_drawings');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `drawing_revision_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Revision Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `drawing_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `primary_drawing_employee_id` SET TAGS ('pii_business_glossary_term' = 'Issuing Engineer Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `primary_drawing_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `primary_drawing_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_business_glossary_term' = 'Reviewer Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `rfi_id` SET TAGS ('pii_business_glossary_term' = 'Rfi Document Rfi Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `superseded_revision_drawing_revision_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Revision Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `acknowledgment_required_flag` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Required Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `acknowledgment_status` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `acknowledgment_status` SET TAGS ('pii_value_regex' = 'not_required|pending|acknowledged|overdue');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `approver_name` SET TAGS ('pii_business_glossary_term' = 'Approver Full Name');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `bim_model_reference` SET TAGS ('pii_business_glossary_term' = 'Building Information Modeling (BIM) Model Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `change_summary` SET TAGS ('pii_business_glossary_term' = 'Revision Change Summary');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `clash_detection_status` SET TAGS ('pii_business_glossary_term' = 'Clash Detection Status');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `clash_detection_status` SET TAGS ('pii_value_regex' = 'not_required|pending|in_progress|passed|failed|resolved');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Revision Comments');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Classification Level');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `distribution_date` SET TAGS ('pii_business_glossary_term' = 'Distribution Date');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `distribution_method` SET TAGS ('pii_business_glossary_term' = 'Distribution Method');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `distribution_method` SET TAGS ('pii_value_regex' = 'electronic|hard_copy|both|portal|email');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `distribution_status` SET TAGS ('pii_business_glossary_term' = 'Distribution Status');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `distribution_status` SET TAGS ('pii_value_regex' = 'pending|distributed|acknowledged|rejected|superseded');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `file_format` SET TAGS ('pii_business_glossary_term' = 'File Format Type');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `file_size_mb` SET TAGS ('pii_business_glossary_term' = 'File Size in Megabytes (MB)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `issuing_engineer_name` SET TAGS ('pii_business_glossary_term' = 'Issuing Engineer Full Name');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `linked_change_order_number` SET TAGS ('pii_business_glossary_term' = 'Linked Change Order (CO) Number');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `linked_submittal_number` SET TAGS ('pii_business_glossary_term' = 'Linked Submittal Number');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `reviewer_name` SET TAGS ('pii_business_glossary_term' = 'Reviewer Full Name');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `revision_code` SET TAGS ('pii_business_glossary_term' = 'Revision Code');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `revision_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `revision_date` SET TAGS ('pii_business_glossary_term' = 'Revision Issue Date');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `revision_description` SET TAGS ('pii_business_glossary_term' = 'Revision Change Description');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Sequence Number');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `revision_reason` SET TAGS ('pii_business_glossary_term' = 'Reason for Revision');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `revision_status` SET TAGS ('pii_business_glossary_term' = 'Revision Lifecycle Status');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `revision_type` SET TAGS ('pii_business_glossary_term' = 'Revision Purpose Type');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `sheet_count` SET TAGS ('pii_business_glossary_term' = 'Sheet Count');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `transmittal_number` SET TAGS ('pii_business_glossary_term' = 'Transmittal Number');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` SET TAGS ('pii_subdomain' = 'engineering_drawings');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `technical_specification_id` SET TAGS ('pii_business_glossary_term' = 'Technical Specification ID');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `applicable_standards` SET TAGS ('pii_business_glossary_term' = 'Applicable Standards');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected|conditional|not_required');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `approver_name` SET TAGS ('pii_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `approver_role` SET TAGS ('pii_business_glossary_term' = 'Approver Role');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `author_name` SET TAGS ('pii_business_glossary_term' = 'Author Name');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `author_organization` SET TAGS ('pii_business_glossary_term' = 'Author Organization');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `boq_reference` SET TAGS ('pii_business_glossary_term' = 'Bill of Quantities (BOQ) Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `confidentiality_classification` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `confidentiality_classification` SET TAGS ('pii_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `csi_division` SET TAGS ('pii_business_glossary_term' = 'Construction Specifications Institute (CSI) Division');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `environmental_requirements` SET TAGS ('pii_business_glossary_term' = 'Environmental Requirements');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `file_format` SET TAGS ('pii_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `file_storage_path` SET TAGS ('pii_business_glossary_term' = 'File Storage Path');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `hse_requirements` SET TAGS ('pii_business_glossary_term' = 'Health Safety and Environment (HSE) Requirements');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `is_client_deliverable` SET TAGS ('pii_business_glossary_term' = 'Is Client Deliverable');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `material_requirements` SET TAGS ('pii_business_glossary_term' = 'Material Requirements');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `page_count` SET TAGS ('pii_business_glossary_term' = 'Page Count');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `related_drawing_references` SET TAGS ('pii_business_glossary_term' = 'Related Drawing References');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `reviewer_name` SET TAGS ('pii_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `scope_of_work` SET TAGS ('pii_business_glossary_term' = 'Scope of Work (SOW)');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `section_number` SET TAGS ('pii_business_glossary_term' = 'Section Number');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `specification_number` SET TAGS ('pii_business_glossary_term' = 'Specification Number');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `specification_title` SET TAGS ('pii_business_glossary_term' = 'Specification Title');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `specification_type` SET TAGS ('pii_business_glossary_term' = 'Specification Type');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `specification_type` SET TAGS ('pii_value_regex' = 'performance|prescriptive|proprietary|reference|master');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `submittal_requirements` SET TAGS ('pii_business_glossary_term' = 'Submittal Requirements');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `superseded_date` SET TAGS ('pii_business_glossary_term' = 'Superseded Date');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `supersedes_specification_number` SET TAGS ('pii_business_glossary_term' = 'Supersedes Specification Number');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `technical_specification_status` SET TAGS ('pii_business_glossary_term' = 'Specification Status');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `testing_requirements` SET TAGS ('pii_business_glossary_term' = 'Testing Requirements');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `warranty_period_months` SET TAGS ('pii_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `workmanship_standards` SET TAGS ('pii_business_glossary_term' = 'Workmanship Standards');
ALTER TABLE `vibe_construction_v1`.`design`.`package` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`design`.`package` SET TAGS ('pii_subdomain' = 'engineering_drawings');
ALTER TABLE `vibe_construction_v1`.`design`.`package` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`package` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`package` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`package` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`package` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`package` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `package_id` SET TAGS ('pii_business_glossary_term' = 'Package ID');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Prepared By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `actual_submission_date` SET TAGS ('pii_business_glossary_term' = 'Actual Submission Date');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `approval_workflow_state` SET TAGS ('pii_business_glossary_term' = 'Approval Workflow State');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `bim_model_reference` SET TAGS ('pii_business_glossary_term' = 'Building Information Modeling (BIM) Model Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `client_acceptance_date` SET TAGS ('pii_business_glossary_term' = 'Client Acceptance Date');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `client_acceptance_status` SET TAGS ('pii_business_glossary_term' = 'Client Acceptance Status');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `client_acceptance_status` SET TAGS ('pii_value_regex' = 'pending|accepted|accepted_with_comments|rejected|conditionally_accepted|superseded');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `completeness_percentage` SET TAGS ('pii_business_glossary_term' = 'Completeness Percentage');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `confidentiality_classification` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `confidentiality_classification` SET TAGS ('pii_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `contractual_due_date` SET TAGS ('pii_business_glossary_term' = 'Contractual Due Date');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `document_count` SET TAGS ('pii_business_glossary_term' = 'Document Count');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `drawing_count` SET TAGS ('pii_business_glossary_term' = 'Drawing Count');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `iso_19650_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'ISO 19650 Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `milestone_stage` SET TAGS ('pii_business_glossary_term' = 'Milestone Stage');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `package_number` SET TAGS ('pii_business_glossary_term' = 'Package Number');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `package_status` SET TAGS ('pii_business_glossary_term' = 'Package Status');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `package_type` SET TAGS ('pii_business_glossary_term' = 'Package Type');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `package_type` SET TAGS ('pii_value_regex' = 'design_package|deliverable_package|submittal_package|handover_package|as_built_package|coordination_package');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `planned_issue_date` SET TAGS ('pii_business_glossary_term' = 'Planned Issue Date');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `recipient_distribution_list` SET TAGS ('pii_business_glossary_term' = 'Recipient Distribution List');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `responsible_organization` SET TAGS ('pii_business_glossary_term' = 'Responsible Organization');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `reviewed_by` SET TAGS ('pii_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `specification_count` SET TAGS ('pii_business_glossary_term' = 'Specification Count');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `storage_location` SET TAGS ('pii_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `submission_status` SET TAGS ('pii_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `submission_status` SET TAGS ('pii_value_regex' = 'not_submitted|submitted|under_review|resubmission_required|accepted|rejected');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `supersedes_package_number` SET TAGS ('pii_business_glossary_term' = 'Supersedes Package Number');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Package Title');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `transmittal_number` SET TAGS ('pii_business_glossary_term' = 'Transmittal Number');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` SET TAGS ('pii_subdomain' = 'engineering_drawings');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `clash_detection_run_id` SET TAGS ('pii_business_glossary_term' = 'Clash Detection Run Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `comparison_run_id` SET TAGS ('pii_business_glossary_term' = 'Comparison Clash Detection Run Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'BIM (Building Information Modeling) Analyst Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `accepted_clashes_count` SET TAGS ('pii_business_glossary_term' = 'Accepted Clashes Count');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `baseline_run_flag` SET TAGS ('pii_business_glossary_term' = 'Baseline Run Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `building_zone` SET TAGS ('pii_business_glossary_term' = 'Building Zone');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `certification_date` SET TAGS ('pii_business_glossary_term' = 'Clash-Free Certification Date');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `clash_free_certification_flag` SET TAGS ('pii_business_glossary_term' = 'Clash-Free Certification Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `clash_tolerance_mm` SET TAGS ('pii_business_glossary_term' = 'Clash Tolerance in Millimeters (mm)');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `clearance_clashes_count` SET TAGS ('pii_business_glossary_term' = 'Clearance Clashes Count');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `coordination_milestone` SET TAGS ('pii_business_glossary_term' = 'Coordination Milestone');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `critical_clashes_count` SET TAGS ('pii_business_glossary_term' = 'Critical Clashes Count');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `discipline_pair` SET TAGS ('pii_business_glossary_term' = 'Discipline Pair Comparison');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `federated_model_name` SET TAGS ('pii_business_glossary_term' = 'Federated Building Information Modeling (BIM) Model Name');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `hard_clashes_count` SET TAGS ('pii_business_glossary_term' = 'Hard Clashes Count');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `major_clashes_count` SET TAGS ('pii_business_glossary_term' = 'Major Clashes Count');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `minor_clashes_count` SET TAGS ('pii_business_glossary_term' = 'Minor Clashes Count');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `model_version` SET TAGS ('pii_business_glossary_term' = 'Building Information Modeling (BIM) Model Version');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `new_clashes_count` SET TAGS ('pii_business_glossary_term' = 'New Clashes Count');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Clash Detection Run Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `open_clashes_count` SET TAGS ('pii_business_glossary_term' = 'Open Clashes Count');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `primary_discipline` SET TAGS ('pii_business_glossary_term' = 'Primary Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `report_file_path` SET TAGS ('pii_business_glossary_term' = 'Clash Detection Report File Path');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `report_format` SET TAGS ('pii_business_glossary_term' = 'Report Format');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `report_format` SET TAGS ('pii_value_regex' = 'pdf|html|xml|excel|csv');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `resolved_clashes_count` SET TAGS ('pii_business_glossary_term' = 'Resolved Clashes Count');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `run_date` SET TAGS ('pii_business_glossary_term' = 'Clash Detection Run Date');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `run_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Run Duration in Minutes');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `run_name` SET TAGS ('pii_business_glossary_term' = 'Clash Detection Run Name');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `run_number` SET TAGS ('pii_business_glossary_term' = 'Clash Detection Run Number');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `run_status` SET TAGS ('pii_business_glossary_term' = 'Clash Detection Run Status');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `run_status` SET TAGS ('pii_value_regex' = 'queued|in_progress|completed|failed|cancelled');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `run_timestamp` SET TAGS ('pii_business_glossary_term' = 'Clash Detection Run Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `secondary_discipline` SET TAGS ('pii_business_glossary_term' = 'Secondary Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `soft_clashes_count` SET TAGS ('pii_business_glossary_term' = 'Soft Clashes Count');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `software_platform` SET TAGS ('pii_business_glossary_term' = 'Building Information Modeling (BIM) Software Platform');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `software_platform` SET TAGS ('pii_value_regex' = 'navisworks|bim_360_coordination|solibri|tekla_bimsight|synchro|other');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `software_version` SET TAGS ('pii_business_glossary_term' = 'Software Version');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `total_clashes_found` SET TAGS ('pii_business_glossary_term' = 'Total Clashes Found Count');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ALTER COLUMN `workflow_clashes_count` SET TAGS ('pii_business_glossary_term' = 'Workflow Clashes Count');
ALTER TABLE `vibe_construction_v1`.`design`.`review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`design`.`review` SET TAGS ('pii_subdomain' = 'engineering_drawings');
ALTER TABLE `vibe_construction_v1`.`design`.`review` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`review` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`review` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`review` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`review` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`review` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `review_id` SET TAGS ('pii_business_glossary_term' = 'Review ID');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `action_items_count` SET TAGS ('pii_business_glossary_term' = 'Action Items Count');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `attendee_count` SET TAGS ('pii_business_glossary_term' = 'Attendee Count');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `attendee_list` SET TAGS ('pii_business_glossary_term' = 'Attendee List');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `bim_model_reference` SET TAGS ('pii_business_glossary_term' = 'Building Information Modeling (BIM) Model Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `chairperson_name` SET TAGS ('pii_business_glossary_term' = 'Chairperson Name');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `clash_detection_performed` SET TAGS ('pii_business_glossary_term' = 'Clash Detection Performed Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `clashes_identified_count` SET TAGS ('pii_business_glossary_term' = 'Clashes Identified Count');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `client_approval_date` SET TAGS ('pii_business_glossary_term' = 'Client Approval Date');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `client_approval_required` SET TAGS ('pii_business_glossary_term' = 'Client Approval Required Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `client_representative_name` SET TAGS ('pii_business_glossary_term' = 'Client Representative Name');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `comments_closed_count` SET TAGS ('pii_business_glossary_term' = 'Comments Closed Count');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `comments_open_count` SET TAGS ('pii_business_glossary_term' = 'Comments Open Count');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `design_package_reference` SET TAGS ('pii_business_glossary_term' = 'Design Package Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `disposition` SET TAGS ('pii_business_glossary_term' = 'Review Disposition');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `disposition` SET TAGS ('pii_value_regex' = 'accepted|conditionally_accepted|rejected|revise_and_resubmit');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `duration_hours` SET TAGS ('pii_business_glossary_term' = 'Review Duration Hours');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `external_reference_code` SET TAGS ('pii_business_glossary_term' = 'External Reference ID');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `major_comments_count` SET TAGS ('pii_business_glossary_term' = 'Major Comments Count');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `meeting_location` SET TAGS ('pii_business_glossary_term' = 'Meeting Location');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `minor_comments_count` SET TAGS ('pii_business_glossary_term' = 'Minor Comments Count');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `minutes_document_reference` SET TAGS ('pii_business_glossary_term' = 'Minutes Document Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `next_review_scheduled_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Scheduled Date');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `recommendations` SET TAGS ('pii_business_glossary_term' = 'Recommendations');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `regulatory_authority` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `review_number` SET TAGS ('pii_business_glossary_term' = 'Review Number');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `review_status` SET TAGS ('pii_value_regex' = 'scheduled|in_progress|completed|cancelled|deferred');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `review_type` SET TAGS ('pii_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `review_type` SET TAGS ('pii_value_regex' = 'internal_peer_review|interdisciplinary_check|client_milestone_review|third_party_review|authority_review|constructability_review');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `scheduled_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `sign_off_authority` SET TAGS ('pii_business_glossary_term' = 'Sign-Off Authority');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `sign_off_date` SET TAGS ('pii_business_glossary_term' = 'Sign-Off Date');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `stage` SET TAGS ('pii_business_glossary_term' = 'Review Stage');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `summary` SET TAGS ('pii_business_glossary_term' = 'Review Summary');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `total_comments_raised` SET TAGS ('pii_business_glossary_term' = 'Total Comments Raised');
ALTER TABLE `vibe_construction_v1`.`design`.`review` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` SET TAGS ('pii_subdomain' = 'change_management');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `change_notice_id` SET TAGS ('pii_business_glossary_term' = 'Change Notice ID');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `bid_contract_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Sub Contract Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `contact_id` SET TAGS ('pii_business_glossary_term' = 'Originator Contact Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Originator Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `actual_cost_impact_amount` SET TAGS ('pii_business_glossary_term' = 'Actual Cost Impact Amount');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `actual_schedule_impact_days` SET TAGS ('pii_business_glossary_term' = 'Actual Schedule Impact Days');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `affected_disciplines` SET TAGS ('pii_business_glossary_term' = 'Affected Disciplines');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `affected_drawing_references` SET TAGS ('pii_business_glossary_term' = 'Affected Drawing References');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `affected_specification_references` SET TAGS ('pii_business_glossary_term' = 'Affected Specification References');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `approval_authority` SET TAGS ('pii_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `bim_model_reference` SET TAGS ('pii_business_glossary_term' = 'Building Information Modeling (BIM) Model Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `change_notice_number` SET TAGS ('pii_business_glossary_term' = 'Engineering Change Notice (ECN) Number');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `change_notice_status` SET TAGS ('pii_business_glossary_term' = 'Change Notice Status');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `change_notice_type` SET TAGS ('pii_business_glossary_term' = 'Change Notice Type');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `change_notice_type` SET TAGS ('pii_value_regex' = 'design_change|engineering_change|specification_change|material_substitution|scope_change|regulatory_change');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `change_order_reference` SET TAGS ('pii_business_glossary_term' = 'Change Order (CO) Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `clash_detection_impact` SET TAGS ('pii_business_glossary_term' = 'Clash Detection Impact');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `client_approval_date` SET TAGS ('pii_business_glossary_term' = 'Client Approval Date');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `client_approval_required_flag` SET TAGS ('pii_business_glossary_term' = 'Client Approval Required Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `cost_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Cost Impact Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `date_raised` SET TAGS ('pii_business_glossary_term' = 'Date Raised');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `change_notice_description` SET TAGS ('pii_business_glossary_term' = 'Change Notice Description');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `estimated_cost_impact_amount` SET TAGS ('pii_business_glossary_term' = 'Estimated Cost Impact Amount');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `estimated_schedule_impact_days` SET TAGS ('pii_business_glossary_term' = 'Estimated Schedule Impact Days');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `implementation_completion_date` SET TAGS ('pii_business_glossary_term' = 'Implementation Completion Date');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `implementation_start_date` SET TAGS ('pii_business_glossary_term' = 'Implementation Start Date');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `implementation_status` SET TAGS ('pii_business_glossary_term' = 'Implementation Status');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `implementation_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|on_hold|cancelled');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `originating_cause` SET TAGS ('pii_business_glossary_term' = 'Originating Cause');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `originating_cause` SET TAGS ('pii_value_regex' = 'client_instruction|site_condition|design_error|regulatory_requirement|value_engineering|constructability_improvement');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `originator_organization` SET TAGS ('pii_business_glossary_term' = 'Originator Organization');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Change Notice Priority');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `rejection_date` SET TAGS ('pii_business_glossary_term' = 'Rejection Date');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `schedule_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Schedule Impact Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Change Notice Title');
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` SET TAGS ('pii_subdomain' = 'spatial_coordination');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `mep_coordination_zone_id` SET TAGS ('pii_business_glossary_term' = 'Mechanical Electrical Plumbing (MEP) Coordination Zone ID');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Assigned MEP Coordinator ID');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `access_constraints` SET TAGS ('pii_business_glossary_term' = 'Access Constraints');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `actual_completion_date` SET TAGS ('pii_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `actual_start_date` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `available_clearance_m` SET TAGS ('pii_business_glossary_term' = 'Available Clearance in Meters');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `bim_model_reference` SET TAGS ('pii_business_glossary_term' = 'Building Information Modeling (BIM) Model Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `bim_model_version` SET TAGS ('pii_business_glossary_term' = 'BIM Model Version');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `building_reference` SET TAGS ('pii_business_glossary_term' = 'Building Reference Code');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `ceiling_height_m` SET TAGS ('pii_business_glossary_term' = 'Ceiling Height in Meters');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `clash_detection_status` SET TAGS ('pii_business_glossary_term' = 'Clash Detection Status');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `clash_detection_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|clashes_detected|clashes_resolved');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `contractor_organization` SET TAGS ('pii_business_glossary_term' = 'Contractor Organization');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `coordination_meeting_date` SET TAGS ('pii_business_glossary_term' = 'Coordination Meeting Date');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `coordination_notes` SET TAGS ('pii_business_glossary_term' = 'Coordination Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `coordination_priority_rank` SET TAGS ('pii_business_glossary_term' = 'Coordination Priority Rank');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `coordination_status` SET TAGS ('pii_business_glossary_term' = 'Coordination Status');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `coordination_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|under_review|signed_off|on_hold|rejected');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `grid_reference_end` SET TAGS ('pii_business_glossary_term' = 'Grid Reference End');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `grid_reference_start` SET TAGS ('pii_business_glossary_term' = 'Grid Reference Start');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `installation_sequence_number` SET TAGS ('pii_business_glossary_term' = 'Installation Sequence Number');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `level_reference` SET TAGS ('pii_business_glossary_term' = 'Level Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `open_clash_count` SET TAGS ('pii_business_glossary_term' = 'Open Clash Count');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `planned_completion_date` SET TAGS ('pii_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `planned_start_date` SET TAGS ('pii_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `primary_discipline` SET TAGS ('pii_business_glossary_term' = 'Primary MEP Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `sign_off_authority` SET TAGS ('pii_business_glossary_term' = 'Sign-Off Authority');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `sign_off_date` SET TAGS ('pii_business_glossary_term' = 'Sign-Off Date');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `soffit_height_m` SET TAGS ('pii_business_glossary_term' = 'Soffit Height in Meters');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `special_requirements` SET TAGS ('pii_business_glossary_term' = 'Special Requirements');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `total_clash_count` SET TAGS ('pii_business_glossary_term' = 'Total Clash Count');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `zone_area_sqm` SET TAGS ('pii_business_glossary_term' = 'Zone Area in Square Meters');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `zone_complexity_rating` SET TAGS ('pii_business_glossary_term' = 'Zone Complexity Rating');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `zone_complexity_rating` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `zone_name` SET TAGS ('pii_business_glossary_term' = 'MEP Zone Name');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `zone_number` SET TAGS ('pii_business_glossary_term' = 'MEP Zone Number');
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` SET TAGS ('pii_subdomain' = 'change_management');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `value_engineering_proposal_id` SET TAGS ('pii_business_glossary_term' = 'Value Engineering (VE) Proposal ID');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Originator Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `affected_design_elements` SET TAGS ('pii_business_glossary_term' = 'Affected Design Elements');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `approval_authority` SET TAGS ('pii_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `change_order_reference` SET TAGS ('pii_business_glossary_term' = 'Change Order (CO) Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `client_decision` SET TAGS ('pii_business_glossary_term' = 'Client Decision');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `client_decision` SET TAGS ('pii_value_regex' = 'accepted|rejected|deferred|conditional_acceptance|pending');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `client_decision_date` SET TAGS ('pii_business_glossary_term' = 'Client Decision Date');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `client_decision_notes` SET TAGS ('pii_business_glossary_term' = 'Client Decision Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `client_review_due_date` SET TAGS ('pii_business_glossary_term' = 'Client Review Due Date');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `client_submission_date` SET TAGS ('pii_business_glossary_term' = 'Client Submission Date');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `environmental_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `estimated_cost_saving` SET TAGS ('pii_business_glossary_term' = 'Estimated Cost Saving');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `implementation_completion_date` SET TAGS ('pii_business_glossary_term' = 'Implementation Completion Date');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `implementation_start_date` SET TAGS ('pii_business_glossary_term' = 'Implementation Start Date');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `implementation_status` SET TAGS ('pii_business_glossary_term' = 'Implementation Status');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `implementation_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|cancelled|on_hold');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `implemented_saving_value` SET TAGS ('pii_business_glossary_term' = 'Implemented Saving Value');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `originator_discipline` SET TAGS ('pii_business_glossary_term' = 'Originator Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `originator_organization` SET TAGS ('pii_business_glossary_term' = 'Originator Organization');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `proposal_description` SET TAGS ('pii_business_glossary_term' = 'Value Engineering (VE) Proposal Description');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `proposal_number` SET TAGS ('pii_business_glossary_term' = 'Value Engineering (VE) Proposal Number');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `proposal_number` SET TAGS ('pii_value_regex' = '^VE-[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `proposal_status` SET TAGS ('pii_business_glossary_term' = 'Value Engineering (VE) Proposal Status');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `proposal_title` SET TAGS ('pii_business_glossary_term' = 'Value Engineering (VE) Proposal Title');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `quality_impact_assessment` SET TAGS ('pii_business_glossary_term' = 'Quality Impact Assessment');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `quality_impact_assessment` SET TAGS ('pii_value_regex' = 'positive|neutral|negative|requires_further_study');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `quality_impact_notes` SET TAGS ('pii_business_glossary_term' = 'Quality Impact Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `related_drawing_references` SET TAGS ('pii_business_glossary_term' = 'Related Drawing References');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `related_specification_references` SET TAGS ('pii_business_glossary_term' = 'Related Specification References');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `reviewed_by` SET TAGS ('pii_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `risk_assessment` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `risk_assessment` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `risk_description` SET TAGS ('pii_business_glossary_term' = 'Risk Description');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `safety_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Safety Impact Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `safety_review_notes` SET TAGS ('pii_business_glossary_term' = 'Safety Review Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `schedule_impact_days` SET TAGS ('pii_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `sustainability_rating` SET TAGS ('pii_business_glossary_term' = 'Sustainability Rating');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `sustainability_rating` SET TAGS ('pii_value_regex' = 'improved|neutral|reduced|not_applicable');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` SET TAGS ('pii_subdomain' = 'change_management');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` SET TAGS ('pii_ssot_role' = 'reference');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` SET TAGS ('pii_ssot_master' = 'contract.contract_scope');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` SET TAGS ('pii_ssot' = 'design.design_scope');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` SET TAGS ('pii_ssot_distinct' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` SET TAGS ('pii_ssot_scope' = 'design');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` SET TAGS ('pii_ssot_counterpart' = 'contract.contract_scope');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` SET TAGS ('pii_ssot_resolved' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `design_scope_id` SET TAGS ('pii_business_glossary_term' = 'Design Scope Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Design Responsibility Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `superseded_by_scope_design_scope_id` SET TAGS ('pii_business_glossary_term' = 'Superseded By Scope Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `applicable_codes_standards` SET TAGS ('pii_business_glossary_term' = 'Applicable Codes and Standards');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `approval_authority` SET TAGS ('pii_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `bim_model_reference` SET TAGS ('pii_business_glossary_term' = 'Building Information Modeling (BIM) Model Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `change_control_baseline` SET TAGS ('pii_business_glossary_term' = 'Change Control Baseline');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `confidentiality_classification` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `confidentiality_classification` SET TAGS ('pii_value_regex' = 'Public|Internal|Confidential|Restricted');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `contract_type` SET TAGS ('pii_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `corrosion_allowance_mm` SET TAGS ('pii_business_glossary_term' = 'Corrosion Allowance Millimeters (mm)');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `design_basis_memorandum_reference` SET TAGS ('pii_business_glossary_term' = 'Design Basis Memorandum (DBM) Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `design_life_years` SET TAGS ('pii_business_glossary_term' = 'Design Life Years');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `design_responsibility_matrix` SET TAGS ('pii_business_glossary_term' = 'Design Responsibility Matrix');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `environmental_design_conditions` SET TAGS ('pii_business_glossary_term' = 'Environmental Design Conditions');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `exclusions_limitations` SET TAGS ('pii_business_glossary_term' = 'Exclusions and Limitations');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `fire_rating_requirements` SET TAGS ('pii_business_glossary_term' = 'Fire Rating Requirements');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `freeze_date` SET TAGS ('pii_business_glossary_term' = 'Scope Freeze Date');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `interface_points` SET TAGS ('pii_business_glossary_term' = 'Interface Points');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `iso_19650_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'ISO 19650 Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `leed_certification_target` SET TAGS ('pii_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Certification Target');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `leed_certification_target` SET TAGS ('pii_value_regex' = 'Not Applicable|Certified|Silver|Gold|Platinum');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `manager_name` SET TAGS ('pii_business_glossary_term' = 'Scope Manager Name');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `narrative_description` SET TAGS ('pii_business_glossary_term' = 'Scope Narrative Description');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `owner_organization` SET TAGS ('pii_business_glossary_term' = 'Scope Owner Organization');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `package_number` SET TAGS ('pii_business_glossary_term' = 'Scope Package Number');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `package_title` SET TAGS ('pii_business_glossary_term' = 'Scope Package Title');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `retention_period_years` SET TAGS ('pii_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `scope_of_work_id` SET TAGS ('pii_business_glossary_term' = 'Contract Scope Id');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `scope_of_work_id` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `scope_of_work_id` SET TAGS ('pii_ssot' = 'contract.contract_scope');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `scope_status` SET TAGS ('pii_business_glossary_term' = 'Scope Status');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `seismic_zone_classification` SET TAGS ('pii_business_glossary_term' = 'Seismic Zone Classification');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `snow_loading_criteria` SET TAGS ('pii_business_glossary_term' = 'Snow Loading Criteria');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `temperature_range_max_c` SET TAGS ('pii_business_glossary_term' = 'Temperature Range Maximum Celsius (C)');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `temperature_range_min_c` SET TAGS ('pii_business_glossary_term' = 'Temperature Range Minimum Celsius (C)');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `wind_loading_criteria` SET TAGS ('pii_business_glossary_term' = 'Wind Loading Criteria');
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` SET TAGS ('pii_subdomain' = 'spatial_coordination');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `interface_point_id` SET TAGS ('pii_business_glossary_term' = 'Interface Point Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approval Authority Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Coordinator Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `actual_handover_date` SET TAGS ('pii_business_glossary_term' = 'Actual Interface Handover Date');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `bim_model_reference` SET TAGS ('pii_business_glossary_term' = 'Building Information Modeling (BIM) Model Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `clash_detection_status` SET TAGS ('pii_business_glossary_term' = 'Clash Detection Status');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `clash_detection_status` SET TAGS ('pii_value_regex' = 'not-applicable|pending|in-progress|resolved|unresolved');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `closure_date` SET TAGS ('pii_business_glossary_term' = 'Interface Closure Date');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Interface Comments');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `coordination_meeting_frequency` SET TAGS ('pii_business_glossary_term' = 'Coordination Meeting Frequency');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `coordination_meeting_frequency` SET TAGS ('pii_value_regex' = 'daily|weekly|bi-weekly|monthly|as-needed|none');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `cost_impact_amount` SET TAGS ('pii_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `cost_impact_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `cost_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Cost Impact Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `interface_agreement_date` SET TAGS ('pii_business_glossary_term' = 'Interface Agreement Date');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `interface_category` SET TAGS ('pii_business_glossary_term' = 'Interface Category');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `interface_category` SET TAGS ('pii_value_regex' = 'design-design|design-construction|construction-construction|construction-commissioning|internal|external');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `interface_description` SET TAGS ('pii_business_glossary_term' = 'Interface Point Description');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `interface_freeze_date` SET TAGS ('pii_business_glossary_term' = 'Interface Freeze Date');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `interface_number` SET TAGS ('pii_business_glossary_term' = 'Interface Point Number');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `interface_status` SET TAGS ('pii_business_glossary_term' = 'Interface Point Status');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `interface_status` SET TAGS ('pii_value_regex' = 'open|under-review|agreed|frozen|closed|disputed');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `interface_title` SET TAGS ('pii_business_glossary_term' = 'Interface Point Title');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `interface_type` SET TAGS ('pii_business_glossary_term' = 'Interface Type');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `interface_type` SET TAGS ('pii_value_regex' = 'physical|functional|data|contractual|organizational');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `location_description` SET TAGS ('pii_business_glossary_term' = 'Interface Location Description');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `originating_party_contact_email` SET TAGS ('pii_business_glossary_term' = 'Originating Party Contact Email');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `originating_party_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `originating_party_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `originating_party_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `originating_party_contact_name` SET TAGS ('pii_business_glossary_term' = 'Originating Party Contact Name');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `originating_party_contact_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `originating_party_organization` SET TAGS ('pii_business_glossary_term' = 'Originating Party Organization');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `originating_scope_package` SET TAGS ('pii_business_glossary_term' = 'Originating Scope Package');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `outstanding_actions` SET TAGS ('pii_business_glossary_term' = 'Outstanding Interface Actions');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `planned_handover_date` SET TAGS ('pii_business_glossary_term' = 'Planned Interface Handover Date');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Interface Priority');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `receiving_party_contact_email` SET TAGS ('pii_business_glossary_term' = 'Receiving Party Contact Email');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `receiving_party_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `receiving_party_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `receiving_party_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `receiving_party_contact_name` SET TAGS ('pii_business_glossary_term' = 'Receiving Party Contact Name');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `receiving_party_contact_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `receiving_party_organization` SET TAGS ('pii_business_glossary_term' = 'Receiving Party Organization');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `receiving_scope_package` SET TAGS ('pii_business_glossary_term' = 'Receiving Scope Package');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `related_drawing_references` SET TAGS ('pii_business_glossary_term' = 'Related Drawing References');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `related_rfi_numbers` SET TAGS ('pii_business_glossary_term' = 'Related Request for Information (RFI) Numbers');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Interface Risk Level');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'very-high|high|medium|low|very-low');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `schedule_impact_days` SET TAGS ('pii_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` SET TAGS ('pii_subdomain' = 'engineering_drawings');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `calculation_register_id` SET TAGS ('pii_business_glossary_term' = 'Calculation Register ID');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `emission_factor_id` SET TAGS ('pii_business_glossary_term' = 'Emission Factor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `primary_calculation_employee_id` SET TAGS ('pii_business_glossary_term' = 'Author ID');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `primary_calculation_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `primary_calculation_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `analysis_software` SET TAGS ('pii_business_glossary_term' = 'Analysis Software');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `approver_name` SET TAGS ('pii_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `approver_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `approver_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `author_name` SET TAGS ('pii_business_glossary_term' = 'Author Name');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `author_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `author_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `calculation_number` SET TAGS ('pii_business_glossary_term' = 'Calculation Number');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `calculation_purpose` SET TAGS ('pii_business_glossary_term' = 'Calculation Purpose');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `calculation_purpose` SET TAGS ('pii_value_regex' = 'member_sizing|hydraulic_analysis|load_study|heat_load|fire_hydraulics|other');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `checker_name` SET TAGS ('pii_business_glossary_term' = 'Checker Name');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `checker_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `checker_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `creation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `design_code` SET TAGS ('pii_business_glossary_term' = 'Design Code');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `discipline` SET TAGS ('pii_value_regex' = 'structural|hydraulic|electrical|hvac|fire_protection|civil');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `input_assumptions` SET TAGS ('pii_business_glossary_term' = 'Input Assumptions');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `is_confidential` SET TAGS ('pii_business_glossary_term' = 'Confidential Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `result_units` SET TAGS ('pii_business_glossary_term' = 'Result Units');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `result_value` SET TAGS ('pii_business_glossary_term' = 'Result Value');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `revision_status` SET TAGS ('pii_business_glossary_term' = 'Revision Status');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `revision_status` SET TAGS ('pii_value_regex' = 'draft|checked|approved|superseded');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Calculation Title');
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'WBS Code');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` SET TAGS ('pii_subdomain' = 'spatial_coordination');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` SET TAGS ('pii_association_edges' = 'design.drawing,equipment.asset');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `equipment_installation_id` SET TAGS ('pii_business_glossary_term' = 'Equipment Installation - Installation Id');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment Installation - Asset Id');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project Id');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `drawing_id` SET TAGS ('pii_business_glossary_term' = 'Equipment Installation - Drawing Id');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `actual_date` SET TAGS ('pii_business_glossary_term' = 'Actual Date');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `actual_install_date` SET TAGS ('pii_business_glossary_term' = 'Actual Install Date');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `actual_installation_date` SET TAGS ('pii_business_glossary_term' = 'Actual Installation Date');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `as_built_ref` SET TAGS ('pii_business_glossary_term' = 'As Built Ref');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `commissioning_date` SET TAGS ('pii_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `commissioning_required` SET TAGS ('pii_business_glossary_term' = 'Commissioning Required');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `commissioning_status` SET TAGS ('pii_business_glossary_term' = 'Commissioning Status');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `elevation` SET TAGS ('pii_business_glossary_term' = 'Elevation');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `elevation_level` SET TAGS ('pii_business_glossary_term' = 'Elevation Level');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `inspection_status` SET TAGS ('pii_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `installation_date` SET TAGS ('pii_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `installation_location` SET TAGS ('pii_business_glossary_term' = 'Installation Location');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `installation_method` SET TAGS ('pii_business_glossary_term' = 'Installation Method');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `installation_status` SET TAGS ('pii_business_glossary_term' = 'Installation Status');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `installed_by` SET TAGS ('pii_business_glossary_term' = 'Installed By');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `location_ref` SET TAGS ('pii_business_glossary_term' = 'Location Ref');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `location_reference` SET TAGS ('pii_business_glossary_term' = 'Location Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `mounting_type` SET TAGS ('pii_business_glossary_term' = 'Mounting Type');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `orientation` SET TAGS ('pii_business_glossary_term' = 'Orientation');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `planned_date` SET TAGS ('pii_business_glossary_term' = 'Planned Date');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `planned_install_date` SET TAGS ('pii_business_glossary_term' = 'Planned Install Date');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `planned_installation_date` SET TAGS ('pii_business_glossary_term' = 'Planned Installation Date');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Quantity Installed');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `tag_number` SET TAGS ('pii_business_glossary_term' = 'Tag Number');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `test_status` SET TAGS ('pii_business_glossary_term' = 'Test Status');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ALTER COLUMN `verified_by` SET TAGS ('pii_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` SET TAGS ('pii_subdomain' = 'spatial_coordination');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` SET TAGS ('pii_association_edges' = 'design.interface_point,equipment.asset');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `interface_equipment_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Interface Equipment Assignment - Interface Equipment Assignment Id');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Interface Equipment Assignment - Asset Id');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `interface_point_id` SET TAGS ('pii_business_glossary_term' = 'Interface Equipment Assignment - Interface Point Id');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `assigned_date` SET TAGS ('pii_business_glossary_term' = 'Assigned Date');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `assignment_date` SET TAGS ('pii_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `assignment_role` SET TAGS ('pii_business_glossary_term' = 'Assignment Role');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `assignment_status` SET TAGS ('pii_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `assignment_type` SET TAGS ('pii_business_glossary_term' = 'Assignment Type');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `connection_type` SET TAGS ('pii_business_glossary_term' = 'Connection Type');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `coordination_notes` SET TAGS ('pii_business_glossary_term' = 'Coordination Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `coordination_status` SET TAGS ('pii_business_glossary_term' = 'Coordination Status');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `installation_date` SET TAGS ('pii_business_glossary_term' = 'Asset Installation Date');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `interface_equipment_assignment_status` SET TAGS ('pii_business_glossary_term' = 'Interface Equipment Assignment Status');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `interface_notes` SET TAGS ('pii_business_glossary_term' = 'Interface Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `interface_role` SET TAGS ('pii_business_glossary_term' = 'Interface Role');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `interface_status` SET TAGS ('pii_business_glossary_term' = 'Interface Status');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `interface_type` SET TAGS ('pii_business_glossary_term' = 'Interface Type');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `resolved_date` SET TAGS ('pii_business_glossary_term' = 'Resolved Date');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `responsibility_party` SET TAGS ('pii_business_glossary_term' = 'Responsibility Party');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `responsible_discipline` SET TAGS ('pii_business_glossary_term' = 'Responsible Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `responsible_party` SET TAGS ('pii_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `role_in_interface` SET TAGS ('pii_business_glossary_term' = 'Asset Role in Interface');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ALTER COLUMN `verified_flag` SET TAGS ('pii_business_glossary_term' = 'Verified Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` SET TAGS ('pii_subdomain' = 'change_management');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` SET TAGS ('pii_association_edges' = 'design.change_notice,equipment.asset');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `change_impact_id` SET TAGS ('pii_business_glossary_term' = 'Change Impact - Change Impact Id');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Change Impact - Asset Id');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `change_notice_id` SET TAGS ('pii_business_glossary_term' = 'Change Impact - Change Notice Id');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project Id');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `affected_discipline` SET TAGS ('pii_business_glossary_term' = 'Affected Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `assessed_by` SET TAGS ('pii_business_glossary_term' = 'Assessed By');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `assessed_date` SET TAGS ('pii_business_glossary_term' = 'Assessed Date');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `assessment_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `change_impact_status` SET TAGS ('pii_business_glossary_term' = 'Change Impact Status');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `cost_impact` SET TAGS ('pii_business_glossary_term' = 'Cost Impact');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `cost_impact_amount` SET TAGS ('pii_business_glossary_term' = 'Asset Cost Impact');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `disposition` SET TAGS ('pii_business_glossary_term' = 'Disposition');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `impact_category` SET TAGS ('pii_business_glossary_term' = 'Impact Category');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `impact_description` SET TAGS ('pii_business_glossary_term' = 'Impact Description');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `impact_severity` SET TAGS ('pii_business_glossary_term' = 'Impact Severity');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `impact_status` SET TAGS ('pii_business_glossary_term' = 'Impact Status');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `impact_type` SET TAGS ('pii_business_glossary_term' = 'Impact Type');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `mitigation_action` SET TAGS ('pii_business_glossary_term' = 'Mitigation Action');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `mutator_note` SET TAGS ('pii_business_glossary_term' = 'Mutator Note');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `schedule_impact_days` SET TAGS ('pii_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `scope_impact` SET TAGS ('pii_business_glossary_term' = 'Scope Impact');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `scope_impact_desc` SET TAGS ('pii_business_glossary_term' = 'Scope Impact Desc');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `severity` SET TAGS ('pii_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` SET TAGS ('pii_subdomain' = 'spatial_coordination');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` SET TAGS ('pii_association_edges' = 'design.mep_coordination_zone,equipment.asset');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `zone_equipment_allocation_id` SET TAGS ('pii_business_glossary_term' = 'Zone Equipment Allocation - Zone Equipment Allocation Id');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Zone Equipment Allocation - Asset Id');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `mep_coordination_zone_id` SET TAGS ('pii_business_glossary_term' = 'Zone Equipment Allocation - Mep Coordination Zone Id');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `access_requirement` SET TAGS ('pii_business_glossary_term' = 'Access Requirement');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `allocated_by` SET TAGS ('pii_business_glossary_term' = 'Allocated By');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `allocated_date` SET TAGS ('pii_business_glossary_term' = 'Allocated Date');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `allocated_quantity` SET TAGS ('pii_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `allocation_date` SET TAGS ('pii_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `allocation_status` SET TAGS ('pii_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `asset_position` SET TAGS ('pii_business_glossary_term' = 'Asset Position');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `clash_count` SET TAGS ('pii_business_glossary_term' = 'Clash Count');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `clash_status` SET TAGS ('pii_business_glossary_term' = 'Clash Status');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `clearance_requirement` SET TAGS ('pii_business_glossary_term' = 'Clearance Requirement');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `clearance_verified` SET TAGS ('pii_business_glossary_term' = 'Clearance Verified');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `coordination_notes` SET TAGS ('pii_business_glossary_term' = 'Coordination Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `coordination_priority` SET TAGS ('pii_business_glossary_term' = 'Coordination Priority');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `coordination_status` SET TAGS ('pii_business_glossary_term' = 'Coordination Status');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `elevation` SET TAGS ('pii_business_glossary_term' = 'Elevation');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `is_clash_resolved` SET TAGS ('pii_business_glossary_term' = 'Is Clash Resolved');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `orientation` SET TAGS ('pii_business_glossary_term' = 'Orientation');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `quantity_allocated` SET TAGS ('pii_business_glossary_term' = 'Quantity Allocated');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `responsible_discipline` SET TAGS ('pii_business_glossary_term' = 'Responsible Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `responsible_party` SET TAGS ('pii_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `spatial_coordination_notes` SET TAGS ('pii_business_glossary_term' = 'Spatial Coordination Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `zone_capacity_used` SET TAGS ('pii_business_glossary_term' = 'Zone Capacity Used');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `zone_ref` SET TAGS ('pii_business_glossary_term' = 'Zone Ref');
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ALTER COLUMN `zone_reference` SET TAGS ('pii_business_glossary_term' = 'Zone Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` SET TAGS ('pii_subdomain' = 'engineering_drawings');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` SET TAGS ('pii_association_edges' = 'design.drawing,schedule.activity');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `drawing_requirement_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Requirement - Drawing Requirement Id');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Requirement - Activity Id');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `drawing_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Requirement - Drawing Id');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `dependency_type` SET TAGS ('pii_business_glossary_term' = 'Dependency Type');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `dependency_type` SET TAGS ('pii_schedule' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `drawing_requirement_description` SET TAGS ('pii_business_glossary_term' = 'Drawing Requirement Description');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `drawing_requirement_status` SET TAGS ('pii_business_glossary_term' = 'Drawing Requirement Status');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `is_critical` SET TAGS ('pii_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `lag_days` SET TAGS ('pii_business_glossary_term' = 'Lag Days');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `lag_days` SET TAGS ('pii_schedule' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `mandatory_flag` SET TAGS ('pii_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `required_by_date` SET TAGS ('pii_business_glossary_term' = 'Required By Date');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `required_date` SET TAGS ('pii_business_glossary_term' = 'Required Date');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `requirement_description` SET TAGS ('pii_business_glossary_term' = 'Requirement Description');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `requirement_status` SET TAGS ('pii_business_glossary_term' = 'Requirement Status');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `requirement_type` SET TAGS ('pii_business_glossary_term' = 'Requirement Type');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `responsible_party` SET TAGS ('pii_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ALTER COLUMN `verified_by` SET TAGS ('pii_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` SET TAGS ('pii_subdomain' = 'engineering_drawings');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` SET TAGS ('pii_association_edges' = 'design.drawing,safety.incident');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ALTER COLUMN `drawing_incident_link_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Incident Link - Drawing Incident Link Id');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ALTER COLUMN `drawing_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Incident Link - Drawing Id');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ALTER COLUMN `incident_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Incident Link - Incident Id');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ALTER COLUMN `drawing_incident_link_status` SET TAGS ('pii_business_glossary_term' = 'Drawing Incident Link Status');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ALTER COLUMN `impact_description` SET TAGS ('pii_business_glossary_term' = 'Impact Description');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ALTER COLUMN `is_root_cause` SET TAGS ('pii_business_glossary_term' = 'Is Root Cause');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ALTER COLUMN `link_date` SET TAGS ('pii_business_glossary_term' = 'Link Date');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ALTER COLUMN `link_description` SET TAGS ('pii_business_glossary_term' = 'Link Description');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ALTER COLUMN `link_reason` SET TAGS ('pii_business_glossary_term' = 'Link Reason');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ALTER COLUMN `link_status` SET TAGS ('pii_business_glossary_term' = 'Link Status');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ALTER COLUMN `link_type` SET TAGS ('pii_business_glossary_term' = 'Link Type');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ALTER COLUMN `linked_by` SET TAGS ('pii_business_glossary_term' = 'Linked By');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ALTER COLUMN `linked_date` SET TAGS ('pii_business_glossary_term' = 'Linked Date');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ALTER COLUMN `reference_notes` SET TAGS ('pii_business_glossary_term' = 'Reference Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ALTER COLUMN `relevance` SET TAGS ('pii_business_glossary_term' = 'Relevance');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ALTER COLUMN `relevance_description` SET TAGS ('pii_business_glossary_term' = 'Relevance Description');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ALTER COLUMN `relevance_note` SET TAGS ('pii_business_glossary_term' = 'Relevance Note');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` SET TAGS ('pii_subdomain' = 'document_control');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `workflow_template_id` SET TAGS ('pii_business_glossary_term' = 'Workflow Template Identifier');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `parent_workflow_template_id` SET TAGS ('pii_business_glossary_term' = 'Parent Workflow Template Id');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `parent_workflow_template_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `approval_required` SET TAGS ('pii_business_glossary_term' = 'Approval Required');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `average_step_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Average Step Duration Minutes');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `workflow_template_code` SET TAGS ('pii_business_glossary_term' = 'Code');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `compliance_requirements` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `default_assignee_role` SET TAGS ('pii_business_glossary_term' = 'Default Assignee Role');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `workflow_template_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `documentation_url` SET TAGS ('pii_business_glossary_term' = 'Documentation Url');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `escalation_policy` SET TAGS ('pii_business_glossary_term' = 'Escalation Policy');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `is_default` SET TAGS ('pii_business_glossary_term' = 'Is Default');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `max_concurrent_instances` SET TAGS ('pii_business_glossary_term' = 'Max Concurrent Instances');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `workflow_template_name` SET TAGS ('pii_business_glossary_term' = 'Name');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `notification_enabled` SET TAGS ('pii_business_glossary_term' = 'Notification Enabled');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `retention_period_days` SET TAGS ('pii_business_glossary_term' = 'Retention Period Days');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `reviewed_by` SET TAGS ('pii_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `step_count` SET TAGS ('pii_business_glossary_term' = 'Step Count');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `workflow_template_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ALTER COLUMN `workflow_template_type` SET TAGS ('pii_business_glossary_term' = 'Type');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` SET TAGS ('pii_subdomain' = 'handover_commissioning');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` SET TAGS ('pii_ssot_role' = 'master');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` SET TAGS ('pii_ssot_resolved_against' = 'quality.quality_submittal');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` SET TAGS ('pii_ssot_distinct' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` SET TAGS ('pii_ssot_scope' = 'design');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` SET TAGS ('pii_ssot_counterpart' = 'quality.quality_submittal');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` SET TAGS ('pii_ssot_master' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `engineering_submittal_id` SET TAGS ('pii_business_glossary_term' = 'Design Submittal Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `drawing_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `rfi_id` SET TAGS ('pii_business_glossary_term' = 'Rfi Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Submitting Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `trade_package_id` SET TAGS ('pii_business_glossary_term' = 'Trade Package Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `transmittal_id` SET TAGS ('pii_business_glossary_term' = 'Transmittal Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `actual_review_date` SET TAGS ('pii_business_glossary_term' = 'Actual Review Completion Date');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `actual_submission_date` SET TAGS ('pii_business_glossary_term' = 'Actual Submission Date');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `approval_authority_level` SET TAGS ('pii_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `approval_authority_level` SET TAGS ('pii_value_regex' = 'contractor|design_consultant|client|regulatory_authority|independent_verifier');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `approval_disposition` SET TAGS ('pii_business_glossary_term' = 'Approval Disposition Code');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `approval_disposition` SET TAGS ('pii_value_regex' = 'approved|approved_as_noted|revise_and_resubmit|rejected|no_exception_taken|reviewed_for_information');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `approver_name` SET TAGS ('pii_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `approver_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `approver_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `attachment_count` SET TAGS ('pii_business_glossary_term' = 'Attachment File Count');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `bim_model_reference` SET TAGS ('pii_business_glossary_term' = 'Building Information Modeling (BIM) Model Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `closure_date` SET TAGS ('pii_business_glossary_term' = 'Submittal Closure Date');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Classification Level');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `cost_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Cost Impact Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `created_timestamp` SET TAGS ('pii_ssot_source' = 'quality.quality_submittal');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `estimated_cost_impact_amount` SET TAGS ('pii_business_glossary_term' = 'Estimated Cost Impact Amount');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `estimated_cost_impact_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `file_format` SET TAGS ('pii_business_glossary_term' = 'Primary File Format');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_ssot_source' = 'quality.quality_submittal');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Submittal Priority Level');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `regulatory_authority` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Required Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `required_submission_date` SET TAGS ('pii_business_glossary_term' = 'Required Submission Date');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `response_notes` SET TAGS ('pii_business_glossary_term' = 'Submitter Response Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `review_comments` SET TAGS ('pii_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `review_due_date` SET TAGS ('pii_business_glossary_term' = 'Review Due Date');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `reviewer_name` SET TAGS ('pii_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `reviewer_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `reviewer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `reviewer_name` SET TAGS ('pii_ssot_source' = 'quality.quality_submittal');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `reviewing_organization` SET TAGS ('pii_business_glossary_term' = 'Reviewing Organization Name');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Submittal Revision Number');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `revision_number` SET TAGS ('pii_ssot_source' = 'quality.quality_submittal');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `schedule_impact_days` SET TAGS ('pii_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `schedule_impact_days` SET TAGS ('pii_ssot_source' = 'quality.quality_submittal');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `schedule_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Schedule Impact Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `specification_section` SET TAGS ('pii_business_glossary_term' = 'Specification Section Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `specification_section` SET TAGS ('pii_ssot_source' = 'quality.quality_submittal');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `submittal_number` SET TAGS ('pii_business_glossary_term' = 'Submittal Number');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `submittal_number` SET TAGS ('pii_ssot_source' = 'quality.quality_submittal');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `submittal_status` SET TAGS ('pii_business_glossary_term' = 'Submittal Review Status');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `submittal_type` SET TAGS ('pii_business_glossary_term' = 'Submittal Type');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `submittal_type` SET TAGS ('pii_ssot_source' = 'quality.quality_submittal');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `submitting_organization` SET TAGS ('pii_business_glossary_term' = 'Submitting Organization Name');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `supersedes_submittal_number` SET TAGS ('pii_business_glossary_term' = 'Supersedes Submittal Number');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Submittal Title');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `title` SET TAGS ('pii_ssot_source' = 'quality.quality_submittal');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `wbs_code` SET TAGS ('pii_ssot_source' = 'quality.quality_submittal');
