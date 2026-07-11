-- Schema for Domain: quality | Business: Semiconductors | Version: v2_mvm
-- Generated on: 2026-07-10 14:04:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`quality` COMMENT 'Quality assurance, reliability testing, defect inspection, metrology, DPPM tracking, FMEA, and qualification programs. Manages KGD certification, yield analysis, customer quality notifications, and compliance with ISO 9001, IATF 16949, and JEDEC reliability standards. Integrates with KLA ICOS inspection systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` (
    `inspection_lot_id` BIGINT COMMENT 'Unique identifier for the inspection lot record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Export compliance verification requires each inspected lot to be linked to the export license authorizing its shipment.',
    `booking_id` BIGINT COMMENT 'Foreign key linking to sales.booking. Business justification: Outgoing inspection lots in semiconductor fabs are triggered by booking/shipment events. Linking inspection_lot to booking enables outgoing quality control traceability — quality engineers need to kno',
    `control_plan_id` BIGINT COMMENT 'Foreign key linking to quality.control_plan. Business justification: An inspection lot is conducted according to a specific control plan that defines the sampling rate, inspection method, measurement criteria, and acceptance criteria. Linking inspection_lot to control_',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: KGD certification inspections are performed on die bank inventory. inspection_lot carries kgd_certified and kgd_certification_date; die_bank carries kgd_status. Linking the certifying inspection_lot t',
    `equipment_run_id` BIGINT COMMENT 'Foreign key linking to fabrication.equipment_run. Business justification: Inline inspection lots are triggered by specific equipment runs (post-etch, post-CMP). MES traceability requires linking inspection results to the exact equipment run that processed the wafers, enabli',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: Inspection lots are performed at specific fab facilities. Facility-level quality reporting, IATF 16949 audits, and customer quality scorecards require inspection results to be attributed to the manufa',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: Final test is a key inspection stage where inspection lots are created and dispositioned. Linking inspection_lot to final_test_run provides IATF 16949 traceability from test execution to quality dispo',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: Outgoing quality control and final acceptance inspection in semiconductor packaging requires tracing each inspection_lot to the specific finished_good inventory lot. Enables lot disposition (accept/re',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: In semiconductor incoming quality control (analogous to SAP QM), goods receipt directly triggers inspection lot creation. This link enables incoming inspection traceability from receipt to disposition',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Inspection lot reports are generated per IC part; linking to ic_catalog enables traceability for compliance and lot‑by‑lot quality reports.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Inspection Lot Report requires linking each lot to the Fab Tool used for inspection to ensure traceability and compliance.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Semiconductor inspection tools are multi-chamber; chamber-level traceability on inspection lots is required for chamber-specific contamination attribution, chamber matching studies, and chamber qualif',
    `osat_work_order_id` BIGINT COMMENT 'Foreign key linking to supply.osat_work_order. Business justification: Post-OSAT incoming inspection lots are created when assembled devices return from the OSAT subcontractor. Linking to the work order enables post-assembly inspection traceability and OSAT quality perfo',
    `process_recipe_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_recipe. Business justification: Inspection sampling plans and acceptance criteria are recipe-dependent. Fabs correlate inspection results with recipe versions for process qualification and recipe change impact assessment — a standar',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: An inspection lot is evaluated against a defined quality specification that sets acceptance criteria, rejection criteria, and sampling plans. Linking inspection_lot to quality_spec establishes the spe',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to inventory.raw_material. Business justification: Incoming material inspection (IMI) is a standard semiconductor process — silicon wafers, process chemicals, and substrates are inspected upon receipt. The inspection_lot must reference the raw_materia',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Incoming inspection lots in semiconductor manufacturing reference the specific ordered SKU — acceptance criteria (AQL, sampling plan) can vary by SKU speed grade and temperature range. inspection_lot ',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Inspection lot tracking ties each lot to the specific process step being inspected, required for lot‑by‑step quality dashboards.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier providing the material.',
    `supplier_qualification_id` BIGINT COMMENT 'Foreign key linking to supply.supplier_qualification. Business justification: Incoming inspection acceptance criteria are determined by the suppliers qualification status. Linking inspection_lot to supplier_qualification enables application of qualification-based sampling plan',
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
    `capa_record_id` BIGINT COMMENT 'Foreign key linking to quality.capa_record. Business justification: A defect record capturing a systematic or critical defect may trigger a Corrective and Preventive Action. Linking defect_record to capa_record provides the traceability from individual defect detectio',
    `defect_inspection_result_id` BIGINT COMMENT 'Foreign key linking to process.defect_inspection_result. Business justification: Quality defect records are created from process-side defect inspection results. This link enables root cause analysis by connecting the quality system record to the originating inspection data, suppor',
    `design_ip_core_id` BIGINT COMMENT 'Foreign key linking to design.ip_core. Business justification: Needed for Defect Attribution Report to associate each defect with the specific IP core block used in the design, enabling targeted remediation.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Defect Analysis Report ties each defect to the detecting Fab Tool for root‑cause analysis and corrective action planning.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Chamber-level defect attribution is a standard semiconductor root cause analysis practice. Chamber matching and chamber qualification reports require knowing which specific chamber detected or process',
    `equipment_run_id` BIGINT COMMENT 'Foreign key linking to fabrication.equipment_run. Business justification: Defect records must trace to the specific equipment run that introduced the defect — fundamental for equipment excursion analysis, SPC, and root cause isolation. Semiconductor quality engineers requir',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: Defects detected during final test are recorded in defect_record. Linking to the final_test_run enables failure analysis teams to trace defects to specific test conditions, handler configurations, and',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Defects found during incoming inspection are directly tied to the goods receipt event. This is the core incoming quality control traceability link — enables lot-level defect tracking from receipt thro',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Research defect analysis ties defect records to the experimental lot they originated from for root‑cause analysis of new process nodes.',
    `inspection_lot_id` BIGINT COMMENT 'FK to quality.inspection_lot.inspection_lot_id — Every defect is detected within an inspection lot. This is the fundamental parent-child relationship for defect tracking. Without this FK, defects cannot be traced to their inspection context.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Defect Tracking & Recall Management uses the inventory lot ID to locate and quarantine affected stock across the supply chain.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Defect records must be tied to the originating order line for root‑cause analysis, warranty claims, and corrective actions.',
    `lot_move_id` BIGINT COMMENT 'Foreign key linking to fabrication.lot_move. Business justification: Defect records are attributed to specific lot_move events (process step executions) where defects were introduced. Step-level defect attribution in MES is required for process window analysis and yiel',
    `lot_process_run_id` BIGINT COMMENT 'Foreign key linking to process.lot_process_run. Business justification: Defect records must be traceable to the specific process run that produced them for run-level defect aggregation and yield analysis. This link enables defect pareto by process run, supporting yield im',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: A defect record capturing a significant defect event may trigger or be associated with a Non-Conformance Report. Linking defect_record to nonconformance_report provides the traceability chain from ind',
    `osat_work_order_id` BIGINT COMMENT 'Foreign key linking to supply.osat_work_order. Business justification: Assembly and packaging defects in semiconductor manufacturing must be traced to the OSAT work order for OSAT supplier quality management, yield loss attribution, and corrective action requests against',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Defect classification references PDK rule deck versions (DRC/LVS/DFM). Defect pareto analysis by PDK version drives design rule updates and yield learning. Essential for foundry-design co-optimization',
    `photomask_id` BIGINT COMMENT 'Foreign key linking to fabrication.photomask. Business justification: Lithography defects are directly attributable to specific photomask instances (mask defects, pellicle contamination). Mask-induced defect tracking is a critical quality process — fabs must correlate d',
    `wafer_map_id` BIGINT COMMENT 'FK to quality.wafer_map.wafer_map_id — Defects with X/Y coordinates must link to the wafer map for spatial analysis. This is critical for systematic defect pattern detection.',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_flow. Business justification: Defects are attributed to specific process flow versions for yield learning. Process flow revision correlation is needed for flow-level defect density analysis and to assess yield impact of flow chang',
    `process_recipe_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_recipe. Business justification: Defects are correlated to fab-specific recipe versions for process excursion analysis and recipe qualification. The existing process_recipe_id links to process.recipe; this links to the fab-domain rec',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Incoming material defects must be traceable to the specific purchase order for supplier quality management, warranty claims, and material disposition decisions. Enables PO-level defect rate reporting ',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Root cause analysis requires linking each defect record to the exact process step where the defect originated, used in RCA reports.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Supplier quality scorecards and 8D reports require tracing defect records to the originating supplier. Incoming material defects (substrate, chemical, wafer) must be attributed to the specific supplie',
    `unit_test_result_id` BIGINT COMMENT 'Foreign key linking to test.unit_test_result. Business justification: A defect_record is often generated from a specific unit_test_result (a single devices failing test outcome). This link enables failure analysis to trace a defect directly to the exact parametric test',
    `wafer_id` BIGINT COMMENT 'Identifier of the wafer on which the defect was observed.',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: Defects detected during wafer probe are recorded in defect_record. Linking to the wafer_probe_run that detected the defect is essential for root cause analysis — engineers need probe run conditions (t',
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
    `bin_definition_id` BIGINT COMMENT 'Foreign key linking to test.bin_definition. Business justification: Wafer maps classify die using bin codes (pass_bin_code, fail_bin_code are denormalized text columns). Linking wafer_map to bin_definition normalizes bin classification, enabling quality engineers to q',
    `equipment_run_id` BIGINT COMMENT 'Foreign key linking to fabrication.equipment_run. Business justification: Wafer maps are generated after specific equipment runs (post-lithography, post-etch). Linking wafer_map to equipment_run enables spatial defect correlation with process conditions — essential for equi',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the inspection tool that produced the map.',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: Wafer maps are generated at final test stage (post-singulation bin maps) as well as wafer probe. Linking wafer_map to final_test_run enables quality engineers to associate final test bin distributions',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Wafer maps are associated with experimental lots to evaluate new wafer designs in research projects.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: A wafer map is generated as part of a quality inspection lot — each wafer map captures the spatial defect/bin distribution for a wafer within a specific inspection lot. Adding inspection_lot_id to waf',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Wafer Map Archive ties each map to the inventory wafer lot for yield analysis and historical compliance audits.',
    `lot_move_id` BIGINT COMMENT 'Foreign key linking to fabrication.lot_move. Business justification: Wafer maps are generated at specific lot_move events (post-process inspection points in MES). Linking wafer_map to lot_move enables step-level spatial defect tracking and correlates map data with actu',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_flow. Business justification: Wafer maps are generated within specific process flows. Flow-level wafer map analysis supports yield learning by process flow revision — a standard semiconductor yield engineering activity for technol',
    `process_recipe_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_recipe. Business justification: Wafer maps are recipe-specific — die layout, exclusion zones, and bin definitions depend on the process recipe version. Recipe-to-map correlation is used in yield learning and recipe qualification sig',
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
    `failing_die_count` STRING COMMENT 'Number of dies classified as failing.',
    `flat_orientation` STRING COMMENT 'Orientation of the wafer flat/notch relative to the map coordinate system.. Valid values are `north|south|east|west`',
    `is_kgd_certified` BOOLEAN COMMENT 'Indicates whether the wafer passed Known Good Die certification.',
    `kgd_certification_timestamp` TIMESTAMP COMMENT 'Timestamp when KGD certification was applied.',
    `map_checksum` STRING COMMENT 'Checksum (e.g., SHA-256) of the map file for integrity verification.',
    `map_file_path` STRING COMMENT 'File system path or URI where the wafer map image/file is stored.',
    `map_generation_timestamp` TIMESTAMP COMMENT 'Date and time when the wafer map was generated.',
    `map_status` STRING COMMENT 'Current processing status of the wafer map.. Valid values are `generated|validated|rejected|archived`',
    `map_version` STRING COMMENT 'Version identifier of the map generation algorithm or software.',
    `passing_die_count` STRING COMMENT 'Number of dies classified as passing.',
    `remarks` STRING COMMENT 'Free-text comments or notes about the wafer map.',
    `total_die_count` STRING COMMENT 'Total number of dies evaluated on the wafer.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_wafer_map PRIMARY KEY(`wafer_map_id`)
) COMMENT 'Spatial defect and bin distribution map for an individual wafer within an inspection lot. Captures wafer ID, lot ID, die grid coordinates, per-die pass/fail bin assignment, defect density per zone, edge exclusion zone, flat/notch orientation, and map generation timestamp. Sourced from KLA ICOS and ATE wafer probing systems. Enables yield spatial analysis and systematic defect pattern detection.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` (
    `yield_record_id` BIGINT COMMENT 'System-generated unique identifier for the yield record.',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: Wafer probe yield records directly determine die bank population — the yield_record at probe stage defines how many known-good die are available for banking. This is a fundamental semiconductor yield-',
    `equipment_run_id` BIGINT COMMENT 'Foreign key linking to fabrication.equipment_run. Business justification: Yield records at specific process steps are correlated to equipment runs for equipment-induced yield loss analysis — a standard yield engineering activity. Identifying which equipment runs correlate w',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: Yield records are attributed to specific fab facilities for facility-level yield benchmarking, capacity planning, and customer quality scorecards. The existing fab_line column is a denormalized facili',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the equipment that performed the measurement.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_wafer_lot. Business justification: Yield records must be traceable to the source wafer lot for lot-level yield reporting, customer yield reports, and yield excursion containment. The existing link is only to wafer; lot-level yield trac',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: REQUIRED: Yield records reference the final test run that produced pass/fail counts; needed for yield vs. test performance dashboards.',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: Final test yield records capture pass/fail counts for specific finished_good inventory lots. yield_record has sku_id (product definition) but not finished_good_id (inventory instance). Linking to fini',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Yield data from quality is linked to experimental lots to assess the success of research‑driven process changes.',
    `inspection_lot_id` BIGINT COMMENT 'FK to quality.inspection_lot.inspection_lot_id — Yield measurements are taken at quality gates associated with inspection lots. This link enables yield-to-defect correlation analysis.',
    `lot_process_run_id` BIGINT COMMENT 'Foreign key linking to process.lot_process_run. Business justification: Yield records are produced from lot process runs; linking them enables process-yield correlation analysis critical for yield improvement programs. Fab yield engineers use this link to identify which p',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: A yield record showing yield below the quality gate threshold may trigger a Non-Conformance Report. Linking yield_record to nonconformance_report enables traceability from yield measurement outcomes t',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_flow. Business justification: Yield records correlated with process flow versions support yield-by-flow-revision analysis — a standard semiconductor yield learning activity required for process flow qualification and technology no',
    `process_recipe_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_recipe. Business justification: Yield records correlated to fab-specific recipe versions support recipe qualification and process control. The existing recipe_id links to process.recipe; this links to the fab-domain recipe for fab-s',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: A yield record captures yield measurements at a quality gate that is defined by a quality specification (yield target, acceptable yield gap, measurement method). Linking yield_record to quality_spec e',
    `recipe_id` BIGINT COMMENT 'Identifier of the process recipe applied to the wafer.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Yield records are produced per SKU for production performance dashboards; FK to sku replaces denormalized product_sku column.',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Yield records are aggregated per process step; linking provides step‑level yield analysis for continuous improvement.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Supports Yield Analysis Dashboard linking yield data to the corresponding tapeout, essential for performance tracking and cost forecasting.',
    `wafer_id` BIGINT COMMENT 'Unique identifier for the individual wafer.',
    `wafer_map_id` BIGINT COMMENT 'Foreign key linking to quality.wafer_map. Business justification: A yield record at wafer probe stage corresponds to a specific wafer map that captures the bin distribution and die pass/fail spatial layout. Linking yield_record to wafer_map enables traceability betw',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: Yield records at wafer probe stage must directly reference the wafer_probe_run for yield analysis dashboards and SPC monitoring. While an indirect path exists via wafer_map, a direct FK enables yield ',
    `batch_number` STRING COMMENT 'Identifier of the data acquisition batch.',
    `bin_distribution_summary` STRING COMMENT 'Compact representation (e.g., JSON) of die bin counts across test bins.',
    `calibration_status` STRING COMMENT 'Indicates whether the measurement equipment was calibrated.. Valid values are `calibrated|uncalibrated`',
    `comments` STRING COMMENT 'Free-text notes or observations related to the measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the yield record was first created in the system.',
    `defect_count` BIGINT COMMENT 'Number of defects detected for the specified defect type.',
    `defect_density_per_cm2` DECIMAL(18,2) COMMENT 'Number of defects per square centimeter of wafer area.',
    `defect_type` STRING COMMENT 'Classification of the dominant defect observed.. Valid values are `critical|major|minor|none`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the yield measurement was captured.',
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` (
    `reliability_test_id` BIGINT COMMENT 'Unique identifier for the reliability test record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer associated with the qualification.',
    `capa_record_id` BIGINT COMMENT 'Foreign key linking to quality.capa_record. Business justification: A reliability test failure triggers a Corrective and Preventive Action to address the identified failure mechanism. Linking reliability_test to capa_record establishes the traceability from reliabilit',
    `customer_contract_id` BIGINT COMMENT 'Foreign key linking to sales.customer_contract. Business justification: Reliability qualification tests (AEC-Q100, JEDEC) are contractually mandated in semiconductor customer contracts. The customer_contract has pcn_obligation and qualification requirements. Linking relia',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: KGD reliability qualification tests are performed on die bank inventory. reliability_test has is_kgd_certified attribute; die_bank has kgd_status. The reliability test that qualifies a die bank lot is',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: Reliability tests are associated with the fab facility that produced the test samples. Facility-level reliability qualification tracking is required for customer qualification packages and JEDEC quali',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the test equipment used (e.g., KLA ICOS system).',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: Reliability test samples are drawn from units that passed final test. Linking reliability_test to final_test_run provides JEDEC and AEC-Q qualification traceability — reliability engineers must docume',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: Reliability qualification tests (HTOL, ELFR, THB) are performed on packaged devices drawn from finished_good inventory lots. AEC-Q100/Q101 qualification requires traceability from reliability test res',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Reliability test results are tied to a specific IC part; required for qualification compliance and customer reliability reports.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Reliability qualification tests are performed on units drawn from a specific inspection lot. Linking reliability_test to inspection_lot establishes traceability between the reliability qualification p',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: REQUIRED: Reliability test plan must be associated with each execution run to satisfy JEDEC reliability compliance and generate post‑run reports.',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: A reliability test failure (e.g., HTOL, HAST, ESD) that does not meet JEDEC or IATF 16949 pass criteria triggers a Non-Conformance Report. Linking reliability_test to nonconformance_report establishes',
    `osat_work_order_id` BIGINT COMMENT 'Foreign key linking to supply.osat_work_order. Business justification: Qualification reliability testing (JEDEC, AEC-Q100) is performed on packaged devices assembled by OSAT. Linking reliability_test to osat_work_order enables package qualification traceability and OSAT ',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_flow. Business justification: Reliability tests (HTOL, ELFR, TDDB) are qualified against specific process flows. JEDEC qualification reporting requires traceability from reliability test results to the process flow version — a man',
    `process_recipe_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_recipe. Business justification: Reliability test results are correlated to process recipes for qualification — gate oxide integrity and electromigration tests are tied to specific deposition/implant recipes. JEDEC/AEC-Q100 qualifica',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Reliability tests (HTOL, burn-in, ESD) are executed using specific test programs. JEDEC and AEC-Q qualification documentation requires recording which test program version was used. Reliability engine',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to process.process_qualification. Business justification: Reliability tests (JEDEC burn-in, HTOL, ESD) are executed as part of process qualification plans. Linking reliability_test to process_qualification enables qualification status tracking, customer appr',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: Reliability tests are executed against defined quality specifications (pass/fail criteria, test conditions, JEDEC standards). Linking reliability_test to quality_spec establishes the specification-to-',
    `sku_id` BIGINT COMMENT 'FK to quality.fmea_record.fmea_record_id — Reliability test failures validate or invalidate FMEA failure mode predictions. FMEA recommended actions often include reliability testing. qualification_program description states Links to reliabili',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: JEDEC reliability qualification (burn-in, HTOL, HAST) is performed in specific stress chambers. Chamber qualification status and calibration history directly affect test result validity. Traceability ',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: KGD (Known Good Die) reliability qualification requires wafer-level reliability testing on samples from specific probe runs. Linking reliability_test to wafer_probe_run provides JEDEC qualification tr',
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` (
    `dppm_record_id` BIGINT COMMENT 'System-generated unique identifier for the DPPM record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer who received the shipment and reported the defect.',
    `booking_id` BIGINT COMMENT 'Foreign key linking to sales.booking. Business justification: DPPM records require the shipped quantity from the booking to compute defects-per-million. The booking captures booked_quantity and ship_to_country. Semiconductor quality engineers routinely calculate',
    `capa_record_id` BIGINT COMMENT 'FK to quality.capa_record.capa_record_id — Customer quality issues (DPPM events, 8D reports) trigger CAPA records. This link is required for customer complaint resolution tracking per IATF 16949.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: DPPM records are customer-facing quality metrics reported to specific contacts at customer accounts. Semiconductor customer quality scorecards and IATF 16949 customer-specific requirements mandate tra',
    `customer_complaint_id` BIGINT COMMENT 'Foreign key linking to quality.customer_complaint. Business justification: DPPM records track customer quality performance and are frequently triggered by or associated with a formal customer complaint. Linking dppm_record to customer_complaint enables traceability from the ',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: DPPM metrics are tracked by manufacturing facility for quality performance dashboards and customer scorecards. Facility-level DPPM reporting is a standard semiconductor customer quality management req',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_wafer_lot. Business justification: DPPM records must trace to the source wafer lot to identify which production lots contributed to field failures. Required for customer quality reporting, corrective action scoping, and lot-level DPPM ',
    `failure_analysis_report_id` BIGINT COMMENT 'Foreign key linking to quality.failure_analysis_report. Business justification: DPPM events involving field failures often require a Failure Analysis Report to determine the root cause of the defective units. Linking dppm_record to failure_analysis_report enables traceability fro',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: DPPM records track field failures traced back to final test runs to identify test escapes. Linking dppm_record to final_test_run is the core of test escape analysis — quality engineers use this to det',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: DPPM records track field failures of shipped finished goods. Linking to the specific finished_good inventory lot enables lot traceability for field containment, customer 8D responses, and identificati',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: DPPM records track defective units per part number; linking to ic_catalog enables part‑level defect analytics.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: DPPM tracking by design project enables design-for-quality metrics and design team accountability. Essential for automotive supplier scorecards and design quality KPIs in zero-defect programs.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: A DPPM record tracking defective units shipped to a customer can be traced back to the inspection lot from which those units were released. Linking dppm_record to inspection_lot enables root cause ana',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: A DPPM event involving defective units shipped to a customer typically results in or is associated with a Non-Conformance Report. Linking dppm_record to nonconformance_report provides the quality chai',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_flow. Business justification: DPPM analysis requires correlation to process flow versions to identify which flow revisions contributed to field failures. Required for process qualification decisions and customer quality reporting ',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: DPPM tracking in semiconductor customer quality is always measured per shipped SKU (specific part number). The plain part_number column is a denormalization of product.sku. Customer scorecards, 8D r',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Supplier DPPM (Defective Parts Per Million) is a core semiconductor supply chain quality KPI. Linking dppm_record to supplier enables supplier quality scorecards, approved vendor list decisions, and I',
    `unit_test_result_id` BIGINT COMMENT 'Foreign key linking to test.unit_test_result. Business justification: DPPM investigations for specific failed units require retrieving the unit_test_result by device serial number to confirm test escape (unit passed test but failed in field). This is a mandatory step in',
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
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: CAPAs in semiconductor manufacturing are frequently customer-initiated or customer-driven. Linking CAPA to the customer account enables customer-specific CAPA tracking, customer scorecards, and IATF 1',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: CAPA effectiveness verification requires customer sign-off from a named contact. In semiconductor quality systems, the customer contact who approves CAPA closure is tracked for audit trail and IATF 16',
    `equipment_run_id` BIGINT COMMENT 'Foreign key linking to fabrication.equipment_run. Business justification: CAPAs triggered by equipment excursions must reference the specific equipment run that caused the nonconformance. Required for 8D/CAPA closure in semiconductor quality systems — the corrective action ',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: CAPAs are scoped to specific fab facilities. Facility-level CAPA tracking is required for quality management system audits (IATF 16949) and for assessing whether corrective actions need to be replicat',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the audit finding associated with the CAPA.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: CAPAs in semiconductor manufacturing are frequently scoped to an entire product family when a process node or design issue affects all devices in the family. Family-level CAPA scoping is required for ',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: CAPAs triggered by finished goods quality escapes (customer returns, DPPM events) must reference the affected finished_good lot for containment action tracking and effectiveness verification. IATF 169',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: CAPAs triggered by in-process wafer lot failures require referencing the inventory_wafer_lot placed on hold during investigation. capa_record has fabrication_wafer_lot_id (fabrication domain) but no i',
    `nonconformance_report_id` BIGINT COMMENT 'FK to quality.nonconformance_report.nonconformance_report_id — CAPAs are triggered by nonconformances. This is a critical traceability link for ISO 9001 clause 10.2 compliance.',
    `process_recipe_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_recipe. Business justification: CAPAs frequently target specific recipe parameters as root cause. Linking CAPA to the fabrication recipe enables recipe change control as corrective action — a standard semiconductor quality managemen',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: CAPAs in semiconductor manufacturing frequently result in test program changes (adding test coverage for newly discovered failure modes). Linking capa_record to test_program documents which test progr',
    `sku_id` BIGINT COMMENT 'Identifier of the product or design associated with the CAPA.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: IATF 16949 CAPA traceability requires identifying the specific equipment chamber that caused the nonconformance (e.g., chamber particle event, temperature drift). Chamber-level CAPA linkage enables ta',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Supplier Corrective Action Requests (SCARs) are a primary use of CAPA records in semiconductor supply chain quality. CAPAs issued to suppliers must reference the supplier for SCAR tracking, effectiven',
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
    `booking_id` BIGINT COMMENT 'Foreign key linking to sales.booking. Business justification: NCRs raised against shipped product must reference the booking for hold/recall decisions, customer notification obligations, and revenue impact assessment. Semiconductor quality teams need the booking',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: NCR already tracks customer_notification_required and customer_notification_sent_timestamp, implying a specific customer contact must be notified. Semiconductor quality systems require the named custo',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: NCRs are raised against die bank inventory when KGD die fail re-inspection or latent defects are discovered. The NCR drives quarantine and disposition of the die_bank lot. Critical for KGD supply chai',
    `fab_facility_id` BIGINT COMMENT 'Identifier of the MRB meeting linked to this report.',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: NCRs are raised when final test results reveal nonconformances (yield excursions, parametric failures outside spec). Linking NCR to final_test_run is essential for MRB (Material Review Board) decision',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: NCRs are raised against finished goods during outgoing QC or customer returns. The NCR drives disposition decisions (scrap, rework, return-to-stock) on the specific finished_good lot. IATF 16949 requi',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: NCRs for incoming material nonconformances are directly triggered by goods receipt events. Standard semiconductor incoming quality process: goods arrive, inspection finds nonconformance, NCR is raised',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: NCMRs are issued for a specific IC part; linking to ic_catalog supports root‑cause analysis and customer notifications.',
    `inspection_lot_id` BIGINT COMMENT 'FK to quality.inspection_lot.inspection_lot_id — NCRs are typically discovered during inspection. This link provides traceability from the non-conformance back to the inspection event where it was detected.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: NCR handling requires linking the report to the inventory lot to enforce holds, quarantine, and corrective action tracking.',
    `osat_work_order_id` BIGINT COMMENT 'Foreign key linking to supply.osat_work_order. Business justification: NCRs raised for OSAT assembly/packaging nonconformances must reference the work order for OSAT supplier quality management, MRB decisions, and corrective action tracking against the assembly subcontra',
    `process_recipe_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_recipe. Business justification: NCRs cite the specific recipe version that was out-of-spec. Recipe version is required for the specification_violated context and corrective action planning — a standard semiconductor NCR documentatio',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: NCR‑PO linkage needed for root‑cause analysis and supplier accountability in Nonconformance Reporting.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: NCRs in semiconductor supply chain are raised against specific orderable SKUs (package type, speed grade, temperature range). Incoming inspection rejection and MRB decisions reference the SKU. nonconf',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: IATF 16949 nonconformance management requires traceability to the equipment source of the nonconformance. NCRs triggered by tool out-of-control events must reference the offending tool to drive equipm',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: NCRs reference the process step where non‑conformance was detected, essential for corrective‑action workflow.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: NCRs raised for incoming material nonconformances must reference the responsible supplier for Supplier Corrective Action Requests (SCARs), supplier performance metrics, and regulatory compliance repor',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: NCRs raised post-tapeout must track which tapeout revision contained the defect for mask revision control and GDS version management. Critical for automotive traceability (IATF 16949) and design chang',
    `wafer_id` BIGINT COMMENT 'Unique identifier of the wafer where the issue was detected.',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: NCRs raised from wafer probe yield excursions or bin distribution anomalies must reference the wafer_probe_run for MRB disposition. Quality engineers need probe run data (yield, bin map, equipment) to',
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` (
    `quality_spec_id` BIGINT COMMENT 'Unique identifier for the quality specification record.',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: Specs often depend on the technology node; linking allows node‑specific parameter validation.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: IATF 16949 requires quality specs scoped to product families. Semiconductor fabs define process-node and lithography-level quality specs at the family level. product_family plain text column is a de',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Quality specs in semiconductor manufacturing are defined at the IC catalog (device type) level for incoming inspection and qualification. A device-level quality spec governs all lots of that IC regard',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Quality specifications define acceptance criteria for specific materials in semiconductor manufacturing. Linking quality_spec to material_master enables material-specific inspection plans, incoming qu',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Specification Measurement Traceability links each spec to the Fab Tool that performs the measurement, required for ISO 9001 compliance.',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Quality specifications define electrical limits (voltage, timing, leakage) and physical constraints (metal density, antenna rules) that are PDK-specific. Critical for process node qualification and de',
    `process_recipe_id` BIGINT COMMENT 'Foreign key linking to fabrication.process_step. Business justification: Specification documents are applied to a particular process step; linking supports step‑specific spec compliance checks.',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to inventory.raw_material. Business justification: Quality specifications define acceptance criteria for raw materials (silicon wafer resistivity limits, purity thresholds, dimensional tolerances). Linking quality_spec to raw_material enables automate',
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` (
    `failure_analysis_report_id` BIGINT COMMENT 'Unique identifier for the failure analysis report.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Failure analysis reports in semiconductor industry are customer-facing documents distributed to the requesting customer account. FA report distribution, 8D report tracking, and customer satisfaction m',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Semiconductor failure analysis reports (SEM, FIB, TEM, EDX) must trace which analytical tool was used. Tool calibration status and qualification history affect FA result validity for customer submissi',
    `capa_record_id` BIGINT COMMENT 'FK to quality.capa_record.capa_record_id — Failure analysis conclusions drive corrective actions. This is a critical link in the closed-loop quality system.',
    `defect_record_id` BIGINT COMMENT 'Foreign key linking to quality.defect_record. Business justification: A failure analysis report investigates a specific defect event captured in a defect record. Linking failure_analysis_report to defect_record provides the traceability from the formal FA investigation ',
    `equipment_run_id` BIGINT COMMENT 'Foreign key linking to fabrication.equipment_run. Business justification: Failure analysis reports trace failures to specific equipment runs for root cause isolation. FA engineers require exact run conditions (temperature, pressure, recipe parameters) to identify process-in',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_wafer_lot. Business justification: FA reports must reference the source wafer lot for sample traceability and containment scope. Direct lot-level traceability is required for FA sample documentation and for determining which other lots',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: FA reports initiated from final test failures reference the specific final_test_run to correlate failure patterns across the run (e.g., socket-specific failures, thermal excursions). FA engineers use ',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: Failure analysis reports in semiconductor field returns are performed on finished goods returned by customers. The FAR must reference the specific finished_good lot to enable traceability back to wafe',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Failure analysis reports in semiconductor quality are conducted on specific IC device types. FA traceability to the IC catalog entry is required for AEC-Q100 qualification, JEDEC reliability reporting',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: FA reports trace silicon failures to design root causes (timing violations, electromigration, latch-up). Required for design ECO decisions and design-for-reliability improvements. Standard practice in',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: A failure analysis report investigates a failed device or wafer that was part of a specific inspection lot. Linking failure_analysis_report to inspection_lot provides the traceability from the formal ',
    `osat_work_order_id` BIGINT COMMENT 'Foreign key linking to supply.osat_work_order. Business justification: Failure analysis on packaged devices must trace back to the OSAT work order to identify assembly process root causes. This is essential for OSAT supplier quality management and package qualification f',
    `nonconformance_report_id` BIGINT COMMENT 'FK to quality.nonconformance_report.nonconformance_report_id — FA reports are triggered by non-conformances. FA description explicitly states Links to... nonconformance_report. This is a critical investigation-to-disposition link.',
    `reliability_test_id` BIGINT COMMENT 'FK to quality.reliability_test.reliability_test_id — Failure analysis reports investigate failures detected during reliability testing. FA report description states Links to reliability_failure which is now merged into reliability_test.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Failure analysis reports in semiconductors frequently identify supplier material as root cause. Linking FA reports to the responsible supplier enables supplier quality management, 8D report issuance, ',
    `unit_test_result_id` BIGINT COMMENT 'Foreign key linking to test.unit_test_result. Business justification: Failure analysis reports are initiated from specific unit test failures. Linking FA report to the triggering unit_test_result enables FA engineers to access exact parametric measurements, bin assignme',
    `wafer_id` BIGINT COMMENT 'Foreign key linking to fabrication.wafer. Business justification: FA reports are performed on specific wafers. Direct wafer-level traceability is required for FA sample documentation, enabling correlation of failure site location with wafer-level process history and',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: FA reports triggered by wafer probe failures reference the wafer_probe_run to access probe conditions (contact yield, test coverage, equipment used). FA engineers use this link to distinguish probe-in',
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` (
    `customer_complaint_id` BIGINT COMMENT 'Primary key for customer_complaint',
    `account_id` BIGINT COMMENT 'Identifier of the customer who submitted the complaint.',
    `booking_id` BIGINT COMMENT 'Foreign key linking to sales.booking. Business justification: Customer complaints in semiconductors must trace to the specific shipment/booking event for DPPM calculation, warranty claim processing, and customer return authorization. A domain expert expects comp',
    `capa_record_id` BIGINT COMMENT 'Foreign key linking to quality.capa_record. Business justification: Customer complaints in semiconductor quality management drive Corrective and Preventive Actions (CAPA). Linking customer_complaint to capa_record enables end-to-end traceability from the customer-repo',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Customer complaint management requires tracking the specific contact who filed the complaint. In semiconductor B2B, quality engineers need the named contact for 8D/CAPA follow-up and customer communic',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Customer complaints in semiconductor operations are tied to specific design wins (the production program). Design-win-level complaint tracking is essential for customer satisfaction reporting, design ',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: Customer complaints are attributed to the manufacturing facility for quality performance tracking and customer scorecards. The manufacturing_site_code column is a denormalized facility reference repla',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_wafer_lot. Business justification: Customer complaints must be traceable to the source wafer lot for containment and root cause analysis. 8D reports require lot traceability — a fundamental customer quality management requirement. The ',
    `failure_analysis_report_id` BIGINT COMMENT 'Foreign key linking to quality.failure_analysis_report. Business justification: Customer complaints about failed devices in the semiconductor industry typically require a formal Failure Analysis Report (FAR) to investigate the root cause. Linking customer_complaint to failure_ana',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: Customer complaint investigations require tracing failed devices back to the final test run to identify test escapes. This is a mandatory step in semiconductor 8D investigations — quality engineers mu',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: Customer complaints in semiconductors are almost always about shipped finished goods. The complaint must reference the specific finished_good lot (date code, lot traceability code) for field return an',
    `ic_catalog_id` BIGINT COMMENT 'Identifier of the product or component the complaint concerns.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Customer complaints with design-related root causes (functional bugs, parametric drift, reliability escapes) must trace to originating design project for 8D reports and design corrective actions. Requ',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: A customer complaint in the semiconductor industry typically triggers an internal Non-Conformance Report (NCR) to document the product or process deviation. Linking customer_complaint to nonconformanc',
    `parent_customer_complaint_id` BIGINT COMMENT 'Self-referencing FK on customer_complaint (related_customer_complaint_id)',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Customer complaints in semiconductor operations always reference the specific shipped SKU (manufacturer part number, package, speed grade). RMA processing, 8D reports, and DPPM tracking require SKU-le',
    `unit_test_result_id` BIGINT COMMENT 'Foreign key linking to test.unit_test_result. Business justification: Customer complaints about specific device failures require retrieving the unit_test_result for that device serial number to confirm test escape status. This is a standard semiconductor customer compla',
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
    `customer_complaint_status` STRING COMMENT 'Current lifecycle status of the complaint.',
    `customer_complaint_description` STRING COMMENT 'Detailed narrative provided by the customer describing the issue.',
    `dppm_impact` DECIMAL(18,2) COMMENT 'Measured impact of the complaint expressed in DPPM.',
    `escalation_flag` BOOLEAN COMMENT 'True if the complaint has been escalated to higher management.',
    `escalation_level` STRING COMMENT 'Level of escalation applied to the complaint.',
    `inspection_result` STRING COMMENT 'Result of the quality inspection related to the complaint.',
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
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the complaint record.',
    `warranty_claim_flag` BOOLEAN COMMENT 'Indicates whether the complaint resulted in a warranty claim.',
    `warranty_claim_number` STRING COMMENT 'Reference number for the associated warranty claim.',
    CONSTRAINT pk_customer_complaint PRIMARY KEY(`customer_complaint_id`)
) COMMENT 'Master reference table for customer_complaint. Referenced by related_customer_complaint_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` (
    `control_plan_id` BIGINT COMMENT 'Primary key for control_plan',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: IATF 16949 control plans must specify the measurement or process equipment used at each control point. Linking control_plan to fab_tool enables automated checks of equipment qualification and calibrat',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: Control plans are facility-specific — a control plan approved for Fab A may not apply to Fab B due to equipment differences. IATF 16949 requires facility-scoped control plans for quality management sy',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: IATF 16949 mandates control plans authored at the product family level in semiconductor manufacturing. A control plan governs all process steps for a device family. control_plan currently has no link ',
    `flow_id` BIGINT COMMENT 'add column process_flow_id (BIGINT) with FK to process.process_flow.process_flow_id - quality control plans govern specific process flows but currently only self-reference',
    `process_recipe_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_recipe. Business justification: Control plans specify measurement criteria and tolerances for specific process recipes. Recipe-level control plans are standard in semiconductor SPC systems — the control plan defines the SPC rules ap',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to inventory.raw_material. Business justification: Control plans in semiconductor manufacturing govern incoming inspection of raw materials (silicon wafer resistivity, chemical purity, substrate dimensions). IATF 16949 requires control plans to refere',
    `spc_control_chart_id` BIGINT COMMENT 'Foreign key linking to process.spc_control_chart. Business justification: IATF 16949 control plans specify which SPC charts monitor each controlled parameter. This link enables control plan execution tracking, automated chart assignment during plan activation, and audit evi',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_step. Business justification: IATF 16949 control plans specify inspection and measurement requirements at specific process steps. The existing plain-text process_step column is a denormalized reference; replacing it with a prope',
    `superseded_control_plan_id` BIGINT COMMENT 'Self-referencing FK on control_plan (superseded_control_plan_id)',
    `approval_status` STRING COMMENT 'Current approval state of the control plan.',
    `author_name` STRING COMMENT 'Name of the person or team that authored the control plan.',
    `change_reason` STRING COMMENT 'Reason or justification for the most recent change to the control plan.',
    `compliance_standard` STRING COMMENT 'Quality or industry standard(s) the control plan adheres to.',
    `control_plan_status` STRING COMMENT 'Current lifecycle state of the control plan.',
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
    `review_cycle` STRING COMMENT 'Scheduled frequency for reviewing the control plan.',
    `risk_level` STRING COMMENT 'Risk classification associated with the control plan.',
    `sampling_rate` DECIMAL(18,2) COMMENT 'Frequency or method of sampling for the control plan.',
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_wafer_map_id` FOREIGN KEY (`wafer_map_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`wafer_map`(`wafer_map_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_wafer_map_id` FOREIGN KEY (`wafer_map_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`wafer_map`(`wafer_map_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_customer_complaint_id` FOREIGN KEY (`customer_complaint_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`customer_complaint`(`customer_complaint_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_failure_analysis_report_id` FOREIGN KEY (`failure_analysis_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`failure_analysis_report`(`failure_analysis_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_defect_record_id` FOREIGN KEY (`defect_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`defect_record`(`defect_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_reliability_test_id` FOREIGN KEY (`reliability_test_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`reliability_test`(`reliability_test_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_failure_analysis_report_id` FOREIGN KEY (`failure_analysis_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`failure_analysis_report`(`failure_analysis_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_parent_customer_complaint_id` FOREIGN KEY (`parent_customer_complaint_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`customer_complaint`(`customer_complaint_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_superseded_control_plan_id` FOREIGN KEY (`superseded_control_plan_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`control_plan`(`control_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_subdomain' = 'inspection_testing');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `equipment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `osat_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Osat Work Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ALTER COLUMN `supplier_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Qualification Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` SET TAGS ('dbx_subdomain' = 'inspection_testing');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_record_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Record ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Record Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `defect_inspection_result_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Inspection Result Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `design_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Core Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Detection Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Detection Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `equipment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `lot_move_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Move Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `osat_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Osat Work Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `photomask_id` SET TAGS ('dbx_business_glossary_term' = 'Photomask Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `wafer_map_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Wafer Map Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `unit_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Test Result Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` SET TAGS ('dbx_subdomain' = 'inspection_testing');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `wafer_map_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Map Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `bin_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Definition Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `equipment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Tool ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `lot_move_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Move Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `passing_die_count` SET TAGS ('dbx_business_glossary_term' = 'Passing Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `total_die_count` SET TAGS ('dbx_business_glossary_term' = 'Total Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` SET TAGS ('dbx_subdomain' = 'inspection_testing');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `yield_record_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Record ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `equipment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Process Recipe ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `defect_density_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Defect Density (defects/cm²)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `defect_type` SET TAGS ('dbx_business_glossary_term' = 'Defect Type');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `defect_type` SET TAGS ('dbx_value_regex' = 'critical|major|minor|none');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` SET TAGS ('dbx_subdomain' = 'inspection_testing');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `reliability_test_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Test ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Record Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contract Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `osat_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Osat Work Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Process Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Fmea Record Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Test Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` SET TAGS ('dbx_subdomain' = 'customer_performance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `dppm_record_id` SET TAGS ('dbx_business_glossary_term' = 'DPPM Record ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Record Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `failure_analysis_report_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Analysis Report Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `unit_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Test Result Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Record Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `shipment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Shipment End Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `shipment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Shipment Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ALTER COLUMN `total_units_shipped` SET TAGS ('dbx_business_glossary_term' = 'Total Units Shipped');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` SET TAGS ('dbx_subdomain' = 'corrective_action');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'CAPA Record Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `equipment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Related Audit Finding Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Source Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` SET TAGS ('dbx_subdomain' = 'corrective_action');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Related MRB Meeting ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `osat_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Osat Work Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Source Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` SET TAGS ('dbx_subdomain' = 'inspection_testing');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification ID (QUALITY_SPEC_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` SET TAGS ('dbx_subdomain' = 'corrective_action');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_analysis_report_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Analysis Report ID');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Analysis Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Record Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `defect_record_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Record Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `equipment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `osat_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Osat Work Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Nonconformance Report Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `reliability_test_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Test Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `unit_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Test Result Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` SET TAGS ('dbx_subdomain' = 'customer_performance');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Record Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `failure_analysis_report_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Analysis Report Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `parent_customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Related Customer Complaint Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `parent_customer_complaint_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `unit_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Test Result Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `customer_complaint_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `customer_complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `dppm_impact` SET TAGS ('dbx_business_glossary_term' = 'Dppm Impact');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ALTER COLUMN `warranty_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` SET TAGS ('dbx_subdomain' = 'corrective_action');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Control Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `spc_control_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Spc Control Chart Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `superseded_control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Control Plan Id');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `superseded_control_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `author_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `control_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
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
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `sampling_rate` SET TAGS ('dbx_business_glossary_term' = 'Sampling Rate');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `tolerance_lower` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Lower');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `tolerance_upper` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Upper');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
