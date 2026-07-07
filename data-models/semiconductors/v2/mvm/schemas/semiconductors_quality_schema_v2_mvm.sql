-- Schema for Domain: quality | Business: Semiconductors | Version: v2_mvm
-- Generated on: 2026-06-27 11:14:02

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`quality` COMMENT 'Quality assurance, reliability testing, defect inspection, metrology, DPPM tracking, FMEA, and qualification programs. Manages KGD certification, yield analysis, customer quality notifications, and compliance with ISO 9001, IATF 16949, and JEDEC reliability standards. Integrates with KLA ICOS inspection systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` (
    `inspection_lot_id` BIGINT COMMENT 'Unique identifier for the inspection lot record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Required for the Inspection Lot Customer Assignment report, tying each lot’s inspection results to the purchasing customer for traceability, billing, and compliance.',
    `calibration_record_id` BIGINT COMMENT 'Foreign key linking to equipment.calibration_record. Business justification: ISO 9001 and IATF 16949 require traceability from measurement results to the calibration record active at time of inspection. This named regulatory audit trail requirement links each inspection lot to',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Inspection lot reports are generated per IC part; linking to ic_catalog enables traceability for compliance and lot‑by‑lot quality reports.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Inspection Lot Report requires linking each lot to the Fab Tool used for inspection to ensure traceability and compliance.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Chamber-level inspection traceability is required for SPC and IATF 16949 audits. Existing FK only reaches fab_tool level; chamber-specific measurement attribution enables chamber-to-chamber variation ',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Inspection sampling plans, defect density acceptance criteria, and AQL levels are process-node-specific in semiconductor manufacturing. technology_node plain string is a denormalization replaced by ',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: An inspection lot is evaluated against a quality specification that defines acceptance criteria, measurement methods, and control limits. This FK links the inspection lot to the governing spec, enabli',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to inventory.raw_material. Business justification: Incoming quality control inspection lots are created for raw materials (silicon wafer substrates, process chemicals, gases) before they enter production. Semiconductor fabs require raw material inspec',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Inspection lot tracking ties each lot to the specific process step being inspected, required for lot‑by‑step quality dashboards.',
    `tool_qualification_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_qualification. Business justification: IATF 16949 and SEMI standards require that inspection results reference the tool qualification status active at time of measurement. This traceability link answers the audit question: was the measurem',
    `acceptance_criteria` STRING COMMENT 'Maximum defect count allowed for acceptance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection lot record was created.',
    `defect_count` STRING COMMENT 'Total number of defects detected in the lot.',
    `defect_density` DECIMAL(18,2) COMMENT 'Defects per unit area metric for the lot.',
    `disposition` STRING COMMENT 'Final disposition assigned to the lot after inspection.. Valid values are `accept|reject|hold|rework`',
    `disposition_reason` STRING COMMENT 'Explanation for the chosen disposition.',
    `external_lot_code` STRING COMMENT 'External reference code used by suppliers or customers.',
    `iatf_16949_compliant` BOOLEAN COMMENT 'Indicates compliance with IATF 16949 automotive quality standards.',
    `inspection_lot_status` STRING COMMENT 'Current lifecycle status of the inspection lot.. Valid values are `open|in_progress|completed|closed|cancelled`',
    `inspection_result` STRING COMMENT 'Overall outcome of the inspection.. Valid values are `pass|fail|conditional`',
    `inspection_stage` STRING COMMENT 'Process stage at which the inspection occurs.. Valid values are `iqc|feol|beol|packaging|final`',
    `inspection_type` STRING COMMENT 'Category of inspection performed on the lot.. Valid values are `visual|metrology|electrical|functional|chemical`',
    `iso_9001_compliant` BOOLEAN COMMENT 'Indicates compliance with ISO 9001 quality management.',
    `jedec_reliability_compliant` BOOLEAN COMMENT 'Indicates compliance with JEDEC reliability specifications.',
    `kgd_certification_date` DATE COMMENT 'Date when KGD certification was granted.',
    `kgd_certified` BOOLEAN COMMENT 'Flag indicating whether the lot contains KGD‑certified dies.',
    `last_modified_by` STRING COMMENT 'User name of the person who last modified the record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the inspection lot record in the quality domain.',
    `lot_size` BIGINT COMMENT 'Total number of units (wafers, dies, or packaged parts) in the lot.',
    `lot_type` STRING COMMENT 'Classification of the lot based on its position in the workflow.. Valid values are `incoming|in_process|final|rework|hold`',
    `material_type` STRING COMMENT 'Type of material the lot consists of.. Valid values are `wafer|mask|chemical|gas|assembly`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Timestamp of the primary measurement taken during inspection.',
    `measurement_unit` STRING COMMENT 'Unit of the measured value.. Valid values are `nm|um|mm|percent|count`',
    `measurement_value` DECIMAL(18,2) COMMENT 'Numeric value of the key measurement (e.g., critical dimension).',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the inspection lot.',
    `quality_engineer` STRING COMMENT 'Name of the quality engineer responsible for the lot.',
    `record_audit_created` TIMESTAMP COMMENT 'The record audit created of the inspection lot record in the quality domain.',
    `record_audit_updated` TIMESTAMP COMMENT 'The record audit updated of the inspection lot record in the quality domain.',
    `rejection_criteria` STRING COMMENT 'Defect count threshold that triggers rejection.',
    `sample_size` STRING COMMENT 'Number of units sampled from the lot.',
    `sampling_plan_aql` STRING COMMENT 'AQL value defined for the sampling plan.',
    `unit_of_measure` STRING COMMENT 'Unit used to quantify the lot size.. Valid values are `wafer|die|unit`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `wafer_size_mm` DECIMAL(18,2) COMMENT 'Diameter of wafers in the lot, expressed in millimetres.',
    `yield_percent` DECIMAL(18,2) COMMENT 'Percentage of good units produced from the lot.',
    CONSTRAINT pk_inspection_lot PRIMARY KEY(`inspection_lot_id`)
) COMMENT 'Quality inspection lot for incoming, in-process, or outgoing material with sampling plan and disposition tracking.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` (
    `defect_record_id` BIGINT COMMENT 'Unique identifier for the defect record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Enables the Defect Ownership Tracking process, linking each defect to the responsible customer account for warranty claims and customer notifications.',
    `booking_id` BIGINT COMMENT 'Foreign key linking to sales.booking. Business justification: Warranty claim analysis requires linking each defect to the original customer booking for liability and cost recovery.',
    `calibration_record_id` BIGINT COMMENT 'Foreign key linking to equipment.calibration_record. Business justification: Measurement System Analysis (MSA) under IATF 16949 requires traceability from defect detection records to the calibration record of the detection instrument. This link validates that defect measuremen',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Defect Analysis Report ties each defect to the detecting Fab Tool for root‑cause analysis and corrective action planning.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Defects must be attributed to the specific chamber that detected or induced them. Chamber-level defect attribution is essential for identifying chamber-specific contamination or process drift in root ',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Defect records in wafer fab are associated with a specific IC design for yield analysis, design-for-manufacturability feedback, and process improvement programs. Defect Pareto by IC catalog entry is a',
    `inspection_lot_id` BIGINT COMMENT 'FK to quality.inspection_lot.inspection_lot_id — Every defect is detected within an inspection lot. This is the fundamental parent-child relationship for defect tracking. Without this FK, defects cannot be traced to their inspection context.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Defect Tracking & Recall Management uses the inventory lot ID to locate and quarantine affected stock across the supply chain.',
    `ip_core_id` BIGINT COMMENT 'Foreign key linking to design.ip_core. Business justification: Needed for Defect Attribution Report to associate each defect with the specific IP core block used in the design, enabling targeted remediation.',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: A defect observation record can trigger or be formally documented in a nonconformance report. This FK provides direct traceability from the individual defect record to the NCR that was raised as a res',
    `wafer_map_id` BIGINT COMMENT 'FK to quality.wafer_map.wafer_map_id — Defects with X/Y coordinates must link to the wafer map for spatial analysis. This is critical for systematic defect pattern detection.',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to process.recipe. Business justification: Defect analysis reports need the recipe used during the step to correlate process parameters with defect types.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: A defect is detected as a deviation from a quality specification. Linking defect_record to quality_spec enables analysis of which specifications are most frequently violated, supports DPPM tracking ag',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Root cause analysis requires linking each defect record to the exact process step where the defect originated, used in RCA reports.',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: Root cause analysis reports in semiconductor fabs routinely correlate defect spikes with preceding maintenance events (chamber cleans, part replacements). This direct link enables the standard fab eng',
    `wafer_id` BIGINT COMMENT 'Identifier of the wafer on which the defect was observed.',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: Defects detected during wafer probe must be traceable to the specific probe run for failure analysis and yield excursion investigation. Quality engineers require this link for defect-to-test-run trace',
    `bin_assignment` STRING COMMENT 'Pass/fail bin code assigned to the die (e.g., P, F1, F2).',
    `classification_method` STRING COMMENT 'The classification method of the defect record record in the quality domain.',
    `comments` STRING COMMENT 'Additional free‑form notes from the inspector or analyst.',
    `corrective_action` STRING COMMENT 'Planned or executed action to remediate the defect.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the defect record record in the quality domain.',
    `defect_area_um2` DOUBLE COMMENT 'Calculated area of the defect in square micrometers.',
    `defect_category` STRING COMMENT 'The defect category of the defect record record in the quality domain.',
    `defect_classification` STRING COMMENT 'High‑level classification of the defect (e.g., particle, patterning, etch).',
    `defect_code` STRING COMMENT 'Standardized code representing the defect type (e.g., D001, D002).',
    `defect_density_per_zone` DOUBLE COMMENT 'Number of defects per unit area within the zone.',
    `defect_layer` STRING COMMENT 'Process layer where the defect was found.. Valid values are `feol|mol|beol|passivation|metal`',
    `defect_record_status` STRING COMMENT 'The status of the defect record record in the quality domain.',
    `defect_severity` STRING COMMENT 'Severity rating indicating impact on yield.. Valid values are `critical|major|minor|warning|info`',
    `defect_size_nm` DOUBLE COMMENT 'Measured size of the defect in nanometers.',
    `defect_size_um` DECIMAL(18,2) COMMENT 'The defect size um of the defect record record in the quality domain.',
    `defect_status` STRING COMMENT 'Current workflow status of the defect record.. Valid values are `open|investigating|resolved|closed|rejected`',
    `defect_type` STRING COMMENT 'The defect type of the defect record record in the quality domain.',
    `detection_method` STRING COMMENT 'Technique used to detect the defect.. Valid values are `optical|ebeam|sem|afm`',
    `detection_timestamp` TIMESTAMP COMMENT 'The detection timestamp of the defect record record in the quality domain.',
    `die_x` STRING COMMENT 'Column index of the die containing the defect on the wafer grid.',
    `die_y` STRING COMMENT 'Row index of the die containing the defect on the wafer grid.',
    `disposition` STRING COMMENT 'Final handling decision for the defect.. Valid values are `scrap|rework|accept|hold`',
    `edge_exclusion_zone_flag` BOOLEAN COMMENT 'Indicates whether the defect lies within the defined edge exclusion area.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the defect was detected during inspection.',
    `flat_notch_orientation` STRING COMMENT 'Orientation of wafer flat or notch relative to the defect.. Valid values are `flat|notch`',
    `inspection_recipe` STRING COMMENT 'Name of the inspection recipe or parameter set used.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the defect record record in the quality domain.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `notes` STRING COMMENT 'The notes of the defect record record in the quality domain.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the defect record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the defect record.',
    `repeatability_flag` BOOLEAN COMMENT 'True if the defect pattern repeats across multiple wafers.',
    `root_cause` STRING COMMENT 'Narrative description of the identified root cause.',
    `severity` STRING COMMENT 'The severity of the defect record record in the quality domain.',
    `severity_class` STRING COMMENT 'The severity class of the defect record record in the quality domain.',
    `x_coordinate` DOUBLE COMMENT 'Horizontal position of the defect on the wafer map (millimeters).',
    `y_coordinate` DOUBLE COMMENT 'Vertical position of the defect on the wafer map (millimeters).',
    CONSTRAINT pk_defect_record PRIMARY KEY(`defect_record_id`)
) COMMENT 'Individual defect observation record with classification, location, and root cause analysis.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` (
    `wafer_map_id` BIGINT COMMENT 'Primary key for wafer_map',
    `bin_definition_id` BIGINT COMMENT 'Foreign key linking to test.bin_definition. Business justification: Wafer maps use bin codes (pass_bin_code, fail_bin_code attributes on wafer_map) defined in bin_definition. Linking wafer_map to bin_definition enables proper bin interpretation and yield analysis by b',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the inspection tool that produced the map.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Wafer maps are generated for a specific IC design — die grid layout, bin definitions, and yield targets are IC-catalog-specific. Yield-by-product reports and DFM feedback loops require wafer_map to re',
    `inspection_lot_id` BIGINT COMMENT 'Unique identifier for the inspection lot record within the wafer map quality entity.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Wafer Map Archive ties each map to the inventory wafer lot for yield analysis and historical compliance audits.',
    `physical_layout_id` BIGINT COMMENT 'Foreign key linking to design.physical_layout. Business justification: Wafer map defect patterns are overlaid on physical layout to identify layout-correlated defect clusters — a standard DFM and yield enhancement workflow. Direct FK enables automated layout-defect spati',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Wafer maps must be attributed to the specific chamber that generated them for spatial defect pattern analysis. Chamber-level wafer map attribution is critical for identifying chamber-induced systemati',
    `wafer_id` BIGINT COMMENT 'Identifier of the wafer associated with this map.',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: REQUIRED: Test execution (wafer_probe_run) creates the wafer map; traceability report links map to its probe run for root‑cause analysis.',
    `bad_die_count` STRING COMMENT 'The bad die count of the wafer map record in the quality domain.',
    `bin_count_total` STRING COMMENT 'Total number of distinct bins used in the map.',
    `bin_summary` STRING COMMENT 'The bin summary of the wafer map record in the quality domain.',
    `compliance_iatf16949` BOOLEAN COMMENT 'Flag indicating compliance with IATF 16949 for this wafer map.',
    `compliance_iso9001` BOOLEAN COMMENT 'Flag indicating compliance with ISO 9001 for this wafer map.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp in the data lake.',
    `defect_density_per_sqmm` DECIMAL(18,2) COMMENT 'Average defect density across the wafer measured in defects per square millimeter.',
    `defect_type` STRING COMMENT 'Primary defect type identified on the wafer.. Valid values are `particle|scratch|void|contamination|other`',
    `defect_zone` STRING COMMENT 'Region of the wafer where defects are concentrated.. Valid values are `center|edge|corner|random`',
    `die_grid_columns` STRING COMMENT 'Number of die columns in the wafer grid.',
    `die_grid_rows` STRING COMMENT 'Number of die rows in the wafer grid.',
    `die_yield_percentage` DECIMAL(18,2) COMMENT 'Yield percentage calculated from passing dies over total dies.',
    `edge_exclusion_zone_mm` DECIMAL(18,2) COMMENT 'Width of the edge exclusion zone in millimeters where dies are not counted.',
    `fail_bin_code` STRING COMMENT 'Bin code representing failing (defective) dies.. Valid values are `FAIL`',
    `failing_die_count` STRING COMMENT 'Number of dies classified as failing.',
    `flat_orientation` STRING COMMENT 'Orientation of the wafer flat/notch relative to the map coordinate system.. Valid values are `north|south|east|west`',
    `good_die_count` STRING COMMENT 'The good die count of the wafer map record in the quality domain.',
    `is_kgd_certified` BOOLEAN COMMENT 'Indicates whether the wafer passed Known Good Die certification.',
    `kgd_certification_timestamp` TIMESTAMP COMMENT 'Timestamp when KGD certification was applied.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the wafer map record in the quality domain.',
    `map_checksum` STRING COMMENT 'Checksum (e.g., SHA-256) of the map file for integrity verification.',
    `map_file_path` STRING COMMENT 'File system path or URI where the wafer map image/file is stored.',
    `map_format` STRING COMMENT 'The map format of the wafer map record in the quality domain.',
    `map_generation_timestamp` TIMESTAMP COMMENT 'Date and time when the wafer map was generated.',
    `map_status` STRING COMMENT 'Current processing status of the wafer map.. Valid values are `generated|validated|rejected|archived`',
    `map_type` STRING COMMENT 'The map type of the wafer map record in the quality domain.',
    `map_version` STRING COMMENT 'Version identifier of the map generation algorithm or software.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `notes` STRING COMMENT 'The notes of the wafer map record in the quality domain.',
    `pass_bin_code` STRING COMMENT 'Bin code representing passing (good) dies.. Valid values are `PASS`',
    `passing_die_count` STRING COMMENT 'Number of dies classified as passing.',
    `record_audit_created` TIMESTAMP COMMENT 'The record audit created of the wafer map record in the quality domain.',
    `record_audit_updated` TIMESTAMP COMMENT 'The record audit updated of the wafer map record in the quality domain.',
    `remarks` STRING COMMENT 'Free-text comments or notes about the wafer map.',
    `total_die_count` STRING COMMENT 'Total number of dies evaluated on the wafer.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `wafer_map_status` STRING COMMENT 'The status of the wafer map record in the quality domain.',
    `yield_percent` DECIMAL(18,2) COMMENT 'The yield percent of the wafer map record in the quality domain.',
    CONSTRAINT pk_wafer_map PRIMARY KEY(`wafer_map_id`)
) COMMENT 'Spatial defect and yield map for a wafer showing die-level pass/fail and defect distribution patterns.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` (
    `yield_record_id` BIGINT COMMENT 'System-generated unique identifier for the yield record.',
    `equipment_process_recipe_id` BIGINT COMMENT 'Foreign key linking to equipment.equipment_process_recipe. Business justification: Recipe-to-yield traceability is a fundamental process control requirement in semiconductor manufacturing. Linking yield_record to equipment_process_recipe enables DOE and SPC analysis correlating spec',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the equipment that performed the measurement.',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: REQUIRED: Yield records reference the final test run that produced pass/fail counts; needed for yield vs. test performance dashboards.',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the yield record quality entity.',
    `inspection_lot_id` BIGINT COMMENT 'FK to quality.inspection_lot.inspection_lot_id — Yield measurements are taken at quality gates associated with inspection lots. This link enables yield-to-defect correlation analysis.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Yield Reporting aggregates yield percentages per inventory lot for financial reporting and customer yield guarantees.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Yield analysis is always segmented by process node in semiconductor manufacturing — yield improvement programs, cost-of-poor-quality models, and baseline yield comparisons are node-specific. process_',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Yield records at test stages must reference the test program used. Yield-by-test-program-version analysis is a standard continuous improvement metric in semiconductor manufacturing for identifying tes',
    `recipe_id` BIGINT COMMENT 'Identifier of the process recipe applied to the wafer.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Yield records are produced per SKU for production performance dashboards; FK to sku replaces denormalized product_sku column.',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Yield records are aggregated per process step; linking provides step‑level yield analysis for continuous improvement.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Supports Yield Analysis Dashboard linking yield data to the corresponding tapeout, essential for performance tracking and cost forecasting.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Chamber-level yield tracking is essential for identifying chamber-to-chamber variation — a core fab yield engineering practice. Existing FK only reaches fab_tool level; chamber attribution enables cha',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: Yield-vs-maintenance correlation reports are a standard fab engineering analysis for identifying maintenance-induced yield loss. This link enables direct traceability from yield records to the mainten',
    `wafer_id` BIGINT COMMENT 'Unique identifier for the individual wafer.',
    `wafer_map_id` BIGINT COMMENT 'Foreign key linking to quality.wafer_map. Business justification: A yield record captures die yield and bin distributions that are spatially represented in a wafer map. The yield_record and wafer_map are both generated from the same wafer probe or inspection activit',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: Yield records for wafer probe stage must link directly to the probe run that generated the yield data. This is a fundamental yield tracking requirement — quality engineers use this for probe yield tre',
    `batch_number` STRING COMMENT 'Identifier of the data acquisition batch.',
    `bin_distribution_summary` STRING COMMENT 'Compact representation (e.g., JSON) of die bin counts across test bins.',
    `calibration_status` STRING COMMENT 'Indicates whether the measurement equipment was calibrated.. Valid values are `calibrated|uncalibrated`',
    `comments` STRING COMMENT 'Free-text notes or observations related to the measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the yield record was first created in the system.',
    `defect_count` BIGINT COMMENT 'Number of defects detected for the specified defect type.',
    `defect_density` DECIMAL(18,2) COMMENT 'The defect density of the yield record record in the quality domain.',
    `defect_density_per_cm2` DECIMAL(18,2) COMMENT 'Number of defects per square centimeter of wafer area.',
    `defect_type` STRING COMMENT 'Classification of the dominant defect observed.. Valid values are `critical|major|minor|none`',
    `die_per_wafer` STRING COMMENT 'The die per wafer of the yield record record in the quality domain.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the yield measurement was captured.',
    `fab_line` STRING COMMENT 'Production line identifier within the fab.',
    `good_die_count` BIGINT COMMENT 'Number of dies that passed all quality tests.',
    `inspection_result` STRING COMMENT 'Overall pass/fail outcome of the inspection.. Valid values are `pass|fail|rework`',
    `inspection_system` STRING COMMENT 'Name of the inspection/metrology system used (e.g., KLA ICOS).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the yield record record in the quality domain.',
    `lot_humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity of the fab environment during measurement.',
    `lot_origin` STRING COMMENT 'Fab location code where the wafer lot originated.',
    `lot_status` STRING COMMENT 'Current processing status of the wafer lot.. Valid values are `in_process|completed|held`',
    `lot_temperature_c` DECIMAL(18,2) COMMENT 'Average temperature of the wafer lot during measurement.',
    `measurement_accuracy_percent` DECIMAL(18,2) COMMENT 'Stated accuracy of the measurement as a percentage.',
    `measurement_date` DATE COMMENT 'The measurement date associated with the yield record quality record.',
    `measurement_method` STRING COMMENT 'Physical method used to obtain the yield measurement.. Valid values are `optical|electrical|thermal`',
    `measurement_stage` STRING COMMENT 'Quality gate at which the yield was measured.. Valid values are `wafer_probe|final_test|packaged`',
    `measurement_unit` STRING COMMENT 'Unit of the primary measurement (e.g., percent, count).',
    `measurement_variance_percent` DECIMAL(18,2) COMMENT 'Statistical variance observed across repeated measurements.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `notes` STRING COMMENT 'The notes of the yield record record in the quality domain.',
    `quality_gate` STRING COMMENT 'Specific quality gate where the measurement was recorded.. Valid values are `wafer_sort|final_test|package_test`',
    `record_audit_created` TIMESTAMP COMMENT 'The record audit created of the yield record record in the quality domain.',
    `record_audit_updated` TIMESTAMP COMMENT 'The record audit updated of the yield record record in the quality domain.',
    `record_date` DATE COMMENT 'The record date associated with the yield record quality record.',
    `shift` STRING COMMENT 'Work shift during which the measurement was taken.. Valid values are `day|swing|night`',
    `source_file_name` STRING COMMENT 'Name of the source file or data feed that supplied the measurement.',
    `test_time_seconds` DECIMAL(18,2) COMMENT 'Total time taken to perform the yield test.',
    `tool_serial_number` STRING COMMENT 'Serial number of the measurement tool.',
    `total_die_count` BIGINT COMMENT 'Total number of dies on the wafer lot.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the yield record.',
    `yield_gap_percent` DECIMAL(18,2) COMMENT 'Difference between actual yield and target yield.',
    `yield_loss_category` STRING COMMENT 'Root cause classification for yield loss.. Valid values are `random_defect|systematic|parametric|test_escape|other`',
    `yield_percent` DECIMAL(18,2) COMMENT 'The yield percent of the yield record record in the quality domain.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Yield expressed as a percentage of good dies over total dies.',
    `yield_record_status` STRING COMMENT 'Current validation status of the yield record.. Valid values are `valid|invalid|pending_review`',
    `yield_stage` STRING COMMENT 'The yield stage of the yield record record in the quality domain.',
    `yield_target_percent` DECIMAL(18,2) COMMENT 'Target yield percentage defined for the product/process.',
    `yield_type` STRING COMMENT 'The yield type of the yield record record in the quality domain.',
    CONSTRAINT pk_yield_record PRIMARY KEY(`yield_record_id`)
) COMMENT 'Yield measurement record tracking die yield, parametric yield, and bin distributions at lot or wafer level.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` (
    `reliability_test_id` BIGINT COMMENT 'Unique identifier for the reliability test record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer associated with the qualification.',
    `assembly_lot_id` BIGINT COMMENT 'Foreign key linking to packaging.assembly_lot. Business justification: Reliability tests (HTOL, TC, HAST) are performed on packaged units from specific assembly lots. JEDEC JESD47 and AEC-Q100 qualification require traceability from reliability test results to the assemb',
    `calibration_record_id` BIGINT COMMENT 'Foreign key linking to equipment.calibration_record. Business justification: JEDEC and AEC-Q100 qualification audits require traceability from reliability test results to the calibration records of test equipment (temperature chambers, voltage sources). This named regulatory r',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the test equipment used (e.g., KLA ICOS system).',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: Reliability qualification units are drawn from specific final test runs. Linking reliability_test to final_test_run enables JEDEC and AEC-Q100 qualification traceability from reliability results back ',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Reliability test results are tied to a specific IC part; required for qualification compliance and customer reliability reports.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Reliability tests (HTOL, HAST, TC) are often initiated from or associated with a specific inspection lot of material. This FK provides traceability from the reliability test execution back to the insp',
    `package_type_id` BIGINT COMMENT 'add column package_type_id (BIGINT) with FK to packaging.package_type.package_type_id - reliability tests are package specific',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Reliability qualification plans, failure rate targets (FIT), and Weibull parameters are process-node-specific. Node-level reliability benchmarking and qualification matrix reports require this FK. No ',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: A reliability test is executed against a quality specification that defines pass/fail criteria, test standards (JEDEC, IATF 16949), and acceptance thresholds. This FK links the test execution to the g',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: JEDEC qualification requires chamber-level traceability for reliability tests (HTOL, ELFR, burn-in). Specific test chambers (e.g., oven chambers) must be identified in qualification documentation. Exi',
    `analysis_method` STRING COMMENT 'Technique used to analyze the failed device.. Valid values are `SEM|FIB|EMMI|curve_trace|other`',
    `applicable_standard` STRING COMMENT 'Industry standard governing the qualification (e.g., AEC‑Q100, JEDEC JESD47).. Valid values are `AEC_Q100|AEC_Q101|JESD47|ISO_9001`',
    `approval_authority` STRING COMMENT 'Name or role of the person/committee approving the qualification.',
    `compliance_iatf_16949` BOOLEAN COMMENT 'True if the test complies with automotive quality standard IATF 16949.',
    `compliance_iso_9001` BOOLEAN COMMENT 'True if the test complies with ISO 9001 quality management requirements.',
    `compliance_jedec` BOOLEAN COMMENT 'True if the test follows applicable JEDEC reliability standards.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the reliability test record in the quality domain.',
    `data_source_system` STRING COMMENT 'Source system that supplied the reliability test data (e.g., KLA ICOS).',
    `device_type` STRING COMMENT 'Identifier for the device family or SKU under test.',
    `duration_hours` STRING COMMENT 'The duration hours of the reliability test record in the quality domain.',
    `fail_count` STRING COMMENT 'The fail count of the reliability test record in the quality domain.',
    `failure_count` STRING COMMENT 'The failure count of the reliability test record in the quality domain.',
    `failure_mechanism` STRING COMMENT 'Physical mechanism responsible for the failure.. Valid values are `electromigration|TDDB|HCI|NBTI|stress_rupture|other`',
    `failure_mode` STRING COMMENT 'Observed mode of failure for the device.. Valid values are `open_circuit|short_circuit|param_shift|timing_error|other`',
    `failure_serial_number` STRING COMMENT 'Serial number of the device that failed during testing.',
    `failure_time_hours` DECIMAL(18,2) COMMENT 'Time elapsed until failure, measured in hours.',
    `fit_rate` DECIMAL(18,2) COMMENT 'Calculated failure rate expressed in FIT (10⁹ hours).',
    `fit_rate_confidence` DECIMAL(18,2) COMMENT 'Statistical confidence level for the reported FIT rate.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'The humidity percent of the reliability test record in the quality domain.',
    `is_kgd_certified` BOOLEAN COMMENT 'Indicates whether the device is Known Good Die (KGD) certified.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the reliability test record in the quality domain.',
    `milestone_schedule` STRING COMMENT 'Key milestones and dates for the qualification program.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `notes` STRING COMMENT 'The notes of the reliability test record in the quality domain.',
    `operator_name` STRING COMMENT 'Name of the technician who ran the test.',
    `overall_status` STRING COMMENT 'Current lifecycle status of the qualification program.. Valid values are `pending|in_progress|completed|failed|cancelled`',
    `pass_fail_criteria` STRING COMMENT 'Business rule defining pass or fail for the test (e.g., max failure rate).',
    `program_code` STRING COMMENT 'Business identifier for the reliability qualification program.',
    `qualification_plan_version` STRING COMMENT 'Version identifier of the qualification plan document.',
    `qualification_type` STRING COMMENT 'Type of qualification driving the reliability test.. Valid values are `new_product|process_change|osat_qualification|pcn_driven`',
    `record_audit_created` TIMESTAMP COMMENT 'The record audit created of the reliability test record in the quality domain.',
    `record_audit_updated` TIMESTAMP COMMENT 'The record audit updated of the reliability test record in the quality domain.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reliability test record was created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reliability test record.',
    `reliability_grade` STRING COMMENT 'Qualitative reliability grade assigned to the device.. Valid values are `A|B|C|D`',
    `reliability_test_status` STRING COMMENT 'The status of the reliability test record in the quality domain.',
    `root_cause_classification` STRING COMMENT 'High‑level classification of the root cause.. Valid values are `design|process|material|handling|unknown`',
    `sample_size` STRING COMMENT 'Number of devices subjected to the test.',
    `temperature_c` STRING COMMENT 'The temperature c of the reliability test record in the quality domain.',
    `test_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the stress test, in hours.',
    `test_execution_timestamp` TIMESTAMP COMMENT 'Date and time when the test was executed.',
    `test_humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity level during the test, expressed as a percentage.',
    `test_location` STRING COMMENT 'Facility or fab where the test was performed.',
    `test_result` STRING COMMENT 'Overall pass/fail outcome of the test.. Valid values are `pass|fail`',
    `test_standard` STRING COMMENT 'The test standard of the reliability test record in the quality domain.',
    `test_status` STRING COMMENT 'Current execution status of the test.. Valid values are `scheduled|running|completed|aborted`',
    `test_temperature_c` DECIMAL(18,2) COMMENT 'Temperature set point for the stress test, in degrees Celsius.',
    `test_type` STRING COMMENT 'Stress test methodology applied.. Valid values are `HTOL|HAST|TC|ESD|JEDEC_stress`',
    `test_voltage_v` DECIMAL(18,2) COMMENT 'Voltage applied during the stress test, in volts.',
    `weibull_scale_parameter` DECIMAL(18,2) COMMENT 'Scale parameter of the Weibull reliability model.',
    `weibull_shape_parameter` DECIMAL(18,2) COMMENT 'Shape parameter of the Weibull reliability model.',
    CONSTRAINT pk_reliability_test PRIMARY KEY(`reliability_test_id`)
) COMMENT 'Reliability test execution record for HTOL, HAST, TC, and other stress tests with pass/fail results.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` (
    `capa_record_id` BIGINT COMMENT 'System-generated unique identifier for the CAPA record.',
    `assembly_lot_id` BIGINT COMMENT 'Foreign key linking to packaging.assembly_lot. Business justification: CAPAs in semiconductor packaging are initiated against specific assembly lots exhibiting defects. Linking capa_record to the triggering assembly_lot supports closed-loop corrective action traceability',
    `defect_record_id` BIGINT COMMENT 'Foreign key linking to quality.defect_record. Business justification: A CAPA can be initiated directly from a specific defect record, particularly for systematic or recurring defects identified during inspection. This FK enables direct traceability from the corrective a',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Equipment-specific CAPAs are a standard IATF 16949 practice in semiconductor fabs — corrective actions targeting a specific fab tool. No existing FK from capa_record to fab_tool exists. Equipment-leve',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: CAPAs in semiconductor ops are raised against IC catalog entries when a quality escape spans multiple SKUs of the same die. IATF 16949 CAPA traceability to product requires IC-level linkage. Existing ',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: A CAPA can be directly triggered by findings from an inspection lot (e.g., AQL rejection, high defect density). While an indirect path exists through nonconformance_report, a direct FK from capa_recor',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: CAPAs in semiconductor fabs frequently prescribe equipment maintenance actions as corrective measures. Linking capa_record to maintenance_event enables IATF 16949 CAPA effectiveness verification — tra',
    `nonconformance_report_id` BIGINT COMMENT 'FK to quality.nonconformance_report.nonconformance_report_id — CAPAs are triggered by nonconformances. This is a critical traceability link for ISO 9001 clause 10.2 compliance.',
    `tool_qualification_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_qualification. Business justification: CAPAs for equipment-related nonconformances often require tool requalification as the corrective action. Linking capa_record to tool_qualification enables IATF 16949 CAPA effectiveness verification — ',
    `actual_completion_date` DATE COMMENT 'Date when the action was actually completed.',
    `attachment_reference` STRING COMMENT 'Reference (e.g., URL or file ID) to supporting documents or images.',
    `capa_number` STRING COMMENT 'Business identifier or code assigned to the CAPA for tracking and reference.',
    `capa_record_status` STRING COMMENT 'Current lifecycle status of the CAPA record.. Valid values are `open|in_progress|closed|rejected`',
    `capa_status` STRING COMMENT 'The capa status of the capa record record in the quality domain.',
    `capa_type` STRING COMMENT 'Indicates whether the action is corrective or preventive.. Valid values are `corrective|preventive`',
    `closure_approval_status` STRING COMMENT 'Approval status of the CAPA closure after verification.. Valid values are `approved|rejected|pending`',
    `closure_date` DATE COMMENT 'Date when the CAPA was formally closed.',
    `compliance_reference` STRING COMMENT 'Reference to the specific compliance clause or standard (e.g., ISO 9001, IATF 16949) governing the CAPA.',
    `corrective_action` STRING COMMENT 'The corrective action of the capa record record in the quality domain.',
    `corrective_action_description` STRING COMMENT 'Specific actions planned or taken to eliminate the identified root cause.',
    `cost_actual` DECIMAL(18,2) COMMENT 'Actual financial cost incurred after implementation.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated financial cost to implement the corrective or preventive action.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CAPA record was initially created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for cost fields.. Valid values are `USD|EUR|JPY|CNY|GBP|Other`',
    `department` STRING COMMENT 'Business department owning the CAPA (e.g., Quality, Engineering).',
    `detection_date` DATE COMMENT 'Date when the problem was first detected.',
    `detection_phase` STRING COMMENT 'Phase of the product lifecycle where the issue was detected.. Valid values are `design|fabrication|testing|field`',
    `detection_source` STRING COMMENT 'Source of detection (e.g., inspection, customer, audit).',
    `due_date` DATE COMMENT 'The due date associated with the capa record quality record.',
    `effectiveness_verification_criteria` STRING COMMENT 'Criteria and metrics used to verify that the CAPA was effective.',
    `impact` STRING COMMENT 'Description of the business or technical impact of the non‑conformance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the capa record record in the quality domain.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the CAPA.',
    `preventive_action` STRING COMMENT 'The preventive action of the capa record record in the quality domain.',
    `preventive_action_description` STRING COMMENT 'Actions designed to prevent recurrence of similar issues in the future.',
    `priority` STRING COMMENT 'Priority ranking to schedule the CAPA work.. Valid values are `1|2|3|4|5`',
    `problem_description` STRING COMMENT 'The problem description of the capa record record in the quality domain.',
    `problem_statement` STRING COMMENT 'Clear description of the problem or non‑conformance that triggered the CAPA.',
    `record_audit_created` TIMESTAMP COMMENT 'Audit timestamp for when the record was first captured in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Audit timestamp for the most recent modification of the record.',
    `risk_level` STRING COMMENT 'Risk assessment of the issue before mitigation.. Valid values are `high|medium|low`',
    `root_cause` STRING COMMENT 'The root cause of the capa record record in the quality domain.',
    `root_cause_description` STRING COMMENT 'Detailed narrative of the identified root cause.',
    `root_cause_method` STRING COMMENT 'Methodology used to determine the root cause (e.g., 5‑Why, Ishikawa, FTA, Pareto).. Valid values are `5_why|ishikawa|fta|pareto`',
    `severity` STRING COMMENT 'Severity level of the issue addressed by the CAPA.. Valid values are `critical|high|medium|low`',
    `target_completion_date` DATE COMMENT 'Planned date by which the corrective or preventive action should be completed.',
    `verification_date` DATE COMMENT 'Date when the effectiveness of the CAPA was verified.',
    `verification_result` STRING COMMENT 'Outcome of the effectiveness verification.. Valid values are `pass|fail|partial`',
    `created_by` STRING COMMENT 'User identifier of the person who created the CAPA record.',
    CONSTRAINT pk_capa_record PRIMARY KEY(`capa_record_id`)
) COMMENT 'Corrective and preventive action record tracking root cause analysis, containment, and effectiveness verification.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` (
    `nonconformance_report_id` BIGINT COMMENT 'System-generated unique identifier for the non‑conformance report.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Feeds the Customer Impact Reporting procedure, associating each NCR with the affected customer account to trigger notifications and compliance reporting.',
    `booking_id` BIGINT COMMENT 'Foreign key linking to sales.booking. Business justification: NCRs with customer impact require direct traceability to the originating booking for financial impact quantification, customer notification workflows, and regulatory reporting. In semiconductors, NCR ',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: NCRs with customer_notification_required=true need a specific customer contact for notification. The existing account_id identifies the company but not the individual. Semiconductor quality teams must',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: NCRs with is_customer_impact=true must be traceable to the affected design win for revenue-at-risk assessment and design win status updates. Semiconductor program managers use this link to evaluate wh',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: NCMRs are issued for a specific IC part; linking to ic_catalog supports root‑cause analysis and customer notifications.',
    `inspection_lot_id` BIGINT COMMENT 'FK to quality.inspection_lot.inspection_lot_id — NCRs are typically discovered during inspection. This link provides traceability from the non-conformance back to the inspection event where it was detected.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: NCR handling requires linking the report to the inventory lot to enforce holds, quarantine, and corrective action tracking.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: A nonconformance report documents a deviation from a quality specification. The existing specification_violated column is a free-text STRING that should be replaced by a proper FK to quality_spec, ena',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: NCRs raised for equipment-induced nonconformances must reference the specific fab tool that caused the nonconformance. No existing FK from nonconformance_report to fab_tool exists. Equipment-level NCR',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: NCRs reference the process step where non‑conformance was detected, essential for corrective‑action workflow.',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: NCRs are frequently raised as a direct result of equipment maintenance events causing process excursions. Linking NCR to maintenance_event enables traceability from nonconformance to the triggering eq',
    `wafer_id` BIGINT COMMENT 'Unique identifier of the wafer where the issue was detected.',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: NCRs raised from wafer probe yield failures must reference the triggering probe run for disposition decisions and hold management. Quality engineers require this link for wafer-level nonconformance tr',
    `attached_document_ids` STRING COMMENT 'Comma‑separated list of document identifiers attached to the report.',
    `audit_trail_notes` STRING COMMENT 'Free‑form notes capturing audit trail details.',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard applicable to the report.. Valid values are `ISO 9001|IATF 16949|JEDEC`',
    `corrective_action_due_date` DATE COMMENT 'Target date for completion of corrective actions.',
    `corrective_action_plan` STRING COMMENT 'Planned corrective actions to prevent recurrence.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action implementation.. Valid values are `pending|completed|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `customer_notification_required` BOOLEAN COMMENT 'Flag indicating if the customer must be notified.',
    `customer_notification_sent_timestamp` TIMESTAMP COMMENT 'Date‑time when the customer notification was sent.',
    `nonconformance_report_description` STRING COMMENT 'The description of the nonconformance report record in the quality domain.',
    `detected_date` DATE COMMENT 'The detected date associated with the nonconformance report quality record.',
    `detection_point` STRING COMMENT 'Process step or system where the non‑conformance was first detected.',
    `die_range` STRING COMMENT 'Range of die numbers on the wafer affected (e.g., "100-200").',
    `disposition` STRING COMMENT 'The disposition of the nonconformance report record in the quality domain.',
    `disposition_action_required` STRING COMMENT 'Specific actions required to implement the chosen disposition.',
    `disposition_decision` STRING COMMENT 'Final decision on how the non‑conforming material will be treated.. Valid values are `use_as_is|rework|scrap|return_to_supplier`',
    `hold_initiated_timestamp` TIMESTAMP COMMENT 'Date‑time when the quality hold was placed.',
    `hold_reason` STRING COMMENT 'Reason why the lot was placed on hold.',
    `hold_release_condition` STRING COMMENT 'Condition(s) that must be satisfied to release the hold.',
    `hold_released_timestamp` TIMESTAMP COMMENT 'Date‑time when the quality hold was lifted (null if still active).',
    `hold_type` STRING COMMENT 'Category of quality hold applied to the lot.. Valid values are `process_excursion|spc_out_of_control|customer_complaint|reliability_failure`',
    `impact_amount` DECIMAL(18,2) COMMENT 'Estimated monetary impact of the non‑conformance.',
    `impact_currency_code` STRING COMMENT 'Three‑letter ISO currency code for the financial impact.. Valid values are `USD|EUR|JPY|CNY|GBP`',
    `is_customer_impact` BOOLEAN COMMENT 'Indicates whether the non‑conformance impacts a customer.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the nonconformance report record in the quality domain.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `mrb_decision` STRING COMMENT 'Decision made by the MRB regarding the non‑conformance.. Valid values are `approve|reject|defer`',
    `ncr_number` STRING COMMENT 'The ncr number of the nonconformance report record in the quality domain.',
    `ncr_status` STRING COMMENT 'The ncr status of the nonconformance report record in the quality domain.',
    `nonconformance_description` STRING COMMENT 'Narrative description of the deviation from specification.',
    `nonconformance_report_status` STRING COMMENT 'Current lifecycle status of the report.. Valid values are `open|under_review|closed|cancelled`',
    `nonconformance_type` STRING COMMENT 'The nonconformance type of the nonconformance report record in the quality domain.',
    `notes` STRING COMMENT 'The notes of the nonconformance report record in the quality domain.',
    `priority` STRING COMMENT 'Priority assigned for handling the report.. Valid values are `high|medium|low`',
    `record_audit_created` TIMESTAMP COMMENT 'The record audit created of the nonconformance report record in the quality domain.',
    `record_audit_updated` TIMESTAMP COMMENT 'The record audit updated of the nonconformance report record in the quality domain.',
    `report_number` STRING COMMENT 'Business‑visible identifier (NCR number) assigned to the report.',
    `report_timestamp` TIMESTAMP COMMENT 'Date‑time when the non‑conformance was initially recorded.',
    `root_cause_analysis` STRING COMMENT 'Analysis identifying the underlying cause of the non‑conformance.',
    `severity` STRING COMMENT 'The severity of the nonconformance report record in the quality domain.',
    `severity_level` STRING COMMENT 'Severity classification of the non‑conformance.. Valid values are `critical|high|medium|low`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    CONSTRAINT pk_nonconformance_report PRIMARY KEY(`nonconformance_report_id`)
) COMMENT 'Nonconformance report documenting material or process deviations from specification with disposition decisions.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` (
    `quality_spec_id` BIGINT COMMENT 'Unique identifier for the quality specification record.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Quality specs in semiconductor ops are authored at product family level — all ICs in a family share baseline reliability and inspection specs. product_family plain column is a denormalized string re',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the quality spec quality entity.',
    `limit_id` BIGINT COMMENT 'Foreign key linking to test.limit. Business justification: Quality specs define acceptance criteria that must align with test limits. Linking quality_spec to test limit enables spec-to-limit alignment verification, required for test limit validation and quali',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Specification Measurement Traceability links each spec to the Fab Tool that performs the measurement, required for ISO 9001 compliance.',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Required for Package Design Specification process where each quality spec must be linked to its package type to enforce dimensional and electrical limits.',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Quality specs for DRC limits, process corners, and electrical parameters are PDK-version-specific. Linking quality_spec to pdk ensures specs are validated against the correct PDK version — required fo',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Quality specs (AQL limits, defect density thresholds, parametric limits) are defined per process node in semiconductor manufacturing. JEDEC and AEC-Q100 qualification specs differ by node. process_no',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to inventory.raw_material. Business justification: Quality specs define acceptance criteria for raw material incoming inspection (resistivity, purity, wafer bow/warp limits). Semiconductor procurement and quality teams must link raw materials to their',
    `technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: Specs often depend on the technology node; linking allows node‑specific parameter validation.',
    `acceptance_criteria` STRING COMMENT 'Free‑text description of the acceptance criteria.',
    `applicability_scope` STRING COMMENT 'Level of the product hierarchy the spec applies to.. Valid values are `wafer|die|package|assembly`',
    `approval_date` DATE COMMENT 'Date when the specification was approved.',
    `approval_status` STRING COMMENT 'Current approval state of the specification.. Valid values are `approved|rejected|pending`',
    `approved_by` STRING COMMENT 'Name of the person who approved the specification.',
    `audit_trail` STRING COMMENT 'Chronological log of changes made to the specification.',
    `change_reason` STRING COMMENT 'Reason for the most recent change to the specification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the specification record was created.',
    `document_url` STRING COMMENT 'Link to the detailed specification document.',
    `effective_from` DATE COMMENT 'Date when the specification becomes effective.',
    `effective_until` DATE COMMENT 'Date when the specification expires (null if open‑ended).',
    `iatf_16949_compliant` BOOLEAN COMMENT 'Indicates compliance with automotive quality standard IATF 16949.',
    `inspection_method` STRING COMMENT 'Technique used to inspect or measure the parameter.. Valid values are `optical|electron|acoustic|other`',
    `iso_9001_compliant` BOOLEAN COMMENT 'Indicates whether the specification complies with ISO 9001 quality standards.',
    `jedec_reliability_compliant` BOOLEAN COMMENT 'Indicates compliance with JEDEC reliability specifications.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the quality spec record in the quality domain.',
    `last_validated_date` DATE COMMENT 'Date of the most recent validation activity.',
    `lower_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable value for the parameter.',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'The lower spec limit of the quality spec record in the quality domain.',
    `measurement_accuracy_percent` DECIMAL(18,2) COMMENT 'Stated accuracy of the measurement equipment as a percentage.',
    `measurement_variance_percent` DECIMAL(18,2) COMMENT 'Observed variance of repeated measurements expressed as a percentage.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `nominal_value` DECIMAL(18,2) COMMENT 'Target nominal value for the parameter.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the specification.',
    `parameter_name` STRING COMMENT 'Name of the measured parameter (e.g., Vth, line width).',
    `quality_spec_status` STRING COMMENT 'Current lifecycle state of the specification.. Valid values are `active|inactive|draft|retired|pending`',
    `record_audit_created` TIMESTAMP COMMENT 'The record audit created of the quality spec record in the quality domain.',
    `record_audit_updated` TIMESTAMP COMMENT 'The record audit updated of the quality spec record in the quality domain.',
    `review_cycle` STRING COMMENT 'Frequency at which the specification is reviewed.. Valid values are `annual|quarterly|ad_hoc`',
    `revision_number` STRING COMMENT 'Sequential revision number of the specification.',
    `spec_code` STRING COMMENT 'Unique business code assigned to the specification.',
    `spec_name` STRING COMMENT 'Human‑readable name of the quality specification.',
    `spec_number` STRING COMMENT 'The spec number of the quality spec record in the quality domain.',
    `spec_status` STRING COMMENT 'The spec status of the quality spec record in the quality domain.',
    `spec_type` STRING COMMENT 'Category of the specification such as electrical, dimensional, visual, or reliability.. Valid values are `electrical|dimensional|visual|reliability|other`',
    `target_value` DECIMAL(18,2) COMMENT 'The target value of the quality spec record in the quality domain.',
    `test_type` STRING COMMENT 'Category of test associated with the specification.. Valid values are `functional|stress|environmental|reliability|visual`',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the parameter (e.g., mV, nm).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the specification record.',
    `upper_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable value for the parameter.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'The upper spec limit of the quality spec record in the quality domain.',
    `validated_flag` BOOLEAN COMMENT 'Indicates whether the specification has been validated against actual parts.',
    `version` STRING COMMENT 'The spec version of the quality spec record in the quality domain.',
    CONSTRAINT pk_quality_spec PRIMARY KEY(`quality_spec_id`)
) COMMENT 'Quality specification defining acceptance criteria, measurement methods, and control limits for product parameters.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` (
    `quality_hold_id` BIGINT COMMENT 'System-generated unique identifier for the quality hold record.',
    `defect_record_id` BIGINT COMMENT 'Identifier of the defect record linked to this hold, when the hold originates from a defect inspection.',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: Quality holds are placed on die bank inventory for KGD failures, reliability disqualifications, or contamination events. die_bank.quality_hold_reason is a denormalized plain string — replacing it with',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Tool-level quality holds (equipment quarantine) are a standard fab practice when a tool is suspected of causing product nonconformance. Linking quality_hold to fab_tool enables direct tool hold manage',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Chamber-level quality holds are placed when a specific chamber is suspected of contamination or process excursion while other chambers on the same tool remain qualified. This chamber-specific hold man',
    `ic_catalog_id` BIGINT COMMENT 'FK to ic_catalog - quality holds apply to specific products',
    `inspection_lot_id` BIGINT COMMENT 'Unique identifier for the inspection lot record within the quality hold quality entity.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Quality holds directly block inventory wafer lots from consumption or shipment. Inventory planners require a typed FK to identify held wafer lots for MRP/planning exclusion. quality_hold has affected_',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Holds are often placed due to issues at a particular process step; linking enables traceability to the step causing the hold.',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: Quality holds are frequently triggered by equipment maintenance events causing process excursions (e.g., unplanned maintenance, part failure). Linking quality_hold to maintenance_event enables MRB tra',
    `affected_entity_ref` BIGINT COMMENT 'Identifier of the specific lot, die bank, or inventory batch under hold.',
    `affected_entity_type` STRING COMMENT 'Type of entity that the hold applies to.. Valid values are `wafer_lot|die_bank|finished_good|inventory_batch`',
    `affected_quantity` BIGINT COMMENT 'Number of units (dies, wafers, or pieces) impacted by the hold.',
    `compliance_iatf_16949_flag` BOOLEAN COMMENT 'True if the hold complies with automotive industry quality standard IATF 16949.',
    `compliance_iso_9001_flag` BOOLEAN COMMENT 'True if the hold complies with ISO 9001 quality management requirements.',
    `compliance_jedec_flag` BOOLEAN COMMENT 'True if the hold meets applicable JEDEC reliability criteria.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the hold record was first created in the system.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Optional date/time after which the hold is automatically cleared if not released.',
    `hold_category` STRING COMMENT 'Broad classification of the hold for reporting and compliance.. Valid values are `safety|quality|regulatory|customer`',
    `hold_number` STRING COMMENT 'External reference number assigned to the hold for tracking across systems.',
    `hold_status` STRING COMMENT 'Current lifecycle status of the hold.. Valid values are `active|released|cancelled|pending_review`',
    `hold_timestamp` TIMESTAMP COMMENT 'The hold timestamp of the quality hold record in the quality domain.',
    `hold_type` STRING COMMENT 'Category describing the reason for the hold.. Valid values are `process_excursion|spc_out_of_control|customer_complaint|reliability_failure|other`',
    `initiated_by` BIGINT COMMENT 'Identifier of the quality engineer who placed the hold.',
    `initiated_timestamp` TIMESTAMP COMMENT 'Date and time when the hold was placed.',
    `is_kgd_certified` BOOLEAN COMMENT 'Indicates whether the held lot requires Known Good Die (KGD) certification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the quality hold record in the quality domain.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `notes` STRING COMMENT 'Additional free‑form notes captured by the quality engineer.',
    `placed_timestamp` TIMESTAMP COMMENT 'The hold placed timestamp of the quality hold record in the quality domain.',
    `priority` STRING COMMENT 'Priority level indicating urgency of resolution.. Valid values are `low|medium|high|critical`',
    `quality_hold_status` STRING COMMENT 'The status of the quality hold record in the quality domain.',
    `reason` STRING COMMENT 'The hold reason of the quality hold record in the quality domain.',
    `reason_code` STRING COMMENT 'Coded value representing the hold reason code of the quality hold quality record.',
    `reason_description` STRING COMMENT 'The hold reason description of the quality hold record in the quality domain.',
    `record_audit_created` TIMESTAMP COMMENT 'The record audit created of the quality hold record in the quality domain.',
    `record_audit_updated` TIMESTAMP COMMENT 'The record audit updated of the quality hold record in the quality domain.',
    `release_reason_description` STRING COMMENT 'Explanation for why the hold was released.',
    `release_timestamp` TIMESTAMP COMMENT 'Date and time when the hold was officially released.',
    `released_timestamp` TIMESTAMP COMMENT 'The hold released timestamp of the quality hold record in the quality domain.',
    `required_disposition_actions` STRING COMMENT 'Specific actions required to resolve the hold (e.g., re‑work, inspection, scrap).',
    `resolution_status` STRING COMMENT 'Current status of the disposition process for the hold.. Valid values are `pending|in_progress|resolved`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the hold record.',
    CONSTRAINT pk_quality_hold PRIMARY KEY(`quality_hold_id`)
) COMMENT 'Quality hold record preventing material movement pending investigation or disposition decision.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` (
    `failure_analysis_report_id` BIGINT COMMENT 'Unique identifier for the failure analysis report.',
    `assembly_lot_id` BIGINT COMMENT 'Foreign key linking to packaging.assembly_lot. Business justification: Failure analysis reports on packaged devices must trace to the specific assembly lot from which the failed unit came. Standard FA traceability practice in semiconductor operations; required for 8D cus',
    `capa_record_id` BIGINT COMMENT 'FK to quality.capa_record.capa_record_id — Failure analysis conclusions drive corrective actions. This is a critical link in the closed-loop quality system.',
    `customer_complaint_id` BIGINT COMMENT 'Foreign key linking to quality.customer_complaint. Business justification: Customer complaints frequently trigger failure analysis investigations. This FK links the FA report to the customer complaint that initiated it, enabling end-to-end traceability from customer-reported',
    `defect_record_id` BIGINT COMMENT 'Unique identifier for the defect record record within the failure analysis report quality entity.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Failure analysis reports must identify the fab tool involved in the failure for root cause investigation. No existing FK from failure_analysis_report to fab_tool exists. This fundamental FA traceabili',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: FA reports initiated from final test failures require the test run context (handler, socket, temperature, yield) for root cause analysis. This is a standard FA workflow in semiconductor quality operat',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the failure analysis report quality entity.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: A failure analysis report can be initiated from an inspection lot finding (e.g., high defect density, AQL failure). This FK provides direct traceability from the FA report back to the inspection lot t',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: Failure analysis reports routinely identify equipment maintenance events as contributing factors to failures. Direct FA-to-maintenance traceability enables engineers to document and verify the mainten',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: FA reports document the package type of the failed device (BGA, QFN, etc.) as a primary classification attribute. Required for FA database queries by package type to identify systemic package-related ',
    `physical_layout_id` BIGINT COMMENT 'Foreign key linking to design.physical_layout. Business justification: FA engineers overlay failure site coordinates on physical layout (GDS layer stack) to identify layout-correlated failure mechanisms. Direct FK enables automated retrieval of layout context for failure',
    `nonconformance_report_id` BIGINT COMMENT 'FK to quality.nonconformance_report.nonconformance_report_id — FA reports are triggered by non-conformances. FA description explicitly states Links to... nonconformance_report. This is a critical investigation-to-disposition link.',
    `reliability_test_id` BIGINT COMMENT 'FK to quality.reliability_test.reliability_test_id — Failure analysis reports investigate failures detected during reliability testing. FA report description states Links to reliability_failure which is now merged into reliability_test.',
    `tool_qualification_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_qualification. Business justification: Failure analysis investigations must verify whether the tool was properly qualified at time of failure. Linking FAR to tool_qualification enables direct traceability from failure analysis conclusions ',
    `unit_test_result_id` BIGINT COMMENT 'Foreign key linking to test.unit_test_result. Business justification: FA is performed on specific failing units identified by their unit test result. Linking FA report to unit_test_result enables engineers to pull exact bin, parametric flags, and test conditions for the',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: FA reports initiated from probe failures require direct access to the probe run data (bin distribution, yield, test conditions). FA engineers use this link to pull exact probe run context during root ',
    `analysis_date` DATE COMMENT 'The analysis date associated with the failure analysis report quality record.',
    `analysis_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the failure analysis investigation was completed.',
    `analysis_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the failure analysis investigation began.',
    `analysis_technique` STRING COMMENT 'Primary analytical method(s) employed during the failure investigation.. Valid values are `SEM|FIB|EMMI|TEM|EDX|Other`',
    `approval_status` STRING COMMENT 'Result of the final review of the report.. Valid values are `approved|rejected|pending`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the report was formally approved or rejected.',
    `comments` STRING COMMENT 'Free‑form notes or observations added by the analyst.',
    `conclusion` STRING COMMENT 'The conclusion of the failure analysis report record in the quality domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the failure analysis report record in the quality domain.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date and time when the report record was first created.',
    `defect_code` STRING COMMENT 'Standard defect code identifying the defect class (e.g., D1234).. Valid values are `^Dd{4}$`',
    `fa_number` STRING COMMENT 'The fa number of the failure analysis report record in the quality domain.',
    `failure_analysis_report_status` STRING COMMENT 'Current lifecycle status of the report.. Valid values are `draft|under_review|approved|rejected|closed`',
    `failure_mechanism` STRING COMMENT 'Descriptive classification of the underlying failure mechanism (e.g., electromigration, latch‑up, oxide breakdown).',
    `failure_mode` STRING COMMENT 'The failure mode of the failure analysis report record in the quality domain.',
    `failure_severity` STRING COMMENT 'Severity rating assigned to the failure based on impact and recurrence risk.. Valid values are `critical|major|minor|warning`',
    `failure_site_location` STRING COMMENT 'Physical location on the die/wafer where the failure was observed (e.g., metal layer 3, die X12Y7).',
    `far_number` STRING COMMENT 'The far number of the failure analysis report record in the quality domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the failure analysis report record in the quality domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the report record.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `notes` STRING COMMENT 'The notes of the failure analysis report record in the quality domain.',
    `record_audit_created` TIMESTAMP COMMENT 'The record audit created of the failure analysis report record in the quality domain.',
    `record_audit_updated` TIMESTAMP COMMENT 'The record audit updated of the failure analysis report record in the quality domain.',
    `report_number` STRING COMMENT 'Business identifier assigned to the report (e.g., FA‑2023‑0012).',
    `report_status` STRING COMMENT 'The report status of the failure analysis report record in the quality domain.',
    `report_title` STRING COMMENT 'Human‑readable title of the failure analysis report.',
    `report_type` STRING COMMENT 'Category indicating the origin of the failure analysis request.. Valid values are `reliability_test|customer_return|in_process|design_review`',
    `root_cause` STRING COMMENT 'Narrative of the root cause conclusion derived from the analysis.',
    `sample_description` STRING COMMENT 'Brief description of the physical sample(s) examined (e.g., wafer lot, die coordinates, package type).',
    `supporting_evidence_refs` STRING COMMENT 'Comma‑separated list of file paths or identifiers for images, data files, and test logs that support the analysis.',
    CONSTRAINT pk_failure_analysis_report PRIMARY KEY(`failure_analysis_report_id`)
) COMMENT 'Failure analysis report documenting physical analysis techniques, findings, and root cause for failed devices.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` (
    `customer_complaint_id` BIGINT COMMENT 'Primary key for customer_complaint',
    `account_id` BIGINT COMMENT 'Identifier of the customer who submitted the complaint.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to invoice.ar_invoice. Business justification: Customer complaints in semiconductors are raised against specific invoices (disputed shipment charges, quality deductions). Linking complaint to the AR invoice enables credit memo processing, DPPM fin',
    `assembly_lot_id` BIGINT COMMENT 'Foreign key linking to packaging.assembly_lot. Business justification: Customer complaints about packaged devices must be traceable to the specific assembly lot for 8D response and containment. IATF 16949 customer complaint handling requires lot-level traceability — a fu',
    `booking_id` BIGINT COMMENT 'Foreign key linking to sales.booking. Business justification: Customer complaint resolution in semiconductors requires tracing the complaint to the originating shipment/booking for warranty claim processing, DPPM reporting, and revenue impact assessment. A domai',
    `capa_record_id` BIGINT COMMENT 'Unique identifier for the capa record record within the customer complaint quality entity.',
    `contact_id` BIGINT COMMENT 'Unique identifier for the contact record within the customer complaint quality entity.',
    `defect_record_id` BIGINT COMMENT 'Foreign key linking to quality.defect_record. Business justification: A customer complaint can reference a specific defect record that was identified during inspection or returned material analysis. This FK links the customer complaint to the specific defect observation',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Field failures and DPPM complaints in semiconductors are tracked back to the originating design win to assess qualification status, revenue-at-risk, and competitive displacement risk. This traceabilit',
    `ic_catalog_id` BIGINT COMMENT 'Identifier of the product or component the complaint concerns.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: A customer complaint can be traced back to a specific inspection lot — the lot that was shipped and subsequently reported as defective. This FK enables lot-level complaint traceability, supports DPPM ',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: A customer complaint can trigger or be associated with a nonconformance report documenting the material or process deviation. This FK links the customer-facing complaint to the internal NCR, enabling ',
    `parent_customer_complaint_id` BIGINT COMMENT 'Self-referencing FK on customer_complaint (related_customer_complaint_id)',
    `unit_test_result_id` BIGINT COMMENT 'Foreign key linking to test.unit_test_result. Business justification: Customer complaints about specific device serial numbers are traced to the unit_test_result for that device. Quality engineers check pass/fail status and bin assignment at test for warranty claim inve',
    `wafer_id` BIGINT COMMENT 'Identifier of the wafer on which the defect was observed.',
    `batch_number` STRING COMMENT 'Batch identifier for the production run.',
    `closure_date` DATE COMMENT 'Date when the complaint record was formally closed.',
    `complaint_category` STRING COMMENT 'The complaint category of the customer complaint record in the quality domain.',
    `complaint_description` STRING COMMENT 'The complaint description of the customer complaint record in the quality domain.',
    `complaint_number` STRING COMMENT 'Business-visible identifier assigned to the complaint for tracking and reference.',
    `complaint_status` STRING COMMENT 'The complaint status of the customer complaint record in the quality domain.',
    `complaint_timestamp` TIMESTAMP COMMENT 'Date and time when the complaint was initially recorded.',
    `complaint_type` STRING COMMENT 'Categorization of the complaint based on its root cause domain.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the complaint triggers a compliance investigation.',
    `corrective_action_completion_date` DATE COMMENT 'Date when the corrective action was completed.',
    `corrective_action_due_date` DATE COMMENT 'Target date for completing the corrective action.',
    `corrective_action_plan` STRING COMMENT 'Planned actions to address the root cause.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action.',
    `cost_adjustments` DECIMAL(18,2) COMMENT 'Adjustments (e.g., discounts, rebates) applied to the gross cost.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total estimated cost associated with the complaint before adjustments.',
    `cost_net` DECIMAL(18,2) COMMENT 'Net cost after adjustments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the complaint record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `customer_complaint_status` STRING COMMENT 'Current lifecycle status of the complaint.',
    `defect_quantity` BIGINT COMMENT 'The defect quantity of the customer complaint record in the quality domain.',
    `customer_complaint_description` STRING COMMENT 'Detailed narrative provided by the customer describing the issue.',
    `disposition` STRING COMMENT 'The disposition of the customer complaint record in the quality domain.',
    `dppm_impact` DECIMAL(18,2) COMMENT 'Measured impact of the complaint expressed in DPPM.',
    `escalation_flag` BOOLEAN COMMENT 'True if the complaint has been escalated to higher management.',
    `escalation_level` STRING COMMENT 'Level of escalation applied to the complaint.',
    `inspection_result` STRING COMMENT 'Result of the quality inspection related to the complaint.',
    `is_customer_impact` BOOLEAN COMMENT 'The is customer impact of the customer complaint record in the quality domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the customer complaint record in the quality domain.',
    `lot_number` STRING COMMENT 'Manufacturing lot identifier associated with the affected product.',
    `manufacturing_site_code` STRING COMMENT 'Code representing the plant or fab where the product was produced.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `notes` STRING COMMENT 'Free‑form notes captured by quality engineers.',
    `priority` STRING COMMENT 'Business priority assigned to the complaint for handling urgency.',
    `received_date` DATE COMMENT 'The received date associated with the customer complaint quality record.',
    `record_audit_created` TIMESTAMP COMMENT 'The record audit created of the customer complaint record in the quality domain.',
    `record_audit_updated` TIMESTAMP COMMENT 'The record audit updated of the customer complaint record in the quality domain.',
    `regulatory_report_flag` BOOLEAN COMMENT 'True if the complaint must be reported to a regulatory body.',
    `regulatory_report_number` STRING COMMENT 'Identifier of the regulatory report filed for this complaint.',
    `resolution_date` DATE COMMENT 'Date on which the complaint was resolved.',
    `resolution_status` STRING COMMENT 'Current status of the corrective or remedial action.',
    `resolution_summary` STRING COMMENT 'The resolution summary of the customer complaint record in the quality domain.',
    `root_cause` STRING COMMENT 'Identified underlying cause of the defect or failure.',
    `root_cause_code` STRING COMMENT 'Standardized code representing the root cause category.',
    `severity` STRING COMMENT 'Severity rating indicating the impact of the complaint on product performance or safety.',
    `source_channel` STRING COMMENT 'Channel through which the complaint was received.',
    `target_resolution_date` DATE COMMENT 'The target resolution date associated with the customer complaint quality record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the complaint record.',
    `warranty_claim_flag` BOOLEAN COMMENT 'Indicates whether the complaint resulted in a warranty claim.',
    `warranty_claim_number` STRING COMMENT 'Reference number for the associated warranty claim.',
    CONSTRAINT pk_customer_complaint PRIMARY KEY(`customer_complaint_id`)
) COMMENT 'Customer complaint record tracking reported issues, investigation, and resolution with customer satisfaction metrics.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_wafer_map_id` FOREIGN KEY (`wafer_map_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`wafer_map`(`wafer_map_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_wafer_map_id` FOREIGN KEY (`wafer_map_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`wafer_map`(`wafer_map_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_defect_record_id` FOREIGN KEY (`defect_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`defect_record`(`defect_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_defect_record_id` FOREIGN KEY (`defect_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`defect_record`(`defect_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_customer_complaint_id` FOREIGN KEY (`customer_complaint_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`customer_complaint`(`customer_complaint_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_defect_record_id` FOREIGN KEY (`defect_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`defect_record`(`defect_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_reliability_test_id` FOREIGN KEY (`reliability_test_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`reliability_test`(`reliability_test_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_defect_record_id` FOREIGN KEY (`defect_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`defect_record`(`defect_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_parent_customer_complaint_id` FOREIGN KEY (`parent_customer_complaint_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`customer_complaint`(`customer_complaint_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_subdomain' = 'material_inspection');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `tool_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria (Number of Defects Allowed)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `defect_density` SET TAGS ('dbx_business_glossary_term' = 'Defect Density (Defects per Unit Area)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'accept|reject|hold|rework');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `disposition_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposition Reason');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `external_lot_code` SET TAGS ('dbx_business_glossary_term' = 'External Lot Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `external_lot_code` SET TAGS ('dbx_natural_key_normalized' = 'fabrication.fabrication_wafer_lot.lot_number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `external_lot_code` SET TAGS ('dbx_denormalized' = 'false');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `iatf_16949_compliant` SET TAGS ('dbx_business_glossary_term' = 'IATF 16949 Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|closed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_business_glossary_term' = 'Inspection Stage');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_value_regex' = 'iqc|feol|beol|packaging|final');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'visual|metrology|electrical|functional|chemical');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `iso_9001_compliant` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `jedec_reliability_compliant` SET TAGS ('dbx_business_glossary_term' = 'JEDEC Reliability Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `kgd_certification_date` SET TAGS ('dbx_business_glossary_term' = 'KGD Certification Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `kgd_certified` SET TAGS ('dbx_business_glossary_term' = 'Known Good Die Certified');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size (Number of Units)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Type (Incoming|In-Process|Final|Rework|Hold)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_value_regex' = 'incoming|in_process|final|rework|hold');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'wafer|mask|chemical|gas|assembly');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'nm|um|mm|percent|count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `quality_engineer` SET TAGS ('dbx_business_glossary_term' = 'Quality Engineer Name');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `quality_engineer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `quality_engineer` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `rejection_criteria` SET TAGS ('dbx_business_glossary_term' = 'Rejection Criteria (Number of Defects)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `sampling_plan_aql` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Acceptable Quality Level (AQL)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'wafer|die|unit');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (mm)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` SET TAGS ('dbx_subdomain' = 'material_inspection');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_record_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Record ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Detection Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Detection Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Core Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `wafer_map_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Wafer Map Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Recipe Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Maintenance Event Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `bin_assignment` SET TAGS ('dbx_business_glossary_term' = 'Bin Assignment');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `classification_method` SET TAGS ('dbx_business_glossary_term' = 'Classification Method');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_area_um2` SET TAGS ('dbx_business_glossary_term' = 'Defect Area (µm²)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_category` SET TAGS ('dbx_business_glossary_term' = 'Defect Category');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_classification` SET TAGS ('dbx_business_glossary_term' = 'Defect Classification');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_density_per_zone` SET TAGS ('dbx_business_glossary_term' = 'Defect Density per Zone');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_layer` SET TAGS ('dbx_business_glossary_term' = 'Defect Layer');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_layer` SET TAGS ('dbx_value_regex' = 'feol|mol|beol|passivation|metal');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_record_status` SET TAGS ('dbx_business_glossary_term' = 'Defect Record Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_severity` SET TAGS ('dbx_business_glossary_term' = 'Defect Severity');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|warning|info');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_size_nm` SET TAGS ('dbx_business_glossary_term' = 'Defect Size (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_size_um` SET TAGS ('dbx_business_glossary_term' = 'Defect Size Um');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_status` SET TAGS ('dbx_business_glossary_term' = 'Defect Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_status` SET TAGS ('dbx_value_regex' = 'open|investigating|resolved|closed|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_type` SET TAGS ('dbx_business_glossary_term' = 'Defect Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'optical|ebeam|sem|afm');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `die_x` SET TAGS ('dbx_business_glossary_term' = 'Die X Grid Coordinate');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `die_y` SET TAGS ('dbx_business_glossary_term' = 'Die Y Grid Coordinate');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Defect Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'scrap|rework|accept|hold');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `edge_exclusion_zone_flag` SET TAGS ('dbx_business_glossary_term' = 'Edge Exclusion Zone Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `flat_notch_orientation` SET TAGS ('dbx_business_glossary_term' = 'Flat/Notch Orientation');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `flat_notch_orientation` SET TAGS ('dbx_value_regex' = 'flat|notch');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `inspection_recipe` SET TAGS ('dbx_business_glossary_term' = 'Inspection Recipe');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `repeatability_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeatability Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `severity_class` SET TAGS ('dbx_business_glossary_term' = 'Severity Class');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `x_coordinate` SET TAGS ('dbx_business_glossary_term' = 'X Coordinate (mm)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `x_coordinate` SET TAGS ('dbx_pii_geolocation' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `x_coordinate` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `x_coordinate` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `y_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Y Coordinate (mm)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `y_coordinate` SET TAGS ('dbx_pii_geolocation' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `y_coordinate` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `y_coordinate` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` SET TAGS ('dbx_subdomain' = 'material_inspection');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `wafer_map_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Map Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `bin_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Definition Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Tool ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `physical_layout_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `bad_die_count` SET TAGS ('dbx_business_glossary_term' = 'Bad Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `bin_count_total` SET TAGS ('dbx_business_glossary_term' = 'Total Bin Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `bin_summary` SET TAGS ('dbx_business_glossary_term' = 'Bin Summary');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `compliance_iatf16949` SET TAGS ('dbx_business_glossary_term' = 'IATF 16949 Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `compliance_iso9001` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `defect_density_per_sqmm` SET TAGS ('dbx_business_glossary_term' = 'Defect Density (defects per mm²)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `defect_type` SET TAGS ('dbx_business_glossary_term' = 'Defect Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `defect_type` SET TAGS ('dbx_value_regex' = 'particle|scratch|void|contamination|other');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `defect_zone` SET TAGS ('dbx_business_glossary_term' = 'Defect Zone');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `defect_zone` SET TAGS ('dbx_value_regex' = 'center|edge|corner|random');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `die_grid_columns` SET TAGS ('dbx_business_glossary_term' = 'Die Grid Columns');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `die_grid_rows` SET TAGS ('dbx_business_glossary_term' = 'Die Grid Rows');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `die_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Die Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `edge_exclusion_zone_mm` SET TAGS ('dbx_business_glossary_term' = 'Edge Exclusion Zone (mm)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `fail_bin_code` SET TAGS ('dbx_business_glossary_term' = 'Fail Bin Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `fail_bin_code` SET TAGS ('dbx_value_regex' = 'FAIL');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `failing_die_count` SET TAGS ('dbx_business_glossary_term' = 'Failing Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `flat_orientation` SET TAGS ('dbx_business_glossary_term' = 'Flat Orientation');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `flat_orientation` SET TAGS ('dbx_value_regex' = 'north|south|east|west');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `good_die_count` SET TAGS ('dbx_business_glossary_term' = 'Good Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `is_kgd_certified` SET TAGS ('dbx_business_glossary_term' = 'KGD Certified Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `kgd_certification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'KGD Certification Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `map_checksum` SET TAGS ('dbx_business_glossary_term' = 'Map Checksum');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `map_file_path` SET TAGS ('dbx_business_glossary_term' = 'Map File Path');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `map_format` SET TAGS ('dbx_business_glossary_term' = 'Map Format');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `map_generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Map Generation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `map_status` SET TAGS ('dbx_business_glossary_term' = 'Map Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `map_status` SET TAGS ('dbx_value_regex' = 'generated|validated|rejected|archived');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `map_type` SET TAGS ('dbx_business_glossary_term' = 'Map Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `map_version` SET TAGS ('dbx_business_glossary_term' = 'Map Version');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `pass_bin_code` SET TAGS ('dbx_business_glossary_term' = 'Pass Bin Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `pass_bin_code` SET TAGS ('dbx_value_regex' = 'PASS');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `passing_die_count` SET TAGS ('dbx_business_glossary_term' = 'Passing Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `total_die_count` SET TAGS ('dbx_business_glossary_term' = 'Total Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `wafer_map_status` SET TAGS ('dbx_business_glossary_term' = 'Wafer Map Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` SET TAGS ('dbx_subdomain' = 'material_inspection');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `yield_record_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Record ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `equipment_process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Process Recipe Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Process Recipe ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Maintenance Event Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `wafer_map_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Map Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `bin_distribution_summary` SET TAGS ('dbx_business_glossary_term' = 'Bin Distribution Summary');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'calibrated|uncalibrated');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `defect_density` SET TAGS ('dbx_business_glossary_term' = 'Defect Density');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `defect_density_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Defect Density (defects/cm²)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `defect_type` SET TAGS ('dbx_business_glossary_term' = 'Defect Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `defect_type` SET TAGS ('dbx_value_regex' = 'critical|major|minor|none');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `die_per_wafer` SET TAGS ('dbx_business_glossary_term' = 'Die Per Wafer');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `fab_line` SET TAGS ('dbx_business_glossary_term' = 'Fab Line');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `good_die_count` SET TAGS ('dbx_business_glossary_term' = 'Good Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail|rework');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `inspection_system` SET TAGS ('dbx_business_glossary_term' = 'Inspection System');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `lot_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Lot Humidity (%)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `lot_origin` SET TAGS ('dbx_business_glossary_term' = 'Lot Origin');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `lot_status` SET TAGS ('dbx_value_regex' = 'in_process|completed|held');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `lot_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Lot Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `measurement_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Measurement Accuracy (%)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'optical|electrical|thermal');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `measurement_stage` SET TAGS ('dbx_business_glossary_term' = 'Measurement Stage');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `measurement_stage` SET TAGS ('dbx_value_regex' = 'wafer_probe|final_test|packaged');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `measurement_variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Measurement Variance (%)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `quality_gate` SET TAGS ('dbx_business_glossary_term' = 'Quality Gate');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `quality_gate` SET TAGS ('dbx_value_regex' = 'wafer_sort|final_test|package_test');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `record_date` SET TAGS ('dbx_business_glossary_term' = 'Record Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|swing|night');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `source_file_name` SET TAGS ('dbx_business_glossary_term' = 'Source File Name');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `test_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Test Time (seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `tool_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Tool Serial Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `total_die_count` SET TAGS ('dbx_business_glossary_term' = 'Total Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `yield_gap_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Gap (%)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `yield_loss_category` SET TAGS ('dbx_business_glossary_term' = 'Yield Loss Category');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `yield_loss_category` SET TAGS ('dbx_value_regex' = 'random_defect|systematic|parametric|test_escape|other');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `yield_record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `yield_record_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|pending_review');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `yield_stage` SET TAGS ('dbx_business_glossary_term' = 'Yield Stage');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `yield_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Target (%)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `yield_type` SET TAGS ('dbx_business_glossary_term' = 'Yield Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` SET TAGS ('dbx_subdomain' = 'material_inspection');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `reliability_test_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Test ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Test Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Failure Analysis Method');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `analysis_method` SET TAGS ('dbx_value_regex' = 'SEM|FIB|EMMI|curve_trace|other');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `applicable_standard` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standard (STD)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `applicable_standard` SET TAGS ('dbx_value_regex' = 'AEC_Q100|AEC_Q101|JESD47|ISO_9001');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `compliance_iatf_16949` SET TAGS ('dbx_business_glossary_term' = 'IATF 16949 Compliance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `compliance_iso_9001` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Compliance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `compliance_jedec` SET TAGS ('dbx_business_glossary_term' = 'JEDEC Compliance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `fail_count` SET TAGS ('dbx_business_glossary_term' = 'Fail Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `failure_count` SET TAGS ('dbx_business_glossary_term' = 'Failure Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `failure_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Failure Mechanism');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `failure_mechanism` SET TAGS ('dbx_value_regex' = 'electromigration|TDDB|HCI|NBTI|stress_rupture|other');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `failure_mode` SET TAGS ('dbx_value_regex' = 'open_circuit|short_circuit|param_shift|timing_error|other');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `failure_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Failed Unit Serial Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `failure_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Failure Time (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `fit_rate` SET TAGS ('dbx_business_glossary_term' = 'FIT Rate (Failures In Time)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `fit_rate_confidence` SET TAGS ('dbx_business_glossary_term' = 'FIT Rate Confidence (%)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Humidity Percent');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `is_kgd_certified` SET TAGS ('dbx_business_glossary_term' = 'KGD Certified Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `milestone_schedule` SET TAGS ('dbx_business_glossary_term' = 'Milestone Schedule');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `overall_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `overall_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `pass_fail_criteria` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Criteria');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Reliability Program Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `qualification_plan_version` SET TAGS ('dbx_business_glossary_term' = 'Qualification Plan Version');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type (QUAL_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'new_product|process_change|osat_qualification|pcn_driven');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `reliability_grade` SET TAGS ('dbx_business_glossary_term' = 'Reliability Grade');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `reliability_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `reliability_test_status` SET TAGS ('dbx_business_glossary_term' = 'Reliability Test Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `root_cause_classification` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Classification');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `root_cause_classification` SET TAGS ('dbx_value_regex' = 'design|process|material|handling|unknown');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature C');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Test Duration (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Test Humidity (%)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_location` SET TAGS ('dbx_business_glossary_term' = 'Test Location');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_standard` SET TAGS ('dbx_business_glossary_term' = 'Test Standard');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'scheduled|running|completed|aborted');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Test Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type (TEST_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'HTOL|HAST|TC|ESD|JEDEC_stress');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Test Voltage (V)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `weibull_scale_parameter` SET TAGS ('dbx_business_glossary_term' = 'Weibull Scale Parameter (η)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `weibull_shape_parameter` SET TAGS ('dbx_business_glossary_term' = 'Weibull Shape Parameter (β)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'CAPA Record Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `defect_record_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Record Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Related Maintenance Event Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `tool_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `attachment_reference` SET TAGS ('dbx_business_glossary_term' = 'Attachment Reference');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `capa_number` SET TAGS ('dbx_business_glossary_term' = 'CAPA Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `capa_record_status` SET TAGS ('dbx_business_glossary_term' = 'CAPA Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `capa_record_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `capa_status` SET TAGS ('dbx_business_glossary_term' = 'Capa Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `capa_type` SET TAGS ('dbx_business_glossary_term' = 'CAPA Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `capa_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `closure_approval_status` SET TAGS ('dbx_business_glossary_term' = 'CAPA Closure Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `closure_approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Closure Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `compliance_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reference');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `cost_actual` SET TAGS ('dbx_business_glossary_term' = 'CAPA Actual Cost');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'CAPA Cost Estimate');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'CAPA Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|Other');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `detection_date` SET TAGS ('dbx_business_glossary_term' = 'Detection Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `detection_phase` SET TAGS ('dbx_business_glossary_term' = 'Detection Phase');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `detection_phase` SET TAGS ('dbx_value_regex' = 'design|fabrication|testing|field');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Detection Source');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `effectiveness_verification_criteria` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verification Criteria');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `impact` SET TAGS ('dbx_business_glossary_term' = 'CAPA Impact');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'CAPA Notes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `preventive_action_description` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'CAPA Priority');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = '1|2|3|4|5');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `problem_description` SET TAGS ('dbx_business_glossary_term' = 'Problem Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `problem_statement` SET TAGS ('dbx_business_glossary_term' = 'Problem Statement');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'CAPA Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `root_cause_method` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Method');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `root_cause_method` SET TAGS ('dbx_value_regex' = '5_why|ishikawa|fta|pareto');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'CAPA Severity');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `verification_result` SET TAGS ('dbx_business_glossary_term' = 'Verification Result');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `verification_result` SET TAGS ('dbx_value_regex' = 'pass|fail|partial');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Source Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Maintenance Event Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `attached_document_ids` SET TAGS ('dbx_business_glossary_term' = 'Attached Document IDs');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_value_regex' = 'ISO 9001|IATF 16949|JEDEC');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'pending|completed|not_applicable');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `customer_notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `nonconformance_report_description` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `detected_date` SET TAGS ('dbx_business_glossary_term' = 'Detected Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `detection_point` SET TAGS ('dbx_business_glossary_term' = 'Detection Point');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `die_range` SET TAGS ('dbx_business_glossary_term' = 'Die Range');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `disposition_action_required` SET TAGS ('dbx_business_glossary_term' = 'Disposition Action Required');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'use_as_is|rework|scrap|return_to_supplier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `hold_initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Initiated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `hold_release_condition` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Condition');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `hold_released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Released Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'process_excursion|spc_out_of_control|customer_complaint|reliability_failure');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `impact_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Impact Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `impact_currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `is_customer_impact` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `mrb_decision` SET TAGS ('dbx_business_glossary_term' = 'Material Review Board Decision');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `mrb_decision` SET TAGS ('dbx_value_regex' = 'approve|reject|defer');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `ncr_number` SET TAGS ('dbx_business_glossary_term' = 'Ncr Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `ncr_status` SET TAGS ('dbx_business_glossary_term' = 'Ncr Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `nonconformance_description` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `nonconformance_report_status` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `nonconformance_report_status` SET TAGS ('dbx_value_regex' = 'open|under_review|closed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `nonconformance_type` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `report_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` SET TAGS ('dbx_subdomain' = 'material_inspection');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification ID (QUALITY_SPEC_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `limit_id` SET TAGS ('dbx_business_glossary_term' = 'Limit Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria Description (ACCEPTANCE_CRITERIA)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_business_glossary_term' = 'Specification Applicability Scope (SPEC_APPLICABILITY_SCOPE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_value_regex' = 'wafer|die|package|assembly');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPROVAL_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (APPROVED_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Specification Audit Trail (SPEC_AUDIT_TRAIL)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Specification Change Reason (SPEC_CHANGE_REASON)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Specification Document URL (SPEC_DOCUMENT_URL)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_FROM)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_UNTIL)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `iatf_16949_compliant` SET TAGS ('dbx_business_glossary_term' = 'IATF 16949 Compliance Flag (IATF_16949_COMPLIANT)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method (INSPECTION_METHOD)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `inspection_method` SET TAGS ('dbx_value_regex' = 'optical|electron|acoustic|other');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `iso_9001_compliant` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Compliance Flag (ISO_9001_COMPLIANT)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `jedec_reliability_compliant` SET TAGS ('dbx_business_glossary_term' = 'JEDEC Reliability Compliance Flag (JEDEC_RELIABILITY_COMPLIANT)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `last_validated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Validation Date (SPEC_LAST_VALIDATED_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LOWER_LIMIT)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Spec Limit');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `measurement_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Measurement Accuracy Percent (MEASUREMENT_ACCURACY_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `measurement_variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Measurement Variance Percent (MEASUREMENT_VARIANCE_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `nominal_value` SET TAGS ('dbx_business_glossary_term' = 'Nominal Value (NOMINAL_VALUE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Specification Notes (SPEC_NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name (PARAMETER_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `quality_spec_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Lifecycle Status (SPEC_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `quality_spec_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired|pending');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Specification Review Cycle (SPEC_REVIEW_CYCLE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'annual|quarterly|ad_hoc');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Revision Number (SPEC_REVISION_NUMBER)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `spec_code` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Code (SPEC_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `spec_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Name (SPEC_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `spec_number` SET TAGS ('dbx_business_glossary_term' = 'Spec Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `spec_status` SET TAGS ('dbx_business_glossary_term' = 'Spec Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `spec_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Type (SPEC_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `spec_type` SET TAGS ('dbx_value_regex' = 'electrical|dimensional|visual|reliability|other');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type (TEST_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'functional|stress|environmental|reliability|visual');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (UPPER_LIMIT)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Spec Limit');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `validated_flag` SET TAGS ('dbx_business_glossary_term' = 'Specification Validated Flag (SPEC_VALIDATED_FLAG)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Spec Version');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` SET TAGS ('dbx_subdomain' = 'material_inspection');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `quality_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `defect_record_id` SET TAGS ('dbx_business_glossary_term' = 'Related Defect Record ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Held Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Held Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Maintenance Event Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `affected_entity_ref` SET TAGS ('dbx_business_glossary_term' = 'Affected Entity ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `affected_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Affected Entity Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `affected_entity_type` SET TAGS ('dbx_value_regex' = 'wafer_lot|die_bank|finished_good|inventory_batch');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `affected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Affected Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `compliance_iatf_16949_flag` SET TAGS ('dbx_business_glossary_term' = 'IATF 16949 Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `compliance_iso_9001_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `compliance_jedec_flag` SET TAGS ('dbx_business_glossary_term' = 'JEDEC Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiration Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `hold_category` SET TAGS ('dbx_business_glossary_term' = 'Hold Category');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `hold_category` SET TAGS ('dbx_value_regex' = 'safety|quality|regulatory|customer');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Number (QH)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|released|cancelled|pending_review');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `hold_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'process_excursion|spc_out_of_control|customer_complaint|reliability_failure|other');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Hold Initiating Engineer ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Initiation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `is_kgd_certified` SET TAGS ('dbx_business_glossary_term' = 'KGD Certified Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Hold Notes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Placed Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Hold Priority');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `quality_hold_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `release_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Reason Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Released Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `required_disposition_actions` SET TAGS ('dbx_business_glossary_term' = 'Required Disposition Actions');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Resolution Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|resolved');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_analysis_report_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Analysis Report ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Record Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `defect_record_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Record Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Related Maintenance Event Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `physical_layout_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Nonconformance Report Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `reliability_test_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Test Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `tool_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `unit_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Test Result Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `analysis_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `analysis_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `analysis_technique` SET TAGS ('dbx_business_glossary_term' = 'Analysis Technique');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `analysis_technique` SET TAGS ('dbx_value_regex' = 'SEM|FIB|EMMI|TEM|EDX|Other');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `conclusion` SET TAGS ('dbx_business_glossary_term' = 'Conclusion');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `defect_code` SET TAGS ('dbx_value_regex' = '^Dd{4}$');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `fa_number` SET TAGS ('dbx_business_glossary_term' = 'Fa Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_analysis_report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_analysis_report_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|rejected|closed');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Failure Mechanism');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_severity` SET TAGS ('dbx_business_glossary_term' = 'Failure Severity');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|warning');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_site_location` SET TAGS ('dbx_business_glossary_term' = 'Failure Site Location');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `far_number` SET TAGS ('dbx_business_glossary_term' = 'Far Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Report Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `report_title` SET TAGS ('dbx_business_glossary_term' = 'Report Title');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'reliability_test|customer_return|in_process|design_review');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `sample_description` SET TAGS ('dbx_business_glossary_term' = 'Sample Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `supporting_evidence_refs` SET TAGS ('dbx_business_glossary_term' = 'Supporting Evidence References');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Record Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `defect_record_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Record Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `parent_customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Related Customer Complaint Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `parent_customer_complaint_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `unit_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Test Result Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_business_glossary_term' = 'Complaint Category');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Complaint Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_business_glossary_term' = 'Complaint Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_business_glossary_term' = 'Complaint Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `complaint_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Complaint Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `complaint_type` SET TAGS ('dbx_business_glossary_term' = 'Complaint Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `cost_adjustments` SET TAGS ('dbx_business_glossary_term' = 'Cost Adjustments');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `cost_net` SET TAGS ('dbx_business_glossary_term' = 'Cost Net');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `customer_complaint_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `defect_quantity` SET TAGS ('dbx_business_glossary_term' = 'Defect Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `customer_complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `dppm_impact` SET TAGS ('dbx_business_glossary_term' = 'Dppm Impact');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `is_customer_impact` SET TAGS ('dbx_business_glossary_term' = 'Is Customer Impact');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `manufacturing_site_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `regulatory_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `regulatory_report_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `resolution_summary` SET TAGS ('dbx_business_glossary_term' = 'Resolution Summary');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `warranty_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Number');
