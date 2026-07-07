-- Schema for Domain: quality | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 05:32:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`quality` COMMENT 'Owns quality assurance, quality control, and GMP compliance data across the product lifecycle. Manages QC inspection results, non-conformance records, CAPA processes, batch release decisions, stability studies, certificate of analysis, GMP audit findings, supplier quality assessments, product complaints, and regulatory hold events. Integrates with SAP QM and Veeva Vault.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` (
    `inspection_plan_id` BIGINT COMMENT 'Unique identifier for the inspection plan. Primary key for the inspection plan master data entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Inspection Plan Approval Process requires linking the approving employee to ensure audit trail and compliance reporting.',
    `laboratory_id` BIGINT COMMENT 'Reference to the quality control laboratory or testing facility responsible for executing this inspection plan.',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where this inspection plan is applicable. Inspection plans may be plant-specific due to local equipment and procedures.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand Quality Assurance Plan links inspection plans to specific brand for compliance reporting and marketing claim validation.',
    `sku_id` BIGINT COMMENT 'Reference to the material (raw material, packaging component, intermediate, or finished good) that this inspection plan applies to.',
    `specification_id` BIGINT COMMENT 'Attribute specification_id of quality.inspection_plan.',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.inspection_plan.',
    `approval_date` DATE COMMENT 'Date on which this inspection plan was formally approved for use. Part of the plans audit trail and regulatory documentation.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether inspection results under this plan require formal approval by a quality manager or authorized person before batch release. Typically true for GMP-critical inspections.',
    `aql_level` DECIMAL(18,2) COMMENT 'Acceptable Quality Level expressed as a percentage. Maximum percent defective that is considered acceptable for the inspection plan. Used in acceptance sampling decisions.',
    `certificate_of_analysis_required_flag` BOOLEAN COMMENT 'Indicates whether a formal Certificate of Analysis document must be generated upon successful completion of inspections under this plan. Typically required for finished goods and customer-facing materials.',
    `change_control_number` STRING COMMENT 'Reference to the change control request or document that authorized the creation or last modification of this inspection plan. Required for GMP compliance and audit trail.. Valid values are `^CC-[0-9]{6,10}$`',
    `characteristic_count` STRING COMMENT 'Number of quality characteristics (test parameters) defined in this inspection plan. Each characteristic has its own specification limits.',
    `inspection_plan_code` STRING COMMENT 'Attribute code of quality.inspection_plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection plan record was first created in the source system. Part of the audit trail.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.inspection_plan.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `inspection_plan_description` STRING COMMENT 'Attribute description of quality.inspection_plan.',
    `dynamic_modification_rule` STRING COMMENT 'Attribute dynamic_modification_rule of quality.inspection_plan.',
    `effective_end_date` DATE COMMENT 'Date after which this inspection plan is no longer valid. Nullable for open-ended plans. Used for version control and regulatory compliance.',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.inspection_plan.',
    `effective_start_date` DATE COMMENT 'Date from which this inspection plan becomes valid and applicable for quality inspections. Part of the plans effective date range.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.inspection_plan.',
    `gmp_critical_flag` BOOLEAN COMMENT 'Indicates whether this inspection plan covers GMP-critical quality attributes that directly impact product safety, efficacy, or regulatory compliance. GMP-critical inspections require enhanced documentation and cannot be skipped.',
    `gmp_relevant` BOOLEAN COMMENT 'Attribute gmp_relevant of quality.inspection_plan.',
    `inspection_frequency` STRING COMMENT 'Attribute inspection_frequency of quality.inspection_plan.',
    `inspection_lead_time_days` STRING COMMENT 'Expected number of calendar days required to complete all inspections and testing defined in this plan. Used for production scheduling and inventory planning.',
    `inspection_method` STRING COMMENT 'Primary method used to perform the inspection: manual measurement, automated testing, laboratory analysis, visual examination, destructive testing, or non-destructive testing.. Valid values are `manual|automated|laboratory|visual|destructive|non_destructive`',
    `inspection_plan_status` STRING COMMENT 'Attribute status of quality.inspection_plan.',
    `inspection_severity` STRING COMMENT 'Severity level of inspection based on supplier quality history and risk assessment. Tightened inspection applies stricter acceptance criteria.. Valid values are `normal|tightened|reduced`',
    `inspection_stage` STRING COMMENT 'Production or supply chain stage at which this inspection is triggered. Aligns with GMP critical control points.. Valid values are `goods_receipt|production_start|production_end|pre_release|post_release`',
    `inspection_type` STRING COMMENT 'Type of quality inspection this plan governs: incoming (supplier materials), in-process (production intermediates), final (finished goods), stability (shelf-life studies), release (batch release), or periodic (routine surveillance).. Valid values are `incoming|in_process|final|stability|release|periodic`',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this inspection plan record. Used for change tracking and data synchronization.',
    `material_type` STRING COMMENT 'Classification of the material subject to inspection. Determines applicable GMP requirements and inspection rigor.. Valid values are `raw_material|packaging_material|intermediate|finished_good|bulk_product`',
    `inspection_plan_name` STRING COMMENT 'Attribute name of quality.inspection_plan.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this inspection plan. GMP requires regular review of quality procedures to ensure continued appropriateness.',
    `notes` STRING COMMENT 'Attribute notes of quality.inspection_plan.',
    `plan_code` STRING COMMENT 'Business identifier for the inspection plan, used across quality management systems and documentation. Externally visible code for referencing the plan in quality specifications and batch records.. Valid values are `^[A-Z0-9]{6,20}$`',
    `plan_description` STRING COMMENT 'Detailed description of the inspection plan including scope, objectives, and special instructions for quality control personnel.',
    `plan_name` STRING COMMENT 'Human-readable name of the inspection plan describing its purpose and scope.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the inspection plan. Only active plans are used for inspection lot creation.. Valid values are `draft|active|inactive|obsolete|under_review`',
    `plan_type` STRING COMMENT 'Attribute plan_type of quality.inspection_plan.',
    `plant_code` STRING COMMENT 'Attribute plant_code of quality.inspection_plan.',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.inspection_plan.',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `regulatory_requirement` STRING COMMENT 'Reference to the regulatory requirement, standard, or guideline that mandates this inspection (e.g., FDA 21 CFR Part 211, EU GMP Annex 1, ISO 22716). Critical for compliance audits.',
    `responsible_inspector_role` STRING COMMENT 'Job role or qualification level required for personnel authorized to perform inspections under this plan (e.g., QC Technician, QC Analyst, QC Manager). Ensures competency requirements are met.',
    `revision_number` STRING COMMENT 'Sequential revision number of this inspection plan. Incremented each time the plan is updated. Part of change control and audit trail.',
    `sample_size` STRING COMMENT 'Number of sample units to be drawn per inspection lot. Determined by statistical sampling plan and AQL requirements.',
    `sample_unit` STRING COMMENT 'Unit of measure for the sample (e.g., pieces, kg, liters, containers). Defines what constitutes one sample unit.',
    `sampling_procedure` STRING COMMENT 'Attribute sampling_procedure of quality.inspection_plan.',
    `sampling_procedure_code` STRING COMMENT 'Code identifying the sampling procedure to be followed: sample size, sampling frequency, sampling method (random, systematic, stratified). References approved sampling SOP.. Valid values are `^[A-Z0-9]{4,12}$`',
    `skip_lot_allowed_flag` BOOLEAN COMMENT 'Indicates whether skip-lot inspection (reduced frequency based on consistent quality history) is permitted for this plan. Not allowed for GMP-critical inspections.',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'Unique identifier of this inspection plan in the source operational system. Enables traceability back to the system of record.',
    `specification_version` STRING COMMENT 'Version number of the quality specification document that this inspection plan implements. Ensures traceability to approved specifications.. Valid values are `^V[0-9]{1,3}(.[0-9]{1,2})?$`',
    `test_equipment_required` STRING COMMENT 'List or description of test equipment, instruments, or laboratory apparatus required to execute this inspection plan. Ensures resource availability.',
    `uom` STRING COMMENT 'Attribute uom of quality.inspection_plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'Attribute updated_timestamp of quality.inspection_plan.',
    `usage_indicator` STRING COMMENT 'Attribute usage_indicator of quality.inspection_plan.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `version_number` STRING COMMENT 'Attribute version_number of quality.inspection_plan.',
    CONSTRAINT pk_inspection_plan PRIMARY KEY(`inspection_plan_id`)
) COMMENT 'Master inspection plan defining characteristics, sampling procedures, AQL levels, and methods applied to inspection lots.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` (
    `inspection_lot_id` BIGINT COMMENT 'Unique identifier for the inspection lot. Primary key for the inspection lot entity representing a discrete QC inspection event triggered by production batch, goods receipt, or periodic review.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Required for traceability: each inspection lot must be linked to the specific manufacturing batch record that produced the lot, enabling batch-level quality release decisions.',
    `inbound_receipt_line_id` BIGINT COMMENT 'Foreign key linking to distribution.inbound_receipt_line. Business justification: Required for traceability: inspection lot must reference the inbound receipt line that supplied the lot, enabling quality inspection reports to be linked to receipt data for OTIF and compliance audits',
    `inspection_plan_id` BIGINT COMMENT 'Identifier of the inspection plan template applied to this lot. Defines the characteristics to be inspected, sampling procedures, and acceptance criteria.',
    `employee_id` BIGINT COMMENT 'Identifier of the quality inspector or technician assigned to perform the inspection activities for this lot.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Regulatory traceability report requires linking each inspection lot to its originating lot batch for audit trails.',
    `manufacturing_facility_id` BIGINT COMMENT 'Attribute manufacturing_facility_id of manufacturing.inspection_lot.',
    `primary_inspection_employee_id` BIGINT COMMENT 'Identifier of the quality manager or authorized person who made the final usage decision for this inspection lot.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Required for traceability: link each inspection lot to the purchase order that supplied the material, enabling regulatory compliance and release decisions.',
    `sku_id` BIGINT COMMENT 'Identifier of the material (raw material, semi-finished good, or finished good) being inspected in this lot.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier or vendor for goods receipt inspection lots. Used for supplier quality performance tracking.',
    `tertiary_inspection_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user who last modified the inspection lot record. Maintains accountability for changes to quality data.',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.inspection_lot.',
    `batch_number` STRING COMMENT 'Attribute batch_number of quality.inspection_lot.',
    `certificate_of_analysis_number` STRING COMMENT 'Document number of the Certificate of Analysis issued for this inspection lot. Links to formal quality documentation in Veeva Vault.',
    `coa_issue_date` DATE COMMENT 'Date when the Certificate of Analysis was formally issued for this inspection lot.',
    `inspection_lot_code` STRING COMMENT 'Attribute code of quality.inspection_lot.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection lot record was first created in the quality management system. Audit trail field.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.inspection_lot.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `decision_date` DATE COMMENT 'Date when the formal usage decision was made and recorded in the quality management system.',
    `decision_timestamp` TIMESTAMP COMMENT 'Precise date and time when the usage decision was recorded. Used for audit trail and compliance reporting.',
    `defect_count` STRING COMMENT 'Total number of defects or non-conformances identified during inspection. Used for quality metrics and trend analysis.',
    `inspection_lot_description` STRING COMMENT 'Attribute description of quality.inspection_lot.',
    `disposition_outcome` STRING COMMENT 'Final outcome status of the lot after disposition decision and stock posting. Confirms the actual inventory movement executed.. Valid values are `released|blocked|scrapped|returned|reworked`',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.inspection_lot.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.inspection_lot.',
    `expiration_date` DATE COMMENT 'Expiration or best-before date assigned to the batch based on stability study results and shelf-life specifications.',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether the inspection lot was produced and inspected in compliance with Good Manufacturing Practice regulations.',
    `inspection_end_date` DATE COMMENT 'Date when all inspection and testing activities were completed for this lot.',
    `inspection_location` STRING COMMENT 'Physical location or quality lab where the inspection was performed. May be different from the plant code for centralized testing facilities.',
    `inspection_lot_number` STRING COMMENT 'Business identifier for the inspection lot. Externally visible alphanumeric code used in SAP QM and quality documentation for traceability and audit purposes.. Valid values are `^[A-Z0-9]{8,12}$`',
    `inspection_lot_status` STRING COMMENT 'Inspection Lot Status value for the Inspection Lot record.',
    `inspection_notes` STRING COMMENT 'Free-text field for inspector comments, observations, or special conditions noted during the inspection process.',
    `inspection_priority` STRING COMMENT 'Priority level assigned to the inspection lot. Determines the sequence and urgency of inspection execution in the quality lab.. Valid values are `urgent|high|normal|low`',
    `inspection_start_date` DATE COMMENT 'Date when the physical inspection and testing activities began for this lot.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection lot. Tracks progression from creation through inspection execution to final disposition decision.. Valid values are `created|released|in_progress|completed|cancelled`',
    `inspection_type` STRING COMMENT 'Classification of the inspection lot based on the triggering event. Determines the inspection plan template and sampling strategy applied.. Valid values are `goods_receipt|production_batch|periodic|in_process|final_release|stability`',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection lot record was last updated. Tracks the most recent change for audit and compliance purposes.',
    `lot_number` STRING COMMENT 'Lot Number value for the Inspection Lot record.',
    `lot_origin_number` STRING COMMENT 'Document number of the originating transaction (production order number, purchase order number, delivery number, etc.) that triggered this inspection lot.',
    `lot_origin_type` STRING COMMENT 'Source document type that triggered the creation of this inspection lot. Links the quality inspection to the originating business transaction.. Valid values are `production_order|purchase_order|process_order|delivery|stock_transfer`',
    `lot_quantity` DECIMAL(18,2) COMMENT 'Total quantity of material in the inspection lot. Represents the population from which samples are drawn for inspection.',
    `lot_quantity_uom` STRING COMMENT 'Unit of measure for the lot quantity (each, kilogram, liter, meter, etc.). Aligns with material master UOM. [ENUM-REF-CANDIDATE: EA|KG|L|M|M2|M3|BOX|CASE — 8 candidates stripped; promote to reference product]',
    `material_number` STRING COMMENT 'Business material code (SKU) of the product being inspected. Used for cross-reference and reporting.',
    `inspection_lot_name` STRING COMMENT 'Attribute name of quality.inspection_lot.',
    `notes` STRING COMMENT 'Attribute notes of quality.inspection_lot.',
    `origin` STRING COMMENT 'Attribute inspection_lot_origin of quality.inspection_lot.',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility code where the inspection is performed. Aligns with SAP plant master data.. Valid values are `^[A-Z0-9]{4}$`',
    `priority` STRING COMMENT 'Attribute priority of quality.inspection_lot.',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.inspection_lot.',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `regulatory_hold_flag` BOOLEAN COMMENT 'Indicates whether the lot is under regulatory hold pending additional review or approval from regulatory affairs or quality assurance.',
    `regulatory_hold_reason` STRING COMMENT 'Detailed explanation of why the lot is under regulatory hold. Documents the specific compliance or quality concern requiring additional review.',
    `retest_date` DATE COMMENT 'Date when the material must be re-inspected to confirm continued compliance with quality specifications. Applicable for raw materials and intermediates.',
    `sample_quantity` DECIMAL(18,2) COMMENT 'Quantity of material drawn as a sample for inspection testing. Determined by the inspection plan sampling procedure.',
    `sample_quantity_uom` STRING COMMENT 'Unit of measure for the sample quantity drawn for testing. [ENUM-REF-CANDIDATE: EA|KG|L|M|M2|M3|BOX|CASE — 8 candidates stripped; promote to reference product]',
    `sample_size` STRING COMMENT 'Sample Size value for the Inspection Lot record.',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'Source System Code value for the Inspection Lot record.',
    `stock_posting_instruction` STRING COMMENT 'Instruction for inventory movement based on the usage decision. Determines the target stock type for material posting in warehouse management.. Valid values are `release_to_unrestricted|move_to_blocked|move_to_quality|scrap|return`',
    `storage_location_code` STRING COMMENT 'Warehouse storage location code where the inspected material is held during quality inspection.',
    `system_status` STRING COMMENT 'Attribute system_status of quality.inspection_lot.',
    `uom` STRING COMMENT 'Attribute uom of quality.inspection_lot.',
    `updated_timestamp` TIMESTAMP COMMENT 'Attribute updated_timestamp of quality.inspection_lot.',
    `usage_decision` STRING COMMENT 'Final disposition decision for the inspected lot. Determines whether material can be released for use, must be reworked, or should be rejected.. Valid values are `accepted|rejected|restricted_use|rework|scrap|return_to_vendor`',
    `usage_decision_code` STRING COMMENT 'Standardized code representing the usage decision. Used for automated stock posting and reporting in SAP QM.. Valid values are `^[A-Z0-9]{2,4}$`',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    CONSTRAINT pk_inspection_lot PRIMARY KEY(`inspection_lot_id`)
) COMMENT 'Quality inspection lot representing a quantity of material under inspection, linked to inspection plan, results, and usage decision.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` (
    `inspection_result_id` BIGINT COMMENT 'Unique identifier for the inspection result record. Primary key for granular QC (Quality Control) measurement and test result records captured at the characteristic level within an inspection lot.',
    `inspection_lot_id` BIGINT COMMENT 'Reference to the parent inspection lot under which this characteristic-level result was captured. Links to the inspection lot entity that groups multiple inspection results for a batch or production run.',
    `employee_id` BIGINT COMMENT 'Recorded By Employee Id referencing workforce.employee.employee_id.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Link inspection_result to its governing specification for easy access to spec limits and versioning.',
    `inspector_employee_id` BIGINT COMMENT 'Attribute inspector_employee_id of workforce.inspection_result.',
    `primary_inspection_employee_id` BIGINT COMMENT 'Unique identifier of the quality inspector or technician who performed the measurement. Required for GMP audit trails and accountability.',
    `sample_id` BIGINT COMMENT 'Unique identifier of the physical sample from which this measurement was taken. Enables traceability back to the specific sample unit within the inspection lot.',
    `equipment_id` BIGINT COMMENT 'Surrogate identifier: Test Equipment Id.',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.inspection_result.',
    `approval_status` STRING COMMENT 'Approval status of this inspection result by a quality supervisor or manager. Pending indicates awaiting review; approved indicates result accepted; rejected indicates result invalidated and retest required.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this inspection result was approved. Required for GMP audit trails and batch release decision traceability.',
    `characteristic_code` STRING COMMENT 'Characteristic Code value for the Inspection Result record.',
    `characteristic_name` STRING COMMENT 'Characteristic Name value for the Inspection Result record.',
    `coa_inclusion_flag` BOOLEAN COMMENT 'Flag indicating whether this result should be included in the Certificate of Analysis (COA) document for the batch. True indicates inclusion; false indicates internal-only result.',
    `inspection_result_code` STRING COMMENT 'Attribute code of quality.inspection_result.',
    `control_chart_rule_violated` STRING COMMENT 'Description of the specific SPC control chart rule that was violated (e.g., point beyond control limit, 7 consecutive points above centerline, 2 of 3 points beyond 2-sigma). Populated when control_chart_violation_flag is true.',
    `control_chart_violation_flag` BOOLEAN COMMENT 'Flag indicating whether this measurement violates SPC (Statistical Process Control) control chart rules (e.g., out of control limits, run rules, trend rules). True indicates a violation requiring investigation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date/time of Created Timestamp.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.inspection_result.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `data_source_system` STRING COMMENT 'Identifier of the source system from which this inspection result was captured (e.g., SAP QM, LIMS, Veeva Vault, manual entry). Used for data lineage and audit purposes.',
    `defect_classification` STRING COMMENT 'Defect Classification value for the Inspection Result record.',
    `defect_code` STRING COMMENT 'Standardized code classifying the type of defect or non-conformance observed when result_status is fail. Used for defect trending and root cause analysis.',
    `defect_severity` STRING COMMENT 'Classification of the severity of the non-conformance. Critical defects pose safety or regulatory risk; major defects affect functionality; minor defects are cosmetic or non-functional.. Valid values are `critical|major|minor`',
    `inspection_result_description` STRING COMMENT 'Attribute description of quality.inspection_result.',
    `deviation_code` STRING COMMENT 'Reference to an approved deviation or waiver document that authorizes acceptance of a non-conforming result. Populated when result_status is waived.',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.inspection_result.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.inspection_result.',
    `environmental_condition_humidity` DECIMAL(18,2) COMMENT 'Relative humidity (percentage) at the time of measurement. Critical for tests sensitive to moisture levels.',
    `environmental_condition_temperature` DECIMAL(18,2) COMMENT 'Ambient temperature (in degrees Celsius) at the time of measurement. Critical for tests sensitive to environmental conditions.',
    `evaluation_result` STRING COMMENT 'Evaluation Result value for the Inspection Result record.',
    `inspection_characteristic_code` STRING COMMENT 'Unique code identifying the specific quality characteristic being measured (e.g., pH level, viscosity, weight, color, microbial count). Corresponds to the master inspection characteristic definition.',
    `inspection_characteristic_name` STRING COMMENT 'Human-readable name of the quality characteristic being tested (e.g., Product pH, Net Weight, Microbial Load, Color Consistency).',
    `inspection_method` STRING COMMENT 'Attribute inspection_method of quality.inspection_result.',
    `inspection_method_code` STRING COMMENT 'Code identifying the standardized test method or procedure used to perform this measurement (e.g., ASTM method, USP method, internal SOP number).',
    `inspection_result_status` STRING COMMENT 'Attribute status of quality.inspection_result.',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date and time when this specific characteristic measurement was performed. Critical for time-sensitive tests and GMP audit trails.',
    `instrument_code` STRING COMMENT 'Unique identifier of the measurement instrument or equipment used to capture this result (e.g., balance ID, pH meter ID, spectrophotometer ID). Required for GMP (Good Manufacturing Practice) audit trails and instrument calibration traceability.',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `is_within_spec` BOOLEAN COMMENT 'Boolean indicator for Is Within Spec.',
    `laboratory_code` STRING COMMENT 'Identifier of the laboratory or testing facility where this measurement was performed. May be an internal QC lab or an external contract lab.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date/time of Last Modified Timestamp.',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Lower Spec Limit value for the Inspection Result record.',
    `lower_specification_limit` DECIMAL(18,2) COMMENT 'The minimum acceptable value for this characteristic as defined in the product specification or quality standard. Values below this threshold indicate non-conformance.',
    `measured_value` DECIMAL(18,2) COMMENT 'The actual quantitative measurement or test result value recorded during inspection. For qualitative characteristics, this may be encoded numerically or stored as a code.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date/time of Measurement Timestamp.',
    `measurement_uncertainty` DECIMAL(18,2) COMMENT 'Quantified estimate of the uncertainty or error margin associated with the measured value. Required for ISO 17025 compliance and advanced SPC (Statistical Process Control) analysis.',
    `inspection_result_name` STRING COMMENT 'Attribute name of quality.inspection_result.',
    `notes` STRING COMMENT 'Notes value for the Inspection Result record.',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.inspection_result.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this inspection result record was first created in the system. Audit trail field for data governance.',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this inspection result record was last modified. Audit trail field for data governance and change tracking.',
    `recorded_timestamp` TIMESTAMP COMMENT 'Attribute recorded_timestamp of quality.inspection_result.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Flag indicating whether this result must be reported to regulatory authorities (e.g., FDA, EPA) due to non-conformance or safety concerns. True indicates reportable event.',
    `remarks` STRING COMMENT 'Free-text comments or observations recorded by the inspector regarding this measurement. May include notes on sample condition, procedural deviations, or contextual information.',
    `result_status` STRING COMMENT 'Pass/fail status of this individual characteristic measurement. Pass indicates the measured value is within specification limits; fail indicates non-conformance; conditional indicates acceptance with restrictions; pending indicates awaiting review; waived indicates non-conformance accepted by authorized deviation.. Valid values are `pass|fail|conditional|pending|waived`',
    `result_uom` STRING COMMENT 'Result Uom value for the Inspection Result record.',
    `result_valuation` STRING COMMENT 'Attribute result_valuation of quality.inspection_result.',
    `result_value` DECIMAL(18,2) COMMENT 'Result Value value for the Inspection Result record.',
    `result_value_text` STRING COMMENT 'Result Value Text value for the Inspection Result record.',
    `retest_indicator` BOOLEAN COMMENT 'Flag indicating whether this result is a retest of a previously failed or inconclusive measurement. True indicates this is a retest; false indicates initial test.',
    `retest_reason_code` STRING COMMENT 'Code indicating the reason for retesting this characteristic. Applicable only when retest_indicator is true.. Valid values are `initial_failure|inconclusive|instrument_error|sample_contamination|procedural_deviation|other`',
    `sample_sequence_number` STRING COMMENT 'Sequential number of this sample within the inspection lot (e.g., 1, 2, 3). Used to track sampling order and support statistical sampling plans.',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'Source System Code value for the Inspection Result record.',
    `target_value` DECIMAL(18,2) COMMENT 'The ideal or nominal value for this characteristic. Used for process capability analysis and SPC (Statistical Process Control) charting.',
    `test_batch_number` STRING COMMENT 'Batch or run number of the test reagents or consumables used during this measurement. Required for traceability in regulated environments.',
    `test_method` STRING COMMENT 'Test Method value for the Inspection Result record.',
    `unit_of_measure` STRING COMMENT 'The unit in which the measured value is expressed (e.g., grams, milliliters, pH units, CFU/g for colony forming units per gram, percentage).',
    `uom` STRING COMMENT 'Attribute uom of quality.inspection_result.',
    `updated_timestamp` TIMESTAMP COMMENT 'Attribute updated_timestamp of quality.inspection_result.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Upper Spec Limit value for the Inspection Result record.',
    `upper_specification_limit` DECIMAL(18,2) COMMENT 'The maximum acceptable value for this characteristic as defined in the product specification or quality standard. Values above this threshold indicate non-conformance.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    CONSTRAINT pk_inspection_result PRIMARY KEY(`inspection_result_id`)
) COMMENT 'Recorded measurement result for an inspection characteristic, evaluated against specification limits with pass/fail valuation.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` (
    `usage_decision_id` BIGINT COMMENT 'Unique identifier for the quality control usage decision record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the quality manager or authorized approver who provided final approval for the usage decision, if required. Null if no approval was needed.',
    `capa_id` BIGINT COMMENT 'Reference to the CAPA record initiated as a result of this usage decision, if applicable. Null if no CAPA was required.',
    `inspection_lot_id` BIGINT COMMENT 'Reference to the inspection lot for which this usage decision was made. Links to the QC inspection lot that was evaluated.',
    `primary_usage_employee_id` BIGINT COMMENT 'Reference to the quality control inspector or authorized personnel who made the usage decision. Required for accountability and audit trails.',
    `sku_id` BIGINT COMMENT 'Reference to the material or product that was inspected and for which the usage decision applies.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor who provided the material, if applicable. Used for supplier quality management and vendor scorecarding.',
    `usage_decided_by_employee_id` BIGINT COMMENT 'Decided By Employee Id referencing workforce.employee.employee_id.',
    `accepted_quantity` DECIMAL(18,2) COMMENT 'Accepted Quantity value for the Usage Decision record.',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.usage_decision.',
    `approval_date` DATE COMMENT 'The date when the usage decision was formally approved by authorized quality management personnel. Null if no approval was required.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this usage decision requires additional management or quality assurance approval before batch release. True=Approval required, False=No additional approval needed.',
    `batch_number` STRING COMMENT 'The production batch or lot number to which this usage decision applies. Critical for traceability and recall management.',
    `capa_required_flag` BOOLEAN COMMENT 'Indicates whether this usage decision triggers a CAPA process due to significant non-conformance. True=CAPA required, False=No CAPA needed. Links to continuous improvement.',
    `certificate_of_analysis_number` STRING COMMENT 'Reference number of the Certificate of Analysis document that supports this usage decision. Links to detailed test results and specifications.',
    `usage_decision_code` STRING COMMENT 'Attribute code of quality.usage_decision.',
    `comments` STRING COMMENT 'Additional free-text comments or notes related to the usage decision. May include special handling instructions, escalation notes, or contextual information.',
    `created_timestamp` TIMESTAMP COMMENT 'Date/time of Created Timestamp.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.usage_decision.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `decision_code` STRING COMMENT 'The formal quality control usage decision code. A=Accept (Unrestricted Use), R=Reject, Q=Quality Hold, S=Restricted Use (Sample/Scrap), X=Rework Required. Drives downstream inventory disposition.. Valid values are `A|R|Q|S|X`',
    `decision_date` DATE COMMENT 'The calendar date on which the usage decision was formally made and recorded. Critical for compliance timelines and batch release tracking.',
    `decision_description` STRING COMMENT 'Decision Description value for the Usage Decision record.',
    `decision_maker_name` STRING COMMENT 'Full name of the quality control inspector or authorized personnel who made the usage decision. Captured for audit and traceability purposes.',
    `decision_text` STRING COMMENT 'Detailed textual description or rationale for the usage decision. Captures the quality assessors reasoning and any special conditions or instructions.',
    `decision_timestamp` TIMESTAMP COMMENT 'The precise date and time when the usage decision was recorded in the system. Provides audit trail precision for regulatory compliance.',
    `decision_type` STRING COMMENT 'Decision Type value for the Usage Decision record.',
    `defect_code` STRING COMMENT 'Standardized code identifying the primary defect or non-conformance that led to rejection or restricted use decision. Used for root cause analysis and trend reporting.',
    `defect_description` STRING COMMENT 'Detailed description of the defect, non-conformance, or quality issue identified during inspection. Supports CAPA and continuous improvement processes.',
    `usage_decision_description` STRING COMMENT 'Attribute description of quality.usage_decision.',
    `disposition` STRING COMMENT 'Disposition value for the Usage Decision record.',
    `disposition_date` DATE COMMENT 'The date when the material disposition action was completed (e.g., stock posted to unrestricted, blocked, or scrapped). Null if disposition is still pending.',
    `disposition_status` STRING COMMENT 'Current status of the material disposition action following the usage decision. pending=Decision made but stock not yet moved, completed=Stock posting completed, cancelled=Decision reversed or voided.. Valid values are `pending|completed|cancelled`',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.usage_decision.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.usage_decision.',
    `follow_up_action` STRING COMMENT 'Attribute follow_up_action of quality.usage_decision.',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether the batch meets Good Manufacturing Practice requirements. True=GMP compliant, False=Non-compliant. Required for pharmaceutical and cosmetic products.',
    `inspection_type` STRING COMMENT 'The type of quality inspection that led to this usage decision. goods_receipt=incoming material inspection, in_process=during production, final=finished goods, stability=shelf-life testing, complaint=customer complaint investigation.. Valid values are `goods_receipt|in_process|final|stability|complaint`',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date/time of Last Modified Timestamp.',
    `usage_decision_name` STRING COMMENT 'Attribute name of quality.usage_decision.',
    `notes` STRING COMMENT 'Attribute notes of quality.usage_decision.',
    `plant_code` STRING COMMENT 'The manufacturing plant or facility code where the inspection and usage decision were performed. Critical for multi-site quality management.',
    `quality_score` DECIMAL(18,2) COMMENT 'Quality Score value for the Usage Decision record.',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.usage_decision.',
    `quantity_accepted` DECIMAL(18,2) COMMENT 'The quantity of material accepted for unrestricted use based on the usage decision. Measured in the materials base unit of measure.',
    `quantity_rejected` DECIMAL(18,2) COMMENT 'The quantity of material rejected and not suitable for use. Measured in the materials base unit of measure. May trigger disposal or return to supplier.',
    `quantity_rework` DECIMAL(18,2) COMMENT 'The quantity of material designated for rework or reprocessing to meet quality standards. Measured in the materials base unit of measure.',
    `reason_code` STRING COMMENT 'Reason Code value for the Usage Decision record.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this usage decision record was first created in the lakehouse. Part of the audit trail for data governance.',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this usage decision record was last updated in the lakehouse. Tracks data freshness and change history.',
    `regulatory_hold_flag` BOOLEAN COMMENT 'Indicates whether the material is under regulatory hold and cannot be released for distribution. True=Hold in effect, False=No regulatory hold. Critical for FDA and EPA compliance.',
    `regulatory_hold_reason` STRING COMMENT 'Detailed explanation of why the material is under regulatory hold. May reference specific test failures, compliance issues, or pending regulatory approvals.',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'Rejected Quantity value for the Usage Decision record.',
    `rework_quantity` DECIMAL(18,2) COMMENT 'Rework Quantity value for the Usage Decision record.',
    `sampling_procedure` STRING COMMENT 'The sampling method or procedure used during the inspection (e.g., random sampling, statistical sampling, 100% inspection). Ensures inspection validity.',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'The unique identifier of this usage decision record in the source operational system. Enables traceability back to the system of record.',
    `stock_posting_instruction` STRING COMMENT 'Instruction for how the inspected material should be posted to inventory. Determines the stock type and availability for use: unrestricted (available for sale/use), blocked (not available), quality_inspection (under evaluation), scrap (to be disposed), sample (for testing), rework (to be reprocessed).. Valid values are `unrestricted|blocked|quality_inspection|scrap|sample|rework`',
    `stock_posting_type` STRING COMMENT 'Attribute stock_posting_type of quality.usage_decision.',
    `storage_location_code` STRING COMMENT 'The warehouse storage location code where the inspected material is physically located. Used for inventory disposition and stock movement.',
    `ud_code` STRING COMMENT 'Attribute ud_code of quality.usage_decision.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantities in this usage decision (e.g., EA=Each, KG=Kilogram, L=Liter, CS=Case). Aligns with material master UOM.',
    `uom` STRING COMMENT 'Attribute uom of quality.usage_decision.',
    `updated_timestamp` TIMESTAMP COMMENT 'Attribute updated_timestamp of quality.usage_decision.',
    `usage_decision_status` STRING COMMENT 'Attribute status of quality.usage_decision.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    CONSTRAINT pk_usage_decision PRIMARY KEY(`usage_decision_id`)
) COMMENT 'Usage decision recording acceptance, rejection, or rework disposition for an inspection lot and resulting stock posting.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` (
    `nonconformance_id` BIGINT COMMENT 'Unique identifier for the nonconformance record. Primary key for the nonconformance data product.',
    `action_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_action. Business justification: Nonconformance findings can lead to regulatory enforcement actions; linking supports audit trails.',
    `capa_id` BIGINT COMMENT 'Foreign key reference to the CAPA record created to address the root cause of this nonconformance. Links to capa_record for tracking corrective and preventive actions.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost of quality report allocates nonconformance financial impact to responsible cost center for internal cost tracking.',
    `inbound_receipt_id` BIGINT COMMENT 'Foreign key linking to distribution.inbound_receipt. Business justification: Required for receipt quality control: nonconformance must reference the inbound receipt that triggered the issue, enabling tracking of receipt-level defects and corrective actions.',
    `inspection_lot_id` BIGINT COMMENT 'Inspection Lot Id referencing quality.inspection_lot.inspection_lot_id.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Non‑conformance investigations must reference the specific lot batch to drive root‑cause analysis and recall actions.',
    `manufacturing_facility_id` BIGINT COMMENT 'Manufacturing Facility Id referencing manufacturing.manufacturing_facility.manufacturing_facility_id.',
    `employee_id` BIGINT COMMENT 'Reported By Employee Id referencing workforce.employee.employee_id.',
    `primary_nonconformance_closed_by_user_employee_id` BIGINT COMMENT 'User identifier of the quality professional who closed the nonconformance record after verification. Links to workforce/employee master data.',
    `product_complaint_id` BIGINT COMMENT 'Foreign key reference to the customer complaint record that triggered this nonconformance, when applicable. Links to consumer complaint tracking system.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Non‑conformance events are tied to the SKU that caused the issue, enabling targeted CAPA and impact analysis.',
    `supplier_id` BIGINT COMMENT 'Foreign key reference to the supplier associated with this nonconformance, applicable when the issue originates from supplier-provided materials or components. Links to supplier master data.',
    `transport_exception_id` BIGINT COMMENT 'Foreign key linking to logistics.transport_exception. Business justification: Captures transport‑related nonconformance incidents, supporting root‑cause analysis and corrective action planning.',
    `affected_quantity` DECIMAL(18,2) COMMENT 'Quantity of product units or material affected by the nonconformance. Used for containment scope and financial impact assessment.',
    `affected_quantity_uom` STRING COMMENT 'Unit of measure for the affected quantity: EA (each/units), KG (kilograms), L (liters), M (meters), BOX (boxes), PALLET (pallets).. Valid values are `EA|KG|L|M|BOX|PALLET`',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.nonconformance.',
    `closed_date` DATE COMMENT 'Date/time of Closed Date.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the nonconformance was formally closed after verification of corrective actions and effectiveness checks. Null if still open.',
    `nonconformance_code` STRING COMMENT 'Attribute code of quality.nonconformance.',
    `containment_action` STRING COMMENT 'Immediate containment actions taken to prevent further occurrence or distribution of nonconforming product. Describes short-term corrective measures implemented before root cause analysis.',
    `containment_timestamp` TIMESTAMP COMMENT 'Date and time when containment actions were completed and verified effective. Critical for regulatory reporting and OTIF compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this nonconformance record was first created in the lakehouse silver layer. Audit trail for data governance.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.nonconformance.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `defect_category` STRING COMMENT 'Attribute defect_category of quality.nonconformance.',
    `defect_classification` STRING COMMENT 'Technical classification of the defect type: appearance (cosmetic defect), functionality (performance issue), safety (consumer safety risk), labeling (incorrect or missing label information), packaging (packaging integrity issue), contamination (foreign material or microbial contamination), specification_failure (out-of-specification test result), or process_deviation (manufacturing process non-conformance). [ENUM-REF-CANDIDATE: appearance|functionality|safety|labeling|packaging|contamination|specification_failure|process_deviation — 8 candidates stripped; promote to reference product]',
    `defect_description` STRING COMMENT 'Detailed narrative description of the nonconformance, including observed symptoms, affected characteristics, and initial assessment. Captures the what, where, and when of the quality event.',
    `nonconformance_description` STRING COMMENT 'Description value for the Nonconformance record.',
    `detected_date` DATE COMMENT 'Date/time of Detected Date.',
    `detected_timestamp` TIMESTAMP COMMENT 'Date and time when the nonconformance was first detected or observed. Represents the real-world event time of quality issue identification.',
    `detection_point` STRING COMMENT 'Attribute detection_point of quality.nonconformance.',
    `detection_source` STRING COMMENT 'Origin point where the nonconformance was first identified: QC inspection (quality control laboratory testing), manufacturing line (in-process detection), supplier receipt (incoming material inspection), customer complaint (consumer-reported issue), regulatory audit (FDA or regulatory body inspection), internal audit (GMP self-audit), or stability study (long-term product stability testing). [ENUM-REF-CANDIDATE: qc_inspection|manufacturing_line|supplier_receipt|customer_complaint|regulatory_audit|internal_audit|stability_study — 7 candidates stripped; promote to reference product]',
    `disposition` STRING COMMENT 'Disposition value for the Nonconformance record.',
    `disposition_approved_by` STRING COMMENT 'User identifier of the quality authority who approved the disposition decision. Links to workforce/employee master data for audit trail and GMP compliance.. Valid values are `^[A-Z0-9]{6,20}$`',
    `disposition_approved_timestamp` TIMESTAMP COMMENT 'Date and time when the disposition decision was formally approved by quality authority. Critical for GMP audit trail and batch release decisions.',
    `disposition_decision` STRING COMMENT 'Final disposition decision for the nonconforming product or material: use_as_is (approved for use despite nonconformance), rework (reprocess to meet specifications), scrap (destroy), return_to_supplier (send back to vendor), downgrade (sell as lower grade), or quarantine (hold pending further investigation).. Valid values are `use_as_is|rework|scrap|return_to_supplier|downgrade|quarantine`',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.nonconformance.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.nonconformance.',
    `event_type` STRING COMMENT 'Classification of the quality event: complaint (customer-reported issue), defect (internal manufacturing defect), deviation (process deviation from standard), improvement request (continuous improvement opportunity), supplier issue (supplier quality problem), or audit finding (GMP audit observation).. Valid values are `complaint|defect|deviation|improvement_request|supplier_issue|audit_finding`',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact of the nonconformance, including costs of rework, scrap, containment, investigation, customer credits, and potential recall costs. Expressed in base currency.',
    `financial_impact_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `is_gmp_related` BOOLEAN COMMENT 'Boolean indicator for Is Gmp Related.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date/time of Last Modified Timestamp.',
    `nonconformance_name` STRING COMMENT 'Attribute name of quality.nonconformance.',
    `nc_number` STRING COMMENT 'Nc Number value for the Nonconformance record.',
    `nc_status` STRING COMMENT 'Nc Status value for the Nonconformance record.',
    `nc_type` STRING COMMENT 'Nc Type value for the Nonconformance record.',
    `nonconformance_status` STRING COMMENT 'Current lifecycle status of the nonconformance record: open (newly created), in_investigation (root cause analysis underway), containment_active (immediate containment actions in progress), capa_assigned (corrective and preventive action assigned), closed (resolved and verified), or cancelled (invalidated).. Valid values are `open|in_investigation|containment_active|capa_assigned|closed|cancelled`',
    `notes` STRING COMMENT 'Attribute notes of quality.nonconformance.',
    `notification_number` STRING COMMENT 'External business identifier for the quality notification or nonconformance event. Corresponds to SAP QM notification number or Veeva Vault quality event identifier.. Valid values are `^[A-Z0-9]{8,20}$`',
    `priority` STRING COMMENT 'Business priority for resolution based on operational impact, customer visibility, and regulatory risk. Urgent: immediate action required; High: expedited resolution needed; Medium: standard timeline; Low: routine handling.. Valid values are `urgent|high|medium|low`',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.nonconformance.',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `regulatory_report_date` DATE COMMENT 'Date when the nonconformance was reported to regulatory authorities, if applicable. Null if not reportable or not yet reported.',
    `regulatory_reportable` BOOLEAN COMMENT 'Boolean indicator for Regulatory Reportable.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Boolean indicator whether this nonconformance requires reporting to regulatory authorities (FDA, EPA, CPSC) based on severity, product category, and regulatory requirements. True indicates mandatory regulatory notification.',
    `reported_date` DATE COMMENT 'Attribute reported_date of quality.nonconformance.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the nonconformance was formally logged into the quality management system (SAP QM or Veeva Vault). May differ from detection timestamp due to reporting lag.',
    `responsible_department` STRING COMMENT 'Functional department responsible for investigating and resolving the nonconformance (e.g., Quality Assurance, Manufacturing, Supply Chain, R&D).',
    `responsible_plant_code` STRING COMMENT 'Manufacturing plant or facility code where the nonconformance originated or is being managed. Links to distribution_facility for organizational accountability.. Valid values are `^[A-Z0-9]{4,10}$`',
    `root_cause` STRING COMMENT 'Root Cause value for the Nonconformance record.',
    `root_cause_analysis` STRING COMMENT 'Detailed findings from root cause investigation, including methodology used (5-Why, Fishbone, Fault Tree Analysis) and identified root causes. Supports CAPA development.',
    `severity` STRING COMMENT 'Severity classification of the quality event based on impact to product safety, efficacy, and regulatory compliance. Critical: immediate risk to consumer safety or regulatory violation; Major: significant quality impact requiring containment; Minor: low impact quality issue.. Valid values are `critical|major|minor`',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'Unique identifier of this nonconformance record in the source system (SAP QM notification number or Veeva Vault quality event ID). Enables traceability back to operational system.',
    `uom` STRING COMMENT 'Attribute uom of quality.nonconformance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this nonconformance record was last modified in the lakehouse silver layer. Audit trail for data governance and change tracking.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `verification_method` STRING COMMENT 'Method used to verify effectiveness of corrective actions and confirm the nonconformance has been resolved (e.g., re-inspection, re-testing, process validation, trend analysis).',
    CONSTRAINT pk_nonconformance PRIMARY KEY(`nonconformance_id`)
) COMMENT 'Nonconformance record documenting a quality deviation, its disposition, root cause, and linkage to CAPA.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`capa` (
    `capa_id` BIGINT COMMENT 'Unique identifier for the CAPA record. Primary key.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: CAPA actions are often initiated to meet specific compliance obligations; linking ties corrective actions to the obligation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CAPA cost impact must be charged to a cost center for budgeting and expense analysis.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Required for ESG goal tracking: each CAPA is linked to the specific ESG commitment it addresses, enabling ESG performance reporting.',
    `manufacturing_facility_id` BIGINT COMMENT 'Identifier of the manufacturing facility, warehouse, or site where the CAPA issue originated or is being addressed.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: CAPA Impact Report tracks corrective actions affecting brand reputation, used by marketing for risk communication and messaging.',
    `employee_id` BIGINT COMMENT 'Owner Employee Id referencing workforce.employee.employee_id.',
    `primary_capa_closed_by_employee_id` BIGINT COMMENT 'Identifier of the employee who formally closed the CAPA record.',
    `quaternary_capa_last_modified_by_employee_id` BIGINT COMMENT 'Identifier of the employee who last modified the CAPA record.',
    `quinary_capa_verified_by_employee_id` BIGINT COMMENT 'Identifier of the employee who performed the effectiveness verification.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: CAPA often stems from findings in an R&D project; linking provides root‑cause context and drives corrective actions.',
    `sku_id` BIGINT COMMENT 'Identifier of the product affected by or related to this CAPA. Links to the product master data.',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: CAPA actions often stem from supplier contract obligations; linking ensures contract compliance tracking and auditability of corrective measures.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier associated with the CAPA, if the issue originated from supplier-provided materials or services.',
    `tertiary_capa_employee_id` BIGINT COMMENT 'Identifier of the employee or team member assigned as the primary owner responsible for executing and closing the CAPA.',
    `nonconformance_id` BIGINT COMMENT 'Nonconformance Id referencing quality.nonconformance.nonconformance_id.',
    `actual_completion_date` DATE COMMENT 'The actual date when all CAPA actions were completed and verified, prior to formal closure.',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.capa.',
    `batch_number` STRING COMMENT 'Manufacturing batch or lot number associated with the CAPA, if applicable. Used to trace quality issues to specific production runs.',
    `capa_number` STRING COMMENT 'Business-facing unique identifier for the CAPA record, typically formatted as CAPA-NNNNNN. Used for external communication and audit trails.. Valid values are `^CAPA-[0-9]{6,10}$`',
    `capa_status` STRING COMMENT 'Current lifecycle status of the CAPA record, tracking progression from initiation through closure. [ENUM-REF-CANDIDATE: open|investigation|action_plan|implementation|verification|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `capa_type` STRING COMMENT 'Classification of the CAPA as corrective (addressing existing nonconformance), preventive (preventing potential nonconformance), or combined (both corrective and preventive actions).. Valid values are `corrective|preventive|combined`',
    `closed_date` DATE COMMENT 'Date/time of Closed Date.',
    `closure_comments` STRING COMMENT 'Final comments or notes recorded at the time of CAPA closure, summarizing outcomes and lessons learned.',
    `closure_date` DATE COMMENT 'The date when the CAPA was formally closed after successful completion and verification of all actions.',
    `capa_code` STRING COMMENT 'Attribute code of quality.capa.',
    `completion_date` DATE COMMENT 'Attribute completion_date of quality.capa.',
    `corrective_action` STRING COMMENT 'Corrective Action value for the Capa record.',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective action(s) taken to address the existing nonconformance and eliminate its cause.',
    `cost_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial cost impact of the CAPA issue, including costs of investigation, rework, scrap, recall, or other remediation activities.',
    `cost_impact_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost impact amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CAPA record was first created in the quality management system.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.capa.',
    `customer_impact_flag` BOOLEAN COMMENT 'Indicates whether the CAPA issue had a direct impact on customers, such as product quality defects, delivery delays, or safety concerns.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `capa_description` STRING COMMENT 'Detailed description of the nonconformance, audit finding, complaint, or stability failure that triggered the CAPA.',
    `due_date` DATE COMMENT 'Date/time of Due Date.',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.capa.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.capa.',
    `effectiveness_check_date` DATE COMMENT 'Date/time of Effectiveness Check Date.',
    `effectiveness_result` STRING COMMENT 'Effectiveness Result value for the Capa record.',
    `effectiveness_verification_method` STRING COMMENT 'The method or approach used to verify that the corrective and preventive actions were effective in resolving the issue and preventing recurrence (e.g., follow-up audit, process monitoring, trend analysis).',
    `effectiveness_verification_result` STRING COMMENT 'The outcome of the effectiveness verification, indicating whether the CAPA actions successfully resolved the issue and prevented recurrence.. Valid values are `effective|ineffective|pending`',
    `effectiveness_verified` BOOLEAN COMMENT 'Attribute effectiveness_verified of quality.capa.',
    `gmp_deviation_flag` BOOLEAN COMMENT 'Indicates whether the CAPA issue involved a deviation from Good Manufacturing Practice (GMP) standards.',
    `initiated_date` DATE COMMENT 'The date when the CAPA record was formally initiated and opened in the quality management system.',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the CAPA record was last updated or modified.',
    `capa_name` STRING COMMENT 'Attribute name of quality.capa.',
    `notes` STRING COMMENT 'Attribute notes of quality.capa.',
    `opened_date` DATE COMMENT 'Date/time of Opened Date.',
    `preventive_action` STRING COMMENT 'Preventive Action value for the Capa record.',
    `preventive_action_description` STRING COMMENT 'Detailed description of the preventive action(s) implemented to prevent recurrence of the issue or occurrence of similar issues.',
    `priority` STRING COMMENT 'Priority level assigned to the CAPA for resource allocation and scheduling purposes.. Valid values are `high|medium|low`',
    `problem_statement` STRING COMMENT 'Attribute problem_statement of quality.capa.',
    `process_area` STRING COMMENT 'The specific process, department, or functional area where the issue occurred (e.g., Manufacturing, Packaging, Quality Control, Supply Chain).',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.capa.',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `regulatory_impact_flag` BOOLEAN COMMENT 'Boolean indicator for Regulatory Impact Flag.',
    `regulatory_report_date` DATE COMMENT 'The date when the CAPA issue was reported to the relevant regulatory authority, if applicable.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this CAPA issue is required to be reported to regulatory authorities such as FDA, EPA, or other governing bodies.',
    `responsible_department` STRING COMMENT 'The department or functional area responsible for implementing the CAPA actions.',
    `root_cause_analysis` STRING COMMENT 'Root Cause Analysis value for the Capa record.',
    `root_cause_analysis_method` STRING COMMENT 'The methodology used to identify the root cause of the issue, such as 5 Whys, Fishbone Diagram, Fault Tree Analysis, Pareto Analysis, or Failure Mode and Effects Analysis (FMEA).. Valid values are `5_whys|fishbone|fault_tree|pareto|failure_mode_effects_analysis|other`',
    `root_cause_description` STRING COMMENT 'Detailed description of the identified root cause(s) of the nonconformance or issue.',
    `severity` STRING COMMENT 'Severity classification of the CAPA issue based on impact to product quality, safety, regulatory compliance, or business operations.. Valid values are `critical|major|minor`',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_reference_number` STRING COMMENT 'Reference identifier of the originating event (e.g., nonconformance ID, audit finding ID, complaint ID) that triggered this CAPA.',
    `source_system_code` STRING COMMENT 'Source System Code value for the Capa record.',
    `source_type` STRING COMMENT 'The origin or trigger event that initiated the CAPA, such as nonconformance, audit finding, customer complaint, supplier quality issue, stability study failure, or regulatory inspection finding.. Valid values are `nonconformance|audit_finding|customer_complaint|supplier_issue|stability_failure|regulatory_inspection`',
    `target_completion_date` DATE COMMENT 'The planned or target date by which all CAPA actions should be completed and verified.',
    `title` STRING COMMENT 'Brief descriptive title summarizing the CAPA issue or focus area.',
    `uom` STRING COMMENT 'Attribute uom of quality.capa.',
    `updated_timestamp` TIMESTAMP COMMENT 'Attribute updated_timestamp of quality.capa.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `verification_date` DATE COMMENT 'The date when the effectiveness verification was completed.',
    CONSTRAINT pk_capa PRIMARY KEY(`capa_id`)
) COMMENT 'Corrective and preventive action record capturing root-cause analysis, corrective actions, preventive actions, and effectiveness verification.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` (
    `batch_release_id` BIGINT COMMENT 'Unique identifier for the batch release decision record. Primary key for the batch release entity.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who last modified the batch release record. Required for audit trail and 21 CFR Part 11 compliance.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Batch release decisions are based on the manufacturing batch record; linking ensures release status reflects the underlying production data and supports regulatory audit trails.',
    `certificate_of_analysis_id` BIGINT COMMENT 'Attribute certificate_of_analysis_id of quality.batch_release.',
    `batch_released_by_employee_id` BIGINT COMMENT 'Released By Employee Id referencing workforce.employee.employee_id.',
    `inspection_lot_id` BIGINT COMMENT 'Attribute inspection_lot_id of quality.batch_release.',
    `inspector_employee_id` BIGINT COMMENT 'Employee identifier of the Qualified Person who authorized the batch release. QP sign-off is a regulatory requirement in EU GMP and similar frameworks.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Batch release decisions rely on the exact lot batch record to confirm quality release status and regulatory compliance.',
    `primary_batch_release_certificate_of_analysis_id` BIGINT COMMENT 'Foreign key linking to quality.certificate_of_analysis. Business justification: Link batch_release to the Certificate of Analysis that documents the released batch, removing redundant reference number.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Batch release reports require linking each release to the specific SKU for traceability, regulatory filing, and inventory reconciliation.',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.batch_release.',
    `audit_trail_reference` STRING COMMENT 'Reference to the complete audit trail log for all actions and approvals related to this batch release. Required for 21 CFR Part 11 compliance.. Valid values are `^AUDIT-[A-Z0-9]{8,20}$`',
    `batch_number` STRING COMMENT 'Attribute batch_number of quality.batch_release.',
    `batch_release_status` STRING COMMENT 'Attribute status of quality.batch_release.',
    `batch_size_quantity` DECIMAL(18,2) COMMENT 'Total quantity of finished goods produced in this batch. Used for yield calculation and inventory planning.',
    `batch_size_uom` STRING COMMENT 'Unit of measure for the batch size quantity (e.g., kilograms, liters, units). Aligns with GS1 standards for trade item measurement. [ENUM-REF-CANDIDATE: kg|lbs|liters|gallons|units|cases|pallets — 7 candidates stripped; promote to reference product]',
    `capa_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a CAPA investigation is required based on deviations or non-conformances identified during batch production or testing.',
    `certificate_of_analysis_number` STRING COMMENT 'Certificate Of Analysis Number value for the Batch Release record.',
    `batch_release_code` STRING COMMENT 'Attribute code of quality.batch_release.',
    `comments` STRING COMMENT 'Comments value for the Batch Release record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch release record was first created in the system. Part of audit trail for regulatory compliance.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.batch_release.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `batch_release_description` STRING COMMENT 'Attribute description of quality.batch_release.',
    `deviation_count` STRING COMMENT 'Number of manufacturing or quality deviations recorded during the production and testing of this batch. Used for quality trend analysis.',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.batch_release.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.batch_release.',
    `expiry_date` DATE COMMENT 'Date after which the batch should not be sold or used. Calculated from production date plus shelf life. Critical for FEFO inventory management and regulatory compliance.',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the batch was manufactured in full compliance with GMP requirements. False indicates deviation or non-conformance.',
    `gmp_compliant` BOOLEAN COMMENT 'Attribute gmp_compliant of quality.batch_release.',
    `hold_initiated_date` DATE COMMENT 'Date when the regulatory or business hold was placed on the batch. Nullable if no hold exists.',
    `hold_reason` STRING COMMENT 'Detailed explanation of why the batch is on hold, if applicable. Includes regulatory citation, investigation reference, or customer complaint number.',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch release record was last updated. Tracks changes to release status, hold status, or other critical fields.',
    `manufacture_date` DATE COMMENT 'Attribute manufacture_date of quality.batch_release.',
    `manufacturing_site_code` STRING COMMENT 'Code identifying the manufacturing facility or plant where the batch was produced. Used for site-level quality tracking and regulatory reporting.. Valid values are `^[A-Z0-9]{3,10}$`',
    `batch_release_name` STRING COMMENT 'Attribute name of quality.batch_release.',
    `notes` STRING COMMENT 'Attribute notes of quality.batch_release.',
    `product_registration_number` STRING COMMENT 'Regulatory registration or approval number for the product in the target market. Required for FDA NDC, EU product registration, or equivalent.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `production_date` DATE COMMENT 'Date when the batch manufacturing was completed. Critical for shelf-life calculation and FEFO inventory management.',
    `qa_signoff_flag` BOOLEAN COMMENT 'Boolean indicator for Qa Signoff Flag.',
    `qc_inspection_status` STRING COMMENT 'Overall status of QC inspection and testing for this batch. Summarizes results from multiple QC test records.. Valid values are `passed|failed|conditional_pass|pending|waived`',
    `qp_certification_flag` BOOLEAN COMMENT 'Boolean indicator for Qp Certification Flag.',
    `qp_signature` STRING COMMENT 'Attribute qp_signature of quality.batch_release.',
    `qp_signature_timestamp` TIMESTAMP COMMENT 'Timestamp when the Qualified Person electronically signed the batch release decision. Part of 21 CFR Part 11 electronic signature compliance.',
    `qualified_person_name` STRING COMMENT 'Full name of the Qualified Person who signed off on the batch release. Required for regulatory audit trail.',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.batch_release.',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `regulatory_hold_status` STRING COMMENT 'Indicates if the batch is under any regulatory or business hold that prevents distribution. Holds may be imposed by FDA, EPA, internal quality, customer complaint, or recall investigation.. Valid values are `no_hold|fda_hold|epa_hold|internal_hold|customer_hold|recall_hold`',
    `regulatory_market` STRING COMMENT 'Primary regulatory market or jurisdiction for which this batch was released. Different markets may have different release requirements and QP sign-off rules. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|DEU|FRA|ITA|ESP|CHN|JPN|AUS|BRA|IND — 13 candidates stripped; promote to reference product]',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'Quantity of the batch that was rejected and marked for destruction or rework. Part of quality yield tracking.',
    `release_date` DATE COMMENT 'Date when the batch was officially released for distribution and sale. Marks the point at which product becomes available to promise (ATP).',
    `release_decision` STRING COMMENT 'Final disposition decision for the batch: released for distribution, rejected for destruction, quarantine for further testing, conditional release with restrictions, pending review, or on hold pending investigation. Critical GMP control point.. Valid values are `released|rejected|quarantine|conditional_release|pending_review|on_hold`',
    `release_notes` STRING COMMENT 'Free-text notes and comments from the Qualified Person regarding the release decision. May include justification for conditional release or special handling instructions.',
    `release_number` STRING COMMENT 'Release Number value for the Batch Release record.',
    `release_quantity` DECIMAL(18,2) COMMENT 'Attribute release_quantity of quality.batch_release.',
    `release_status` STRING COMMENT 'Release Status value for the Batch Release record.',
    `release_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the batch release decision was recorded in the system. Used for audit trail and regulatory compliance.',
    `released_quantity` DECIMAL(18,2) COMMENT 'Quantity of the batch that was approved for release and distribution. May be less than batch size if partial rejection occurred.',
    `retest_date` DATE COMMENT 'Date when the batch must be retested to confirm continued quality and stability. Common for raw materials and intermediates.',
    `sap_qm_inspection_lot` STRING COMMENT 'SAP QM inspection lot number associated with this batch release. Links to SAP S/4HANA QM module for detailed inspection results and usage decisions.. Valid values are `^[0-9]{10}$`',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'Source System Code value for the Batch Release record.',
    `stability_study_reference` STRING COMMENT 'Reference number linking to the stability study protocol and results that support the assigned shelf life and expiry date for this batch.. Valid values are `^STAB-[A-Z0-9]{8,20}$`',
    `uom` STRING COMMENT 'Attribute uom of quality.batch_release.',
    `updated_timestamp` TIMESTAMP COMMENT 'Attribute updated_timestamp of quality.batch_release.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `veeva_vault_document_reference` STRING COMMENT 'Document identifier in Veeva Vault system linking to the official batch release record and supporting quality documents. Integrates with Veeva Vault QMS.. Valid values are `^VV-[A-Z0-9]{10,20}$`',
    CONSTRAINT pk_batch_release PRIMARY KEY(`batch_release_id`)
) COMMENT 'Quality decision record authorizing the release, hold, or rejection of a manufactured batch, including QP certification and disposition.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` (
    `certificate_of_analysis_id` BIGINT COMMENT 'Unique identifier for the certificate of analysis record. Primary key.',
    `batch_record_id` BIGINT COMMENT 'Batch Record Id referencing manufacturing.batch_record.batch_record_id.',
    `employee_id` BIGINT COMMENT 'Attribute approved_by_employee_id of workforce.certificate_of_analysis.',
    `certificate_issued_by_employee_id` BIGINT COMMENT 'Issued By Employee Id referencing workforce.employee.employee_id.',
    `laboratory_id` BIGINT COMMENT 'Foreign key linking to quality.laboratory. Business justification: Link certificate_of_analysis to the laboratory that issued it, removing redundant name/code fields.',
    `inspection_lot_id` BIGINT COMMENT 'Attribute inspection_lot_id of quality.certificate_of_analysis.',
    `lot_batch_id` BIGINT COMMENT 'Reference to the lot or batch for which this certificate of analysis was issued. Links to the specific production batch of finished goods or raw materials.',
    `sku_id` BIGINT COMMENT 'Sku Id referencing product.sku.sku_id.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: COA must reference the supplier of the batch for traceability and regulatory compliance; supplier_name is replaced by FK.',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.certificate_of_analysis.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the certificate was officially approved by the authorized signatory. Represents the moment of quality release decision.',
    `approved_flag` BOOLEAN COMMENT 'Boolean indicator for Approved Flag.',
    `authorized_signatory_name` STRING COMMENT 'Full name of the quality assurance professional authorized to approve and sign this certificate. Must have appropriate delegation of authority.',
    `authorized_signatory_title` STRING COMMENT 'Job title or role of the authorized signatory (e.g., QA Manager, Quality Director, Laboratory Supervisor).',
    `batch_number` STRING COMMENT 'The manufacturing batch or lot number for the material being certified. Critical for traceability and recall management.. Valid values are `^[A-Z0-9]{6,20}$`',
    `batch_size` DECIMAL(18,2) COMMENT 'Total quantity produced in the manufacturing batch. Used to assess sample representativeness and for statistical quality control.',
    `batch_size_uom` STRING COMMENT 'Unit of measure for the batch size. Typically matches the materials production UOM.. Valid values are `kg|g|L|mL|units|cases`',
    `certificate_number` STRING COMMENT 'Externally-known unique certificate number assigned to this CoA document. Used for customer communication and regulatory submissions.. Valid values are `^COA-[A-Z0-9]{8,20}$`',
    `certificate_of_analysis_status` STRING COMMENT 'Attribute status of quality.certificate_of_analysis.',
    `certificate_type` STRING COMMENT 'Classification of the certificate based on the material type being certified. Determines applicable test parameters and regulatory requirements.. Valid values are `finished_goods|raw_material|intermediate|packaging_material`',
    `coa_number` STRING COMMENT 'Coa Number value for the Certificate Of Analysis record.',
    `coa_status` STRING COMMENT 'Coa Status value for the Certificate Of Analysis record.',
    `certificate_of_analysis_code` STRING COMMENT 'Attribute code of quality.certificate_of_analysis.',
    `compliance_statement` STRING COMMENT 'Attribute compliance_statement of quality.certificate_of_analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this certificate record was first created in the system. Audit trail for record lifecycle.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.certificate_of_analysis.',
    `customer_facing_flag` BOOLEAN COMMENT 'Indicates whether this certificate is intended for external distribution to trade customers or is for internal use only. True if customer-facing.',
    `customer_name` STRING COMMENT 'Customer Name value for the Certificate Of Analysis record.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `certificate_of_analysis_description` STRING COMMENT 'Attribute description of quality.certificate_of_analysis.',
    `document_reference` STRING COMMENT 'Document Reference value for the Certificate Of Analysis record.',
    `document_url` STRING COMMENT 'URL or file path to the digitally signed PDF or scanned image of the certificate stored in Veeva Vault or document management system.. Valid values are `^https?://.*`',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.certificate_of_analysis.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.certificate_of_analysis.',
    `expiry_date` DATE COMMENT 'The date after which the material should not be used or sold. Based on stability studies and regulatory requirements.',
    `gmp_compliant_flag` BOOLEAN COMMENT 'Indicates whether the batch and testing process were conducted under GMP conditions. True if GMP-compliant.',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `issue_date` DATE COMMENT 'The date on which this certificate of analysis was officially issued and authorized for distribution to customers or regulatory bodies.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date/time of Last Modified Timestamp.',
    `lot_number` STRING COMMENT 'Lot Number value for the Certificate Of Analysis record.',
    `manufacture_date` DATE COMMENT 'Date/time of Manufacture Date.',
    `manufacturing_date` DATE COMMENT 'The date on which the batch was manufactured or produced. Used for shelf-life calculations and FEFO inventory management.',
    `manufacturing_site_code` STRING COMMENT 'Code identifying the manufacturing facility or plant where the batch was produced. Critical for site-specific compliance and traceability.. Valid values are `^SITE-[A-Z0-9]{4,10}$`',
    `manufacturing_site_name` STRING COMMENT 'Full name and location of the manufacturing site. Supports multi-site operations and regulatory site registration requirements.',
    `material_code` STRING COMMENT 'The product or material code (SKU, item number, or raw material identifier) for which this certificate was issued. Links to master product or material data.. Valid values are `^[A-Z0-9]{6,20}$`',
    `material_description` STRING COMMENT 'Full textual description of the material or product covered by this certificate. Includes product name, variant, and key characteristics.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this certificate record was last modified. Supports change tracking and audit compliance.',
    `certificate_of_analysis_name` STRING COMMENT 'Attribute name of quality.certificate_of_analysis.',
    `notes` STRING COMMENT 'Attribute notes of quality.certificate_of_analysis.',
    `overall_result` STRING COMMENT 'Overall Result value for the Certificate Of Analysis record.',
    `overall_result_status` STRING COMMENT 'Aggregate pass/fail status for all test parameters on this certificate. Determines batch release decision and customer distribution eligibility.. Valid values are `pass|fail|conditional_pass|pending_review`',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.certificate_of_analysis.',
    `quantity_tested` DECIMAL(18,2) COMMENT 'The quantity of material sampled and tested for this certificate. Expressed in the materials base unit of measure.',
    `quantity_tested_uom` STRING COMMENT 'Unit of measure for the quantity tested (e.g., kilograms, liters, units). Aligns with material master UOM.. Valid values are `kg|g|L|mL|units|cases`',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Indicates whether this certificate is required for regulatory submissions or compliance filings with FDA, EPA, or other governing bodies. True if required for submission.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, observations, or special conditions related to the testing or batch. May include deviations or special handling instructions.',
    `retest_date` DATE COMMENT 'The date by which the material should be retested to confirm continued conformance to specifications. Applicable primarily to raw materials.',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'Source System Code value for the Certificate Of Analysis record.',
    `specification_version` STRING COMMENT 'Version number of the product specification or quality standard used for testing. Ensures traceability to the correct specification limits.. Valid values are `^V[0-9]{1,3}.[0-9]{1,3}$`',
    `storage_condition` STRING COMMENT 'Recommended storage conditions for the material (e.g., store in cool dry place, refrigerate at 2-8°C, protect from light). Based on stability data.',
    `supplier_lot_number` STRING COMMENT 'The lot or batch number assigned by the supplier for raw materials or packaging materials. Used for supplier quality traceability.',
    `test_date` DATE COMMENT 'The date on which quality control testing was performed for this certificate. May differ from manufacturing date for retained samples.',
    `test_method_reference` STRING COMMENT 'Reference to the analytical test methods used (e.g., USP, ASTM, internal method codes). May be a comma-separated list for multiple methods.',
    `uom` STRING COMMENT 'Attribute uom of quality.certificate_of_analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Attribute updated_timestamp of quality.certificate_of_analysis.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `veeva_vault_document_reference` STRING COMMENT 'Unique document identifier in Veeva Vault system where the certificate is stored. Enables integration with regulatory document management.. Valid values are `^[A-Z0-9]{10,30}$`',
    CONSTRAINT pk_certificate_of_analysis PRIMARY KEY(`certificate_of_analysis_id`)
) COMMENT 'Authoritative certificate documenting test results and specification conformance for a manufactured or supplied lot.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` (
    `quality_stability_study_id` BIGINT COMMENT 'Unique identifier for the stability study record. Primary key.',
    `laboratory_id` BIGINT COMMENT 'Responsible Lab Id referencing quality.laboratory.laboratory_id.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Stability studies are performed on a defined lot batch; linking enables shelf‑life reporting and regulatory submissions.',
    `employee_id` BIGINT COMMENT 'Owner Employee Id referencing workforce.employee.employee_id.',
    `product_formulation_id` BIGINT COMMENT 'Attribute product_formulation_id of product.quality_stability_study.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Link quality_stability_study to the specification it validates, eliminating the free‑text reference column.',
    `quality_study_director_employee_id` BIGINT COMMENT 'Attribute study_director_employee_id of workforce.quality_stability_study.',
    `sku_id` BIGINT COMMENT 'Reference to the product or formulation being tested in this stability study.',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.quality_stability_study.',
    `approved_shelf_life_months` STRING COMMENT 'Regulatory-approved or final determined shelf life in months based on stability study results. May differ from proposed shelf life if data does not support full duration.',
    `quality_stability_study_code` STRING COMMENT 'Attribute code of quality.quality_stability_study.',
    `commitment_due_date` DATE COMMENT 'Regulatory deadline by which stability study results must be submitted to the health authority. Applicable only when stability_commitment_flag is true.',
    `container_closure_system` STRING COMMENT 'Detailed specification of the container and closure materials and design used in the stability study. Critical for assessing barrier properties and product protection.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stability study record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.quality_stability_study.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `quality_stability_study_description` STRING COMMENT 'Attribute description of quality.quality_stability_study.',
    `deviation_count` STRING COMMENT 'Number of protocol deviations or non-conformances recorded during the stability study execution (e.g., missed time points, temperature excursions, testing delays).',
    `duration_months` STRING COMMENT 'Duration Months value for the Quality Stability Study record.',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.quality_stability_study.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.quality_stability_study.',
    `formulation_code` STRING COMMENT 'Identifier for the specific product formulation or recipe being tested. Used to track formulation changes and their impact on stability.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Humidity Percent value for the Quality Stability Study record.',
    `ich_climatic_zone` STRING COMMENT 'International Council for Harmonisation (ICH) climatic zone classification for the intended market. Zone I (temperate), Zone II (subtropical/Mediterranean), Zone III (hot/dry), Zone IV (hot/humid). Determines required storage conditions.. Valid values are `I|II|III|IV-A|IV-B`',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this stability study record was last updated. Audit trail for record changes.',
    `manufacturing_site` STRING COMMENT 'Identifier or name of the manufacturing facility where the batch being tested was produced. Important for site-specific stability commitments.',
    `quality_stability_study_name` STRING COMMENT 'Attribute name of quality.quality_stability_study.',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or context about the stability study that do not fit in structured fields.',
    `out_of_specification_flag` BOOLEAN COMMENT 'Indicates whether any test results during the study were out of specification, triggering investigation and potential corrective action. True if any OOS results occurred.',
    `out_of_trend_flag` BOOLEAN COMMENT 'Indicates whether any test results showed unexpected trends or deviations from expected stability behavior, even if within specification. True if any OOT results occurred.',
    `packaging_configuration` STRING COMMENT 'Description of the primary and secondary packaging used for the stability samples (e.g., HDPE bottle with child-resistant cap, aluminum tube with flip-top cap). Packaging can significantly impact product stability.',
    `product_category` STRING COMMENT 'Classification of the product type being tested (e.g., oral solid, topical cream, liquid suspension, aerosol). Different product forms have different stability considerations and testing requirements.',
    `proposed_shelf_life_months` STRING COMMENT 'Intended or claimed shelf life in months that this stability study is designed to support. Final shelf life determination is based on study results.',
    `protocol_reference` STRING COMMENT 'Reference identifier for the approved stability study protocol document that defines test methods, sampling schedule, acceptance criteria, and storage conditions. Links to protocol management system or Veeva Vault.',
    `quality_stability_study_status` STRING COMMENT 'Attribute status of quality.quality_stability_study.',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.quality_stability_study.',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `regulatory_purpose` STRING COMMENT 'Primary regulatory or business purpose for conducting the stability study. Registration studies support new product applications. Post-approval studies fulfill ongoing commitments. Change-control studies assess impact of manufacturing or formulation changes.. Valid values are `registration|post-approval|annual-review|change-control|shelf-life-extension|market-complaint`',
    `regulatory_region` STRING COMMENT 'Geographic region or regulatory authority for which this stability study is being conducted (e.g., USA, EU, Japan, Global). Different regions may have different storage condition requirements per ICH climatic zones.',
    `report_approval_date` DATE COMMENT 'Date when the final stability study report was reviewed and approved by quality assurance. Marks formal completion of the study.',
    `report_reference` STRING COMMENT 'Document identifier for the final stability study report. Links to document management system or Veeva Vault for full study documentation.',
    `responsible_laboratory` STRING COMMENT 'Name or identifier of the laboratory facility conducting the stability testing. May be internal quality control (QC) lab or external contract testing laboratory.',
    `sample_size` STRING COMMENT 'Number of individual product units or samples placed on stability for this study. Must be sufficient to support all planned time-point testing.',
    `shelf_life_target_months` STRING COMMENT 'Shelf Life Target Months value for the Quality Stability Study record.',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'Source System Code value for the Quality Stability Study record.',
    `stability_commitment_flag` BOOLEAN COMMENT 'Indicates whether this study is part of a formal stability commitment made to a regulatory authority. True if this is a committed study that must be completed and reported per regulatory agreement.',
    `storage_condition` STRING COMMENT 'Primary storage condition for the study, expressed as temperature and relative humidity (e.g., 25°C/60%RH for long-term, 30°C/65%RH for intermediate, 40°C/75%RH for accelerated). May include additional conditions such as light exposure or freezing.',
    `storage_humidity_pct` DECIMAL(18,2) COMMENT 'Target relative humidity percentage for the stability study storage condition.',
    `storage_instruction` STRING COMMENT 'Consumer-facing storage instructions that will appear on product labeling, derived from stability study results (e.g., Store at room temperature, Do not freeze, Protect from light).',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Target storage temperature in degrees Celsius for the stability study chamber or condition.',
    `study_conclusion` STRING COMMENT 'Summary conclusion of the stability study results, including whether the product met all acceptance criteria throughout the study duration and any recommendations for shelf life or storage conditions.',
    `study_coordinator` STRING COMMENT 'Name or employee identifier of the person responsible for coordinating and overseeing the stability study execution.',
    `study_duration_months` STRING COMMENT 'Planned total duration of the stability study in months. Typical durations are 6 months for accelerated studies, 12-36 months for real-time studies, and up to 60 months for long-term studies.',
    `study_end_date` DATE COMMENT 'Planned or actual completion date of the stability study. For ongoing studies, represents the projected completion date based on protocol duration.',
    `study_number` STRING COMMENT 'Business identifier for the stability study, typically assigned by the quality management system or laboratory information management system (LIMS). Used for external reference and regulatory submissions.',
    `study_start_date` DATE COMMENT 'Date when the stability study was initiated and samples were placed on stability storage. Marks the beginning of the study timeline for time-point calculations.',
    `study_status` STRING COMMENT 'Current lifecycle status of the stability study. Tracks progression from planning through completion or discontinuation.. Valid values are `planned|in-progress|completed|discontinued|on-hold|under-review`',
    `study_type` STRING COMMENT 'Classification of the stability study protocol. Accelerated studies use elevated temperature/humidity to predict shelf life. Real-time studies use recommended storage conditions. Intermediate studies bridge accelerated and real-time. Stress studies test extreme conditions. Photostability studies assess light exposure impact. In-use studies simulate consumer usage conditions.. Valid values are `accelerated|real-time|intermediate|stress|photostability|in-use`',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Temperature Celsius value for the Quality Stability Study record.',
    `test_parameters` STRING COMMENT 'List of quality attributes and test methods included in the stability protocol (e.g., appearance, pH, assay, impurities, microbial limits, viscosity). Comma-separated or structured list.',
    `testing_frequency` STRING COMMENT 'Schedule of time points at which samples are pulled and tested (e.g., 0, 3, 6, 9, 12, 18, 24, 36 months). Defined in the study protocol and varies by study type.',
    `uom` STRING COMMENT 'Attribute uom of quality.quality_stability_study.',
    `updated_timestamp` TIMESTAMP COMMENT 'Attribute updated_timestamp of quality.quality_stability_study.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    CONSTRAINT pk_quality_stability_study PRIMARY KEY(`quality_stability_study_id`)
) COMMENT 'Stability study record defining storage conditions, test parameters, and shelf-life determination for a product or batch.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` (
    `stability_result_id` BIGINT COMMENT 'Unique identifier for the stability test result record. Primary key for the stability result entity.',
    `lot_batch_id` BIGINT COMMENT 'Reference to the specific production lot or batch being tested for stability.',
    `original_result_stability_result_id` BIGINT COMMENT 'Reference to the original stability result record if this is a retest.',
    `quality_stability_study_id` BIGINT COMMENT 'Reference to the parent stability study protocol under which this result was generated.',
    `sku_id` BIGINT COMMENT 'Reference to the product being tested in this stability study.',
    `employee_id` BIGINT COMMENT 'Recorded By Employee Id referencing workforce.employee.employee_id.',
    `stability_tested_by_employee_id` BIGINT COMMENT 'Attribute tested_by_employee_id of workforce.stability_result.',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.stability_result.',
    `analyst_name` STRING COMMENT 'Name of the laboratory analyst who performed the test.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this stability result was reviewed and approved by quality assurance.',
    `stability_result_code` STRING COMMENT 'Attribute code of quality.stability_result.',
    `comments` STRING COMMENT 'Free-text comments or observations recorded by the analyst or reviewer regarding this stability result.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stability result record was first created in the system.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.stability_result.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `stability_result_description` STRING COMMENT 'Attribute description of quality.stability_result.',
    `deviation_percentage` DECIMAL(18,2) COMMENT 'Percentage deviation of the measured value from the specification target or initial value.',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.stability_result.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.stability_result.',
    `instrument_code` STRING COMMENT 'Unique identifier of the analytical instrument used to perform the test.',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `is_within_spec` BOOLEAN COMMENT 'Boolean indicator for Is Within Spec.',
    `laboratory_location` STRING COMMENT 'Physical location or site code of the laboratory where the test was performed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date/time of Last Modified Timestamp.',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Lower Spec Limit value for the Stability Result record.',
    `measured_value` DECIMAL(18,2) COMMENT 'Numeric result obtained from the stability test for this characteristic at this time point.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this stability result record was last modified.',
    `stability_result_name` STRING COMMENT 'Attribute name of quality.stability_result.',
    `notes` STRING COMMENT 'Notes value for the Stability Result record.',
    `out_of_specification_flag` BOOLEAN COMMENT 'Boolean indicator that the result is out of specification and requires investigation per GMP requirements.',
    `parameter_name` STRING COMMENT 'Parameter Name value for the Stability Result record.',
    `pass_fail_status` STRING COMMENT 'Indicates whether the measured value meets the specification limits. Pass indicates conformance, fail indicates non-conformance.. Valid values are `pass|fail|inconclusive|pending`',
    `pull_date` DATE COMMENT 'Date when the sample was pulled from stability storage for testing at this time point.',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.stability_result.',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Indicates whether this result is included in regulatory submission packages to FDA, EMA, or other health authorities.',
    `result_pass_fail` STRING COMMENT 'Attribute result_pass_fail of quality.stability_result.',
    `result_uom` STRING COMMENT 'Result Uom value for the Stability Result record.',
    `result_value` DECIMAL(18,2) COMMENT 'Result Value value for the Stability Result record.',
    `retest_flag` BOOLEAN COMMENT 'Indicates whether this result is a retest following an initial out-of-specification result or laboratory investigation.',
    `reviewer_name` STRING COMMENT 'Name of the quality professional who reviewed and approved the test result.',
    `sap_qm_inspection_lot` STRING COMMENT 'SAP Quality Management inspection lot number associated with this stability test result.',
    `shelf_life_impact_flag` BOOLEAN COMMENT 'Indicates whether this result impacts the determination of product shelf life or expiration dating.',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'Source System Code value for the Stability Result record.',
    `specification_limit` STRING COMMENT 'Attribute specification_limit of quality.stability_result.',
    `specification_lower_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable value for this test characteristic as defined in the product specification.',
    `specification_target` DECIMAL(18,2) COMMENT 'Target or nominal value for this test characteristic as defined in the product specification.',
    `specification_upper_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable value for this test characteristic as defined in the product specification.',
    `stability_result_status` STRING COMMENT 'Attribute status of quality.stability_result.',
    `storage_condition` STRING COMMENT 'Environmental condition under which the sample was stored (temperature and relative humidity). Standard ICH conditions include 25°C/60% RH (long-term), 30°C/65% RH (intermediate), and 40°C/75% RH (accelerated).. Valid values are `25C/60RH|30C/65RH|40C/75RH|5C|refrigerated|frozen`',
    `test_characteristic` STRING COMMENT 'Specific quality attribute or parameter being measured (e.g., assay, impurity level, pH, viscosity, color, odor, dissolution rate, microbial count).',
    `test_date` DATE COMMENT 'Date when the laboratory test was performed on the pulled sample.',
    `test_interval_number` STRING COMMENT 'Sequential interval number within the stability study protocol (e.g., 0, 1, 3, 6, 9, 12, 18, 24 months).',
    `test_method` STRING COMMENT 'Analytical method or procedure used to measure the test characteristic (e.g., HPLC, GC, UV-Vis, titration, Karl Fischer).',
    `test_parameter` STRING COMMENT 'Attribute test_parameter of quality.stability_result.',
    `test_status` STRING COMMENT 'Current lifecycle status of this stability test result.. Valid values are `scheduled|in_progress|completed|cancelled|on_hold`',
    `timepoint_months` STRING COMMENT 'Timepoint Months value for the Stability Result record.',
    `trend` STRING COMMENT 'Trend value for the Stability Result record.',
    `trend_flag` BOOLEAN COMMENT 'Indicates whether this result shows a statistically significant trend toward specification limits that may predict future failure.',
    `unit_of_measure` STRING COMMENT 'Unit in which the measured value is expressed (e.g., %, mg/g, pH units, cP, CFU/g).',
    `uom` STRING COMMENT 'Attribute uom of quality.stability_result.',
    `updated_timestamp` TIMESTAMP COMMENT 'Attribute updated_timestamp of quality.stability_result.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Upper Spec Limit value for the Stability Result record.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `veeva_vault_document_reference` STRING COMMENT 'Reference identifier to the associated stability test report or certificate of analysis stored in Veeva Vault quality document management system.',
    CONSTRAINT pk_stability_result PRIMARY KEY(`stability_result_id`)
) COMMENT 'Time-point stability test result evaluated against specification limits, supporting shelf-life and trend analysis.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` (
    `gmp_audit_id` BIGINT COMMENT 'Unique identifier for the GMP audit event record. Primary key.',
    `audit_program_id` BIGINT COMMENT 'Reference to the audit program or audit plan under which this audit was conducted (e.g., annual internal audit program, supplier qualification program).',
    `capa_id` BIGINT COMMENT 'Reference to the CAPA record initiated in response to audit findings.',
    `employee_id` BIGINT COMMENT 'Lead Auditor Employee Id referencing workforce.employee.employee_id.',
    `inspector_employee_id` BIGINT COMMENT 'System identifier for the lead auditor, linking to employee or external auditor master data.',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing facility, contract manufacturer, or laboratory where the audit was conducted.',
    `supplier_id` BIGINT COMMENT 'Supplier Id referencing procurement.supplier.supplier_id.',
    `audit_checklist_id` BIGINT COMMENT 'Reference to the audit checklist or protocol used during the audit to ensure consistent evaluation criteria.',
    `actual_end_date` DATE COMMENT 'Actual date when the audit fieldwork was completed.',
    `actual_start_date` DATE COMMENT 'Actual date when the audit commenced on-site or remotely.',
    `affected_process_areas` STRING COMMENT 'Comma-separated list of process areas or departments affected by audit findings (e.g., production, quality control, warehouse, documentation, cleaning validation).',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.gmp_audit.',
    `audit_date` DATE COMMENT 'Attribute audit_date of quality.gmp_audit.',
    `audit_end_date` DATE COMMENT 'Date/time of Audit End Date.',
    `audit_notes` STRING COMMENT 'Free-text field for additional audit notes, context, or observations not captured in structured fields.',
    `audit_number` STRING COMMENT 'Externally-known unique identifier for the audit event, used for tracking and regulatory reporting.',
    `audit_report_date` DATE COMMENT 'Date when the final audit report was issued to the facility or organization.',
    `audit_result` STRING COMMENT 'Attribute audit_result of quality.gmp_audit.',
    `audit_scope` STRING COMMENT 'Description of the audit scope including processes, systems, and areas covered (e.g., production lines, quality systems, documentation practices, cleaning validation).',
    `audit_standard` STRING COMMENT 'Audit Standard value for the Gmp Audit record.',
    `audit_start_date` DATE COMMENT 'Date/time of Audit Start Date.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit: scheduled (planned but not started), in_progress (fieldwork underway), report_draft (findings being documented), report_issued (final report delivered), closed (all findings resolved), cancelled (audit did not proceed).. Valid values are `scheduled|in_progress|report_draft|report_issued|closed|cancelled`',
    `audit_team_members` STRING COMMENT 'Comma-separated list of additional audit team members who participated in the audit.',
    `audit_type` STRING COMMENT 'Classification of the audit based on the auditing party: internal (self-assessment), regulatory (FDA, EU authority), third-party (certification body), supplier (vendor qualification), or customer (buyer audit).. Valid values are `internal|regulatory|third_party|supplier|customer`',
    `capa_required_flag` BOOLEAN COMMENT 'Indicates whether the audit findings require formal CAPA initiation (True) or are informational only (False).',
    `closure_date` DATE COMMENT 'Date when all audit findings were resolved and the audit was formally closed.',
    `closure_status` STRING COMMENT 'Status of audit closure: open (findings not yet addressed), pending_response (awaiting facility response), under_review (response being evaluated), closed (all findings resolved), escalated (unresolved findings escalated to management or regulatory authority).. Valid values are `open|pending_response|under_review|closed|escalated`',
    `gmp_audit_code` STRING COMMENT 'Attribute code of quality.gmp_audit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the system.',
    `critical_finding_count` STRING COMMENT 'Critical Finding Count value for the Gmp Audit record.',
    `critical_findings_count` STRING COMMENT 'Number of critical findings that pose immediate risk to product quality, patient safety, or regulatory compliance.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.gmp_audit.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `gmp_audit_description` STRING COMMENT 'Attribute description of quality.gmp_audit.',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.gmp_audit.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.gmp_audit.',
    `finding_count` STRING COMMENT 'Finding Count value for the Gmp Audit record.',
    `follow_up_audit_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up audit is required to verify implementation of corrective actions (True) or not (False).',
    `follow_up_audit_scheduled_date` DATE COMMENT 'Scheduled date for the follow-up audit to verify corrective action effectiveness.',
    `gmp_audit_status` STRING COMMENT 'Attribute status of quality.gmp_audit.',
    `gmp_standard_reference` STRING COMMENT 'Reference to the GMP standard or regulation against which the audit was conducted (e.g., FDA 21 CFR Part 211, EU GMP Annex 1, ICH Q7).',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was last updated in the system.',
    `lead_auditor_name` STRING COMMENT 'Name of the lead auditor responsible for conducting and reporting the audit.',
    `major_findings_count` STRING COMMENT 'Number of major findings representing significant GMP deviations requiring corrective action.',
    `minor_findings_count` STRING COMMENT 'Number of minor findings representing opportunities for improvement without immediate compliance risk.',
    `gmp_audit_name` STRING COMMENT 'Attribute name of quality.gmp_audit.',
    `notes` STRING COMMENT 'Attribute notes of quality.gmp_audit.',
    `observation_count` STRING COMMENT 'Number of observations noted during the audit that do not constitute non-conformances but warrant attention.',
    `overall_rating` STRING COMMENT 'Summary rating assigned to the facility based on audit findings: compliant (no significant issues), acceptable (minor issues), needs_improvement (major issues requiring action), non_compliant (critical GMP violations), critical (immediate regulatory risk).. Valid values are `compliant|acceptable|needs_improvement|non_compliant|critical`',
    `planned_date` DATE COMMENT 'Date/time of Planned Date.',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.gmp_audit.',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory authority conducting the audit (e.g., FDA, EMA, MHRA, Health Canada) for regulatory audits; null for internal or third-party audits.',
    `regulatory_body` STRING COMMENT 'Regulatory Body value for the Gmp Audit record.',
    `regulatory_reference_number` STRING COMMENT 'Official reference number assigned by the regulatory authority (e.g., FDA 483 number, EMA inspection reference).',
    `response_due_date` DATE COMMENT 'Date by which the audited facility must submit a formal response to audit findings, including corrective and preventive actions (CAPA).',
    `response_submitted_date` DATE COMMENT 'Actual date when the facility submitted its formal response to the audit findings.',
    `scheduled_end_date` DATE COMMENT 'Planned end date for the audit as communicated to the facility.',
    `scheduled_start_date` DATE COMMENT 'Planned start date for the audit as communicated to the facility.',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'Source System Code value for the Gmp Audit record.',
    `total_findings_count` STRING COMMENT 'Total number of findings (observations, deviations, non-conformances) identified during the audit.',
    `uom` STRING COMMENT 'Attribute uom of quality.gmp_audit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Attribute updated_timestamp of quality.gmp_audit.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `veeva_vault_document_reference` STRING COMMENT 'Reference to the audit report document stored in Veeva Vault for regulatory document management and audit trail.',
    CONSTRAINT pk_gmp_audit PRIMARY KEY(`gmp_audit_id`)
) COMMENT 'Good Manufacturing Practice audit record covering scope, findings, ratings, and regulatory follow-up for a facility or supplier.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'Unique identifier for the audit finding record. Primary key.',
    `employee_id` BIGINT COMMENT 'Assigned To Employee Id referencing workforce.employee.employee_id.',
    `capa_id` BIGINT COMMENT 'Reference to the CAPA record initiated to address this audit finding.',
    `gmp_audit_id` BIGINT COMMENT 'Reference to the parent GMP audit event during which this finding was raised.',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Links audit findings (e.g., temperature excursions) to the specific shipment for CAPA and regulatory reporting.',
    `lot_batch_id` BIGINT COMMENT 'Reference to the specific production batch or lot impacted by the finding, if applicable.',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing facility or site where the finding was observed.',
    `previous_finding_audit_finding_id` BIGINT COMMENT 'Reference to the previous audit finding record if this is identified as a repeat finding.',
    `sku_id` BIGINT COMMENT 'Reference to the specific product or SKU (Stock Keeping Unit) impacted by the finding, if applicable.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Audit findings often relate to supplier‑provided materials; linking enables supplier performance tracking and corrective actions.',
    `affected_process_area` STRING COMMENT 'The manufacturing or quality process area where the finding was identified (e.g., Raw Material Receiving, Mixing, Filling, Packaging, Quality Control Laboratory, Warehouse).',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.audit_finding.',
    `attachment_count` STRING COMMENT 'Number of supporting documents, photos, or evidence files attached to the finding record (e.g., photos of non-conformance, lab reports, procedure documents).',
    `audit_finding_status` STRING COMMENT 'Attribute status of quality.audit_finding.',
    `auditor_name` STRING COMMENT 'Name of the auditor or inspection team member who raised the finding.',
    `auditor_organization` STRING COMMENT 'Organization or regulatory body the auditor represents (e.g., FDA, Internal QA, Third-Party Certification Body, EU Competent Authority).',
    `closed_date` DATE COMMENT 'Date/time of Closed Date.',
    `closure_approved_by` STRING COMMENT 'Name or identifier of the quality manager or authorized personnel who approved the closure of the finding.',
    `closure_date` DATE COMMENT 'Date when the audit finding was formally closed after successful verification of corrective actions.',
    `audit_finding_code` STRING COMMENT 'Attribute code of quality.audit_finding.',
    `comments` STRING COMMENT 'Additional notes, clarifications, or context provided by auditors, quality personnel, or management regarding the finding.',
    `corrective_action_required` STRING COMMENT 'Corrective Action Required value for the Audit Finding record.',
    `corrective_action_summary` STRING COMMENT 'Summary of the corrective actions taken or planned to remediate the finding and prevent recurrence.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit finding record was first created in the quality management system.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.audit_finding.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `audit_finding_description` STRING COMMENT 'Description value for the Audit Finding record.',
    `due_date` DATE COMMENT 'Date/time of Due Date.',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.audit_finding.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.audit_finding.',
    `finding_category` STRING COMMENT 'Attribute finding_category of quality.audit_finding.',
    `finding_classification` STRING COMMENT 'Severity classification of the audit finding. Critical: immediate risk to product safety or regulatory compliance; Major: significant deviation from GMP requiring prompt correction; Minor: isolated deviation with low impact; Observation: opportunity for improvement without regulatory breach.. Valid values are `critical|major|minor|observation`',
    `finding_date` DATE COMMENT 'Date when the audit finding was identified and documented during the audit.',
    `finding_description` STRING COMMENT 'Detailed narrative description of the audit finding, including observed deviation, evidence collected, and context of the non-conformance.',
    `finding_number` STRING COMMENT 'Business identifier for the audit finding, typically formatted as audit prefix followed by sequential number (e.g., FDA-000123, INT-002456).. Valid values are `^[A-Z0-9]{2,4}-[0-9]{4,6}$`',
    `finding_source_document` STRING COMMENT 'Reference to the source audit report, inspection form, or document where the finding was originally recorded.',
    `finding_status` STRING COMMENT 'Current lifecycle status of the audit finding in the remediation workflow.. Valid values are `open|under_review|capa_initiated|pending_verification|closed|overdue`',
    `finding_title` STRING COMMENT 'Brief summary title of the audit finding for quick identification and reporting.',
    `finding_type` STRING COMMENT 'Finding Type value for the Audit Finding record.',
    `identified_date` DATE COMMENT 'Date/time of Identified Date.',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified the audit finding record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit finding record was last updated or modified.',
    `audit_finding_name` STRING COMMENT 'Attribute name of quality.audit_finding.',
    `notes` STRING COMMENT 'Attribute notes of quality.audit_finding.',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.audit_finding.',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `regulatory_reference` STRING COMMENT 'Citation of the specific regulatory requirement, GMP guideline, or standard that was violated or not met (e.g., 21 CFR 211.100, EU GMP Chapter 4, ISO 22716 Section 5.3).',
    `regulatory_report_date` DATE COMMENT 'Date when the finding was formally reported to the regulatory authority, if applicable.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this finding must be reported to regulatory authorities such as FDA (Food and Drug Administration) or EU competent authorities per regulatory requirements.',
    `regulatory_response_received_date` DATE COMMENT 'Date when a formal response or acknowledgment was received from the regulatory authority regarding the reported finding.',
    `repeat_finding_flag` BOOLEAN COMMENT 'Indicates whether this finding is a repeat observation from a previous audit, suggesting ineffective corrective action or systemic issue.',
    `requirement_reference` STRING COMMENT 'Requirement Reference value for the Audit Finding record.',
    `response_due_date` DATE COMMENT 'Deadline by which the organization must submit a formal response or corrective action plan to address the finding.',
    `response_submitted_date` DATE COMMENT 'Date when the formal response or corrective action plan was submitted to the auditor or regulatory authority.',
    `responsible_department` STRING COMMENT 'Department or functional area responsible for implementing corrective actions and resolving the finding (e.g., Manufacturing, Quality Assurance, Quality Control (QC), Supply Chain).',
    `responsible_person` STRING COMMENT 'Name or identifier of the individual assigned ownership for addressing the finding and implementing corrective actions.',
    `risk_level` STRING COMMENT 'Risk assessment level assigned to the finding based on potential impact to product quality, patient safety, or regulatory compliance.. Valid values are `high|medium|low`',
    `root_cause_summary` STRING COMMENT 'Summary of the root cause analysis conducted to determine the underlying reason for the finding.',
    `severity` STRING COMMENT 'Severity value for the Audit Finding record.',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'Source System Code value for the Audit Finding record.',
    `uom` STRING COMMENT 'Attribute uom of quality.audit_finding.',
    `updated_timestamp` TIMESTAMP COMMENT 'Attribute updated_timestamp of quality.audit_finding.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `verification_date` DATE COMMENT 'Date when the corrective action effectiveness was verified and the finding was confirmed as resolved.',
    `verification_method` STRING COMMENT 'Method used to verify the effectiveness of corrective actions (e.g., follow-up audit, document review, process validation, trend analysis).',
    `verified_by` STRING COMMENT 'Name or identifier of the quality assurance personnel or auditor who verified the corrective action effectiveness.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created the audit finding record in the system.',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Individual finding, observation, or nonconformity raised during a quality or GMP audit, including severity, evidence, and remediation status.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` (
    `supplier_assessment_id` BIGINT COMMENT 'Primary key for supplier_assessment',
    `previous_assessment_supplier_assessment_id` BIGINT COMMENT 'Reference to the prior supplier quality assessment record for tracking assessment history and trends.',
    `employee_id` BIGINT COMMENT 'Identifier of the quality professional who led the supplier assessment.',
    `supplier_assessor_employee_id` BIGINT COMMENT 'Assessor Employee Id referencing workforce.employee.employee_id.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier being assessed for quality performance.',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.supplier_assessment.',
    `approval_status` STRING COMMENT 'Approval decision resulting from the quality assessment, determining the suppliers eligibility for business.. Valid values are `approved|conditional|disqualified|pending_review|suspended`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the assessment results and supplier status decision were formally approved.',
    `approval_valid_from_date` DATE COMMENT 'Effective start date of the supplier approval status resulting from this assessment.',
    `approval_valid_to_date` DATE COMMENT 'Expiration date of the supplier approval status, after which re-assessment is required.',
    `approved_by_name` STRING COMMENT 'Full name of the quality manager who approved the supplier assessment outcome.',
    `asl_status` STRING COMMENT 'Current status of the supplier on the Approved Supplier List based on this assessment outcome.. Valid values are `active|conditional|blocked|expired|pending`',
    `assessment_comments` STRING COMMENT 'Additional notes, observations, or context provided by the assessment team regarding the supplier evaluation.',
    `assessment_date` DATE COMMENT 'Date when the supplier quality assessment was conducted or completed.',
    `assessment_frequency_months` STRING COMMENT 'Number of months between required assessments for this supplier based on risk rating and business criticality.',
    `assessment_method` STRING COMMENT 'Method or approach used to conduct the supplier quality assessment.. Valid values are `onsite_audit|remote_audit|document_review|questionnaire|third_party_certification|hybrid`',
    `assessment_number` STRING COMMENT 'Business identifier for the supplier quality assessment, typically generated by the quality management system.',
    `assessment_report_reference` STRING COMMENT 'Document identifier for the detailed supplier quality assessment report stored in the document management system.',
    `assessment_scope` STRING COMMENT 'Description of the scope of the assessment including materials, processes, facilities, or systems evaluated.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the supplier quality assessment process.. Valid values are `scheduled|in_progress|completed|approved|rejected|on_hold`',
    `assessment_team_members` STRING COMMENT 'Comma-separated list of team members who participated in the supplier quality assessment.',
    `assessment_type` STRING COMMENT 'Category of supplier quality assessment indicating the trigger or purpose of the evaluation.. Valid values are `initial_qualification|periodic_requalification|for_cause_audit|regulatory_triggered|risk_based_review|new_material_qualification`',
    `capa_due_date` DATE COMMENT 'Deadline by which the supplier must submit their CAPA response to address identified deficiencies.',
    `capa_required_flag` BOOLEAN COMMENT 'Indicates whether the supplier is required to submit a CAPA plan to address assessment findings.',
    `certification_status` STRING COMMENT 'Third-party certification status of the supplier relevant to quality and compliance standards.. Valid values are `iso_9001_certified|iso_22716_certified|fsc_certified|rspo_certified|not_certified|certification_expired`',
    `supplier_assessment_code` STRING COMMENT 'Attribute code of quality.supplier_assessment.',
    `comments` STRING COMMENT 'Comments value for the Supplier Assessment record.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Compliance Score value for the Supplier Assessment record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the supplier quality assessment record was first created in the system.',
    `critical_findings_count` STRING COMMENT 'Number of critical non-conformances or major deficiencies identified during the assessment.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.supplier_assessment.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `delivery_score` DECIMAL(18,2) COMMENT 'Delivery Score value for the Supplier Assessment record.',
    `supplier_assessment_description` STRING COMMENT 'Attribute description of quality.supplier_assessment.',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.supplier_assessment.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.supplier_assessment.',
    `facility_location` STRING COMMENT 'Geographic location or address of the supplier facility that was assessed.',
    `gmp_compliance_score` DECIMAL(18,2) COMMENT 'Score evaluating the suppliers adherence to Good Manufacturing Practice standards and requirements.',
    `improvement_trend` STRING COMMENT 'Trend indicator comparing current assessment results to previous evaluations.. Valid values are `improving|stable|declining|first_assessment`',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `is_approved` BOOLEAN COMMENT 'Boolean indicator for Is Approved.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the supplier quality assessment record was last updated.',
    `lead_assessor_name` STRING COMMENT 'Full name of the lead quality assessor responsible for conducting the evaluation.',
    `major_findings_count` STRING COMMENT 'Number of major non-conformances identified during the supplier assessment.',
    `material_categories_assessed` STRING COMMENT 'Comma-separated list of material categories or product types covered in this supplier assessment.',
    `minor_findings_count` STRING COMMENT 'Number of minor non-conformances or observations identified during the assessment.',
    `supplier_assessment_name` STRING COMMENT 'Attribute name of quality.supplier_assessment.',
    `next_assessment_date` DATE COMMENT 'Date/time of Next Assessment Date.',
    `next_assessment_due_date` DATE COMMENT 'Scheduled date for the next periodic supplier quality assessment.',
    `notes` STRING COMMENT 'Attribute notes of quality.supplier_assessment.',
    `overall_score` DECIMAL(18,2) COMMENT 'Composite numerical score representing the suppliers overall quality performance across all evaluation criteria.',
    `quality_score` DECIMAL(18,2) COMMENT 'Quality Score value for the Supplier Assessment record.',
    `quality_system_score` DECIMAL(18,2) COMMENT 'Score assessing the maturity and effectiveness of the suppliers quality management system.',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.supplier_assessment.',
    `rating` STRING COMMENT 'Rating value for the Supplier Assessment record.',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `regulatory_compliance_score` DECIMAL(18,2) COMMENT 'Score evaluating the suppliers compliance with applicable regulatory requirements including FDA, EPA, REACH, and other governing body standards.',
    `risk_rating` STRING COMMENT 'Risk classification assigned to the supplier based on assessment findings, indicating the level of quality and compliance risk.. Valid values are `low|medium|high|critical`',
    `score_scale_max` DECIMAL(18,2) COMMENT 'Maximum possible score on the assessment scale used for this evaluation.',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'Source System Code value for the Supplier Assessment record.',
    `supplier_assessment_status` STRING COMMENT 'Attribute status of quality.supplier_assessment.',
    `uom` STRING COMMENT 'Attribute uom of quality.supplier_assessment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Attribute updated_timestamp of quality.supplier_assessment.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    CONSTRAINT pk_supplier_assessment PRIMARY KEY(`supplier_assessment_id`)
) COMMENT 'Quality assessment of a supplier covering qualification, scorecards, audit outcomes, and risk classification.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` (
    `product_complaint_id` BIGINT COMMENT 'Unique identifier for the product complaint record. Primary key.',
    `action_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_action. Business justification: When a complaint triggers enforcement, a regulatory action is opened; linking enables tracking complaint to action.',
    `capa_id` BIGINT COMMENT 'Identifier linking this complaint to a formal CAPA record if one was initiated.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Financial impact of product complaints is allocated to a cost center for cost‑of‑quality reporting.',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Associates customer complaints with the originating shipment for traceability, recall decisions, and service recovery.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Customer complaints must be tied to the exact lot batch to assess impact, trigger investigations, and manage recalls.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand Complaint Dashboard requires linking complaints to the brand to monitor reputation and adjust campaigns.',
    `outbound_order_line_id` BIGINT COMMENT 'Foreign key linking to distribution.outbound_order_line. Business justification: Required for complaint traceability: product complaint must reference the outbound order line that delivered the product, allowing root cause analysis and customer service reporting.',
    `employee_id` BIGINT COMMENT 'Assigned To Employee Id referencing workforce.employee.employee_id.',
    `product_handled_by_employee_id` BIGINT COMMENT 'Attribute handled_by_employee_id of workforce.product_complaint.',
    `product_handler_employee_id` BIGINT COMMENT 'Attribute handler_employee_id of workforce.product_complaint.',
    `product_investigation_assigned_employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Complaint Investigation Assignment links each complaint to the responsible investigator employee for tracking and regulatory reporting.',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: Store‑level complaint tracking required for quality investigations and performance dashboards; linking complaints to the retail store where purchase occurred is standard in consumer‑goods.',
    `shopper_id` BIGINT COMMENT 'Foreign key linking to consumer.shopper. Business justification: Complaint handling process requires linking each product complaint to the shopper who reported it for traceability and regulatory reporting.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Complaints are investigated per SKU; linking enables root‑cause analysis, corrective actions, and compliance reporting.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Complaints must be tied to the responsible supplier for performance monitoring and regulatory reporting.',
    `trade_account_id` BIGINT COMMENT 'Identifier of the retail or trade account where the product was purchased, if applicable.',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.product_complaint.',
    `batch_number` STRING COMMENT 'Attribute batch_number of quality.product_complaint.',
    `closed_date` DATE COMMENT 'Date/time of Closed Date.',
    `closure_date` DATE COMMENT 'Attribute closure_date of quality.product_complaint.',
    `product_complaint_code` STRING COMMENT 'Attribute code of quality.product_complaint.',
    `complainant_address` STRING COMMENT 'Mailing address of the complainant for correspondence and product sample return.',
    `complainant_contact` STRING COMMENT 'Attribute complainant_contact of quality.product_complaint.',
    `complainant_country_code` STRING COMMENT 'Three-letter ISO country code of the complainant location.. Valid values are `^[A-Z]{3}$`',
    `complainant_email` STRING COMMENT 'Email address of the complainant for follow-up communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `complainant_name` STRING COMMENT 'Full name of the individual or organization filing the complaint.',
    `complainant_phone` STRING COMMENT 'Contact phone number of the complainant.',
    `complaint_category` STRING COMMENT 'Primary classification of the complaint type based on the nature of the quality issue reported.. Valid values are `foreign_body|contamination|labeling_error|efficacy_failure|packaging_defect|adverse_reaction`',
    `complaint_description` STRING COMMENT 'Detailed narrative description of the complaint as reported by the complainant, including symptoms, observations, and circumstances.',
    `complaint_number` STRING COMMENT 'Externally-visible unique complaint reference number used for tracking and communication with consumers and regulatory bodies.. Valid values are `^CPL-[0-9]{8}$`',
    `complaint_received_timestamp` TIMESTAMP COMMENT 'Date and time when the complaint was first received by the organization.',
    `complaint_source` STRING COMMENT 'Origin channel through which the complaint was received.. Valid values are `consumer_direct|retailer|distributor|regulatory_agency|social_media|call_center`',
    `complaint_status` STRING COMMENT 'Current lifecycle state of the complaint investigation and resolution process.. Valid values are `open|under_investigation|pending_lab_analysis|resolved|closed|escalated`',
    `complaint_subcategory` STRING COMMENT 'Detailed sub-classification providing additional granularity to the complaint category.',
    `complaint_type` STRING COMMENT 'Complaint Type value for the Product Complaint record.',
    `corrective_action` STRING COMMENT 'Description of corrective actions taken to address the immediate complaint.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the complaint record was first created in the system.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.product_complaint.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `product_complaint_description` STRING COMMENT 'Description value for the Product Complaint record.',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.product_complaint.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.product_complaint.',
    `expiry_date` DATE COMMENT 'Product expiration or best-before date printed on the package.',
    `gtin` STRING COMMENT 'Global Trade Item Number uniquely identifying the product in the supply chain.. Valid values are `^[0-9]{8}$|^[0-9]{12}$|^[0-9]{13}$|^[0-9]{14}$`',
    `incident_date` DATE COMMENT 'Date when the consumer or customer experienced the quality issue or adverse event.',
    `investigation_completion_date` DATE COMMENT 'Date when the investigation was concluded and findings documented.',
    `investigation_outcome` STRING COMMENT 'Attribute investigation_outcome of quality.product_complaint.',
    `investigation_start_date` DATE COMMENT 'Date when the formal investigation of the complaint was initiated.',
    `investigation_status` STRING COMMENT 'Current state of the internal quality investigation process.. Valid values are `not_started|in_progress|lab_testing|pending_capa|completed`',
    `investigation_summary` STRING COMMENT 'Attribute investigation_summary of quality.product_complaint.',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `is_adverse_event` BOOLEAN COMMENT 'Boolean indicator for Is Adverse Event.',
    `is_reportable` BOOLEAN COMMENT 'Attribute is_reportable of quality.product_complaint.',
    `lab_analysis_result` STRING COMMENT 'Summary of laboratory test results conducted on the returned product sample.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the complaint record was last updated.',
    `lot_number` STRING COMMENT 'Lot Number value for the Product Complaint record.',
    `manufacturing_date` DATE COMMENT 'Date when the product batch was manufactured.',
    `product_complaint_name` STRING COMMENT 'Attribute name of quality.product_complaint.',
    `notes` STRING COMMENT 'Attribute notes of quality.product_complaint.',
    `preventive_action` STRING COMMENT 'Description of preventive actions implemented to prevent recurrence of similar issues.',
    `priority` STRING COMMENT 'Attribute priority of quality.product_complaint.',
    `product_complaint_status` STRING COMMENT 'Attribute status of quality.product_complaint.',
    `product_name` STRING COMMENT 'Attribute product_name of quality.product_complaint.',
    `purchase_date` DATE COMMENT 'Date when the complainant purchased the product.',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.product_complaint.',
    `received_date` DATE COMMENT 'Date/time of Received Date.',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `regulatory_agency` STRING COMMENT 'Name of the regulatory agency to which the complaint was reported (e.g., FDA, EPA, CPSC).',
    `regulatory_case_number` STRING COMMENT 'Case or reference number assigned by the regulatory agency for tracking purposes.',
    `regulatory_report_date` DATE COMMENT 'Date when the complaint was reported to the relevant regulatory authority.',
    `regulatory_reportable` BOOLEAN COMMENT 'Boolean indicator for Regulatory Reportable.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this complaint must be reported to regulatory authorities such as FDA, EPA, or CPSC.',
    `resolution` STRING COMMENT 'Resolution value for the Product Complaint record.',
    `resolution_date` DATE COMMENT 'Date when the complaint was resolved and closed.',
    `resolution_outcome` STRING COMMENT 'Final outcome or action taken to resolve the complaint with the complainant.. Valid values are `refund_issued|replacement_sent|no_action_required|product_recall|investigation_ongoing`',
    `root_cause` STRING COMMENT 'Identified root cause of the quality issue based on investigation findings.',
    `sample_received_date` DATE COMMENT 'Date when the returned product sample was received by the quality assurance team.',
    `sample_returned_flag` BOOLEAN COMMENT 'Indicates whether the complainant returned a physical product sample for laboratory analysis.',
    `severity` STRING COMMENT 'Severity value for the Product Complaint record.',
    `severity_level` STRING COMMENT 'Risk classification indicating the potential impact to consumer safety and business reputation.. Valid values are `critical|high|medium|low`',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'Source System Code value for the Product Complaint record.',
    `uom` STRING COMMENT 'Attribute uom of quality.product_complaint.',
    `updated_timestamp` TIMESTAMP COMMENT 'Attribute updated_timestamp of quality.product_complaint.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    CONSTRAINT pk_product_complaint PRIMARY KEY(`product_complaint_id`)
) COMMENT 'Consumer or customer product complaint record with investigation, classification, and regulatory reportability tracking.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` (
    `regulatory_hold_id` BIGINT COMMENT 'Unique identifier for the regulatory hold event record. Primary key.',
    `capa_id` BIGINT COMMENT 'Identifier linking this regulatory hold to a CAPA record initiated to address the root cause.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Regulatory hold financial impact is charged to a cost center for compliance cost tracking.',
    `employee_id` BIGINT COMMENT 'Initiated By Employee Id referencing workforce.employee.employee_id.',
    `inspection_lot_id` BIGINT COMMENT 'Attribute inspection_lot_id of quality.regulatory_hold.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Regulatory holds are placed on specific lot batches; linking ensures hold status propagates to inventory and reporting.',
    `manufacturing_facility_id` BIGINT COMMENT 'Identifier for the manufacturing facility or distribution center where the affected product or material is located.',
    `nonconformance_id` BIGINT COMMENT 'Attribute nonconformance_id of quality.regulatory_hold.',
    `product_complaint_id` BIGINT COMMENT 'Identifier linking this regulatory hold to a consumer or customer complaint that triggered the investigation.',
    `product_recall_id` BIGINT COMMENT 'Identifier linking this regulatory hold to a product recall event if the hold escalated to a recall.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Regulatory holds are applied to specific SKUs; FK supports hold management, release decisions, and audit trails.',
    `supplier_id` BIGINT COMMENT 'Identifier for the supplier associated with the affected material or product, if the hold is supplier-related.',
    `actual_release_date` DATE COMMENT 'The actual date when the regulatory hold was lifted and the affected product, batch, or material was released or dispositioned.',
    `actual_release_timestamp` TIMESTAMP COMMENT 'The precise date and time when the regulatory hold was lifted and the affected product, batch, or material was released or dispositioned.',
    `affected_material_code` STRING COMMENT 'The raw material or component code placed under regulatory hold. May be null if hold applies to finished goods.',
    `affected_quantity` DECIMAL(18,2) COMMENT 'The total quantity of product, batch, or material placed under regulatory hold.',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.regulatory_hold.',
    `batch_number` STRING COMMENT 'Attribute batch_number of quality.regulatory_hold.',
    `regulatory_hold_code` STRING COMMENT 'Attribute code of quality.regulatory_hold.',
    `comments` STRING COMMENT 'Comments value for the Regulatory Hold record.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this regulatory hold record was first created in the system.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.regulatory_hold.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `regulatory_hold_description` STRING COMMENT 'Attribute description of quality.regulatory_hold.',
    `disposition` STRING COMMENT 'Disposition value for the Regulatory Hold record.',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.regulatory_hold.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.regulatory_hold.',
    `expected_release_date` DATE COMMENT 'The anticipated date when the regulatory hold review and assessment is expected to be completed and a release decision made.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact of the regulatory hold event, including inventory value, disposal costs, and business disruption.',
    `financial_impact_currency` STRING COMMENT 'The currency code for the financial impact amount, following ISO 4217 standard. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|CAD|AUD — 7 candidates stripped; promote to reference product]',
    `held_quantity` DECIMAL(18,2) COMMENT 'Held Quantity value for the Regulatory Hold record.',
    `held_quantity_uom` STRING COMMENT 'Attribute held_quantity_uom of quality.regulatory_hold.',
    `hold_date` DATE COMMENT 'Attribute hold_date of quality.regulatory_hold.',
    `hold_description` STRING COMMENT 'Attribute hold_description of quality.regulatory_hold.',
    `hold_duration_days` STRING COMMENT 'The total number of calendar days the regulatory hold was in effect, from start to release.',
    `hold_notes` STRING COMMENT 'Additional notes, observations, and context related to the regulatory hold event, investigation, and resolution.',
    `hold_number` STRING COMMENT 'Business identifier for the regulatory hold event, formatted as RH- followed by 8 digits. Used for external communication and tracking.. Valid values are `^RH-[0-9]{8}$`',
    `hold_reason` STRING COMMENT 'Hold Reason value for the Regulatory Hold record.',
    `hold_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for placing the product under regulatory hold. [ENUM-REF-CANDIDATE: contamination|labeling_error|stability_failure|microbial_excursion|foreign_material|potency_deviation|regulatory_inspection|consumer_complaint|supplier_issue — 9 candidates stripped; promote to reference product]',
    `hold_reason_description` STRING COMMENT 'Detailed narrative explanation of the circumstances and findings that led to the regulatory hold decision.',
    `hold_release_date` DATE COMMENT 'Date/time of Hold Release Date.',
    `hold_scope` STRING COMMENT 'The level at which the regulatory hold is applied, defining the breadth of affected inventory or operations.. Valid values are `batch|sku|material|facility|supplier|product_line`',
    `hold_start_date` DATE COMMENT 'The date when the regulatory hold was officially placed and became effective.',
    `hold_start_timestamp` TIMESTAMP COMMENT 'The precise date and time when the regulatory hold was officially placed and became effective.',
    `hold_status` STRING COMMENT 'Current lifecycle status of the regulatory hold event indicating its progression through the review and release process.. Valid values are `active|under_review|pending_release|released|extended|escalated`',
    `hold_type` STRING COMMENT 'Classification of the regulatory hold event indicating the nature and origin of the hold decision.. Valid values are `voluntary|regulatory_mandated|precautionary|recall_related|safety_assessment|quality_investigation`',
    `initiating_authority` STRING COMMENT 'The organization or entity that initiated or mandated the regulatory hold event. [ENUM-REF-CANDIDATE: FDA|CPSC|EPA|internal_qa|internal_regulatory|supplier|customer|third_party_lab — 8 candidates stripped; promote to reference product]',
    `initiating_authority_reference` STRING COMMENT 'External reference number or case identifier provided by the initiating regulatory authority or organization.',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this regulatory hold record was last updated or modified.',
    `regulatory_hold_name` STRING COMMENT 'Attribute name of quality.regulatory_hold.',
    `notes` STRING COMMENT 'Attribute notes of quality.regulatory_hold.',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.regulatory_hold.',
    `quantity_unit` STRING COMMENT 'The unit of measure for the affected quantity (EA=Each, CS=Case, KG=Kilogram, LB=Pound, L=Liter, GAL=Gallon, MT=Metric Ton). [ENUM-REF-CANDIDATE: EA|CS|KG|LB|L|GAL|MT — 7 candidates stripped; promote to reference product]',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `regulatory_authority` STRING COMMENT 'Attribute regulatory_authority of quality.regulatory_hold.',
    `regulatory_body` STRING COMMENT 'Regulatory Body value for the Regulatory Hold record.',
    `regulatory_hold_status` STRING COMMENT 'Attribute status of quality.regulatory_hold.',
    `regulatory_notification_date` DATE COMMENT 'The date when the regulatory authority was formally notified of the hold event.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Indicates whether this regulatory hold event requires formal notification to external regulatory authorities.',
    `release_authorization_name` STRING COMMENT 'The full name of the authorized individual who approved the release or disposition of the regulatory hold.',
    `release_authorization_title` STRING COMMENT 'The job title or role of the individual who authorized the release or disposition decision.',
    `release_date` DATE COMMENT 'Attribute release_date of quality.regulatory_hold.',
    `release_decision` STRING COMMENT 'The final disposition decision made for the product, batch, or material under regulatory hold.. Valid values are `released_approved|rejected_destroyed|reworked|relabeled|downgraded|returned_to_supplier`',
    `release_justification` STRING COMMENT 'Detailed explanation and supporting evidence for the release or disposition decision, including test results and risk assessment findings.',
    `release_reason` STRING COMMENT 'Attribute release_reason of quality.regulatory_hold.',
    `released_by` STRING COMMENT 'Attribute released_by of quality.regulatory_hold.',
    `risk_level` STRING COMMENT 'The assessed risk level of the regulatory hold event based on potential consumer safety impact and regulatory exposure.. Valid values are `critical|high|medium|low`',
    `sap_qm_notification_number` STRING COMMENT 'The SAP QM notification number associated with this regulatory hold event for traceability to the source ERP system.',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'Source System Code value for the Regulatory Hold record.',
    `uom` STRING COMMENT 'Attribute uom of quality.regulatory_hold.',
    `updated_timestamp` TIMESTAMP COMMENT 'Attribute updated_timestamp of quality.regulatory_hold.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `veeva_vault_document_reference` STRING COMMENT 'Reference identifier for the regulatory hold documentation stored in Veeva Vault quality document management system.',
    CONSTRAINT pk_regulatory_hold PRIMARY KEY(`regulatory_hold_id`)
) COMMENT 'Regulatory or quality hold record restricting use, shipment, or release of affected inventory pending disposition.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`specification` (
    `specification_id` BIGINT COMMENT 'Unique identifier for the quality specification record. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Approved By Employee Id referencing workforce.employee.employee_id.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Each quality specification must satisfy a compliance obligation; linking ensures traceability to the governing regulation.',
    `primary_specification_approved_by_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `product_formulation_id` BIGINT COMMENT 'Attribute product_formulation_id of product.specification.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Specifications are developed within an R&D project; linking ties each spec to its originating project for governance.',
    `sku_id` BIGINT COMMENT 'Reference to the material or product this specification applies to. Links to the master material record in SAP MM.',
    `specification_sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Quality specifications are defined per SKU to ensure manufacturing compliance and product release criteria.',
    `superseded_by_specification_id` BIGINT COMMENT 'Reference to the newer specification that replaces this one when status is superseded. Maintains specification version lineage.',
    `inspection_plan_id` BIGINT COMMENT 'Reference to the SAP QM inspection plan that uses this specification. Links specification to operational quality control procedures.',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.specification.',
    `approval_date` DATE COMMENT 'Date when this specification was formally approved for use. Part of the specification lifecycle audit trail.',
    `specification_category` STRING COMMENT 'High-level classification of the type of quality attribute being specified. Groups related test characteristics for reporting and analysis.. Valid values are `physical|chemical|microbiological|sensory|functional|safety`',
    `coa_inclusion_flag` BOOLEAN COMMENT 'Indicates whether test results for this specification must be included on the Certificate of Analysis provided to customers. Drives CoA generation logic.',
    `specification_code` STRING COMMENT 'Attribute code of quality.specification.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this specification record was first created in the system. Part of the audit trail for compliance and traceability.',
    `critical_quality_attribute_flag` BOOLEAN COMMENT 'Indicates whether this characteristic is a Critical Quality Attribute that directly impacts product safety, efficacy, or regulatory compliance. CQAs require enhanced controls and documentation.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.specification.',
    `customer_requirement_flag` BOOLEAN COMMENT 'Indicates whether this specification is driven by specific customer contractual requirements rather than internal or regulatory standards.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `specification_description` STRING COMMENT 'Attribute description of quality.specification.',
    `effective_date` DATE COMMENT 'Date/time of Effective Date.',
    `effective_end_date` DATE COMMENT 'The date after which this specification is no longer valid. Null indicates an open-ended specification. Used for specification versioning and supersession.',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.specification.',
    `effective_start_date` DATE COMMENT 'The date from which this specification becomes valid and must be used for quality control testing. Supports time-based specification management.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.specification.',
    `expiry_date` DATE COMMENT 'Date/time of Expiry Date.',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this specification record was last updated. Tracks change history for audit and compliance purposes.',
    `lower_limit` DECIMAL(18,2) COMMENT 'Lower Limit value for the Specification record.',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Attribute lower_spec_limit of quality.specification.',
    `lower_specification_limit` DECIMAL(18,2) COMMENT 'The minimum acceptable value for the test characteristic. Results below this limit indicate non-conformance.',
    `material_type` STRING COMMENT 'Attribute material_type of quality.specification.',
    `specification_name` STRING COMMENT 'Attribute name of quality.specification.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this specification. Used for compliance tracking and specification maintenance planning.',
    `notes` STRING COMMENT 'Additional context, special instructions, or clarifications related to this specification. May include testing conditions, sample preparation requirements, or interpretation guidance.',
    `parameter_name` STRING COMMENT 'Parameter Name value for the Specification record.',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.specification.',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `regulatory_basis` STRING COMMENT 'Regulatory Basis value for the Specification record.',
    `review_frequency_months` STRING COMMENT 'How often this specification must be reviewed and revalidated, expressed in months. Ensures specifications remain current and appropriate.',
    `revision_number` STRING COMMENT 'Attribute revision_number of quality.specification.',
    `sampling_plan` STRING COMMENT 'Description of the sampling methodology and sample size requirements for this test (e.g., AQL 2.5, n=10, ANSI/ASQ Z1.4). Ensures statistical validity of test results.',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'Source System Code value for the Specification record.',
    `spec_category` STRING COMMENT 'Attribute spec_category of quality.specification.',
    `spec_code` STRING COMMENT 'Spec Code value for the Specification record.',
    `spec_name` STRING COMMENT 'Spec Name value for the Specification record.',
    `spec_number` STRING COMMENT 'Attribute spec_number of quality.specification.',
    `spec_status` STRING COMMENT 'Spec Status value for the Specification record.',
    `spec_type` STRING COMMENT 'Spec Type value for the Specification record.',
    `specification_number` STRING COMMENT 'Business identifier for the quality specification, used for external reference and documentation. Unique across the organization.. Valid values are `^[A-Z0-9]{6,20}$`',
    `specification_status` STRING COMMENT 'Current lifecycle status of the specification. Only active specifications are used for quality control and Certificate of Analysis (CoA) generation.. Valid values are `draft|under_review|approved|active|superseded|obsolete`',
    `specification_type` STRING COMMENT 'Classification of the specification based on the material or product stage it applies to. Determines the applicable quality control procedures.. Valid values are `raw_material|packaging_material|in_process|finished_good|intermediate|bulk`',
    `stability_indicating_flag` BOOLEAN COMMENT 'Indicates whether this test characteristic is used in stability studies to monitor product degradation over time. Critical for shelf-life determination.',
    `target_value` DECIMAL(18,2) COMMENT 'The ideal or nominal value for the test characteristic. Represents the center point of the acceptable range.',
    `test_characteristic` STRING COMMENT 'The specific quality attribute or property being measured or tested (e.g., pH, viscosity, color, weight, purity, microbial count). Defines what is being inspected.',
    `test_equipment_required` STRING COMMENT 'Description of specialized equipment or instrumentation needed to perform this test (e.g., HPLC, spectrophotometer, viscometer). Supports resource planning and capability assessment.',
    `test_frequency` STRING COMMENT 'How often this test characteristic must be measured during production or quality control. Drives inspection plan scheduling. [ENUM-REF-CANDIDATE: per_batch|per_lot|hourly|daily|weekly|monthly|on_demand — 7 candidates stripped; promote to reference product]',
    `test_method` STRING COMMENT 'Test Method value for the Specification record.',
    `test_method_reference` STRING COMMENT 'Reference to the standard test method or procedure used to measure the characteristic (e.g., ASTM D1475, USP 621, internal SOP number). Ensures consistent testing methodology.',
    `unit_of_measure` STRING COMMENT 'The unit in which the test characteristic is measured (e.g., mg/L, %, pH units, cP, CFU/g). Critical for interpreting specification limits.',
    `uom` STRING COMMENT 'Uom value for the Specification record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Attribute updated_timestamp of quality.specification.',
    `upper_limit` DECIMAL(18,2) COMMENT 'Upper Limit value for the Specification record.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Attribute upper_spec_limit of quality.specification.',
    `upper_specification_limit` DECIMAL(18,2) COMMENT 'The maximum acceptable value for the test characteristic. Results above this limit indicate non-conformance.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `veeva_vault_document_reference` STRING COMMENT 'Reference to the controlled document in Veeva Vault that contains the full specification details and supporting documentation. Ensures document control and regulatory compliance.',
    `version` STRING COMMENT 'Version number of the specification to track revisions and changes over time. Follows major.minor versioning convention.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    `version_number` STRING COMMENT 'Version Number value for the Specification record.',
    CONSTRAINT pk_specification PRIMARY KEY(`specification_id`)
) COMMENT 'Authoritative quality specification defining acceptance criteria, methods, and limits for a material or product characteristic.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` (
    `lab_test_request_id` BIGINT COMMENT 'Unique identifier for the laboratory test request record. Primary key.',
    `inspection_lot_id` BIGINT COMMENT 'Inspection Lot Id referencing quality.inspection_lot.inspection_lot_id.',
    `employee_id` BIGINT COMMENT 'Requested By Employee Id referencing workforce.employee.employee_id.',
    `lab_requestor_employee_id` BIGINT COMMENT 'Employee identifier of the individual who submitted the laboratory test request.',
    `laboratory_id` BIGINT COMMENT 'Laboratory Id referencing quality.laboratory.laboratory_id.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key reference to the production lot or batch associated with this test request. Links to inventory.lot_batch.',
    `quality_stability_study_id` BIGINT COMMENT 'Identifier linking this test request to a formal stability study protocol for shelf-life determination and expiry date validation.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Lab test requests are issued for a specific SKU to verify formulation and compliance before release.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Lab test requests need supplier identification to assess supplier quality impact; supplier_code is replaced by FK to supplier.',
    `sample_id` BIGINT COMMENT 'Attribute sample_id of quality.lab_test_request.',
    `actual_turnaround_time_hours` DECIMAL(18,2) COMMENT 'Measured elapsed time in hours from request submission to result receipt. Used for laboratory performance monitoring and Service Level Agreement (SLA) compliance.',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.lab_test_request.',
    `assigned_lab_code` STRING COMMENT 'Code identifying the internal or external laboratory facility assigned to perform the testing.',
    `assigned_lab_name` STRING COMMENT 'Full name of the laboratory facility assigned to perform the testing (internal QC lab or external contract lab).',
    `cancellation_reason` STRING COMMENT 'Business justification if the laboratory test request was cancelled before completion (e.g., sample compromised, request duplicate, business decision changed).',
    `lab_test_request_code` STRING COMMENT 'Attribute code of quality.lab_test_request.',
    `comments` STRING COMMENT 'Comments value for the Lab Test Request record.',
    `completed_date` DATE COMMENT 'Date/time of Completed Date.',
    `completion_date` DATE COMMENT 'Attribute completion_date of quality.lab_test_request.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this laboratory test request record was first created in the quality management system.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.lab_test_request.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `lab_test_request_description` STRING COMMENT 'Attribute description of quality.lab_test_request.',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.lab_test_request.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.lab_test_request.',
    `gmp_compliant_flag` BOOLEAN COMMENT 'Indicates whether this laboratory test must be performed under Good Manufacturing Practice (GMP) conditions with full documentation and traceability for regulatory submission.',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `lab_assignment_timestamp` TIMESTAMP COMMENT 'Date and time when the test request was assigned to a specific laboratory facility and analyst.',
    `lab_test_request_status` STRING COMMENT 'Attribute status of quality.lab_test_request.',
    `lab_type` STRING COMMENT 'Classification of the assigned laboratory as internal company facility, external third-party lab, or contract testing organization.. Valid values are `internal|external|contract`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this laboratory test request record was most recently updated.',
    `manufacturing_site_code` STRING COMMENT 'Code identifying the production facility where the material being tested was manufactured.',
    `material_code` STRING COMMENT 'SAP material master code identifying the product, raw material, or packaging component being tested.',
    `material_description` STRING COMMENT 'Business description of the material being tested for human-readable identification.',
    `lab_test_request_name` STRING COMMENT 'Attribute name of quality.lab_test_request.',
    `notes` STRING COMMENT 'Attribute notes of quality.lab_test_request.',
    `priority` STRING COMMENT 'Priority value for the Lab Test Request record.',
    `priority_level` STRING COMMENT 'Business priority assigned to the test request determining turnaround time and resource allocation. Critical and regulatory priorities receive expedited processing.. Valid values are `routine|urgent|critical|regulatory`',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.lab_test_request.',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body requiring this test (e.g., FDA, EPA, EU Commission, Health Canada) if regulatory_requirement_flag is true.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this laboratory test is mandated by regulatory authority (FDA, EPA, EU REACH) for product registration, batch release, or ongoing compliance.',
    `request_notes` STRING COMMENT 'Free-text field for additional context, special instructions, or background information relevant to the laboratory test request.',
    `request_number` STRING COMMENT 'Business identifier for the laboratory test request, typically formatted as LTR-YYYYNNNN for external reference and tracking.. Valid values are `^LTR-[0-9]{8}$`',
    `request_status` STRING COMMENT 'Current lifecycle status of the laboratory test request in the workflow from submission through completion. [ENUM-REF-CANDIDATE: draft|submitted|assigned|in_progress|completed|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `request_submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the laboratory test request was officially submitted to the laboratory for processing. Marks the start of turnaround time measurement.',
    `request_type` STRING COMMENT 'Category of laboratory testing requested: physical properties, chemical composition, microbiological safety, sensory evaluation, stability study, or regulatory compliance testing.. Valid values are `physical|chemical|microbiological|sensory|stability|regulatory`',
    `requested_completion_date` DATE COMMENT 'Target date by which laboratory test results must be received to support business decisions (batch release, regulatory submission, etc.).',
    `requested_date` DATE COMMENT 'Date/time of Requested Date.',
    `requesting_department` STRING COMMENT 'Name of the business department or functional area that initiated the laboratory test request (e.g., Quality Assurance, Research and Development, Manufacturing, Regulatory Affairs).',
    `requestor_name` STRING COMMENT 'Full name of the individual who submitted the laboratory test request.',
    `required_by_date` DATE COMMENT 'Date/time of Required By Date.',
    `required_turnaround_time_hours` STRING COMMENT 'Maximum number of hours allowed from request submission to result receipt based on business priority and operational requirements.',
    `result_receipt_timestamp` TIMESTAMP COMMENT 'Date and time when laboratory test results were received and recorded in the quality management system. Marks the end of turnaround time measurement.',
    `sample_count` STRING COMMENT 'Sample Count value for the Lab Test Request record.',
    `sample_quantity` DECIMAL(18,2) COMMENT 'Quantity of sample material submitted for laboratory testing.',
    `sample_quantity_uom` STRING COMMENT 'Unit of measure for the sample quantity (e.g., g, kg, mL, L, units).',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'Source System Code value for the Lab Test Request record.',
    `special_handling_instructions` STRING COMMENT 'Any special requirements for sample handling, storage, or testing conditions (e.g., light-sensitive, temperature-controlled, hazardous material precautions).',
    `specification_version` STRING COMMENT 'Version number of the product specification document defining acceptance criteria for the test results.',
    `stability_time_point` STRING COMMENT 'Specific time point in the stability study protocol when this sample was pulled for testing (e.g., T0, 3 months, 6 months, 12 months, 24 months).',
    `storage_condition` STRING COMMENT 'Environmental conditions under which the sample was stored prior to testing (e.g., 25°C/60% RH, 40°C/75% RH, refrigerated, frozen).',
    `supplier_lot_number` STRING COMMENT 'Lot or batch number assigned by the external supplier for traceability of incoming materials.',
    `test_description` STRING COMMENT 'Attribute test_description of quality.lab_test_request.',
    `test_method` STRING COMMENT 'Test Method value for the Lab Test Request record.',
    `test_method_reference` STRING COMMENT 'Reference to the validated analytical method or standard operating procedure (SOP) to be used for testing (e.g., USP method, ASTM standard, internal SOP number).',
    `test_panel_code` STRING COMMENT 'Code identifying the predefined set of analytical tests to be performed (e.g., full release panel, stability panel, microbial panel).',
    `test_panel_description` STRING COMMENT 'Detailed description of the test panel including specific analytical methods and parameters to be measured.',
    `test_purpose` STRING COMMENT 'Business reason for requesting the laboratory test (e.g., batch release, stability monitoring, complaint investigation, supplier qualification, regulatory submission, method validation).',
    `test_type` STRING COMMENT 'Attribute test_type of quality.lab_test_request.',
    `testing_start_timestamp` TIMESTAMP COMMENT 'Date and time when laboratory analytical work began on the sample.',
    `turnaround_days` STRING COMMENT 'Turnaround Days value for the Lab Test Request record.',
    `uom` STRING COMMENT 'Attribute uom of quality.lab_test_request.',
    `updated_timestamp` TIMESTAMP COMMENT 'Attribute updated_timestamp of quality.lab_test_request.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `veeva_vault_document_reference` STRING COMMENT 'Reference to the associated quality document, test protocol, or specification stored in Veeva Vault document management system.',
    CONSTRAINT pk_lab_test_request PRIMARY KEY(`lab_test_request_id`)
) COMMENT 'Request for laboratory testing of a sample, defining required tests, priority, and routing to the responsible laboratory.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`notification` (
    `notification_id` BIGINT COMMENT 'Unique identifier for the quality notification record. Primary key.',
    `capa_id` BIGINT COMMENT 'Reference identifier linking this quality notification to a formal CAPA record for corrective and preventive actions.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Quality notification financial impact is allocated to a cost center for expense reporting.',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Connects quality notifications triggered by shipment issues (e.g., temperature breach) to the specific shipment for corrective actions.',
    `manufacturing_facility_id` BIGINT COMMENT 'Attribute manufacturing_facility_id of manufacturing.notification.',
    `nonconformance_id` BIGINT COMMENT 'Nonconformance Id referencing quality.nonconformance.nonconformance_id.',
    `employee_id` BIGINT COMMENT 'Attribute created_by_employee_id of workforce.notification.',
    `notification_raised_by_employee_id` BIGINT COMMENT 'Raised By Employee Id referencing workforce.employee.employee_id.',
    `notification_recipient_employee_id` BIGINT COMMENT 'Attribute recipient_employee_id of workforce.notification.',
    `primary_notification_closed_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who formally closed the quality notification.',
    `product_complaint_id` BIGINT COMMENT 'Reference identifier linking this quality notification to an originating customer complaint record, if applicable.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier associated with the quality issue, used when the notification relates to supplier quality performance.',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'Attribute acknowledged_timestamp of quality.notification.',
    `affected_quantity` DECIMAL(18,2) COMMENT 'Quantity of material or product units affected by the quality issue.',
    `affected_quantity_uom` STRING COMMENT 'Unit of measure for the affected quantity (e.g., EA for each, KG for kilograms, L for liters).. Valid values are `^[A-Z]{2,3}$`',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.notification.',
    `assigned_to` STRING COMMENT 'Assigned To value for the Notification record.',
    `assigned_to_name` STRING COMMENT 'Full name of the person assigned to handle this quality notification.',
    `batch_number` STRING COMMENT 'Manufacturing batch or lot number of the affected material, enabling traceability and containment actions.. Valid values are `^[A-Z0-9]{6,20}$`',
    `category_code` STRING COMMENT 'Category Code value for the Notification record.',
    `channel` STRING COMMENT 'Attribute notification_channel of quality.notification.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the quality notification was formally closed after all actions were completed and verified.',
    `notification_code` STRING COMMENT 'Attribute code of quality.notification.',
    `completed_date` DATE COMMENT 'Date/time of Completed Date.',
    `completion_date` DATE COMMENT 'Attribute completion_date of quality.notification.',
    `containment_action` STRING COMMENT 'Immediate containment actions taken to prevent further impact or spread of the quality issue while root cause investigation is underway.',
    `containment_timestamp` TIMESTAMP COMMENT 'Date and time when containment actions were implemented.',
    `created_date` DATE COMMENT 'Date when the quality notification was initially created in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this quality notification record was first created in the lakehouse, representing the audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.notification.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `defect_class` STRING COMMENT 'Severity classification of the defect based on its impact on product safety, functionality, and regulatory compliance.. Valid values are `critical|major|minor|cosmetic`',
    `defect_code` STRING COMMENT 'Standardized code classifying the type of defect or quality issue for categorization and trend analysis.. Valid values are `^[A-Z0-9]{2,10}$`',
    `notification_description` STRING COMMENT 'Detailed textual description of the quality issue, defect, or improvement opportunity documented in this notification.',
    `detected_timestamp` TIMESTAMP COMMENT 'Date and time when the quality issue was first detected or observed, which may differ from when it was formally reported.',
    `detection_source` STRING COMMENT 'Origin or source where the quality issue was first identified or detected. [ENUM-REF-CANDIDATE: customer|production|inspection|audit|supplier|warehouse|field — 7 candidates stripped; promote to reference product]',
    `disposition_approved_by` STRING COMMENT 'Name or identifier of the quality authority who approved the material disposition decision.',
    `disposition_approved_timestamp` TIMESTAMP COMMENT 'Date and time when the disposition decision was formally approved.',
    `disposition_decision` STRING COMMENT 'Final disposition decision for the affected material or product: use as-is, rework, scrap, return to supplier, or downgrade to alternate use.. Valid values are `use_as_is|rework|scrap|return_to_supplier|downgrade`',
    `due_date` DATE COMMENT 'Attribute due_date of quality.notification.',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.notification.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.notification.',
    `escalation_level` STRING COMMENT 'Attribute escalation_level of quality.notification.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact of the quality issue including costs of rework, scrap, customer credits, and remediation.',
    `financial_impact_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount.. Valid values are `^[A-Z]{3}$`',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this quality notification record was most recently updated in the lakehouse, supporting change tracking and audit requirements.',
    `material_code` STRING COMMENT 'SAP material master code identifying the product or raw material affected by this quality notification.. Valid values are `^[A-Z0-9]{6,18}$`',
    `material_description` STRING COMMENT 'Human-readable description of the material or product affected by the quality issue.',
    `message_body` STRING COMMENT 'Attribute message_body of quality.notification.',
    `notification_name` STRING COMMENT 'Attribute name of quality.notification.',
    `notes` STRING COMMENT 'Attribute notes of quality.notification.',
    `notification_number` STRING COMMENT 'Business identifier for the quality notification, externally visible and used for tracking and reference across systems.. Valid values are `^[A-Z0-9]{10,20}$`',
    `notification_status` STRING COMMENT 'Current lifecycle status of the quality notification indicating its position in the resolution workflow.. Valid values are `open|in_progress|pending_approval|closed|cancelled`',
    `notification_type` STRING COMMENT 'Classification of the quality notification indicating the nature of the issue: customer complaint, internal defect, improvement request, process deviation, audit finding, or supplier quality issue.. Valid values are `complaint|defect|improvement|deviation|audit_finding|supplier_issue`',
    `plant_code` STRING COMMENT 'SAP plant code identifying the manufacturing facility or distribution center responsible for addressing this quality notification.. Valid values are `^[A-Z0-9]{4,10}$`',
    `plant_name` STRING COMMENT 'Name of the manufacturing plant or facility associated with the quality notification.',
    `priority` STRING COMMENT 'Business priority level assigned to the notification based on severity, impact, and urgency of resolution required.. Valid values are `critical|high|medium|low`',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.notification.',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body to which this quality notification was reported (e.g., FDA, EPA, CPSC).',
    `regulatory_report_date` DATE COMMENT 'Date when the quality issue was formally reported to the relevant regulatory authority.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this quality notification must be reported to regulatory authorities such as FDA, EPA, or CPSC.',
    `reported_date` DATE COMMENT 'Attribute reported_date of quality.notification.',
    `reported_timestamp` TIMESTAMP COMMENT 'Precise date and time when the quality issue was formally reported, representing the principal business event timestamp for this notification.',
    `required_completion_date` DATE COMMENT 'Attribute required_completion_date of quality.notification.',
    `required_end_date` DATE COMMENT 'Attribute required_end_date of quality.notification.',
    `responsible_department` STRING COMMENT 'Department or functional area responsible for investigating and resolving the quality notification.',
    `root_cause_analysis` STRING COMMENT 'Detailed findings from root cause analysis investigation documenting the underlying cause of the quality issue.',
    `sent_timestamp` TIMESTAMP COMMENT 'Attribute sent_timestamp of quality.notification.',
    `severity` STRING COMMENT 'Severity value for the Notification record.',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'Unique identifier of this quality notification record in the source system, used for traceability and reconciliation.',
    `subject` STRING COMMENT 'Subject value for the Notification record.',
    `uom` STRING COMMENT 'Attribute uom of quality.notification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Attribute updated_timestamp of quality.notification.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `veeva_vault_document_reference` STRING COMMENT 'Reference identifier linking this quality notification to supporting documentation stored in Veeva Vault quality document management system.. Valid values are `^[A-Z0-9]{10,30}$`',
    `verification_method` STRING COMMENT 'Method or approach used to verify that corrective actions were effective and the quality issue was resolved.',
    CONSTRAINT pk_notification PRIMARY KEY(`notification_id`)
) COMMENT 'Quality notification record capturing defects, complaints, or deviations and triggering downstream quality processes.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` (
    `control_chart_id` BIGINT COMMENT 'Unique identifier for the Statistical Process Control (SPC) control chart record. Primary key for the control chart entity.',
    `specification_id` BIGINT COMMENT 'Specification Id referencing quality.specification.specification_id.',
    `employee_id` BIGINT COMMENT 'Identifier of the individual user or quality engineer responsible for maintaining and reviewing this control chart.',
    `manufacturing_facility_id` BIGINT COMMENT 'Attribute manufacturing_facility_id of manufacturing.control_chart.',
    `owner_employee_id` BIGINT COMMENT 'Owner Employee Id referencing workforce.employee.employee_id.',
    `primary_control_chart_specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Link control_chart to the specification that defines the monitored characteristic limits.',
    `production_line_id` BIGINT COMMENT 'Identifier of the production line or manufacturing equipment where this control chart is applied. Links to manufacturing execution system line master data.',
    `sku_id` BIGINT COMMENT 'Sku Id referencing product.sku.sku_id.',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.control_chart.',
    `baseline_period_end_date` DATE COMMENT 'The end date of the baseline period used to establish initial control limits.',
    `baseline_period_start_date` DATE COMMENT 'The start date of the baseline period used to establish initial control limits. Baseline data should represent stable process conditions.',
    `baseline_sample_count` STRING COMMENT 'The number of samples or subgroups used in the baseline period to calculate initial control limits. Typically requires 20-25 subgroups minimum for reliable limits.',
    `center_line` DECIMAL(18,2) COMMENT 'The center line or process mean for the control chart, representing the target or average value of the monitored characteristic under stable process conditions.',
    `characteristic` STRING COMMENT 'Characteristic value for the Control Chart record.',
    `characteristic_code` STRING COMMENT 'Standardized code or identifier for the monitored characteristic, typically aligned with SAP QM inspection characteristic master data or quality specification codes.',
    `chart_code` STRING COMMENT 'Chart Code value for the Control Chart record.',
    `chart_name` STRING COMMENT 'Chart Name value for the Control Chart record.',
    `chart_number` STRING COMMENT 'Business identifier for the control chart, used for external reference and reporting. Typically follows plant or quality system numbering conventions.',
    `chart_review_frequency` STRING COMMENT 'The frequency at which this control chart is formally reviewed by quality management. Examples include daily, weekly, monthly, or quarterly reviews.',
    `chart_status` STRING COMMENT 'Current lifecycle status of the control chart. Active charts are in use for real-time monitoring, inactive charts are retired, suspended charts are temporarily paused, under review charts are being evaluated for control limit recalculation.. Valid values are `active|inactive|suspended|under_review`',
    `chart_type` STRING COMMENT 'Type of Statistical Process Control chart used for monitoring. X-bar/R for variable data with range, X-bar/S for variable data with standard deviation, p-chart for proportion defective, c-chart for count of defects, u-chart for defects per unit, CUSUM for cumulative sum, EWMA for exponentially weighted moving average. [ENUM-REF-CANDIDATE: x_bar_r|x_bar_s|p_chart|c_chart|u_chart|cusum|ewma — 7 candidates stripped; promote to reference product]',
    `control_chart_code` STRING COMMENT 'Attribute code of quality.control_chart.',
    `control_chart_status` STRING COMMENT 'Attribute status of quality.control_chart.',
    `control_limit_calculation_date` DATE COMMENT 'The date when the current control limits were calculated or last recalculated based on process data.',
    `control_limit_calculation_method` STRING COMMENT 'The statistical method or formula used to calculate control limits. Examples include 3-sigma method, probability limits, or custom calculation procedures.',
    `control_rule_set` STRING COMMENT 'The set of statistical control rules applied to detect out-of-control conditions. Common rule sets include Western Electric rules (1-4), Nelson rules (1-8), or custom rule combinations defined by the quality system.',
    `cp_value` DECIMAL(18,2) COMMENT 'The process capability index Cp, measuring the potential capability of the process if it were perfectly centered between specification limits. Does not account for process centering.',
    `cpk_value` DECIMAL(18,2) COMMENT 'The process capability index Cpk, measuring how well the process fits within specification limits while accounting for process centering. Values above 1.33 typically indicate capable processes in GMP environments.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this control chart record was first created in the system.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.control_chart.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `control_chart_description` STRING COMMENT 'Attribute description of quality.control_chart.',
    `effective_date` DATE COMMENT 'Date/time of Effective Date.',
    `effective_end_date` DATE COMMENT 'The date when this control chart configuration was retired or superseded. Null for currently active charts.',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.control_chart.',
    `effective_start_date` DATE COMMENT 'The date when this control chart configuration became effective and active for process monitoring.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.control_chart.',
    `evaluation_date` DATE COMMENT 'Attribute evaluation_date of quality.control_chart.',
    `gmp_compliant_flag` BOOLEAN COMMENT 'Indicates whether this control chart is part of GMP-regulated process monitoring and subject to regulatory requirements. True for pharmaceutical, cosmetic, and food products under FDA or EU GMP regulations.',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this control chart record was last modified or updated.',
    `last_review_date` DATE COMMENT 'The date when this control chart was last formally reviewed by quality management or process engineering.',
    `lower_control_limit` DECIMAL(18,2) COMMENT 'The lower control limit calculated for this control chart, typically set at 3 standard deviations below the center line. Values below this threshold indicate the process is out of statistical control.',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Attribute lower_spec_limit of quality.control_chart.',
    `lower_specification_limit` DECIMAL(18,2) COMMENT 'The lower specification limit defined by product quality specifications or regulatory requirements. Represents the minimum acceptable value for the characteristic.',
    `material_code` STRING COMMENT 'Material or SKU (Stock Keeping Unit) code for the product being monitored. Links to product master data in ERP systems.',
    `material_description` STRING COMMENT 'Human-readable description of the material or product being monitored by this control chart.',
    `measurement_unit` STRING COMMENT 'Measurement Unit value for the Control Chart record.',
    `monitored_characteristic` STRING COMMENT 'The Critical Quality Attribute (CQA) or process parameter being monitored by this control chart. Examples include fill weight, pH level, viscosity, tablet hardness, dissolution rate, or any measurable quality attribute.',
    `control_chart_name` STRING COMMENT 'Attribute name of quality.control_chart.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next formal review of this control chart configuration and performance.',
    `notes` STRING COMMENT 'Attribute notes of quality.control_chart.',
    `ocap_reference` STRING COMMENT 'Reference to the Out-of-Control Action Plan document or procedure that defines the response actions when control chart violations are detected. Links to quality management system procedures.',
    `out_of_control_flag` BOOLEAN COMMENT 'Attribute out_of_control_flag of quality.control_chart.',
    `parameter_name` STRING COMMENT 'Parameter Name value for the Control Chart record.',
    `period_end_date` DATE COMMENT 'Attribute period_end_date of quality.control_chart.',
    `period_start_date` DATE COMMENT 'Attribute period_start_date of quality.control_chart.',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility code where the control chart is deployed. Aligns with SAP plant master data or ERP facility codes.',
    `ppk_value` DECIMAL(18,2) COMMENT 'The process performance index Ppk, measuring long-term process performance relative to specification limits. Calculated using overall process variation rather than within-subgroup variation.',
    `process_capability_cpk` DECIMAL(18,2) COMMENT 'Process Capability Cpk value for the Control Chart record.',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.control_chart.',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `regulatory_requirement_reference` STRING COMMENT 'Reference to specific regulatory requirements or guidance documents that mandate or recommend this control chart. Examples include FDA guidance, ICH guidelines, or pharmacopeial requirements.',
    `responsible_department` STRING COMMENT 'The department or organizational unit responsible for monitoring this control chart and responding to out-of-control signals. Typically Quality Assurance, Production, or Process Engineering.',
    `sample_size` STRING COMMENT 'Sample Size value for the Control Chart record.',
    `sample_subgroup_size` STRING COMMENT 'Sample Subgroup Size value for the Control Chart record.',
    `sampling_frequency` STRING COMMENT 'The frequency at which samples are collected for control chart monitoring. Examples include every 15 minutes, hourly, per batch, or per shift.',
    `sampling_plan_code` STRING COMMENT 'Code or identifier for the sampling plan used to collect data for this control chart. Links to quality management system sampling procedures.',
    `sap_qm_inspection_characteristic` STRING COMMENT 'SAP QM inspection characteristic code that this control chart monitors. Links to SAP QM master data for inspection planning and results recording.',
    `sigma_level` DECIMAL(18,2) COMMENT 'Sigma Level value for the Control Chart record.',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'Source System Code value for the Control Chart record.',
    `subgroup_frequency` STRING COMMENT 'Subgroup Frequency value for the Control Chart record.',
    `subgroup_size` STRING COMMENT 'The number of samples or observations collected in each subgroup for control chart analysis. Typical values range from 2 to 10 for variable control charts.',
    `target_value` DECIMAL(18,2) COMMENT 'The target or nominal value for the monitored characteristic as defined in product specifications or process design. May differ from the center line if the process is not centered on target.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the monitored characteristic and control limits. Examples include grams, milliliters, pH units, percentage, ppm (parts per million), or dimensionless ratios.',
    `uom` STRING COMMENT 'Attribute uom of quality.control_chart.',
    `updated_timestamp` TIMESTAMP COMMENT 'Attribute updated_timestamp of quality.control_chart.',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'The upper control limit calculated for this control chart, typically set at 3 standard deviations above the center line. Values above this threshold indicate the process is out of statistical control.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Attribute upper_spec_limit of quality.control_chart.',
    `upper_specification_limit` DECIMAL(18,2) COMMENT 'The upper specification limit defined by product quality specifications or regulatory requirements. Represents the maximum acceptable value for the characteristic.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `veeva_vault_document_reference` STRING COMMENT 'Document identifier in Veeva Vault quality management system linking to the control chart procedure, OCAP, or related quality documentation.',
    CONSTRAINT pk_control_chart PRIMARY KEY(`control_chart_id`)
) COMMENT 'Statistical process control chart tracking quality characteristics over time with control limits and rule-violation flags.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` (
    `change_control_id` BIGINT COMMENT 'Unique identifier for the change control request record. Primary key for the change control entity.',
    `capa_id` BIGINT COMMENT 'Foreign key reference to the CAPA record if this change control request was initiated as part of a corrective or preventive action.',
    `employee_id` BIGINT COMMENT 'Approved By Employee Id referencing workforce.employee.employee_id.',
    `change_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_change. Business justification: Regulatory changes often drive change controls; linking records which change control addresses which regulatory amendment.',
    `change_initiator_employee_id` BIGINT COMMENT 'Initiator Employee Id referencing workforce.employee.employee_id.',
    `change_requested_by_employee_id` BIGINT COMMENT 'Requested By Employee Id referencing workforce.employee.employee_id.',
    `inspector_employee_id` BIGINT COMMENT 'Employee or user identifier for the change control request initiator.',
    `manufacturing_facility_id` BIGINT COMMENT 'Manufacturing Facility Id referencing manufacturing.manufacturing_facility.manufacturing_facility_id.',
    `nonconformance_id` BIGINT COMMENT 'Foreign key reference to a nonconformance record if this change control request was triggered by a quality deviation or defect.',
    `owner_employee_id` BIGINT COMMENT 'Attribute owner_employee_id of workforce.change_control.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Change Control is initiated by an R&D project when product changes are required; linking ensures traceability of project origin.',
    `sku_id` BIGINT COMMENT 'Sku Id referencing product.sku.sku_id.',
    `actual_implementation_date` DATE COMMENT 'Actual date when the change was implemented in production or operations, formatted as yyyy-MM-dd.',
    `affected_facilities` STRING COMMENT 'Manufacturing sites, warehouses, or laboratories impacted by the change, identified by facility code or name.',
    `affected_markets` STRING COMMENT 'Geographic markets or regulatory jurisdictions where the change will be implemented, using ISO 3166-1 alpha-3 country codes or region names.',
    `affected_products` STRING COMMENT 'Comma-separated list or narrative description of product SKUs, GTINs, or product families impacted by the change control request.',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.change_control.',
    `approval_date` DATE COMMENT 'Date/time of Approval Date.',
    `approval_workflow_status` STRING COMMENT 'Current stage in the multi-level approval workflow, indicating which functional area or authority is currently reviewing the change control request.. Valid values are `pending_qa|pending_regulatory|pending_operations|pending_management|approved|rejected`',
    `approver_name` STRING COMMENT 'Approver Name value for the Change Control record.',
    `change_category` STRING COMMENT 'Change Category value for the Change Control record.',
    `change_control_number` STRING COMMENT 'Change Control Number value for the Change Control record.',
    `change_control_status` STRING COMMENT 'Attribute status of quality.change_control.',
    `change_justification` STRING COMMENT 'Business and technical rationale for the proposed change, including benefits, risk mitigation, or compliance drivers.',
    `change_priority` STRING COMMENT 'Business priority level assigned to the change control request, influencing review and implementation timelines.. Valid values are `critical|high|medium|low`',
    `change_request_number` STRING COMMENT 'Business identifier for the change control request, typically formatted as CR-NNNNNN. Used for external communication and tracking.. Valid values are `^CR-[0-9]{6,10}$`',
    `change_status` STRING COMMENT 'Current lifecycle status of the change control request in the approval and implementation workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|on_hold|implemented|closed|cancelled — 9 candidates stripped; promote to reference product]',
    `change_title` STRING COMMENT 'Brief descriptive title summarizing the change control request for quick identification and reporting.',
    `change_type` STRING COMMENT 'Classification of the change control request by the type of change being proposed: formulation (product recipe), process (manufacturing method), equipment (machinery or tooling), facility (building or infrastructure), specification (quality standards), or quality_system (QMS procedures).. Valid values are `formulation|process|equipment|facility|specification|quality_system`',
    `closed_date` DATE COMMENT 'Date/time of Closed Date.',
    `closure_comments` STRING COMMENT 'Final remarks or summary notes recorded at the time of change control closure, documenting lessons learned or outstanding items.',
    `closure_date` DATE COMMENT 'Date when the change control request was formally closed after successful implementation and verification, formatted as yyyy-MM-dd.',
    `change_control_code` STRING COMMENT 'Attribute code of quality.change_control.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the change control record was first created in the system, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.change_control.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `change_control_description` STRING COMMENT 'Description value for the Change Control record.',
    `effective_date` DATE COMMENT 'Date/time of Effective Date.',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.change_control.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.change_control.',
    `effectiveness_review_date` DATE COMMENT 'Scheduled or actual date for conducting the effectiveness review of the implemented change, formatted as yyyy-MM-dd.',
    `effectiveness_review_outcome` STRING COMMENT 'Result of the effectiveness review, indicating whether the change achieved its intended objectives.. Valid values are `effective|partially_effective|ineffective|pending`',
    `effectiveness_review_required_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether a formal effectiveness review is required after a defined period to assess long-term impact of the change.',
    `final_approval_date` DATE COMMENT 'Date when final approval was granted, authorizing implementation of the change, formatted as yyyy-MM-dd.',
    `final_approver_name` STRING COMMENT 'Full name of the senior authority who provided final approval for the change control request, typically a Quality Director or Plant Manager.',
    `gmp_impact_flag` BOOLEAN COMMENT 'Boolean indicator for Gmp Impact Flag.',
    `impact_assessment` STRING COMMENT 'Impact Assessment value for the Change Control record.',
    `implementation_date` DATE COMMENT 'Date/time of Implementation Date.',
    `initiated_date` DATE COMMENT 'Date/time of Initiated Date.',
    `initiator_department` STRING COMMENT 'Organizational department or functional area of the change control request initiator.',
    `initiator_name` STRING COMMENT 'Full name of the individual who originated the change control request.',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `justification` STRING COMMENT 'Justification value for the Change Control record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the change control record, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `change_control_name` STRING COMMENT 'Attribute name of quality.change_control.',
    `notes` STRING COMMENT 'Attribute notes of quality.change_control.',
    `post_change_verification_required_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether post-implementation verification activities are required to confirm the change achieved its intended outcome without adverse effects.',
    `priority` STRING COMMENT 'Priority value for the Change Control record.',
    `qa_approval_date` DATE COMMENT 'Date when Quality Assurance approval was granted, formatted as yyyy-MM-dd.',
    `qa_approver_name` STRING COMMENT 'Full name of the Quality Assurance representative who approved or rejected the change control request.',
    `quality_impact_assessment` STRING COMMENT 'Detailed evaluation of the potential impact of the change on product quality attributes, safety, efficacy, and GMP compliance. Documents risk analysis and mitigation strategies.',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.change_control.',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `regulatory_approval_date` DATE COMMENT 'Date when Regulatory Affairs approval was granted, formatted as yyyy-MM-dd.',
    `regulatory_approver_name` STRING COMMENT 'Full name of the Regulatory Affairs representative who approved or rejected the change control request.',
    `regulatory_impact_classification` STRING COMMENT 'Assessment of the regulatory significance of the change. Major changes require regulatory authority notification or approval; minor changes may be managed internally per validated change control procedures.. Valid values are `major|moderate|minor|none`',
    `regulatory_impact_flag` BOOLEAN COMMENT 'Boolean indicator for Regulatory Impact Flag.',
    `request_date` DATE COMMENT 'Date when the change control request was formally submitted for review, formatted as yyyy-MM-dd.',
    `requested_date` DATE COMMENT 'Date/time of Requested Date.',
    `risk_assessment` STRING COMMENT 'Attribute risk_assessment of quality.change_control.',
    `risk_level` STRING COMMENT 'Risk Level value for the Change Control record.',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'Source System Code value for the Change Control record.',
    `supply_chain_impact_assessment` STRING COMMENT 'Evaluation of the changes impact on supply chain operations, including material sourcing, production capacity, lead times, and distribution.',
    `target_implementation_date` DATE COMMENT 'Planned date for implementing the approved change, formatted as yyyy-MM-dd.',
    `title` STRING COMMENT 'Title value for the Change Control record.',
    `uom` STRING COMMENT 'Attribute uom of quality.change_control.',
    `updated_timestamp` TIMESTAMP COMMENT 'Attribute updated_timestamp of quality.change_control.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `veeva_vault_document_reference` STRING COMMENT 'Unique document identifier in Veeva Vault QMS system where the change control request and supporting documentation are stored.',
    `verification_completion_date` DATE COMMENT 'Date when post-change verification activities were completed, formatted as yyyy-MM-dd.',
    `verification_method` STRING COMMENT 'Description of the method or procedure used to verify the effectiveness of the implemented change, such as testing, inspection, or performance monitoring.',
    CONSTRAINT pk_change_control PRIMARY KEY(`change_control_id`)
) COMMENT 'Formal change-control record governing GMP-relevant changes to processes, specifications, equipment, or documentation.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` (
    `audit_program_id` BIGINT COMMENT 'Primary key for audit_program',
    `manufacturing_facility_id` BIGINT COMMENT 'Manufacturing Facility Id referencing manufacturing.manufacturing_facility.manufacturing_facility_id.',
    `employee_id` BIGINT COMMENT 'Owner Employee Id referencing workforce.employee.employee_id.',
    `parent_audit_program_id` BIGINT COMMENT 'Self-referencing FK on audit_program (parent_audit_program_id)',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.audit_program.',
    `approval_date` DATE COMMENT 'Date/time of Approval Date.',
    `audit_category` STRING COMMENT 'High‑level classification of the audit focus area.',
    `audit_criteria` STRING COMMENT 'Specific criteria or checkpoints evaluated during the audit.',
    `audit_duration_hours` STRING COMMENT 'Estimated or actual number of hours required to complete the audit.',
    `audit_findings_count` STRING COMMENT 'Number of non‑conformances or observations identified in the latest audit.',
    `audit_frequency_months` STRING COMMENT 'Number of months between scheduled executions of the audit program.',
    `audit_method` STRING COMMENT 'Methodology used to conduct the audit (e.g., internal team, external auditor).',
    `audit_notes` STRING COMMENT 'Free‑form notes or comments captured by the audit owner.',
    `audit_outcome_template` STRING COMMENT 'Reference to the template used for documenting audit findings.',
    `audit_owner` STRING COMMENT 'Name of the internal employee or team responsible for the audit program.',
    `audit_program_status` STRING COMMENT 'Current lifecycle state of the audit program.',
    `audit_report_format` STRING COMMENT 'File format in which the audit report is produced.',
    `audit_resources_required` STRING COMMENT 'List of personnel, equipment, or tools needed for the audit.',
    `audit_scope` STRING COMMENT 'Textual description of the functional, product, or facility scope covered by the audit.',
    `audit_program_code` STRING COMMENT 'Attribute code of quality.audit_program.',
    `completed_audit_count` STRING COMMENT 'Completed Audit Count value for the Audit Program record.',
    `compliance_area` STRING COMMENT 'Regulatory or standards domain the audit program addresses.',
    `corrective_action_due_date` DATE COMMENT 'Deadline for completing corrective actions arising from the audit.',
    `corrective_actions_required` BOOLEAN COMMENT 'Indicates whether the audit generated mandatory corrective actions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit program record was first created in the system.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.audit_program.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `audit_program_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and objectives of the audit program.',
    `effective_end_date` DATE COMMENT 'Date on which the audit program expires or is retired (nullable).',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.audit_program.',
    `effective_start_date` DATE COMMENT 'Date on which the audit program becomes effective.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.audit_program.',
    `end_date` DATE COMMENT 'Date/time of End Date.',
    `execution_status` STRING COMMENT 'Current execution state of the most recent audit run.',
    `fiscal_year` STRING COMMENT 'Fiscal Year value for the Audit Program record.',
    `frequency` STRING COMMENT 'Frequency value for the Audit Program record.',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the audit program is required by regulation or policy.',
    `last_executed_date` DATE COMMENT 'Date when the audit program was most recently executed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date/time of Last Modified Timestamp.',
    `audit_program_name` STRING COMMENT 'Descriptive name of the audit program.',
    `next_scheduled_date` DATE COMMENT 'Planned date for the next execution of the audit program.',
    `notes` STRING COMMENT 'Attribute notes of quality.audit_program.',
    `planned_audit_count` STRING COMMENT 'Planned Audit Count value for the Audit Program record.',
    `program_code` STRING COMMENT 'Human‑readable code used to reference the audit program in reports and systems.',
    `program_description` STRING COMMENT 'Program Description value for the Audit Program record.',
    `program_end_date` DATE COMMENT 'Attribute program_end_date of quality.audit_program.',
    `program_name` STRING COMMENT 'Program Name value for the Audit Program record.',
    `program_number` STRING COMMENT 'Program Number value for the Audit Program record.',
    `program_scope` STRING COMMENT 'Program Scope value for the Audit Program record.',
    `program_start_date` DATE COMMENT 'Attribute program_start_date of quality.audit_program.',
    `program_status` STRING COMMENT 'Program Status value for the Audit Program record.',
    `program_type` STRING COMMENT 'Category that defines the nature of the audit program.',
    `program_year` STRING COMMENT 'Program Year value for the Audit Program record.',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.audit_program.',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `regulatory_basis` STRING COMMENT 'Regulatory Basis value for the Audit Program record.',
    `regulatory_reference` STRING COMMENT 'Citation of the specific regulation, guideline, or standard that drives the audit program.',
    `responsible_department` STRING COMMENT 'Organizational department that owns the audit program.',
    `review_frequency` STRING COMMENT 'Review Frequency value for the Audit Program record.',
    `risk_level` STRING COMMENT 'Risk classification assigned to the audit program based on impact and likelihood.',
    `scope` STRING COMMENT 'Scope value for the Audit Program record.',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'Source System Code value for the Audit Program record.',
    `standard_reference` STRING COMMENT 'Standard Reference value for the Audit Program record.',
    `start_date` DATE COMMENT 'Date/time of Start Date.',
    `uom` STRING COMMENT 'Attribute uom of quality.audit_program.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the audit program record.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `version_description` STRING COMMENT 'Narrative describing changes introduced in the current version.',
    `version_number` STRING COMMENT 'Version identifier for the audit program definition.',
    CONSTRAINT pk_audit_program PRIMARY KEY(`audit_program_id`)
) COMMENT 'Master schedule and governance framework for planned internal, supplier, and regulatory quality audits across the enterprise.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` (
    `audit_checklist_id` BIGINT COMMENT 'Primary key for audit_checklist',
    `audit_program_id` BIGINT COMMENT 'Audit Program Id referencing quality.audit_program.audit_program_id.',
    `employee_id` BIGINT COMMENT 'Created By Employee Id referencing workforce.employee.employee_id.',
    `gmp_audit_id` BIGINT COMMENT 'Gmp Audit Id referencing quality.gmp_audit.gmp_audit_id.',
    `parent_audit_checklist_id` BIGINT COMMENT 'Self-referencing FK on audit_checklist (parent_audit_checklist_id)',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.audit_checklist.',
    `applicable_process` STRING COMMENT 'Business process or operation to which the checklist applies.',
    `approval_date` DATE COMMENT 'Date/time of Approval Date.',
    `audit_checklist_status` STRING COMMENT 'Current lifecycle status of the checklist entry.',
    `audit_type` STRING COMMENT 'Classification of the audit (e.g., internal, external, regulatory, supplier).',
    `audit_checklist_category` STRING COMMENT 'Attribute category of quality.audit_checklist.',
    `checklist_category` STRING COMMENT 'Checklist Category value for the Audit Checklist record.',
    `checklist_code` STRING COMMENT 'Checklist Code value for the Audit Checklist record.',
    `checklist_name` STRING COMMENT 'Checklist Name value for the Audit Checklist record.',
    `checklist_number` STRING COMMENT 'Checklist Number value for the Audit Checklist record.',
    `checklist_status` STRING COMMENT 'Checklist Status value for the Audit Checklist record.',
    `checklist_type` STRING COMMENT 'Attribute checklist_type of quality.audit_checklist.',
    `checklist_version` STRING COMMENT 'Checklist Version value for the Audit Checklist record.',
    `audit_checklist_code` STRING COMMENT 'Attribute code of quality.audit_checklist.',
    `comments` STRING COMMENT 'Comments value for the Audit Checklist record.',
    `compliance_area` STRING COMMENT 'Regulatory or standards domain the checklist addresses.',
    `compliance_status` STRING COMMENT 'Compliance Status value for the Audit Checklist record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the checklist record was first created.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.audit_checklist.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `audit_checklist_description` STRING COMMENT 'Detailed description of the audit checklist purpose and scope.',
    `document_reference` STRING COMMENT 'Reference to supporting documentation or SOP (e.g., file name or URL).',
    `effective_date` DATE COMMENT 'Date/time of Effective Date.',
    `effective_from` DATE COMMENT 'Date from which the checklist becomes valid.',
    `effective_until` DATE COMMENT 'Date after which the checklist is no longer valid (nullable for open‑ended).',
    `frequency` STRING COMMENT 'How often the audit checklist should be performed.',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the checklist item is mandatory for compliance.',
    `item_count` STRING COMMENT 'Item Count value for the Audit Checklist record.',
    `item_number` STRING COMMENT 'Item Number value for the Audit Checklist record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date/time of Last Modified Timestamp.',
    `last_reviewed_date` DATE COMMENT 'Date when the checklist was last reviewed for relevance.',
    `audit_checklist_name` STRING COMMENT 'Descriptive name of the audit checklist item.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the checklist item.',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.audit_checklist.',
    `question_category` STRING COMMENT 'Attribute question_category of quality.audit_checklist.',
    `question_count` STRING COMMENT 'Question Count value for the Audit Checklist record.',
    `question_number` STRING COMMENT 'Attribute question_number of quality.audit_checklist.',
    `question_text` STRING COMMENT 'Question Text value for the Audit Checklist record.',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `regulatory_basis` STRING COMMENT 'Attribute regulatory_basis of quality.audit_checklist.',
    `regulatory_reference` STRING COMMENT 'Regulatory Reference value for the Audit Checklist record.',
    `regulatory_standard` STRING COMMENT 'Attribute regulatory_standard of quality.audit_checklist.',
    `requirement_reference` STRING COMMENT 'Requirement Reference value for the Audit Checklist record.',
    `response` STRING COMMENT 'Response value for the Audit Checklist record.',
    `responsible_role` STRING COMMENT 'Organizational role or function responsible for executing the checklist.',
    `reviewed_by` STRING COMMENT 'Name or identifier of the person who performed the last review.',
    `revision_number` STRING COMMENT 'Attribute revision_number of quality.audit_checklist.',
    `risk_level` STRING COMMENT 'Risk rating associated with the audit item.',
    `score` DECIMAL(18,2) COMMENT 'Score value for the Audit Checklist record.',
    `scoring_method` STRING COMMENT 'Scoring Method value for the Audit Checklist record.',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'Source System Code value for the Audit Checklist record.',
    `total_possible_score` DECIMAL(18,2) COMMENT 'Total Possible Score value for the Audit Checklist record.',
    `uom` STRING COMMENT 'Attribute uom of quality.audit_checklist.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the checklist record.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `version` STRING COMMENT 'Version number of the checklist definition.',
    `version_number` STRING COMMENT 'Attribute version_number of quality.audit_checklist.',
    `weight` DECIMAL(18,2) COMMENT 'Weight value for the Audit Checklist record.',
    CONSTRAINT pk_audit_checklist PRIMARY KEY(`audit_checklist_id`)
) COMMENT 'Reusable audit checklist template defining the questions, scoring criteria, and regulatory references used during quality and GMP audits.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` (
    `laboratory_id` BIGINT COMMENT 'Primary key for laboratory',
    `employee_id` BIGINT COMMENT 'Lab Manager Employee Id referencing workforce.employee.employee_id.',
    `laboratory_manager_employee_id` BIGINT COMMENT 'Manager Employee Id referencing workforce.employee.employee_id.',
    `manufacturing_facility_id` BIGINT COMMENT 'Manufacturing Facility Id referencing manufacturing.manufacturing_facility.manufacturing_facility_id.',
    `supervising_laboratory_id` BIGINT COMMENT 'Self-referencing FK on laboratory (supervising_laboratory_id)',
    `accreditation_body` STRING COMMENT 'Organization that granted the laboratory accreditation (e.g., ISO, FDA).',
    `accreditation_expiry` DATE COMMENT 'Date when the current accreditation expires.',
    `accreditation_expiry_date` DATE COMMENT 'Date/time of Accreditation Expiry Date.',
    `accreditation_number` STRING COMMENT 'Accreditation Number value for the Laboratory record.',
    `accreditation_standard` STRING COMMENT 'Attribute accreditation_standard of quality.laboratory.',
    `accreditation_status` STRING COMMENT 'Current accreditation status of the laboratory.',
    `address_city` STRING COMMENT 'Address City value for the Laboratory record.',
    `address_country` STRING COMMENT 'Address Country value for the Laboratory record.',
    `address_line1` STRING COMMENT 'Primary street address of the laboratory.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.laboratory.',
    `capability_scope` STRING COMMENT 'Capability Scope value for the Laboratory record.',
    `capacity_per_day` STRING COMMENT 'Maximum number of samples the laboratory can process per day.',
    `city` STRING COMMENT 'City where the laboratory is located.',
    `closing_date` DATE COMMENT 'Date the laboratory ceased operations (null if still active).',
    `laboratory_code` STRING COMMENT 'Laboratory Code value for the Laboratory record.',
    `compliance_flag` STRING COMMENT 'Key compliance framework(s) the laboratory adheres to.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the laboratory.',
    `country_code` STRING COMMENT 'Country Code value for the Laboratory record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the laboratory record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.laboratory.',
    `data_classification` STRING COMMENT 'Overall classification level for the laboratory record.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `laboratory_description` STRING COMMENT 'Free‑text description of the laboratorys capabilities and focus.',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.laboratory.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.laboratory.',
    `email_address` STRING COMMENT 'Primary email contact for the laboratory.',
    `external_reference_code` STRING COMMENT 'Identifier used in external systems (e.g., SAP QM, Veeva Vault).',
    `gmp_certified_flag` BOOLEAN COMMENT 'Boolean indicator for Gmp Certified Flag.',
    `hazard_level` STRING COMMENT 'Risk classification for hazardous materials handled.',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `is_external` BOOLEAN COMMENT 'Attribute is_external of quality.laboratory.',
    `is_external_flag` BOOLEAN COMMENT 'Boolean indicator for Is External Flag.',
    `is_gmp_certified` BOOLEAN COMMENT 'Boolean indicator for Is Gmp Certified.',
    `is_iso17025_accredited` BOOLEAN COMMENT 'Attribute is_iso17025_accredited of quality.laboratory.',
    `lab_code` STRING COMMENT 'External business code used to reference the laboratory in ERP and LIMS systems.',
    `lab_name` STRING COMMENT 'Lab Name value for the Laboratory record.',
    `lab_status` STRING COMMENT 'Lab Status value for the Laboratory record.',
    `lab_type` STRING COMMENT 'Category of analytical capability the laboratory provides.',
    `laboratory_status` STRING COMMENT 'Laboratory Status value for the Laboratory record.',
    `laboratory_type` STRING COMMENT 'Laboratory Type value for the Laboratory record.',
    `last_audit_date` DATE COMMENT 'Date of the most recent internal or external audit.',
    `last_audit_result` STRING COMMENT 'Outcome of the most recent audit.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date/time of Last Modified Timestamp.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the laboratory location.',
    `location` STRING COMMENT 'Location value for the Laboratory record.',
    `location_city` STRING COMMENT 'Attribute location_city of quality.laboratory.',
    `location_country` STRING COMMENT 'Attribute location_country of quality.laboratory.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the laboratory location.',
    `manager_name` STRING COMMENT 'Full name of the person responsible for laboratory operations.',
    `laboratory_name` STRING COMMENT 'Laboratory Name value for the Laboratory record.',
    `notes` STRING COMMENT 'Attribute notes of quality.laboratory.',
    `number_of_equipment` STRING COMMENT 'Total count of major analytical instruments owned by the laboratory.',
    `opening_date` DATE COMMENT 'Date the laboratory began operations.',
    `operational_hours` STRING COMMENT 'Standard daily operating hours (e.g., 08:00‑17:00).',
    `phone_number` STRING COMMENT 'Primary telephone contact for the laboratory.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the laboratory address.',
    `quality_score` DECIMAL(18,2) COMMENT 'Composite quality metric derived from audit results and performance KPIs.',
    `quantity` DECIMAL(18,2) COMMENT 'Attribute quantity of quality.laboratory.',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `region` STRING COMMENT 'Business region where the laboratory operates.',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'Source System Code value for the Laboratory record.',
    `state` STRING COMMENT 'State or province of the laboratory location.',
    `total_area_sqm` DECIMAL(18,2) COMMENT 'Physical footprint of the laboratory in square meters.',
    `uom` STRING COMMENT 'Attribute uom of quality.laboratory.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the laboratory record.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `waste_disposal_method` STRING COMMENT 'Primary method used for laboratory waste disposal.',
    CONSTRAINT pk_laboratory PRIMARY KEY(`laboratory_id`)
) COMMENT 'Master record of a quality control or analytical laboratory including accreditation, location, and testing capabilities.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`sample` (
    `sample_id` BIGINT COMMENT 'Primary key for sample',
    `inspection_lot_id` BIGINT COMMENT 'Inspection Lot Id referencing quality.inspection_lot.inspection_lot_id.',
    `lab_test_request_id` BIGINT COMMENT 'add column lab_test_request_id (BIGINT) with FK to quality.lab_test_request.lab_test_request_id - samples are typically taken in response to a lab test request',
    `laboratory_id` BIGINT COMMENT 'Laboratory Id referencing quality.laboratory.laboratory_id.',
    `lot_batch_id` BIGINT COMMENT 'Lot Batch Id referencing inventory.lot_batch.lot_batch_id.',
    `parent_sample_id` BIGINT COMMENT 'Self-referencing FK on sample (parent_sample_id)',
    `employee_id` BIGINT COMMENT 'Sampled By Employee Id referencing workforce.employee.employee_id.',
    `sample_collected_by_employee_id` BIGINT COMMENT 'Collected By Employee Id referencing workforce.employee.employee_id.',
    `sku_id` BIGINT COMMENT 'Identifier of the finished product from which the sample was taken.',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.sample.',
    `analysis_date` DATE COMMENT 'Date on which the analysis was completed.',
    `analysis_result` STRING COMMENT 'Outcome of the quality analysis for the sample.',
    `analysis_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the analysis result was recorded.',
    `analyst_name` STRING COMMENT 'Name of the quality analyst who performed the test.',
    `batch_number` STRING COMMENT 'Attribute batch_number of quality.sample.',
    `sample_code` STRING COMMENT 'External code or barcode assigned to the sample for tracking in the quality system.',
    `collected_by` STRING COMMENT 'Name of the person who performed the sample collection.',
    `collected_timestamp` TIMESTAMP COMMENT 'Date/time of Collected Timestamp.',
    `collection_date` DATE COMMENT 'Date on which the sample was physically collected.',
    `collection_location` STRING COMMENT 'Collection Location value for the Sample record.',
    `collection_point` STRING COMMENT 'Collection Point value for the Sample record.',
    `collection_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the sample was collected.',
    `comments` STRING COMMENT 'Additional observations or notes recorded by the analyst.',
    `condition` STRING COMMENT 'Sample Condition value for the Sample record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sample record was first created in the system.',
    `currency_code` STRING COMMENT 'Attribute currency_code of quality.sample.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `sample_description` STRING COMMENT 'Attribute description of quality.sample.',
    `disposal_date` DATE COMMENT 'Date/time of Disposal Date.',
    `disposed_date` DATE COMMENT 'Attribute disposed_date of quality.sample.',
    `disposition` STRING COMMENT 'Attribute disposition of quality.sample.',
    `effective_from` DATE COMMENT 'Attribute effective_from of quality.sample.',
    `effective_until` DATE COMMENT 'Attribute effective_until of quality.sample.',
    `expiry_date` DATE COMMENT 'Date after which the sample is considered expired for testing.',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `is_control` BOOLEAN COMMENT 'Indicates whether the sample is a control specimen used for method verification.',
    `is_retest` BOOLEAN COMMENT 'True if the sample is a repeat test due to a prior failure or out‑of‑spec result.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date/time of Last Modified Timestamp.',
    `location_code` STRING COMMENT 'Code identifying the storage location (e.g., freezer, shelf) where the sample is kept.',
    `lot_number` STRING COMMENT 'Manufacturing lot number associated with the sample.',
    `sample_name` STRING COMMENT 'Human‑readable name or description of the sample (e.g., "Batch 12 – Tablet Sample").',
    `notes` STRING COMMENT 'Attribute notes of quality.sample.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity value for the Sample record.',
    `quantity_uom` STRING COMMENT 'Quantity Uom value for the Sample record.',
    `record_source_system` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `result_unit` STRING COMMENT 'Unit of measure for the numeric result.',
    `result_value` DECIMAL(18,2) COMMENT 'Quantitative measurement obtained from the analysis (e.g., concentration).',
    `retention_period_months` STRING COMMENT 'Retention Period Months value for the Sample record.',
    `retention_sample_flag` BOOLEAN COMMENT 'Attribute retention_sample_flag of quality.sample.',
    `sample_number` STRING COMMENT 'Sample Number value for the Sample record.',
    `sample_status` STRING COMMENT 'Current lifecycle state of the sample within the quality process.',
    `sample_type` STRING COMMENT 'Category of the sample indicating its purpose in quality testing.',
    `source_record_code` STRING COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `source_system_code` STRING COMMENT 'Source System Code value for the Sample record.',
    `storage_condition` STRING COMMENT 'Storage Condition value for the Sample record.',
    `storage_location` STRING COMMENT 'Free‑text description of the storage environment (e.g., "‑20°C freezer, Shelf B3").',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Temperature at which the sample is stored, expressed in degrees Celsius.',
    `uom` STRING COMMENT 'Attribute uom of quality.sample.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the sample record.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `volume_ml` DECIMAL(18,2) COMMENT 'Measured volume of the sample in milliliters.',
    `weight_g` DECIMAL(18,2) COMMENT 'Measured weight of the sample in grams.',
    CONSTRAINT pk_sample PRIMARY KEY(`sample_id`)
) COMMENT 'Physical quality sample drawn for inspection, testing, or stability monitoring with chain-of-custody and retention details.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`laboratory`(`laboratory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`sample`(`sample_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_product_complaint_id` FOREIGN KEY (`product_complaint_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`product_complaint`(`product_complaint_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_primary_batch_release_certificate_of_analysis_id` FOREIGN KEY (`primary_batch_release_certificate_of_analysis_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`laboratory`(`laboratory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ADD CONSTRAINT `fk_quality_quality_stability_study_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`laboratory`(`laboratory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ADD CONSTRAINT `fk_quality_quality_stability_study_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ADD CONSTRAINT `fk_quality_stability_result_original_result_stability_result_id` FOREIGN KEY (`original_result_stability_result_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`stability_result`(`stability_result_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ADD CONSTRAINT `fk_quality_stability_result_quality_stability_study_id` FOREIGN KEY (`quality_stability_study_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`quality_stability_study`(`quality_stability_study_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ADD CONSTRAINT `fk_quality_gmp_audit_audit_program_id` FOREIGN KEY (`audit_program_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`audit_program`(`audit_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ADD CONSTRAINT `fk_quality_gmp_audit_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ADD CONSTRAINT `fk_quality_gmp_audit_audit_checklist_id` FOREIGN KEY (`audit_checklist_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`audit_checklist`(`audit_checklist_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_gmp_audit_id` FOREIGN KEY (`gmp_audit_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`gmp_audit`(`gmp_audit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_previous_finding_audit_finding_id` FOREIGN KEY (`previous_finding_audit_finding_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ADD CONSTRAINT `fk_quality_supplier_assessment_previous_assessment_supplier_assessment_id` FOREIGN KEY (`previous_assessment_supplier_assessment_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`supplier_assessment`(`supplier_assessment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ADD CONSTRAINT `fk_quality_regulatory_hold_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ADD CONSTRAINT `fk_quality_regulatory_hold_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ADD CONSTRAINT `fk_quality_regulatory_hold_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ADD CONSTRAINT `fk_quality_regulatory_hold_product_complaint_id` FOREIGN KEY (`product_complaint_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`product_complaint`(`product_complaint_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_superseded_by_specification_id` FOREIGN KEY (`superseded_by_specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ADD CONSTRAINT `fk_quality_lab_test_request_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ADD CONSTRAINT `fk_quality_lab_test_request_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`laboratory`(`laboratory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ADD CONSTRAINT `fk_quality_lab_test_request_quality_stability_study_id` FOREIGN KEY (`quality_stability_study_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`quality_stability_study`(`quality_stability_study_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ADD CONSTRAINT `fk_quality_lab_test_request_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`sample`(`sample_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_product_complaint_id` FOREIGN KEY (`product_complaint_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`product_complaint`(`product_complaint_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ADD CONSTRAINT `fk_quality_control_chart_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ADD CONSTRAINT `fk_quality_control_chart_primary_control_chart_specification_id` FOREIGN KEY (`primary_control_chart_specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ADD CONSTRAINT `fk_quality_audit_program_parent_audit_program_id` FOREIGN KEY (`parent_audit_program_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`audit_program`(`audit_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ADD CONSTRAINT `fk_quality_audit_checklist_audit_program_id` FOREIGN KEY (`audit_program_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`audit_program`(`audit_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ADD CONSTRAINT `fk_quality_audit_checklist_gmp_audit_id` FOREIGN KEY (`gmp_audit_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`gmp_audit`(`gmp_audit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ADD CONSTRAINT `fk_quality_audit_checklist_parent_audit_checklist_id` FOREIGN KEY (`parent_audit_checklist_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`audit_checklist`(`audit_checklist_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ADD CONSTRAINT `fk_quality_laboratory_supervising_laboratory_id` FOREIGN KEY (`supervising_laboratory_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`laboratory`(`laboratory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_lab_test_request_id` FOREIGN KEY (`lab_test_request_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`lab_test_request`(`lab_test_request_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`laboratory`(`laboratory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_parent_sample_id` FOREIGN KEY (`parent_sample_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`sample`(`sample_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_ssot_concept' = 'inspection_plan');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_authoritative_source' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Laboratory ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `aql_level` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Quality Level (AQL)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `certificate_of_analysis_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `change_control_number` SET TAGS ('dbx_value_regex' = '^CC-[0-9]{6,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `characteristic_count` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic Count');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `dynamic_modification_rule` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Modification Rule');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `gmp_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Critical Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `gmp_relevant` SET TAGS ('dbx_business_glossary_term' = 'Gmp Relevant');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_method` SET TAGS ('dbx_value_regex' = 'manual|automated|laboratory|visual|destructive|non_destructive');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_severity` SET TAGS ('dbx_business_glossary_term' = 'Inspection Severity Level');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_severity` SET TAGS ('dbx_value_regex' = 'normal|tightened|reduced');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_business_glossary_term' = 'Inspection Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_value_regex' = 'goods_receipt|production_start|production_end|pre_release|post_release');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'incoming|in_process|final|stability|release|periodic');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'raw_material|packaging_material|intermediate|finished_good|bulk_product');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_plan_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|obsolete|under_review');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `responsible_inspector_role` SET TAGS ('dbx_business_glossary_term' = 'Responsible Inspector Role');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `sample_unit` SET TAGS ('dbx_business_glossary_term' = 'Sample Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `sampling_procedure` SET TAGS ('dbx_business_glossary_term' = 'Sampling Procedure');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `sampling_procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Sampling Procedure Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `sampling_procedure_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `skip_lot_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Skip Lot Inspection Allowed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `specification_version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `specification_version` SET TAGS ('dbx_value_regex' = '^V[0-9]{1,3}(.[0-9]{1,2})?$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `test_equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Required');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `usage_indicator` SET TAGS ('dbx_business_glossary_term' = 'Usage Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_ssot_concept' = 'inspection_lot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_authoritative_source' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inbound_receipt_line_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Line Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `primary_inspection_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Decision Maker ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `primary_inspection_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `primary_inspection_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `tertiary_inspection_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `tertiary_inspection_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `tertiary_inspection_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `certificate_of_analysis_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `coa_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Issue Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `disposition_outcome` SET TAGS ('dbx_business_glossary_term' = 'Disposition Outcome');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `disposition_outcome` SET TAGS ('dbx_value_regex' = 'released|blocked|scrapped|returned|reworked');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_end_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_location` SET TAGS ('dbx_business_glossary_term' = 'Inspection Location');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_priority` SET TAGS ('dbx_business_glossary_term' = 'Inspection Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_start_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'created|released|in_progress|completed|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'goods_receipt|production_batch|periodic|in_process|final_release|stability');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_origin_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Origin Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_origin_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Origin Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_origin_type` SET TAGS ('dbx_value_regex' = 'production_order|purchase_order|process_order|delivery|stock_transfer');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_quantity` SET TAGS ('dbx_business_glossary_term' = 'Lot Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Lot Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `origin` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Origin');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `regulatory_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `regulatory_hold_reason` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `regulatory_hold_reason` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `sample_quantity` SET TAGS ('dbx_business_glossary_term' = 'Sample Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `sample_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Sample Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `stock_posting_instruction` SET TAGS ('dbx_business_glossary_term' = 'Stock Posting Instruction');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `stock_posting_instruction` SET TAGS ('dbx_value_regex' = 'release_to_unrestricted|move_to_blocked|move_to_quality|scrap|return');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `system_status` SET TAGS ('dbx_business_glossary_term' = 'System Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `usage_decision` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `usage_decision` SET TAGS ('dbx_value_regex' = 'accepted|rejected|restricted_use|rework|scrap|return_to_vendor');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `usage_decision_code` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `usage_decision_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` SET TAGS ('dbx_ssot_concept' = 'inspection_result');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` SET TAGS ('dbx_authoritative_source' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_result_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_result_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_result_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_result_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result Specification Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `primary_inspection_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `primary_inspection_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'Characteristic Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `characteristic_name` SET TAGS ('dbx_business_glossary_term' = 'Characteristic Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `coa_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Inclusion Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_result_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `control_chart_rule_violated` SET TAGS ('dbx_business_glossary_term' = 'Control Chart Rule Violated');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `control_chart_rule_violated` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `control_chart_rule_violated` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `control_chart_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Control Chart Violation Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `control_chart_violation_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `control_chart_violation_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `defect_classification` SET TAGS ('dbx_business_glossary_term' = 'Defect Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `defect_severity` SET TAGS ('dbx_business_glossary_term' = 'Defect Severity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `defect_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_result_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `deviation_code` SET TAGS ('dbx_business_glossary_term' = 'Deviation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `environmental_condition_humidity` SET TAGS ('dbx_business_glossary_term' = 'Environmental Condition Humidity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `environmental_condition_temperature` SET TAGS ('dbx_business_glossary_term' = 'Environmental Condition Temperature');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `evaluation_result` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Result');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_characteristic_name` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_method_code` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_result_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `instrument_code` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `is_within_spec` SET TAGS ('dbx_business_glossary_term' = 'Is Within Spec');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `laboratory_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Spec Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `lower_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `measurement_uncertainty` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_result_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `recorded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recorded Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|pending|waived');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `result_uom` SET TAGS ('dbx_business_glossary_term' = 'Result Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `result_valuation` SET TAGS ('dbx_business_glossary_term' = 'Result Valuation');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `result_value` SET TAGS ('dbx_business_glossary_term' = 'Result Value');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `result_value_text` SET TAGS ('dbx_business_glossary_term' = 'Result Value Text');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `retest_indicator` SET TAGS ('dbx_business_glossary_term' = 'Retest Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `retest_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Retest Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `retest_reason_code` SET TAGS ('dbx_value_regex' = 'initial_failure|inconclusive|instrument_error|sample_contamination|procedural_deviation|other');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `sample_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Sequence Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `test_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Test Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Spec Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `upper_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `usage_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `usage_decision_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `usage_decision_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `usage_decision_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `primary_usage_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Decision Maker ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `primary_usage_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `primary_usage_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `usage_decided_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Decided By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `usage_decided_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `usage_decided_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `accepted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Accepted Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `certificate_of_analysis_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `usage_decision_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `decision_code` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `decision_code` SET TAGS ('dbx_value_regex' = 'A|R|Q|S|X');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `decision_description` SET TAGS ('dbx_business_glossary_term' = 'Decision Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `decision_maker_name` SET TAGS ('dbx_business_glossary_term' = 'Decision Maker Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `decision_text` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `decision_type` SET TAGS ('dbx_business_glossary_term' = 'Decision Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `usage_decision_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `disposition_status` SET TAGS ('dbx_business_glossary_term' = 'Disposition Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `disposition_status` SET TAGS ('dbx_value_regex' = 'pending|completed|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `follow_up_action` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Action');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'goods_receipt|in_process|final|stability|complaint');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `usage_decision_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `quantity_accepted` SET TAGS ('dbx_business_glossary_term' = 'Quantity Accepted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `quantity_rejected` SET TAGS ('dbx_business_glossary_term' = 'Quantity Rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `quantity_rework` SET TAGS ('dbx_business_glossary_term' = 'Quantity for Rework');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `regulatory_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `regulatory_hold_reason` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `regulatory_hold_reason` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `rework_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rework Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `sampling_procedure` SET TAGS ('dbx_business_glossary_term' = 'Sampling Procedure');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `stock_posting_instruction` SET TAGS ('dbx_business_glossary_term' = 'Stock Posting Instruction');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `stock_posting_instruction` SET TAGS ('dbx_value_regex' = 'unrestricted|blocked|quality_inspection|scrap|sample|rework');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `stock_posting_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Posting Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `ud_code` SET TAGS ('dbx_business_glossary_term' = 'Ud Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `usage_decision_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` SET TAGS ('dbx_subdomain' = 'deviation_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `action_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Action Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `primary_nonconformance_closed_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Closed By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `primary_nonconformance_closed_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `primary_nonconformance_closed_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `transport_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Exception Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `affected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Affected Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `affected_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Affected Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `affected_quantity_uom` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|BOX|PALLET');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `nonconformance_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `containment_action` SET TAGS ('dbx_business_glossary_term' = 'Containment Action');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `containment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Containment Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `defect_category` SET TAGS ('dbx_business_glossary_term' = 'Defect Category');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `defect_classification` SET TAGS ('dbx_business_glossary_term' = 'Defect Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `nonconformance_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `detected_date` SET TAGS ('dbx_business_glossary_term' = 'Detected Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `detection_point` SET TAGS ('dbx_business_glossary_term' = 'Detection Point');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Detection Source');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `disposition_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Disposition Approved By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `disposition_approved_by` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `disposition_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposition Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'use_as_is|rework|scrap|return_to_supplier|downgrade|quarantine');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Event Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'complaint|defect|deviation|improvement_request|supplier_issue|audit_finding');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `is_gmp_related` SET TAGS ('dbx_business_glossary_term' = 'Is Gmp Related');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `is_gmp_related` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `is_gmp_related` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `nonconformance_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `nc_number` SET TAGS ('dbx_business_glossary_term' = 'Nc Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `nc_status` SET TAGS ('dbx_business_glossary_term' = 'Nc Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `nc_type` SET TAGS ('dbx_business_glossary_term' = 'Nc Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `nonconformance_status` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `nonconformance_status` SET TAGS ('dbx_value_regex' = 'open|in_investigation|containment_active|capa_assigned|closed|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `notification_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `notification_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'urgent|high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `regulatory_reportable` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `regulatory_reportable` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `regulatory_reportable` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `responsible_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Responsible Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `responsible_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Severity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` SET TAGS ('dbx_subdomain' = 'deviation_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `capa_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `capa_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `capa_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `primary_capa_closed_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Closed By ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `primary_capa_closed_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `primary_capa_closed_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `quaternary_capa_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `quaternary_capa_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `quaternary_capa_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `quinary_capa_verified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `quinary_capa_verified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `quinary_capa_verified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `tertiary_capa_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `tertiary_capa_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `tertiary_capa_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `capa_number` SET TAGS ('dbx_business_glossary_term' = 'CAPA Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `capa_number` SET TAGS ('dbx_value_regex' = '^CAPA-[0-9]{6,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `capa_status` SET TAGS ('dbx_business_glossary_term' = 'CAPA Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `capa_type` SET TAGS ('dbx_business_glossary_term' = 'CAPA Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `capa_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|combined');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `closure_comments` SET TAGS ('dbx_business_glossary_term' = 'Closure Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Closure Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `capa_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `cost_impact_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `cost_impact_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `customer_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `capa_description` SET TAGS ('dbx_business_glossary_term' = 'CAPA Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `effectiveness_check_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `effectiveness_result` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Result');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `effectiveness_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verification Method');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `effectiveness_verification_result` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verification Result');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `effectiveness_verification_result` SET TAGS ('dbx_value_regex' = 'effective|ineffective|pending');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `effectiveness_verified` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verified');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `gmp_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Deviation Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Initiated Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `capa_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Opened Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `preventive_action_description` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'CAPA Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `problem_statement` SET TAGS ('dbx_business_glossary_term' = 'Problem Statement');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `process_area` SET TAGS ('dbx_business_glossary_term' = 'Process Area');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `root_cause_analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Method');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `root_cause_analysis_method` SET TAGS ('dbx_value_regex' = '5_whys|fishbone|fault_tree|pareto|failure_mode_effects_analysis|other');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'CAPA Severity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `source_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Source Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'CAPA Source Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'nonconformance|audit_finding|customer_complaint|supplier_issue|stability_failure|regulatory_inspection');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'CAPA Title');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` SET TAGS ('dbx_subdomain' = 'deviation_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Release ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_release_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_release_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_release_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `certificate_of_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Analysis Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_released_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Released By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_released_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_released_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Qualified Person (QP) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `primary_batch_release_certificate_of_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Release Certificate Of Analysis Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_value_regex' = '^AUDIT-[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_release_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_size_quantity` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_size_uom` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `certificate_of_analysis_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Analysis Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_release_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_release_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `gmp_compliant` SET TAGS ('dbx_business_glossary_term' = 'Gmp Compliant');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `hold_initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Initiated Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `manufacturing_site_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `manufacturing_site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_release_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `product_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `product_registration_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `qa_signoff_flag` SET TAGS ('dbx_business_glossary_term' = 'Qa Signoff Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `qc_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Inspection Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `qc_inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional_pass|pending|waived');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `qp_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Qp Certification Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `qp_signature` SET TAGS ('dbx_business_glossary_term' = 'Qp Signature');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `qp_signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Qualified Person (QP) Signature Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `qualified_person_name` SET TAGS ('dbx_business_glossary_term' = 'Qualified Person (QP) Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `qualified_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `qualified_person_name` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `regulatory_hold_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `regulatory_hold_status` SET TAGS ('dbx_value_regex' = 'no_hold|fda_hold|epa_hold|internal_hold|customer_hold|recall_hold');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `regulatory_hold_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `regulatory_hold_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `regulatory_market` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Market');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `regulatory_market` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `regulatory_market` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `release_decision` SET TAGS ('dbx_business_glossary_term' = 'Release Decision');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `release_decision` SET TAGS ('dbx_value_regex' = 'released|rejected|quarantine|conditional_release|pending_review|on_hold');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `release_notes` SET TAGS ('dbx_business_glossary_term' = 'Release Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `release_number` SET TAGS ('dbx_business_glossary_term' = 'Release Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `release_quantity` SET TAGS ('dbx_business_glossary_term' = 'Release Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `release_status` SET TAGS ('dbx_business_glossary_term' = 'Release Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Release Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `released_quantity` SET TAGS ('dbx_business_glossary_term' = 'Released Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `sap_qm_inspection_lot` SET TAGS ('dbx_business_glossary_term' = 'SAP Quality Management (QM) Inspection Lot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `sap_qm_inspection_lot` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `stability_study_reference` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `stability_study_reference` SET TAGS ('dbx_value_regex' = '^STAB-[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_value_regex' = '^VV-[A-Z0-9]{10,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_subdomain' = 'laboratory_testing');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_ssot_concept' = 'certificate_of_analysis');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_authoritative_source' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_of_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_of_analysis_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_of_analysis_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_of_analysis_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_issued_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issued By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_issued_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_issued_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Analysis Laboratory Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Approved Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `authorized_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Title');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `batch_size` SET TAGS ('dbx_business_glossary_term' = 'Batch Size');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `batch_size_uom` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `batch_size_uom` SET TAGS ('dbx_value_regex' = 'kg|g|L|mL|units|cases');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_number` SET TAGS ('dbx_value_regex' = '^COA-[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_of_analysis_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_type` SET TAGS ('dbx_value_regex' = 'finished_goods|raw_material|intermediate|packaging_material');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `coa_number` SET TAGS ('dbx_business_glossary_term' = 'Coa Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `coa_status` SET TAGS ('dbx_business_glossary_term' = 'Coa Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_of_analysis_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `compliance_statement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Statement');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `customer_facing_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Facing Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `customer_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `customer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `customer_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_of_analysis_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `document_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `gmp_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `manufacturing_site_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `manufacturing_site_code` SET TAGS ('dbx_value_regex' = '^SITE-[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `manufacturing_site_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `material_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_of_analysis_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `overall_result` SET TAGS ('dbx_business_glossary_term' = 'Overall Result');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `overall_result_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Result Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `overall_result_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|pending_review');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `quantity_tested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Tested');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `quantity_tested_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Tested Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `quantity_tested_uom` SET TAGS ('dbx_value_regex' = 'kg|g|L|mL|units|cases');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `specification_version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `specification_version` SET TAGS ('dbx_value_regex' = '^V[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `supplier_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `test_method_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Method Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` SET TAGS ('dbx_subdomain' = 'laboratory_testing');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` SET TAGS ('dbx_ssot_concept' = 'stability_study');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` SET TAGS ('dbx_authoritative_source' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `quality_stability_study_id` SET TAGS ('dbx_business_glossary_term' = 'Stability Study ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `quality_stability_study_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `quality_stability_study_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `quality_stability_study_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Lab Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Product Formulation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Stability Study Specification Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `quality_study_director_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Study Director Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `quality_study_director_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `quality_study_director_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `approved_shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Approved Shelf Life (Months)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `quality_stability_study_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `commitment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `container_closure_system` SET TAGS ('dbx_business_glossary_term' = 'Container Closure System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `quality_stability_study_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `duration_months` SET TAGS ('dbx_business_glossary_term' = 'Duration Months');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `formulation_code` SET TAGS ('dbx_business_glossary_term' = 'Formulation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `formulation_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `formulation_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Humidity Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `ich_climatic_zone` SET TAGS ('dbx_business_glossary_term' = 'ICH Climatic Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `ich_climatic_zone` SET TAGS ('dbx_value_regex' = 'I|II|III|IV-A|IV-B');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `manufacturing_site` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `quality_stability_study_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `out_of_specification_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Specification (OOS) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `out_of_trend_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Trend (OOT) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `packaging_configuration` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `proposed_shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Proposed Shelf Life (Months)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `protocol_reference` SET TAGS ('dbx_business_glossary_term' = 'Protocol Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `quality_stability_study_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `regulatory_purpose` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Purpose');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `regulatory_purpose` SET TAGS ('dbx_value_regex' = 'registration|post-approval|annual-review|change-control|shelf-life-extension|market-complaint');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `regulatory_purpose` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `regulatory_purpose` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Region');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `report_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Report Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `report_reference` SET TAGS ('dbx_business_glossary_term' = 'Report Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `responsible_laboratory` SET TAGS ('dbx_business_glossary_term' = 'Responsible Laboratory');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `shelf_life_target_months` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Target Months');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `stability_commitment_flag` SET TAGS ('dbx_business_glossary_term' = 'Stability Commitment Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `storage_humidity_pct` SET TAGS ('dbx_business_glossary_term' = 'Storage Humidity Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `storage_instruction` SET TAGS ('dbx_business_glossary_term' = 'Storage Instruction');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `study_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Study Conclusion');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `study_coordinator` SET TAGS ('dbx_business_glossary_term' = 'Study Coordinator');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `study_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Study Duration (Months)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `study_end_date` SET TAGS ('dbx_business_glossary_term' = 'Study End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `study_number` SET TAGS ('dbx_business_glossary_term' = 'Study Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `study_start_date` SET TAGS ('dbx_business_glossary_term' = 'Study Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `study_status` SET TAGS ('dbx_value_regex' = 'planned|in-progress|completed|discontinued|on-hold|under-review');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Study Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'accelerated|real-time|intermediate|stress|photostability|in-use');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Celsius');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `test_parameters` SET TAGS ('dbx_business_glossary_term' = 'Test Parameters');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `testing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Testing Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` SET TAGS ('dbx_subdomain' = 'laboratory_testing');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` SET TAGS ('dbx_ssot_concept' = 'stability_result');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` SET TAGS ('dbx_authoritative_source' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `stability_result_id` SET TAGS ('dbx_business_glossary_term' = 'Stability Result ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `stability_result_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `stability_result_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `stability_result_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `original_result_stability_result_id` SET TAGS ('dbx_business_glossary_term' = 'Original Result ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `quality_stability_study_id` SET TAGS ('dbx_business_glossary_term' = 'Stability Study ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `stability_tested_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Tested By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `stability_tested_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `stability_tested_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `analyst_name` SET TAGS ('dbx_business_glossary_term' = 'Analyst Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `analyst_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `stability_result_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `stability_result_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `deviation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Deviation Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `instrument_code` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `is_within_spec` SET TAGS ('dbx_business_glossary_term' = 'Is Within Spec');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `laboratory_location` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Location');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Spec Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `stability_result_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `out_of_specification_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Specification (OOS) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|inconclusive|pending');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `pull_date` SET TAGS ('dbx_business_glossary_term' = 'Pull Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `result_pass_fail` SET TAGS ('dbx_business_glossary_term' = 'Result Pass Fail');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `result_uom` SET TAGS ('dbx_business_glossary_term' = 'Result Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `result_value` SET TAGS ('dbx_business_glossary_term' = 'Result Value');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `retest_flag` SET TAGS ('dbx_business_glossary_term' = 'Retest Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `sap_qm_inspection_lot` SET TAGS ('dbx_business_glossary_term' = 'SAP QM (Quality Management) Inspection Lot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `shelf_life_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Impact Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Specification Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `specification_lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Specification Lower Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `specification_target` SET TAGS ('dbx_business_glossary_term' = 'Specification Target');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `specification_upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Specification Upper Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `stability_result_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `storage_condition` SET TAGS ('dbx_value_regex' = '25C/60RH|30C/65RH|40C/75RH|5C|refrigerated|frozen');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `test_characteristic` SET TAGS ('dbx_business_glossary_term' = 'Test Characteristic');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `test_interval_number` SET TAGS ('dbx_business_glossary_term' = 'Test Interval Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `test_parameter` SET TAGS ('dbx_business_glossary_term' = 'Test Parameter');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|on_hold');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `timepoint_months` SET TAGS ('dbx_business_glossary_term' = 'Timepoint Months');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `trend` SET TAGS ('dbx_business_glossary_term' = 'Trend');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `trend_flag` SET TAGS ('dbx_business_glossary_term' = 'Trend Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Spec Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` SET TAGS ('dbx_ssot_concept' = 'gmp_audit');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` SET TAGS ('dbx_authoritative_source' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `gmp_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Audit ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `gmp_audit_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `gmp_audit_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `gmp_audit_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `audit_program_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Program ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `audit_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Checklist ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `affected_process_areas` SET TAGS ('dbx_business_glossary_term' = 'Affected Process Areas');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `audit_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `audit_report_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `audit_result` SET TAGS ('dbx_business_glossary_term' = 'Audit Result');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `audit_standard` SET TAGS ('dbx_business_glossary_term' = 'Audit Standard');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `audit_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|report_draft|report_issued|closed|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `audit_team_members` SET TAGS ('dbx_business_glossary_term' = 'Audit Team Members');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal|regulatory|third_party|supplier|customer');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Closure Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'Closure Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `closure_status` SET TAGS ('dbx_value_regex' = 'open|pending_response|under_review|closed|escalated');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `gmp_audit_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `critical_finding_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Finding Count');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `gmp_audit_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `finding_count` SET TAGS ('dbx_business_glossary_term' = 'Finding Count');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `follow_up_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `follow_up_audit_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Scheduled Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `gmp_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `gmp_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Standard Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `gmp_audit_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `observation_count` SET TAGS ('dbx_business_glossary_term' = 'Observation Count');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'compliant|acceptable|needs_improvement|non_compliant|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `total_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `gmp_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Audit Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Batch Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Facility Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `previous_finding_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `affected_process_area` SET TAGS ('dbx_business_glossary_term' = 'Affected Process Area');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `auditor_organization` SET TAGS ('dbx_business_glossary_term' = 'Auditor Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `closure_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Closure Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `audit_finding_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `corrective_action_summary` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Summary');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `audit_finding_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_business_glossary_term' = 'Finding Category');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `finding_classification` SET TAGS ('dbx_business_glossary_term' = 'Finding Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `finding_classification` SET TAGS ('dbx_value_regex' = 'critical|major|minor|observation');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `finding_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}-[0-9]{4,6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `finding_source_document` SET TAGS ('dbx_business_glossary_term' = 'Finding Source Document');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_value_regex' = 'open|under_review|capa_initiated|pending_verification|closed|overdue');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `finding_title` SET TAGS ('dbx_business_glossary_term' = 'Finding Title');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `audit_finding_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `regulatory_response_received_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Response Received Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `regulatory_response_received_date` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `regulatory_response_received_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `repeat_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Finding Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `requirement_reference` SET TAGS ('dbx_business_glossary_term' = 'Requirement Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `responsible_person` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `root_cause_summary` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Summary');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` SET TAGS ('dbx_ssot_concept' = 'supplier_assessment');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` SET TAGS ('dbx_authoritative_source' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `supplier_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Assessment Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `supplier_assessment_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `supplier_assessment_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `supplier_assessment_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `previous_assessment_supplier_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Assessment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Assessor ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `supplier_assessor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `supplier_assessor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `supplier_assessor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|conditional|disqualified|pending_review|suspended');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `approval_valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Valid From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `approval_valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Valid To Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `asl_status` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier List (ASL) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `asl_status` SET TAGS ('dbx_value_regex' = 'active|conditional|blocked|expired|pending');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `assessment_comments` SET TAGS ('dbx_business_glossary_term' = 'Assessment Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `assessment_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Assessment Frequency in Months');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'onsite_audit|remote_audit|document_review|questionnaire|third_party_certification|hybrid');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `assessment_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Assessment Report ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `assessment_scope` SET TAGS ('dbx_business_glossary_term' = 'Assessment Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|approved|rejected|on_hold');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `assessment_team_members` SET TAGS ('dbx_business_glossary_term' = 'Assessment Team Members');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'initial_qualification|periodic_requalification|for_cause_audit|regulatory_triggered|risk_based_review|new_material_qualification');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `capa_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'iso_9001_certified|iso_22716_certified|fsc_certified|rspo_certified|not_certified|certification_expired');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `supplier_assessment_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `delivery_score` SET TAGS ('dbx_business_glossary_term' = 'Delivery Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `supplier_assessment_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `facility_location` SET TAGS ('dbx_business_glossary_term' = 'Facility Location');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `gmp_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `improvement_trend` SET TAGS ('dbx_business_glossary_term' = 'Improvement Trend');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `improvement_trend` SET TAGS ('dbx_value_regex' = 'improving|stable|declining|first_assessment');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `is_approved` SET TAGS ('dbx_business_glossary_term' = 'Is Approved');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `lead_assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Assessor Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `material_categories_assessed` SET TAGS ('dbx_business_glossary_term' = 'Material Categories Assessed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `supplier_assessment_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `next_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Assessment Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `quality_system_score` SET TAGS ('dbx_business_glossary_term' = 'Quality System Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `rating` SET TAGS ('dbx_business_glossary_term' = 'Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `regulatory_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `regulatory_compliance_score` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `regulatory_compliance_score` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Supplier Risk Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `score_scale_max` SET TAGS ('dbx_business_glossary_term' = 'Score Scale Maximum');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `supplier_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` SET TAGS ('dbx_subdomain' = 'deviation_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Product Complaint ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `action_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Action Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `outbound_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Line Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `product_handled_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Handled By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `product_handled_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `product_handled_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `product_handler_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Handler Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `product_handler_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `product_handler_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `product_investigation_assigned_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Assigned Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `product_investigation_assigned_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `product_investigation_assigned_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `product_complaint_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complainant_address` SET TAGS ('dbx_business_glossary_term' = 'Complainant Address');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complainant_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complainant_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complainant_contact` SET TAGS ('dbx_business_glossary_term' = 'Complainant Contact');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complainant_country_code` SET TAGS ('dbx_business_glossary_term' = 'Complainant Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complainant_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complainant_email` SET TAGS ('dbx_business_glossary_term' = 'Complainant Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complainant_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complainant_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complainant_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complainant_name` SET TAGS ('dbx_business_glossary_term' = 'Complainant Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complainant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complainant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complainant_phone` SET TAGS ('dbx_business_glossary_term' = 'Complainant Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complainant_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complainant_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_business_glossary_term' = 'Complaint Category');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_value_regex' = 'foreign_body|contamination|labeling_error|efficacy_failure|packaging_defect|adverse_reaction');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Complaint Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_business_glossary_term' = 'Complaint Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_value_regex' = '^CPL-[0-9]{8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complaint_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Complaint Received Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complaint_source` SET TAGS ('dbx_business_glossary_term' = 'Complaint Source');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complaint_source` SET TAGS ('dbx_value_regex' = 'consumer_direct|retailer|distributor|regulatory_agency|social_media|call_center');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_business_glossary_term' = 'Complaint Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|pending_lab_analysis|resolved|closed|escalated');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complaint_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Complaint Subcategory');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `complaint_type` SET TAGS ('dbx_business_glossary_term' = 'Complaint Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `product_complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$|^[0-9]{12}$|^[0-9]{13}$|^[0-9]{14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `investigation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Investigation Outcome');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|lab_testing|pending_capa|completed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `investigation_summary` SET TAGS ('dbx_business_glossary_term' = 'Investigation Summary');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `is_adverse_event` SET TAGS ('dbx_business_glossary_term' = 'Is Adverse Event');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `is_reportable` SET TAGS ('dbx_business_glossary_term' = 'Is Reportable');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `lab_analysis_result` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analysis Result');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `product_complaint_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `product_complaint_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `regulatory_case_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Case Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `regulatory_case_number` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `regulatory_case_number` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `regulatory_reportable` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `regulatory_reportable` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `regulatory_reportable` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Resolution');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'refund_issued|replacement_sent|no_action_required|product_recall|investigation_ongoing');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `sample_received_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Received Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `sample_returned_flag` SET TAGS ('dbx_business_glossary_term' = 'Sample Returned Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` SET TAGS ('dbx_subdomain' = 'deviation_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_hold_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_hold_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_hold_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_hold_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_hold_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Related Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Related Complaint ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `product_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Related Recall ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `product_recall_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `product_recall_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `actual_release_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `actual_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `affected_material_code` SET TAGS ('dbx_business_glossary_term' = 'Affected Material Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `affected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Affected Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_hold_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_hold_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_hold_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_hold_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_hold_description` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_hold_description` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `expected_release_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Release Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `held_quantity` SET TAGS ('dbx_business_glossary_term' = 'Held Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `held_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Held Quantity Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `hold_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `hold_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `hold_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Duration in Days');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `hold_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_value_regex' = '^RH-[0-9]{8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `hold_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Reason Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `hold_release_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `hold_scope` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `hold_scope` SET TAGS ('dbx_value_regex' = 'batch|sku|material|facility|supplier|product_line');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `hold_start_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `hold_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|under_review|pending_release|released|extended|escalated');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'voluntary|regulatory_mandated|precautionary|recall_related|safety_assessment|quality_investigation');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `initiating_authority` SET TAGS ('dbx_business_glossary_term' = 'Initiating Authority');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `initiating_authority_reference` SET TAGS ('dbx_business_glossary_term' = 'Initiating Authority Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_hold_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_hold_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_hold_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_hold_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_hold_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_hold_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `release_authorization_name` SET TAGS ('dbx_business_glossary_term' = 'Release Authorization Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `release_authorization_title` SET TAGS ('dbx_business_glossary_term' = 'Release Authorization Title');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `release_decision` SET TAGS ('dbx_business_glossary_term' = 'Release Decision');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `release_decision` SET TAGS ('dbx_value_regex' = 'released_approved|rejected_destroyed|reworked|relabeled|downgraded|returned_to_supplier');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `release_justification` SET TAGS ('dbx_business_glossary_term' = 'Release Justification');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `release_reason` SET TAGS ('dbx_business_glossary_term' = 'Release Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `released_by` SET TAGS ('dbx_business_glossary_term' = 'Released By');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `sap_qm_notification_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Quality Management (QM) Notification Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `specification_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `specification_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `specification_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `primary_specification_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Approved By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `primary_specification_approved_by_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Product Formulation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `specification_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `superseded_by_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Specification ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `specification_category` SET TAGS ('dbx_business_glossary_term' = 'Specification Category');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `specification_category` SET TAGS ('dbx_value_regex' = 'physical|chemical|microbiological|sensory|functional|safety');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `coa_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) Inclusion Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `specification_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `critical_quality_attribute_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Quality Attribute (CQA) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `customer_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Requirement Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `specification_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Spec Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `lower_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `specification_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Specification Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Months)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `sampling_plan` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `spec_category` SET TAGS ('dbx_business_glossary_term' = 'Spec Category');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `spec_code` SET TAGS ('dbx_business_glossary_term' = 'Spec Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `spec_name` SET TAGS ('dbx_business_glossary_term' = 'Spec Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `spec_number` SET TAGS ('dbx_business_glossary_term' = 'Spec Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `spec_status` SET TAGS ('dbx_business_glossary_term' = 'Spec Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `spec_type` SET TAGS ('dbx_business_glossary_term' = 'Spec Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `specification_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `specification_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|obsolete');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_business_glossary_term' = 'Specification Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_value_regex' = 'raw_material|packaging_material|in_process|finished_good|intermediate|bulk');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `stability_indicating_flag` SET TAGS ('dbx_business_glossary_term' = 'Stability Indicating Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `test_characteristic` SET TAGS ('dbx_business_glossary_term' = 'Test Characteristic');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `test_equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Required');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `test_frequency` SET TAGS ('dbx_business_glossary_term' = 'Test Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `test_method_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Method Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Spec Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `upper_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` SET TAGS ('dbx_subdomain' = 'laboratory_testing');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `lab_test_request_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Request ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `lab_test_request_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `lab_test_request_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `lab_test_request_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `lab_requestor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `lab_requestor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `lab_requestor_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `quality_stability_study_id` SET TAGS ('dbx_business_glossary_term' = 'Stability Study ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `actual_turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Turnaround Time (TAT) in Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `assigned_lab_code` SET TAGS ('dbx_business_glossary_term' = 'Assigned Laboratory Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `assigned_lab_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Laboratory Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Request Cancellation Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `lab_test_request_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'Completed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `lab_test_request_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `gmp_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `lab_assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Assignment Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `lab_test_request_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `lab_type` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `lab_type` SET TAGS ('dbx_value_regex' = 'internal|external|contract');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `manufacturing_site_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `lab_test_request_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Request Priority Level');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|urgent|critical|regulatory');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `request_notes` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Request Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Request Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^LTR-[0-9]{8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Request Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `request_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Submitted Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Request Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'physical|chemical|microbiological|sensory|stability|regulatory');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `requested_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `requesting_department` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Full Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `required_by_date` SET TAGS ('dbx_business_glossary_term' = 'Required By Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `required_turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Required Turnaround Time (TAT) in Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `result_receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Result Receipt Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `sample_count` SET TAGS ('dbx_business_glossary_term' = 'Sample Count');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `sample_quantity` SET TAGS ('dbx_business_glossary_term' = 'Sample Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `sample_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Sample Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `specification_version` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Version');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `stability_time_point` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Time Point');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Sample Storage Condition');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `supplier_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `test_description` SET TAGS ('dbx_business_glossary_term' = 'Test Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `test_method_reference` SET TAGS ('dbx_business_glossary_term' = 'Analytical Test Method Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `test_panel_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Panel Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `test_panel_description` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Panel Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `test_purpose` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Purpose');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `testing_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Testing Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `turnaround_days` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Days');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` SET TAGS ('dbx_subdomain' = 'deviation_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `notification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `notification_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `notification_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `notification_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `notification_raised_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Raised By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `notification_raised_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `notification_raised_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `notification_recipient_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `notification_recipient_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `notification_recipient_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `primary_notification_closed_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Closed By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `primary_notification_closed_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `primary_notification_closed_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `affected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Affected Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `affected_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Affected Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `affected_quantity_uom` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Assigned To');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `assigned_to_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification Closed Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `notification_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'Completed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `containment_action` SET TAGS ('dbx_business_glossary_term' = 'Containment Action');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `containment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Containment Action Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification Creation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `defect_class` SET TAGS ('dbx_business_glossary_term' = 'Quality Defect Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `defect_class` SET TAGS ('dbx_value_regex' = 'critical|major|minor|cosmetic');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Quality Defect Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `defect_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `notification_description` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Issue Detection Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Quality Issue Detection Source');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `disposition_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Disposition Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `disposition_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposition Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Material Disposition Decision');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'use_as_is|rework|scrap|return_to_supplier|downgrade');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `escalation_level` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `escalation_level` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `material_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,18}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `message_body` SET TAGS ('dbx_business_glossary_term' = 'Message Body');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `notification_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `notification_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `notification_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `notification_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `notification_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_approval|closed|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `notification_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `notification_type` SET TAGS ('dbx_value_regex' = 'complaint|defect|improvement|deviation|audit_finding|supplier_issue');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `plant_name` SET TAGS ('dbx_business_glossary_term' = 'Plant Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Issue Reported Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `required_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Required Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `required_end_date` SET TAGS ('dbx_business_glossary_term' = 'Required End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sent Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Subject');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `control_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Control Chart ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `control_chart_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `control_chart_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `control_chart_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `primary_control_chart_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Control Chart Specification Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `baseline_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `baseline_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `baseline_sample_count` SET TAGS ('dbx_business_glossary_term' = 'Baseline Sample Count');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `center_line` SET TAGS ('dbx_business_glossary_term' = 'Center Line (CL)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `characteristic` SET TAGS ('dbx_business_glossary_term' = 'Characteristic');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'Characteristic Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `chart_code` SET TAGS ('dbx_business_glossary_term' = 'Chart Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `chart_name` SET TAGS ('dbx_business_glossary_term' = 'Chart Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `chart_number` SET TAGS ('dbx_business_glossary_term' = 'Control Chart Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `chart_review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Chart Review Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `chart_status` SET TAGS ('dbx_business_glossary_term' = 'Control Chart Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `chart_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `chart_type` SET TAGS ('dbx_business_glossary_term' = 'Control Chart Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `control_chart_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `control_chart_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `control_limit_calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Control Limit Calculation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `control_limit_calculation_date` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `control_limit_calculation_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `control_limit_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Control Limit Calculation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `control_limit_calculation_method` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `control_limit_calculation_method` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `control_rule_set` SET TAGS ('dbx_business_glossary_term' = 'Control Rule Set');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `cp_value` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cp)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `cpk_value` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cpk)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `control_chart_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `gmp_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `lower_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Spec Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `lower_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `monitored_characteristic` SET TAGS ('dbx_business_glossary_term' = 'Monitored Characteristic');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `control_chart_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `ocap_reference` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Control Action Plan (OCAP) Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `out_of_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Out Of Control Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `ppk_value` SET TAGS ('dbx_business_glossary_term' = 'Process Performance Index (Ppk)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `process_capability_cpk` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Cpk');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `regulatory_requirement_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `regulatory_requirement_reference` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `regulatory_requirement_reference` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `sample_subgroup_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Subgroup Size');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `sampling_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `sap_qm_inspection_characteristic` SET TAGS ('dbx_business_glossary_term' = 'SAP Quality Management (QM) Inspection Characteristic');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `sigma_level` SET TAGS ('dbx_business_glossary_term' = 'Sigma Level');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `subgroup_frequency` SET TAGS ('dbx_business_glossary_term' = 'Subgroup Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `subgroup_size` SET TAGS ('dbx_business_glossary_term' = 'Subgroup Size');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Spec Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `upper_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` SET TAGS ('dbx_subdomain' = 'deviation_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_control_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_control_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_control_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_initiator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiator Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_initiator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_initiator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_requested_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_requested_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_requested_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiator Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Related Nonconformance Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `actual_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Implementation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `affected_facilities` SET TAGS ('dbx_business_glossary_term' = 'Affected Facilities');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `affected_markets` SET TAGS ('dbx_business_glossary_term' = 'Affected Markets');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `affected_products` SET TAGS ('dbx_business_glossary_term' = 'Affected Products');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `approval_workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `approval_workflow_status` SET TAGS ('dbx_value_regex' = 'pending_qa|pending_regulatory|pending_operations|pending_management|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_control_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_justification` SET TAGS ('dbx_business_glossary_term' = 'Change Justification');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_priority` SET TAGS ('dbx_business_glossary_term' = 'Change Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_request_number` SET TAGS ('dbx_business_glossary_term' = 'Change Request Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_request_number` SET TAGS ('dbx_value_regex' = '^CR-[0-9]{6,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_status` SET TAGS ('dbx_business_glossary_term' = 'Change Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_title` SET TAGS ('dbx_business_glossary_term' = 'Change Title');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'formulation|process|equipment|facility|specification|quality_system');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `closure_comments` SET TAGS ('dbx_business_glossary_term' = 'Closure Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_control_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_control_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `effectiveness_review_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `effectiveness_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Outcome');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `effectiveness_review_outcome` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|pending');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `effectiveness_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `final_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `final_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Final Approver Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `gmp_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Gmp Impact Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Initiated Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `initiator_department` SET TAGS ('dbx_business_glossary_term' = 'Initiator Department');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `initiator_name` SET TAGS ('dbx_business_glossary_term' = 'Initiator Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Justification');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_control_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `post_change_verification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Change Verification Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `qa_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `qa_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Approver Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `quality_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Quality Impact Assessment');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `regulatory_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approver Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `regulatory_approver_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `regulatory_approver_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `regulatory_impact_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `regulatory_impact_classification` SET TAGS ('dbx_value_regex' = 'major|moderate|minor|none');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `regulatory_impact_classification` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `regulatory_impact_classification` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `supply_chain_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Impact Assessment');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `target_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Target Implementation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `verification_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `audit_program_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `audit_program_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `audit_program_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `audit_program_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `parent_audit_program_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Audit Program Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `parent_audit_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `audit_category` SET TAGS ('dbx_business_glossary_term' = 'Audit Category');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `audit_criteria` SET TAGS ('dbx_business_glossary_term' = 'Audit Criteria');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `audit_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Audit Duration Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `audit_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Count');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency Months');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `audit_method` SET TAGS ('dbx_business_glossary_term' = 'Audit Method');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `audit_outcome_template` SET TAGS ('dbx_business_glossary_term' = 'Audit Outcome Template');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `audit_outcome_template` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `audit_outcome_template` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `audit_owner` SET TAGS ('dbx_business_glossary_term' = 'Audit Owner');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `audit_program_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `audit_report_format` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Format');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `audit_resources_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Resources Required');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `audit_program_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `completed_audit_count` SET TAGS ('dbx_business_glossary_term' = 'Completed Audit Count');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `compliance_area` SET TAGS ('dbx_business_glossary_term' = 'Compliance Area');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `corrective_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Required');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `audit_program_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `last_executed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Executed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `audit_program_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `next_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `planned_audit_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Audit Count');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `program_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `program_number` SET TAGS ('dbx_business_glossary_term' = 'Program Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `program_scope` SET TAGS ('dbx_business_glossary_term' = 'Program Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `program_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `program_year` SET TAGS ('dbx_business_glossary_term' = 'Program Year');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Standard Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `version_description` SET TAGS ('dbx_business_glossary_term' = 'Version Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `audit_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Checklist Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `audit_checklist_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `audit_checklist_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `audit_checklist_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `audit_program_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `gmp_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Gmp Audit Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `parent_audit_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Audit Checklist Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `parent_audit_checklist_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `applicable_process` SET TAGS ('dbx_business_glossary_term' = 'Applicable Process');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `audit_checklist_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `audit_checklist_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `checklist_category` SET TAGS ('dbx_business_glossary_term' = 'Checklist Category');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `checklist_code` SET TAGS ('dbx_business_glossary_term' = 'Checklist Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `checklist_name` SET TAGS ('dbx_business_glossary_term' = 'Checklist Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `checklist_number` SET TAGS ('dbx_business_glossary_term' = 'Checklist Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `checklist_status` SET TAGS ('dbx_business_glossary_term' = 'Checklist Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `checklist_type` SET TAGS ('dbx_business_glossary_term' = 'Checklist Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `checklist_version` SET TAGS ('dbx_business_glossary_term' = 'Checklist Version');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `audit_checklist_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `compliance_area` SET TAGS ('dbx_business_glossary_term' = 'Compliance Area');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `audit_checklist_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `item_count` SET TAGS ('dbx_business_glossary_term' = 'Item Count');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `item_number` SET TAGS ('dbx_business_glossary_term' = 'Item Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `audit_checklist_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `question_category` SET TAGS ('dbx_business_glossary_term' = 'Question Category');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `question_count` SET TAGS ('dbx_business_glossary_term' = 'Question Count');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `question_number` SET TAGS ('dbx_business_glossary_term' = 'Question Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `question_text` SET TAGS ('dbx_business_glossary_term' = 'Question Text');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `regulatory_standard` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Standard');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `regulatory_standard` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `regulatory_standard` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `requirement_reference` SET TAGS ('dbx_business_glossary_term' = 'Requirement Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `response` SET TAGS ('dbx_business_glossary_term' = 'Response');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `responsible_role` SET TAGS ('dbx_business_glossary_term' = 'Responsible Role');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `scoring_method` SET TAGS ('dbx_business_glossary_term' = 'Scoring Method');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `total_possible_score` SET TAGS ('dbx_business_glossary_term' = 'Total Possible Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `weight` SET TAGS ('dbx_business_glossary_term' = 'Weight');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` SET TAGS ('dbx_subdomain' = 'laboratory_testing');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Manager Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `laboratory_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `laboratory_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `laboratory_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `supervising_laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Supervising Laboratory Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `supervising_laboratory_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `accreditation_expiry` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiry');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `accreditation_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `accreditation_standard` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Standard');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `address_city` SET TAGS ('dbx_business_glossary_term' = 'Address City');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `address_city` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `address_city` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `address_country` SET TAGS ('dbx_business_glossary_term' = 'Address Country');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `address_country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `address_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `capability_scope` SET TAGS ('dbx_business_glossary_term' = 'Capability Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `capacity_per_day` SET TAGS ('dbx_business_glossary_term' = 'Capacity Per Day');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `capacity_per_day` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `capacity_per_day` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `laboratory_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `laboratory_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `gmp_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Gmp Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `hazard_level` SET TAGS ('dbx_business_glossary_term' = 'Hazard Level');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `is_external` SET TAGS ('dbx_business_glossary_term' = 'Is External');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `is_external_flag` SET TAGS ('dbx_business_glossary_term' = 'Is External Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `is_gmp_certified` SET TAGS ('dbx_business_glossary_term' = 'Is Gmp Certified');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `is_iso17025_accredited` SET TAGS ('dbx_business_glossary_term' = 'Is Iso17025 Accredited');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `lab_code` SET TAGS ('dbx_business_glossary_term' = 'Lab Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `lab_name` SET TAGS ('dbx_business_glossary_term' = 'Lab Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `lab_status` SET TAGS ('dbx_business_glossary_term' = 'Lab Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `lab_type` SET TAGS ('dbx_business_glossary_term' = 'Lab Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `laboratory_status` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `laboratory_type` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `last_audit_result` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Result');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `latitude` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'Location City');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `location_city` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `location_city` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `location_country` SET TAGS ('dbx_business_glossary_term' = 'Location Country');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `longitude` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `laboratory_name` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `number_of_equipment` SET TAGS ('dbx_business_glossary_term' = 'Number Of Equipment');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `operational_hours` SET TAGS ('dbx_business_glossary_term' = 'Operational Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `total_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Total Area Sqm');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `waste_disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposal Method');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` SET TAGS ('dbx_subdomain' = 'laboratory_testing');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` SET TAGS ('dbx_ssot' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` SET TAGS ('dbx_data_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` SET TAGS ('dbx_data_steward' = 'quality_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` SET TAGS ('dbx_mvm' = 'managed');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` SET TAGS ('dbx_governed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` SET TAGS ('dbx_ecm_curated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` SET TAGS ('dbx_governance' = 'ssot');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `sample_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `sample_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `sample_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `parent_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Sample Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `parent_sample_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sampled By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `sample_collected_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Collected By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `sample_collected_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `sample_collected_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `analysis_result` SET TAGS ('dbx_business_glossary_term' = 'Analysis Result');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `analysis_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `analyst_name` SET TAGS ('dbx_business_glossary_term' = 'Analyst Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `analyst_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `analyst_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `sample_code` SET TAGS ('dbx_business_glossary_term' = 'Sample Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `collected_by` SET TAGS ('dbx_business_glossary_term' = 'Collected By');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `collected_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `collected_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `collected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collected Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `collection_location` SET TAGS ('dbx_business_glossary_term' = 'Collection Location');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `collection_point` SET TAGS ('dbx_business_glossary_term' = 'Collection Point');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collection Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `condition` SET TAGS ('dbx_business_glossary_term' = 'Sample Condition');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `sample_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `disposed_date` SET TAGS ('dbx_business_glossary_term' = 'Disposed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `is_control` SET TAGS ('dbx_business_glossary_term' = 'Is Control');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `is_retest` SET TAGS ('dbx_business_glossary_term' = 'Is Retest');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `sample_name` SET TAGS ('dbx_business_glossary_term' = 'Sample Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `result_unit` SET TAGS ('dbx_business_glossary_term' = 'Result Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `result_value` SET TAGS ('dbx_business_glossary_term' = 'Result Value');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `retention_period_months` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Months');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `retention_sample_flag` SET TAGS ('dbx_business_glossary_term' = 'Retention Sample Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `sample_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `sample_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature C');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Volume Ml');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `weight_g` SET TAGS ('dbx_business_glossary_term' = 'Weight G');
