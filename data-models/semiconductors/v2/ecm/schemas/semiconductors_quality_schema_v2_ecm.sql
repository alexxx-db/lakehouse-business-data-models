-- Schema for Domain: quality | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 12:17:29

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`quality` COMMENT 'Quality assurance, reliability testing, defect inspection, metrology, DPPM tracking, FMEA, and qualification programs. Manages KGD certification, yield analysis, customer quality notifications, and compliance with ISO 9001, IATF 16949, and JEDEC reliability standards. Integrates with KLA ICOS inspection systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` (
    `inspection_lot_id` BIGINT COMMENT 'Unique identifier for the inspection lot record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inspection lot cost allocation required for budgeting and internal accounting; finance cost_center tracks these expenses.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Export compliance verification requires each inspected lot to be linked to the export license authorizing its shipment.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_wafer_lot. Business justification: Inspection lot records are tied to a specific wafer lot for lot‑level quality inspection; linking enables lot‑level inspection reports and traceability.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Inspection lot reports are generated per IC part; linking to ic_catalog enables traceability for compliance and lot‑by‑lot quality reports.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Required for Inspection Lot Traceability Report linking each lot to its originating IC design project for root‑cause analysis and compliance.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Inspection Lot Report requires linking each lot to the Fab Tool used for inspection to ensure traceability and compliance.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for Inspection Lot Traceability Report: links each lot to the inspector employee who performed the inspection.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Opportunity‑to‑Lot traceability report ties production lot quality outcomes back to the originating sales opportunity for revenue impact analysis.',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Inspection lot is generated per order line; linking enables traceability for warranty and inspection reporting.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Inspection lot tracking ties each lot to the specific process step being inspected, required for lot‑by‑step quality dashboards.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Inspection Lot‑PO traceability required for Supplier Performance Review reports linking inspection results to the originating purchase order.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier providing the material.',
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
    `lot_size` BIGINT COMMENT 'Total number of units (wafers, dies, or packaged parts) in the lot.',
    `lot_type` STRING COMMENT 'Classification of the lot based on its position in the workflow.. Valid values are `incoming|in_process|final|rework|hold`',
    `material_type` STRING COMMENT 'Type of material the lot consists of.. Valid values are `wafer|mask|chemical|gas|assembly`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Timestamp of the primary measurement taken during inspection.',
    `measurement_unit` STRING COMMENT 'Unit of the measured value.. Valid values are `nm|um|mm|percent|count`',
    `measurement_value` DECIMAL(18,2) COMMENT 'Numeric value of the key measurement (e.g., critical dimension).',
    `notes` STRING COMMENT 'Free‑form notes or comments about the inspection lot.',
    `quality_engineer` STRING COMMENT 'Name of the quality engineer responsible for the lot.',
    `rejection_criteria` STRING COMMENT 'Defect count threshold that triggers rejection.',
    `sample_size` STRING COMMENT 'Number of units sampled from the lot.',
    `sampling_plan_aql` STRING COMMENT 'AQL value defined for the sampling plan.',
    `technology_node` STRING COMMENT 'Process technology node used for the lot.. Valid values are `5nm|7nm|10nm|14nm|28nm|45nm`',
    `unit_of_measure` STRING COMMENT 'Unit used to quantify the lot size.. Valid values are `wafer|die|unit`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `wafer_size_mm` DECIMAL(18,2) COMMENT 'Diameter of wafers in the lot, expressed in millimetres.',
    `yield_percent` DECIMAL(18,2) COMMENT 'Percentage of good units produced from the lot.',
    CONSTRAINT pk_inspection_lot PRIMARY KEY(`inspection_lot_id`)
) COMMENT 'Master record for a quality inspection lot representing a batch of wafers, dies, or packaged units submitted for quality inspection at any stage. Covers all inspection types: incoming material (IQC for raw wafers, chemicals, photomasks, gases, OSAT subassemblies with supplier and PO reference), in-process (FEOL, BEOL, packaging), and final outgoing. Captures lot origin, supplier ID (for IQC), inspection type, inspection stage, lot size, sampling plan parameters (AQL, sample size, acceptance/rejection numbers), inspection results, measured parameters, and disposition decision (accept, reject, hold, rework). Integrates with SAP QM and Camstar MES for lot status management and goods receipt inspection. SSOT for all quality inspection activities across the fab-to-finish flow including incoming quality control.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` (
    `defect_record_id` BIGINT COMMENT 'Unique identifier for the defect record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Defect handling expenses are charged to a cost center for financial tracking of quality loss costs.',
    `defect_cluster_id` BIGINT COMMENT 'Identifier linking defects that belong to the same spatial cluster.',
    `design_ip_core_id` BIGINT COMMENT 'Foreign key linking to design.ip_core. Business justification: Needed for Defect Attribution Report to associate each defect with the specific IP core block used in the design, enabling targeted remediation.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Defect Analysis Report ties each defect to the detecting Fab Tool for root‑cause analysis and corrective action planning.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who performed the inspection.',
    `experimental_lot_id` BIGINT COMMENT 'Foreign key linking to research.experimental_lot. Business justification: Research defect analysis ties defect records to the experimental lot they originated from for root‑cause analysis of new process nodes.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the wafer lot containing the wafer.',
    `inspection_lot_id` BIGINT COMMENT 'FK to quality.inspection_lot.inspection_lot_id — Every defect is detected within an inspection lot. This is the fundamental parent-child relationship for defect tracking. Without this FK, defects cannot be traced to their inspection context.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Defect Tracking & Recall Management uses the inventory lot ID to locate and quarantine affected stock across the supply chain.',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Defect records must be tied to the originating order line for root‑cause analysis, warranty claims, and corrective actions.',
    `wafer_map_id` BIGINT COMMENT 'FK to quality.wafer_map.wafer_map_id — Defects with X/Y coordinates must link to the wafer map for spatial analysis. This is critical for systematic defect pattern detection.',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to process.recipe. Business justification: Defect analysis reports need the recipe used during the step to correlate process parameters with defect types.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Root cause analysis requires linking each defect record to the exact process step where the defect originated, used in RCA reports.',
    `wafer_id` BIGINT COMMENT 'Identifier of the wafer on which the defect was observed.',
    `wafer_zone_id` BIGINT COMMENT 'Logical zone on the wafer used for density calculations.',
    `bin_assignment` STRING COMMENT 'Pass/fail bin code assigned to the die (e.g., P, F1, F2).',
    `comments` STRING COMMENT 'Additional free‑form notes from the inspector or analyst.',
    `corrective_action` STRING COMMENT 'Planned or executed action to remediate the defect.',
    `defect_area_um2` DOUBLE COMMENT 'Calculated area of the defect in square micrometers.',
    `defect_classification` STRING COMMENT 'High‑level classification of the defect (e.g., particle, patterning, etch).',
    `defect_code` STRING COMMENT 'Standardized code representing the defect type (e.g., D001, D002).',
    `defect_density_per_zone` DOUBLE COMMENT 'Number of defects per unit area within the zone.',
    `defect_layer` STRING COMMENT 'Process layer where the defect was found.. Valid values are `feol|mol|beol|passivation|metal`',
    `defect_severity` STRING COMMENT 'Severity rating indicating impact on yield.. Valid values are `critical|major|minor|warning|info`',
    `defect_size_nm` DOUBLE COMMENT 'Measured size of the defect in nanometers.',
    `defect_status` STRING COMMENT 'Current workflow status of the defect record.. Valid values are `open|investigating|resolved|closed|rejected`',
    `detection_method` STRING COMMENT 'Technique used to detect the defect.. Valid values are `optical|ebeam|sem|afm`',
    `die_x` STRING COMMENT 'Column index of the die containing the defect on the wafer grid.',
    `die_y` STRING COMMENT 'Row index of the die containing the defect on the wafer grid.',
    `disposition` STRING COMMENT 'Final handling decision for the defect.. Valid values are `scrap|rework|accept|hold`',
    `edge_exclusion_zone_flag` BOOLEAN COMMENT 'Indicates whether the defect lies within the defined edge exclusion area.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the defect was detected during inspection.',
    `flat_notch_orientation` STRING COMMENT 'Orientation of wafer flat or notch relative to the defect.. Valid values are `flat|notch`',
    `inspection_recipe` STRING COMMENT 'Name of the inspection recipe or parameter set used.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the defect record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the defect record.',
    `repeatability_flag` BOOLEAN COMMENT 'True if the defect pattern repeats across multiple wafers.',
    `root_cause` STRING COMMENT 'Narrative description of the identified root cause.',
    `x_coordinate` DOUBLE COMMENT 'Horizontal position of the defect on the wafer map (millimeters).',
    `y_coordinate` DOUBLE COMMENT 'Vertical position of the defect on the wafer map (millimeters).',
    CONSTRAINT pk_defect_record PRIMARY KEY(`defect_record_id`)
) COMMENT 'Transactional record capturing individual defect events, wafer-level defect maps, and spatial bin distributions detected during wafer inspection, die sort, or final test. At the defect event level: stores defect classification code, defect coordinates (X/Y on wafer map), defect size, defect layer (FEOL/MOL/BEOL), detection method (KLA ICOS optical, e-beam, SEM), severity rating, and disposition (scrap, rework, accept). At the wafer map level: captures per-wafer die grid coordinates, per-die pass/fail bin assignment, defect density per zone, edge exclusion zone, flat/notch orientation, and map generation timestamp. Enables yield spatial analysis, systematic defect pattern detection (repeater analysis, cluster detection), and wafer-level bin map visualization. Integrates directly with KLA ICOS inspection system output and ATE wafer probing systems. SSOT for all defect events, spatial defect analysis, and wafer-level quality maps.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` (
    `wafer_map_id` BIGINT COMMENT 'Primary key for wafer_map',
    `employee_id` BIGINT COMMENT 'Identifier of the operator or system user who initiated the map generation.',
    `experimental_lot_id` BIGINT COMMENT 'Foreign key linking to research.experimental_lot. Business justification: Wafer maps are associated with experimental lots to evaluate new wafer designs in research projects.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the inspection tool that produced the map.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the fabrication lot containing the wafer.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Wafer Map Archive ties each map to the inventory wafer lot for yield analysis and historical compliance audits.',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: Costing and pricing analysis links wafer map data to the original sales quote to validate pricing assumptions against actual silicon usage.',
    `wafer_id` BIGINT COMMENT 'Identifier of the wafer associated with this map.',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: REQUIRED: Test execution (wafer_probe_run) creates the wafer map; traceability report links map to its probe run for root‑cause analysis.',
    `bin_count_total` STRING COMMENT 'Total number of distinct bins used in the map.',
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
    `is_kgd_certified` BOOLEAN COMMENT 'Indicates whether the wafer passed Known Good Die certification.',
    `kgd_certification_timestamp` TIMESTAMP COMMENT 'Timestamp when KGD certification was applied.',
    `map_checksum` STRING COMMENT 'Checksum (e.g., SHA-256) of the map file for integrity verification.',
    `map_file_path` STRING COMMENT 'File system path or URI where the wafer map image/file is stored.',
    `map_generation_timestamp` TIMESTAMP COMMENT 'Date and time when the wafer map was generated.',
    `map_status` STRING COMMENT 'Current processing status of the wafer map.. Valid values are `generated|validated|rejected|archived`',
    `map_version` STRING COMMENT 'Version identifier of the map generation algorithm or software.',
    `pass_bin_code` STRING COMMENT 'Bin code representing passing (good) dies.. Valid values are `PASS`',
    `passing_die_count` STRING COMMENT 'Number of dies classified as passing.',
    `remarks` STRING COMMENT 'Free-text comments or notes about the wafer map.',
    `total_die_count` STRING COMMENT 'Total number of dies evaluated on the wafer.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_wafer_map PRIMARY KEY(`wafer_map_id`)
) COMMENT 'Spatial defect and bin distribution map for an individual wafer within an inspection lot. Captures wafer ID, lot ID, die grid coordinates, per-die pass/fail bin assignment, defect density per zone, edge exclusion zone, flat/notch orientation, and map generation timestamp. Sourced from KLA ICOS and ATE wafer probing systems. Enables yield spatial analysis and systematic defect pattern detection.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` (
    `yield_record_id` BIGINT COMMENT 'System-generated unique identifier for the yield record.',
    `employee_id` BIGINT COMMENT 'Identifier of the operator or technician overseeing the measurement.',
    `experimental_lot_id` BIGINT COMMENT 'Foreign key linking to research.experimental_lot. Business justification: Yield data from quality is linked to experimental lots to assess the success of research‑driven process changes.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the equipment that performed the measurement.',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: REQUIRED: Yield records reference the final test run that produced pass/fail counts; needed for yield vs. test performance dashboards.',
    `inspection_lot_id` BIGINT COMMENT 'FK to quality.inspection_lot.inspection_lot_id — Yield measurements are taken at quality gates associated with inspection lots. This link enables yield-to-defect correlation analysis.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Yield Reporting aggregates yield percentages per inventory lot for financial reporting and customer yield guarantees.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Yield records are aggregated per process step; linking provides step‑level yield analysis for continuous improvement.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Yield performance is reported per profit center to assess profitability of product lines.',
    `recipe_id` BIGINT COMMENT 'Identifier of the process recipe applied to the wafer.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Yield records are produced per SKU for production performance dashboards; FK to sku replaces denormalized product_sku column.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Supports Yield Analysis Dashboard linking yield data to the corresponding tapeout, essential for performance tracking and cost forecasting.',
    `wafer_id` BIGINT COMMENT 'Unique identifier for the individual wafer.',
    `batch_number` STRING COMMENT 'Identifier of the data acquisition batch.',
    `bin_distribution_summary` STRING COMMENT 'Compact representation (e.g., JSON) of die bin counts across test bins.',
    `calibration_status` STRING COMMENT 'Indicates whether the measurement equipment was calibrated.. Valid values are `calibrated|uncalibrated`',
    `comments` STRING COMMENT 'Free-text notes or observations related to the measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the yield record was first created in the system.',
    `defect_count` BIGINT COMMENT 'Number of defects detected for the specified defect type.',
    `defect_density_per_cm2` DECIMAL(18,2) COMMENT 'Number of defects per square centimeter of wafer area.',
    `defect_type` STRING COMMENT 'Classification of the dominant defect observed.. Valid values are `critical|major|minor|none`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the yield measurement was captured.',
    `fab_line` STRING COMMENT 'Production line identifier within the fab.',
    `good_die_count` BIGINT COMMENT 'Number of dies that passed all quality tests.',
    `inspection_result` STRING COMMENT 'Overall pass/fail outcome of the inspection.. Valid values are `pass|fail|rework`',
    `inspection_system` STRING COMMENT 'Name of the inspection/metrology system used (e.g., KLA ICOS).',
    `lot_humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity of the fab environment during measurement.',
    `lot_origin` STRING COMMENT 'Fab location code where the wafer lot originated.',
    `lot_status` STRING COMMENT 'Current processing status of the wafer lot.. Valid values are `in_process|completed|held`',
    `lot_temperature_c` DECIMAL(18,2) COMMENT 'Average temperature of the wafer lot during measurement.',
    `measurement_accuracy_percent` DECIMAL(18,2) COMMENT 'Stated accuracy of the measurement as a percentage.',
    `measurement_method` STRING COMMENT 'Physical method used to obtain the yield measurement.. Valid values are `optical|electrical|thermal`',
    `measurement_stage` STRING COMMENT 'Quality gate at which the yield was measured.. Valid values are `wafer_probe|final_test|packaged`',
    `measurement_unit` STRING COMMENT 'Unit of the primary measurement (e.g., percent, count).',
    `measurement_variance_percent` DECIMAL(18,2) COMMENT 'Statistical variance observed across repeated measurements.',
    `process_node` STRING COMMENT 'Technology node (e.g., 7nm, 5nm) used for the wafer.',
    `quality_gate` STRING COMMENT 'Specific quality gate where the measurement was recorded.. Valid values are `wafer_sort|final_test|package_test`',
    `shift` STRING COMMENT 'Work shift during which the measurement was taken.. Valid values are `day|swing|night`',
    `source_file_name` STRING COMMENT 'Name of the source file or data feed that supplied the measurement.',
    `test_time_seconds` DECIMAL(18,2) COMMENT 'Total time taken to perform the yield test.',
    `tool_serial_number` STRING COMMENT 'Serial number of the measurement tool.',
    `total_die_count` BIGINT COMMENT 'Total number of dies on the wafer lot.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the yield record.',
    `yield_gap_percent` DECIMAL(18,2) COMMENT 'Difference between actual yield and target yield.',
    `yield_loss_category` STRING COMMENT 'Root cause classification for yield loss.. Valid values are `random_defect|systematic|parametric|test_escape|other`',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Yield expressed as a percentage of good dies over total dies.',
    `yield_record_status` STRING COMMENT 'Current validation status of the yield record.. Valid values are `valid|invalid|pending_review`',
    `yield_target_percent` DECIMAL(18,2) COMMENT 'Target yield percentage defined for the product/process.',
    CONSTRAINT pk_yield_record PRIMARY KEY(`yield_record_id`)
) COMMENT 'Transactional record capturing yield measurement outcomes at each quality gate: wafer probe (die sort yield), final test yield, and packaged unit yield. Stores wafer lot ID, process node, product SKU, total die count, good die count, yield percentage, bin distribution summary, yield loss category (random defect, systematic, parametric, test escape), and measurement timestamp. SSOT for yield tracking across the fab-to-finish flow.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` (
    `spc_chart_id` BIGINT COMMENT 'Unique identifier for the SPC chart record. _canonical_skip_reason: Entity does not fit standard role categories and is modeled as a custom data product.',
    `control_plan_id` BIGINT COMMENT 'Identifier of the control plan that defines the SPC parameters for this chart.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who performed the measurement or logged the data.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the wafer lot associated with the measurement.',
    `inspection_lot_id` BIGINT COMMENT 'FK to quality.inspection_lot.inspection_lot_id — SPC measurements are taken during inspection activities. Out-of-control SPC signals trigger inspection lot holds. This is the process control to inspection feedback loop.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: SPC Dashboard monitors process control metrics linked to the specific inventory lot to trigger corrective actions.',
    `opc_rule_set_id` BIGINT COMMENT 'Foreign key linking to process.opc_rule_set. Business justification: OPC rule set defines target CD for the step; SPC chart must reference it for model‑based control limits per JEDEC standards.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: SPC charts are generated per process step; linking enables automated retrieval of step metadata for control‑limit calculations.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: SPC Chart‑PO association enables statistical process control monitoring tied to specific supplier purchase orders.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: SPC charts created during research runs are stored with the associated research project for statistical analysis.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: SPC Dashboard links each chart to the Fab Tool that generated the data, enabling tool‑level performance monitoring.',
    `wafer_id` BIGINT COMMENT 'Identifier of the specific wafer within the lot.',
    `assignable_cause_code` STRING COMMENT 'Code representing the identified root cause for an out‑of‑control signal.',
    `chart_type` STRING COMMENT 'Statistical chart type used for the measurement series.. Valid values are `xbar_r|c_chart|p_chart|np_chart|cusum|ewma`',
    `comments` STRING COMMENT 'Additional notes or observations related to the measurement.',
    `control_limit_center` DECIMAL(18,2) COMMENT 'Center line value (process mean) for the chart.',
    `control_limit_lower` DECIMAL(18,2) COMMENT 'Calculated lower control limit for the chart.',
    `control_limit_upper` DECIMAL(18,2) COMMENT 'Calculated upper control limit for the chart.',
    `corrective_action_reference` STRING COMMENT 'Identifier of the corrective action taken to address the assignable cause.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the SPC chart record was created in the system.',
    `data_source_system` STRING COMMENT 'Originating system that supplied the measurement data.. Valid values are `KLA_ICOS|Camstar|SmartFactory`',
    `die_position` STRING COMMENT 'Identifier of the individual die (chip) measured.',
    `effective_end_date` DATE COMMENT 'Date when this SPC chart configuration was retired or superseded.',
    `effective_start_date` DATE COMMENT 'Date when this SPC chart configuration became effective.',
    `is_baseline` BOOLEAN COMMENT 'True if this chart serves as the baseline for comparative analysis.',
    `measurement_method` STRING COMMENT 'Technique by which the measurement was obtained.. Valid values are `inline|offline|automated`',
    `measurement_subgroup` STRING COMMENT 'Logical grouping identifier for the sample (e.g., lot number, wafer ID).',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the measurement was recorded.',
    `measurement_tool` STRING COMMENT 'Equipment or system that performed the measurement.. Valid values are `KLA|ASML|custom`',
    `measurement_value` DECIMAL(18,2) COMMENT 'Observed value of the monitored parameter for the sample.',
    `out_of_control_flag` BOOLEAN COMMENT 'True when the measurement falls outside control limits.',
    `parameter_name` STRING COMMENT 'Name of the process parameter being monitored (e.g., CD, Thickness, Resistivity).',
    `parameter_unit` STRING COMMENT 'Unit of measure for the monitored parameter (e.g., nm, µm, %).',
    `sample_size` STRING COMMENT 'Number of units in each sample subgroup.',
    `sampling_frequency` STRING COMMENT 'How often samples are taken for this SPC chart.. Valid values are `hourly|daily|per_lot|per_shift|per_batch|per_run`',
    `shift` STRING COMMENT 'Work shift during which the measurement was taken.. Valid values are `A|B|C|D`',
    `spc_chart_status` STRING COMMENT 'Operational status of the SPC chart record.. Valid values are `active|inactive|archived|pending`',
    `spc_to_metrology` BIGINT COMMENT 'FK to quality.metrology_measurement.metrology_measurement_id — SPC charts are populated by metrology measurements. This is the fundamental data flow from measurement to statistical control.',
    `spc_to_spec` BIGINT COMMENT 'FK to quality.spec.spec_id — SPC control limits are derived from product/process specifications. The spec product defines the acceptance criteria that SPC monitors against. This link is essential for automated OOC detection.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the SPC chart record.',
    `version_number` STRING COMMENT 'Version number of the control plan applied to this chart.',
    CONSTRAINT pk_spc_chart PRIMARY KEY(`spc_chart_id`)
) COMMENT 'Statistical Process Control record encompassing both the control plan definition and ongoing chart measurements for a specific process step and tool combination. Captures control plan parameters (monitored parameters, chart type, sampling frequency, sample size, reaction plan), control chart data (X-bar/R, CUSUM, EWMA values), UCL/LCL/CL values, out-of-control signal flags, assignable cause codes, and corrective action references. Supports IATF 16949 and ISO 9001 SPC requirements for process stability monitoring. SSOT for SPC configuration and measurement tracking.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` (
    `fmea_record_id` BIGINT COMMENT 'Unique system-generated identifier for each Failure Mode and Effects Analysis (FMEA) record.',
    `fabrication_process_step_id` BIGINT COMMENT 'Foreign key hint to the manufacturing process step entity.',
    `sku_id` BIGINT COMMENT 'Foreign key hint to the product master record associated with this FMEA.',
    `action_owner` STRING COMMENT 'Name or identifier of the person accountable for implementing the recommended action.',
    `approval_date` DATE COMMENT 'Date on which the FMEA was formally approved by quality management.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who granted final approval.',
    `cause_of_failure` STRING COMMENT 'Identified underlying cause(s) that could lead to the failure mode.',
    `comments` STRING COMMENT 'Open text field for any supplemental information or notes.',
    `compliance_standards` STRING COMMENT 'Enumerated list of quality or industry standards governing the FMEA.. Valid values are `IATF16949|ISO9001|JEDEC`',
    `control_plan_reference` STRING COMMENT 'Identifier linking the FMEA to the relevant control plan document.',
    `created_by_user` STRING COMMENT 'Identifier of the system user who entered the FMEA record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the FMEA record was initially entered into the system.',
    `detection_method` STRING COMMENT 'Technique or inspection method employed to discover the failure during manufacturing or testing.',
    `detection_rating` STRING COMMENT 'Numerical rating (1‑10) indicating how likely the failure will be detected before it reaches the customer.',
    `detection_technique` STRING COMMENT 'Specific detection approach (e.g., visual inspection, automated metrology).. Valid values are `visual|automated|test|simulation`',
    `effective_date` DATE COMMENT 'Date from which the FMEA record is considered active for risk management.',
    `failure_mode_description` STRING COMMENT 'Narrative describing how the failure can occur within the product or process.',
    `fmea_code` STRING COMMENT 'Business‑level code used to reference the FMEA in reports and change management systems.',
    `fmea_name` STRING COMMENT 'Human‑readable name that identifies the FMEA, often reflecting the product or process it evaluates.',
    `fmea_record_status` STRING COMMENT 'Lifecycle status of the FMEA record, tracking its progression from creation to retirement.. Valid values are `draft|review|approved|released|retired`',
    `fmea_scope` STRING COMMENT 'Narrative defining the boundaries (product, process, geography) covered by the analysis.',
    `fmea_to_qualification` BIGINT COMMENT 'FK to quality.qualification_program.qualification_program_id — FMEAs feed into qualification programs. IATF 16949 requires FMEA linkage to qualification activities.',
    `fmea_type` STRING COMMENT 'Indicates whether the record is a Design FMEA (DFMEA) or Process FMEA (PFMEA).. Valid values are `DFMEA|PFMEA`',
    `is_critical` BOOLEAN COMMENT 'True if the failure mode is deemed critical to product safety or performance.',
    `last_modified_by_user` STRING COMMENT 'Identifier of the system user who performed the most recent update.',
    `occurrence_rating` STRING COMMENT 'Numerical rating (1‑10) representing the probability that the failure mode will occur.',
    `post_action_rpn` STRING COMMENT 'Re‑calculated risk priority number after corrective actions have been applied.',
    `potential_effect` STRING COMMENT 'Explanation of the impact on the customer if the failure mode materializes.',
    `recommended_action` STRING COMMENT 'Text describing the action(s) proposed to mitigate the identified failure mode.',
    `related_design_item` STRING COMMENT 'Reference to the specific IC design element, IP core, or component associated with the failure.',
    `related_process_step` STRING COMMENT 'Name or identifier of the manufacturing/process step where the failure is observed.',
    `revision_number` STRING COMMENT 'Sequential version identifier tracking changes to the FMEA over time.',
    `risk_category` STRING COMMENT 'High‑level classification of the failure mode origin.. Valid values are `design|process|system`',
    `risk_priority_number` STRING COMMENT 'Calculated risk priority number derived from severity, occurrence, and detection ratings.',
    `severity_rating` STRING COMMENT 'Numerical rating (1‑10) of the seriousness of the failure effect on the end customer.',
    `target_completion_date` DATE COMMENT 'Planned date by which the recommended action should be finished.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the latest modification to the FMEA record.',
    CONSTRAINT pk_fmea_record PRIMARY KEY(`fmea_record_id`)
) COMMENT 'Failure Mode and Effects Analysis record documenting potential failure modes for a product design or manufacturing process step. Captures failure mode description, potential effect on end customer, severity rating (S), occurrence probability (O), detection rating (D), RPN (Risk Priority Number = S×O×D), recommended actions, responsible owner, target completion date, and post-action revised RPN. Supports IATF 16949 DFMEA and PFMEA requirements.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` (
    `reliability_test_id` BIGINT COMMENT 'Unique identifier for the reliability test record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer associated with the qualification.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Reliability test results are required evidence for product certification; linking ties each test to its certification record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Reliability test costs are allocated to a cost center for cost‑of‑quality accounting.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the test equipment used (e.g., KLA ICOS system).',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the wafer lot from which samples were taken.',
    `fmea_record_id` BIGINT COMMENT 'FK to quality.fmea_record.fmea_record_id — Reliability test failures validate or invalidate FMEA failure mode predictions. FMEA recommended actions often include reliability testing. qualification_program description states Links to reliabili',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Reliability test results are tied to a specific IC part; required for qualification compliance and customer reliability reports.',
    `reliability_test_run_id` BIGINT COMMENT 'Foreign key linking to test.reliability_test_run. Business justification: REQUIRED: Reliability test plan must be associated with each execution run to satisfy JEDEC reliability compliance and generate post‑run reports.',
    `analysis_method` STRING COMMENT 'Technique used to analyze the failed device.. Valid values are `SEM|FIB|EMMI|curve_trace|other`',
    `applicable_standard` STRING COMMENT 'Industry standard governing the qualification (e.g., AEC‑Q100, JEDEC JESD47).. Valid values are `AEC_Q100|AEC_Q101|JESD47|ISO_9001`',
    `approval_authority` STRING COMMENT 'Name or role of the person/committee approving the qualification.',
    `compliance_iatf_16949` BOOLEAN COMMENT 'True if the test complies with automotive quality standard IATF 16949.',
    `compliance_iso_9001` BOOLEAN COMMENT 'True if the test complies with ISO 9001 quality management requirements.',
    `compliance_jedec` BOOLEAN COMMENT 'True if the test follows applicable JEDEC reliability standards.',
    `data_source_system` STRING COMMENT 'Source system that supplied the reliability test data (e.g., KLA ICOS).',
    `device_type` STRING COMMENT 'Identifier for the device family or SKU under test.',
    `failure_mechanism` STRING COMMENT 'Physical mechanism responsible for the failure.. Valid values are `electromigration|TDDB|HCI|NBTI|stress_rupture|other`',
    `failure_mode` STRING COMMENT 'Observed mode of failure for the device.. Valid values are `open_circuit|short_circuit|param_shift|timing_error|other`',
    `failure_serial_number` STRING COMMENT 'Serial number of the device that failed during testing.',
    `failure_time_hours` DECIMAL(18,2) COMMENT 'Time elapsed until failure, measured in hours.',
    `fit_rate` DECIMAL(18,2) COMMENT 'Calculated failure rate expressed in FIT (10⁹ hours).',
    `fit_rate_confidence` DECIMAL(18,2) COMMENT 'Statistical confidence level for the reported FIT rate.',
    `is_kgd_certified` BOOLEAN COMMENT 'Indicates whether the device is Known Good Die (KGD) certified.',
    `milestone_schedule` STRING COMMENT 'Key milestones and dates for the qualification program.',
    `operator_name` STRING COMMENT 'Name of the technician who ran the test.',
    `overall_status` STRING COMMENT 'Current lifecycle status of the qualification program.. Valid values are `pending|in_progress|completed|failed|cancelled`',
    `pass_fail_criteria` STRING COMMENT 'Business rule defining pass or fail for the test (e.g., max failure rate).',
    `program_code` STRING COMMENT 'Business identifier for the reliability qualification program.',
    `qualification_plan_version` STRING COMMENT 'Version identifier of the qualification plan document.',
    `qualification_type` STRING COMMENT 'Type of qualification driving the reliability test.. Valid values are `new_product|process_change|osat_qualification|pcn_driven`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reliability test record was created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reliability test record.',
    `reliability_grade` STRING COMMENT 'Qualitative reliability grade assigned to the device.. Valid values are `A|B|C|D`',
    `reltest_to_qualification` BIGINT COMMENT 'FK to quality.qualification_program.qualification_program_id — Reliability tests are executed as part of qualification programs. This link is essential for tracking qualification completeness.',
    `root_cause_classification` STRING COMMENT 'High‑level classification of the root cause.. Valid values are `design|process|material|handling|unknown`',
    `sample_size` STRING COMMENT 'Number of devices subjected to the test.',
    `test_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the stress test, in hours.',
    `test_execution_timestamp` TIMESTAMP COMMENT 'Date and time when the test was executed.',
    `test_humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity level during the test, expressed as a percentage.',
    `test_location` STRING COMMENT 'Facility or fab where the test was performed.',
    `test_result` STRING COMMENT 'Overall pass/fail outcome of the test.. Valid values are `pass|fail`',
    `test_status` STRING COMMENT 'Current execution status of the test.. Valid values are `scheduled|running|completed|aborted`',
    `test_temperature_c` DECIMAL(18,2) COMMENT 'Temperature set point for the stress test, in degrees Celsius.',
    `test_type` STRING COMMENT 'Stress test methodology applied.. Valid values are `HTOL|HAST|TC|ESD|JEDEC_stress`',
    `test_voltage_v` DECIMAL(18,2) COMMENT 'Voltage applied during the stress test, in volts.',
    `weibull_scale_parameter` DECIMAL(18,2) COMMENT 'Scale parameter of the Weibull reliability model.',
    `weibull_shape_parameter` DECIMAL(18,2) COMMENT 'Shape parameter of the Weibull reliability model.',
    CONSTRAINT pk_reliability_test PRIMARY KEY(`reliability_test_id`)
) COMMENT 'Master record for reliability qualification programs and individual test execution, encompassing program definition, test planning, stress test execution, and failure event tracking. At the program level: captures qualification type (new product, process change, OSAT qualification, PCN-driven), applicable standards (AEC-Q100, JEDEC JESD47, ISO 9001), qualification plan version, milestone schedule, overall qualification status, and approval authority. At the test level: captures test type (HTOL, HAST, TC, ESD, JEDEC stress tests), test conditions (temperature, voltage, humidity, duration), sample size, device type, pass/fail criteria, and individual failure details including failed unit serial number, failure time (hours), failure mode, failure analysis method (SEM, FIB, EMMI, curve trace), root cause classification, and failure mechanism (electromigration, TDDB, HCI, NBTI). SSOT for JEDEC JESD47 and AEC-Q100/Q101 qualification lifecycle from program initiation through test execution to final disposition, FIT rate calculations, and Weibull reliability modeling.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` (
    `quality_qualification_program_id` BIGINT COMMENT 'Unique surrogate key for the qualification program record.',
    `product_qualification_program_id` BIGINT COMMENT 'Foreign key linking to product.qualification_program. Business justification: Quality qualification programs map one‑to‑one with product qualification programs for tracking regulatory and internal compliance.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Qualification Program Management requires linking each program to its owner employee for governance reporting.',
    `fmea_record_id` BIGINT COMMENT 'Reference to the Failure Mode and Effects Analysis linked to this program.',
    `test_plan_id` BIGINT COMMENT 'Reference to the detailed test plan used during qualification.',
    `research_program_id` BIGINT COMMENT 'Foreign key linking to research.program. Business justification: Qualification programs certify new technologies and are managed under the corresponding research program.',
    `actual_yield_percent` DECIMAL(18,2) COMMENT 'Measured wafer yield achieved during qualification.',
    `applicable_standards` STRING COMMENT 'Comma‑separated list of standards governing the program (e.g., AEC‑Q100, JEDEC JESD47, ISO 9001).',
    `approval_authority` STRING COMMENT 'Name or role of the individual/committee that approves the program.',
    `approval_date` DATE COMMENT 'Date on which the qualification program was formally approved.',
    `change_request_number` STRING COMMENT 'Identifier of the change request that triggered the qualification (if PCN‑driven).',
    `compliance_status` STRING COMMENT 'Current compliance posture against applicable standards.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualification program record was first created.',
    `customer_notification_required` BOOLEAN COMMENT 'Indicates whether customers must be notified of qualification outcomes.',
    `documentation_link` STRING COMMENT 'URL or path to the primary qualification program documentation.',
    `dppm_actual` DECIMAL(18,2) COMMENT 'Measured DPPM observed during qualification.',
    `dppm_target` DECIMAL(18,2) COMMENT 'Maximum acceptable DPPM for the qualification program.',
    `effective_from` DATE COMMENT 'Date on which the qualification program becomes binding.',
    `effective_until` DATE COMMENT 'Date on which the qualification program expires or is superseded (nullable for open‑ended).',
    `final_disposition` STRING COMMENT 'Outcome after program completion indicating product release eligibility.. Valid values are `qualified|rejected|conditional|withdrawn`',
    `kgd_certification_required` BOOLEAN COMMENT 'Flag indicating if Known Good Die certification is mandatory for the program.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of the qualification program.',
    `last_reviewed_by` STRING COMMENT 'User identifier of the person who performed the last review.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the qualification program.. Valid values are `draft|planned|in_progress|completed|closed|cancelled`',
    `milestone_schedule` STRING COMMENT 'Serialized representation (e.g., JSON) of key milestones and target dates.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the qualification program.',
    `overall_status` STRING COMMENT 'Aggregated result of the qualification program.. Valid values are `pass|fail|pending|deferred`',
    `program_budget_usd` DECIMAL(18,2) COMMENT 'Allocated budget for the qualification effort expressed in US dollars.',
    `program_category` STRING COMMENT 'High‑level classification of the program for reporting and governance.. Valid values are `internal|customer|regulatory|partner`',
    `program_code` STRING COMMENT 'Business identifier or code used to reference the program in ERP/PLM systems.',
    `program_manager` STRING COMMENT 'Person responsible for day‑to‑day management of the qualification program.',
    `program_name` STRING COMMENT 'Human‑readable name of the qualification program.',
    `qualification_plan_version` STRING COMMENT 'Version identifier for the detailed qualification plan document.',
    `qualification_type` STRING COMMENT 'Category of qualification: new product, process change, OSAT qualification, or PCN‑driven.. Valid values are `new_product|process_change|osat|pcn_driven`',
    `regulatory_approval_status` STRING COMMENT 'Status of any required regulatory clearances.. Valid values are `approved|pending|rejected`',
    `risk_level` STRING COMMENT 'Overall risk rating assigned to the qualification program.. Valid values are `low|medium|high|critical`',
    `statistical_process_control_included` BOOLEAN COMMENT 'True if SPC data collection is part of the qualification activities.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Desired wafer yield expressed as a percent.',
    `updated_by` STRING COMMENT 'User identifier of the person who last updated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    `version_number` STRING COMMENT 'Version identifier for the qualification plan, e.g., V1.0, V2.1.',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_quality_qualification_program PRIMARY KEY(`quality_qualification_program_id`)
) COMMENT 'Master record for a product or process qualification program governing the full set of qualification activities required before production release. Captures qualification type (new product, process change, OSAT qualification, PCN-driven), applicable standards (AEC-Q100, JEDEC JESD47, ISO 9001), qualification plan version, milestone schedule, overall qualification status, approval authority, and final disposition. Links to reliability tests, FMEA records, and PCN events.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` (
    `quality_kgd_certification_id` BIGINT COMMENT 'System-generated unique identifier for the KGD certification record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Supports the Customer‑Specific KGD Certification Management workflow, replacing free‑text customer_name with a reference to the customer account for accurate certification tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: KGD Certification Process mandates tracking the engineer who signs off each certification for audit trails.',
    `die_bank_id` BIGINT COMMENT 'Identifier of the die lot that was certified.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: KGD Certification records must reference the Fab Tool used for testing to satisfy JEDEC reliability audit requirements.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification was formally approved.',
    `burn_in_status` STRING COMMENT 'Indicates whether burn‑in testing was performed and its outcome.. Valid values are `completed|not_required|pending`',
    `certification_batch` STRING COMMENT 'Batch identifier grouping multiple certifications performed together.',
    `certification_date` DATE COMMENT 'Date the certification was issued.',
    `certification_location` STRING COMMENT 'Physical location where the certification was performed.',
    `certification_number` STRING COMMENT 'Human‑readable identifier assigned to the certification.',
    `certification_reference` STRING COMMENT 'External reference code used by customers or partners to track the certification.',
    `certification_standard` STRING COMMENT 'Standard or specification against which the die lot was certified.. Valid values are `JEDEC_JESD49|JEDEC_JESD20|CUSTOM`',
    `compliance_iatf16949` BOOLEAN COMMENT 'True if the certification complies with automotive quality standards.',
    `compliance_iso9001` BOOLEAN COMMENT 'True if the certification complies with ISO 9001 quality standards.',
    `compliance_jedec` BOOLEAN COMMENT 'True if the certification meets JEDEC requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification record was created.',
    `customer_requirements` STRING COMMENT 'Any customer‑specific KGD criteria or notes.',
    `expiration_reason` STRING COMMENT 'Reason why the certification expired or was terminated.. Valid values are `end_of_life|customer_request|quality_issue|other`',
    `expiry_date` DATE COMMENT 'Date the certification becomes invalid.',
    `kgd_version` STRING COMMENT 'Version of the KGD certification schema applied.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the certification.',
    `parametric_screen_result` STRING COMMENT 'Result of the parametric screening step.. Valid values are `pass|fail|conditional`',
    `part_number` STRING COMMENT 'Manufacturer part number of the product associated with the die lot.',
    `quality_kgd_certification_status` STRING COMMENT 'Current lifecycle state of the certification.. Valid values are `active|expired|revoked`',
    `reliability_grade` STRING COMMENT 'Overall reliability classification assigned to the die lot.. Valid values are `A|B|C|D|E`',
    `revision_number` STRING COMMENT 'Revision count of the certification record.',
    `test_coverage_percent` DECIMAL(18,2) COMMENT 'Percentage of required tests that were successfully completed.',
    `test_duration_hours` DECIMAL(18,2) COMMENT 'Length of time the test was run.',
    `test_temperature_c` DECIMAL(18,2) COMMENT 'Temperature at which the test was conducted.',
    `test_type` STRING COMMENT 'Category of test performed for the certification.. Valid values are `electrical|parametric|reliability`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification record.',
    CONSTRAINT pk_quality_kgd_certification PRIMARY KEY(`quality_kgd_certification_id`)
) COMMENT 'Known Good Die certification record attesting that a specific die lot has passed all required electrical, parametric, and reliability screens for bare-die shipment to customers. Captures die lot ID, product part number, certification standard (JEDEC JESD49), test coverage percentage, burn-in status, parametric screen results, certification date, expiry date, certifying engineer, and customer-specific KGD requirements. Critical for advanced packaging and MCM customers.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` (
    `dppm_record_id` BIGINT COMMENT 'System-generated unique identifier for the DPPM record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer who received the shipment and reported the defect.',
    `capa_record_id` BIGINT COMMENT 'FK to quality.capa_record.capa_record_id — Customer quality issues (DPPM events, 8D reports) trigger CAPA records. This link is required for customer complaint resolution tracking per IATF 16949.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: DPPM records track defective units per part number; linking to ic_catalog enables part‑level defect analytics.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the DPPM record was first created in the system.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the DPPM record.',
    `closure_status` STRING COMMENT 'Current closure state of the quality notification.. Valid values are `open|closed|in_progress|deferred`',
    `compliance_iso9001` STRING COMMENT 'Compliance status of the record with ISO 9001 quality management requirements.',
    `containment_action` STRING COMMENT 'Immediate actions taken to contain the defect and prevent further impact.',
    `corrective_action` STRING COMMENT 'Corrective steps implemented to eliminate the root cause.',
    `defective_units` BIGINT COMMENT 'Number of units returned by the customer that were identified as defective.',
    `dppm_value` DECIMAL(18,2) COMMENT 'Calculated DPPM value for the shipment period (defective_units / total_units_shipped * 1,000,000).',
    `eight_d_report_reference` STRING COMMENT 'Identifier of the associated 8‑D problem‑solving report.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp of the primary quality event (e.g., notification creation).',
    `failure_description` STRING COMMENT 'Narrative description of the observed failure mode or defect.',
    `is_kgd_certified` BOOLEAN COMMENT 'Indicates whether the returned die was a Known Good Die (KGD) certified part.',
    `kgd_certification_date` DATE COMMENT 'Date on which the KGD certification was granted.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle state of the DPPM record.. Valid values are `draft|submitted|approved|closed`',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `notification_type` STRING COMMENT 'Classification of the quality notification associated with the record.. Valid values are `8D|SCAR|Customer_Complaint|Field_Return|Other`',
    `part_number` STRING COMMENT 'Manufacturer part number (MPN) of the semiconductor product associated with the DPPM record.',
    `preventive_action` STRING COMMENT 'Preventive measures introduced to avoid recurrence of similar defects.',
    `record_number` STRING COMMENT 'Business identifier assigned to the DPPM record, used for external reference and tracking.',
    `response_due_date` DATE COMMENT 'Date by which the customer or supplier must respond to the notification.',
    `root_cause` STRING COMMENT 'Root cause analysis result identifying the underlying reason for the defect.',
    `shipment_end_date` DATE COMMENT 'Last calendar date of the shipment period covered by this DPPM record.',
    `shipment_start_date` DATE COMMENT 'First calendar date of the shipment period covered by this DPPM record.',
    `total_units_shipped` BIGINT COMMENT 'Total number of units shipped to the customer during the shipment period.',
    CONSTRAINT pk_dppm_record PRIMARY KEY(`dppm_record_id`)
) COMMENT 'Customer quality performance and communication record encompassing DPPM tracking, formal quality notifications (8D, SCAR, customer complaints), field return management, and customer-facing quality communications. Captures product part number, customer account, shipment period, total units shipped, defective units returned, DPPM value, notification type, failure description, containment actions, root cause, corrective/preventive actions, 8D report reference, response due date, and closure status. SSOT for all customer-facing quality metrics, notifications, and communications per IATF 16949 customer satisfaction monitoring. Integrates with Salesforce CRM for customer communication tracking.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` (
    `capa_record_id` BIGINT COMMENT 'System-generated unique identifier for the CAPA record.',
    `audit_id` BIGINT COMMENT 'FK to quality.audit.audit_id — Audit findings (now merged into audit) trigger CAPAs. audit_finding description states linked CAPA record. This is a mandatory operational link for ISO 9001 clause 10.2.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CAPA implementation costs are allocated to a cost center to monitor corrective action spending.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for implementing the CAPA.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the wafer or lot linked to the issue.',
    `nonconformance_report_id` BIGINT COMMENT 'FK to quality.nonconformance_report.nonconformance_report_id — CAPAs are triggered by nonconformances. This is a critical traceability link for ISO 9001 clause 10.2 compliance.',
    `quality_audit_finding_id` BIGINT COMMENT 'Identifier of the audit finding associated with the CAPA.',
    `customer_complaint_id` BIGINT COMMENT 'Identifier of the customer complaint that triggered the CAPA.',
    `defect_record_id` BIGINT COMMENT 'Identifier of the defect record linked to this CAPA.',
    `sku_id` BIGINT COMMENT 'Identifier of the product or design associated with the CAPA.',
    `actual_completion_date` DATE COMMENT 'Date when the action was actually completed.',
    `attachment_reference` STRING COMMENT 'Reference (e.g., URL or file ID) to supporting documents or images.',
    `capa_number` STRING COMMENT 'Business identifier or code assigned to the CAPA for tracking and reference.',
    `capa_record_status` STRING COMMENT 'Current lifecycle status of the CAPA record.. Valid values are `open|in_progress|closed|rejected`',
    `capa_type` STRING COMMENT 'Indicates whether the action is corrective or preventive.. Valid values are `corrective|preventive`',
    `closure_approval_status` STRING COMMENT 'Approval status of the CAPA closure after verification.. Valid values are `approved|rejected|pending`',
    `closure_date` DATE COMMENT 'Date when the CAPA was formally closed.',
    `compliance_reference` STRING COMMENT 'Reference to the specific compliance clause or standard (e.g., ISO 9001, IATF 16949) governing the CAPA.',
    `corrective_action_description` STRING COMMENT 'Specific actions planned or taken to eliminate the identified root cause.',
    `cost_actual` DECIMAL(18,2) COMMENT 'Actual financial cost incurred after implementation.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated financial cost to implement the corrective or preventive action.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CAPA record was initially created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for cost fields.. Valid values are `USD|EUR|JPY|CNY|GBP|Other`',
    `department` STRING COMMENT 'Business department owning the CAPA (e.g., Quality, Engineering).',
    `detection_date` DATE COMMENT 'Date when the problem was first detected.',
    `detection_phase` STRING COMMENT 'Phase of the product lifecycle where the issue was detected.. Valid values are `design|fabrication|testing|field`',
    `detection_source` STRING COMMENT 'Source of detection (e.g., inspection, customer, audit).',
    `effectiveness_verification_criteria` STRING COMMENT 'Criteria and metrics used to verify that the CAPA was effective.',
    `impact` STRING COMMENT 'Description of the business or technical impact of the non‑conformance.',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the CAPA.',
    `preventive_action_description` STRING COMMENT 'Actions designed to prevent recurrence of similar issues in the future.',
    `priority` STRING COMMENT 'Priority ranking to schedule the CAPA work.. Valid values are `1|2|3|4|5`',
    `problem_statement` STRING COMMENT 'Clear description of the problem or non‑conformance that triggered the CAPA.',
    `record_audit_created` TIMESTAMP COMMENT 'Audit timestamp for when the record was first captured in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Audit timestamp for the most recent modification of the record.',
    `risk_level` STRING COMMENT 'Risk assessment of the issue before mitigation.. Valid values are `high|medium|low`',
    `root_cause_description` STRING COMMENT 'Detailed narrative of the identified root cause.',
    `root_cause_method` STRING COMMENT 'Methodology used to determine the root cause (e.g., 5‑Why, Ishikawa, FTA, Pareto).. Valid values are `5_why|ishikawa|fta|pareto`',
    `severity` STRING COMMENT 'Severity level of the issue addressed by the CAPA.. Valid values are `critical|high|medium|low`',
    `target_completion_date` DATE COMMENT 'Planned date by which the corrective or preventive action should be completed.',
    `verification_date` DATE COMMENT 'Date when the effectiveness of the CAPA was verified.',
    `verification_result` STRING COMMENT 'Outcome of the effectiveness verification.. Valid values are `pass|fail|partial`',
    `created_by` STRING COMMENT 'User identifier of the person who created the CAPA record.',
    CONSTRAINT pk_capa_record PRIMARY KEY(`capa_record_id`)
) COMMENT 'Corrective and Preventive Action record managing the full lifecycle of a quality improvement action triggered by a defect, customer complaint, audit finding, or reliability failure. Captures problem statement, root cause analysis method (5-Why, Ishikawa, FTA), root cause description, corrective action plan, preventive action plan, implementation owner, target and actual completion dates, effectiveness verification criteria, and closure approval. Supports ISO 9001 clause 10.2 and IATF 16949 CAPA requirements.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` (
    `nonconformance_report_id` BIGINT COMMENT 'System-generated unique identifier for the non‑conformance report.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Feeds the Customer Impact Reporting procedure, associating each NCR with the affected customer account to trigger notifications and compliance reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Nonconformance handling expenses are tracked against a cost center for financial impact analysis.',
    `employee_id` BIGINT COMMENT 'Identifier of the quality engineer responsible for the report.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Nonconformances affecting export‑controlled items must be reported against the specific export license for regulatory tracking.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the wafer lot impacted by the non‑conformance.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: NCMRs are issued for a specific IC part; linking to ic_catalog supports root‑cause analysis and customer notifications.',
    `inspection_lot_id` BIGINT COMMENT 'FK to quality.inspection_lot.inspection_lot_id — NCRs are typically discovered during inspection. This link provides traceability from the non-conformance back to the inspection event where it was detected.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: NCR handling requires linking the report to the inventory lot to enforce holds, quarantine, and corrective action tracking.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: NCRs reference the process step where non‑conformance was detected, essential for corrective‑action workflow.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: NCR‑PO linkage needed for root‑cause analysis and supplier accountability in Nonconformance Reporting.',
    `mrb_meeting_id` BIGINT COMMENT 'Identifier of the MRB meeting linked to this report.',
    `wafer_id` BIGINT COMMENT 'Unique identifier of the wafer where the issue was detected.',
    `attached_document_ids` STRING COMMENT 'Comma‑separated list of document identifiers attached to the report.',
    `audit_trail_notes` STRING COMMENT 'Free‑form notes capturing audit trail details.',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard applicable to the report.. Valid values are `ISO 9001|IATF 16949|JEDEC`',
    `corrective_action_due_date` DATE COMMENT 'Target date for completion of corrective actions.',
    `corrective_action_plan` STRING COMMENT 'Planned corrective actions to prevent recurrence.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action implementation.. Valid values are `pending|completed|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `customer_notification_required` BOOLEAN COMMENT 'Flag indicating if the customer must be notified.',
    `customer_notification_sent_timestamp` TIMESTAMP COMMENT 'Date‑time when the customer notification was sent.',
    `detection_point` STRING COMMENT 'Process step or system where the non‑conformance was first detected.',
    `die_range` STRING COMMENT 'Range of die numbers on the wafer affected (e.g., "100-200").',
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
    `mrb_decision` STRING COMMENT 'Decision made by the MRB regarding the non‑conformance.. Valid values are `approve|reject|defer`',
    `nonconformance_description` STRING COMMENT 'Narrative description of the deviation from specification.',
    `nonconformance_report_status` STRING COMMENT 'Current lifecycle status of the report.. Valid values are `open|under_review|closed|cancelled`',
    `priority` STRING COMMENT 'Priority assigned for handling the report.. Valid values are `high|medium|low`',
    `report_number` STRING COMMENT 'Business‑visible identifier (NCR number) assigned to the report.',
    `report_timestamp` TIMESTAMP COMMENT 'Date‑time when the non‑conformance was initially recorded.',
    `root_cause_analysis` STRING COMMENT 'Analysis identifying the underlying cause of the non‑conformance.',
    `severity_level` STRING COMMENT 'Severity classification of the non‑conformance.. Valid values are `critical|high|medium|low`',
    `specification_violated` STRING COMMENT 'Name or code of the specification that was not met.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    CONSTRAINT pk_nonconformance_report PRIMARY KEY(`nonconformance_report_id`)
) COMMENT 'Non-Conformance Report (NCR) and quality hold management record documenting product or process deviations from specification, managing lot hold/release lifecycle, and tracking material review board dispositions. Captures NCR number, affected lot/wafer/unit range, non-conformance description, specification violated, detection point, hold type (process excursion, SPC out-of-control, customer complaint, reliability failure), hold initiation and release timestamps, hold reason, hold release conditions with approver, disposition decision (use-as-is, rework, scrap, return to supplier), material review board (MRB) decision, responsible quality engineer, required disposition actions, and financial impact assessment. SSOT for all in-process quality escapes, quality holds, MRB dispositions, and lot release management. Integrates with Camstar MES and SAP QM for lot status management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` (
    `quality_audit_finding_id` BIGINT COMMENT 'System-generated unique identifier for each quality audit finding record.',
    `audit_event_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_event. Business justification: Quality audit findings originate from compliance audit events; linking provides traceability to the audit that generated the finding.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Audit finding remediation costs are charged to a cost center for budgeting corrective actions.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the equipment involved in the finding, if applicable.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_wafer_lot. Business justification: Audit findings are associated with the wafer lot under audit; linking provides lot‑level audit traceability.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Audit findings often cite the specific process step; linking supports audit traceability and remediation tracking.',
    `quality_document_id` BIGINT COMMENT 'Reference to supporting documentation (e.g., inspection report, test log).',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Audit findings related to research processes are linked to the originating research project for compliance tracking.',
    `sku_id` BIGINT COMMENT 'Identifier of the product (IC, ASIC, etc.) related to the finding.',
    `wafer_id` BIGINT COMMENT 'Identifier of the wafer associated with the finding.',
    `capa_record_id` BIGINT COMMENT 'Reference to the CAPA record that resolves this finding.',
    `audit_date` TIMESTAMP COMMENT 'Timestamp when the audit was performed or the observation was recorded.',
    `audit_number` STRING COMMENT 'Business identifier assigned to the audit finding, used for tracking and reference.',
    `audit_region` STRING COMMENT 'Geographic region where the audit was conducted.. Valid values are `APAC|EMEA|AMER|LATAM|APJ`',
    `audit_scope` STRING COMMENT 'Scope of the audit (e.g., Process, Design, Supplier).',
    `audit_score` DECIMAL(18,2) COMMENT 'Numeric score assigned to the audit based on internal rating criteria.',
    `audit_team` STRING COMMENT 'Name or identifier of the audit team responsible.',
    `audit_type` STRING COMMENT 'Category of audit that generated the finding: internal, customer, third‑party, or regulatory.. Valid values are `internal|customer|third_party|regulatory`',
    `auditor_name` STRING COMMENT 'Full legal name of the person who performed the audit.',
    `closure_date` DATE COMMENT 'Date when the finding was formally closed.',
    `closure_status` STRING COMMENT 'Current status of the findings resolution lifecycle.. Valid values are `open|closed|deferred|rejected`',
    `compliance_status` STRING COMMENT 'Overall compliance outcome of the audit finding.. Valid values are `compliant|non_compliant|partial`',
    `corrective_action_due_date` DATE COMMENT 'Target date by which corrective actions must be completed.',
    `corrective_action_plan` STRING COMMENT 'Planned actions to address the finding and prevent recurrence.',
    `detection_method` STRING COMMENT 'Method used to detect the finding (e.g., inspection, test, review).. Valid values are `inspection|test|review|automated|manual`',
    `finding_classification` STRING COMMENT 'Classification of the finding: major non‑conformance, minor non‑conformance, observation, or improvement opportunity.. Valid values are `major_nc|minor_nc|observation|opportunity`',
    `finding_description` STRING COMMENT 'Detailed narrative of the observation, non‑conformance, or opportunity identified.',
    `impact_estimate` STRING COMMENT 'Qualitative or quantitative estimate of the potential impact on yield, cost, or schedule.',
    `is_repeat_issue` BOOLEAN COMMENT 'Indicates whether the same issue has been observed previously.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information.',
    `observation_location` STRING COMMENT 'Physical location (fab, cleanroom, design office) where the finding was observed.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit finding record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the audit finding record.',
    `regulatory_body` STRING COMMENT 'Standard or regulatory framework referenced (e.g., ISO 9001, IATF 16949).',
    `repeat_issue_count` STRING COMMENT 'Number of times this specific issue has been recorded.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the finding based on severity and impact.. Valid values are `high|medium|low`',
    `root_cause` STRING COMMENT 'Identified underlying cause of the finding after analysis.',
    `severity_level` STRING COMMENT 'Impact severity of the finding on product quality, safety, or compliance.. Valid values are `critical|high|medium|low|info`',
    `standard_clause` STRING COMMENT 'Reference to the specific clause of a standard (e.g., ISO 9001:8.5.1) that the finding relates to.',
    `verification_date` DATE COMMENT 'Date when the effectiveness of corrective action was verified.',
    `verification_status` STRING COMMENT 'Current status of verification of the corrective action.. Valid values are `pending|verified|failed`',
    CONSTRAINT pk_quality_audit_finding PRIMARY KEY(`quality_audit_finding_id`)
) COMMENT 'Quality audit finding record capturing observations, non-conformances, and opportunities for improvement identified during internal quality audits, customer audits, or third-party certification audits (ISO 9001, IATF 16949). Stores audit type, audit date, auditor name, audited process/area, finding classification (major NC, minor NC, observation), finding description, applicable standard clause, linked CAPA record, and closure status.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`audit` (
    `audit_id` BIGINT COMMENT 'Primary key for audit',
    `employee_id` BIGINT COMMENT 'Unique identifier of the lead auditor responsible for the audit.',
    `actual_end_date` DATE COMMENT 'Calendar date when the audit was completed.',
    `actual_start_date` DATE COMMENT 'Calendar date when the audit actually started.',
    `applicable_standard` STRING COMMENT 'Regulatory or industry standard against which the audit is performed.. Valid values are `ISO 9001|IATF 16949|JEDEC|ISO 14001|ISO 45001`',
    `audit_number` STRING COMMENT 'Business identifier or code assigned to the audit (e.g., QA-2024-001).',
    `audit_status` STRING COMMENT 'Current lifecycle state of the audit record.. Valid values are `planned|in_progress|completed|closed|cancelled`',
    `audit_type` STRING COMMENT 'Classification of the audit: internal, customer‑conducted, third‑party certification, or other.. Valid values are `internal|customer|third_party|certification`',
    `certificate_reference` STRING COMMENT 'Identifier of the certification issued (if any) as a result of the audit.',
    `corrective_action_due_date` DATE COMMENT 'Latest date by which all corrective actions must be closed.',
    `findings_total` STRING COMMENT 'Aggregate number of findings recorded for the audit.',
    `major_nonconformances` STRING COMMENT 'Count of major non‑conformances identified.',
    `minor_nonconformances` STRING COMMENT 'Count of minor non‑conformances identified.',
    `observations` STRING COMMENT 'Number of observations (non‑conformance but not a defect).',
    `opportunities_for_improvement` STRING COMMENT 'Count of OFI (Opportunity for Improvement) findings.',
    `overall_result` STRING COMMENT 'Final outcome of the audit after evaluation of all findings.. Valid values are `passed|failed|conditional|pending`',
    `plan_document` STRING COMMENT 'Reference (e.g., file name or URL) to the detailed audit plan.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the audit record.',
    `scheduled_date` DATE COMMENT 'Planned calendar date for the audit to commence.',
    `scope` STRING COMMENT 'Textual description of the functional or product scope covered by the audit.',
    `team` STRING COMMENT 'Comma‑separated list of auditor identifiers or names participating in the audit.',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Master record for quality management system audit events and their findings, covering internal, customer-conducted, and third-party certification body audits. At the audit level: captures audit program reference, audit type (system, process, product), audit scope, applicable standard (ISO 9001, IATF 16949, JEDEC), lead auditor, audit team, scheduled and actual dates, audit plan document reference, overall audit result, and certificate reference. At the finding level: captures individual observations, non-conformances, and opportunities for improvement with finding classification (major NC, minor NC, observation, OFI), finding description, applicable standard clause, corrective action linkage, responsible owner, due date, and closure status. SSOT for all quality audit planning, execution, and finding management per ISO 19011 and IATF 16949 clause 9.2.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` (
    `quality_metrology_measurement_id` BIGINT COMMENT 'Unique surrogate identifier for each metrology measurement event.',
    `employee_id` BIGINT COMMENT 'Identifier of the personnel who initiated or supervised the measurement.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the metrology equipment that performed the measurement.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Metrology measurements are taken for a specific IC part; FK supports process control dashboards and traceability.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Metrology measurements must be associated with the inventory lot for compliance audits and traceability of measurement data.',
    `recipe_id` BIGINT COMMENT 'Identifier of the process recipe or step definition associated with this measurement.',
    `wafer_id` BIGINT COMMENT 'Unique identifier for the individual wafer on which the measurement was performed.',
    `gauge_rr_reference` STRING COMMENT 'Identifier of the gauge repeatability and reproducibility study linked to this measurement.',
    `measurement_comment` STRING COMMENT 'Optional free‑text comments or observations captured by the operator or system.',
    `measurement_mode` STRING COMMENT 'Indicates whether the measurement was performed automatically by the tool or manually by an operator.. Valid values are `automatic|manual`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the metrology reading was taken on the wafer or test structure.',
    `measurement_type` STRING COMMENT 'Category of metrology measurement (e.g., CD-SEM, ellipsometry, profilometry, overlay, film thickness, resistivity, particle count).',
    `measurement_uncertainty` DECIMAL(18,2) COMMENT 'Estimated uncertainty (±) associated with the measured value.',
    `measurement_unit` STRING COMMENT 'Unit of the measured value (e.g., nm, µm, Å, %).',
    `measurement_value` DECIMAL(18,2) COMMENT 'Numeric result of the metrology reading expressed in the associated unit.',
    `pass_fail_status` STRING COMMENT 'Result of the measurement comparison against specification limits.. Valid values are `pass|fail|out_of_spec`',
    `process_step` STRING COMMENT 'Name or code of the fabrication step (e.g., lithography, etch, CMP) during which the measurement was taken.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the measurement record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the measurement record.',
    `site_coordinates` STRING COMMENT 'Encoded X/Y coordinate(s) of the measurement location(s) within the wafer map.',
    `site_map_type` STRING COMMENT 'Granularity of the measurement site layout used (e.g., 5‑point, 9‑point, 49‑point, full wafer map).. Valid values are `5_point|9_point|49_point|full_map`',
    `spec_lower_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable value for the measurement before it is considered out‑of‑spec.',
    `spec_upper_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable value for the measurement before it is considered out‑of‑spec.',
    `target_value` DECIMAL(18,2) COMMENT 'Desired nominal value for the measurement as defined by the process specification.',
    `tool_qualification_status` STRING COMMENT 'Current qualification state of the metrology tool (e.g., qualified, unqualified, under maintenance).. Valid values are `qualified|unqualified|maintenance`',
    CONSTRAINT pk_quality_metrology_measurement PRIMARY KEY(`quality_metrology_measurement_id`)
) COMMENT 'Transactional record of individual metrology measurements taken on wafers or test structures during semiconductor processing for quality verification and process control. Captures measurement type (CD-SEM, ellipsometry, profilometry, overlay, film thickness, resistivity, particle count), tool ID and tool qualification status, wafer lot ID, process step, measurement site coordinates (5-point, 9-point, 49-point maps), measured value, target value, upper/lower spec limits, pass/fail status, measurement uncertainty, gauge R&R reference, and measurement timestamp. Sourced from KLA, ASML, Onto Innovation, and other metrology tools. Feeds SPC control charts and process control loops. SSOT for all quality-critical dimensional and parametric measurements.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` (
    `supplier_quality_scorecard_id` BIGINT COMMENT 'System-generated unique identifier for each supplier quality scorecard record.',
    `employee_id` BIGINT COMMENT 'add column employee_id (BIGINT) with FK to workforce.employee.employee_id - scorecards need a responsible quality engineer',
    `inspection_lot_id` BIGINT COMMENT 'FK to quality.inspection_lot.inspection_lot_id — Supplier scorecards aggregate incoming inspection results. The scorecard description states aggregating incoming inspection results. This is the data source link.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier evaluated in the scorecard.',
    `contact_email` STRING COMMENT 'Primary email address for the suppliers quality liaison.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code for monetary values in the scorecard.. Valid values are `USD|EUR|JPY|CNY|GBP|CHF`',
    `evaluation_period_end` DATE COMMENT 'Last day of the reporting period covered by the scorecard.',
    `evaluation_period_start` DATE COMMENT 'First day of the reporting period covered by the scorecard.',
    `improvement_action_plan` STRING COMMENT 'Reference identifier for the corrective action plan associated with this scorecard.',
    `kpi_cost_of_poor_quality` DECIMAL(18,2) COMMENT 'Monetary cost associated with defects, rework, and warranty claims for the period.',
    `kpi_delivery_conformance` DECIMAL(18,2) COMMENT 'Percentage of deliveries that meet agreed‑upon quality criteria.',
    `kpi_incoming_quality_rate` DECIMAL(18,2) COMMENT 'Percentage of incoming parts that meet quality specifications.',
    `kpi_responsiveness` DECIMAL(18,2) COMMENT 'Average time (in days) for the supplier to address corrective actions.',
    `next_review_date` DATE COMMENT 'Planned date for the next supplier quality review.',
    `notes` STRING COMMENT 'Free‑form comments or observations from the reviewer.',
    `overall_quality_score` DECIMAL(18,2) COMMENT 'Aggregated quality score for the supplier (0‑100 scale).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the scorecard record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the scorecard record.',
    `scorecard_status` STRING COMMENT 'Current lifecycle status of the scorecard record.. Valid values are `draft|active|closed|archived`',
    `scorecard_version` STRING COMMENT 'Version number of the scorecard for change‑tracking purposes.',
    `supplier_development_program` STRING COMMENT 'Name or code of the development program linked to the supplier.',
    `supplier_type` STRING COMMENT 'Classification of the supplier based on business relationship (e.g., tier level).. Valid values are `tier1|tier2|tier3|tier4|other`',
    `tier_classification` STRING COMMENT 'Overall classification of the supplier based on the scorecard outcome.. Valid values are `preferred|approved|conditional|probation|disqualified`',
    `trend_direction` STRING COMMENT 'Direction of quality performance trend compared to the previous period.. Valid values are `up|down|stable|declining|improving`',
    CONSTRAINT pk_supplier_quality_scorecard PRIMARY KEY(`supplier_quality_scorecard_id`)
) COMMENT 'Periodic quality performance scorecard for a supplier, aggregating incoming inspection results, NCR counts, DPPM, on-time delivery quality, and CAPA responsiveness over a defined reporting period. Captures supplier ID, evaluation period, overall quality score, individual KPI scores (incoming quality rate, delivery conformance, responsiveness, cost of poor quality), scorecard tier classification (preferred, approved, conditional, probation, disqualified), trend direction, improvement action plan references, supplier development program linkage, and next review date. Supports supplier qualification decisions, approved vendor list management, and IATF 16949 clause 8.4 external provider monitoring requirements.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` (
    `quality_spec_id` BIGINT COMMENT 'Unique identifier for the quality specification record.',
    `fabrication_process_step_id` BIGINT COMMENT 'Foreign key linking to fabrication.process_step. Business justification: Specification documents are applied to a particular process step; linking supports step‑specific spec compliance checks.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: Specs often depend on the technology node; linking allows node‑specific parameter validation.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Specification Measurement Traceability links each spec to the Fab Tool that performs the measurement, required for ISO 9001 compliance.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Spec Ownership Register requires linking each specification to the responsible engineer for accountability.',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Required for Package Design Specification process where each quality spec must be linked to its package type to enforce dimensional and electrical limits.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Quality specifications are defined per SKU; FK replaces the denormalized product_sku field for precise version control.',
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
    `last_validated_date` DATE COMMENT 'Date of the most recent validation activity.',
    `lower_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable value for the parameter.',
    `measurement_accuracy_percent` DECIMAL(18,2) COMMENT 'Stated accuracy of the measurement equipment as a percentage.',
    `measurement_variance_percent` DECIMAL(18,2) COMMENT 'Observed variance of repeated measurements expressed as a percentage.',
    `nominal_value` DECIMAL(18,2) COMMENT 'Target nominal value for the parameter.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the specification.',
    `parameter_name` STRING COMMENT 'Name of the measured parameter (e.g., Vth, line width).',
    `process_node` STRING COMMENT 'Technology node (e.g., 7nm, 5nm) relevant to the specification.',
    `product_family` STRING COMMENT 'Family or series to which the product belongs.',
    `quality_spec_status` STRING COMMENT 'Current lifecycle state of the specification.. Valid values are `active|inactive|draft|retired|pending`',
    `review_cycle` STRING COMMENT 'Frequency at which the specification is reviewed.. Valid values are `annual|quarterly|ad_hoc`',
    `revision_number` STRING COMMENT 'Sequential revision number of the specification.',
    `spec_code` STRING COMMENT 'Unique business code assigned to the specification.',
    `spec_name` STRING COMMENT 'Human‑readable name of the quality specification.',
    `spec_type` STRING COMMENT 'Category of the specification such as electrical, dimensional, visual, or reliability.. Valid values are `electrical|dimensional|visual|reliability|other`',
    `test_type` STRING COMMENT 'Category of test associated with the specification.. Valid values are `functional|stress|environmental|reliability|visual`',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the parameter (e.g., mV, nm).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the specification record.',
    `upper_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable value for the parameter.',
    `validated_flag` BOOLEAN COMMENT 'Indicates whether the specification has been validated against actual parts.',
    `version` STRING COMMENT 'Version identifier for the specification.',
    CONSTRAINT pk_quality_spec PRIMARY KEY(`quality_spec_id`)
) COMMENT 'Master record defining the quality specification for a product SKU or process step, including all acceptance criteria, parametric limits, visual inspection standards, and test coverage requirements. Captures spec version, applicable product family, process node, specification type (electrical, dimensional, visual, reliability), parameter name, nominal value, upper and lower spec limits, measurement units, and approval status. SSOT for quality acceptance criteria referenced by inspection lots and test programs.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` (
    `quality_hold_id` BIGINT COMMENT 'System-generated unique identifier for the quality hold record.',
    `customer_complaint_id` BIGINT COMMENT 'Identifier of the customer complaint that caused the hold, if applicable.',
    `defect_record_id` BIGINT COMMENT 'Identifier of the defect record linked to this hold, when the hold originates from a defect inspection.',
    `employee_id` BIGINT COMMENT 'Identifier of the person who approved the hold release.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_wafer_lot. Business justification: Quality holds are frequently placed on entire wafer lots; linking enables lot‑wide hold management and reporting.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Holds are often placed due to issues at a particular process step; linking enables traceability to the step causing the hold.',
    `spc_control_chart_id` BIGINT COMMENT 'Identifier of the statistical process control rule that triggered the hold, if applicable.',
    `trade_compliance_hold_id` BIGINT COMMENT 'Foreign key linking to compliance.trade_compliance_hold. Business justification: When a quality hold is placed for trade‑compliance reasons, it must reference the corresponding trade compliance hold record.',
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
    `hold_type` STRING COMMENT 'Category describing the reason for the hold.. Valid values are `process_excursion|spc_out_of_control|customer_complaint|reliability_failure|other`',
    `initiated_by` BIGINT COMMENT 'Identifier of the quality engineer who placed the hold.',
    `initiated_timestamp` TIMESTAMP COMMENT 'Date and time when the hold was placed.',
    `is_kgd_certified` BOOLEAN COMMENT 'Indicates whether the held lot requires Known Good Die (KGD) certification.',
    `notes` STRING COMMENT 'Additional free‑form notes captured by the quality engineer.',
    `priority` STRING COMMENT 'Priority level indicating urgency of resolution.. Valid values are `low|medium|high|critical`',
    `reason_description` STRING COMMENT 'Free‑text description of the business or technical reason for the hold.',
    `release_reason_description` STRING COMMENT 'Explanation for why the hold was released.',
    `release_timestamp` TIMESTAMP COMMENT 'Date and time when the hold was officially released.',
    `required_disposition_actions` STRING COMMENT 'Specific actions required to resolve the hold (e.g., re‑work, inspection, scrap).',
    `resolution_status` STRING COMMENT 'Current status of the disposition process for the hold.. Valid values are `pending|in_progress|resolved`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the hold record.',
    CONSTRAINT pk_quality_hold PRIMARY KEY(`quality_hold_id`)
) COMMENT 'Transactional record placing a quality hold on a wafer lot, die bank, or finished goods inventory pending quality disposition. Captures hold type (process excursion, SPC out-of-control, customer complaint, reliability failure), affected lot or unit range, hold initiation timestamp, hold reason description, responsible quality engineer, required disposition actions, hold release conditions, and actual release timestamp with approver. Integrates with Camstar MES and SAP QM for lot status management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` (
    `failure_analysis_report_id` BIGINT COMMENT 'Unique identifier for the failure analysis report.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Failure Analysis Report requires linking the analyst employee to the report for accountability and skill tracking.',
    `capa_record_id` BIGINT COMMENT 'FK to quality.capa_record.capa_record_id — Failure analysis conclusions drive corrective actions. This is a critical link in the closed-loop quality system.',
    `nonconformance_report_id` BIGINT COMMENT 'FK to quality.nonconformance_report.nonconformance_report_id — FA reports are triggered by non-conformances. FA description explicitly states Links to... nonconformance_report. This is a critical investigation-to-disposition link.',
    `related_failure_failure_analysis_report_id` BIGINT COMMENT 'Identifier of the associated reliability failure record, if the analysis originates from a reliability test.',
    `reliability_test_id` BIGINT COMMENT 'FK to quality.reliability_test.reliability_test_id — Failure analysis reports investigate failures detected during reliability testing. FA report description states Links to reliability_failure which is now merged into reliability_test.',
    `analysis_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the failure analysis investigation was completed.',
    `analysis_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the failure analysis investigation began.',
    `analysis_technique` STRING COMMENT 'Primary analytical method(s) employed during the failure investigation.. Valid values are `SEM|FIB|EMMI|TEM|EDX|Other`',
    `approval_status` STRING COMMENT 'Result of the final review of the report.. Valid values are `approved|rejected|pending`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the report was formally approved or rejected.',
    `comments` STRING COMMENT 'Free‑form notes or observations added by the analyst.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date and time when the report record was first created.',
    `defect_code` STRING COMMENT 'Standard defect code identifying the defect class (e.g., D1234).. Valid values are `^Dd{4}$`',
    `failure_analysis_report_status` STRING COMMENT 'Current lifecycle status of the report.. Valid values are `draft|under_review|approved|rejected|closed`',
    `failure_mechanism` STRING COMMENT 'Descriptive classification of the underlying failure mechanism (e.g., electromigration, latch‑up, oxide breakdown).',
    `failure_severity` STRING COMMENT 'Severity rating assigned to the failure based on impact and recurrence risk.. Valid values are `critical|major|minor|warning`',
    `failure_site_location` STRING COMMENT 'Physical location on the die/wafer where the failure was observed (e.g., metal layer 3, die X12Y7).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the report record.',
    `report_number` STRING COMMENT 'Business identifier assigned to the report (e.g., FA‑2023‑0012).',
    `report_title` STRING COMMENT 'Human‑readable title of the failure analysis report.',
    `report_type` STRING COMMENT 'Category indicating the origin of the failure analysis request.. Valid values are `reliability_test|customer_return|in_process|design_review`',
    `root_cause` STRING COMMENT 'Narrative of the root cause conclusion derived from the analysis.',
    `sample_description` STRING COMMENT 'Brief description of the physical sample(s) examined (e.g., wafer lot, die coordinates, package type).',
    `supporting_evidence_refs` STRING COMMENT 'Comma‑separated list of file paths or identifiers for images, data files, and test logs that support the analysis.',
    CONSTRAINT pk_failure_analysis_report PRIMARY KEY(`failure_analysis_report_id`)
) COMMENT 'Formal failure analysis report documenting the investigation of a failed device, wafer, or component. Captures FA request source (reliability test, customer return, in-process failure), sample description, analysis techniques used (SEM, FIB cross-section, EMMI, TEM, EDX), failure site location, identified failure mechanism, root cause conclusion, supporting evidence references, analyst name, and report approval status. Links to reliability_failure, nonconformance_report, and capa_record.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` (
    `quality_notification_id` BIGINT COMMENT 'Primary key for quality_notification',
    `ic_catalog_id` BIGINT COMMENT 'Identifier of the product or component impacted by the quality issue.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: A quality notification is always generated for a specific inspection lot; linking notification to its lot enables traceability and eliminates redundant lot reference columns.',
    `parent_quality_notification_id` BIGINT COMMENT 'Self-referencing FK on quality_notification (related_quality_notification_id)',
    `employee_id` BIGINT COMMENT 'Identifier of the person or department that reported the quality issue.',
    `quality_review_owner_employee_id` BIGINT COMMENT 'Identifier of the person responsible for reviewing the notification.',
    `order_id` BIGINT COMMENT 'Identifier of the work order created to address the issue.',
    `actual_resolution_date` DATE COMMENT 'Date when the issue was actually closed or resolved.',
    `attachment_flag` BOOLEAN COMMENT 'True if supporting documents or images are attached to the notification.',
    `batch_number` STRING COMMENT 'Manufacturing batch identifier associated with the affected units.',
    `comments` STRING COMMENT 'Free‑form notes entered by users regarding the notification.',
    `compliance_standard` STRING COMMENT 'Quality management standard(s) applicable to the notification.',
    `corrective_action` STRING COMMENT 'Planned or executed actions to remediate the quality problem.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the notification record was first created in the system.',
    `customer_impact_description` STRING COMMENT 'Details on how customers are impacted by the defect.',
    `defect_count` STRING COMMENT 'Number of defective units identified in the notification.',
    `defect_rate_ppm` DECIMAL(18,2) COMMENT 'Defects per million units calculated for the affected lot.',
    `escalation_level` STRING COMMENT 'Level of escalation required for the issue.',
    `inspection_date` DATE COMMENT 'Date when the inspection that generated the notification was performed.',
    `inspection_tool` STRING COMMENT 'Equipment used to perform the quality inspection.',
    `is_customer_impact` BOOLEAN COMMENT 'Indicates whether the quality issue affects external customers.',
    `is_repeat_issue` BOOLEAN COMMENT 'True if the same defect has been reported previously.',
    `kgd_certified` BOOLEAN COMMENT 'Indicates whether the product is KGD (Key Generic Device) certified.',
    `location` STRING COMMENT 'Factory or site code where the defect was observed.',
    `lot_number` STRING COMMENT 'Lot identifier for the wafer or component lot.',
    `measurement_unit` STRING COMMENT 'Unit of the measured value.',
    `measurement_value` DECIMAL(18,2) COMMENT 'Numeric measurement captured during inspection (e.g., line width).',
    `mitigation_plan` STRING COMMENT 'Planned steps to mitigate the identified risk.',
    `notification_number` STRING COMMENT 'Human‑readable business identifier assigned to the notification (e.g., QN‑2024‑000123).',
    `notification_type` STRING COMMENT 'Category describing the origin or nature of the quality issue.',
    `priority` STRING COMMENT 'Business‑defined priority level for handling the notification.',
    `repeat_issue_count` STRING COMMENT 'Number of times this defect has been reported in the past.',
    `reported_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the quality issue was initially reported.',
    `review_date` DATE COMMENT 'Date when the notification was reviewed.',
    `risk_assessment` STRING COMMENT 'Qualitative risk rating assigned to the issue.',
    `root_cause` STRING COMMENT 'Narrative description of the underlying cause of the quality issue.',
    `severity` STRING COMMENT 'Impact level of the quality issue based on risk and potential loss.',
    `quality_notification_status` STRING COMMENT 'Current lifecycle state of the notification.',
    `target_resolution_date` DATE COMMENT 'Planned date by which the issue should be resolved.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the notification record.',
    CONSTRAINT pk_quality_notification PRIMARY KEY(`quality_notification_id`)
) COMMENT 'Master reference table for quality_notification. Referenced by quality_notification_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` (
    `qualification_report_id` BIGINT COMMENT 'Primary key for qualification_report',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Manufacturing lot identifier associated with the qualification.',
    `ic_catalog_id` BIGINT COMMENT 'Identifier of the product that the qualification report pertains to.',
    `quality_qualification_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_qualification_program. Business justification: Each qualification report documents the outcome of a qualification program; linking the report to its program provides proper hierarchy and prevents the report table from being isolated.',
    `superseded_qualification_report_id` BIGINT COMMENT 'Self-referencing FK on qualification_report (superseded_qualification_report_id)',
    `test_program_id` BIGINT COMMENT 'Identifier of the test program used for the qualification.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the report was approved.',
    `approved_by` STRING COMMENT 'Name of the individual who approved the qualification report.',
    `comments` STRING COMMENT 'Free‑form comments or notes added by the author.',
    `compliance_standards` STRING COMMENT 'Comma‑separated list of standards the qualification adheres to. [ENUM-REF-CANDIDATE: ISO 9001|JEDEC|IATF 16949|ASTM|MIL‑STD|CUSTOM — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the qualification report record was first created in the system.',
    `customer_name` STRING COMMENT 'Name of the customer requesting or receiving the qualification.',
    `data_source` STRING COMMENT 'Originating system or tool that supplied the qualification data.',
    `dppm` DECIMAL(18,2) COMMENT 'Defect density measured as defects per million units.',
    `effective_date` DATE COMMENT 'Date from which the qualification results are considered effective.',
    `engineer_name` STRING COMMENT 'Name of the engineer responsible for the qualification.',
    `expiration_date` DATE COMMENT 'Date after which the qualification report is no longer valid (nullable).',
    `measurement_unit` STRING COMMENT 'Unit of measure for quantitative results in the report.',
    `qualification_result` STRING COMMENT 'Overall outcome of the qualification (pass, fail, or conditional).',
    `report_date` DATE COMMENT 'The calendar date on which the qualification report was issued.',
    `report_name` STRING COMMENT 'Human‑readable name or title of the qualification report.',
    `report_number` STRING COMMENT 'Business identifier assigned to the qualification report, used for tracking and reference.',
    `report_type` STRING COMMENT 'Category of the qualification report indicating the subject of qualification.',
    `report_version` STRING COMMENT 'Version label of the qualification report (e.g., v1.0, v2.1).',
    `revision_number` STRING COMMENT 'Sequential revision number of the qualification report.',
    `qualification_report_status` STRING COMMENT 'Current lifecycle status of the report.',
    `test_end_timestamp` TIMESTAMP COMMENT 'Date and time when the qualification testing completed.',
    `test_start_timestamp` TIMESTAMP COMMENT 'Date and time when the qualification testing began.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the qualification report record.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Percentage of units meeting qualification criteria.',
    CONSTRAINT pk_qualification_report PRIMARY KEY(`qualification_report_id`)
) COMMENT 'Master reference table for qualification_report. Referenced by qualification_report_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` (
    `customer_complaint_id` BIGINT COMMENT 'Primary key for customer_complaint',
    `account_id` BIGINT COMMENT 'Identifier of the customer who submitted the complaint.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for the corrective action.',
    `ic_catalog_id` BIGINT COMMENT 'Identifier of the product or component the complaint concerns.',
    `parent_customer_complaint_id` BIGINT COMMENT 'Self-referencing FK on customer_complaint (related_customer_complaint_id)',
    `wafer_id` BIGINT COMMENT 'Identifier of the wafer on which the defect was observed.',
    `batch_number` STRING COMMENT 'Batch identifier for the production run.',
    `closure_date` DATE COMMENT 'Date when the complaint record was formally closed.',
    `complaint_number` STRING COMMENT 'Business-visible identifier assigned to the complaint for tracking and reference.',
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
    `customer_complaint_description` STRING COMMENT 'Detailed narrative provided by the customer describing the issue.',
    `dppm_impact` DECIMAL(18,2) COMMENT 'Measured impact of the complaint expressed in DPPM.',
    `escalation_flag` BOOLEAN COMMENT 'True if the complaint has been escalated to higher management.',
    `escalation_level` STRING COMMENT 'Level of escalation applied to the complaint.',
    `inspection_result` STRING COMMENT 'Result of the quality inspection related to the complaint.',
    `lot_number` STRING COMMENT 'Manufacturing lot identifier associated with the affected product.',
    `manufacturing_site_code` STRING COMMENT 'Code representing the plant or fab where the product was produced.',
    `notes` STRING COMMENT 'Free‑form notes captured by quality engineers.',
    `priority` STRING COMMENT 'Business priority assigned to the complaint for handling urgency.',
    `regulatory_report_flag` BOOLEAN COMMENT 'True if the complaint must be reported to a regulatory body.',
    `regulatory_report_number` STRING COMMENT 'Identifier of the regulatory report filed for this complaint.',
    `resolution_date` DATE COMMENT 'Date on which the complaint was resolved.',
    `resolution_status` STRING COMMENT 'Current status of the corrective or remedial action.',
    `root_cause` STRING COMMENT 'Identified underlying cause of the defect or failure.',
    `root_cause_code` STRING COMMENT 'Standardized code representing the root cause category.',
    `severity` STRING COMMENT 'Severity rating indicating the impact of the complaint on product performance or safety.',
    `source_channel` STRING COMMENT 'Channel through which the complaint was received.',
    `customer_complaint_status` STRING COMMENT 'Current lifecycle status of the complaint.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the complaint record.',
    `warranty_claim_flag` BOOLEAN COMMENT 'Indicates whether the complaint resulted in a warranty claim.',
    `warranty_claim_number` STRING COMMENT 'Reference number for the associated warranty claim.',
    CONSTRAINT pk_customer_complaint PRIMARY KEY(`customer_complaint_id`)
) COMMENT 'Master reference table for customer_complaint. Referenced by related_customer_complaint_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` (
    `wafer_zone_id` BIGINT COMMENT 'Primary key for wafer_zone',
    `parent_wafer_zone_id` BIGINT COMMENT 'Self-referencing FK on wafer_zone (parent_wafer_zone_id)',
    `wafer_map_id` BIGINT COMMENT 'add column wafer_map_id (BIGINT) with FK to quality.wafer_map.wafer_map_id - wafer zones are subdivisions of wafer maps but currently only self-reference',
    `area_um2` DECIMAL(18,2) COMMENT 'Physical area of the zone expressed in square micrometers.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the wafer zone record was first created in the data lake.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the wafer zone record.',
    `effective_end_date` DATE COMMENT 'Date when the zone definition was retired or superseded; null if still active.',
    `effective_start_date` DATE COMMENT 'Date when the zone definition became effective for production.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the zone is considered critical for yield and reliability analyses.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the zone.',
    `process_step` STRING COMMENT 'Manufacturing process step most associated with this zone.',
    `responsible_team` STRING COMMENT 'Internal team or group accountable for the zones quality performance.',
    `shape` STRING COMMENT 'Geometric shape of the zone used for metrology calculations.',
    `typical_defect_density` DECIMAL(18,2) COMMENT 'Average defect density historically observed in this zone, expressed as defects per square centimeter.',
    `zone_code` STRING COMMENT 'Short alphanumeric code used to reference the wafer zone in manufacturing systems.',
    `zone_description` STRING COMMENT 'Detailed description of the zones purpose, geometry, and typical usage.',
    `zone_name` STRING COMMENT 'Human‑readable name of the wafer zone (e.g., Center, Edge A).',
    `zone_status` STRING COMMENT 'Current operational status of the zone within the fab workflow.',
    `zone_type` STRING COMMENT 'Category describing the logical location of the zone on the wafer.',
    `zone_version` STRING COMMENT 'Version number of the zone definition, incremented on each change.',
    CONSTRAINT pk_wafer_zone PRIMARY KEY(`wafer_zone_id`)
) COMMENT 'Master reference table for wafer_zone. Referenced by zone_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` (
    `defect_cluster_id` BIGINT COMMENT 'Primary key for defect_cluster',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Lot identifier where this defect cluster has been observed.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the equipment most commonly linked to this defect cluster.',
    `fabrication_process_step_id` BIGINT COMMENT 'add column fabrication_process_step_id (BIGINT) with FK to fabrication.fabrication_process_step.fabrication_process_step_id - defect clusters correlate to specific process steps for root cause',
    `parent_defect_cluster_id` BIGINT COMMENT 'Self-referencing FK on defect_cluster (parent_defect_cluster_id)',
    `associated_process_step` STRING COMMENT 'Manufacturing process step where the defect cluster is typically observed.',
    `associated_product_family` STRING COMMENT 'Product family code to which the defect cluster is most relevant.',
    `associated_wafers` STRING COMMENT 'Typical count of wafers impacted per lot by this defect cluster.',
    `cluster_code` STRING COMMENT 'Business code used to reference the defect cluster in downstream systems.',
    `cluster_creation_date` DATE COMMENT 'Date when the defect cluster definition was first created.',
    `cluster_name` STRING COMMENT 'Human‑readable name of the defect cluster.',
    `cluster_type` STRING COMMENT 'Classification of the defect cluster based on impact and origin.',
    `compliance_standard` STRING COMMENT 'Quality or reliability standard(s) governing this defect cluster.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the defect cluster record was first created.',
    `customer_impact_flag` BOOLEAN COMMENT 'True if the defect cluster directly impacts customer shipments.',
    `defect_pattern` STRING COMMENT 'Pattern or morphology description of the defect (e.g., line, pit, particle).',
    `defect_cluster_description` STRING COMMENT 'Detailed textual description of the defect cluster.',
    `dppm` DECIMAL(18,2) COMMENT 'Defect density expressed as defects per million units.',
    `effective_from` DATE COMMENT 'Date from which the defect cluster definition is effective.',
    `effective_until` DATE COMMENT 'Date after which the defect cluster definition is no longer valid (null if open‑ended).',
    `impact_yield_percent` DECIMAL(18,2) COMMENT 'Estimated percentage reduction in yield caused by this defect cluster.',
    `inspection_tool` STRING COMMENT 'Name of the inspection system (e.g., KLA ICOS) that detects this defect cluster.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the defect cluster is considered critical for product quality.',
    `is_customer_reported` BOOLEAN COMMENT 'True if the defect cluster has been reported by a customer.',
    `last_review_date` DATE COMMENT 'Date of the most recent review of the defect cluster definition.',
    `measurement_unit` STRING COMMENT 'Unit of the measurement value (e.g., µm, nm).',
    `measurement_value` DECIMAL(18,2) COMMENT 'Typical measured size or intensity value for defects in this cluster.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the defect cluster.',
    `review_status` STRING COMMENT 'Current status of the latest review process.',
    `root_cause_category` STRING COMMENT 'Primary root‑cause category for the defects in this cluster.',
    `severity_level` STRING COMMENT 'Severity rating of the defect cluster.',
    `defect_cluster_status` STRING COMMENT 'Current lifecycle status of the defect cluster.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the defect cluster record.',
    `version_number` STRING COMMENT 'Version of the defect cluster definition.',
    CONSTRAINT pk_defect_cluster PRIMARY KEY(`defect_cluster_id`)
) COMMENT 'Master reference table for defect_cluster. Referenced by cluster_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` (
    `mrb_meeting_id` BIGINT COMMENT 'Primary key for mrb_meeting',
    `fab_facility_id` BIGINT COMMENT 'add column fab_facility_id (BIGINT) with FK to fabrication.fab_facility.fab_facility_id - MRB meetings occur at specific facilities and review lots from those facilities',
    `parent_mrb_meeting_id` BIGINT COMMENT 'Self-referencing FK on mrb_meeting (related_mrb_meeting_id)',
    `action_items` STRING COMMENT 'List of follow‑up actions assigned during the meeting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the meeting record was first created in the system.',
    `decision_summary` STRING COMMENT 'Brief summary of decisions and outcomes from the meeting.',
    `end_timestamp` TIMESTAMP COMMENT 'Exact end time of the meeting (UTC).',
    `facilitator_email` STRING COMMENT 'Email address of the meeting facilitator.',
    `facilitator_name` STRING COMMENT 'Full name of the person facilitating the MRB meeting.',
    `location_code` STRING COMMENT 'Code of the fab or facility where the meeting is held, e.g., FAB01.',
    `meeting_code` STRING COMMENT 'Short alphanumeric code used to reference the meeting in quality systems.',
    `meeting_date` DATE COMMENT 'Calendar date on which the meeting is scheduled.',
    `meeting_name` STRING COMMENT 'Human‑readable name or title of the MRB meeting.',
    `meeting_type` STRING COMMENT 'Category of the MRB meeting (e.g., initial review, follow‑up).',
    `participant_count` STRING COMMENT 'Number of participants attending the meeting.',
    `start_timestamp` TIMESTAMP COMMENT 'Exact start time of the meeting (UTC).',
    `mrb_meeting_status` STRING COMMENT 'Current lifecycle state of the meeting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the meeting record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the meeting record.',
    CONSTRAINT pk_mrb_meeting PRIMARY KEY(`mrb_meeting_id`)
) COMMENT 'Master reference table for mrb_meeting. Referenced by related_mrb_meeting_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` (
    `quality_document_id` BIGINT COMMENT 'Primary key for quality_document',
    `employee_id` BIGINT COMMENT 'add column owner_employee_id (BIGINT) with FK to workforce.employee.employee_id - quality documents require document owners for QMS compliance but currently only self-reference',
    `superseded_quality_document_id` BIGINT COMMENT 'Self-referencing FK on quality_document (superseded_quality_document_id)',
    `approval_date` DATE COMMENT 'Date on which the document was formally approved.',
    `archived_timestamp` TIMESTAMP COMMENT 'Timestamp when the document was moved to archive storage.',
    `author_name` STRING COMMENT 'Full name of the person who originally authored the document.',
    `checksum_md5` STRING COMMENT 'MD5 hash of the document file for integrity verification.',
    `compliance_standards` STRING COMMENT 'Comma‑separated list of standards (e.g., ISO 9001, IATF 16949, JEDEC) the document satisfies.',
    `confidentiality_level` STRING COMMENT 'Classified confidentiality level of the document content.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the document record was first created in the system.',
    `quality_document_description` STRING COMMENT 'Detailed narrative describing the purpose and scope of the document.',
    `document_category` STRING COMMENT 'High‑level classification of the document for governance and retrieval.',
    `document_number` STRING COMMENT 'Business-assigned unique document number used for external reference.',
    `document_type` STRING COMMENT 'Category of the quality document indicating its purpose.',
    `effective_date` DATE COMMENT 'Date on which the document becomes effective for use.',
    `expiration_date` DATE COMMENT 'Date after which the document is no longer valid (nullable for indefinite validity).',
    `file_path` STRING COMMENT 'Logical storage path or URL where the electronic document file resides.',
    `file_size_bytes` BIGINT COMMENT 'Size of the stored document file in bytes.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the document is mandatory for compliance (true) or optional (false).',
    `language` STRING COMMENT 'ISO 639‑1 language code of the document content (e.g., EN, DE, JP).',
    `retention_period_years` STRING COMMENT 'Number of years the document must be retained according to policy.',
    `reviewer_name` STRING COMMENT 'Full name of the person who reviewed and approved the document.',
    `revision_number` STRING COMMENT 'Revision identifier indicating the iteration of the document (e.g., A, B, C, 1, 2).',
    `quality_document_status` STRING COMMENT 'Current lifecycle state of the document.',
    `title` STRING COMMENT 'Descriptive title of the quality document.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the document record.',
    `version_number` DECIMAL(18,2) COMMENT 'Numeric version of the document, used for tracking major/minor changes.',
    CONSTRAINT pk_quality_document PRIMARY KEY(`quality_document_id`)
) COMMENT 'Master reference table for quality_document. Referenced by related_document_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` (
    `test_plan_id` BIGINT COMMENT 'Primary key for test_plan',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the test equipment or platform used for this plan.',
    `parent_test_plan_id` BIGINT COMMENT 'Self-referencing FK on test_plan (related_test_plan_id)',
    `approval_date` DATE COMMENT 'Date on which the test plan received formal approval.',
    `approver` STRING COMMENT 'Name of the person who approved the test plan for release.',
    `author` STRING COMMENT 'Name of the person who originally authored the test plan.',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard that the test plan adheres to (e.g., JEDEC, ISO 9001).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the test plan record was first created in the system.',
    `defect_threshold` STRING COMMENT 'Maximum allowable number of defects per million parts (DPPM) for the plan.',
    `test_plan_description` STRING COMMENT 'Detailed textual description of the test plan purpose, scope, and methodology.',
    `effective_end_date` DATE COMMENT 'Date on which the test plan expires or is superseded; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date on which the test plan becomes operationally effective.',
    `last_executed_timestamp` TIMESTAMP COMMENT 'Date and time when the test plan was most recently run.',
    `last_result` STRING COMMENT 'Outcome of the most recent execution of the test plan.',
    `measurement_units` STRING COMMENT 'Units of measurement for key test parameters (e.g., V, A, Ohm).',
    `notes` STRING COMMENT 'Free‑form comments or observations about the test plan.',
    `pass_fail_criteria` STRING COMMENT 'Textual definition of the conditions that determine pass or fail outcomes.',
    `plan_code` STRING COMMENT 'External code or number used to reference the test plan in manufacturing systems.',
    `plan_name` STRING COMMENT 'Human‑readable name of the test plan.',
    `priority` STRING COMMENT 'Business priority assigned to the test plan.',
    `product_family` STRING COMMENT 'Product family or line to which the test plan applies.',
    `revision_number` STRING COMMENT 'Sequential revision number for change control of the test plan.',
    `test_plan_status` STRING COMMENT 'Current lifecycle state of the test plan.',
    `target_device` STRING COMMENT 'Identifier of the semiconductor device or die that the test plan validates.',
    `test_category` STRING COMMENT 'Business category of the test plan (e.g., qualification, production, debug).',
    `test_duration_estimate_minutes` STRING COMMENT 'Estimated total execution time for the test plan, in minutes.',
    `test_environment` STRING COMMENT 'Physical or logical environment where the test plan is executed (e.g., cleanroom, probe station).',
    `test_type` STRING COMMENT 'Category of testing performed by the plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the test plan record.',
    `version` STRING COMMENT 'Alphanumeric version label (e.g., v1.2, R3) for the test plan.',
    `wafer_size` STRING COMMENT 'Standard wafer diameter (e.g., 200mm, 300mm) for which the plan is defined.',
    CONSTRAINT pk_test_plan PRIMARY KEY(`test_plan_id`)
) COMMENT 'Master reference table for test_plan. Referenced by related_test_plan_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` (
    `control_plan_id` BIGINT COMMENT 'Primary key for control_plan',
    `process_flow_id` BIGINT COMMENT 'add column process_flow_id (BIGINT) with FK to process.process_flow.process_flow_id - quality control plans govern specific process flows but currently only self-reference',
    `superseded_control_plan_id` BIGINT COMMENT 'Self-referencing FK on control_plan (superseded_control_plan_id)',
    `approval_status` STRING COMMENT 'Current approval state of the control plan.',
    `author_name` STRING COMMENT 'Name of the person or team that authored the control plan.',
    `change_reason` STRING COMMENT 'Reason or justification for the most recent change to the control plan.',
    `compliance_standard` STRING COMMENT 'Quality or industry standard(s) the control plan adheres to.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the control plan record was first created.',
    `control_plan_description` STRING COMMENT 'Detailed free‑text description of the control plan purpose and scope.',
    `dppm_actual` DECIMAL(18,2) COMMENT 'Observed defect rate measured under the control plan.',
    `dppm_target` DECIMAL(18,2) COMMENT 'Target defect rate expressed in parts per million.',
    `effective_from` DATE COMMENT 'Date when the control plan becomes effective.',
    `effective_until` DATE COMMENT 'Date when the control plan expires or is superseded (nullable for open‑ended plans).',
    `inspection_tool` STRING COMMENT 'Equipment or system used to perform the inspection (e.g., KLA ICOS).',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the control plan is considered critical for product quality.',
    `last_review_date` DATE COMMENT 'Date when the control plan was last reviewed for relevance.',
    `measurement_criteria` STRING COMMENT 'Key measurement or characteristic monitored by the control plan.',
    `notes` STRING COMMENT 'Additional free‑form remarks or observations.',
    `plan_code` STRING COMMENT 'External code or number used to reference the control plan in manufacturing systems.',
    `plan_name` STRING COMMENT 'Human‑readable name of the control plan.',
    `plan_type` STRING COMMENT 'Category describing the nature of the control plan.',
    `process_step` STRING COMMENT 'Manufacturing process step(s) covered by the control plan.',
    `related_product_family` STRING COMMENT 'Product family or line to which the control plan applies.',
    `review_cycle` STRING COMMENT 'Scheduled frequency for reviewing the control plan.',
    `risk_level` STRING COMMENT 'Risk classification associated with the control plan.',
    `sampling_rate` DECIMAL(18,2) COMMENT 'Frequency or method of sampling for the control plan.',
    `control_plan_status` STRING COMMENT 'Current lifecycle state of the control plan.',
    `target_value` DECIMAL(18,2) COMMENT 'Target numeric value for the measured characteristic.',
    `tolerance_lower` DECIMAL(18,2) COMMENT 'Maximum acceptable deviation below the target value.',
    `tolerance_upper` DECIMAL(18,2) COMMENT 'Maximum acceptable deviation above the target value.',
    `unit_of_measure` STRING COMMENT 'Unit used for the target and tolerance values.',
    `updated_by` STRING COMMENT 'Identifier of the user or system that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the control plan record.',
    `version_number` STRING COMMENT 'Version identifier of the control plan (e.g., v1.0, v2.1).',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the record.',
    CONSTRAINT pk_control_plan PRIMARY KEY(`control_plan_id`)
) COMMENT 'Master reference table for control_plan. Referenced by control_plan_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_defect_cluster_id` FOREIGN KEY (`defect_cluster_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`defect_cluster`(`defect_cluster_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_wafer_map_id` FOREIGN KEY (`wafer_map_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`wafer_map`(`wafer_map_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_wafer_zone_id` FOREIGN KEY (`wafer_zone_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`wafer_zone`(`wafer_zone_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_fmea_record_id` FOREIGN KEY (`fmea_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`fmea_record`(`fmea_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ADD CONSTRAINT `fk_quality_quality_qualification_program_fmea_record_id` FOREIGN KEY (`fmea_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`fmea_record`(`fmea_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ADD CONSTRAINT `fk_quality_quality_qualification_program_test_plan_id` FOREIGN KEY (`test_plan_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`test_plan`(`test_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`audit`(`audit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_quality_audit_finding_id` FOREIGN KEY (`quality_audit_finding_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_audit_finding`(`quality_audit_finding_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_customer_complaint_id` FOREIGN KEY (`customer_complaint_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`customer_complaint`(`customer_complaint_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_defect_record_id` FOREIGN KEY (`defect_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`defect_record`(`defect_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_mrb_meeting_id` FOREIGN KEY (`mrb_meeting_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`mrb_meeting`(`mrb_meeting_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ADD CONSTRAINT `fk_quality_quality_audit_finding_quality_document_id` FOREIGN KEY (`quality_document_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_document`(`quality_document_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ADD CONSTRAINT `fk_quality_quality_audit_finding_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ADD CONSTRAINT `fk_quality_supplier_quality_scorecard_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_customer_complaint_id` FOREIGN KEY (`customer_complaint_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`customer_complaint`(`customer_complaint_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_defect_record_id` FOREIGN KEY (`defect_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`defect_record`(`defect_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_related_failure_failure_analysis_report_id` FOREIGN KEY (`related_failure_failure_analysis_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`failure_analysis_report`(`failure_analysis_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_reliability_test_id` FOREIGN KEY (`reliability_test_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`reliability_test`(`reliability_test_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ADD CONSTRAINT `fk_quality_quality_notification_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ADD CONSTRAINT `fk_quality_quality_notification_parent_quality_notification_id` FOREIGN KEY (`parent_quality_notification_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_notification`(`quality_notification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_quality_qualification_program_id` FOREIGN KEY (`quality_qualification_program_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_qualification_program`(`quality_qualification_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_superseded_qualification_report_id` FOREIGN KEY (`superseded_qualification_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`qualification_report`(`qualification_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_parent_customer_complaint_id` FOREIGN KEY (`parent_customer_complaint_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`customer_complaint`(`customer_complaint_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ADD CONSTRAINT `fk_quality_wafer_zone_parent_wafer_zone_id` FOREIGN KEY (`parent_wafer_zone_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`wafer_zone`(`wafer_zone_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ADD CONSTRAINT `fk_quality_wafer_zone_wafer_map_id` FOREIGN KEY (`wafer_map_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`wafer_map`(`wafer_map_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ADD CONSTRAINT `fk_quality_defect_cluster_parent_defect_cluster_id` FOREIGN KEY (`parent_defect_cluster_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`defect_cluster`(`defect_cluster_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ADD CONSTRAINT `fk_quality_mrb_meeting_parent_mrb_meeting_id` FOREIGN KEY (`parent_mrb_meeting_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`mrb_meeting`(`mrb_meeting_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ADD CONSTRAINT `fk_quality_quality_document_superseded_quality_document_id` FOREIGN KEY (`superseded_quality_document_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_document`(`quality_document_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_parent_test_plan_id` FOREIGN KEY (`parent_test_plan_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`test_plan`(`test_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_superseded_control_plan_id` FOREIGN KEY (`superseded_control_plan_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`control_plan`(`control_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria (Number of Defects Allowed)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `defect_density` SET TAGS ('dbx_business_glossary_term' = 'Defect Density (Defects per Unit Area)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'accept|reject|hold|rework');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `disposition_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposition Reason');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `external_lot_code` SET TAGS ('dbx_business_glossary_term' = 'External Lot Code');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size (Number of Units)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Type (Incoming|In-Process|Final|Rework|Hold)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_value_regex' = 'incoming|in_process|final|rework|hold');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'wafer|mask|chemical|gas|assembly');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'nm|um|mm|percent|count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `quality_engineer` SET TAGS ('dbx_business_glossary_term' = 'Quality Engineer Name');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `quality_engineer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `quality_engineer` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `rejection_criteria` SET TAGS ('dbx_business_glossary_term' = 'Rejection Criteria (Number of Defects)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `sampling_plan_aql` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Acceptable Quality Level (AQL)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `technology_node` SET TAGS ('dbx_value_regex' = '5nm|7nm|10nm|14nm|28nm|45nm');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'wafer|die|unit');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (mm)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_record_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Record ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Cluster Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `design_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Core Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Detection Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `experimental_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `wafer_map_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Wafer Map Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Recipe Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `wafer_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `bin_assignment` SET TAGS ('dbx_business_glossary_term' = 'Bin Assignment');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_area_um2` SET TAGS ('dbx_business_glossary_term' = 'Defect Area (µm²)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_classification` SET TAGS ('dbx_business_glossary_term' = 'Defect Classification');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_density_per_zone` SET TAGS ('dbx_business_glossary_term' = 'Defect Density per Zone');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_layer` SET TAGS ('dbx_business_glossary_term' = 'Defect Layer');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_layer` SET TAGS ('dbx_value_regex' = 'feol|mol|beol|passivation|metal');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_severity` SET TAGS ('dbx_business_glossary_term' = 'Defect Severity');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|warning|info');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_size_nm` SET TAGS ('dbx_business_glossary_term' = 'Defect Size (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_status` SET TAGS ('dbx_business_glossary_term' = 'Defect Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_status` SET TAGS ('dbx_value_regex' = 'open|investigating|resolved|closed|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'optical|ebeam|sem|afm');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `die_x` SET TAGS ('dbx_business_glossary_term' = 'Die X Grid Coordinate');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `die_y` SET TAGS ('dbx_business_glossary_term' = 'Die Y Grid Coordinate');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Defect Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'scrap|rework|accept|hold');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `edge_exclusion_zone_flag` SET TAGS ('dbx_business_glossary_term' = 'Edge Exclusion Zone Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `flat_notch_orientation` SET TAGS ('dbx_business_glossary_term' = 'Flat/Notch Orientation');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `flat_notch_orientation` SET TAGS ('dbx_value_regex' = 'flat|notch');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `inspection_recipe` SET TAGS ('dbx_business_glossary_term' = 'Inspection Recipe');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `repeatability_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeatability Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `x_coordinate` SET TAGS ('dbx_business_glossary_term' = 'X Coordinate (mm)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `y_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Y Coordinate (mm)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `wafer_map_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Map Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `experimental_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Tool ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `bin_count_total` SET TAGS ('dbx_business_glossary_term' = 'Total Bin Count');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `is_kgd_certified` SET TAGS ('dbx_business_glossary_term' = 'KGD Certified Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `kgd_certification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'KGD Certification Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `map_checksum` SET TAGS ('dbx_business_glossary_term' = 'Map Checksum');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `map_file_path` SET TAGS ('dbx_business_glossary_term' = 'Map File Path');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `map_generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Map Generation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `map_status` SET TAGS ('dbx_business_glossary_term' = 'Map Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `map_status` SET TAGS ('dbx_value_regex' = 'generated|validated|rejected|archived');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `map_version` SET TAGS ('dbx_business_glossary_term' = 'Map Version');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `pass_bin_code` SET TAGS ('dbx_business_glossary_term' = 'Pass Bin Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `pass_bin_code` SET TAGS ('dbx_value_regex' = 'PASS');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `passing_die_count` SET TAGS ('dbx_business_glossary_term' = 'Passing Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `total_die_count` SET TAGS ('dbx_business_glossary_term' = 'Total Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `yield_record_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Record ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `experimental_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Process Recipe ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `bin_distribution_summary` SET TAGS ('dbx_business_glossary_term' = 'Bin Distribution Summary');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'calibrated|uncalibrated');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `defect_density_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Defect Density (defects/cm²)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `defect_type` SET TAGS ('dbx_business_glossary_term' = 'Defect Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `defect_type` SET TAGS ('dbx_value_regex' = 'critical|major|minor|none');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `fab_line` SET TAGS ('dbx_business_glossary_term' = 'Fab Line');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `good_die_count` SET TAGS ('dbx_business_glossary_term' = 'Good Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail|rework');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `inspection_system` SET TAGS ('dbx_business_glossary_term' = 'Inspection System');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `lot_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Lot Humidity (%)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `lot_origin` SET TAGS ('dbx_business_glossary_term' = 'Lot Origin');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `lot_status` SET TAGS ('dbx_value_regex' = 'in_process|completed|held');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `lot_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Lot Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `measurement_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Measurement Accuracy (%)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'optical|electrical|thermal');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `measurement_stage` SET TAGS ('dbx_business_glossary_term' = 'Measurement Stage');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `measurement_stage` SET TAGS ('dbx_value_regex' = 'wafer_probe|final_test|packaged');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `measurement_variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Measurement Variance (%)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `process_node` SET TAGS ('dbx_business_glossary_term' = 'Process Node');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `quality_gate` SET TAGS ('dbx_business_glossary_term' = 'Quality Gate');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `quality_gate` SET TAGS ('dbx_value_regex' = 'wafer_sort|final_test|package_test');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|swing|night');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `source_file_name` SET TAGS ('dbx_business_glossary_term' = 'Source File Name');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `source_file_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `test_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Test Time (seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `tool_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Tool Serial Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `total_die_count` SET TAGS ('dbx_business_glossary_term' = 'Total Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `yield_gap_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Gap (%)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `yield_loss_category` SET TAGS ('dbx_business_glossary_term' = 'Yield Loss Category');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `yield_loss_category` SET TAGS ('dbx_value_regex' = 'random_defect|systematic|parametric|test_escape|other');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `yield_record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `yield_record_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|pending_review');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `yield_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Target (%)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `spc_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control Chart ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `opc_rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Opc Rule Set Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `assignable_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Assignable Cause Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `chart_type` SET TAGS ('dbx_business_glossary_term' = 'Control Chart Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `chart_type` SET TAGS ('dbx_value_regex' = 'xbar_r|c_chart|p_chart|np_chart|cusum|ewma');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `control_limit_center` SET TAGS ('dbx_business_glossary_term' = 'Center Line (CL)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `control_limit_lower` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `control_limit_upper` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `corrective_action_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Reference');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'KLA_ICOS|Camstar|SmartFactory');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `die_position` SET TAGS ('dbx_business_glossary_term' = 'Die Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `is_baseline` SET TAGS ('dbx_business_glossary_term' = 'Baseline Chart Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'inline|offline|automated');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `measurement_subgroup` SET TAGS ('dbx_business_glossary_term' = 'Measurement Subgroup Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `measurement_tool` SET TAGS ('dbx_business_glossary_term' = 'Measurement Tool');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `measurement_tool` SET TAGS ('dbx_value_regex' = 'KLA|ASML|custom');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Value');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `out_of_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Control Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `parameter_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `parameter_unit` SET TAGS ('dbx_business_glossary_term' = 'Parameter Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_value_regex' = 'hourly|daily|per_lot|per_shift|per_batch|per_run');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift Designation');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `spc_chart_status` SET TAGS ('dbx_business_glossary_term' = 'SPC Chart Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `spc_chart_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `spc_to_metrology` SET TAGS ('dbx_business_glossary_term' = 'Spc To Metrology');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `spc_to_spec` SET TAGS ('dbx_business_glossary_term' = 'Spc To Spec');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` SET TAGS ('dbx_subdomain' = 'reliability_assurance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `fmea_record_id` SET TAGS ('dbx_business_glossary_term' = 'FMEA Record Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `fabrication_process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `action_owner` SET TAGS ('dbx_business_glossary_term' = 'Action Owner');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `cause_of_failure` SET TAGS ('dbx_business_glossary_term' = 'Cause of Failure');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `compliance_standards` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standards');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `compliance_standards` SET TAGS ('dbx_value_regex' = 'IATF16949|ISO9001|JEDEC');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `control_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Reference');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `detection_rating` SET TAGS ('dbx_business_glossary_term' = 'Detection Rating (D)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `detection_technique` SET TAGS ('dbx_business_glossary_term' = 'Detection Technique');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `detection_technique` SET TAGS ('dbx_value_regex' = 'visual|automated|test|simulation');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `failure_mode_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `fmea_code` SET TAGS ('dbx_business_glossary_term' = 'FMEA Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `fmea_name` SET TAGS ('dbx_business_glossary_term' = 'FMEA Name');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `fmea_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `fmea_record_status` SET TAGS ('dbx_business_glossary_term' = 'FMEA Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `fmea_record_status` SET TAGS ('dbx_value_regex' = 'draft|review|approved|released|retired');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `fmea_scope` SET TAGS ('dbx_business_glossary_term' = 'FMEA Scope');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `fmea_to_qualification` SET TAGS ('dbx_business_glossary_term' = 'Fmea To Qualification');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `fmea_type` SET TAGS ('dbx_business_glossary_term' = 'FMEA Type (Design or Process)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `fmea_type` SET TAGS ('dbx_value_regex' = 'DFMEA|PFMEA');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Failure Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `occurrence_rating` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Rating (O)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `post_action_rpn` SET TAGS ('dbx_business_glossary_term' = 'Post‑Action RPN');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `potential_effect` SET TAGS ('dbx_business_glossary_term' = 'Potential Effect');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `related_design_item` SET TAGS ('dbx_business_glossary_term' = 'Related Design Item');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `related_process_step` SET TAGS ('dbx_business_glossary_term' = 'Related Process Step');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'design|process|system');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `risk_priority_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Priority Number (RPN)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Severity Rating (S)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` SET TAGS ('dbx_subdomain' = 'reliability_assurance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `reliability_test_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Test ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `fmea_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fmea Record Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `reliability_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Failure Analysis Method');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `analysis_method` SET TAGS ('dbx_value_regex' = 'SEM|FIB|EMMI|curve_trace|other');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `applicable_standard` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standard (STD)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `applicable_standard` SET TAGS ('dbx_value_regex' = 'AEC_Q100|AEC_Q101|JESD47|ISO_9001');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `compliance_iatf_16949` SET TAGS ('dbx_business_glossary_term' = 'IATF 16949 Compliance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `compliance_iso_9001` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Compliance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `compliance_jedec` SET TAGS ('dbx_business_glossary_term' = 'JEDEC Compliance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `failure_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Failure Mechanism');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `failure_mechanism` SET TAGS ('dbx_value_regex' = 'electromigration|TDDB|HCI|NBTI|stress_rupture|other');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `failure_mode` SET TAGS ('dbx_value_regex' = 'open_circuit|short_circuit|param_shift|timing_error|other');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `failure_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Failed Unit Serial Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `failure_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Failure Time (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `fit_rate` SET TAGS ('dbx_business_glossary_term' = 'FIT Rate (Failures In Time)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `fit_rate_confidence` SET TAGS ('dbx_business_glossary_term' = 'FIT Rate Confidence (%)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `is_kgd_certified` SET TAGS ('dbx_business_glossary_term' = 'KGD Certified Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `milestone_schedule` SET TAGS ('dbx_business_glossary_term' = 'Milestone Schedule');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `reliability_grade` SET TAGS ('dbx_business_glossary_term' = 'Reliability Grade');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `reliability_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `reltest_to_qualification` SET TAGS ('dbx_business_glossary_term' = 'Reltest To Qualification');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `root_cause_classification` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Classification');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `root_cause_classification` SET TAGS ('dbx_value_regex' = 'design|process|material|handling|unknown');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Test Duration (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Test Humidity (%)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_location` SET TAGS ('dbx_business_glossary_term' = 'Test Location');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'scheduled|running|completed|aborted');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Test Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type (TEST_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'HTOL|HAST|TC|ESD|JEDEC_stress');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `test_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Test Voltage (V)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `weibull_scale_parameter` SET TAGS ('dbx_business_glossary_term' = 'Weibull Scale Parameter (η)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `weibull_shape_parameter` SET TAGS ('dbx_business_glossary_term' = 'Weibull Shape Parameter (β)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` SET TAGS ('dbx_subdomain' = 'reliability_assurance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `quality_qualification_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Qualification Program Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `product_qualification_program_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `fmea_record_id` SET TAGS ('dbx_business_glossary_term' = 'Related FMEA Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `test_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Related Test Plan Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `actual_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `applicable_standards` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standards');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `change_request_number` SET TAGS ('dbx_business_glossary_term' = 'Change Request Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `documentation_link` SET TAGS ('dbx_business_glossary_term' = 'Documentation Link');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `dppm_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Defective Parts Per Million');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `dppm_target` SET TAGS ('dbx_business_glossary_term' = 'Target Defective Parts Per Million');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `final_disposition` SET TAGS ('dbx_business_glossary_term' = 'Final Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `final_disposition` SET TAGS ('dbx_value_regex' = 'qualified|rejected|conditional|withdrawn');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `kgd_certification_required` SET TAGS ('dbx_business_glossary_term' = 'KGD Certification Required');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed By');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|planned|in_progress|completed|closed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `milestone_schedule` SET TAGS ('dbx_business_glossary_term' = 'Milestone Schedule');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `overall_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `overall_status` SET TAGS ('dbx_value_regex' = 'pass|fail|pending|deferred');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `program_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Program Budget (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Program Category');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `program_category` SET TAGS ('dbx_value_regex' = 'internal|customer|regulatory|partner');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Qualification Program Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `program_manager` SET TAGS ('dbx_business_glossary_term' = 'Program Manager');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Qualification Program Name');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `program_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `qualification_plan_version` SET TAGS ('dbx_business_glossary_term' = 'Qualification Plan Version');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'new_product|process_change|osat|pcn_driven');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `statistical_process_control_included` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control Included');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Program Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` SET TAGS ('dbx_subdomain' = 'reliability_assurance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `quality_kgd_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Known Good Die Certification ID (KGD_CERT_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Engineer Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Lot Identifier (DIE_LOT_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Test Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Certification Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `burn_in_status` SET TAGS ('dbx_business_glossary_term' = 'Burn‑In Status (BURN_IN_STS)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `burn_in_status` SET TAGS ('dbx_value_regex' = 'completed|not_required|pending');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `certification_batch` SET TAGS ('dbx_business_glossary_term' = 'Certification Batch Identifier (CERT_BATCH)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date (CERT_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `certification_location` SET TAGS ('dbx_business_glossary_term' = 'Certification Facility Location (CERT_LOC)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number (CERT_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `certification_reference` SET TAGS ('dbx_business_glossary_term' = 'Certification Reference Code (CERT_REF)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `certification_standard` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard (CERT_STD)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `certification_standard` SET TAGS ('dbx_value_regex' = 'JEDEC_JESD49|JEDEC_JESD20|CUSTOM');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `compliance_iatf16949` SET TAGS ('dbx_business_glossary_term' = 'IATF 16949 Compliance Indicator (COMPLY_IATF16949)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `compliance_iso9001` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Compliance Indicator (COMPLY_ISO9001)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `compliance_jedec` SET TAGS ('dbx_business_glossary_term' = 'JEDEC Compliance Indicator (COMPLY_JEDEC)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `customer_requirements` SET TAGS ('dbx_business_glossary_term' = 'Customer Specific KGD Requirements (CUSTOMER_REQ)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `expiration_reason` SET TAGS ('dbx_business_glossary_term' = 'Reason for Certification Expiration (EXPIRY_REASON)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `expiration_reason` SET TAGS ('dbx_value_regex' = 'end_of_life|customer_request|quality_issue|other');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date (EXPIRY_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `kgd_version` SET TAGS ('dbx_business_glossary_term' = 'KGD Version Identifier (KGD_VER)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `parametric_screen_result` SET TAGS ('dbx_business_glossary_term' = 'Parametric Screen Result (PARAM_SCREEN_RES)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `parametric_screen_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Product Part Number (PART_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `quality_kgd_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Lifecycle Status (CERT_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `quality_kgd_certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|revoked');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `reliability_grade` SET TAGS ('dbx_business_glossary_term' = 'Reliability Grade (REL_GRADE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `reliability_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Revision Number (REV_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `test_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Test Coverage Percentage (TEST_COV_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `test_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Test Duration in Hours (TEST_DUR_HRS)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `test_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Test Temperature in Celsius (TEST_TEMP_C)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type Conducted (TEST_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'electrical|parametric|reliability');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` SET TAGS ('dbx_subdomain' = 'supplier_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `dppm_record_id` SET TAGS ('dbx_business_glossary_term' = 'DPPM Record ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Record Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'Closure Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `closure_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress|deferred');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `compliance_iso9001` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `containment_action` SET TAGS ('dbx_business_glossary_term' = 'Containment Action');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `defective_units` SET TAGS ('dbx_business_glossary_term' = 'Defective Units Returned');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `dppm_value` SET TAGS ('dbx_business_glossary_term' = 'Defective Parts Per Million (DPPM)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `eight_d_report_reference` SET TAGS ('dbx_business_glossary_term' = '8D Report Reference');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `failure_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `is_kgd_certified` SET TAGS ('dbx_business_glossary_term' = 'KGD Certified Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `kgd_certification_date` SET TAGS ('dbx_business_glossary_term' = 'KGD Certification Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|closed');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `notification_type` SET TAGS ('dbx_business_glossary_term' = 'Notification Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `notification_type` SET TAGS ('dbx_value_regex' = '8D|SCAR|Customer_Complaint|Field_Return|Other');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Record Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `shipment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Shipment End Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `shipment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Shipment Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `total_units_shipped` SET TAGS ('dbx_business_glossary_term' = 'Total Units Shipped');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` SET TAGS ('dbx_subdomain' = 'supplier_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'CAPA Record Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'CAPA Owner Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `quality_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Related Audit Finding Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Related Customer Complaint Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `defect_record_id` SET TAGS ('dbx_business_glossary_term' = 'Related Defect Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `attachment_reference` SET TAGS ('dbx_business_glossary_term' = 'Attachment Reference');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `capa_number` SET TAGS ('dbx_business_glossary_term' = 'CAPA Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `capa_record_status` SET TAGS ('dbx_business_glossary_term' = 'CAPA Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `capa_record_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `capa_type` SET TAGS ('dbx_business_glossary_term' = 'CAPA Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `capa_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `closure_approval_status` SET TAGS ('dbx_business_glossary_term' = 'CAPA Closure Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `closure_approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Closure Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `compliance_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reference');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `effectiveness_verification_criteria` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verification Criteria');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `impact` SET TAGS ('dbx_business_glossary_term' = 'CAPA Impact');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'CAPA Notes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `preventive_action_description` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'CAPA Priority');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = '1|2|3|4|5');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `problem_statement` SET TAGS ('dbx_business_glossary_term' = 'Problem Statement');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'CAPA Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` SET TAGS ('dbx_subdomain' = 'supplier_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Engineer ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `mrb_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Related MRB Meeting ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `detection_point` SET TAGS ('dbx_business_glossary_term' = 'Detection Point');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `die_range` SET TAGS ('dbx_business_glossary_term' = 'Die Range');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `mrb_decision` SET TAGS ('dbx_business_glossary_term' = 'Material Review Board Decision');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `mrb_decision` SET TAGS ('dbx_value_regex' = 'approve|reject|defer');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `nonconformance_description` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `nonconformance_report_status` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `nonconformance_report_status` SET TAGS ('dbx_value_regex' = 'open|under_review|closed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `report_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `specification_violated` SET TAGS ('dbx_business_glossary_term' = 'Specification Violated');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` SET TAGS ('dbx_subdomain' = 'audit_governance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `quality_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Audit Finding Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `audit_event_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (EQ_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `quality_document_id` SET TAGS ('dbx_business_glossary_term' = 'Related Document Identifier (DOC_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (PID)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier (WF_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action and Preventive Action Identifier (CAPA_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date and Time (ADT)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Number (AFN)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `audit_region` SET TAGS ('dbx_business_glossary_term' = 'Audit Region (AR)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `audit_region` SET TAGS ('dbx_value_regex' = 'APAC|EMEA|AMER|LATAM|APJ');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope (AS)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score (AS)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `audit_team` SET TAGS ('dbx_business_glossary_term' = 'Audit Team (AT)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type (AT)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal|customer|third_party|regulatory');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Full Name (AFN)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Closure Date (FCD)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Closure Status (FCS)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `closure_status` SET TAGS ('dbx_value_regex' = 'open|closed|deferred|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (CS)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date (CAD)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method (DM)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'inspection|test|review|automated|manual');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `finding_classification` SET TAGS ('dbx_business_glossary_term' = 'Finding Classification (FC)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `finding_classification` SET TAGS ('dbx_value_regex' = 'major_nc|minor_nc|observation|opportunity');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description (FD)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'Impact Estimate (IE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `is_repeat_issue` SET TAGS ('dbx_business_glossary_term' = 'Repeat Issue Flag (RIF)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (AN)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `observation_location` SET TAGS ('dbx_business_glossary_term' = 'Observation Location (OL)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body (RB)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `repeat_issue_count` SET TAGS ('dbx_business_glossary_term' = 'Repeat Issue Count (RIC)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating (RR)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level (SL)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|info');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `standard_clause` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standard Clause (ASC)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date (VD)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status (VS)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|failed');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` SET TAGS ('dbx_subdomain' = 'audit_governance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Audit End Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Audit Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `applicable_standard` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standard');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `applicable_standard` SET TAGS ('dbx_value_regex' = 'ISO 9001|IATF 16949|JEDEC|ISO 14001|ISO 45001');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|closed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal|customer|third_party|certification');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Certificate Reference');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `findings_total` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `major_nonconformances` SET TAGS ('dbx_business_glossary_term' = 'Major Non‑Conformance Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `minor_nonconformances` SET TAGS ('dbx_business_glossary_term' = 'Minor Non‑Conformance Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `observations` SET TAGS ('dbx_business_glossary_term' = 'Observation Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `opportunities_for_improvement` SET TAGS ('dbx_business_glossary_term' = 'Opportunity for Improvement Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `overall_result` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Result');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `overall_result` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional|pending');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `plan_document` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan Document Reference');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Audit Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ALTER COLUMN `team` SET TAGS ('dbx_business_glossary_term' = 'Audit Team');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `quality_metrology_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Metrology Measurement ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Metrology Tool Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Process Recipe Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `gauge_rr_reference` SET TAGS ('dbx_business_glossary_term' = 'Gauge R&R Reference');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `measurement_comment` SET TAGS ('dbx_business_glossary_term' = 'Measurement Comment');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `measurement_mode` SET TAGS ('dbx_business_glossary_term' = 'Measurement Mode');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `measurement_mode` SET TAGS ('dbx_value_regex' = 'automatic|manual');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `measurement_uncertainty` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|out_of_spec');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `site_coordinates` SET TAGS ('dbx_business_glossary_term' = 'Site Coordinates');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `site_map_type` SET TAGS ('dbx_business_glossary_term' = 'Site Map Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `site_map_type` SET TAGS ('dbx_value_regex' = '5_point|9_point|49_point|full_map');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `spec_lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `spec_upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `tool_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Tool Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ALTER COLUMN `tool_qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|unqualified|maintenance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` SET TAGS ('dbx_subdomain' = 'supplier_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `supplier_quality_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Quality Scorecard ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Supplier Primary Contact Email');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|CHF');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `evaluation_period_end` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `evaluation_period_start` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `improvement_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Improvement Action Plan Reference');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `kpi_cost_of_poor_quality` SET TAGS ('dbx_business_glossary_term' = 'Cost of Poor Quality KPI');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `kpi_delivery_conformance` SET TAGS ('dbx_business_glossary_term' = 'Delivery Conformance KPI');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `kpi_incoming_quality_rate` SET TAGS ('dbx_business_glossary_term' = 'Incoming Quality Rate KPI');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `kpi_responsiveness` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness KPI');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Notes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `overall_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Quality Score');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_value_regex' = 'draft|active|closed|archived');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `scorecard_version` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Version');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `supplier_development_program` SET TAGS ('dbx_business_glossary_term' = 'Supplier Development Program');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `supplier_type` SET TAGS ('dbx_business_glossary_term' = 'Supplier Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `supplier_type` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4|other');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `tier_classification` SET TAGS ('dbx_business_glossary_term' = 'Tier Classification');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `tier_classification` SET TAGS ('dbx_value_regex' = 'preferred|approved|conditional|probation|disqualified');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `trend_direction` SET TAGS ('dbx_business_glossary_term' = 'Trend Direction');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ALTER COLUMN `trend_direction` SET TAGS ('dbx_value_regex' = 'up|down|stable|declining|improving');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` SET TAGS ('dbx_subdomain' = 'audit_governance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification ID (QUALITY_SPEC_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `fabrication_process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Spec Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `last_validated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Validation Date (SPEC_LAST_VALIDATED_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LOWER_LIMIT)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `measurement_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Measurement Accuracy Percent (MEASUREMENT_ACCURACY_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `measurement_variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Measurement Variance Percent (MEASUREMENT_VARIANCE_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `nominal_value` SET TAGS ('dbx_business_glossary_term' = 'Nominal Value (NOMINAL_VALUE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Specification Notes (SPEC_NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name (PARAMETER_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `parameter_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `process_node` SET TAGS ('dbx_business_glossary_term' = 'Process Node (PROCESS_NODE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family (PRODUCT_FAMILY)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `quality_spec_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Lifecycle Status (SPEC_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `quality_spec_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired|pending');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Specification Review Cycle (SPEC_REVIEW_CYCLE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'annual|quarterly|ad_hoc');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Revision Number (SPEC_REVISION_NUMBER)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `spec_code` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Code (SPEC_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `spec_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Name (SPEC_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `spec_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `spec_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Type (SPEC_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `spec_type` SET TAGS ('dbx_value_regex' = 'electrical|dimensional|visual|reliability|other');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type (TEST_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'functional|stress|environmental|reliability|visual');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (UPPER_LIMIT)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `validated_flag` SET TAGS ('dbx_business_glossary_term' = 'Specification Validated Flag (SPEC_VALIDATED_FLAG)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version (SPEC_VERSION)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` SET TAGS ('dbx_subdomain' = 'supplier_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `quality_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Related Customer Complaint ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `defect_record_id` SET TAGS ('dbx_business_glossary_term' = 'Related Defect Record ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Approver ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `spc_control_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Related SPC Rule ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `trade_compliance_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Compliance Hold Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'process_excursion|spc_out_of_control|customer_complaint|reliability_failure|other');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Hold Initiating Engineer ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Initiation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `is_kgd_certified` SET TAGS ('dbx_business_glossary_term' = 'KGD Certified Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Hold Notes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Hold Priority');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `release_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Reason Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `required_disposition_actions` SET TAGS ('dbx_business_glossary_term' = 'Required Disposition Actions');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Resolution Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|resolved');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` SET TAGS ('dbx_subdomain' = 'reliability_assurance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_analysis_report_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Analysis Report ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Record Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Nonconformance Report Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `related_failure_failure_analysis_report_id` SET TAGS ('dbx_business_glossary_term' = 'Related Reliability Failure ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `reliability_test_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Test Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `analysis_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `analysis_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `analysis_technique` SET TAGS ('dbx_business_glossary_term' = 'Analysis Technique');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `analysis_technique` SET TAGS ('dbx_value_regex' = 'SEM|FIB|EMMI|TEM|EDX|Other');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `defect_code` SET TAGS ('dbx_value_regex' = '^Dd{4}$');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_analysis_report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_analysis_report_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|rejected|closed');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Failure Mechanism');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_severity` SET TAGS ('dbx_business_glossary_term' = 'Failure Severity');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|warning');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_site_location` SET TAGS ('dbx_business_glossary_term' = 'Failure Site Location');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Report Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `report_title` SET TAGS ('dbx_business_glossary_term' = 'Report Title');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'reliability_test|customer_return|in_process|design_review');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `sample_description` SET TAGS ('dbx_business_glossary_term' = 'Sample Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `supporting_evidence_refs` SET TAGS ('dbx_business_glossary_term' = 'Supporting Evidence References');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` SET TAGS ('dbx_subdomain' = 'audit_governance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `quality_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `parent_quality_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Related Quality Notification Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `parent_quality_notification_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `quality_review_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Review Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `quality_review_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `quality_review_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Work Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachment Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `customer_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `defect_rate_ppm` SET TAGS ('dbx_business_glossary_term' = 'Defect Rate Ppm');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `inspection_tool` SET TAGS ('dbx_business_glossary_term' = 'Inspection Tool');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `is_customer_impact` SET TAGS ('dbx_business_glossary_term' = 'Is Customer Impact');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `is_repeat_issue` SET TAGS ('dbx_business_glossary_term' = 'Is Repeat Issue');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `kgd_certified` SET TAGS ('dbx_business_glossary_term' = 'Kgd Certified');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Value');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `notification_number` SET TAGS ('dbx_business_glossary_term' = 'Notification Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `notification_type` SET TAGS ('dbx_business_glossary_term' = 'Notification Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `repeat_issue_count` SET TAGS ('dbx_business_glossary_term' = 'Repeat Issue Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `quality_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` SET TAGS ('dbx_subdomain' = 'reliability_assurance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `qualification_report_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Report Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `quality_qualification_program_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `superseded_qualification_report_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Qualification Report Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `superseded_qualification_report_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `compliance_standards` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standards');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `customer_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Name');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `customer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `customer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `dppm` SET TAGS ('dbx_business_glossary_term' = 'Dppm');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Engineer Name');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `engineer_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `qualification_result` SET TAGS ('dbx_business_glossary_term' = 'Qualification Result');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `report_date` SET TAGS ('dbx_business_glossary_term' = 'Report Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `report_name` SET TAGS ('dbx_business_glossary_term' = 'Report Name');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `report_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Report Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `report_version` SET TAGS ('dbx_business_glossary_term' = 'Report Version');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `qualification_report_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `test_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `test_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` SET TAGS ('dbx_subdomain' = 'audit_governance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `parent_customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Related Customer Complaint Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `parent_customer_complaint_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_business_glossary_term' = 'Complaint Number');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `customer_complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `dppm_impact` SET TAGS ('dbx_business_glossary_term' = 'Dppm Impact');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `manufacturing_site_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `regulatory_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `regulatory_report_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `customer_complaint_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `warranty_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ALTER COLUMN `wafer_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Zone Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ALTER COLUMN `parent_wafer_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Wafer Zone Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ALTER COLUMN `parent_wafer_zone_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ALTER COLUMN `area_um2` SET TAGS ('dbx_business_glossary_term' = 'Area Um2');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ALTER COLUMN `responsible_team` SET TAGS ('dbx_business_glossary_term' = 'Responsible Team');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ALTER COLUMN `shape` SET TAGS ('dbx_business_glossary_term' = 'Shape');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ALTER COLUMN `typical_defect_density` SET TAGS ('dbx_business_glossary_term' = 'Typical Defect Density');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Zone Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ALTER COLUMN `zone_description` SET TAGS ('dbx_business_glossary_term' = 'Zone Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ALTER COLUMN `zone_name` SET TAGS ('dbx_business_glossary_term' = 'Zone Name');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ALTER COLUMN `zone_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ALTER COLUMN `zone_status` SET TAGS ('dbx_business_glossary_term' = 'Zone Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_business_glossary_term' = 'Zone Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ALTER COLUMN `zone_version` SET TAGS ('dbx_business_glossary_term' = 'Zone Version');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `defect_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Cluster Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Lot Fabrication Wafer Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `parent_defect_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Defect Cluster Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `parent_defect_cluster_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `associated_process_step` SET TAGS ('dbx_business_glossary_term' = 'Associated Process Step');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `associated_product_family` SET TAGS ('dbx_business_glossary_term' = 'Associated Product Family');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `associated_wafers` SET TAGS ('dbx_business_glossary_term' = 'Associated Wafers');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `cluster_code` SET TAGS ('dbx_business_glossary_term' = 'Cluster Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `cluster_creation_date` SET TAGS ('dbx_business_glossary_term' = 'Cluster Creation Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `cluster_name` SET TAGS ('dbx_business_glossary_term' = 'Cluster Name');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `cluster_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `cluster_type` SET TAGS ('dbx_business_glossary_term' = 'Cluster Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `customer_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `defect_pattern` SET TAGS ('dbx_business_glossary_term' = 'Defect Pattern');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `defect_cluster_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `dppm` SET TAGS ('dbx_business_glossary_term' = 'Dppm');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `impact_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Impact Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `inspection_tool` SET TAGS ('dbx_business_glossary_term' = 'Inspection Tool');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `is_customer_reported` SET TAGS ('dbx_business_glossary_term' = 'Is Customer Reported');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Value');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `defect_cluster_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` SET TAGS ('dbx_subdomain' = 'supplier_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `mrb_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Mrb Meeting Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `parent_mrb_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Related Mrb Meeting Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `parent_mrb_meeting_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `action_items` SET TAGS ('dbx_business_glossary_term' = 'Action Items');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `decision_summary` SET TAGS ('dbx_business_glossary_term' = 'Decision Summary');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `facilitator_email` SET TAGS ('dbx_business_glossary_term' = 'Facilitator Email');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `facilitator_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `facilitator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `facilitator_name` SET TAGS ('dbx_business_glossary_term' = 'Facilitator Name');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `facilitator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `facilitator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `meeting_code` SET TAGS ('dbx_business_glossary_term' = 'Meeting Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Meeting Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `meeting_name` SET TAGS ('dbx_business_glossary_term' = 'Meeting Name');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `meeting_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `meeting_type` SET TAGS ('dbx_business_glossary_term' = 'Meeting Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `participant_count` SET TAGS ('dbx_business_glossary_term' = 'Participant Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `mrb_meeting_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` SET TAGS ('dbx_subdomain' = 'audit_governance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `quality_document_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Document Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `superseded_quality_document_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Quality Document Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `superseded_quality_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `author_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `author_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'Checksum Md5');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `compliance_standards` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standards');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `quality_document_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `document_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Path');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size Bytes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `quality_document_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` SET TAGS ('dbx_subdomain' = 'audit_governance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `test_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Test Plan Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `parent_test_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Related Test Plan Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `parent_test_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `approver` SET TAGS ('dbx_business_glossary_term' = 'Approver');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `approver` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `approver` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `author` SET TAGS ('dbx_business_glossary_term' = 'Author');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `author` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `author` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `defect_threshold` SET TAGS ('dbx_business_glossary_term' = 'Defect Threshold');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `test_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `last_executed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Executed Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `last_result` SET TAGS ('dbx_business_glossary_term' = 'Last Result');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `measurement_units` SET TAGS ('dbx_business_glossary_term' = 'Measurement Units');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `pass_fail_criteria` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Criteria');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `test_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `target_device` SET TAGS ('dbx_business_glossary_term' = 'Target Device');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `test_category` SET TAGS ('dbx_business_glossary_term' = 'Test Category');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `test_duration_estimate_minutes` SET TAGS ('dbx_business_glossary_term' = 'Test Duration Estimate Minutes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `test_environment` SET TAGS ('dbx_business_glossary_term' = 'Test Environment');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ALTER COLUMN `wafer_size` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` SET TAGS ('dbx_subdomain' = 'audit_governance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `superseded_control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Control Plan Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `superseded_control_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `author_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `control_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `dppm_actual` SET TAGS ('dbx_business_glossary_term' = 'Dppm Actual');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `dppm_target` SET TAGS ('dbx_business_glossary_term' = 'Dppm Target');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `inspection_tool` SET TAGS ('dbx_business_glossary_term' = 'Inspection Tool');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `measurement_criteria` SET TAGS ('dbx_business_glossary_term' = 'Measurement Criteria');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `related_product_family` SET TAGS ('dbx_business_glossary_term' = 'Related Product Family');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `sampling_rate` SET TAGS ('dbx_business_glossary_term' = 'Sampling Rate');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `control_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `tolerance_lower` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Lower');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `tolerance_upper` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Upper');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
