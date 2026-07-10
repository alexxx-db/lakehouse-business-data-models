-- Schema for Domain: quality | Business: Manufacturing | Version: v2_mvm
-- Generated on: 2026-07-03 07:50:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`quality` COMMENT 'Quality assurance and control domain encompassing SPC, Cp/Cpk indices, inspection plans, NCRs, CAPAs, PPAP, APQP, and FMEA records. Manages in-process and final inspection results, supplier quality audits, compliance testing, and regulatory conformance data aligned with ISO 9001 and SAP QM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` (
    `inspection_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the inspection plan record. Primary key for the inspection_plan data product in the quality domain.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Inspection plans are created for each component to define inspection characteristics; linking ensures traceability from plan to the exact component inspected.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Customer‑Specific Inspection Plan process requires linking each inspection_plan to the owning customer_account for contract compliance reporting.',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: eco_number exists as a denormalized field on inspection_plan, signaling this relationship. When an ECO is issued, affected inspection plans must be reviewed and updated. Replacing the free-text eco_nu',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_specification. Business justification: Inspection plans are derived directly from engineering specifications — tolerances, acceptance criteria, and test methods originate in the spec. Quality engineers build inspection plans by translating',
    `fmea_id` BIGINT COMMENT 'Foreign key linking to quality.fmea. Business justification: inspection_plan has a denormalized fmea_reference (STRING) field that references the FMEA driving the inspection requirements. Adding a proper FK fmea_id normalizes this relationship — an inspection p',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Inspection plans are revision-specific: APQP and PPAP require that inspection criteria match the exact engineering revision. When an ECO changes a revision, quality must update the inspection plan. A ',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Inspection plans are defined per product SKU for quality control; linking enables plan retrieval by SKU in the Inspection Planning process.',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to production.work_center. Business justification: Inspection plans are authored for specific work centers (in-process inspection). The existing work_center_code plain attribute is a denormalized reference to production.work_center. A proper FK enab',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection plan was formally approved for use. Provides an audit trail for ISO 9001 document control and regulatory compliance.',
    `apqp_phase` STRING COMMENT 'APQP phase during which this inspection plan was developed or is applicable. Phase 1: Plan and Define; Phase 2: Product Design and Development; Phase 3: Process Design and Development; Phase 4: Product and Process Validation; Phase 5: Feedback, Assessment and Corrective Action.. Valid values are `phase_1|phase_2|phase_3|phase_4|phase_5`',
    `aql_level` DECIMAL(18,2) COMMENT 'Acceptable Quality Level expressed as a percentage defective, defining the maximum tolerable defect rate for the sampling plan. Used in conjunction with ISO 2859-1 / ANSI Z1.4 sampling tables.',
    `characteristic_count` STRING COMMENT 'Total number of inspection characteristics (measurement parameters) defined within this inspection plan. Provides a quick summary of plan complexity for scheduling and resource planning.',
    `characteristic_unit` STRING COMMENT 'Unit of measure for the inspection characteristic tolerance limits and target value (e.g., mm, µm, N, bar, °C, %). Aligns with SAP QM master inspection characteristic unit.',
    `control_method_code` STRING COMMENT 'Code identifying the measurement or control method used during inspection (e.g., visual, dimensional, functional, chemical, SPC chart). References the SAP QM master inspection characteristic control indicator.',
    `control_plan_reference` STRING COMMENT 'Document number of the associated APQP Control Plan that this inspection plan implements. The control plan defines the process controls and reaction plans linked to inspection characteristics.',
    `cpk_minimum` DECIMAL(18,2) COMMENT 'Minimum acceptable Cpk (Process Capability Index) value required for this inspection characteristic. Typically 1.33 for standard processes and 1.67 for safety-critical characteristics per PPAP requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection plan record was first created in the source system. Provides audit trail for data governance and ISO 9001 document control.',
    `customer_specific_requirement` BOOLEAN COMMENT 'Indicates whether this inspection plan was created or modified to satisfy a specific customer quality requirement (CSR) beyond standard internal or regulatory requirements. Relevant for OEM (Original Equipment Manufacturer) supply relationships.',
    `effective_from` DATE COMMENT 'Date from which this inspection plan version becomes valid and applicable for production inspection operations. Aligns with SAP QM validity start date.',
    `effective_until` DATE COMMENT 'Date on which this inspection plan version expires and is no longer valid for new inspection lots. Null indicates the plan is open-ended with no scheduled expiry. Aligns with SAP QM validity end date.',
    `equipment_category` STRING COMMENT 'Category of measurement equipment or test instrument required to perform the inspection. Used for calibration scheduling and resource allocation in Maximo Asset Management.. Valid values are `gauge|cmm|vision_system|test_bench|manual|spc_tool`',
    `inspection_method_code` STRING COMMENT 'Reference to the standardized inspection method or test procedure document used to perform the inspection. Links to the SAP QM inspection method master record.',
    `inspection_scope` STRING COMMENT 'Defines the intensity of inspection applied: full (normal), reduced (lower frequency for trusted suppliers/processes), tightened (increased scrutiny after failures), or skip-lot (periodic sampling). Aligned with SPC-driven dynamic inspection level adjustments.. Valid values are `full|reduced|tightened|skip_lot`',
    `inspection_stage` STRING COMMENT 'Stage in the production or supply chain process at which the inspection is performed. Incoming covers receiving inspection; in-process covers WIP (Work In Progress) checks; final covers end-of-line; outgoing covers pre-shipment; skip indicates skip-lot logic.. Valid values are `incoming|in_process|final|outgoing|skip`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection plan record was last updated in the source system. Used for change tracking, data lineage, and incremental lakehouse ingestion.',
    `long_text_description` STRING COMMENT 'Detailed narrative description of the inspection plan scope, special instructions, safety precautions, and any additional context required by the inspector. Corresponds to SAP QM long text on the task list header.',
    `lower_tolerance_limit` DECIMAL(18,2) COMMENT 'Lower specification limit for the primary inspection characteristic. Values below this limit result in a non-conformance. Used in SPC and Cp/Cpk capability index calculations.',
    `next_review_date` TIMESTAMP COMMENT 'Date by which the inspection plan must be reviewed and revalidated to ensure continued suitability and compliance with current product specifications and regulatory requirements.',
    `operation_number` DECIMAL(18,2) COMMENT 'Routing operation number within the inspection plan, corresponding to the SAP QM task list operation (PLPO.VORNR). Defines the sequence of inspection steps within the plan.',
    `plan_name` STRING COMMENT 'Human-readable name or short description of the inspection plan, identifying the product, process, or operation it governs.',
    `plan_number` STRING COMMENT 'Externally-known alphanumeric identifier for the inspection plan, aligned with SAP QM plan group and plan group counter. Used for cross-system reference and document control.. Valid values are `^QP-[A-Z0-9]{2,10}-[0-9]{4,8}$`',
    `plan_status` STRING COMMENT 'Current lifecycle state of the inspection plan. Controls whether the plan is available for use in production inspection operations. Draft plans are under development; active plans are approved for use; obsolete plans are superseded.. Valid values are `draft|active|inactive|obsolete|under_review`',
    `plan_type` STRING COMMENT 'Classification of the inspection plan by its operational purpose. Covers in-process, final inspection, receiving inspection, supplier audit, PPAP (Production Part Approval Process), APQP (Advanced Product Quality Planning), and first article inspection types. [ENUM-REF-CANDIDATE: in_process|final_inspection|receiving|supplier_audit|ppap|apqp|first_article — promote to reference product]',
    `plan_version` STRING COMMENT 'Version or revision number of the inspection plan, corresponding to the SAP QM plan group counter. Tracks engineering changes and revisions aligned with ECO/ECN processes.. Valid values are `^[0-9]{2}$`',
    `ppap_level` DECIMAL(18,2) COMMENT 'PPAP submission level (1–5) required for this inspection plan, per AIAG PPAP standard. Level 1 requires only a Part Submission Warrant; Level 3 is the default full submission; Level 5 requires records reviewed at the manufacturing site.',
    `product_group_code` STRING COMMENT 'SAP material group or product family code to which this inspection plan applies. Enables grouping of inspection plans by product category for reporting and analytics.',
    `revision_reason` STRING COMMENT 'Description of the reason for the current plan version, such as an ECO (Engineering Change Order), CAPA (Corrective and Preventive Action) outcome, customer complaint, or regulatory update.',
    `sample_size` STRING COMMENT 'Number of units to be drawn from the inspection lot for evaluation. Determined by the sampling procedure and AQL level. A value of zero indicates 100% inspection.',
    `sample_size_unit` STRING COMMENT 'Unit of measure for the sample size quantity (e.g., EA for each/piece, KG for kilogram, M for meter). Aligns with SAP base unit of measure for the material. [ENUM-REF-CANDIDATE: EA|PC|KG|M|L|M2|M3 — 7 candidates stripped; promote to reference product]',
    `sampling_procedure_code` STRING COMMENT 'Code referencing the statistical sampling procedure applied in this inspection plan, including sample size, acceptance number, and rejection number per AQL (Acceptable Quality Level) tables.',
    `spc_enabled` BOOLEAN COMMENT 'Indicates whether SPC (Statistical Process Control) charting and Cp/Cpk capability monitoring are activated for this inspection plan. When true, measurement results feed into control charts and process capability analysis.',
    `target_value` DECIMAL(18,2) COMMENT 'Nominal or target value for the primary inspection characteristic. Represents the ideal measurement around which tolerances are defined. Used as the centerline reference in SPC control charts.',
    `upper_tolerance_limit` DECIMAL(18,2) COMMENT 'Upper specification limit for the primary inspection characteristic. Values exceeding this limit result in a non-conformance. Used in SPC (Statistical Process Control) and Cp/Cpk capability index calculations.',
    `usage_decision_code` STRING COMMENT 'SAP QM usage decision code that defines the default disposition action (accept, reject, rework) applied when inspection results meet or fail acceptance criteria.',
    `created_by` STRING COMMENT 'User ID of the quality engineer or planner who originally created this inspection plan record in SAP QM or the source system.',
    CONSTRAINT pk_inspection_plan PRIMARY KEY(`inspection_plan_id`)
) COMMENT 'Master definition of inspection plans aligned with SAP QM, specifying inspection characteristics, sampling procedures, control methods, and acceptance criteria for in-process and final inspection operations. Covers PPAP, APQP, and routine production inspection plans per ISO 9001 requirements.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` (
    `inspection_lot_id` BIGINT COMMENT 'Unique system-generated surrogate key identifying a single inspection lot record in the quality execution system. Primary key for the inspection_lot entity.',
    `contract_release_order_id` BIGINT COMMENT 'Foreign key linking to procurement.contract_release_order. Business justification: In manufacturing, deliveries against scheduling agreements/contract releases trigger inspection lots. Quality teams must trace nonconformances to the specific release order for supplier penalty enforc',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Customer Inspection Lot Reporting mandates associating each inspection_lot with the customer_account to deliver lot‑level quality results to the customer.',
    `inspection_plan_id` BIGINT COMMENT 'Reference to the inspection plan (control plan) that defines the inspection operations, characteristics, sampling procedures, and acceptance criteria to be executed for this lot. Aligns with SAP QM inspection plan assignment.',
    `ncr_id` BIGINT COMMENT 'Reference to the Non-Conformance Report (NCR) record created as a result of this inspection lots non-conformance or reject disposition. Enables traceability from inspection event to corrective action workflow.',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to supply.planned_order. Business justification: Inspection lots are created as quality gates for planned orders before conversion to production/purchase orders. Enables quality hold/release workflow where planned orders cannot convert until inspect',
    `po_line_item_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line_item. Business justification: Incoming goods inspection in manufacturing is performed at PO line item level (specific material, quantity, delivery). Quality engineers must trace inspection results and disposition decisions to the ',
    `material_master_id` BIGINT COMMENT 'Reference to the material or part master record subject to this inspection lot. Links to the product/material master in SAP MM/PLM for BOM and specification retrieval.',
    `procurement_goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt document (SAP material document) that triggered this incoming inspection lot. Applicable for inspection types 01 (GR from PO) and 04 (GR from Production Order). Enables traceability from inspection to inventory movement.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order associated with this inspection lot, applicable for incoming goods receipt inspections from suppliers. Links to SAP MM purchasing documents.',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Inspection lots must reference the engineering revision of the material being inspected to confirm the correct inspection plan and tolerances are applied. revision_level on inspection_lot is a denorma',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Inspection lot must be linked to the physical storage location for traceability in the warehouse inspection process, required by ISO 9001 audit.',
    `work_center_id` BIGINT COMMENT 'Reference to the work center or production cell where the in-process inspection is performed. Applicable for in-process and milestone inspection types. Links to SAP PP work center master.',
    `certificate_number` STRING COMMENT 'Reference number of the quality certificate or Certificate of Conformance (CoC) issued for this inspection lot upon acceptance. Supports customer documentation requirements and regulatory compliance traceability.',
    `certificate_of_conformance_required` BOOLEAN COMMENT 'Indicates whether a Certificate of Conformance (CoC) or quality certificate must be generated and issued upon acceptance of this inspection lot. Driven by customer contract requirements or regulatory mandates.',
    `created_timestamp` TIMESTAMP COMMENT 'Audit timestamp recording when this inspection lot record was first persisted in the data platform (Silver layer). Used for data lineage and audit trail compliance.',
    `defect_count` STRING COMMENT 'Total number of defects or non-conformances detected across all inspection characteristics within this lot. Used for defect rate calculation, SPC analysis, and NCR triggering thresholds.',
    `disposition_by` STRING COMMENT 'User ID or name of the quality engineer or authorized personnel who recorded the usage decision and disposition for this inspection lot. Supports accountability and audit trail requirements.',
    `disposition_code` STRING COMMENT 'SAP QM usage decision code (e.g., A1=Accept, R1=Reject, R2=Rework, S1=Scrap) providing a standardized coded classification of the disposition decision for system processing and reporting.',
    `disposition_decision` STRING COMMENT 'Final disposition decision made upon completion of inspection results evaluation. Determines the fate of the inspected material: accept = material released to stock/use; reject = material blocked/returned; rework = material sent for corrective rework; scrap = material scrapped; conditional_release = accepted with documented deviations/concessions.. Valid values are `accept|reject|rework|scrap|conditional_release`',
    `disposition_timestamp` TIMESTAMP COMMENT 'Date and time when the usage decision (disposition) was formally recorded in the quality management system. Marks the closure of the active inspection phase and triggers downstream stock posting or NCR creation.',
    `dynamic_modification_rule` STRING COMMENT 'Code or name of the dynamic modification rule applied to automatically adjust the inspection level (normal/tightened/reduced/skip) based on cumulative quality history for this material-supplier or material-plant combination. Aligns with SAP QM dynamic modification.',
    `inspection_end_timestamp` TIMESTAMP COMMENT 'Date and time when all inspection activities and results recording were completed for this lot. Combined with inspection_start_timestamp to compute inspection cycle time (Lead Time metric).',
    `inspection_level` DECIMAL(18,2) COMMENT 'Current inspection severity level applied to this lot based on the supplier or process quality history. normal = standard AQL sampling; tightened = increased scrutiny due to recent failures; reduced = relaxed sampling due to consistent quality; skip = lot accepted without inspection based on skip-lot qualification.',
    `inspection_method` STRING COMMENT 'Primary inspection method applied to this lot: visual = visual examination; dimensional = measurement against dimensional tolerances; functional = operational/performance testing; destructive = destructive testing (sample consumed); non_destructive = NDT methods (ultrasonic, X-ray, etc.); chemical = chemical composition analysis; electrical = electrical parameter testing. [ENUM-REF-CANDIDATE: visual|dimensional|functional|destructive|non_destructive|chemical|electrical — 7 candidates stripped; promote to reference product]',
    `inspection_start_timestamp` TIMESTAMP COMMENT 'Date and time when physical inspection activities commenced for this lot. Used to calculate inspection cycle time and monitor SLA compliance for quality turnaround.',
    `inspection_type_code` STRING COMMENT 'SAP QM inspection type code classifying the origin and nature of the inspection lot. Standard SAP codes: 01=Goods Receipt from Purchase Order (incoming), 04=Goods Receipt from Production Order (final), 05=Goods Issue, 06=Delivery to Customer, 08=In-Process Inspection, 10=Recurring Inspection, 89=RMA/Customer Return Receipt. [ENUM-REF-CANDIDATE: 01|04|05|06|08|10|89 — promote to reference product for full SAP inspection type catalogue]',
    `inspection_type_description` STRING COMMENT 'Business-readable classification of the inspection event type: incoming = supplier goods receipt; in_process = mid-production milestone check; final = post-production completion check; recurring = periodic scheduled inspection; rma_receipt = customer return receipt inspection; delivery = pre-shipment inspection; goods_issue = outbound goods inspection. [ENUM-REF-CANDIDATE: incoming|in_process|final|recurring|rma_receipt|delivery|goods_issue — 7 candidates stripped; promote to reference product]',
    `lot_origin_timestamp` TIMESTAMP COMMENT 'The principal real-world business event timestamp recording when the inspection lot was triggered and created in the quality management system. Distinct from ETL audit timestamps. Aligns with SAP QM lot creation date/time.',
    `lot_quantity` DECIMAL(18,2) COMMENT 'Total quantity of material or units submitted for inspection in this lot. Represents the population from which samples are drawn. Expressed in the base unit of measure of the material.',
    `lot_quantity_uom` STRING COMMENT 'Unit of measure for the inspection lot quantity (e.g., EA=Each, KG=Kilogram, M=Meter, L=Liter, M2=Square Meter). Aligns with SAP base unit of measure from material master.',
    `lot_remarks` STRING COMMENT 'Free-text field for quality engineers to record observations, special conditions, deviations, or contextual notes relevant to this inspection lot that are not captured in structured fields. Supports audit documentation.',
    `lot_status` STRING COMMENT 'Current workflow state of the inspection lot within the quality execution lifecycle. Drives downstream actions: created = lot opened awaiting release; released = inspection authorized to begin; results_recorded = all characteristic results entered; usage_decided = disposition decision made; closed = lot archived. [ENUM-REF-CANDIDATE: created|released|results_recorded|usage_decided|closed — promote to reference product if additional statuses are required]. Valid values are `created|released|results_recorded|usage_decided|closed`',
    `ncr_triggered` BOOLEAN COMMENT 'Indicates whether a Non-Conformance Report (NCR) was automatically or manually triggered as a result of this inspection lots reject disposition or detected non-conformances. True = NCR created; False = no NCR required.',
    `nonconforming_quantity` DECIMAL(18,2) COMMENT 'Quantity of units or material within the lot that failed to meet specification requirements. Expressed in the same unit of measure as lot_quantity. Used to calculate reject rate and determine disposition scope.',
    `overall_result` STRING COMMENT 'Summarized quality outcome of the inspection lot based on all characteristic results evaluated against acceptance criteria. passed = all characteristics within specification; failed = one or more characteristics out of specification; conditionally_passed = passed with documented deviations; pending = results not yet fully recorded.. Valid values are `passed|failed|conditionally_passed|pending`',
    `plant_code` STRING COMMENT 'SAP plant code identifying the manufacturing facility or site where the inspection lot was created and executed. Supports multi-plant quality reporting and compliance.',
    `required_end_date` TIMESTAMP COMMENT 'Target date by which the inspection lot must be completed and a usage decision recorded, as defined by the inspection plan or production schedule. Supports SLA monitoring and escalation management.',
    `rma_number` STRING COMMENT 'Return Material Authorization (RMA) number associated with this inspection lot when triggered by a customer return receipt. Enables traceability from returned goods inspection back to the original customer complaint and RMA process.',
    `sample_drawing_procedure` STRING COMMENT 'Code or name of the sampling procedure applied to determine the sample size for this inspection lot (e.g., AQL 1.0, AQL 2.5, 100% inspection, skip-lot). Derived from the inspection plan sampling scheme.',
    `sample_size` DECIMAL(18,2) COMMENT 'Actual number of units or quantity drawn from the lot for physical inspection, as determined by the sampling procedure in the inspection plan. May differ from the planned sample size if adjustments were made.',
    `serial_number` STRING COMMENT 'Individual unit serial number associated with this inspection lot, applicable when inspection is performed at the serialized unit level (e.g., high-value automation components, safety-critical assemblies). Supports unit-level traceability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Audit timestamp recording when this inspection lot record was most recently modified in the data platform. Supports change detection and incremental processing.',
    CONSTRAINT pk_inspection_lot PRIMARY KEY(`inspection_lot_id`)
) COMMENT 'Transactional inspection lot record representing a single inspection event triggered by goods receipt, production order completion, in-process milestone, periodic schedule, or customer return receipt. Captures lot origin, material/part reference, inspection quantity, inspection type (incoming, in-process, final, recurring, RMA-receipt), current status (created, released, results-recorded, usage-decided), and disposition decision (accept, reject, rework, scrap). Links to inspection plan for execution instructions and generates inspection_result child records. Triggers NCR creation upon reject disposition or non-conformance detection. Central transactional entity for quality execution aligned with SAP QM inspection lot processing.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` (
    `inspection_result_id` BIGINT COMMENT 'Unique surrogate identifier for each inspection characteristic result record within an inspection lot. Primary key for the inspection_result data product in the quality domain.',
    `equipment_register_id` BIGINT COMMENT 'Reference to the measurement equipment or gauge used to capture the inspection result. Supports gauge R&R studies and calibration traceability per MSA requirements.',
    `inspection_characteristic_id` BIGINT COMMENT 'Reference to the master inspection characteristic definition (e.g., dimension, hardness, visual attribute) as configured in the inspection plan. Enables aggregation of results across lots for SPC analysis.',
    `inspection_lot_id` BIGINT COMMENT 'Reference to the parent inspection lot under which this characteristic result was recorded. Links the result to its originating inspection event in SAP QM.',
    `inspection_plan_id` BIGINT COMMENT 'Reference to the inspection plan (control plan) that defines the characteristic being measured. Ties the result back to the approved quality plan and sampling procedure.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Required for linking each inspection result to its specific order line, enabling quality reports and order fulfillment decisions.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Inspection results must trace to specific production/procurement batches for batch genealogy, certificate of analysis generation, and regulatory traceability (FDA 21 CFR Part 11, ISO 9001 clause 8.5.2',
    `material_master_id` BIGINT COMMENT 'Reference to the material or product being inspected. Enables quality performance analysis by SKU, part number, or finished good across production runs.',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: inspection_result has a denormalized ncr_number (STRING) field. When an inspection result is out-of-spec (is_out_of_spec=true), it triggers an NCR. Adding ncr_id as a proper FK normalizes this relatio',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to supply.planned_order. Business justification: First article inspection (FAI) and prototype inspection results are recorded against planned orders during new product introduction. Results determine whether planned order can be released to producti',
    `production_work_order_id` BIGINT COMMENT 'Reference to the manufacturing production order associated with the inspected batch or lot. Enables traceability from quality result back to the production execution event.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Required for Supplier Performance Report linking inspection results to the purchase order that supplied the material, enabling root‑cause analysis per supplier.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Inspection results are recorded for each inspected product SKU; linking allows quality dashboards to aggregate results by SKU.',
    `work_center_id` BIGINT COMMENT 'Reference to the manufacturing work center or production cell where the inspection was performed. Supports OEE and quality-by-location analysis.',
    `attribute_result` STRING COMMENT 'Pass/fail judgment for attribute-type inspection characteristics (e.g., visual defect present/absent, functional test pass/fail). Null for variable characteristics where measured_value is populated.. Valid values are `pass|fail|not_applicable`',
    `calibration_due_date` TIMESTAMP COMMENT 'Date by which the measurement device used for this inspection must next be calibrated. Captured at time of measurement to flag results obtained with overdue equipment, supporting ISO/IEC 17025 traceability requirements.',
    `characteristic_type` STRING COMMENT 'Classification of the inspection characteristic: variable (measurable numeric value), attribute (pass/fail judgment), visual (visual inspection), or functional (functional performance test). Determines the applicable SPC methodology.. Valid values are `variable|attribute|visual|functional`',
    `cp_index` DECIMAL(18,2) COMMENT 'Process capability index Cp measuring the ratio of the specification width to the process spread (6-sigma). Indicates whether the process is capable of meeting specification limits regardless of centering. Cp ≥ 1.33 is typically required per PPAP.',
    `cpk_index` DECIMAL(18,2) COMMENT 'Process capability index Cpk measuring the ratio of the nearest specification limit to the process mean, accounting for process centering. Cpk ≥ 1.33 is typically required for PPAP approval. Key metric for supplier quality and process performance reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection result record was first created in the system. Supports audit trail, data lineage, and Silver layer ingestion tracking per lakehouse governance requirements.',
    `defect_code` STRING COMMENT 'Standardized defect classification code identifying the type of nonconformance detected (e.g., DIM-OOT for out-of-tolerance dimension, SURF-SCR for surface scratch). Feeds Pareto analysis and CAPA root cause categorization. [ENUM-REF-CANDIDATE: promote to reference product for defect code catalog]',
    `defect_count` STRING COMMENT 'Number of defects or nonconformances detected for this characteristic within the inspected sample. Used for defect rate calculation, Pareto analysis, and NCR triggering thresholds.',
    `defect_description` STRING COMMENT 'Free-text description of the nonconformance or defect observed during inspection. Provides context beyond the defect code for root cause analysis and CAPA documentation.',
    `inspection_date` TIMESTAMP COMMENT 'Calendar date on which the inspection was performed. Used for daily/weekly quality trend reporting and shift-level aggregation without requiring timestamp precision.',
    `inspection_method` STRING COMMENT 'Method used to perform the inspection: manual (operator measurement), automated (CMM or inline sensor), semi_automated, destructive (material consumed in test), or non_destructive (NDT methods such as ultrasonic, X-ray). Affects result reliability and sampling plan selection.. Valid values are `manual|automated|semi_automated|destructive|non_destructive`',
    `inspection_stage` STRING COMMENT 'Stage in the production or supply chain process at which the inspection was performed: incoming (goods receipt), in_process (during manufacturing), final (finished goods), outgoing (pre-shipment), or supplier (at supplier site).. Valid values are `incoming|in_process|final|outgoing|supplier`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection measurement was physically recorded. The principal business event timestamp for this result. Used for SPC time-series analysis, shift-based quality reporting, and audit trail.',
    `is_out_of_control` BOOLEAN COMMENT 'Indicates whether the measurement triggered an SPC out-of-control signal (e.g., point beyond control limits, run rule violation per Western Electric rules). Distinct from out-of-spec: a process can be in-spec but out-of-control. Triggers SPC investigation workflow.',
    `is_out_of_spec` BOOLEAN COMMENT 'Indicates whether the measured value falls outside the engineering specification limits (USL or LSL). True when measured_value > upper_spec_limit or measured_value < lower_spec_limit. Used for rapid filtering of nonconforming results and NCR triggering.',
    `lower_control_limit` DECIMAL(18,2) COMMENT 'The lower statistical process control limit for the characteristic, typically set at ±3 sigma from the process mean. Used in SPC X-bar and R charts to detect process shifts.',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'The lower engineering specification limit for the characteristic. Measurements below this value are out-of-specification. Used in Cp/Cpk calculation and SPC control chart setup.',
    `measured_value` DECIMAL(18,2) COMMENT 'The actual numeric measurement recorded for a variable inspection characteristic (e.g., 24.987 mm for a diameter). Null for attribute-type characteristics. Core data point for SPC charting and Cp/Cpk calculation.',
    `nominal_value` DECIMAL(18,2) COMMENT 'The engineering design target or nominal value for the characteristic as specified in the drawing or specification. Used to calculate deviation from target and for SPC centering analysis.',
    `plant_code` STRING COMMENT 'SAP plant code identifying the manufacturing facility where the inspection was performed. Enables multi-plant quality benchmarking and regulatory reporting by site.',
    `remarks` STRING COMMENT 'Free-text remarks or observations entered by the inspector at the time of measurement. Captures contextual information not covered by structured fields, such as environmental conditions, equipment anomalies, or visual observations.',
    `result_status` STRING COMMENT 'Current disposition status of the inspection characteristic result: accepted (within specification), rejected (out of specification), conditional (requires further review or deviation approval), open (not yet evaluated), or cancelled.. Valid values are `accepted|rejected|conditional|open|cancelled`',
    `sample_size` STRING COMMENT 'Number of units or specimens included in the inspection sample for this characteristic result. Determined by the sampling plan (e.g., AQL per ANSI/ASQ Z1.4 or Z1.9). Required for statistical validity assessment.',
    `sampling_procedure` STRING COMMENT 'Sampling procedure or plan applied for this inspection characteristic (e.g., AQL 1.0 Level II, 100% inspection, skip-lot). Determines the statistical confidence of the inspection result.',
    `serial_number` STRING COMMENT 'Serial number of the individual unit inspected, where serialized traceability is required (e.g., high-value assemblies, safety-critical components). Null for non-serialized bulk materials.',
    `shift_code` STRING COMMENT 'Production shift during which the inspection was performed (e.g., day, afternoon, night). Enables shift-based quality performance analysis to identify systematic variation by shift.. Valid values are `day|afternoon|night`',
    `spc_chart_type` STRING COMMENT 'Type of SPC control chart applied to this characteristic: xbar_r (X-bar and R for subgroups), i_mr (Individuals and Moving Range), p_chart (proportion defective), np_chart (number defective), c_chart (count of defects), u_chart (defects per unit). Determines the statistical method for control limit calculation. [ENUM-REF-CANDIDATE: xbar_r|xbar_s|i_mr|p_chart|np_chart|c_chart|u_chart — 7 candidates stripped; promote to reference product]',
    `subgroup_number` STRING COMMENT 'Sequential subgroup number within the SPC control chart for this characteristic. Used to order data points on the SPC chart and identify the rational subgroup to which this measurement belongs.',
    `unit_of_measure` STRING COMMENT 'Engineering unit of the measured value (e.g., mm, kg, MPa, Ra, °C, %). Follows ISO 80000 and SAP UoM conventions. Required for dimensional analysis and SPC chart labeling.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this inspection result record. Used for incremental data pipeline processing, change detection, and audit trail in the Databricks Silver layer.',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'The upper statistical process control limit for the characteristic, typically set at ±3 sigma from the process mean. Triggers investigation when exceeded even if within specification. Used in SPC X-bar and R charts.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'The upper engineering specification limit for the characteristic. Measurements above this value are out-of-specification. Used in Cp/Cpk calculation and SPC control chart setup.',
    `usage_decision_code` STRING COMMENT 'SAP QM usage decision code indicating the final disposition of the inspected material based on this and other characteristic results: accept (release to stock), reject (return or scrap), rework (send for rework), scrap, or conditional_release (deviation approval). Drives inventory posting in SAP MM.. Valid values are `accept|reject|rework|scrap|conditional_release`',
    CONSTRAINT pk_inspection_result PRIMARY KEY(`inspection_result_id`)
) COMMENT 'Detailed measurement and characteristic result records captured during inspection lot execution. Stores individual measured values, attribute results (pass/fail), SPC data points, Cp/Cpk indices, and defect codes per inspection characteristic. Feeds SPC charts and process capability reporting.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`quality`.`ncr` (
    `ncr_id` BIGINT COMMENT 'Unique system-generated identifier for the Non-Conformance Report (NCR) record. Primary key for the quality event.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: NCRs often identify carrier-caused damage (transit damage, temperature excursions, handling issues). Manufacturing quality teams track NCRs by carrier for performance scorecarding, claims management, ',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: NCRs for design-related nonconformances must reference the engineering component to determine if the defect is a design issue requiring an ECO. Quality engineers need to retrieve all NCRs for a compon',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.customer_contact. Business justification: NCR disposition and technical resolution require direct communication with specific customer quality contacts for approval, clarification, and containment coordination. Manufacturing reality: quality ',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account associated with the NCR, applicable for customer complaint and field return NCR types. Links to Salesforce CRM customer account for 8D reporting and customer communication.',
    `material_master_id` BIGINT COMMENT 'Identifier of the material, component, or finished product involved in the non-conformance. Maps to SAP MM material master.',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to supply.planned_order. Business justification: NCRs raised during design review, supplier qualification, or pre-production phases are linked to planned orders to block conversion until corrective action is complete. Essential for launch readiness ',
    `po_line_item_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line_item. Business justification: NCRs raised against incoming material require line-level PO traceability to enable supplier debit notes, return-to-vendor processing, and 8D corrective action tracking per line. Existing ncr.purchase_',
    `procurement_goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_goods_receipt. Business justification: NCRs are frequently triggered directly from goods receipt inspection failures. Linking NCR to the specific goods receipt enables supplier quality traceability, debit memo processing, regulatory audit ',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Needed for NCR Traceability Report to associate non‑conformances with the originating purchase order for supplier corrective actions.',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: NCRs raised during sample evaluation or pre-production trials reference quoted specifications to document deviations. Critical for managing customer expectations and quote revisions when prototypes/sa',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Non‑conformance reports are issued for specific product SKUs; FK supports NCR trend analysis per SKU.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: NCR records the location of non‑conforming material in the warehouse for quarantine and retrieval, essential for corrective action tracking.',
    `work_center_id` BIGINT COMMENT 'Identifier of the specific work center, production cell, or shop floor station where the non-conformance was detected during manufacturing execution. Sourced from SAP PP/MES.',
    `actual_closure_date` TIMESTAMP COMMENT 'Actual date on which the NCR was formally closed after verification of all corrective actions and disposition completion. Used for cycle time KPI calculation.',
    `containment_action` STRING COMMENT 'Description of immediate containment actions taken to prevent further non-conforming product from reaching the customer or next process step (e.g., quarantine, 100% inspection, production hold). Corresponds to 8D Step D3.',
    `containment_completed_date` TIMESTAMP COMMENT 'Date by which all immediate containment actions were verified as complete. Used for 8D D3 closure tracking and customer reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the NCR record was first created in the data platform (Silver layer ingestion). Used for audit trail and data lineage.',
    `customer_complaint_number` STRING COMMENT 'Customer-provided reference number for the complaint or quality issue, as received from the customer or logged in Salesforce Service Cloud. Enables cross-reference with customer records.',
    `customer_notification_required` BOOLEAN COMMENT 'Indicates whether the customer must be formally notified of this non-conformance (e.g., for shipped non-conforming product, field safety issues, or contractual quality notification requirements).',
    `defect_code` STRING COMMENT 'Standardized defect classification code from the quality defect catalog (e.g., dimensional deviation, surface defect, functional failure). Maps to SAP QM defect code catalog. [ENUM-REF-CANDIDATE: promote to reference product for full defect code catalog]',
    `defect_location` STRING COMMENT 'Physical location or feature on the part/product where the defect was found (e.g., weld seam, connector pin 3, housing surface). Supports targeted rework and process improvement.',
    `detection_source` STRING COMMENT 'The process stage or channel where the non-conformance was first detected: incoming_inspection (receiving), in_process (shop floor/WIP), final_inspection (end-of-line), field_customer (reported by customer or field), audit (internal/external audit), supplier_delivery (at point of supplier delivery).. Valid values are `incoming_inspection|in_process|final_inspection|field_customer|audit|supplier_delivery`',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the non-conformance was first detected or observed. This is the principal business event timestamp for the NCR lifecycle.',
    `disposition` STRING COMMENT 'Formal disposition decision for the non-conforming material: use_as_is (accept with deviation), rework (correct in-house), scrap (destroy), return_to_supplier, repair, replace (issue replacement), credit (issue financial credit), no_fault_found. Drives material handling and financial impact. [ENUM-REF-CANDIDATE: use_as_is|rework|scrap|return_to_supplier|repair|replace|credit|no_fault_found — 8 candidates stripped; promote to reference product]',
    `disposition_authority` STRING COMMENT 'Name or role of the authorized person or body (e.g., Material Review Board, Quality Manager, Engineering) who approved the disposition decision. Required for regulatory and customer-specific quality requirements.',
    `disposition_timestamp` TIMESTAMP COMMENT 'Date and time when the formal disposition decision was made and approved. Used for cycle time measurement and regulatory compliance documentation.',
    `eight_d_report_number` STRING COMMENT 'Reference number of the formal 8D problem-solving report associated with this NCR. Applicable when is_8d_required is true. Enables cross-reference to the 8D documentation submitted to the customer.',
    `is_8d_required` BOOLEAN COMMENT 'Indicates whether the 8D (Eight Disciplines) structured problem-solving methodology is required for this NCR, typically mandated for customer-facing complaints or high-severity issues.',
    `material_description` STRING COMMENT 'Short description of the affected material or product as defined in the material master. Provides human-readable context without requiring a join to the material master.',
    `ncr_number` STRING COMMENT 'Human-readable, externally-visible NCR reference number used in communications with suppliers, customers, and auditors. Format: NCR-YYYY-NNNNNN. Maps to SAP QM notification number.. Valid values are `^NCR-[0-9]{4}-[0-9]{6}$`',
    `ncr_status` STRING COMMENT 'Current lifecycle state of the NCR workflow: draft (being authored), open (submitted and active), under_review (root cause analysis in progress), disposition_pending (awaiting disposition decision), closed (all actions complete), cancelled (voided).. Valid values are `draft|open|under_review|disposition_pending|closed|cancelled`',
    `ncr_type` STRING COMMENT 'Classification of the NCR by originating channel: internal (detected in-house), customer (complaint from customer), supplier (incoming material non-conformance), field_return (RMA/field failure), or audit (finding from internal or external audit).. Valid values are `internal|customer|supplier|field_return|audit`',
    `nonconformance_description` STRING COMMENT 'Detailed narrative description of the non-conformance, including the observed defect, deviation from specification, or failure mode. Supports root cause analysis and CAPA.',
    `nonconforming_qty` DECIMAL(18,2) COMMENT 'Quantity of units, parts, or material identified as non-conforming. Used for scrap cost calculation, yield rate analysis, and containment scope.',
    `qty_unit_of_measure` STRING COMMENT 'Unit of measure for the non-conforming quantity (e.g., EA=each, KG=kilogram, M=meter, PC=piece). Aligns with SAP base unit of measure. [ENUM-REF-CANDIDATE: EA|KG|LB|M|M2|M3|L|PC|SET|BOX — 10 candidates stripped; promote to reference product]',
    `regulatory_reportable` BOOLEAN COMMENT 'Indicates whether this non-conformance must be reported to a regulatory authority (e.g., OSHA, EPA, CE/UL product safety authority). Triggers mandatory regulatory notification workflows.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the NCR was formally submitted and entered into the quality management system. May differ from detection_timestamp if there is a reporting lag.',
    `return_shipment_status` STRING COMMENT 'Current status of the physical return shipment for RMA-linked NCRs: not_applicable (no physical return), pending (RMA issued, awaiting shipment), in_transit (goods in transit), received (goods received at facility), inspected (incoming inspection complete), closed (return process complete).. Valid values are `not_applicable|pending|in_transit|received|inspected|closed`',
    `rma_number` STRING COMMENT 'Return Material Authorization number issued to the customer or supplier for physical return of non-conforming goods. Applicable for field_return and supplier NCR types. Enables tracking of return shipment and disposition.',
    `root_cause_category` STRING COMMENT 'Standardized category of the identified root cause for trend analysis and SPC reporting: design, process, material, equipment, human_error, measurement, supplier, or environment. Enables Pareto analysis of quality failures. [ENUM-REF-CANDIDATE: design|process|material|equipment|human_error|measurement|supplier|environment — 8 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Narrative description of the identified root cause of the non-conformance, derived from root cause analysis methods (e.g., 5-Why, Ishikawa/fishbone, FMEA). Corresponds to 8D Step D4.',
    `sap_qm_notification_type` STRING COMMENT 'SAP QM notification type code mapped to this NCR: Q1 (customer complaint), Q2 (internal quality notification), Q3 (supplier quality notification). Enables direct traceability to the SAP QM source record.. Valid values are `Q1|Q2|Q3`',
    `serial_number` STRING COMMENT 'Serial number of the specific unit affected by the non-conformance, where serialized tracking applies (e.g., finished goods, capital equipment). Enables unit-level traceability.',
    `severity` STRING COMMENT 'Severity level of the non-conformance based on impact to safety, quality, regulatory compliance, or customer satisfaction: critical (safety/regulatory risk), major (significant quality impact), minor (limited impact), observation (potential risk noted).. Valid values are `critical|major|minor|observation`',
    `target_closure_date` TIMESTAMP COMMENT 'Planned date by which the NCR is expected to be fully closed, including all corrective actions verified. Used for SLA tracking and escalation management.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the NCR record. Used for change tracking and audit compliance.',
    CONSTRAINT pk_ncr PRIMARY KEY(`ncr_id`)
) COMMENT 'Non-Conformance Report (NCR) serving as the single, unified quality event record for ALL deviations from specifications, standards, or requirements regardless of detection source or reporting channel. Encompasses internal defects, customer complaints (including 8D problem-solving), supplier non-conformances, field returns/RMA dispositions, and audit-triggered findings. Captures non-conformance type (internal/customer/supplier/field-return/audit), affected material/product/serial number, detection source (incoming inspection, in-process, final inspection, field/customer, audit, supplier delivery), severity classification, containment actions, root cause analysis, disposition decision (use-as-is, rework, scrap, return-to-supplier, repair, replace, credit, no-fault-found), RMA tracking fields (return authorization number, customer reference, repair actions, return shipment status), SAP QM notification type mapping (Q1/Q2/Q3), and linkage to CAPA for corrective/preventive action. Supports 8D methodology for customer-facing issues. Aligned with ISO 9001 clause 8.7 (control of nonconforming outputs), clause 10.2 (corrective action), and integrates with Salesforce Service Cloud for customer-originated events.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`quality`.`capa` (
    `capa_id` BIGINT COMMENT 'Unique system-generated identifier for the Corrective and Preventive Action (CAPA) record. Primary key for the capa data product in the quality domain.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: CAPA actions are often triggered by defects in a particular component; linking enables root‑cause tracking and corrective action reporting.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.customer_contact. Business justification: Customer-related CAPAs (8D reports) require specific customer contact for effectiveness verification sign-off and closure approval. Real scenario: automotive 8D process mandates customer quality engin',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer associated with this CAPA when triggered by a customer complaint, field failure, or warranty claim. Links to the customer account for customer-facing quality reporting and Salesforce CRM integration.',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: eco_number exists as a denormalized field on capa, directly signaling this relationship. CAPAs for design-related root causes trigger ECOs. Replacing the free-text eco_number with a proper FK enables ',
    `ncr_id` BIGINT COMMENT 'Identifier of the Non-Conformance Report (NCR) that triggered this CAPA. Establishes the traceability link between the nonconformity detection record and the corrective action response.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: CAPA actions address root causes of defects on a particular product SKU; linking provides product‑centric corrective action tracking.',
    `action_implementation_date` TIMESTAMP COMMENT 'The date on which the corrective and/or preventive actions were fully implemented in the production process or quality system. Marks the transition from planning to execution phase.',
    `actual_closure_date` TIMESTAMP COMMENT 'The actual calendar date on which the CAPA was formally closed after successful verification of effectiveness. Null if the CAPA is still open. Used to calculate actual cycle time versus target.',
    `affected_process_code` STRING COMMENT 'Identifier of the manufacturing process, work center, or production routing step where the nonconformity was detected or originated. Sourced from SAP PP routing or Siemens Opcenter MES process definition.',
    `approval_date` TIMESTAMP COMMENT 'The date on which the CAPA was formally approved for closure by the authorized quality approver. Represents the final lifecycle milestone before the record is archived.',
    `capa_number` STRING COMMENT 'Human-readable, externally-known business identifier for the CAPA record, typically formatted as CAPA-YYYY-NNNNNN. Used in communications, audit trails, and regulatory submissions. Sourced from SAP QM notification numbering.. Valid values are `^CAPA-[0-9]{4}-[0-9]{6}$`',
    `capa_status` STRING COMMENT 'Current lifecycle state of the CAPA record. Tracks progression from initial creation through root cause analysis, action implementation, effectiveness verification, and formal closure per ISO 9001 Clause 10.2.. Valid values are `draft|open|in_progress|pending_verification|closed|cancelled`',
    `capa_type` STRING COMMENT 'Classifies whether the action is corrective (addressing an existing nonconformity), preventive (eliminating a potential nonconformity), or both. Drives workflow routing and reporting in SAP QM.. Valid values are `corrective|preventive|both`',
    `containment_completion_date` TIMESTAMP COMMENT 'The date on which all immediate containment actions were completed and verified. Used to measure response speed and compliance with customer-mandated containment timelines.',
    `corrective_action_plan` STRING COMMENT 'Detailed description of the permanent corrective actions planned to eliminate the root cause of the nonconformity and prevent recurrence. Includes process changes, design modifications, procedure updates, or training interventions.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the CAPA record was first created in the quality management system. Used for audit trail, data lineage, and Silver layer ingestion tracking.',
    `customer_notification_date` TIMESTAMP COMMENT 'The date on which the customer was formally notified of the nonconformity and the corrective action plan. Null if customer notification is not required or has not yet occurred.',
    `customer_notification_required` BOOLEAN COMMENT 'Indicates whether the customer must be formally notified of the nonconformity and the corrective action taken. Driven by customer contract requirements, product safety implications, or regulatory obligations.',
    `department_code` STRING COMMENT 'Organizational department or cost center responsible for the process or area where the nonconformity originated. Used for departmental quality KPI reporting and accountability tracking.',
    `effectiveness_verification_date` TIMESTAMP COMMENT 'The date on which the effectiveness of the implemented actions was formally verified and documented. Required for CAPA closure per ISO 9001 Clause 10.2.',
    `effectiveness_verification_method` STRING COMMENT 'Description of the method used to verify that the implemented corrective and preventive actions were effective in eliminating the root cause and preventing recurrence. May include SPC monitoring, re-audit, production run data review, or customer feedback analysis.',
    `effectiveness_verified` BOOLEAN COMMENT 'Indicates whether the corrective and preventive actions have been formally verified as effective. True when verification is complete and documented; False when verification is pending or failed. Required gate for CAPA closure.',
    `immediate_containment_action` STRING COMMENT 'Description of the short-term containment actions taken immediately upon detection of the nonconformity to prevent further defective product from reaching the customer or next process step. Corresponds to D3 in the 8D methodology.',
    `initiated_date` TIMESTAMP COMMENT 'The calendar date on which the CAPA was formally opened and initiated. Represents the principal business event timestamp for the CAPA lifecycle. Used to calculate cycle time and compliance with response time SLAs.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording the most recent modification to the CAPA record. Used for change detection in incremental data pipeline loads and audit trail compliance.',
    `lessons_learned` STRING COMMENT 'Summary of key lessons learned from the CAPA investigation and resolution that should be shared across the organization to prevent similar issues. Feeds into the knowledge management and APQP process for future product launches.',
    `n8d_report_number` STRING COMMENT 'Reference number of the formal 8D (Eight Disciplines) problem-solving report associated with this CAPA, if applicable. Used when customer-mandated 8D reporting is required, particularly in automotive and industrial OEM supply chains.',
    `ppap_impact_flag` BOOLEAN COMMENT 'Indicates whether this CAPA requires a new or revised Production Part Approval Process (PPAP) submission due to process or design changes resulting from the corrective action. Relevant for automotive and industrial OEM supply chains.',
    `preventive_action_plan` STRING COMMENT 'Description of proactive actions planned to eliminate the causes of potential nonconformities before they occur. Addresses systemic risks identified during root cause analysis that may affect similar processes or products.',
    `priority` STRING COMMENT 'Business priority level assigned to the CAPA based on risk severity, customer impact, regulatory exposure, or recurrence frequency. Drives escalation timelines and resource allocation.. Valid values are `critical|high|medium|low`',
    `problem_description` STRING COMMENT 'Detailed narrative describing the nonconformity, defect, or quality event that triggered the CAPA. Includes observed symptoms, affected product or process, and initial impact assessment. Corresponds to the problem statement in the 8D or CAPA methodology.',
    `quality_standard_reference` STRING COMMENT 'The specific quality standard clause, regulatory requirement, or customer specification that was violated or is being addressed by this CAPA. Examples: ISO 9001:2015 Clause 8.5.2, IATF 16949, customer-specific quality requirements.',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this CAPA addresses a recurring nonconformity that has been previously reported. True if the same or similar root cause has been identified in a prior CAPA. Used for chronic problem identification and escalation.',
    `regulatory_impact_flag` BOOLEAN COMMENT 'Indicates whether this CAPA has regulatory reporting implications, such as mandatory notification to ISO certification bodies, OSHA, EPA, or CE/UL certification authorities. Triggers compliance escalation workflow when True.',
    `root_cause_analysis_method` STRING COMMENT 'The structured methodology used to identify the root cause of the nonconformity. Common methods include 5-Why, Ishikawa (fishbone) diagram, 8D problem solving, Failure Mode and Effects Analysis (FMEA), fault tree analysis, or Pareto analysis. [ENUM-REF-CANDIDATE: 5_why|ishikawa|8d|fmea|fault_tree|pareto|other — 7 candidates stripped; promote to reference product]',
    `root_cause_category` STRING COMMENT 'High-level categorization of the root cause using the 6M Ishikawa framework: Man (human error), Machine (equipment), Material (raw material/component), Method (process/procedure), Measurement (inspection/calibration), or Environment (facility/conditions). Enables systemic trend analysis.. Valid values are `man|machine|material|method|measurement|environment`',
    `root_cause_description` STRING COMMENT 'Detailed narrative of the identified root cause(s) of the nonconformity as determined through the root cause analysis. This is the foundational finding that drives the corrective action plan.',
    `source_reference_number` STRING COMMENT 'The identifier of the originating document or record that triggered this CAPA, such as an NCR number, audit finding reference, customer complaint ticket number, or SAP QM notification number. Enables traceability back to the triggering event.',
    `source_type` STRING COMMENT 'Category of the triggering event that initiated the CAPA. Indicates whether the CAPA originated from a Non-Conformance Report (NCR), customer complaint, internal or external audit finding, shop floor quality event, supplier quality issue, or regulatory inspection finding. [ENUM-REF-CANDIDATE: ncr|customer_complaint|audit_finding|internal_quality_event|supplier_issue|regulatory_finding|field_failure|warranty_claim — promote to reference product]. Valid values are `ncr|customer_complaint|audit_finding|internal_quality_event|supplier_issue|regulatory_finding`',
    `target_closure_date` TIMESTAMP COMMENT 'The planned date by which all corrective and preventive actions must be implemented and verified as effective. Used for on-time closure KPI tracking and escalation management.',
    `title` STRING COMMENT 'Short, descriptive title summarizing the quality problem or improvement opportunity addressed by this CAPA. Used in dashboards, reports, and management reviews.',
    CONSTRAINT pk_capa PRIMARY KEY(`capa_id`)
) COMMENT 'Corrective and Preventive Action (CAPA) record managing the full lifecycle of quality improvement actions triggered by NCRs, audit findings, customer complaints, or internal quality events. Tracks root cause analysis (5-Why, Ishikawa), corrective action plan, preventive action plan, responsible owner, target dates, verification of effectiveness, and closure status per ISO 9001 clause 10.2.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`quality`.`fmea` (
    `fmea_id` BIGINT COMMENT 'Unique system-generated identifier for the FMEA record. Primary key for the fmea data product in the quality domain.',
    `capa_id` BIGINT COMMENT 'Reference to the associated CAPA record initiated as a result of this FMEA recommended action. Links the FMEA to the formal corrective action management process in SAP QM or the quality management system.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: DFMEAs are component-specific. part_name and part_number on fmea are denormalized signals of this relationship. Linking fmea to the engineering component master enables design-quality traceability, su',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer or OEM for whom this FMEA is being prepared. Customer-specific FMEA requirements (e.g., Ford, GM, Stellantis CSRs) may impose additional rating criteria or documentation standards.',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: DFMEAs and PFMEAs are initiated as deliverables within APQP engineering projects. The engineering project defines the FMEA scope, timeline, and team. APQP Phase 2 explicitly requires FMEA completion a',
    `ppap_submission_id` BIGINT COMMENT 'Reference to the PPAP submission package that includes this FMEA as a required deliverable. The FMEA is a mandatory PPAP element per AIAG PPAP 4th Edition. Links quality analysis to the formal part approval process.',
    `sku_master_id` BIGINT COMMENT 'Reference to the product or component that is the subject of this FMEA analysis. Links the FMEA to the product master record managed in Siemens Teamcenter PLM or SAP S/4HANA MM.',
    `action_priority` STRING COMMENT 'AIAG-VDA Action Priority classification (High, Medium, Low) assigned to the failure mode based on the combination of Severity, Occurrence, and Detection ratings. Replaces the legacy RPN-only prioritization approach introduced in the 2019 AIAG-VDA FMEA Handbook. Core AIAG-VDA Step 7 field.. Valid values are `high|medium|low`',
    `action_taken` STRING COMMENT 'Description of the actual corrective or preventive action implemented to address the failure mode. Documents what was done versus what was recommended, enabling traceability for PPAP and audit purposes. Core AIAG-VDA Step 9 field.',
    `actual_completion_date` TIMESTAMP COMMENT 'Date on which the recommended action was actually implemented and verified as complete. Compared against target_completion_date to measure action closure timeliness. Formatted as yyyy-MM-dd.',
    `approved_date` TIMESTAMP COMMENT 'Date on which the FMEA was formally reviewed and approved by the responsible engineering and quality authority. Required for PPAP submission and regulatory compliance documentation. Formatted as yyyy-MM-dd.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the FMEA record was first created in the data platform. Used for data lineage, audit trail, and Silver layer ingestion tracking. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `current_detection_controls` STRING COMMENT 'Description of existing design verification or process monitoring controls that detect the failure mode or cause before the product reaches the customer. Examples include inspection plans, SPC monitoring, functional testing, and CMM measurement. Core AIAG-VDA Step 7 field.',
    `current_prevention_controls` STRING COMMENT 'Description of existing design or process controls that prevent the failure cause from occurring or reduce the occurrence rate. Examples include design standards, material specifications, process parameters, and mistake-proofing (poka-yoke) devices. Core AIAG-VDA Step 6 field.',
    `detection_rating` STRING COMMENT 'Numeric rating (1–10) assessing the ability of current controls to detect the failure cause or failure mode before the product reaches the customer. A rating of 10 indicates no detection capability; 1 indicates near-certain detection. Core AIAG-VDA Step 7 field.',
    `failure_cause` STRING COMMENT 'Root cause or mechanism that leads to the failure mode. Describes the specific design weakness, process deficiency, or material condition that initiates the failure (e.g., insufficient weld penetration, incorrect torque specification). Core AIAG-VDA Step 4 field.',
    `failure_effect` STRING COMMENT 'Description of the consequence of the failure mode on the customer, end user, or downstream process. Defines what the customer experiences when the failure occurs (e.g., loss of function, noise, injury risk). Core AIAG-VDA Step 4 field.',
    `failure_mode` STRING COMMENT 'The specific manner in which the item, component, or process step could potentially fail to perform its intended function. Represents the physical or chemical description of the failure (e.g., fracture, short circuit, dimensional out-of-tolerance). Core AIAG-VDA Step 4 field.',
    `fmea_number` STRING COMMENT 'Externally-known, human-readable document control number assigned to the FMEA record in Siemens Teamcenter PLM. Used for cross-referencing in engineering change orders (ECOs), PPAP packages, and APQP deliverables.. Valid values are `^FMEA-[A-Z]{2,6}-[0-9]{4,8}$`',
    `fmea_status` STRING COMMENT 'Current lifecycle state of the FMEA document within the Siemens Teamcenter PLM workflow. Controls whether the FMEA is editable, under review, formally released for production use, or retired.. Valid values are `draft|in_review|approved|released|obsolete|superseded`',
    `fmea_type` STRING COMMENT 'Classification of the FMEA by analysis scope: DFMEA (Design FMEA) evaluates design-related failure modes; PFMEA (Process FMEA) evaluates manufacturing process failure modes; SFMEA (System FMEA) evaluates system-level interactions; MFMEA (Machinery FMEA) evaluates equipment failure modes. Aligned with AIAG-VDA methodology.. Valid values are `DFMEA|PFMEA|SFMEA|MFMEA`',
    `function_description` STRING COMMENT 'Description of the intended function or purpose of the item, component, or process step being analyzed. Defines what the element is supposed to do under normal operating conditions. Core AIAG-VDA Step 3 field.',
    `initiated_date` TIMESTAMP COMMENT 'Date on which the FMEA analysis was formally initiated or first created. Marks the start of the FMEA lifecycle and is used for APQP timing and project milestone tracking. Formatted as yyyy-MM-dd.',
    `last_review_date` TIMESTAMP COMMENT 'Date of the most recent periodic review of the FMEA. FMEAs must be reviewed and updated when design or process changes occur, when field failures are reported, or on a scheduled basis per the quality management system. Formatted as yyyy-MM-dd.',
    `occurrence_rating` STRING COMMENT 'Numeric rating (1–10) estimating the likelihood or frequency of the failure cause occurring. A rating of 10 indicates near-certain occurrence; 1 indicates extremely unlikely. Based on historical failure data, process capability (Cp/Cpk), or engineering judgment. Core AIAG-VDA Step 6 field.',
    `process_step` STRING COMMENT 'Name or description of the specific manufacturing process step or operation being analyzed in a PFMEA (e.g., Welding Station 3, CNC Milling Op 20). Derived from the process routing in SAP S/4HANA PP or Siemens Opcenter MES.',
    `recommended_action` STRING COMMENT 'Proposed corrective or preventive action to reduce the severity, occurrence, or detection rating of the failure mode. Drives CAPA initiation and engineering change orders (ECOs). Core AIAG-VDA Step 8 field.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the failure mode is associated with a regulatory compliance requirement (e.g., CE Marking, UL certification, EPA, OSHA). Failure modes with this flag require documented evidence of control effectiveness in regulatory submissions.',
    `revised_action_priority` STRING COMMENT 'Updated AIAG-VDA Action Priority (High, Medium, Low) recalculated after implementation of the recommended action. Confirms whether the residual risk level is acceptable or requires further action.. Valid values are `high|medium|low`',
    `revised_detection_rating` STRING COMMENT 'Updated detection rating (1–10) after implementation of the recommended action. Reflects improved detection capability resulting from new controls, inspection methods, or monitoring systems. Core AIAG-VDA Step 9 field.',
    `revised_occurrence_rating` STRING COMMENT 'Updated occurrence rating (1–10) after implementation of the recommended action. Reflects the reduced likelihood of the failure cause occurring following corrective action. Core AIAG-VDA Step 9 field.',
    `revised_rpn` STRING COMMENT 'Recalculated Risk Priority Number (Revised S × Revised O × Revised D) after implementation of the recommended action. Used to verify that the corrective action achieved the desired risk reduction. Core AIAG-VDA Step 9 field.',
    `revised_severity_rating` STRING COMMENT 'Updated severity rating (1–10) after implementation of the recommended action. Severity typically does not change unless a design change eliminates the failure effect. Core AIAG-VDA Step 9 field for post-action re-evaluation.',
    `revision` STRING COMMENT 'Document revision identifier (e.g., A, B, C, 01, 02) tracking the version history of the FMEA in Siemens Teamcenter PLM. Incremented upon each approved change to the FMEA content.. Valid values are `^[A-Z0-9]{1,5}$`',
    `rpn` STRING COMMENT 'Risk Priority Number calculated as the product of Severity × Occurrence × Detection ratings (S × O × D). Ranges from 1 to 1000. Used to prioritize failure modes for corrective action. Higher RPN indicates greater risk requiring immediate attention. Stored as a business-critical field per AIAG-VDA methodology.',
    `safety_critical_flag` BOOLEAN COMMENT 'Indicates whether the failure mode has a safety-critical or regulatory compliance impact (severity rating 9 or 10). Safety-critical failure modes require mandatory escalation, special controls, and PPAP documentation. Aligned with OSHA and CE Marking requirements.',
    `scope` STRING COMMENT 'Description of the boundaries and scope of the FMEA analysis, including what is included and excluded from the analysis. Defines the system boundary, interfaces, and assumptions. Required for AIAG-VDA Step 2 (Structure Analysis).',
    `severity_rating` STRING COMMENT 'Numeric rating (1–10) assessing the seriousness of the failure effect on the customer or downstream process. A rating of 10 indicates a safety-critical or regulatory non-compliance failure; 1 indicates no discernible effect. Defined per AIAG-VDA severity evaluation criteria. Core AIAG-VDA Step 5 field.',
    `special_characteristic_code` STRING COMMENT 'Designation indicating whether the failure mode relates to a special product or process characteristic requiring enhanced control. SC = Special Characteristic; CC = Critical Characteristic; KPC = Key Product Characteristic; KCC = Key Control Characteristic. Drives control plan and inspection plan requirements.. Valid values are `SC|CC|KPC|KCC|`',
    `target_completion_date` TIMESTAMP COMMENT 'Planned date by which the recommended action must be implemented and verified. Used for action tracking and escalation management in the FMEA review cycle. Formatted as yyyy-MM-dd.',
    `team_members` STRING COMMENT 'Comma-separated list or description of cross-functional team members who participated in the FMEA analysis session. Typically includes representatives from design engineering, manufacturing, quality, and supplier quality. Required for AIAG-VDA Step 1 documentation.',
    `title` STRING COMMENT 'Descriptive title of the FMEA document identifying the product, component, or process being analyzed. Used for search, retrieval, and display in PLM and quality management systems.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the FMEA record was last modified in the data platform. Supports change tracking, data quality monitoring, and incremental load processing in the Databricks Lakehouse Silver layer. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_fmea PRIMARY KEY(`fmea_id`)
) COMMENT 'Failure Mode and Effects Analysis (FMEA) master record covering both DFMEA (Design FMEA) and PFMEA (Process FMEA). Stores failure modes, effects, causes, current controls, severity/occurrence/detection ratings, Risk Priority Number (RPN), recommended actions, and revised RPN after action implementation. Managed in Siemens Teamcenter PLM and aligned with AIAG-VDA FMEA methodology.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` (
    `control_plan_id` BIGINT COMMENT 'Unique surrogate identifier for the control plan record in the lakehouse silver layer. Primary key.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Control plans are written for specific components. part_name and part_number on control_plan are denormalized fields. Linking to the engineering component master enables direct retrieval of all contro',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Control plans are defined per customer requirements; linking to customer_account enables traceability of customer‑driven control specifications.',
    `fmea_id` BIGINT COMMENT 'Reference to the PFMEA (Process Failure Mode and Effects Analysis) record from which this control plan characteristic was derived. Ensures traceability between risk analysis and process controls per AIAG APQP linkage requirements.',
    `inspection_characteristic_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_characteristic. Business justification: A control plan row defines controls for a specific inspection characteristic. The control_plan table contains denormalized characteristic_name, characteristic_number, characteristic_class, and charact',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Control plans are revision-specific per AIAG APQP standard. part_revision on control_plan is a denormalized signal. When an engineering revision changes tolerances or processes, the control plan must ',
    `sourcing_rule_id` BIGINT COMMENT 'Foreign key linking to supply.sourcing_rule. Business justification: Control plans for supplier-provided materials reference the sourcing rule to document inspection/control methods specific to that suppliers process capability. Ensures incoming inspection requirement',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to production.work_center. Business justification: Control plans define process controls at specific work centers (process_step_name, measurement_method per work center). The existing work_center_code plain attribute is denormalized. A proper FK ena',
    `approved_by` STRING COMMENT 'Name or employee ID of the authorized approver (typically Quality Manager or Engineering Manager) who formally approved this control plan revision. Required for ISO 9001 document control compliance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this control plan revision was formally approved. Provides the authoritative approval event timestamp for document control audit trails and PPAP submission packages.',
    `control_method` STRING COMMENT 'The process control technique applied to monitor and control this characteristic (e.g., SPC X-bar/R Chart, Pre-control Chart, Poka-yoke, Visual Standard, Attribute Control Chart, Process Parameter Monitoring). Core APQP deliverable field.',
    `control_type` STRING COMMENT 'Indicates whether the control is a prevention control (prevents the defect from occurring) or a detection control (detects the defect after it has occurred). Aligns with PFMEA prevention/detection control columns.. Valid values are `prevention|detection`',
    `cpk_minimum_required` BOOLEAN COMMENT 'The minimum acceptable Cpk (Process Capability Index) value required for this characteristic to be considered capable. Typically 1.33 for production and 1.67 for critical/safety characteristics per AIAG PPAP requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this control plan record was first created in the system. Supports audit trail requirements under ISO 9001 document control and data lineage tracking in the Databricks lakehouse.',
    `effective_date` TIMESTAMP COMMENT 'Date from which this revision of the control plan becomes active and must be followed on the shop floor. Aligns with the ECO/ECN implementation date in Siemens Teamcenter PLM.',
    `error_proofing_method` STRING COMMENT 'Description of the poka-yoke or error-proofing device/method applied at this process step to prevent or detect non-conformances (e.g., Torque monitoring with automatic shutdown, Vision system barcode verification, Fixture limit switch). Reduces reliance on operator inspection.',
    `expiry_date` TIMESTAMP COMMENT 'Date on which this control plan revision expires or is superseded. Null for open-ended plans. Used to enforce periodic review cycles mandated by ISO 9001 and customer-specific requirements.',
    `gauge_type` STRING COMMENT 'Type or category of measurement instrument or gauge used for this characteristic (e.g., Vernier Caliper, CMM, Go/No-Go Gauge, Torque Tester, Vision System). Used for gauge calibration scheduling and MSA planning.',
    `is_ctq` BOOLEAN COMMENT 'Indicates whether this characteristic is designated as Critical-to-Quality (CTQ), meaning it directly impacts customer satisfaction, safety, or regulatory compliance. CTQ characteristics receive enhanced monitoring and are mandatory in PPAP submissions.',
    `is_regulatory_requirement` BOOLEAN COMMENT 'Indicates whether this characteristic is controlled to meet a specific regulatory or certification requirement (e.g., CE Marking, UL, IEC 62443, EPA, OSHA). Drives mandatory retention of inspection records for regulatory audit purposes.',
    `is_safety_characteristic` BOOLEAN COMMENT 'Indicates whether this characteristic is classified as a safety-critical characteristic (SC) per customer-specific requirements or regulatory mandates. Safety characteristics require 100% inspection or validated error-proofing (poka-yoke) and special PPAP documentation.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this control plan record. Used for change detection, incremental ETL processing, and audit trail compliance in the silver layer.',
    `lower_control_limit` DECIMAL(18,2) COMMENT 'The lower statistical process control limit (LCL) for the SPC control chart associated with this characteristic. Calculated as the process mean minus three standard deviations. Triggers reaction plan when breached.',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'The lower engineering specification limit (LSL) for the quality characteristic. Measurements below this value are considered non-conforming. Used in Cp/Cpk process capability index calculations.',
    `measurement_method` STRING COMMENT 'Description of the measurement technique or method used to evaluate the characteristic (e.g., CMM dimensional measurement, Torque wrench with digital readout, Visual inspection per drawing). Supports Measurement System Analysis (MSA) traceability.',
    `nominal_value` DECIMAL(18,2) COMMENT 'The target or nominal engineering specification value for the quality characteristic (e.g., 25.00 mm, 45 Nm). Used as the center point for control limit calculations and SPC charting.',
    `plan_number` STRING COMMENT 'Externally-known, human-readable unique identifier for the control plan document, typically formatted as CP-<part/process code>-<sequence>. Used for cross-referencing in APQP packages, PPAP submissions, and SAP QM inspection plans.. Valid values are `^CP-[A-Z0-9]{2,10}-[0-9]{4,8}$`',
    `plan_status` STRING COMMENT 'Current lifecycle status of the control plan document. Drives whether the plan is actively used on the shop floor. Managed through the document control workflow in Siemens Teamcenter PLM.. Valid values are `draft|under_review|approved|obsolete|superseded`',
    `plan_type` STRING COMMENT 'Phase classification of the control plan per AIAG APQP methodology: prototype (early design validation), pre-launch (pilot/trial production), or production (full-rate manufacturing). Determines the rigor and scope of controls applied.. Valid values are `prototype|pre-launch|production`',
    `process_step_name` STRING COMMENT 'Descriptive name of the manufacturing process step or operation (e.g., Welding, CNC Machining, Final Assembly Inspection). Provides human-readable context for the control being defined.',
    `process_step_number` STRING COMMENT 'Sequential identifier for the manufacturing process step or operation within the control plan (e.g., 10, 20, 30). Aligns with the process flow diagram and PFMEA step numbering per AIAG standards.',
    `reaction_plan` STRING COMMENT 'Prescribed corrective actions to be taken when the process goes out of control or a non-conformance is detected for this characteristic (e.g., Stop production, quarantine last 2 hours output, notify quality engineer, initiate NCR). Mandatory APQP control plan field.',
    `sample_frequency` STRING COMMENT 'Frequency or trigger condition for performing the inspection (e.g., Every 2 hours, Every 50 pieces, First-off and last-off, Each lot, 100% inspection). Defines the inspection cadence on the shop floor.',
    `sample_size` STRING COMMENT 'Number of parts or units to be measured per inspection event for this characteristic. Defined per statistical sampling plan (e.g., ANSI/ASQ Z1.4, Z1.9) or engineering judgment. Drives inspection workload planning.',
    `spc_chart_type` STRING COMMENT 'Type of SPC (Statistical Process Control) control chart applied to monitor this characteristic. Determines the statistical rules and control limit formulas used. Applicable only when control_method includes SPC. [ENUM-REF-CANDIDATE: xbar_r|xbar_s|individuals_mr|p_chart|np_chart|c_chart|u_chart — promote to reference product]',
    `unit_of_measure` STRING COMMENT 'Engineering unit of measure for the characteristics nominal value and specification limits (e.g., mm, Nm, MPa, °C, %). Aligns with SAP MM unit of measure codes and ISO 80000 international measurement standards.',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'The upper statistical process control limit (UCL) for the SPC control chart associated with this characteristic. Calculated as the process mean plus three standard deviations. Triggers reaction plan when exceeded.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'The upper engineering specification limit (USL) for the quality characteristic. Measurements exceeding this value are considered non-conforming. Used in Cp/Cpk process capability index calculations.',
    CONSTRAINT pk_control_plan PRIMARY KEY(`control_plan_id`)
) COMMENT 'Manufacturing control plan defining the process controls, inspection frequency, measurement methods, reaction plans, and control limits for each critical-to-quality (CTQ) characteristic at each process step. Links to PFMEA and inspection plans. Core APQP deliverable managed per AIAG standards and ISO 9001 clause 8.5.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` (
    `ppap_submission_id` BIGINT COMMENT 'Primary key for ppap_submission',
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.capa. Business justification: PPAP submission can trigger a CAPA; add FK to capture this relationship.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: PPAP submissions are fundamentally component-level submissions. part_name on ppap_submission is a denormalized signal. Linking to the engineering component master enables retrieval of all PPAP history',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account requiring PPAP approval for this part. Links to the customer master in Salesforce CRM or SAP SD. Represents the PARTY_REFERENCE for this transaction.',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: PPAP submissions are APQP deliverables tied to engineering projects. The apqp_phase field on ppap_submission signals this relationship. Engineering project managers track PPAP status as a launch gate.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: PPAP submissions must be traceable to the purchase order for the part, required for customer acceptance and audit trails.',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: PPAP submissions are revision-specific per AIAG PPAP standard — a new PPAP is required when the engineering revision changes. part_revision_level on ppap_submission is a denormalized signal. Linking t',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: PPAP submissions are submitted for a particular product SKU; FK enables traceability of approval status per SKU.',
    `annual_production_volume` STRING COMMENT 'Estimated annual production volume (number of parts per year) declared on the Part Submission Warrant. Used by the customer to assess production capacity and process capability requirements.',
    `appearance_approval_status` STRING COMMENT 'Status of the Appearance Approval Report (AAR) for parts with appearance requirements (PPAP Element 12). Indicates whether the parts color, grain, gloss, and surface finish have been approved by the customer.. Valid values are `approved|rejected|not_applicable`',
    `apqp_phase` STRING COMMENT 'APQP phase during which this PPAP submission was initiated. PPAP is typically completed in APQP Phase 4 (Product and Process Validation). Provides traceability to the broader APQP program.. Valid values are `phase_1|phase_2|phase_3|phase_4|phase_5`',
    `bulk_material_checklist_status` STRING COMMENT 'Completion status of the Bulk Material Requirements Checklist (PPAP Element 13), applicable for bulk/raw material submissions. Confirms all regulatory and customer-specific material requirements have been addressed.. Valid values are `complete|incomplete|not_applicable`',
    `checking_aids_status` STRING COMMENT 'Status of checking aids (gauges, fixtures, templates) used for part inspection (PPAP Element 14). Confirms that all required checking aids are available, calibrated, and documented.. Valid values are `available|not_available|not_applicable`',
    `cpk_minimum` DECIMAL(18,2) COMMENT 'Minimum Cpk value recorded across all critical and significant characteristics in the initial process capability study. Used to assess whether the process meets the customers capability requirements (typically Cpk ≥ 1.67 for new processes).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the PPAP submission record was first created in the system. Represents the audit trail creation event. Populated automatically by the quality management system.',
    `customer_approval_date` TIMESTAMP COMMENT 'Date on which the customer issued the formal PPAP disposition (approved, conditionally approved, or rejected). Null if disposition has not yet been received.',
    `customer_approver_name` STRING COMMENT 'Name of the customers quality representative or engineer who reviewed and issued the formal PPAP disposition. Recorded for audit trail and accountability purposes.',
    `customer_part_number` STRING COMMENT 'The customers own part number or drawing number for the submitted component, used for cross-reference between the manufacturers and customers part identification systems.',
    `customer_specific_requirements_status` STRING COMMENT 'Status indicating whether all customer-specific requirements (PPAP Element 15) have been addressed in the submission. Customers may have additional requirements beyond the standard AIAG PPAP elements.. Valid values are `met|not_met|not_applicable`',
    `design_record_number` STRING COMMENT 'Document number of the design record (drawing, CAD model, or specification) that defines the part requirements. PPAP Element 1. Traceable to Siemens Teamcenter PLM document management.',
    `dimensional_results_status` STRING COMMENT 'Overall status of the dimensional inspection results (PPAP Element 10) indicating whether all measured dimensions conform to the design record tolerances. Pass = all characteristics within tolerance; Fail = one or more out of tolerance; Conditional = deviations accepted with customer concession.. Valid values are `pass|fail|conditional`',
    `imds_submission_reference` STRING COMMENT 'Submission identifier in the International Material Data System (IMDS) for material composition reporting. Required for automotive and industrial parts to comply with REACH, RoHS, and ELV regulations. PPAP Element 13 supporting document.',
    `initial_process_study_number` STRING COMMENT 'Document reference number for the Initial Process Capability Study (Preliminary Process Capability) included in the PPAP package. PPAP Element 8. Contains Cp/Cpk indices for critical characteristics.',
    `interim_approval_expiry_date` TIMESTAMP COMMENT 'Expiry date of a conditional or interim PPAP approval granted by the customer. Production is authorized only until this date, after which a full approval or resubmission is required. Null if disposition is full approval or rejection.',
    `is_safety_critical_part` BOOLEAN COMMENT 'Flag indicating whether the submitted part is classified as safety-critical, requiring enhanced PPAP scrutiny, additional testing, and regulatory compliance documentation. Safety-critical parts may require higher PPAP submission levels.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the PPAP submission record. Used for audit trail, data lineage, and change tracking in the Databricks Silver Layer.',
    `manufacturing_process_description` STRING COMMENT 'Brief description of the key manufacturing processes used to produce the part (e.g., CNC machining, injection molding, stamping, welding). Summarizes the process flow documented in the PPAP element.',
    `material_test_results_status` STRING COMMENT 'Overall status of material and functional test results (PPAP Element 11) confirming that the part meets all material specifications and functional performance requirements defined in the design record.. Valid values are `pass|fail|not_applicable`',
    `msa_study_number` STRING COMMENT 'Document reference number for the Measurement System Analysis (MSA) study included in the PPAP package. PPAP Element 7. Validates the measurement systems used for inspection. Aligns with AIAG MSA 4th Edition.',
    `pfmea_number` STRING COMMENT 'Document reference number for the Process Failure Mode and Effects Analysis (PFMEA) included in the PPAP package. PPAP Element 5. Identifies the PFMEA document in Siemens Teamcenter PLM.',
    `production_run_quantity` STRING COMMENT 'Total number of parts produced during the significant production run used to generate PPAP samples and process capability data. Typically a minimum of 300 consecutive pieces per AIAG requirements.',
    `psw_authorization_date` TIMESTAMP COMMENT 'Date on which the suppliers authorized representative signed the Part Submission Warrant (PSW), certifying the completeness and accuracy of the PPAP submission package.',
    `psw_disposition` STRING COMMENT 'Customers formal disposition recorded on the Part Submission Warrant (PSW), the cover document of the PPAP package. Approved = full production authorization; Interim Approval = conditional authorization with defined expiry; Rejected = resubmission required.. Valid values are `approved|interim_approval|rejected`',
    `regulatory_compliance_status` STRING COMMENT 'Status of the parts compliance with applicable regulatory requirements (e.g., REACH, RoHS, CE Marking, UL certification) as documented in the PPAP package. Ensures the submission addresses all relevant regulatory conformance obligations.. Valid values are `compliant|non_compliant|pending|not_applicable`',
    `rejection_reason` STRING COMMENT 'Detailed description of the reason(s) for PPAP rejection or conditional approval issued by the customer. Populated when submission_status is rejected or psw_disposition is rejected. Used to drive corrective actions.',
    `resubmission_due_date` TIMESTAMP COMMENT 'Target date by which a corrected PPAP package must be resubmitted to the customer following a rejection or conditional approval. Agreed between supplier and customer quality teams.',
    `sample_quantity` STRING COMMENT 'Number of sample parts produced from the production run and submitted to the customer as part of the PPAP package. PPAP Element 9. AIAG typically requires a minimum of 300 consecutive pieces for initial process studies.',
    `submission_date` TIMESTAMP COMMENT 'Date on which the completed PPAP package was formally submitted to the customer for review and approval. Represents the principal business event timestamp for this transaction.',
    `submission_level` STRING COMMENT 'AIAG-defined PPAP submission level (1 through 5) indicating the extent of documentation and samples required by the customer. Level 1 = Part Submission Warrant only; Level 5 = Full submission retained at manufacturing site.',
    `submission_notes` STRING COMMENT 'Free-text field for additional notes, clarifications, or special conditions associated with the PPAP submission. May include customer-specific instructions, deviations, or open action items.',
    `submission_number` STRING COMMENT 'Externally-known business identifier for the PPAP submission package, typically assigned by the quality management system (SAP QM) or PLM system. Used for cross-system traceability and customer communication.',
    `submission_reason` STRING COMMENT 'Reason triggering the PPAP submission as defined by AIAG. Indicates whether the submission is for a new part, an engineering change order (ECO), tooling change, process change, supplier change, or material change. [ENUM-REF-CANDIDATE: new_part|engineering_change|tooling_change|process_change|supplier_change|material_change|correction|resubmission — promote to reference product]. Valid values are `new_part|engineering_change|tooling_change|process_change|supplier_change|material_change`',
    `submission_status` STRING COMMENT 'Current lifecycle status of the PPAP submission package. Tracks progression from draft preparation through customer review to final disposition (approved, conditionally approved, or rejected). Aligns with SAP QM inspection lot status.. Valid values are `draft|submitted|under_review|approved|conditionally_approved|rejected`',
    `tooling_number` STRING COMMENT 'Identifier of the production tooling (mold, die, fixture) used to manufacture the submitted parts. Relevant for tooling-related PPAP submissions and tracked in the asset management system (Maximo).',
    CONSTRAINT pk_ppap_submission PRIMARY KEY(`ppap_submission_id`)
) COMMENT 'Production Part Approval Process (PPAP) submission package record tracking the 18 PPAP elements required for new or changed part approval. Captures submission level, part number, customer, design record, process flow, PFMEA, control plan, measurement system analysis (MSA), initial process capability study, sample parts, and overall submission status. Aligned with AIAG PPAP 4th Edition.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` (
    `customer_complaint_id` BIGINT COMMENT 'Unique system-generated identifier for the customer complaint record. Primary key for this entity.',
    `capa_id` BIGINT COMMENT 'Reference to the formal Corrective and Preventive Action (CAPA) record created to address the root cause of this complaint. Links complaint to the CAPA management process.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Customer complaints involving design defects must be traced to the engineering component to initiate ECOs and DFMEA updates. Quality engineers need to retrieve all complaints for a component during de',
    `contact_id` BIGINT COMMENT 'Reference to the specific contact person at the customer organization who reported the complaint.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Customer complaints in manufacturing often result in credit memos or billing adjustments. Finance teams need to track which invoice was issued to resolve the complaint (credit, replacement billing). T',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account (OEM, distributor, or end user) who submitted the complaint. Links to the customer domain.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Complaints originate from specific customer sites where defects were discovered. Site context is critical for root cause analysis (environmental factors, handling practices, site-specific usage). Manu',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Links complaints to the precise order line, enabling root‑cause analysis and targeted corrective actions.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Complaints identify affected batch/lot numbers for containment, recall management (FDA, NHTSA), and batch genealogy investigation. FK supports automated stock hold, customer notification, and field ac',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Customer complaints reference specific materials (plant-specific part numbers) for defect tracking, quality cost analysis, and supplier scorecarding. Enables material-level complaint rate KPIs and CAP',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: Customer Complaint may stem from an NCR; link complaint to NCR for traceability.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to production.production_plant. Business justification: Customer complaints are attributed to specific manufacturing plants for root cause investigation and corrective action ownership. The existing plant_code plain attribute is denormalized. A proper FK',
    `production_work_order_id` BIGINT COMMENT 'Foreign key linking to production.production_work_order. Business justification: Customer complaints are traced to the specific production work order that manufactured the defective product for root cause analysis and warranty cost allocation. The existing production_order_number',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Complaints are investigated against the exact order intake that generated the sale, supporting root‑cause analysis.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Customer complaint investigations require the originating shipment to assess handling, used in the Complaint Root‑Cause Analysis report.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Customer complaints reference the affected product SKU; FK enables complaint analysis and warranty reporting per SKU.',
    `affected_serial_number` STRING COMMENT 'Serial number of the specific unit reported in the complaint. Enables unit-level traceability through manufacturing, shipping, and field service records.',
    `closure_date` TIMESTAMP COMMENT 'Date on which the complaint was formally closed following customer acceptance of the resolution and verification of corrective action effectiveness.',
    `complaint_description` STRING COMMENT 'Full narrative description of the customer complaint including observed symptoms, conditions of failure, and customer-reported impact. Corresponds to SAP QM QN Problem Description field.',
    `complaint_number` STRING COMMENT 'Externally-visible, human-readable complaint reference number used in customer communications and SAP QM Quality Notification (QN). Format: CC-YYYY-NNNNNN.. Valid values are `^CC-[0-9]{4}-[0-9]{6}$`',
    `complaint_source` STRING COMMENT 'Origin channel or party type from which the complaint was received. Supports segmentation of complaint volumes by customer tier.. Valid values are `oem_customer|distributor|end_user|field_service|warranty_claim|regulatory_body`',
    `complaint_status` STRING COMMENT 'Current workflow state of the complaint record. Drives escalation, SLA tracking, and reporting. pending_customer indicates awaiting customer feedback or approval.. Valid values are `open|in_progress|pending_customer|closed|cancelled`',
    `complaint_title` STRING COMMENT 'Short, human-readable summary title of the complaint as entered by the quality engineer or service representative. Used in dashboards and notification emails.',
    `complaint_type` STRING COMMENT 'Categorization of the complaint by nature of the issue. Used for trend analysis, routing, and regulatory reporting. [ENUM-REF-CANDIDATE: product_defect|field_failure|delivery_issue|documentation_error|safety_concern|performance_deviation — promote to reference product]. Valid values are `product_defect|field_failure|delivery_issue|documentation_error|safety_concern|performance_deviation`',
    `containment_action` STRING COMMENT 'Immediate containment action taken to prevent further defective product from reaching the customer, corresponding to Step D3 of the 8D problem-solving methodology. Includes field holds, sorting, or shipment stops.',
    `containment_date` TIMESTAMP COMMENT 'Date on which the containment action was implemented. Used to measure response speed and SLA compliance for initial containment.',
    `corrective_action_completed_date` TIMESTAMP COMMENT 'Actual date on which the permanent corrective action was fully implemented and verified effective.',
    `corrective_action_description` STRING COMMENT 'Description of the permanent corrective action selected and implemented to eliminate the root cause, corresponding to 8D Steps D5 (select) and D6 (implement). May trigger an Engineering Change Order (ECO) or Engineering Change Notice (ECN).',
    `corrective_action_due_date` TIMESTAMP COMMENT 'Target date by which the permanent corrective action must be implemented and verified. Used for SLA tracking and escalation management.',
    `created_timestamp` TIMESTAMP COMMENT 'System audit timestamp recording when this complaint record was first created in the data platform.',
    `customer_acceptance_status` STRING COMMENT 'Status of the customers acceptance of the proposed resolution or 8D corrective action response. Determines whether the complaint can be formally closed.. Valid values are `accepted|rejected|pending|conditionally_accepted`',
    `customer_order_number` STRING COMMENT 'SAP SD sales order number associated with the delivery of the affected product. Links complaint to order fulfillment and revenue impact analysis.',
    `customer_response_date` TIMESTAMP COMMENT 'Date on which the formal response (e.g., 8D report, corrective action plan) was communicated to the customer. Used for SLA compliance measurement.',
    `defect_location` STRING COMMENT 'Physical location or component area on the product where the defect or failure was observed. Supports PFMEA and design engineering root cause analysis.',
    `eight_d_report_number` STRING COMMENT 'Reference number of the formal 8D (Eight Disciplines) problem-solving report issued to the customer. Required by many OEM customers as part of complaint resolution documentation.',
    `failure_code` STRING COMMENT 'Standardized alphanumeric code from the quality defect code catalog identifying the failure mode. Used for statistical analysis and SPC trending. Corresponds to SAP QM defect code.. Valid values are `^[A-Z]{2,4}-[0-9]{3,6}$`',
    `failure_mode` STRING COMMENT 'Specific manner in which the product or component failed as identified during complaint investigation. Aligned with FMEA failure mode taxonomy. [ENUM-REF-CANDIDATE: promote to reference product for standardized failure mode codes]',
    `is_regulatory_reportable` BOOLEAN COMMENT 'Indicates whether this complaint must be reported to a regulatory authority (e.g., OSHA, EPA, UL, CE Marking body). Triggers compliance workflow and documentation requirements.',
    `is_safety_related` BOOLEAN COMMENT 'Indicates whether the complaint involves a potential safety hazard to personnel or end users. Triggers mandatory escalation to product safety and regulatory teams per OSHA and CE Marking requirements.',
    `preventive_action_description` STRING COMMENT 'Description of systemic preventive actions taken to prevent recurrence of similar complaints across other products or processes, corresponding to 8D Step D7.',
    `quantity_complained` STRING COMMENT 'Number of units reported as defective or non-conforming in the complaint. Used for severity assessment and potential recall scope estimation.',
    `quantity_returned` STRING COMMENT 'Number of units physically returned by the customer under a Return Material Authorization (RMA). May differ from quantity complained if partial returns occur.',
    `received_timestamp` TIMESTAMP COMMENT 'Precise date and time when the complaint was received and logged in the system. Used for SLA response-time measurement.',
    `reported_date` TIMESTAMP COMMENT 'Calendar date on which the customer formally reported or submitted the complaint. Used as the principal business event date for SLA and aging calculations.',
    `resolution_type` STRING COMMENT 'Type of resolution provided to the customer. Drives financial impact tracking (credit notes, replacements) and customer satisfaction measurement.. Valid values are `replacement|repair|credit_note|rework|no_fault_found|goodwill`',
    `root_cause_category` STRING COMMENT 'Standardized category of the identified root cause. Enables Pareto analysis of complaint drivers across design, process, material, and supplier dimensions. [ENUM-REF-CANDIDATE: design|process|material|supplier|handling|measurement|other — 7 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Narrative description of the verified root cause of the complaint, corresponding to Step D4 of the 8D methodology. May reference 5-Why analysis, fishbone diagram, or PFMEA findings.',
    `salesforce_case_number` STRING COMMENT 'Cross-reference identifier from Salesforce Service Cloud case record linked to this complaint, enabling traceability between CRM and quality management systems.',
    `sap_qn_number` STRING COMMENT 'SAP QM Quality Notification number corresponding to this complaint, used for traceability within SAP S/4HANA QM module.',
    `severity_level` DECIMAL(18,2) COMMENT 'Severity classification of the complaint based on customer impact, safety risk, and regulatory implications. Drives escalation rules and response SLA targets. Aligned with FMEA severity ranking.',
    `updated_timestamp` TIMESTAMP COMMENT 'System audit timestamp recording the most recent modification to this complaint record.',
    CONSTRAINT pk_customer_complaint PRIMARY KEY(`customer_complaint_id`)
) COMMENT 'Customer complaint and field quality issue record capturing reported defects, failures, or dissatisfaction from OEM customers, distributors, or end users. Tracks complaint description, affected product/serial number, failure mode, 8D problem-solving steps, containment actions, root cause, corrective actions, and customer response. Integrates with Salesforce Service Cloud and SAP QM QN.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` (
    `rma_disposition_id` BIGINT COMMENT 'Unique identifier for the RMA disposition record. Primary key for tracking quality disposition decisions on returned products.',
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.capa. Business justification: rma_disposition has a capa_required_flag (BOOLEAN) indicating that a CAPA may be triggered from the RMA quality disposition. When a CAPA is created in response to the RMA findings, the capa_id FK link',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.customer_contact. Business justification: RMA disposition decisions require coordination with specific customer contacts (receiving manager, quality engineer) for return authorization approval, disposition agreement (scrap/rework/credit), and',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: RMA dispositions (scrap/repair/replace/credit) directly drive billing actions: credit memos for returned goods, invoices for replacement shipments, repair charges. Manufacturing finance requires linki',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account that initiated the return. Links to the customer master data.',
    `customer_complaint_id` BIGINT COMMENT 'Foreign key linking to quality.customer_complaint. Business justification: An RMA disposition record is the quality outcome of a product return, which is typically initiated by a customer complaint. Linking rma_disposition to customer_complaint establishes the traceability c',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Returns are processed to/from specific customer sites with site-specific return procedures and receiving locations. Manufacturing reality: material returned from customers warehouse vs. production si',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: When returned material is received, an inspection lot is created to perform incoming quality inspection of the returned goods. rma_disposition has denormalized incoming_inspection_result and inspectio',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: RMA material is received and stored at specific facility locations (RMA receiving dock, quarantine area, scrap bin). Essential for warehouse management, inventory segregation, and disposition tracking',
    `ncr_id` BIGINT COMMENT '',
    `rma_id` BIGINT COMMENT 'Foreign key linking to order.order_rma. Business justification: Disposition decisions (scrap, repair, restock, credit) are made on RMA cases. Core quality→order return workflow linking quality inspection outcomes to return authorizations. Drives credit memo issuan',
    `rma_line_id` BIGINT COMMENT 'Foreign key linking to order.rma_line. Business justification: Disposition decisions apply to specific returned line items. Tracks which items are scrapped, repaired, or restocked at line-item granularity. Essential for inventory accounting, warranty cost allocat',
    `sku_master_id` BIGINT COMMENT '',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: RMA disposition needs to reference the storage location where returned material is held, required for inventory reconciliation and warranty processing.',
    `batch_number` STRING COMMENT 'Production batch or lot number of the returned product, used for batch-level quality analysis and potential recall actions.',
    `capa_required_flag` BOOLEAN COMMENT 'Indicates whether this RMA disposition requires initiation of a formal CAPA process for systemic issue resolution.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this RMA disposition record was first created in the data system.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Monetary credit amount issued to the customer if disposition was credit, in the transaction currency.',
    `credit_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the credit amount (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `currency_code` STRING COMMENT '',
    `customer_reference_number` STRING COMMENT 'Customers own reference or tracking number for this return, used for cross-reference in customer communications.',
    `disposition_code` STRING COMMENT '',
    `disposition_decision` STRING COMMENT 'Final disposition decision for the returned material, determining the action to be taken and financial impact. [ENUM-REF-CANDIDATE: repair|replace|scrap|credit|return_to_customer|use_as_is|rework — 7 candidates stripped; promote to reference product]',
    `disposition_notes` STRING COMMENT '',
    `disposition_reason` STRING COMMENT '',
    `disposition_status` STRING COMMENT '',
    `disposition_timestamp` TIMESTAMP COMMENT 'Date and time when the disposition decision was made and authorized.',
    `disposition_type` STRING COMMENT '',
    `failure_code_confirmed` STRING COMMENT 'Standardized failure code assigned by quality inspection based on actual findings, used for defect trending and FMEA analysis.',
    `failure_code_reported` STRING COMMENT 'Standardized failure code selected by customer or service representative at time of return initiation.',
    `failure_description_confirmed` STRING COMMENT 'Detailed description of the actual failure or defect as confirmed by quality inspection, which may differ from the customer-reported failure.',
    `failure_description_reported` STRING COMMENT 'Customers description of the failure or defect as reported at the time of RMA initiation.',
    `inspection_completed_date` DATE COMMENT 'Date when the incoming inspection and failure analysis were completed.',
    `quantity_disposed` DECIMAL(18,2) COMMENT '',
    `quantity_returned` DECIMAL(18,2) COMMENT 'Number of units returned under this RMA. May be fractional for bulk materials measured by weight or volume.',
    `quantity_uom` STRING COMMENT '',
    `received_timestamp` TIMESTAMP COMMENT '',
    `receiving_plant_code` STRING COMMENT 'SAP plant code of the facility that received the returned material for inspection and disposition.',
    `receiving_warehouse_location` STRING COMMENT 'Specific warehouse location or storage bin where the returned material is held pending disposition.',
    `repair_action_performed` STRING COMMENT 'Description of the repair or rework actions performed on the returned product, if disposition was repair or rework.',
    `repair_completed_date` DATE COMMENT 'Date when repair or rework activities were completed and the product was ready for return or reuse.',
    `replacement_material_number` STRING COMMENT 'Material number of the replacement product sent to the customer, if disposition was replace.',
    `replacement_order_number` STRING COMMENT '',
    `replacement_serial_number` STRING COMMENT 'Serial number of the replacement unit shipped to the customer, enabling traceability of the replacement.',
    `return_initiated_date` DATE COMMENT 'Date when the RMA was authorized and the return process was initiated by the customer or service team.',
    `return_reason_code` STRING COMMENT '',
    `return_received_timestamp` TIMESTAMP COMMENT 'Date and time when the returned product was physically received at the inspection facility or warehouse.',
    `return_shipment_date` DATE COMMENT 'Date when the repaired or replacement product was shipped back to the customer.',
    `return_to_customer_status` STRING COMMENT 'Status of the return shipment to the customer for repaired or replaced products.. Valid values are `not_applicable|pending|shipped|delivered|cancelled`',
    `return_tracking_number` STRING COMMENT 'Carrier tracking number for the return shipment to the customer, enabling delivery confirmation.',
    `returned_material_description` STRING COMMENT 'Full text description of the returned material for human readability and reporting.',
    `returned_material_number` STRING COMMENT 'Material number (SKU) of the product being returned. References the product master in SAP MM.',
    `returned_quantity` DECIMAL(18,2) COMMENT '',
    `rma_status` STRING COMMENT 'Current lifecycle status of the RMA process, tracking progression from initiation through final disposition. [ENUM-REF-CANDIDATE: initiated|in_transit|received|inspection_in_progress|disposition_complete|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `rma_type` STRING COMMENT 'Classification of the return reason category, determining handling procedures and cost allocation.. Valid values are `warranty|non_warranty|field_service|customer_complaint|recall|goodwill`',
    `root_cause_category` STRING COMMENT 'High-level categorization of the root cause of the failure, used for quality improvement prioritization. [ENUM-REF-CANDIDATE: design|manufacturing|material|handling|installation|operation|maintenance|no_defect — 8 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed explanation of the root cause determined through failure analysis, supporting CAPA and continuous improvement.',
    `salesforce_case_reference` STRING COMMENT 'Reference to the originating service case in Salesforce Service Cloud that initiated this RMA.',
    `sap_qm_notification_number` STRING COMMENT 'Quality notification number generated in SAP QM module for tracking the quality issue associated with this RMA.. Valid values are `^[0-9]{10,12}$`',
    `scrap_disposition_flag` BOOLEAN COMMENT '',
    `serial_number` STRING COMMENT 'Unique serial number of the specific unit being returned, enabling traceability to manufacturing batch and production history.',
    `supplier_responsibility_flag` BOOLEAN COMMENT 'Indicates whether the root cause is attributable to a supplier defect, triggering supplier quality notification and potential cost recovery.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the returned quantity (each, kilogram, meter, liter, etc.). [ENUM-REF-CANDIDATE: EA|KG|LB|M|FT|L|GAL|M2|M3 — 9 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this RMA disposition record was last modified, supporting audit trail and data lineage.',
    `warranty_claim_flag` BOOLEAN COMMENT 'Indicates whether this RMA is covered under product warranty terms, affecting cost allocation and supplier recovery.',
    CONSTRAINT pk_rma_disposition PRIMARY KEY(`rma_disposition_id`)
) COMMENT 'Return Material Authorization (RMA) quality disposition record for products returned from customers or field service due to reported defects or failures. Captures RMA number, returned product/serial number, customer reference, failure description reported vs confirmed, incoming inspection results upon receipt, root cause determination, disposition decision (repair/replace/scrap/credit/no-fault-found), repair actions performed, and return-to-customer shipment status. Integrates with Salesforce Service Cloud for case tracking and SAP QM for quality notification generation.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` (
    `certificate_of_conformance_id` BIGINT COMMENT 'Primary key for certificate_of_conformance',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer to whom this certificate is issued. Links to customer master data.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Certificates of Conformance are issued to specific customer receiving sites for traceability and site-specific receiving inspection requirements. Manufacturing reality: shipment CoC must reference the',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_specification. Business justification: CoCs certify conformance to a specific engineering specification. specification_reference and specification_version on CoC are denormalized signals. Linking to engineering_specification enables automa',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: Certificates of conformance reference measurement equipment used for certification testing. Required for traceability, regulatory compliance (FDA, ISO), and customer audit requirements in regulated ma',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Certificate of Conformance is issued for a specific Inspection Lot; replace string with FK.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: CoCs may reference test facility location for regulatory compliance and customer requirements. Supports multi-site manufacturing traceability and quality system audits (ISO 9001, AS9100, IATF 16949).',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: CoCs certify specific batch/lot numbers for customer delivery. FK enables automated CoC generation from batch master data and supports regulatory compliance (IATF 16949, AS9100). Batch_number/lot_numb',
    `material_master_id` BIGINT COMMENT 'Identifier of the material or product for which this certificate is issued. Links to master material data.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to production.production_plant. Business justification: Certificates of conformance are issued by specific manufacturing plants and must identify the issuing plant. The existing plant_code and plant_name plain attributes are denormalized. A proper FK e',
    `ppap_submission_id` BIGINT COMMENT 'Foreign key linking to quality.ppap_submission. Business justification: A Certificate of Conformance issued for a PPAP-approved part references the PPAP submission that established the approval baseline. certificate_of_conformance has a denormalized ppap_submission_number',
    `production_goods_receipt_id` BIGINT COMMENT 'Foreign key linking to production.production_goods_receipt. Business justification: A certificate of conformance is issued upon production goods receipt posting for finished goods. The CoC certifies the specific batch/lot received into stock. Linking CoC to the GR document enables sh',
    `production_work_order_id` BIGINT COMMENT 'Foreign key linking to production.production_work_order. Business justification: Certificates of conformance are issued for specific production orders; the CoC certifies the output of a specific work order. The existing production_order_number plain attribute is denormalized. A ',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Certificates of conformance must certify a specific engineering revision. revision_number on CoC is a denormalized signal. Customers require revision-specific CoCs; linking to engineering_revision ena',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Certificates of Conformance are issued per contract requirements in regulated manufacturing. Must reference governing contract to verify compliance with contractual quality standards, specifications, ',
    `shipment_id` BIGINT COMMENT '',
    `sku_master_id` BIGINT COMMENT '',
    `applicable_standard` STRING COMMENT '',
    `authorized_signatory_name` STRING COMMENT 'Name of the authorized person who signed and approved the certificate for release. Typically a quality manager or authorized representative.',
    `authorized_signatory_title` STRING COMMENT 'Job title or position of the authorized signatory (e.g., Quality Manager, Plant Manager, Authorized Representative).',
    `certificate_language` STRING COMMENT 'Language in which the certificate is issued (ISO 639-1 two-letter code or full language name). May be required for international shipments.',
    `certificate_number` STRING COMMENT 'Externally-known unique certificate number assigned to this Certificate of Conformance or Certificate of Analysis. Used for customer reference and traceability.',
    `certificate_status` STRING COMMENT 'Current lifecycle status of the certificate. Draft = under preparation, Issued = released to customer, Revised = updated version issued, Voided = cancelled, Superseded = replaced by newer version, Archived = historical record.. Valid values are `draft|issued|revised|voided|superseded|archived`',
    `certificate_type` STRING COMMENT 'Type of quality certificate issued. CoC = Certificate of Conformance, CoA = Certificate of Analysis, CoC_CoA = Combined certificate, Material_Test_Report = MTR, Mill_Test_Certificate = MTC for raw materials, Inspection_Certificate = third-party inspection.. Valid values are `CoC|CoA|CoC_CoA|Material_Test_Report|Mill_Test_Certificate|Inspection_Certificate`',
    `conformance_statement` STRING COMMENT 'Formal statement declaring that the material conforms to specified requirements. Typically a standardized declaration text.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certificate record was first created in the system. Audit trail for record creation.',
    `customer_name` STRING COMMENT 'Name of the customer receiving this certificate. Denormalized for certificate document completeness.',
    `customer_order_number` STRING COMMENT 'Customers purchase order number or reference number for which this certificate is issued. Enables customer-side traceability.',
    `customer_part_number` STRING COMMENT '',
    `customer_specific_requirements` STRING COMMENT 'Additional customer-specific requirements or clauses that must be included in the certificate per customer contract or specification.',
    `delivery_number` STRING COMMENT 'Shipment or delivery document number for the material covered by this certificate. Links certificate to logistics execution.',
    `digital_signature_reference` STRING COMMENT 'Identifier or hash of the digital signature applied to the certificate for authenticity and non-repudiation. Used for electronic certificates.',
    `document_url` STRING COMMENT 'URL or file path to the PDF or electronic document of the certificate stored in the document management system.',
    `expiry_date` TIMESTAMP COMMENT '',
    `inspection_date` DATE COMMENT 'Date when the quality inspection or testing was performed for this certificate.',
    `inspector_name` STRING COMMENT 'Name of the quality inspector or technician who performed the inspection and testing.',
    `issue_date` TIMESTAMP COMMENT '',
    `issued_date` TIMESTAMP COMMENT 'Date when the certificate was officially issued and released to the customer or recipient.',
    `issued_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the certificate was officially issued, including time zone information for global traceability.',
    `lot_quantity` DECIMAL(18,2) COMMENT '',
    `material_description` STRING COMMENT 'Full description of the material or product covered by this certificate. Provides human-readable identification.',
    `material_number` STRING COMMENT 'Material number (SKU) of the product or material covered by this certificate. Corresponds to SAP material master.',
    `material_specification` STRING COMMENT '',
    `part_number` STRING COMMENT '',
    `ppap_level` DECIMAL(18,2) COMMENT 'PPAP submission level if this certificate is part of a PPAP package. Levels 1-5 define the documentation requirements per AIAG PPAP standard.',
    `quantity_certified` DECIMAL(18,2) COMMENT 'Quantity of material covered by this certificate. Represents the amount tested and certified as conforming.',
    `quantity_uom` STRING COMMENT '',
    `regulatory_compliance_statement` STRING COMMENT 'Statement of compliance with applicable regulatory requirements (e.g., RoHS, REACH, FDA, CE marking). Lists regulations the product conforms to.',
    `regulatory_reference` STRING COMMENT '',
    `revision_date` DATE COMMENT 'Date of the most recent revision to this certificate. Null for initial issue.',
    `revision_reason` STRING COMMENT 'Explanation for why the certificate was revised. Documents the nature of corrections or updates made.',
    `sales_order_number` STRING COMMENT 'Internal sales order number associated with the shipment covered by this certificate.',
    `serial_number` STRING COMMENT 'Unique serial number of the individual unit or assembly covered by this certificate. Used for serialized products requiring unit-level traceability.',
    `signature_date` DATE COMMENT 'Date when the authorized signatory signed and approved the certificate.',
    `standard_reference` STRING COMMENT '',
    `test_method_reference` STRING COMMENT 'Reference to the test methods or standards used for inspection and testing (e.g., ASTM E8, ISO 6892, EN 10002). May list multiple methods.',
    `test_report_number` STRING COMMENT '',
    `test_results_summary` STRING COMMENT 'Summary of key test results and measurements included in the certificate. May include chemical composition, mechanical properties, dimensional checks, etc.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the certified quantity (e.g., EA, KG, M, L). Follows ISO 31 or SAP UoM standards.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this certificate record was last modified. Audit trail for record changes.',
    CONSTRAINT pk_certificate_of_conformance PRIMARY KEY(`certificate_of_conformance_id`)
) COMMENT 'Quality certificate (Certificate of Conformance / Certificate of Analysis) issued for manufactured products or material lots shipped to customers. Captures certificate type (CoC, CoA), issued date, product/material, lot/batch number, inspection lot reference, test results summary, specification compliance statement, authorized signatory, and customer-specific certificate requirements.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` (
    `inspection_characteristic_id` BIGINT COMMENT 'Primary key for inspection_characteristic',
    `component_id` BIGINT COMMENT '',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_specification. Business justification: Inspection characteristics are derived from engineering specifications — the spec defines what must be measured and to what tolerance. spec_source on inspection_characteristic is a denormalized signal',
    `parent_inspection_characteristic_id` BIGINT COMMENT 'Self-referencing FK on inspection_characteristic (parent_inspection_characteristic_id)',
    `resource_tool_id` BIGINT COMMENT 'Foreign key linking to production.resource_tool. Business justification: Each inspection characteristic specifies the calibrated measurement tool (gauge, CMM, micrometer) required. The existing measurement_tool plain attribute is denormalized. A proper FK to resource_too',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Inspection characteristics define measurable quality attributes (dimensions, tolerances, performance parameters) for manufactured parts. Direct link to sku_master enables traceability of which charact',
    `characteristic_class` STRING COMMENT '',
    `characteristic_code` STRING COMMENT '',
    `characteristic_name` STRING COMMENT '',
    `characteristic_number` STRING COMMENT '',
    `characteristic_type` STRING COMMENT 'Category of the characteristic indicating the nature of the measurement.',
    `inspection_characteristic_code` STRING COMMENT 'Unique alphanumeric code assigned by engineering to identify the characteristic across systems.',
    `control_indicator` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the characteristic record was first created.',
    `criticality_level` DECIMAL(18,2) COMMENT 'Impact level of the characteristic on product quality and compliance.',
    `data_collection_system` STRING COMMENT 'System that records the measurement data (e.g., MES, PLC, manual log).',
    `inspection_characteristic_description` STRING COMMENT 'Detailed description of what the characteristic measures and why it is important.',
    `effective_from` DATE COMMENT 'Date when the characteristic becomes valid for use.',
    `effective_until` DATE COMMENT 'Date when the characteristic is retired or superseded (null if open‑ended).',
    `frequency_per_shift` STRING COMMENT 'Number of times this characteristic is inspected each production shift.',
    `inspection_method` STRING COMMENT 'Method used to capture the characteristic (e.g., manual, automated sensor).',
    `inspection_method_code` STRING COMMENT '',
    `is_critical` BOOLEAN COMMENT '',
    `is_critical_to_quality` BOOLEAN COMMENT '',
    `is_required` BOOLEAN COMMENT 'Indicates whether the characteristic must be inspected for every unit.',
    `is_safety_characteristic` BOOLEAN COMMENT '',
    `is_statistical_process_control` BOOLEAN COMMENT 'True if the characteristic is used in SPC calculations (Cp/Cpk).',
    `lifecycle_status` STRING COMMENT 'Current status of the characteristic definition.',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable value for the characteristic.',
    `measurement_unit` STRING COMMENT 'Unit of measure used for the characteristic (e.g., mm, °C, psi).',
    `inspection_characteristic_name` STRING COMMENT 'Human‑readable name of the inspection characteristic used in reports and work instructions.',
    `nominal_value` DECIMAL(18,2) COMMENT '',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or remarks.',
    `operation_number` DECIMAL(18,2) COMMENT '',
    `sample_size` STRING COMMENT '',
    `sampling_plan` STRING COMMENT 'Definition of the sampling approach (e.g., 1‑in‑5, 100% inspection).',
    `sampling_procedure` STRING COMMENT '',
    `sampling_procedure_code` STRING COMMENT '',
    `sequence_number` STRING COMMENT '',
    `spc_enabled` BOOLEAN COMMENT '',
    `special_characteristic_code` STRING COMMENT '',
    `target_value` DECIMAL(18,2) COMMENT 'Nominal target value that the characteristic is expected to meet.',
    `tolerance` DECIMAL(18,2) COMMENT 'Allowed deviation from the target value, expressed in the same unit as measurement_unit.',
    `tolerance_lower` DECIMAL(18,2) COMMENT '',
    `tolerance_upper` DECIMAL(18,2) COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the characteristic record.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable value for the characteristic.',
    CONSTRAINT pk_inspection_characteristic PRIMARY KEY(`inspection_characteristic_id`)
) COMMENT 'Master reference table for inspection_characteristic. Referenced by characteristic_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_fmea_id` FOREIGN KEY (`fmea_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`fmea`(`fmea_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_inspection_characteristic_id` FOREIGN KEY (`inspection_characteristic_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_characteristic`(`inspection_characteristic_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_ppap_submission_id` FOREIGN KEY (`ppap_submission_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ppap_submission`(`ppap_submission_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_fmea_id` FOREIGN KEY (`fmea_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`fmea`(`fmea_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_inspection_characteristic_id` FOREIGN KEY (`inspection_characteristic_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_characteristic`(`inspection_characteristic_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ADD CONSTRAINT `fk_quality_rma_disposition_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ADD CONSTRAINT `fk_quality_rma_disposition_customer_complaint_id` FOREIGN KEY (`customer_complaint_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`customer_complaint`(`customer_complaint_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ADD CONSTRAINT `fk_quality_rma_disposition_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ADD CONSTRAINT `fk_quality_rma_disposition_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_ppap_submission_id` FOREIGN KEY (`ppap_submission_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ppap_submission`(`ppap_submission_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ADD CONSTRAINT `fk_quality_inspection_characteristic_parent_inspection_characteristic_id` FOREIGN KEY (`parent_inspection_characteristic_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_characteristic`(`inspection_characteristic_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_manufacturing_v1`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_subdomain' = 'inspection_management');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Specification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `fmea_id` SET TAGS ('dbx_business_glossary_term' = 'Fmea Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `apqp_phase` SET TAGS ('dbx_business_glossary_term' = 'Advanced Product Quality Planning (APQP) Phase');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `apqp_phase` SET TAGS ('dbx_value_regex' = 'phase_1|phase_2|phase_3|phase_4|phase_5');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `aql_level` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Quality Level (AQL)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `characteristic_count` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic Count');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `characteristic_unit` SET TAGS ('dbx_business_glossary_term' = 'Characteristic Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `control_method_code` SET TAGS ('dbx_business_glossary_term' = 'Control Method Code');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `control_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `cpk_minimum` SET TAGS ('dbx_business_glossary_term' = 'Minimum Process Capability Index (Cpk)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `customer_specific_requirement` SET TAGS ('dbx_business_glossary_term' = 'Customer-Specific Requirement Flag');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `equipment_category` SET TAGS ('dbx_business_glossary_term' = 'Inspection Equipment Category');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `equipment_category` SET TAGS ('dbx_value_regex' = 'gauge|cmm|vision_system|test_bench|manual|spc_tool');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_method_code` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method Code');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_business_glossary_term' = 'Inspection Scope');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_value_regex' = 'full|reduced|tightened|skip_lot');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_business_glossary_term' = 'Inspection Stage');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_value_regex' = 'incoming|in_process|final|outgoing|skip');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `long_text_description` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Long Text Description');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `lower_tolerance_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Tolerance Limit (LTL)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `operation_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Operation Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Name');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^QP-[A-Z0-9]{2,10}-[0-9]{4,8}$');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Status');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|obsolete|under_review');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Type');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Version');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `ppap_level` SET TAGS ('dbx_business_glossary_term' = 'Production Part Approval Process (PPAP) Level');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `product_group_code` SET TAGS ('dbx_business_glossary_term' = 'Product Group Code');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `sample_size_unit` SET TAGS ('dbx_business_glossary_term' = 'Sample Size Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `sampling_procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Sampling Procedure Code');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `spc_enabled` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Enabled Flag');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target (Nominal) Value');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `upper_tolerance_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Tolerance Limit (UTL)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `usage_decision_code` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Code');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (User ID)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_subdomain' = 'inspection_management');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `contract_release_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Release Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Item Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `procurement_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Certificate Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `certificate_of_conformance_required` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Conformance (CoC) Required');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `disposition_by` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision Made By');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Disposition Code');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision / Disposition Decision');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'accept|reject|rework|scrap|conditional_release');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `disposition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `dynamic_modification_rule` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Modification Rule');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_level` SET TAGS ('dbx_business_glossary_term' = 'Inspection Level');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_type_code` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type Code');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_type_description` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type Description');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_origin_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Origin Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_quantity` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Quantity Unit of Measure (UoM)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_remarks` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Remarks');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Status');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_value_regex' = 'created|released|results_recorded|usage_decided|closed');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `ncr_triggered` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Triggered');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `nonconforming_quantity` SET TAGS ('dbx_business_glossary_term' = 'Non-Conforming Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `overall_result` SET TAGS ('dbx_business_glossary_term' = 'Overall Inspection Result');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `overall_result` SET TAGS ('dbx_value_regex' = 'passed|failed|conditionally_passed|pending');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `required_end_date` SET TAGS ('dbx_business_glossary_term' = 'Required Inspection End Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `sample_drawing_procedure` SET TAGS ('dbx_business_glossary_term' = 'Sample Drawing Procedure');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` SET TAGS ('dbx_subdomain' = 'inspection_management');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_result_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_characteristic_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `attribute_result` SET TAGS ('dbx_business_glossary_term' = 'Attribute Inspection Result');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `attribute_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Gauge Calibration Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `characteristic_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic Type');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `characteristic_type` SET TAGS ('dbx_value_regex' = 'variable|attribute|visual|functional');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `cp_index` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cp)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `cpk_index` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cpk)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_method` SET TAGS ('dbx_value_regex' = 'manual|automated|semi_automated|destructive|non_destructive');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_business_glossary_term' = 'Inspection Stage');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_value_regex' = 'incoming|in_process|final|outgoing|supplier');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `is_out_of_control` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Control Flag (SPC)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `is_out_of_spec` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Specification Flag');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `lower_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `nominal_value` SET TAGS ('dbx_business_glossary_term' = 'Nominal (Target) Value');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Inspector Remarks');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result Status');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|conditional|open|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `sampling_procedure` SET TAGS ('dbx_business_glossary_term' = 'Sampling Procedure');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Production Shift Code');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = 'day|afternoon|night');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `spc_chart_type` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Chart Type');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `subgroup_number` SET TAGS ('dbx_business_glossary_term' = 'SPC Subgroup Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `usage_decision_code` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Code (UD)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ALTER COLUMN `usage_decision_code` SET TAGS ('dbx_value_regex' = 'accept|reject|rework|scrap|conditional_release');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` SET TAGS ('dbx_subdomain' = 'defect_resolution');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Item Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `procurement_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `actual_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Closure Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `containment_action` SET TAGS ('dbx_business_glossary_term' = 'Containment Action Description');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `containment_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Containment Action Completed Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `customer_complaint_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `defect_location` SET TAGS ('dbx_business_glossary_term' = 'Defect Location');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Detection Source');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `detection_source` SET TAGS ('dbx_value_regex' = 'incoming_inspection|in_process|final_inspection|field_customer|audit|supplier_delivery');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Detection Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `disposition_authority` SET TAGS ('dbx_business_glossary_term' = 'Disposition Authority');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `disposition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `eight_d_report_number` SET TAGS ('dbx_business_glossary_term' = '8D Report Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `is_8d_required` SET TAGS ('dbx_business_glossary_term' = '8D Problem Solving Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `ncr_number` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `ncr_number` SET TAGS ('dbx_value_regex' = '^NCR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `ncr_status` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Status');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `ncr_status` SET TAGS ('dbx_value_regex' = 'draft|open|under_review|disposition_pending|closed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `ncr_type` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Type');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `ncr_type` SET TAGS ('dbx_value_regex' = 'internal|customer|supplier|field_return|audit');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `nonconformance_description` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Description');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `nonconforming_qty` SET TAGS ('dbx_business_glossary_term' = 'Non-Conforming Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `qty_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `regulatory_reportable` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Reported Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `return_shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment Status');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `return_shipment_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|in_transit|received|inspected|closed');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `sap_qm_notification_type` SET TAGS ('dbx_business_glossary_term' = 'SAP Quality Management (QM) Notification Type');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `sap_qm_notification_type` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Severity Classification');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|observation');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `target_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Target Closure Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` SET TAGS ('dbx_subdomain' = 'defect_resolution');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `action_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Action Implementation Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `actual_closure_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Actual Closure Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `affected_process_code` SET TAGS ('dbx_business_glossary_term' = 'Affected Process Code');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `capa_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `capa_number` SET TAGS ('dbx_value_regex' = '^CAPA-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `capa_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Status');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `capa_status` SET TAGS ('dbx_value_regex' = 'draft|open|in_progress|pending_verification|closed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `capa_type` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Type');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `capa_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|both');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `containment_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Containment Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `customer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `effectiveness_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verification Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `effectiveness_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verification Method');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `effectiveness_verified` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verified Flag');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `immediate_containment_action` SET TAGS ('dbx_business_glossary_term' = 'Immediate Containment Action');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Initiated Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `n8d_report_number` SET TAGS ('dbx_business_glossary_term' = '8D Report Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `ppap_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Production Part Approval Process (PPAP) Impact Flag');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `preventive_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Plan');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'CAPA Priority');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `problem_description` SET TAGS ('dbx_business_glossary_term' = 'Problem Description');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `quality_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Reference');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `root_cause_analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Method');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category (6M)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'man|machine|material|method|measurement|environment');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `source_reference_number` SET TAGS ('dbx_business_glossary_term' = 'CAPA Source Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'CAPA Source Type');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'ncr|customer_complaint|audit_finding|internal_quality_event|supplier_issue|regulatory_finding');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `target_closure_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Target Closure Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'CAPA Title');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `fmea_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode and Effects Analysis (FMEA) ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `ppap_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Production Part Approval Process (PPAP) ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `action_priority` SET TAGS ('dbx_business_glossary_term' = 'Action Priority (AP)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `action_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `action_taken` SET TAGS ('dbx_business_glossary_term' = 'Action Taken');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'FMEA Approved Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `current_detection_controls` SET TAGS ('dbx_business_glossary_term' = 'Current Detection Controls');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `current_prevention_controls` SET TAGS ('dbx_business_glossary_term' = 'Current Prevention Controls');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `detection_rating` SET TAGS ('dbx_business_glossary_term' = 'Detection (D) Rating');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `failure_cause` SET TAGS ('dbx_business_glossary_term' = 'Failure Cause');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `failure_effect` SET TAGS ('dbx_business_glossary_term' = 'Failure Effect');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `fmea_number` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode and Effects Analysis (FMEA) Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `fmea_number` SET TAGS ('dbx_value_regex' = '^FMEA-[A-Z]{2,6}-[0-9]{4,8}$');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `fmea_status` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode and Effects Analysis (FMEA) Status');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `fmea_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|released|obsolete|superseded');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `fmea_type` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode and Effects Analysis (FMEA) Type');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `fmea_type` SET TAGS ('dbx_value_regex' = 'DFMEA|PFMEA|SFMEA|MFMEA');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `function_description` SET TAGS ('dbx_business_glossary_term' = 'Function Description');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'FMEA Initiated Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `occurrence_rating` SET TAGS ('dbx_business_glossary_term' = 'Occurrence (O) Rating');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `revised_action_priority` SET TAGS ('dbx_business_glossary_term' = 'Revised Action Priority (AP)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `revised_action_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `revised_detection_rating` SET TAGS ('dbx_business_glossary_term' = 'Revised Detection (D) Rating');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `revised_occurrence_rating` SET TAGS ('dbx_business_glossary_term' = 'Revised Occurrence (O) Rating');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `revised_rpn` SET TAGS ('dbx_business_glossary_term' = 'Revised Risk Priority Number (RPN)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `revised_severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Revised Severity (S) Rating');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `revision` SET TAGS ('dbx_business_glossary_term' = 'FMEA Revision Level');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `revision` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `rpn` SET TAGS ('dbx_business_glossary_term' = 'Risk Priority Number (RPN)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `safety_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical Flag');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'FMEA Scope');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Severity (S) Rating');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `special_characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'Special Characteristic Code');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `special_characteristic_code` SET TAGS ('dbx_value_regex' = 'SC|CC|KPC|KCC|');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `team_members` SET TAGS ('dbx_business_glossary_term' = 'FMEA Team Members');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'FMEA Title');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Control Plan ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `fmea_id` SET TAGS ('dbx_business_glossary_term' = 'Process Failure Mode and Effects Analysis (PFMEA) ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `inspection_characteristic_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `sourcing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Rule Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `control_method` SET TAGS ('dbx_business_glossary_term' = 'Control Method');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'prevention|detection');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `cpk_minimum_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Required Process Capability Index (Cpk)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `error_proofing_method` SET TAGS ('dbx_business_glossary_term' = 'Error-Proofing (Poka-Yoke) Method');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `gauge_type` SET TAGS ('dbx_business_glossary_term' = 'Gauge / Measurement Device Type');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `is_ctq` SET TAGS ('dbx_business_glossary_term' = 'Critical-to-Quality (CTQ) Flag');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `is_regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `is_safety_characteristic` SET TAGS ('dbx_business_glossary_term' = 'Safety Characteristic Flag');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `lower_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `nominal_value` SET TAGS ('dbx_business_glossary_term' = 'Nominal Value');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^CP-[A-Z0-9]{2,10}-[0-9]{4,8}$');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Status');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|obsolete|superseded');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Type');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'prototype|pre-launch|production');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `process_step_name` SET TAGS ('dbx_business_glossary_term' = 'Process Step Name');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `process_step_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `process_step_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `process_step_number` SET TAGS ('dbx_business_glossary_term' = 'Process Step Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `reaction_plan` SET TAGS ('dbx_business_glossary_term' = 'Reaction Plan');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `sample_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `spc_chart_type` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Chart Type');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `ppap_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Ppap Submission Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `annual_production_volume` SET TAGS ('dbx_business_glossary_term' = 'Annual Production Volume');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `appearance_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Appearance Approval Report (AAR) Status');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `appearance_approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|not_applicable');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `apqp_phase` SET TAGS ('dbx_business_glossary_term' = 'Advanced Product Quality Planning (APQP) Phase');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `apqp_phase` SET TAGS ('dbx_value_regex' = 'phase_1|phase_2|phase_3|phase_4|phase_5');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `bulk_material_checklist_status` SET TAGS ('dbx_business_glossary_term' = 'Bulk Material Requirements Checklist Status');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `bulk_material_checklist_status` SET TAGS ('dbx_value_regex' = 'complete|incomplete|not_applicable');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `checking_aids_status` SET TAGS ('dbx_business_glossary_term' = 'Checking Aids Status');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `checking_aids_status` SET TAGS ('dbx_value_regex' = 'available|not_available|not_applicable');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `cpk_minimum` SET TAGS ('dbx_business_glossary_term' = 'Minimum Process Capability Index (Cpk)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `customer_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `customer_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Approver Name');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `customer_approver_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `customer_approver_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `customer_approver_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `customer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Part Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `customer_specific_requirements_status` SET TAGS ('dbx_business_glossary_term' = 'Customer-Specific Requirements Status');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `customer_specific_requirements_status` SET TAGS ('dbx_value_regex' = 'met|not_met|not_applicable');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `design_record_number` SET TAGS ('dbx_business_glossary_term' = 'Design Record Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `dimensional_results_status` SET TAGS ('dbx_business_glossary_term' = 'Dimensional Results Status');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `dimensional_results_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `imds_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'International Material Data System (IMDS) Submission ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `initial_process_study_number` SET TAGS ('dbx_business_glossary_term' = 'Initial Process Capability Study Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `interim_approval_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Interim Approval Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `is_safety_critical_part` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical Part Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `manufacturing_process_description` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Process Description');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `material_test_results_status` SET TAGS ('dbx_business_glossary_term' = 'Material and Functional Test Results Status');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `material_test_results_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `msa_study_number` SET TAGS ('dbx_business_glossary_term' = 'Measurement System Analysis (MSA) Study Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `pfmea_number` SET TAGS ('dbx_business_glossary_term' = 'Process Failure Mode and Effects Analysis (PFMEA) Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `production_run_quantity` SET TAGS ('dbx_business_glossary_term' = 'Significant Production Run Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `psw_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Part Submission Warrant (PSW) Authorization Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `psw_disposition` SET TAGS ('dbx_business_glossary_term' = 'Part Submission Warrant (PSW) Disposition');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `psw_disposition` SET TAGS ('dbx_value_regex' = 'approved|interim_approval|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|not_applicable');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'PPAP Rejection Reason');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `resubmission_due_date` SET TAGS ('dbx_business_glossary_term' = 'PPAP Resubmission Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `sample_quantity` SET TAGS ('dbx_business_glossary_term' = 'Sample Part Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'PPAP Submission Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `submission_level` SET TAGS ('dbx_business_glossary_term' = 'PPAP Submission Level');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `submission_notes` SET TAGS ('dbx_business_glossary_term' = 'PPAP Submission Notes');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'PPAP Submission Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `submission_reason` SET TAGS ('dbx_business_glossary_term' = 'PPAP Submission Reason');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `submission_reason` SET TAGS ('dbx_value_regex' = 'new_part|engineering_change|tooling_change|process_change|supplier_change|material_change');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'PPAP Submission Status');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|conditionally_approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ALTER COLUMN `tooling_number` SET TAGS ('dbx_business_glossary_term' = 'Tooling Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` SET TAGS ('dbx_subdomain' = 'defect_resolution');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Invoice Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Site Account Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Production Plant Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Work Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Intake Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `affected_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Complaint Closure Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Complaint Description');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_value_regex' = '^CC-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `complaint_source` SET TAGS ('dbx_business_glossary_term' = 'Complaint Source Channel');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `complaint_source` SET TAGS ('dbx_value_regex' = 'oem_customer|distributor|end_user|field_service|warranty_claim|regulatory_body');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_business_glossary_term' = 'Complaint Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_customer|closed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `complaint_title` SET TAGS ('dbx_business_glossary_term' = 'Complaint Title');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `complaint_type` SET TAGS ('dbx_business_glossary_term' = 'Complaint Type Classification');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `complaint_type` SET TAGS ('dbx_value_regex' = 'product_defect|field_failure|delivery_issue|documentation_error|safety_concern|performance_deviation');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `containment_action` SET TAGS ('dbx_business_glossary_term' = 'Containment Action (8D D3)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `containment_date` SET TAGS ('dbx_business_glossary_term' = 'Containment Action Implementation Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `corrective_action_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completed Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description (8D D5/D6)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `customer_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Acceptance Status');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `customer_acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|pending|conditionally_accepted');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `customer_order_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Sales Order Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `customer_response_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `defect_location` SET TAGS ('dbx_business_glossary_term' = 'Defect Location on Product');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `eight_d_report_number` SET TAGS ('dbx_business_glossary_term' = '8D Problem-Solving Report Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `failure_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Code');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `failure_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{3,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `is_regulatory_reportable` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `is_safety_related` SET TAGS ('dbx_business_glossary_term' = 'Safety-Related Complaint Flag');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `preventive_action_description` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Description (8D D7)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `quantity_complained` SET TAGS ('dbx_business_glossary_term' = 'Quantity Complained');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `quantity_returned` SET TAGS ('dbx_business_glossary_term' = 'Quantity Returned');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Complaint Received Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Complaint Reported Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Complaint Resolution Type');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `resolution_type` SET TAGS ('dbx_value_regex' = 'replacement|repair|credit_note|rework|no_fault_found|goodwill');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description (8D D4)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `salesforce_case_number` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Service Cloud Case Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `sap_qn_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Quality Management (QM) Quality Notification (QN) Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Complaint Severity Level');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` SET TAGS ('dbx_subdomain' = 'defect_resolution');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `rma_disposition_id` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Disposition ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Invoice Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Site Account Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Order Rma Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `rma_line_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `credit_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Credit Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `credit_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `customer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `disposition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `failure_code_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Failure Code Confirmed');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `failure_code_reported` SET TAGS ('dbx_business_glossary_term' = 'Failure Code Reported');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `failure_description_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Failure Description Confirmed by Inspection');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `failure_description_reported` SET TAGS ('dbx_business_glossary_term' = 'Failure Description Reported by Customer');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `inspection_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Completed Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `quantity_returned` SET TAGS ('dbx_business_glossary_term' = 'Quantity Returned');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `receiving_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `receiving_warehouse_location` SET TAGS ('dbx_business_glossary_term' = 'Receiving Warehouse Location');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `repair_action_performed` SET TAGS ('dbx_business_glossary_term' = 'Repair Action Performed');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `repair_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Repair Completed Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `replacement_material_number` SET TAGS ('dbx_business_glossary_term' = 'Replacement Material Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `replacement_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Replacement Product Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `return_initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Return Initiated Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `return_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Received Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `return_shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `return_to_customer_status` SET TAGS ('dbx_business_glossary_term' = 'Return to Customer Status');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `return_to_customer_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|shipped|delivered|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `return_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment Tracking Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `returned_material_description` SET TAGS ('dbx_business_glossary_term' = 'Returned Material Description');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `returned_material_number` SET TAGS ('dbx_business_glossary_term' = 'Returned Material Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `rma_status` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Status');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `rma_type` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Type');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `rma_type` SET TAGS ('dbx_value_regex' = 'warranty|non_warranty|field_service|customer_complaint|recall|goodwill');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `salesforce_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Service Cloud Case ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `sap_qm_notification_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Quality Management (QM) Notification Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `sap_qm_notification_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Product Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `supplier_responsibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplier Responsibility Flag');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `certificate_of_conformance_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Conformance Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Site Account Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Specification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Production Plant Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `ppap_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Ppap Submission Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `production_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Production Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Work Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Name');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `authorized_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Title');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `certificate_language` SET TAGS ('dbx_business_glossary_term' = 'Certificate Language');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate Status');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `certificate_status` SET TAGS ('dbx_value_regex' = 'draft|issued|revised|voided|superseded|archived');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate Type');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `certificate_type` SET TAGS ('dbx_value_regex' = 'CoC|CoA|CoC_CoA|Material_Test_Report|Mill_Test_Certificate|Inspection_Certificate');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `conformance_statement` SET TAGS ('dbx_business_glossary_term' = 'Conformance Statement');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `customer_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Name');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `customer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `customer_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `customer_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `customer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `customer_name` SET TAGS ('dbx_mask' = 'non_prod');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `customer_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `customer_order_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Order Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `customer_specific_requirements` SET TAGS ('dbx_business_glossary_term' = 'Customer-Specific Requirements');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `delivery_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `digital_signature_reference` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature ID');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document URL');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `inspector_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `inspector_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `issued_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `ppap_level` SET TAGS ('dbx_business_glossary_term' = 'Production Part Approval Process (PPAP) Level');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `quantity_certified` SET TAGS ('dbx_business_glossary_term' = 'Quantity Certified');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `regulatory_compliance_statement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Statement');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Revision Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Certificate Revision Reason');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `sales_order_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Signature Date');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `test_method_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Method Reference');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `test_results_summary` SET TAGS ('dbx_business_glossary_term' = 'Test Results Summary');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` SET TAGS ('dbx_subdomain' = 'inspection_management');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `inspection_characteristic_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Specification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `parent_inspection_characteristic_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Inspection Characteristic Id');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `parent_inspection_characteristic_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `resource_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Tool Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `characteristic_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `characteristic_type` SET TAGS ('dbx_business_glossary_term' = 'Characteristic Type');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `inspection_characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `criticality_level` SET TAGS ('dbx_business_glossary_term' = 'Criticality Level');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `data_collection_system` SET TAGS ('dbx_business_glossary_term' = 'Data Collection System');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `inspection_characteristic_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `frequency_per_shift` SET TAGS ('dbx_business_glossary_term' = 'Frequency Per Shift');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `is_required` SET TAGS ('dbx_business_glossary_term' = 'Is Required');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `is_statistical_process_control` SET TAGS ('dbx_business_glossary_term' = 'Is Statistical Process Control');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Spec Limit');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `inspection_characteristic_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `inspection_characteristic_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `inspection_characteristic_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `sampling_plan` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `tolerance` SET TAGS ('dbx_business_glossary_term' = 'Tolerance');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Spec Limit');
