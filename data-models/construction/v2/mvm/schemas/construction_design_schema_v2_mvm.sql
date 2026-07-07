-- Schema for Domain: design | Business: Construction | Version: v2_mvm
-- Generated on: 2026-06-27 01:56:03

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`design` COMMENT 'Engineering and design domain owning BIM models, CAD drawings, technical specifications, design packages, RFIs, submittals, clash detection, document control registers, transmittals, correspondence, workflow approvals, and handover documentation for construction projects';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`transmittal` (
    `transmittal_id` BIGINT COMMENT 'Unique identifier for the transmittal record. Primary key for the transmittal entity.',
    `phase_id` BIGINT COMMENT 'Reference to the project phase or stage during which this transmittal is issued. Provides temporal context within the project lifecycle.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Design transmittals are formally issued to vendors in construction (RFQ packages, IFC drawings, specifications). recipient_organization is a plain-text denormalization when the recipient is a vendor. ',
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
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: RFI management requires tracking which client account the RFI is raised against for client-specific RFI registers, escalation reporting, and contractual response-time SLA monitoring. A construction do',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: RFIs may result in cost changes; linking each RFI to the relevant cost code enables cost impact analysis.',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: RFIs with cost_impact_flag=true must be traced to the specific budget line affected for cost impact management and budget variance reporting. Project controls engineers use rfi→project_budget traceabi',
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
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: Documents in the register are organized and issued as part of formal design packages. Adding document_register.package_id as a FK to design.package.package_id links each document register entry to its',
    `transmittal_id` BIGINT COMMENT 'Foreign key linking to design.transmittal. Business justification: Documents in the register are formally issued via transmittals. document_register.transmittal_number is a denormalized STRING reference. Adding document_register.transmittal_id as a FK to design.trans',
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
    `retention_period_years` STRING COMMENT 'Number of years the document must be retained per regulatory, contractual, or organizational requirements before eligible for disposal.',
    `review_due_date` DATE COMMENT 'Target date by which the document review must be completed to maintain project schedule.',
    `reviewer_name` STRING COMMENT 'Name of the individual who reviewed the document for technical accuracy and completeness.',
    `revision_description` STRING COMMENT 'Brief description of the changes made in the current revision compared to the previous version.',
    `revision_number` STRING COMMENT 'Current revision identifier of the document following project revision convention (e.g., A, B, C or 01, 02, 03 or R0, R1, R2).',
    `storage_location` STRING COMMENT 'Physical or digital location where the document is stored (e.g., Aconex folder path, SharePoint site, physical archive location).',
    `superseded_by_document_number` STRING COMMENT 'Document number of the newer document that supersedes this document, if applicable. Used to maintain document lineage and version control.',
    `supersedes_document_number` STRING COMMENT 'Document number of the older document that this document supersedes or replaces.',
    CONSTRAINT pk_document_register PRIMARY KEY(`document_register_id`)
) COMMENT 'Central master register of all project documents beyond drawings — including specifications, reports, procedures, method statements, O&M manuals, certificates, and correspondence — managed in Aconex CDE (Common Data Environment). Captures document number, title, document type, discipline, revision, status, originator, issue date, confidentiality classification, retention period, and numbering convention. Provides the authoritative catalog of all project documentation per ISO 19650 information container requirements.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`revision` (
    `revision_id` BIGINT COMMENT 'Primary key for revision',
    `document_register_id` BIGINT COMMENT 'Reference to the parent document in the document register. Links this revision to its master document record.',
    `superseded_revision_id` BIGINT COMMENT 'Reference to the previous revision that this version replaces. Maintains the revision chain and version history.',
    `transmittal_id` BIGINT COMMENT 'Foreign key linking to design.transmittal. Business justification: Document revisions are issued and distributed via transmittals. revision.transmittal_number is a denormalized STRING reference to the transmittal. Adding revision.transmittal_id as a FK to design.tran',
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
    CONSTRAINT pk_revision PRIMARY KEY(`revision_id`)
) COMMENT 'Version control record for each document in the document register, capturing revision identifier, revision date, revision description, author, reviewer, approver, change summary, superseded revision reference, and file storage path. Maintains a complete and auditable version history for all project documents to support regulatory compliance, handover, and DLP (Defects Liability Period) obligations.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`workflow_approval` (
    `workflow_approval_id` BIGINT COMMENT 'Unique identifier for the workflow approval instance. Primary key for the workflow approval entity.',
    `document_register_id` BIGINT COMMENT 'Reference to the document or deliverable under review in this workflow. Links to the document management system record.',
    `revision_id` BIGINT COMMENT 'Foreign key linking to design.revision. Business justification: Workflow approvals are initiated to formally approve a specific document revision. workflow_approval.revision_number is a denormalized STRING reference to the revision being approved. Adding workflow_',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`bim_model` (
    `bim_model_id` BIGINT COMMENT 'Unique identifier for the BIM model record. Primary key for the BIM model entity.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: BIM models represent specific physical assets in ISO 19650 digital twin and asset handover workflows. Linking bim_model to asset enables BIM model for this asset queries critical for facilities mana',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: BIM models are formally issued as part of design deliverable packages at project milestones. Adding bim_model.package_id as a FK to design.package.package_id links each BIM model to the design package',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: BIM models progress through LOD levels tied to project phases (LOD 100 concept → LOD 500 as-built) per ISO 19650. BIM managers track model versions by phase for BIM Execution Plan compliance. Phase-ba',
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
    `bim_model_id` BIGINT COMMENT 'Foreign key linking to design.bim_model. Business justification: Drawing belongs to a BIM model; replace string reference with proper FK to BIM model for traceability.',
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
    `bim_model_id` BIGINT COMMENT 'Foreign key linking to design.bim_model. Business justification: Drawing revisions are derived from or associated with a specific BIM model version. drawing_revision.bim_model_reference is a denormalized STRING reference to the source BIM model. Adding drawing_revi',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project this drawing revision is associated with. Enables project-level filtering and reporting.',
    `drawing_id` BIGINT COMMENT 'Reference to the parent drawing document that this revision belongs to. Links to the master drawing record in the document management system.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Drawing revisions triggered by safety incidents (design error caused an incident, requiring corrective drawing revision) must be traceable to the originating incident. Incident investigators and desig',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: Drawing revisions are formally issued as part of design packages at project milestones. Adding drawing_revision.package_id as a FK to design.package.package_id links each drawing revision event to the',
    `rfi_id` BIGINT COMMENT 'Foreign key linking to design.rfi. Business justification: Provides a second inbound link to RFI from drawing_revision, consolidating the existing string reference into a proper FK.',
    `superseded_revision_drawing_revision_id` BIGINT COMMENT 'Reference to the previous revision that this revision replaces or supersedes. Maintains the version control chain and audit trail.',
    `transmittal_id` BIGINT COMMENT 'Foreign key linking to design.transmittal. Business justification: Each drawing revision is distributed via a formal transmittal. drawing_revision.transmittal_number is a denormalized STRING reference. Adding drawing_revision.transmittal_id as a FK to design.transmit',
    `acknowledgment_required_flag` BOOLEAN COMMENT 'Indicates whether recipients are required to formally acknowledge receipt and review of this revision. Used for critical or contractual revisions.',
    `acknowledgment_status` STRING COMMENT 'Current status of acknowledgment from recipients. Tracks whether required acknowledgments have been received.. Valid values are `not_required|pending|acknowledged|overdue`',
    `approval_date` DATE COMMENT 'Date when this revision received formal approval for issuance. Marks the transition from draft to approved status.',
    `approver_name` STRING COMMENT 'Full name of the individual who approved this revision. Provides human-readable identification for the approval authority.',
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
    `wbs_code` STRING COMMENT 'The WBS element or work package code that this drawing revision is associated with. Enables project structure-based reporting and cost allocation.',
    CONSTRAINT pk_drawing_revision PRIMARY KEY(`drawing_revision_id`)
) COMMENT 'Transactional record capturing each revision event for a drawing. Stores revision code, revision date, description of changes, reason for revision (RFI-driven, design change, client instruction), issuing engineer, reviewer, approver, and distribution status. Enables full version-control audit trail for IFC/CAD drawing lifecycle.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`technical_specification` (
    `technical_specification_id` BIGINT COMMENT 'Unique identifier for the technical specification document. Primary key for this entity.',
    `asset_category_id` BIGINT COMMENT 'Foreign key linking to equipment.asset_category. Business justification: Technical specifications govern procurement, installation, and maintenance standards for an equipment category (e.g., crane specs, generator specs). Procurement and QA teams run specifications by equ',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Technical specifications are organized by CSI division and drive material/workmanship cost estimates. Linking specification to cost_code enables QS/estimating teams to allocate budget by specification',
    `hazard_register_id` BIGINT COMMENT 'Foreign key linking to safety.hazard_register. Business justification: Technical specifications for hazardous materials (asbestos, chemicals, explosives) must reference the hazard register entry. Spec authors and HSE officers must confirm spec requirements align with reg',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Technical specifications are developed and approved per project phase (basis of design, detailed design, construction). Phase-gated specification approval is required for design gate reviews. Specific',
    `skill_trade_id` BIGINT COMMENT 'Foreign key linking to workforce.skill_trade. Business justification: Technical specifications define workmanship standards and mandatory trade qualifications (e.g., AWS D1.1 welding cert for structural steel specs). Linking spec to skill_trade enables staffing plan val',
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
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Design packages are issued per project phase (concept, FEED, detailed design, IFC). Phase-gated package approval is a standard design management process. Design managers report package completion by p',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Design packages (IFC, IFT, IFR) are contractual deliverables tied to milestone payments and budget drawdowns. Linking package to project_budget enables earned value tracking — when a package is approv',
    `transmittal_id` BIGINT COMMENT 'Foreign key linking to design.transmittal. Business justification: A design package is formally dispatched via a transmittal. package.transmittal_number is a denormalized STRING reference to the transmittal record. Adding package.transmittal_id as a proper FK to desi',
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
    `wbs_code` STRING COMMENT 'Work Breakdown Structure code linking this package to the project cost and schedule hierarchy.',
    CONSTRAINT pk_package PRIMARY KEY(`package_id`)
) COMMENT 'Master record representing a formal design deliverable package issued at a project milestone (30%, 60%, 90%, IFC, As-Built). Groups related drawings, specifications, calculations, and BIM models into a contractual issuance unit. Tracks package number, milestone stage, discipline, issue date, contractual due date, recipient distribution list, submission status, client acceptance status, and approval workflow state. Also serves as the contractual deliverable register (DDR), tracking each required deliverable item with its type (drawing, specification, report, model, calculation), responsible discipline, milestone linkage, planned vs. actual submission dates, and client acceptance status. SSOT for design deliverable scheduling, contractual compliance monitoring, and milestone gate readiness assessment.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`design`.`engineering_submittal` (
    `engineering_submittal_id` BIGINT COMMENT 'Unique identifier for the design submittal record. Primary key for the design submittal entity.',
    `bim_model_id` BIGINT COMMENT 'Foreign key linking to design.bim_model. Business justification: Engineering submittals (shop drawings, product data) are often derived from or reference a specific BIM model. engineering_submittal.bim_model_reference is a denormalized STRING reference to the sourc',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Submittals are associated with cost items; linking to cost code supports cost allocation and audit of submitted items.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Material submittals reference specific material master records for approval and traceability.',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: Engineering submittals are organized and issued as part of formal design packages. Adding engineering_submittal.package_id as a FK to design.package.package_id establishes the parent-child relationshi',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Engineering submittals with cost_impact_flag=true require direct traceability to the budget line for cost impact authorization and budget variance reporting. The existing cost_code FK identifies the c',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Engineering submittals for high-risk activities (confined space, hot work, lifting plans) must reference the governing risk assessment. Submittal reviewers explicitly verify risk assessment adequacy —',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Engineering submittals (shop drawings, material submittals) are submitted BY vendors in construction. submitting_organization is a plain-text denormalization. Structured FK enables vendor submittal pe',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Engineering submittals are submitted in compliance with a governing technical specification. engineering_submittal.specification_section (STRING) references a section within a specification, but there',
    `transmittal_id` BIGINT COMMENT 'Foreign key linking to design.transmittal. Business justification: Link submittal to the transmittal that delivered it, enabling end‑to‑end document flow tracking.',
    `actual_review_date` DATE COMMENT 'Actual date on which the review was completed and the submittal disposition was communicated back to the submitting party.',
    `actual_submission_date` DATE COMMENT 'Actual date on which the submittal was formally submitted to the reviewing authority, used for schedule performance tracking and SLA compliance.',
    `approval_authority_level` STRING COMMENT 'Classification of the approval authority indicating the organizational level or role responsible for final disposition: contractor for internal review, design_consultant for technical design review, client for owner acceptance, regulatory_authority for statutory compliance, independent_verifier for third-party certification.. Valid values are `contractor|design_consultant|client|regulatory_authority|independent_verifier`',
    `approval_disposition` STRING COMMENT 'Final disposition code assigned by the reviewing authority indicating the outcome of the review: approved for full acceptance without changes, approved_as_noted for conditional acceptance with minor comments that do not require resubmission, revise_and_resubmit for rework and formal resubmission required, rejected for non-compliance requiring major revision, no_exception_taken for acknowledgment without formal approval, reviewed_for_information for informational submittals not requiring approval.. Valid values are `approved|approved_as_noted|revise_and_resubmit|rejected|no_exception_taken|reviewed_for_information`',
    `approver_name` STRING COMMENT 'Full name of the individual with approval authority who formally authorized the submittal disposition, may be the same as reviewer or a senior authority depending on approval matrix.',
    `attachment_count` STRING COMMENT 'Number of supporting documents, drawings, data sheets, or files attached to this submittal, used for completeness verification and document control.',
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
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_construction_v1`.`design`.`package`(`package_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_transmittal_id` FOREIGN KEY (`transmittal_id`) REFERENCES `vibe_construction_v1`.`design`.`transmittal`(`transmittal_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `vibe_construction_v1`.`design`.`document_register`(`document_register_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_superseded_revision_id` FOREIGN KEY (`superseded_revision_id`) REFERENCES `vibe_construction_v1`.`design`.`revision`(`revision_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_transmittal_id` FOREIGN KEY (`transmittal_id`) REFERENCES `vibe_construction_v1`.`design`.`transmittal`(`transmittal_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `vibe_construction_v1`.`design`.`document_register`(`document_register_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_construction_v1`.`design`.`revision`(`revision_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ADD CONSTRAINT `fk_design_bim_model_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_construction_v1`.`design`.`package`(`package_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ADD CONSTRAINT `fk_design_bim_model_superseded_by_model_bim_model_id` FOREIGN KEY (`superseded_by_model_bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_construction_v1`.`design`.`package`(`package_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `vibe_construction_v1`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_superseded_revision_drawing_revision_id` FOREIGN KEY (`superseded_revision_drawing_revision_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing_revision`(`drawing_revision_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_transmittal_id` FOREIGN KEY (`transmittal_id`) REFERENCES `vibe_construction_v1`.`design`.`transmittal`(`transmittal_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`package` ADD CONSTRAINT `fk_design_package_transmittal_id` FOREIGN KEY (`transmittal_id`) REFERENCES `vibe_construction_v1`.`design`.`transmittal`(`transmittal_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ADD CONSTRAINT `fk_design_engineering_submittal_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ADD CONSTRAINT `fk_design_engineering_submittal_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_construction_v1`.`design`.`package`(`package_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ADD CONSTRAINT `fk_design_engineering_submittal_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ADD CONSTRAINT `fk_design_engineering_submittal_transmittal_id` FOREIGN KEY (`transmittal_id`) REFERENCES `vibe_construction_v1`.`design`.`transmittal`(`transmittal_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`design` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_construction_v1`.`design` SET TAGS ('dbx_domain' = 'design');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` SET TAGS ('dbx_subdomain' = 'document_control');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `transmittal_id` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `acknowledgement_by` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged By');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `acknowledgement_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `acknowledgement_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Date');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `acknowledgement_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Required Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Status');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_value_regex' = 'pending|acknowledged|overdue|not_required');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'electronic|courier|hand_delivery|postal_mail|ftp|portal');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `transmittal_description` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Description');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Document Count');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Priority');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `purpose_of_issue` SET TAGS ('dbx_business_glossary_term' = 'Purpose of Issue');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `purpose_of_issue` SET TAGS ('dbx_value_regex' = 'for_approval|for_information|for_construction|for_record|for_review|for_comment');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `recipient_organization` SET TAGS ('dbx_business_glossary_term' = 'Recipient Organization');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `reference_transmittal_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Transmittal Number');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Remarks');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `revision_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.]+$');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `sender_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Sender Contact Name');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `sender_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `sender_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `sender_email` SET TAGS ('dbx_business_glossary_term' = 'Sender Email Address');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `sender_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `sender_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `sender_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Subject');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `transmittal_number` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Number');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `transmittal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `transmittal_status` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Status');
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ALTER COLUMN `transmittal_status` SET TAGS ('dbx_value_regex' = 'draft|issued|acknowledged|rejected|superseded|closed');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` SET TAGS ('dbx_subdomain' = 'document_control');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `rfi_id` SET TAGS ('dbx_business_glossary_term' = 'Rfi Identifier');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `actual_response_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Response Date');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `cost_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `date_raised` SET TAGS ('dbx_business_glossary_term' = 'Date Raised');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `rfi_description` SET TAGS ('dbx_business_glossary_term' = 'Request for Information (RFI) Description');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Request for Information (RFI) Priority');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `response_content` SET TAGS ('dbx_business_glossary_term' = 'Response Content');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `response_time_days` SET TAGS ('dbx_business_glossary_term' = 'Response Time Days');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `rfi_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Information (RFI) Number');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `rfi_status` SET TAGS ('dbx_business_glossary_term' = 'Request for Information (RFI) Status');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `rfi_status` SET TAGS ('dbx_value_regex' = 'draft|open|pending_response|responded|closed|cancelled');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `schedule_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Request for Information (RFI) Subject');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` SET TAGS ('dbx_subdomain' = 'document_control');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `document_register_id` SET TAGS ('dbx_business_glossary_term' = 'Document Register ID');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `transmittal_id` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Distribution List');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `document_purpose` SET TAGS ('dbx_business_glossary_term' = 'Document Purpose');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `document_register_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size (Megabytes)');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `is_client_deliverable` SET TAGS ('dbx_business_glossary_term' = 'Is Client Deliverable');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `is_controlled_document` SET TAGS ('dbx_business_glossary_term' = 'Is Controlled Document');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `originator` SET TAGS ('dbx_business_glossary_term' = 'Document Originator');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Years)');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `revision_description` SET TAGS ('dbx_business_glossary_term' = 'Revision Description');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `superseded_by_document_number` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Document Number');
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ALTER COLUMN `supersedes_document_number` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Document Number');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` SET TAGS ('dbx_subdomain' = 'document_control');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Revision Identifier');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `document_register_id` SET TAGS ('dbx_business_glossary_term' = 'Document ID');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `superseded_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Revision ID');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `transmittal_id` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `approver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `author_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `change_reason` SET TAGS ('dbx_value_regex' = 'design_change|client_request|rfi_response|regulatory_update|error_correction|clarification');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Change Summary');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `checksum_hash` SET TAGS ('dbx_business_glossary_term' = 'Checksum Hash');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `revision_description` SET TAGS ('dbx_business_glossary_term' = 'Revision Description');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Distribution List');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'File Name');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `file_storage_path` SET TAGS ('dbx_business_glossary_term' = 'File Storage Path');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `is_controlled_copy` SET TAGS ('dbx_business_glossary_term' = 'Is Controlled Copy');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `revision_status` SET TAGS ('dbx_business_glossary_term' = 'Revision Status');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `revision_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|issued|superseded|obsolete');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `revision_type` SET TAGS ('dbx_business_glossary_term' = 'Revision Type');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `revision_type` SET TAGS ('dbx_value_regex' = 'initial|minor|major|emergency|regulatory');
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ALTER COLUMN `sheet_count` SET TAGS ('dbx_business_glossary_term' = 'Sheet Count');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` SET TAGS ('dbx_subdomain' = 'document_control');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `workflow_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Workflow Approval ID');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `document_register_id` SET TAGS ('dbx_business_glossary_term' = 'Document ID');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Revision Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `action_date` SET TAGS ('dbx_business_glossary_term' = 'Action Date');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `action_taken` SET TAGS ('dbx_business_glossary_term' = 'Action Taken');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `assigned_reviewer_role` SET TAGS ('dbx_business_glossary_term' = 'Assigned Reviewer Role');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `current_step_sequence` SET TAGS ('dbx_business_glossary_term' = 'Current Step Sequence');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `delegation_reason` SET TAGS ('dbx_business_glossary_term' = 'Delegation Reason');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Initiated Date');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `last_reminder_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reminder Date');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `outcome_date` SET TAGS ('dbx_business_glossary_term' = 'Outcome Date');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_business_glossary_term' = 'Overall Outcome');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_value_regex' = 'approved|rejected|withdrawn|superseded|closed');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `reminder_count` SET TAGS ('dbx_business_glossary_term' = 'Reminder Count');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `sla_actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Hours');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `total_steps` SET TAGS ('dbx_business_glossary_term' = 'Total Steps');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `workflow_name` SET TAGS ('dbx_business_glossary_term' = 'Workflow Name');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `workflow_number` SET TAGS ('dbx_business_glossary_term' = 'Workflow Number');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Workflow Status');
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ALTER COLUMN `workflow_type` SET TAGS ('dbx_business_glossary_term' = 'Workflow Type');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` SET TAGS ('dbx_subdomain' = 'engineering_deliverables');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `bim_model_id` SET TAGS ('dbx_business_glossary_term' = 'Building Information Model (BIM) Model ID');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `superseded_by_model_bim_model_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Model ID');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `author_organization` SET TAGS ('dbx_business_glossary_term' = 'Author Organization');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `authoring_software` SET TAGS ('dbx_business_glossary_term' = 'Authoring Software');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `building_zone` SET TAGS ('dbx_business_glossary_term' = 'Building Zone');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `clash_count` SET TAGS ('dbx_business_glossary_term' = 'Clash Count');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `clash_detection_status` SET TAGS ('dbx_business_glossary_term' = 'Clash Detection Status');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `clash_detection_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|issues_identified|resolved');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Project Coordinate System');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'BIM Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `element_count` SET TAGS ('dbx_business_glossary_term' = 'Element Count');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `federation_role` SET TAGS ('dbx_business_glossary_term' = 'Federation Role');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `federation_role` SET TAGS ('dbx_value_regex' = 'host|linked|standalone|reference');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size (MB)');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `iso_19650_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 19650 Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Project Lifecycle Stage');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `lod_classification` SET TAGS ('dbx_business_glossary_term' = 'Level of Development (LOD) Classification');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `lod_classification` SET TAGS ('dbx_value_regex' = 'LOD_100|LOD_200|LOD_300|LOD_350|LOD_400|LOD_500');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'BIM Model Name');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'BIM Model Number');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `model_status` SET TAGS ('dbx_business_glossary_term' = 'BIM Model Status');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `model_status` SET TAGS ('dbx_value_regex' = 'wip|shared|published|archived|superseded');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'BIM Model Type');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'design|coordination|construction|as_built|facility_management');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `origin_elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Origin Elevation (Meters)');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `origin_latitude` SET TAGS ('dbx_business_glossary_term' = 'Origin Latitude');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `origin_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `origin_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `origin_longitude` SET TAGS ('dbx_business_glossary_term' = 'Origin Longitude');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `origin_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `origin_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` SET TAGS ('dbx_subdomain' = 'engineering_deliverables');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Identifier');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `bim_model_id` SET TAGS ('dbx_business_glossary_term' = 'Bim Model Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `cad_file_name` SET TAGS ('dbx_business_glossary_term' = 'Computer-Aided Design (CAD) File Name');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `checker_name` SET TAGS ('dbx_business_glossary_term' = 'Checker Name');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `clash_detection_status` SET TAGS ('dbx_business_glossary_term' = 'Clash Detection Status');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `clash_detection_status` SET TAGS ('dbx_value_regex' = 'not_checked|passed|clashes_detected|resolved');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Distribution List');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `drawing_number` SET TAGS ('dbx_business_glossary_term' = 'Drawing Number');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `drawing_status` SET TAGS ('dbx_business_glossary_term' = 'Drawing Status');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `drawing_type` SET TAGS ('dbx_business_glossary_term' = 'Drawing Type');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `drawing_type` SET TAGS ('dbx_value_regex' = 'plan|elevation|section|detail|schedule|isometric');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'PDF|DWG|DXF|RVT|IFC|DGN');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size in Megabytes (MB)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `is_client_deliverable` SET TAGS ('dbx_business_glossary_term' = 'Is Client Deliverable Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `is_controlled_document` SET TAGS ('dbx_business_glossary_term' = 'Is Controlled Document Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `issue_purpose` SET TAGS ('dbx_business_glossary_term' = 'Issue Purpose');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `issue_purpose` SET TAGS ('dbx_value_regex' = 'information|review|approval|construction|tender|as_built');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `originator` SET TAGS ('dbx_business_glossary_term' = 'Originator Organization');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Years');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `scale` SET TAGS ('dbx_business_glossary_term' = 'Drawing Scale');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `sheet_size` SET TAGS ('dbx_business_glossary_term' = 'Sheet Size');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `superseded_by_drawing_number` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Drawing Number');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `supersedes_drawing_number` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Drawing Number');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Drawing Title');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `zone_location` SET TAGS ('dbx_business_glossary_term' = 'Zone or Location');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` SET TAGS ('dbx_subdomain' = 'engineering_deliverables');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `drawing_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Revision Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `bim_model_id` SET TAGS ('dbx_business_glossary_term' = 'Bim Model Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `rfi_id` SET TAGS ('dbx_business_glossary_term' = 'Rfi Document Rfi Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `superseded_revision_drawing_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Revision Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `transmittal_id` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `acknowledgment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Required Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|acknowledged|overdue');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Full Name');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Revision Change Summary');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `clash_detection_status` SET TAGS ('dbx_business_glossary_term' = 'Clash Detection Status');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `clash_detection_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|passed|failed|resolved');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Revision Comments');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification Level');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `distribution_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Date');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `distribution_method` SET TAGS ('dbx_business_glossary_term' = 'Distribution Method');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `distribution_method` SET TAGS ('dbx_value_regex' = 'electronic|hard_copy|both|portal|email');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `distribution_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Status');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `distribution_status` SET TAGS ('dbx_value_regex' = 'pending|distributed|acknowledged|rejected|superseded');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format Type');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size in Megabytes (MB)');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `issuing_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Engineer Full Name');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Full Name');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `revision_code` SET TAGS ('dbx_business_glossary_term' = 'Revision Code');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `revision_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Issue Date');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `revision_description` SET TAGS ('dbx_business_glossary_term' = 'Revision Change Description');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Sequence Number');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Reason for Revision');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `revision_status` SET TAGS ('dbx_business_glossary_term' = 'Revision Lifecycle Status');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `revision_type` SET TAGS ('dbx_business_glossary_term' = 'Revision Purpose Type');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `sheet_count` SET TAGS ('dbx_business_glossary_term' = 'Sheet Count');
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` SET TAGS ('dbx_subdomain' = 'engineering_deliverables');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification ID');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `asset_category_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Category Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `hazard_register_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Register Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `skill_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Trade Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `applicable_standards` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standards');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional|not_required');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `approver_role` SET TAGS ('dbx_business_glossary_term' = 'Approver Role');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `author_organization` SET TAGS ('dbx_business_glossary_term' = 'Author Organization');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `boq_reference` SET TAGS ('dbx_business_glossary_term' = 'Bill of Quantities (BOQ) Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `csi_division` SET TAGS ('dbx_business_glossary_term' = 'Construction Specifications Institute (CSI) Division');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `environmental_requirements` SET TAGS ('dbx_business_glossary_term' = 'Environmental Requirements');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `file_storage_path` SET TAGS ('dbx_business_glossary_term' = 'File Storage Path');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `hse_requirements` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Requirements');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `is_client_deliverable` SET TAGS ('dbx_business_glossary_term' = 'Is Client Deliverable');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `material_requirements` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `scope_of_work` SET TAGS ('dbx_business_glossary_term' = 'Scope of Work (SOW)');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `section_number` SET TAGS ('dbx_business_glossary_term' = 'Section Number');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `specification_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Number');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `specification_title` SET TAGS ('dbx_business_glossary_term' = 'Specification Title');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_business_glossary_term' = 'Specification Type');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_value_regex' = 'performance|prescriptive|proprietary|reference|master');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `submittal_requirements` SET TAGS ('dbx_business_glossary_term' = 'Submittal Requirements');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Superseded Date');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `supersedes_specification_number` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Specification Number');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `technical_specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `testing_requirements` SET TAGS ('dbx_business_glossary_term' = 'Testing Requirements');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ALTER COLUMN `workmanship_standards` SET TAGS ('dbx_business_glossary_term' = 'Workmanship Standards');
ALTER TABLE `vibe_construction_v1`.`design`.`package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`design`.`package` SET TAGS ('dbx_subdomain' = 'engineering_deliverables');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package ID');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `transmittal_id` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `actual_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Submission Date');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `approval_workflow_state` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow State');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `bim_model_reference` SET TAGS ('dbx_business_glossary_term' = 'Building Information Modeling (BIM) Model Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `client_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Client Acceptance Date');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `client_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Client Acceptance Status');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `client_acceptance_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|accepted_with_comments|rejected|conditionally_accepted|superseded');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `completeness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completeness Percentage');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `contractual_due_date` SET TAGS ('dbx_business_glossary_term' = 'Contractual Due Date');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Document Count');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `drawing_count` SET TAGS ('dbx_business_glossary_term' = 'Drawing Count');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `iso_19650_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 19650 Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `milestone_stage` SET TAGS ('dbx_business_glossary_term' = 'Milestone Stage');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `package_number` SET TAGS ('dbx_business_glossary_term' = 'Package Number');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `package_status` SET TAGS ('dbx_business_glossary_term' = 'Package Status');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'design_package|deliverable_package|submittal_package|handover_package|as_built_package|coordination_package');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `planned_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Issue Date');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `recipient_distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Recipient Distribution List');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `responsible_organization` SET TAGS ('dbx_business_glossary_term' = 'Responsible Organization');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `specification_count` SET TAGS ('dbx_business_glossary_term' = 'Specification Count');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|under_review|resubmission_required|accepted|rejected');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `supersedes_package_number` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Package Number');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Package Title');
ALTER TABLE `vibe_construction_v1`.`design`.`package` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` SET TAGS ('dbx_subdomain' = 'engineering_deliverables');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `engineering_submittal_id` SET TAGS ('dbx_business_glossary_term' = 'Design Submittal Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `bim_model_id` SET TAGS ('dbx_business_glossary_term' = 'Bim Model Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Submitting Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `transmittal_id` SET TAGS ('dbx_business_glossary_term' = 'Transmittal Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `actual_review_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Review Completion Date');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `actual_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Submission Date');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_value_regex' = 'contractor|design_consultant|client|regulatory_authority|independent_verifier');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `approval_disposition` SET TAGS ('dbx_business_glossary_term' = 'Approval Disposition Code');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `approval_disposition` SET TAGS ('dbx_value_regex' = 'approved|approved_as_noted|revise_and_resubmit|rejected|no_exception_taken|reviewed_for_information');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `approver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `approver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment File Count');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Submittal Closure Date');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification Level');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `cost_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ssot_source' = 'quality.quality_submittal');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `estimated_cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Impact Amount');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `estimated_cost_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'Primary File Format');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_ssot_source' = 'quality.quality_submittal');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Submittal Priority Level');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Required Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `required_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Required Submission Date');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `response_notes` SET TAGS ('dbx_business_glossary_term' = 'Submitter Response Notes');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `review_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_ssot_source' = 'quality.quality_submittal');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `reviewing_organization` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Organization Name');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Submittal Revision Number');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `revision_number` SET TAGS ('dbx_ssot_source' = 'quality.quality_submittal');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_ssot_source' = 'quality.quality_submittal');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `schedule_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Flag');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `specification_section` SET TAGS ('dbx_business_glossary_term' = 'Specification Section Reference');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `specification_section` SET TAGS ('dbx_ssot_source' = 'quality.quality_submittal');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `submittal_number` SET TAGS ('dbx_business_glossary_term' = 'Submittal Number');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `submittal_number` SET TAGS ('dbx_ssot_source' = 'quality.quality_submittal');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `submittal_status` SET TAGS ('dbx_business_glossary_term' = 'Submittal Review Status');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `submittal_type` SET TAGS ('dbx_business_glossary_term' = 'Submittal Type');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `submittal_type` SET TAGS ('dbx_ssot_source' = 'quality.quality_submittal');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `submitting_organization` SET TAGS ('dbx_business_glossary_term' = 'Submitting Organization Name');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `supersedes_submittal_number` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Submittal Number');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Submittal Title');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `title` SET TAGS ('dbx_ssot_source' = 'quality.quality_submittal');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ALTER COLUMN `wbs_code` SET TAGS ('dbx_ssot_source' = 'quality.quality_submittal');
