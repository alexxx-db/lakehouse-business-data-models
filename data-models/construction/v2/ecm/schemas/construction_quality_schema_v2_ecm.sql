-- Schema for Domain: quality | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:09:59

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`quality` COMMENT 'QA/QC (Quality Assurance/Quality Control) domain managing ITP (Inspection and Test Plans), NCR (Non-Conformance Reports), inspection checklists, material test certificates, weld records, FAT (Factory Acceptance Test), SAT (Site Acceptance Test), and defect tracking through DLP. Ensures construction deliverables meet specifications and ISO 9001 standards.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`itp` (
    `itp_id` BIGINT COMMENT 'Unique identifier for the Inspection and Test Plan record. Primary key for the ITP entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Contract‑Based QA: ITPs are defined per contract to ensure compliance; linking to agreement enables contract‑level audit and performance tracking.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this ITP applies. Links the quality control framework to the parent project.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Required for Contract Responsibility Report linking ITP contractor to subcontractor record for compliance and billing.',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: ITP execution is performed under a Permit‑to‑Work; linking ensures the ITP is authorized and aligns with safety permitting processes.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: ITP approval workflow requires tracking the internal QC inspector responsible for the plan, enabling accountability and audit trails.',
    `subcontract_id` BIGINT COMMENT 'Foreign key linking to contract.subcontract. Business justification: Subcontractor ITP: Subcontractors submit ITPs under a specific subcontract; FK ties ITP to the subcontract for responsibility and schedule management.',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: ITPs are created from specific technical specifications; FK ensures correct acceptance criteria.',
    `acceptance_criteria` STRING COMMENT 'Detailed acceptance criteria and tolerances that must be met for the work to pass inspection. Defines the pass/fail thresholds for quality verification.',
    `applicable_standards` STRING COMMENT 'Comma-separated list of applicable quality, design, and construction standards governing this ITP (e.g., ISO 9001, ACI 318, ASME B31.3, IBC 2018). Defines the regulatory and technical framework.',
    `approval_date` DATE COMMENT 'Date on which the ITP was formally approved by the client or authorized party. Marks the effective date for use in quality control.',
    `approval_status` STRING COMMENT 'Current approval status of the ITP document in the quality management workflow. Governs whether the ITP can be used for active inspections. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|superseded|obsolete — 7 candidates stripped; promote to reference product]',
    `approved_by` STRING COMMENT 'Name of the individual or role who granted final approval for the ITP document, authorizing its use for quality control activities.',
    `client_inspector_responsible_party` STRING COMMENT 'Name or role of the client or third-party inspector responsible for witnessing or reviewing inspections per this ITP.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ITP record was first created in the system. Part of the audit trail for data governance.',
    `defect_liability_period_days` STRING COMMENT 'Duration in days of the defects liability period applicable to work covered by this ITP. Defines the warranty period for quality defects.',
    `discipline` STRING COMMENT 'Engineering discipline or trade to which this ITP applies. Enables filtering and assignment of ITPs by technical specialty. [ENUM-REF-CANDIDATE: civil|structural|mechanical|electrical|plumbing|hvac|instrumentation|piping|architectural|geotechnical — 10 candidates stripped; promote to reference product]',
    `document_storage_location` STRING COMMENT 'Physical or digital location where the ITP document and related inspection records are stored (e.g., Aconex folder path, SharePoint URL, physical file reference).',
    `effective_date` DATE COMMENT 'Date from which this ITP becomes effective and must be applied to the specified work activities. May differ from approval date.',
    `expiry_date` DATE COMMENT 'Date on which this ITP expires or is superseded by a new revision. Nullable for ITPs that remain valid until explicitly superseded.',
    `fat_required` BOOLEAN COMMENT 'Indicates whether a Factory Acceptance Test is required as part of this ITP. Applicable to equipment and prefabricated components.',
    `hold_point_required` BOOLEAN COMMENT 'Indicates whether this ITP includes mandatory hold points where work cannot proceed until inspection approval is obtained. Critical for compliance and risk management.',
    `inspection_frequency` STRING COMMENT 'Frequency or sampling rate for inspections defined in this ITP (e.g., 100% inspection, Every 10th unit, Daily, Per shift). Defines the intensity of quality control.',
    `inspection_scope` STRING COMMENT 'Detailed scope of inspection activities covered by this ITP, including specific items, locations, and phases to be inspected.',
    `itp_number` STRING COMMENT 'Business identifier for the ITP document, typically following a project-specific numbering convention. Used for external reference and document control.. Valid values are `^ITP-[A-Z0-9]{4,12}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this ITP record was last modified in the system. Tracks the most recent update for audit and version control purposes.',
    `material_test_certificate_required` BOOLEAN COMMENT 'Indicates whether material test certificates must be submitted and verified as part of this ITP. Common for structural materials and critical components.',
    `ndt_method_required` STRING COMMENT 'Type of non-destructive testing method required by this ITP, if applicable. Critical for structural integrity verification in construction. [ENUM-REF-CANDIDATE: none|visual|ultrasonic|radiographic|magnetic_particle|liquid_penetrant|eddy_current — 7 candidates stripped; promote to reference product]',
    `prepared_by` STRING COMMENT 'Name of the individual or role who prepared the ITP document. Part of the document control and accountability trail.',
    `qc_inspector_responsible_party` STRING COMMENT 'Name or role of the contractor QC inspector responsible for verifying compliance with this ITP before submission to the client.',
    `remarks` STRING COMMENT 'Additional remarks, notes, or special instructions related to this ITP. Captures context or clarifications not covered in other fields.',
    `review_point_required` BOOLEAN COMMENT 'Indicates whether this ITP includes review points where inspection records and test results must be submitted for review by the client or engineer.',
    `reviewed_by` STRING COMMENT 'Name of the individual or role who reviewed the ITP document for technical accuracy and completeness before submission for approval.',
    `revision_date` DATE COMMENT 'Date of the current revision of the ITP document. Used for version control and ensuring the latest approved version is in use.',
    `revision_number` STRING COMMENT 'Revision number or letter of the ITP document, tracking version history and changes. Critical for document control and traceability.. Valid values are `^[A-Z0-9]{1,3}$`',
    `sat_required` BOOLEAN COMMENT 'Indicates whether a Site Acceptance Test is required as part of this ITP. Applicable to installed equipment and systems commissioning.',
    `test_method_reference` STRING COMMENT 'Reference to the standard test methods or procedures to be used for testing under this ITP (e.g., ASTM E165, ISO 9712, ACI 318 Section 5.6).',
    `title` STRING COMMENT 'Descriptive title of the ITP defining the scope of work or activity being inspected (e.g., Structural Steel Welding ITP, Concrete Pour ITP - Foundation Slab).',
    `wbs_code` STRING COMMENT 'Hierarchical code identifying the work package or activity within the project WBS that this ITP governs. Enables traceability from quality plans to project scope.. Valid values are `^[A-Z0-9]{2,6}(.[A-Z0-9]{2,6}){0,5}$`',
    `witness_point_required` BOOLEAN COMMENT 'Indicates whether this ITP includes witness points where the client or third-party inspector must be notified and given the opportunity to witness the inspection.',
    `work_package_description` STRING COMMENT 'Detailed description of the construction work package, activity, or deliverable that this ITP covers. Defines the scope of inspection and testing.',
    CONSTRAINT pk_itp PRIMARY KEY(`itp_id`)
) COMMENT 'Inspection and Test Plan (ITP) master record defining the structured quality control framework for a construction work package or activity. Captures the inspection scope, hold/witness/review points, applicable standards (ISO 9001, IBC, ACI), responsible parties, acceptance criteria, and linkage to the WBS. Serves as the authoritative QA/QC planning document governing all inspection activities on a project.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`itp_line` (
    `itp_line_id` BIGINT COMMENT 'Unique identifier for the ITP line item. Primary key for the ITP line entity.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: ITP line execution is assigned to a specific worker; required for execution accountability.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Needed for detailed ITP line responsibility tracking; ties each activity to the subcontractor performing the work.',
    `itp_id` BIGINT COMMENT 'Reference to the parent ITP document that contains this line item. Links the line to its header ITP.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: ITP line often executed by a crew; linking crew provides crew‑level accountability.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Each ITP line item is associated with the WBS element where the activity occurs.',
    `acceptance_criteria` STRING COMMENT 'The specific criteria, tolerances, or standards that must be met for the inspection or test to pass. Defines what constitutes acceptable quality.',
    `activity_description` STRING COMMENT 'Detailed description of the specific inspection or test activity to be performed at this hold point, witness point, or review point.',
    `applicable_standard` STRING COMMENT 'The industry standard, code, or specification that governs this inspection activity (e.g., ASTM, ASME, ACI, AISC, BS, EN, ISO standard reference).',
    `approved_by` STRING COMMENT 'Name or identifier of the quality manager, project manager, or authorized person who approved this ITP line item for use.',
    `approved_date` DATE COMMENT 'The date on which this ITP line item was formally approved for implementation.',
    `calibration_required` BOOLEAN COMMENT 'Indicates whether the test equipment used for this inspection must have valid calibration certificates before use.',
    `client_witness_required` BOOLEAN COMMENT 'Indicates whether the client or their representative must be present to witness this inspection activity before work can proceed.',
    `consultant_witness_required` BOOLEAN COMMENT 'Indicates whether the consultant or engineer must be present to witness this inspection activity before work can proceed.',
    `cost_code` STRING COMMENT 'The cost code used for tracking inspection and quality control costs associated with this ITP line item.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this ITP line item record was first created in the system.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether this inspection activity is on the project critical path and delays would impact overall project schedule.',
    `effective_date` DATE COMMENT 'The date from which this ITP line item version becomes effective and must be followed for inspections.',
    `environmental_conditions` STRING COMMENT 'Any specific environmental conditions or constraints that must be met during inspection (e.g., temperature range, humidity limits, weather restrictions, lighting requirements).',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'The estimated time in hours required to complete this inspection or test activity, including setup, execution, and documentation.',
    `hold_point_type` STRING COMMENT 'Classification of the inspection point. Hold: work cannot proceed without approval. Witness: client/consultant must be present. Review: documentation review only. Surveillance: periodic monitoring.. Valid values are `hold|witness|review|surveillance`',
    `inspection_frequency` STRING COMMENT 'How often or at what stage the inspection must be performed (e.g., 100%, first and last, every 10th unit, per batch, continuous).',
    `inspection_method` STRING COMMENT 'The method or technique to be used for performing the inspection or test (e.g., visual inspection, ultrasonic testing, dimensional check, pressure test, material sampling).',
    `inspection_stage` STRING COMMENT 'The construction or manufacturing stage at which this inspection must be performed (e.g., pre-pour, during installation, post-weld, before backfill, at completion).',
    `itp_line_status` STRING COMMENT 'Current status of this ITP line item in its lifecycle. Planned: not yet ready. Ready: prerequisites met. In Progress: inspection underway. Completed: inspection finished. Waived: inspection waived by authority. Cancelled: no longer required.. Valid values are `planned|ready|in_progress|completed|waived|cancelled`',
    `line_number` STRING COMMENT 'Sequential line number within the parent ITP document. Defines the order of inspection activities.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this inspection is mandatory per contract requirements or regulatory compliance, or if it is optional/recommended.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this ITP line item record was last modified or updated.',
    `ncr_trigger_criteria` STRING COMMENT 'The specific conditions or findings that would trigger the issuance of a Non-Conformance Report (NCR) if this inspection fails.',
    `notification_lead_time_hours` STRING COMMENT 'The minimum advance notice in hours that must be given to client, consultant, or third-party witnesses before performing this inspection.',
    `reference_document` STRING COMMENT 'The specification, drawing, standard, or procedure document that governs this inspection activity (e.g., drawing number, specification code, industry standard reference).',
    `remarks` STRING COMMENT 'Additional notes, clarifications, or special instructions related to this inspection line item that do not fit in other structured fields.',
    `required_documentation` STRING COMMENT 'List of documents, certificates, or records that must be produced as evidence of inspection completion (e.g., test certificates, inspection reports, material certificates, calibration records).',
    `responsible_discipline` STRING COMMENT 'The engineering or construction discipline responsible for performing or coordinating this inspection (e.g., Civil, Mechanical, Electrical, Piping, QA/QC, MEP).',
    `revision_number` STRING COMMENT 'The revision number of this ITP line item. Increments when inspection requirements, acceptance criteria, or other details are changed.',
    `safety_requirements` STRING COMMENT 'Specific health, safety, and environment (HSE) requirements, personal protective equipment (PPE), or permits required for performing this inspection activity.',
    `sampling_plan` STRING COMMENT 'The statistical sampling plan or sample size requirements for this inspection activity (e.g., AQL levels, sample quantity, sampling method).',
    `sequence_dependency` STRING COMMENT 'Description of any prerequisite inspections or activities that must be completed before this inspection can be performed.',
    `superseded_date` DATE COMMENT 'The date on which this ITP line item version was superseded by a newer revision. Null if this is the current active version.',
    `test_equipment_required` STRING COMMENT 'List of specialized test equipment, instruments, or tools required to perform this inspection or test (e.g., ultrasonic tester, pressure gauge, theodolite, concrete slump cone).',
    `third_party_witness_required` BOOLEAN COMMENT 'Indicates whether a third-party inspector, certification body, or regulatory authority must witness this inspection activity.',
    CONSTRAINT pk_itp_line PRIMARY KEY(`itp_line_id`)
) COMMENT 'Individual inspection or test activity line item within an ITP. Defines a specific hold point, witness point, or review point with its activity description, inspection method, acceptance criteria, frequency, responsible discipline, and required documentation. Each line drives a discrete inspection event on site.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`inspection` (
    `inspection_id` BIGINT COMMENT 'Unique identifier for the inspection record. Primary key.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Inspection schedule report ties each inspection to the specific scheduled activity it validates; activity_id provides that link.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Inspection reports are contract‑driven; linking to agreement allows traceability of inspections to contractual obligations.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Equipment inspection process records which specific asset (e.g., crane, excavator) was inspected; required for compliance reports and maintenance scheduling.',
    `checklist_id` BIGINT COMMENT 'Reference to the standardized inspection checklist template used for this inspection. Defines the verification criteria and check items.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Inspection requests originate from a client account; required for client‑billing and inspection tracking reports.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Client contact may attend or request the inspection; needed for audit of client participation.',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Permit‑mandated inspections: inspections are scheduled to satisfy conditions of an active permit, linking inspection records to the governing permit.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this inspection is performed.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Inspection logs which craft worker performed the inspection; required for QC audit reports.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Inspections are scheduled for specific crews; needed for crew‑based inspection planning.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Inspection reports must reference the exact drawing inspected for traceability and compliance.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the qualified inspector or quality control engineer who conducted the inspection. Primary party responsible for verification.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Required for Cost Allocation Report: each inspection activity is charged to a cost code for budgeting and client billing.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Inspection witness verification requires linking the subcontractor representative to the inspection record for audit trails.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Needed to link inspection results to the goods receipt that triggered the inspection, supporting receipt‑inspection traceability.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: When a quality inspection uncovers a safety hazard, an incident is logged; linking inspection to incident supports immediate corrective action and compliance documentation.',
    `itp_line_id` BIGINT COMMENT 'Foreign key linking to quality.itp_line. Business justification: Link inspection to its ITP line for proper hierarchy; inspection may occur multiple times per line.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Required for Inspection Report linking each inspection to its purchase order, enabling PO‑based compliance tracking.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Inspections are scheduled against specific WBS elements (e.g., structural components); FK supports inspection‑WBS mapping.',
    `attachment_count` STRING COMMENT 'Number of supporting documents, photos, measurements, or other digital attachments linked to this inspection record. Provides evidence trail for QA/QC compliance.',
    `checklist_template_name` STRING COMMENT 'Name of the checklist template used (e.g., Concrete Pour Inspection Checklist, Structural Steel Welding Inspection, MEP Rough-in Checklist). Provides human-readable context.',
    `checklist_version` STRING COMMENT 'Version number of the checklist template used at the time of inspection. Ensures audit trail of which criteria were applied.',
    `corrective_action_required` BOOLEAN COMMENT 'Boolean flag indicating whether corrective action is required to address findings from this inspection. True indicates action needed; false indicates no action required.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this inspection record was first created in the quality management system. Audit trail for data lineage.',
    `defects_identified` STRING COMMENT 'Description of specific defects, non-conformances, or quality issues identified during the inspection. Forms the basis for NCR (Non-Conformance Report) creation and defect tracking through DLP (Defects Liability Period).',
    `end_time` TIMESTAMP COMMENT 'Precise timestamp when the inspection activity was completed and all checklist items verified.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity percentage at the time of inspection. Relevant for coating, painting, and other moisture-sensitive quality checks.',
    `inspection_date` DATE COMMENT 'The calendar date on which the physical inspection was conducted. Principal business event timestamp for this transaction.',
    `inspection_number` STRING COMMENT 'Business-facing unique inspection reference number used in documentation, reports, and correspondence. Typically follows project or organizational numbering conventions.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection. Scheduled indicates planned but not started; in progress indicates active inspection; pass indicates all checks met; fail indicates non-conformance detected; conditional pass indicates minor issues with conditions; cancelled indicates inspection not performed; deferred indicates postponed to later date. [ENUM-REF-CANDIDATE: scheduled|in_progress|pass|fail|conditional_pass|cancelled|deferred — 7 candidates stripped; promote to reference product]',
    `inspection_type` STRING COMMENT 'Classification of the inspection activity. Hold point requires mandatory approval before proceeding; witness point allows client/consultant observation; surveillance is routine monitoring; pre-pour checks concrete readiness; structural verifies load-bearing elements; MEP (Mechanical Electrical and Plumbing) inspects building systems; material test validates material certificates; weld inspects welding quality; FAT (Factory Acceptance Test) is factory verification; SAT (Site Acceptance Test) is on-site verification. [ENUM-REF-CANDIDATE: hold_point|witness_point|surveillance|pre_pour|structural|mep|material_test|weld|fat|sat — 10 candidates stripped; promote to reference product]',
    `inspector_certification` STRING COMMENT 'Professional certification or qualification held by the inspector (e.g., AWS CWI for welding, ACI for concrete, ASNT for NDT). Validates inspector competency.',
    `inspector_signature_captured` BOOLEAN COMMENT 'Boolean flag indicating whether the inspectors digital signature was captured as part of the inspection sign-off. True indicates signature obtained; false indicates signature pending or not required.',
    `items_failed` STRING COMMENT 'Count of checklist items that did not meet acceptance criteria and failed verification. Typically triggers NCR (Non-Conformance Report) creation.',
    `items_not_applicable` STRING COMMENT 'Count of checklist items marked as not applicable to this specific inspection instance due to scope or conditions.',
    `items_passed` STRING COMMENT 'Count of checklist items that met acceptance criteria and passed verification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this inspection record was last updated or modified. Audit trail for change tracking.',
    `location_description` STRING COMMENT 'Detailed description of the specific location where inspection was performed (e.g., Building A Level 3 Column Grid C5, Fabrication Shop Bay 2, Concrete Lab). Provides spatial context for traceability.',
    `location_type` STRING COMMENT 'Classification of where the inspection was physically conducted. Site indicates construction site; factory indicates manufacturer facility for FAT; workshop indicates fabrication shop; laboratory indicates testing facility; warehouse indicates storage location; offsite indicates other external location.. Valid values are `site|factory|workshop|laboratory|warehouse|offsite`',
    `ncr_raised` BOOLEAN COMMENT 'Boolean flag indicating whether a Non-Conformance Report (NCR) was raised as a result of this inspection. True indicates NCR created; false indicates no NCR required.',
    `ncr_reference` STRING COMMENT 'Reference number of the NCR (Non-Conformance Report) raised as a result of this inspection, if applicable. Links inspection to corrective action workflow.',
    `observations` STRING COMMENT 'General observations, notes, and comments recorded by the inspector during the inspection. Captures qualitative findings, context, and professional judgment.',
    `overall_outcome` STRING COMMENT 'Final verdict of the inspection based on aggregated check item results. Pass indicates all critical items met; fail indicates non-conformance requiring corrective action; conditional pass indicates minor issues with conditions for acceptance.. Valid values are `pass|fail|conditional_pass`',
    `photo_count` STRING COMMENT 'Number of photographs captured during the inspection as visual evidence of conditions, defects, or compliance.',
    `reinspection_date` DATE COMMENT 'Scheduled date for follow-up reinspection to verify corrective actions have been implemented and defects resolved.',
    `reinspection_required` BOOLEAN COMMENT 'Boolean flag indicating whether a follow-up reinspection is required after corrective actions are completed. True indicates reinspection needed; false indicates no reinspection required.',
    `specification_reference` STRING COMMENT 'Reference to the technical specification, standard, or code against which the inspection was performed (e.g., ACI 318, AISC 360, project specification section). Defines acceptance criteria.',
    `start_time` TIMESTAMP COMMENT 'Precise timestamp when the inspection activity commenced on site or at the facility.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Ambient temperature in degrees Celsius at the time of inspection. Critical for temperature-sensitive activities such as concrete curing, welding, coating application.',
    `total_check_items` STRING COMMENT 'Total number of individual verification items in the checklist that were evaluated during this inspection.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of inspection (e.g., clear, rainy, windy, temperature). Relevant for outdoor inspections where weather may affect quality or inspection validity.',
    `witness_signature_captured` BOOLEAN COMMENT 'Boolean flag indicating whether the witness partys digital signature was captured. True indicates signature obtained; false indicates signature pending or not required.',
    `work_package_reference` STRING COMMENT 'Reference to the work package, activity, or WBS (Work Breakdown Structure) element being inspected. Links quality verification to project schedule and scope.',
    CONSTRAINT pk_inspection PRIMARY KEY(`inspection_id`)
) COMMENT 'Transactional record of a physical quality inspection or checklist verification event conducted on site, at a factory, or workshop. Captures inspection date, location, inspector identity, ITP line reference, checklist template used, item-level verification results (pass/fail/N/A per check item with remarks), overall outcome (pass/fail/conditional), observations, non-conformances raised, digital sign-off, and attachments (photos, measurements). Covers all inspection types: hold-point inspections, witness-point inspections, pre-pour checks, structural inspections, MEP inspections, and any checklist-based quality verification. Each record serves as the auditable evidence trail for QA/QC compliance and may trigger NCR creation on failure.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`ncr` (
    `ncr_id` BIGINT COMMENT 'Unique identifier for the non-conformance report. Primary key for the NCR entity.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: NCR impact analysis requires knowing which activity triggered the non‑conformance; activity_id records that relationship.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: NCRs affect contract performance and liquidated damages; contract reference is required for claim and settlement processes.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: NCRs are tracked against the client account for contract compliance and client‑specific reporting.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project where the non-conformance was identified.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: NCR assigns a specific worker to resolve the issue; needed for corrective‑action tracking.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: NCRs are raised against a specific drawing; linking enables automated impact analysis.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Needed for Cost Impact Tracking: NCR corrective cost is allocated to a cost code to reflect financial impact in cost reports.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: NCR responsibility assignment report must reference the subcontractor accountable for the non‑conformance.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Required for traceability: NCR investigations often trigger safety incident investigations; linking enables root‑cause analysis and regulatory reporting.',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Permit Condition Violation NCR tracking: each NCR is raised when a specific permit condition is breached, required for compliance reporting.',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Regulatory NCRs often cite the violated technical specification; direct FK supports compliance reporting.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Assigns each NCR to the responsible vendor, essential for vendor performance evaluation and corrective action.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the specific work package or WBS (Work Breakdown Structure) element affected by the non-conformance.',
    `ncr_category` STRING COMMENT 'High-level classification of the type of non-conformance to support trend analysis and root cause categorization.. Valid values are `material|workmanship|design|documentation|dimensional|procedural`',
    `client_notification_date` DATE COMMENT 'Date when the client was formally notified of the non-conformance. Null if client notification was not required.',
    `client_notification_required` BOOLEAN COMMENT 'Indicates whether the client must be formally notified of this non-conformance per contract requirements. Typically true for major or critical NCRs.',
    `closed_by` STRING COMMENT 'Name or identifier of the person who authorized closure of the NCR. Typically a QA/QC manager or project quality manager.',
    `closure_date` DATE COMMENT 'Date when the NCR was formally closed after successful completion of corrective action, verification, and effectiveness review. Marks the end of the CAPA cycle.',
    `corrective_action_completion_date` DATE COMMENT 'Actual date when the corrective action was completed. Compared against target date for performance measurement.',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective action(s) to be taken to address the immediate non-conformance. Part of the CAPA (Corrective and Preventive Action) process.',
    `corrective_action_responsible_party` STRING COMMENT 'Name or identifier of the person or organization responsible for implementing the corrective action.',
    `corrective_action_target_date` DATE COMMENT 'Planned target date for completion of the corrective action. Used for tracking and escalation if deadlines are missed.',
    `cost_impact_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated cost impact (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this NCR record was first created in the system. Part of audit trail for record lifecycle tracking.',
    `ncr_description` STRING COMMENT 'Detailed narrative description of the non-conformance, including what was observed, what was expected per specifications, and the extent of the deviation.',
    `discipline` STRING COMMENT 'Engineering or construction discipline to which the non-conformance relates. Used for categorization and routing to appropriate technical specialists. [ENUM-REF-CANDIDATE: civil|structural|architectural|mechanical|electrical|plumbing|hvac|instrumentation|piping|welding|painting|insulation|fireproofing|other — 14 candidates stripped; promote to reference product]',
    `disposition` STRING COMMENT 'Formal decision on how the non-conforming work or material will be handled. Disposition determines the corrective action path and may require client approval for concessions.. Valid values are `accept_as_is|rework|repair|reject|scrap|use_as_is_with_concession`',
    `disposition_approved_by` STRING COMMENT 'Name or identifier of the person who approved the disposition decision. Typically a senior QA/QC manager, project manager, or client representative.',
    `disposition_approved_date` DATE COMMENT 'Date when the disposition was formally approved, allowing corrective action to proceed.',
    `disposition_justification` STRING COMMENT 'Technical and business justification for the selected disposition, including engineering analysis, code compliance assessment, and impact on functionality.',
    `effectiveness_review_comments` STRING COMMENT 'Comments from the effectiveness review assessing whether the corrective and preventive actions have successfully addressed the non-conformance and prevented recurrence.',
    `estimated_cost_impact` DECIMAL(18,2) COMMENT 'Estimated financial cost impact of the non-conformance including rework, material replacement, schedule delay, and potential liquidated damages. Used for cost tracking and recovery.',
    `hold_release_date` DATE COMMENT 'Date when the hold was released, allowing work to resume. Null if no hold was placed or if hold is still active.',
    `hold_status` BOOLEAN COMMENT 'Indicates whether a hold has been placed on the affected work or material, preventing further work until the NCR is resolved. True if hold is active, False otherwise.',
    `identified_date` DATE COMMENT 'Date when the non-conformance was first discovered or identified on site. Represents the business event timestamp for the NCR initiation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this NCR record was last modified. Used for audit trail and change tracking throughout the CAPA lifecycle.',
    `location_description` STRING COMMENT 'Detailed description of the physical location where the non-conformance was identified (e.g., Building A Level 3, Grid Line E5, Foundation Block 12).',
    `ncr_number` STRING COMMENT 'Business identifier for the NCR, typically following a project-specific numbering convention. Externally visible reference number used in correspondence and documentation.. Valid values are `^NCR-[A-Z0-9]{4,20}$`',
    `ncr_status` STRING COMMENT 'Current lifecycle status of the NCR tracking its progression from identification through closure. Reflects the workflow state in the CAPA (Corrective and Preventive Action) cycle. [ENUM-REF-CANDIDATE: draft|open|under_investigation|pending_disposition|corrective_action_in_progress|verification_pending|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `preventive_action_description` STRING COMMENT 'Description of preventive actions to be taken to prevent recurrence of similar non-conformances. Addresses systemic issues identified in root cause analysis.',
    `preventive_action_responsible_party` STRING COMMENT 'Name or identifier of the person or organization responsible for implementing the preventive action.',
    `quantity_affected` DECIMAL(18,2) COMMENT 'Numeric quantity of work, material, or units affected by the non-conformance (e.g., 150 cubic meters of concrete, 25 welds, 500 linear meters of pipe).',
    `reported_by` STRING COMMENT 'Name or identifier of the person who identified and reported the non-conformance. Typically a QA/QC inspector, site engineer, or subcontractor representative.',
    `reported_by_organization` STRING COMMENT 'Organization or company that the reporting person represents (e.g., General Contractor, Subcontractor, Client, Third-Party Inspector).',
    `root_cause_analysis` STRING COMMENT 'Detailed analysis of the underlying root cause(s) of the non-conformance. May reference techniques such as 5 Whys, Fishbone Diagram, or Fault Tree Analysis.',
    `schedule_impact_days` STRING COMMENT 'Estimated number of calendar days of schedule delay caused by the non-conformance and its resolution. Used for schedule recovery planning and EOT (Extension of Time) claims.',
    `severity` STRING COMMENT 'Severity classification indicating the impact of the non-conformance on safety, quality, schedule, and cost. Critical NCRs may trigger work stoppage.. Valid values are `critical|major|minor`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity affected (e.g., m3, kg, linear meter, each, square meter).',
    `verification_date` DATE COMMENT 'Date when the verification of corrective action effectiveness was performed.',
    `verification_method` STRING COMMENT 'Method used to verify that the corrective action was effective and the non-conformance has been resolved. May include re-inspection, testing, or document review. [ENUM-REF-CANDIDATE: visual_inspection|dimensional_check|material_test|functional_test|document_review|third_party_inspection|other — 7 candidates stripped; promote to reference product]',
    `verification_performed_by` STRING COMMENT 'Name or identifier of the person who performed the verification of corrective action effectiveness. Typically a QA/QC inspector or independent verifier.',
    `verification_result` STRING COMMENT 'Outcome of the verification activity indicating whether the corrective action was effective and the non-conformance is resolved.. Valid values are `passed|failed|conditional`',
    CONSTRAINT pk_ncr PRIMARY KEY(`ncr_id`)
) COMMENT 'Non-Conformance Report (NCR) and corrective action record capturing formal documentation of construction deliverables, materials, or workmanship that do not meet specified requirements. Tracks NCR number, description of non-conformance, affected work package, root cause analysis, disposition (accept-as-is, rework, reject, concession), corrective and preventive actions (CAPA) with responsible parties, target and actual completion dates, verification method, effectiveness review, and closure status. Supports hold/release workflow and the full CAPA cycle required under ISO 9001 clause 10.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`corrective_action` (
    `corrective_action_id` BIGINT COMMENT 'Primary key for corrective_action',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Corrective action records the worker responsible for implementing the action; needed for audit trails.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Allows budgeting of corrective actions: each corrective_action record must be linked to the cost code under which its expense is recorded.',
    `project_change_order_id` BIGINT COMMENT 'Reference to the Change Order (CO) generated as a result of this corrective action, if cost or schedule impacts require contract modification.',
    `rfi_id` BIGINT COMMENT 'Reference to the Request for Information (RFI) issued to clarify design or specification ambiguities related to this corrective action.',
    `ncr_id` BIGINT COMMENT 'Reference to the parent Non-Conformance Report that triggered this corrective or preventive action.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the employee, subcontractor, or organizational unit assigned to execute this corrective action.',
    `tertiary_corrective_created_by_employee_id` BIGINT COMMENT 'Reference to the user who created this corrective action record.',
    `action_description` STRING COMMENT 'Detailed narrative of the specific remediation steps to be taken, including scope, method, materials, and acceptance criteria.',
    `action_number` STRING COMMENT 'Business-readable identifier for the corrective or preventive action, typically formatted as NCR-XXXX-CA-YY for traceability.',
    `action_status` STRING COMMENT 'Current lifecycle state of the corrective action: open (assigned but not started), in_progress (work underway), pending_verification (awaiting QA/QC review), verified (effectiveness confirmed), closed (completed and accepted), cancelled (no longer required).. Valid values are `open|in_progress|pending_verification|verified|closed|cancelled`',
    `action_type` STRING COMMENT 'Classification of the action: corrective (addresses existing defect), preventive (prevents recurrence), containment (immediate isolation), or interim (temporary measure pending permanent fix).. Valid values are `corrective|preventive|containment|interim`',
    `actual_completion_date` DATE COMMENT 'Date when the corrective action was actually completed and submitted for verification. Null if still in progress.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred to implement the corrective action, captured from job costing and procurement records.',
    `assigned_date` DATE COMMENT 'Date when the corrective action was formally assigned to the responsible party.',
    `client_approval_date` DATE COMMENT 'Date when the client formally approved the corrective action plan. Null if client approval is not required or pending.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost to implement the corrective action, including labor, materials, equipment, and any rework or schedule impact costs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this corrective action record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `document_reference` STRING COMMENT 'Reference to supporting documentation such as inspection reports, test certificates, photographs, or revised drawings stored in the document management system (e.g., Aconex, BIM 360).',
    `effectiveness_review_comments` STRING COMMENT 'Detailed comments from the effectiveness review, including evidence of resolution, lessons learned, and recommendations for process improvement.',
    `effectiveness_review_date` DATE COMMENT 'Date when the effectiveness of the corrective action was formally reviewed, typically 30-90 days after implementation.',
    `effectiveness_review_outcome` STRING COMMENT 'Result of the effectiveness review: effective (action resolved the issue and prevented recurrence), partially_effective (issue partially resolved, additional action required), ineffective (action did not resolve the issue), pending_review (awaiting final assessment).. Valid values are `effective|partially_effective|ineffective|pending_review`',
    `is_systemic_issue` BOOLEAN COMMENT 'Indicates whether the root cause analysis identified this as a systemic issue requiring organization-wide corrective action across multiple projects or processes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this corrective action record was last updated.',
    `lessons_learned` STRING COMMENT 'Summary of lessons learned from this corrective action, including process improvements, training needs, and recommendations for future projects.',
    `priority` STRING COMMENT 'Priority level of the corrective action based on safety impact, schedule criticality, and cost exposure: critical (immediate action required), high (urgent), medium (standard timeline), low (routine).. Valid values are `critical|high|medium|low`',
    `recurrence_prevention_measures` STRING COMMENT 'Specific measures implemented to prevent recurrence of the non-conformance, such as updated work instructions, additional inspections, or supplier quality audits.',
    `requires_client_approval` BOOLEAN COMMENT 'Indicates whether the corrective action requires formal approval from the client or project owner before implementation.',
    `requires_design_change` BOOLEAN COMMENT 'Indicates whether the corrective action requires a formal design change, triggering BIM (Building Information Modeling) revision and engineering approval workflows.',
    `root_cause_analysis` STRING COMMENT 'Summary of the root cause investigation findings that informed this corrective action, often using 5-Why, Fishbone, or Fault Tree Analysis methods.',
    `schedule_impact_days` STRING COMMENT 'Number of calendar days by which the corrective action delayed the project schedule or affected the critical path.',
    `target_completion_date` DATE COMMENT 'Planned date by which the corrective action must be completed to meet project schedule and compliance requirements.',
    `verification_date` DATE COMMENT 'Date when the corrective action was verified by QA/QC personnel or the designated authority.',
    `verification_method` STRING COMMENT 'Method used to verify the effectiveness of the corrective action: inspection (visual check), testing (material or functional test), document_review (record verification), audit (formal QA/QC audit), site_observation (field walkdown), measurement (dimensional or performance measurement).. Valid values are `inspection|testing|document_review|audit|site_observation|measurement`',
    `verified_by_name` STRING COMMENT 'Name of the individual who performed the verification of the corrective action.',
    CONSTRAINT pk_corrective_action PRIMARY KEY(`corrective_action_id`)
) COMMENT 'Corrective and preventive action record linked to an NCR. Tracks the specific remediation steps assigned, responsible party, target completion date, actual completion date, verification method, and effectiveness review outcome. Supports the CAPA (Corrective Action / Preventive Action) cycle required under ISO 9001 clause 10.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`checklist` (
    `checklist_id` BIGINT COMMENT 'Unique identifier for the quality inspection checklist template. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract that mandates or governs the use of this checklist, linking to contract-specific quality requirements.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this checklist template was created or customized, if project-specific.',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Permit condition compliance checklist: checklists verify that each permit condition is met during construction activities.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Checklist scope is defined per WBS element for quality control; linking enables WBS‑level checklist tracking.',
    `acceptance_criteria` STRING COMMENT 'Overall acceptance criteria for the checklist (e.g., All critical items must pass, 95% of items must pass with no critical failures).',
    `activity_type` STRING COMMENT 'Classification of the construction activity type that this checklist applies to, aligned with WBS (Work Breakdown Structure) and ITP (Inspection and Test Plan) categories. [ENUM-REF-CANDIDATE: concrete_pour|rebar_placement|formwork_erection|waterproofing|structural_steel_erection|welding|mechanical_installation|electrical_installation|piping_installation|excavation|backfill|piling|painting|insulation|commissioning|other — 16 candidates stripped; promote to reference product]',
    `applicable_standard` STRING COMMENT 'Reference to the governing technical standard, code, or specification that this checklist enforces (e.g., ACI 318, AISC 360, ASME B31.3, IBC 2018, ASTM C39).',
    `approval_status` STRING COMMENT 'Current lifecycle status of the checklist template in the document control workflow, indicating whether it is ready for use in field inspections.. Valid values are `draft|under_review|approved|superseded|obsolete`',
    `approved_by` STRING COMMENT 'Name or identifier of the QA/QC (Quality Assurance/Quality Control) manager or authorized person who approved this checklist template for use.',
    `approved_date` DATE COMMENT 'Date when the checklist template was formally approved for use in quality inspections.',
    `average_pass_rate` DECIMAL(18,2) COMMENT 'Historical average pass rate (percentage) for inspections conducted using this checklist, used to identify problematic activities or checklist items.',
    `checklist_code` STRING COMMENT 'Externally-known unique business identifier for the checklist template, used for reference in inspection documentation and ITP (Inspection and Test Plan) workflows.. Valid values are `^[A-Z0-9]{6,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this checklist template record was first created in the system.',
    `critical_items_count` STRING COMMENT 'Number of check items in this checklist that are classified as critical and must pass for overall acceptance.',
    `checklist_description` STRING COMMENT 'Detailed description of the checklist purpose, scope, and applicability, including any special instructions or prerequisites for use.',
    `discipline` STRING COMMENT 'Engineering or construction discipline that this checklist is associated with, used for routing to appropriate QA/QC (Quality Assurance/Quality Control) personnel. [ENUM-REF-CANDIDATE: civil|structural|architectural|mechanical|electrical|plumbing|hvac|instrumentation|piping|geotechnical|environmental|multi_discipline — 12 candidates stripped; promote to reference product]',
    `effective_from_date` DATE COMMENT 'Date from which this checklist template version becomes effective and should be used for new inspections.',
    `effective_to_date` DATE COMMENT 'Date until which this checklist template version remains effective, after which it is superseded by a newer revision.',
    `estimated_duration_minutes` STRING COMMENT 'Estimated time in minutes required to complete the inspection using this checklist, used for resource planning and scheduling.',
    `frequency` STRING COMMENT 'Frequency or trigger for when this checklist should be used (e.g., per concrete pour, daily for ongoing work, per material batch). [ENUM-REF-CANDIDATE: per_occurrence|daily|weekly|monthly|per_batch|per_lot|as_required — 7 candidates stripped; promote to reference product]',
    `hold_point_flag` BOOLEAN COMMENT 'Indicates whether this checklist represents a hold point where work cannot proceed until inspection is completed and accepted.',
    `inspection_stage` STRING COMMENT 'Phase of construction activity when this checklist should be applied, aligned with ITP (Inspection and Test Plan) hold points and witness points.. Valid values are `pre_work|during_work|post_work|hold_point|witness_point`',
    `inspection_type` STRING COMMENT 'Category of inspection method that this checklist governs (e.g., visual inspection, NDT, dimensional verification, functional testing). [ENUM-REF-CANDIDATE: visual|dimensional|non_destructive_testing|destructive_testing|functional|performance|documentation_review — 7 candidates stripped; promote to reference product]',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this checklist is mandatory for the associated activity type per contract requirements, ITP (Inspection and Test Plan), or regulatory compliance.',
    `modified_by` STRING COMMENT 'Name or identifier of the person who last modified this checklist template.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this checklist template record was last modified.',
    `checklist_name` STRING COMMENT 'Human-readable name of the checklist template describing the inspection scope (e.g., Concrete Pour Inspection, Rebar Placement Verification, Waterproofing Application Check).',
    `ncr_trigger_threshold` STRING COMMENT 'Criteria that automatically trigger the issuance of an NCR (Non-Conformance Report) when inspection results fail to meet this threshold.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this checklist template.',
    `reference_documents` STRING COMMENT 'List of supporting documents, drawings, specifications, or procedures that inspectors should reference when using this checklist.',
    `required_equipment` STRING COMMENT 'List of tools, instruments, or equipment required to perform the inspection per this checklist (e.g., tape measure, level, ultrasonic thickness gauge, calibrated thermometer).',
    `required_qualifications` STRING COMMENT 'Qualifications, certifications, or competencies required for the inspector who will use this checklist (e.g., AWS CWI, ACI Level 1, ASNT NDT Level II).',
    `revision_date` DATE COMMENT 'Date when the current revision of the checklist was issued, used to ensure inspectors are using the latest approved version.',
    `revision_number` STRING COMMENT 'Version or revision identifier for the checklist template, incremented when checklist content is updated to reflect specification changes or lessons learned.. Valid values are `^[A-Z0-9]{1,10}$`',
    `safety_requirements` STRING COMMENT 'HSE (Health Safety and Environment) requirements and PPE (Personal Protective Equipment) needed when performing inspections using this checklist.',
    `total_check_items` STRING COMMENT 'Total number of individual verification items or questions included in this checklist template.',
    `usage_count` STRING COMMENT 'Number of times this checklist template has been used in actual field inspections, used for analytics and continuous improvement.',
    `witness_point_flag` BOOLEAN COMMENT 'Indicates whether this checklist represents a witness point where the client or third-party inspector must be notified and given opportunity to witness the inspection.',
    `created_by` STRING COMMENT 'Name or identifier of the person who originally created this checklist template.',
    CONSTRAINT pk_checklist PRIMARY KEY(`checklist_id`)
) COMMENT 'Quality inspection checklist template defining the structured set of verification items for a specific construction activity type (e.g., concrete pour, rebar placement, waterproofing, structural steel erection). Captures checklist name, revision, activity type, applicable standard, approval status, and ordered check items with acceptance criteria and inspection method. Used as the governing template when conducting inspections — each inspection references a checklist to ensure consistent verification coverage.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`checklist_execution` (
    `checklist_execution_id` BIGINT COMMENT 'Unique identifier for the completed checklist execution instance. Primary key for this quality inspection record.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this quality inspection was performed.',
    `checklist_id` BIGINT COMMENT 'Reference to the master checklist template that was executed. Links to the standard ITP (Inspection and Test Plan) or inspection checklist definition.',
    `checklist_site_construction_project_id` BIGINT COMMENT 'Reference to the construction site or facility where the inspection took place.',
    `firm_profile_id` BIGINT COMMENT 'Reference to the contractor or subcontractor whose work is being inspected.',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Checklist execution on site requires a Permit‑to‑Work; linking records the permit governing the execution for safety compliance.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the qualified QA/QC inspector who performed the checklist execution. Must be a certified quality professional.',
    `tertiary_checklist_approved_by_employee_id` BIGINT COMMENT 'Reference to the QA/QC manager or authorized person who approved the checklist execution results.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Execution of a checklist is performed against a specific WBS element on site.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the checklist execution: draft (in progress), submitted (awaiting review), approved (accepted), rejected (not accepted), or revision required.. Valid values are `draft|submitted|approved|rejected|revision_required`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the checklist execution was formally approved by the QA/QC manager.',
    `compliance_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage of checklist items that passed inspection, excluding N/A items. Formula: (pass_count / (total_items - na_count)) * 100.',
    `corrective_action_required` STRING COMMENT 'Description of corrective actions or remediation work required to address failed inspection items.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the checklist execution record was first created in the system.',
    `critical_failure_flag` BOOLEAN COMMENT 'Indicates whether any critical or safety-related inspection items failed, requiring immediate stop-work or remediation.',
    `defects_identified` STRING COMMENT 'Summary description of defects, non-conformances, or quality issues identified during the inspection.',
    `document_reference_number` STRING COMMENT 'Reference number linking this checklist execution to the project document management system for archival and retrieval.',
    `execution_date` DATE COMMENT 'Date when the quality inspection checklist was executed on site.',
    `execution_end_time` TIMESTAMP COMMENT 'Timestamp when the inspector completed the checklist execution and submitted the results.',
    `execution_number` STRING COMMENT 'Business-readable unique identifier for this checklist execution, often formatted as project-discipline-sequence (e.g., PRJ001-QC-0123).',
    `execution_start_time` TIMESTAMP COMMENT 'Timestamp when the inspector began the checklist execution on site.',
    `fail_count` STRING COMMENT 'Number of checklist items that failed inspection criteria and require corrective action.',
    `humidity_percentage` DECIMAL(18,2) COMMENT 'Relative humidity percentage at the time of inspection, relevant for coating, painting, and material testing activities.',
    `inspection_stage` STRING COMMENT 'Project lifecycle stage when the inspection was conducted: pre-construction, during construction, post-construction, commissioning, or DLP (Defects Liability Period).. Valid values are `pre_construction|during_construction|post_construction|commissioning|DLP`',
    `inspection_type` STRING COMMENT 'Category of quality inspection performed: ITP (Inspection and Test Plan), FAT (Factory Acceptance Test), SAT (Site Acceptance Test), material test, weld inspection, concrete test, structural inspection, MEP (Mechanical Electrical Plumbing) inspection, final inspection, or defect inspection. [ENUM-REF-CANDIDATE: ITP|FAT|SAT|material_test|weld_inspection|concrete_test|structural_inspection|MEP_inspection|final_inspection|defect_inspection — 10 candidates stripped; promote to reference product]',
    `inspector_name` STRING COMMENT 'Full name of the inspector who executed the checklist for display and reporting purposes.',
    `inspector_remarks` STRING COMMENT 'General observations, comments, or notes recorded by the inspector during the checklist execution. Provides context for inspection results.',
    `inspector_signature_captured` BOOLEAN COMMENT 'Indicates whether the inspectors digital signature was captured as part of the checklist sign-off process.',
    `inspector_signature_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspector digitally signed off on the completed checklist execution.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the checklist execution record was last updated or modified.',
    `location_description` STRING COMMENT 'Physical location on site where the inspection was performed (e.g., Building A - Level 2 - Grid C3, North Wing Foundation, Substation Area).',
    `na_count` STRING COMMENT 'Number of checklist items marked as not applicable to this specific inspection instance.',
    `ncr_generated_flag` BOOLEAN COMMENT 'Indicates whether this inspection resulted in the generation of one or more NCRs (Non-Conformance Reports) for failed items.',
    `overall_result` STRING COMMENT 'Overall outcome of the checklist execution: pass (all items compliant), fail (one or more critical failures), conditional pass (minor defects requiring remediation), or not applicable.. Valid values are `pass|fail|conditional_pass|not_applicable`',
    `pass_count` STRING COMMENT 'Number of checklist items that passed inspection criteria.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Ambient temperature in Celsius at the time of inspection, critical for concrete curing, welding, and coating applications.',
    `total_items` STRING COMMENT 'Total number of inspection items in the executed checklist.',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time of inspection, relevant for outdoor construction activities and material testing (e.g., Clear, 25°C, Light rain, 18°C).',
    `witness_name` STRING COMMENT 'Full name of the witness who co-signed the inspection for display and reporting purposes.',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether this inspection requires a witness signature from client, consultant, or third-party inspector per contract requirements.',
    `witness_signature_captured` BOOLEAN COMMENT 'Indicates whether the witnesss digital signature was captured as part of the checklist sign-off process.',
    `witness_signature_timestamp` TIMESTAMP COMMENT 'Timestamp when the witness digitally signed off on the completed checklist execution.',
    `work_activity_description` STRING COMMENT 'Detailed description of the specific construction work activity or deliverable being inspected (e.g., Foundation concrete pour - Grid A1 to A5, HVAC ductwork installation - Level 3).',
    CONSTRAINT pk_checklist_execution PRIMARY KEY(`checklist_execution_id`)
) COMMENT 'Completed instance of a quality inspection checklist executed on site for a specific work activity. Records the execution date, inspector, work location, WBS reference, each checklist item result (pass/fail/N/A), overall outcome, remarks, and digital sign-off. Provides the auditable evidence trail for QA/QC compliance.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`test_certificate` (
    `test_certificate_id` BIGINT COMMENT 'Primary key for test_certificate',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Material test certificates are contract‑required evidence of compliance; contract link supports audit and payment certification.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project for which the material was tested. Links the certificate to the project quality records.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Material test certificates need a FK to the supplying subcontractor for traceability and warranty management.',
    `itp_id` BIGINT COMMENT 'Foreign key linking to quality.itp. Business justification: Test certificates are often issued for ITP items and may be associated with NCRs; linking enables direct lookup.',
    `material_catalog_id` BIGINT COMMENT 'Foreign key linking to procurement.material_catalog. Business justification: Links material test certificates to the material master record, enabling traceability of test results to specific catalog items.',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: Test certificates may also be linked to NCRs for traceability.',
    `sample_id` BIGINT COMMENT 'Unique identifier assigned to the physical material sample that was tested. Links the certificate to the specific specimen extracted from the batch or lot.',
    `sustainable_material_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainable_material. Business justification: Sustainable material certification relies on test certificates; the FK ties each certificate to the material record, supporting material compliance verification in sustainability assessments.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Material test certificates are linked to the WBS element using the material, supporting compliance reporting.',
    `accreditation_body` STRING COMMENT 'Name of the accreditation authority that certified the laboratory (e.g., UKAS, A2LA, NABL, NATA).',
    `approval_date` DATE COMMENT 'Date when the test certificate was formally approved and released for use in construction quality records.',
    `approved_by` STRING COMMENT 'Name of the quality manager, engineer, or authorized signatory who reviewed and approved the test certificate.',
    `batch_number` STRING COMMENT 'Manufacturer or supplier batch number identifying the production lot from which the sample was taken. Critical for traceability and recall management.',
    `certificate_expiry_date` DATE COMMENT 'Date when the certificate validity expires, if applicable. Some certificates have time-limited validity for regulatory or contractual reasons.',
    `certificate_issue_date` DATE COMMENT 'Date when the certificate was officially issued by the laboratory or supplier. This is the principal business event timestamp for the certificate lifecycle.',
    `certificate_number` STRING COMMENT 'Externally-known unique certificate number issued by the testing laboratory or supplier. This is the business identifier printed on the physical or digital certificate document.',
    `certificate_status` STRING COMMENT 'Current lifecycle status of the test certificate in the quality management workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|superseded|expired — 7 candidates stripped; promote to reference product]',
    `certificate_type` STRING COMMENT 'Classification of the test certificate indicating the source and nature of testing. MTC (Material Test Certificate) from supplier, laboratory test from independent lab, factory test (FAT - Factory Acceptance Test), site test (SAT - Site Acceptance Test), third-party test from accredited body, or supplier certificate.. Valid values are `MTC|laboratory_test|factory_test|site_test|third_party_test|supplier_certificate`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this test certificate record was first created in the quality management system.',
    `delivery_lot_number` STRING COMMENT 'Delivery or shipment lot number identifying the specific material consignment from which the sample was taken. Links certificate to goods receipt.',
    `document_url` STRING COMMENT 'URL or file path to the digital copy of the test certificate document stored in the document management system (e.g., Aconex, BIM 360, Procore).',
    `heat_number` STRING COMMENT 'Steel mill heat number for steel and rebar materials, identifying the specific furnace melt. Essential for metallurgical traceability.',
    `issuing_laboratory` STRING COMMENT 'Name of the testing laboratory or organization that performed the tests and issued the certificate.',
    `laboratory_accreditation_number` STRING COMMENT 'Accreditation certificate number issued by the national or international accreditation body (e.g., ISO/IEC 17025 accreditation number). Validates the laboratorys competence.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this test certificate record was last updated in the quality management system.',
    `material_description` STRING COMMENT 'Detailed textual description of the material being tested, including grade, specification, and any relevant characteristics (e.g., Grade 60 Rebar, M30 Concrete, AC-20 Bitumen).',
    `material_type` STRING COMMENT 'Category of construction material being tested. Covers primary materials used in infrastructure and building construction projects. [ENUM-REF-CANDIDATE: concrete|steel|aggregate|bitumen|soil|asphalt|geotextile|cement|rebar|structural_steel|weld|paint|coating — 13 candidates stripped; promote to reference product]',
    `pass_fail_status` STRING COMMENT 'Overall determination of whether the tested material meets the specification requirements. Conditional pass indicates minor deviations requiring engineering review.. Valid values are `pass|fail|conditional_pass|pending_review`',
    `purchase_order_number` STRING COMMENT 'Purchase order number linking the tested material to the procurement transaction. Enables traceability from test certificate back to supplier contract and delivery.',
    `remarks` STRING COMMENT 'Additional notes, observations, or comments from the testing laboratory or quality engineer regarding the test results, sample condition, or special circumstances.',
    `sampling_date` DATE COMMENT 'Date when the material sample was collected from the batch, delivery, or construction site for testing.',
    `sampling_location` STRING COMMENT 'Physical location where the material sample was collected (e.g., site name, warehouse, delivery truck, production line, grid reference).',
    `specification_requirement` STRING COMMENT 'Required values or acceptance criteria per project specification, contract, or standard (e.g., minimum compressive strength 30 MPa, yield strength 420 MPa min).',
    `technician_name` STRING COMMENT 'Name of the laboratory technician or engineer who performed the testing and signed the certificate.',
    `test_date` DATE COMMENT 'Date when the laboratory or field testing was performed on the sample.',
    `test_method` STRING COMMENT 'Specific testing procedure or method applied (e.g., compression test, tensile test, slump test, sieve analysis, chemical analysis).',
    `test_parameters` STRING COMMENT 'List of specific properties or characteristics measured during testing (e.g., compressive strength, yield strength, elongation, gradation, moisture content). Stored as structured text or JSON.',
    `test_results` STRING COMMENT 'Measured values and outcomes for each test parameter. Stored as structured text or JSON containing parameter-value pairs with units.',
    `test_standard` STRING COMMENT 'Industry or regulatory test standard followed during testing (e.g., ASTM C39, BS EN 12390, AASHTO T22, ISO 6892). Defines the test methodology and acceptance criteria.',
    `work_package_code` STRING COMMENT 'Work Breakdown Structure (WBS) code or work package identifier indicating where the tested material will be used in the project.',
    CONSTRAINT pk_test_certificate PRIMARY KEY(`test_certificate_id`)
) COMMENT 'Material test certificate and laboratory test result record capturing certified testing outcomes for construction materials (concrete, steel, aggregates, bitumen, soil, asphalt, geotextiles). Stores certificate number, sample ID, material type, batch/heat number, sampling date and location, test standard (ASTM, BS, EN, AASHTO), test parameters and measured values, pass/fail determination, issuing laboratory, laboratory accreditation number, and traceability to purchase order and delivery lot. Covers both third-party MTC documents received from suppliers and in-house/independent lab test results for site-sampled materials.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`weld_record` (
    `weld_record_id` BIGINT COMMENT 'Unique identifier for the weld record. Primary key for weld inspection and traceability documentation.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Weld records are subject to contract specifications and warranties; linking to agreement enables contract‑level quality assurance.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Welding records require linking the welding machine (asset) to ensure equipment maintenance, certification, and traceability of weld quality.',
    `carbon_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_emission. Business justification: Carbon accounting tracks emissions per welding activity; linking weld records to the corresponding carbon emission entry provides granular emission data for reporting.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this weld was performed.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Weld record must capture the worker who performed the weld for traceability and compliance.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Weld records must be linked to the drawing showing weld details for verification.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Weld records are billed to specific cost codes; linking enables accurate labor/material cost tracking in project cost control.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Weld quality records must link the welding contractor (subcontractor) for compliance and payment verification.',
    `itp_id` BIGINT COMMENT 'Foreign key linking to quality.itp. Business justification: Weld records are tied to ITP items; linking enables traceability of welding activities to the plan.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Weld records must reference the structural WBS element they belong to for inspection and certification.',
    `acceptance_standard` STRING COMMENT 'Industry code or standard against which the weld quality is evaluated. Defines acceptance criteria for defects, dimensions, and mechanical properties.. Valid values are `AWS D1.1|ASME Section IX|ISO 3834|API 1104|EN 1090|AISC 360`',
    `acceptance_status` STRING COMMENT 'Final quality disposition of the weld record indicating whether it meets project specifications and is approved for service. Current lifecycle state of the weld record.. Valid values are `accepted|rejected|rework_required|pending_review`',
    `base_material_grade` STRING COMMENT 'Material specification and grade of the base metal being welded. Critical for ensuring compatibility with welding procedures and filler materials.. Valid values are `^[A-Z0-9-]+$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this weld record was first created in the system. Audit trail for data lineage.',
    `defect_description` STRING COMMENT 'Detailed description of any defects, discontinuities, or non-conformances identified during visual or NDT inspection. Includes type, location, and severity of defects.',
    `filler_material_grade` STRING COMMENT 'Specification and grade of the welding consumable (electrode, wire, or rod) used to create the weld joint.. Valid values are `^[A-Z0-9-]+$`',
    `heat_number` STRING COMMENT 'Heat or lot number of the base material used in the weld. Provides traceability to material test certificates and chemical composition records.. Valid values are `^[A-Z0-9-]+$`',
    `interpass_temperature_c` DECIMAL(18,2) COMMENT 'Maximum temperature maintained between weld passes, measured in degrees Celsius. Controls cooling rate and prevents overheating.',
    `joint_type` STRING COMMENT 'Classification of the weld joint configuration based on the geometry and orientation of the components being joined. [ENUM-REF-CANDIDATE: butt|fillet|corner|edge|lap|plug|slot|tee — 8 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this weld record was last updated. Tracks changes to inspection results, acceptance status, or rework completion.',
    `material_thickness_mm` DECIMAL(18,2) COMMENT 'Thickness of the base material being welded, measured in millimeters. Influences welding parameters and inspection requirements.',
    `ndt_date` DATE COMMENT 'Date on which the NDT inspection was performed. Must occur after weld execution date.',
    `ndt_inspector_certification` STRING COMMENT 'Certification number of the NDT inspector verifying their qualification level and authorization to perform the specified NDT method.. Valid values are `^[A-Z0-9-]+$`',
    `ndt_inspector_name` STRING COMMENT 'Full name of the certified NDT inspector who performed the inspection. Required for traceability and accountability.',
    `ndt_method` STRING COMMENT 'Type of NDT inspection applied: VT (Visual Testing), PT (Penetrant Testing), MT (Magnetic Particle Testing), UT (Ultrasonic Testing), RT (Radiographic Testing), ET (Eddy Current Testing), LT (Leak Testing). [ENUM-REF-CANDIDATE: VT|PT|MT|UT|RT|ET|LT — 7 candidates stripped; promote to reference product]',
    `ndt_report_number` STRING COMMENT 'Unique identifier for the NDT inspection report documenting the test method, results, and inspector certification.. Valid values are `^[A-Z0-9-]+$`',
    `ndt_result` STRING COMMENT 'Outcome of the NDT inspection indicating whether the weld meets acceptance criteria or requires remediation.. Valid values are `accept|reject|conditional|retest`',
    `preheat_temperature_c` DECIMAL(18,2) COMMENT 'Temperature to which the base material was preheated before welding, measured in degrees Celsius. Required for certain materials to prevent cracking.',
    `pwht_completion_date` DATE COMMENT 'Date on which post-weld heat treatment was completed. Null if PWHT was not required or not yet performed.',
    `pwht_required_flag` BOOLEAN COMMENT 'Indicates whether post-weld heat treatment is required per the WPS or material specification. True if PWHT is mandatory, False otherwise.',
    `qc_approval_date` DATE COMMENT 'Date on which the QC inspector approved the weld record and certified that it meets all acceptance criteria.',
    `qc_inspector_name` STRING COMMENT 'Full name of the internal QC inspector who verified and approved the weld record. Responsible for final quality sign-off.',
    `remarks` STRING COMMENT 'Additional notes, observations, or special conditions related to the weld execution, inspection, or acceptance. Free-text field for contextual information.',
    `rework_completion_date` DATE COMMENT 'Date on which any required rework or repair of the weld was completed. Null if no rework was required.',
    `rework_required_flag` BOOLEAN COMMENT 'Indicates whether the weld requires repair, grinding, or re-welding to meet acceptance criteria. True if rework is needed, False if weld is acceptable as-is.',
    `weld_date` DATE COMMENT 'Date on which the welding activity was performed. Principal business event timestamp for the weld record lifecycle.',
    `weld_length_mm` DECIMAL(18,2) COMMENT 'Total length of the weld seam measured in millimeters. Used for production tracking and inspection planning.',
    `weld_number` STRING COMMENT 'Unique business identifier for the weld joint. Externally-known alphanumeric code used for traceability across project documentation, drawings, and inspection reports.. Valid values are `^[A-Z0-9-]+$`',
    `weld_position` STRING COMMENT 'Spatial orientation of the weld joint during welding. Positions are classified per AWS standards (1G through 6G for pipe, or flat/horizontal/vertical/overhead for plate). [ENUM-REF-CANDIDATE: 1G|2G|3G|4G|5G|6G|flat|horizontal|vertical|overhead — 10 candidates stripped; promote to reference product]',
    `weld_type` STRING COMMENT 'Welding process method used: SMAW (Shielded Metal Arc Welding), GMAW (Gas Metal Arc Welding), GTAW (Gas Tungsten Arc Welding), FCAW (Flux-Cored Arc Welding), SAW (Submerged Arc Welding), PAW (Plasma Arc Welding).. Valid values are `SMAW|GMAW|GTAW|FCAW|SAW|PAW`',
    `welder_stamp` STRING COMMENT 'Unique stamp or mark applied by the welder to identify their work on the physical weld joint. Provides field-level traceability.. Valid values are `^[A-Z0-9]+$`',
    `witness_name` STRING COMMENT 'Full name of the third-party or client representative who witnessed the weld inspection. Null if no witness was required.',
    `witness_organization` STRING COMMENT 'Name of the organization (client, consultant, or third-party inspection agency) that the witness inspector represents.',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether third-party or client witness is required for the weld inspection per the ITP. True if witness hold point applies, False otherwise.',
    `wps_number` STRING COMMENT 'Reference to the approved Welding Procedure Specification that governs the welding parameters, techniques, and materials for this weld. Ensures compliance with qualified welding procedures.. Valid values are `^[A-Z0-9-]+$`',
    `wqc_number` STRING COMMENT 'Certificate number of the qualified welder who performed the weld. Verifies that the welder is certified and authorized to perform welding under the specified WPS.. Valid values are `^[A-Z0-9-]+$`',
    CONSTRAINT pk_weld_record PRIMARY KEY(`weld_record_id`)
) COMMENT 'Weld inspection and traceability record for structural and pressure-system welding activities. Captures weld ID, weld procedure specification (WPS) reference, welder qualification certificate (WQC) number, joint type, material grade, NDT (Non-Destructive Testing) method applied, NDT result, acceptance standard (AWS, ASME, ISO 3834), and final acceptance status. Critical for structural integrity compliance.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`acceptance_test` (
    `acceptance_test_id` BIGINT COMMENT 'Unique identifier for the acceptance test record. Primary key for the acceptance test entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Factory Acceptance Tests are contractual milestones; FK ties test results to the contract for acceptance and payment triggers.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this acceptance test is performed.',
    `asset_id` BIGINT COMMENT 'Reference to the equipment or asset being tested. Links to the equipment asset master record.',
    `itp_id` BIGINT COMMENT 'Foreign key linking to quality.itp. Business justification: Acceptance test belongs to an Inspection and Test Plan; many acceptance tests can be associated with a single ITP.',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: When defects are identified during acceptance testing, an NCR may be raised; many acceptance tests can reference the same NCR.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: FAT records are tied to the WBS element being commissioned for traceability.',
    `acceptance_certificate_number` STRING COMMENT 'Reference number of the formal acceptance certificate issued upon successful completion of the test. Links to the document management system.',
    `acceptance_date` DATE COMMENT 'Date on which the equipment or system was formally accepted by the client or authorized representative. Marks the start of warranty and DLP (Defects Liability Period).',
    `acceptance_status` STRING COMMENT 'Final acceptance decision for the equipment or system. Accepted indicates full approval for delivery or commissioning. Rejected requires remediation and retest. Conditional acceptance allows progression with punch-list items.. Valid values are `accepted|rejected|conditional_acceptance|pending_retest`',
    `client_representative_name` STRING COMMENT 'Name of the clients representative who witnessed and approved the acceptance test results.',
    `compliance_standard` STRING COMMENT 'Industry standards or regulatory codes that the equipment must comply with. Examples include ASME, API, IEC, NFPA, or project-specific standards.',
    `contractor_name` STRING COMMENT 'Name of the contractor or subcontractor responsible for the equipment or system being tested.',
    `corrective_action_required` STRING COMMENT 'Description of corrective actions required to address any defects or non-conformances identified during the test. Links to NCR (Non-Conformance Report) if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this acceptance test record was first created in the system. Audit trail for record creation.',
    `defects_identified` STRING COMMENT 'List of specific defects or non-conformances identified during the acceptance test. Each defect should be documented with severity and required corrective action.',
    `equipment_description` STRING COMMENT 'Detailed description of the equipment, system, or assembly being tested. Includes make, model, serial number, and key specifications.',
    `manufacturer_name` STRING COMMENT 'Name of the equipment manufacturer. Particularly relevant for FAT conducted at the manufacturers facility.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this acceptance test record. Audit trail for accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this acceptance test record was last modified. Audit trail for record updates.',
    `remarks` STRING COMMENT 'Additional remarks, notes, or observations related to the acceptance test. Captures any special conditions, deviations, or contextual information.',
    `retest_date` DATE COMMENT 'Scheduled or actual date for retest after corrective actions. Null if no retest is required.',
    `retest_required` BOOLEAN COMMENT 'Indicates whether a retest is required after corrective actions are completed. True if the test failed or had conditional pass requiring verification.',
    `specification_reference` STRING COMMENT 'Reference to the technical specification or contract requirements against which the equipment was tested. Defines the acceptance criteria.',
    `test_date` DATE COMMENT 'The date on which the acceptance test was conducted. Principal business event timestamp for the test execution.',
    `test_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the acceptance test in hours. Captures the time from test start to completion.',
    `test_engineer_name` STRING COMMENT 'Name of the engineer or technician who conducted the acceptance test. Primary responsible party for test execution.',
    `test_findings` STRING COMMENT 'Detailed findings and observations from the acceptance test execution. Documents any deviations, defects, or non-conformances identified during testing.',
    `test_humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity percentage during the acceptance test. Environmental condition that may affect test results for sensitive equipment.',
    `test_location` STRING COMMENT 'Physical location where the acceptance test was performed. For FAT, typically the manufacturers facility name and address. For SAT, the project site location.',
    `test_number` STRING COMMENT 'Unique business identifier for the acceptance test. Externally visible test reference number used in documentation and correspondence.',
    `test_procedure_reference` STRING COMMENT 'Reference to the approved test procedure or ITP (Inspection and Test Plan) document that governs this acceptance test. Links to the document management system.',
    `test_procedure_version` STRING COMMENT 'Version number of the test procedure document used during the test execution. Ensures traceability to the correct revision.',
    `test_report_reference` STRING COMMENT 'Reference to the detailed test report document. Links to the document management system for full test documentation including measurements, photos, and witness signatures.',
    `test_result` STRING COMMENT 'Overall outcome of the acceptance test. Pass indicates full compliance with specifications. Fail indicates non-compliance requiring remediation. Conditional pass indicates acceptance with minor punch-list items.. Valid values are `pass|fail|conditional_pass`',
    `test_status` STRING COMMENT 'Current lifecycle status of the acceptance test. Tracks progression from scheduling through execution to final acceptance decision.. Valid values are `scheduled|in_progress|passed|failed|conditional_pass|cancelled`',
    `test_temperature_c` DECIMAL(18,2) COMMENT 'Ambient temperature in degrees Celsius during the acceptance test. Environmental condition that may affect test results.',
    `test_type` STRING COMMENT 'Type of acceptance test being performed. FAT (Factory Acceptance Test) is conducted at the manufacturers facility before shipment. SAT (Site Acceptance Test) is conducted at the project site after installation.. Valid values are `FAT|SAT`',
    `witness_party` STRING COMMENT 'Names and organizations of all parties who witnessed the acceptance test. Typically includes client representatives, consultant engineers, and regulatory inspectors.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this acceptance test record. Audit trail for accountability.',
    CONSTRAINT pk_acceptance_test PRIMARY KEY(`acceptance_test_id`)
) COMMENT 'Acceptance test record documenting formal Factory Acceptance Testing (FAT) and Site Acceptance Testing (SAT) of manufactured equipment, prefabricated assemblies, and installed systems. Captures test type (FAT/SAT), test date, location, equipment reference, test procedure, results, witness parties, and acceptance status';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`defect` (
    `defect_id` BIGINT COMMENT 'Unique identifier for the defect record. Primary key for the defect entity.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Defect tracking links defects to the activity where they were discovered, enabling schedule‑based defect reporting.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Defects are tied to contractual warranty periods and penalties; contract reference enables warranty and LD calculations.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project where the defect was identified.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Defects are logged against the drawing that defines the affected element for corrective action.',
    `firm_profile_id` BIGINT COMMENT 'System identifier for the contractor or subcontractor responsible for rectifying the defect.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Defect register records which employee identified the defect, needed for root‑cause analysis and performance reporting.',
    `inspection_id` BIGINT COMMENT 'System identifier for the inspection record during which this defect was identified (e.g., ITP inspection, FAT, SAT, DLP walkthrough).',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: Defect may be raised from an NCR; linking provides traceability.',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Defect records often cite the specific spec clause violated; FK enables traceability.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Defects are recorded against the WBS element where they occur, enabling root‑cause analysis.',
    `actual_rectification_date` DATE COMMENT 'Actual date when the defect rectification work was completed.',
    `assigned_to` STRING COMMENT 'Name of the individual or team currently assigned to manage or rectify the defect.',
    `closure_date` DATE COMMENT 'Date when the defect record was formally closed after successful verification and acceptance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the defect record was first created in the system.',
    `defect_number` STRING COMMENT 'Business-facing unique identifier or reference number for the defect, typically used in correspondence and reporting.',
    `defect_status` STRING COMMENT 'Current lifecycle status of the defect: open (newly identified), assigned (allocated to responsible party), in_progress (rectification underway), rectified (work completed, awaiting verification), verified (inspected and accepted), closed (fully resolved), rejected (not a valid defect). [ENUM-REF-CANDIDATE: open|assigned|in_progress|rectified|verified|closed|rejected — 7 candidates stripped; promote to reference product]',
    `defect_type` STRING COMMENT 'Classification of the defect by nature: workmanship (poor execution), material (defective materials), design (design flaw), installation (incorrect installation), finish (cosmetic/surface defects), structural (load-bearing issues), MEP (Mechanical Electrical Plumbing systems), or other. [ENUM-REF-CANDIDATE: workmanship|material|design|installation|finish|structural|MEP|other — 8 candidates stripped; promote to reference product]',
    `defect_description` STRING COMMENT 'Detailed description of the defect including nature, extent, and any observable symptoms or deviations from specification.',
    `dlp_expiry_date` DATE COMMENT 'Date when the Defects Liability Period (DLP) expires for the work package or project area where this defect was identified. Defects identified before this date must be rectified by the contractor at no cost to the client.',
    `identified_by` STRING COMMENT 'Name of the person or role who identified the defect (e.g., QA/QC inspector, client representative, commissioning engineer, site supervisor).',
    `identified_date` DATE COMMENT 'Date when the defect was first identified or discovered during inspection, commissioning, or DLP (Defects Liability Period) walkthrough.',
    `identified_phase` STRING COMMENT 'Project phase during which the defect was identified: construction (during active construction), pre_commissioning (before system startup), commissioning (during FAT/SAT), handover (at project handover), DLP (Defects Liability Period), post_handover (after final handover).. Valid values are `construction|pre_commissioning|commissioning|handover|DLP|post_handover`',
    `impact_on_handover` BOOLEAN COMMENT 'Indicates whether the defect impacts project handover or commissioning milestones (True if it blocks handover, False otherwise).',
    `location_building` STRING COMMENT 'Building or structure identifier where the defect is located (e.g., Building A, Main Terminal, Power Block 1).',
    `location_grid_reference` STRING COMMENT 'Grid reference or coordinate system identifier pinpointing the defect location on construction drawings (e.g., Grid A-3, Column Line B/5).',
    `location_level` STRING COMMENT 'Floor or level identifier where the defect is located (e.g., Ground Floor, Level 3, Basement 2, Roof).',
    `location_zone` STRING COMMENT 'Zone, area, or room identifier where the defect is located (e.g., Zone A, Room 301, Lobby, Mechanical Room).',
    `modified_by` STRING COMMENT 'Username or identifier of the person who last modified the defect record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the defect record was last modified or updated.',
    `photo_reference` STRING COMMENT 'Reference or file path to photographic evidence of the defect, typically stored in document management system (e.g., Aconex, BIM 360).',
    `rectification_cost` DECIMAL(18,2) COMMENT 'Estimated or actual cost incurred to rectify the defect, typically borne by the responsible contractor.',
    `rectification_method` STRING COMMENT 'Description of the method or approach used to rectify the defect (e.g., rework, replacement, repair, adjustment, re-finishing).',
    `remarks` STRING COMMENT 'Additional comments, notes, or observations related to the defect, rectification process, or verification outcome.',
    `responsible_contractor_name` STRING COMMENT 'Name of the contractor or subcontractor responsible for rectifying the defect.',
    `severity` STRING COMMENT 'Severity classification of the defect: critical (safety/structural risk, immediate action required), major (significant impact on functionality or performance), minor (limited impact, does not affect primary function), cosmetic (aesthetic only, no functional impact).. Valid values are `critical|major|minor|cosmetic`',
    `target_rectification_date` DATE COMMENT 'Target or planned date by which the defect should be rectified, often driven by DLP (Defects Liability Period) expiry or contractual milestones.',
    `title` STRING COMMENT 'Short descriptive title or summary of the defect for quick identification and reporting.',
    `trade_discipline` STRING COMMENT 'Construction trade or discipline responsible for the work where the defect occurred (e.g., Concrete, Steel, MEP, HVAC, Electrical, Plumbing, Finishes, Painting).',
    `verification_date` DATE COMMENT 'Date when the rectified defect was inspected and verified as satisfactorily resolved by QA/QC or client representative.',
    `verified_by` STRING COMMENT 'Name of the person or role who verified the defect rectification (e.g., QA/QC inspector, client representative, project engineer).',
    `created_by` STRING COMMENT 'Username or identifier of the person who created the defect record in the system.',
    CONSTRAINT pk_defect PRIMARY KEY(`defect_id`)
) COMMENT 'Defect record tracking a physical construction defect identified during inspection, commissioning, or the Defects Liability Period (DLP). Captures defect description, location (grid reference, level, zone), severity classification, responsible trade/subcontractor, date identified, target rectification date, rectification method, and closure status. Distinct from NCR in that defects may arise post-handover during DLP.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`punch_list` (
    `punch_list_id` BIGINT COMMENT 'Unique identifier for the punch list record. Primary key for the punch list entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Punch list close‑out is a contractual deliverable; linking to agreement tracks fulfillment of contract milestones.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Client oversees punch‑list during project handover; required for client‑focused punch‑list status reports.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this punch list belongs.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Punch list responsibility matrix must reference the subcontractor responsible for each item to drive close‑out.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Punch list creation is logged with the employee who prepared it, required for traceability in handover documentation.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Punch lists are generated per WBS element to allocate cost and schedule impacts accurately.',
    `actual_closeout_date` DATE COMMENT 'The actual date on which the punch list was fully closed, indicating all items have been resolved and accepted. Nullable until closure is achieved.',
    `client_representative` STRING COMMENT 'Name of the client or owner representative who is involved in the punch list review and acceptance process.',
    `closed_items_count` STRING COMMENT 'The current count of punch list items that have been resolved and closed. Indicates progress toward full punch list closure.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'The percentage of punch list items that have been closed, calculated as (closed_items_count / total_items_count) * 100. Provides a quick progress indicator.',
    `contract_reference` STRING COMMENT 'Reference to the contract or contract package under which this punch list is being managed. Links the punch list to contractual obligations and terms.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this punch list record was first created in the system. Part of the audit trail for record lifecycle tracking.',
    `critical_items_count` STRING COMMENT 'The count of items classified as critical or high-priority, typically those that block handover or pose safety/operational risks.',
    `discipline` STRING COMMENT 'The engineering or construction discipline that this punch list primarily covers. Used to route items to the appropriate trade or subcontractor for resolution. [ENUM-REF-CANDIDATE: civil|structural|architectural|mechanical|electrical|plumbing|hvac|instrumentation|piping|general — 10 candidates stripped; promote to reference product]',
    `dlp_commencement_gate` BOOLEAN COMMENT 'Boolean flag indicating whether closure of this punch list triggers the start of the Defects Liability Period (DLP). True means DLP clock starts upon punch list closure.',
    `document_reference` STRING COMMENT 'Reference to the formal punch list document, report, or file stored in the document management system (e.g., Aconex, BIM 360). Enables traceability to the source document.',
    `handover_gate` BOOLEAN COMMENT 'Boolean flag indicating whether closure of this punch list is a contractual gate for project handover. True means handover cannot proceed until this list is closed.',
    `inspection_date` DATE COMMENT 'The date on which the inspection was conducted that resulted in the creation of this punch list. Typically the date of the pre-handover or milestone inspection walk-through.',
    `milestone_type` STRING COMMENT 'The project milestone or phase that this punch list is associated with. Defines the contractual stage at which defects and incomplete works are being tracked for resolution. [ENUM-REF-CANDIDATE: mechanical_completion|practical_completion|substantial_completion|final_completion|handover|commissioning|pre_commissioning — 7 candidates stripped; promote to reference product]',
    `modified_by` STRING COMMENT 'The username or identifier of the user who last modified this punch list record. Part of the audit trail for accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this punch list record was last modified or updated. Part of the audit trail for record lifecycle tracking.',
    `punch_list_name` STRING COMMENT 'Descriptive name or title for the punch list, often indicating the milestone, area, or phase it relates to (e.g., Mechanical Completion - Building A, Practical Completion - Zone 3).',
    `open_items_count` STRING COMMENT 'The current count of punch list items that remain open or unresolved. Used to track progress toward close-out.',
    `prepared_by` STRING COMMENT 'Name of the individual or role who prepared or compiled the punch list, typically a QA/QC inspector, project engineer, or commissioning manager.',
    `priority` STRING COMMENT 'Overall priority classification for the punch list, reflecting the urgency and impact of the items it contains. Critical punch lists may block handover or commissioning.. Valid values are `critical|high|medium|low`',
    `project_area` STRING COMMENT 'The physical area, zone, building, or section of the project to which this punch list applies (e.g., Building A, Zone 3, East Wing, Substation 2).',
    `punch_list_number` STRING COMMENT 'Business identifier for the punch list, typically a human-readable code or number used for tracking and reference in project documentation and handover processes.',
    `punch_list_status` STRING COMMENT 'Current lifecycle status of the punch list. Indicates whether the list is being compiled, actively worked, under review, or closed out.. Valid values are `draft|open|in_progress|under_review|closed|cancelled`',
    `remarks` STRING COMMENT 'General comments, notes, or observations related to the punch list. May include context on delays, coordination issues, or special conditions affecting close-out.',
    `responsible_party_type` STRING COMMENT 'Classification of the party responsible for punch list resolution. Helps route accountability and track performance by party type.. Valid values are `general_contractor|subcontractor|supplier|joint_venture|client|consultant`',
    `reviewed_by` STRING COMMENT 'Name of the individual or role who reviewed and approved the punch list for issuance, typically a project manager, client representative, or QA/QC manager.',
    `specification_reference` STRING COMMENT 'Reference to the technical specification, design document, or quality standard against which the punch list items are being evaluated.',
    `target_closeout_date` DATE COMMENT 'The planned or contractually required date by which all items on the punch list must be resolved and the list closed. Critical for handover and DLP (Defects Liability Period) commencement.',
    `total_items_count` STRING COMMENT 'The total number of punch list items (defects, incomplete works, commissioning tasks) recorded on this punch list.',
    `created_by` STRING COMMENT 'The username or identifier of the user who created this punch list record in the system. Part of the audit trail for accountability.',
    `creation_date` DATE COMMENT 'The date on which the punch list was initially created or issued. Marks the start of the close-out tracking process for the associated milestone.',
    CONSTRAINT pk_punch_list PRIMARY KEY(`punch_list_id`)
) COMMENT 'Punch list (snagging list) master record grouping outstanding defects, incomplete works, and commissioning items requiring resolution before a project milestone (mechanical completion, practical completion, or handover). Captures punch list number, associated milestone, project area/zone, creation date, total items count, open/closed item counts, target close-out date, responsible party, and overall status. Drives the close-out workflow that gates contractual handover.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`punch_item` (
    `punch_item_id` BIGINT COMMENT 'Unique identifier for the punch list item. Primary key.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Punch list generation ties each punch item to its originating activity for close‑out verification and handover.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Each punch item must be traced to the governing contract for liability and final acceptance.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project where this punch item was identified. Enables project-level defect tracking and close-out reporting.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Punch item assignment to a worker enables tracking of who will close the item.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Punch items track deficiencies on particular drawings; FK enables linkage to BIM models.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Punch items often generate change order costs; linking each punch_item to a cost code enables precise cost tracking for close‑out.',
    `firm_profile_id` BIGINT COMMENT 'Reference to the subcontractor or trade contractor responsible for rectifying the punch item. Drives accountability and work assignment during close-out.',
    `punch_list_id` BIGINT COMMENT 'Reference to the parent punch list record that contains this item. Links the item to the overall punch list inspection event.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Punch items can be assigned to a crew for coordinated resolution; supports crew workload tracking.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Punch list items are assigned to a responsible employee; linking enables tracking of responsibility and performance.',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Punch items may reference a spec clause; FK supports audit of spec compliance.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Each punch item must be tied to its originating WBS element for traceability and cost tracking.',
    `actual_completion_date` DATE COMMENT 'Actual date when the punch item was completed and ready for verification. Used to track schedule performance and close-out progress.',
    `punch_item_category` STRING COMMENT 'Classification of the punch item by discipline or trade. Structural covers concrete, steel, and load-bearing elements; MEP (Mechanical Electrical and Plumbing) covers HVAC, electrical, plumbing, and fire protection; Architectural covers doors, windows, ceilings, and interior finishes; Civil covers site work, paving, and drainage; Finishes covers painting, flooring, and decorative elements; Landscaping covers external plantings and hardscapes.. Valid values are `structural|mep|architectural|civil|finishes|landscaping`',
    `client_representative_name` STRING COMMENT 'Name of the client representative or consultant who witnessed or approved the punch item closure. Provides client acceptance traceability.',
    `closure_status` STRING COMMENT 'Final disposition status of the punch item at project close-out. Accepted indicates satisfactory completion; rejected indicates non-conformance; deferred indicates item moved to DLP (Defects Liability Period) or post-handover.. Valid values are `pending|accepted|rejected|deferred`',
    `corrective_action` STRING COMMENT 'Description of the corrective action taken or required to resolve the punch item. Provides remediation guidance and audit trail.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost impact amount. Enables multi-currency project tracking.. Valid values are `^[A-Z]{3}$`',
    `cost_impact` DECIMAL(18,2) COMMENT 'Estimated or actual cost incurred to rectify the punch item. Used for financial tracking and back-charge to responsible parties.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the punch item record was first created in the system. Provides audit trail for data lineage.',
    `deferred_to_dlp` BOOLEAN COMMENT 'Flag indicating whether the punch item was deferred to the DLP (Defects Liability Period) for post-handover rectification. True if deferred; false otherwise.',
    `dlp_end_date` DATE COMMENT 'End date of the DLP (Defects Liability Period) applicable to this punch item if deferred. Defines the contractual deadline for rectification.',
    `identified_by` STRING COMMENT 'Name of the inspector, quality engineer, or project manager who identified the punch item during the inspection walkthrough.',
    `identified_date` DATE COMMENT 'Date when the punch item was identified during the inspection. Marks the start of the remediation lifecycle.',
    `item_description` STRING COMMENT 'Detailed description of the defect, deficiency, or incomplete work identified during inspection. Provides clear guidance for remediation.',
    `item_number` STRING COMMENT 'Sequential or hierarchical item number within the punch list. Used for tracking and referencing specific defects during close-out inspections.',
    `location` STRING COMMENT 'Physical location or area within the project where the punch item was identified. May reference building, floor, room, grid reference, or zone.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the punch item record was last modified. Tracks data currency and change history.',
    `photo_reference` STRING COMMENT 'Reference or file path to photographic evidence of the punch item. Supports visual documentation and dispute resolution.',
    `priority` STRING COMMENT 'Priority level assigned to the punch item based on impact to project completion, safety, or functionality. Critical items block practical completion; high items affect major systems; medium items are cosmetic or minor; low items are non-essential.. Valid values are `critical|high|medium|low`',
    `punch_item_status` STRING COMMENT 'Current lifecycle status of the punch item. Open indicates newly identified; in_progress indicates work underway; completed indicates work finished awaiting verification; verified indicates inspection passed; closed indicates final acceptance; rejected indicates failed verification requiring rework.. Valid values are `open|in_progress|completed|verified|closed|rejected`',
    `rejection_reason` STRING COMMENT 'Reason provided by the verification inspector if the punch item was rejected after attempted completion. Drives rework and quality improvement.',
    `remarks` STRING COMMENT 'Additional notes, comments, or observations related to the punch item. Captures context, special conditions, or coordination issues.',
    `target_completion_date` DATE COMMENT 'Target date by which the punch item must be rectified. Drives scheduling and resource allocation for close-out activities.',
    `verification_date` DATE COMMENT 'Date when the completed punch item was inspected and verified as satisfactory. Marks the closure of the remediation cycle.',
    `verification_inspector` STRING COMMENT 'Name of the inspector or quality engineer who verified that the punch item was satisfactorily completed. Provides accountability for quality sign-off.',
    CONSTRAINT pk_punch_item PRIMARY KEY(`punch_item_id`)
) COMMENT 'Individual punch list item within a punch list record. Captures item number, description, location, category (structural, MEP, architectural, civil), responsible subcontractor, priority, target completion date, actual completion date, verification inspector, and closure status. Drives the close-out workflow for practical completion.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`quality_plan` (
    `quality_plan_id` BIGINT COMMENT 'Unique identifier for the Project Quality Plan (PQP). Primary key.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project this quality plan governs.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Quality plans can be defined per WBS element to address element‑specific requirements.',
    `applicable_standards` STRING COMMENT 'List of quality standards, codes, and specifications applicable to the project (e.g., ISO 9001, ASTM, ACI, AISC, project-specific specifications).',
    `approval_date` DATE COMMENT 'Date when the quality plan was formally approved by authorized personnel.',
    `approval_status` STRING COMMENT 'Approval state of the quality plan by client and internal stakeholders.. Valid values are `pending|approved|rejected|conditional`',
    `approved_by_name` STRING COMMENT 'Name of the individual who formally approved the quality plan for implementation.',
    `approved_by_role` STRING COMMENT 'Organizational role or title of the approver (e.g., Project Director, Quality Director).',
    `audit_schedule_reference` STRING COMMENT 'Reference to the internal and external audit schedule defined for the project.',
    `calibration_procedure_reference` STRING COMMENT 'Reference to the procedure for calibration and maintenance of inspection, measuring, and test equipment.',
    `client_approval_date` DATE COMMENT 'Date when the client formally approved the quality plan.',
    `client_approval_required` BOOLEAN COMMENT 'Indicates whether client approval is contractually required for this quality plan.',
    `client_approved_by_name` STRING COMMENT 'Name of the client representative who approved the quality plan.',
    `continuous_improvement_mechanism` STRING COMMENT 'Description of mechanisms for continuous improvement, including lessons learned, corrective actions, and preventive actions.',
    `contract_reference` STRING COMMENT 'Reference to the construction contract that mandates this quality plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quality plan record was first created in the system.',
    `defect_liability_period_days` STRING COMMENT 'Duration in days of the Defects Liability Period during which quality defects must be rectified.',
    `document_control_procedure` STRING COMMENT 'Description of document control procedures for quality records, including numbering, distribution, revision, and archival.',
    `effective_date` DATE COMMENT 'Date when the quality plan becomes binding and operational for the project.',
    `expiry_date` DATE COMMENT 'Date when the quality plan ceases to be active, typically at project completion or handover.',
    `handover_quality_requirements` STRING COMMENT 'Description of quality documentation and completion criteria required for project handover and commissioning.',
    `inspection_regime_summary` STRING COMMENT 'High-level summary of the inspection and testing regime, including hold points, witness points, and surveillance activities.',
    `itp_register_reference` STRING COMMENT 'Reference to the master ITP register that lists all inspection and test plans governed by this quality plan.',
    `material_control_procedure` STRING COMMENT 'Description of procedures for material receipt, inspection, storage, and traceability.',
    `modified_by` STRING COMMENT 'User identifier of the person who last modified the quality plan record in the system.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the quality plan record was last modified in the system.',
    `ncr_procedure_reference` STRING COMMENT 'Reference to the procedure for raising, investigating, and closing Non-Conformance Reports.',
    `organizational_structure` STRING COMMENT 'Description of the project quality organization, including roles, responsibilities, and reporting lines.',
    `plan_number` STRING COMMENT 'Externally-known unique identifier for the quality plan document, typically following organizational numbering conventions.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the quality plan document.. Valid values are `draft|under_review|approved|active|superseded|archived`',
    `prepared_by_name` STRING COMMENT 'Name of the individual or team responsible for preparing the quality plan.',
    `prepared_by_role` STRING COMMENT 'Organizational role or title of the person who prepared the quality plan (e.g., Quality Manager, QA/QC Engineer).',
    `quality_manager_name` STRING COMMENT 'Name of the designated Quality Manager responsible for implementing this plan.',
    `quality_objectives` STRING COMMENT 'Specific, measurable quality objectives defined for the project (e.g., zero NCRs in critical systems, 100% ITP compliance).',
    `quality_policy_reference` STRING COMMENT 'Reference to the organizational quality policy document that this plan implements.',
    `remarks` STRING COMMENT 'Additional notes, comments, or clarifications related to the quality plan.',
    `reviewed_by_name` STRING COMMENT 'Name of the individual who reviewed the quality plan for technical accuracy and completeness.',
    `reviewed_by_role` STRING COMMENT 'Organizational role or title of the reviewer (e.g., Project Manager, Senior QA/QC Manager).',
    `scope_of_work` STRING COMMENT 'Description of the project scope covered by this quality plan, including major deliverables and work packages.',
    `subcontractor_quality_management` STRING COMMENT 'Description of quality management requirements and oversight procedures for subcontractors and suppliers.',
    `title` STRING COMMENT 'Descriptive title of the Project Quality Plan document.',
    `training_requirements` STRING COMMENT 'Description of quality-related training requirements for project personnel, including induction, competency assessments, and certifications.',
    `version` STRING COMMENT 'Version identifier for the quality plan document, incremented with each revision.',
    `created_by` STRING COMMENT 'User identifier of the person who created the quality plan record in the system.',
    CONSTRAINT pk_quality_plan PRIMARY KEY(`quality_plan_id`)
) COMMENT 'Project Quality Plan (PQP) master document defining the overall QA/QC strategy for a specific project. Captures organizational quality responsibilities, applicable standards and codes, inspection regime definitions, document control procedures, audit schedule, NCR procedures, training requirements, and continuous improvement mechanisms. Serves as the top-level quality governance document per ISO 9001 and contract requirements. All ITPs, checklists, and audit programs trace back to this plan.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`quality_audit` (
    `quality_audit_id` BIGINT COMMENT 'Unique identifier for the quality audit record. Primary key.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project being audited.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Audit reports require the lead auditors employee ID for internal audit tracking and regulator‑required audit logs.',
    `quality_plan_id` BIGINT COMMENT 'Foreign key linking to quality.quality_plan. Business justification: Each quality audit evaluates a specific quality plan; many audits can be linked to one plan.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Audits may target specific WBS elements; linking records audit findings to the element.',
    `areas_audited` STRING COMMENT 'Comma-separated list of physical locations, work areas, or processes audited (e.g., Site Office, Concrete Batching Plant, Welding Shop, Material Testing Lab).',
    `audit_date` DATE COMMENT 'The date when the audit was conducted or commenced. Principal business event timestamp for the audit.',
    `audit_number` STRING COMMENT 'Externally-known unique audit reference number assigned by the quality management system.',
    `audit_scope` STRING COMMENT 'Description of the audit scope including processes, areas, activities, or clauses covered (e.g., ISO 9001 clauses 7.1-7.5, site QA/QC processes, material testing laboratory).',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit: planned (scheduled but not started), in_progress (audit fieldwork underway), completed (audit report issued), closed (all corrective actions verified), cancelled (audit not conducted).. Valid values are `planned|in_progress|completed|closed|cancelled`',
    `audit_type` STRING COMMENT 'Classification of the audit: internal (conducted by organization), external (conducted by client), third-party (certification body), surveillance (periodic ISO follow-up), or certification (initial ISO certification).. Valid values are `internal|external|third_party|surveillance|certification`',
    `auditee_department` STRING COMMENT 'The department, division, or functional area being audited.',
    `auditee_representative_name` STRING COMMENT 'Name of the primary representative from the audited area who participated in the audit.',
    `auditor_organization` STRING COMMENT 'Name of the organization conducting the audit (internal department, client organization, or third-party certification body).',
    `car_raised_count` STRING COMMENT 'Total number of Corrective Action Requests (CARs) raised as a result of the audit findings requiring formal corrective action.',
    `certification_body` STRING COMMENT 'Name of the third-party certification body conducting the audit (applicable for certification or surveillance audits).',
    `certification_standard` STRING COMMENT 'The ISO or industry standard being audited for certification (e.g., ISO 9001:2015, ISO 14001:2015, ISO 45001:2018).',
    `closed_by` STRING COMMENT 'Name of the quality manager or authorized person who formally closed the audit.',
    `closure_date` DATE COMMENT 'The date when the audit was formally closed after verification that all corrective actions have been satisfactorily completed.',
    `conclusion` STRING COMMENT 'Overall audit conclusion: satisfactory (no major issues), satisfactory_with_observations (minor issues noted), unsatisfactory (major non-conformances requiring action), not_recommended_for_certification (for certification audits).. Valid values are `satisfactory|satisfactory_with_observations|unsatisfactory|not_recommended_for_certification`',
    `corrective_action_due_date` DATE COMMENT 'The deadline by which all corrective actions arising from the audit must be completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was first created in the system.',
    `criteria` STRING COMMENT 'The standards, specifications, or requirements against which the audit is conducted (e.g., ISO 9001:2015, Project Quality Plan Rev 3, Contract Specification Section 5).',
    `documents_reviewed` STRING COMMENT 'Summary or list of key documents reviewed during the audit (e.g., Quality Plan, ITP registers, NCR logs, calibration certificates).',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the audit in hours, including preparation, fieldwork, and reporting time.',
    `end_date` DATE COMMENT 'The date when the audit fieldwork was completed.',
    `findings_summary` STRING COMMENT 'Executive summary of the audit findings, highlighting key observations, non-conformances, and areas of concern.',
    `follow_up_audit_date` DATE COMMENT 'The scheduled or actual date of the follow-up audit to verify corrective action effectiveness.',
    `follow_up_audit_required` BOOLEAN COMMENT 'Indicates whether a follow-up audit is required to verify closure of corrective actions (True) or not (False).',
    `lead_auditor_name` STRING COMMENT 'Full name of the lead auditor responsible for conducting and reporting the audit.',
    `major_nc_count` STRING COMMENT 'Total number of major non-conformances identified: systemic failures, complete absence of required processes, or situations that could result in delivery of non-conforming product/service.',
    `minor_nc_count` STRING COMMENT 'Total number of minor non-conformances identified: isolated lapses or single failures that do not indicate systemic breakdown.',
    `modified_by` STRING COMMENT 'Username or identifier of the person who last modified this audit record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was last modified.',
    `observations_count` STRING COMMENT 'Total number of observations (opportunities for improvement) identified during the audit that do not constitute non-conformances.',
    `personnel_interviewed` STRING COMMENT 'Comma-separated list of roles or names of personnel interviewed during the audit.',
    `positive_findings` STRING COMMENT 'Description of positive practices, strengths, or areas of excellence identified during the audit.',
    `remarks` STRING COMMENT 'Additional comments, notes, or context relevant to the audit not captured in other fields.',
    `report_issued_date` DATE COMMENT 'The date when the formal audit report was issued to the auditee.',
    `report_reference` STRING COMMENT 'Document reference number or file path to the formal audit report.',
    `start_date` DATE COMMENT 'The date when the audit fieldwork began, applicable for multi-day audits.',
    `team_members` STRING COMMENT 'Comma-separated list of audit team member names who participated in the audit.',
    `created_by` STRING COMMENT 'Username or identifier of the person who created this audit record.',
    CONSTRAINT pk_quality_audit PRIMARY KEY(`quality_audit_id`)
) COMMENT 'Internal or external quality audit record assessing compliance with the Project Quality Plan, ISO 9001, and contractual QA/QC requirements. Captures audit type (internal/external/third-party), audit date, scope, auditor, findings (observations, minor non-conformances, major non-conformances), corrective action requests raised, and audit closure status.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`quality_submittal` (
    `quality_submittal_id` BIGINT COMMENT 'Unique identifier for the quality submittal record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Submittals are contract deliverables; linking to agreement supports compliance verification and audit trails.',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Permit submittal tracking: submittals are submitted to obtain or modify permits, linking submittal records to the relevant permit.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this submittal is being made.',
    `engineering_submittal_id` BIGINT COMMENT 'SSOT reference to canonical design.design_submittal (single source of truth).',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Submittals must be linked to the drawing they pertain to for reviewer reference.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Submittal tracking requires linking each submittal to the originating subcontractor for approval workflow.',
    `quality_plan_id` BIGINT COMMENT 'Foreign key linking to quality.quality_plan. Business justification: Quality submittals are made against a quality plan; many submittals can belong to one plan.',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Submittals often satisfy a particular spec clause; FK enables automated compliance checks.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Submittals are often scoped to a specific WBS element; FK enables tracking of approvals per element.',
    `actual_review_days` STRING COMMENT 'Actual number of days taken to complete the review from submission to disposition. Used for performance tracking and schedule impact analysis.',
    `approval_code` STRING COMMENT 'Standard approval code indicating the disposition: A=Approved, B=Approved with Comments, C=Approved as Noted, D=Rejected, E=Resubmit, R=For Review Only. Industry-standard coding per AIA and FIDIC practices.. Valid values are `A|B|C|D|E|R`',
    `certification_required` BOOLEAN COMMENT 'Flag indicating whether material test certificates, factory acceptance test (FAT) reports, or third-party certifications are required as part of the submittal package.',
    `compliance_standard` STRING COMMENT 'Industry standard, code, or specification that the submitted material or product must comply with (e.g., ASTM A615, BS EN 1992, ACI 318).',
    `contractor_name` STRING COMMENT 'Name of the contractor or subcontractor submitting the material, product data, or documentation for review.',
    `contractor_response` STRING COMMENT 'Contractors response to reviewer comments, including actions taken, clarifications provided, or justification for resubmission.',
    `contractual_review_days` STRING COMMENT 'Number of calendar or working days allowed per contract for the review and return of submittals. Used to monitor compliance with contract terms.',
    `cost_impact` DECIMAL(18,2) COMMENT 'Estimated cost impact (positive or negative) associated with the submittal, particularly relevant for material substitutions or design changes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the submittal record was first created in the system. Audit trail for record creation.',
    `document_reference` STRING COMMENT 'Reference to the document management system location, file path, or document control number where the submittal files are stored.',
    `final_approval_date` DATE COMMENT 'Date when the submittal received final approval and was cleared for procurement or construction use.',
    `linked_change_order_number` STRING COMMENT 'Reference to any change order that this submittal is associated with, particularly for design changes or material substitutions.',
    `linked_rfi_number` STRING COMMENT 'Reference to any related RFI (Request for Information) that prompted or is associated with this submittal.',
    `manufacturer_model_number` STRING COMMENT 'Specific model number, catalog number, or product code from the manufacturer identifying the exact product being submitted.',
    `manufacturer_name` STRING COMMENT 'Name of the manufacturer or supplier of the material, product, or equipment being submitted for approval.',
    `modified_by` STRING COMMENT 'Username or identifier of the person who last modified the submittal record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the submittal record was last modified. Audit trail for tracking changes and updates.',
    `remarks` STRING COMMENT 'Additional notes, observations, or context regarding the submittal that do not fit into other structured fields.',
    `required_on_site_date` DATE COMMENT 'Date by which the material or equipment must be approved and available on site to meet the construction schedule. Critical for procurement lead time planning.',
    `resubmission_date` DATE COMMENT 'Date when the revised submittal was resubmitted following initial review comments or rejection.',
    `resubmission_required` BOOLEAN COMMENT 'Flag indicating whether the submittal must be revised and resubmitted for further review based on reviewer comments or rejection.',
    `review_completion_date` DATE COMMENT 'Date when the review was completed and the submittal disposition was communicated back to the contractor.',
    `review_priority` STRING COMMENT 'Priority level assigned to the submittal review based on schedule criticality and impact on construction progress.. Valid values are `critical|high|normal|low`',
    `review_start_date` DATE COMMENT 'Date when the formal review process began. Used to track review duration and compliance with contractual review periods.',
    `review_status` STRING COMMENT 'Current status of the submittal in the review and approval workflow. Tracks progression from submission through final disposition. [ENUM-REF-CANDIDATE: submitted|under_review|approved|approved_with_comments|rejected|resubmit_required|withdrawn|superseded — 8 candidates stripped; promote to reference product]',
    `reviewer_comments` STRING COMMENT 'Detailed comments, notes, or instructions provided by the reviewer regarding the submittal. May include required corrections, clarifications, or conditions of approval.',
    `reviewer_name` STRING COMMENT 'Name of the engineer, consultant, or quality manager assigned to review and approve the submittal.',
    `reviewer_organization` STRING COMMENT 'Organization or company name of the reviewing party (e.g., design consultant, client representative, third-party inspector).',
    `revision_number` STRING COMMENT 'Revision identifier for the submittal (e.g., Rev 0, Rev A, Rev 1). Tracks iterations and resubmissions following review comments.',
    `schedule_impact_days` STRING COMMENT 'Number of days of schedule impact (delay or acceleration) resulting from the submittal review outcome or material approval.',
    `specification_section` STRING COMMENT 'Reference to the project specification section or clause that this submittal addresses (e.g., Section 03300 - Cast-in-Place Concrete).',
    `submission_date` DATE COMMENT 'Date when the submittal was formally submitted to the engineer, consultant, or client for review. Key milestone for tracking review turnaround times.',
    `submittal_description` STRING COMMENT 'Detailed description of the submittal content, scope, and purpose. Provides context for reviewers on what is being submitted and why.',
    `submittal_number` STRING COMMENT 'Unique business identifier for the submittal, typically following project-specific numbering conventions (e.g., S-001, SUB-MEP-2024-045).',
    `submittal_type` STRING COMMENT 'Category of submittal being submitted for review and approval. Defines the nature of the documentation or sample being provided. [ENUM-REF-CANDIDATE: material_sample|shop_drawing|method_statement|product_data_sheet|test_certificate|manufacturer_literature|design_mix|calculation|warranty_certificate — 9 candidates stripped; promote to reference product]',
    `title` STRING COMMENT 'Descriptive title of the submittal indicating the material, equipment, or work item being submitted (e.g., Structural Steel Shop Drawings, Concrete Mix Design).',
    `wbs_code` STRING COMMENT 'Work Breakdown Structure code identifying the project phase, area, or work package to which this submittal belongs.',
    `created_by` STRING COMMENT 'Username or identifier of the person who created the submittal record in the system.',
    CONSTRAINT pk_quality_submittal PRIMARY KEY(`quality_submittal_id`)
) COMMENT 'Quality submittal record tracking contractor submissions of material samples, shop drawings, method statements, and product data sheets for engineer/client review and approval prior to construction. Captures submittal number, submittal type, revision, submission date, review status (approved/approved-with-comments/rejected/resubmit), reviewer comments, and final disposition. Distinct from document transmittals — submittals are specifically QA/QC pre-construction approval records. [SSOT: distinct source of truth for quality domain]';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`ndt_record` (
    `ndt_record_id` BIGINT COMMENT 'Unique identifier for the NDT record. Primary key for the NDT record entity.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: NDT activities are performed with dedicated NDT equipment; linking to the asset enables traceability, calibration tracking, and cost allocation.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this NDT was performed.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: NDT reports must reference the drawing of the inspected component for traceability.',
    `itp_id` BIGINT COMMENT 'Reference to the ITP that governs this NDT activity.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: NDT records are associated with the WBS element inspected, enabling traceability of non‑destructive testing.',
    `acceptance_criteria` STRING COMMENT 'The acceptance criteria or standard against which the NDT results are evaluated (e.g., ASME Section VIII, AWS D1.1, project specification).',
    `acceptance_status` STRING COMMENT 'Final acceptance status of the tested component based on NDT results and acceptance criteria.. Valid values are `accepted|rejected|conditional|pending_review`',
    `calibration_due_date` DATE COMMENT 'The date by which the NDT equipment must be recalibrated to remain valid for testing.',
    `calibration_reference` STRING COMMENT 'Reference number or certificate number of the equipment calibration record, ensuring the equipment was within valid calibration at the time of testing.',
    `component_description` STRING COMMENT 'Description of the structural element, weld, or pressure system component being tested (e.g., pipe weld joint, structural beam, pressure vessel).',
    `component_identifier` STRING COMMENT 'Unique identifier or tag number of the component being tested, as per engineering drawings or asset register.',
    `contractor_name` STRING COMMENT 'Name of the contractor or subcontractor responsible for performing the NDT.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this NDT record was first created in the system.',
    `equipment_serial_number` STRING COMMENT 'Serial number of the NDT equipment used, for traceability and calibration verification.',
    `equipment_used` STRING COMMENT 'Description or model of the NDT equipment used (e.g., ultrasonic flaw detector, X-ray machine, magnetic yoke).',
    `indication_count` STRING COMMENT 'Number of indications or defects identified during the NDT.',
    `indication_findings` STRING COMMENT 'Detailed description of any indications, discontinuities, or defects found during the NDT (e.g., crack, porosity, lack of fusion, slag inclusion).',
    `indication_severity` STRING COMMENT 'Severity classification of the most significant indication found (minor, major, critical) based on acceptance criteria.. Valid values are `minor|major|critical`',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this NDT record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this NDT record was last modified or updated.',
    `ncr_number` STRING COMMENT 'Reference number of the NCR raised if the NDT result was a failure or conditional.',
    `ncr_raised` BOOLEAN COMMENT 'Indicates whether a Non-Conformance Report was raised as a result of this NDT (True/False).',
    `ndt_method` STRING COMMENT 'The NDT method used: RT (Radiographic Testing), UT (Ultrasonic Testing), MT (Magnetic Particle Testing), PT (Dye Penetrant Testing), VT (Visual Testing), ET (Eddy Current Testing), LT (Leak Testing). [ENUM-REF-CANDIDATE: RT|UT|MT|PT|VT|ET|LT — 7 candidates stripped; promote to reference product]',
    `remarks` STRING COMMENT 'Additional comments, observations, or notes related to the NDT test, findings, or conditions during testing.',
    `repair_required` BOOLEAN COMMENT 'Indicates whether repair or corrective action is required based on the NDT findings (True/False).',
    `retest_date` DATE COMMENT 'Scheduled or actual date for retesting the component after repair or corrective action.',
    `retest_required` BOOLEAN COMMENT 'Indicates whether a retest is required after repair or due to inconclusive results (True/False).',
    `specification_reference` STRING COMMENT 'Reference to the project specification, technical standard, or code that governs the NDT requirements (e.g., ASME Section VIII, AWS D1.1, project QA/QC plan).',
    `technician_certification_expiry_date` DATE COMMENT 'Expiry date of the NDT technicians certification, ensuring the technician was qualified at the time of testing.',
    `technician_certification_level` STRING COMMENT 'Certification level of the NDT technician as per ASNT SNT-TC-1A or PCN (Level I, Level II, Level III).. Valid values are `Level I|Level II|Level III`',
    `technician_certification_number` STRING COMMENT 'Unique certification number issued to the NDT technician by the certifying body (ASNT, PCN, or equivalent).',
    `technician_name` STRING COMMENT 'Full name of the NDT technician who performed the test.',
    `test_date` DATE COMMENT 'The date on which the NDT was performed.',
    `test_location` STRING COMMENT 'Physical location or grid reference where the NDT was conducted (e.g., site area, building zone, or GPS coordinates).',
    `test_number` STRING COMMENT 'Unique business identifier for the NDT test, typically assigned by the QA/QC team or testing contractor.',
    `test_procedure_reference` STRING COMMENT 'Reference number of the approved NDT procedure or work instruction followed during testing.',
    `test_procedure_version` STRING COMMENT 'Version number of the NDT procedure used, ensuring traceability to the correct revision.',
    `test_report_number` STRING COMMENT '',
    `test_report_reference` STRING COMMENT 'Reference number or document ID of the formal NDT test report issued by the testing contractor.',
    `test_result` STRING COMMENT 'Overall result of the NDT: pass (acceptable), fail (rejected), or conditional (requires further review or repair).. Valid values are `pass|fail|conditional`',
    `test_status` STRING COMMENT 'Current lifecycle status of the NDT test.. Valid values are `scheduled|in_progress|completed|cancelled`',
    `weld_number` STRING COMMENT 'Unique identifier for the weld joint being tested, if applicable. Used for traceability in welding quality control.',
    `witness_name` STRING COMMENT '',
    `witness_party` STRING COMMENT 'Name of the party who witnessed the NDT (e.g., client representative, consultant, third-party inspector).',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this NDT record.',
    CONSTRAINT pk_ndt_record PRIMARY KEY(`ndt_record_id`)
) COMMENT 'Non-Destructive Testing (NDT) record capturing the results of radiographic (RT), ultrasonic (UT), magnetic particle (MT), dye penetrant (PT), or visual (VT) testing performed on structural elements, welds, or pressure systems. Stores NDT method, equipment calibration reference, technician certification level (ASNT/PCN), test location, indication findings, acceptance criteria, and pass/fail result.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` (
    `concrete_pour_record_id` BIGINT COMMENT 'Unique identifier for the concrete pour record. Primary key for this quality assurance document.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Concrete pour records must capture the concrete pump (asset) used for each pour to allocate costs and meet regulatory equipment usage logs.',
    `carbon_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_emission. Business justification: Concrete pours are a major source of CO₂; associating each pour with a carbon emission record enables accurate scope‑1/2 emissions calculation.',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Concrete pour permits: each concrete pour requires a specific permit, tracking pour records to the associated permit.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project where this concrete pour occurred.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Concrete pour records reference structural drawings to confirm element locations.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Concrete pour records incur costs; associating with a cost code supports cost roll‑up for concrete works in financial statements.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Concrete pour logs require the responsible subcontractor to be identified for schedule and quality reporting.',
    `inspection_id` BIGINT COMMENT '',
    `itp_id` BIGINT COMMENT 'Reference to the ITP (Inspection and Test Plan) governing this concrete pour activity.',
    `ncr_id` BIGINT COMMENT 'Reference to the NCR (Non-Conformance Report) if one was raised for this pour.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Concrete pour records are scoped to the WBS element (e.g., slab) for schedule and quality tracking.',
    `acceptance_status` STRING COMMENT 'Final acceptance status of the concrete pour by the quality authority.. Valid values are `pending|accepted|conditionally_accepted|rejected`',
    `ambient_temperature_c` DECIMAL(18,2) COMMENT 'Ambient air temperature at the time of concrete placement, measured in degrees Celsius.',
    `approved_submittal_number` STRING COMMENT 'Reference number of the approved material submittal package for the concrete mix design.',
    `batch_plant_name` STRING COMMENT 'Name of the concrete batching plant that supplied the concrete for this pour.',
    `client_witness_name` STRING COMMENT 'Name of the client representative who witnessed the concrete pour, if applicable.',
    `concrete_grade` STRING COMMENT 'Specified concrete strength grade (e.g., C25, C30, C40) indicating the characteristic compressive strength.',
    `concrete_temperature_c` DECIMAL(18,2) COMMENT 'Temperature of the fresh concrete at the time of placement, measured in degrees Celsius.',
    `consultant_witness_name` STRING COMMENT 'Name of the consultant or third-party representative who witnessed the concrete pour, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this concrete pour record was first created in the system.',
    `cube_sample_ids` STRING COMMENT 'Comma-separated list of concrete cube sample identifiers taken from this pour for compressive strength testing.',
    `cube_samples_taken` STRING COMMENT '',
    `curing_duration_days` STRING COMMENT 'Planned or actual duration of the concrete curing period in days.',
    `curing_method` STRING COMMENT 'Method used for curing the concrete after placement (e.g., wet covering, curing compound, plastic sheeting, water ponding).. Valid values are `wet_covering|curing_compound|plastic_sheeting|water_ponding|steam_curing|membrane_curing`',
    `curing_start_date` DATE COMMENT 'Date when the concrete curing process began.',
    `cylinder_sample_ids` STRING COMMENT 'Comma-separated list of concrete cylinder sample identifiers taken from this pour for compressive strength testing.',
    `delivery_docket_numbers` STRING COMMENT 'Comma-separated list of delivery docket or ticket numbers for all concrete trucks that delivered to this pour.',
    `element_location` STRING COMMENT 'Specific location description of the structural element within the project (e.g., grid reference, building zone).',
    `element_reference` STRING COMMENT '',
    `element_type` STRING COMMENT 'Type of structural element being poured (e.g., foundation, slab, column, beam, wall). [ENUM-REF-CANDIDATE: foundation|slab|column|beam|wall|deck|footing|pile_cap|shear_wall|retaining_wall — 10 candidates stripped; promote to reference product]',
    `grid_reference` STRING COMMENT 'Grid coordinate reference identifying the exact location of the pour within the construction drawings.',
    `inspector_name` STRING COMMENT 'Name of the quality inspector who witnessed and documented the concrete pour.',
    `inspector_signature_date` DATE COMMENT 'Date when the inspector signed off on the concrete pour record.',
    `concrete_pour_record_level` STRING COMMENT 'Building level or elevation where the concrete pour occurred (e.g., basement, ground floor, level 3).',
    `location_description` STRING COMMENT '',
    `mix_design_reference` STRING COMMENT 'Reference code or identifier for the approved concrete mix design specification used for this pour.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this concrete pour record was last modified.',
    `ncr_raised` BOOLEAN COMMENT 'Indicates whether a Non-Conformance Report (NCR) was raised for this concrete pour (True/False).',
    `number_of_samples_taken` STRING COMMENT 'Total number of concrete test samples (cubes or cylinders) taken from this pour.',
    `number_of_trucks` STRING COMMENT 'Total number of concrete delivery trucks used for this pour.',
    `pour_date` DATE COMMENT 'The date on which the concrete pour was executed.',
    `pour_end_time` TIMESTAMP COMMENT 'Timestamp when the concrete placement was completed.',
    `pour_number` STRING COMMENT 'Unique business identifier for this concrete pour event, typically assigned sequentially within the project.',
    `pour_start_time` TIMESTAMP COMMENT 'Timestamp when the concrete placement began.',
    `pour_status` STRING COMMENT 'Current lifecycle status of the concrete pour activity. [ENUM-REF-CANDIDATE: planned|approved|in_progress|completed|curing|tested|accepted|rejected — 8 candidates stripped; promote to reference product]',
    `pour_volume_m3` DECIMAL(18,2) COMMENT '',
    `remarks` STRING COMMENT 'Additional comments, observations, or notes related to the concrete pour event.',
    `slump_mm` DECIMAL(18,2) COMMENT '',
    `slump_specification_mm` STRING COMMENT 'Specified acceptable slump range for this concrete mix (e.g., 75-100mm).',
    `slump_test_passed` BOOLEAN COMMENT 'Indicates whether the slump test result met the specification requirements (True/False).',
    `slump_test_result_mm` STRING COMMENT 'Measured slump value in millimeters from the concrete workability test performed on site.',
    `slump_value_mm` DECIMAL(18,2) COMMENT '',
    `supplier_name` STRING COMMENT 'Name of the concrete supplier company providing the ready-mix concrete.',
    `total_pour_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of concrete placed during this pour event, measured in cubic meters.',
    `volume_poured_m3` DECIMAL(18,2) COMMENT '',
    `weather_conditions` STRING COMMENT 'Description of weather conditions during the pour (e.g., sunny, cloudy, rainy, windy).',
    CONSTRAINT pk_concrete_pour_record PRIMARY KEY(`concrete_pour_record_id`)
) COMMENT 'Concrete pour record capturing the quality data for each concrete placement event. Stores pour date, pour location (element type, grid, level), mix design reference, approved submittal number, batch plant, delivery docket numbers, slump test results, cube/cylinder sample IDs, pour volume, ambient temperature, curing method, and inspector sign-off. Critical QA evidence for structural concrete compliance.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`lab_test` (
    `lab_test_id` BIGINT COMMENT 'Unique identifier for the laboratory test record. Primary key for the lab_test product.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this material sample was tested.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Lab tests on materials are tied to the drawing that defines the element where material is used.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Lab test services are charged to cost codes; linking enables proper expense allocation in the lab cost ledger.',
    `itp_id` BIGINT COMMENT 'Foreign key linking to quality.itp. Business justification: Lab tests are performed against ITP items; linking provides context.',
    `laboratory_id` BIGINT COMMENT '',
    `ncr_id` BIGINT COMMENT 'Reference to the Non-Conformance Report raised if this test result failed to meet acceptance criteria.',
    `original_test_lab_test_id` BIGINT COMMENT 'Reference to the original lab_test_id if this record represents a retest. Null for initial tests.',
    `sample_id` BIGINT COMMENT 'Unique identifier assigned to the material sample submitted for testing. Typically follows project-specific or laboratory numbering conventions.',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Lab test results are evaluated against the technical specification they verify.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Lab tests on samples are linked to the WBS element where the material is used for quality assurance.',
    `acceptance_criteria` STRING COMMENT '',
    `accreditation_body` STRING COMMENT 'Name of the national or international accreditation body that issued the laboratory accreditation, such as UKAS, A2LA, NATA, or equivalent.',
    `batch_number` STRING COMMENT 'Manufacturer or supplier batch number or lot number for the material, enabling traceability to production records.',
    `cost_code` STRING COMMENT 'Cost code or account code for charging the laboratory testing costs to the appropriate project budget line.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this laboratory test record was first created in the system.',
    `delivery_ticket_number` STRING COMMENT 'Delivery docket or ticket number associated with the material delivery from which the sample was taken.',
    `lab_test_number` STRING COMMENT '',
    `laboratory_accreditation_number` STRING COMMENT 'Accreditation certificate number or registration number issued by the national accreditation body (e.g., UKAS, A2LA, NATA) confirming the laboratory meets ISO/IEC 17025 standards.',
    `material_description` STRING COMMENT 'Detailed description of the material sample including grade, mix design reference, supplier, or other identifying characteristics.',
    `material_type` STRING COMMENT 'Type of construction material being tested. Determines applicable test standards and acceptance criteria. [ENUM-REF-CANDIDATE: concrete|soil|asphalt|aggregate|steel|rebar|weld|grout|mortar|other — 10 candidates stripped; promote to reference product]',
    `measured_result` DECIMAL(18,2) COMMENT 'Numerical value of the test result as measured by the laboratory.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this laboratory test record was last modified or updated.',
    `pass_fail_status` STRING COMMENT '',
    `remarks` STRING COMMENT 'Additional comments, observations, or notes regarding the test, sample condition, deviations, or special circumstances.',
    `report_issue_date` DATE COMMENT '',
    `report_number` STRING COMMENT '',
    `result_unit` STRING COMMENT 'Unit of measure for the test result, such as MPa, psi, kg/m3, percent, mm, or other applicable units.',
    `result_value` DECIMAL(18,2) COMMENT '',
    `retest_flag` BOOLEAN COMMENT 'Indicates whether this test is a retest following a previous failure or non-conformance.',
    `reviewed_by` STRING COMMENT 'Name or identifier of the laboratory supervisor or authorized signatory who reviewed and approved the test results.',
    `sampled_by` STRING COMMENT 'Name or identifier of the person or organization responsible for collecting the sample.',
    `sampling_date` DATE COMMENT 'Date when the material sample was collected from the construction site or delivery location.',
    `sampling_location` STRING COMMENT 'Physical location or grid reference where the sample was collected, including building, floor, zone, or chainage reference.',
    `specification_requirement` DECIMAL(18,2) COMMENT 'Required or target value per project specifications or applicable standards against which the test result is evaluated.',
    `supplier_name` STRING COMMENT 'Name of the material supplier or manufacturer who provided the tested material.',
    `technician_name` STRING COMMENT '',
    `test_age_days` STRING COMMENT 'Age of the sample at the time of testing, measured in days from sampling date. Critical for concrete cube/cylinder tests (typically 7, 28, or 56 days).',
    `test_certificate_number` STRING COMMENT 'Unique certificate number issued by the laboratory for the test report, used for verification and traceability.',
    `test_date` DATE COMMENT 'Date when the laboratory test was performed.',
    `test_method` STRING COMMENT 'Specific test method or procedure code applied, such as ASTM C39 for concrete compressive strength or ASTM D1557 for soil compaction.',
    `test_number` STRING COMMENT 'Laboratory-assigned test number or report reference number for tracking and retrieval of test documentation.',
    `test_parameter` STRING COMMENT 'The specific property or characteristic being measured, such as compressive strength, slump, moisture content, or gradation.',
    `test_parameters` STRING COMMENT '',
    `test_report_reference` STRING COMMENT 'Document reference or file path to the full laboratory test report or certificate.',
    `test_result_status` STRING COMMENT 'Pass/fail determination based on comparison of measured result against specification requirements and tolerances.. Valid values are `pass|fail|conditional|retest_required|pending`',
    `test_result_value` DECIMAL(18,2) COMMENT '',
    `test_standard` STRING COMMENT 'Industry or international standard governing the test procedure, such as ASTM, BS, EN, AASHTO, or ISO standards.',
    `test_status` STRING COMMENT '',
    `test_type` STRING COMMENT '',
    `tested_by` STRING COMMENT 'Name or identifier of the laboratory technician or engineer who performed the test.',
    `tolerance_lower_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable value for the test parameter. Results below this threshold constitute a failure.',
    `tolerance_upper_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable value for the test parameter. Results above this threshold may constitute a failure depending on the parameter.',
    `unit_of_measure` STRING COMMENT '',
    `wbs_code` STRING COMMENT 'Work Breakdown Structure code identifying the project phase, activity, or work package to which this test relates.',
    `witness_name` STRING COMMENT 'Name of the client, consultant, or third-party representative who witnessed the test, if applicable.',
    `witness_party` STRING COMMENT '',
    `witness_required` BOOLEAN COMMENT 'Indicates whether client, consultant, or third-party witness was required to be present during testing per contract or ITP requirements.',
    CONSTRAINT pk_lab_test PRIMARY KEY(`lab_test_id`)
) COMMENT 'Laboratory test record for construction material samples submitted to an accredited testing laboratory. Captures sample ID, material type, sampling date and location, test standard (ASTM, BS, EN, AASHTO), test parameters, measured results, pass/fail determination, laboratory accreditation number, and report reference. Covers concrete cube/cylinder tests, soil compaction, asphalt core tests, and aggregate grading.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`sample` (
    `sample_id` BIGINT COMMENT 'Primary key for sample',
    `concrete_pour_record_id` BIGINT COMMENT '',
    `construction_project_id` BIGINT COMMENT '',
    `itp_id` BIGINT COMMENT '',
    `laboratory_id` BIGINT COMMENT 'Identifier of the testing laboratory.',
    `material_catalog_id` BIGINT COMMENT '',
    `parent_sample_id` BIGINT COMMENT 'Self-referencing FK on sample (parent_sample_id)',
    `sample_laboratory_id` BIGINT COMMENT '',
    `site_location_id` BIGINT COMMENT 'Identifier of the site or area where the sample originated.',
    `wbs_element_id` BIGINT COMMENT '',
    `approval_date` DATE COMMENT 'Calendar date of approval.',
    `approved_by` STRING COMMENT 'Individual who signed off on the test result.',
    `batch_lot_number` STRING COMMENT '',
    `batch_number` STRING COMMENT 'Group identifier for samples collected or processed together.',
    `chain_of_custody_reference` STRING COMMENT '',
    `sample_code` STRING COMMENT 'Business identifier assigned to the sample, following the company coding convention.',
    `collected_by` STRING COMMENT 'Person responsible for obtaining the sample.',
    `collection_date` DATE COMMENT 'The calendar date on which the sample was taken.',
    `collection_location` STRING COMMENT '',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard governing the test.',
    `condition` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time the sample record was first entered into the system.',
    `disposal_date` DATE COMMENT 'When the sample was removed from inventory.',
    `disposition` STRING COMMENT '',
    `expiration_date` DATE COMMENT 'When the sample expires for compliance or quality purposes.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Percentage humidity recorded during testing.',
    `is_critical` BOOLEAN COMMENT 'True if the sample is designated as critical for safety or regulatory compliance.',
    `location` STRING COMMENT '',
    `material` STRING COMMENT 'Primary material that the sample consists of.',
    `material_description` STRING COMMENT '',
    `modified_timestamp` TIMESTAMP COMMENT '',
    `sample_name` STRING COMMENT 'Descriptive name given to the sample for easy identification.',
    `notes` STRING COMMENT 'Additional comments, observations, or remarks about the sample.',
    `quality_status` STRING COMMENT 'Result of the quality assessment for the sample.',
    `quantity` DECIMAL(18,2) COMMENT '',
    `remarks` STRING COMMENT '',
    `sample_number` STRING COMMENT '',
    `sample_status` STRING COMMENT 'Indicates where the sample is in its testing or handling workflow.',
    `sample_type` STRING COMMENT 'Category indicating the kind of material or component the sample represents.',
    `sampling_date` DATE COMMENT '',
    `sampling_location` STRING COMMENT '',
    `sampling_method` STRING COMMENT '',
    `storage_condition` STRING COMMENT '',
    `storage_location` STRING COMMENT 'Designated area where the sample is kept after collection.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Temperature in degrees Celsius recorded during testing.',
    `test_date` TIMESTAMP COMMENT 'Exact date and time the test was executed.',
    `test_method` STRING COMMENT 'Standardized test procedure used to evaluate the sample.',
    `test_result_unit` STRING COMMENT 'Unit associated with the test result value.',
    `test_result_value` DECIMAL(18,2) COMMENT 'Measured value produced by the test (e.g., strength, concentration).',
    `unit_of_measure` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the sample record.',
    `volume_l` DECIMAL(18,2) COMMENT 'Measured volume of the sample in liters.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Mass of the sample measured in kilograms.',
    `witness_party` STRING COMMENT '',
    CONSTRAINT pk_sample PRIMARY KEY(`sample_id`)
) COMMENT 'Master reference table for sample. Referenced by sample_id.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`laboratory` (
    `laboratory_id` BIGINT COMMENT 'Primary key for laboratory',
    `construction_project_id` BIGINT COMMENT '',
    `parent_laboratory_id` BIGINT COMMENT 'Self-referencing FK on laboratory (parent_laboratory_id)',
    `vendor_id` BIGINT COMMENT '',
    `accreditation_body` STRING COMMENT 'Organization that granted accreditation to the laboratory.',
    `accreditation_expiry_date` DATE COMMENT 'Expiration date of the current accreditation.',
    `accreditation_number` STRING COMMENT 'Unique identifier of the laboratorys accreditation certificate.',
    `accreditation_standard` STRING COMMENT '',
    `accreditation_status` STRING COMMENT '',
    `address` STRING COMMENT '',
    `address_line` STRING COMMENT '',
    `address_line1` STRING COMMENT 'Primary street address of the laboratory site.',
    `address_line2` STRING COMMENT 'Secondary address information for the laboratory site.',
    `approval_date` DATE COMMENT '',
    `capacity_tests_per_day` STRING COMMENT 'Operational capacity expressed as number of tests per calendar day.',
    `certification_details` STRING COMMENT 'Textual details of certifications held by the laboratory.',
    `city` STRING COMMENT 'Municipality of the laboratory location.',
    `closing_date` DATE COMMENT 'Date the laboratory ceased operations, if applicable.',
    `laboratory_code` STRING COMMENT 'Business identifier assigned to the laboratory by the organization.',
    `contact_email` STRING COMMENT '',
    `contact_name` STRING COMMENT '',
    `contact_person` STRING COMMENT '',
    `contact_phone` STRING COMMENT '',
    `country_code` STRING COMMENT 'Three‑letter country identifier for the laboratory location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the laboratory record was first inserted.',
    `data_sharing_agreement` BOOLEAN COMMENT 'Indicates if the laboratory has signed agreements to share test data with external parties.',
    `laboratory_description` STRING COMMENT 'Narrative description providing additional context about the laboratory.',
    `email_address` STRING COMMENT 'Email address used for laboratory communications.',
    `equipment_summary` STRING COMMENT 'Brief description of key testing equipment available at the laboratory.',
    `hazardous_materials_allowed` BOOLEAN COMMENT 'True if the laboratory is permitted to test hazardous substances.',
    `is_approved` BOOLEAN COMMENT '',
    `is_certified` BOOLEAN COMMENT 'True if the laboratory is currently certified under the relevant standard.',
    `is_external` BOOLEAN COMMENT '',
    `is_internal` BOOLEAN COMMENT '',
    `lab_area_sqm` DECIMAL(18,2) COMMENT 'Total usable floor area of the laboratory.',
    `laboratory_status` STRING COMMENT 'Lifecycle status indicating whether the laboratory is operational.',
    `laboratory_type` STRING COMMENT 'Classification of the laboratory based on primary testing capabilities.',
    `last_inspection_date` DATE COMMENT 'When the laboratory was last inspected for compliance.',
    `latitude` DOUBLE COMMENT 'Latitude coordinate of the laboratory site.',
    `longitude` DOUBLE COMMENT 'Longitude coordinate of the laboratory site.',
    `manager_name` STRING COMMENT 'Full name of the person responsible for the laboratory.',
    `max_sample_weight_kg` DECIMAL(18,2) COMMENT 'Upper limit for individual sample weight accepted for testing.',
    `modified_timestamp` TIMESTAMP COMMENT '',
    `laboratory_name` STRING COMMENT 'Descriptive name of the laboratory used in reports and UI.',
    `next_inspection_due` DATE COMMENT 'Planned date for the upcoming compliance inspection.',
    `opening_date` DATE COMMENT 'First day the laboratory became operational.',
    `operating_hours` STRING COMMENT 'Typical daily operating window for the laboratory.',
    `phone_number` STRING COMMENT 'Main telephone number for reaching the laboratory.',
    `postal_code` STRING COMMENT 'Postal code for the laboratory address.',
    `quality_management_system` STRING COMMENT 'Standard or framework governing quality processes at the laboratory.',
    `region` STRING COMMENT 'Broad region used for reporting and analytics.',
    `remarks` STRING COMMENT '',
    `safety_rating` STRING COMMENT 'Overall safety performance grade for the laboratory.',
    `sample_storage_temperature_c` DECIMAL(18,2) COMMENT 'Typical temperature at which samples are stored before analysis.',
    `scope_of_testing` STRING COMMENT '',
    `state_province` STRING COMMENT 'Administrative region of the laboratory.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the laboratory record.',
    `waste_disposal_method` STRING COMMENT 'Primary approach for handling hazardous and non‑hazardous waste.',
    CONSTRAINT pk_laboratory PRIMARY KEY(`laboratory_id`)
) COMMENT 'Master reference table for laboratory. Referenced by lab_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `vibe_construction_v1`.`quality`.`checklist`(`checklist_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_itp_line_id` FOREIGN KEY (`itp_line_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp_line`(`itp_line_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `vibe_construction_v1`.`quality`.`checklist`(`checklist_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `vibe_construction_v1`.`quality`.`sample`(`sample_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ADD CONSTRAINT `fk_quality_weld_record_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ADD CONSTRAINT `fk_quality_acceptance_test_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ADD CONSTRAINT `fk_quality_acceptance_test_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `vibe_construction_v1`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_punch_list_id` FOREIGN KEY (`punch_list_id`) REFERENCES `vibe_construction_v1`.`quality`.`punch_list`(`punch_list_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_quality_plan_id` FOREIGN KEY (`quality_plan_id`) REFERENCES `vibe_construction_v1`.`quality`.`quality_plan`(`quality_plan_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ADD CONSTRAINT `fk_quality_quality_submittal_quality_plan_id` FOREIGN KEY (`quality_plan_id`) REFERENCES `vibe_construction_v1`.`quality`.`quality_plan`(`quality_plan_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ADD CONSTRAINT `fk_quality_ndt_record_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `vibe_construction_v1`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `vibe_construction_v1`.`quality`.`laboratory`(`laboratory_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_original_test_lab_test_id` FOREIGN KEY (`original_test_lab_test_id`) REFERENCES `vibe_construction_v1`.`quality`.`lab_test`(`lab_test_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `vibe_construction_v1`.`quality`.`sample`(`sample_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_concrete_pour_record_id` FOREIGN KEY (`concrete_pour_record_id`) REFERENCES `vibe_construction_v1`.`quality`.`concrete_pour_record`(`concrete_pour_record_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `vibe_construction_v1`.`quality`.`laboratory`(`laboratory_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_parent_sample_id` FOREIGN KEY (`parent_sample_id`) REFERENCES `vibe_construction_v1`.`quality`.`sample`(`sample_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_sample_laboratory_id` FOREIGN KEY (`sample_laboratory_id`) REFERENCES `vibe_construction_v1`.`quality`.`laboratory`(`laboratory_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ADD CONSTRAINT `fk_quality_laboratory_parent_laboratory_id` FOREIGN KEY (`parent_laboratory_id`) REFERENCES `vibe_construction_v1`.`quality`.`laboratory`(`laboratory_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`quality` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_construction_v1`.`quality` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` SET TAGS ('pii_subdomain' = 'inspection_planning');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` SET TAGS ('pii_ssot_view' = 'mvm_quality_itp_ssot');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` SET TAGS ('pii_mvm_ssot_owner' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `itp_id` SET TAGS ('pii_business_glossary_term' = 'Inspection and Test Plan (ITP) ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Contractor Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `permit_to_work_id` SET TAGS ('pii_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Qc Inspector Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `subcontract_id` SET TAGS ('pii_business_glossary_term' = 'Subcontract Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `technical_specification_id` SET TAGS ('pii_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `acceptance_criteria` SET TAGS ('pii_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `applicable_standards` SET TAGS ('pii_business_glossary_term' = 'Applicable Quality Standards');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'ITP Approval Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Inspection and Test Plan (ITP) Approval Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'ITP Approved By');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `client_inspector_responsible_party` SET TAGS ('pii_business_glossary_term' = 'Client Inspector Responsible Party');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `defect_liability_period_days` SET TAGS ('pii_business_glossary_term' = 'Defects Liability Period (DLP) Days');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `document_storage_location` SET TAGS ('pii_business_glossary_term' = 'Document Storage Location');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'ITP Effective Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'ITP Expiry Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `fat_required` SET TAGS ('pii_business_glossary_term' = 'Factory Acceptance Test (FAT) Required Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `hold_point_required` SET TAGS ('pii_business_glossary_term' = 'Hold Point Required Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `inspection_frequency` SET TAGS ('pii_business_glossary_term' = 'Inspection Frequency');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `inspection_scope` SET TAGS ('pii_business_glossary_term' = 'Inspection Scope');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `itp_number` SET TAGS ('pii_business_glossary_term' = 'Inspection and Test Plan (ITP) Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `itp_number` SET TAGS ('pii_value_regex' = '^ITP-[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `material_test_certificate_required` SET TAGS ('pii_business_glossary_term' = 'Material Test Certificate (MTC) Required Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `ndt_method_required` SET TAGS ('pii_business_glossary_term' = 'Non-Destructive Testing (NDT) Method Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `prepared_by` SET TAGS ('pii_business_glossary_term' = 'ITP Prepared By');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `qc_inspector_responsible_party` SET TAGS ('pii_business_glossary_term' = 'Quality Control (QC) Inspector Responsible Party');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'ITP Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `review_point_required` SET TAGS ('pii_business_glossary_term' = 'Review Point Required Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `reviewed_by` SET TAGS ('pii_business_glossary_term' = 'ITP Reviewed By');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `revision_date` SET TAGS ('pii_business_glossary_term' = 'Document Revision Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Document Revision Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `revision_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{1,3}$');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `sat_required` SET TAGS ('pii_business_glossary_term' = 'Site Acceptance Test (SAT) Required Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `test_method_reference` SET TAGS ('pii_business_glossary_term' = 'Test Method Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Inspection and Test Plan (ITP) Title');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `wbs_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,6}(.[A-Z0-9]{2,6}){0,5}$');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `witness_point_required` SET TAGS ('pii_business_glossary_term' = 'Witness Point Required Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `work_package_description` SET TAGS ('pii_business_glossary_term' = 'Work Package Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` SET TAGS ('pii_subdomain' = 'inspection_planning');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` SET TAGS ('pii_mvm_ssot_owner' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `itp_line_id` SET TAGS ('pii_business_glossary_term' = 'Inspection and Test Plan (ITP) Line ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Contractor Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `itp_id` SET TAGS ('pii_business_glossary_term' = 'Inspection and Test Plan (ITP) ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `crew_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `acceptance_criteria` SET TAGS ('pii_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `activity_description` SET TAGS ('pii_business_glossary_term' = 'Activity Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `applicable_standard` SET TAGS ('pii_business_glossary_term' = 'Applicable Standard');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `approved_date` SET TAGS ('pii_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `calibration_required` SET TAGS ('pii_business_glossary_term' = 'Calibration Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `client_witness_required` SET TAGS ('pii_business_glossary_term' = 'Client Witness Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `consultant_witness_required` SET TAGS ('pii_business_glossary_term' = 'Consultant Witness Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `cost_code` SET TAGS ('pii_business_glossary_term' = 'Cost Code');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `critical_path_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `environmental_conditions` SET TAGS ('pii_business_glossary_term' = 'Environmental Conditions');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `estimated_duration_hours` SET TAGS ('pii_business_glossary_term' = 'Estimated Duration Hours');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `hold_point_type` SET TAGS ('pii_business_glossary_term' = 'Hold Point Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `hold_point_type` SET TAGS ('pii_value_regex' = 'hold|witness|review|surveillance');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `inspection_frequency` SET TAGS ('pii_business_glossary_term' = 'Inspection Frequency');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `inspection_method` SET TAGS ('pii_business_glossary_term' = 'Inspection Method');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `inspection_stage` SET TAGS ('pii_business_glossary_term' = 'Inspection Stage');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `itp_line_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `itp_line_status` SET TAGS ('pii_value_regex' = 'planned|ready|in_progress|completed|waived|cancelled');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `mandatory_flag` SET TAGS ('pii_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `ncr_trigger_criteria` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Trigger Criteria');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `notification_lead_time_hours` SET TAGS ('pii_business_glossary_term' = 'Notification Lead Time Hours');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `reference_document` SET TAGS ('pii_business_glossary_term' = 'Reference Document');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `required_documentation` SET TAGS ('pii_business_glossary_term' = 'Required Documentation');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `responsible_discipline` SET TAGS ('pii_business_glossary_term' = 'Responsible Discipline');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `safety_requirements` SET TAGS ('pii_business_glossary_term' = 'Safety Requirements');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `sampling_plan` SET TAGS ('pii_business_glossary_term' = 'Sampling Plan');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `sequence_dependency` SET TAGS ('pii_business_glossary_term' = 'Sequence Dependency');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `superseded_date` SET TAGS ('pii_business_glossary_term' = 'Superseded Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `test_equipment_required` SET TAGS ('pii_business_glossary_term' = 'Test Equipment Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `third_party_witness_required` SET TAGS ('pii_business_glossary_term' = 'Third Party Witness Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` SET TAGS ('pii_subdomain' = 'field_verification');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` SET TAGS ('pii_ssot_view' = 'mvm_quality_inspection_ssot');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` SET TAGS ('pii_mvm_ssot_owner' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `inspection_id` SET TAGS ('pii_business_glossary_term' = 'Inspection ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `checklist_id` SET TAGS ('pii_business_glossary_term' = 'Checklist Template ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `contact_id` SET TAGS ('pii_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Inspector Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `crew_id` SET TAGS ('pii_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `drawing_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Witness Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `goods_receipt_id` SET TAGS ('pii_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `incident_id` SET TAGS ('pii_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `itp_line_id` SET TAGS ('pii_business_glossary_term' = 'Itp Line Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `attachment_count` SET TAGS ('pii_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `checklist_template_name` SET TAGS ('pii_business_glossary_term' = 'Checklist Template Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `checklist_version` SET TAGS ('pii_business_glossary_term' = 'Checklist Version');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `corrective_action_required` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `defects_identified` SET TAGS ('pii_business_glossary_term' = 'Defects Identified');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `end_time` SET TAGS ('pii_business_glossary_term' = 'Inspection End Time');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `humidity_percent` SET TAGS ('pii_business_glossary_term' = 'Humidity Percentage');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `inspection_date` SET TAGS ('pii_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `inspection_number` SET TAGS ('pii_business_glossary_term' = 'Inspection Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `inspection_status` SET TAGS ('pii_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `inspection_type` SET TAGS ('pii_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `inspector_certification` SET TAGS ('pii_business_glossary_term' = 'Inspector Certification');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `inspector_signature_captured` SET TAGS ('pii_business_glossary_term' = 'Inspector Signature Captured Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `items_failed` SET TAGS ('pii_business_glossary_term' = 'Items Failed');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `items_not_applicable` SET TAGS ('pii_business_glossary_term' = 'Items Not Applicable');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `items_passed` SET TAGS ('pii_business_glossary_term' = 'Items Passed');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `location_description` SET TAGS ('pii_business_glossary_term' = 'Inspection Location Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `location_type` SET TAGS ('pii_business_glossary_term' = 'Inspection Location Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `location_type` SET TAGS ('pii_value_regex' = 'site|factory|workshop|laboratory|warehouse|offsite');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `ncr_raised` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Raised Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `ncr_reference` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `observations` SET TAGS ('pii_business_glossary_term' = 'Inspection Observations');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `overall_outcome` SET TAGS ('pii_business_glossary_term' = 'Overall Inspection Outcome');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `overall_outcome` SET TAGS ('pii_value_regex' = 'pass|fail|conditional_pass');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `photo_count` SET TAGS ('pii_business_glossary_term' = 'Photo Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `reinspection_date` SET TAGS ('pii_business_glossary_term' = 'Reinspection Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `reinspection_required` SET TAGS ('pii_business_glossary_term' = 'Reinspection Required Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `specification_reference` SET TAGS ('pii_business_glossary_term' = 'Specification Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `start_time` SET TAGS ('pii_business_glossary_term' = 'Inspection Start Time');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `temperature_celsius` SET TAGS ('pii_business_glossary_term' = 'Temperature in Celsius');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `total_check_items` SET TAGS ('pii_business_glossary_term' = 'Total Check Items');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `weather_conditions` SET TAGS ('pii_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `witness_signature_captured` SET TAGS ('pii_business_glossary_term' = 'Witness Signature Captured Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `work_package_reference` SET TAGS ('pii_business_glossary_term' = 'Work Package Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` SET TAGS ('pii_subdomain' = 'field_verification');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` SET TAGS ('pii_ssot_view' = 'mvm_quality_ncr_ssot');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` SET TAGS ('pii_mvm_ssot_owner' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `ncr_id` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `drawing_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `incident_id` SET TAGS ('pii_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `permit_condition_id` SET TAGS ('pii_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `technical_specification_id` SET TAGS ('pii_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Package ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `ncr_category` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Category');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `ncr_category` SET TAGS ('pii_value_regex' = 'material|workmanship|design|documentation|dimensional|procedural');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `client_notification_date` SET TAGS ('pii_business_glossary_term' = 'Client Notification Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `client_notification_required` SET TAGS ('pii_business_glossary_term' = 'Client Notification Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `closed_by` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Closed By');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `closure_date` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Closure Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `corrective_action_description` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `corrective_action_responsible_party` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Responsible Party');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `corrective_action_target_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Target Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `cost_impact_currency` SET TAGS ('pii_business_glossary_term' = 'Cost Impact Currency');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `cost_impact_currency` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `ncr_description` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `disposition` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Disposition');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `disposition` SET TAGS ('pii_value_regex' = 'accept_as_is|rework|repair|reject|scrap|use_as_is_with_concession');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `disposition_approved_by` SET TAGS ('pii_business_glossary_term' = 'Disposition Approved By');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `disposition_approved_date` SET TAGS ('pii_business_glossary_term' = 'Disposition Approved Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `disposition_justification` SET TAGS ('pii_business_glossary_term' = 'Disposition Justification');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `effectiveness_review_comments` SET TAGS ('pii_business_glossary_term' = 'Effectiveness Review Comments');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `estimated_cost_impact` SET TAGS ('pii_business_glossary_term' = 'Estimated Cost Impact');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `estimated_cost_impact` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `hold_release_date` SET TAGS ('pii_business_glossary_term' = 'Hold Release Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `hold_status` SET TAGS ('pii_business_glossary_term' = 'Hold Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `identified_date` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Identified Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `location_description` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Location Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `ncr_number` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `ncr_number` SET TAGS ('pii_value_regex' = '^NCR-[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `ncr_status` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `preventive_action_description` SET TAGS ('pii_business_glossary_term' = 'Preventive Action Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `preventive_action_responsible_party` SET TAGS ('pii_business_glossary_term' = 'Preventive Action Responsible Party');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `quantity_affected` SET TAGS ('pii_business_glossary_term' = 'Quantity Affected');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `reported_by` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Reported By');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `reported_by_organization` SET TAGS ('pii_business_glossary_term' = 'Reported By Organization');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `root_cause_analysis` SET TAGS ('pii_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `schedule_impact_days` SET TAGS ('pii_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `severity` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Severity');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `severity` SET TAGS ('pii_value_regex' = 'critical|major|minor');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `verification_method` SET TAGS ('pii_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `verification_performed_by` SET TAGS ('pii_business_glossary_term' = 'Verification Performed By');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `verification_result` SET TAGS ('pii_business_glossary_term' = 'Verification Result');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `verification_result` SET TAGS ('pii_value_regex' = 'passed|failed|conditional');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` SET TAGS ('pii_subdomain' = 'field_verification');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` SET TAGS ('pii_ssot_view' = 'mvm_quality_corrective_action_ssot');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` SET TAGS ('pii_mvm_ssot_owner' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `corrective_action_id` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Identifier');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `project_change_order_id` SET TAGS ('pii_business_glossary_term' = 'Linked Change Order (CO) ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `rfi_id` SET TAGS ('pii_business_glossary_term' = 'Linked Request for Information (RFI) ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `ncr_id` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `tertiary_corrective_created_by_employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `tertiary_corrective_created_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `tertiary_corrective_created_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `action_description` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `action_number` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `action_status` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `action_status` SET TAGS ('pii_value_regex' = 'open|in_progress|pending_verification|verified|closed|cancelled');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('pii_business_glossary_term' = 'Corrective Action / Preventive Action (CAPA) Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('pii_value_regex' = 'corrective|preventive|containment|interim');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `actual_completion_date` SET TAGS ('pii_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `actual_cost` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Actual Cost');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `assigned_date` SET TAGS ('pii_business_glossary_term' = 'Action Assigned Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `client_approval_date` SET TAGS ('pii_business_glossary_term' = 'Client Approval Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `cost_estimate` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Cost Estimate');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `effectiveness_review_comments` SET TAGS ('pii_business_glossary_term' = 'Effectiveness Review Comments');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `effectiveness_review_date` SET TAGS ('pii_business_glossary_term' = 'Effectiveness Review Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `effectiveness_review_outcome` SET TAGS ('pii_business_glossary_term' = 'Effectiveness Review Outcome');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `effectiveness_review_outcome` SET TAGS ('pii_value_regex' = 'effective|partially_effective|ineffective|pending_review');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `is_systemic_issue` SET TAGS ('pii_business_glossary_term' = 'Systemic Issue Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `lessons_learned` SET TAGS ('pii_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Priority');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `recurrence_prevention_measures` SET TAGS ('pii_business_glossary_term' = 'Recurrence Prevention Measures');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `requires_client_approval` SET TAGS ('pii_business_glossary_term' = 'Requires Client Approval Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `requires_design_change` SET TAGS ('pii_business_glossary_term' = 'Requires Design Change Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `root_cause_analysis` SET TAGS ('pii_business_glossary_term' = 'Root Cause Analysis (RCA)');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `schedule_impact_days` SET TAGS ('pii_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `target_completion_date` SET TAGS ('pii_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('pii_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('pii_value_regex' = 'inspection|testing|document_review|audit|site_observation|measurement');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `verified_by_name` SET TAGS ('pii_business_glossary_term' = 'Verified By Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` SET TAGS ('pii_subdomain' = 'inspection_planning');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` SET TAGS ('pii_mvm_ssot_owner' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `checklist_id` SET TAGS ('pii_business_glossary_term' = 'Checklist ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `permit_condition_id` SET TAGS ('pii_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `acceptance_criteria` SET TAGS ('pii_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `activity_type` SET TAGS ('pii_business_glossary_term' = 'Activity Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `applicable_standard` SET TAGS ('pii_business_glossary_term' = 'Applicable Standard');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'draft|under_review|approved|superseded|obsolete');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `approved_date` SET TAGS ('pii_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `average_pass_rate` SET TAGS ('pii_business_glossary_term' = 'Average Pass Rate (Percentage)');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `checklist_code` SET TAGS ('pii_business_glossary_term' = 'Checklist Code');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `checklist_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `critical_items_count` SET TAGS ('pii_business_glossary_term' = 'Critical Items Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `checklist_description` SET TAGS ('pii_business_glossary_term' = 'Checklist Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Discipline');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `effective_from_date` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `effective_to_date` SET TAGS ('pii_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Estimated Duration (Minutes)');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `frequency` SET TAGS ('pii_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `hold_point_flag` SET TAGS ('pii_business_glossary_term' = 'Hold Point Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `inspection_stage` SET TAGS ('pii_business_glossary_term' = 'Inspection Stage');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `inspection_stage` SET TAGS ('pii_value_regex' = 'pre_work|during_work|post_work|hold_point|witness_point');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `inspection_type` SET TAGS ('pii_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `mandatory_flag` SET TAGS ('pii_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `checklist_name` SET TAGS ('pii_business_glossary_term' = 'Checklist Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `ncr_trigger_threshold` SET TAGS ('pii_business_glossary_term' = 'NCR (Non-Conformance Report) Trigger Threshold');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `reference_documents` SET TAGS ('pii_business_glossary_term' = 'Reference Documents');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `required_equipment` SET TAGS ('pii_business_glossary_term' = 'Required Equipment');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `required_qualifications` SET TAGS ('pii_business_glossary_term' = 'Required Qualifications');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `revision_date` SET TAGS ('pii_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `revision_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `safety_requirements` SET TAGS ('pii_business_glossary_term' = 'Safety Requirements');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `total_check_items` SET TAGS ('pii_business_glossary_term' = 'Total Check Items');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `usage_count` SET TAGS ('pii_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `witness_point_flag` SET TAGS ('pii_business_glossary_term' = 'Witness Point Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` SET TAGS ('pii_subdomain' = 'inspection_planning');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` SET TAGS ('pii_mvm_ssot_owner' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `checklist_execution_id` SET TAGS ('pii_business_glossary_term' = 'Checklist Execution ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `checklist_id` SET TAGS ('pii_business_glossary_term' = 'Checklist Template ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `checklist_site_construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Contractor ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `permit_to_work_id` SET TAGS ('pii_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `tertiary_checklist_approved_by_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `tertiary_checklist_approved_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `tertiary_checklist_approved_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected|revision_required');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `compliance_percentage` SET TAGS ('pii_business_glossary_term' = 'Compliance Percentage');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `corrective_action_required` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `critical_failure_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Failure Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `defects_identified` SET TAGS ('pii_business_glossary_term' = 'Defects Identified');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `document_reference_number` SET TAGS ('pii_business_glossary_term' = 'Document Reference Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `execution_date` SET TAGS ('pii_business_glossary_term' = 'Execution Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `execution_end_time` SET TAGS ('pii_business_glossary_term' = 'Execution End Time');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `execution_number` SET TAGS ('pii_business_glossary_term' = 'Execution Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `execution_start_time` SET TAGS ('pii_business_glossary_term' = 'Execution Start Time');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `fail_count` SET TAGS ('pii_business_glossary_term' = 'Fail Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `humidity_percentage` SET TAGS ('pii_business_glossary_term' = 'Humidity Percentage');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `inspection_stage` SET TAGS ('pii_business_glossary_term' = 'Inspection Stage');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `inspection_stage` SET TAGS ('pii_value_regex' = 'pre_construction|during_construction|post_construction|commissioning|DLP');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `inspection_type` SET TAGS ('pii_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `inspector_name` SET TAGS ('pii_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `inspector_remarks` SET TAGS ('pii_business_glossary_term' = 'Inspector Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `inspector_signature_captured` SET TAGS ('pii_business_glossary_term' = 'Inspector Signature Captured');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `inspector_signature_timestamp` SET TAGS ('pii_business_glossary_term' = 'Inspector Signature Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `location_description` SET TAGS ('pii_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `na_count` SET TAGS ('pii_business_glossary_term' = 'Not Applicable (N/A) Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `ncr_generated_flag` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Generated Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `overall_result` SET TAGS ('pii_business_glossary_term' = 'Overall Result');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `overall_result` SET TAGS ('pii_value_regex' = 'pass|fail|conditional_pass|not_applicable');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `pass_count` SET TAGS ('pii_business_glossary_term' = 'Pass Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `temperature_celsius` SET TAGS ('pii_business_glossary_term' = 'Temperature (Celsius)');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `total_items` SET TAGS ('pii_business_glossary_term' = 'Total Items');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `weather_conditions` SET TAGS ('pii_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `witness_name` SET TAGS ('pii_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `witness_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `witness_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `witness_required_flag` SET TAGS ('pii_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `witness_signature_captured` SET TAGS ('pii_business_glossary_term' = 'Witness Signature Captured');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `witness_signature_timestamp` SET TAGS ('pii_business_glossary_term' = 'Witness Signature Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ALTER COLUMN `work_activity_description` SET TAGS ('pii_business_glossary_term' = 'Work Activity Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` SET TAGS ('pii_subdomain' = 'material_testing');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` SET TAGS ('pii_ssot_view' = 'mvm_quality_test_certificate_ssot');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` SET TAGS ('pii_mvm_ssot_owner' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `test_certificate_id` SET TAGS ('pii_business_glossary_term' = 'Test Certificate Identifier');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Supplier Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `itp_id` SET TAGS ('pii_business_glossary_term' = 'Itp Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `material_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Procurement Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `ncr_id` SET TAGS ('pii_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `sample_id` SET TAGS ('pii_business_glossary_term' = 'Sample ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `sustainable_material_id` SET TAGS ('pii_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `accreditation_body` SET TAGS ('pii_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `approved_by` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `certificate_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `certificate_issue_date` SET TAGS ('pii_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `certificate_number` SET TAGS ('pii_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `certificate_status` SET TAGS ('pii_business_glossary_term' = 'Certificate Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `certificate_type` SET TAGS ('pii_business_glossary_term' = 'Certificate Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `certificate_type` SET TAGS ('pii_value_regex' = 'MTC|laboratory_test|factory_test|site_test|third_party_test|supplier_certificate');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `delivery_lot_number` SET TAGS ('pii_business_glossary_term' = 'Delivery Lot Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `document_url` SET TAGS ('pii_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `heat_number` SET TAGS ('pii_business_glossary_term' = 'Heat Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `issuing_laboratory` SET TAGS ('pii_business_glossary_term' = 'Issuing Laboratory');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `laboratory_accreditation_number` SET TAGS ('pii_business_glossary_term' = 'Laboratory Accreditation Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `material_description` SET TAGS ('pii_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `material_type` SET TAGS ('pii_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `pass_fail_status` SET TAGS ('pii_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `pass_fail_status` SET TAGS ('pii_value_regex' = 'pass|fail|conditional_pass|pending_review');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `purchase_order_number` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `sampling_date` SET TAGS ('pii_business_glossary_term' = 'Sampling Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `sampling_location` SET TAGS ('pii_business_glossary_term' = 'Sampling Location');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `specification_requirement` SET TAGS ('pii_business_glossary_term' = 'Specification Requirement');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `technician_name` SET TAGS ('pii_business_glossary_term' = 'Technician Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `technician_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `test_date` SET TAGS ('pii_business_glossary_term' = 'Test Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `test_method` SET TAGS ('pii_business_glossary_term' = 'Test Method');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `test_parameters` SET TAGS ('pii_business_glossary_term' = 'Test Parameters');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `test_results` SET TAGS ('pii_business_glossary_term' = 'Test Results');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `test_standard` SET TAGS ('pii_business_glossary_term' = 'Test Standard');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `work_package_code` SET TAGS ('pii_business_glossary_term' = 'Work Package Code');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` SET TAGS ('pii_subdomain' = 'material_testing');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` SET TAGS ('pii_mvm_ssot_owner' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `weld_record_id` SET TAGS ('pii_business_glossary_term' = 'Weld Record ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `carbon_emission_id` SET TAGS ('pii_business_glossary_term' = 'Carbon Emission Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Welder Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `drawing_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Contractor Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `itp_id` SET TAGS ('pii_business_glossary_term' = 'Itp Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `acceptance_standard` SET TAGS ('pii_business_glossary_term' = 'Weld Acceptance Standard');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `acceptance_standard` SET TAGS ('pii_value_regex' = 'AWS D1.1|ASME Section IX|ISO 3834|API 1104|EN 1090|AISC 360');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `acceptance_status` SET TAGS ('pii_business_glossary_term' = 'Weld Acceptance Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `acceptance_status` SET TAGS ('pii_value_regex' = 'accepted|rejected|rework_required|pending_review');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `base_material_grade` SET TAGS ('pii_business_glossary_term' = 'Base Material Grade');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `base_material_grade` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `defect_description` SET TAGS ('pii_business_glossary_term' = 'Weld Defect Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `filler_material_grade` SET TAGS ('pii_business_glossary_term' = 'Filler Material Grade');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `filler_material_grade` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `heat_number` SET TAGS ('pii_business_glossary_term' = 'Material Heat Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `heat_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `interpass_temperature_c` SET TAGS ('pii_business_glossary_term' = 'Interpass Temperature (°C)');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `joint_type` SET TAGS ('pii_business_glossary_term' = 'Weld Joint Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `material_thickness_mm` SET TAGS ('pii_business_glossary_term' = 'Material Thickness (mm)');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `ndt_date` SET TAGS ('pii_business_glossary_term' = 'Non-Destructive Testing (NDT) Inspection Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `ndt_inspector_certification` SET TAGS ('pii_business_glossary_term' = 'Non-Destructive Testing (NDT) Inspector Certification Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `ndt_inspector_certification` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `ndt_inspector_name` SET TAGS ('pii_business_glossary_term' = 'Non-Destructive Testing (NDT) Inspector Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `ndt_inspector_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `ndt_inspector_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `ndt_method` SET TAGS ('pii_business_glossary_term' = 'Non-Destructive Testing (NDT) Method');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `ndt_report_number` SET TAGS ('pii_business_glossary_term' = 'Non-Destructive Testing (NDT) Report Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `ndt_report_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `ndt_result` SET TAGS ('pii_business_glossary_term' = 'Non-Destructive Testing (NDT) Result');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `ndt_result` SET TAGS ('pii_value_regex' = 'accept|reject|conditional|retest');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `preheat_temperature_c` SET TAGS ('pii_business_glossary_term' = 'Preheat Temperature (°C)');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `pwht_completion_date` SET TAGS ('pii_business_glossary_term' = 'Post-Weld Heat Treatment (PWHT) Completion Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `pwht_required_flag` SET TAGS ('pii_business_glossary_term' = 'Post-Weld Heat Treatment (PWHT) Required Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `qc_approval_date` SET TAGS ('pii_business_glossary_term' = 'Quality Control (QC) Approval Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `qc_inspector_name` SET TAGS ('pii_business_glossary_term' = 'Quality Control (QC) Inspector Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `qc_inspector_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `qc_inspector_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Weld Record Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `rework_completion_date` SET TAGS ('pii_business_glossary_term' = 'Rework Completion Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `rework_required_flag` SET TAGS ('pii_business_glossary_term' = 'Rework Required Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `weld_date` SET TAGS ('pii_business_glossary_term' = 'Weld Execution Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `weld_length_mm` SET TAGS ('pii_business_glossary_term' = 'Weld Length (mm)');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `weld_number` SET TAGS ('pii_business_glossary_term' = 'Weld Identification Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `weld_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `weld_position` SET TAGS ('pii_business_glossary_term' = 'Weld Position');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `weld_type` SET TAGS ('pii_business_glossary_term' = 'Welding Process Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `weld_type` SET TAGS ('pii_value_regex' = 'SMAW|GMAW|GTAW|FCAW|SAW|PAW');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `welder_stamp` SET TAGS ('pii_business_glossary_term' = 'Welder Identification Stamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `welder_stamp` SET TAGS ('pii_value_regex' = '^[A-Z0-9]+$');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `witness_name` SET TAGS ('pii_business_glossary_term' = 'Witness Inspector Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `witness_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `witness_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `witness_organization` SET TAGS ('pii_business_glossary_term' = 'Witness Organization Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `witness_required_flag` SET TAGS ('pii_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `wps_number` SET TAGS ('pii_business_glossary_term' = 'Welding Procedure Specification (WPS) Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `wps_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `wqc_number` SET TAGS ('pii_business_glossary_term' = 'Welder Qualification Certificate (WQC) Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ALTER COLUMN `wqc_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` SET TAGS ('pii_subdomain' = 'material_testing');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` SET TAGS ('pii_mvm_ssot_owner' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `acceptance_test_id` SET TAGS ('pii_business_glossary_term' = 'Acceptance Test ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment Asset ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `itp_id` SET TAGS ('pii_business_glossary_term' = 'Itp Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `ncr_id` SET TAGS ('pii_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `acceptance_certificate_number` SET TAGS ('pii_business_glossary_term' = 'Acceptance Certificate Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `acceptance_date` SET TAGS ('pii_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `acceptance_status` SET TAGS ('pii_business_glossary_term' = 'Acceptance Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `acceptance_status` SET TAGS ('pii_value_regex' = 'accepted|rejected|conditional_acceptance|pending_retest');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `client_representative_name` SET TAGS ('pii_business_glossary_term' = 'Client Representative Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `compliance_standard` SET TAGS ('pii_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `contractor_name` SET TAGS ('pii_business_glossary_term' = 'Contractor Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `contractor_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `contractor_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `corrective_action_required` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `defects_identified` SET TAGS ('pii_business_glossary_term' = 'Defects Identified');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `equipment_description` SET TAGS ('pii_business_glossary_term' = 'Equipment Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Test Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `retest_date` SET TAGS ('pii_business_glossary_term' = 'Retest Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `retest_required` SET TAGS ('pii_business_glossary_term' = 'Retest Required Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `specification_reference` SET TAGS ('pii_business_glossary_term' = 'Specification Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `test_date` SET TAGS ('pii_business_glossary_term' = 'Test Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `test_duration_hours` SET TAGS ('pii_business_glossary_term' = 'Test Duration Hours');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `test_engineer_name` SET TAGS ('pii_business_glossary_term' = 'Test Engineer Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `test_findings` SET TAGS ('pii_business_glossary_term' = 'Test Findings');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `test_humidity_percent` SET TAGS ('pii_business_glossary_term' = 'Test Humidity Percent');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `test_location` SET TAGS ('pii_business_glossary_term' = 'Test Location');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `test_number` SET TAGS ('pii_business_glossary_term' = 'Test Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `test_procedure_reference` SET TAGS ('pii_business_glossary_term' = 'Test Procedure Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `test_procedure_version` SET TAGS ('pii_business_glossary_term' = 'Test Procedure Version');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `test_report_reference` SET TAGS ('pii_business_glossary_term' = 'Test Report Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `test_result` SET TAGS ('pii_business_glossary_term' = 'Test Result');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `test_result` SET TAGS ('pii_value_regex' = 'pass|fail|conditional_pass');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `test_status` SET TAGS ('pii_business_glossary_term' = 'Test Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `test_status` SET TAGS ('pii_value_regex' = 'scheduled|in_progress|passed|failed|conditional_pass|cancelled');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `test_temperature_c` SET TAGS ('pii_business_glossary_term' = 'Test Temperature Celsius');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `test_type` SET TAGS ('pii_business_glossary_term' = 'Test Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `test_type` SET TAGS ('pii_value_regex' = 'FAT|SAT');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `witness_party` SET TAGS ('pii_business_glossary_term' = 'Witness Party');
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` SET TAGS ('pii_subdomain' = 'field_verification');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` SET TAGS ('pii_ssot_view' = 'mvm_quality_defect_ssot');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` SET TAGS ('pii_mvm_ssot_owner' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `defect_id` SET TAGS ('pii_business_glossary_term' = 'Defect ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `drawing_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Contractor ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Identified By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `inspection_id` SET TAGS ('pii_business_glossary_term' = 'Related Inspection ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `ncr_id` SET TAGS ('pii_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `technical_specification_id` SET TAGS ('pii_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `actual_rectification_date` SET TAGS ('pii_business_glossary_term' = 'Actual Rectification Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `assigned_to` SET TAGS ('pii_business_glossary_term' = 'Assigned To');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `closure_date` SET TAGS ('pii_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `defect_number` SET TAGS ('pii_business_glossary_term' = 'Defect Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `defect_status` SET TAGS ('pii_business_glossary_term' = 'Defect Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `defect_type` SET TAGS ('pii_business_glossary_term' = 'Defect Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `defect_description` SET TAGS ('pii_business_glossary_term' = 'Defect Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `dlp_expiry_date` SET TAGS ('pii_business_glossary_term' = 'DLP (Defects Liability Period) Expiry Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `identified_by` SET TAGS ('pii_business_glossary_term' = 'Identified By');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `identified_date` SET TAGS ('pii_business_glossary_term' = 'Defect Identified Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `identified_phase` SET TAGS ('pii_business_glossary_term' = 'Identified Phase');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `identified_phase` SET TAGS ('pii_value_regex' = 'construction|pre_commissioning|commissioning|handover|DLP|post_handover');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `impact_on_handover` SET TAGS ('pii_business_glossary_term' = 'Impact on Handover');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `location_building` SET TAGS ('pii_business_glossary_term' = 'Location Building');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `location_grid_reference` SET TAGS ('pii_business_glossary_term' = 'Location Grid Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `location_level` SET TAGS ('pii_business_glossary_term' = 'Location Level');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `location_zone` SET TAGS ('pii_business_glossary_term' = 'Location Zone');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `photo_reference` SET TAGS ('pii_business_glossary_term' = 'Photo Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `rectification_cost` SET TAGS ('pii_business_glossary_term' = 'Rectification Cost');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `rectification_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `rectification_method` SET TAGS ('pii_business_glossary_term' = 'Rectification Method');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `responsible_contractor_name` SET TAGS ('pii_business_glossary_term' = 'Responsible Contractor Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `responsible_contractor_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `responsible_contractor_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `severity` SET TAGS ('pii_business_glossary_term' = 'Defect Severity');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `severity` SET TAGS ('pii_value_regex' = 'critical|major|minor|cosmetic');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `target_rectification_date` SET TAGS ('pii_business_glossary_term' = 'Target Rectification Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Defect Title');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `trade_discipline` SET TAGS ('pii_business_glossary_term' = 'Trade Discipline');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `verified_by` SET TAGS ('pii_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` SET TAGS ('pii_subdomain' = 'field_verification');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` SET TAGS ('pii_ssot_view' = 'mvm_quality_punch_ssot');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` SET TAGS ('pii_mvm_ssot_owner' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `punch_list_id` SET TAGS ('pii_business_glossary_term' = 'Punch List ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Prepared By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `actual_closeout_date` SET TAGS ('pii_business_glossary_term' = 'Actual Close-Out Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `client_representative` SET TAGS ('pii_business_glossary_term' = 'Client Representative');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `closed_items_count` SET TAGS ('pii_business_glossary_term' = 'Closed Items Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `completion_percentage` SET TAGS ('pii_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `contract_reference` SET TAGS ('pii_business_glossary_term' = 'Contract Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `critical_items_count` SET TAGS ('pii_business_glossary_term' = 'Critical Items Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Discipline');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `dlp_commencement_gate` SET TAGS ('pii_business_glossary_term' = 'Defects Liability Period (DLP) Commencement Gate');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `handover_gate` SET TAGS ('pii_business_glossary_term' = 'Handover Gate');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `inspection_date` SET TAGS ('pii_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `milestone_type` SET TAGS ('pii_business_glossary_term' = 'Milestone Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `punch_list_name` SET TAGS ('pii_business_glossary_term' = 'Punch List Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `open_items_count` SET TAGS ('pii_business_glossary_term' = 'Open Items Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `prepared_by` SET TAGS ('pii_business_glossary_term' = 'Prepared By');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Punch List Priority');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `project_area` SET TAGS ('pii_business_glossary_term' = 'Project Area');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `punch_list_number` SET TAGS ('pii_business_glossary_term' = 'Punch List Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `punch_list_status` SET TAGS ('pii_business_glossary_term' = 'Punch List Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `punch_list_status` SET TAGS ('pii_value_regex' = 'draft|open|in_progress|under_review|closed|cancelled');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `responsible_party_type` SET TAGS ('pii_business_glossary_term' = 'Responsible Party Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `responsible_party_type` SET TAGS ('pii_value_regex' = 'general_contractor|subcontractor|supplier|joint_venture|client|consultant');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `reviewed_by` SET TAGS ('pii_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `specification_reference` SET TAGS ('pii_business_glossary_term' = 'Specification Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `target_closeout_date` SET TAGS ('pii_business_glossary_term' = 'Target Close-Out Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `total_items_count` SET TAGS ('pii_business_glossary_term' = 'Total Items Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `creation_date` SET TAGS ('pii_business_glossary_term' = 'Punch List Creation Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` SET TAGS ('pii_subdomain' = 'field_verification');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` SET TAGS ('pii_mvm_ssot_owner' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `punch_item_id` SET TAGS ('pii_business_glossary_term' = 'Punch Item ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `drawing_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `punch_list_id` SET TAGS ('pii_business_glossary_term' = 'Punch List ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `crew_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Party Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `technical_specification_id` SET TAGS ('pii_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `actual_completion_date` SET TAGS ('pii_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `punch_item_category` SET TAGS ('pii_business_glossary_term' = 'Punch Item Category');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `punch_item_category` SET TAGS ('pii_value_regex' = 'structural|mep|architectural|civil|finishes|landscaping');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `client_representative_name` SET TAGS ('pii_business_glossary_term' = 'Client Representative Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `closure_status` SET TAGS ('pii_business_glossary_term' = 'Closure Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `closure_status` SET TAGS ('pii_value_regex' = 'pending|accepted|rejected|deferred');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `corrective_action` SET TAGS ('pii_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `cost_currency_code` SET TAGS ('pii_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `cost_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `cost_impact` SET TAGS ('pii_business_glossary_term' = 'Cost Impact');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `cost_impact` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `deferred_to_dlp` SET TAGS ('pii_business_glossary_term' = 'Deferred to DLP (Defects Liability Period)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `dlp_end_date` SET TAGS ('pii_business_glossary_term' = 'DLP (Defects Liability Period) End Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `identified_by` SET TAGS ('pii_business_glossary_term' = 'Identified By');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `identified_date` SET TAGS ('pii_business_glossary_term' = 'Identified Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `item_description` SET TAGS ('pii_business_glossary_term' = 'Punch Item Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `item_number` SET TAGS ('pii_business_glossary_term' = 'Punch Item Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `location` SET TAGS ('pii_business_glossary_term' = 'Punch Item Location');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `photo_reference` SET TAGS ('pii_business_glossary_term' = 'Photo Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Punch Item Priority');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `punch_item_status` SET TAGS ('pii_business_glossary_term' = 'Punch Item Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `punch_item_status` SET TAGS ('pii_value_regex' = 'open|in_progress|completed|verified|closed|rejected');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `target_completion_date` SET TAGS ('pii_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `verification_inspector` SET TAGS ('pii_business_glossary_term' = 'Verification Inspector');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` SET TAGS ('pii_subdomain' = 'inspection_planning');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` SET TAGS ('pii_mvm_ssot_owner' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `quality_plan_id` SET TAGS ('pii_business_glossary_term' = 'Quality Plan ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `applicable_standards` SET TAGS ('pii_business_glossary_term' = 'Applicable Standards');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `approved_by_name` SET TAGS ('pii_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `approved_by_role` SET TAGS ('pii_business_glossary_term' = 'Approved By Role');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `audit_schedule_reference` SET TAGS ('pii_business_glossary_term' = 'Audit Schedule Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `calibration_procedure_reference` SET TAGS ('pii_business_glossary_term' = 'Calibration Procedure Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `client_approval_date` SET TAGS ('pii_business_glossary_term' = 'Client Approval Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `client_approval_required` SET TAGS ('pii_business_glossary_term' = 'Client Approval Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `client_approved_by_name` SET TAGS ('pii_business_glossary_term' = 'Client Approved By Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `continuous_improvement_mechanism` SET TAGS ('pii_business_glossary_term' = 'Continuous Improvement Mechanism');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `contract_reference` SET TAGS ('pii_business_glossary_term' = 'Contract Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `defect_liability_period_days` SET TAGS ('pii_business_glossary_term' = 'Defects Liability Period (DLP) Days');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `document_control_procedure` SET TAGS ('pii_business_glossary_term' = 'Document Control Procedure');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `handover_quality_requirements` SET TAGS ('pii_business_glossary_term' = 'Handover Quality Requirements');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `inspection_regime_summary` SET TAGS ('pii_business_glossary_term' = 'Inspection Regime Summary');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `itp_register_reference` SET TAGS ('pii_business_glossary_term' = 'Inspection and Test Plan (ITP) Register Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `material_control_procedure` SET TAGS ('pii_business_glossary_term' = 'Material Control Procedure');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `ncr_procedure_reference` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Procedure Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `organizational_structure` SET TAGS ('pii_business_glossary_term' = 'Organizational Structure');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `plan_number` SET TAGS ('pii_business_glossary_term' = 'Project Quality Plan (PQP) Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_value_regex' = 'draft|under_review|approved|active|superseded|archived');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `prepared_by_name` SET TAGS ('pii_business_glossary_term' = 'Prepared By Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `prepared_by_role` SET TAGS ('pii_business_glossary_term' = 'Prepared By Role');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `quality_manager_name` SET TAGS ('pii_business_glossary_term' = 'Quality Manager Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `quality_objectives` SET TAGS ('pii_business_glossary_term' = 'Quality Objectives');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `quality_policy_reference` SET TAGS ('pii_business_glossary_term' = 'Quality Policy Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `reviewed_by_name` SET TAGS ('pii_business_glossary_term' = 'Reviewed By Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `reviewed_by_role` SET TAGS ('pii_business_glossary_term' = 'Reviewed By Role');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `scope_of_work` SET TAGS ('pii_business_glossary_term' = 'Scope of Work');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `subcontractor_quality_management` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Quality Management');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Quality Plan Title');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `training_requirements` SET TAGS ('pii_business_glossary_term' = 'Training Requirements');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Plan Version Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` SET TAGS ('pii_subdomain' = 'field_verification');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` SET TAGS ('pii_ssot_view' = 'mvm_quality_audit_ssot');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` SET TAGS ('pii_mvm_ssot_owner' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `quality_audit_id` SET TAGS ('pii_business_glossary_term' = 'Quality Audit ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Lead Auditor Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `quality_plan_id` SET TAGS ('pii_business_glossary_term' = 'Quality Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `areas_audited` SET TAGS ('pii_business_glossary_term' = 'Areas Audited');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `audit_date` SET TAGS ('pii_business_glossary_term' = 'Audit Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `audit_number` SET TAGS ('pii_business_glossary_term' = 'Audit Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `audit_scope` SET TAGS ('pii_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `audit_status` SET TAGS ('pii_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `audit_status` SET TAGS ('pii_value_regex' = 'planned|in_progress|completed|closed|cancelled');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `audit_type` SET TAGS ('pii_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `audit_type` SET TAGS ('pii_value_regex' = 'internal|external|third_party|surveillance|certification');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `auditee_department` SET TAGS ('pii_business_glossary_term' = 'Auditee Department');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `auditee_representative_name` SET TAGS ('pii_business_glossary_term' = 'Auditee Representative Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `auditor_organization` SET TAGS ('pii_business_glossary_term' = 'Auditor Organization');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `car_raised_count` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Request (CAR) Raised Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `certification_body` SET TAGS ('pii_business_glossary_term' = 'Certification Body');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `certification_standard` SET TAGS ('pii_business_glossary_term' = 'Certification Standard');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `closed_by` SET TAGS ('pii_business_glossary_term' = 'Closed By');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `closure_date` SET TAGS ('pii_business_glossary_term' = 'Audit Closure Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `conclusion` SET TAGS ('pii_business_glossary_term' = 'Audit Conclusion');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `conclusion` SET TAGS ('pii_value_regex' = 'satisfactory|satisfactory_with_observations|unsatisfactory|not_recommended_for_certification');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `corrective_action_due_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `criteria` SET TAGS ('pii_business_glossary_term' = 'Audit Criteria');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `documents_reviewed` SET TAGS ('pii_business_glossary_term' = 'Documents Reviewed');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `duration_hours` SET TAGS ('pii_business_glossary_term' = 'Audit Duration Hours');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Audit End Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `findings_summary` SET TAGS ('pii_business_glossary_term' = 'Audit Findings Summary');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `follow_up_audit_date` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Audit Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `follow_up_audit_required` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Audit Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('pii_business_glossary_term' = 'Lead Auditor Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `major_nc_count` SET TAGS ('pii_business_glossary_term' = 'Major Non-Conformance (NC) Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `minor_nc_count` SET TAGS ('pii_business_glossary_term' = 'Minor Non-Conformance (NC) Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `observations_count` SET TAGS ('pii_business_glossary_term' = 'Observations Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `personnel_interviewed` SET TAGS ('pii_business_glossary_term' = 'Personnel Interviewed');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `positive_findings` SET TAGS ('pii_business_glossary_term' = 'Positive Findings');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `report_issued_date` SET TAGS ('pii_business_glossary_term' = 'Audit Report Issued Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `report_reference` SET TAGS ('pii_business_glossary_term' = 'Audit Report Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Audit Start Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `team_members` SET TAGS ('pii_business_glossary_term' = 'Audit Team Members');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` SET TAGS ('pii_subdomain' = 'field_verification');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` SET TAGS ('pii_ssot_view' = 'mvm_quality_submittal_ssot');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` SET TAGS ('pii_ssot_role' = 'non_canonical_view');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` SET TAGS ('pii_ssot_canonical' = 'design.design_submittal');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` SET TAGS ('pii_mvm_ssot_resolved' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` SET TAGS ('pii_ssot' = 'canonical');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` SET TAGS ('pii_ssot_master' = 'design.design_submittal');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` SET TAGS ('pii_ssot_distinct' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` SET TAGS ('pii_ssot_scope' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` SET TAGS ('pii_ssot_counterpart' = 'design.design_submittal');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` SET TAGS ('pii_mvm_ssot_owner' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `quality_submittal_id` SET TAGS ('pii_business_glossary_term' = 'Quality Submittal ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `engineering_submittal_id` SET TAGS ('pii_business_glossary_term' = 'Design Submittal Id');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `engineering_submittal_id` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `engineering_submittal_id` SET TAGS ('pii_ssot' = 'design.design_submittal');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `drawing_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `quality_plan_id` SET TAGS ('pii_business_glossary_term' = 'Quality Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `technical_specification_id` SET TAGS ('pii_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `actual_review_days` SET TAGS ('pii_business_glossary_term' = 'Actual Review Days');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `approval_code` SET TAGS ('pii_business_glossary_term' = 'Approval Code');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `approval_code` SET TAGS ('pii_value_regex' = 'A|B|C|D|E|R');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `certification_required` SET TAGS ('pii_business_glossary_term' = 'Certification Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `compliance_standard` SET TAGS ('pii_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `contractor_name` SET TAGS ('pii_business_glossary_term' = 'Contractor Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `contractor_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `contractor_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `contractor_response` SET TAGS ('pii_business_glossary_term' = 'Contractor Response');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `contractual_review_days` SET TAGS ('pii_business_glossary_term' = 'Contractual Review Days');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `cost_impact` SET TAGS ('pii_business_glossary_term' = 'Cost Impact');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `cost_impact` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `final_approval_date` SET TAGS ('pii_business_glossary_term' = 'Final Approval Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `linked_change_order_number` SET TAGS ('pii_business_glossary_term' = 'Linked Change Order (CO) Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `linked_rfi_number` SET TAGS ('pii_business_glossary_term' = 'Linked Request for Information (RFI) Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `manufacturer_model_number` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Model Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `required_on_site_date` SET TAGS ('pii_business_glossary_term' = 'Required On-Site Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `resubmission_date` SET TAGS ('pii_business_glossary_term' = 'Resubmission Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `resubmission_required` SET TAGS ('pii_business_glossary_term' = 'Resubmission Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `review_completion_date` SET TAGS ('pii_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `review_priority` SET TAGS ('pii_business_glossary_term' = 'Review Priority');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `review_priority` SET TAGS ('pii_value_regex' = 'critical|high|normal|low');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `review_start_date` SET TAGS ('pii_business_glossary_term' = 'Review Start Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `reviewer_comments` SET TAGS ('pii_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `reviewer_name` SET TAGS ('pii_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `reviewer_organization` SET TAGS ('pii_business_glossary_term' = 'Reviewer Organization');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `schedule_impact_days` SET TAGS ('pii_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `specification_section` SET TAGS ('pii_business_glossary_term' = 'Specification Section');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `submittal_description` SET TAGS ('pii_business_glossary_term' = 'Submittal Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `submittal_number` SET TAGS ('pii_business_glossary_term' = 'Submittal Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `submittal_type` SET TAGS ('pii_business_glossary_term' = 'Submittal Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Submittal Title');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` SET TAGS ('pii_subdomain' = 'material_testing');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` SET TAGS ('pii_mvm_ssot_owner' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `ndt_record_id` SET TAGS ('pii_business_glossary_term' = 'Non-Destructive Testing (NDT) Record ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `drawing_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `itp_id` SET TAGS ('pii_business_glossary_term' = 'Inspection and Test Plan (ITP) ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `acceptance_criteria` SET TAGS ('pii_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `acceptance_status` SET TAGS ('pii_business_glossary_term' = 'Acceptance Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `acceptance_status` SET TAGS ('pii_value_regex' = 'accepted|rejected|conditional|pending_review');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `calibration_due_date` SET TAGS ('pii_business_glossary_term' = 'Calibration Due Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `calibration_reference` SET TAGS ('pii_business_glossary_term' = 'Equipment Calibration Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `component_description` SET TAGS ('pii_business_glossary_term' = 'Component Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `component_identifier` SET TAGS ('pii_business_glossary_term' = 'Component Identifier');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `contractor_name` SET TAGS ('pii_business_glossary_term' = 'Contractor Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `contractor_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `contractor_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `equipment_serial_number` SET TAGS ('pii_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `equipment_used` SET TAGS ('pii_business_glossary_term' = 'NDT Equipment Used');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `indication_count` SET TAGS ('pii_business_glossary_term' = 'Indication Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `indication_findings` SET TAGS ('pii_business_glossary_term' = 'Indication Findings');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `indication_severity` SET TAGS ('pii_business_glossary_term' = 'Indication Severity');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `indication_severity` SET TAGS ('pii_value_regex' = 'minor|major|critical');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `ncr_number` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `ncr_raised` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Raised');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `ndt_method` SET TAGS ('pii_business_glossary_term' = 'Non-Destructive Testing (NDT) Method');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `repair_required` SET TAGS ('pii_business_glossary_term' = 'Repair Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `retest_date` SET TAGS ('pii_business_glossary_term' = 'Retest Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `retest_required` SET TAGS ('pii_business_glossary_term' = 'Retest Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `specification_reference` SET TAGS ('pii_business_glossary_term' = 'Specification Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `technician_certification_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Technician Certification Expiry Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `technician_certification_level` SET TAGS ('pii_business_glossary_term' = 'Technician Certification Level');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `technician_certification_level` SET TAGS ('pii_value_regex' = 'Level I|Level II|Level III');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `technician_certification_number` SET TAGS ('pii_business_glossary_term' = 'Technician Certification Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `technician_name` SET TAGS ('pii_business_glossary_term' = 'NDT Technician Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `test_date` SET TAGS ('pii_business_glossary_term' = 'NDT Test Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `test_location` SET TAGS ('pii_business_glossary_term' = 'NDT Test Location');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `test_number` SET TAGS ('pii_business_glossary_term' = 'NDT Test Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `test_procedure_reference` SET TAGS ('pii_business_glossary_term' = 'Test Procedure Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `test_procedure_version` SET TAGS ('pii_business_glossary_term' = 'Test Procedure Version');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `test_report_number` SET TAGS ('pii_business_glossary_term' = 'Test Report Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `test_report_reference` SET TAGS ('pii_business_glossary_term' = 'Test Report Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `test_result` SET TAGS ('pii_business_glossary_term' = 'NDT Test Result');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `test_result` SET TAGS ('pii_value_regex' = 'pass|fail|conditional');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `test_status` SET TAGS ('pii_business_glossary_term' = 'NDT Test Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `test_status` SET TAGS ('pii_value_regex' = 'scheduled|in_progress|completed|cancelled');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `weld_number` SET TAGS ('pii_business_glossary_term' = 'Weld Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `witness_name` SET TAGS ('pii_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `witness_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `witness_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `witness_party` SET TAGS ('pii_business_glossary_term' = 'Witness Party');
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` SET TAGS ('pii_subdomain' = 'material_testing');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` SET TAGS ('pii_mvm_ssot_owner' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `concrete_pour_record_id` SET TAGS ('pii_business_glossary_term' = 'Concrete Pour Record ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `carbon_emission_id` SET TAGS ('pii_business_glossary_term' = 'Carbon Emission Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `drawing_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Contractor Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `inspection_id` SET TAGS ('pii_business_glossary_term' = 'Inspection Id');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `itp_id` SET TAGS ('pii_business_glossary_term' = 'Inspection and Test Plan (ITP) ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `ncr_id` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `acceptance_status` SET TAGS ('pii_business_glossary_term' = 'Acceptance Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `acceptance_status` SET TAGS ('pii_value_regex' = 'pending|accepted|conditionally_accepted|rejected');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `ambient_temperature_c` SET TAGS ('pii_business_glossary_term' = 'Ambient Temperature (Celsius)');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `approved_submittal_number` SET TAGS ('pii_business_glossary_term' = 'Approved Submittal Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `batch_plant_name` SET TAGS ('pii_business_glossary_term' = 'Batch Plant Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `client_witness_name` SET TAGS ('pii_business_glossary_term' = 'Client Witness Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `client_witness_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `client_witness_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `concrete_grade` SET TAGS ('pii_business_glossary_term' = 'Concrete Grade');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `concrete_temperature_c` SET TAGS ('pii_business_glossary_term' = 'Concrete Temperature (Celsius)');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `consultant_witness_name` SET TAGS ('pii_business_glossary_term' = 'Consultant Witness Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `consultant_witness_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `consultant_witness_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `cube_sample_ids` SET TAGS ('pii_business_glossary_term' = 'Cube Sample IDs');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `cube_samples_taken` SET TAGS ('pii_business_glossary_term' = 'Cube Samples Taken');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `curing_duration_days` SET TAGS ('pii_business_glossary_term' = 'Curing Duration (Days)');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `curing_method` SET TAGS ('pii_business_glossary_term' = 'Curing Method');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `curing_method` SET TAGS ('pii_value_regex' = 'wet_covering|curing_compound|plastic_sheeting|water_ponding|steam_curing|membrane_curing');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `curing_start_date` SET TAGS ('pii_business_glossary_term' = 'Curing Start Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `cylinder_sample_ids` SET TAGS ('pii_business_glossary_term' = 'Cylinder Sample IDs');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `delivery_docket_numbers` SET TAGS ('pii_business_glossary_term' = 'Delivery Docket Numbers');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `element_location` SET TAGS ('pii_business_glossary_term' = 'Element Location');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `element_reference` SET TAGS ('pii_business_glossary_term' = 'Element Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `element_type` SET TAGS ('pii_business_glossary_term' = 'Element Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `grid_reference` SET TAGS ('pii_business_glossary_term' = 'Grid Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `inspector_name` SET TAGS ('pii_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `inspector_signature_date` SET TAGS ('pii_business_glossary_term' = 'Inspector Signature Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `concrete_pour_record_level` SET TAGS ('pii_business_glossary_term' = 'Level');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `location_description` SET TAGS ('pii_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `mix_design_reference` SET TAGS ('pii_business_glossary_term' = 'Mix Design Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `ncr_raised` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Raised');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `number_of_samples_taken` SET TAGS ('pii_business_glossary_term' = 'Number of Samples Taken');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `number_of_trucks` SET TAGS ('pii_business_glossary_term' = 'Number of Trucks');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `pour_date` SET TAGS ('pii_business_glossary_term' = 'Pour Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `pour_end_time` SET TAGS ('pii_business_glossary_term' = 'Pour End Time');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `pour_number` SET TAGS ('pii_business_glossary_term' = 'Pour Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `pour_start_time` SET TAGS ('pii_business_glossary_term' = 'Pour Start Time');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `pour_status` SET TAGS ('pii_business_glossary_term' = 'Pour Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `pour_volume_m3` SET TAGS ('pii_business_glossary_term' = 'Pour Volume M3');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `slump_mm` SET TAGS ('pii_business_glossary_term' = 'Slump Mm');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `slump_specification_mm` SET TAGS ('pii_business_glossary_term' = 'Slump Specification (Millimeters)');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `slump_test_passed` SET TAGS ('pii_business_glossary_term' = 'Slump Test Passed');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `slump_test_result_mm` SET TAGS ('pii_business_glossary_term' = 'Slump Test Result (Millimeters)');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `slump_value_mm` SET TAGS ('pii_business_glossary_term' = 'Slump Value Mm');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `supplier_name` SET TAGS ('pii_business_glossary_term' = 'Supplier Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `total_pour_volume_m3` SET TAGS ('pii_business_glossary_term' = 'Total Pour Volume (Cubic Meters)');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `volume_poured_m3` SET TAGS ('pii_business_glossary_term' = 'Volume Poured M3');
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ALTER COLUMN `weather_conditions` SET TAGS ('pii_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` SET TAGS ('pii_subdomain' = 'material_testing');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` SET TAGS ('pii_mvm_ssot_owner' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `lab_test_id` SET TAGS ('pii_business_glossary_term' = 'Laboratory Test ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `drawing_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `itp_id` SET TAGS ('pii_business_glossary_term' = 'Itp Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `laboratory_id` SET TAGS ('pii_business_glossary_term' = 'Laboratory Id');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `ncr_id` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `original_test_lab_test_id` SET TAGS ('pii_business_glossary_term' = 'Original Test ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `sample_id` SET TAGS ('pii_business_glossary_term' = 'Sample Identification Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `technical_specification_id` SET TAGS ('pii_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `acceptance_criteria` SET TAGS ('pii_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `accreditation_body` SET TAGS ('pii_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `cost_code` SET TAGS ('pii_business_glossary_term' = 'Cost Code');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `delivery_ticket_number` SET TAGS ('pii_business_glossary_term' = 'Delivery Ticket Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `lab_test_number` SET TAGS ('pii_business_glossary_term' = 'Lab Test Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `laboratory_accreditation_number` SET TAGS ('pii_business_glossary_term' = 'Laboratory Accreditation Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `material_description` SET TAGS ('pii_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `material_type` SET TAGS ('pii_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `measured_result` SET TAGS ('pii_business_glossary_term' = 'Measured Result');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `pass_fail_status` SET TAGS ('pii_business_glossary_term' = 'Pass Fail Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `report_issue_date` SET TAGS ('pii_business_glossary_term' = 'Report Issue Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `report_number` SET TAGS ('pii_business_glossary_term' = 'Report Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `result_unit` SET TAGS ('pii_business_glossary_term' = 'Result Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `result_value` SET TAGS ('pii_business_glossary_term' = 'Result Value');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `retest_flag` SET TAGS ('pii_business_glossary_term' = 'Retest Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `reviewed_by` SET TAGS ('pii_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `sampled_by` SET TAGS ('pii_business_glossary_term' = 'Sampled By');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `sampling_date` SET TAGS ('pii_business_glossary_term' = 'Sampling Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `sampling_location` SET TAGS ('pii_business_glossary_term' = 'Sampling Location');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `specification_requirement` SET TAGS ('pii_business_glossary_term' = 'Specification Requirement');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `supplier_name` SET TAGS ('pii_business_glossary_term' = 'Supplier Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `technician_name` SET TAGS ('pii_business_glossary_term' = 'Technician Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `test_age_days` SET TAGS ('pii_business_glossary_term' = 'Test Age (Days)');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `test_certificate_number` SET TAGS ('pii_business_glossary_term' = 'Test Certificate Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `test_date` SET TAGS ('pii_business_glossary_term' = 'Test Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `test_method` SET TAGS ('pii_business_glossary_term' = 'Test Method');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `test_number` SET TAGS ('pii_business_glossary_term' = 'Test Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `test_parameter` SET TAGS ('pii_business_glossary_term' = 'Test Parameter');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `test_parameters` SET TAGS ('pii_business_glossary_term' = 'Test Parameters');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `test_report_reference` SET TAGS ('pii_business_glossary_term' = 'Test Report Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `test_result_status` SET TAGS ('pii_business_glossary_term' = 'Test Result Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `test_result_status` SET TAGS ('pii_value_regex' = 'pass|fail|conditional|retest_required|pending');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `test_result_value` SET TAGS ('pii_business_glossary_term' = 'Test Result Value');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `test_standard` SET TAGS ('pii_business_glossary_term' = 'Test Standard');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `test_status` SET TAGS ('pii_business_glossary_term' = 'Test Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `test_type` SET TAGS ('pii_business_glossary_term' = 'Test Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `tested_by` SET TAGS ('pii_business_glossary_term' = 'Tested By');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `tolerance_lower_limit` SET TAGS ('pii_business_glossary_term' = 'Tolerance Lower Limit');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `tolerance_upper_limit` SET TAGS ('pii_business_glossary_term' = 'Tolerance Upper Limit');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `witness_name` SET TAGS ('pii_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `witness_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `witness_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `witness_party` SET TAGS ('pii_business_glossary_term' = 'Witness Party');
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ALTER COLUMN `witness_required` SET TAGS ('pii_business_glossary_term' = 'Witness Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` SET TAGS ('pii_subdomain' = 'material_testing');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` SET TAGS ('pii_mvm_ssot_owner' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `sample_id` SET TAGS ('pii_business_glossary_term' = 'Sample Identifier');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `concrete_pour_record_id` SET TAGS ('pii_business_glossary_term' = 'Concrete Pour Record Id');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project Id');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `itp_id` SET TAGS ('pii_business_glossary_term' = 'Itp Id');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `laboratory_id` SET TAGS ('pii_business_glossary_term' = 'Lab Id');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `material_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Material Catalog Id');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `parent_sample_id` SET TAGS ('pii_business_glossary_term' = 'Parent Sample Id');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `parent_sample_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `sample_laboratory_id` SET TAGS ('pii_business_glossary_term' = 'Laboratory Id');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `site_location_id` SET TAGS ('pii_business_glossary_term' = 'Location Id');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Wbs Element Id');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `batch_lot_number` SET TAGS ('pii_business_glossary_term' = 'Batch Lot Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `chain_of_custody_reference` SET TAGS ('pii_business_glossary_term' = 'Chain Of Custody Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `sample_code` SET TAGS ('pii_business_glossary_term' = 'Sample Code');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `collected_by` SET TAGS ('pii_business_glossary_term' = 'Collected By');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `collection_date` SET TAGS ('pii_business_glossary_term' = 'Collection Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `collection_location` SET TAGS ('pii_business_glossary_term' = 'Collection Location');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `compliance_standard` SET TAGS ('pii_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `condition` SET TAGS ('pii_business_glossary_term' = 'Condition');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `disposal_date` SET TAGS ('pii_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `disposition` SET TAGS ('pii_business_glossary_term' = 'Disposition');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `humidity_percent` SET TAGS ('pii_business_glossary_term' = 'Humidity Percent');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `is_critical` SET TAGS ('pii_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `location` SET TAGS ('pii_business_glossary_term' = 'Location');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `material` SET TAGS ('pii_business_glossary_term' = 'Material');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `material_description` SET TAGS ('pii_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `sample_name` SET TAGS ('pii_business_glossary_term' = 'Sample Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `quality_status` SET TAGS ('pii_business_glossary_term' = 'Quality Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `sample_number` SET TAGS ('pii_business_glossary_term' = 'Sample Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `sample_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `sample_type` SET TAGS ('pii_business_glossary_term' = 'Sample Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `sampling_date` SET TAGS ('pii_business_glossary_term' = 'Sampling Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `sampling_location` SET TAGS ('pii_business_glossary_term' = 'Sampling Location');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `sampling_method` SET TAGS ('pii_business_glossary_term' = 'Sampling Method');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `storage_condition` SET TAGS ('pii_business_glossary_term' = 'Storage Condition');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `storage_location` SET TAGS ('pii_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `temperature_c` SET TAGS ('pii_business_glossary_term' = 'Temperature C');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `test_date` SET TAGS ('pii_business_glossary_term' = 'Test Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `test_method` SET TAGS ('pii_business_glossary_term' = 'Test Method');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `test_result_unit` SET TAGS ('pii_business_glossary_term' = 'Test Result Unit');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `test_result_value` SET TAGS ('pii_business_glossary_term' = 'Test Result Value');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `volume_l` SET TAGS ('pii_business_glossary_term' = 'Sample Volume L');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `weight_kg` SET TAGS ('pii_business_glossary_term' = 'Sample Weight Kg');
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ALTER COLUMN `witness_party` SET TAGS ('pii_business_glossary_term' = 'Witness Party');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` SET TAGS ('pii_subdomain' = 'material_testing');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` SET TAGS ('pii_mvm_ssot_owner' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `laboratory_id` SET TAGS ('pii_business_glossary_term' = 'Laboratory Identifier');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project Id');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `parent_laboratory_id` SET TAGS ('pii_business_glossary_term' = 'Parent Laboratory Id');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `parent_laboratory_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `accreditation_body` SET TAGS ('pii_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `accreditation_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Accreditation Expiry Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `accreditation_number` SET TAGS ('pii_business_glossary_term' = 'Accreditation Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `accreditation_standard` SET TAGS ('pii_business_glossary_term' = 'Accreditation Standard');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `accreditation_status` SET TAGS ('pii_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `address` SET TAGS ('pii_business_glossary_term' = 'Address');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `address_line` SET TAGS ('pii_business_glossary_term' = 'Address Line');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `address_line` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `address_line` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `capacity_tests_per_day` SET TAGS ('pii_business_glossary_term' = 'Capacity Tests Per Day');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `certification_details` SET TAGS ('pii_business_glossary_term' = 'Certification Details');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `closing_date` SET TAGS ('pii_business_glossary_term' = 'Closing Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `laboratory_code` SET TAGS ('pii_business_glossary_term' = 'Code');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `contact_email` SET TAGS ('pii_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `contact_name` SET TAGS ('pii_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `contact_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `contact_person` SET TAGS ('pii_business_glossary_term' = 'Contact Person');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `contact_phone` SET TAGS ('pii_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `data_sharing_agreement` SET TAGS ('pii_business_glossary_term' = 'Data Sharing Agreement');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `laboratory_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `email_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `equipment_summary` SET TAGS ('pii_business_glossary_term' = 'Equipment Summary');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `hazardous_materials_allowed` SET TAGS ('pii_business_glossary_term' = 'Hazardous Materials Allowed');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `is_approved` SET TAGS ('pii_business_glossary_term' = 'Is Approved');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `is_certified` SET TAGS ('pii_business_glossary_term' = 'Is Certified');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `is_external` SET TAGS ('pii_business_glossary_term' = 'Is External');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `is_internal` SET TAGS ('pii_business_glossary_term' = 'Is Internal');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `lab_area_sqm` SET TAGS ('pii_business_glossary_term' = 'Lab Area Sqm');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `laboratory_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `laboratory_type` SET TAGS ('pii_business_glossary_term' = 'Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `last_inspection_date` SET TAGS ('pii_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `manager_name` SET TAGS ('pii_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `manager_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `manager_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `max_sample_weight_kg` SET TAGS ('pii_business_glossary_term' = 'Max Sample Weight Kg');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `laboratory_name` SET TAGS ('pii_business_glossary_term' = 'Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `next_inspection_due` SET TAGS ('pii_business_glossary_term' = 'Next Inspection Due');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `opening_date` SET TAGS ('pii_business_glossary_term' = 'Opening Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `operating_hours` SET TAGS ('pii_business_glossary_term' = 'Operating Hours');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `phone_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `quality_management_system` SET TAGS ('pii_business_glossary_term' = 'Quality Management System');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `region` SET TAGS ('pii_business_glossary_term' = 'Region');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `safety_rating` SET TAGS ('pii_business_glossary_term' = 'Safety Rating');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `sample_storage_temperature_c` SET TAGS ('pii_business_glossary_term' = 'Sample Storage Temperature C');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `scope_of_testing` SET TAGS ('pii_business_glossary_term' = 'Scope Of Testing');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `state_province` SET TAGS ('pii_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `state_province` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `state_province` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ALTER COLUMN `waste_disposal_method` SET TAGS ('pii_business_glossary_term' = 'Waste Disposal Method');
