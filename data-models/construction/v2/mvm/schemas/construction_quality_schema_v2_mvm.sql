-- Schema for Domain: quality | Business: Construction | Version: v2_mvm
-- Generated on: 2026-06-27 01:56:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`quality` COMMENT 'QA/QC (Quality Assurance/Quality Control) domain managing ITP (Inspection and Test Plans), NCR (Non-Conformance Reports), inspection checklists, material test certificates, weld records, FAT (Factory Acceptance Test), SAT (Site Acceptance Test), and defect tracking through DLP. Ensures construction deliverables meet specifications and ISO 9001 standards.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`itp` (
    `itp_id` BIGINT COMMENT 'Unique identifier for the Inspection and Test Plan record. Primary key for the ITP entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: ITPs require client-specific approval and define client inspector responsibilities. Linking ITP to client.account enables client-specific ITP approval workflows, client inspector assignment reporting,',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: ITPs are scoped to design packages in construction — the ITP register is prepared in response to a design package issue. QA managers track which ITP governs each package scope. A QA engineer would exp',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: ITPs are scoped to project phases (civil, MEP, commissioning). Phase-level ITP register reporting is a standard construction QMS requirement — quality managers assign and track ITPs per phase gate. No',
    `plan_id` BIGINT COMMENT 'Foreign key linking to quality.quality_plan. Business justification: An Inspection and Test Plan (ITP) is a child document governed by the Project Quality Plan (PQP). The quality_plan is the master QA/QC strategy document, and ITPs are the operational execution plans u',
    `acceptance_criteria` STRING COMMENT 'Detailed acceptance criteria and tolerances that must be met for the work to pass inspection. Defines the pass/fail thresholds for quality verification.',
    `applicable_standards` STRING COMMENT 'Comma-separated list of applicable quality, design, and construction standards governing this ITP (e.g., ISO 9001, ACI 318, ASME B31.3, IBC 2018). Defines the regulatory and technical framework.',
    `approval_date` DATE COMMENT 'Date on which the ITP was formally approved by the client or authorized party. Marks the effective date for use in quality control.',
    `approval_status` STRING COMMENT 'Current approval status of the ITP document in the quality management workflow. Governs whether the ITP can be used for active inspections. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|superseded|obsolete — 7 candidates stripped; promote to reference product]',
    `approved_by` STRING COMMENT 'Name of the individual or role who granted final approval for the ITP document, authorizing its use for quality control activities.',
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
    `asset_category_id` BIGINT COMMENT 'Foreign key linking to equipment.asset_category. Business justification: Individual ITP lines specify inspection activities for particular equipment categories (e.g., ITP line for crane load testing, ITP line for pressure vessel hydrostatic test). Category-level ITP line s',
    `checklist_id` BIGINT COMMENT 'Foreign key linking to quality.checklist. Business justification: An ITP line item (hold point, witness point, review point) specifies which checklist template should be used when the inspection is conducted. This is a direct business relationship: the ITP line pres',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Each ITP line represents a discrete inspection activity with estimated duration and associated QA cost. Construction project controls require ITP line activities to be coded for QA cost tracking, earn',
    `itp_id` BIGINT COMMENT 'Reference to the parent ITP document that contains this line item. Links the line to its header ITP.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: ITP line often executed by a crew; linking crew provides crew‑level accountability.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Individual ITP line activities are risk-rated; the risk assessment drives hold point type (H/W/R) and inspection frequency per line. Risk-based inspection planning at activity level is a core construc',
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
    `checklist_id` BIGINT COMMENT 'Reference to the standardized inspection checklist template used for this inspection. Defines the verification criteria and check items.',
    `concrete_pour_id` BIGINT COMMENT 'Foreign key linking to site.concrete_pour. Business justification: Concrete pours require mandatory pre-pour, during-pour, and post-pour inspections under ITP hold points. Linking inspection to concrete_pour enables pour inspection traceability and supports the QC ho',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Inspections are scheduled for specific crews; needed for crew‑based inspection planning.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Required for Cost Allocation Report: each inspection activity is charged to a cost code for budgeting and client billing.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Needed to link inspection results to the goods receipt that triggered the inspection, supporting receipt‑inspection traceability.',
    `itp_line_id` BIGINT COMMENT 'Foreign key linking to quality.itp_line. Business justification: Link inspection to its ITP line for proper hierarchy; inspection may occur multiple times per line.',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Milestone hold-point inspections are contractually required in construction — inspections gate milestone sign-off (e.g., pre-handover, pre-NTP). Linking inspection to project_milestone enables milesto',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Quality inspections of PTW-controlled work (confined space, hot work, pressure testing) require the inspector to verify an active PTW exists. Inspection records must reference the authorizing PTW for ',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Inspections are conducted within specific project phases. Phase-level inspection KPI reports (pass rate per phase, defects per phase) are standard construction QA dashboards. No phase_id exists on ins',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: Quality inspectors verify SWMS compliance during inspection of high-risk construction activities. The inspection record references the applicable SWMS to confirm control measures are implemented — a n',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to material.warehouse. Business justification: Warehouse/storage facility inspection process: warehouses storing construction materials undergo periodic QA audits (storage condition checks, hazmat certification inspections, temperature-controlled ',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Inspections are conducted at specific work fronts. Linking inspection to work_front enables the inspection register to be filtered by work front location — essential for ITP hold-point management and ',
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
    `invoice_id` BIGINT COMMENT 'Foreign key linking to finance.invoice. Business justification: When a subcontractor NCR results in a financial back-charge, the back-charge invoice must be traceable to the originating NCR for contract administration, dispute resolution, and audit. Construction c',
    `change_order_id` BIGINT COMMENT 'Foreign key linking to project.project_change_order. Business justification: NCR dispositions in construction frequently generate change orders for rework scope and cost recovery. Linking NCR to the resulting change order enables cost-of-quality tracking and contractual rework',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: NCRs are tracked against the client account for contract compliance and client‑specific reporting.',
    `engineering_submittal_id` BIGINT COMMENT 'Foreign key linking to design.engineering_submittal. Business justification: NCRs are raised when submitted materials or shop drawings fail review during the submittal process. Submittal disposition tracking and NCR root cause analysis require traceability back to the engineer',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Needed for Cost Impact Tracking: NCR corrective cost is allocated to a cost code to reflect financial impact in cost reports.',
    `goods_issue_id` BIGINT COMMENT 'Foreign key linking to material.goods_issue. Business justification: Material non-conformance at point of use: NCRs are raised when materials issued to site are found non-conforming during installation (wrong spec, damaged, expired). Linking NCR to goods_issue enables ',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Material rejection workflow: NCRs are raised at goods receipt when delivered materials fail incoming inspection. Linking NCR to goods receipt enables return-to-vendor processing, goods receipt reversa',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Required for traceability: NCR investigations often trigger safety incident investigations; linking enables root‑cause analysis and regulatory reporting.',
    `itp_line_id` BIGINT COMMENT 'Foreign key linking to quality.itp_line. Business justification: An NCR is triggered when a specific ITP line item (hold point, witness point, or review point) fails its acceptance criteria. itp_line has ncr_trigger_criteria attribute, confirming this business rela',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.master. Business justification: Material NCR reporting: NCRs in construction frequently reference the specific material type that failed (e.g., Grade 500N rebar does not meet specification). FK to material.master enables NCR freq',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: NCRs are raised during specific project phases. Phase-level NCR KPI reporting (NCR count per phase, phase quality score) is a standard construction QMS metric used in phase gate reviews and client rep',
    `rfi_id` BIGINT COMMENT 'Foreign key linking to design.rfi. Business justification: NCR disposition frequently requires design clarification via RFI — the NCR cannot be closed until the RFI response resolves the non-conformance. NCR-to-RFI traceability is a standard QA audit requirem',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: NCRs affecting safety-critical systems require a risk assessment before disposition is approved. Construction QMS procedures mandate risk assessment linkage for NCRs on structural, pressure, or electr',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Assigns each NCR to the responsible vendor, essential for vendor performance evaluation and corrective action.',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: NCRs are raised against specific work fronts where non-conformances occur. This link enables the NCR register to be filtered by work front for defect density analysis and corrective action tracking — ',
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
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: In construction HSE management (Intelex), corrective actions are raised directly against safety incidents as a regulatory requirement (OSHA, WHS Act). Direct link supports incident corrective action t',
    `ncr_id` BIGINT COMMENT 'Reference to the parent Non-Conformance Report that triggered this corrective or preventive action.',
    `rfi_id` BIGINT COMMENT 'Foreign key linking to design.rfi. Business justification: corrective_action has attribute requires_design_change — when true, an RFI is raised to the design team. Corrective action closure tracking requires the linked RFI response. This is a named step in ',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Corrective actions are executed against specific WBS work packages in construction. WBS-level corrective action tracking enables cost-of-quality reporting, rework cost allocation to WBS, and earned va',
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
    `asset_category_id` BIGINT COMMENT 'Foreign key linking to equipment.asset_category. Business justification: Quality checklists are defined per equipment category (e.g., crane pre-use checklist, excavator daily inspection checklist). Linking checklist to asset_category enables automatic checklist assignment ',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Inspection checklists in construction are phase-specific (foundation phase, structural phase, commissioning phase). Phase-level checklist management enables QA planning per phase gate and supports pha',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Quality checklists for high-risk activities are developed from risk assessments — the safety_requirements and acceptance_criteria fields on checklist are derived from the risk assessment control measu',
    `acceptance_criteria` STRING COMMENT 'Overall acceptance criteria for the checklist (e.g., All critical items must pass, 95% of items must pass with no critical failures).',
    `activity_type` STRING COMMENT 'Classification of the construction activity type that this checklist applies to, aligned with WBS (Work Breakdown Structure) and ITP (Inspection and Test Plan) categories. [ENUM-REF-CANDIDATE: concrete_pour|rebar_placement|formwork_erection|waterproofing|structural_steel_erection|welding|mechanical_installation|electrical_installation|piping_installation|excavation|backfill|piling|painting|insulation|commissioning|other — 16 candidates stripped; promote to reference product]',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`test_certificate` (
    `test_certificate_id` BIGINT COMMENT 'Primary key for test_certificate',
    `concrete_pour_id` BIGINT COMMENT 'Foreign key linking to site.concrete_pour. Business justification: Concrete cylinder test certificates are issued per pour. Linking test_certificate to concrete_pour enables strength result traceability back to the specific pour event — a mandatory requirement for st',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Material testing costs (lab fees, third-party certification) are tracked against project cost codes in construction QA cost reporting. A QA manager and project controller both need test certificate co',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Material receiving QA process: test certificates are generated at goods receipt to certify delivered materials meet spec before storage/use. Construction QA managers require traceability from test cer',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to quality.inspection. Business justification: A material test certificate is often generated as a result of a physical inspection or testing event. Linking test_certificate to the inspection that triggered or verified the test provides full QA/QC',
    `itp_id` BIGINT COMMENT 'Foreign key linking to quality.itp. Business justification: Test certificates are often issued for ITP items and may be associated with NCRs; linking enables direct lookup.',
    `itp_line_id` BIGINT COMMENT 'Foreign key linking to quality.itp_line. Business justification: A test certificate is the documented evidence for a specific ITP line item test activity. test_certificate already has itp_id (linking to the ITP master), but adding itp_line_id provides granular trac',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.master. Business justification: Material certification management: test certificates are issued for specific material types/grades (e.g., Grade 500N rebar, C40 concrete). FK to material.master enables all valid certificates for thi',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: Test certificates may also be linked to NCRs for traceability.',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Test certificates are issued during specific project phases. Phase-level material certification registers are required for handover documentation packages and regulatory compliance — a standard constr',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Vendor material traceability: construction QA requires test certificates linked to the supplying vendor for vendor performance scoring, material traceability reports, and regulatory compliance. Vendor',
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
    `pass_fail_status` STRING COMMENT 'Overall determination of whether the tested material meets the specification requirements. Conditional pass indicates minor deviations requiring engineering review.. Valid values are `pass|fail|conditional_pass|pending_review`',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`punch_list` (
    `punch_list_id` BIGINT COMMENT 'Unique identifier for the punch list record. Primary key for the punch list entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Client oversees punch‑list during project handover; required for client‑focused punch‑list status reports.',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Punch lists are phase-specific in construction (commissioning phase punch list, handover phase punch list). Phase-level punch list closeout tracking is a standard construction handover management repo',
    `actual_closeout_date` DATE COMMENT 'The actual date on which the punch list was fully closed, indicating all items have been resolved and accepted. Nullable until closure is achieved.',
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
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Punch items often generate change order costs; linking each punch_item to a cost code enables precise cost tracking for close‑out.',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to quality.inspection. Business justification: A punch item is typically identified during an inspection event. Linking punch_item to the originating inspection provides full traceability: which inspection identified this defect/incomplete work. i',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: A punch item can be directly linked to a Non-Conformance Report when the defect or incomplete work has been formally documented as an NCR. This is a standard construction QA/QC practice where punch it',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Punch item rectification during commissioning frequently requires a PTW (confined space, hot work, energized systems). Construction commissioning procedures mandate PTW reference before executing Cate',
    `punch_list_id` BIGINT COMMENT 'Reference to the parent punch list record that contains this item. Links the item to the overall punch list inspection event.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Punch items can be assigned to a crew for coordinated resolution; supports crew workload tracking.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Safety-critical punch items (Category A — affecting personnel safety or system integrity) reference risk assessments to determine priority, required controls, and PTW requirements for rectification. S',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Punch items are identified at specific work fronts during pre-handover inspections. A direct FK enables punch item closeout tracking by work front, which is a standard handover management process in c',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`quality`.`plan` (
    `plan_id` BIGINT COMMENT 'Unique identifier for the Project Quality Plan (PQP). Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Quality plans require formal client approval as a contractual obligation (client_approval_required, client_approval_date already present). Linking quality_plan to client.account enables client-specifi',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Construction QA/QC plans have dedicated budget allocations tracked against specific cost codes. Project controllers report QA cost performance (actual vs. budgeted) by cost code. A quality manager and',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Quality plans in construction are phase-specific — separate QPs govern civil, structural, MEP, and commissioning phases. Phase-level quality plan approval is a standard phase gate requirement in const',
    `applicable_standards` STRING COMMENT 'List of quality standards, codes, and specifications applicable to the project (e.g., ISO 9001, ASTM, ACI, AISC, project-specific specifications).',
    `approval_date` DATE COMMENT 'Date when the quality plan was formally approved by authorized personnel.',
    `approval_status` STRING COMMENT 'Approval state of the quality plan by client and internal stakeholders.. Valid values are `pending|approved|rejected|conditional`',
    `approved_by_name` STRING COMMENT 'Name of the individual who formally approved the quality plan for implementation.',
    `approved_by_role` STRING COMMENT 'Organizational role or title of the approver (e.g., Project Director, Quality Director).',
    `audit_schedule_reference` STRING COMMENT 'Reference to the internal and external audit schedule defined for the project.',
    `calibration_procedure_reference` STRING COMMENT 'Reference to the procedure for calibration and maintenance of inspection, measuring, and test equipment.',
    `client_approval_date` DATE COMMENT 'Date when the client formally approved the quality plan.',
    `client_approval_required` BOOLEAN COMMENT 'Indicates whether client approval is contractually required for this quality plan.',
    `continuous_improvement_mechanism` STRING COMMENT 'Description of mechanisms for continuous improvement, including lessons learned, corrective actions, and preventive actions.',
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
    CONSTRAINT pk_plan PRIMARY KEY(`plan_id`)
) COMMENT 'Project Quality Plan (PQP) master document defining the overall QA/QC strategy for a specific project. Captures organizational quality responsibilities, applicable standards and codes, inspection regime definitions, document control procedures, audit schedule, NCR procedures, training requirements, and continuous improvement mechanisms. Serves as the top-level quality governance document per ISO 9001 and contract requirements. All ITPs, checklists, and audit programs trace back to this plan.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_construction_v1`.`quality`.`plan`(`plan_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `vibe_construction_v1`.`quality`.`checklist`(`checklist_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `vibe_construction_v1`.`quality`.`checklist`(`checklist_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_itp_line_id` FOREIGN KEY (`itp_line_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp_line`(`itp_line_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_itp_line_id` FOREIGN KEY (`itp_line_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp_line`(`itp_line_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `vibe_construction_v1`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_itp_line_id` FOREIGN KEY (`itp_line_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp_line`(`itp_line_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `vibe_construction_v1`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_punch_list_id` FOREIGN KEY (`punch_list_id`) REFERENCES `vibe_construction_v1`.`quality`.`punch_list`(`punch_list_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_construction_v1`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` SET TAGS ('dbx_subdomain' = 'inspection_planning');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `itp_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection and Test Plan (ITP) ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `applicable_standards` SET TAGS ('dbx_business_glossary_term' = 'Applicable Quality Standards');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'ITP Approval Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection and Test Plan (ITP) Approval Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'ITP Approved By');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `defect_liability_period_days` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period (DLP) Days');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `document_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Location');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'ITP Effective Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'ITP Expiry Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `fat_required` SET TAGS ('dbx_business_glossary_term' = 'Factory Acceptance Test (FAT) Required Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `hold_point_required` SET TAGS ('dbx_business_glossary_term' = 'Hold Point Required Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_business_glossary_term' = 'Inspection Scope');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `itp_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection and Test Plan (ITP) Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `itp_number` SET TAGS ('dbx_value_regex' = '^ITP-[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `material_test_certificate_required` SET TAGS ('dbx_business_glossary_term' = 'Material Test Certificate (MTC) Required Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `ndt_method_required` SET TAGS ('dbx_business_glossary_term' = 'Non-Destructive Testing (NDT) Method Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `prepared_by` SET TAGS ('dbx_business_glossary_term' = 'ITP Prepared By');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `qc_inspector_responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Inspector Responsible Party');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'ITP Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `review_point_required` SET TAGS ('dbx_business_glossary_term' = 'Review Point Required Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'ITP Reviewed By');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Document Revision Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Document Revision Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `revision_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,3}$');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `sat_required` SET TAGS ('dbx_business_glossary_term' = 'Site Acceptance Test (SAT) Required Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `test_method_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Method Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Inspection and Test Plan (ITP) Title');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `wbs_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}(.[A-Z0-9]{2,6}){0,5}$');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `witness_point_required` SET TAGS ('dbx_business_glossary_term' = 'Witness Point Required Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ALTER COLUMN `work_package_description` SET TAGS ('dbx_business_glossary_term' = 'Work Package Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` SET TAGS ('dbx_subdomain' = 'inspection_planning');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `itp_line_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection and Test Plan (ITP) Line ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `asset_category_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Category Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `itp_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection and Test Plan (ITP) ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `applicable_standard` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standard');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `calibration_required` SET TAGS ('dbx_business_glossary_term' = 'Calibration Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `client_witness_required` SET TAGS ('dbx_business_glossary_term' = 'Client Witness Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `consultant_witness_required` SET TAGS ('dbx_business_glossary_term' = 'Consultant Witness Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `cost_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Code');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `environmental_conditions` SET TAGS ('dbx_business_glossary_term' = 'Environmental Conditions');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Hours');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `hold_point_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Point Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `hold_point_type` SET TAGS ('dbx_value_regex' = 'hold|witness|review|surveillance');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_business_glossary_term' = 'Inspection Stage');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `itp_line_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `itp_line_status` SET TAGS ('dbx_value_regex' = 'planned|ready|in_progress|completed|waived|cancelled');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `ncr_trigger_criteria` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Trigger Criteria');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `notification_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Notification Lead Time Hours');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `reference_document` SET TAGS ('dbx_business_glossary_term' = 'Reference Document');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `required_documentation` SET TAGS ('dbx_business_glossary_term' = 'Required Documentation');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `responsible_discipline` SET TAGS ('dbx_business_glossary_term' = 'Responsible Discipline');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `safety_requirements` SET TAGS ('dbx_business_glossary_term' = 'Safety Requirements');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `sampling_plan` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `sequence_dependency` SET TAGS ('dbx_business_glossary_term' = 'Sequence Dependency');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Superseded Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `test_equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ALTER COLUMN `third_party_witness_required` SET TAGS ('dbx_business_glossary_term' = 'Third Party Witness Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` SET TAGS ('dbx_subdomain' = 'inspection_planning');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Template ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `concrete_pour_id` SET TAGS ('dbx_business_glossary_term' = 'Concrete Pour Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `itp_line_id` SET TAGS ('dbx_business_glossary_term' = 'Itp Line Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `checklist_template_name` SET TAGS ('dbx_business_glossary_term' = 'Checklist Template Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `checklist_version` SET TAGS ('dbx_business_glossary_term' = 'Checklist Version');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `defects_identified` SET TAGS ('dbx_business_glossary_term' = 'Defects Identified');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Time');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Humidity Percentage');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `inspector_certification` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `inspector_signature_captured` SET TAGS ('dbx_business_glossary_term' = 'Inspector Signature Captured Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `items_failed` SET TAGS ('dbx_business_glossary_term' = 'Items Failed');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `items_not_applicable` SET TAGS ('dbx_business_glossary_term' = 'Items Not Applicable');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `items_passed` SET TAGS ('dbx_business_glossary_term' = 'Items Passed');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Inspection Location Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Location Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'site|factory|workshop|laboratory|warehouse|offsite');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `ncr_raised` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Raised Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `observations` SET TAGS ('dbx_business_glossary_term' = 'Inspection Observations');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_business_glossary_term' = 'Overall Inspection Outcome');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `photo_count` SET TAGS ('dbx_business_glossary_term' = 'Photo Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `reinspection_date` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `reinspection_required` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Required Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Specification Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Time');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature in Celsius');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `total_check_items` SET TAGS ('dbx_business_glossary_term' = 'Total Check Items');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `witness_signature_captured` SET TAGS ('dbx_business_glossary_term' = 'Witness Signature Captured Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ALTER COLUMN `work_package_reference` SET TAGS ('dbx_business_glossary_term' = 'Work Package Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` SET TAGS ('dbx_subdomain' = 'defect_control');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Backcharge Invoice Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Project Change Order Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `engineering_submittal_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Submittal Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `goods_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `itp_line_id` SET TAGS ('dbx_business_glossary_term' = 'Itp Line Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `rfi_id` SET TAGS ('dbx_business_glossary_term' = 'Rfi Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `ncr_category` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Category');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `ncr_category` SET TAGS ('dbx_value_regex' = 'material|workmanship|design|documentation|dimensional|procedural');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `client_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Client Notification Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `client_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Client Notification Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `closed_by` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Closed By');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Closure Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `corrective_action_responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Responsible Party');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `corrective_action_target_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Target Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `cost_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Currency');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `cost_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `ncr_description` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Disposition');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'accept_as_is|rework|repair|reject|scrap|use_as_is_with_concession');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `disposition_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Disposition Approved By');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `disposition_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Approved Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `disposition_justification` SET TAGS ('dbx_business_glossary_term' = 'Disposition Justification');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `effectiveness_review_comments` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Comments');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `estimated_cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Impact');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `estimated_cost_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `hold_release_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Identified Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Location Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `ncr_number` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `ncr_number` SET TAGS ('dbx_value_regex' = '^NCR-[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `ncr_status` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `preventive_action_description` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `preventive_action_responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Responsible Party');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `quantity_affected` SET TAGS ('dbx_business_glossary_term' = 'Quantity Affected');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Reported By');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `reported_by_organization` SET TAGS ('dbx_business_glossary_term' = 'Reported By Organization');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Severity');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `verification_performed_by` SET TAGS ('dbx_business_glossary_term' = 'Verification Performed By');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `verification_result` SET TAGS ('dbx_business_glossary_term' = 'Verification Result');
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ALTER COLUMN `verification_result` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` SET TAGS ('dbx_subdomain' = 'defect_control');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Identifier');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `rfi_id` SET TAGS ('dbx_business_glossary_term' = 'Rfi Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_verification|verified|closed|cancelled');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action / Preventive Action (CAPA) Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|containment|interim');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Actual Cost');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Action Assigned Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `client_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Cost Estimate');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `effectiveness_review_comments` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Comments');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `effectiveness_review_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `effectiveness_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Outcome');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `effectiveness_review_outcome` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|pending_review');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `is_systemic_issue` SET TAGS ('dbx_business_glossary_term' = 'Systemic Issue Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Priority');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `recurrence_prevention_measures` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Prevention Measures');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `requires_client_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Client Approval Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `requires_design_change` SET TAGS ('dbx_business_glossary_term' = 'Requires Design Change Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA)');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'inspection|testing|document_review|audit|site_observation|measurement');
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ALTER COLUMN `verified_by_name` SET TAGS ('dbx_business_glossary_term' = 'Verified By Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` SET TAGS ('dbx_subdomain' = 'inspection_planning');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `asset_category_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Category Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|superseded|obsolete');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `average_pass_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Pass Rate (Percentage)');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `checklist_code` SET TAGS ('dbx_business_glossary_term' = 'Checklist Code');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `checklist_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `critical_items_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Items Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `checklist_description` SET TAGS ('dbx_business_glossary_term' = 'Checklist Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Discipline');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (Minutes)');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `hold_point_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Point Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_business_glossary_term' = 'Inspection Stage');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_value_regex' = 'pre_work|during_work|post_work|hold_point|witness_point');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `checklist_name` SET TAGS ('dbx_business_glossary_term' = 'Checklist Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `ncr_trigger_threshold` SET TAGS ('dbx_business_glossary_term' = 'NCR (Non-Conformance Report) Trigger Threshold');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `reference_documents` SET TAGS ('dbx_business_glossary_term' = 'Reference Documents');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `required_equipment` SET TAGS ('dbx_business_glossary_term' = 'Required Equipment');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `required_qualifications` SET TAGS ('dbx_business_glossary_term' = 'Required Qualifications');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `revision_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `safety_requirements` SET TAGS ('dbx_business_glossary_term' = 'Safety Requirements');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `total_check_items` SET TAGS ('dbx_business_glossary_term' = 'Total Check Items');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `witness_point_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Point Flag');
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` SET TAGS ('dbx_subdomain' = 'inspection_planning');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `test_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Test Certificate Identifier');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `concrete_pour_id` SET TAGS ('dbx_business_glossary_term' = 'Concrete Pour Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `itp_id` SET TAGS ('dbx_business_glossary_term' = 'Itp Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `itp_line_id` SET TAGS ('dbx_business_glossary_term' = 'Itp Line Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `certificate_type` SET TAGS ('dbx_value_regex' = 'MTC|laboratory_test|factory_test|site_test|third_party_test|supplier_certificate');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `delivery_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Lot Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `heat_number` SET TAGS ('dbx_business_glossary_term' = 'Heat Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `issuing_laboratory` SET TAGS ('dbx_business_glossary_term' = 'Issuing Laboratory');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `laboratory_accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Accreditation Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|pending_review');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `sampling_date` SET TAGS ('dbx_business_glossary_term' = 'Sampling Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `sampling_location` SET TAGS ('dbx_business_glossary_term' = 'Sampling Location');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `specification_requirement` SET TAGS ('dbx_business_glossary_term' = 'Specification Requirement');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `technician_name` SET TAGS ('dbx_business_glossary_term' = 'Technician Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `technician_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `test_parameters` SET TAGS ('dbx_business_glossary_term' = 'Test Parameters');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `test_results` SET TAGS ('dbx_business_glossary_term' = 'Test Results');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `test_standard` SET TAGS ('dbx_business_glossary_term' = 'Test Standard');
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ALTER COLUMN `work_package_code` SET TAGS ('dbx_business_glossary_term' = 'Work Package Code');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` SET TAGS ('dbx_subdomain' = 'defect_control');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `punch_list_id` SET TAGS ('dbx_business_glossary_term' = 'Punch List ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `actual_closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Close-Out Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `closed_items_count` SET TAGS ('dbx_business_glossary_term' = 'Closed Items Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `critical_items_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Items Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Discipline');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `dlp_commencement_gate` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period (DLP) Commencement Gate');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `handover_gate` SET TAGS ('dbx_business_glossary_term' = 'Handover Gate');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `punch_list_name` SET TAGS ('dbx_business_glossary_term' = 'Punch List Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `open_items_count` SET TAGS ('dbx_business_glossary_term' = 'Open Items Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `prepared_by` SET TAGS ('dbx_business_glossary_term' = 'Prepared By');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Punch List Priority');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `project_area` SET TAGS ('dbx_business_glossary_term' = 'Project Area');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `punch_list_number` SET TAGS ('dbx_business_glossary_term' = 'Punch List Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `punch_list_status` SET TAGS ('dbx_business_glossary_term' = 'Punch List Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `punch_list_status` SET TAGS ('dbx_value_regex' = 'draft|open|in_progress|under_review|closed|cancelled');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Type');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_value_regex' = 'general_contractor|subcontractor|supplier|joint_venture|client|consultant');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Specification Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `target_closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Target Close-Out Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `total_items_count` SET TAGS ('dbx_business_glossary_term' = 'Total Items Count');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Punch List Creation Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` SET TAGS ('dbx_subdomain' = 'defect_control');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `punch_item_id` SET TAGS ('dbx_business_glossary_term' = 'Punch Item ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `punch_list_id` SET TAGS ('dbx_business_glossary_term' = 'Punch List ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `punch_item_category` SET TAGS ('dbx_business_glossary_term' = 'Punch Item Category');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `punch_item_category` SET TAGS ('dbx_value_regex' = 'structural|mep|architectural|civil|finishes|landscaping');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `client_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Client Representative Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'Closure Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `closure_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|rejected|deferred');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `cost_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `deferred_to_dlp` SET TAGS ('dbx_business_glossary_term' = 'Deferred to DLP (Defects Liability Period)');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `dlp_end_date` SET TAGS ('dbx_business_glossary_term' = 'DLP (Defects Liability Period) End Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `identified_by` SET TAGS ('dbx_business_glossary_term' = 'Identified By');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Punch Item Description');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `item_number` SET TAGS ('dbx_business_glossary_term' = 'Punch Item Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Punch Item Location');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `photo_reference` SET TAGS ('dbx_business_glossary_term' = 'Photo Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Punch Item Priority');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `punch_item_status` SET TAGS ('dbx_business_glossary_term' = 'Punch Item Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `punch_item_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|verified|closed|rejected');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ALTER COLUMN `verification_inspector` SET TAGS ('dbx_business_glossary_term' = 'Verification Inspector');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` SET TAGS ('dbx_subdomain' = 'inspection_planning');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Plan ID');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `applicable_standards` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standards');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `approved_by_role` SET TAGS ('dbx_business_glossary_term' = 'Approved By Role');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `audit_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Schedule Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `calibration_procedure_reference` SET TAGS ('dbx_business_glossary_term' = 'Calibration Procedure Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `client_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `client_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Required');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `continuous_improvement_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Continuous Improvement Mechanism');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `defect_liability_period_days` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period (DLP) Days');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `document_control_procedure` SET TAGS ('dbx_business_glossary_term' = 'Document Control Procedure');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `handover_quality_requirements` SET TAGS ('dbx_business_glossary_term' = 'Handover Quality Requirements');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `inspection_regime_summary` SET TAGS ('dbx_business_glossary_term' = 'Inspection Regime Summary');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `itp_register_reference` SET TAGS ('dbx_business_glossary_term' = 'Inspection and Test Plan (ITP) Register Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `material_control_procedure` SET TAGS ('dbx_business_glossary_term' = 'Material Control Procedure');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `ncr_procedure_reference` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Procedure Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `organizational_structure` SET TAGS ('dbx_business_glossary_term' = 'Organizational Structure');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Project Quality Plan (PQP) Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|archived');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `prepared_by_name` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `prepared_by_role` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Role');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `quality_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Manager Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `quality_objectives` SET TAGS ('dbx_business_glossary_term' = 'Quality Objectives');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `quality_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Quality Policy Reference');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `reviewed_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Name');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `reviewed_by_role` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Role');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `scope_of_work` SET TAGS ('dbx_business_glossary_term' = 'Scope of Work');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `subcontractor_quality_management` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor Quality Management');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Quality Plan Title');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `training_requirements` SET TAGS ('dbx_business_glossary_term' = 'Training Requirements');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Number');
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
