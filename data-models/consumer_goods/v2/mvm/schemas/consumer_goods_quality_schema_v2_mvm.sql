-- Schema for Domain: quality | Business: Consumer_Goods | Version: v2_mvm
-- Generated on: 2026-06-27 07:48:17

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`quality` COMMENT 'Owns quality assurance, quality control, and GMP compliance data across the product lifecycle. Manages QC inspection results, non-conformance records, CAPA processes, batch release decisions, stability studies, certificate of analysis, GMP audit findings, supplier quality assessments, product complaints, and regulatory hold events. Integrates with SAP QM and Veeva Vault.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` (
    `inspection_plan_id` BIGINT COMMENT 'Unique identifier for the inspection plan. Primary key for the inspection plan master data entity.',
    `approved_supplier_list_id` BIGINT COMMENT 'Foreign key linking to procurement.approved_supplier_list. Business justification: Supplier qualification process: inspection plans are assigned based on ASL qualification level (e.g., AQL severity tied to supplier approval tier). QA teams need to know which ASL entry a plan was des',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Inspection plans govern inbound receiving quality checks at distribution centers. Consumer goods DCs maintain facility-specific AQL levels and sampling procedures. This FK scopes inspection plans to d',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to manufacturing.equipment. Business justification: Inspection plans specify which calibrated test equipment must be used, driving equipment scheduling and calibration compliance verification. inspection_plan has test_equipment_required as plain text (',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.product_formulation. Business justification: GMP in-process and finished goods inspection plans reference the approved formulation to define test parameters (pH, viscosity, active ingredient content) and acceptance criteria. Standard consumer go',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Goods receipt quality inspection for raw/packaging materials requires material-level inspection plans. inspection_plan has sku_id for finished goods but no material_id. Standard SAP QM MM integration:',
    `packaging_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_packaging_spec. Business justification: Packaging incoming inspection requires linking the inspection plan to the packaging specification to define acceptance criteria (dimensions, material composition, print quality) for each packaging com',
    `sku_id` BIGINT COMMENT 'Reference to the material (raw material, packaging component, intermediate, or finished good) that this inspection plan applies to.',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: Major retail accounts (Walmart, Costco, Kroger) in CPG mandate customer-specific quality inspection plans as a contractual requirement. QA teams must associate inspection plans with the trade account ',
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
    `approved_supplier_list_id` BIGINT COMMENT 'Foreign key linking to procurement.approved_supplier_list. Business justification: Supplier qualification traceability: the ASL entry active at time of receipt determines inspection requirements. Regulatory audits require proof that the supplier was on the approved list when the lot',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: QC inspection costs (labor, consumables, equipment time) are charged to a cost center in SAP QM/CO integration. Consumer goods QC departments track inspection cost per lot against their cost center bu',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Inspection lots created during inbound receiving at a DC must reference that distribution facility. The existing manufacturing_facility_id covers factory-origin lots; this FK covers DC-origin lots, en',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Core QM process: in SAP QM and equivalent systems, a goods receipt event directly triggers creation of an inspection lot. Tracing inspection_lot back to the specific goods_receipt is fundamental for i',
    `inspection_plan_id` BIGINT COMMENT 'Identifier of the inspection plan template applied to this lot. Defines the characteristics to be inspected, sampling procedures, and acceptance criteria.',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Goods receipt inspection for raw/packaging materials creates inspection lots against the material master. inspection_lot has sku_id for finished goods but no material_id for raw/packaging materials. E',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: Incoming inspection is triggered at PO line level (specific material/quantity). Linking inspection_lot to po_line enables line-level quality traceability, accepted/rejected quantity reconciliation aga',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_line. Business justification: In-process inspection lots in consumer goods manufacturing are tied to the production line being monitored for IPC compliance. Line-level inspection lot tracking enables production line quality perfor',
    `sku_id` BIGINT COMMENT 'Identifier of the material (raw material, semi-finished good, or finished good) being inspected in this lot.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_storage_location. Business justification: Inspection lots are physically held in quarantine storage locations during inspection. WMS quarantine management and FEFO/FIFO compliance require a proper FK to the storage location, replacing the den',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier or vendor for goods receipt inspection lots. Used for supplier quality performance tracking.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Supplier site-level quality performance reporting: consumer goods companies track inspection results by supplier site (not just supplier) to identify site-specific quality issues and schedule site aud',
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
    `inspection_lot_name` STRING COMMENT 'Attribute name of quality.inspection_lot.',
    `notes` STRING COMMENT 'Attribute notes of quality.inspection_lot.',
    `origin` STRING COMMENT 'Attribute inspection_lot_origin of quality.inspection_lot.',
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
    `nonconformance_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance. Business justification: An out-of-specification inspection result is the direct trigger for raising a nonconformance record. This FK links the specific measurement result (with its deviation_code, defect_classification, defe',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Link inspection_result to its governing specification for easy access to spec limits and versioning.',
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
    `capa_id` BIGINT COMMENT 'Reference to the CAPA record initiated as a result of this usage decision, if applicable. Null if no CAPA was required.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Usage decisions triggering scrap, rework, or destruction post costs to a cost center (scrap account, rework cost center). Consumer goods operations track disposition costs by cost center for variance ',
    `inbound_receipt_line_id` BIGINT COMMENT 'Foreign key linking to distribution.inbound_receipt_line. Business justification: Usage decisions (accept/reject/rework) directly govern disposition of inbound receipt lines — stock posting, quarantine, or supplier return. QA and logistics teams jointly use this link for GMP dispos',
    `inspection_lot_id` BIGINT COMMENT 'Reference to the inspection lot for which this usage decision was made. Links to the QC inspection lot that was evaluated.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Usage decisions in SAP QM trigger automatic goods movement postings (QI stock → unrestricted/scrap/rework) that generate journal entries. Linking usage_decision to journal_entry enables financial audi',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Usage decisions (accept/reject/rework) on inspection lots directly trigger logistics actions: shipment holds, returns, or release for distribution. Linking usage_decision to logistics_shipment enables',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Material disposition process (accept/reject/rework) for incoming raw/packaging materials requires linking usage decisions to the material master for inventory stock posting and supplier feedback. usag',
    `nonconformance_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance. Business justification: A usage decision resulting in rejection or rework disposition directly triggers a nonconformance record. This FK links the usage decision (with its disposition, rejected_quantity, rework_quantity) to ',
    `sku_id` BIGINT COMMENT 'Reference to the material or product that was inspected and for which the usage decision applies.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_storage_location. Business justification: Usage decisions include stock_posting_instruction directing material to a specific storage location (quarantine, blocked, or available). Formalizing this FK replaces the denormalized storage_location_',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor who provided the material, if applicable. Used for supplier quality management and vendor scorecarding.',
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
    `certificate_of_analysis_id` BIGINT COMMENT 'Foreign key linking to quality.certificate_of_analysis. Business justification: A nonconformance raised during batch review or incoming goods inspection may reference the Certificate of Analysis for the implicated batch. This FK enables QA to directly access the CoA from the nonc',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost of quality report allocates nonconformance financial impact to responsible cost center for internal cost tracking.',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Nonconformances detected at distribution centers (e.g., storage failures, picking damage, temperature excursions) must reference the DC where detected. The existing manufacturing_facility_id covers fa',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to manufacturing.equipment. Business justification: Equipment failures are a primary root cause category for nonconformances in consumer goods manufacturing. Linking NCs to specific equipment enables equipment reliability analysis, drives maintenance C',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.product_formulation. Business justification: Formulation deviation management requires linking NCs to the specific product formulation version when in-process failures (out-of-spec pH, viscosity, active ingredient content) occur. Supports root c',
    `inspection_lot_id` BIGINT COMMENT 'Inspection Lot Id referencing quality.inspection_lot.inspection_lot_id.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Nonconformances with financial impact (scrap write-offs, material destruction, rework costs) generate journal entries. nonconformance already has financial_impact_amount, confirming financial posting ',
    `label_spec_id` BIGINT COMMENT 'Foreign key linking to product.label_spec. Business justification: Label quality management requires raising NCs against specific label specifications when label defects (regulatory text errors, artwork deviations, missing allergen warnings) are detected during inspe',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_brand. Business justification: Brand protection and recall risk management require nonconformance events to be tracked by brand. Brand managers and QA teams use brand-level nonconformance reporting for regulatory submissions, brand',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Supplier quality management requires raising nonconformances against specific raw/packaging materials when they fail incoming inspection. nonconformance has sku_id for finished goods but no material_i',
    `packaging_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_packaging_spec. Business justification: Packaging quality management requires raising NCs against specific packaging specifications when components fail dimensional, material, or print quality requirements. Enables packaging supplier qualit',
    `product_complaint_id` BIGINT COMMENT 'Foreign key reference to the customer complaint record that triggered this nonconformance, when applicable. Links to consumer complaint tracking system.',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_line. Business justification: Nonconformances in consumer goods manufacturing are attributed to specific production lines for root cause analysis, line performance KPIs, and OEE quality component reporting. Quality managers need N',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Non‑conformance events are tied to the SKU that caused the issue, enabling targeted CAPA and impact analysis.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: A nonconformance is raised when a material or process deviates from a defined quality specification. Linking nonconformance directly to specification enables QA to identify which specification was vio',
    `supplier_id` BIGINT COMMENT 'Foreign key reference to the supplier associated with this nonconformance, applicable when the issue originates from supplier-provided materials or components. Links to supplier master data.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Site-level nonconformance tracking is standard in consumer goods supplier quality management. Multi-site suppliers require site-specific NC metrics for audit scheduling and site performance scorecards',
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
    `approved_supplier_list_id` BIGINT COMMENT 'Foreign key linking to procurement.approved_supplier_list. Business justification: Supplier re-qualification process: CAPAs issued to suppliers often require completion before ASL status is restored or upgraded. Linking CAPA to the specific ASL entry enables tracking of qualificatio',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: CAPAs are frequently initiated against carriers for recurring logistics quality failures (damage rates, temperature excursions, OTIF failures). capa already has supplier_id but carriers are distinct m',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CAPA cost impact must be charged to a cost center for budgeting and expense analysis.',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: CAPAs initiated from distribution-related nonconformances (storage failures, mispicks, cold chain breaks) must reference the originating DC. The existing manufacturing_facility_id covers factory CAPAs',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to manufacturing.equipment. Business justification: Equipment-related CAPAs (triggered by equipment failures causing quality events) must reference the specific equipment to drive preventive maintenance scheduling, requalification, and effectiveness ve',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.product_formulation. Business justification: Formulation change control requires linking CAPAs to the specific formulation version that triggered the quality failure (stability failure, ingredient nonconformance). Enables root cause analysis and',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: CAPA implementation costs (investigation, process changes, retraining, equipment upgrades) are posted as journal entries. capa already has cost_impact_amount and cost_impact_currency_code, confirming ',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Supplier corrective action process for raw/packaging material quality failures requires linking CAPAs to the material master. capa has sku_id for finished goods but no material_id. Enables material-le',
    `nonconformance_id` BIGINT COMMENT 'Nonconformance Id referencing quality.nonconformance.nonconformance_id.',
    `sku_id` BIGINT COMMENT 'Identifier of the product affected by or related to this CAPA. Links to the product master data.',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: CAPA actions often stem from supplier contract obligations; linking ensures contract compliance tracking and auditability of corrective measures.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier associated with the CAPA, if the issue originated from supplier-provided materials or services.',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_center. Business justification: CAPAs in consumer goods GMP manufacturing are scoped to specific work centers for effectiveness verification and requalification. capa has process_area as plain text (denormalized work center referenc',
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
    `certificate_of_analysis_id` BIGINT COMMENT 'Attribute certificate_of_analysis_id of quality.batch_release.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Batch release decisions are based on the manufacturing batch record; linking ensures release status reflects the underlying production data and supports regulatory audit trails.',
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.capa. Business justification: A batch release may be conditioned on or associated with a CAPA when deviations are found during batch review. batch_release.capa_required_flag (BOOLEAN) indicates a CAPA is needed, but the FK to capa',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Batch release activities (QP certification, lab testing, QA sign-off) incur costs charged to the QA/QC cost center. In regulated consumer goods (OTC, personal care), batch release cost tracking by cos',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Batch release decisions are scoped to the distribution facility from which the batch will be dispatched. Regulatory market traceability and OTIF compliance reporting require linking each batch release',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.product_formulation. Business justification: GMP batch release requires verifying the batch was produced against the approved formulation version. This FK enables batch record review to confirm formulation compliance, supporting QP certification',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: In consumer goods (food, personal care, OTC), batch release for incoming raw materials/packaging is triggered post-goods-receipt. Linking batch_release to goods_receipt enables end-to-end traceability',
    `inspection_lot_id` BIGINT COMMENT 'Attribute inspection_lot_id of quality.batch_release.',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: GMP batch release decisions govern whether an outbound shipment can proceed. QA and logistics teams use this link for batch-release-to-shipment traceability reports, regulatory audits, and shipment ho',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_brand. Business justification: Batch release decisions are brand-specific in consumer goods — QA releases product by brand for market launch timing, regulatory market clearance, and brand-level quality KPI reporting. Brand teams tr',
    `packaging_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_packaging_spec. Business justification: GMP batch release requires confirming the packaging used matches the approved packaging specification. This FK enables batch record review to verify correct packaging was used, supporting GMP complian',
    `primary_batch_release_certificate_of_analysis_id` BIGINT COMMENT 'Foreign key linking to quality.certificate_of_analysis. Business justification: Link batch_release to the Certificate of Analysis that documents the released batch, removing redundant reference number.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Batch release is the quality disposition of a production orders output. Release reports in consumer goods directly reference production order numbers for regulatory submissions and customer COA reque',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Batch release reports require linking each release to the specific SKU for traceability, regulatory filing, and inventory reconciliation.',
    `usage_decision_id` BIGINT COMMENT 'Foreign key linking to quality.usage_decision. Business justification: A batch release decision is the formal QP-level authorization that follows the usage decision on the inspection lot. Linking batch_release directly to usage_decision enables traceability from the rele',
    `amount` DECIMAL(18,2) COMMENT 'Attribute amount of quality.batch_release.',
    `audit_trail_reference` STRING COMMENT 'Reference to the complete audit trail log for all actions and approvals related to this batch release. Required for 21 CFR Part 11 compliance.. Valid values are `^AUDIT-[A-Z0-9]{8,20}$`',
    `batch_number` STRING COMMENT 'Attribute batch_number of quality.batch_release.',
    `batch_release_status` STRING COMMENT 'Attribute status of quality.batch_release.',
    `batch_size_quantity` DECIMAL(18,2) COMMENT 'Total quantity of finished goods produced in this batch. Used for yield calculation and inventory planning.',
    `batch_size_uom` STRING COMMENT 'Unit of measure for the batch size quantity (e.g., kilograms, liters, units). Aligns with GS1 standards for trade item measurement. [ENUM-REF-CANDIDATE: kg|lbs|liters|gallons|units|cases|pallets — 7 candidates stripped; promote to reference product]',
    `capa_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a CAPA investigation is required based on deviations or non-conformances identified during batch production or testing.',
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
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: COAs accompany incoming shipments and are matched to goods receipts during incoming inspection. goods_receipt has certificate_of_analysis_received_flag (denormalized). Linking COA to goods_receipt ena',
    `inspection_lot_id` BIGINT COMMENT 'Attribute inspection_lot_id of quality.certificate_of_analysis.',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Supplier CoA management for raw/packaging materials requires linking each CoA to the material master for incoming inspection validation and material release decisions. Standard SAP QM incoming goods p',
    `sku_id` BIGINT COMMENT 'Sku Id referencing product.sku.sku_id.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: A Certificate of Analysis documents test results evaluated against a specific quality specification. The FK to specification normalizes the relationship and enables direct retrieval of acceptance crit',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: COA must reference the supplier of the batch for traceability and regulatory compliance; supplier_name is replaced by FK.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: COAs identify the supplier manufacturing/testing site that produced and tested the batch. certificate_of_analysis has denormalized manufacturing_site_code and manufacturing_site_name; replacing with s',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` (
    `product_complaint_id` BIGINT COMMENT 'Unique identifier for the product complaint record. Primary key.',
    `certificate_of_analysis_id` BIGINT COMMENT 'Foreign key linking to quality.certificate_of_analysis. Business justification: During product complaint investigation, QA retrieves the Certificate of Analysis for the implicated batch to verify test results and specification conformance. This FK enables direct traceability from',
    `label_spec_id` BIGINT COMMENT 'Foreign key linking to product.label_spec. Business justification: Regulatory reporting for labeling complaints (missing allergen warnings, incorrect ingredient declarations) requires linking complaints to the specific label specification version. Supports label reca',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand Complaint Dashboard requires linking complaints to the brand to monitor reputation and adjust campaigns.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: CPG complaint investigations require tracing the specific sales order that delivered the complained-about product to identify shipment date, lot, and distribution path. The complaint investigation p',
    `outbound_order_line_id` BIGINT COMMENT 'Foreign key linking to distribution.outbound_order_line. Business justification: Required for complaint traceability: product complaint must reference the outbound order line that delivered the product, allowing root cause analysis and customer service reporting.',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`specification` (
    `specification_id` BIGINT COMMENT 'Unique identifier for the quality specification record. Primary key for this entity.',
    `approved_supplier_list_id` BIGINT COMMENT 'Foreign key linking to procurement.approved_supplier_list. Business justification: Supplier qualification requires documenting which material specification the supplier was qualified against. The ASL entry references the approved specification version. Linking specification to ASL e',
    `formulation_id` BIGINT COMMENT 'Attribute product_formulation_id of product.specification.',
    `inspection_plan_id` BIGINT COMMENT 'Reference to the SAP QM inspection plan that uses this specification. Links specification to operational quality control procedures.',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Raw material and packaging material quality specifications must reference the material master to drive incoming inspection plans and CoA validation. specification has sku_id FKs for finished goods but',
    `sku_id` BIGINT COMMENT 'Reference to the material or product this specification applies to. Links to the master material record in SAP MM.',
    `specification_sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Quality specifications are defined per SKU to ensure manufacturing compliance and product release criteria.',
    `superseded_by_specification_id` BIGINT COMMENT 'Reference to the newer specification that replaces this one when status is superseded. Maintains specification version lineage.',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_product_complaint_id` FOREIGN KEY (`product_complaint_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`product_complaint`(`product_complaint_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_primary_batch_release_certificate_of_analysis_id` FOREIGN KEY (`primary_batch_release_certificate_of_analysis_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_usage_decision_id` FOREIGN KEY (`usage_decision_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`usage_decision`(`usage_decision_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_superseded_by_specification_id` FOREIGN KEY (`superseded_by_specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `approved_supplier_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier List Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Product Formulation Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Packaging Spec Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `usage_indicator` SET TAGS ('dbx_business_glossary_term' = 'Usage Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `approved_supplier_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier List Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `origin` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Origin');
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
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_result_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_result_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_result_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_result_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result Specification Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `usage_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `usage_decision_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `usage_decision_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `usage_decision_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `inbound_receipt_line_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Line Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
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
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `ud_code` SET TAGS ('dbx_business_glossary_term' = 'Ud Code');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `usage_decision_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `certificate_of_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Analysis Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Product Formulation Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `label_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Label Spec Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Packaging Spec Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `capa_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `capa_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `capa_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `approved_supplier_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier List Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Product Formulation Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Release ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_release_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_release_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_release_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `certificate_of_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Analysis Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Product Formulation Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Packaging Spec Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `primary_batch_release_certificate_of_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Release Certificate Of Analysis Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `usage_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_value_regex' = '^AUDIT-[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_release_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_size_quantity` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `batch_size_uom` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
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
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_of_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_of_analysis_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_of_analysis_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_of_analysis_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Product Complaint ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `certificate_of_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Analysis Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `label_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Label Spec Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `outbound_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Line Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `specification_id` SET TAGS ('dbx_ssot_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `specification_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `specification_id` SET TAGS ('dbx_ssot' = 'key');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `approved_supplier_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier List Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Product Formulation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `specification_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `superseded_by_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Specification ID');
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
